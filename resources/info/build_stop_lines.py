import pandas as pd

UP = "/mnt/user-data/uploads"

routes = pd.read_csv(f"{UP}/routes.txt", dtype=str)
trips = pd.read_csv(f"{UP}/trips.txt", dtype=str)
stop_times = pd.read_csv(f"{UP}/stop_times.txt", dtype=str, usecols=["trip_id", "stop_id"])
stops = pd.read_csv(f"{UP}/stops.txt", dtype=str, usecols=["stop_id", "stop_name"])

# route_id -> route_short_name
trip_to_route = trips[["trip_id", "route_id"]].merge(
    routes[["route_id", "route_short_name"]], on="route_id", how="left"
)

# stop_id -> route_short_name (via trip_id), dedup
st = stop_times.merge(trip_to_route[["trip_id", "route_short_name"]], on="trip_id", how="left")
st = st.dropna(subset=["route_short_name"])
stop_lines = st.groupby("stop_id")["route_short_name"].unique().reset_index()

# attach stop_name
stop_lines = stop_lines.merge(stops, on="stop_id", how="left")

def sort_key(line):
    # numerische Linien zuerst numerisch sortiert, Rest alphabetisch danach
    try:
        return (0, int(line))
    except ValueError:
        return (1, line)

def format_lines(lines):
    uniq = sorted(set(lines), key=sort_key)
    return ",".join(uniq)

stop_lines["lines_str"] = stop_lines["route_short_name"].apply(format_lines)

# eine Zeile pro stop_id (Haltestelle inkl. Richtung/Fahrbahnseite bleibt separat)
# Key ist die stop_id (eindeutig, richtungs-/bussteig-genau), stop_name nur als Referenzspalte
result = stop_lines[["stop_id", "stop_name", "lines_str"]].sort_values("stop_id")

# Nur Münster wird als Datei ausgegeben (stop_id-Präfix de:05515:)

# Zusätzlich: gefilterte Liste nur für Münster (stop_id-Präfix de:05515:)
muenster = result[result["stop_id"].str.startswith("de:05515:")]
out_ms = "/mnt/user-data/outputs/haltestellen_linien_muenster.txt"
with open(out_ms, "w", encoding="utf-8") as f:
    for _, row in muenster.iterrows():
        f.write(f"{row['stop_id']}: {row['lines_str']}\n")
print(f"Münster-Datei: {out_ms} ({len(muenster)} Haltestellen)")

#!/usr/bin/env bash
# Print which student finished which exercise.
# Shared cluster (default): one cluster, all namespaces.
# Dedicated clusters: TENANCY=dedicated and one context per line in contexts.example.
set -euo pipefail

TENANCY="${TENANCY:-shared}"
LABEL="workshop.redhat.com/progress=true"
ROOT="$(cd "$(dirname "$0")" && pwd)"

rows() {
  local ctx
  if [[ "${TENANCY}" == "dedicated" ]]; then
    while read -r ctx; do
      [[ -z "${ctx}" || "${ctx}" == \#* ]] && continue
      oc --context "${ctx}" get configmap -A -l "${LABEL}" \
        -o jsonpath='{range .items[*]}{.data.user}{"\t"}{.data.exercise}{"\t"}{.data.status}{"\n"}{end}'
    done < "${ROOT}/contexts.example"
  else
    oc get configmap -A -l "${LABEL}" \
      -o jsonpath='{range .items[*]}{.data.user}{"\t"}{.data.exercise}{"\t"}{.data.status}{"\n"}{end}'
  fi
}

rows | python3 -c '
import sys
from collections import OrderedDict

users = OrderedDict()
exercises = []
seen = set()
for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    parts = line.split("\t")
    if len(parts) < 3:
        continue
    user, exercise, status = parts[0], parts[1], parts[2]
    if exercise not in seen:
        seen.add(exercise)
        exercises.append(exercise)
    users.setdefault(user, {})[exercise] = status

if not users:
    print("No progress records found.")
    sys.exit(0)

print("\t".join(["USER"] + exercises))
for user, done in users.items():
    cells = [user]
    for exercise in exercises:
        cells.append("done" if done.get(exercise) == "done" else "-")
    print("\t".join(cells))
'

#!/bin/env python3

import sys
import json

with open(sys.argv[1]) as APO_file:
    APO_file_contents = APO_file.read()

APO_data = APO_file_contents.split("\n")
for i, line in enumerate(APO_data):
    APO_data[i] = line.split(" ")

EE_DATA = {
    "output": {
        "blocklist": [],
        "equalizer": {
            "input-gain": 0.0,
            "left": {},
            "right": {},
            "mode": "IIR",
            "num-bands": 20,
            "output-gain": APO_data[0][1],
            "split-channels": False,
        },
        "plugins_order": ["equalizer"],
    },
}

for i, line in enumerate(APO_data):
    if i == 0 or line[0] == "":  # first and last lines
        continue
    elif line[0] == "Filter":
        EE_DATA["output"]["equalizer"]["left"][f"band{int(APO_data[i][1][:-1])-1}"] = {
            "frequency": float(APO_data[i][5]),
            "gain": float(APO_data[i][8]),
            "mode": "APO (DR)",
            "mute": False,
            "q": float(APO_data[i][11]),
            "slope": "x1",
            "solo": False,
            "type": "Bell",
        }


EE_DATA["output"]["equalizer"]["right"] = EE_DATA["output"]["equalizer"]["left"]

print(json.dumps(EE_DATA, indent=4))

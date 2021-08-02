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
            "mode": "IIR",
            "num-bands": len(APO_data) - 2,
            "output-gain": float(APO_data[0][1]),
            "right": {},
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
            "gain": max(min(float(APO_data[i][8]), 35.0), -35.0),
            "mode": "APO (DR)",
            "mute": False,
            "q": float(APO_data[i][11]),
            "slope": "x1",
            "solo": False,
            "type": "Bell",
        }
        if float(APO_data[i][8]) > 35.0 or float(APO_data[i][8]) < -35.0:
            print(
                f"WARNING clamping {float(APO_data[i][8])} to {max(min(float(APO_data[i][8]), 35.0), -35.0)}",
                file=sys.stderr,
            )


EE_DATA["output"]["equalizer"]["right"] = EE_DATA["output"]["equalizer"]["left"]

print(json.dumps(EE_DATA, indent=4))

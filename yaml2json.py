#!python3
import json
import sys

import yaml

if __name__ == "__main__":
    infile = sys.argv[1]
    outfile = sys.argv[2]
    with open(infile, 'r') as f:
        data = yaml.load(f)
    with open(outfile, 'w') as f:
        json.dump(data, f)
    

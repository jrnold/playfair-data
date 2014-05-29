YAML2JSON = python3 yaml2json.py
RSCRIPT = Rscript

all: data/Playfair1801.csv datapackage.json

data/Playfair1801.csv: sources/Playfair1801.R sources/Playfair1801.csv
	$(RSCRIPT) $^ $@

datapackage.json: datapackage.yaml
	$(YAML2JSON) $< $@

.PHONY: clean all-data

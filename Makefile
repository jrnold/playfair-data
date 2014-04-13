YAML2JSON = python3 yaml2json.py

all: datapackage.json

datapackage.json: datapackage.yaml
	$(YAML2JSON) $< $@

.PHONY: clean all-data

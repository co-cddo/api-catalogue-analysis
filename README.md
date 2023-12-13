# API Catalogue Analysis

This is a small temporary application used to carry out some analysis of the API Catalogue's data

## Data

- catalogue.csv comes from the [api-catalogue app at `/data`](https://github.com/co-cddo/api-catalogue/tree/main/data)
- uk_cross_government_metadata_exchange_model.yaml and uk-gov-orgs.yaml define the metadate linkml structure. They
  come from the [UK Cross-Government Metadata Exchange Model](https://github.com/co-cddo/ukgov-metadata-exchange-model/tree/main/src/model)

## Dependancy

Note that the gen-json-schema app is installed when you install the python utility [linkml](https://linkml.io/linkml/):

    pip install linkml

linkml provides the validation tool used to validate the cross government metadata.

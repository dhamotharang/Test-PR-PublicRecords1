CleanProviderData HIPIE Plugin

This plugin cleans provider data file. 

INCOMING DATA NOTES

* The plugin expects provider data file to be in ICD10 layout.

* Provider Key is required field.

* This plugin uses provider type field to figure out if the record belongs to provider or facility.

* Decent population of first, last, address line1 , city, state and zip are required for cleaner to function properly.

Cleaned ATTRIBUTE NOTES

* The plugin has custom logic to clean provider file. 

* Additionally this cleaner appends cleaned name and address. 


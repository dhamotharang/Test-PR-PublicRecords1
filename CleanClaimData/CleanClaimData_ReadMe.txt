CleanClaimData HIPIE Plugin

This plugin cleans the claims data file. 

NOTE : This plugin is specific to Healthcare 

INCOMING DATA NOTES

* The plugin expects claims file to be in ICD10 layout.

* Provider Key, patient key, claim number, claim line number are required fields.

* The plugin also cleans service from date, service to date, service date, charge amount and paid amount values.

Cleaned ATTRIBUTE NOTES

* The plugin has custom logic to clean claim file and appends cleaned fields to the input file with a custom prefix. 


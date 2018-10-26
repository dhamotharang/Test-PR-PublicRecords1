AppendBIPIds
 HIPIE Plugin
===========================================================
                      Plugin Type
===========================================================
This is an APPEND plugin

===========================================================
                      Plugin Description
===========================================================
This plugin appends BIP Ids to an incoming dataset.

===========================================================
                      What to Input
===========================================================
Appended Columns Prefix will add a prefix to appended columns

Following should be input:
	Company Name
	Primary Range
	Primary Name
	Secondary Range
	City
	State
	Zipcode - 5 digit
	Fein
	Phone

* All records must have a company name

* Decent population of values for a clean address (primRange, primName, etc.).

* FEIN is optional.

* Phone is optional

===========================================================
                     Output
===========================================================
* BIP ids are appended to the output.
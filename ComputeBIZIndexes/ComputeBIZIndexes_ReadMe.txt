Compute BIZ Indexes 
ReadMe

This is a CUSTOM plugin.


This plugin builds custom BIZ Indexes for use in custom BIZ search query used by BIZ project dashboards.
This plugin is meant to be used in the main prep BIZ composition downstream and uses two input files. 
One is the main BIZ output file and the other is the Normalized officer output files. 
The Normalized officer file should be derived from the main BIZ output file so it has the same unique record ID.


JobID will be appended to the indexes names to avoid collision with previous runs of the BIZ prep composition.
For example if the JobID is 12345 the indexes names will look like  ~biz::key::payload::12345

BusinessKeyIdentifier is used in the business keys' name. 
Default is Business in order to produce ~biz::key::BusinessName::<JobID> for example

BusinessPersonKeyIdentifier is used in the business person keys' name.
Default is Officer in order to produce ~biz::key::OfficerName::<JobID> for example

The dsInputBusiness is the main BIZ output file. 
The following field must be specified:
    	RecordId is the unique record identifier
	AccountNumber is the customer account number
	BusinessName is the legal business name
	DBAName is the DBA name
	UltBusinessName is the Ult business name from BIP Best
	SeleBusinessName is the Sele business name from BIP Best
	ProxBusinessName is the Prox business name from BIP Best
	BusinessPrimaryName is the business location primary name
	BusinessPrimaryRange is the business location primary range
	BusinessSecondaryRange is the business location secondary range
	BusinessCity is the business location city
	BusinessState is the business location state
    	BusinessZip is the business location zip
	FEIN is the business FEIN

The dsInputPerson is the normalized officer output file generated from the main BIZ output file 
The following field must be specified:
    	FirstName is the business person best first name
	MiddleName is the business person best middle name
	LastName is the business person best last name
	NameSuffix is the business person best name suffix
	RawName is the business person name raw name from customer data
	PrimaryName is the address primary name
	PrimaryRange is the address primary range
	SecondaryRange is the address secondary range
	City is the address city
    	State is the address state
    	Zip is the address zip
	SSN is the business person SSN



Append DCA Business Attributes ReadMe
Version 1.0

===========================================================
                      Plugin Type
===========================================================
This is an APPEND plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin will appends business attributes from DCA dataset at the Sele (legal) level


===========================================================
                    What to Input
===========================================================

The Prefix input will be appended to the front of the newly created best BIP details columns.

The dsInput is the input dataset.

All these columns need to be specified by the user from the input dataset:
	UltID
	OrgID
	SeleID

The following options are currently required regardless of the data not needing restrictions
	DPPA Purpose
	GLB Purpose
	Data Restriction Mask
These variables will typically be set as global variables and passed in through the whole composition and should be known beforehand.

===========================================================
                      Output
===========================================================

This plugin will append the following fields from the DCA data
    EnterpriseNumber - Populated in DCA data 100%
    BusinessDescription - Populated in DCA data ~99%
    CompanyType - Populated in DCA data ~23%
    NumberOfEmployees - Populated in DCA data ~68%
    SalesOrRevenue - Populated in DCA data ~32%
    Sales - Populated in DCA data ~32%
    Earnings - Populated in DCA data ~3%
    NetWorth - Populated in DCA data ~3%
    Assets - Populated in DCA data ~3%
    Liabilities - Populated in DCA data ~3%
    UpdateDate - Populated in DCA data ~99%






Append Corporate Business Attributes ReadMe
Version 1.0

===========================================================
                      Plugin Type
===========================================================
This is an APPEND plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin will appends business attributes from Corp dataset
 at the Prox or Sele level.
This plugin will first attempt to find matching records at the Prox level and if we can't 
find records at the Prox level we will append records at the Sele level.

===========================================================
                    What to Input
===========================================================

The Prefix input will be appended to the front of the newly created best BIP details columns.

The dsInput is the input dataset.

All these columns need to be specified by the user from the input dataset:
	UltID
	OrgID
	SeleID
	ProxID
	State - The state the business is in.

The following options are currently required regardless of the data not needing restrictions
	DPPA Purpose
	GLB Purpose
	Data Restriction Mask
These variables will typically be set as global variables and passed in through the whole composition and should be known beforehand.

===========================================================
                      Output
===========================================================

This plugin will append the following fields from the Corp data
    CorporateKey - Populated in Corp data 100%
    CorporateState - Populated in Corp data 100%
    CorporateProcessDate - Populated in Corp data 100%
    LegalName - Populated in Corp data 100%
    CorporateFilingDescription - Populated in Corp data ~16%
    CorporateStatus - Populated in Corp data ~94%
    CorporateStatusDate - Populated in Corp data ~28%
    CorporateStatusComment - Populated in Corp data ~18%
    CorporateIncorporationDate - Populated in Corp data ~78%
    CorporateIncorporationState - Populated in Corp data 100%
    CorporateFederalTaxID - Populated in Corp data ~5%
    OrganizationStructureDescription - Populated in Corp data ~80%
    ProfitIndicator - Populated in Corp data ~27%
    RegisteredAgentName - Populated in Corp data ~77%
    BipLevel - Prox if we matched at the ProxID Level, Sele if we matched at the SeleID level and blank if we didn't match

===========================================================
                      Side Effects
===========================================================
Hit Rate: Counts of how many records had a Corp match either by Prox or by Sele, check these to make sure that it matches your expectation based on the input.

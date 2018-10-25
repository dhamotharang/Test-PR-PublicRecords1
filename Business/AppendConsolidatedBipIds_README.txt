Append Consolidated BIP Ids ReadMe

===========================================================
                      Plugin Type
===========================================================
This is an APPEND plugin.

===========================================================
                      Plugin Description
===========================================================

In cases where there are multiple business names and addresses (business details, mailing business details, DBA details) 
we have to run BIP  for each variation and land up with multiple sets of BIP Ids.

This plugin will consolidate the BIP Ids, pick the best on and append that set of BIP IDs (ultiid, orgid, seleid, proxid etc.)

===========================================================
                      What to Input
===========================================================


The Prefix input will be appended to the front of the newly created field names

The dsInput is the input dataset.

NOTE: This plugin supports 4 sets max but only two are required.

***REQUIRED***
UltID1
SeleID1
ProxID1
OrgID1
PowID1
DotID1 (If Applicable)
EmpID1 (If Applicable)


UltID2
SeleID2
ProxID2
OrgID2
PowID2
DotID2 (If Applicable)
EmpID2 (If Applicable)
***REQUIRED***

***OPTIONAL***
UltID3
SeleID3
ProxID3
OrgID3
PowID3
DotID3 (If Applicable)
EmpID3 (If Applicable)

UltID4
SeleID4
ProxID4
OrgID4
PowID4
DotID4 (If Applicable)
EmpID4 (If Applicable)
***OPTIONAL***
===========================================================
                      Output
===========================================================

The output for this plugin will the consolidated IDs of each of the entities that were specified. It will
choose the best option for each for up to 4 business entities.

The following new fields will be appended:

UltID
SeleID
ProxID
OrgID
PowID
DotID
EmpID



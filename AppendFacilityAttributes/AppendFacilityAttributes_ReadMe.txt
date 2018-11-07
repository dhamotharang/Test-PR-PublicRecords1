AppendFacilityAttributes HIPIE Plugin

This plugin appends dataset that contains lexis nexis facility id with facility shell attributes. 

INCOMING DATA NOTES

* The plugin expects lexis nexis facility id. This is a required field. 


Input Parameters
Prefix: The prefix for all the appended columns. 
        e.g. LNFID will result in the column FacilityAttrLNFID being appended 
            (along with the additional linking result columns).
LNFID: Lexis Nexis Facility ID

Output Parameters

All attributes from facility shell are appended as output.

Resource Requirements
This plugin is dependant on all the internal indexes and code used for facility shell.



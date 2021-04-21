Default generated readme file for AppendAdlBest
Soapcalls Roxie batch service didville.did_batch_service_raw to append best information
Append ADL Best ReadMe

===========================================================
                      Plugin Type
===========================================================
This is an APPEND plugin.

===========================================================
                      Plugin Description
===========================================================
Given a LexID SOAPCALLs to didville.did_batch_service_raw (ADL Best)
to append the best information

===========================================================
                      What to Input
===========================================================
The Prefix input will be appended to the front of the newly created field's name.

The dsInput is the input dataset.

LexID is Lexis Nexis person identifier.

UniqueID is a unique identifier or account number field used by ADL Best to keep rows separate.
This input field is optional and a COUNTER will be used if not provided.

The plugin uses the following options
DPPA Purpose 
GLB Purpose
Data Restriction Mask	
Data Permission Mask
Appends - ADL Appends option, i.e 'BEST_ALL', 'BEST_EDA', etc.
Verify - ADL Best Verify option, i.e. 'BEST_ALL', 'VERIFY_ALL', etc.
Deduped - ADL Best Deduped option 
Include Ranking - ADL Best Include Ranking option
Patriot Process - ADL Best Patriot Process

The plugin uses the following SOAPCALL options
ADL Best Roxie VIP - the url for SOAPCALL, i.e. http://roxieqavip.br.seisint.com:9876
Parallel Nodes
Batch Size
Parallel Request

===========================================================
                      Outputs
===========================================================
In the output the following fields are appended 

Title 
FirstName 
MiddleName 
LastName 
Address
City
State
Zip
Zip4
AddressDate

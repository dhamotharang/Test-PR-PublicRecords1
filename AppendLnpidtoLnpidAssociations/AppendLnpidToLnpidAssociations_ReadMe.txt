Append LNPID to LNPID Associations ReadMe

===========================================================
                      Plugin Type
===========================================================
This is a COMPUTE plugin.

===========================================================
                      Plugin Description
===========================================================
Given a single LNPID on a row of data this plugin will append all provider associations for that LNPID.
This allows for subsequent aggregations on the associated LNPID. 

===========================================================
                      What to Input
===========================================================
The Prefix input will be appended to the front of the newly created field's name.

The dsInput is the input dataset.

LNPID is Lexis Nexis' Professional ID.

LexID is the Provider's LexID. This is optional.

Name is the Provider's name. This is optional.

AssociateThreshold is the threshold for LNPID association. The default is 10.

===========================================================
                      Outputs
===========================================================
In the output the following fields are appended from the LNPID association key

PersonLnpid - The main LNPID the association is done on
AssociateLnpid - The associated LNPID
PrimaryRange - the primary range of the address the associated LNPID is located at
PreDirection - the predirection of the address the associated LNPID is located at
PrimaryName - the primary name of the address the associated LNPID is located at
AddressSuffix -- the address suffix of the address the associated LNPID is located at
PostDirection - the post direction of the address the associated LNPID is located at
SecondaryRange - the secondary range of the address the associated LNPID is located at
City - the city of the address the associated LNPID is located at
State - the state of the address the associated LNPID is located at
Zip - the zip of the address the associated LNPID is located at
HasActiveExclusion - A flag showing if the LNPID has active exclustion. This flag is an INTEGER return 1 for true and 0 for false.
HasActiveRevocation - A flag showing if the LNPID has active revocation. This flag is an INTEGER return 1 for true and 0 for false.
HasReinstatedExclusion - A flag showing if the LNPID has reinstated exclustion. This flag is an INTEGER return 1 for true and 0 for false.
HasReinstatedRevocation - A flag showing if the LNPID has reinstated revocation. This flag is an INTEGER return 1 for true and 0 for false.
HasBankruptcy - A flag showing if the LNPID has bankruptcy. This flag is an INTEGER return 1 for true and 0 for false.
HasCriminalHistory - A flag showing if the LNPID has a criminal record. This flag is an INTEGER return 1 for true and 0 for false.
HasRelativeConvictions - A flag showing if the LNPID has a relative with a conviction record. This flag is an INTEGER return 1 for true and 0 for false.
HasRelativeBankruptcy - A flag showing if the LNPID has a relative with a bankruptcy record. This flag is an INTEGER return 1 for true and 0 for false.
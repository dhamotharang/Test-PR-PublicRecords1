Append Person Best Info ReadMe

===========================================================
                      Plugin Type
===========================================================
This is an APPEND plugin.

===========================================================
                      Plugin Description
===========================================================
Given a LexID append Watchdog name and address.
Currently we are ONLY allowing Watchdog Non GLB keys.

===========================================================
                      What to Input
===========================================================
The Prefix input will be appended to the front of the newly created field's name.

The dsInput is the input dataset.

LexID is Lexis Nexis person identifier.

Use Non Blank Index specifies whether to use the blank or non blank watchdog key. 
If "best" algorithm couldn't choose a value -- like if two names are equally good -- then it has a choice: 
either leave it blank (when this option is set to False) or force either one (when this option is set to True)

This 2 options MUST be passed in for this plugin to work:
GLB Purpose
Data Restriction Mask	

Include Marketing specifies whether to use watchdog marketing keys. 
Currently this option does not do anything as we are ONLY allowing to use the Non GLB Watchdog Keys.

Return Date Of Death specifies whether to Return Date Of Death. 
Currently this option does not do anything as we are ONLY allowing to use the Non GLB Watchdog Keys.

Include Minors specifies whether or not to include minors. 
Currently this option does not do anything as we are ONLY allowing to use the Non GLB Watchdog Keys.

===========================================================
                      Outputs
===========================================================
In the output the following fields are appended from the appropriate Watchdog key

Title 
FirstName 
MiddleName 
LastName 
NameSuffix 
PrimaryRange
PreDirectional
PrimaryName
AddressSuffix
PostDirectional
UnitDesignation
SecondaryRange
City
State
Zip
Zip4
AddressFirstSeen
AddressLastSeen

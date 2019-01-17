Append Additional Business Entities README
===========================================================
                      Plugin Type
===========================================================
This is a COMPUTE plugin.

===========================================================
                      Plugin Description
===========================================================
It will add additional rows of business entities that fall under BIP 
entities (by UltID) in the input dataset but are not in the input dataset.
If the option Add all missing businesses? is set to TRUE and there is only 
one State Jurisdiction to add businesses from then the plugin will add ALL
missing business entities within the State Jurisdiction regardless of whether
they fall under the original input file entities.

===========================================================
                      What to Input
===========================================================
The dsInput is the input dataset.

An option to add a column prefix to the appended data is the first item. This is optional 

***Important***
For this plugin to work properly, it expects an input dataset that contains UltID and SeleID
It is assumed that the AppendBusiness plugin be run before which would supply the below
columns
Preferably ProxID's should be filled as well
***Important***

All these columns need to be specified by the user from the input dataset:
	UltID
	SeleID
	ProxID
	CompanyName
	PrimaryRange
	PreDirectional
	PrimaryName
	AddressSuffix
	PostDirectional
	UnitDesignation
	SecondaryRange
	PostalCity
	VanityCity
	State
	Zip5
	Zip4
	County
	Latitude
	Longitude

The Jurisidiction States is the list of states to look for new business entities in.

Add all missing businesses? is an option to return all the businesses within a jurisdiction regardless of whether they originate
from the input file (by UltID). 
This option should be used carefully and will only work when the Jurisdiction States lists only one state. 
Otherwise this option will be ignored.
 
===========================================================
                      Output
===========================================================
Outputs additional rows of business entities that fall under BIP entities but are not in the input dataset. If 
Jurisdiction States are selected it will look for new business entities in those states.

Additionally adds the following fields:	
	isUltinput  - Integer value whether UltID is input
	isSeleinput - Integer value whether SeleID is input
	isProxinput - Integer value whether ProxID is input
	isNewBusinessHierarchy - Integer value whether the new record is a new business not originating from the input file


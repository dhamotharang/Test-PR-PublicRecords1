Append Business Contacts Entities ReadMe

===========================================================
                      Plugin Type
===========================================================
This is a COMPUTE plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin appends the business contacts for a business that has previously had the BIP Ids appended.

===========================================================
                      What to Input
===========================================================


The Prefix input will be appended to the front of the newly created best BIP details columns.

The dsInput is the input dataset.

All these columns need to be specified by the user from the input dataset:
	UltID
	OrgID
	SeleID
The above variables would be defined if the data set had businesses with previously appended BIP ID's

ReturnExecutivesOnly returns contacts that are executives only. The default for this is False, and should 
be changed to True if you want only executives to be listed.

ReturnCurrentContacts returns current contacts only. Current contacts are contacts with a date last seen within 
2 (730 days) years of the current date. The default value for this is true which will select only current contacts.

The following global variables need to be defined in order to run this plugin:
	Application Type
	DPPA Purpose
	GLB Purpose
	Data Restriction Mask
These variables should be known beforehand.

===========================================================
                      Outputs
===========================================================

Three different output options will be available.

dsOutput is the first option:
	This outputs the original file that was input
dsContactsByBusinesses is the second option:
	This outputs the original file with the records within having been DEDUPed and appended
dsContacts is the third option:
	This outputs the original file with the records within having been appended

The following fields were appended to the records:
LexID - LexID of person associated
Title - Title of person associated (Mr, Mrs, etc.)
FirstName - First name of person associated
MiddleName - Middle name of person associated
LastName - Last name of person associated
Suffix - Suffix of person associated
JobTitle - Job Title of person associated (President, Director, Contact, etc.)
ContactType - Type of contact (Officer, Contact, etc.)
IsExecutive - Boolean value of true if executive, false if not
ExecutiveOrder - Value representing order of executive hierarchy
DateFirstSeen - Date first seen in system
DateLastSeen - Date last seen in system/
IsCurrent - Boolean value of true if current (within 730 days)
ContactAppended - Boolean value of true if appended
ContactIdentified - Boolean value of true if identified	

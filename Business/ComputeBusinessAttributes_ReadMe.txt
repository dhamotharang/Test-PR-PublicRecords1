Compute Business Attributes ReadMe

===========================================================
                      Plugin Type
===========================================================
This is a COMPUTE plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin computes additional attributes and flags to support dashboarding of the business 
data and appends them to the input.

Currently this plugin supports the following:
Computes the current businesses flag using date first seen – input: date first seen and days threshold (default 180)
Computes flag for business not seen in the past x months – input: date last seen and months threshold (default 18)
===========================================================
                      What to Input
===========================================================
The dsInput is the input dataset.

The Prefix input will be appended to the front of the newly created field names

UltID - the Ultimate Business ID
SeleID - the smallest encapsulating legal entity of a business ID
ProxID - the physical location of a business entity ID

DateFirstSeen is the business date first seen in YYYYMMDD format
DateLastSeen is the business date last seen in YYYYMMDD format

NewBusinessThreshold is used to determine if a business is new. 
Default is 180 days.

InactiveThreshold is used to determine if a business is inactive. 
Default is 18 months.

===========================================================
                      Output
===========================================================

The following new additional fields will be available:

IsNew - Boolean value to determine if business was created within 6 months
IsInactive - Boolean Value to determine if business is inactive for 18 months or more
HierarchySize - The size of the business hierarchy (aggregration by UltID)
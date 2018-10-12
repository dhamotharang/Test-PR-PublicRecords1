Append Bankruptcy flag Read Me

===========================================================
                      Plugin Type
===========================================================
This is an APPEND plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin performs a simple lookup of a person's LexID into the Bocashell Bankruptcy Key
and appends a flag showing whether the subject has a bankruptcy in Bocashell.

===========================================================
                      What to Input
===========================================================

The Prefix input will be appended to the front of the newly created field's name.

The dsInput is the input dataset.

LexID is the person's LexID.

===========================================================
                      Outputs
===========================================================

In the output the following fields are appended:

hasBankruptcy- a Flag showing if the subject has a bankruptcy in Bocashell 

Append Sequence Id ReadMe

===========================================================
                      Plugin Type
===========================================================
This is an APPEND plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin sequences records of the input dataset.
Among other things, this is useful when you want to create indexes for use in searches and 
need to ensure a field will have unique values to link back to the original record.
===========================================================
                      What to Input
===========================================================
The Prefix input will be appended to the front of the newly created field's name.

The dsInput is the input dataset.

Starting ID is the minimum record identifier to assign. Defaults to 1.

Stricly Sequential IDs will set the assigned IDs in numerically increasing order when True. 
Otherwise (if False), the assigned IDs will be unique but there may be gaps, depending on 
how the records are distributed. (Default is True)


===========================================================
                      Outputs
===========================================================

In the output the following fields are appended:

RecID - Unique Record/Sequential ID added to each record in a numerically increasing order. 
In this case it will only do it strictly sequential if that value is set to true.
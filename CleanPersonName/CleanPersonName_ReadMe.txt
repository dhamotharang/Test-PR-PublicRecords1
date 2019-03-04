Clean Person Name Plugin.

This plugin will parse a single column that contains the first, lastname or 
first middle lastname of a person into three new new columns that contain
the first, middle and last name.

This plugin will typically be used before a LexID plugin within a composition as the LexID 
plugin requires first, lastname etc. separately.

Parameters

Prefix: will prefix the new columns so they are unique. 
e.g. BusinessContact will result in new columns 
     BusinessContactFirstname, BusinessContactMiddlename, BusinessContactLastname

Platform Requirements
Currently only available in a MySQL repo environment.


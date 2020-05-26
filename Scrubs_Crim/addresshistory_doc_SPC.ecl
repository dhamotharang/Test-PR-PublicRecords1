OPTIONS:-gh
MODULE:Scrubs_Crim
FILENAME:crim
NAMESCOPE:addresshistory_doc
SOURCEFIELD:vendor

FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Source_ID:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ )
FIELDTYPE:Invalid_ZIP:ALLOW(0123456789)
FIELDTYPE:Invalid_City:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.- )

FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0
FIELD:statecode:LIKE(Invalid_State):TYPE(STRING2):0,0
FIELD:street:TYPE(STRING150):0,0
FIELD:unit:TYPE(STRING20):0,0
FIELD:city:LIKE(Invalid_City):TYPE(STRING50):0,0
FIELD:orig_state:TYPE(STRING2):0,0
FIELD:orig_zip:LIKE(Invalid_ZIP):TYPE(STRING9):0,0
FIELD:addresstype:TYPE(STRING20):0,0
FIELD:sourcename:TYPE(STRING100):0,0
FIELD:sourceid:LIKE(Invalid_Source_ID):TYPE(STRING):0,0
FIELD:vendor:TYPE(STRING10):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

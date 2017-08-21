MODULE:Scrubs_SANCTN_NPKeys
FILENAME:SANCTN_NPKeys
NAMESCOPE:incident_text
SOURCEFIELD:dbcode

FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(1..)
FIELDTYPE:Invalid_DBCode:ENUM(N|F)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Field:ENUM(OTHERINFO|INCIDENT_TEXT|INCIDENT_RESPONSE|)

FIELD:batch:LIKE(Invalid_Batch):TYPE(STRING8):0,0
FIELD:dbcode:LIKE(Invalid_DBCode):TYPE(STRING1):0,0
FIELD:incident_num:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:seq:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:field_name:LIKE(Invalid_Field):TYPE(STRING20):0,0
FIELD:field_txt:TYPE(STRING):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

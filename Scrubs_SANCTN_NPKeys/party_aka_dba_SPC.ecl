MODULE:Scrubs_SANCTN_NPKeys
FILENAME:SANCTN_NPKeys
NAMESCOPE:party_aka_dba
SOURCEFIELD:dbcode

FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(1..)
FIELDTYPE:Invalid_DBCode:ENUM(N|F)
FIELDTYPE:Invalid_NameType:ENUM(D|A)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)

FIELD:batch:LIKE(Invalid_Batch):TYPE(STRING8):0,0
FIELD:dbcode:LIKE(Invalid_DBCode):TYPE(STRING1):0,0
FIELD:incident_num:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:party_num:LIKE(Invalid_Num):TYPE(STRING7):0,0
FIELD:name_type:LIKE(Invalid_NameType):TYPE(STRING1):0,0
FIELD:first_name:TYPE(STRING50):0,0
FIELD:middle_name:TYPE(STRING50):0,0
FIELD:last_name:TYPE(STRING50):0,0
FIELD:aka_dba_text:TYPE(STRING100):0,0
FIELD:party_key:LIKE(Invalid_Num):TYPE(INTEGER8):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

MODULE:Scrubs_SANCTNKeys
FILENAME:SANCTNKeys
NAMESCOPE:party_aka_dba

FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_):LENGTHS(1..)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_NameType:ENUM(D|A)


FIELD:batch_number:LIKE(Invalid_Batch):TYPE(STRING8):0,0
FIELD:incident_number:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:party_number:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:record_type:TYPE(STRING1):0,0
FIELD:order_number:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:name_type:LIKE(Invalid_NameType):TYPE(STRING1):0,0
FIELD:last_name:TYPE(STRING50):0,0
FIELD:first_name:TYPE(STRING50):0,0
FIELD:middle_name:TYPE(STRING50):0,0
FIELD:aka_dba_text:TYPE(STRING500):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

MODULE:Scrubs_SANCTNKeys
FILENAME:SANCTNKeys
NAMESCOPE:rebuttal

FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_):LENGTHS(1..)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)

FIELD:batch_number:LIKE(Invalid_Batch):TYPE(STRING8):0,0
FIELD:incident_number:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:party_number:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:record_type:TYPE(STRING1):0,0
FIELD:order_number:LIKE(Invalid_Num):TYPE(STRING4):0,0
FIELD:party_text:TYPE(STRING255):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

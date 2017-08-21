MODULE:Scrubs_SANCTNKeys
FILENAME:SANCTNKeys
NAMESCOPE:license

FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_):LENGTHS(1..)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_LicenseNumber:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz .-#)
FIELDTYPE:Invalid_ClnLicenseNumber:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_State:CUSTOM(Scrubs.fn_Valid_StateAbbrev>0)
FIELDTYPE:Invalid_LicenseType:CUSTOM(Scrubs_SANCTNKeys.fn_CodeCheck_Licence>0)

FIELD:batch_number:LIKE(Invalid_Batch):TYPE(STRING8):0,0
FIELD:incident_number:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:party_number:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:record_type:TYPE(STRING1):0,0
FIELD:order_number:LIKE(Invalid_Num):TYPE(STRING4):0,0
FIELD:license_number:LIKE(Invalid_LicenseNumber):TYPE(STRING50):0,0
FIELD:license_type:LIKE(Invalid_LicenseType):TYPE(STRING50):0,0
FIELD:license_state:LIKE(Invalid_State):TYPE(STRING20):0,0
FIELD:cln_license_number:LIKE(Invalid_ClnLicenseNumber):TYPE(STRING50):0,0
FIELD:std_type_desc:TYPE(STRING50):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

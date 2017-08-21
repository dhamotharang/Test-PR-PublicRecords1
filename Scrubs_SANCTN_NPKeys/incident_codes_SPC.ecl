MODULE:Scrubs_SANCTN_NPKeys
FILENAME:SANCTN_NPKeys
NAMESCOPE:incident_codes
SOURCEFIELD:dbcode

FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(1..)
FIELDTYPE:Invalid_Licence:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-)
FIELDTYPE:Invalid_DBCode:ENUM(N|F)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Field:ENUM(LICENSECODE|INTERNALCODE|PROFESSIONCODE|)
FIELDTYPE:Invalid_State:CUSTOM(Scrubs.fn_Valid_StateAbbrev>0)
FIELDTYPE:Invalid_LicenceCode:CUSTOM(Scrubs_SANCTN_NPKeys.fn_CodeCheck_Licence>0,field_name)
FIELDTYPE:Invalid_ProfessionCode:CUSTOM(Scrubs_SANCTN_NPKeys.fn_CodeCheck_Professional>0,field_name)

FIELD:batch:LIKE(Invalid_Batch):TYPE(STRING8):0,0
FIELD:dbcode:LIKE(Invalid_DBCode):TYPE(STRING1):0,0
FIELD:primary_key:LIKE(Invalid_Num):TYPE(INTEGER8):0,0
FIELD:foreign_key:LIKE(Invalid_Num):TYPE(INTEGER8):0,0
FIELD:incident_num:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:number:LIKE(Invalid_Num):TYPE(STRING7):0,0
FIELD:field_name:LIKE(Invalid_Field):TYPE(STRING20):0,0
FIELD:code_type:TYPE(STRING20):0,0
FIELD:code_value:TYPE(STRING20):0,0
FIELD:code_state:LIKE(Invalid_State):TYPE(STRING2):0,0
FIELD:other_desc:LIKE(Invalid_ProfessionCode):TYPE(STRING500):0,0
FIELD:std_type_desc:LIKE(Invalid_LicenceCode):TYPE(STRING80):0,0
FIELD:cln_license_number:LIKE(Invalid_Licence):TYPE(STRING20):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

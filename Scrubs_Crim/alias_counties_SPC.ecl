OPTIONS:-gh
MODULE:Scrubs_Crim
FILENAME:crim
NAMESCOPE:alias_counties
SOURCEFIELD:vendor

FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_ )
FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:AKA_Search:CUSTOM(Scrubs_Crim.fn_FindAKA>0)

FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0
FIELD:statecode:LIKE(Invalid_State):TYPE(STRING2):0,0
FIELD:akaname:LIKE(AKA_Search):TYPE(STRING115):0,0
FIELD:akalastname:LIKE(AKA_Search):TYPE(STRING50):0,0
FIELD:akafirstname:LIKE(AKA_Search):TYPE(STRING50):0,0
FIELD:akamiddlename:LIKE(AKA_Search):TYPE(STRING40):0,0
FIELD:akasuffix:TYPE(STRING15):0,0
FIELD:akadob:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:sourcename:TYPE(STRING100):0,0
FIELD:vendor:TYPE(STRING10):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

OPTIONS:-gh
MODULE:Scrubs_Crim
FILENAME:crim
NAMESCOPE:charge_counties
SOURCEFIELD:vendor

FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_ )
FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Case_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_ )
FIELDTYPE:Invalid_Current_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,'future')
FIELDTYPE:Invalid_Source_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ )


FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0
FIELD:statecode:LIKE(Invalid_State):TYPE(STRING2):0,0
FIELD:caseid:LIKE(Invalid_Case_ID):TYPE(STRING40):0,0
FIELD:warrantnumber:TYPE(STRING20):0,0
FIELD:warrantdate:TYPE(STRING8):0,0
FIELD:warrantdesc:TYPE(STRING200):0,0
FIELD:warrantissuedate:TYPE(STRING8):0,0
FIELD:warrantissuingagency:TYPE(STRING50):0,0
FIELD:warrantstatus:TYPE(STRING100):0,0
FIELD:citationnumber:TYPE(STRING20):0,0
FIELD:bookingnumber:TYPE(STRING20):0,0
FIELD:arrestdate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:arrestingagency:TYPE(STRING50):0,0
FIELD:bookingdate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:custodydate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:custodylocation:TYPE(STRING50):0,0
FIELD:initialcharge:TYPE(STRING100):0,0
FIELD:initialchargedate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:initialchargecancelleddate:TYPE(STRING8):0,0
FIELD:chargedisposed:TYPE(STRING100):0,0
FIELD:chargedisposeddate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:chargeseverity:TYPE(STRING20):0,0
FIELD:chargedisposition:TYPE(STRING150):0,0
FIELD:amendedcharge:TYPE(STRING100):0,0
FIELD:amendedchargedate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:bondsman:TYPE(STRING50):0,0
FIELD:bondamount:TYPE(STRING10):0,0
FIELD:bondtype:TYPE(STRING50):0,0
FIELD:sourcename:TYPE(STRING100):0,0
FIELD:sourceid:LIKE(Invalid_Source_ID):TYPE(STRING):0,0
FIELD:vendor:TYPE(STRING10):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

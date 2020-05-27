OPTIONS:-gh
MODULE:Scrubs_Crim
FILENAME:crim
NAMESCOPE:defendant_counties
SOURCEFIELD:vendor

FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_)
FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Current_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,'future')
FIELDTYPE:Invalid_Source_ID:ALLOW(0123456789C)
FIELDTYPE:Invalid_Inmate_Num:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-*,#/ )
FIELDTYPE:Invalid_Gender:ENUM(MALE|FEMALE|Female|Male|female|male|f|m|F|M|Unknown|UNKNOWN|U|u|)
FIELDTYPE:Invalid_Zip:ALLOW(0123456789)
FIELDTYPE:Invalid_Race:CUSTOM(Scrubs_Crim.fn_StandardizeRace>0)
FIELDTYPE:Invalid_Height:ALLOW(0123456789,"')
FIELDTYPE:Invalid_City:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.-,?' )

FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0
FIELD:sourcename:TYPE(STRING100):0,0
FIELD:sourcetype:TYPE(STRING20):0,0
FIELD:statecode:LIKE(Invalid_State):TYPE(STRING2):0,0
FIELD:recordtype:TYPE(STRING20):0,0
FIELD:recorduploaddate:TYPE(STRING8):0,0
FIELD:docnumber:TYPE(STRING20):0,0
FIELD:fbinumber:TYPE(STRING20):0,0
FIELD:stateidnumber:TYPE(STRING20):0,0
FIELD:inmatenumber:LIKE(Invalid_Inmate_Num):TYPE(STRING20):0,0
FIELD:aliennumber:TYPE(STRING20):0,0
FIELD:orig_ssn:TYPE(STRING9):0,0
FIELD:nametype:TYPE(STRING1):0,0
FIELD:name:TYPE(STRING115):0,0
FIELD:lastname:TYPE(STRING50):0,0
FIELD:firstname:TYPE(STRING50):0,0
FIELD:middlename:TYPE(STRING40):0,0
FIELD:suffix:TYPE(STRING15):0,0
FIELD:defendantstatus:TYPE(STRING100):0,0
FIELD:defendantadditionalinfo:TYPE(STRING200):0,0
FIELD:dob:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:birthcity:LIKE(Invalid_City):TYPE(STRING50):0,0
FIELD:birthplace:TYPE(STRING100):0,0
FIELD:age:TYPE(STRING3):0,0
FIELD:gender:LIKE(Invalid_Gender):TYPE(STRING10):0,0
FIELD:height:TYPE(STRING10):0,0
FIELD:weight:TYPE(STRING10):0,0
FIELD:haircolor:TYPE(STRING10):0,0
FIELD:eyecolor:TYPE(STRING10):0,0
FIELD:race:LIKE(Invalid_Race):TYPE(STRING50):0,0
FIELD:ethnicity:TYPE(STRING20):0,0
FIELD:skincolor:TYPE(STRING10):0,0
FIELD:bodymarks:TYPE(STRING100):0,0
FIELD:physicalbuild:TYPE(STRING20):0,0
FIELD:photoname:TYPE(STRING50):0,0
FIELD:dlnumber:TYPE(STRING20):0,0
FIELD:dlstate:LIKE(Invalid_State):TYPE(STRING2):0,0
FIELD:phone:TYPE(STRING20):0,0
FIELD:phonetype:TYPE(STRING10):0,0
FIELD:uscitizenflag:TYPE(STRING1):0,0
FIELD:addresstype:TYPE(STRING20):0,0
FIELD:street:TYPE(STRING150):0,0
FIELD:unit:TYPE(STRING20):0,0
FIELD:city:LIKE(Invalid_City):TYPE(STRING50):0,0
FIELD:orig_state:TYPE(STRING2):0,0
FIELD:orig_zip:LIKE(Invalid_Zip):TYPE(STRING9):0,0
FIELD:county:TYPE(STRING50):0,0
FIELD:institutionname:TYPE(STRING100):0,0
FIELD:institutiondetails:TYPE(STRING200):0,0
FIELD:institutionreceiptdate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:releasetolocation:TYPE(STRING100):0,0
FIELD:releasetodetails:TYPE(STRING200):0,0
FIELD:deceasedflag:TYPE(STRING1):0,0
FIELD:deceaseddate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:healthflag:TYPE(STRING1):0,0
FIELD:healthdesc:TYPE(STRING100):0,0
FIELD:bloodtype:TYPE(STRING10):0,0
FIELD:sexoffenderregistrydate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:sexoffenderregexpirationdate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:sexoffenderregistrynumber:TYPE(STRING100):0,0
FIELD:sourceid:TYPE(STRING20):0,0
FIELD:vendor:TYPE(STRING10):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

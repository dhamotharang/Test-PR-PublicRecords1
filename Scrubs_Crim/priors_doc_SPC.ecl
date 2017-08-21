MODULE:Scrubs_Crim
FILENAME:crim
NAMESCOPE:priors_doc
SOURCEFIELD:vendor

FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_)
FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Non_Blank:LENGTHS(1..)
FIELDTYPE:Invalid_Current_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,'future')
FIELDTYPE:Invalid_Num:ALLOW(0123456789.)

FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0
FIELD:statecode:LIKE(Invalid_Char):TYPE(STRING2):0,0
FIELD:caseid:LIKE(Non_Blank):TYPE(STRING40):0,0
FIELD:casenumber:TYPE(STRING50):0,0
FIELD:offensedesc:TYPE(STRING100):0,0
FIELD:offensedate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:offensetype:TYPE(STRING100):0,0
FIELD:offensedegree:TYPE(STRING20):0,0
FIELD:offenseclass:TYPE(STRING20):0,0
FIELD:disposition:TYPE(STRING150):0,0
FIELD:dispositiondate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:sentencedate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:sentencebegindate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:sentenceenddate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:sentencetype:TYPE(STRING20):0,0
FIELD:sentencemaxyears:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:sentencemaxmonths:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:sentencemaxdays:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:sentenceminyears:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:sentenceminmonths:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:sentencemindays:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:scheduledreleasedate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:actualreleasedate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:sentencestatus:TYPE(STRING100):0,0
FIELD:communitysupervisioncounty:TYPE(STRING50):0,0
FIELD:communitysupervisionyears:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:communitysupervisionmonths:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:communitysupervisiondays:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:sourcename:LIKE(Non_Blank):TYPE(STRING100):0,0
FIELD:sourceid:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:vendor:TYPE(STRING10):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

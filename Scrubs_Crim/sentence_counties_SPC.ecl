MODULE:Scrubs_Crim
FILENAME:crim
NAMESCOPE:sentence_counties
SOURCEFIELD:vendor

FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_)
FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Non_Blank:LENGTHS(1..)
FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,'future')
FIELDTYPE:Invalid_Num:ALLOW(0123456789.)

FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0
FIELD:statecode:LIKE(Invalid_Char):TYPE(STRING2):0,0
FIELD:caseid:LIKE(Non_Blank):TYPE(STRING40):0,0
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
FIELD:timeservedyears:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:timeservedmonths:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:timeserveddays:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:publicservicehours:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:sentenceadditionalinfo:TYPE(STRING200):0,0
FIELD:communitysupervisioncounty:TYPE(STRING50):0,0
FIELD:communitysupervisionyears:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:communitysupervisionmonths:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:communitysupervisiondays:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:parolebegindate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:paroleenddate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:paroleeligibilitydate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:parolehearingdate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:parolemaxyears:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:parolemaxmonths:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:parolemaxdays:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:paroleminyears:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:paroleminmonths:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:parolemindays:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:parolestatus:TYPE(STRING100):0,0
FIELD:paroleofficer:TYPE(STRING50):0,0
FIELD:paroleoffcerphone:TYPE(STRING20):0,0
FIELD:probationbegindate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:probationenddate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:probationmaxyears:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:probationmaxmonths:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:probationmaxdays:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:probationminyears:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:probationminmonths:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:probationmindays:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:probationstatus:TYPE(STRING100):0,0
FIELD:sourcename:LIKE(Non_Blank):TYPE(STRING100):0,0
FIELD:vendor:TYPE(STRING10):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

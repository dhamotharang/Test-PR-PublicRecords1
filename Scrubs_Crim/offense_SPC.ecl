MODULE:Scrubs_Crim
FILENAME:crim
NAMESCOPE:offense
SOURCEFIELD:vendor

FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_)
FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Non_Blank:LENGTHS(1..)
FIELDTYPE:Invalid_Current_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_VictimUnder18:ENUM(Y|N|)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)

FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0
FIELD:statecode:LIKE(Invalid_Char):TYPE(STRING2):0,0
FIELD:caseid:LIKE(Non_Blank):TYPE(STRING40):0,0
FIELD:casenumber:TYPE(STRING50):0,0
FIELD:casetitle:TYPE(STRING100):0,0
FIELD:casetype:TYPE(STRING20):0,0
FIELD:casestatus:TYPE(STRING100):0,0
FIELD:casestatusdate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:casecomments:TYPE(STRING200):0,0
FIELD:fileddate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:caseinfo:TYPE(STRING100):0,0
FIELD:docketnumber:TYPE(STRING30):0,0
FIELD:offensecode:TYPE(STRING30):0,0
FIELD:offensedesc:TYPE(STRING100):0,0
FIELD:offensedate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:offensetype:TYPE(STRING100):0,0
FIELD:offensedegree:TYPE(STRING20):0,0
FIELD:offenseclass:TYPE(STRING20):0,0
FIELD:dispositionstatus:TYPE(STRING100):0,0
FIELD:dispositionstatusdate:TYPE(STRING8):0,0
FIELD:disposition:TYPE(STRING150):0,0
FIELD:dispositiondate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:offenselocation:TYPE(STRING50):0,0
FIELD:finaloffense:TYPE(STRING100):0,0
FIELD:finaloffensedate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:offensecount:TYPE(STRING4):0,0
FIELD:victimunder18:LIKE(Invalid_VictimUnder18):TYPE(STRING1):0,0
FIELD:prioroffenseflag:TYPE(STRING1):0,0
FIELD:initialplea:TYPE(STRING20):0,0
FIELD:initialpleadate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:finalruling:TYPE(STRING20):0,0
FIELD:finalrulingdate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:appealstatus:TYPE(STRING50):0,0
FIELD:appealdate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:courtname:TYPE(STRING50):0,0
FIELD:fineamount:TYPE(STRING10):0,0
FIELD:courtfee:TYPE(STRING10):0,0
FIELD:restitution:TYPE(STRING10):0,0
FIELD:trialtype:TYPE(STRING20):0,0
FIELD:courtdate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:sourcename:TYPE(STRING100):0,0
FIELD:sourceid:TYPE(STRING):0,0
FIELD:classification_code:TYPE(STRING):0,0
FIELD:sub_classification_code:TYPE(STRING):0,0
FIELD:unit:TYPE(STRING):0,0
FIELD:city:TYPE(STRING):0,0
FIELD:state:TYPE(STRING):0,0
FIELD:zip:TYPE(STRING):0,0
FIELD:county:TYPE(STRING):0,0
FIELD:institutionname:TYPE(STRING):0,0
FIELD:institutiondetails:TYPE(STRING):0,0
FIELD:institutionreceiptdate:TYPE(STRING):0,0
FIELD:releasetolocation:TYPE(STRING):0,0
FIELD:releasetodetails:TYPE(STRING):0,0
FIELD:deceasedflag:TYPE(STRING):0,0
FIELD:deceaseddate:LIKE(Invalid_Current_Date):TYPE(STRING):0,0
FIELD:healthflag:TYPE(STRING):0,0
FIELD:healthdesc:TYPE(STRING):0,0
FIELD:bloodtype:TYPE(STRING):0,0
FIELD:sexoffenderregistrydate:TYPE(STRING):0,0
FIELD:sexoffenderregexpirationdate:TYPE(STRING):0,0
FIELD:sexoffenderregistrynumber:TYPE(STRING):0,0
FIELD:sourceid2:TYPE(STRING):0,0
FIELD:vendor:TYPE(STRING10):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

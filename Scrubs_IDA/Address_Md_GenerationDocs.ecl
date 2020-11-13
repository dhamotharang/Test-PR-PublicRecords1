Generated by SALT V3.11.11
Command line options: -DC:\\Users\\granjo01\\Documents\\gitlab\\PublicRecords 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_IDA
FILENAME:IDA
NAMESCOPE:Address_Md

FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_FName:SPACES( ):LIKE(Invalid_Alpha):LENGTHS(2..15):WORDS(0,1)
FIELDTYPE:Invalid_MName:SPACES(. ):LIKE(Invalid_Alpha):LENGTHS(0,1,2):WORDS(0,1)
FIELDTYPE:Invalid_LName:SPACES( ):LIKE(Invalid_Alpha):LENGTHS(2..20):WORDS(0,1)
FIELDTYPE:Invalid_Suffix:SPACES( ):ALLOW(.123IVXJRSr):LENGTHS(0,1,2,3):WORDS(0,1)
FIELDTYPE:Invalid_Address1:SPACES( ):LIKE(Invalid_AlphaNum):WORDS(0..7)
FIELDTYPE:Invalid_Address2:SPACES( #):LIKE(Invalid_AlphaNum):WORDS(0..2)
FIELDTYPE:Invalid_City:SPACES( ):LIKE(Invalid_Alpha):WORDS(0..4)
FIELDTYPE:Invalid_State:CUSTOM(Scrubs.Functions.fn_verify_state > 0)
FIELDTYPE:Invalid_Zip:LIKE(Invalid_Num):LENGTHS(0,4,5,9)
FIELDTYPE:Invalid_DOB:CUSTOM(Scrubs.Functions.fn_dob > 0)
FIELDTYPE:Invalid_SSN:SPACES( ):ALLOW(0123456789):LENGTHS(0,9):WORDS(0,1)
FIELDTYPE:Invalid_DL:CUSTOM(Scrubs.Functions.FN_valid_DL > 0)
FIELDTYPE:Invalid_Phone:LIKE(Invalid_Num):LENGTHS(0,10)
FIELDTYPE:Invalid_Phone2:ALLOW(0123456789X):LENGTHS(0,7,10)
FIELDTYPE:Invalid_Phone3:CUSTOM(Scrubs.Functions.fn_Valid_Phone > 0)
FIELDTYPE:Invalid_Clientassigneduniquerecordid:LIKE(Invalid_Num)
FIELDTYPE:Invalid_Emailaddress:CUSTOM(Scrubs.Functions.fn_valid_email > 0)
FIELDTYPE:Invalid_Ipaddress:CUSTOM(Scrubs.Functions.fn_valid_IP > 0)


FIELD:firstname:TYPE(STRING20):LIKE(Invalid_FName):0,0
FIELD:middlename:TYPE(STRING20):LIKE(Invalid_MName):0,0
FIELD:lastname:TYPE(STRING25):LIKE(Invalid_LName):0,0
FIELD:suffix:TYPE(STRING3):LIKE(Invalid_Suffix):0,0
FIELD:addressline1:TYPE(STRING50):LIKE(Invalid_Address1):0,0
FIELD:addressline2:TYPE(STRING20):LIKE(Invalid_Address2):0,0
FIELD:city:TYPE(STRING35):LIKE(Invalid_City):0,0
FIELD:state:TYPE(STRING2):LIKE(Invalid_State):0,0
FIELD:zip:TYPE(UNSIGNED3):LIKE(Invalid_Zip):0,0
FIELD:dob:TYPE(UNSIGNED4):LIKE(Invalid_DOB):0,0
FIELD:ssn:TYPE(STRING12):LIKE(Invalid_SSN):0,0
FIELD:dl:TYPE(STRING12):LIKE(Invalid_DL):0,0
FIELD:dlstate:TYPE(STRING5):LIKE(Invalid_State):0,0
FIELD:phone:TYPE(STRING10):LIKE(Invalid_Phone):0,0
FIELD:phone2:TYPE(STRING10):LIKE(Invalid_Phone2):0,0
FIELD:phone3:TYPE(STRING10):LIKE(Invalid_Phone3):0,0
FIELD:clientassigneduniquerecordid:TYPE(UNSIGNED8):LIKE(Invalid_Clientassigneduniquerecordid):0,0
FIELD:emailaddress:TYPE(STRING50):LIKE(Invalid_Emailaddress):0,0
FIELD:ipaddress:TYPE(STRING15):LIKE(Invalid_Ipaddress):0,0
FIELD:filecategory:TYPE(STRING):0,0



Total available specificity:0
Search Threshold set at -4
Use of PERSISTs in code set at:3


__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters

Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.

Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.


__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.



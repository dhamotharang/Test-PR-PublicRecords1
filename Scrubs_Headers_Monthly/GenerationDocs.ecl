﻿Generated by SALT V3.11.9
Command line options: -MScrubs_Headers_Monthly -eC:\Users\granjo01\AppData\Local\Temp\TFRC053.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Headers_Monthly
FILENAME:File
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking
 
FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
 
FIELDTYPE:did:SPACES( ):LIKE(Invalid_Num):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:rid:SPACES( ):LIKE(Invalid_Num):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:pflag1:SPACES( ):ALLOW(+A):LENGTHS(1,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:pflag2:SPACES( ):ALLOW(?ANR):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:pflag3:SPACES( ):ALLOW(GV):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:src:SPACES( ):ALLOW(!+.01234567?ABCDEFGHIKLMNOPQRSTUVWXYZ):LENGTHS(2,1,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:dt_first_seen:SPACES( ):LIKE(Invalid_Num):LENGTHS(6,0,1):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:dt_last_seen:SPACES( ):LIKE(Invalid_Num):LENGTHS(6,0,1):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:dt_vendor_last_reported:SPACES( ):LIKE(Invalid_Num):LENGTHS(6,0,1):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:dt_vendor_first_reported:SPACES( ):LIKE(Invalid_Num):LENGTHS(6,0,1):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:dt_nonglb_last_seen:SPACES( ):LIKE(Invalid_Num):LENGTHS(0,6,1):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:rec_type:SPACES( ):ALLOW(123AHS):LENGTHS(1,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:vendor_id:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:phone:SPACES( ):LIKE(Invalid_Num):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:ssn:SPACES( ):LIKE(Invalid_Num):LENGTHS(9,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:dob:SPACES( ):LIKE(Invalid_Num):LENGTHS(8,1,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:title:SPACES( ):ALLOW(MRS):LENGTHS(2,0):ONFAIL(CLEAN)
FIELDTYPE:fname:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)
FIELDTYPE:mname:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)
FIELDTYPE:lname:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)
FIELDTYPE:name_suffix:SPACES( ):ALLOW(12345JRS):ONFAIL(CLEAN)
FIELDTYPE:prim_range:SPACES( ):ALLOW(-/0123456789ABNW):ONFAIL(CLEAN)
FIELDTYPE:predir:SPACES( ):ALLOW(ENSW):ONFAIL(CLEAN)
FIELDTYPE:prim_name:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ):ONFAIL(CLEAN)
FIELDTYPE:suffix:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)
FIELDTYPE:postdir:SPACES( ):ALLOW(ENSW):ONFAIL(CLEAN)
FIELDTYPE:unit_desig:SPACES( ):ALLOW(#ABCDEFILMNOPRSTUX):ONFAIL(CLEAN)
FIELDTYPE:sec_range:SPACES( ):ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVW):ONFAIL(CLEAN)
FIELDTYPE:city_name:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)
FIELDTYPE:st:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)
FIELDTYPE:zip:SPACES( ):LIKE(Invalid_Num):LENGTHS(5,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:zip4:SPACES( ):LIKE(Invalid_Num):LENGTHS(4,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:county:SPACES( ):LIKE(Invalid_Num):LENGTHS(3,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:geo_blk:SPACES( ):LIKE(Invalid_Num):LENGTHS(7,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:cbsa:SPACES( ):LIKE(Invalid_Num):LENGTHS(5,4,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:tnt:SPACES( ):ALLOW(DNPY):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:valid_ssn:SPACES( ):ALLOW(BFGORUZ):LENGTHS(1,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:jflag1:SPACES( ):ALLOW(CLTU):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:jflag2:SPACES( ):ALLOW(ABCD):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:jflag3:SPACES( ):ALLOW(C):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:rawaid:SPACES( ):LIKE(Invalid_Num):LENGTHS(13,1,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:dodgy_tracking:SPACES( ):ALLOW(0123456789KNU):LENGTHS(0,3):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:nid:SPACES( ):ONFAIL(CLEAN)
FIELDTYPE:address_ind:SPACES( ):ONFAIL(CLEAN)
FIELDTYPE:name_ind:SPACES( ):ONFAIL(CLEAN)
FIELDTYPE:persistent_record_id:SPACES( ):ONFAIL(CLEAN)
 
FIELD:did:LIKE(did):TYPE(UNSIGNED6):0,0
FIELD:rid:LIKE(rid):TYPE(UNSIGNED6):0,0
FIELD:pflag1:LIKE(pflag1):TYPE(STRING1):0,0
FIELD:pflag2:LIKE(pflag2):TYPE(STRING1):0,0
FIELD:pflag3:LIKE(pflag3):TYPE(STRING1):0,0
FIELD:src:LIKE(src):TYPE(STRING2):0,0
FIELD:dt_first_seen:LIKE(dt_first_seen):TYPE(UNSIGNED3):0,0
FIELD:dt_last_seen:LIKE(dt_last_seen):TYPE(UNSIGNED3):0,0
FIELD:dt_vendor_last_reported:LIKE(dt_vendor_last_reported):TYPE(UNSIGNED3):0,0
FIELD:dt_vendor_first_reported:LIKE(dt_vendor_first_reported):TYPE(UNSIGNED3):0,0
FIELD:dt_nonglb_last_seen:LIKE(dt_nonglb_last_seen):TYPE(UNSIGNED3):0,0
FIELD:rec_type:LIKE(rec_type):TYPE(STRING1):0,0
FIELD:vendor_id:LIKE(vendor_id):TYPE(QSTRING14):0,0
FIELD:phone:LIKE(phone):TYPE(QSTRING8):0,0
FIELD:ssn:LIKE(ssn):TYPE(QSTRING7):0,0
FIELD:dob:LIKE(dob):TYPE(INTEGER4):0,0
FIELD:title:LIKE(title):TYPE(QSTRING4):0,0
FIELD:fname:LIKE(fname):TYPE(QSTRING15):0,0
FIELD:mname:LIKE(mname):TYPE(QSTRING15):0,0
FIELD:lname:LIKE(lname):TYPE(QSTRING15):0,0
FIELD:name_suffix:LIKE(name_suffix):TYPE(QSTRING4):0,0
FIELD:prim_range:LIKE(prim_range):TYPE(QSTRING8):0,0
FIELD:predir:LIKE(predir):TYPE(STRING2):0,0
FIELD:prim_name:LIKE(prim_name):TYPE(QSTRING21):0,0
FIELD:suffix:LIKE(suffix):TYPE(QSTRING3):0,0
FIELD:postdir:LIKE(postdir):TYPE(STRING2):0,0
FIELD:unit_desig:LIKE(unit_desig):TYPE(QSTRING8):0,0
FIELD:sec_range:LIKE(sec_range):TYPE(QSTRING6):0,0
FIELD:city_name:LIKE(city_name):TYPE(QSTRING19):0,0
FIELD:st:LIKE(st):TYPE(STRING2):0,0
FIELD:zip:LIKE(zip):TYPE(QSTRING4):0,0
FIELD:zip4:LIKE(zip4):TYPE(QSTRING3):0,0
FIELD:county:LIKE(county):TYPE(STRING3):0,0
FIELD:geo_blk:LIKE(geo_blk):TYPE(QSTRING6):0,0
FIELD:cbsa:LIKE(cbsa):TYPE(QSTRING4):0,0
FIELD:tnt:LIKE(tnt):TYPE(STRING1):0,0
FIELD:valid_ssn:LIKE(valid_ssn):TYPE(STRING1):0,0
FIELD:jflag1:LIKE(jflag1):TYPE(STRING1):0,0
FIELD:jflag2:LIKE(jflag2):TYPE(STRING1):0,0
FIELD:jflag3:LIKE(jflag3):TYPE(STRING1):0,0
FIELD:rawaid:LIKE(rawaid):TYPE(UNSIGNED8):0,0
FIELD:dodgy_tracking:LIKE(dodgy_tracking):TYPE(STRING5):0,0
FIELD:nid:LIKE(nid):TYPE(UNSIGNED8):0,0
FIELD:address_ind:LIKE(address_ind):TYPE(UNSIGNED2):0,0
FIELD:name_ind:LIKE(name_ind):TYPE(UNSIGNED2):0,0
FIELD:persistent_record_id:LIKE(persistent_record_id):TYPE(UNSIGNED8):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
 
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
 

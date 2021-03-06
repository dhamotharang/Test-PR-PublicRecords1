Generated by SALT V3.7.0
Command line options: -MBair_ExternalLinkKeys_V2 -eC:\Users\nookse01\AppData\Local\Temp\TFR89B2.tmp 
File being processed :-
OPTIONS:-ma
MODULE:Bair_ExternalLinkKeys_V2 
FILENAME:Classify_PS
IDNAME:EID_HASH
IDFIELD:EXISTS:EID_HASH
RECORDS:300000000
POPULATION:270000000
NINES:3
PROCESS:PS:UBER(NEVER)
FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("'):ONFAIL(CLEAN):
FIELDTYPE:NUMBER:ALLOW(0123456789):
FIELDTYPE:T_ALLCAPS:CAPS:ONFAIL(CLEAN)
FIELDTYPE:T_ALPHANUM:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
// FUZZY
FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)
FIELD:NAME_SUFFIX:PROP:LIKE(T_ALPHANUM):6,54 //Changed from sname to NAME_Suffix
FIELD:FNAME:TYPE(STRING20):INITIAL:PHONETIC:EDIT1:PreferredName:WEIGHT(0.8):LIKE(T_ALPHANUM):9,263
FIELD:MNAME:TYPE(STRING20):INITIAL:PROP:EDIT2:WEIGHT(0.8):LIKE(T_ALPHANUM):8,228
FIELD:LNAME:TYPE(STRING28):BAGOFWORDS(ANY):WEIGHT(2):LIKE(T_ALPHANUM):11,383
//Address
FIELD:PRIM_RANGE:TYPE(STRING10):EDIT1:11,463
FIELD:PRIM_NAME:TYPE(STRING28):EDIT1:11,469
FIELD:SEC_RANGE:TYPE(STRING8):CONTEXT(PRIM_NAME):HYPHEN2:8,371
FIELD:P_CITY_NAME:TYPE(STRING25):CONTEXT(ST):10,420
FIELD:ST:TYPE(STRING2):5,310
FIELD:ZIP:TYPE(STRING5):LIKE(NUMBER):14,0
DATEFIELD:DOB:SOFT1(4.0):YEARSHIFT13(4.0):MDDM:PROP:FORCE(--3):15,0
FIELD:PHONE:TYPE(STRING10):LIKE(NUMBER):WEIGHT(0.5):PROP:21,420
FIELD:DL_ST:TYPE(STRING15):9,25
FIELD:DL:CONTEXT(DL_ST):23,124
//
FIELD:LEXID:15,350
FIELD:POSSIBLE_SSN:TYPE(STRING9):EDIT1:PROP:24,35
FIELD:CRIME:TYPE(STRING):10,45
FIELD:NAME_TYPE:TYPE(STRING):10,45
FIELD:CLEAN_GENDER:TYPE(STRING):10,45
FIELD:CLASS_CODE:10,0
FIELD:DT_FIRST_SEEN:1,0
FIELD:DT_LAST_SEEN:1,0
FIELD:DATA_PROVIDER_ORI:10,120
//vehicle
FIELD:VIN:TYPE(STRING27):12,450
FIELD:PLATE:TYPE(STRING):1,0
//LATLONG
FIELD:LATITUDE:TYPE(STRING):1,0
FIELD:LONGITUDE:TYPE(STRING):1,0
FIELD:SEARCH_ADDR1:TYPE(STRING):18,576
FIELD:SEARCH_ADDR2:TYPE(STRING):20,520
FIELD:CLEAN_COMPANY_NAME:TYPE(STRING100):22,550
// Concept
CONCEPT:MAINNAME:FNAME:MNAME:LNAME:22,691
CONCEPT:FULLNAME:MAINNAME:NAME_SUFFIX:22,529
HACK:KEYPREFIX
HACK:KEYINFIX
HACK:KEYSUPERFILE
HACK:MAXBLOCKSIZE(5000)
LINKPATH:NAME:FNAME:LNAME:ST:?:NAME_SUFFIX:MNAME:+:PRIM_RANGE:PRIM_NAME:SEC_RANGE:P_CITY_NAME:DOB:SEARCH_ADDR1:SEARCH_ADDR2:LEXID:MAXBLOCKSIZE(500)
LINKPATH:ADDRESS:PRIM_RANGE:PRIM_NAME:ZIP:?:SEC_RANGE:MAINNAME:+:P_CITY_NAME:ST:NAME_SUFFIX:DOB
LINKPATH:DOB:DOB:LNAME:?:FNAME:MNAME:+:ST:P_CITY_NAME:NAME_SUFFIX
LINKPATH:ZIP_PR:ZIP:PRIM_RANGE:?:FNAME:LNAME:+:PRIM_NAME:SEC_RANGE:P_CITY_NAME:ST:NAME_SUFFIX:DOB
LINKPATH:DLN:DL:DL_ST:?:MAINNAME:+:NAME_SUFFIX:DOB
LINKPATH:PH:PHONE:?:MAINNAME:DOB:+:P_CITY_NAME:ST
LINKPATH:LFZ:LNAME:FNAME:ZIP:+:P_CITY_NAME:PRIM_RANGE:PRIM_NAME:MNAME:SEC_RANGE:NAME_SUFFIX:DOB
LINKPATH:VIN:VIN:?:LNAME:+:P_CITY_NAME
LINKPATH:LEXID:LEXID:?:MAINNAME:+:NAME_SUFFIX:DOB:DL
LINKPATH:SSN:POSSIBLE_SSN:?:MAINNAME:+:SEARCH_ADDR1:P_CITY_NAME:ST:DOB
LINKPATH:LATLONG:LATITUDE:LONGITUDE:?:MAINNAME:+:POSSIBLE_SSN
LINKPATH:PLATE:PLATE:?:MAINNAME:+:P_CITY_NAME:ST
LINKPATH:COMPANY:CLEAN_COMPANY_NAME:?:SEARCH_ADDR1(HASBASE):+:P_CITY_NAME:ST:SEARCH_ADDR2:LEXID
 
Total available specificity:371
Specificity number that should imply one record specified 28.
Assuming an average of 1 records per cluster
Specificity value at which N^2 joins will be tolerated: 22
Recommended matching threshold 38
Search Threshold set at 17
Use of PERSISTs in code set at:3
Link paths supported :-
UBER Key
// Search threshold computed from blocksize: 21
FNAME:LNAME:ST:?:NAME_SUFFIX:MNAME:+:PRIM_RANGE:PRIM_NAME:SEC_RANGE:P_CITY_NAME:DOB:SEARCH_ADDR1:SEARCH_ADDR2:LEXIDPRIM_RANGE:PRIM_NAME:ZIP:?:SEC_RANGE:MAINNAME:+:P_CITY_NAME:ST:NAME_SUFFIX:DOBDOB:LNAME:?:FNAME:MNAME:+:ST:P_CITY_NAME:NAME_SUFFIXZIP:PRIM_RANGE:?:FNAME:LNAME:+:PRIM_NAME:SEC_RANGE:P_CITY_NAME:ST:NAME_SUFFIX:DOBDL:DL_ST:?:MAINNAME:+:NAME_SUFFIX:DOBPHONE:?:MAINNAME:DOB:+:P_CITY_NAME:STLNAME:FNAME:?:ZIP:+:P_CITY_NAME:PRIM_RANGE:PRIM_NAME:MNAME:SEC_RANGE:NAME_SUFFIX:DOB:STVIN:?:LNAME:+:P_CITY_NAME:STLEXID:?:MAINNAME:+:NAME_SUFFIX:DOB:DL:DL_STPOSSIBLE_SSN:?:MAINNAME:+:SEARCH_ADDR1:P_CITY_NAME:ST:DOBLATITUDE:LONGITUDE:?:MAINNAME:+:POSSIBLE_SSNPLATE:?:MAINNAME:+:P_CITY_NAME:STCLEAN_COMPANY_NAME:?:SEARCH_ADDR1:+:P_CITY_NAME:ST:SEARCH_ADDR2:LEXID
 
______________________________English Description of External Matching Process___________________________
 
SALT generated external matching is based upon the concept of LinkPaths which correspond to Roxie keys.
 
Each LinkPath consists of three sections :-
  -- Fixed - these fields must match perfectly (byte for byte) for a match to occur
  -- Optional - if present these fields must match; at least using fuzzy search criteria
  -- Extra Credit - if these fields match then points are allocated
Any search, or external matching request will then be analysed to see which fields are present in the query.
Based upon that analysis it is possible to determine which Fixed criteria could possibly match.
All of those linkpaths that could match will then be searched to see if a match exists.
Every matching record from every matching linkpath is then scored and then the scores are tallied by EID_HASH.
The distance of the leading scorer from the rest of the possible matches then determines the confidence of the match (if any).
In the following each individual linkpath is described; brief descriptions of field level matching will be given.
More detail regarding the precise matching done on a field by field basis will follow and will be common for all linkpaths that use that field.
 
LinkPath NAME:
FNAME:LNAME:ST:?:NAME_SUFFIX:MNAME:+:PRIM_RANGE:PRIM_NAME:SEC_RANGE:P_CITY_NAME:DOB:SEARCH_ADDR1:SEARCH_ADDR2:LEXIDIn order for LinkPath NAME to be considered for matching the fields FNAME, LNAME and ST
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the fields NAME_SUFFIX and MNAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of PRIM_RANGE,PRIM_NAME,SEC_RANGE,P_CITY_NAME,DOB,SEARCH_ADDR1,SEARCH_ADDR2,LEXID which match to any extent.
 
LinkPath ADDRESS:
PRIM_RANGE:PRIM_NAME:ZIP:?:SEC_RANGE:MAINNAME:+:P_CITY_NAME:ST:NAME_SUFFIX:DOBIn order for LinkPath ADDRESS to be considered for matching the fields PRIM_RANGE, PRIM_NAME and ZIP
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the fields SEC_RANGE and MAINNAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of P_CITY_NAME,ST,NAME_SUFFIX,DOB which match to any extent.
 
LinkPath DOB:
DOB:LNAME:?:FNAME:MNAME:+:ST:P_CITY_NAME:NAME_SUFFIXIn order for LinkPath DOB to be considered for matching the fields DOB and LNAME
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the fields FNAME and MNAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of ST,P_CITY_NAME,NAME_SUFFIX which match to any extent.
 
LinkPath ZIP_PR:
ZIP:PRIM_RANGE:?:FNAME:LNAME:+:PRIM_NAME:SEC_RANGE:P_CITY_NAME:ST:NAME_SUFFIX:DOBIn order for LinkPath ZIP_PR to be considered for matching the fields ZIP and PRIM_RANGE
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the fields FNAME and LNAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of PRIM_NAME,SEC_RANGE,P_CITY_NAME,ST,NAME_SUFFIX,DOB which match to any extent.
 
LinkPath DLN:
DL:DL_ST:?:MAINNAME:+:NAME_SUFFIX:DOBIn order for LinkPath DLN to be considered for matching the fields DL and DL_ST
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the field MAINNAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of NAME_SUFFIX,DOB which match to any extent.
 
LinkPath PH:
PHONE:?:MAINNAME:DOB:+:P_CITY_NAME:STIn order for LinkPath PH to be considered for matching the field PHONE
must be present in the query and for a match it must be completely identical.
In addition for a record to be considered for scoring the fields MAINNAME and DOB
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of P_CITY_NAME,ST which match to any extent.
 
LinkPath LFZ:
LNAME:FNAME:?:ZIP:+:P_CITY_NAME:PRIM_RANGE:PRIM_NAME:MNAME:SEC_RANGE:NAME_SUFFIX:DOB:STIn order for LinkPath LFZ to be considered for matching the fields LNAME and FNAME
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the field ZIP
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of P_CITY_NAME,PRIM_RANGE,PRIM_NAME,MNAME,SEC_RANGE,NAME_SUFFIX,DOB,ST which match to any extent.
 
LinkPath VIN:
VIN:?:LNAME:+:P_CITY_NAME:STIn order for LinkPath VIN to be considered for matching the field VIN
must be present in the query and for a match it must be completely identical.
In addition for a record to be considered for scoring the field LNAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of P_CITY_NAME,ST which match to any extent.
 
LinkPath LEXID:
LEXID:?:MAINNAME:+:NAME_SUFFIX:DOB:DL:DL_STIn order for LinkPath LEXID to be considered for matching the field LEXID
must be present in the query and for a match it must be completely identical.
In addition for a record to be considered for scoring the field MAINNAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of NAME_SUFFIX,DOB,DL,DL_ST which match to any extent.
 
LinkPath SSN:
POSSIBLE_SSN:?:MAINNAME:+:SEARCH_ADDR1:P_CITY_NAME:ST:DOBIn order for LinkPath SSN to be considered for matching the field POSSIBLE_SSN
must be present in the query and for a match it must be completely identical.
In addition for a record to be considered for scoring the field MAINNAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of SEARCH_ADDR1,P_CITY_NAME,ST,DOB which match to any extent.
 
LinkPath LATLONG:
LATITUDE:LONGITUDE:?:MAINNAME:+:POSSIBLE_SSNIn order for LinkPath LATLONG to be considered for matching the fields LATITUDE and LONGITUDE
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the field MAINNAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of POSSIBLE_SSN which match to any extent.
 
LinkPath PLATE:
PLATE:?:MAINNAME:+:P_CITY_NAME:STIn order for LinkPath PLATE to be considered for matching the field PLATE
must be present in the query and for a match it must be completely identical.
In addition for a record to be considered for scoring the field MAINNAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of P_CITY_NAME,ST which match to any extent.
 
LinkPath COMPANY:
CLEAN_COMPANY_NAME:?:SEARCH_ADDR1:+:P_CITY_NAME:ST:SEARCH_ADDR2:LEXIDIn order for LinkPath COMPANY to be considered for matching the field CLEAN_COMPANY_NAME
must be present in the query and for a match it must be completely identical.
In addition for a record to be considered for scoring the field SEARCH_ADDR1
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of P_CITY_NAME,ST,SEARCH_ADDR2,LEXID which match to any extent.
 
The detailed scoring for the individual fields is the same from linkpath to linkpath and is as follows:-
NAME_SUFFIX Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two NAME_SUFFIX fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the NAME_SUFFIX
but should average 6 points.
It should also be noted that NAME_SUFFIX is a child field of FULLNAME. Therefore if FULLNAME is a full match this field will score 0.
This field is scaled to match with its parent FULLNAME, on average that will mean multiplying by 78%
 
FNAME Scoring: Two FNAME fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - one is the leading part of the other
  - one can be turned into the other with 1 edit (see Glossary)
  - if the two fields have the same metaphone handle
  - if the two fields have the same value for the function PreferredName
The exact number of points allocated to a match will depend upon the global scarcity of the FNAME
and the degree of fuzziness required but should average 9 points.
The SPC file has specified that the weight should be multiplied by  0.80
It should also be noted that FNAME is a child field of MAINNAME. Therefore if MAINNAME is a full match this field will score 0.
This field is scaled to match with its parent MAINNAME, on average that will mean multiplying by 78%
 
MNAME Scoring: If a field is null or an initial and another record in the same cluster has a fuller value for that field then the other records value will be used.
Two MNAME fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - one is the leading part of the other
  - one can be turned into the other with 2 edits (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the MNAME
and the degree of fuzziness required but should average 8 points.
The SPC file has specified that the weight should be multiplied by  0.80
It should also be noted that MNAME is a child field of MAINNAME. Therefore if MAINNAME is a full match this field will score 0.
This field is scaled to match with its parent MAINNAME, on average that will mean multiplying by 78%
 
LNAME Scoring: Two LNAME fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - if the space separated tokens in one match the other if re-arranged
The exact number of points allocated to a match will depend upon the global scarcity of the LNAME
and the degree of fuzziness required but should average 11 points.
The SPC file has specified that the weight should be multiplied by  2.00
It should also be noted that LNAME is a child field of MAINNAME. Therefore if MAINNAME is a full match this field will score 0.
This field is scaled to match with its parent MAINNAME, on average that will mean multiplying by 78%
 
PRIM_RANGE Scoring: Two PRIM_RANGE fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the PRIM_RANGE
and the degree of fuzziness required but should average 11 points.
 
PRIM_NAME Scoring: Two PRIM_NAME fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the PRIM_NAME
and the degree of fuzziness required but should average 11 points.
 
SEC_RANGE Scoring: 
The scoring for this field is ignored unless the PRIM_NAME fields are identical.
Two SEC_RANGE fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - if the two strings are identical if hypens and spaces are ignored
  - if one is the leading or trailing part of the other
The exact number of points allocated to a match will depend upon the global scarcity of the SEC_RANGE
and the degree of fuzziness required but should average 8 points.
 
P_CITY_NAME Scoring: 
The scoring for this field is ignored unless the ST fields are identical.
Two P_CITY_NAME fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the P_CITY_NAME
but should average 10 points.
 
ST Scoring: Two ST fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the ST
but should average 5 points.
 
ZIP Scoring: Two ZIP fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the ZIP
but should average 14 points.
 
DOB Scoring: In order for two records to be a match it is also required that the DOB fields not not match.
Specifically the score awarded to this field must be >= 3 unless one field is null.
If one or more components (year/month/day) of the field are blank then a value from a different record
in the same cluster will be used provided the other components match. eg DAY will propagate in cluster if year/month match.
Two DOB fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - if a Month or Day miss-match has a 01 on either side it will count as a 0 for that component
  - if the decade value differs by 1 it will be considered a fuzzy match
  - if the Year value differs by 3 it will be considered a fuzzy match
  - if the month component matches the day and vice-versi it will be considered a fuzzy match
  - otherwise each component of the score will be scored individually
The exact number of points allocated to a match will depend upon the global scarcity of the DOB
but should average 15 points.
 
PHONE Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two PHONE fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the PHONE
but should average 21 points.
The SPC file has specified that the weight should be multiplied by  0.50
 
DL_ST Scoring: Two DL_ST fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the DL_ST
but should average 9 points.
 
DL Scoring: 
The scoring for this field is ignored unless the DL_ST fields are identical.
Two DL fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the DL
but should average 23 points.
 
LEXID Scoring: Two LEXID fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the LEXID
but should average 15 points.
 
POSSIBLE_SSN Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two POSSIBLE_SSN fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the POSSIBLE_SSN
and the degree of fuzziness required but should average 24 points.
 
CRIME Scoring: Two CRIME fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the CRIME
but should average 10 points.
 
NAME_TYPE Scoring: Two NAME_TYPE fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the NAME_TYPE
but should average 10 points.
 
CLEAN_GENDER Scoring: Two CLEAN_GENDER fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the CLEAN_GENDER
but should average 10 points.
 
CLASS_CODE Scoring: Two CLASS_CODE fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the CLASS_CODE
but should average 10 points.
 
DT_FIRST_SEEN Scoring: Two DT_FIRST_SEEN fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the DT_FIRST_SEEN
but should average 1 points.
 
DT_LAST_SEEN Scoring: Two DT_LAST_SEEN fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the DT_LAST_SEEN
but should average 1 points.
 
DATA_PROVIDER_ORI Scoring: Two DATA_PROVIDER_ORI fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the DATA_PROVIDER_ORI
but should average 10 points.
 
VIN Scoring: Two VIN fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the VIN
but should average 12 points.
 
PLATE Scoring: Two PLATE fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the PLATE
but should average 1 points.
 
LATITUDE Scoring: Two LATITUDE fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the LATITUDE
but should average 1 points.
 
LONGITUDE Scoring: Two LONGITUDE fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the LONGITUDE
but should average 1 points.
 
SEARCH_ADDR1 Scoring: Two SEARCH_ADDR1 fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the SEARCH_ADDR1
but should average 18 points.
 
SEARCH_ADDR2 Scoring: Two SEARCH_ADDR2 fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the SEARCH_ADDR2
but should average 20 points.
 
CLEAN_COMPANY_NAME Scoring: Two CLEAN_COMPANY_NAME fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the CLEAN_COMPANY_NAME
but should average 22 points.
 
 
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
 

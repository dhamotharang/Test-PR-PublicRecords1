Generated by SALT V2.9 Gold SR1
File being processed :-
//MODULE:Health_Facility_Services
MODULE:PRTE_Health_Facility_Services
PROCESS:xLNPID:UBER(REQUIRED)
FILENAME:HealthFacility
IDNAME:LNPID
IDFIELD:EXISTS:LNPID
FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("'):ONFAIL(CLEAN):
FIELDTYPE:NUMBER:ALLOW(0123456789-):
FIELDTYPE:ALPHA:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):
FIELDTYPE:ALPHANUM:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):
FIELDTYPE:WORDBAG:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN):
//Uncomment up to NINES for internal or external adl
//RIDFIELD:RID
RECORDS:7784262
POPULATION:1600000
NINES:4
//Fuzzy
FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)
FUZZY:CleanLic:RST:CUSTOM(fn_cleanlicense):TYPE(STRING25)
FUZZY:CleanPhone:RST:CUSTOM(fn_cleanphone):TYPE(STRING10)
//FUZZY:FTaxonomy:RST:CUSTOM(fn_taxonomy):TYPE(STRING10)
// CName
FIELD:CNAME:CARRY:0,0
FIELD:CNP_NAME:BAGOFWORDS(MANY):LIKE(WORDBAG):TYPE(STRING120):INITIAL:HYPHEN1:ABBR(ACRONYM,INITIAL,FIRST):STEM(3):EDIT1(3):13,279
FIELD:CNP_NUMBER:14,37
FIELD:CNP_STORE_NUMBER:20,44
FIELD:CNP_BTYPE:PROP:4,21
FIELD:CNP_LOWV:5,28
// Address
FIELD:PRIM_RANGE:EDIT1:LIKE(ALPHANUM):12,206
FIELD:PRIM_NAME:EDIT1:LIKE(ALPHANUM):13,285
FIELD:SEC_RANGE:LIKE(ALPHANUM):CONTEXT(PRIM_NAME):HYPHEN2:7,63
FIELD:V_CITY_NAME:LIKE(ALPHANUM):CONTEXT(ST):EDIT2:PHONETIC:11,187
FIELD:ST:LIKE(ALPHA):5,69
FIELD:ZIP:LIKE(NUMBER):13,236
//Unique
FIELD:TAX_ID:LIKE(NUMBER):WEIGHT(0.25):PROP:18:0
FIELD:FEIN:LIKE(NUMBER):WEIGHT(0.25):PROP:14:0
FIELD:PHONE:TYPE(STRING10):WEIGHT(0.25):CleanPhone:20,212
FIELD:FAX:TYPE(STRING10):WEIGHT(0.25):CleanPhone:20,185
FIELD:LIC_STATE:TYPE(STRING2):5,9
FIELD:C_LIC_NBR:CONTEXT(LIC_STATE):INITIAL:EDIT2:WEIGHT(2.0):11,93
FIELD:DEA_NUMBER:21,0
FIELD:VENDOR_ID:CONTEXT(SRC):22,920
FIELD:NPI_NUMBER:22,0
FIELD:CLIA_NUMBER:22,0
FIELD:MEDICARE_FACILITY_NUMBER:22,14
FIELD:MEDICAID_NUMBER:22,16
FIELD:NCPDP_NUMBER:22,0
FIELD:TAXONOMY:7,61
FIELD:TAXONOMY_CODE:4,10
FIELD:BDID:21,264
//Source
FIELD:SRC:TYPE(STRING2):1,880
FIELD:SOURCE_RID:CONTEXT(SRC):22,842
//FIELD:RID:34,0
//CONCEPT
CONCEPT:FAC_NAME:CNP_NAME:CNP_NUMBER:CNP_STORE_NUMBER:CNP_BTYPE:CNP_LOWV:BAGOFWORDS:20,352
CONCEPT:ADDR1:PRIM_RANGE:SEC_RANGE:PRIM_NAME:WEIGHT(0.75):20,439
CONCEPT:LOCALE:V_CITY_NAME:ST:ZIP:WEIGHT(0.5):13,238
CONCEPT:ADDRES:ADDR1:LOCALE:20,442
//LINKPATH
LINKPATH:ZBNAME:CNP_NAME:ZIP:?:PRIM_NAME:ST(HASBASE):V_CITY_NAME:+:CNP_NUMBER:CNP_STORE_NUMBER:CNP_BTYPE:CNP_LOWV:PRIM_RANGE:SEC_RANGE:TAXONOMY:TAXONOMY_CODE
LINKPATH:BNAME:CNP_NAME:?:PRIM_NAME:ST:V_CITY_NAME:+:CNP_NUMBER:CNP_STORE_NUMBER:CNP_BTYPE:CNP_LOWV:PRIM_RANGE:SEC_RANGE:ZIP(HASBASE):TAXONOMY:TAXONOMY_CODE:REQUIRED(ZBNAME)
LINKPATH:SBNAME:CNP_NAME:ST:?:PRIM_NAME:ZIP(HASBASE):V_CITY_NAME:+:CNP_NUMBER:CNP_STORE_NUMBER:CNP_BTYPE:CNP_LOWV:PRIM_RANGE:SEC_RANGE:TAXONOMY:TAXONOMY_CODE
LINKPATH:ADDRESS:PRIM_NAME:PRIM_RANGE:ZIP:?:V_CITY_NAME:ST:+:SEC_RANGE:FAC_NAME:TAXONOMY:TAXONOMY_CODE
LINKPATH:ZIP_LP:PRIM_NAME:ZIP:?:PRIM_RANGE:ST(HASBASE):+:SEC_RANGE:V_CITY_NAME:FAC_NAME:TAXONOMY:TAXONOMY_CODE
LINKPATH:CITY_LP:PRIM_NAME:V_CITY_NAME:ST:?:PRIM_RANGE:+:ZIP:SEC_RANGE:FAC_NAME:TAXONOMY:TAXONOMY_CODE
LINKPATH:PHONE_LP:PHONE:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:FAX_LP:FAX:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:LIC:C_LIC_NBR:LIC_STATE:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:VEN:VENDOR_ID:?:SRC:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:TAX:TAX_ID:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:FEN:FEIN:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:DEA:DEA_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:NPI:NPI_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:ADDR_NPI:NPI_NUMBER:?:ST:+:ADDR1:ZIP:V_CITY_NAME:FAC_NAME:TAXONOMY:TAXONOMY_CODE
LINKPATH:CLIA:CLIA_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:MEDICARE:MEDICARE_FACILITY_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:MEDICAID:MEDICAID_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:NCPDP:NCPDP_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
LINKPATH:BID:BDID:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
Total available specificity:486
Specificity number that should imply one record specified 21.
Assuming an average of 5 records per cluster
Specificity value at which N^2 joins will be tolerated: 17
Recommended matching threshold 34
Search Threshold set at 11
Use of PERSISTs in code set at:3
Link paths supported :-
UBER Key
CNP_NAME:ZIP:?:PRIM_NAME:ST:V_CITY_NAME:+:CNP_NUMBER:CNP_STORE_NUMBER:CNP_BTYPE:CNP_LOWV:PRIM_RANGE:SEC_RANGE:TAXONOMY:TAXONOMY_CODE
CNP_NAME:?:PRIM_NAME:ST:V_CITY_NAME:+:CNP_NUMBER:CNP_STORE_NUMBER:CNP_BTYPE:CNP_LOWV:PRIM_RANGE:SEC_RANGE:ZIP:TAXONOMY:TAXONOMY_CODE
CNP_NAME:ST:?:PRIM_NAME:ZIP:V_CITY_NAME:+:CNP_NUMBER:CNP_STORE_NUMBER:CNP_BTYPE:CNP_LOWV:PRIM_RANGE:SEC_RANGE:TAXONOMY:TAXONOMY_CODE
PRIM_NAME:PRIM_RANGE:ZIP:?:V_CITY_NAME:ST:+:SEC_RANGE:FAC_NAME:TAXONOMY:TAXONOMY_CODE
PRIM_NAME:ZIP:?:PRIM_RANGE:ST:+:SEC_RANGE:V_CITY_NAME:FAC_NAME:TAXONOMY:TAXONOMY_CODE
PRIM_NAME:V_CITY_NAME:ST:?:PRIM_RANGE:+:ZIP:SEC_RANGE:FAC_NAME:TAXONOMY:TAXONOMY_CODE
PHONE:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
FAX:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
C_LIC_NBR:?:LIC_STATE:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
VENDOR_ID:?:SRC:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
TAX_ID:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
FEIN:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
DEA_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
NPI_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
NPI_NUMBER:?:ST:+:ADDR1:ZIP:V_CITY_NAME:FAC_NAME:TAXONOMY:TAXONOMY_CODE
CLIA_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
MEDICARE_FACILITY_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
MEDICAID_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
NCPDP_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
BDID:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
______________________________English Description of External Matching Process___________________________
SALT generated external matching is based upon the concept of LinkPaths which correspond to Roxie keys.
Each LinkPath consists of three sections :-
  -- Fixed - these fields must match perfectly (byte for byte) for a match to occur
  -- Optional - if present these fields must match; at least using fuzzy search criteria
  -- Extra Credit - if these fields match then points are allocated
Any search, or external matching request will then be analysed to see which fields are present in the query.
Based upon that analysis it is possible to determine which Fixed criteria could possibly match.
All of those linkpaths that could match will then be searched to see if a match exists.
If none of the linkpaths could possibly be satisfied then the UBER key will be used (described later).
Every matching record from every matching linkpath is then scored and then the scores are tallied by LNPID.
The distance of the leading scorer from the rest of the possible matches then determines the confidence of the match (if any).
In the following each individual linkpath is described; brief descriptions of field level matching will be given.
More detail regarding the precise matching done on a field by field basis will follow and will be common for all linkpaths that use that field.
LinkPath ZBNAME:
CNP_NAME:ZIP:?:PRIM_NAME:ST:V_CITY_NAME:+:CNP_NUMBER:CNP_STORE_NUMBER:CNP_BTYPE:CNP_LOWV:PRIM_RANGE:SEC_RANGE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath ZBNAME to be considered for matching the fields CNP_NAME and ZIP
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the fields PRIM_NAME, ST and V_CITY_NAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath BNAME:
CNP_NAME:?:PRIM_NAME:ST:V_CITY_NAME:+:CNP_NUMBER:CNP_STORE_NUMBER:CNP_BTYPE:CNP_LOWV:PRIM_RANGE:SEC_RANGE:ZIP:TAXONOMY:TAXONOMY_CODE
Linkpath BNAME will only be invoked when ZBNAME cannot be.
In order for LinkPath BNAME to be considered for matching the field CNP_NAME
must be present in the query and for a match it must be completely identical.
In addition for a record to be considered for scoring the fields PRIM_NAME, ST and V_CITY_NAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,ZIP,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath SBNAME:
CNP_NAME:ST:?:PRIM_NAME:ZIP:V_CITY_NAME:+:CNP_NUMBER:CNP_STORE_NUMBER:CNP_BTYPE:CNP_LOWV:PRIM_RANGE:SEC_RANGE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath SBNAME to be considered for matching the fields CNP_NAME and ST
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the fields PRIM_NAME, ZIP and V_CITY_NAME
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,SEC_RANGE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath ADDRESS:
PRIM_NAME:PRIM_RANGE:ZIP:?:V_CITY_NAME:ST:+:SEC_RANGE:FAC_NAME:TAXONOMY:TAXONOMY_CODE
In order for LinkPath ADDRESS to be considered for matching the fields PRIM_NAME, PRIM_RANGE and ZIP
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the fields V_CITY_NAME and ST
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of SEC_RANGE,FAC_NAME,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath ZIP_LP:
PRIM_NAME:ZIP:?:PRIM_RANGE:ST:+:SEC_RANGE:V_CITY_NAME:FAC_NAME:TAXONOMY:TAXONOMY_CODE
In order for LinkPath ZIP_LP to be considered for matching the fields PRIM_NAME and ZIP
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the fields PRIM_RANGE and ST
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of SEC_RANGE,V_CITY_NAME,FAC_NAME,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath CITY_LP:
PRIM_NAME:V_CITY_NAME:ST:?:PRIM_RANGE:+:ZIP:SEC_RANGE:FAC_NAME:TAXONOMY:TAXONOMY_CODE
In order for LinkPath CITY_LP to be considered for matching the fields PRIM_NAME, V_CITY_NAME and ST
must all be present in the query and for a match they must all be completely identical.
In addition for a record to be considered for scoring the field PRIM_RANGE
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of ZIP,SEC_RANGE,FAC_NAME,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath PHONE_LP:
PHONE:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath PHONE_LP to be considered for matching the field PHONE
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath FAX_LP:
FAX:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath FAX_LP to be considered for matching the field FAX
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath LIC:
C_LIC_NBR:?:LIC_STATE:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath LIC to be considered for matching the field C_LIC_NBR
must be present in the query and for a match it must be completely identical.
In addition for a record to be considered for scoring the field LIC_STATE
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath VEN:
VENDOR_ID:?:SRC:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath VEN to be considered for matching the field VENDOR_ID
must be present in the query and for a match it must be completely identical.
In addition for a record to be considered for scoring the field SRC
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath TAX:
TAX_ID:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath TAX to be considered for matching the field TAX_ID
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath FEN:
FEIN:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath FEN to be considered for matching the field FEIN
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath DEA:
DEA_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath DEA to be considered for matching the field DEA_NUMBER
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath NPI:
NPI_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath NPI to be considered for matching the field NPI_NUMBER
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath ADDR_NPI:
NPI_NUMBER:?:ST:+:ADDR1:ZIP:V_CITY_NAME:FAC_NAME:TAXONOMY:TAXONOMY_CODE
In order for LinkPath ADDR_NPI to be considered for matching the field NPI_NUMBER
must be present in the query and for a match it must be completely identical.
In addition for a record to be considered for scoring the field ST
must all be identical, null or fuzzily equal.
Additional scoring points will be allocated for any of ADDR1,ZIP,V_CITY_NAME,FAC_NAME,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath CLIA:
CLIA_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath CLIA to be considered for matching the field CLIA_NUMBER
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath MEDICARE:
MEDICARE_FACILITY_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath MEDICARE to be considered for matching the field MEDICARE_FACILITY_NUMBER
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath MEDICAID:
MEDICAID_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath MEDICAID to be considered for matching the field MEDICAID_NUMBER
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath NCPDP:
NCPDP_NUMBER:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath NCPDP to be considered for matching the field NCPDP_NUMBER
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
LinkPath BID:
BDID:+:FAC_NAME:ADDR1:LOCALE:TAXONOMY:TAXONOMY_CODE
In order for LinkPath BID to be considered for matching the field BDID
must be present in the query and for a match it must be completely identical.
Additional scoring points will be allocated for any of FAC_NAME,ADDR1,LOCALE,TAXONOMY,TAXONOMY_CODE which match to any extent.
UBER Key
In order to trigger one of the linkpaths at least one of the following field combinations must exist in the input query:
CNP_NAME:ZIP
CNP_NAME
CNP_NAME:ST
PRIM_NAME:PRIM_RANGE:ZIP
PRIM_NAME:ZIP
PRIM_NAME:V_CITY_NAME:ST
PHONE
FAX
C_LIC_NBR
VENDOR_ID
TAX_ID
FEIN
DEA_NUMBER
NPI_NUMBER
NPI_NUMBER
CLIA_NUMBER
MEDICARE_FACILITY_NUMBER
MEDICAID_NUMBER
NCPDP_NUMBER
BDID
if none of these conditions are met then the UBER key is used instead.
The UBER key is an inverted index; it will execute more slowly than the other linkpaths - but is more flexible.
For a record to match the UBER key it is required that every field in the input match the record exactly; but any combination of fields may be present.
The detailed scoring for the individual fields is the same from linkpath to linkpath and is as follows:-
CNAME Scoring: This field is not used for scoring; rather it is carried along for context and debugging
CNP_NAME Scoring: Two CNP_NAME fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
  - one is the leading part of the other
  - if the space separated tokens in one match the other if re-arranged
  - if the two strings are identical if hypens and spaces are ignored
  - if one is the leading or trailing part of the otherand a hypen or space indicates a logical break in the shorter string
The exact number of points allocated to a match will depend upon the global scarcity of the CNP_NAME
and the degree of fuzziness required but should average 13 points.
It should also be noted that CNP_NAME is a child field of FAC_NAME. Therefore if FAC_NAME is a full match this field will score 0.
This field is scaled to match with its parent FAC_NAME, on average that will mean multiplying by 35%
CNP_NUMBER Scoring: Two CNP_NUMBER fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the CNP_NUMBER
but should average 14 points.
It should also be noted that CNP_NUMBER is a child field of FAC_NAME. Therefore if FAC_NAME is a full match this field will score 0.
This field is scaled to match with its parent FAC_NAME, on average that will mean multiplying by 35%
CNP_STORE_NUMBER Scoring: Two CNP_STORE_NUMBER fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the CNP_STORE_NUMBER
but should average 20 points.
It should also be noted that CNP_STORE_NUMBER is a child field of FAC_NAME. Therefore if FAC_NAME is a full match this field will score 0.
This field is scaled to match with its parent FAC_NAME, on average that will mean multiplying by 35%
CNP_BTYPE Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two CNP_BTYPE fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the CNP_BTYPE
but should average 4 points.
It should also be noted that CNP_BTYPE is a child field of FAC_NAME. Therefore if FAC_NAME is a full match this field will score 0.
This field is scaled to match with its parent FAC_NAME, on average that will mean multiplying by 35%
CNP_LOWV Scoring: Two CNP_LOWV fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the CNP_LOWV
but should average 5 points.
It should also be noted that CNP_LOWV is a child field of FAC_NAME. Therefore if FAC_NAME is a full match this field will score 0.
This field is scaled to match with its parent FAC_NAME, on average that will mean multiplying by 35%
PRIM_RANGE Scoring: Two PRIM_RANGE fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the PRIM_RANGE
and the degree of fuzziness required but should average 12 points.
It should also be noted that PRIM_RANGE is a child field of ADDR1. Therefore if ADDR1 is a full match this field will score 0.
This field is scaled to match with its parent ADDR1, on average that will mean multiplying by 62%
PRIM_NAME Scoring: Two PRIM_NAME fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the PRIM_NAME
and the degree of fuzziness required but should average 13 points.
It should also be noted that PRIM_NAME is a child field of ADDR1. Therefore if ADDR1 is a full match this field will score 0.
This field is scaled to match with its parent ADDR1, on average that will mean multiplying by 62%
SEC_RANGE Scoring: 
The scoring for this field is ignored unless the PRIM_NAME fields are identical.
Two SEC_RANGE fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - if the two strings are identical if hypens and spaces are ignored
  - if one is the leading or trailing part of the other
The exact number of points allocated to a match will depend upon the global scarcity of the SEC_RANGE
and the degree of fuzziness required but should average 7 points.
It should also be noted that SEC_RANGE is a child field of ADDR1. Therefore if ADDR1 is a full match this field will score 0.
This field is scaled to match with its parent ADDR1, on average that will mean multiplying by 62%
V_CITY_NAME Scoring: 
The scoring for this field is ignored unless the ST fields are identical.
Two V_CITY_NAME fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - one can be turned into the other with 2 edits (see Glossary)
  - if the two fields have the same metaphone handle
The exact number of points allocated to a match will depend upon the global scarcity of the V_CITY_NAME
and the degree of fuzziness required but should average 11 points.
It should also be noted that V_CITY_NAME is a child field of LOCALE. Therefore if LOCALE is a full match this field will score 0.
This field is scaled to match with its parent LOCALE, on average that will mean multiplying by 44%
ST Scoring: Two ST fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the ST
but should average 5 points.
It should also be noted that ST is a child field of LOCALE. Therefore if LOCALE is a full match this field will score 0.
This field is scaled to match with its parent LOCALE, on average that will mean multiplying by 44%
ZIP Scoring: Two ZIP fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the ZIP
but should average 13 points.
It should also be noted that ZIP is a child field of LOCALE. Therefore if LOCALE is a full match this field will score 0.
This field is scaled to match with its parent LOCALE, on average that will mean multiplying by 44%
TAX_ID Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two TAX_ID fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the TAX_ID
but should average 18 points.
The SPC file has specified that the weight should be multiplied by  0.25
FEIN Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two FEIN fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the FEIN
but should average 14 points.
The SPC file has specified that the weight should be multiplied by  0.25
PHONE Scoring: Two PHONE fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - if the two fields have the same value for the function CleanPhone
The exact number of points allocated to a match will depend upon the global scarcity of the PHONE
but should average 20 points.
The SPC file has specified that the weight should be multiplied by  0.25
FAX Scoring: Two FAX fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - if the two fields have the same value for the function CleanPhone
The exact number of points allocated to a match will depend upon the global scarcity of the FAX
but should average 20 points.
The SPC file has specified that the weight should be multiplied by  0.25
LIC_STATE Scoring: Two LIC_STATE fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the LIC_STATE
but should average 5 points.
C_LIC_NBR Scoring: 
The scoring for this field is ignored unless the LIC_STATE fields are identical.
Two C_LIC_NBR fields will be considered to match in optional or extra credit positions if:
  - they are identical
  - one can be turned into the other with 2 edits (see Glossary)
  - one is the leading part of the other
The exact number of points allocated to a match will depend upon the global scarcity of the C_LIC_NBR
and the degree of fuzziness required but should average 11 points.
The SPC file has specified that the weight should be multiplied by  2.00
DEA_NUMBER Scoring: Two DEA_NUMBER fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the DEA_NUMBER
but should average 21 points.
VENDOR_ID Scoring: 
The scoring for this field is ignored unless the SRC fields are identical.
Two VENDOR_ID fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the VENDOR_ID
but should average 22 points.
NPI_NUMBER Scoring: Two NPI_NUMBER fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the NPI_NUMBER
but should average 22 points.
CLIA_NUMBER Scoring: Two CLIA_NUMBER fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the CLIA_NUMBER
but should average 22 points.
MEDICARE_FACILITY_NUMBER Scoring: Two MEDICARE_FACILITY_NUMBER fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the MEDICARE_FACILITY_NUMBER
but should average 22 points.
MEDICAID_NUMBER Scoring: Two MEDICAID_NUMBER fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the MEDICAID_NUMBER
but should average 22 points.
NCPDP_NUMBER Scoring: Two NCPDP_NUMBER fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the NCPDP_NUMBER
but should average 22 points.
TAXONOMY Scoring: Two TAXONOMY fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the TAXONOMY
but should average 7 points.
TAXONOMY_CODE Scoring: Two TAXONOMY_CODE fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the TAXONOMY_CODE
but should average 4 points.
BDID Scoring: Two BDID fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the BDID
but should average 21 points.
SRC Scoring: Two SRC fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the SRC
but should average 1 points.
SOURCE_RID Scoring: 
The scoring for this field is ignored unless the SRC fields are identical.
Two SOURCE_RID fields will be considered to match in optional or extra credit positions if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the SOURCE_RID
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

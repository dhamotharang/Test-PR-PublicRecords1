﻿Generated by SALT V3.11.7
Command line options: -MHealthcareNoMatchHeader_InternalLinking -eC:\Users\garrke01\AppData\Local\Temp\TFR6F2A.tmp 
File being processed :-
OPTIONS:-ga -gs2
THRESHOLD:45
MODULE:HealthcareNoMatchHeader_InternalLinking
IDNAME:nomatch_id
RIDFIELD:RID
FILENAME:HEADER
IDFIELD:EXISTS:nomatch_id
RECORDS:285873
POPULATION:300000
NINES:3
// HACK:SLICEDISTANCE:18
FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("'):ONFAIL(CLEAN):
FIELDTYPE:NUMBER:LIKE():ALLOW(0123456789):NOQUOTES("'):ONFAIL(CLEAN):
// Source Field - CARRY option ignores it for linking
FIELD:SRC:CARRY
SOURCEFIELD:SRC
// FUZZY
FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)
FUZZY:TrimLeadingZero:RST:CUSTOM(fn_TrimLeadingZero):TYPE(STRING20)
FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)
// SSN-DOB
FIELD:SSN:LIKE(NUMBER):EDIT1:0,0
DATEFIELD:DOB:PROP:SOFT1(4.0):MDDM:YEARSHIFT12(4.0):FORCE(GENERATION,--3):0,0
// LexID
FIELD:LEXID:PROP:LIKE(NUMBER):18,0
// Name
FIELD:SUFFIX:PROP:10,0
FIELD:FNAME:PROP:EDITX(6):INITIAL:PreferredName:FORCE(--):8,0
FIELD:MNAME:PROP:INITIAL:EDITX(6):14,0
FIELD:LNAME:PROP:INITIAL:HYPHEN2:EDITX(6):10,0
FIELD:GENDER:1,0
// Address
FIELD:PRIM_NAME:10,0
FIELD:PRIM_RANGE:13,0
FIELD:SEC_RANGE:HYPHEN2:8,0
FIELD:CITY_NAME:6,0
FIELD:ST:0,0
FIELD:ZIP:6,0
// Date
FIELD:DT_FIRST_SEEN:RECORDDATE(FIRST,YYYYMM):0,0
FIELD:DT_LAST_SEEN:RECORDDATE(LAST,YYYYMM):0,0
// Concept
CONCEPT:MAINNAME:FNAME:MNAME:LNAME:BAGOFWORDS:18,0
CONCEPT:ADDR1:PRIM_RANGE:SEC_RANGE:PRIM_NAME:16,0
CONCEPT:LOCALE:CITY_NAME:ST:ZIP:6,0
CONCEPT:ADDRESS:ADDR1:LOCALE:16,0
CONCEPT:FULLNAME:MAINNAME:SUFFIX:18,0
 
Total available specificity:178
Specificity number that should imply one record specified 18.
Assuming an average of 1 records per cluster
Specificity value at which N^2 joins will be tolerated: 12
User specified threshold 45
Recommended matching threshold 28
Search Threshold set at 6
Use of PERSISTs in code set at:3
 
______________________________English Description of Matching Process___________________________
 
A SALT generated matching process really only contains one single matching rule.
SALT compares every record to every possible matching record and then allocates a score to how well
the records match. SALT then pairs those clusters which have the highest match scores provided the scores
meet or exceed the matching threshold. The scoring process is highly sophisticated and detailed below
however it can essentially be thought of as allocating points for every pair of fields that match
and subtracting points for every pair of fields that do not match.
This process was told to produce 3 nines of accuracy on a population of 300000 with 285873 records.
A matching threshold of 28 is recommended although this was overridden to 45.
 
___Field by Field Breakdown of Scoring Method___
 
SRC Scoring:
This field is not used for scoring; rather it is carried along for context and debugging
SSN Scoring:
Two SSN fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the SSN
and the degree of fuzziness required but should average 0 points with a failed match subtracting 0 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for SSN.)
 
DOB Scoring:
In order for two records to be a match it is also required that the DOB fields not not match.
Specifically the score awarded to this field must be >= 3 unless one field is null.
If one or more components (year/month/day) of the field are blank then a value from a different record
in the same cluster will be used provided the other components match. eg DAY will propagate in cluster if year/month match.
Two DOB fields will be considered to match if:
  - they are identical
  - if the YEARs are more than 13 apart then the whole record will be a no match.
  - if a Month or Day miss-match has a 01 on either side it will count as a 0 for that component
  - if the decade value differs by 1 it will be considered a fuzzy match
  - if the Year value differs by 2 it will be considered a fuzzy match
  - if the month component matches the day and vice-versi it will be considered a fuzzy match
  - otherwise each component of the score will be scored individually
The exact number of points allocated to a match will depend upon the global scarcity of the DOB
but should average 0 points with a failed match subtracting 0 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for DOB.)
 
LEXID Scoring:
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two LEXID fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the LEXID
but should average 18 points with a failed match subtracting 18 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for LEXID.)
 
SUFFIX Scoring:
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two SUFFIX fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the SUFFIX
but should average 10 points with a failed match subtracting 10 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for SUFFIX.)
It should also be noted that SUFFIX is a child field of FULLNAME. Therefore if FULLNAME is a full match this field will score 0.
This field is scaled to match with its parent FULLNAME, on average that will mean multiplying by 64%
 
FNAME Scoring:
In order for two records to be a match it is also required that the FNAME fields not not match.
If a field is null or an initial and another record in the same cluster has a fuller value for that field then the other records value will be used.
Two FNAME fields will be considered to match if:
  - they are identical
  - one is the leading part of the other
  - one can be turned into the other with 2 edits (see Glossary)
  - if the two fields have the same value for the function PreferredName
The exact number of points allocated to a match will depend upon the global scarcity of the FNAME
and the degree of fuzziness required but should average 8 points with a failed match subtracting 8 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for FNAME.)
It should also be noted that FNAME is a child field of MAINNAME. Therefore if MAINNAME is a full match this field will score 0.
This field is scaled to match with its parent MAINNAME, on average that will mean multiplying by 56%
(Although the score is still computed to satisfy the forcing condition.)
 
MNAME Scoring:
If a field is null or an initial and another record in the same cluster has a fuller value for that field then the other records value will be used.
Two MNAME fields will be considered to match if:
  - they are identical
  - one is the leading part of the other
  - one can be turned into the other with 2 edits (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the MNAME
and the degree of fuzziness required but should average 14 points with a failed match subtracting 14 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for MNAME.)
It should also be noted that MNAME is a child field of MAINNAME. Therefore if MAINNAME is a full match this field will score 0.
This field is scaled to match with its parent MAINNAME, on average that will mean multiplying by 56%
 
LNAME Scoring:
If a field is null or an initial and another record in the same cluster has a fuller value for that field then the other records value will be used.
Two LNAME fields will be considered to match if:
  - they are identical
  - if the two strings are identical if hyphens and spaces are ignored
  - if one is the leading or trailing part of the other
  - one is the leading part of the other
  - one can be turned into the other with 2 edits (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the LNAME
and the degree of fuzziness required but should average 10 points with a failed match subtracting 10 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for LNAME.)
It should also be noted that LNAME is a child field of MAINNAME. Therefore if MAINNAME is a full match this field will score 0.
This field is scaled to match with its parent MAINNAME, on average that will mean multiplying by 56%
 
GENDER Scoring:
Two GENDER fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the GENDER
but should average 1 points with a failed match subtracting 1 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for GENDER.)
 
PRIM_NAME Scoring:
Two PRIM_NAME fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the PRIM_NAME
but should average 10 points with a failed match subtracting 10 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for PRIM_NAME.)
It should also be noted that PRIM_NAME is a child field of ADDR1. Therefore if ADDR1 is a full match this field will score 0.
This field is scaled to match with its parent ADDR1, on average that will mean multiplying by 51%
 
PRIM_RANGE Scoring:
Two PRIM_RANGE fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the PRIM_RANGE
but should average 13 points with a failed match subtracting 13 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for PRIM_RANGE.)
It should also be noted that PRIM_RANGE is a child field of ADDR1. Therefore if ADDR1 is a full match this field will score 0.
This field is scaled to match with its parent ADDR1, on average that will mean multiplying by 51%
 
SEC_RANGE Scoring:
Two SEC_RANGE fields will be considered to match if:
  - they are identical
  - if the two strings are identical if hyphens and spaces are ignored
  - if one is the leading or trailing part of the other
The exact number of points allocated to a match will depend upon the global scarcity of the SEC_RANGE
and the degree of fuzziness required but should average 8 points with a failed match subtracting 8 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for SEC_RANGE.)
It should also be noted that SEC_RANGE is a child field of ADDR1. Therefore if ADDR1 is a full match this field will score 0.
This field is scaled to match with its parent ADDR1, on average that will mean multiplying by 51%
 
CITY_NAME Scoring:
Two CITY_NAME fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the CITY_NAME
but should average 6 points with a failed match subtracting 6 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for CITY_NAME.)
It should also be noted that CITY_NAME is a child field of LOCALE. Therefore if LOCALE is a full match this field will score 0.
This field is scaled to match with its parent LOCALE, on average that will mean multiplying by 50%
 
ST Scoring:
Two ST fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the ST
but should average 0 points with a failed match subtracting 0 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for ST.)
It should also be noted that ST is a child field of LOCALE. Therefore if LOCALE is a full match this field will score 0.
This field is scaled to match with its parent LOCALE, on average that will mean multiplying by 50%
 
ZIP Scoring:
Two ZIP fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the ZIP
but should average 6 points with a failed match subtracting 6 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for ZIP.)
It should also be noted that ZIP is a child field of LOCALE. Therefore if LOCALE is a full match this field will score 0.
This field is scaled to match with its parent LOCALE, on average that will mean multiplying by 50%
 
DT_FIRST_SEEN Scoring:
Date fields are not presently used for scoring but are carried along for debugging purposes
DT_LAST_SEEN Scoring:
Date fields are not presently used for scoring but are carried along for debugging purposes
MAINNAME Scoring:
Two MAINNAME fields will be considered to match if:
  - they are identical
  - The fields of either concept (but not both) can be shuffled so that they match preserving the FORCE conditions upon FNAME
Note: MAINNAME is an amalgam of (FNAME,MNAME,LNAME)
Points will only be allocated for a match, the amount depending upon the scarcity of MAINNAME
but should average 18 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score).
It should also be noted that MAINNAME is a child field of FULLNAME. Therefore if FULLNAME is a full match this field will score 0.
This field is scaled to match with its parent FULLNAME, on average that will mean multiplying by 64%
 
ADDR1 Scoring:
Two ADDR1 fields will be considered to match if:
  - they are identical
Note: ADDR1 is an amalgam of (PRIM_RANGE,SEC_RANGE,PRIM_NAME)
Points will only be allocated for a match, the amount depending upon the scarcity of ADDR1
but should average 16 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score).
It should also be noted that ADDR1 is a child field of ADDRESS. Therefore if ADDRESS is a full match this field will score 0.
This field is scaled to match with its parent ADDRESS, on average that will mean multiplying by 72%
 
LOCALE Scoring:
Two LOCALE fields will be considered to match if:
  - they are identical
Note: LOCALE is an amalgam of (CITY_NAME,ST,ZIP)
Points will only be allocated for a match, the amount depending upon the scarcity of LOCALE
but should average 6 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score).
It should also be noted that LOCALE is a child field of ADDRESS. Therefore if ADDRESS is a full match this field will score 0.
This field is scaled to match with its parent ADDRESS, on average that will mean multiplying by 72%
 
ADDRESS Scoring:
Two ADDRESS fields will be considered to match if:
  - they are identical
Note: ADDRESS is an amalgam of (ADDR1,LOCALE)
Points will only be allocated for a match, the amount depending upon the scarcity of ADDRESS
but should average 16 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score).
 
FULLNAME Scoring:
Two FULLNAME fields will be considered to match if:
  - they are identical
Note: FULLNAME is an amalgam of (MAINNAME,SUFFIX)
Points will only be allocated for a match, the amount depending upon the scarcity of FULLNAME
but should average 18 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score).
 
 
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
 

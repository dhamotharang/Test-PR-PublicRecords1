Generated by SALT V3.3.0
Command line options: -MBIPV2_DotID -eC:\Users\bentlela\AppData\Local\Temp\TFR5DA3.tmp 
File being processed :-
OPTIONS:-gh -ga -p2 -gs2 
MODULE:BIPV2_DotID  
FILENAME:DOT
// ------------------------------------
//  IDs and Tuning
// ------------------------------------
RIDFIELD:rcid
IDFIELD:EXISTS:DOTid
IDPARENTS:proxid,lgid3,orgid,ultid
// 5.0B, 750M (rounded)
RECORDS:6442679314
POPULATION:750000000
NINES:3
BLOCKTHRESHOLD:5
HACK:CUSTOMINTERNALJOIN:_mj_extra
HACK:NOSLICE
HACK:NO_PARALLEL_MATCH
//FIELDTYPE:multiword:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:number:ALLOW(0123456789)
FIELDTYPE:upper:CAPS:ONFAIL(CLEAN)
//FIELDTYPE:cname:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):CUSTOM(fn_cname):ONFAIL(REJECT)
FIELDTYPE:cname:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./"):CUSTOM(fn_cname):ONFAIL(REJECT)
FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)
FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)
FUZZY:NormSuffix:RST:CUSTOM(fn_normSuffix):TYPE(STRING5)
// ------------------------------------
//  1. Company
// ------------------------------------
FIELD:company_name:LIKE(cname):CARRY:0,0
//FIELD:cnp_name:EDIT1:LIKE(multiword):FORCE(+):25,64
FIELD:cnp_name:EDIT1:FORCE(+):25,67
FIELD:corp_legal_name:BAGOFWORDS(MOST):PROP:ABBR:EDIT1:FORCE(--):TYPE(string250):25,68
FIELD:cnp_number:FORCE:14,0
FIELD:cnp_btype:PROP:3,25
FIELD:cnp_lowv:CARRY:0,0
FIELD:cnp_translated:CARRY:0,0
FIELD:cnp_classid:CARRY:0,0
FIELD:company_fein:PROP:FORCE(--):27,17
ATTRIBUTEFILE:ForeignCorpkey:NAMED(_attr_ck_charters):VALUES(company_charter_number<company_inc_state):FORCE(--,ALL):IDFIELD(dotid):26,35
// FIELD:company_inc_state:PROP:7,16
// FIELD:company_charter_number:CONTEXT(company_inc_state):PROP:FORCE(--):26,18
// Active ID fields from reliable sources
FIELD:active_duns_number:PROP:24,12
FIELD:active_enterprise_number:FORCE(--):PROP:27,0
FIELD:active_domestic_corp_key:FORCE(--):PROP:27,0
FIELD:company_bdid:CARRY:0,0
FIELD:company_phone:CARRY:0,0
CLEAVE:solo_cnum:BASIS(cnp_number):MINIMUM(1)
CLEAVE:solo_enterprise:BASIS(active_enterprise_number):MINIMUM(1)
CLEAVE:solo_corp_key:BASIS(active_domestic_corp_key):MINIMUM(1)
// ------------------------------------
//  2. Place
// ------------------------------------
FIELD:prim_range:PROP:FORCE:13,0
FIELD:prim_name:PROP:FORCE(+):15,0
FIELD:sec_range:PROP:FORCE(--):12,3
FIELD:st:LIKE(alpha):FORCE(+):5,0
FIELD:v_city_name:CONTEXT(st):11,8
FIELD:zip:LIKE(number):14,4
CONCEPT:csz:v_city_name:st:zip:FORCE(+-2):14,16
CONCEPT:addr1:prim_range:prim_name:sec_range:23,64
CONCEPT:address:addr1:csz:FORCE(+):25,77
// ------------------------------------
//  3. Contact
// ------------------------------------
FIELD:isContact:FORCE:1,0
FIELD:title:CARRY:0,0
FIELD:fname:EDIT1:INITIAL:PreferredName:FORCE(+):9,21
FIELD:mname:EDIT1:INITIAL:PROP:FORCE(--):10,6
FIELD:lname:EDIT1:HYPHEN2(3):FORCE(+):11,28
FIELD:name_suffix:NormSuffix:PROP:FORCE(--):9,12
FIELD:contact_ssn:LIKE(NUMBER):EDIT1:Right4:28,32
FIELD:contact_phone:CARRY:0,0
FIELD:contact_email:LIKE(upper):CARRY:0,0
FIELD:contact_job_title_raw:CARRY:0,0
FIELD:company_department:CARRY:0,0
// ------------------------------------
//  Metadata
// ------------------------------------
FIELD:dt_first_seen:RECORDDATE(FIRST):10,505
FIELD:dt_last_seen:RECORDDATE(LAST):10,592
// ------------------------------------
//  Source information
// ------------------------------------
SOURCEFIELD:source:CONSISTENT(company_name,prim_range,prim_name,sec_range,st,v_city_name,zip):PARTITION(BIPV2.Mod_Sources.src2partition)
 
Total available specificity:372
Recommended matching threshold 39
Search Threshold set at 21
Use of PERSISTs in code set at:2
 
______________________________English Description of Matching Process___________________________
 
A SALT generated matching process really only contains one single matching rule.
SALT compares every record to every possible matching record and then allocates a score to how well
the records match. SALT then pairs those clusters which have the highest match scores provided the scores
meet or exceed the matching threshold. The scoring process is highly sophisticated and detailed below
however it can essentially be thought of as allocating points for every pair of fields that match
and subtracting points for every pair of fields that do not match.
This process was told to produce 3 nines of accuracy on a population of 750000000 with  6442679296 records.
The matching threshold is therefore set at 39.
 
___Field by Field Breakdown of Scoring Method___
 
company_name Scoring: This field is not used for scoring; rather it is carried along for context and debugging
cnp_name Scoring: In order for two records to be a match it is also required that the cnp_name fields match.
Two cnp_name fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the cnp_name
and the degree of fuzziness required but should average 25 points with a failed match substracting 23 points.
(This subtraction estimate is based upon 6% of clusters with 2 or more records have 2 or more values for cnp_name.)
 
corp_legal_name Scoring: In order for two records to be a match it is also required that the corp_legal_name fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two corp_legal_name fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
  - if the space separated tokens in one match the other if re-arranged
The exact number of points allocated to a match will depend upon the global scarcity of the corp_legal_name
and the degree of fuzziness required but should average 25 points with a failed match substracting 23 points.
(This subtraction estimate is based upon 6% of clusters with 2 or more records have 2 or more values for corp_legal_name.)
 
cnp_number Scoring: In order for two records to be a match it is also required that the cnp_number fields match.
Two cnp_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the cnp_number
but should average 14 points with a failed match substracting 14 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for cnp_number.)
 
cnp_btype Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two cnp_btype fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the cnp_btype
but should average 3 points with a failed match substracting 2 points.
(This subtraction estimate is based upon 2% of clusters with 2 or more records have 2 or more values for cnp_btype.)
 
cnp_lowv Scoring: This field is not used for scoring; rather it is carried along for context and debugging
cnp_translated Scoring: This field is not used for scoring; rather it is carried along for context and debugging
cnp_classid Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_fein Scoring: In order for two records to be a match it is also required that the company_fein fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two company_fein fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the company_fein
but should average 27 points with a failed match substracting 26 points.
(This subtraction estimate is based upon 1% of clusters with 2 or more records have 2 or more values for company_fein.)
 
active_duns_number Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two active_duns_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the active_duns_number
but should average 24 points with a failed match substracting 23 points.
(This subtraction estimate is based upon 1% of clusters with 2 or more records have 2 or more values for active_duns_number.)
 
active_enterprise_number Scoring: In order for two records to be a match it is also required that the active_enterprise_number fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two active_enterprise_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the active_enterprise_number
but should average 27 points with a failed match substracting 27 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for active_enterprise_number.)
 
active_domestic_corp_key Scoring: In order for two records to be a match it is also required that the active_domestic_corp_key fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two active_domestic_corp_key fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the active_domestic_corp_key
but should average 27 points with a failed match substracting 27 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for active_domestic_corp_key.)
 
company_bdid Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_phone Scoring: This field is not used for scoring; rather it is carried along for context and debugging
prim_range Scoring: In order for two records to be a match it is also required that the prim_range fields match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two prim_range fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the prim_range
but should average 13 points with a failed match substracting 13 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for prim_range.)
It should also be noted that prim_range is a child field of addr1. Therefore if addr1 is a full match this field will score 0.
This field is scaled to match with its parent addr1, on average that will mean multiplying by 57%
(Although the score is still computed to satisfy the forcing condition.)
 
prim_name Scoring: In order for two records to be a match it is also required that the prim_name fields match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two prim_name fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the prim_name
but should average 15 points with a failed match substracting 15 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for prim_name.)
It should also be noted that prim_name is a child field of addr1. Therefore if addr1 is a full match this field will score 0.
This field is scaled to match with its parent addr1, on average that will mean multiplying by 57%
(Although the score is still computed to satisfy the forcing condition.)
 
sec_range Scoring: In order for two records to be a match it is also required that the sec_range fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two sec_range fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the sec_range
but should average 12 points with a failed match substracting 11 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for sec_range.)
It should also be noted that sec_range is a child field of addr1. Therefore if addr1 is a full match this field will score 0.
This field is scaled to match with its parent addr1, on average that will mean multiplying by 57%
(Although the score is still computed to satisfy the forcing condition.)
 
st Scoring: In order for two records to be a match it is also required that the st fields match.
Two st fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the st
but should average 5 points with a failed match substracting 5 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for st.)
It should also be noted that st is a child field of csz. Therefore if csz is a full match this field will score 0.
This field is scaled to match with its parent csz, on average that will mean multiplying by 46%
(Although the score is still computed to satisfy the forcing condition.)
 
v_city_name Scoring: 
The scoring for this field is ignored unless the st fields are identical.
Two v_city_name fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the v_city_name
but should average 11 points with a failed match substracting 10 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for v_city_name.)
It should also be noted that v_city_name is a child field of csz. Therefore if csz is a full match this field will score 0.
This field is scaled to match with its parent csz, on average that will mean multiplying by 46%
 
zip Scoring: Two zip fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the zip
but should average 14 points with a failed match substracting 13 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for zip.)
It should also be noted that zip is a child field of csz. Therefore if csz is a full match this field will score 0.
This field is scaled to match with its parent csz, on average that will mean multiplying by 46%
 
csz Scoring: In order for two records to be a match it is also required that the csz fields match.
Specifically the score awarded to this field must be >= -2 .
Two csz fields will be considered to match if:
  - they are identical
Note: csz is an amalgam of (v_city_name,st,zip)
Points will only be allocated for a match, the amount depending upon the scarcity of csz
but should average 14 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score) and the sum of the scores of its' children will be used to determine the force criteria.
It should also be noted that csz is a child field of address. Therefore if address is a full match this field will score 0.
This field is scaled to match with its parent address, on average that will mean multiplying by 67%
(Although the score is still computed to satisfy the forcing condition.)
 
addr1 Scoring: Two addr1 fields will be considered to match if:
  - they are identical
Note: addr1 is an amalgam of (prim_range,prim_name,sec_range)
Points will only be allocated for a match, the amount depending upon the scarcity of addr1
but should average 23 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score).
It should also be noted that addr1 is a child field of address. Therefore if address is a full match this field will score 0.
This field is scaled to match with its parent address, on average that will mean multiplying by 67%
 
address Scoring: In order for two records to be a match it is also required that the address fields match.
Two address fields will be considered to match if:
  - they are identical
Note: address is an amalgam of (addr1,csz)
Points will only be allocated for a match, the amount depending upon the scarcity of address
but should average 25 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score) and the sum of the scores of its' children will be used to determine the force criteria.
 
isContact Scoring: In order for two records to be a match it is also required that the isContact fields match.
Two isContact fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the isContact
but should average 1 points with a failed match substracting 1 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for isContact.)
 
title Scoring: This field is not used for scoring; rather it is carried along for context and debugging
fname Scoring: In order for two records to be a match it is also required that the fname fields match.
Two fname fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
  - one is the leading part of the other
  - if the two fields have the same value for the function PreferredName
The exact number of points allocated to a match will depend upon the global scarcity of the fname
and the degree of fuzziness required but should average 9 points with a failed match substracting 8 points.
(This subtraction estimate is based upon 2% of clusters with 2 or more records have 2 or more values for fname.)
 
mname Scoring: In order for two records to be a match it is also required that the mname fields not not match.
If a field is null or an initial and another record in the same cluster has a fuller value for that field then the other records value will be used.
Two mname fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
  - one is the leading part of the other
The exact number of points allocated to a match will depend upon the global scarcity of the mname
and the degree of fuzziness required but should average 10 points with a failed match substracting 9 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for mname.)
 
lname Scoring: In order for two records to be a match it is also required that the lname fields match.
Two lname fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
  - if the two strings are identical if hypens and spaces are ignored
  - if one is the leading or trailing part of the other (and the shorter string is a least 3 chars long)
The exact number of points allocated to a match will depend upon the global scarcity of the lname
and the degree of fuzziness required but should average 11 points with a failed match substracting 10 points.
(This subtraction estimate is based upon 2% of clusters with 2 or more records have 2 or more values for lname.)
 
name_suffix Scoring: In order for two records to be a match it is also required that the name_suffix fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two name_suffix fields will be considered to match if:
  - they are identical
  - if the two fields have the same value for the function NormSuffix
The exact number of points allocated to a match will depend upon the global scarcity of the name_suffix
but should average 9 points with a failed match substracting 8 points.
(This subtraction estimate is based upon 1% of clusters with 2 or more records have 2 or more values for name_suffix.)
 
contact_ssn Scoring: Two contact_ssn fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
  - if the two fields have the same value for the function Right4
The exact number of points allocated to a match will depend upon the global scarcity of the contact_ssn
and the degree of fuzziness required but should average 28 points with a failed match substracting 27 points.
(This subtraction estimate is based upon 3% of clusters with 2 or more records have 2 or more values for contact_ssn.)
 
contact_phone Scoring: This field is not used for scoring; rather it is carried along for context and debugging
contact_email Scoring: This field is not used for scoring; rather it is carried along for context and debugging
contact_job_title_raw Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_department Scoring: This field is not used for scoring; rather it is carried along for context and debugging
dt_first_seen Scoring: Date fields are not presently used for scoring but are carried along for debugging purposes
dt_last_seen Scoring: Date fields are not presently used for scoring but are carried along for debugging purposes
 
_AttributeFile Scoring_
Scores from attribute files are attributed to every potential record match between two clusters
All the field scoring and force restrictions specified above still apply.
The scores noted below may be thought of as bonus points.
 
Additional Scoring for fields company_charter_number,company_inc_state from file ForeignCorpkey:
 A score will be allocated for ForeignCorpkey only in the event of an exact match, no penalty attaches to a no-match
The exact score will depend upon the global scarcity of ForeignCorpkey but should average 26.
If multiple ForeignCorpkey match for the same cluster pairing only the highest scoring 1 will apply.
Every attribute value must match to a value in the other attribute IF they have the same context
 
______________________________English Description of Cleaving___________________________
 
 Prior to performing matching all clusters are first assessed to see if they are presently overlinked.
A cluster is considered to be overlinked if it is possible to 'slice' or 'cleave' the cluster in such a way
that records either side of the slice completely differ in one or more fields; and their are 0 records
that 'straddle' the slice point (containing values characteristic of BOTH sides of the cleave point.
The particular characteristics of each cleave point follow:-
 
 Cleave point for basis:_cnp_number
A cleave point is considered to exist if it is possible to divide the cluster into groups each of which have
unique values for cnp_number
Unique means different in any way; no degree of fuzziness is allowed for.
Once a cleave point is established three clusters will be formed; two composed of records that match the values of the cleave point in any field, and one containing any records left over.
 
 Cleave point for basis:_active_enterprise_number
A cleave point is considered to exist if it is possible to divide the cluster into groups each of which have
unique values for active_enterprise_number
Unique means different in any way; no degree of fuzziness is allowed for.
Once a cleave point is established three clusters will be formed; two composed of records that match the values of the cleave point in any field, and one containing any records left over.
 
 Cleave point for basis:_active_domestic_corp_key
A cleave point is considered to exist if it is possible to divide the cluster into groups each of which have
unique values for active_domestic_corp_key
Unique means different in any way; no degree of fuzziness is allowed for.
Once a cleave point is established three clusters will be formed; two composed of records that match the values of the cleave point in any field, and one containing any records left over.
 
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
 

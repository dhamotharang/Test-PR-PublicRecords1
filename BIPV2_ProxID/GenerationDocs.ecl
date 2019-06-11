﻿Generated by SALT V3.11.4
Command line options: -MBIPV2_ProxID -eC:\Users\wilmotkx\AppData\Local\Temp\TFRFE32.tmp 
File being processed :-
//SALTVERSION:311
OPTIONS:-gh -ga -gs2
 
MODULE:BIPV2_ProxID
FILENAME:DOT_Base
IDFIELD:EXISTS:Proxid
RIDFIELD:rcid
RECORDS:227982173
POPULATION:200000000
NINES:3
THRESHOLD:30
BLOCKTHRESHOLD:5
HACK:MAXBLOCKSIZE:20000
// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields 
//FIELDTYPE:wordbag:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:number:ALLOW(0123456789)
FIELDTYPE:upper:CAPS:ONFAIL(CLEAN)
FIELDTYPE:multiword:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:Noblanks:LIKE(multiword):LENGTHS(1..):ONFAIL(CLEAN,REJECT)
// FIELDTYPE:positive:ALLOW(0123456789):CUSTOM(fn_positive):ONFAIL(REJECT)
//FIELDTYPE:cname:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):CUSTOM(fn_cname):ONFAIL(REJECT)
// FUZZY can be used to create new types of FUZZY linking
FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)
FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)
FUZZY:NormSuffix:RST:CUSTOM(fn_normSuffix):TYPE(STRING5)
// ------------------------------------
//  1. Company
// ------------------------------------
// Active ID fields from reliable sources
FIELD:active_duns_number:PROP:18,78
FIELD:active_enterprise_number:FORCE(--):PROP:20,15
FIELD:active_domestic_corp_key:FORCE(--):PROP:19,1
// Historical and non-domestic IDs from reliable sources
// If match, add to score, if not, don't care(SWITCH0)
FIELD:hist_enterprise_number:PROP:20,22
FIELD:hist_duns_number:PROP:18,72
FIELD:hist_domestic_corp_key:PROP:19,151
FIELD:foreign_corp_key:SWITCH0:PROP:19,418
FIELD:unk_corp_key:SWITCH0:PROP:19,133
FIELD:ebr_file_number:PROP:20,427
FIELD:company_fein:PROP:EDIT1:17,227
FIELD:company_name:CARRY:0,0
FIELD:cnp_name:TYPE(STRING250):LIKE(Noblanks):BAGOFWORDS(MOST):EDIT1:FORCE(+6,OR(active_domestic_corp_key),OR(active_duns_number),OR(company_fein)):ABBR(ACRONYM,INITIAL,MAXSPC(13)):HYPHEN1:12,334
// FIELD:cnp_name:BAGOFWORDS(MOST):EDIT1:FORCE(+13,OR(active_domestic_corp_key),OR(active_duns_number)):ABBR(FIRST):HYPHEN1:TYPE(string250):15,137
//FIELD:source:CARRY:0,0
FIELD:company_name_type_raw:CARRY:0,0
FIELD:company_name_type_derived:WEIGHT(0.001):PROP:1,402
FIELD:cnp_hasnumber:CARRY:0,0
FIELD:cnp_number:FORCE:PROP:13,0
//FIELD:cnp_btype:FORCE(--):2,1  CO and inc for same name forced apart here
FIELD:cnp_btype:3,166
FIELD:cnp_lowv:CARRY:0,0
FIELD:cnp_translated:CARRY:0,0
FIELD:cnp_classid:CARRY:0,0
//FIELD:company_org_structure_derived:FORCE(--):PROP:0,0
//FIELD:company_charter_state:PROP:7,72
//FIELD:company_charter_number:CONTEXT(company_charter_state):PROP:EDIT1:18,25
FIELD:company_foreign_domestic:CARRY:0,0
FIELD:company_bdid:CARRY:0,0
// -- could add this field as SWITCH0 
FIELD:company_phone:SWITCH0:PROP:18,426
//FIELD:current:PROP:FORCE(--):3,0
//FIELD:iscorp:SWITCH0:PROP:1,0
// ------------------------------------
//  2. Place
// ------------------------------------
FIELD:prim_name:CARRY:0,0
FIELD:prim_name_derived:TYPE(STRING250):LIKE(Noblanks):BAGOFWORDS(MOST):EDIT1:FORCE(+5):ABBR(FIRST):HYPHEN1:11,14
// FIELD:prim_name:BAGOFWORDS(MOST):EDIT1:FORCE(+5):ABBR(FIRST):HYPHEN1:13,4
//FIELD:prim_name:FORCE(+):15,0
FIELD:sec_range:HYPHEN1:PROP:11,142
FIELD:v_city_name:CONTEXT(st):10,18
FIELD:st:LIKE(alpha):FORCE(+):5,0
FIELD:zip:LIKE(number):13,18
BESTTYPE:SINGLEPRIMRANGE:BASIS(cnp_name:prim_name_derived:v_city_name:st:zip):UNIQUE:PROP
FIELD:prim_range:CARRY:0,0
FIELD:prim_range_derived:FORCE:SINGLEPRIMRANGE:12,7
CONCEPT:company_csz:v_city_name:st:zip:FORCE(+-2):13,52
CONCEPT:company_addr1:prim_range_derived:prim_name_derived:sec_range:17,177
CONCEPT:company_address:company_addr1:company_csz:FORCE(+):18,205
// ------------------------------------
//  3. Contact
// ------------------------------------
// -- could add these fields as SWITCH0.  maybe just the concept...
//FIELD:isContact:CARRY:0,0
//FIELD:title:SWITCH0:1,13
//FIELD:fname:SWITCH0:11,98
//FIELD:mname:SWITCH0:8,56
//FIELD:lname:SWITCH0:15,64
//FIELD:name_suffix:SWITCH0:8,22
//CONCEPT:contact_name:fname:mname:lname:BAGOFWORDS:23,158
//CONCEPT:contact_fullname:contact_name:name_suffix:23,164
//FIELD:contact_ssn:SWITCH0:28,5
//FIELD:contact_phone:SWITCH0:23,44
//FIELD:contact_email:LIKE(upper):SWITCH0:29,4
//FIELD:contact_job_title_raw:SWITCH0:6,457
//FIELD:company_department:SWITCH0:0,0
// ------------------------------------
//  Metadata
// ------------------------------------
FIELD:dt_first_seen:RECORDDATE(FIRST):9,729
FIELD:dt_last_seen:RECORDDATE(LAST):8,773
SOURCEFIELD:source:PARTITION(BIPV2.Mod_Sources.src2partition)
HACK:CUSTOMINTERNALJOIN:_mj_extra
// ------------------------------------
//  Cleaves
// ------------------------------------
CLEAVE:solo_corp_key:BASIS(active_domestic_corp_key):MINIMUM(1)
//CLEAVE:solo_active_duns:BASIS(active_duns_number):MINIMUM(1)
CLEAVE:solo_cnp_number:BASIS(cnp_number):MINIMUM(1)
// ------------------------------------
//  Attribute Files
// ------------------------------------
ATTRIBUTEFILE:SrcRidVlid:NAMED(file_SrcRidVlid):VALUES(source:source_record_id:vl_id):IDFIELD(Proxid):SUPPORTS(cnp_name):19,753
ATTRIBUTEFILE:ForeignCorpkey:NAMED(file_Foreign_Corpkey):VALUES(company_charter_number<company_inc_state):FORCE(--,ALL):IDFIELD(Proxid):19,321
ATTRIBUTEFILE:RAAddresses:NAMED(file_RA_Addresses):VALUES(cname):FORCE:IDFIELD(Proxid):18,196
ATTRIBUTEFILE:FilterPrimNames:NAMED(file_filter_Prim_names):VALUES(pname_digits):FORCE:IDFIELD(Proxid):12,5
ATTRIBUTEFILE:UnderLinks:NAMED(file_underLink):VALUES(UnderLinkId):SUPPORTS(cnp_name):IDFIELD(ProxID):20,0
// ------------------------------------
//  ID Parents
// ------------------------------------
IDPARENTS:lgid3,orgid,ultid
IDCHILDREN:dotid
BLOCKLINK:NAMED(OverLinks):BASIS(cnp_name)
//ATTRIBUTEFILE:SrcVlid:NAMED(file_SrcVlid):VALUES(source:vl_id):IDFIELD(Proxid):SUPPORTS(cnp_name):19,167
// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
// CONCEPT statements should be used to group together interellated fields; such as address
// RELATIONSHIP is used to find non-obvious relationships between the clusters
// SOURCEFIELD is used if a field of the file denotes a source of the records in that file
// LINKPATH is used to define access paths for external linking
// DotID
// ?  a contact name (or the absence of a contact) at a company name at a physical address.  Separate legal entities within an office will consist of separate Dots.
// o  The only thing new here is the word ?physical?.  I want to allow for other address types to join in at the Dot level.
// ProxID
// 1. A legal entity at a physical address. (fuzzy matching to account for typos and different representations of same name)
// 2. has no more than 1 active charter for a given state (fuzzy matching to account for typos).  Now this should allow for charters from different states
//    to be ok, but not two charters in the same state.
// 3. has no more than 1 active Duns or LNCA lowest level ID.
// 4. Has no more than 1 status (active vs defunct).
// 5. Has no more than 1 legal name.
// 6. FEIN is sometimes useful for pulling records together, but won?t be pushed to push records apart.
// 7. Unincorporated businesses will need more than just company name & address to bring them together into a Prox.  Address + contact is enough.
// Beyond ProxID
// 1. LNCA hierarchy
// 2. Duns hierarchy
// Business Relatives (outside of hierarchy - linkable from a report)
// TBD, but essentially any other connection we come across in this process but do not feel is strong enough for ProxID linking.
 
Total available specificity:346
User specified threshold 30
Recommended matching threshold 38
Search Threshold set at 15
Use of PERSISTs in code set at:3
 
______________________________English Description of Matching Process___________________________
 
A SALT generated matching process really only contains one single matching rule.
SALT compares every record to every possible matching record and then allocates a score to how well
the records match. SALT then pairs those clusters which have the highest match scores provided the scores
meet or exceed the matching threshold. The scoring process is highly sophisticated and detailed below
however it can essentially be thought of as allocating points for every pair of fields that match
and subtracting points for every pair of fields that do not match.
This process was told to produce 3 nines of accuracy on a population of 200000000 with   227982176 records.
A matching threshold of 38 is recommended although this was overridden to 30.
 
___Field by Field Breakdown of Scoring Method___
 
active_duns_number Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two active_duns_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the active_duns_number
but should average 18 points with a failed match substracting 16 points.
(This subtraction estimate is based upon 7% of clusters with 2 or more records have 2 or more values for active_duns_number.)
 
active_enterprise_number Scoring: In order for two records to be a match it is also required that the active_enterprise_number fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two active_enterprise_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the active_enterprise_number
but should average 20 points with a failed match substracting 19 points.
(This subtraction estimate is based upon 1% of clusters with 2 or more records have 2 or more values for active_enterprise_number.)
 
active_domestic_corp_key Scoring: In order for two records to be a match it is also required that the active_domestic_corp_key fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two active_domestic_corp_key fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the active_domestic_corp_key
but should average 19 points with a failed match substracting 18 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for active_domestic_corp_key.)
 
hist_enterprise_number Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two hist_enterprise_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the hist_enterprise_number
but should average 20 points with a failed match substracting 19 points.
(This subtraction estimate is based upon 2% of clusters with 2 or more records have 2 or more values for hist_enterprise_number.)
 
hist_duns_number Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two hist_duns_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the hist_duns_number
but should average 18 points with a failed match substracting 16 points.
(This subtraction estimate is based upon 7% of clusters with 2 or more records have 2 or more values for hist_duns_number.)
 
hist_domestic_corp_key Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two hist_domestic_corp_key fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the hist_domestic_corp_key
but should average 19 points with a failed match substracting 16 points.
(This subtraction estimate is based upon 15% of clusters with 2 or more records have 2 or more values for hist_domestic_corp_key.)
 
foreign_corp_key Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two foreign_corp_key fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the foreign_corp_key
but should average 19 points with a failed match substracting 11 points.
(This subtraction estimate is based upon 41% of clusters with 2 or more records have 2 or more values for foreign_corp_key.)
 
unk_corp_key Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two unk_corp_key fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the unk_corp_key
but should average 19 points with a failed match substracting 16 points.
(This subtraction estimate is based upon 13% of clusters with 2 or more records have 2 or more values for unk_corp_key.)
 
ebr_file_number Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two ebr_file_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the ebr_file_number
but should average 20 points with a failed match substracting 11 points.
(This subtraction estimate is based upon 42% of clusters with 2 or more records have 2 or more values for ebr_file_number.)
 
company_fein Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two company_fein fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the company_fein
and the degree of fuzziness required but should average 17 points with a failed match substracting 13 points.
(This subtraction estimate is based upon 22% of clusters with 2 or more records have 2 or more values for company_fein.)
 
company_name Scoring: This field is not used for scoring; rather it is carried along for context and debugging
cnp_name Scoring: In order for two records to be a match it is also required that the cnp_name fields match.
Specifically the score awarded to this field must be >= 6 .
Two cnp_name fields will be considered to match if:
  - they are identical
  - if the two strings are identical if hypens and spaces are ignored
  - if one is the leading or trailing part of the otherand a hypen or space indicates a logical break in the shorter string
  - one can be turned into the other with 1 edit (see Glossary)
  - if the space separated tokens in one match the other if re-arranged
The exact number of points allocated to a match will depend upon the global scarcity of the cnp_name
and the degree of fuzziness required but should average 12 points with a failed match substracting 7 points.
(This subtraction estimate is based upon 33% of clusters with 2 or more records have 2 or more values for cnp_name.)
 
company_name_type_raw Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_name_type_derived Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two company_name_type_derived fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the company_name_type_derived
but should average 1 points with a failed match substracting 0 points.
(This subtraction estimate is based upon 40% of clusters with 2 or more records have 2 or more values for company_name_type_derived.)
The SPC file has specified that the weight should be multiplied by  0.00
 
cnp_hasnumber Scoring: This field is not used for scoring; rather it is carried along for context and debugging
cnp_number Scoring: In order for two records to be a match it is also required that the cnp_number fields match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two cnp_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the cnp_number
but should average 13 points with a failed match substracting 13 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for cnp_number.)
 
cnp_btype Scoring: Two cnp_btype fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the cnp_btype
but should average 3 points with a failed match substracting 2 points.
(This subtraction estimate is based upon 16% of clusters with 2 or more records have 2 or more values for cnp_btype.)
 
cnp_lowv Scoring: This field is not used for scoring; rather it is carried along for context and debugging
cnp_translated Scoring: This field is not used for scoring; rather it is carried along for context and debugging
cnp_classid Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_foreign_domestic Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_bdid Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_phone Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two company_phone fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the company_phone
but should average 18 points with a failed match substracting 10 points.
(This subtraction estimate is based upon 42% of clusters with 2 or more records have 2 or more values for company_phone.)
 
prim_name Scoring: This field is not used for scoring; rather it is carried along for context and debugging
prim_name_derived Scoring: In order for two records to be a match it is also required that the prim_name_derived fields match.
Specifically the score awarded to this field must be >= 5 .
Two prim_name_derived fields will be considered to match if:
  - they are identical
  - if the two strings are identical if hypens and spaces are ignored
  - if one is the leading or trailing part of the otherand a hypen or space indicates a logical break in the shorter string
  - one can be turned into the other with 1 edit (see Glossary)
  - if the space separated tokens in one match the other if re-arranged
The exact number of points allocated to a match will depend upon the global scarcity of the prim_name_derived
and the degree of fuzziness required but should average 11 points with a failed match substracting 10 points.
(This subtraction estimate is based upon 1% of clusters with 2 or more records have 2 or more values for prim_name_derived.)
It should also be noted that prim_name_derived is a child field of company_addr1. Therefore if company_addr1 is a full match this field will score 0.
This field is scaled to match with its parent company_addr1, on average that will mean multiplying by 50%
(Although the score is still computed to satisfy the forcing condition.)
 
sec_range Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two sec_range fields will be considered to match if:
  - they are identical
  - if the two strings are identical if hypens and spaces are ignored
  - if one is the leading or trailing part of the otherand a hypen or space indicates a logical break in the shorter string
The exact number of points allocated to a match will depend upon the global scarcity of the sec_range
and the degree of fuzziness required but should average 11 points with a failed match substracting 9 points.
(This subtraction estimate is based upon 14% of clusters with 2 or more records have 2 or more values for sec_range.)
It should also be noted that sec_range is a child field of company_addr1. Therefore if company_addr1 is a full match this field will score 0.
This field is scaled to match with its parent company_addr1, on average that will mean multiplying by 50%
 
v_city_name Scoring: 
The scoring for this field is ignored unless the st fields are identical.
Two v_city_name fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the v_city_name
but should average 10 points with a failed match substracting 9 points.
(This subtraction estimate is based upon 1% of clusters with 2 or more records have 2 or more values for v_city_name.)
It should also be noted that v_city_name is a child field of company_csz. Therefore if company_csz is a full match this field will score 0.
This field is scaled to match with its parent company_csz, on average that will mean multiplying by 46%
 
st Scoring: In order for two records to be a match it is also required that the st fields match.
Two st fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the st
but should average 5 points with a failed match substracting 5 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for st.)
It should also be noted that st is a child field of company_csz. Therefore if company_csz is a full match this field will score 0.
This field is scaled to match with its parent company_csz, on average that will mean multiplying by 46%
(Although the score is still computed to satisfy the forcing condition.)
 
zip Scoring: Two zip fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the zip
but should average 13 points with a failed match substracting 12 points.
(This subtraction estimate is based upon 1% of clusters with 2 or more records have 2 or more values for zip.)
It should also be noted that zip is a child field of company_csz. Therefore if company_csz is a full match this field will score 0.
This field is scaled to match with its parent company_csz, on average that will mean multiplying by 46%
 
prim_range Scoring: This field is not used for scoring; rather it is carried along for context and debugging
prim_range_derived Scoring: In order for two records to be a match it is also required that the prim_range_derived fields match.
 
Prior to matching the following rules are applied in a cascade in an attempt to fix or complete field values.
 1. Gather together all records that match on (cnp_name,prim_name_derived,v_city_name,st,zip).
 The number of each field value are then counted.
 The best is then defined to be the one which is unique.
 If the value generated is non-null and the value currently in the field is null then the value currently in the field will be replaced.
Two prim_range_derived fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the prim_range_derived
but should average 12 points with a failed match substracting 11 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for prim_range_derived.)
It should also be noted that prim_range_derived is a child field of company_addr1. Therefore if company_addr1 is a full match this field will score 0.
This field is scaled to match with its parent company_addr1, on average that will mean multiplying by 50%
(Although the score is still computed to satisfy the forcing condition.)
 
company_csz Scoring: In order for two records to be a match it is also required that the company_csz fields match.
Specifically the score awarded to this field must be >= -2 .
Two company_csz fields will be considered to match if:
  - they are identical
Note: company_csz is an amalgam of (v_city_name,st,zip)
Points will only be allocated for a match, the amount depending upon the scarcity of company_csz
but should average 13 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score) and the sum of the scores of its' children will be used to determine the force criteria.
It should also be noted that company_csz is a child field of company_address. Therefore if company_address is a full match this field will score 0.
This field is scaled to match with its parent company_address, on average that will mean multiplying by 60%
(Although the score is still computed to satisfy the forcing condition.)
 
company_addr1 Scoring: Two company_addr1 fields will be considered to match if:
  - they are identical
Note: company_addr1 is an amalgam of (prim_range_derived,prim_name_derived,sec_range)
Points will only be allocated for a match, the amount depending upon the scarcity of company_addr1
but should average 17 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score).
It should also be noted that company_addr1 is a child field of company_address. Therefore if company_address is a full match this field will score 0.
This field is scaled to match with its parent company_address, on average that will mean multiplying by 60%
 
company_address Scoring: In order for two records to be a match it is also required that the company_address fields match.
Two company_address fields will be considered to match if:
  - they are identical
Note: company_address is an amalgam of (company_addr1,company_csz)
Points will only be allocated for a match, the amount depending upon the scarcity of company_address
but should average 18 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score) and the sum of the scores of its' children will be used to determine the force criteria.
 
dt_first_seen Scoring: Date fields are not presently used for scoring but are carried along for debugging purposes
dt_last_seen Scoring: Date fields are not presently used for scoring but are carried along for debugging purposes
 
_AttributeFile Scoring_
Scores from attribute files are attributed to every potential record match between two clusters
All the field scoring and force restrictions specified above still apply. If multiple attribute fields match then their scores add.
 
The scores noted below may be thought of as bonus points.
 
Additional Scoring for fields source,source_record_id,vl_id from file SrcRidVlid:
 A score will be allocated for SrcRidVlid only in the event of an exact match, no penalty attaches to a no-match
The exact score will depend upon the global scarcity of SrcRidVlid but should average 19.
If multiple SrcRidVlid match for the same cluster pairing only the highest scoring 1 will apply.
There is no force condition on this attributefile so all mis matches are ignored.
Additional Scoring for fields company_charter_number,company_inc_state from file ForeignCorpkey:
 A score will be allocated for ForeignCorpkey only in the event of an exact match, no penalty attaches to a no-match
The exact score will depend upon the global scarcity of ForeignCorpkey but should average 19.
If multiple ForeignCorpkey match for the same cluster pairing only the highest scoring 1 will apply.
Every attribute value must match to a value in the other attribute IF they have the same context
 
Additional Scoring for field cname from file RAAddresses:
 A score will be allocated for RAAddresses only in the event of an exact match, no penalty attaches to a no-match
The exact score will depend upon the global scarcity of RAAddresses but should average 18.
If multiple RAAddresses match for the same cluster pairing only the highest scoring 1 will apply.
Every attribute value has to exactly match every attribute value of the corresponding identifier or both have no values
 
Additional Scoring for field pname_digits from file FilterPrimNames:
 A score will be allocated for FilterPrimNames only in the event of an exact match, no penalty attaches to a no-match
The exact score will depend upon the global scarcity of FilterPrimNames but should average 12.
If multiple FilterPrimNames match for the same cluster pairing only the highest scoring 1 will apply.
Every attribute value has to exactly match every attribute value of the corresponding identifier or both have no values
 
Additional Scoring for field UnderLinkId from file UnderLinks:
 A score will be allocated for UnderLinks only in the event of an exact match, no penalty attaches to a no-match
The exact score will depend upon the global scarcity of UnderLinks but should average 20.
If multiple UnderLinks match for the same cluster pairing only the highest scoring 1 will apply.
There is no force condition on this attributefile so all mis matches are ignored.
 
______________________________English Description of Cleaving___________________________
 
 Prior to performing matching all clusters are first assessed to see if they are presently overlinked.
A cluster is considered to be overlinked if it is possible to 'slice' or 'cleave' the cluster in such a way
that records either side of the slice completely differ in one or more fields; and their are 0 records
that 'straddle' the slice point (containing values characteristic of BOTH sides of the cleave point.
The particular characteristics of each cleave point follow:-
 
 Cleave point for basis:_active_domestic_corp_key
A cleave point is considered to exist if it is possible to divide the cluster into groups each of which have
unique values for active_domestic_corp_key
Unique means different in any way; no degree of fuzziness is allowed for.
Once a cleave point is established three clusters will be formed; two composed of records that match the values of the cleave point in any field, and one containing any records left over.
 
 Cleave point for basis:_cnp_number
A cleave point is considered to exist if it is possible to divide the cluster into groups each of which have
unique values for cnp_number
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
 

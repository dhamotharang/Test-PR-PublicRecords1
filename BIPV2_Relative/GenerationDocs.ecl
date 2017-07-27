Generated by SALT V2.5 Gold
File being processed :-
MODULE:BIPV2_Relative
FILENAME:DOT_Base
IDFIELD:EXISTS:Proxid
RIDFIELD:rcid
RECORDS:5704681
POPULATION:4305563
NINES:3
// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields 
FIELDTYPE:wordbag:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:number:ALLOW(0123456789)
FIELDTYPE:upper:CAPS:ONFAIL(CLEAN)
FIELDTYPE:cname:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):CUSTOM(fn_cname):ONFAIL(REJECT)
FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)
FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)
FUZZY:NormSuffix:RST:CUSTOM(fn_normSuffix):TYPE(STRING5)
BESTTYPE:UniqueSingleValue:BASIS(Proxid):UNIQUE:PROP
// ------------------------------------
//  1. Company
// ------------------------------------
FIELD:company_name:LIKE(cname):CARRY:0,0
//FIELD:cnp_name:EDIT1:LIKE(wordbag):FORCE(+):10,0
FIELD:cnp_name:EDIT1:LIKE(wordbag):24,7
FIELD:corp_legal_name:EDIT1:LIKE(wordbag):PROP:FORCE(--):24,7
FIELD:cnp_hasnumber:FORCE(+):0,0
FIELD:cnp_number:FORCE(--):11,1
FIELD:cnp_btype:FORCE(--):3,1
FIELD:cnp_lowv:CARRY:0,0
FIELD:cnp_translated:CARRY:0,0
FIELD:cnp_classid:CARRY:0,0
FIELD:company_fein:PROP:25,8
FIELD:company_inc_state:PROP:8,1
FIELD:company_charter_number:CONTEXT(company_inc_state):PROP:EDIT1:25,7
FIELD:company_bdid:CARRY:0,0
FIELD:company_phone:CARRY:0,0
FIELD:iscorp:PROP:1,1
// ------------------------------------
//  2. Place
// ------------------------------------
FIELD:prim_range:FORCE(--):13,1
FIELD:predir:CONTEXT(prim_name):4,1
FIELD:prim_name:15,5
FIELD:addr_suffix:4,0
FIELD:postdir:CONTEXT(prim_name):7,0
FIELD:unit_desig:CARRY:0,0
FIELD:sec_range:PROP:FORCE(--):12,1
FIELD:p_city_name:CONTEXT(st):11,8
FIELD:v_city_name:CONTEXT(st):11,9
FIELD:st:LIKE(alpha):5,4
FIELD:zip:LIKE(number):14,9
FIELD:zip4:CONTEXT(zip):LIKE(number):13,1
FIELD:Company_RAWAID:CARRY:0,0
CONCEPT:company_csz:v_city_name:st:zip:22,24
CONCEPT:company_addr1:prim_range:prim_name:sec_range:23,42
CONCEPT:company_address:company_addr1:company_csz:24,45
// Active ID fields from reliable sources
FIELD:active_duns_number:FORCE(--):UniqueSingleValue:25,9
FIELD:active_enterprise_number:FORCE(--):UniqueSingleValue:26,8
FIELD:active_domestic_corp_key:FORCE(--):UniqueSingleValue:EDIT1:25,6
FIELD:source:2,2
FIELD:source_record_id:26,26
// ------------------------------------
//  3. Contact
// ------------------------------------
FIELD:isContact:CARRY:0,0
FIELD:title:CARRY:0,0
FIELD:fname:10,4
FIELD:mname:8,0
FIELD:lname:15,5
FIELD:name_suffix:CARRY:9,0
FIELD:contact_ssn:26,5
FIELD:contact_phone:25,25
FIELD:contact_email:LIKE(upper):CARRY:0,0
FIELD:contact_job_title_raw:CARRY:0,0
FIELD:company_department:CARRY:0,0
FIELD:contact_email_username:0,0
// ------------------------------------
//  Metadata
// ------------------------------------
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
// ------------------------------------
//  Attribute Files
// ------------------------------------
//ATTRIBUTEFILE:SrcVlid:NAMED(file_SrcVlid):VALUES(vl_id):IDFIELD(Proxid):WEIGHT(3.0):17,30
//ATTRIBUTEFILE:Contact:NAMED(file_contact):VALUES(contact):IDFIELD(Proxid):KEEP(ALL):18,20
HACK:KEYSUFFIX
BLOCKTHRESHOLD:13
// Relationships
RELATIONSHIP:NAMEST:BASIS(cnp_name:st):LINK(NONE):THRESHOLD(10)
RELATIONSHIP:CHARTER:BASIS(company_charter_number:company_inc_state):LINK(NONE):THRESHOLD(20)
RELATIONSHIP:FEIN:BASIS(company_fein):LINK(NONE):THRESHOLD(10)
RELATIONSHIP:CONTACT:BASIS(fname:lname):SCORE(mname:contact_ssn:contact_phone:contact_email_username):MULTIPLE(2):LINK(NONE):THRESHOLD(18)
RELATIONSHIP:ADDRESS:BASIS(prim_name:prim_range:v_city_name:st:?:sec_range):SPLIT(16):DEDUP(prim_range):LINK(NONE):THRESHOLD(10)
RELATIONSHIP:DUNS_NUMBER:BASIS(active_duns_number):LINK(NONE):THRESHOLD(10)
RELATIONSHIP:ENTERPRISE_NUMBER:BASIS(active_enterprise_number):LINK(NONE):THRESHOLD(10)
RELATIONSHIP:SOURCE:BASIS(source:source_record_id):LINK(NONE):THRESHOLD(20)
RELATIONSHIP:ASSOC:DUNS_NUMBER:ENTERPRISE_NUMBER:SOURCE:CONTACT:ADDRESS:NAMEST:CHARTER:FEIN:CONTACT:ADDRESS:THRESHOLD(18)
  
 
  
Total available specificity:487
Recommended matching threshold 32
Search Threshold set at 11
Use of PERSISTs in code set at:3
______________________________English Description of Matching Process___________________________
A SALT generated matching process really only contains one single matching rule.
SALT compares every record to every possible matching record and then allocates a score to how well
the records match. SALT then pairs those clusters which have the highest match scores provided the scores
meet or exceed the matching threshold. The scoring process is highly sophisticated and detailed below
however it can essentially be thought of as allocating points for every pair of fields that match
and subtracting points for every pair of fields that do not match.
This process was told to produce 3 nines of accuracy on a population of 4305563 with 5704681 records.
The matching threshold is therefore set at 32.
___Field by Field Breakdown of Scoring Method___
company_name Scoring: This field is not used for scoring; rather it is carried along for context and debugging
cnp_name Scoring: Two cnp_name fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the cnp_name
and the degree of fuzziness required but should average 24 points with a failed match substracting 23 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for cnp_name.)
corp_legal_name Scoring: In order for two records to be a match it is also required that the corp_legal_name fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two corp_legal_name fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the corp_legal_name
and the degree of fuzziness required but should average 24 points with a failed match substracting 23 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for corp_legal_name.)
cnp_hasnumber Scoring: In order for two records to be a match it is also required that the cnp_hasnumber fields match.
Two cnp_hasnumber fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the cnp_hasnumber
but should average 0 points with a failed match substracting 0 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for cnp_hasnumber.)
cnp_number Scoring: In order for two records to be a match it is also required that the cnp_number fields not not match.
Two cnp_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the cnp_number
but should average 11 points with a failed match substracting 10 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for cnp_number.)
cnp_btype Scoring: In order for two records to be a match it is also required that the cnp_btype fields not not match.
Two cnp_btype fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the cnp_btype
but should average 3 points with a failed match substracting 2 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for cnp_btype.)
cnp_lowv Scoring: This field is not used for scoring; rather it is carried along for context and debugging
cnp_translated Scoring: This field is not used for scoring; rather it is carried along for context and debugging
cnp_classid Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_fein Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two company_fein fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the company_fein
but should average 25 points with a failed match substracting 24 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for company_fein.)
company_inc_state Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two company_inc_state fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the company_inc_state
but should average 8 points with a failed match substracting 7 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for company_inc_state.)
company_charter_number Scoring: 
The scoring for this field is ignored unless the company_inc_state fields are identical.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two company_charter_number fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the company_charter_number
and the degree of fuzziness required but should average 25 points with a failed match substracting 24 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for company_charter_number.)
company_bdid Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_phone Scoring: This field is not used for scoring; rather it is carried along for context and debugging
iscorp Scoring: If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two iscorp fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the iscorp
but should average 1 points with a failed match substracting 0 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for iscorp.)
prim_range Scoring: In order for two records to be a match it is also required that the prim_range fields not not match.
Two prim_range fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the prim_range
but should average 13 points with a failed match substracting 12 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for prim_range.)
It should also be noted that prim_range is a child field of company_addr1. Therefore if company_addr1 is a full match this field will score 0.
This field is scaled to match with its parent company_addr1, on average that will mean multiplying by 57%
(Although the score is still computed to satisfy the forcing condition.)
predir Scoring: 
The scoring for this field is ignored unless the prim_name fields are identical.
Two predir fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the predir
but should average 4 points with a failed match substracting 3 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for predir.)
prim_name Scoring: Two prim_name fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the prim_name
but should average 15 points with a failed match substracting 14 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for prim_name.)
It should also be noted that prim_name is a child field of company_addr1. Therefore if company_addr1 is a full match this field will score 0.
This field is scaled to match with its parent company_addr1, on average that will mean multiplying by 57%
addr_suffix Scoring: Two addr_suffix fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the addr_suffix
but should average 4 points with a failed match substracting 4 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for addr_suffix.)
postdir Scoring: 
The scoring for this field is ignored unless the prim_name fields are identical.
Two postdir fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the postdir
but should average 7 points with a failed match substracting 7 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for postdir.)
unit_desig Scoring: This field is not used for scoring; rather it is carried along for context and debugging
sec_range Scoring: In order for two records to be a match it is also required that the sec_range fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two sec_range fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the sec_range
but should average 12 points with a failed match substracting 11 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for sec_range.)
It should also be noted that sec_range is a child field of company_addr1. Therefore if company_addr1 is a full match this field will score 0.
This field is scaled to match with its parent company_addr1, on average that will mean multiplying by 57%
(Although the score is still computed to satisfy the forcing condition.)
p_city_name Scoring: 
The scoring for this field is ignored unless the st fields are identical.
Two p_city_name fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the p_city_name
but should average 11 points with a failed match substracting 10 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for p_city_name.)
v_city_name Scoring: 
The scoring for this field is ignored unless the st fields are identical.
Two v_city_name fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the v_city_name
but should average 11 points with a failed match substracting 10 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for v_city_name.)
It should also be noted that v_city_name is a child field of company_csz. Therefore if company_csz is a full match this field will score 0.
This field is scaled to match with its parent company_csz, on average that will mean multiplying by 73%
st Scoring: Two st fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the st
but should average 5 points with a failed match substracting 4 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for st.)
It should also be noted that st is a child field of company_csz. Therefore if company_csz is a full match this field will score 0.
This field is scaled to match with its parent company_csz, on average that will mean multiplying by 73%
zip Scoring: Two zip fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the zip
but should average 14 points with a failed match substracting 13 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for zip.)
It should also be noted that zip is a child field of company_csz. Therefore if company_csz is a full match this field will score 0.
This field is scaled to match with its parent company_csz, on average that will mean multiplying by 73%
zip4 Scoring: 
The scoring for this field is ignored unless the zip fields are identical.
Two zip4 fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the zip4
but should average 13 points with a failed match substracting 12 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for zip4.)
Company_RAWAID Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_csz Scoring: Two company_csz fields will be considered to match if:
  - they are identical
Note: company_csz is an amalgam of (v_city_name,st,zip)
Points will only be allocated for a match, the amount depending upon the scarcity of company_csz
but should average 22 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score).
It should also be noted that company_csz is a child field of company_address. Therefore if company_address is a full match this field will score 0.
This field is scaled to match with its parent company_address, on average that will mean multiplying by 53%
company_addr1 Scoring: Two company_addr1 fields will be considered to match if:
  - they are identical
Note: company_addr1 is an amalgam of (prim_range,prim_name,sec_range)
Points will only be allocated for a match, the amount depending upon the scarcity of company_addr1
but should average 23 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score).
It should also be noted that company_addr1 is a child field of company_address. Therefore if company_address is a full match this field will score 0.
This field is scaled to match with its parent company_address, on average that will mean multiplying by 53%
company_address Scoring: Two company_address fields will be considered to match if:
  - they are identical
Note: company_address is an amalgam of (company_addr1,company_csz)
Points will only be allocated for a match, the amount depending upon the scarcity of company_address
but should average 24 points.
In the event of a non-match this field will score 0 (and the child fields will be allowed to score).
active_duns_number Scoring: In order for two records to be a match it is also required that the active_duns_number fields not not match.
Prior to matching the following rules are applied in a cascade in an attempt to fix or complete field values.
 1. Gather together all records that match on (Proxid).
 The number of each field value are then counted.
 The best is then defined to be the one which is unique.
 If the value generated is non-null and the value currently in the field is null then the value currently in the field will be replaced.
Two active_duns_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the active_duns_number
but should average 25 points with a failed match substracting 24 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for active_duns_number.)
active_enterprise_number Scoring: In order for two records to be a match it is also required that the active_enterprise_number fields not not match.
Prior to matching the following rules are applied in a cascade in an attempt to fix or complete field values.
 1. Gather together all records that match on (Proxid).
 The number of each field value are then counted.
 The best is then defined to be the one which is unique.
 If the value generated is non-null and the value currently in the field is null then the value currently in the field will be replaced.
Two active_enterprise_number fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the active_enterprise_number
but should average 26 points with a failed match substracting 25 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for active_enterprise_number.)
active_domestic_corp_key Scoring: In order for two records to be a match it is also required that the active_domestic_corp_key fields not not match.
Prior to matching the following rules are applied in a cascade in an attempt to fix or complete field values.
 1. Gather together all records that match on (Proxid).
 The number of each field value are then counted.
 The best is then defined to be the one which is unique.
 If the value generated is non-null and the value currently in the field is null then the value currently in the field will be replaced.
Two active_domestic_corp_key fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
The exact number of points allocated to a match will depend upon the global scarcity of the active_domestic_corp_key
and the degree of fuzziness required but should average 25 points with a failed match substracting 24 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for active_domestic_corp_key.)
source Scoring: Two source fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the source
but should average 2 points with a failed match substracting 1 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for source.)
source_record_id Scoring: Two source_record_id fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the source_record_id
but should average 26 points with a failed match substracting 25 points.
(This subtraction estimate is based upon 2% of clusters with 2 or more records have 2 or more values for source_record_id.)
isContact Scoring: This field is not used for scoring; rather it is carried along for context and debugging
title Scoring: This field is not used for scoring; rather it is carried along for context and debugging
fname Scoring: Two fname fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the fname
but should average 10 points with a failed match substracting 9 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for fname.)
mname Scoring: Two mname fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the mname
but should average 8 points with a failed match substracting 8 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for mname.)
lname Scoring: Two lname fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the lname
but should average 15 points with a failed match substracting 14 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for lname.)
name_suffix Scoring: This field is not used for scoring; rather it is carried along for context and debugging
contact_ssn Scoring: Two contact_ssn fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the contact_ssn
but should average 26 points with a failed match substracting 25 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for contact_ssn.)
contact_phone Scoring: Two contact_phone fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the contact_phone
but should average 25 points with a failed match substracting 24 points.
(This subtraction estimate is based upon 2% of clusters with 2 or more records have 2 or more values for contact_phone.)
contact_email Scoring: This field is not used for scoring; rather it is carried along for context and debugging
contact_job_title_raw Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_department Scoring: This field is not used for scoring; rather it is carried along for context and debugging
contact_email_username Scoring: Two contact_email_username fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the contact_email_username
but should average 0 points with a failed match substracting 0 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for contact_email_username.)
dt_first_seen Scoring: Date fields are not presently used for scoring but are carried along for debugging purposes
dt_last_seen Scoring: Date fields are not presently used for scoring but are carried along for debugging purposes
______________________________English Description of Relationships___________________________
In SALT relationships use identical mathematics and similar logic to normal SALT linking.
The principle difference is that SALT relationships allow a single field or series of fields to acquire a score for more than one field value.
This allows you to capture concepts such as 'these two people share 5 addresses'.
The relationships tracked are :-
NAMEST Relationship:
This relationship is determined by looking for entities that share common values for the fields(the Basis) cnp_name AND st.
The best score for each Basis is kept; two basis are considered different if they have different values for the fields cnp_name AND st.
For a relationship to occur the total score across all Basis values must equal or exceed 10.
CHARTER Relationship:
This relationship is determined by looking for entities that share common values for the fields(the Basis) company_charter_number AND company_inc_state.
The best score for each Basis is kept; two basis are considered different if they have different values for the fields company_charter_number AND company_inc_state.
For a relationship to occur the total score across all Basis values must equal or exceed 20.
FEIN Relationship:
This relationship is determined by looking for entities that share common values for the field(the Basis) company_fein.
The best score for each Basis is kept; two basis are considered different if they have different values for the field company_fein.
For a relationship to occur the total score across all Basis values must equal or exceed 10.
CONTACT Relationship:
This relationship is determined by looking for entities that share common values for the fields(the Basis) fname AND lname.
At least 2 different values for those fields must be shared for a relationship to occur.
The following fields are also scored towards a relationship:mname,contact_ssn,contact_phone,contact_email_username and the highest match score is kept.
The best score for each Basis is kept; two basis are considered different if they have different values for the fields fname AND lname.
For a relationship to occur the total score across all Basis values and score fields must equal or exceed 18.
ADDRESS Relationship:
This relationship is determined by looking for entities that share common values for the fields(the Basis) prim_name,prim_range,v_city_name AND st in addition sec_range must be null or equal.
The best score for each Basis is kept; two basis are considered different if they have different values for the field prim_range.
For a relationship to occur the total score across all Basis values must equal or exceed 10.
DUNS_NUMBER Relationship:
This relationship is determined by looking for entities that share common values for the field(the Basis) active_duns_number.
The best score for each Basis is kept; two basis are considered different if they have different values for the field active_duns_number.
For a relationship to occur the total score across all Basis values must equal or exceed 10.
ENTERPRISE_NUMBER Relationship:
This relationship is determined by looking for entities that share common values for the field(the Basis) active_enterprise_number.
The best score for each Basis is kept; two basis are considered different if they have different values for the field active_enterprise_number.
For a relationship to occur the total score across all Basis values must equal or exceed 10.
SOURCE Relationship:
This relationship is determined by looking for entities that share common values for the fields(the Basis) source AND source_record_id.
The best score for each Basis is kept; two basis are considered different if they have different values for the fields source AND source_record_id.
For a relationship to occur the total score across all Basis values must equal or exceed 20.
ASSOC Relationship:
Two entities are considered to be in the ASSOC relationship if they are in one or more of the following relationships:
  - DUNS_NUMBER
  - ENTERPRISE_NUMBER
  - SOURCE
  - CONTACT
  - ADDRESS
  - NAMEST
  - CHARTER
  - FEIN
The scores from the child relationships are retained for information purposes although all double-counts are removed.
For a relationship to occur the total score across all Basis values must equal or exceed 18.
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

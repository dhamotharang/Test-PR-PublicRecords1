Generated by SALT V3.2.0
Command line options: -MBIPV2_EmpID_Down -eC:\Users\bentlela\AppData\Local\Temp\TFR420F.tmp 
File being processed :-
OPTIONS:-gh -ga -p2 -gs
MODULE:BIPV2_EmpID_Down
FILENAME:EmpID
 
// ------------------------------------
//  IDs and Tuning
// ------------------------------------
IDFIELD:EXISTS:EmpID
RIDFIELD:rcid
// IDPARENT:OrgID,UltID
// IDCHILDREN:DotID
 
RECORDS:3013764042
POPULATION:600000000
NINES:3
BLOCKTHRESHOLD:5
HACK:NOSLICE
HACK:NO_PARALLEL_MATCH
THRESHOLD:60
 
// -------------------------------------
//  Field validation/cleaning/fuzziness
// -------------------------------------
FIELDTYPE:fld_ssn:ALLOW(0123456789):LENGTHS(9,11):ONFAIL(CLEAN)
 
FUZZY:PreferredName:RST:CUSTOM(BIPV2_Tools.fn_PreferredName):TYPE(STRING20)
FUZZY:NormSuffix:RST:CUSTOM(BIPV2_Tools.fn_normSuffix):TYPE(STRING5)
FUZZY:Right4:RST:CUSTOM(BIPV2_Tools.fn_Right4):TYPE(STRING4)
 
// ------------------------------------
//  Linking fields
// ------------------------------------
 
// An EmpID is a person at an organization.
 
// don't even consider matching non-contact clusters
FIELDTYPE:fld_contact:ALLOW(T):LENGTHS(1):ONFAIL(REJECT) 
// FIELDTYPE:fld_contact:ENUM(T):ONFAIL(REJECT)
FIELD:isContact:LIKE(fld_contact):CARRY:0,0
 
FIELD:orgid:FORCE:26,0
// CLEAVE:solo_orgid:BASIS(orgid):MINIMUM(1) // Cleave may be needed if we start feeding back around to the next iteration
 
// we may need to fuzz this up more, perhaps with BAGOFWORDS
FIELD:fname:EDIT1:INITIAL:PreferredName:FORCE(+):8,20
FIELD:mname:EDIT1:INITIAL:PROP:FORCE(--):9,9
FIELD:lname:EDIT1:HYPHEN2(3):FORCE(+):10,31
FIELD:name_suffix:NormSuffix:PROP:FORCE(--):8,16
 
FIELD:contact_did:26,38
FIELD:contact_ssn:LIKE(fld_ssn):EDIT1:Right4:27,7
 
// tempting... but if we have non-personal phone/email here it would destroy us
FIELD:contact_phone:CARRY:0,0
FIELD:contact_email:CARRY:0,0
 
// ----------------------------------------------------
//  FYI -- no effect, but helpful during sample review
// ----------------------------------------------------
FIELD:company_name:CARRY:0,0
 
FIELD:prim_range:CARRY:0,0
FIELD:prim_name:CARRY:0,0
FIELD:sec_range:CARRY:0,0
FIELD:v_city_name:CARRY:0,0
FIELD:st:CARRY:0,0
FIELD:zip:CARRY:0,0
 
FIELD:active_duns_number:CARRY:0,0
FIELD:hist_duns_number:CARRY:0,0
FIELD:active_domestic_corp_key:CARRY:0,0
FIELD:hist_domestic_corp_key:CARRY:0,0
FIELD:foreign_corp_key:CARRY:0,0
FIELD:unk_corp_key:CARRY:0,0
 
 
// ------------------------------------
//  Metadata
// ------------------------------------
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
SOURCEFIELD:source:CONSISTENT(fname,mname,lname,name_suffix,contact_ssn):PARTITION(BIPV2.Mod_Sources.src2partition)
 
Total available specificity:114
User specified threshold 60
Recommended matching threshold 39
Search Threshold set at 20
Use of PERSISTs in code set at:2
 
______________________________English Description of Matching Process___________________________
 
A SALT generated matching process really only contains one single matching rule.
SALT compares every record to every possible matching record and then allocates a score to how well
the records match. SALT then pairs those clusters which have the highest match scores provided the scores
meet or exceed the matching threshold. The scoring process is highly sophisticated and detailed below
however it can essentially be thought of as allocating points for every pair of fields that match
and subtracting points for every pair of fields that do not match.
This process was told to produce 3 nines of accuracy on a population of 600000000 with  3013764096 records.
A matching threshold of 39 is recommended although this was overridden to 60.
 
___Field by Field Breakdown of Scoring Method___
 
isContact Scoring: This field is not used for scoring; rather it is carried along for context and debugging
orgid Scoring: In order for two records to be a match it is also required that the orgid fields match.
Two orgid fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the orgid
but should average 26 points with a failed match substracting 26 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for orgid.)
 
fname Scoring: In order for two records to be a match it is also required that the fname fields match.
Two fname fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
  - one is the leading part of the other
  - if the two fields have the same value for the function PreferredName
The exact number of points allocated to a match will depend upon the global scarcity of the fname
and the degree of fuzziness required but should average 8 points with a failed match substracting 7 points.
(This subtraction estimate is based upon 2% of clusters with 2 or more records have 2 or more values for fname.)
 
mname Scoring: In order for two records to be a match it is also required that the mname fields not not match.
If a field is null or an initial and another record in the same cluster has a fuller value for that field then the other records value will be used.
Two mname fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
  - one is the leading part of the other
The exact number of points allocated to a match will depend upon the global scarcity of the mname
and the degree of fuzziness required but should average 9 points with a failed match substracting 8 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for mname.)
 
lname Scoring: In order for two records to be a match it is also required that the lname fields match.
Two lname fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
  - if the two strings are identical if hypens and spaces are ignored
  - if one is the leading or trailing part of the other (and the shorter string is a least 3 chars long)
The exact number of points allocated to a match will depend upon the global scarcity of the lname
and the degree of fuzziness required but should average 10 points with a failed match substracting 9 points.
(This subtraction estimate is based upon 3% of clusters with 2 or more records have 2 or more values for lname.)
 
name_suffix Scoring: In order for two records to be a match it is also required that the name_suffix fields not not match.
If a field is null and another record in the same cluster has a value for that field then the other records value will be used.
Two name_suffix fields will be considered to match if:
  - they are identical
  - if the two fields have the same value for the function NormSuffix
The exact number of points allocated to a match will depend upon the global scarcity of the name_suffix
but should average 8 points with a failed match substracting 7 points.
(This subtraction estimate is based upon 1% of clusters with 2 or more records have 2 or more values for name_suffix.)
 
contact_did Scoring: Two contact_did fields will be considered to match if:
  - they are identical
The exact number of points allocated to a match will depend upon the global scarcity of the contact_did
but should average 26 points with a failed match substracting 25 points.
(This subtraction estimate is based upon 3% of clusters with 2 or more records have 2 or more values for contact_did.)
 
contact_ssn Scoring: Two contact_ssn fields will be considered to match if:
  - they are identical
  - one can be turned into the other with 1 edit (see Glossary)
  - if the two fields have the same value for the function Right4
The exact number of points allocated to a match will depend upon the global scarcity of the contact_ssn
and the degree of fuzziness required but should average 27 points with a failed match substracting 26 points.
(This subtraction estimate is based upon 0% of clusters with 2 or more records have 2 or more values for contact_ssn.)
 
contact_phone Scoring: This field is not used for scoring; rather it is carried along for context and debugging
contact_email Scoring: This field is not used for scoring; rather it is carried along for context and debugging
company_name Scoring: This field is not used for scoring; rather it is carried along for context and debugging
prim_range Scoring: This field is not used for scoring; rather it is carried along for context and debugging
prim_name Scoring: This field is not used for scoring; rather it is carried along for context and debugging
sec_range Scoring: This field is not used for scoring; rather it is carried along for context and debugging
v_city_name Scoring: This field is not used for scoring; rather it is carried along for context and debugging
st Scoring: This field is not used for scoring; rather it is carried along for context and debugging
zip Scoring: This field is not used for scoring; rather it is carried along for context and debugging
active_duns_number Scoring: This field is not used for scoring; rather it is carried along for context and debugging
hist_duns_number Scoring: This field is not used for scoring; rather it is carried along for context and debugging
active_domestic_corp_key Scoring: This field is not used for scoring; rather it is carried along for context and debugging
hist_domestic_corp_key Scoring: This field is not used for scoring; rather it is carried along for context and debugging
foreign_corp_key Scoring: This field is not used for scoring; rather it is carried along for context and debugging
unk_corp_key Scoring: This field is not used for scoring; rather it is carried along for context and debugging
dt_first_seen Scoring: Date fields are not presently used for scoring but are carried along for debugging purposes
dt_last_seen Scoring: Date fields are not presently used for scoring but are carried along for debugging purposes
 
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
 

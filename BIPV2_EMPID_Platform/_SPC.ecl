OPTIONS:-gh -ga -p2 -gs2
MODULE:BIPV2_EMPID_Platform
FILENAME:EmpID


// ------------------------------------
//  IDs and Tuning
// ------------------------------------
IDFIELD:EXISTS:EmpID
RIDFIELD:rcid
RECORDS:4816645228
POPULATION:650474159
NINES:4
BLOCKTHRESHOLD:5
// THRESHOLD:42

IDPARENTS:SeleID,OrgID,UltID
// IDCHILDREN:DotID


// ------------------------------------
//  Field validation/cleaning
// ------------------------------------
FIELDTYPE:multiword:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:number:ALLOW(0123456789)
FIELDTYPE:hasZip4:ALLOW(0123456789):LENGTHS(4):ONFAIL(REJECT)


// ------------------------------------
//  Linking fields
// ------------------------------------

// ASSERT - Unincorporated businesses
FIELDTYPE:isNoCorp:ALLOW(F):LENGTHS(0,1):ONFAIL(REJECT)
FIELD:isCorpEnhanced:LIKE(isNoCorp):CARRY:0,0

// ASSERT - Identified owner
FIELDTYPE:isOwner:ENUM(OWNER):ONFAIL(REJECT)
FIELD:contact_job_title_derived:LIKE(isOwner):CARRY:0,0

// Company Name - fname/lname remove to avoid double counting
FIELD:cname_devanitize:LIKE(multiword):BAGOFWORDS(MOST):EDIT1(2):PROP:FORCE(+):TYPE(string250):20,90

// skeletal address match, assert zip4 exists to ensure quality
FIELD:prim_range:FORCE:13,37
FIELD:prim_name:PROP:FORCE(+):15,53
FIELD:zip:LIKE(number):14,31
FIELD:zip4:LIKE(hasZip4):CARRY:0,0

FUZZY:PreferredName:RST:CUSTOM(BIPV2_Tools.fn_PreferredName):TYPE(STRING20)
FIELD:fname:INITIAL:PreferredName:FORCE(+):8,15
FIELD:lname:FORCE(+):15,20
FIELD:contact_phone:24,101
FIELD:contact_did:FORCE(--):24,23
FIELD:contact_ssn:FORCE(--):4,48

// CARRY fields useful for evaluation
FIELD:company_name:CARRY:0,0
FIELD:sec_range:CARRY:0,0
FIELD:v_city_name:CARRY:0,0
FIELD:st:CARRY:0,0
FIELD:company_inc_state:CARRY:0,0
FIELD:company_charter_number:CARRY:0,0
FIELD:active_duns_number:CARRY:0,0
FIELD:hist_duns_number:CARRY:0,0
FIELD:active_domestic_corp_key:CARRY:0,0
FIELD:hist_domestic_corp_key:CARRY:0,0
FIELD:foreign_corp_key:CARRY:0,0
FIELD:unk_corp_key:CARRY:0,0
FIELD:company_fein:CARRY:0,0
FIELD:cnp_btype:CARRY:0,0
FIELD:cnp_name:CARRY:0,0
FIELD:company_name_type_derived:CARRY:0,0
FIELD:company_bdid:CARRY:0,0
FIELD:nodes_total:CARRY:0,0


// ------------------------------------
//  Metadata
// ------------------------------------
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
SOURCEFIELD:source:CONSISTENT(cname_devanitize,prim_range,prim_name,zip,fname,lname):PARTITION(BIPV2.Mod_Sources.src2partition)

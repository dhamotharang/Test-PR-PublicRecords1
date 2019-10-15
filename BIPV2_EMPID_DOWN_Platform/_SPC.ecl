OPTIONS:-gh -ga -p2 -gs
MODULE:BIPV2_EMPID_DOWN_Platform
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

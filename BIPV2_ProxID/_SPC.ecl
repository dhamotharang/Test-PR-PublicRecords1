OPTIONS:-gh -ga -gs2
MODULE:BIPV2_ProxID
FILENAME:DOT_Base

IDFIELD:EXISTS:Proxid
RIDFIELD:rcid
RECORDS:6397861389
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
FIELD:active_duns_number:PROP:27,20
FIELD:active_enterprise_number:FORCE(--):PROP:27,4
FIELD:active_domestic_corp_key:FORCE(--):PROP:27,6
// Historical and non-domestic IDs from reliable sources
// If match, add to score, if not, don't care(SWITCH0)
FIELD:hist_enterprise_number:PROP:27,6
FIELD:hist_duns_number:PROP:27,169
FIELD:hist_domestic_corp_key:PROP:27,47
FIELD:foreign_corp_key:SWITCH0:PROP:27,155
FIELD:unk_corp_key:SWITCH0:PROP:27,49
FIELD:ebr_file_number:PROP:28,222
FIELD:company_fein:PROP:EDIT1:27,154
FIELD:company_name:CARRY:0,0
FIELD:cnp_name:TYPE(STRING250):BAGOFWORDS(MOST):EDIT1:FORCE(+6,OR(active_domestic_corp_key),OR(active_duns_number),OR(company_fein)):ABBR(ACRONYM,INITIAL,MAXSPC(13)):HYPHEN1:TYPE(string250):15,158
// FIELD:cnp_name:BAGOFWORDS(MOST):EDIT1:FORCE(+13,OR(active_domestic_corp_key),OR(active_duns_number)):ABBR(FIRST):HYPHEN1:TYPE(string250):15,137
//FIELD:source:CARRY:0,0
FIELD:company_name_type_raw:CARRY:0,0
FIELD:company_name_type_derived:CARRY:0,0
FIELD:cnp_hasnumber:CARRY:0,0
FIELD:cnp_number:FORCE:PROP:15,0
//FIELD:cnp_btype:FORCE(--):2,1  CO and inc for same name forced apart here
FIELD:cnp_btype:3,49
FIELD:cnp_lowv:CARRY:0,0
FIELD:cnp_translated:CARRY:0,0
FIELD:cnp_classid:CARRY:0,0
//FIELD:company_org_structure_derived:FORCE(--):PROP:0,0
//FIELD:company_charter_state:PROP:7,72
//FIELD:company_charter_number:CONTEXT(company_charter_state):PROP:EDIT1:18,25
FIELD:company_foreign_domestic:CARRY:0,0
FIELD:company_bdid:CARRY:0,0
// -- could add this field as SWITCH0 
FIELD:company_phone:SWITCH0:PROP:27,294
//FIELD:current:PROP:FORCE(--):3,0
//FIELD:iscorp:SWITCH0:PROP:1,0
// ------------------------------------
//  2. Place
// ------------------------------------
FIELD:prim_name:CARRY:0,0
FIELD:prim_name_derived:BAGOFWORDS(MOST):EDIT1:FORCE(+5):ABBR(FIRST):HYPHEN1:13,7
// FIELD:prim_name:BAGOFWORDS(MOST):EDIT1:FORCE(+5):ABBR(FIRST):HYPHEN1:13,4
//FIELD:prim_name:FORCE(+):15,0
FIELD:sec_range:HYPHEN1:PROP:12,82
FIELD:v_city_name:CONTEXT(st):11,13
FIELD:st:LIKE(alpha):FORCE(+):5,0
FIELD:zip:LIKE(number):14,6
BESTTYPE:SINGLEPRIMRANGE:BASIS(cnp_name:prim_name_derived:v_city_name:st:zip):UNIQUE:PROP
FIELD:prim_range:CARRY:0,0
FIELD:prim_range_derived:FORCE:SINGLEPRIMRANGE:13,3
CONCEPT:company_csz:v_city_name:st:zip:FORCE(+-2):14,24
CONCEPT:company_addr1:prim_range_derived:prim_name_derived:sec_range:24,99
CONCEPT:company_address:company_addr1:company_csz:FORCE(+):25,116
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
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
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
ATTRIBUTEFILE:SrcRidVlid:NAMED(file_SrcRidVlid):VALUES(source:source_record_id:vl_id):IDFIELD(Proxid):SUPPORTS(cnp_name):27,619
ATTRIBUTEFILE:ForeignCorpkey:NAMED(file_Foreign_Corpkey):VALUES(company_charter_number<company_inc_state):FORCE(--,ALL):IDFIELD(Proxid):27,38
ATTRIBUTEFILE:RAAddresses:NAMED(file_RA_Addresses):VALUES(cname):FORCE:IDFIELD(Proxid):28,89
ATTRIBUTEFILE:FilterPrimNames:NAMED(file_filter_Prim_names):VALUES(pname_digits):FORCE:IDFIELD(Proxid):13,2
// ------------------------------------
//  ID Parents
// ------------------------------------
IDPARENTS:lgid3,orgid,ultid
IDCHILDREN:dotid
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

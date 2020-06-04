OPTIONS:-gh -ga -p2 -gs2
MODULE:BIPV2_DOTID_PLATFORM
FILENAME:DOT
// ------------------------------------
//  IDs and Tuning
// ------------------------------------
RIDFIELD:rcid
IDFIELD:EXISTS:DOTid
IDPARENTS:proxid,lgid3,orgid,ultid
// 5.0B, 750M (rounded)
RECORDS:6309030296
POPULATION:750000000
NINES:3
BLOCKTHRESHOLD:5
HACK:CUSTOMINTERNALJOIN:_mj_extra
HACK:NOSLICE
HACK:NO_PARALLEL_MATCH
FIELDTYPE:multiword:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:number:ALLOW(0123456789)
FIELDTYPE:upper:CAPS:ONFAIL(CLEAN)
FIELDTYPE:cname:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):CUSTOM(fn_cname):ONFAIL(REJECT)
FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)
FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)
FUZZY:NormSuffix:RST:CUSTOM(fn_normSuffix):TYPE(STRING5)
// ------------------------------------
//  1. Company
// ------------------------------------
FIELD:company_name:LIKE(cname):CARRY:0,0
FIELD:cnp_name:EDIT1:LIKE(multiword):FORCE(+):25,64
FIELD:corp_legal_name:BAGOFWORDS(MOST):PROP:ABBR:EDIT1:FORCE(--):TYPE(string250):25,68
FIELD:cnp_number:FORCE:14,0
FIELD:cnp_btype:PROP:3,25
FIELD:cnp_lowv:CARRY:0,0
FIELD:cnp_translated:CARRY:0,0
FIELD:cnp_classid:CARRY:0,0
FIELD:company_fein:PROP:FORCE(--):27,17
ATTRIBUTEFILE:ForeignCorpkey:NAMED(_attr_ck_charters):VALUES(company_charter_number<company_inc_state):FORCE(--,ALL):IDFIELD(dotid):26,34
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
CONCEPT:addr1:prim_range:prim_name:sec_range:23,63
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
FIELD:contact_ssn:LIKE(NUMBER):EDIT1:Right4:28,33
FIELD:contact_phone:CARRY:0,0
FIELD:contact_email:LIKE(upper):CARRY:0,0
FIELD:contact_job_title_raw:CARRY:0,0
FIELD:company_department:CARRY:0,0
// ------------------------------------
//  Metadata
// ------------------------------------
FIELD:dt_first_seen:RECORDDATE(FIRST):10,504
FIELD:dt_last_seen:RECORDDATE(LAST):10,588
// ------------------------------------
//  Source information
// ------------------------------------
SOURCEFIELD:source:CONSISTENT(company_name,prim_range,prim_name,sec_range,st,v_city_name,zip):PARTITION(BIPV2.Mod_Sources.src2partition)

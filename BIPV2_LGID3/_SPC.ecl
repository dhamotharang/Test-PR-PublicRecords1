OPTIONS:-gh -ga -p2 -gs2
MODULE:BIPV2_LGID3
FILENAME:LGID3 
 
// ------------------------------------
//  IDs and Tuning
// ------------------------------------
IDFIELD:EXISTS:LGID3
RIDFIELD:rcid
IDPARENTS:seleid,orgid,ultid
IDCHILDREN:proxid,dotid
RECORDS:6397861389
POPULATION:225000000
NINES:3
BLOCKTHRESHOLD:5 
HACK:SLICETHRESHOLD:1 // No slices allowed!
THRESHOLD:40
// This won't be needed after GitHub issue 667 is fixed
HACK:CUSTOMINTERNALJOIN:_mj_extra
// ------------------------------------
//  Field validation/cleaning
// ------------------------------------
FIELDTYPE:multiword:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:Noblanks:LENGTHS(1..):ONFAIL(REJECT)
// ------------------------------------
//  Linking fields
// ------------------------------------
// Exclude clusters linked by Hrchy
//FIELDTYPE:not_hrchy:ENUM(0|1):ONFAIL(REJECT)
//FIELD:nodes_total:LIKE(not_hrchy):CARRY:0,0
FIELD:sbfe_id:WEIGHT(2.0):27,478
FIELDTYPE:not_hrchy_parent:ENUM('0'):ONFAIL(REJECT)
FIELD:nodes_below_st:LIKE(not_hrchy_parent):CARRY:0,0
FIELD:Lgid3IfHrchy:FORCE(--):PROP:27,0
//LGID3 iteration may split sele cluster, the following will be used to merge them back.
FIELD:OriginalSeleId:CARRY:0,0
FIELD:OriginalOrgId:CARRY:0,0
// Legal Name
// FIELD:company_name:LIKE(multiword):BAGOFWORDS(MOST):EDIT1(2):PROP:FORCE(+):TYPE(string250):25,147
FIELD:company_name:LIKE(multiword):LIKE(Noblanks):BAGOFWORDS(MOST):EDIT1(2):PROP:TYPE(string250):26,341
FIELD:cnp_number:PROP:FORCE(--,OR(sbfe_id)):13,1
// NOTE: This assumes we hack the data to blank company_name except when it's a Legal Name.
// Given field specificities and the THRESHOLD we've set above, we in-effect require
// a match on at least one of: duns_number, company_charter_number, or company_fein
// DUNS number (v2)
FIELD:active_duns_number:PROP:SWITCH0:27,50
FIELD:duns_number:PROP:SWITCH0:26,116
CONCEPT:duns_number_concept:active_duns_number:duns_number:26,174
//CONCEPT:company_csz:v_city_name:st:zip:FORCE(+-2):14,23
//FIELD:duns_number:PROP:25,260
// Company_charter_number or company_fein (v1)
FIELD:company_fein:26,183
FIELD:company_inc_state:PROP:FORCE(+,OR(active_duns_number),OR(duns_number),OR(duns_number_concept),OR(company_fein),OR(sbfe_id)):6,33
FIELD:company_charter_number:PROP:CONTEXT(company_inc_state):26,106
FIELD:cnp_btype:3,58
// ----------------------------------------------------
//  FYI -- no effect, but helpful during sample review
// ----------------------------------------------------
// FIELD:active_duns_number:CARRY:26,1
FIELD:company_name_type_derived:CARRY:0,0
FIELD:hist_duns_number:CARRY:0,0
FIELD:active_domestic_corp_key:CARRY:0,0
FIELD:hist_domestic_corp_key:CARRY:0,0
FIELD:foreign_corp_key:CARRY:0,0
FIELD:unk_corp_key:CARRY:0,0
FIELD:cnp_name:CARRY:0,0
FIELD:cnp_hasNumber:CARRY:0,0
// FIELD:cnp_number:CARRY:0,0
FIELD:cnp_lowv:CARRY:0,0
FIELD:cnp_translated:CARRY:0,0
FIELD:cnp_classid:CARRY:0,0
FIELD:prim_range:CARRY:0,0
FIELD:prim_name:CARRY:0,0
FIELD:sec_range:CARRY:0,0
FIELD:v_city_name:CARRY:0,0
FIELD:st:CARRY:0,0
FIELD:zip:CARRY:0,0
//For the postprocess update. HS added
FIELD:has_lgid:CARRY:0,0	
FIELD:is_sele_level:CARRY:0,0
FIELD:is_org_level:CARRY:0,0
FIELD:is_ult_level:CARRY:0,0
FIELD:parent_proxid:CARRY:0,0
FIELD:sele_proxid:CARRY:0,0
FIELD:org_proxid:CARRY:0,0
FIELD:ultimate_proxid:CARRY:0,0
FIELD:levels_from_top:CARRY:0,0
FIELD:nodes_total:CARRY:0,0
// ------------------------------------
//  Metadata
// ------------------------------------
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
SOURCEFIELD:source:CONSISTENT(company_inc_state,company_charter_number,company_name,cnp_btype,company_fein):PARTITION(BIPV2.Mod_Sources.src2partition)

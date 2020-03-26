OPTIONS:-gh -ga -p2 -gs2
MODULE:BIPV2_POWID_Platform
FILENAME:POWID
// ------------------------------------
//  IDs and Tuning
// ------------------------------------
IDFIELD:EXISTS:POWID
RIDFIELD:rcid
RECORDS:4816645228
POPULATION:288596120
NINES:3
BLOCKTHRESHOLD:5
// THRESHOLD:42
IDPARENTS:OrgID,UltID
// IDCHILDREN:ProxID,DotID
HACK:NO_PARALLEL_MATCH
HACK:MULTIPARENT
HACK:NOSLICE
// ------------------------------------
//  Field validation/cleaning
// ------------------------------------
FIELDTYPE:multiword:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:number:ALLOW(0123456789)
FIELDTYPE:hasZip4:ALLOW(0123456789):LENGTHS(4):ONFAIL(REJECT)
FIELDTYPE:RejectIfOverOne:ENUM(0|1):ONFAIL(REJECT)
FIELDTYPE:namesPerAddress:ENUM(0|1|2|3|4|5|6|7|8|9|10):ONFAIL(REJECT)
// ------------------------------------
//  Linking fields
// ------------------------------------
// residential v business
// # of inc biz @ address
// all biz name similar
// location
// if =1 inc biz @ addr & names are similar, then that's a POW
// if =0 inc biz 
// no more than 1 inc in clusters (is this still necessary?)
ATTRIBUTEFILE:charter:NAMED(_ds_attr_charter):VALUES(company_charter_number<company_inc_state):FORCE(--,ALL):IDFIELD(powid):26,1
// no more than 1 inc per address
FIELD:num_incs:LIKE(RejectIfOverOne):CARRY:0,0
FIELD:nodes_total:LIKE(RejectIfOverOne):CARRY:0,0
// FIELD:cnt_prox_per_lgid3:LIKE(RejectIfOverOne):CARRY:0,0
FIELD:RID_If_Big_Biz:FORCE(--):PROP:26,0
// no more than 10 legal names per address
FIELD:num_legal_names:LIKE(namesPerAddress):CARRY:0,0
// all biz name similar
FIELD:company_name:LIKE(multiword):BAGOFWORDS(MOST):EDIT1(2):PROP:FORCE(+):TYPE(string250):25,277
FIELD:cnp_name:LIKE(multiword):BAGOFWORDS(MANY):FORCE(+13):TYPE(string250):26,126
FIELD:cnp_number:PROP:FORCE(--):14,0
// skeletal address match, assert zip4 exists to ensure quality
FIELD:prim_range:FORCE:13,0
FIELD:prim_name:PROP:FORCE(+):15,0
FIELD:zip:LIKE(number):14,1
FIELD:zip4:LIKE(hasZip4):CARRY:0,0
// CARRY fields useful for evaluation
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
FIELD:company_name_type_derived:CARRY:0,0
FIELD:company_bdid:CARRY:0,0
// FIELD:nodes_total:CARRY:0,0
// ------------------------------------
//  Metadata
// ------------------------------------
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
SOURCEFIELD:source:CONSISTENT(company_name,cnp_number,prim_range,prim_name,zip):PARTITION(BIPV2.Mod_Sources.src2partition)

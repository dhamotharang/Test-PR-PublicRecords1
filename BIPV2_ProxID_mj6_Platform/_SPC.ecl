OPTIONS:-gh -ga -gs2

MODULE:BIPV2_ProxID_mj6_PlatForm

FILENAME:DOT_Base
IDFIELD:EXISTS:Proxid
RIDFIELD:rcid
RECORDS:6309030513
POPULATION:200000000
NINES:3
THRESHOLD:0
BLOCKTHRESHOLD:5
HACK:MAXBLOCKSIZE:20000

FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:number:ALLOW(0123456789)

// ------------------------------------
//  1. Company
// ------------------------------------
FIELD:cnp_name:FORCE(+):TYPE(string250):25,212
FIELD:cnp_number:FORCE:PROP:15,0

FIELD:active_duns_number:SWITCH0:PROP:28,22
FIELD:active_enterprise_number:FORCE(--):PROP:27,4
FIELD:active_domestic_corp_key:FORCE(--):PROP:27,5

FIELD:hist_enterprise_number:SWITCH0:PROP:27,6
FIELD:hist_duns_number:SWITCH0:PROP:27,169
FIELD:hist_domestic_corp_key:SWITCH0:PROP:27,48
FIELD:foreign_corp_key:SWITCH0:PROP:27,155
FIELD:unk_corp_key:SWITCH0:PROP:27,48
FIELD:ebr_file_number:SWITCH0:PROP:28,223

FIELD:company_fein:SWITCH0:PROP:27,155
FIELD:company_phone:SWITCH0:PROP:27,295

// ------------------------------------
//  2. Place
// ------------------------------------
FIELD:prim_range:FORCE:13,3
FIELD:prim_name_derived:FORCE(+):15,12
FIELD:sec_range:SWITCH0:PROP:12,117
FIELD:v_city_name:CONTEXT(st):FORCE(--):11,13
FIELD:st:LIKE(alpha):FORCE(+):5,0
FIELD:zip:LIKE(number):FORCE(+):14,6

CONCEPT:company_csz:v_city_name:st:zip:FORCE(+):14,25
CONCEPT:company_addr1:prim_range:prim_name_derived:sec_range:FORCE(+):24,99
CONCEPT:company_address:company_addr1:company_csz:FORCE(+):25,116

// ------------------------------------
//  Metadata
// ------------------------------------
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0

SOURCEFIELD:source:PARTITION(BIPV2.Mod_Sources.src2partition)

// ------------------------------------
//  Attribute Files
// ------------------------------------
ATTRIBUTEFILE:ForeignCorpkey:NAMED(_file_Foreign_Corpkey):VALUES(company_charter_number<company_inc_state):FORCE(--,ALL):IDFIELD(Proxid):27,38

// ------------------------------------
//  ID Parents
// ------------------------------------
IDPARENTS:lgid3,orgid,ultid
IDCHILDREN:dotid

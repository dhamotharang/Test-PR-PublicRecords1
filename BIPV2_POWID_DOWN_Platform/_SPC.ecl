OPTIONS:-gh -ga -p2 -gs2
MODULE:BIPV2_POWID_DOWN_Platform
FILENAME:POWID_Down


// ------------------------------------
//  IDs and Tuning
// ------------------------------------
IDFIELD:EXISTS:POWID
RIDFIELD:rcid
// RECORDS:2883814282 
// POPULATION:191477685
RECORDS:3688224497 
POPULATION:275408226
NINES:3
BLOCKTHRESHOLD:5
// THRESHOLD:42

// IDPARENT:OrgID,UltID
// IDCHILDREN:ProxID,DotID


// ------------------------------------
//  Field validation/cleaning
// ------------------------------------
FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:number:ALLOW(0123456789)


// ------------------------------------
//  Linking fields
// ------------------------------------

FIELD:company_name:CARRY:0,0

FIELD:orgid:FORCE:28,0
// CLEAVE:solo_orgid:BASIS(orgid):MINIMUM(1) // Cleave may be needed if we start feeding back around to the next iteration

FIELD:prim_range:FORCE:13,0
// FIELD:prim_range:EDIT1:FORCE(+):13,0
// FIELD:prim_range:EDIT1:FORCE(--):13,0
FIELD:prim_name:PROP:FORCE(+):14,0
// FIELD:prim_name:PROP:EDIT1:FORCE(+):15,0
// FIELD:sec_range:PROP:FORCE(--):12,0
FIELD:st:LIKE(alpha):FORCE(+):5,0
FIELD:v_city_name:CONTEXT(st):11,6
FIELD:zip:LIKE(number):14,7
CONCEPT:csz:v_city_name:st:zip:FORCE(+-2):14,19
// CONCEPT:addr1:prim_range:prim_name:sec_range:23,77
CONCEPT:addr1:prim_range:prim_name:22,0
CONCEPT:address:addr1:csz:FORCE(+):25,19


// ------------------------------------
//  Metadata
// ------------------------------------
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
// SOURCEFIELD:source:CONSISTENT(prim_range,prim_name,sec_range,st,v_city_name,zip):PARTITION(BIPV2.Mod_Sources.src2partition)
SOURCEFIELD:source:CONSISTENT(prim_range,prim_name,st,v_city_name,zip):PARTITION(BIPV2.Mod_Sources.src2partition)
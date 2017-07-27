OPTIONS:-gs2 -gr -grl -ga
// OPTIONS:-gh -ga -gs2 -gr -grl
MODULE:BIPV2_Seleid_Relative
FILENAME:Base
IDFIELD:EXISTS:Seleid
RIDFIELD:rcid
RECORDS:3156802047
POPULATION:2500000000
NINES:3
FIELDTYPE:wordbag:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
//BESTTYPE:UniqueSingleValue:BASIS(Proxid):UNIQUE:PROP
// ------------------------------------
//  1. Company
// ------------------------------------
//FIELD:company_name:LIKE(cname):CARRY:0,0
FIELD:cnp_name:EDIT1:LIKE(wordbag):25,279
FIELD:company_inc_state:PROP:7,28
FIELD:company_charter_number:CONTEXT(company_inc_state):PROP:EDIT1:27,57
FIELD:company_fein:PROP:27,173
FIELD:prim_range:FORCE(--):13,153
FIELD:prim_name:15,177
FIELD:postdir:CONTEXT(prim_name):7,58
FIELD:unit_desig:CARRY:0,0
FIELD:sec_range:PROP:FORCE(--):12,206
FIELD:v_city_name:CONTEXT(st):11,104
FIELD:st:LIKE(alpha):5,23
// Active ID fields from reliable sources
//FIELD:active_duns_number:UniqueSingleValue:FORCE(--):25,9
//FIELD:active_enterprise_number:FORCE(--):UniqueSingleValue:26,8
FIELD:active_duns_number:FORCE(--):28,52
FIELD:active_enterprise_number:FORCE(--):28,31
FIELD:source:4,682
FIELD:source_record_id:27,908
FIELD:fname:11,471
FIELD:mname:8,320
FIELD:lname:16,354
FIELD:contact_ssn:27,145
FIELD:contact_phone:27,221
FIELD:company_department:CARRY:0,0
FIELD:contact_email_username:26,208
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
FIELD:dt_first_seen_contact:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen_contact:RECORDDATE(LAST):0,0
HACK:KEYPREFIX
HACK:KEYINFIX
HACK:KEYSUPERFILE
//BLOCKTHRESHOLD:13
// Relationships
RELATIONSHIP:NAMEST:BASIS(cnp_name:st):TRACK(dt_first_seen:dt_last_seen):LINK(NONE):THRESHOLD(10)
RELATIONSHIP:CHARTER:BASIS(company_charter_number:company_inc_state):TRACK(dt_first_seen:dt_last_seen):LINK(NONE):THRESHOLD(20)
RELATIONSHIP:FEIN:BASIS(company_fein):LINK(NONE):TRACK(dt_first_seen:dt_last_seen):THRESHOLD(10)
RELATIONSHIP:CONTACT:BASIS(fname:lname):SCORE(mname:contact_ssn:contact_phone:contact_email_username):TRACK(dt_first_seen_contact:dt_last_seen_contact):MULTIPLE(2):LINK(NONE):THRESHOLD(18)
RELATIONSHIP:ADDRESS:BASIS(prim_name:prim_range:v_city_name:st:?:sec_range):SPLIT(16):DEDUP(prim_range):TRACK(dt_first_seen:dt_last_seen):MULTIPLE(2):LINK(NONE):THRESHOLD(10)
RELATIONSHIP:DUNS_NUMBER:BASIS(active_duns_number):LINK(NONE):TRACK(dt_first_seen:dt_last_seen):THRESHOLD(10)
RELATIONSHIP:ENTERPRISE_NUMBER:BASIS(active_enterprise_number):TRACK(dt_first_seen:dt_last_seen):LINK(NONE):THRESHOLD(10)
RELATIONSHIP:SOURCE:BASIS(source:source_record_id):LINK(NONE):TRACK(dt_first_seen:dt_last_seen):THRESHOLD(20)
RELATIONSHIP:ASSOC:DUNS_NUMBER:ENTERPRISE_NUMBER:SOURCE:CONTACT:ADDRESS:NAMEST:CHARTER:FEIN:CONTACT:ADDRESS:THRESHOLD(18)

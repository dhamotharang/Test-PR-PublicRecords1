﻿OPTIONS:-ga -gs2
THRESHOLD:12
MODULE:InsuranceHeader_Address
IDNAME:ADDRESS_GROUP_ID
RIDFIELD:RID
FILENAME:Address_Link
IDFIELD:EXISTS:ADDRESS_GROUP_ID
RECORDS:3556054198
POPULATION:3378251488
NINES:3
// HACK:SLICEDISTANCE:18
FIELDTYPE:WORDBAG:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN):
FIELD:DID:WEIGHT(.01):FORCE(--):30,0
FIELD:src:CARRY:
FIELD:dt_first_seen:CARRY:
FIELD:dt_last_seen:CARRY:
FIELD:prim_range:CARRY:
FIELD:prim_range_alpha:FORCE(--):PROP:10,0
FIELD:prim_range_num:LIKE(WORDBAG):TYPE(STRING10):BAGOFWORDS(MOST):PROP:FORCE(--):13,0
FIELD:prim_range_fract:FORCE(--):PROP:9,0
FIELD:predir:CARRY:
FIELD:prim_name:CARRY:
FIELD:prim_name_num:LIKE(WORDBAG):TYPE(STRING28):BAGOFWORDS(MOST):FORCE(--):13,0
FIELD:prim_name_alpha:LIKE(WORDBAG):TYPE(STRING50):BAGOFWORDS(MOST):FORCE(--):INITIAL:ABBR:HYPHEN2:10,0
FIELD:addr_suffix:CARRY:
FIELD:addr_ind:CARRY:
FIELD:postdir:CARRY:
FIELD:unit_desig:CARRY:
FIELD:sec_range:CARRY:
FIELD:sec_range_alpha:FORCE(--):PROP:9,0
FIELD:sec_range_num:INITIAL:FORCE(--):PROP:9,0
FIELD:city:LIKE(WORDBAG):TYPE(STRING25):BAGOFWORDS(MOST):EDIT1:HYPHEN2:8,0
FIELD:st:FORCE(--):6,0
FIELD:zip:14,0
FIELD:rec_cnt:CARRY:
FIELD:src_cnt:CARRY:
CONCEPT:addr:prim_range_num:prim_range_alpha:prim_range_fract:prim_name_num:prim_name_alpha:sec_range_num:sec_range_alpha:FORCE(--):26,0
CONCEPT:locale:city:st:zip:15,0

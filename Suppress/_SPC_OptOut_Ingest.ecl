﻿OPTIONS:-gn
MODULE:Suppress
FILENAME:OptOut_Base
INGESTFILE:optout_update:NAMED(Suppress.In_OptOut_Base)
RIDFIELD:rcid

FIELD:dt_first_seen:TYPE(UNSIGNED4):RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0
FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):RECORDDATE(FIRST):0,0
FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0
FIELD:process_date:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0
FIELD:history_flag:TYPE(STRING1):DERIVED:0,0
FIELD:entry_type:TYPE(STRING30):0,0
FIELD:lexid:TYPE(UNSIGNED8):0,0
FIELD:prof_data:TYPE(STRING1):DERIVED:0,0
FIELD:state_act:TYPE(STRING2):0,0
FIELD:exemptions:TYPE(UNSIGNED8):DERIVED:0,0
FIELD:act_id:TYPE(STRING10):DERIVED:0,0
FIELD:date_added:TYPE(STRING8):DERIVED:0,0
FIELD:global_sids:TYPE(SET OF UNSIGNED4):DERIVED:0,0
FIELD:rcid:TYPE(UNSIGNED8):DERIVED:0,0



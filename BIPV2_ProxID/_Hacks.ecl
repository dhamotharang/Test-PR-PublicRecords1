/*
Hacks:
  BIPV2_ProxID.matches: hack default force for cnp_number,cnp_name & prim_range(make sure they equal each other) in matchjoin attribute
                        add logic so that one side of cnp_name match(when SUPPORTED) is a DBA
                        add mj1 add "AND LEFT.cnp_name[1..4] = RIGHT.cnp_name[1..4]" to join condition and to atmost
                        add mj2 add "AND LEFT.sec_range = RIGHT.sec_range" to join condition and to atmost
                        add all mjs up here:
                        last_mjs_t :=mj0 + mj1 + mj2;
  BIPV2_ProxID.Debug:   hack sample match join to match hacks in matchjoin in matches.            
                        change match sample key so it's score is correct
  BIPV2_ProxID._SPC:    added company_name_type_raw & company_name_type_derived to SPC as CARRY fields.
*/

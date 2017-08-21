Generated by SALT V1.9 Gold
File being processed :-
MODULE: Hygenics_Eval
FILENAME: AOC_Offender
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:
//RIDFIELD:
//RECORDS:
//POPULATION:
//NINES:
//Uncomment Process if doing external adl
//PROCESS:
FIELD:process_date:0,0
FIELD:offender_key:0,0
FIELD:vendor:0,0
FIELD:state_origin:0,0
FIELD:source_file:0,0
FIELD:off_comp:0,0
FIELD:off_delete_flag:0,0
FIELD:off_date:0,0
FIELD:arr_date:0,0
FIELD:num_of_counts:0,0
FIELD:le_agency_cd:0,0
FIELD:le_agency_desc:0,0
FIELD:le_agency_case_number:0,0
FIELD:traffic_ticket_number:0,0
FIELD:traffic_dl_no:0,0
FIELD:traffic_dl_st:0,0
FIELD:arr_off_code:0,0
FIELD:arr_off_desc_1:0,0
FIELD:arr_off_desc_2:0,0
FIELD:arr_off_type_cd:0,0
FIELD:arr_off_type_desc:0,0
FIELD:arr_off_lev:0,0
FIELD:arr_statute:0,0
FIELD:arr_statute_desc:0,0
FIELD:arr_disp_date:0,0
FIELD:arr_disp_code:0,0
FIELD:arr_disp_desc_1:0,0
FIELD:arr_disp_desc_2:0,0
FIELD:pros_refer_cd:0,0
FIELD:pros_refer:0,0
FIELD:pros_assgn_cd:0,0
FIELD:pros_assgn:0,0
FIELD:pros_chg_rej:0,0
FIELD:pros_off_code:0,0
FIELD:pros_off_desc_1:0,0
FIELD:pros_off_desc_2:0,0
FIELD:pros_off_type_cd:0,0
FIELD:pros_off_type_desc:0,0
FIELD:pros_off_lev:0,0
FIELD:pros_act_filed:0,0
FIELD:court_case_number:0,0
FIELD:court_cd:0,0
FIELD:court_desc:0,0
FIELD:court_appeal_flag:0,0
FIELD:court_final_plea:0,0
FIELD:court_off_code:0,0
FIELD:court_off_desc_1:0,0
FIELD:court_off_desc_2:0,0
FIELD:court_off_type_cd:0,0
FIELD:court_off_type_desc:0,0
FIELD:court_off_lev:0,0
FIELD:court_statute:0,0
FIELD:court_additional_statutes:0,0
FIELD:court_statute_desc:0,0
FIELD:court_disp_date:0,0
FIELD:court_disp_code:0,0
FIELD:court_disp_desc_1:0,0
FIELD:court_disp_desc_2:0,0
FIELD:sent_date:0,0
FIELD:sent_jail:0,0
FIELD:sent_susp_time:0,0
FIELD:sent_court_cost:0,0
FIELD:sent_court_fine:0,0
FIELD:sent_susp_court_fine:0,0
FIELD:sent_probation:0,0
FIELD:sent_addl_prov_code:0,0
FIELD:sent_addl_prov_desc_1:0,0
FIELD:sent_addl_prov_desc_2:0,0
FIELD:sent_consec:0,0
FIELD:sent_agency_rec_cust_ori:0,0
FIELD:sent_agency_rec_cust:0,0
FIELD:appeal_date:0,0
FIELD:appeal_off_disp:0,0
FIELD:appeal_final_decision:0,0
Total available specificity:0
Search Threshold set at -4
Need threshold and blockthreshold to continue
Use of PERSISTs in code set at:3
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.

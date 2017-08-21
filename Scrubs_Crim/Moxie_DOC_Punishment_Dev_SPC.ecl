MODULE:Scrubs_Crim
FILENAME:crim
NAMESCOPE:Moxie_DOC_Punishment_Dev
SOURCEFIELD:vendor

FIELDTYPE:Invalid_Current_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,'future')
FIELDTYPE:Non_Blank:LENGTHS(1..)
FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )
FIELDTYPE:Invalid_Num:ALLOW(0123456789 )
FIELDTYPE:Invalid_Punishment_Type:ENUM(I|P)
FIELDTYPE:Invalid_ConOverDateFlag:ENUM(R|P|I|)
FIELDTYPE:Invalid_FCRADateFlag:ENUM(L|R|P|)

FIELD:process_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:offender_key:LIKE(Non_Blank):TYPE(STRING60):0,0
FIELD:event_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:vendor:LIKE(Non_Blank):TYPE(STRING5):0,0
FIELD:source_file:TYPE(STRING20):0,0
FIELD:record_type:TYPE(STRING2):0,0
FIELD:orig_state:LIKE(Invalid_Char):TYPE(STRING2):0,0
FIELD:offense_key:TYPE(STRING50):0,0
FIELD:punishment_type:LIKE(Invalid_Punishment_Type):TYPE(STRING1):0,0
FIELD:sent_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:sent_length:LIKE(Invalid_Num):TYPE(STRING15):0,0
FIELD:sent_length_desc:TYPE(STRING60):0,0
FIELD:cur_stat_inm:TYPE(STRING8):0,0
FIELD:cur_stat_inm_desc:TYPE(STRING50):0,0
FIELD:cur_loc_inm_cd:TYPE(STRING8):0,0
FIELD:cur_loc_inm:TYPE(STRING60):0,0
FIELD:inm_com_cty_cd:TYPE(STRING8):0,0
FIELD:inm_com_cty:TYPE(STRING25):0,0
FIELD:cur_sec_class_dt:TYPE(STRING8):0,0
FIELD:cur_loc_sec:TYPE(STRING25):0,0
FIELD:gain_time:TYPE(STRING3):0,0
FIELD:gain_time_eff_dt:TYPE(STRING8):0,0
FIELD:latest_adm_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:sch_rel_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:act_rel_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:ctl_rel_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:presump_par_rel_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:mutl_part_pgm_dt:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:release_type:TYPE(STRING4):0,0
FIELD:office_region:TYPE(STRING2):0,0
FIELD:par_cur_stat:TYPE(STRING8):0,0
FIELD:par_cur_stat_desc:TYPE(STRING50):0,0
FIELD:par_status_dt:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:par_st_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:par_sch_end_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:par_act_end_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:par_cty_cd:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:par_cty:TYPE(STRING50):0,0
FIELD:supv_office:TYPE(STRING30):0,0
FIELD:supv_officer:TYPE(STRING30):0,0
FIELD:office_phone:TYPE(STRING14):0,0
FIELD:tdcjid_unit_type:TYPE(STRING2):0,0
FIELD:tdcjid_unit_assigned:TYPE(STRING15):0,0
FIELD:tdcjid_admit_date:LIKE(Invalid_Current_Date):TYPE(STRING1):0,0
FIELD:prison_status:TYPE(STRING1):0,0
FIELD:recv_dept_code:TYPE(STRING2):0,0
FIELD:recv_dept_date:LIKE(Invalid_Current_Date):TYPE(STRING10):0,0
FIELD:parole_active_flag:TYPE(STRING1):0,0
FIELD:casepull_date:LIKE(Invalid_Current_Date):TYPE(STRING10):0,0
FIELD:pro_st_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:pro_end_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:pro_status:TYPE(STRING50):0,0
FIELD:conviction_override_date:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0
FIELD:conviction_override_date_type:LIKE(Invalid_ConOverDateFlag):TYPE(STRING1):0,0
FIELD:punishment_persistent_id:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:fcra_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0
FIELD:fcra_date_type:LIKE(Invalid_FCRADateFlag):TYPE(STRING1):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

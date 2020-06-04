// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Moxie_Court_Offenses_Dev_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Crim';
  EXPORT spc_NAMESCOPE := 'Moxie_Court_Offenses_Dev';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'vendor';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'crim';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,process_date,offender_key,vendor,state_origin,source_file,data_type,off_comp,off_delete_flag,off_date,arr_date,num_of_counts,le_agency_cd,le_agency_desc,le_agency_case_number,traffic_ticket_number,traffic_dl_no,traffic_dl_st,arr_off_code,arr_off_desc_1,arr_off_desc_2,arr_off_type_cd,arr_off_type_desc,arr_off_lev,arr_statute,arr_statute_desc,arr_disp_date,arr_disp_code,arr_disp_desc_1,arr_disp_desc_2,pros_refer_cd,pros_refer,pros_assgn_cd,pros_assgn,pros_chg_rej,pros_off_code,pros_off_desc_1,pros_off_desc_2,pros_off_type_cd,pros_off_type_desc,pros_off_lev,pros_act_filed,court_case_number,court_cd,court_desc,court_appeal_flag,court_final_plea,court_off_code,court_off_desc_1,court_off_desc_2,court_off_type_cd,court_off_type_desc,court_off_lev,court_statute,court_additional_statutes,court_statute_desc,court_disp_date,court_disp_code,court_disp_desc_1,court_disp_desc_2,sent_date,sent_jail,sent_susp_time,sent_court_cost,sent_court_fine,sent_susp_court_fine,sent_probation,sent_addl_prov_code,sent_addl_prov_desc_1,sent_addl_prov_desc_2,sent_consec,sent_agency_rec_cust_ori,sent_agency_rec_cust,appeal_date,appeal_off_disp,appeal_final_decision,convict_dt,offense_town,cty_conv,restitution,community_service,parole,addl_sent_dates,probation_desc2,court_dt,court_county,arr_off_lev_mapped,court_off_lev_mapped,fcra_offense_key,fcra_conviction_flag,fcra_traffic_flag,fcra_date,fcra_date_type,conviction_override_date,conviction_override_date_type,offense_score,offense_persistent_id,offense_category';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Crim\n'
    + 'FILENAME:crim\n'
    + 'NAMESCOPE:Moxie_Court_Offenses_Dev\n'
    + 'SOURCEFIELD:vendor\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Current_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,\'future\')\n'
    + 'FIELDTYPE:Non_Blank:LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Data_Type:ENUM(2|5)\n'
    + 'FIELDTYPE:Invalid_FCRAConFlag:ENUM(Y|N|U|)\n'
    + 'FIELDTYPE:Invalid_FCRATrafficFlag:ENUM(N|Y|)\n'
    + 'FIELDTYPE:Invalid_FCRADateFlag:ENUM(S|D|M|F|)\n'
    + 'FIELDTYPE:Invalid_ConOverDateFlag:ENUM(D|F|O|A|S|M|)\n'
    + 'FIELDTYPE:Invalid_OffenseScore:ENUM(U|F|M|I|)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_CourtOffLev:CUSTOM(Scrubs_Crim.fn_v3Code_check>0,\'COURT_OFF_LEV\',\'COURT_OFFENSES\')\n'
    + 'FIELDTYPE:Invalid_ArrOffLev:CUSTOM(Scrubs_Crim.fn_v3Code_check>0,\'ARR_OFF_LEV\',\'COURT_OFFENSES\')\n'
    + '\n'
    + '\n'
    + 'FIELD:process_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:offender_key:LIKE(Non_Blank):TYPE(STRING60):0,0\n'
    + 'FIELD:vendor:LIKE(Non_Blank):TYPE(STRING5):0,0\n'
    + 'FIELD:state_origin:LIKE(Invalid_Char):TYPE(STRING2):0,0\n'
    + 'FIELD:source_file:LIKE(Non_Blank):TYPE(STRING20):0,0\n'
    + 'FIELD:data_type:TYPE(STRING1):0,0\n'
    + 'FIELD:off_comp:TYPE(STRING4):0,0\n'
    + 'FIELD:off_delete_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:off_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:arr_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:num_of_counts:TYPE(STRING3):0,0\n'
    + 'FIELD:le_agency_cd:TYPE(STRING10):0,0\n'
    + 'FIELD:le_agency_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:le_agency_case_number:TYPE(STRING35):0,0\n'
    + 'FIELD:traffic_ticket_number:TYPE(STRING35):0,0\n'
    + 'FIELD:traffic_dl_no:TYPE(STRING25):0,0\n'
    + 'FIELD:traffic_dl_st:TYPE(STRING2):0,0\n'
    + 'FIELD:arr_off_code:TYPE(STRING20):0,0\n'
    + 'FIELD:arr_off_desc_1:TYPE(STRING75):0,0\n'
    + 'FIELD:arr_off_desc_2:TYPE(STRING50):0,0\n'
    + 'FIELD:arr_off_type_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:arr_off_type_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:arr_off_lev:LIKE(Invalid_ArrOffLev):TYPE(STRING5):0,0\n'
    + 'FIELD:arr_statute:TYPE(STRING20):0,0\n'
    + 'FIELD:arr_statute_desc:TYPE(STRING70):0,0\n'
    + 'FIELD:arr_disp_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:arr_disp_code:TYPE(STRING5):0,0\n'
    + 'FIELD:arr_disp_desc_1:TYPE(STRING30):0,0\n'
    + 'FIELD:arr_disp_desc_2:TYPE(STRING30):0,0\n'
    + 'FIELD:pros_refer_cd:TYPE(STRING10):0,0\n'
    + 'FIELD:pros_refer:TYPE(STRING50):0,0\n'
    + 'FIELD:pros_assgn_cd:TYPE(STRING10):0,0\n'
    + 'FIELD:pros_assgn:TYPE(STRING50):0,0\n'
    + 'FIELD:pros_chg_rej:TYPE(STRING1):0,0\n'
    + 'FIELD:pros_off_code:TYPE(STRING20):0,0\n'
    + 'FIELD:pros_off_desc_1:TYPE(STRING75):0,0\n'
    + 'FIELD:pros_off_desc_2:TYPE(STRING50):0,0\n'
    + 'FIELD:pros_off_type_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:pros_off_type_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:pros_off_lev:TYPE(STRING5):0,0\n'
    + 'FIELD:pros_act_filed:TYPE(STRING30):0,0\n'
    + 'FIELD:court_case_number:TYPE(STRING35):0,0\n'
    + 'FIELD:court_cd:TYPE(STRING10):0,0\n'
    + 'FIELD:court_desc:TYPE(STRING40):0,0\n'
    + 'FIELD:court_appeal_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:court_final_plea:TYPE(STRING30):0,0\n'
    + 'FIELD:court_off_code:TYPE(STRING20):0,0\n'
    + 'FIELD:court_off_desc_1:TYPE(STRING75):0,0\n'
    + 'FIELD:court_off_desc_2:TYPE(STRING50):0,0\n'
    + 'FIELD:court_off_type_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:court_off_type_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:court_off_lev:LIKE(Invalid_CourtOffLev):TYPE(STRING5):0,0\n'
    + 'FIELD:court_statute:TYPE(STRING20):0,0\n'
    + 'FIELD:court_additional_statutes:TYPE(STRING50):0,0\n'
    + 'FIELD:court_statute_desc:TYPE(STRING70):0,0\n'
    + 'FIELD:court_disp_date:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:court_disp_code:TYPE(STRING5):0,0\n'
    + 'FIELD:court_disp_desc_1:TYPE(STRING40):0,0\n'
    + 'FIELD:court_disp_desc_2:TYPE(STRING40):0,0\n'
    + 'FIELD:sent_date:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:sent_jail:TYPE(STRING50):0,0\n'
    + 'FIELD:sent_susp_time:TYPE(STRING50):0,0\n'
    + 'FIELD:sent_court_cost:TYPE(STRING8):0,0\n'
    + 'FIELD:sent_court_fine:TYPE(STRING9):0,0\n'
    + 'FIELD:sent_susp_court_fine:TYPE(STRING9):0,0\n'
    + 'FIELD:sent_probation:TYPE(STRING50):0,0\n'
    + 'FIELD:sent_addl_prov_code:TYPE(STRING5):0,0\n'
    + 'FIELD:sent_addl_prov_desc_1:TYPE(STRING40):0,0\n'
    + 'FIELD:sent_addl_prov_desc_2:TYPE(STRING40):0,0\n'
    + 'FIELD:sent_consec:TYPE(STRING2):0,0\n'
    + 'FIELD:sent_agency_rec_cust_ori:TYPE(STRING10):0,0\n'
    + 'FIELD:sent_agency_rec_cust:TYPE(STRING50):0,0\n'
    + 'FIELD:appeal_date:TYPE(STRING8):0,0\n'
    + 'FIELD:appeal_off_disp:TYPE(STRING40):0,0\n'
    + 'FIELD:appeal_final_decision:TYPE(STRING40):0,0\n'
    + 'FIELD:convict_dt:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:offense_town:TYPE(STRING30):0,0\n'
    + 'FIELD:cty_conv:TYPE(STRING30):0,0\n'
    + 'FIELD:restitution:TYPE(STRING12):0,0\n'
    + 'FIELD:community_service:TYPE(STRING30):0,0\n'
    + 'FIELD:parole:TYPE(STRING20):0,0\n'
    + 'FIELD:addl_sent_dates:TYPE(STRING30):0,0\n'
    + 'FIELD:probation_desc2:TYPE(STRING60):0,0\n'
    + 'FIELD:court_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:court_county:TYPE(STRING40):0,0\n'
    + 'FIELD:arr_off_lev_mapped:TYPE(STRING35):0,0\n'
    + 'FIELD:court_off_lev_mapped:TYPE(STRING35):0,0\n'
    + 'FIELD:fcra_offense_key:TYPE(STRING60):0,0\n'
    + 'FIELD:fcra_conviction_flag:LIKE(Invalid_FCRAConFlag):TYPE(STRING1):0,0\n'
    + 'FIELD:fcra_traffic_flag:LIKE(Invalid_FCRATrafficFlag):TYPE(STRING1):0,0\n'
    + 'FIELD:fcra_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:fcra_date_type:LIKE(Invalid_FCRADateFlag):TYPE(STRING1):0,0\n'
    + 'FIELD:conviction_override_date:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:conviction_override_date_type:LIKE(Invalid_ConOverDateFlag):TYPE(STRING1):0,0\n'
    + 'FIELD:offense_score:LIKE(Invalid_OffenseScore):TYPE(STRING2):0,0\n'
    + 'FIELD:offense_persistent_id:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:offense_category:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;


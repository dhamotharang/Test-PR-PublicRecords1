// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Moxie_DOC_Offenses_Dev_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Crim';
  EXPORT spc_NAMESCOPE := 'Moxie_DOC_Offenses_Dev';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,process_date,offender_key,vendor,county_of_origin,source_file,data_type,record_type,orig_state,offense_key,off_date,arr_date,case_num,total_num_of_offenses,num_of_counts,off_code,chg,chg_typ_flg,off_of_record,off_desc_1,off_desc_2,add_off_cd,add_off_desc,off_typ,off_lev,arr_disp_date,arr_disp_cd,arr_disp_desc_1,arr_disp_desc_2,arr_disp_desc_3,court_cd,court_desc,ct_dist,ct_fnl_plea_cd,ct_fnl_plea,ct_off_code,ct_chg,ct_chg_typ_flg,ct_off_desc_1,ct_off_desc_2,ct_addl_desc_cd,ct_off_lev,ct_disp_dt,ct_disp_cd,ct_disp_desc_1,ct_disp_desc_2,cty_conv_cd,cty_conv,adj_wthd,stc_dt,stc_cd,stc_comp,stc_desc_1,stc_desc_2,stc_desc_3,stc_desc_4,stc_lgth,stc_lgth_desc,inc_adm_dt,min_term,min_term_desc,max_term,max_term_desc,parole,probation,offensetown,convict_dt,court_county,fcra_offense_key,fcra_conviction_flag,fcra_traffic_flag,fcra_date,fcra_date_type,conviction_override_date,conviction_override_date_type,offense_score,offense_persistent_id,offense_category,hyg_classification_code,old_ln_offense_score';
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
    + 'NAMESCOPE:Moxie_DOC_Offenses_Dev\n'
    + 'SOURCEFIELD:vendor\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Current_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,\'future\')\n'
    + 'FIELDTYPE:Non_Blank:LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_Off_Typ:ENUM(F|M|I| )\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz012456789)\n'
    + 'FIELDTYPE:Invalid_CtyConvCd:ENUM(AA|99|17|PA|27|32|06|31|39|34|00|18|08|03|21|37|13|04|14|29|11|)\n'
    + 'FIELDTYPE:Invalid_FCRAConFlag:ENUM(D|U|)\n'
    + 'FIELDTYPE:Invalid_FCRATrafficFlag:ALLOW(N)\n'
    + 'FIELDTYPE:Invalid_FCRADateFlag:ENUM(S|I|D|B|)\n'
    + 'FIELDTYPE:Invalid_ConOverDateFlag:ENUM(O|I|D|A|)\n'
    + 'FIELDTYPE:Invalid_OffenseScore:ENUM(U|F|M|)\n'
    + 'FIELDTYPE:Invalid_OffLev:CUSTOM(Scrubs_Crim.fn_v3Code_Check>0,\'OFF_LEV\',\'DOC_OFFENSE\')\n'
    + '\n'
    + 'FIELD:process_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:offender_key:LIKE(Non_Blank):TYPE(STRING60):0,0\n'
    + 'FIELD:vendor:TYPE(STRING5):0,0\n'
    + 'FIELD:county_of_origin:TYPE(STRING30):0,0\n'
    + 'FIELD:source_file:LIKE(Non_Blank):TYPE(STRING20):0,0\n'
    + 'FIELD:data_type:TYPE(STRING1):0,0\n'
    + 'FIELD:record_type:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_state:LIKE(Invalid_Char):TYPE(STRING2):0,0\n'
    + 'FIELD:offense_key:LIKE(Non_Blank):TYPE(STRING50):0,0\n'
    + 'FIELD:off_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:arr_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:case_num:TYPE(STRING35):0,0\n'
    + 'FIELD:total_num_of_offenses:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:num_of_counts:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:off_code:TYPE(STRING20):0,0\n'
    + 'FIELD:chg:TYPE(STRING31):0,0\n'
    + 'FIELD:chg_typ_flg:TYPE(STRING1):0,0\n'
    + 'FIELD:off_of_record:TYPE(STRING4):0,0\n'
    + 'FIELD:off_desc_1:TYPE(STRING75):0,0\n'
    + 'FIELD:off_desc_2:TYPE(STRING50):0,0\n'
    + 'FIELD:add_off_cd:TYPE(STRING2):0,0\n'
    + 'FIELD:add_off_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:off_typ:LIKE(Invalid_Off_Typ):TYPE(STRING1):0,0\n'
    + 'FIELD:off_lev:LIKE(Invalid_OffLev):TYPE(STRING5):0,0\n'
    + 'FIELD:arr_disp_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:arr_disp_cd:TYPE(STRING3):0,0\n'
    + 'FIELD:arr_disp_desc_1:TYPE(STRING50):0,0\n'
    + 'FIELD:arr_disp_desc_2:TYPE(STRING50):0,0\n'
    + 'FIELD:arr_disp_desc_3:TYPE(STRING50):0,0\n'
    + 'FIELD:court_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:court_desc:TYPE(STRING40):0,0\n'
    + 'FIELD:ct_dist:TYPE(STRING40):0,0\n'
    + 'FIELD:ct_fnl_plea_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:ct_fnl_plea:TYPE(STRING30):0,0\n'
    + 'FIELD:ct_off_code:TYPE(STRING8):0,0\n'
    + 'FIELD:ct_chg:TYPE(STRING17):0,0\n'
    + 'FIELD:ct_chg_typ_flg:TYPE(STRING1):0,0\n'
    + 'FIELD:ct_off_desc_1:TYPE(STRING50):0,0\n'
    + 'FIELD:ct_off_desc_2:TYPE(STRING50):0,0\n'
    + 'FIELD:ct_addl_desc_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:ct_off_lev:TYPE(STRING2):0,0\n'
    + 'FIELD:ct_disp_dt:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:ct_disp_cd:TYPE(STRING4):0,0\n'
    + 'FIELD:ct_disp_desc_1:TYPE(STRING50):0,0\n'
    + 'FIELD:ct_disp_desc_2:TYPE(STRING50):0,0\n'
    + 'FIELD:cty_conv_cd:LIKE(Invalid_CtyConvCd):TYPE(STRING2):0,0\n'
    + 'FIELD:cty_conv:TYPE(STRING30):0,0\n'
    + 'FIELD:adj_wthd:TYPE(STRING1):0,0\n'
    + 'FIELD:stc_dt:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:stc_cd:TYPE(STRING3):0,0\n'
    + 'FIELD:stc_comp:TYPE(STRING3):0,0\n'
    + 'FIELD:stc_desc_1:TYPE(STRING50):0,0\n'
    + 'FIELD:stc_desc_2:TYPE(STRING50):0,0\n'
    + 'FIELD:stc_desc_3:TYPE(STRING50):0,0\n'
    + 'FIELD:stc_desc_4:TYPE(STRING50):0,0\n'
    + 'FIELD:stc_lgth:TYPE(STRING15):0,0\n'
    + 'FIELD:stc_lgth_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:inc_adm_dt:TYPE(STRING8):0,0\n'
    + 'FIELD:min_term:TYPE(STRING10):0,0\n'
    + 'FIELD:min_term_desc:TYPE(STRING35):0,0\n'
    + 'FIELD:max_term:TYPE(STRING10):0,0\n'
    + 'FIELD:max_term_desc:TYPE(STRING35):0,0\n'
    + 'FIELD:parole:TYPE(STRING50):0,0\n'
    + 'FIELD:probation:TYPE(STRING50):0,0\n'
    + 'FIELD:offensetown:TYPE(STRING40):0,0\n'
    + 'FIELD:convict_dt:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:court_county:TYPE(STRING40):0,0\n'
    + 'FIELD:fcra_offense_key:TYPE(STRING60):0,0\n'
    + 'FIELD:fcra_conviction_flag:LIKE(Invalid_FCRAConFlag):TYPE(STRING1):0,0\n'
    + 'FIELD:fcra_traffic_flag:LIKE(Invalid_FCRATrafficFlag):TYPE(STRING1):0,0\n'
    + 'FIELD:fcra_date:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:fcra_date_type:LIKE(Invalid_FCRADateFlag):TYPE(STRING1):0,0\n'
    + 'FIELD:conviction_override_date:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:conviction_override_date_type:LIKE(Invalid_ConOverDateFlag):TYPE(STRING1):0,0\n'
    + 'FIELD:offense_score:TYPE(STRING2):0,0\n'
    + 'FIELD:offense_persistent_id:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:offense_category:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:hyg_classification_code:LIKE(Invalid_Char):TYPE(STRING8):0,0\n'
    + 'FIELD:old_ln_offense_score:LIKE(Invalid_OffenseScore):TYPE(STRING8):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;


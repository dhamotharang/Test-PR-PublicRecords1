IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Voters_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 201;
  EXPORT NumRulesFromFieldType := 201;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 194;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Voters_Layout_eMerges)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 score_Invalid;
    UNSIGNED1 best_ssn_Invalid;
    UNSIGNED1 did_out_Invalid;
    UNSIGNED1 file_id_Invalid;
    UNSIGNED1 source_state_Invalid;
    UNSIGNED1 source_code_Invalid;
    UNSIGNED1 file_acquired_date_Invalid;
    UNSIGNED1 _use_Invalid;
    UNSIGNED1 title_in_Invalid;
    UNSIGNED1 lname_in_Invalid;
    UNSIGNED1 fname_in_Invalid;
    UNSIGNED1 mname_in_Invalid;
    UNSIGNED1 maiden_prior_Invalid;
    UNSIGNED1 name_suffix_in_Invalid;
    UNSIGNED1 source_voterid_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 agecat_Invalid;
    UNSIGNED1 headhousehold_Invalid;
    UNSIGNED1 place_of_birth_Invalid;
    UNSIGNED1 occupation_Invalid;
    UNSIGNED1 maiden_name_Invalid;
    UNSIGNED1 motorvoterid_Invalid;
    UNSIGNED1 regsource_Invalid;
    UNSIGNED1 regdate_Invalid;
    UNSIGNED1 race_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 poliparty_Invalid;
    UNSIGNED1 poliparty_mapped_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 work_phone_Invalid;
    UNSIGNED1 other_phone_Invalid;
    UNSIGNED1 active_status_Invalid;
    UNSIGNED1 active_status_mapped_Invalid;
    UNSIGNED1 active_other_Invalid;
    UNSIGNED1 voterstatus_Invalid;
    UNSIGNED1 voterstatus_mapped_Invalid;
    UNSIGNED1 resaddr1_Invalid;
    UNSIGNED1 resaddr2_Invalid;
    UNSIGNED1 res_city_Invalid;
    UNSIGNED1 res_state_Invalid;
    UNSIGNED1 res_zip_Invalid;
    UNSIGNED1 res_county_Invalid;
    UNSIGNED1 mail_addr1_Invalid;
    UNSIGNED1 mail_addr2_Invalid;
    UNSIGNED1 mail_city_Invalid;
    UNSIGNED1 mail_state_Invalid;
    UNSIGNED1 mail_zip_Invalid;
    UNSIGNED1 mail_county_Invalid;
    UNSIGNED1 towncode_Invalid;
    UNSIGNED1 distcode_Invalid;
    UNSIGNED1 countycode_Invalid;
    UNSIGNED1 schoolcode_Invalid;
    UNSIGNED1 cityinout_Invalid;
    UNSIGNED1 spec_dist1_Invalid;
    UNSIGNED1 spec_dist2_Invalid;
    UNSIGNED1 precinct1_Invalid;
    UNSIGNED1 precinct2_Invalid;
    UNSIGNED1 precinct3_Invalid;
    UNSIGNED1 villageprecinct_Invalid;
    UNSIGNED1 schoolprecinct_Invalid;
    UNSIGNED1 ward_Invalid;
    UNSIGNED1 precinct_citytown_Invalid;
    UNSIGNED1 ancsmdindc_Invalid;
    UNSIGNED1 citycouncildist_Invalid;
    UNSIGNED1 countycommdist_Invalid;
    UNSIGNED1 statehouse_Invalid;
    UNSIGNED1 statesenate_Invalid;
    UNSIGNED1 ushouse_Invalid;
    UNSIGNED1 elemschooldist_Invalid;
    UNSIGNED1 schooldist_Invalid;
    UNSIGNED1 commcolldist_Invalid;
    UNSIGNED1 municipal_Invalid;
    UNSIGNED1 villagedist_Invalid;
    UNSIGNED1 policejury_Invalid;
    UNSIGNED1 policedist_Invalid;
    UNSIGNED1 publicservcomm_Invalid;
    UNSIGNED1 rescue_Invalid;
    UNSIGNED1 fire_Invalid;
    UNSIGNED1 sanitary_Invalid;
    UNSIGNED1 sewerdist_Invalid;
    UNSIGNED1 waterdist_Invalid;
    UNSIGNED1 mosquitodist_Invalid;
    UNSIGNED1 taxdist_Invalid;
    UNSIGNED1 supremecourt_Invalid;
    UNSIGNED1 justiceofpeace_Invalid;
    UNSIGNED1 judicialdist_Invalid;
    UNSIGNED1 superiorctdist_Invalid;
    UNSIGNED1 appealsct_Invalid;
    UNSIGNED1 contributorparty_Invalid;
    UNSIGNED1 recptparty_Invalid;
    UNSIGNED1 dateofcontr_Invalid;
    UNSIGNED1 dollaramt_Invalid;
    UNSIGNED1 primary02_Invalid;
    UNSIGNED1 special02_Invalid;
    UNSIGNED1 other02_Invalid;
    UNSIGNED1 special202_Invalid;
    UNSIGNED1 general02_Invalid;
    UNSIGNED1 primary01_Invalid;
    UNSIGNED1 special01_Invalid;
    UNSIGNED1 other01_Invalid;
    UNSIGNED1 special201_Invalid;
    UNSIGNED1 general01_Invalid;
    UNSIGNED1 pres00_Invalid;
    UNSIGNED1 primary00_Invalid;
    UNSIGNED1 special00_Invalid;
    UNSIGNED1 other00_Invalid;
    UNSIGNED1 special200_Invalid;
    UNSIGNED1 general00_Invalid;
    UNSIGNED1 primary99_Invalid;
    UNSIGNED1 special99_Invalid;
    UNSIGNED1 other99_Invalid;
    UNSIGNED1 special299_Invalid;
    UNSIGNED1 general99_Invalid;
    UNSIGNED1 primary98_Invalid;
    UNSIGNED1 special98_Invalid;
    UNSIGNED1 other98_Invalid;
    UNSIGNED1 special298_Invalid;
    UNSIGNED1 general98_Invalid;
    UNSIGNED1 primary97_Invalid;
    UNSIGNED1 special97_Invalid;
    UNSIGNED1 other97_Invalid;
    UNSIGNED1 special297_Invalid;
    UNSIGNED1 general97_Invalid;
    UNSIGNED1 pres96_Invalid;
    UNSIGNED1 primary96_Invalid;
    UNSIGNED1 special96_Invalid;
    UNSIGNED1 other96_Invalid;
    UNSIGNED1 special296_Invalid;
    UNSIGNED1 general96_Invalid;
    UNSIGNED1 lastdayvote_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 score_on_input_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dpbc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 ace_fips_st_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 county_name_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 mail_prim_range_Invalid;
    UNSIGNED1 mail_predir_Invalid;
    UNSIGNED1 mail_prim_name_Invalid;
    UNSIGNED1 mail_addr_suffix_Invalid;
    UNSIGNED1 mail_postdir_Invalid;
    UNSIGNED1 mail_unit_desig_Invalid;
    UNSIGNED1 mail_sec_range_Invalid;
    UNSIGNED1 mail_p_city_name_Invalid;
    UNSIGNED1 mail_v_city_name_Invalid;
    UNSIGNED1 mail_st_Invalid;
    UNSIGNED1 mail_ace_zip_Invalid;
    UNSIGNED1 mail_zip4_Invalid;
    UNSIGNED1 mail_cart_Invalid;
    UNSIGNED1 mail_cr_sort_sz_Invalid;
    UNSIGNED1 mail_lot_Invalid;
    UNSIGNED1 mail_lot_order_Invalid;
    UNSIGNED1 mail_dpbc_Invalid;
    UNSIGNED1 mail_chk_digit_Invalid;
    UNSIGNED1 mail_record_type_Invalid;
    UNSIGNED1 mail_ace_fips_st_Invalid;
    UNSIGNED1 mail_fipscounty_Invalid;
    UNSIGNED1 mail_geo_lat_Invalid;
    UNSIGNED1 mail_geo_long_Invalid;
    UNSIGNED1 mail_msa_Invalid;
    UNSIGNED1 mail_geo_blk_Invalid;
    UNSIGNED1 mail_geo_match_Invalid;
    UNSIGNED1 mail_err_stat_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Voters_Layout_eMerges)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
  END;
  EXPORT Rule_Layout := RECORD(Voters_Layout_eMerges)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'process_date:Invalid_Date:CUSTOM'
          ,'date_first_seen:Invalid_Date:CUSTOM'
          ,'date_last_seen:Invalid_Date:CUSTOM'
          ,'score:Invalid_No:ALLOW'
          ,'best_ssn:Invalid_Float:ALLOW'
          ,'did_out:Invalid_No:ALLOW'
          ,'file_id:Invalid_Alpha:ALLOW'
          ,'source_state:Invalid_State:ALLOW','source_state:Invalid_State:LENGTHS'
          ,'source_code:Invalid_Alpha:ALLOW'
          ,'file_acquired_date:Invalid_Date:CUSTOM'
          ,'_use:Invalid_AlphaNum:ALLOW'
          ,'title_in:Invalid_Alpha:ALLOW'
          ,'lname_in:Invalid_Alpha:ALLOW'
          ,'fname_in:Invalid_Alpha:ALLOW'
          ,'mname_in:Invalid_Alpha:ALLOW'
          ,'maiden_prior:Invalid_Alpha:ALLOW'
          ,'name_suffix_in:Invalid_AlphaNum:ALLOW'
          ,'source_voterid:Invalid_No:ALLOW'
          ,'dob:Invalid_Date:CUSTOM'
          ,'agecat:Invalid_No:ALLOW'
          ,'headhousehold:Invalid_Alpha:ALLOW'
          ,'place_of_birth:Invalid_Date:CUSTOM'
          ,'occupation:Invalid_Alpha:ALLOW'
          ,'maiden_name:Invalid_Alpha:ALLOW'
          ,'motorvoterid:Invalid_No:ALLOW'
          ,'regsource:Invalid_Alpha:ALLOW'
          ,'regdate:Invalid_Date:CUSTOM'
          ,'race:Invalid_Alpha:ALLOW'
          ,'gender:Invalid_Alpha:ALLOW'
          ,'poliparty:Invalid_No:ALLOW'
          ,'poliparty_mapped:Invalid_Alpha:ALLOW'
          ,'phone:Invalid_Float:ALLOW'
          ,'work_phone:Invalid_Float:ALLOW'
          ,'other_phone:Invalid_Float:ALLOW'
          ,'active_status:Invalid_Alpha:ALLOW'
          ,'active_status_mapped:Invalid_Alpha:ALLOW'
          ,'active_other:Invalid_AlphaNum:ALLOW'
          ,'voterstatus:Invalid_AlphaNum:ALLOW'
          ,'voterstatus_mapped:Invalid_AlphaNum:ALLOW'
          ,'resaddr1:Invalid_AlphaNum:ALLOW'
          ,'resaddr2:Invalid_AlphaNum:ALLOW'
          ,'res_city:Invalid_Alpha:ALLOW'
          ,'res_state:Invalid_State:ALLOW','res_state:Invalid_State:LENGTHS'
          ,'res_zip:Invalid_Zip:ALLOW','res_zip:Invalid_Zip:LENGTHS'
          ,'res_county:Invalid_AlphaNum:ALLOW'
          ,'mail_addr1:Invalid_AlphaNum:ALLOW'
          ,'mail_addr2:Invalid_AlphaNum:ALLOW'
          ,'mail_city:Invalid_Alpha:ALLOW'
          ,'mail_state:Invalid_State:ALLOW','mail_state:Invalid_State:LENGTHS'
          ,'mail_zip:Invalid_Zip:ALLOW','mail_zip:Invalid_Zip:LENGTHS'
          ,'mail_county:Invalid_No:ALLOW'
          ,'towncode:Invalid_AlphaNum:ALLOW'
          ,'distcode:Invalid_AlphaNum:ALLOW'
          ,'countycode:Invalid_AlphaNum:ALLOW'
          ,'schoolcode:Invalid_AlphaNum:ALLOW'
          ,'cityinout:Invalid_AlphaNum:ALLOW'
          ,'spec_dist1:Invalid_AlphaNum:ALLOW'
          ,'spec_dist2:Invalid_AlphaNum:ALLOW'
          ,'precinct1:Invalid_AlphaNum:ALLOW'
          ,'precinct2:Invalid_AlphaNum:ALLOW'
          ,'precinct3:Invalid_AlphaNum:ALLOW'
          ,'villageprecinct:Invalid_AlphaNum:ALLOW'
          ,'schoolprecinct:Invalid_AlphaNum:ALLOW'
          ,'ward:Invalid_AlphaNum:ALLOW'
          ,'precinct_citytown:Invalid_AlphaNum:ALLOW'
          ,'ancsmdindc:Invalid_AlphaNum:ALLOW'
          ,'citycouncildist:Invalid_AlphaNum:ALLOW'
          ,'countycommdist:Invalid_AlphaNum:ALLOW'
          ,'statehouse:Invalid_AlphaNum:ALLOW'
          ,'statesenate:Invalid_AlphaNum:ALLOW'
          ,'ushouse:Invalid_AlphaNum:ALLOW'
          ,'elemschooldist:Invalid_AlphaNum:ALLOW'
          ,'schooldist:Invalid_AlphaNum:ALLOW'
          ,'commcolldist:Invalid_AlphaNum:ALLOW'
          ,'municipal:Invalid_AlphaNum:ALLOW'
          ,'villagedist:Invalid_AlphaNum:ALLOW'
          ,'policejury:Invalid_AlphaNum:ALLOW'
          ,'policedist:Invalid_AlphaNum:ALLOW'
          ,'publicservcomm:Invalid_AlphaNum:ALLOW'
          ,'rescue:Invalid_No:ALLOW'
          ,'fire:Invalid_No:ALLOW'
          ,'sanitary:Invalid_Alpha:ALLOW'
          ,'sewerdist:Invalid_No:ALLOW'
          ,'waterdist:Invalid_No:ALLOW'
          ,'mosquitodist:Invalid_No:ALLOW'
          ,'taxdist:Invalid_No:ALLOW'
          ,'supremecourt:Invalid_No:ALLOW'
          ,'justiceofpeace:Invalid_AlphaNum:ALLOW'
          ,'judicialdist:Invalid_AlphaNum:ALLOW'
          ,'superiorctdist:Invalid_AlphaNum:ALLOW'
          ,'appealsct:Invalid_AlphaNum:ALLOW'
          ,'contributorparty:Invalid_Alpha:ALLOW'
          ,'recptparty:Invalid_No:ALLOW'
          ,'dateofcontr:Invalid_Date:CUSTOM'
          ,'dollaramt:Invalid_No:ALLOW'
          ,'primary02:Invalid_Alpha:ALLOW'
          ,'special02:Invalid_Alpha:ALLOW'
          ,'other02:Invalid_Alpha:ALLOW'
          ,'special202:Invalid_Alpha:ALLOW'
          ,'general02:Invalid_Alpha:ALLOW'
          ,'primary01:Invalid_Alpha:ALLOW'
          ,'special01:Invalid_Alpha:ALLOW'
          ,'other01:Invalid_Alpha:ALLOW'
          ,'special201:Invalid_Alpha:ALLOW'
          ,'general01:Invalid_Alpha:ALLOW'
          ,'pres00:Invalid_Alpha:ALLOW'
          ,'primary00:Invalid_Alpha:ALLOW'
          ,'special00:Invalid_Alpha:ALLOW'
          ,'other00:Invalid_Alpha:ALLOW'
          ,'special200:Invalid_Alpha:ALLOW'
          ,'general00:Invalid_Alpha:ALLOW'
          ,'primary99:Invalid_Alpha:ALLOW'
          ,'special99:Invalid_Alpha:ALLOW'
          ,'other99:Invalid_Alpha:ALLOW'
          ,'special299:Invalid_Alpha:ALLOW'
          ,'general99:Invalid_Alpha:ALLOW'
          ,'primary98:Invalid_Alpha:ALLOW'
          ,'special98:Invalid_Alpha:ALLOW'
          ,'other98:Invalid_Alpha:ALLOW'
          ,'special298:Invalid_Alpha:ALLOW'
          ,'general98:Invalid_Alpha:ALLOW'
          ,'primary97:Invalid_Alpha:ALLOW'
          ,'special97:Invalid_Alpha:ALLOW'
          ,'other97:Invalid_Alpha:ALLOW'
          ,'special297:Invalid_Alpha:ALLOW'
          ,'general97:Invalid_Alpha:ALLOW'
          ,'pres96:Invalid_Alpha:ALLOW'
          ,'primary96:Invalid_Alpha:ALLOW'
          ,'special96:Invalid_Alpha:ALLOW'
          ,'other96:Invalid_Alpha:ALLOW'
          ,'special296:Invalid_Alpha:ALLOW'
          ,'general96:Invalid_Alpha:ALLOW'
          ,'lastdayvote:Invalid_Date:CUSTOM'
          ,'title:Invalid_Alpha:ALLOW'
          ,'fname:Invalid_Alpha:ALLOW'
          ,'mname:Invalid_Alpha:ALLOW'
          ,'lname:Invalid_Alpha:ALLOW'
          ,'name_suffix:Invalid_Alpha:ALLOW'
          ,'score_on_input:Invalid_No:ALLOW'
          ,'prim_range:Invalid_No:ALLOW'
          ,'predir:Invalid_Alpha:ALLOW'
          ,'prim_name:Invalid_AlphaNum:ALLOW'
          ,'suffix:Invalid_Alpha:ALLOW'
          ,'postdir:Invalid_Alpha:ALLOW'
          ,'unit_desig:Invalid_Alpha:ALLOW'
          ,'sec_range:Invalid_AlphaNum:ALLOW'
          ,'p_city_name:Invalid_Alpha:ALLOW'
          ,'city_name:Invalid_Alpha:ALLOW'
          ,'st:Invalid_Alpha:ALLOW'
          ,'zip:Invalid_Zip:ALLOW','zip:Invalid_Zip:LENGTHS'
          ,'zip4:Invalid_No:ALLOW'
          ,'cart:Invalid_AlphaNum:ALLOW'
          ,'cr_sort_sz:Invalid_Alpha:ALLOW'
          ,'lot:Invalid_No:ALLOW'
          ,'lot_order:Invalid_Alpha:ALLOW'
          ,'dpbc:Invalid_No:ALLOW'
          ,'chk_digit:Invalid_No:ALLOW'
          ,'record_type:Invalid_Alpha:ALLOW'
          ,'ace_fips_st:Invalid_AlphaNum:ALLOW'
          ,'county:Invalid_No:ALLOW'
          ,'county_name:Invalid_Alpha:ALLOW'
          ,'geo_lat:Invalid_Float:ALLOW'
          ,'geo_long:Invalid_Float:ALLOW'
          ,'msa:Invalid_Float:ALLOW'
          ,'geo_blk:Invalid_Float:ALLOW'
          ,'geo_match:Invalid_Float:ALLOW'
          ,'err_stat:Invalid_AlphaNum:ALLOW'
          ,'mail_prim_range:Invalid_No:ALLOW'
          ,'mail_predir:Invalid_Alpha:ALLOW'
          ,'mail_prim_name:Invalid_AlphaNum:ALLOW'
          ,'mail_addr_suffix:Invalid_Alpha:ALLOW'
          ,'mail_postdir:Invalid_Alpha:ALLOW'
          ,'mail_unit_desig:Invalid_Alpha:ALLOW'
          ,'mail_sec_range:Invalid_AlphaNum:ALLOW'
          ,'mail_p_city_name:Invalid_Alpha:ALLOW'
          ,'mail_v_city_name:Invalid_Alpha:ALLOW'
          ,'mail_st:Invalid_Alpha:ALLOW'
          ,'mail_ace_zip:Invalid_Zip:ALLOW','mail_ace_zip:Invalid_Zip:LENGTHS'
          ,'mail_zip4:Invalid_No:ALLOW'
          ,'mail_cart:Invalid_AlphaNum:ALLOW'
          ,'mail_cr_sort_sz:Invalid_Alpha:ALLOW'
          ,'mail_lot:Invalid_No:ALLOW'
          ,'mail_lot_order:Invalid_Alpha:ALLOW'
          ,'mail_dpbc:Invalid_No:ALLOW'
          ,'mail_chk_digit:Invalid_No:ALLOW'
          ,'mail_record_type:Invalid_Alpha:ALLOW'
          ,'mail_ace_fips_st:Invalid_No:ALLOW'
          ,'mail_fipscounty:Invalid_No:ALLOW'
          ,'mail_geo_lat:Invalid_Float:ALLOW'
          ,'mail_geo_long:Invalid_Float:ALLOW'
          ,'mail_msa:Invalid_Float:ALLOW'
          ,'mail_geo_blk:Invalid_Float:ALLOW'
          ,'mail_geo_match:Invalid_Float:ALLOW'
          ,'mail_err_stat:Invalid_AlphaNum:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Voters_Fields.InvalidMessage_process_date(1)
          ,Voters_Fields.InvalidMessage_date_first_seen(1)
          ,Voters_Fields.InvalidMessage_date_last_seen(1)
          ,Voters_Fields.InvalidMessage_score(1)
          ,Voters_Fields.InvalidMessage_best_ssn(1)
          ,Voters_Fields.InvalidMessage_did_out(1)
          ,Voters_Fields.InvalidMessage_file_id(1)
          ,Voters_Fields.InvalidMessage_source_state(1),Voters_Fields.InvalidMessage_source_state(2)
          ,Voters_Fields.InvalidMessage_source_code(1)
          ,Voters_Fields.InvalidMessage_file_acquired_date(1)
          ,Voters_Fields.InvalidMessage__use(1)
          ,Voters_Fields.InvalidMessage_title_in(1)
          ,Voters_Fields.InvalidMessage_lname_in(1)
          ,Voters_Fields.InvalidMessage_fname_in(1)
          ,Voters_Fields.InvalidMessage_mname_in(1)
          ,Voters_Fields.InvalidMessage_maiden_prior(1)
          ,Voters_Fields.InvalidMessage_name_suffix_in(1)
          ,Voters_Fields.InvalidMessage_source_voterid(1)
          ,Voters_Fields.InvalidMessage_dob(1)
          ,Voters_Fields.InvalidMessage_agecat(1)
          ,Voters_Fields.InvalidMessage_headhousehold(1)
          ,Voters_Fields.InvalidMessage_place_of_birth(1)
          ,Voters_Fields.InvalidMessage_occupation(1)
          ,Voters_Fields.InvalidMessage_maiden_name(1)
          ,Voters_Fields.InvalidMessage_motorvoterid(1)
          ,Voters_Fields.InvalidMessage_regsource(1)
          ,Voters_Fields.InvalidMessage_regdate(1)
          ,Voters_Fields.InvalidMessage_race(1)
          ,Voters_Fields.InvalidMessage_gender(1)
          ,Voters_Fields.InvalidMessage_poliparty(1)
          ,Voters_Fields.InvalidMessage_poliparty_mapped(1)
          ,Voters_Fields.InvalidMessage_phone(1)
          ,Voters_Fields.InvalidMessage_work_phone(1)
          ,Voters_Fields.InvalidMessage_other_phone(1)
          ,Voters_Fields.InvalidMessage_active_status(1)
          ,Voters_Fields.InvalidMessage_active_status_mapped(1)
          ,Voters_Fields.InvalidMessage_active_other(1)
          ,Voters_Fields.InvalidMessage_voterstatus(1)
          ,Voters_Fields.InvalidMessage_voterstatus_mapped(1)
          ,Voters_Fields.InvalidMessage_resaddr1(1)
          ,Voters_Fields.InvalidMessage_resaddr2(1)
          ,Voters_Fields.InvalidMessage_res_city(1)
          ,Voters_Fields.InvalidMessage_res_state(1),Voters_Fields.InvalidMessage_res_state(2)
          ,Voters_Fields.InvalidMessage_res_zip(1),Voters_Fields.InvalidMessage_res_zip(2)
          ,Voters_Fields.InvalidMessage_res_county(1)
          ,Voters_Fields.InvalidMessage_mail_addr1(1)
          ,Voters_Fields.InvalidMessage_mail_addr2(1)
          ,Voters_Fields.InvalidMessage_mail_city(1)
          ,Voters_Fields.InvalidMessage_mail_state(1),Voters_Fields.InvalidMessage_mail_state(2)
          ,Voters_Fields.InvalidMessage_mail_zip(1),Voters_Fields.InvalidMessage_mail_zip(2)
          ,Voters_Fields.InvalidMessage_mail_county(1)
          ,Voters_Fields.InvalidMessage_towncode(1)
          ,Voters_Fields.InvalidMessage_distcode(1)
          ,Voters_Fields.InvalidMessage_countycode(1)
          ,Voters_Fields.InvalidMessage_schoolcode(1)
          ,Voters_Fields.InvalidMessage_cityinout(1)
          ,Voters_Fields.InvalidMessage_spec_dist1(1)
          ,Voters_Fields.InvalidMessage_spec_dist2(1)
          ,Voters_Fields.InvalidMessage_precinct1(1)
          ,Voters_Fields.InvalidMessage_precinct2(1)
          ,Voters_Fields.InvalidMessage_precinct3(1)
          ,Voters_Fields.InvalidMessage_villageprecinct(1)
          ,Voters_Fields.InvalidMessage_schoolprecinct(1)
          ,Voters_Fields.InvalidMessage_ward(1)
          ,Voters_Fields.InvalidMessage_precinct_citytown(1)
          ,Voters_Fields.InvalidMessage_ancsmdindc(1)
          ,Voters_Fields.InvalidMessage_citycouncildist(1)
          ,Voters_Fields.InvalidMessage_countycommdist(1)
          ,Voters_Fields.InvalidMessage_statehouse(1)
          ,Voters_Fields.InvalidMessage_statesenate(1)
          ,Voters_Fields.InvalidMessage_ushouse(1)
          ,Voters_Fields.InvalidMessage_elemschooldist(1)
          ,Voters_Fields.InvalidMessage_schooldist(1)
          ,Voters_Fields.InvalidMessage_commcolldist(1)
          ,Voters_Fields.InvalidMessage_municipal(1)
          ,Voters_Fields.InvalidMessage_villagedist(1)
          ,Voters_Fields.InvalidMessage_policejury(1)
          ,Voters_Fields.InvalidMessage_policedist(1)
          ,Voters_Fields.InvalidMessage_publicservcomm(1)
          ,Voters_Fields.InvalidMessage_rescue(1)
          ,Voters_Fields.InvalidMessage_fire(1)
          ,Voters_Fields.InvalidMessage_sanitary(1)
          ,Voters_Fields.InvalidMessage_sewerdist(1)
          ,Voters_Fields.InvalidMessage_waterdist(1)
          ,Voters_Fields.InvalidMessage_mosquitodist(1)
          ,Voters_Fields.InvalidMessage_taxdist(1)
          ,Voters_Fields.InvalidMessage_supremecourt(1)
          ,Voters_Fields.InvalidMessage_justiceofpeace(1)
          ,Voters_Fields.InvalidMessage_judicialdist(1)
          ,Voters_Fields.InvalidMessage_superiorctdist(1)
          ,Voters_Fields.InvalidMessage_appealsct(1)
          ,Voters_Fields.InvalidMessage_contributorparty(1)
          ,Voters_Fields.InvalidMessage_recptparty(1)
          ,Voters_Fields.InvalidMessage_dateofcontr(1)
          ,Voters_Fields.InvalidMessage_dollaramt(1)
          ,Voters_Fields.InvalidMessage_primary02(1)
          ,Voters_Fields.InvalidMessage_special02(1)
          ,Voters_Fields.InvalidMessage_other02(1)
          ,Voters_Fields.InvalidMessage_special202(1)
          ,Voters_Fields.InvalidMessage_general02(1)
          ,Voters_Fields.InvalidMessage_primary01(1)
          ,Voters_Fields.InvalidMessage_special01(1)
          ,Voters_Fields.InvalidMessage_other01(1)
          ,Voters_Fields.InvalidMessage_special201(1)
          ,Voters_Fields.InvalidMessage_general01(1)
          ,Voters_Fields.InvalidMessage_pres00(1)
          ,Voters_Fields.InvalidMessage_primary00(1)
          ,Voters_Fields.InvalidMessage_special00(1)
          ,Voters_Fields.InvalidMessage_other00(1)
          ,Voters_Fields.InvalidMessage_special200(1)
          ,Voters_Fields.InvalidMessage_general00(1)
          ,Voters_Fields.InvalidMessage_primary99(1)
          ,Voters_Fields.InvalidMessage_special99(1)
          ,Voters_Fields.InvalidMessage_other99(1)
          ,Voters_Fields.InvalidMessage_special299(1)
          ,Voters_Fields.InvalidMessage_general99(1)
          ,Voters_Fields.InvalidMessage_primary98(1)
          ,Voters_Fields.InvalidMessage_special98(1)
          ,Voters_Fields.InvalidMessage_other98(1)
          ,Voters_Fields.InvalidMessage_special298(1)
          ,Voters_Fields.InvalidMessage_general98(1)
          ,Voters_Fields.InvalidMessage_primary97(1)
          ,Voters_Fields.InvalidMessage_special97(1)
          ,Voters_Fields.InvalidMessage_other97(1)
          ,Voters_Fields.InvalidMessage_special297(1)
          ,Voters_Fields.InvalidMessage_general97(1)
          ,Voters_Fields.InvalidMessage_pres96(1)
          ,Voters_Fields.InvalidMessage_primary96(1)
          ,Voters_Fields.InvalidMessage_special96(1)
          ,Voters_Fields.InvalidMessage_other96(1)
          ,Voters_Fields.InvalidMessage_special296(1)
          ,Voters_Fields.InvalidMessage_general96(1)
          ,Voters_Fields.InvalidMessage_lastdayvote(1)
          ,Voters_Fields.InvalidMessage_title(1)
          ,Voters_Fields.InvalidMessage_fname(1)
          ,Voters_Fields.InvalidMessage_mname(1)
          ,Voters_Fields.InvalidMessage_lname(1)
          ,Voters_Fields.InvalidMessage_name_suffix(1)
          ,Voters_Fields.InvalidMessage_score_on_input(1)
          ,Voters_Fields.InvalidMessage_prim_range(1)
          ,Voters_Fields.InvalidMessage_predir(1)
          ,Voters_Fields.InvalidMessage_prim_name(1)
          ,Voters_Fields.InvalidMessage_suffix(1)
          ,Voters_Fields.InvalidMessage_postdir(1)
          ,Voters_Fields.InvalidMessage_unit_desig(1)
          ,Voters_Fields.InvalidMessage_sec_range(1)
          ,Voters_Fields.InvalidMessage_p_city_name(1)
          ,Voters_Fields.InvalidMessage_city_name(1)
          ,Voters_Fields.InvalidMessage_st(1)
          ,Voters_Fields.InvalidMessage_zip(1),Voters_Fields.InvalidMessage_zip(2)
          ,Voters_Fields.InvalidMessage_zip4(1)
          ,Voters_Fields.InvalidMessage_cart(1)
          ,Voters_Fields.InvalidMessage_cr_sort_sz(1)
          ,Voters_Fields.InvalidMessage_lot(1)
          ,Voters_Fields.InvalidMessage_lot_order(1)
          ,Voters_Fields.InvalidMessage_dpbc(1)
          ,Voters_Fields.InvalidMessage_chk_digit(1)
          ,Voters_Fields.InvalidMessage_record_type(1)
          ,Voters_Fields.InvalidMessage_ace_fips_st(1)
          ,Voters_Fields.InvalidMessage_county(1)
          ,Voters_Fields.InvalidMessage_county_name(1)
          ,Voters_Fields.InvalidMessage_geo_lat(1)
          ,Voters_Fields.InvalidMessage_geo_long(1)
          ,Voters_Fields.InvalidMessage_msa(1)
          ,Voters_Fields.InvalidMessage_geo_blk(1)
          ,Voters_Fields.InvalidMessage_geo_match(1)
          ,Voters_Fields.InvalidMessage_err_stat(1)
          ,Voters_Fields.InvalidMessage_mail_prim_range(1)
          ,Voters_Fields.InvalidMessage_mail_predir(1)
          ,Voters_Fields.InvalidMessage_mail_prim_name(1)
          ,Voters_Fields.InvalidMessage_mail_addr_suffix(1)
          ,Voters_Fields.InvalidMessage_mail_postdir(1)
          ,Voters_Fields.InvalidMessage_mail_unit_desig(1)
          ,Voters_Fields.InvalidMessage_mail_sec_range(1)
          ,Voters_Fields.InvalidMessage_mail_p_city_name(1)
          ,Voters_Fields.InvalidMessage_mail_v_city_name(1)
          ,Voters_Fields.InvalidMessage_mail_st(1)
          ,Voters_Fields.InvalidMessage_mail_ace_zip(1),Voters_Fields.InvalidMessage_mail_ace_zip(2)
          ,Voters_Fields.InvalidMessage_mail_zip4(1)
          ,Voters_Fields.InvalidMessage_mail_cart(1)
          ,Voters_Fields.InvalidMessage_mail_cr_sort_sz(1)
          ,Voters_Fields.InvalidMessage_mail_lot(1)
          ,Voters_Fields.InvalidMessage_mail_lot_order(1)
          ,Voters_Fields.InvalidMessage_mail_dpbc(1)
          ,Voters_Fields.InvalidMessage_mail_chk_digit(1)
          ,Voters_Fields.InvalidMessage_mail_record_type(1)
          ,Voters_Fields.InvalidMessage_mail_ace_fips_st(1)
          ,Voters_Fields.InvalidMessage_mail_fipscounty(1)
          ,Voters_Fields.InvalidMessage_mail_geo_lat(1)
          ,Voters_Fields.InvalidMessage_mail_geo_long(1)
          ,Voters_Fields.InvalidMessage_mail_msa(1)
          ,Voters_Fields.InvalidMessage_mail_geo_blk(1)
          ,Voters_Fields.InvalidMessage_mail_geo_match(1)
          ,Voters_Fields.InvalidMessage_mail_err_stat(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Voters_Layout_eMerges) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Voters_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.date_first_seen_Invalid := Voters_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Voters_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.score_Invalid := Voters_Fields.InValid_score((SALT311.StrType)le.score);
    SELF.best_ssn_Invalid := Voters_Fields.InValid_best_ssn((SALT311.StrType)le.best_ssn);
    SELF.did_out_Invalid := Voters_Fields.InValid_did_out((SALT311.StrType)le.did_out);
    SELF.file_id_Invalid := Voters_Fields.InValid_file_id((SALT311.StrType)le.file_id);
    SELF.source_state_Invalid := Voters_Fields.InValid_source_state((SALT311.StrType)le.source_state);
    SELF.source_code_Invalid := Voters_Fields.InValid_source_code((SALT311.StrType)le.source_code);
    SELF.file_acquired_date_Invalid := Voters_Fields.InValid_file_acquired_date((SALT311.StrType)le.file_acquired_date);
    SELF._use_Invalid := Voters_Fields.InValid__use((SALT311.StrType)le._use);
    SELF.title_in_Invalid := Voters_Fields.InValid_title_in((SALT311.StrType)le.title_in);
    SELF.lname_in_Invalid := Voters_Fields.InValid_lname_in((SALT311.StrType)le.lname_in);
    SELF.fname_in_Invalid := Voters_Fields.InValid_fname_in((SALT311.StrType)le.fname_in);
    SELF.mname_in_Invalid := Voters_Fields.InValid_mname_in((SALT311.StrType)le.mname_in);
    SELF.maiden_prior_Invalid := Voters_Fields.InValid_maiden_prior((SALT311.StrType)le.maiden_prior);
    SELF.name_suffix_in_Invalid := Voters_Fields.InValid_name_suffix_in((SALT311.StrType)le.name_suffix_in);
    SELF.source_voterid_Invalid := Voters_Fields.InValid_source_voterid((SALT311.StrType)le.source_voterid);
    SELF.dob_Invalid := Voters_Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.agecat_Invalid := Voters_Fields.InValid_agecat((SALT311.StrType)le.agecat);
    SELF.headhousehold_Invalid := Voters_Fields.InValid_headhousehold((SALT311.StrType)le.headhousehold);
    SELF.place_of_birth_Invalid := Voters_Fields.InValid_place_of_birth((SALT311.StrType)le.place_of_birth);
    SELF.occupation_Invalid := Voters_Fields.InValid_occupation((SALT311.StrType)le.occupation);
    SELF.maiden_name_Invalid := Voters_Fields.InValid_maiden_name((SALT311.StrType)le.maiden_name);
    SELF.motorvoterid_Invalid := Voters_Fields.InValid_motorvoterid((SALT311.StrType)le.motorvoterid);
    SELF.regsource_Invalid := Voters_Fields.InValid_regsource((SALT311.StrType)le.regsource);
    SELF.regdate_Invalid := Voters_Fields.InValid_regdate((SALT311.StrType)le.regdate);
    SELF.race_Invalid := Voters_Fields.InValid_race((SALT311.StrType)le.race);
    SELF.gender_Invalid := Voters_Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.poliparty_Invalid := Voters_Fields.InValid_poliparty((SALT311.StrType)le.poliparty);
    SELF.poliparty_mapped_Invalid := Voters_Fields.InValid_poliparty_mapped((SALT311.StrType)le.poliparty_mapped);
    SELF.phone_Invalid := Voters_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.work_phone_Invalid := Voters_Fields.InValid_work_phone((SALT311.StrType)le.work_phone);
    SELF.other_phone_Invalid := Voters_Fields.InValid_other_phone((SALT311.StrType)le.other_phone);
    SELF.active_status_Invalid := Voters_Fields.InValid_active_status((SALT311.StrType)le.active_status);
    SELF.active_status_mapped_Invalid := Voters_Fields.InValid_active_status_mapped((SALT311.StrType)le.active_status_mapped);
    SELF.active_other_Invalid := Voters_Fields.InValid_active_other((SALT311.StrType)le.active_other);
    SELF.voterstatus_Invalid := Voters_Fields.InValid_voterstatus((SALT311.StrType)le.voterstatus);
    SELF.voterstatus_mapped_Invalid := Voters_Fields.InValid_voterstatus_mapped((SALT311.StrType)le.voterstatus_mapped);
    SELF.resaddr1_Invalid := Voters_Fields.InValid_resaddr1((SALT311.StrType)le.resaddr1);
    SELF.resaddr2_Invalid := Voters_Fields.InValid_resaddr2((SALT311.StrType)le.resaddr2);
    SELF.res_city_Invalid := Voters_Fields.InValid_res_city((SALT311.StrType)le.res_city);
    SELF.res_state_Invalid := Voters_Fields.InValid_res_state((SALT311.StrType)le.res_state);
    SELF.res_zip_Invalid := Voters_Fields.InValid_res_zip((SALT311.StrType)le.res_zip);
    SELF.res_county_Invalid := Voters_Fields.InValid_res_county((SALT311.StrType)le.res_county);
    SELF.mail_addr1_Invalid := Voters_Fields.InValid_mail_addr1((SALT311.StrType)le.mail_addr1);
    SELF.mail_addr2_Invalid := Voters_Fields.InValid_mail_addr2((SALT311.StrType)le.mail_addr2);
    SELF.mail_city_Invalid := Voters_Fields.InValid_mail_city((SALT311.StrType)le.mail_city);
    SELF.mail_state_Invalid := Voters_Fields.InValid_mail_state((SALT311.StrType)le.mail_state);
    SELF.mail_zip_Invalid := Voters_Fields.InValid_mail_zip((SALT311.StrType)le.mail_zip);
    SELF.mail_county_Invalid := Voters_Fields.InValid_mail_county((SALT311.StrType)le.mail_county);
    SELF.towncode_Invalid := Voters_Fields.InValid_towncode((SALT311.StrType)le.towncode);
    SELF.distcode_Invalid := Voters_Fields.InValid_distcode((SALT311.StrType)le.distcode);
    SELF.countycode_Invalid := Voters_Fields.InValid_countycode((SALT311.StrType)le.countycode);
    SELF.schoolcode_Invalid := Voters_Fields.InValid_schoolcode((SALT311.StrType)le.schoolcode);
    SELF.cityinout_Invalid := Voters_Fields.InValid_cityinout((SALT311.StrType)le.cityinout);
    SELF.spec_dist1_Invalid := Voters_Fields.InValid_spec_dist1((SALT311.StrType)le.spec_dist1);
    SELF.spec_dist2_Invalid := Voters_Fields.InValid_spec_dist2((SALT311.StrType)le.spec_dist2);
    SELF.precinct1_Invalid := Voters_Fields.InValid_precinct1((SALT311.StrType)le.precinct1);
    SELF.precinct2_Invalid := Voters_Fields.InValid_precinct2((SALT311.StrType)le.precinct2);
    SELF.precinct3_Invalid := Voters_Fields.InValid_precinct3((SALT311.StrType)le.precinct3);
    SELF.villageprecinct_Invalid := Voters_Fields.InValid_villageprecinct((SALT311.StrType)le.villageprecinct);
    SELF.schoolprecinct_Invalid := Voters_Fields.InValid_schoolprecinct((SALT311.StrType)le.schoolprecinct);
    SELF.ward_Invalid := Voters_Fields.InValid_ward((SALT311.StrType)le.ward);
    SELF.precinct_citytown_Invalid := Voters_Fields.InValid_precinct_citytown((SALT311.StrType)le.precinct_citytown);
    SELF.ancsmdindc_Invalid := Voters_Fields.InValid_ancsmdindc((SALT311.StrType)le.ancsmdindc);
    SELF.citycouncildist_Invalid := Voters_Fields.InValid_citycouncildist((SALT311.StrType)le.citycouncildist);
    SELF.countycommdist_Invalid := Voters_Fields.InValid_countycommdist((SALT311.StrType)le.countycommdist);
    SELF.statehouse_Invalid := Voters_Fields.InValid_statehouse((SALT311.StrType)le.statehouse);
    SELF.statesenate_Invalid := Voters_Fields.InValid_statesenate((SALT311.StrType)le.statesenate);
    SELF.ushouse_Invalid := Voters_Fields.InValid_ushouse((SALT311.StrType)le.ushouse);
    SELF.elemschooldist_Invalid := Voters_Fields.InValid_elemschooldist((SALT311.StrType)le.elemschooldist);
    SELF.schooldist_Invalid := Voters_Fields.InValid_schooldist((SALT311.StrType)le.schooldist);
    SELF.commcolldist_Invalid := Voters_Fields.InValid_commcolldist((SALT311.StrType)le.commcolldist);
    SELF.municipal_Invalid := Voters_Fields.InValid_municipal((SALT311.StrType)le.municipal);
    SELF.villagedist_Invalid := Voters_Fields.InValid_villagedist((SALT311.StrType)le.villagedist);
    SELF.policejury_Invalid := Voters_Fields.InValid_policejury((SALT311.StrType)le.policejury);
    SELF.policedist_Invalid := Voters_Fields.InValid_policedist((SALT311.StrType)le.policedist);
    SELF.publicservcomm_Invalid := Voters_Fields.InValid_publicservcomm((SALT311.StrType)le.publicservcomm);
    SELF.rescue_Invalid := Voters_Fields.InValid_rescue((SALT311.StrType)le.rescue);
    SELF.fire_Invalid := Voters_Fields.InValid_fire((SALT311.StrType)le.fire);
    SELF.sanitary_Invalid := Voters_Fields.InValid_sanitary((SALT311.StrType)le.sanitary);
    SELF.sewerdist_Invalid := Voters_Fields.InValid_sewerdist((SALT311.StrType)le.sewerdist);
    SELF.waterdist_Invalid := Voters_Fields.InValid_waterdist((SALT311.StrType)le.waterdist);
    SELF.mosquitodist_Invalid := Voters_Fields.InValid_mosquitodist((SALT311.StrType)le.mosquitodist);
    SELF.taxdist_Invalid := Voters_Fields.InValid_taxdist((SALT311.StrType)le.taxdist);
    SELF.supremecourt_Invalid := Voters_Fields.InValid_supremecourt((SALT311.StrType)le.supremecourt);
    SELF.justiceofpeace_Invalid := Voters_Fields.InValid_justiceofpeace((SALT311.StrType)le.justiceofpeace);
    SELF.judicialdist_Invalid := Voters_Fields.InValid_judicialdist((SALT311.StrType)le.judicialdist);
    SELF.superiorctdist_Invalid := Voters_Fields.InValid_superiorctdist((SALT311.StrType)le.superiorctdist);
    SELF.appealsct_Invalid := Voters_Fields.InValid_appealsct((SALT311.StrType)le.appealsct);
    SELF.contributorparty_Invalid := Voters_Fields.InValid_contributorparty((SALT311.StrType)le.contributorparty);
    SELF.recptparty_Invalid := Voters_Fields.InValid_recptparty((SALT311.StrType)le.recptparty);
    SELF.dateofcontr_Invalid := Voters_Fields.InValid_dateofcontr((SALT311.StrType)le.dateofcontr);
    SELF.dollaramt_Invalid := Voters_Fields.InValid_dollaramt((SALT311.StrType)le.dollaramt);
    SELF.primary02_Invalid := Voters_Fields.InValid_primary02((SALT311.StrType)le.primary02);
    SELF.special02_Invalid := Voters_Fields.InValid_special02((SALT311.StrType)le.special02);
    SELF.other02_Invalid := Voters_Fields.InValid_other02((SALT311.StrType)le.other02);
    SELF.special202_Invalid := Voters_Fields.InValid_special202((SALT311.StrType)le.special202);
    SELF.general02_Invalid := Voters_Fields.InValid_general02((SALT311.StrType)le.general02);
    SELF.primary01_Invalid := Voters_Fields.InValid_primary01((SALT311.StrType)le.primary01);
    SELF.special01_Invalid := Voters_Fields.InValid_special01((SALT311.StrType)le.special01);
    SELF.other01_Invalid := Voters_Fields.InValid_other01((SALT311.StrType)le.other01);
    SELF.special201_Invalid := Voters_Fields.InValid_special201((SALT311.StrType)le.special201);
    SELF.general01_Invalid := Voters_Fields.InValid_general01((SALT311.StrType)le.general01);
    SELF.pres00_Invalid := Voters_Fields.InValid_pres00((SALT311.StrType)le.pres00);
    SELF.primary00_Invalid := Voters_Fields.InValid_primary00((SALT311.StrType)le.primary00);
    SELF.special00_Invalid := Voters_Fields.InValid_special00((SALT311.StrType)le.special00);
    SELF.other00_Invalid := Voters_Fields.InValid_other00((SALT311.StrType)le.other00);
    SELF.special200_Invalid := Voters_Fields.InValid_special200((SALT311.StrType)le.special200);
    SELF.general00_Invalid := Voters_Fields.InValid_general00((SALT311.StrType)le.general00);
    SELF.primary99_Invalid := Voters_Fields.InValid_primary99((SALT311.StrType)le.primary99);
    SELF.special99_Invalid := Voters_Fields.InValid_special99((SALT311.StrType)le.special99);
    SELF.other99_Invalid := Voters_Fields.InValid_other99((SALT311.StrType)le.other99);
    SELF.special299_Invalid := Voters_Fields.InValid_special299((SALT311.StrType)le.special299);
    SELF.general99_Invalid := Voters_Fields.InValid_general99((SALT311.StrType)le.general99);
    SELF.primary98_Invalid := Voters_Fields.InValid_primary98((SALT311.StrType)le.primary98);
    SELF.special98_Invalid := Voters_Fields.InValid_special98((SALT311.StrType)le.special98);
    SELF.other98_Invalid := Voters_Fields.InValid_other98((SALT311.StrType)le.other98);
    SELF.special298_Invalid := Voters_Fields.InValid_special298((SALT311.StrType)le.special298);
    SELF.general98_Invalid := Voters_Fields.InValid_general98((SALT311.StrType)le.general98);
    SELF.primary97_Invalid := Voters_Fields.InValid_primary97((SALT311.StrType)le.primary97);
    SELF.special97_Invalid := Voters_Fields.InValid_special97((SALT311.StrType)le.special97);
    SELF.other97_Invalid := Voters_Fields.InValid_other97((SALT311.StrType)le.other97);
    SELF.special297_Invalid := Voters_Fields.InValid_special297((SALT311.StrType)le.special297);
    SELF.general97_Invalid := Voters_Fields.InValid_general97((SALT311.StrType)le.general97);
    SELF.pres96_Invalid := Voters_Fields.InValid_pres96((SALT311.StrType)le.pres96);
    SELF.primary96_Invalid := Voters_Fields.InValid_primary96((SALT311.StrType)le.primary96);
    SELF.special96_Invalid := Voters_Fields.InValid_special96((SALT311.StrType)le.special96);
    SELF.other96_Invalid := Voters_Fields.InValid_other96((SALT311.StrType)le.other96);
    SELF.special296_Invalid := Voters_Fields.InValid_special296((SALT311.StrType)le.special296);
    SELF.general96_Invalid := Voters_Fields.InValid_general96((SALT311.StrType)le.general96);
    SELF.lastdayvote_Invalid := Voters_Fields.InValid_lastdayvote((SALT311.StrType)le.lastdayvote);
    SELF.title_Invalid := Voters_Fields.InValid_title((SALT311.StrType)le.title);
    SELF.fname_Invalid := Voters_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := Voters_Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := Voters_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.name_suffix_Invalid := Voters_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.score_on_input_Invalid := Voters_Fields.InValid_score_on_input((SALT311.StrType)le.score_on_input);
    SELF.prim_range_Invalid := Voters_Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Voters_Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Voters_Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.suffix_Invalid := Voters_Fields.InValid_suffix((SALT311.StrType)le.suffix);
    SELF.postdir_Invalid := Voters_Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := Voters_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Voters_Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Voters_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.city_name_Invalid := Voters_Fields.InValid_city_name((SALT311.StrType)le.city_name);
    SELF.st_Invalid := Voters_Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip_Invalid := Voters_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.zip4_Invalid := Voters_Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.cart_Invalid := Voters_Fields.InValid_cart((SALT311.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Voters_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Voters_Fields.InValid_lot((SALT311.StrType)le.lot);
    SELF.lot_order_Invalid := Voters_Fields.InValid_lot_order((SALT311.StrType)le.lot_order);
    SELF.dpbc_Invalid := Voters_Fields.InValid_dpbc((SALT311.StrType)le.dpbc);
    SELF.chk_digit_Invalid := Voters_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    SELF.record_type_Invalid := Voters_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.ace_fips_st_Invalid := Voters_Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st);
    SELF.county_Invalid := Voters_Fields.InValid_county((SALT311.StrType)le.county);
    SELF.county_name_Invalid := Voters_Fields.InValid_county_name((SALT311.StrType)le.county_name);
    SELF.geo_lat_Invalid := Voters_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Voters_Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    SELF.msa_Invalid := Voters_Fields.InValid_msa((SALT311.StrType)le.msa);
    SELF.geo_blk_Invalid := Voters_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Voters_Fields.InValid_geo_match((SALT311.StrType)le.geo_match);
    SELF.err_stat_Invalid := Voters_Fields.InValid_err_stat((SALT311.StrType)le.err_stat);
    SELF.mail_prim_range_Invalid := Voters_Fields.InValid_mail_prim_range((SALT311.StrType)le.mail_prim_range);
    SELF.mail_predir_Invalid := Voters_Fields.InValid_mail_predir((SALT311.StrType)le.mail_predir);
    SELF.mail_prim_name_Invalid := Voters_Fields.InValid_mail_prim_name((SALT311.StrType)le.mail_prim_name);
    SELF.mail_addr_suffix_Invalid := Voters_Fields.InValid_mail_addr_suffix((SALT311.StrType)le.mail_addr_suffix);
    SELF.mail_postdir_Invalid := Voters_Fields.InValid_mail_postdir((SALT311.StrType)le.mail_postdir);
    SELF.mail_unit_desig_Invalid := Voters_Fields.InValid_mail_unit_desig((SALT311.StrType)le.mail_unit_desig);
    SELF.mail_sec_range_Invalid := Voters_Fields.InValid_mail_sec_range((SALT311.StrType)le.mail_sec_range);
    SELF.mail_p_city_name_Invalid := Voters_Fields.InValid_mail_p_city_name((SALT311.StrType)le.mail_p_city_name);
    SELF.mail_v_city_name_Invalid := Voters_Fields.InValid_mail_v_city_name((SALT311.StrType)le.mail_v_city_name);
    SELF.mail_st_Invalid := Voters_Fields.InValid_mail_st((SALT311.StrType)le.mail_st);
    SELF.mail_ace_zip_Invalid := Voters_Fields.InValid_mail_ace_zip((SALT311.StrType)le.mail_ace_zip);
    SELF.mail_zip4_Invalid := Voters_Fields.InValid_mail_zip4((SALT311.StrType)le.mail_zip4);
    SELF.mail_cart_Invalid := Voters_Fields.InValid_mail_cart((SALT311.StrType)le.mail_cart);
    SELF.mail_cr_sort_sz_Invalid := Voters_Fields.InValid_mail_cr_sort_sz((SALT311.StrType)le.mail_cr_sort_sz);
    SELF.mail_lot_Invalid := Voters_Fields.InValid_mail_lot((SALT311.StrType)le.mail_lot);
    SELF.mail_lot_order_Invalid := Voters_Fields.InValid_mail_lot_order((SALT311.StrType)le.mail_lot_order);
    SELF.mail_dpbc_Invalid := Voters_Fields.InValid_mail_dpbc((SALT311.StrType)le.mail_dpbc);
    SELF.mail_chk_digit_Invalid := Voters_Fields.InValid_mail_chk_digit((SALT311.StrType)le.mail_chk_digit);
    SELF.mail_record_type_Invalid := Voters_Fields.InValid_mail_record_type((SALT311.StrType)le.mail_record_type);
    SELF.mail_ace_fips_st_Invalid := Voters_Fields.InValid_mail_ace_fips_st((SALT311.StrType)le.mail_ace_fips_st);
    SELF.mail_fipscounty_Invalid := Voters_Fields.InValid_mail_fipscounty((SALT311.StrType)le.mail_fipscounty);
    SELF.mail_geo_lat_Invalid := Voters_Fields.InValid_mail_geo_lat((SALT311.StrType)le.mail_geo_lat);
    SELF.mail_geo_long_Invalid := Voters_Fields.InValid_mail_geo_long((SALT311.StrType)le.mail_geo_long);
    SELF.mail_msa_Invalid := Voters_Fields.InValid_mail_msa((SALT311.StrType)le.mail_msa);
    SELF.mail_geo_blk_Invalid := Voters_Fields.InValid_mail_geo_blk((SALT311.StrType)le.mail_geo_blk);
    SELF.mail_geo_match_Invalid := Voters_Fields.InValid_mail_geo_match((SALT311.StrType)le.mail_geo_match);
    SELF.mail_err_stat_Invalid := Voters_Fields.InValid_mail_err_stat((SALT311.StrType)le.mail_err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Voters_Layout_eMerges);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.date_first_seen_Invalid << 1 ) + ( le.date_last_seen_Invalid << 2 ) + ( le.score_Invalid << 3 ) + ( le.best_ssn_Invalid << 4 ) + ( le.did_out_Invalid << 5 ) + ( le.file_id_Invalid << 6 ) + ( le.source_state_Invalid << 7 ) + ( le.source_code_Invalid << 9 ) + ( le.file_acquired_date_Invalid << 10 ) + ( le._use_Invalid << 11 ) + ( le.title_in_Invalid << 12 ) + ( le.lname_in_Invalid << 13 ) + ( le.fname_in_Invalid << 14 ) + ( le.mname_in_Invalid << 15 ) + ( le.maiden_prior_Invalid << 16 ) + ( le.name_suffix_in_Invalid << 17 ) + ( le.source_voterid_Invalid << 18 ) + ( le.dob_Invalid << 19 ) + ( le.agecat_Invalid << 20 ) + ( le.headhousehold_Invalid << 21 ) + ( le.place_of_birth_Invalid << 22 ) + ( le.occupation_Invalid << 23 ) + ( le.maiden_name_Invalid << 24 ) + ( le.motorvoterid_Invalid << 25 ) + ( le.regsource_Invalid << 26 ) + ( le.regdate_Invalid << 27 ) + ( le.race_Invalid << 28 ) + ( le.gender_Invalid << 29 ) + ( le.poliparty_Invalid << 30 ) + ( le.poliparty_mapped_Invalid << 31 ) + ( le.phone_Invalid << 32 ) + ( le.work_phone_Invalid << 33 ) + ( le.other_phone_Invalid << 34 ) + ( le.active_status_Invalid << 35 ) + ( le.active_status_mapped_Invalid << 36 ) + ( le.active_other_Invalid << 37 ) + ( le.voterstatus_Invalid << 38 ) + ( le.voterstatus_mapped_Invalid << 39 ) + ( le.resaddr1_Invalid << 40 ) + ( le.resaddr2_Invalid << 41 ) + ( le.res_city_Invalid << 42 ) + ( le.res_state_Invalid << 43 ) + ( le.res_zip_Invalid << 45 ) + ( le.res_county_Invalid << 47 ) + ( le.mail_addr1_Invalid << 48 ) + ( le.mail_addr2_Invalid << 49 ) + ( le.mail_city_Invalid << 50 ) + ( le.mail_state_Invalid << 51 ) + ( le.mail_zip_Invalid << 53 ) + ( le.mail_county_Invalid << 55 ) + ( le.towncode_Invalid << 56 ) + ( le.distcode_Invalid << 57 ) + ( le.countycode_Invalid << 58 ) + ( le.schoolcode_Invalid << 59 ) + ( le.cityinout_Invalid << 60 ) + ( le.spec_dist1_Invalid << 61 ) + ( le.spec_dist2_Invalid << 62 ) + ( le.precinct1_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.precinct2_Invalid << 0 ) + ( le.precinct3_Invalid << 1 ) + ( le.villageprecinct_Invalid << 2 ) + ( le.schoolprecinct_Invalid << 3 ) + ( le.ward_Invalid << 4 ) + ( le.precinct_citytown_Invalid << 5 ) + ( le.ancsmdindc_Invalid << 6 ) + ( le.citycouncildist_Invalid << 7 ) + ( le.countycommdist_Invalid << 8 ) + ( le.statehouse_Invalid << 9 ) + ( le.statesenate_Invalid << 10 ) + ( le.ushouse_Invalid << 11 ) + ( le.elemschooldist_Invalid << 12 ) + ( le.schooldist_Invalid << 13 ) + ( le.commcolldist_Invalid << 14 ) + ( le.municipal_Invalid << 15 ) + ( le.villagedist_Invalid << 16 ) + ( le.policejury_Invalid << 17 ) + ( le.policedist_Invalid << 18 ) + ( le.publicservcomm_Invalid << 19 ) + ( le.rescue_Invalid << 20 ) + ( le.fire_Invalid << 21 ) + ( le.sanitary_Invalid << 22 ) + ( le.sewerdist_Invalid << 23 ) + ( le.waterdist_Invalid << 24 ) + ( le.mosquitodist_Invalid << 25 ) + ( le.taxdist_Invalid << 26 ) + ( le.supremecourt_Invalid << 27 ) + ( le.justiceofpeace_Invalid << 28 ) + ( le.judicialdist_Invalid << 29 ) + ( le.superiorctdist_Invalid << 30 ) + ( le.appealsct_Invalid << 31 ) + ( le.contributorparty_Invalid << 32 ) + ( le.recptparty_Invalid << 33 ) + ( le.dateofcontr_Invalid << 34 ) + ( le.dollaramt_Invalid << 35 ) + ( le.primary02_Invalid << 36 ) + ( le.special02_Invalid << 37 ) + ( le.other02_Invalid << 38 ) + ( le.special202_Invalid << 39 ) + ( le.general02_Invalid << 40 ) + ( le.primary01_Invalid << 41 ) + ( le.special01_Invalid << 42 ) + ( le.other01_Invalid << 43 ) + ( le.special201_Invalid << 44 ) + ( le.general01_Invalid << 45 ) + ( le.pres00_Invalid << 46 ) + ( le.primary00_Invalid << 47 ) + ( le.special00_Invalid << 48 ) + ( le.other00_Invalid << 49 ) + ( le.special200_Invalid << 50 ) + ( le.general00_Invalid << 51 ) + ( le.primary99_Invalid << 52 ) + ( le.special99_Invalid << 53 ) + ( le.other99_Invalid << 54 ) + ( le.special299_Invalid << 55 ) + ( le.general99_Invalid << 56 ) + ( le.primary98_Invalid << 57 ) + ( le.special98_Invalid << 58 ) + ( le.other98_Invalid << 59 ) + ( le.special298_Invalid << 60 ) + ( le.general98_Invalid << 61 ) + ( le.primary97_Invalid << 62 ) + ( le.special97_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.other97_Invalid << 0 ) + ( le.special297_Invalid << 1 ) + ( le.general97_Invalid << 2 ) + ( le.pres96_Invalid << 3 ) + ( le.primary96_Invalid << 4 ) + ( le.special96_Invalid << 5 ) + ( le.other96_Invalid << 6 ) + ( le.special296_Invalid << 7 ) + ( le.general96_Invalid << 8 ) + ( le.lastdayvote_Invalid << 9 ) + ( le.title_Invalid << 10 ) + ( le.fname_Invalid << 11 ) + ( le.mname_Invalid << 12 ) + ( le.lname_Invalid << 13 ) + ( le.name_suffix_Invalid << 14 ) + ( le.score_on_input_Invalid << 15 ) + ( le.prim_range_Invalid << 16 ) + ( le.predir_Invalid << 17 ) + ( le.prim_name_Invalid << 18 ) + ( le.suffix_Invalid << 19 ) + ( le.postdir_Invalid << 20 ) + ( le.unit_desig_Invalid << 21 ) + ( le.sec_range_Invalid << 22 ) + ( le.p_city_name_Invalid << 23 ) + ( le.city_name_Invalid << 24 ) + ( le.st_Invalid << 25 ) + ( le.zip_Invalid << 26 ) + ( le.zip4_Invalid << 28 ) + ( le.cart_Invalid << 29 ) + ( le.cr_sort_sz_Invalid << 30 ) + ( le.lot_Invalid << 31 ) + ( le.lot_order_Invalid << 32 ) + ( le.dpbc_Invalid << 33 ) + ( le.chk_digit_Invalid << 34 ) + ( le.record_type_Invalid << 35 ) + ( le.ace_fips_st_Invalid << 36 ) + ( le.county_Invalid << 37 ) + ( le.county_name_Invalid << 38 ) + ( le.geo_lat_Invalid << 39 ) + ( le.geo_long_Invalid << 40 ) + ( le.msa_Invalid << 41 ) + ( le.geo_blk_Invalid << 42 ) + ( le.geo_match_Invalid << 43 ) + ( le.err_stat_Invalid << 44 ) + ( le.mail_prim_range_Invalid << 45 ) + ( le.mail_predir_Invalid << 46 ) + ( le.mail_prim_name_Invalid << 47 ) + ( le.mail_addr_suffix_Invalid << 48 ) + ( le.mail_postdir_Invalid << 49 ) + ( le.mail_unit_desig_Invalid << 50 ) + ( le.mail_sec_range_Invalid << 51 ) + ( le.mail_p_city_name_Invalid << 52 ) + ( le.mail_v_city_name_Invalid << 53 ) + ( le.mail_st_Invalid << 54 ) + ( le.mail_ace_zip_Invalid << 55 ) + ( le.mail_zip4_Invalid << 57 ) + ( le.mail_cart_Invalid << 58 ) + ( le.mail_cr_sort_sz_Invalid << 59 ) + ( le.mail_lot_Invalid << 60 ) + ( le.mail_lot_order_Invalid << 61 ) + ( le.mail_dpbc_Invalid << 62 ) + ( le.mail_chk_digit_Invalid << 63 );
    SELF.ScrubsBits4 := ( le.mail_record_type_Invalid << 0 ) + ( le.mail_ace_fips_st_Invalid << 1 ) + ( le.mail_fipscounty_Invalid << 2 ) + ( le.mail_geo_lat_Invalid << 3 ) + ( le.mail_geo_long_Invalid << 4 ) + ( le.mail_msa_Invalid << 5 ) + ( le.mail_geo_blk_Invalid << 6 ) + ( le.mail_geo_match_Invalid << 7 ) + ( le.mail_err_stat_Invalid << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0 OR (mask&le.ScrubsBits3)>0 OR (mask&le.ScrubsBits4)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND le.ScrubsBits3=0 AND le.ScrubsBits4=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Voters_Layout_eMerges);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.score_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.best_ssn_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.did_out_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.file_id_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.source_state_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.source_code_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.file_acquired_date_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF._use_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.title_in_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.lname_in_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.fname_in_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.mname_in_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.maiden_prior_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.name_suffix_in_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.source_voterid_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.agecat_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.headhousehold_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.place_of_birth_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.occupation_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.maiden_name_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.motorvoterid_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.regsource_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.regdate_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.race_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.poliparty_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.poliparty_mapped_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.work_phone_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.other_phone_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.active_status_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.active_status_mapped_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.active_other_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.voterstatus_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.voterstatus_mapped_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.resaddr1_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.resaddr2_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.res_city_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.res_state_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.res_zip_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.res_county_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.mail_addr1_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.mail_addr2_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.mail_city_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.mail_state_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.mail_zip_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.mail_county_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.towncode_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.distcode_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.countycode_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.schoolcode_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.cityinout_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.spec_dist1_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.spec_dist2_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.precinct1_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.precinct2_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.precinct3_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.villageprecinct_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.schoolprecinct_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.ward_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.precinct_citytown_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.ancsmdindc_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.citycouncildist_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.countycommdist_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.statehouse_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.statesenate_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.ushouse_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.elemschooldist_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.schooldist_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.commcolldist_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.municipal_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.villagedist_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.policejury_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.policedist_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.publicservcomm_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.rescue_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.fire_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.sanitary_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.sewerdist_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.waterdist_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.mosquitodist_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.taxdist_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.supremecourt_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.justiceofpeace_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.judicialdist_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.superiorctdist_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.appealsct_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.contributorparty_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.recptparty_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.dateofcontr_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.dollaramt_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.primary02_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.special02_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.other02_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.special202_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.general02_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.primary01_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.special01_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.other01_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.special201_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.general01_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.pres00_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.primary00_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.special00_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.other00_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.special200_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.general00_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.primary99_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.special99_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.other99_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.special299_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.general99_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.primary98_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.special98_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.other98_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.special298_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.general98_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.primary97_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.special97_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.other97_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.special297_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.general97_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.pres96_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.primary96_Invalid := (le.ScrubsBits3 >> 4) & 1;
    SELF.special96_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.other96_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.special296_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.general96_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.lastdayvote_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.title_Invalid := (le.ScrubsBits3 >> 10) & 1;
    SELF.fname_Invalid := (le.ScrubsBits3 >> 11) & 1;
    SELF.mname_Invalid := (le.ScrubsBits3 >> 12) & 1;
    SELF.lname_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.score_on_input_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.predir_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.city_name_Invalid := (le.ScrubsBits3 >> 24) & 1;
    SELF.st_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.zip_Invalid := (le.ScrubsBits3 >> 26) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.cart_Invalid := (le.ScrubsBits3 >> 29) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.lot_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits3 >> 32) & 1;
    SELF.dpbc_Invalid := (le.ScrubsBits3 >> 33) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits3 >> 34) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits3 >> 35) & 1;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits3 >> 36) & 1;
    SELF.county_Invalid := (le.ScrubsBits3 >> 37) & 1;
    SELF.county_name_Invalid := (le.ScrubsBits3 >> 38) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits3 >> 39) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits3 >> 40) & 1;
    SELF.msa_Invalid := (le.ScrubsBits3 >> 41) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits3 >> 42) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits3 >> 43) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits3 >> 44) & 1;
    SELF.mail_prim_range_Invalid := (le.ScrubsBits3 >> 45) & 1;
    SELF.mail_predir_Invalid := (le.ScrubsBits3 >> 46) & 1;
    SELF.mail_prim_name_Invalid := (le.ScrubsBits3 >> 47) & 1;
    SELF.mail_addr_suffix_Invalid := (le.ScrubsBits3 >> 48) & 1;
    SELF.mail_postdir_Invalid := (le.ScrubsBits3 >> 49) & 1;
    SELF.mail_unit_desig_Invalid := (le.ScrubsBits3 >> 50) & 1;
    SELF.mail_sec_range_Invalid := (le.ScrubsBits3 >> 51) & 1;
    SELF.mail_p_city_name_Invalid := (le.ScrubsBits3 >> 52) & 1;
    SELF.mail_v_city_name_Invalid := (le.ScrubsBits3 >> 53) & 1;
    SELF.mail_st_Invalid := (le.ScrubsBits3 >> 54) & 1;
    SELF.mail_ace_zip_Invalid := (le.ScrubsBits3 >> 55) & 3;
    SELF.mail_zip4_Invalid := (le.ScrubsBits3 >> 57) & 1;
    SELF.mail_cart_Invalid := (le.ScrubsBits3 >> 58) & 1;
    SELF.mail_cr_sort_sz_Invalid := (le.ScrubsBits3 >> 59) & 1;
    SELF.mail_lot_Invalid := (le.ScrubsBits3 >> 60) & 1;
    SELF.mail_lot_order_Invalid := (le.ScrubsBits3 >> 61) & 1;
    SELF.mail_dpbc_Invalid := (le.ScrubsBits3 >> 62) & 1;
    SELF.mail_chk_digit_Invalid := (le.ScrubsBits3 >> 63) & 1;
    SELF.mail_record_type_Invalid := (le.ScrubsBits4 >> 0) & 1;
    SELF.mail_ace_fips_st_Invalid := (le.ScrubsBits4 >> 1) & 1;
    SELF.mail_fipscounty_Invalid := (le.ScrubsBits4 >> 2) & 1;
    SELF.mail_geo_lat_Invalid := (le.ScrubsBits4 >> 3) & 1;
    SELF.mail_geo_long_Invalid := (le.ScrubsBits4 >> 4) & 1;
    SELF.mail_msa_Invalid := (le.ScrubsBits4 >> 5) & 1;
    SELF.mail_geo_blk_Invalid := (le.ScrubsBits4 >> 6) & 1;
    SELF.mail_geo_match_Invalid := (le.ScrubsBits4 >> 7) & 1;
    SELF.mail_err_stat_Invalid := (le.ScrubsBits4 >> 8) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    score_ALLOW_ErrorCount := COUNT(GROUP,h.score_Invalid=1);
    best_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=1);
    did_out_ALLOW_ErrorCount := COUNT(GROUP,h.did_out_Invalid=1);
    file_id_ALLOW_ErrorCount := COUNT(GROUP,h.file_id_Invalid=1);
    source_state_ALLOW_ErrorCount := COUNT(GROUP,h.source_state_Invalid=1);
    source_state_LENGTHS_ErrorCount := COUNT(GROUP,h.source_state_Invalid=2);
    source_state_Total_ErrorCount := COUNT(GROUP,h.source_state_Invalid>0);
    source_code_ALLOW_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    file_acquired_date_CUSTOM_ErrorCount := COUNT(GROUP,h.file_acquired_date_Invalid=1);
    _use_ALLOW_ErrorCount := COUNT(GROUP,h._use_Invalid=1);
    title_in_ALLOW_ErrorCount := COUNT(GROUP,h.title_in_Invalid=1);
    lname_in_ALLOW_ErrorCount := COUNT(GROUP,h.lname_in_Invalid=1);
    fname_in_ALLOW_ErrorCount := COUNT(GROUP,h.fname_in_Invalid=1);
    mname_in_ALLOW_ErrorCount := COUNT(GROUP,h.mname_in_Invalid=1);
    maiden_prior_ALLOW_ErrorCount := COUNT(GROUP,h.maiden_prior_Invalid=1);
    name_suffix_in_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_in_Invalid=1);
    source_voterid_ALLOW_ErrorCount := COUNT(GROUP,h.source_voterid_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    agecat_ALLOW_ErrorCount := COUNT(GROUP,h.agecat_Invalid=1);
    headhousehold_ALLOW_ErrorCount := COUNT(GROUP,h.headhousehold_Invalid=1);
    place_of_birth_CUSTOM_ErrorCount := COUNT(GROUP,h.place_of_birth_Invalid=1);
    occupation_ALLOW_ErrorCount := COUNT(GROUP,h.occupation_Invalid=1);
    maiden_name_ALLOW_ErrorCount := COUNT(GROUP,h.maiden_name_Invalid=1);
    motorvoterid_ALLOW_ErrorCount := COUNT(GROUP,h.motorvoterid_Invalid=1);
    regsource_ALLOW_ErrorCount := COUNT(GROUP,h.regsource_Invalid=1);
    regdate_CUSTOM_ErrorCount := COUNT(GROUP,h.regdate_Invalid=1);
    race_ALLOW_ErrorCount := COUNT(GROUP,h.race_Invalid=1);
    gender_ALLOW_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    poliparty_ALLOW_ErrorCount := COUNT(GROUP,h.poliparty_Invalid=1);
    poliparty_mapped_ALLOW_ErrorCount := COUNT(GROUP,h.poliparty_mapped_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    work_phone_ALLOW_ErrorCount := COUNT(GROUP,h.work_phone_Invalid=1);
    other_phone_ALLOW_ErrorCount := COUNT(GROUP,h.other_phone_Invalid=1);
    active_status_ALLOW_ErrorCount := COUNT(GROUP,h.active_status_Invalid=1);
    active_status_mapped_ALLOW_ErrorCount := COUNT(GROUP,h.active_status_mapped_Invalid=1);
    active_other_ALLOW_ErrorCount := COUNT(GROUP,h.active_other_Invalid=1);
    voterstatus_ALLOW_ErrorCount := COUNT(GROUP,h.voterstatus_Invalid=1);
    voterstatus_mapped_ALLOW_ErrorCount := COUNT(GROUP,h.voterstatus_mapped_Invalid=1);
    resaddr1_ALLOW_ErrorCount := COUNT(GROUP,h.resaddr1_Invalid=1);
    resaddr2_ALLOW_ErrorCount := COUNT(GROUP,h.resaddr2_Invalid=1);
    res_city_ALLOW_ErrorCount := COUNT(GROUP,h.res_city_Invalid=1);
    res_state_ALLOW_ErrorCount := COUNT(GROUP,h.res_state_Invalid=1);
    res_state_LENGTHS_ErrorCount := COUNT(GROUP,h.res_state_Invalid=2);
    res_state_Total_ErrorCount := COUNT(GROUP,h.res_state_Invalid>0);
    res_zip_ALLOW_ErrorCount := COUNT(GROUP,h.res_zip_Invalid=1);
    res_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.res_zip_Invalid=2);
    res_zip_Total_ErrorCount := COUNT(GROUP,h.res_zip_Invalid>0);
    res_county_ALLOW_ErrorCount := COUNT(GROUP,h.res_county_Invalid=1);
    mail_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.mail_addr1_Invalid=1);
    mail_addr2_ALLOW_ErrorCount := COUNT(GROUP,h.mail_addr2_Invalid=1);
    mail_city_ALLOW_ErrorCount := COUNT(GROUP,h.mail_city_Invalid=1);
    mail_state_ALLOW_ErrorCount := COUNT(GROUP,h.mail_state_Invalid=1);
    mail_state_LENGTHS_ErrorCount := COUNT(GROUP,h.mail_state_Invalid=2);
    mail_state_Total_ErrorCount := COUNT(GROUP,h.mail_state_Invalid>0);
    mail_zip_ALLOW_ErrorCount := COUNT(GROUP,h.mail_zip_Invalid=1);
    mail_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.mail_zip_Invalid=2);
    mail_zip_Total_ErrorCount := COUNT(GROUP,h.mail_zip_Invalid>0);
    mail_county_ALLOW_ErrorCount := COUNT(GROUP,h.mail_county_Invalid=1);
    towncode_ALLOW_ErrorCount := COUNT(GROUP,h.towncode_Invalid=1);
    distcode_ALLOW_ErrorCount := COUNT(GROUP,h.distcode_Invalid=1);
    countycode_ALLOW_ErrorCount := COUNT(GROUP,h.countycode_Invalid=1);
    schoolcode_ALLOW_ErrorCount := COUNT(GROUP,h.schoolcode_Invalid=1);
    cityinout_ALLOW_ErrorCount := COUNT(GROUP,h.cityinout_Invalid=1);
    spec_dist1_ALLOW_ErrorCount := COUNT(GROUP,h.spec_dist1_Invalid=1);
    spec_dist2_ALLOW_ErrorCount := COUNT(GROUP,h.spec_dist2_Invalid=1);
    precinct1_ALLOW_ErrorCount := COUNT(GROUP,h.precinct1_Invalid=1);
    precinct2_ALLOW_ErrorCount := COUNT(GROUP,h.precinct2_Invalid=1);
    precinct3_ALLOW_ErrorCount := COUNT(GROUP,h.precinct3_Invalid=1);
    villageprecinct_ALLOW_ErrorCount := COUNT(GROUP,h.villageprecinct_Invalid=1);
    schoolprecinct_ALLOW_ErrorCount := COUNT(GROUP,h.schoolprecinct_Invalid=1);
    ward_ALLOW_ErrorCount := COUNT(GROUP,h.ward_Invalid=1);
    precinct_citytown_ALLOW_ErrorCount := COUNT(GROUP,h.precinct_citytown_Invalid=1);
    ancsmdindc_ALLOW_ErrorCount := COUNT(GROUP,h.ancsmdindc_Invalid=1);
    citycouncildist_ALLOW_ErrorCount := COUNT(GROUP,h.citycouncildist_Invalid=1);
    countycommdist_ALLOW_ErrorCount := COUNT(GROUP,h.countycommdist_Invalid=1);
    statehouse_ALLOW_ErrorCount := COUNT(GROUP,h.statehouse_Invalid=1);
    statesenate_ALLOW_ErrorCount := COUNT(GROUP,h.statesenate_Invalid=1);
    ushouse_ALLOW_ErrorCount := COUNT(GROUP,h.ushouse_Invalid=1);
    elemschooldist_ALLOW_ErrorCount := COUNT(GROUP,h.elemschooldist_Invalid=1);
    schooldist_ALLOW_ErrorCount := COUNT(GROUP,h.schooldist_Invalid=1);
    commcolldist_ALLOW_ErrorCount := COUNT(GROUP,h.commcolldist_Invalid=1);
    municipal_ALLOW_ErrorCount := COUNT(GROUP,h.municipal_Invalid=1);
    villagedist_ALLOW_ErrorCount := COUNT(GROUP,h.villagedist_Invalid=1);
    policejury_ALLOW_ErrorCount := COUNT(GROUP,h.policejury_Invalid=1);
    policedist_ALLOW_ErrorCount := COUNT(GROUP,h.policedist_Invalid=1);
    publicservcomm_ALLOW_ErrorCount := COUNT(GROUP,h.publicservcomm_Invalid=1);
    rescue_ALLOW_ErrorCount := COUNT(GROUP,h.rescue_Invalid=1);
    fire_ALLOW_ErrorCount := COUNT(GROUP,h.fire_Invalid=1);
    sanitary_ALLOW_ErrorCount := COUNT(GROUP,h.sanitary_Invalid=1);
    sewerdist_ALLOW_ErrorCount := COUNT(GROUP,h.sewerdist_Invalid=1);
    waterdist_ALLOW_ErrorCount := COUNT(GROUP,h.waterdist_Invalid=1);
    mosquitodist_ALLOW_ErrorCount := COUNT(GROUP,h.mosquitodist_Invalid=1);
    taxdist_ALLOW_ErrorCount := COUNT(GROUP,h.taxdist_Invalid=1);
    supremecourt_ALLOW_ErrorCount := COUNT(GROUP,h.supremecourt_Invalid=1);
    justiceofpeace_ALLOW_ErrorCount := COUNT(GROUP,h.justiceofpeace_Invalid=1);
    judicialdist_ALLOW_ErrorCount := COUNT(GROUP,h.judicialdist_Invalid=1);
    superiorctdist_ALLOW_ErrorCount := COUNT(GROUP,h.superiorctdist_Invalid=1);
    appealsct_ALLOW_ErrorCount := COUNT(GROUP,h.appealsct_Invalid=1);
    contributorparty_ALLOW_ErrorCount := COUNT(GROUP,h.contributorparty_Invalid=1);
    recptparty_ALLOW_ErrorCount := COUNT(GROUP,h.recptparty_Invalid=1);
    dateofcontr_CUSTOM_ErrorCount := COUNT(GROUP,h.dateofcontr_Invalid=1);
    dollaramt_ALLOW_ErrorCount := COUNT(GROUP,h.dollaramt_Invalid=1);
    primary02_ALLOW_ErrorCount := COUNT(GROUP,h.primary02_Invalid=1);
    special02_ALLOW_ErrorCount := COUNT(GROUP,h.special02_Invalid=1);
    other02_ALLOW_ErrorCount := COUNT(GROUP,h.other02_Invalid=1);
    special202_ALLOW_ErrorCount := COUNT(GROUP,h.special202_Invalid=1);
    general02_ALLOW_ErrorCount := COUNT(GROUP,h.general02_Invalid=1);
    primary01_ALLOW_ErrorCount := COUNT(GROUP,h.primary01_Invalid=1);
    special01_ALLOW_ErrorCount := COUNT(GROUP,h.special01_Invalid=1);
    other01_ALLOW_ErrorCount := COUNT(GROUP,h.other01_Invalid=1);
    special201_ALLOW_ErrorCount := COUNT(GROUP,h.special201_Invalid=1);
    general01_ALLOW_ErrorCount := COUNT(GROUP,h.general01_Invalid=1);
    pres00_ALLOW_ErrorCount := COUNT(GROUP,h.pres00_Invalid=1);
    primary00_ALLOW_ErrorCount := COUNT(GROUP,h.primary00_Invalid=1);
    special00_ALLOW_ErrorCount := COUNT(GROUP,h.special00_Invalid=1);
    other00_ALLOW_ErrorCount := COUNT(GROUP,h.other00_Invalid=1);
    special200_ALLOW_ErrorCount := COUNT(GROUP,h.special200_Invalid=1);
    general00_ALLOW_ErrorCount := COUNT(GROUP,h.general00_Invalid=1);
    primary99_ALLOW_ErrorCount := COUNT(GROUP,h.primary99_Invalid=1);
    special99_ALLOW_ErrorCount := COUNT(GROUP,h.special99_Invalid=1);
    other99_ALLOW_ErrorCount := COUNT(GROUP,h.other99_Invalid=1);
    special299_ALLOW_ErrorCount := COUNT(GROUP,h.special299_Invalid=1);
    general99_ALLOW_ErrorCount := COUNT(GROUP,h.general99_Invalid=1);
    primary98_ALLOW_ErrorCount := COUNT(GROUP,h.primary98_Invalid=1);
    special98_ALLOW_ErrorCount := COUNT(GROUP,h.special98_Invalid=1);
    other98_ALLOW_ErrorCount := COUNT(GROUP,h.other98_Invalid=1);
    special298_ALLOW_ErrorCount := COUNT(GROUP,h.special298_Invalid=1);
    general98_ALLOW_ErrorCount := COUNT(GROUP,h.general98_Invalid=1);
    primary97_ALLOW_ErrorCount := COUNT(GROUP,h.primary97_Invalid=1);
    special97_ALLOW_ErrorCount := COUNT(GROUP,h.special97_Invalid=1);
    other97_ALLOW_ErrorCount := COUNT(GROUP,h.other97_Invalid=1);
    special297_ALLOW_ErrorCount := COUNT(GROUP,h.special297_Invalid=1);
    general97_ALLOW_ErrorCount := COUNT(GROUP,h.general97_Invalid=1);
    pres96_ALLOW_ErrorCount := COUNT(GROUP,h.pres96_Invalid=1);
    primary96_ALLOW_ErrorCount := COUNT(GROUP,h.primary96_Invalid=1);
    special96_ALLOW_ErrorCount := COUNT(GROUP,h.special96_Invalid=1);
    other96_ALLOW_ErrorCount := COUNT(GROUP,h.other96_Invalid=1);
    special296_ALLOW_ErrorCount := COUNT(GROUP,h.special296_Invalid=1);
    general96_ALLOW_ErrorCount := COUNT(GROUP,h.general96_Invalid=1);
    lastdayvote_CUSTOM_ErrorCount := COUNT(GROUP,h.lastdayvote_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    score_on_input_ALLOW_ErrorCount := COUNT(GROUP,h.score_on_input_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    city_name_ALLOW_ErrorCount := COUNT(GROUP,h.city_name_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.dpbc_Invalid=1);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    county_name_ALLOW_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    mail_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.mail_prim_range_Invalid=1);
    mail_predir_ALLOW_ErrorCount := COUNT(GROUP,h.mail_predir_Invalid=1);
    mail_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.mail_prim_name_Invalid=1);
    mail_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.mail_addr_suffix_Invalid=1);
    mail_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.mail_postdir_Invalid=1);
    mail_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.mail_unit_desig_Invalid=1);
    mail_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.mail_sec_range_Invalid=1);
    mail_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.mail_p_city_name_Invalid=1);
    mail_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.mail_v_city_name_Invalid=1);
    mail_st_ALLOW_ErrorCount := COUNT(GROUP,h.mail_st_Invalid=1);
    mail_ace_zip_ALLOW_ErrorCount := COUNT(GROUP,h.mail_ace_zip_Invalid=1);
    mail_ace_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.mail_ace_zip_Invalid=2);
    mail_ace_zip_Total_ErrorCount := COUNT(GROUP,h.mail_ace_zip_Invalid>0);
    mail_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.mail_zip4_Invalid=1);
    mail_cart_ALLOW_ErrorCount := COUNT(GROUP,h.mail_cart_Invalid=1);
    mail_cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.mail_cr_sort_sz_Invalid=1);
    mail_lot_ALLOW_ErrorCount := COUNT(GROUP,h.mail_lot_Invalid=1);
    mail_lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.mail_lot_order_Invalid=1);
    mail_dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.mail_dpbc_Invalid=1);
    mail_chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.mail_chk_digit_Invalid=1);
    mail_record_type_ALLOW_ErrorCount := COUNT(GROUP,h.mail_record_type_Invalid=1);
    mail_ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.mail_ace_fips_st_Invalid=1);
    mail_fipscounty_ALLOW_ErrorCount := COUNT(GROUP,h.mail_fipscounty_Invalid=1);
    mail_geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.mail_geo_lat_Invalid=1);
    mail_geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.mail_geo_long_Invalid=1);
    mail_msa_ALLOW_ErrorCount := COUNT(GROUP,h.mail_msa_Invalid=1);
    mail_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.mail_geo_blk_Invalid=1);
    mail_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.mail_geo_match_Invalid=1);
    mail_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.mail_err_stat_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.score_Invalid > 0 OR h.best_ssn_Invalid > 0 OR h.did_out_Invalid > 0 OR h.file_id_Invalid > 0 OR h.source_state_Invalid > 0 OR h.source_code_Invalid > 0 OR h.file_acquired_date_Invalid > 0 OR h._use_Invalid > 0 OR h.title_in_Invalid > 0 OR h.lname_in_Invalid > 0 OR h.fname_in_Invalid > 0 OR h.mname_in_Invalid > 0 OR h.maiden_prior_Invalid > 0 OR h.name_suffix_in_Invalid > 0 OR h.source_voterid_Invalid > 0 OR h.dob_Invalid > 0 OR h.agecat_Invalid > 0 OR h.headhousehold_Invalid > 0 OR h.place_of_birth_Invalid > 0 OR h.occupation_Invalid > 0 OR h.maiden_name_Invalid > 0 OR h.motorvoterid_Invalid > 0 OR h.regsource_Invalid > 0 OR h.regdate_Invalid > 0 OR h.race_Invalid > 0 OR h.gender_Invalid > 0 OR h.poliparty_Invalid > 0 OR h.poliparty_mapped_Invalid > 0 OR h.phone_Invalid > 0 OR h.work_phone_Invalid > 0 OR h.other_phone_Invalid > 0 OR h.active_status_Invalid > 0 OR h.active_status_mapped_Invalid > 0 OR h.active_other_Invalid > 0 OR h.voterstatus_Invalid > 0 OR h.voterstatus_mapped_Invalid > 0 OR h.resaddr1_Invalid > 0 OR h.resaddr2_Invalid > 0 OR h.res_city_Invalid > 0 OR h.res_state_Invalid > 0 OR h.res_zip_Invalid > 0 OR h.res_county_Invalid > 0 OR h.mail_addr1_Invalid > 0 OR h.mail_addr2_Invalid > 0 OR h.mail_city_Invalid > 0 OR h.mail_state_Invalid > 0 OR h.mail_zip_Invalid > 0 OR h.mail_county_Invalid > 0 OR h.towncode_Invalid > 0 OR h.distcode_Invalid > 0 OR h.countycode_Invalid > 0 OR h.schoolcode_Invalid > 0 OR h.cityinout_Invalid > 0 OR h.spec_dist1_Invalid > 0 OR h.spec_dist2_Invalid > 0 OR h.precinct1_Invalid > 0 OR h.precinct2_Invalid > 0 OR h.precinct3_Invalid > 0 OR h.villageprecinct_Invalid > 0 OR h.schoolprecinct_Invalid > 0 OR h.ward_Invalid > 0 OR h.precinct_citytown_Invalid > 0 OR h.ancsmdindc_Invalid > 0 OR h.citycouncildist_Invalid > 0 OR h.countycommdist_Invalid > 0 OR h.statehouse_Invalid > 0 OR h.statesenate_Invalid > 0 OR h.ushouse_Invalid > 0 OR h.elemschooldist_Invalid > 0 OR h.schooldist_Invalid > 0 OR h.commcolldist_Invalid > 0 OR h.municipal_Invalid > 0 OR h.villagedist_Invalid > 0 OR h.policejury_Invalid > 0 OR h.policedist_Invalid > 0 OR h.publicservcomm_Invalid > 0 OR h.rescue_Invalid > 0 OR h.fire_Invalid > 0 OR h.sanitary_Invalid > 0 OR h.sewerdist_Invalid > 0 OR h.waterdist_Invalid > 0 OR h.mosquitodist_Invalid > 0 OR h.taxdist_Invalid > 0 OR h.supremecourt_Invalid > 0 OR h.justiceofpeace_Invalid > 0 OR h.judicialdist_Invalid > 0 OR h.superiorctdist_Invalid > 0 OR h.appealsct_Invalid > 0 OR h.contributorparty_Invalid > 0 OR h.recptparty_Invalid > 0 OR h.dateofcontr_Invalid > 0 OR h.dollaramt_Invalid > 0 OR h.primary02_Invalid > 0 OR h.special02_Invalid > 0 OR h.other02_Invalid > 0 OR h.special202_Invalid > 0 OR h.general02_Invalid > 0 OR h.primary01_Invalid > 0 OR h.special01_Invalid > 0 OR h.other01_Invalid > 0 OR h.special201_Invalid > 0 OR h.general01_Invalid > 0 OR h.pres00_Invalid > 0 OR h.primary00_Invalid > 0 OR h.special00_Invalid > 0 OR h.other00_Invalid > 0 OR h.special200_Invalid > 0 OR h.general00_Invalid > 0 OR h.primary99_Invalid > 0 OR h.special99_Invalid > 0 OR h.other99_Invalid > 0 OR h.special299_Invalid > 0 OR h.general99_Invalid > 0 OR h.primary98_Invalid > 0 OR h.special98_Invalid > 0 OR h.other98_Invalid > 0 OR h.special298_Invalid > 0 OR h.general98_Invalid > 0 OR h.primary97_Invalid > 0 OR h.special97_Invalid > 0 OR h.other97_Invalid > 0 OR h.special297_Invalid > 0 OR h.general97_Invalid > 0 OR h.pres96_Invalid > 0 OR h.primary96_Invalid > 0 OR h.special96_Invalid > 0 OR h.other96_Invalid > 0 OR h.special296_Invalid > 0 OR h.general96_Invalid > 0 OR h.lastdayvote_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.score_on_input_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dpbc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.record_type_Invalid > 0 OR h.ace_fips_st_Invalid > 0 OR h.county_Invalid > 0 OR h.county_name_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.mail_prim_range_Invalid > 0 OR h.mail_predir_Invalid > 0 OR h.mail_prim_name_Invalid > 0 OR h.mail_addr_suffix_Invalid > 0 OR h.mail_postdir_Invalid > 0 OR h.mail_unit_desig_Invalid > 0 OR h.mail_sec_range_Invalid > 0 OR h.mail_p_city_name_Invalid > 0 OR h.mail_v_city_name_Invalid > 0 OR h.mail_st_Invalid > 0 OR h.mail_ace_zip_Invalid > 0 OR h.mail_zip4_Invalid > 0 OR h.mail_cart_Invalid > 0 OR h.mail_cr_sort_sz_Invalid > 0 OR h.mail_lot_Invalid > 0 OR h.mail_lot_order_Invalid > 0 OR h.mail_dpbc_Invalid > 0 OR h.mail_chk_digit_Invalid > 0 OR h.mail_record_type_Invalid > 0 OR h.mail_ace_fips_st_Invalid > 0 OR h.mail_fipscounty_Invalid > 0 OR h.mail_geo_lat_Invalid > 0 OR h.mail_geo_long_Invalid > 0 OR h.mail_msa_Invalid > 0 OR h.mail_geo_blk_Invalid > 0 OR h.mail_geo_match_Invalid > 0 OR h.mail_err_stat_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_state_Total_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_acquired_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le._use_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_prior_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_voterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.agecat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.headhousehold_ALLOW_ErrorCount > 0, 1, 0) + IF(le.place_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.occupation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.motorvoterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regsource_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.race_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.poliparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.poliparty_mapped_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.work_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_mapped_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voterstatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voterstatus_mapped_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_state_Total_ErrorCount > 0, 1, 0) + IF(le.res_zip_Total_ErrorCount > 0, 1, 0) + IF(le.res_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_state_Total_ErrorCount > 0, 1, 0) + IF(le.mail_zip_Total_ErrorCount > 0, 1, 0) + IF(le.mail_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.towncode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.distcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countycode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schoolcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cityinout_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spec_dist1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spec_dist2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.villageprecinct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schoolprecinct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ward_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct_citytown_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ancsmdindc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.citycouncildist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countycommdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statehouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statesenate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ushouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.elemschooldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schooldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.commcolldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.municipal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.villagedist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policejury_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policedist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicservcomm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rescue_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fire_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sanitary_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sewerdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.waterdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mosquitodist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.taxdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.supremecourt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.justiceofpeace_ALLOW_ErrorCount > 0, 1, 0) + IF(le.judicialdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.superiorctdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.appealsct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contributorparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recptparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateofcontr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dollaramt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special202_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special201_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pres00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special200_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special299_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special298_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special297_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pres96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special296_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdayvote_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.score_on_input_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_Total_ErrorCount > 0, 1, 0) + IF(le.mail_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_err_stat_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_acquired_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le._use_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_prior_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_voterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.agecat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.headhousehold_ALLOW_ErrorCount > 0, 1, 0) + IF(le.place_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.occupation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.motorvoterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regsource_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.race_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.poliparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.poliparty_mapped_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.work_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_mapped_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voterstatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voterstatus_mapped_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.res_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.res_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mail_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mail_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.towncode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.distcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countycode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schoolcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cityinout_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spec_dist1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spec_dist2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.villageprecinct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schoolprecinct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ward_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct_citytown_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ancsmdindc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.citycouncildist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countycommdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statehouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statesenate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ushouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.elemschooldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schooldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.commcolldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.municipal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.villagedist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policejury_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policedist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicservcomm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rescue_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fire_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sanitary_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sewerdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.waterdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mosquitodist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.taxdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.supremecourt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.justiceofpeace_ALLOW_ErrorCount > 0, 1, 0) + IF(le.judicialdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.superiorctdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.appealsct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contributorparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recptparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateofcontr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dollaramt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special202_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special201_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pres00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special200_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special299_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special298_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special297_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pres96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special296_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdayvote_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.score_on_input_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mail_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_err_stat_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.score_Invalid,le.best_ssn_Invalid,le.did_out_Invalid,le.file_id_Invalid,le.source_state_Invalid,le.source_code_Invalid,le.file_acquired_date_Invalid,le._use_Invalid,le.title_in_Invalid,le.lname_in_Invalid,le.fname_in_Invalid,le.mname_in_Invalid,le.maiden_prior_Invalid,le.name_suffix_in_Invalid,le.source_voterid_Invalid,le.dob_Invalid,le.agecat_Invalid,le.headhousehold_Invalid,le.place_of_birth_Invalid,le.occupation_Invalid,le.maiden_name_Invalid,le.motorvoterid_Invalid,le.regsource_Invalid,le.regdate_Invalid,le.race_Invalid,le.gender_Invalid,le.poliparty_Invalid,le.poliparty_mapped_Invalid,le.phone_Invalid,le.work_phone_Invalid,le.other_phone_Invalid,le.active_status_Invalid,le.active_status_mapped_Invalid,le.active_other_Invalid,le.voterstatus_Invalid,le.voterstatus_mapped_Invalid,le.resaddr1_Invalid,le.resaddr2_Invalid,le.res_city_Invalid,le.res_state_Invalid,le.res_zip_Invalid,le.res_county_Invalid,le.mail_addr1_Invalid,le.mail_addr2_Invalid,le.mail_city_Invalid,le.mail_state_Invalid,le.mail_zip_Invalid,le.mail_county_Invalid,le.towncode_Invalid,le.distcode_Invalid,le.countycode_Invalid,le.schoolcode_Invalid,le.cityinout_Invalid,le.spec_dist1_Invalid,le.spec_dist2_Invalid,le.precinct1_Invalid,le.precinct2_Invalid,le.precinct3_Invalid,le.villageprecinct_Invalid,le.schoolprecinct_Invalid,le.ward_Invalid,le.precinct_citytown_Invalid,le.ancsmdindc_Invalid,le.citycouncildist_Invalid,le.countycommdist_Invalid,le.statehouse_Invalid,le.statesenate_Invalid,le.ushouse_Invalid,le.elemschooldist_Invalid,le.schooldist_Invalid,le.commcolldist_Invalid,le.municipal_Invalid,le.villagedist_Invalid,le.policejury_Invalid,le.policedist_Invalid,le.publicservcomm_Invalid,le.rescue_Invalid,le.fire_Invalid,le.sanitary_Invalid,le.sewerdist_Invalid,le.waterdist_Invalid,le.mosquitodist_Invalid,le.taxdist_Invalid,le.supremecourt_Invalid,le.justiceofpeace_Invalid,le.judicialdist_Invalid,le.superiorctdist_Invalid,le.appealsct_Invalid,le.contributorparty_Invalid,le.recptparty_Invalid,le.dateofcontr_Invalid,le.dollaramt_Invalid,le.primary02_Invalid,le.special02_Invalid,le.other02_Invalid,le.special202_Invalid,le.general02_Invalid,le.primary01_Invalid,le.special01_Invalid,le.other01_Invalid,le.special201_Invalid,le.general01_Invalid,le.pres00_Invalid,le.primary00_Invalid,le.special00_Invalid,le.other00_Invalid,le.special200_Invalid,le.general00_Invalid,le.primary99_Invalid,le.special99_Invalid,le.other99_Invalid,le.special299_Invalid,le.general99_Invalid,le.primary98_Invalid,le.special98_Invalid,le.other98_Invalid,le.special298_Invalid,le.general98_Invalid,le.primary97_Invalid,le.special97_Invalid,le.other97_Invalid,le.special297_Invalid,le.general97_Invalid,le.pres96_Invalid,le.primary96_Invalid,le.special96_Invalid,le.other96_Invalid,le.special296_Invalid,le.general96_Invalid,le.lastdayvote_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.score_on_input_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.record_type_Invalid,le.ace_fips_st_Invalid,le.county_Invalid,le.county_name_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.mail_prim_range_Invalid,le.mail_predir_Invalid,le.mail_prim_name_Invalid,le.mail_addr_suffix_Invalid,le.mail_postdir_Invalid,le.mail_unit_desig_Invalid,le.mail_sec_range_Invalid,le.mail_p_city_name_Invalid,le.mail_v_city_name_Invalid,le.mail_st_Invalid,le.mail_ace_zip_Invalid,le.mail_zip4_Invalid,le.mail_cart_Invalid,le.mail_cr_sort_sz_Invalid,le.mail_lot_Invalid,le.mail_lot_order_Invalid,le.mail_dpbc_Invalid,le.mail_chk_digit_Invalid,le.mail_record_type_Invalid,le.mail_ace_fips_st_Invalid,le.mail_fipscounty_Invalid,le.mail_geo_lat_Invalid,le.mail_geo_long_Invalid,le.mail_msa_Invalid,le.mail_geo_blk_Invalid,le.mail_geo_match_Invalid,le.mail_err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Voters_Fields.InvalidMessage_process_date(le.process_date_Invalid),Voters_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Voters_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Voters_Fields.InvalidMessage_score(le.score_Invalid),Voters_Fields.InvalidMessage_best_ssn(le.best_ssn_Invalid),Voters_Fields.InvalidMessage_did_out(le.did_out_Invalid),Voters_Fields.InvalidMessage_file_id(le.file_id_Invalid),Voters_Fields.InvalidMessage_source_state(le.source_state_Invalid),Voters_Fields.InvalidMessage_source_code(le.source_code_Invalid),Voters_Fields.InvalidMessage_file_acquired_date(le.file_acquired_date_Invalid),Voters_Fields.InvalidMessage__use(le._use_Invalid),Voters_Fields.InvalidMessage_title_in(le.title_in_Invalid),Voters_Fields.InvalidMessage_lname_in(le.lname_in_Invalid),Voters_Fields.InvalidMessage_fname_in(le.fname_in_Invalid),Voters_Fields.InvalidMessage_mname_in(le.mname_in_Invalid),Voters_Fields.InvalidMessage_maiden_prior(le.maiden_prior_Invalid),Voters_Fields.InvalidMessage_name_suffix_in(le.name_suffix_in_Invalid),Voters_Fields.InvalidMessage_source_voterid(le.source_voterid_Invalid),Voters_Fields.InvalidMessage_dob(le.dob_Invalid),Voters_Fields.InvalidMessage_agecat(le.agecat_Invalid),Voters_Fields.InvalidMessage_headhousehold(le.headhousehold_Invalid),Voters_Fields.InvalidMessage_place_of_birth(le.place_of_birth_Invalid),Voters_Fields.InvalidMessage_occupation(le.occupation_Invalid),Voters_Fields.InvalidMessage_maiden_name(le.maiden_name_Invalid),Voters_Fields.InvalidMessage_motorvoterid(le.motorvoterid_Invalid),Voters_Fields.InvalidMessage_regsource(le.regsource_Invalid),Voters_Fields.InvalidMessage_regdate(le.regdate_Invalid),Voters_Fields.InvalidMessage_race(le.race_Invalid),Voters_Fields.InvalidMessage_gender(le.gender_Invalid),Voters_Fields.InvalidMessage_poliparty(le.poliparty_Invalid),Voters_Fields.InvalidMessage_poliparty_mapped(le.poliparty_mapped_Invalid),Voters_Fields.InvalidMessage_phone(le.phone_Invalid),Voters_Fields.InvalidMessage_work_phone(le.work_phone_Invalid),Voters_Fields.InvalidMessage_other_phone(le.other_phone_Invalid),Voters_Fields.InvalidMessage_active_status(le.active_status_Invalid),Voters_Fields.InvalidMessage_active_status_mapped(le.active_status_mapped_Invalid),Voters_Fields.InvalidMessage_active_other(le.active_other_Invalid),Voters_Fields.InvalidMessage_voterstatus(le.voterstatus_Invalid),Voters_Fields.InvalidMessage_voterstatus_mapped(le.voterstatus_mapped_Invalid),Voters_Fields.InvalidMessage_resaddr1(le.resaddr1_Invalid),Voters_Fields.InvalidMessage_resaddr2(le.resaddr2_Invalid),Voters_Fields.InvalidMessage_res_city(le.res_city_Invalid),Voters_Fields.InvalidMessage_res_state(le.res_state_Invalid),Voters_Fields.InvalidMessage_res_zip(le.res_zip_Invalid),Voters_Fields.InvalidMessage_res_county(le.res_county_Invalid),Voters_Fields.InvalidMessage_mail_addr1(le.mail_addr1_Invalid),Voters_Fields.InvalidMessage_mail_addr2(le.mail_addr2_Invalid),Voters_Fields.InvalidMessage_mail_city(le.mail_city_Invalid),Voters_Fields.InvalidMessage_mail_state(le.mail_state_Invalid),Voters_Fields.InvalidMessage_mail_zip(le.mail_zip_Invalid),Voters_Fields.InvalidMessage_mail_county(le.mail_county_Invalid),Voters_Fields.InvalidMessage_towncode(le.towncode_Invalid),Voters_Fields.InvalidMessage_distcode(le.distcode_Invalid),Voters_Fields.InvalidMessage_countycode(le.countycode_Invalid),Voters_Fields.InvalidMessage_schoolcode(le.schoolcode_Invalid),Voters_Fields.InvalidMessage_cityinout(le.cityinout_Invalid),Voters_Fields.InvalidMessage_spec_dist1(le.spec_dist1_Invalid),Voters_Fields.InvalidMessage_spec_dist2(le.spec_dist2_Invalid),Voters_Fields.InvalidMessage_precinct1(le.precinct1_Invalid),Voters_Fields.InvalidMessage_precinct2(le.precinct2_Invalid),Voters_Fields.InvalidMessage_precinct3(le.precinct3_Invalid),Voters_Fields.InvalidMessage_villageprecinct(le.villageprecinct_Invalid),Voters_Fields.InvalidMessage_schoolprecinct(le.schoolprecinct_Invalid),Voters_Fields.InvalidMessage_ward(le.ward_Invalid),Voters_Fields.InvalidMessage_precinct_citytown(le.precinct_citytown_Invalid),Voters_Fields.InvalidMessage_ancsmdindc(le.ancsmdindc_Invalid),Voters_Fields.InvalidMessage_citycouncildist(le.citycouncildist_Invalid),Voters_Fields.InvalidMessage_countycommdist(le.countycommdist_Invalid),Voters_Fields.InvalidMessage_statehouse(le.statehouse_Invalid),Voters_Fields.InvalidMessage_statesenate(le.statesenate_Invalid),Voters_Fields.InvalidMessage_ushouse(le.ushouse_Invalid),Voters_Fields.InvalidMessage_elemschooldist(le.elemschooldist_Invalid),Voters_Fields.InvalidMessage_schooldist(le.schooldist_Invalid),Voters_Fields.InvalidMessage_commcolldist(le.commcolldist_Invalid),Voters_Fields.InvalidMessage_municipal(le.municipal_Invalid),Voters_Fields.InvalidMessage_villagedist(le.villagedist_Invalid),Voters_Fields.InvalidMessage_policejury(le.policejury_Invalid),Voters_Fields.InvalidMessage_policedist(le.policedist_Invalid),Voters_Fields.InvalidMessage_publicservcomm(le.publicservcomm_Invalid),Voters_Fields.InvalidMessage_rescue(le.rescue_Invalid),Voters_Fields.InvalidMessage_fire(le.fire_Invalid),Voters_Fields.InvalidMessage_sanitary(le.sanitary_Invalid),Voters_Fields.InvalidMessage_sewerdist(le.sewerdist_Invalid),Voters_Fields.InvalidMessage_waterdist(le.waterdist_Invalid),Voters_Fields.InvalidMessage_mosquitodist(le.mosquitodist_Invalid),Voters_Fields.InvalidMessage_taxdist(le.taxdist_Invalid),Voters_Fields.InvalidMessage_supremecourt(le.supremecourt_Invalid),Voters_Fields.InvalidMessage_justiceofpeace(le.justiceofpeace_Invalid),Voters_Fields.InvalidMessage_judicialdist(le.judicialdist_Invalid),Voters_Fields.InvalidMessage_superiorctdist(le.superiorctdist_Invalid),Voters_Fields.InvalidMessage_appealsct(le.appealsct_Invalid),Voters_Fields.InvalidMessage_contributorparty(le.contributorparty_Invalid),Voters_Fields.InvalidMessage_recptparty(le.recptparty_Invalid),Voters_Fields.InvalidMessage_dateofcontr(le.dateofcontr_Invalid),Voters_Fields.InvalidMessage_dollaramt(le.dollaramt_Invalid),Voters_Fields.InvalidMessage_primary02(le.primary02_Invalid),Voters_Fields.InvalidMessage_special02(le.special02_Invalid),Voters_Fields.InvalidMessage_other02(le.other02_Invalid),Voters_Fields.InvalidMessage_special202(le.special202_Invalid),Voters_Fields.InvalidMessage_general02(le.general02_Invalid),Voters_Fields.InvalidMessage_primary01(le.primary01_Invalid),Voters_Fields.InvalidMessage_special01(le.special01_Invalid),Voters_Fields.InvalidMessage_other01(le.other01_Invalid),Voters_Fields.InvalidMessage_special201(le.special201_Invalid),Voters_Fields.InvalidMessage_general01(le.general01_Invalid),Voters_Fields.InvalidMessage_pres00(le.pres00_Invalid),Voters_Fields.InvalidMessage_primary00(le.primary00_Invalid),Voters_Fields.InvalidMessage_special00(le.special00_Invalid),Voters_Fields.InvalidMessage_other00(le.other00_Invalid),Voters_Fields.InvalidMessage_special200(le.special200_Invalid),Voters_Fields.InvalidMessage_general00(le.general00_Invalid),Voters_Fields.InvalidMessage_primary99(le.primary99_Invalid),Voters_Fields.InvalidMessage_special99(le.special99_Invalid),Voters_Fields.InvalidMessage_other99(le.other99_Invalid),Voters_Fields.InvalidMessage_special299(le.special299_Invalid),Voters_Fields.InvalidMessage_general99(le.general99_Invalid),Voters_Fields.InvalidMessage_primary98(le.primary98_Invalid),Voters_Fields.InvalidMessage_special98(le.special98_Invalid),Voters_Fields.InvalidMessage_other98(le.other98_Invalid),Voters_Fields.InvalidMessage_special298(le.special298_Invalid),Voters_Fields.InvalidMessage_general98(le.general98_Invalid),Voters_Fields.InvalidMessage_primary97(le.primary97_Invalid),Voters_Fields.InvalidMessage_special97(le.special97_Invalid),Voters_Fields.InvalidMessage_other97(le.other97_Invalid),Voters_Fields.InvalidMessage_special297(le.special297_Invalid),Voters_Fields.InvalidMessage_general97(le.general97_Invalid),Voters_Fields.InvalidMessage_pres96(le.pres96_Invalid),Voters_Fields.InvalidMessage_primary96(le.primary96_Invalid),Voters_Fields.InvalidMessage_special96(le.special96_Invalid),Voters_Fields.InvalidMessage_other96(le.other96_Invalid),Voters_Fields.InvalidMessage_special296(le.special296_Invalid),Voters_Fields.InvalidMessage_general96(le.general96_Invalid),Voters_Fields.InvalidMessage_lastdayvote(le.lastdayvote_Invalid),Voters_Fields.InvalidMessage_title(le.title_Invalid),Voters_Fields.InvalidMessage_fname(le.fname_Invalid),Voters_Fields.InvalidMessage_mname(le.mname_Invalid),Voters_Fields.InvalidMessage_lname(le.lname_Invalid),Voters_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Voters_Fields.InvalidMessage_score_on_input(le.score_on_input_Invalid),Voters_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Voters_Fields.InvalidMessage_predir(le.predir_Invalid),Voters_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Voters_Fields.InvalidMessage_suffix(le.suffix_Invalid),Voters_Fields.InvalidMessage_postdir(le.postdir_Invalid),Voters_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Voters_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Voters_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Voters_Fields.InvalidMessage_city_name(le.city_name_Invalid),Voters_Fields.InvalidMessage_st(le.st_Invalid),Voters_Fields.InvalidMessage_zip(le.zip_Invalid),Voters_Fields.InvalidMessage_zip4(le.zip4_Invalid),Voters_Fields.InvalidMessage_cart(le.cart_Invalid),Voters_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Voters_Fields.InvalidMessage_lot(le.lot_Invalid),Voters_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Voters_Fields.InvalidMessage_dpbc(le.dpbc_Invalid),Voters_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Voters_Fields.InvalidMessage_record_type(le.record_type_Invalid),Voters_Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),Voters_Fields.InvalidMessage_county(le.county_Invalid),Voters_Fields.InvalidMessage_county_name(le.county_name_Invalid),Voters_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Voters_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Voters_Fields.InvalidMessage_msa(le.msa_Invalid),Voters_Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Voters_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Voters_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Voters_Fields.InvalidMessage_mail_prim_range(le.mail_prim_range_Invalid),Voters_Fields.InvalidMessage_mail_predir(le.mail_predir_Invalid),Voters_Fields.InvalidMessage_mail_prim_name(le.mail_prim_name_Invalid),Voters_Fields.InvalidMessage_mail_addr_suffix(le.mail_addr_suffix_Invalid),Voters_Fields.InvalidMessage_mail_postdir(le.mail_postdir_Invalid),Voters_Fields.InvalidMessage_mail_unit_desig(le.mail_unit_desig_Invalid),Voters_Fields.InvalidMessage_mail_sec_range(le.mail_sec_range_Invalid),Voters_Fields.InvalidMessage_mail_p_city_name(le.mail_p_city_name_Invalid),Voters_Fields.InvalidMessage_mail_v_city_name(le.mail_v_city_name_Invalid),Voters_Fields.InvalidMessage_mail_st(le.mail_st_Invalid),Voters_Fields.InvalidMessage_mail_ace_zip(le.mail_ace_zip_Invalid),Voters_Fields.InvalidMessage_mail_zip4(le.mail_zip4_Invalid),Voters_Fields.InvalidMessage_mail_cart(le.mail_cart_Invalid),Voters_Fields.InvalidMessage_mail_cr_sort_sz(le.mail_cr_sort_sz_Invalid),Voters_Fields.InvalidMessage_mail_lot(le.mail_lot_Invalid),Voters_Fields.InvalidMessage_mail_lot_order(le.mail_lot_order_Invalid),Voters_Fields.InvalidMessage_mail_dpbc(le.mail_dpbc_Invalid),Voters_Fields.InvalidMessage_mail_chk_digit(le.mail_chk_digit_Invalid),Voters_Fields.InvalidMessage_mail_record_type(le.mail_record_type_Invalid),Voters_Fields.InvalidMessage_mail_ace_fips_st(le.mail_ace_fips_st_Invalid),Voters_Fields.InvalidMessage_mail_fipscounty(le.mail_fipscounty_Invalid),Voters_Fields.InvalidMessage_mail_geo_lat(le.mail_geo_lat_Invalid),Voters_Fields.InvalidMessage_mail_geo_long(le.mail_geo_long_Invalid),Voters_Fields.InvalidMessage_mail_msa(le.mail_msa_Invalid),Voters_Fields.InvalidMessage_mail_geo_blk(le.mail_geo_blk_Invalid),Voters_Fields.InvalidMessage_mail_geo_match(le.mail_geo_match_Invalid),Voters_Fields.InvalidMessage_mail_err_stat(le.mail_err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.best_ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_out_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.file_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.file_acquired_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le._use_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title_in_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_in_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_in_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_in_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.maiden_prior_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_in_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_voterid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.agecat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.headhousehold_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.place_of_birth_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.occupation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.maiden_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.motorvoterid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.regsource_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.regdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.race_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.poliparty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.poliparty_mapped_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.work_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.active_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.active_status_mapped_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.active_other_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.voterstatus_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.voterstatus_mapped_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.resaddr1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.resaddr2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.res_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.res_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.res_zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.res_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_addr1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_addr2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mail_zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mail_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.towncode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.distcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.countycode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.schoolcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cityinout_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spec_dist1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spec_dist2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.precinct1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.precinct2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.precinct3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.villageprecinct_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.schoolprecinct_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ward_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.precinct_citytown_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ancsmdindc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.citycouncildist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.countycommdist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statehouse_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statesenate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ushouse_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.elemschooldist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.schooldist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.commcolldist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.municipal_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.villagedist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.policejury_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.policedist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.publicservcomm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rescue_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fire_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sanitary_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sewerdist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.waterdist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mosquitodist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.taxdist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.supremecourt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.justiceofpeace_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.judicialdist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.superiorctdist_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.appealsct_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contributorparty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.recptparty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dateofcontr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dollaramt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary02_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special02_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other02_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special202_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.general02_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary01_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special01_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other01_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special201_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.general01_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pres00_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary00_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special00_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other00_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special200_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.general00_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary99_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special99_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other99_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special299_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.general99_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary98_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special98_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other98_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special298_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.general98_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary97_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special97_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other97_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special297_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.general97_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pres96_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primary96_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special96_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other96_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.special296_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.general96_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lastdayvote_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.score_on_input_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dpbc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ace_fips_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_ace_zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mail_zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_cr_sort_sz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_lot_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_dpbc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_ace_fips_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_fipscounty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_err_stat_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','file_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','source_voterid','dob','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','gender','poliparty','poliparty_mapped','phone','work_phone','other_phone','active_status','active_status_mapped','active_other','voterstatus','voterstatus_mapped','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','commcolldist','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','contributorparty','recptparty','dateofcontr','dollaramt','primary02','special02','other02','special202','general02','primary01','special01','other01','special201','general01','pres00','primary00','special00','other00','special200','general00','primary99','special99','other99','special299','general99','primary98','special98','other98','special298','general98','primary97','special97','other97','special297','general97','pres96','primary96','special96','other96','special296','general96','lastdayvote','title','fname','mname','lname','name_suffix','score_on_input','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_No','Invalid_Float','Invalid_No','Invalid_Alpha','Invalid_State','Invalid_Alpha','Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Date','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Date','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Alpha','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.process_date,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.score,(SALT311.StrType)le.best_ssn,(SALT311.StrType)le.did_out,(SALT311.StrType)le.file_id,(SALT311.StrType)le.source_state,(SALT311.StrType)le.source_code,(SALT311.StrType)le.file_acquired_date,(SALT311.StrType)le._use,(SALT311.StrType)le.title_in,(SALT311.StrType)le.lname_in,(SALT311.StrType)le.fname_in,(SALT311.StrType)le.mname_in,(SALT311.StrType)le.maiden_prior,(SALT311.StrType)le.name_suffix_in,(SALT311.StrType)le.source_voterid,(SALT311.StrType)le.dob,(SALT311.StrType)le.agecat,(SALT311.StrType)le.headhousehold,(SALT311.StrType)le.place_of_birth,(SALT311.StrType)le.occupation,(SALT311.StrType)le.maiden_name,(SALT311.StrType)le.motorvoterid,(SALT311.StrType)le.regsource,(SALT311.StrType)le.regdate,(SALT311.StrType)le.race,(SALT311.StrType)le.gender,(SALT311.StrType)le.poliparty,(SALT311.StrType)le.poliparty_mapped,(SALT311.StrType)le.phone,(SALT311.StrType)le.work_phone,(SALT311.StrType)le.other_phone,(SALT311.StrType)le.active_status,(SALT311.StrType)le.active_status_mapped,(SALT311.StrType)le.active_other,(SALT311.StrType)le.voterstatus,(SALT311.StrType)le.voterstatus_mapped,(SALT311.StrType)le.resaddr1,(SALT311.StrType)le.resaddr2,(SALT311.StrType)le.res_city,(SALT311.StrType)le.res_state,(SALT311.StrType)le.res_zip,(SALT311.StrType)le.res_county,(SALT311.StrType)le.mail_addr1,(SALT311.StrType)le.mail_addr2,(SALT311.StrType)le.mail_city,(SALT311.StrType)le.mail_state,(SALT311.StrType)le.mail_zip,(SALT311.StrType)le.mail_county,(SALT311.StrType)le.towncode,(SALT311.StrType)le.distcode,(SALT311.StrType)le.countycode,(SALT311.StrType)le.schoolcode,(SALT311.StrType)le.cityinout,(SALT311.StrType)le.spec_dist1,(SALT311.StrType)le.spec_dist2,(SALT311.StrType)le.precinct1,(SALT311.StrType)le.precinct2,(SALT311.StrType)le.precinct3,(SALT311.StrType)le.villageprecinct,(SALT311.StrType)le.schoolprecinct,(SALT311.StrType)le.ward,(SALT311.StrType)le.precinct_citytown,(SALT311.StrType)le.ancsmdindc,(SALT311.StrType)le.citycouncildist,(SALT311.StrType)le.countycommdist,(SALT311.StrType)le.statehouse,(SALT311.StrType)le.statesenate,(SALT311.StrType)le.ushouse,(SALT311.StrType)le.elemschooldist,(SALT311.StrType)le.schooldist,(SALT311.StrType)le.commcolldist,(SALT311.StrType)le.municipal,(SALT311.StrType)le.villagedist,(SALT311.StrType)le.policejury,(SALT311.StrType)le.policedist,(SALT311.StrType)le.publicservcomm,(SALT311.StrType)le.rescue,(SALT311.StrType)le.fire,(SALT311.StrType)le.sanitary,(SALT311.StrType)le.sewerdist,(SALT311.StrType)le.waterdist,(SALT311.StrType)le.mosquitodist,(SALT311.StrType)le.taxdist,(SALT311.StrType)le.supremecourt,(SALT311.StrType)le.justiceofpeace,(SALT311.StrType)le.judicialdist,(SALT311.StrType)le.superiorctdist,(SALT311.StrType)le.appealsct,(SALT311.StrType)le.contributorparty,(SALT311.StrType)le.recptparty,(SALT311.StrType)le.dateofcontr,(SALT311.StrType)le.dollaramt,(SALT311.StrType)le.primary02,(SALT311.StrType)le.special02,(SALT311.StrType)le.other02,(SALT311.StrType)le.special202,(SALT311.StrType)le.general02,(SALT311.StrType)le.primary01,(SALT311.StrType)le.special01,(SALT311.StrType)le.other01,(SALT311.StrType)le.special201,(SALT311.StrType)le.general01,(SALT311.StrType)le.pres00,(SALT311.StrType)le.primary00,(SALT311.StrType)le.special00,(SALT311.StrType)le.other00,(SALT311.StrType)le.special200,(SALT311.StrType)le.general00,(SALT311.StrType)le.primary99,(SALT311.StrType)le.special99,(SALT311.StrType)le.other99,(SALT311.StrType)le.special299,(SALT311.StrType)le.general99,(SALT311.StrType)le.primary98,(SALT311.StrType)le.special98,(SALT311.StrType)le.other98,(SALT311.StrType)le.special298,(SALT311.StrType)le.general98,(SALT311.StrType)le.primary97,(SALT311.StrType)le.special97,(SALT311.StrType)le.other97,(SALT311.StrType)le.special297,(SALT311.StrType)le.general97,(SALT311.StrType)le.pres96,(SALT311.StrType)le.primary96,(SALT311.StrType)le.special96,(SALT311.StrType)le.other96,(SALT311.StrType)le.special296,(SALT311.StrType)le.general96,(SALT311.StrType)le.lastdayvote,(SALT311.StrType)le.title,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.score_on_input,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dpbc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.record_type,(SALT311.StrType)le.ace_fips_st,(SALT311.StrType)le.county,(SALT311.StrType)le.county_name,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.msa,(SALT311.StrType)le.geo_blk,(SALT311.StrType)le.geo_match,(SALT311.StrType)le.err_stat,(SALT311.StrType)le.mail_prim_range,(SALT311.StrType)le.mail_predir,(SALT311.StrType)le.mail_prim_name,(SALT311.StrType)le.mail_addr_suffix,(SALT311.StrType)le.mail_postdir,(SALT311.StrType)le.mail_unit_desig,(SALT311.StrType)le.mail_sec_range,(SALT311.StrType)le.mail_p_city_name,(SALT311.StrType)le.mail_v_city_name,(SALT311.StrType)le.mail_st,(SALT311.StrType)le.mail_ace_zip,(SALT311.StrType)le.mail_zip4,(SALT311.StrType)le.mail_cart,(SALT311.StrType)le.mail_cr_sort_sz,(SALT311.StrType)le.mail_lot,(SALT311.StrType)le.mail_lot_order,(SALT311.StrType)le.mail_dpbc,(SALT311.StrType)le.mail_chk_digit,(SALT311.StrType)le.mail_record_type,(SALT311.StrType)le.mail_ace_fips_st,(SALT311.StrType)le.mail_fipscounty,(SALT311.StrType)le.mail_geo_lat,(SALT311.StrType)le.mail_geo_long,(SALT311.StrType)le.mail_msa,(SALT311.StrType)le.mail_geo_blk,(SALT311.StrType)le.mail_geo_match,(SALT311.StrType)le.mail_err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,194,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Voters_Layout_eMerges) prevDS = DATASET([], Voters_Layout_eMerges), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.score_ALLOW_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount
          ,le.did_out_ALLOW_ErrorCount
          ,le.file_id_ALLOW_ErrorCount
          ,le.source_state_ALLOW_ErrorCount,le.source_state_LENGTHS_ErrorCount
          ,le.source_code_ALLOW_ErrorCount
          ,le.file_acquired_date_CUSTOM_ErrorCount
          ,le._use_ALLOW_ErrorCount
          ,le.title_in_ALLOW_ErrorCount
          ,le.lname_in_ALLOW_ErrorCount
          ,le.fname_in_ALLOW_ErrorCount
          ,le.mname_in_ALLOW_ErrorCount
          ,le.maiden_prior_ALLOW_ErrorCount
          ,le.name_suffix_in_ALLOW_ErrorCount
          ,le.source_voterid_ALLOW_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.agecat_ALLOW_ErrorCount
          ,le.headhousehold_ALLOW_ErrorCount
          ,le.place_of_birth_CUSTOM_ErrorCount
          ,le.occupation_ALLOW_ErrorCount
          ,le.maiden_name_ALLOW_ErrorCount
          ,le.motorvoterid_ALLOW_ErrorCount
          ,le.regsource_ALLOW_ErrorCount
          ,le.regdate_CUSTOM_ErrorCount
          ,le.race_ALLOW_ErrorCount
          ,le.gender_ALLOW_ErrorCount
          ,le.poliparty_ALLOW_ErrorCount
          ,le.poliparty_mapped_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.work_phone_ALLOW_ErrorCount
          ,le.other_phone_ALLOW_ErrorCount
          ,le.active_status_ALLOW_ErrorCount
          ,le.active_status_mapped_ALLOW_ErrorCount
          ,le.active_other_ALLOW_ErrorCount
          ,le.voterstatus_ALLOW_ErrorCount
          ,le.voterstatus_mapped_ALLOW_ErrorCount
          ,le.resaddr1_ALLOW_ErrorCount
          ,le.resaddr2_ALLOW_ErrorCount
          ,le.res_city_ALLOW_ErrorCount
          ,le.res_state_ALLOW_ErrorCount,le.res_state_LENGTHS_ErrorCount
          ,le.res_zip_ALLOW_ErrorCount,le.res_zip_LENGTHS_ErrorCount
          ,le.res_county_ALLOW_ErrorCount
          ,le.mail_addr1_ALLOW_ErrorCount
          ,le.mail_addr2_ALLOW_ErrorCount
          ,le.mail_city_ALLOW_ErrorCount
          ,le.mail_state_ALLOW_ErrorCount,le.mail_state_LENGTHS_ErrorCount
          ,le.mail_zip_ALLOW_ErrorCount,le.mail_zip_LENGTHS_ErrorCount
          ,le.mail_county_ALLOW_ErrorCount
          ,le.towncode_ALLOW_ErrorCount
          ,le.distcode_ALLOW_ErrorCount
          ,le.countycode_ALLOW_ErrorCount
          ,le.schoolcode_ALLOW_ErrorCount
          ,le.cityinout_ALLOW_ErrorCount
          ,le.spec_dist1_ALLOW_ErrorCount
          ,le.spec_dist2_ALLOW_ErrorCount
          ,le.precinct1_ALLOW_ErrorCount
          ,le.precinct2_ALLOW_ErrorCount
          ,le.precinct3_ALLOW_ErrorCount
          ,le.villageprecinct_ALLOW_ErrorCount
          ,le.schoolprecinct_ALLOW_ErrorCount
          ,le.ward_ALLOW_ErrorCount
          ,le.precinct_citytown_ALLOW_ErrorCount
          ,le.ancsmdindc_ALLOW_ErrorCount
          ,le.citycouncildist_ALLOW_ErrorCount
          ,le.countycommdist_ALLOW_ErrorCount
          ,le.statehouse_ALLOW_ErrorCount
          ,le.statesenate_ALLOW_ErrorCount
          ,le.ushouse_ALLOW_ErrorCount
          ,le.elemschooldist_ALLOW_ErrorCount
          ,le.schooldist_ALLOW_ErrorCount
          ,le.commcolldist_ALLOW_ErrorCount
          ,le.municipal_ALLOW_ErrorCount
          ,le.villagedist_ALLOW_ErrorCount
          ,le.policejury_ALLOW_ErrorCount
          ,le.policedist_ALLOW_ErrorCount
          ,le.publicservcomm_ALLOW_ErrorCount
          ,le.rescue_ALLOW_ErrorCount
          ,le.fire_ALLOW_ErrorCount
          ,le.sanitary_ALLOW_ErrorCount
          ,le.sewerdist_ALLOW_ErrorCount
          ,le.waterdist_ALLOW_ErrorCount
          ,le.mosquitodist_ALLOW_ErrorCount
          ,le.taxdist_ALLOW_ErrorCount
          ,le.supremecourt_ALLOW_ErrorCount
          ,le.justiceofpeace_ALLOW_ErrorCount
          ,le.judicialdist_ALLOW_ErrorCount
          ,le.superiorctdist_ALLOW_ErrorCount
          ,le.appealsct_ALLOW_ErrorCount
          ,le.contributorparty_ALLOW_ErrorCount
          ,le.recptparty_ALLOW_ErrorCount
          ,le.dateofcontr_CUSTOM_ErrorCount
          ,le.dollaramt_ALLOW_ErrorCount
          ,le.primary02_ALLOW_ErrorCount
          ,le.special02_ALLOW_ErrorCount
          ,le.other02_ALLOW_ErrorCount
          ,le.special202_ALLOW_ErrorCount
          ,le.general02_ALLOW_ErrorCount
          ,le.primary01_ALLOW_ErrorCount
          ,le.special01_ALLOW_ErrorCount
          ,le.other01_ALLOW_ErrorCount
          ,le.special201_ALLOW_ErrorCount
          ,le.general01_ALLOW_ErrorCount
          ,le.pres00_ALLOW_ErrorCount
          ,le.primary00_ALLOW_ErrorCount
          ,le.special00_ALLOW_ErrorCount
          ,le.other00_ALLOW_ErrorCount
          ,le.special200_ALLOW_ErrorCount
          ,le.general00_ALLOW_ErrorCount
          ,le.primary99_ALLOW_ErrorCount
          ,le.special99_ALLOW_ErrorCount
          ,le.other99_ALLOW_ErrorCount
          ,le.special299_ALLOW_ErrorCount
          ,le.general99_ALLOW_ErrorCount
          ,le.primary98_ALLOW_ErrorCount
          ,le.special98_ALLOW_ErrorCount
          ,le.other98_ALLOW_ErrorCount
          ,le.special298_ALLOW_ErrorCount
          ,le.general98_ALLOW_ErrorCount
          ,le.primary97_ALLOW_ErrorCount
          ,le.special97_ALLOW_ErrorCount
          ,le.other97_ALLOW_ErrorCount
          ,le.special297_ALLOW_ErrorCount
          ,le.general97_ALLOW_ErrorCount
          ,le.pres96_ALLOW_ErrorCount
          ,le.primary96_ALLOW_ErrorCount
          ,le.special96_ALLOW_ErrorCount
          ,le.other96_ALLOW_ErrorCount
          ,le.special296_ALLOW_ErrorCount
          ,le.general96_ALLOW_ErrorCount
          ,le.lastdayvote_CUSTOM_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.score_on_input_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount
          ,le.dpbc_ALLOW_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.county_name_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount
          ,le.mail_prim_range_ALLOW_ErrorCount
          ,le.mail_predir_ALLOW_ErrorCount
          ,le.mail_prim_name_ALLOW_ErrorCount
          ,le.mail_addr_suffix_ALLOW_ErrorCount
          ,le.mail_postdir_ALLOW_ErrorCount
          ,le.mail_unit_desig_ALLOW_ErrorCount
          ,le.mail_sec_range_ALLOW_ErrorCount
          ,le.mail_p_city_name_ALLOW_ErrorCount
          ,le.mail_v_city_name_ALLOW_ErrorCount
          ,le.mail_st_ALLOW_ErrorCount
          ,le.mail_ace_zip_ALLOW_ErrorCount,le.mail_ace_zip_LENGTHS_ErrorCount
          ,le.mail_zip4_ALLOW_ErrorCount
          ,le.mail_cart_ALLOW_ErrorCount
          ,le.mail_cr_sort_sz_ALLOW_ErrorCount
          ,le.mail_lot_ALLOW_ErrorCount
          ,le.mail_lot_order_ALLOW_ErrorCount
          ,le.mail_dpbc_ALLOW_ErrorCount
          ,le.mail_chk_digit_ALLOW_ErrorCount
          ,le.mail_record_type_ALLOW_ErrorCount
          ,le.mail_ace_fips_st_ALLOW_ErrorCount
          ,le.mail_fipscounty_ALLOW_ErrorCount
          ,le.mail_geo_lat_ALLOW_ErrorCount
          ,le.mail_geo_long_ALLOW_ErrorCount
          ,le.mail_msa_ALLOW_ErrorCount
          ,le.mail_geo_blk_ALLOW_ErrorCount
          ,le.mail_geo_match_ALLOW_ErrorCount
          ,le.mail_err_stat_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.score_ALLOW_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount
          ,le.did_out_ALLOW_ErrorCount
          ,le.file_id_ALLOW_ErrorCount
          ,le.source_state_ALLOW_ErrorCount,le.source_state_LENGTHS_ErrorCount
          ,le.source_code_ALLOW_ErrorCount
          ,le.file_acquired_date_CUSTOM_ErrorCount
          ,le._use_ALLOW_ErrorCount
          ,le.title_in_ALLOW_ErrorCount
          ,le.lname_in_ALLOW_ErrorCount
          ,le.fname_in_ALLOW_ErrorCount
          ,le.mname_in_ALLOW_ErrorCount
          ,le.maiden_prior_ALLOW_ErrorCount
          ,le.name_suffix_in_ALLOW_ErrorCount
          ,le.source_voterid_ALLOW_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.agecat_ALLOW_ErrorCount
          ,le.headhousehold_ALLOW_ErrorCount
          ,le.place_of_birth_CUSTOM_ErrorCount
          ,le.occupation_ALLOW_ErrorCount
          ,le.maiden_name_ALLOW_ErrorCount
          ,le.motorvoterid_ALLOW_ErrorCount
          ,le.regsource_ALLOW_ErrorCount
          ,le.regdate_CUSTOM_ErrorCount
          ,le.race_ALLOW_ErrorCount
          ,le.gender_ALLOW_ErrorCount
          ,le.poliparty_ALLOW_ErrorCount
          ,le.poliparty_mapped_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.work_phone_ALLOW_ErrorCount
          ,le.other_phone_ALLOW_ErrorCount
          ,le.active_status_ALLOW_ErrorCount
          ,le.active_status_mapped_ALLOW_ErrorCount
          ,le.active_other_ALLOW_ErrorCount
          ,le.voterstatus_ALLOW_ErrorCount
          ,le.voterstatus_mapped_ALLOW_ErrorCount
          ,le.resaddr1_ALLOW_ErrorCount
          ,le.resaddr2_ALLOW_ErrorCount
          ,le.res_city_ALLOW_ErrorCount
          ,le.res_state_ALLOW_ErrorCount,le.res_state_LENGTHS_ErrorCount
          ,le.res_zip_ALLOW_ErrorCount,le.res_zip_LENGTHS_ErrorCount
          ,le.res_county_ALLOW_ErrorCount
          ,le.mail_addr1_ALLOW_ErrorCount
          ,le.mail_addr2_ALLOW_ErrorCount
          ,le.mail_city_ALLOW_ErrorCount
          ,le.mail_state_ALLOW_ErrorCount,le.mail_state_LENGTHS_ErrorCount
          ,le.mail_zip_ALLOW_ErrorCount,le.mail_zip_LENGTHS_ErrorCount
          ,le.mail_county_ALLOW_ErrorCount
          ,le.towncode_ALLOW_ErrorCount
          ,le.distcode_ALLOW_ErrorCount
          ,le.countycode_ALLOW_ErrorCount
          ,le.schoolcode_ALLOW_ErrorCount
          ,le.cityinout_ALLOW_ErrorCount
          ,le.spec_dist1_ALLOW_ErrorCount
          ,le.spec_dist2_ALLOW_ErrorCount
          ,le.precinct1_ALLOW_ErrorCount
          ,le.precinct2_ALLOW_ErrorCount
          ,le.precinct3_ALLOW_ErrorCount
          ,le.villageprecinct_ALLOW_ErrorCount
          ,le.schoolprecinct_ALLOW_ErrorCount
          ,le.ward_ALLOW_ErrorCount
          ,le.precinct_citytown_ALLOW_ErrorCount
          ,le.ancsmdindc_ALLOW_ErrorCount
          ,le.citycouncildist_ALLOW_ErrorCount
          ,le.countycommdist_ALLOW_ErrorCount
          ,le.statehouse_ALLOW_ErrorCount
          ,le.statesenate_ALLOW_ErrorCount
          ,le.ushouse_ALLOW_ErrorCount
          ,le.elemschooldist_ALLOW_ErrorCount
          ,le.schooldist_ALLOW_ErrorCount
          ,le.commcolldist_ALLOW_ErrorCount
          ,le.municipal_ALLOW_ErrorCount
          ,le.villagedist_ALLOW_ErrorCount
          ,le.policejury_ALLOW_ErrorCount
          ,le.policedist_ALLOW_ErrorCount
          ,le.publicservcomm_ALLOW_ErrorCount
          ,le.rescue_ALLOW_ErrorCount
          ,le.fire_ALLOW_ErrorCount
          ,le.sanitary_ALLOW_ErrorCount
          ,le.sewerdist_ALLOW_ErrorCount
          ,le.waterdist_ALLOW_ErrorCount
          ,le.mosquitodist_ALLOW_ErrorCount
          ,le.taxdist_ALLOW_ErrorCount
          ,le.supremecourt_ALLOW_ErrorCount
          ,le.justiceofpeace_ALLOW_ErrorCount
          ,le.judicialdist_ALLOW_ErrorCount
          ,le.superiorctdist_ALLOW_ErrorCount
          ,le.appealsct_ALLOW_ErrorCount
          ,le.contributorparty_ALLOW_ErrorCount
          ,le.recptparty_ALLOW_ErrorCount
          ,le.dateofcontr_CUSTOM_ErrorCount
          ,le.dollaramt_ALLOW_ErrorCount
          ,le.primary02_ALLOW_ErrorCount
          ,le.special02_ALLOW_ErrorCount
          ,le.other02_ALLOW_ErrorCount
          ,le.special202_ALLOW_ErrorCount
          ,le.general02_ALLOW_ErrorCount
          ,le.primary01_ALLOW_ErrorCount
          ,le.special01_ALLOW_ErrorCount
          ,le.other01_ALLOW_ErrorCount
          ,le.special201_ALLOW_ErrorCount
          ,le.general01_ALLOW_ErrorCount
          ,le.pres00_ALLOW_ErrorCount
          ,le.primary00_ALLOW_ErrorCount
          ,le.special00_ALLOW_ErrorCount
          ,le.other00_ALLOW_ErrorCount
          ,le.special200_ALLOW_ErrorCount
          ,le.general00_ALLOW_ErrorCount
          ,le.primary99_ALLOW_ErrorCount
          ,le.special99_ALLOW_ErrorCount
          ,le.other99_ALLOW_ErrorCount
          ,le.special299_ALLOW_ErrorCount
          ,le.general99_ALLOW_ErrorCount
          ,le.primary98_ALLOW_ErrorCount
          ,le.special98_ALLOW_ErrorCount
          ,le.other98_ALLOW_ErrorCount
          ,le.special298_ALLOW_ErrorCount
          ,le.general98_ALLOW_ErrorCount
          ,le.primary97_ALLOW_ErrorCount
          ,le.special97_ALLOW_ErrorCount
          ,le.other97_ALLOW_ErrorCount
          ,le.special297_ALLOW_ErrorCount
          ,le.general97_ALLOW_ErrorCount
          ,le.pres96_ALLOW_ErrorCount
          ,le.primary96_ALLOW_ErrorCount
          ,le.special96_ALLOW_ErrorCount
          ,le.other96_ALLOW_ErrorCount
          ,le.special296_ALLOW_ErrorCount
          ,le.general96_ALLOW_ErrorCount
          ,le.lastdayvote_CUSTOM_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.score_on_input_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount
          ,le.dpbc_ALLOW_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.county_name_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount
          ,le.mail_prim_range_ALLOW_ErrorCount
          ,le.mail_predir_ALLOW_ErrorCount
          ,le.mail_prim_name_ALLOW_ErrorCount
          ,le.mail_addr_suffix_ALLOW_ErrorCount
          ,le.mail_postdir_ALLOW_ErrorCount
          ,le.mail_unit_desig_ALLOW_ErrorCount
          ,le.mail_sec_range_ALLOW_ErrorCount
          ,le.mail_p_city_name_ALLOW_ErrorCount
          ,le.mail_v_city_name_ALLOW_ErrorCount
          ,le.mail_st_ALLOW_ErrorCount
          ,le.mail_ace_zip_ALLOW_ErrorCount,le.mail_ace_zip_LENGTHS_ErrorCount
          ,le.mail_zip4_ALLOW_ErrorCount
          ,le.mail_cart_ALLOW_ErrorCount
          ,le.mail_cr_sort_sz_ALLOW_ErrorCount
          ,le.mail_lot_ALLOW_ErrorCount
          ,le.mail_lot_order_ALLOW_ErrorCount
          ,le.mail_dpbc_ALLOW_ErrorCount
          ,le.mail_chk_digit_ALLOW_ErrorCount
          ,le.mail_record_type_ALLOW_ErrorCount
          ,le.mail_ace_fips_st_ALLOW_ErrorCount
          ,le.mail_fipscounty_ALLOW_ErrorCount
          ,le.mail_geo_lat_ALLOW_ErrorCount
          ,le.mail_geo_long_ALLOW_ErrorCount
          ,le.mail_msa_ALLOW_ErrorCount
          ,le.mail_geo_blk_ALLOW_ErrorCount
          ,le.mail_geo_match_ALLOW_ErrorCount
          ,le.mail_err_stat_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Voters_hygiene(PROJECT(h, Voters_Layout_eMerges));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'score:' + getFieldTypeText(h.score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'best_ssn:' + getFieldTypeText(h.best_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_out:' + getFieldTypeText(h.did_out) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_id:' + getFieldTypeText(h.file_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_id:' + getFieldTypeText(h.vendor_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_state:' + getFieldTypeText(h.source_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_code:' + getFieldTypeText(h.source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_acquired_date:' + getFieldTypeText(h.file_acquired_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'_use:' + getFieldTypeText(h._use) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title_in:' + getFieldTypeText(h.title_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname_in:' + getFieldTypeText(h.lname_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname_in:' + getFieldTypeText(h.fname_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname_in:' + getFieldTypeText(h.mname_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'maiden_prior:' + getFieldTypeText(h.maiden_prior) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix_in:' + getFieldTypeText(h.name_suffix_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'votefiller:' + getFieldTypeText(h.votefiller) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_voterid:' + getFieldTypeText(h.source_voterid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'agecat:' + getFieldTypeText(h.agecat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'headhousehold:' + getFieldTypeText(h.headhousehold) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'place_of_birth:' + getFieldTypeText(h.place_of_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'occupation:' + getFieldTypeText(h.occupation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'maiden_name:' + getFieldTypeText(h.maiden_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'motorvoterid:' + getFieldTypeText(h.motorvoterid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regsource:' + getFieldTypeText(h.regsource) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regdate:' + getFieldTypeText(h.regdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'race:' + getFieldTypeText(h.race) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'poliparty:' + getFieldTypeText(h.poliparty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'poliparty_mapped:' + getFieldTypeText(h.poliparty_mapped) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'work_phone:' + getFieldTypeText(h.work_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_phone:' + getFieldTypeText(h.other_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_status:' + getFieldTypeText(h.active_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_status_mapped:' + getFieldTypeText(h.active_status_mapped) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'votefiller2:' + getFieldTypeText(h.votefiller2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_other:' + getFieldTypeText(h.active_other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'voterstatus:' + getFieldTypeText(h.voterstatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'voterstatus_mapped:' + getFieldTypeText(h.voterstatus_mapped) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'resaddr1:' + getFieldTypeText(h.resaddr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'resaddr2:' + getFieldTypeText(h.resaddr2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_city:' + getFieldTypeText(h.res_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_state:' + getFieldTypeText(h.res_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_zip:' + getFieldTypeText(h.res_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_county:' + getFieldTypeText(h.res_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_addr1:' + getFieldTypeText(h.mail_addr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_addr2:' + getFieldTypeText(h.mail_addr2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_city:' + getFieldTypeText(h.mail_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_state:' + getFieldTypeText(h.mail_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_zip:' + getFieldTypeText(h.mail_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_county:' + getFieldTypeText(h.mail_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_filler1:' + getFieldTypeText(h.addr_filler1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_filler2:' + getFieldTypeText(h.addr_filler2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_filler:' + getFieldTypeText(h.city_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_filler:' + getFieldTypeText(h.state_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_filler:' + getFieldTypeText(h.zip_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_filler:' + getFieldTypeText(h.county_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'towncode:' + getFieldTypeText(h.towncode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'distcode:' + getFieldTypeText(h.distcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countycode:' + getFieldTypeText(h.countycode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'schoolcode:' + getFieldTypeText(h.schoolcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cityinout:' + getFieldTypeText(h.cityinout) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spec_dist1:' + getFieldTypeText(h.spec_dist1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spec_dist2:' + getFieldTypeText(h.spec_dist2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinct1:' + getFieldTypeText(h.precinct1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinct2:' + getFieldTypeText(h.precinct2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinct3:' + getFieldTypeText(h.precinct3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'villageprecinct:' + getFieldTypeText(h.villageprecinct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'schoolprecinct:' + getFieldTypeText(h.schoolprecinct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ward:' + getFieldTypeText(h.ward) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'precinct_citytown:' + getFieldTypeText(h.precinct_citytown) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ancsmdindc:' + getFieldTypeText(h.ancsmdindc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'citycouncildist:' + getFieldTypeText(h.citycouncildist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countycommdist:' + getFieldTypeText(h.countycommdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statehouse:' + getFieldTypeText(h.statehouse) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statesenate:' + getFieldTypeText(h.statesenate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ushouse:' + getFieldTypeText(h.ushouse) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'elemschooldist:' + getFieldTypeText(h.elemschooldist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'schooldist:' + getFieldTypeText(h.schooldist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'schoolfiller:' + getFieldTypeText(h.schoolfiller) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commcolldist:' + getFieldTypeText(h.commcolldist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dist_filler:' + getFieldTypeText(h.dist_filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'municipal:' + getFieldTypeText(h.municipal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'villagedist:' + getFieldTypeText(h.villagedist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policejury:' + getFieldTypeText(h.policejury) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policedist:' + getFieldTypeText(h.policedist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicservcomm:' + getFieldTypeText(h.publicservcomm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rescue:' + getFieldTypeText(h.rescue) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fire:' + getFieldTypeText(h.fire) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sanitary:' + getFieldTypeText(h.sanitary) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sewerdist:' + getFieldTypeText(h.sewerdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'waterdist:' + getFieldTypeText(h.waterdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mosquitodist:' + getFieldTypeText(h.mosquitodist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'taxdist:' + getFieldTypeText(h.taxdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'supremecourt:' + getFieldTypeText(h.supremecourt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'justiceofpeace:' + getFieldTypeText(h.justiceofpeace) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judicialdist:' + getFieldTypeText(h.judicialdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'superiorctdist:' + getFieldTypeText(h.superiorctdist) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'appealsct:' + getFieldTypeText(h.appealsct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtfiller:' + getFieldTypeText(h.courtfiller) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contributorparty:' + getFieldTypeText(h.contributorparty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recptparty:' + getFieldTypeText(h.recptparty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateofcontr:' + getFieldTypeText(h.dateofcontr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dollaramt:' + getFieldTypeText(h.dollaramt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officecontto:' + getFieldTypeText(h.officecontto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cumuldollaramt:' + getFieldTypeText(h.cumuldollaramt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contfiller1:' + getFieldTypeText(h.contfiller1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contfiller2:' + getFieldTypeText(h.contfiller2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'conttype:' + getFieldTypeText(h.conttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contfiller3:' + getFieldTypeText(h.contfiller3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary02:' + getFieldTypeText(h.primary02) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special02:' + getFieldTypeText(h.special02) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other02:' + getFieldTypeText(h.other02) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special202:' + getFieldTypeText(h.special202) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'general02:' + getFieldTypeText(h.general02) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary01:' + getFieldTypeText(h.primary01) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special01:' + getFieldTypeText(h.special01) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other01:' + getFieldTypeText(h.other01) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special201:' + getFieldTypeText(h.special201) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'general01:' + getFieldTypeText(h.general01) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pres00:' + getFieldTypeText(h.pres00) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary00:' + getFieldTypeText(h.primary00) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special00:' + getFieldTypeText(h.special00) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other00:' + getFieldTypeText(h.other00) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special200:' + getFieldTypeText(h.special200) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'general00:' + getFieldTypeText(h.general00) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary99:' + getFieldTypeText(h.primary99) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special99:' + getFieldTypeText(h.special99) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other99:' + getFieldTypeText(h.other99) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special299:' + getFieldTypeText(h.special299) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'general99:' + getFieldTypeText(h.general99) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary98:' + getFieldTypeText(h.primary98) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special98:' + getFieldTypeText(h.special98) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other98:' + getFieldTypeText(h.other98) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special298:' + getFieldTypeText(h.special298) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'general98:' + getFieldTypeText(h.general98) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary97:' + getFieldTypeText(h.primary97) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special97:' + getFieldTypeText(h.special97) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other97:' + getFieldTypeText(h.other97) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special297:' + getFieldTypeText(h.special297) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'general97:' + getFieldTypeText(h.general97) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pres96:' + getFieldTypeText(h.pres96) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary96:' + getFieldTypeText(h.primary96) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special96:' + getFieldTypeText(h.special96) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other96:' + getFieldTypeText(h.other96) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special296:' + getFieldTypeText(h.special296) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'general96:' + getFieldTypeText(h.general96) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastdayvote:' + getFieldTypeText(h.lastdayvote) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'score_on_input:' + getFieldTypeText(h.score_on_input) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_name:' + getFieldTypeText(h.city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_name:' + getFieldTypeText(h.county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_prim_range:' + getFieldTypeText(h.mail_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_predir:' + getFieldTypeText(h.mail_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_prim_name:' + getFieldTypeText(h.mail_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_addr_suffix:' + getFieldTypeText(h.mail_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_postdir:' + getFieldTypeText(h.mail_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_unit_desig:' + getFieldTypeText(h.mail_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_sec_range:' + getFieldTypeText(h.mail_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_p_city_name:' + getFieldTypeText(h.mail_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_v_city_name:' + getFieldTypeText(h.mail_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_st:' + getFieldTypeText(h.mail_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_ace_zip:' + getFieldTypeText(h.mail_ace_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_zip4:' + getFieldTypeText(h.mail_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_cart:' + getFieldTypeText(h.mail_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_cr_sort_sz:' + getFieldTypeText(h.mail_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_lot:' + getFieldTypeText(h.mail_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_lot_order:' + getFieldTypeText(h.mail_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_dpbc:' + getFieldTypeText(h.mail_dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_chk_digit:' + getFieldTypeText(h.mail_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_record_type:' + getFieldTypeText(h.mail_record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_ace_fips_st:' + getFieldTypeText(h.mail_ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_fipscounty:' + getFieldTypeText(h.mail_fipscounty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_lat:' + getFieldTypeText(h.mail_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_long:' + getFieldTypeText(h.mail_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_msa:' + getFieldTypeText(h.mail_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_blk:' + getFieldTypeText(h.mail_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_geo_match:' + getFieldTypeText(h.mail_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mail_err_stat:' + getFieldTypeText(h.mail_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_process_date_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_score_cnt
          ,le.populated_best_ssn_cnt
          ,le.populated_did_out_cnt
          ,le.populated_source_cnt
          ,le.populated_file_id_cnt
          ,le.populated_vendor_id_cnt
          ,le.populated_source_state_cnt
          ,le.populated_source_code_cnt
          ,le.populated_file_acquired_date_cnt
          ,le.populated__use_cnt
          ,le.populated_title_in_cnt
          ,le.populated_lname_in_cnt
          ,le.populated_fname_in_cnt
          ,le.populated_mname_in_cnt
          ,le.populated_maiden_prior_cnt
          ,le.populated_name_suffix_in_cnt
          ,le.populated_votefiller_cnt
          ,le.populated_source_voterid_cnt
          ,le.populated_dob_cnt
          ,le.populated_agecat_cnt
          ,le.populated_headhousehold_cnt
          ,le.populated_place_of_birth_cnt
          ,le.populated_occupation_cnt
          ,le.populated_maiden_name_cnt
          ,le.populated_motorvoterid_cnt
          ,le.populated_regsource_cnt
          ,le.populated_regdate_cnt
          ,le.populated_race_cnt
          ,le.populated_gender_cnt
          ,le.populated_poliparty_cnt
          ,le.populated_poliparty_mapped_cnt
          ,le.populated_phone_cnt
          ,le.populated_work_phone_cnt
          ,le.populated_other_phone_cnt
          ,le.populated_active_status_cnt
          ,le.populated_active_status_mapped_cnt
          ,le.populated_votefiller2_cnt
          ,le.populated_active_other_cnt
          ,le.populated_voterstatus_cnt
          ,le.populated_voterstatus_mapped_cnt
          ,le.populated_resaddr1_cnt
          ,le.populated_resaddr2_cnt
          ,le.populated_res_city_cnt
          ,le.populated_res_state_cnt
          ,le.populated_res_zip_cnt
          ,le.populated_res_county_cnt
          ,le.populated_mail_addr1_cnt
          ,le.populated_mail_addr2_cnt
          ,le.populated_mail_city_cnt
          ,le.populated_mail_state_cnt
          ,le.populated_mail_zip_cnt
          ,le.populated_mail_county_cnt
          ,le.populated_addr_filler1_cnt
          ,le.populated_addr_filler2_cnt
          ,le.populated_city_filler_cnt
          ,le.populated_state_filler_cnt
          ,le.populated_zip_filler_cnt
          ,le.populated_county_filler_cnt
          ,le.populated_towncode_cnt
          ,le.populated_distcode_cnt
          ,le.populated_countycode_cnt
          ,le.populated_schoolcode_cnt
          ,le.populated_cityinout_cnt
          ,le.populated_spec_dist1_cnt
          ,le.populated_spec_dist2_cnt
          ,le.populated_precinct1_cnt
          ,le.populated_precinct2_cnt
          ,le.populated_precinct3_cnt
          ,le.populated_villageprecinct_cnt
          ,le.populated_schoolprecinct_cnt
          ,le.populated_ward_cnt
          ,le.populated_precinct_citytown_cnt
          ,le.populated_ancsmdindc_cnt
          ,le.populated_citycouncildist_cnt
          ,le.populated_countycommdist_cnt
          ,le.populated_statehouse_cnt
          ,le.populated_statesenate_cnt
          ,le.populated_ushouse_cnt
          ,le.populated_elemschooldist_cnt
          ,le.populated_schooldist_cnt
          ,le.populated_schoolfiller_cnt
          ,le.populated_commcolldist_cnt
          ,le.populated_dist_filler_cnt
          ,le.populated_municipal_cnt
          ,le.populated_villagedist_cnt
          ,le.populated_policejury_cnt
          ,le.populated_policedist_cnt
          ,le.populated_publicservcomm_cnt
          ,le.populated_rescue_cnt
          ,le.populated_fire_cnt
          ,le.populated_sanitary_cnt
          ,le.populated_sewerdist_cnt
          ,le.populated_waterdist_cnt
          ,le.populated_mosquitodist_cnt
          ,le.populated_taxdist_cnt
          ,le.populated_supremecourt_cnt
          ,le.populated_justiceofpeace_cnt
          ,le.populated_judicialdist_cnt
          ,le.populated_superiorctdist_cnt
          ,le.populated_appealsct_cnt
          ,le.populated_courtfiller_cnt
          ,le.populated_contributorparty_cnt
          ,le.populated_recptparty_cnt
          ,le.populated_dateofcontr_cnt
          ,le.populated_dollaramt_cnt
          ,le.populated_officecontto_cnt
          ,le.populated_cumuldollaramt_cnt
          ,le.populated_contfiller1_cnt
          ,le.populated_contfiller2_cnt
          ,le.populated_conttype_cnt
          ,le.populated_contfiller3_cnt
          ,le.populated_primary02_cnt
          ,le.populated_special02_cnt
          ,le.populated_other02_cnt
          ,le.populated_special202_cnt
          ,le.populated_general02_cnt
          ,le.populated_primary01_cnt
          ,le.populated_special01_cnt
          ,le.populated_other01_cnt
          ,le.populated_special201_cnt
          ,le.populated_general01_cnt
          ,le.populated_pres00_cnt
          ,le.populated_primary00_cnt
          ,le.populated_special00_cnt
          ,le.populated_other00_cnt
          ,le.populated_special200_cnt
          ,le.populated_general00_cnt
          ,le.populated_primary99_cnt
          ,le.populated_special99_cnt
          ,le.populated_other99_cnt
          ,le.populated_special299_cnt
          ,le.populated_general99_cnt
          ,le.populated_primary98_cnt
          ,le.populated_special98_cnt
          ,le.populated_other98_cnt
          ,le.populated_special298_cnt
          ,le.populated_general98_cnt
          ,le.populated_primary97_cnt
          ,le.populated_special97_cnt
          ,le.populated_other97_cnt
          ,le.populated_special297_cnt
          ,le.populated_general97_cnt
          ,le.populated_pres96_cnt
          ,le.populated_primary96_cnt
          ,le.populated_special96_cnt
          ,le.populated_other96_cnt
          ,le.populated_special296_cnt
          ,le.populated_general96_cnt
          ,le.populated_lastdayvote_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_score_on_input_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_record_type_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_county_cnt
          ,le.populated_county_name_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_mail_prim_range_cnt
          ,le.populated_mail_predir_cnt
          ,le.populated_mail_prim_name_cnt
          ,le.populated_mail_addr_suffix_cnt
          ,le.populated_mail_postdir_cnt
          ,le.populated_mail_unit_desig_cnt
          ,le.populated_mail_sec_range_cnt
          ,le.populated_mail_p_city_name_cnt
          ,le.populated_mail_v_city_name_cnt
          ,le.populated_mail_st_cnt
          ,le.populated_mail_ace_zip_cnt
          ,le.populated_mail_zip4_cnt
          ,le.populated_mail_cart_cnt
          ,le.populated_mail_cr_sort_sz_cnt
          ,le.populated_mail_lot_cnt
          ,le.populated_mail_lot_order_cnt
          ,le.populated_mail_dpbc_cnt
          ,le.populated_mail_chk_digit_cnt
          ,le.populated_mail_record_type_cnt
          ,le.populated_mail_ace_fips_st_cnt
          ,le.populated_mail_fipscounty_cnt
          ,le.populated_mail_geo_lat_cnt
          ,le.populated_mail_geo_long_cnt
          ,le.populated_mail_msa_cnt
          ,le.populated_mail_geo_blk_cnt
          ,le.populated_mail_geo_match_cnt
          ,le.populated_mail_err_stat_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_process_date_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_score_pcnt
          ,le.populated_best_ssn_pcnt
          ,le.populated_did_out_pcnt
          ,le.populated_source_pcnt
          ,le.populated_file_id_pcnt
          ,le.populated_vendor_id_pcnt
          ,le.populated_source_state_pcnt
          ,le.populated_source_code_pcnt
          ,le.populated_file_acquired_date_pcnt
          ,le.populated__use_pcnt
          ,le.populated_title_in_pcnt
          ,le.populated_lname_in_pcnt
          ,le.populated_fname_in_pcnt
          ,le.populated_mname_in_pcnt
          ,le.populated_maiden_prior_pcnt
          ,le.populated_name_suffix_in_pcnt
          ,le.populated_votefiller_pcnt
          ,le.populated_source_voterid_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_agecat_pcnt
          ,le.populated_headhousehold_pcnt
          ,le.populated_place_of_birth_pcnt
          ,le.populated_occupation_pcnt
          ,le.populated_maiden_name_pcnt
          ,le.populated_motorvoterid_pcnt
          ,le.populated_regsource_pcnt
          ,le.populated_regdate_pcnt
          ,le.populated_race_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_poliparty_pcnt
          ,le.populated_poliparty_mapped_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_work_phone_pcnt
          ,le.populated_other_phone_pcnt
          ,le.populated_active_status_pcnt
          ,le.populated_active_status_mapped_pcnt
          ,le.populated_votefiller2_pcnt
          ,le.populated_active_other_pcnt
          ,le.populated_voterstatus_pcnt
          ,le.populated_voterstatus_mapped_pcnt
          ,le.populated_resaddr1_pcnt
          ,le.populated_resaddr2_pcnt
          ,le.populated_res_city_pcnt
          ,le.populated_res_state_pcnt
          ,le.populated_res_zip_pcnt
          ,le.populated_res_county_pcnt
          ,le.populated_mail_addr1_pcnt
          ,le.populated_mail_addr2_pcnt
          ,le.populated_mail_city_pcnt
          ,le.populated_mail_state_pcnt
          ,le.populated_mail_zip_pcnt
          ,le.populated_mail_county_pcnt
          ,le.populated_addr_filler1_pcnt
          ,le.populated_addr_filler2_pcnt
          ,le.populated_city_filler_pcnt
          ,le.populated_state_filler_pcnt
          ,le.populated_zip_filler_pcnt
          ,le.populated_county_filler_pcnt
          ,le.populated_towncode_pcnt
          ,le.populated_distcode_pcnt
          ,le.populated_countycode_pcnt
          ,le.populated_schoolcode_pcnt
          ,le.populated_cityinout_pcnt
          ,le.populated_spec_dist1_pcnt
          ,le.populated_spec_dist2_pcnt
          ,le.populated_precinct1_pcnt
          ,le.populated_precinct2_pcnt
          ,le.populated_precinct3_pcnt
          ,le.populated_villageprecinct_pcnt
          ,le.populated_schoolprecinct_pcnt
          ,le.populated_ward_pcnt
          ,le.populated_precinct_citytown_pcnt
          ,le.populated_ancsmdindc_pcnt
          ,le.populated_citycouncildist_pcnt
          ,le.populated_countycommdist_pcnt
          ,le.populated_statehouse_pcnt
          ,le.populated_statesenate_pcnt
          ,le.populated_ushouse_pcnt
          ,le.populated_elemschooldist_pcnt
          ,le.populated_schooldist_pcnt
          ,le.populated_schoolfiller_pcnt
          ,le.populated_commcolldist_pcnt
          ,le.populated_dist_filler_pcnt
          ,le.populated_municipal_pcnt
          ,le.populated_villagedist_pcnt
          ,le.populated_policejury_pcnt
          ,le.populated_policedist_pcnt
          ,le.populated_publicservcomm_pcnt
          ,le.populated_rescue_pcnt
          ,le.populated_fire_pcnt
          ,le.populated_sanitary_pcnt
          ,le.populated_sewerdist_pcnt
          ,le.populated_waterdist_pcnt
          ,le.populated_mosquitodist_pcnt
          ,le.populated_taxdist_pcnt
          ,le.populated_supremecourt_pcnt
          ,le.populated_justiceofpeace_pcnt
          ,le.populated_judicialdist_pcnt
          ,le.populated_superiorctdist_pcnt
          ,le.populated_appealsct_pcnt
          ,le.populated_courtfiller_pcnt
          ,le.populated_contributorparty_pcnt
          ,le.populated_recptparty_pcnt
          ,le.populated_dateofcontr_pcnt
          ,le.populated_dollaramt_pcnt
          ,le.populated_officecontto_pcnt
          ,le.populated_cumuldollaramt_pcnt
          ,le.populated_contfiller1_pcnt
          ,le.populated_contfiller2_pcnt
          ,le.populated_conttype_pcnt
          ,le.populated_contfiller3_pcnt
          ,le.populated_primary02_pcnt
          ,le.populated_special02_pcnt
          ,le.populated_other02_pcnt
          ,le.populated_special202_pcnt
          ,le.populated_general02_pcnt
          ,le.populated_primary01_pcnt
          ,le.populated_special01_pcnt
          ,le.populated_other01_pcnt
          ,le.populated_special201_pcnt
          ,le.populated_general01_pcnt
          ,le.populated_pres00_pcnt
          ,le.populated_primary00_pcnt
          ,le.populated_special00_pcnt
          ,le.populated_other00_pcnt
          ,le.populated_special200_pcnt
          ,le.populated_general00_pcnt
          ,le.populated_primary99_pcnt
          ,le.populated_special99_pcnt
          ,le.populated_other99_pcnt
          ,le.populated_special299_pcnt
          ,le.populated_general99_pcnt
          ,le.populated_primary98_pcnt
          ,le.populated_special98_pcnt
          ,le.populated_other98_pcnt
          ,le.populated_special298_pcnt
          ,le.populated_general98_pcnt
          ,le.populated_primary97_pcnt
          ,le.populated_special97_pcnt
          ,le.populated_other97_pcnt
          ,le.populated_special297_pcnt
          ,le.populated_general97_pcnt
          ,le.populated_pres96_pcnt
          ,le.populated_primary96_pcnt
          ,le.populated_special96_pcnt
          ,le.populated_other96_pcnt
          ,le.populated_special296_pcnt
          ,le.populated_general96_pcnt
          ,le.populated_lastdayvote_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_score_on_input_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_county_pcnt
          ,le.populated_county_name_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_mail_prim_range_pcnt
          ,le.populated_mail_predir_pcnt
          ,le.populated_mail_prim_name_pcnt
          ,le.populated_mail_addr_suffix_pcnt
          ,le.populated_mail_postdir_pcnt
          ,le.populated_mail_unit_desig_pcnt
          ,le.populated_mail_sec_range_pcnt
          ,le.populated_mail_p_city_name_pcnt
          ,le.populated_mail_v_city_name_pcnt
          ,le.populated_mail_st_pcnt
          ,le.populated_mail_ace_zip_pcnt
          ,le.populated_mail_zip4_pcnt
          ,le.populated_mail_cart_pcnt
          ,le.populated_mail_cr_sort_sz_pcnt
          ,le.populated_mail_lot_pcnt
          ,le.populated_mail_lot_order_pcnt
          ,le.populated_mail_dpbc_pcnt
          ,le.populated_mail_chk_digit_pcnt
          ,le.populated_mail_record_type_pcnt
          ,le.populated_mail_ace_fips_st_pcnt
          ,le.populated_mail_fipscounty_pcnt
          ,le.populated_mail_geo_lat_pcnt
          ,le.populated_mail_geo_long_pcnt
          ,le.populated_mail_msa_pcnt
          ,le.populated_mail_geo_blk_pcnt
          ,le.populated_mail_geo_match_pcnt
          ,le.populated_mail_err_stat_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,213,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Voters_Delta(prevDS, PROJECT(h, Voters_Layout_eMerges));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),213,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Voters_Layout_eMerges) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_eMerges, Voters_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;

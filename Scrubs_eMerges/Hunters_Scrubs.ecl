IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Hunters_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 187;
  EXPORT NumRulesFromFieldType := 187;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 180;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Hunters_Layout_eMerges)
    UNSIGNED1 persistent_record_id_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 score_Invalid;
    UNSIGNED1 best_ssn_Invalid;
    UNSIGNED1 did_out_Invalid;
    UNSIGNED1 file_id_Invalid;
    UNSIGNED1 vendor_id_Invalid;
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
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 work_phone_Invalid;
    UNSIGNED1 other_phone_Invalid;
    UNSIGNED1 active_status_Invalid;
    UNSIGNED1 active_other_Invalid;
    UNSIGNED1 voterstatus_Invalid;
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
    UNSIGNED1 huntfishperm_Invalid;
    UNSIGNED1 license_type_mapped_Invalid;
    UNSIGNED1 datelicense_Invalid;
    UNSIGNED1 homestate_Invalid;
    UNSIGNED1 resident_Invalid;
    UNSIGNED1 nonresident_Invalid;
    UNSIGNED1 hunt_Invalid;
    UNSIGNED1 fish_Invalid;
    UNSIGNED1 combosuper_Invalid;
    UNSIGNED1 sportsman_Invalid;
    UNSIGNED1 trap_Invalid;
    UNSIGNED1 archery_Invalid;
    UNSIGNED1 muzzle_Invalid;
    UNSIGNED1 drawing_Invalid;
    UNSIGNED1 day1_Invalid;
    UNSIGNED1 day3_Invalid;
    UNSIGNED1 day7_Invalid;
    UNSIGNED1 day14to15_Invalid;
    UNSIGNED1 seasonannual_Invalid;
    UNSIGNED1 lifetimepermit_Invalid;
    UNSIGNED1 landowner_Invalid;
    UNSIGNED1 family_Invalid;
    UNSIGNED1 junior_Invalid;
    UNSIGNED1 seniorcit_Invalid;
    UNSIGNED1 crewmemeber_Invalid;
    UNSIGNED1 retarded_Invalid;
    UNSIGNED1 indian_Invalid;
    UNSIGNED1 serviceman_Invalid;
    UNSIGNED1 disabled_Invalid;
    UNSIGNED1 lowincome_Invalid;
    UNSIGNED1 regioncounty_Invalid;
    UNSIGNED1 blind_Invalid;
    UNSIGNED1 salmon_Invalid;
    UNSIGNED1 freshwater_Invalid;
    UNSIGNED1 saltwater_Invalid;
    UNSIGNED1 lakesandresevoirs_Invalid;
    UNSIGNED1 setlinefish_Invalid;
    UNSIGNED1 trout_Invalid;
    UNSIGNED1 fallfishing_Invalid;
    UNSIGNED1 steelhead_Invalid;
    UNSIGNED1 whitejubherring_Invalid;
    UNSIGNED1 sturgeon_Invalid;
    UNSIGNED1 shellfishcrab_Invalid;
    UNSIGNED1 shellfishlobster_Invalid;
    UNSIGNED1 deer_Invalid;
    UNSIGNED1 bear_Invalid;
    UNSIGNED1 elk_Invalid;
    UNSIGNED1 moose_Invalid;
    UNSIGNED1 buffalo_Invalid;
    UNSIGNED1 antelope_Invalid;
    UNSIGNED1 sikebull_Invalid;
    UNSIGNED1 bighorn_Invalid;
    UNSIGNED1 javelina_Invalid;
    UNSIGNED1 cougar_Invalid;
    UNSIGNED1 anterless_Invalid;
    UNSIGNED1 pheasant_Invalid;
    UNSIGNED1 goose_Invalid;
    UNSIGNED1 duck_Invalid;
    UNSIGNED1 turkey_Invalid;
    UNSIGNED1 snowmobile_Invalid;
    UNSIGNED1 biggame_Invalid;
    UNSIGNED1 skipass_Invalid;
    UNSIGNED1 migbird_Invalid;
    UNSIGNED1 smallgame_Invalid;
    UNSIGNED1 sturgeon2_Invalid;
    UNSIGNED1 gun_Invalid;
    UNSIGNED1 bonus_Invalid;
    UNSIGNED1 lottery_Invalid;
    UNSIGNED1 otherbirds_Invalid;
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
  EXPORT  Bitmap_Layout := RECORD(Hunters_Layout_eMerges)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
  END;
  EXPORT Rule_Layout := RECORD(Hunters_Layout_eMerges)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'persistent_record_id:Invalid_No:ALLOW'
          ,'process_date:Invalid_Date:CUSTOM'
          ,'date_first_seen:Invalid_Date:CUSTOM'
          ,'date_last_seen:Invalid_Date:CUSTOM'
          ,'score:Invalid_No:ALLOW'
          ,'best_ssn:Invalid_Float:ALLOW'
          ,'did_out:Invalid_No:ALLOW'
          ,'file_id:Invalid_Alpha:ALLOW'
          ,'vendor_id:Invalid_No:ALLOW'
          ,'source_state:Invalid_State:ALLOW','source_state:Invalid_State:LENGTHS'
          ,'source_code:Invalid_Alpha:ALLOW'
          ,'file_acquired_date:Invalid_Date:CUSTOM'
          ,'_use:Invalid_AlphaNum:ALLOW'
          ,'title_in:Invalid_Alpha:ALLOW'
          ,'lname_in:Invalid_Alpha:ALLOW'
          ,'fname_in:Invalid_Alpha:ALLOW'
          ,'mname_in:Invalid_Alpha:ALLOW'
          ,'maiden_prior:Invalid_Alpha:ALLOW'
          ,'name_suffix_in:Invalid_Alpha:ALLOW'
          ,'source_voterid:Invalid_No:ALLOW'
          ,'dob:Invalid_Date:CUSTOM'
          ,'agecat:Invalid_No:ALLOW'
          ,'headhousehold:Invalid_Alpha:ALLOW'
          ,'place_of_birth:Invalid_Date:CUSTOM'
          ,'occupation:Invalid_Alpha:ALLOW'
          ,'maiden_name:Invalid_Alpha:ALLOW'
          ,'motorvoterid:Invalid_No:ALLOW'
          ,'regsource:Invalid_AlphaNum:ALLOW'
          ,'regdate:Invalid_Date:CUSTOM'
          ,'race:Invalid_Alpha:ALLOW'
          ,'gender:Invalid_Alpha:ALLOW'
          ,'poliparty:Invalid_No:ALLOW'
          ,'phone:Invalid_Float:ALLOW'
          ,'work_phone:Invalid_Float:ALLOW'
          ,'other_phone:Invalid_Float:ALLOW'
          ,'active_status:Invalid_Alpha:ALLOW'
          ,'active_other:Invalid_Alpha:ALLOW'
          ,'voterstatus:Invalid_Alpha:ALLOW'
          ,'resaddr1:Invalid_AlphaNum:ALLOW'
          ,'resaddr2:Invalid_AlphaNum:ALLOW'
          ,'res_city:Invalid_Alpha:ALLOW'
          ,'res_state:Invalid_State:ALLOW','res_state:Invalid_State:LENGTHS'
          ,'res_zip:Invalid_Zip:ALLOW','res_zip:Invalid_Zip:LENGTHS'
          ,'res_county:Invalid_Alpha:ALLOW'
          ,'mail_addr1:Invalid_AlphaNum:ALLOW'
          ,'mail_addr2:Invalid_Alpha:ALLOW'
          ,'mail_city:Invalid_Alpha:ALLOW'
          ,'mail_state:Invalid_State:ALLOW','mail_state:Invalid_State:LENGTHS'
          ,'mail_zip:Invalid_Zip:ALLOW','mail_zip:Invalid_Zip:LENGTHS'
          ,'mail_county:Invalid_AlphaNum:ALLOW'
          ,'huntfishperm:Invalid_AlphaNum:ALLOW'
          ,'license_type_mapped:Invalid_Alpha:ALLOW'
          ,'datelicense:Invalid_Date:CUSTOM'
          ,'homestate:Invalid_AlphaNum:ALLOW'
          ,'resident:Invalid_Alpha:ALLOW'
          ,'nonresident:Invalid_Alpha:ALLOW'
          ,'hunt:Invalid_Alpha:ALLOW'
          ,'fish:Invalid_Alpha:ALLOW'
          ,'combosuper:Invalid_Alpha:ALLOW'
          ,'sportsman:Invalid_Alpha:ALLOW'
          ,'trap:Invalid_Alpha:ALLOW'
          ,'archery:Invalid_Alpha:ALLOW'
          ,'muzzle:Invalid_Alpha:ALLOW'
          ,'drawing:Invalid_Alpha:ALLOW'
          ,'day1:Invalid_Date:CUSTOM'
          ,'day3:Invalid_Date:CUSTOM'
          ,'day7:Invalid_Date:CUSTOM'
          ,'day14to15:Invalid_Date:CUSTOM'
          ,'seasonannual:Invalid_Date:CUSTOM'
          ,'lifetimepermit:Invalid_Alpha:ALLOW'
          ,'landowner:Invalid_Alpha:ALLOW'
          ,'family:Invalid_Alpha:ALLOW'
          ,'junior:Invalid_Alpha:ALLOW'
          ,'seniorcit:Invalid_Alpha:ALLOW'
          ,'crewmemeber:Invalid_Alpha:ALLOW'
          ,'retarded:Invalid_Alpha:ALLOW'
          ,'indian:Invalid_Alpha:ALLOW'
          ,'serviceman:Invalid_Alpha:ALLOW'
          ,'disabled:Invalid_Alpha:ALLOW'
          ,'lowincome:Invalid_Alpha:ALLOW'
          ,'regioncounty:Invalid_Alpha:ALLOW'
          ,'blind:Invalid_Alpha:ALLOW'
          ,'salmon:Invalid_Alpha:ALLOW'
          ,'freshwater:Invalid_Alpha:ALLOW'
          ,'saltwater:Invalid_Alpha:ALLOW'
          ,'lakesandresevoirs:Invalid_Alpha:ALLOW'
          ,'setlinefish:Invalid_Alpha:ALLOW'
          ,'trout:Invalid_Alpha:ALLOW'
          ,'fallfishing:Invalid_Alpha:ALLOW'
          ,'steelhead:Invalid_Alpha:ALLOW'
          ,'whitejubherring:Invalid_Alpha:ALLOW'
          ,'sturgeon:Invalid_Alpha:ALLOW'
          ,'shellfishcrab:Invalid_Alpha:ALLOW'
          ,'shellfishlobster:Invalid_Alpha:ALLOW'
          ,'deer:Invalid_Alpha:ALLOW'
          ,'bear:Invalid_Alpha:ALLOW'
          ,'elk:Invalid_Alpha:ALLOW'
          ,'moose:Invalid_Alpha:ALLOW'
          ,'buffalo:Invalid_Alpha:ALLOW'
          ,'antelope:Invalid_Alpha:ALLOW'
          ,'sikebull:Invalid_Alpha:ALLOW'
          ,'bighorn:Invalid_Alpha:ALLOW'
          ,'javelina:Invalid_Alpha:ALLOW'
          ,'cougar:Invalid_Alpha:ALLOW'
          ,'anterless:Invalid_Alpha:ALLOW'
          ,'pheasant:Invalid_Alpha:ALLOW'
          ,'goose:Invalid_Alpha:ALLOW'
          ,'duck:Invalid_Alpha:ALLOW'
          ,'turkey:Invalid_Alpha:ALLOW'
          ,'snowmobile:Invalid_Alpha:ALLOW'
          ,'biggame:Invalid_Alpha:ALLOW'
          ,'skipass:Invalid_Alpha:ALLOW'
          ,'migbird:Invalid_Alpha:ALLOW'
          ,'smallgame:Invalid_Alpha:ALLOW'
          ,'sturgeon2:Invalid_Alpha:ALLOW'
          ,'gun:Invalid_Alpha:ALLOW'
          ,'bonus:Invalid_Alpha:ALLOW'
          ,'lottery:Invalid_Alpha:ALLOW'
          ,'otherbirds:Invalid_Alpha:ALLOW'
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
          ,'ace_fips_st:Invalid_No:ALLOW'
          ,'county:Invalid_No:ALLOW'
          ,'county_name:Invalid_Alpha:ALLOW'
          ,'geo_lat:Invalid_Float:ALLOW'
          ,'geo_long:Invalid_Float:ALLOW'
          ,'msa:Invalid_Float:ALLOW'
          ,'geo_blk:Invalid_Float:ALLOW'
          ,'geo_match:Invalid_Float:ALLOW'
          ,'err_stat:Invalid_AlphaNum:ALLOW'
          ,'mail_prim_range:Invalid_No:ALLOW'
          ,'mail_predir:Invalid_AlphaNum:ALLOW'
          ,'mail_prim_name:Invalid_Alpha:ALLOW'
          ,'mail_addr_suffix:Invalid_Alpha:ALLOW'
          ,'mail_postdir:Invalid_Alpha:ALLOW'
          ,'mail_unit_desig:Invalid_Alpha:ALLOW'
          ,'mail_sec_range:Invalid_No:ALLOW'
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
          ,Hunters_Fields.InvalidMessage_persistent_record_id(1)
          ,Hunters_Fields.InvalidMessage_process_date(1)
          ,Hunters_Fields.InvalidMessage_date_first_seen(1)
          ,Hunters_Fields.InvalidMessage_date_last_seen(1)
          ,Hunters_Fields.InvalidMessage_score(1)
          ,Hunters_Fields.InvalidMessage_best_ssn(1)
          ,Hunters_Fields.InvalidMessage_did_out(1)
          ,Hunters_Fields.InvalidMessage_file_id(1)
          ,Hunters_Fields.InvalidMessage_vendor_id(1)
          ,Hunters_Fields.InvalidMessage_source_state(1),Hunters_Fields.InvalidMessage_source_state(2)
          ,Hunters_Fields.InvalidMessage_source_code(1)
          ,Hunters_Fields.InvalidMessage_file_acquired_date(1)
          ,Hunters_Fields.InvalidMessage__use(1)
          ,Hunters_Fields.InvalidMessage_title_in(1)
          ,Hunters_Fields.InvalidMessage_lname_in(1)
          ,Hunters_Fields.InvalidMessage_fname_in(1)
          ,Hunters_Fields.InvalidMessage_mname_in(1)
          ,Hunters_Fields.InvalidMessage_maiden_prior(1)
          ,Hunters_Fields.InvalidMessage_name_suffix_in(1)
          ,Hunters_Fields.InvalidMessage_source_voterid(1)
          ,Hunters_Fields.InvalidMessage_dob(1)
          ,Hunters_Fields.InvalidMessage_agecat(1)
          ,Hunters_Fields.InvalidMessage_headhousehold(1)
          ,Hunters_Fields.InvalidMessage_place_of_birth(1)
          ,Hunters_Fields.InvalidMessage_occupation(1)
          ,Hunters_Fields.InvalidMessage_maiden_name(1)
          ,Hunters_Fields.InvalidMessage_motorvoterid(1)
          ,Hunters_Fields.InvalidMessage_regsource(1)
          ,Hunters_Fields.InvalidMessage_regdate(1)
          ,Hunters_Fields.InvalidMessage_race(1)
          ,Hunters_Fields.InvalidMessage_gender(1)
          ,Hunters_Fields.InvalidMessage_poliparty(1)
          ,Hunters_Fields.InvalidMessage_phone(1)
          ,Hunters_Fields.InvalidMessage_work_phone(1)
          ,Hunters_Fields.InvalidMessage_other_phone(1)
          ,Hunters_Fields.InvalidMessage_active_status(1)
          ,Hunters_Fields.InvalidMessage_active_other(1)
          ,Hunters_Fields.InvalidMessage_voterstatus(1)
          ,Hunters_Fields.InvalidMessage_resaddr1(1)
          ,Hunters_Fields.InvalidMessage_resaddr2(1)
          ,Hunters_Fields.InvalidMessage_res_city(1)
          ,Hunters_Fields.InvalidMessage_res_state(1),Hunters_Fields.InvalidMessage_res_state(2)
          ,Hunters_Fields.InvalidMessage_res_zip(1),Hunters_Fields.InvalidMessage_res_zip(2)
          ,Hunters_Fields.InvalidMessage_res_county(1)
          ,Hunters_Fields.InvalidMessage_mail_addr1(1)
          ,Hunters_Fields.InvalidMessage_mail_addr2(1)
          ,Hunters_Fields.InvalidMessage_mail_city(1)
          ,Hunters_Fields.InvalidMessage_mail_state(1),Hunters_Fields.InvalidMessage_mail_state(2)
          ,Hunters_Fields.InvalidMessage_mail_zip(1),Hunters_Fields.InvalidMessage_mail_zip(2)
          ,Hunters_Fields.InvalidMessage_mail_county(1)
          ,Hunters_Fields.InvalidMessage_huntfishperm(1)
          ,Hunters_Fields.InvalidMessage_license_type_mapped(1)
          ,Hunters_Fields.InvalidMessage_datelicense(1)
          ,Hunters_Fields.InvalidMessage_homestate(1)
          ,Hunters_Fields.InvalidMessage_resident(1)
          ,Hunters_Fields.InvalidMessage_nonresident(1)
          ,Hunters_Fields.InvalidMessage_hunt(1)
          ,Hunters_Fields.InvalidMessage_fish(1)
          ,Hunters_Fields.InvalidMessage_combosuper(1)
          ,Hunters_Fields.InvalidMessage_sportsman(1)
          ,Hunters_Fields.InvalidMessage_trap(1)
          ,Hunters_Fields.InvalidMessage_archery(1)
          ,Hunters_Fields.InvalidMessage_muzzle(1)
          ,Hunters_Fields.InvalidMessage_drawing(1)
          ,Hunters_Fields.InvalidMessage_day1(1)
          ,Hunters_Fields.InvalidMessage_day3(1)
          ,Hunters_Fields.InvalidMessage_day7(1)
          ,Hunters_Fields.InvalidMessage_day14to15(1)
          ,Hunters_Fields.InvalidMessage_seasonannual(1)
          ,Hunters_Fields.InvalidMessage_lifetimepermit(1)
          ,Hunters_Fields.InvalidMessage_landowner(1)
          ,Hunters_Fields.InvalidMessage_family(1)
          ,Hunters_Fields.InvalidMessage_junior(1)
          ,Hunters_Fields.InvalidMessage_seniorcit(1)
          ,Hunters_Fields.InvalidMessage_crewmemeber(1)
          ,Hunters_Fields.InvalidMessage_retarded(1)
          ,Hunters_Fields.InvalidMessage_indian(1)
          ,Hunters_Fields.InvalidMessage_serviceman(1)
          ,Hunters_Fields.InvalidMessage_disabled(1)
          ,Hunters_Fields.InvalidMessage_lowincome(1)
          ,Hunters_Fields.InvalidMessage_regioncounty(1)
          ,Hunters_Fields.InvalidMessage_blind(1)
          ,Hunters_Fields.InvalidMessage_salmon(1)
          ,Hunters_Fields.InvalidMessage_freshwater(1)
          ,Hunters_Fields.InvalidMessage_saltwater(1)
          ,Hunters_Fields.InvalidMessage_lakesandresevoirs(1)
          ,Hunters_Fields.InvalidMessage_setlinefish(1)
          ,Hunters_Fields.InvalidMessage_trout(1)
          ,Hunters_Fields.InvalidMessage_fallfishing(1)
          ,Hunters_Fields.InvalidMessage_steelhead(1)
          ,Hunters_Fields.InvalidMessage_whitejubherring(1)
          ,Hunters_Fields.InvalidMessage_sturgeon(1)
          ,Hunters_Fields.InvalidMessage_shellfishcrab(1)
          ,Hunters_Fields.InvalidMessage_shellfishlobster(1)
          ,Hunters_Fields.InvalidMessage_deer(1)
          ,Hunters_Fields.InvalidMessage_bear(1)
          ,Hunters_Fields.InvalidMessage_elk(1)
          ,Hunters_Fields.InvalidMessage_moose(1)
          ,Hunters_Fields.InvalidMessage_buffalo(1)
          ,Hunters_Fields.InvalidMessage_antelope(1)
          ,Hunters_Fields.InvalidMessage_sikebull(1)
          ,Hunters_Fields.InvalidMessage_bighorn(1)
          ,Hunters_Fields.InvalidMessage_javelina(1)
          ,Hunters_Fields.InvalidMessage_cougar(1)
          ,Hunters_Fields.InvalidMessage_anterless(1)
          ,Hunters_Fields.InvalidMessage_pheasant(1)
          ,Hunters_Fields.InvalidMessage_goose(1)
          ,Hunters_Fields.InvalidMessage_duck(1)
          ,Hunters_Fields.InvalidMessage_turkey(1)
          ,Hunters_Fields.InvalidMessage_snowmobile(1)
          ,Hunters_Fields.InvalidMessage_biggame(1)
          ,Hunters_Fields.InvalidMessage_skipass(1)
          ,Hunters_Fields.InvalidMessage_migbird(1)
          ,Hunters_Fields.InvalidMessage_smallgame(1)
          ,Hunters_Fields.InvalidMessage_sturgeon2(1)
          ,Hunters_Fields.InvalidMessage_gun(1)
          ,Hunters_Fields.InvalidMessage_bonus(1)
          ,Hunters_Fields.InvalidMessage_lottery(1)
          ,Hunters_Fields.InvalidMessage_otherbirds(1)
          ,Hunters_Fields.InvalidMessage_title(1)
          ,Hunters_Fields.InvalidMessage_fname(1)
          ,Hunters_Fields.InvalidMessage_mname(1)
          ,Hunters_Fields.InvalidMessage_lname(1)
          ,Hunters_Fields.InvalidMessage_name_suffix(1)
          ,Hunters_Fields.InvalidMessage_score_on_input(1)
          ,Hunters_Fields.InvalidMessage_prim_range(1)
          ,Hunters_Fields.InvalidMessage_predir(1)
          ,Hunters_Fields.InvalidMessage_prim_name(1)
          ,Hunters_Fields.InvalidMessage_suffix(1)
          ,Hunters_Fields.InvalidMessage_postdir(1)
          ,Hunters_Fields.InvalidMessage_unit_desig(1)
          ,Hunters_Fields.InvalidMessage_sec_range(1)
          ,Hunters_Fields.InvalidMessage_p_city_name(1)
          ,Hunters_Fields.InvalidMessage_city_name(1)
          ,Hunters_Fields.InvalidMessage_st(1)
          ,Hunters_Fields.InvalidMessage_zip(1),Hunters_Fields.InvalidMessage_zip(2)
          ,Hunters_Fields.InvalidMessage_zip4(1)
          ,Hunters_Fields.InvalidMessage_cart(1)
          ,Hunters_Fields.InvalidMessage_cr_sort_sz(1)
          ,Hunters_Fields.InvalidMessage_lot(1)
          ,Hunters_Fields.InvalidMessage_lot_order(1)
          ,Hunters_Fields.InvalidMessage_dpbc(1)
          ,Hunters_Fields.InvalidMessage_chk_digit(1)
          ,Hunters_Fields.InvalidMessage_record_type(1)
          ,Hunters_Fields.InvalidMessage_ace_fips_st(1)
          ,Hunters_Fields.InvalidMessage_county(1)
          ,Hunters_Fields.InvalidMessage_county_name(1)
          ,Hunters_Fields.InvalidMessage_geo_lat(1)
          ,Hunters_Fields.InvalidMessage_geo_long(1)
          ,Hunters_Fields.InvalidMessage_msa(1)
          ,Hunters_Fields.InvalidMessage_geo_blk(1)
          ,Hunters_Fields.InvalidMessage_geo_match(1)
          ,Hunters_Fields.InvalidMessage_err_stat(1)
          ,Hunters_Fields.InvalidMessage_mail_prim_range(1)
          ,Hunters_Fields.InvalidMessage_mail_predir(1)
          ,Hunters_Fields.InvalidMessage_mail_prim_name(1)
          ,Hunters_Fields.InvalidMessage_mail_addr_suffix(1)
          ,Hunters_Fields.InvalidMessage_mail_postdir(1)
          ,Hunters_Fields.InvalidMessage_mail_unit_desig(1)
          ,Hunters_Fields.InvalidMessage_mail_sec_range(1)
          ,Hunters_Fields.InvalidMessage_mail_p_city_name(1)
          ,Hunters_Fields.InvalidMessage_mail_v_city_name(1)
          ,Hunters_Fields.InvalidMessage_mail_st(1)
          ,Hunters_Fields.InvalidMessage_mail_ace_zip(1),Hunters_Fields.InvalidMessage_mail_ace_zip(2)
          ,Hunters_Fields.InvalidMessage_mail_zip4(1)
          ,Hunters_Fields.InvalidMessage_mail_cart(1)
          ,Hunters_Fields.InvalidMessage_mail_cr_sort_sz(1)
          ,Hunters_Fields.InvalidMessage_mail_lot(1)
          ,Hunters_Fields.InvalidMessage_mail_lot_order(1)
          ,Hunters_Fields.InvalidMessage_mail_dpbc(1)
          ,Hunters_Fields.InvalidMessage_mail_chk_digit(1)
          ,Hunters_Fields.InvalidMessage_mail_record_type(1)
          ,Hunters_Fields.InvalidMessage_mail_ace_fips_st(1)
          ,Hunters_Fields.InvalidMessage_mail_fipscounty(1)
          ,Hunters_Fields.InvalidMessage_mail_geo_lat(1)
          ,Hunters_Fields.InvalidMessage_mail_geo_long(1)
          ,Hunters_Fields.InvalidMessage_mail_msa(1)
          ,Hunters_Fields.InvalidMessage_mail_geo_blk(1)
          ,Hunters_Fields.InvalidMessage_mail_geo_match(1)
          ,Hunters_Fields.InvalidMessage_mail_err_stat(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Hunters_Layout_eMerges) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.persistent_record_id_Invalid := Hunters_Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id);
    SELF.process_date_Invalid := Hunters_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.date_first_seen_Invalid := Hunters_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Hunters_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.score_Invalid := Hunters_Fields.InValid_score((SALT311.StrType)le.score);
    SELF.best_ssn_Invalid := Hunters_Fields.InValid_best_ssn((SALT311.StrType)le.best_ssn);
    SELF.did_out_Invalid := Hunters_Fields.InValid_did_out((SALT311.StrType)le.did_out);
    SELF.file_id_Invalid := Hunters_Fields.InValid_file_id((SALT311.StrType)le.file_id);
    SELF.vendor_id_Invalid := Hunters_Fields.InValid_vendor_id((SALT311.StrType)le.vendor_id);
    SELF.source_state_Invalid := Hunters_Fields.InValid_source_state((SALT311.StrType)le.source_state);
    SELF.source_code_Invalid := Hunters_Fields.InValid_source_code((SALT311.StrType)le.source_code);
    SELF.file_acquired_date_Invalid := Hunters_Fields.InValid_file_acquired_date((SALT311.StrType)le.file_acquired_date);
    SELF._use_Invalid := Hunters_Fields.InValid__use((SALT311.StrType)le._use);
    SELF.title_in_Invalid := Hunters_Fields.InValid_title_in((SALT311.StrType)le.title_in);
    SELF.lname_in_Invalid := Hunters_Fields.InValid_lname_in((SALT311.StrType)le.lname_in);
    SELF.fname_in_Invalid := Hunters_Fields.InValid_fname_in((SALT311.StrType)le.fname_in);
    SELF.mname_in_Invalid := Hunters_Fields.InValid_mname_in((SALT311.StrType)le.mname_in);
    SELF.maiden_prior_Invalid := Hunters_Fields.InValid_maiden_prior((SALT311.StrType)le.maiden_prior);
    SELF.name_suffix_in_Invalid := Hunters_Fields.InValid_name_suffix_in((SALT311.StrType)le.name_suffix_in);
    SELF.source_voterid_Invalid := Hunters_Fields.InValid_source_voterid((SALT311.StrType)le.source_voterid);
    SELF.dob_Invalid := Hunters_Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.agecat_Invalid := Hunters_Fields.InValid_agecat((SALT311.StrType)le.agecat);
    SELF.headhousehold_Invalid := Hunters_Fields.InValid_headhousehold((SALT311.StrType)le.headhousehold);
    SELF.place_of_birth_Invalid := Hunters_Fields.InValid_place_of_birth((SALT311.StrType)le.place_of_birth);
    SELF.occupation_Invalid := Hunters_Fields.InValid_occupation((SALT311.StrType)le.occupation);
    SELF.maiden_name_Invalid := Hunters_Fields.InValid_maiden_name((SALT311.StrType)le.maiden_name);
    SELF.motorvoterid_Invalid := Hunters_Fields.InValid_motorvoterid((SALT311.StrType)le.motorvoterid);
    SELF.regsource_Invalid := Hunters_Fields.InValid_regsource((SALT311.StrType)le.regsource);
    SELF.regdate_Invalid := Hunters_Fields.InValid_regdate((SALT311.StrType)le.regdate);
    SELF.race_Invalid := Hunters_Fields.InValid_race((SALT311.StrType)le.race);
    SELF.gender_Invalid := Hunters_Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.poliparty_Invalid := Hunters_Fields.InValid_poliparty((SALT311.StrType)le.poliparty);
    SELF.phone_Invalid := Hunters_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.work_phone_Invalid := Hunters_Fields.InValid_work_phone((SALT311.StrType)le.work_phone);
    SELF.other_phone_Invalid := Hunters_Fields.InValid_other_phone((SALT311.StrType)le.other_phone);
    SELF.active_status_Invalid := Hunters_Fields.InValid_active_status((SALT311.StrType)le.active_status);
    SELF.active_other_Invalid := Hunters_Fields.InValid_active_other((SALT311.StrType)le.active_other);
    SELF.voterstatus_Invalid := Hunters_Fields.InValid_voterstatus((SALT311.StrType)le.voterstatus);
    SELF.resaddr1_Invalid := Hunters_Fields.InValid_resaddr1((SALT311.StrType)le.resaddr1);
    SELF.resaddr2_Invalid := Hunters_Fields.InValid_resaddr2((SALT311.StrType)le.resaddr2);
    SELF.res_city_Invalid := Hunters_Fields.InValid_res_city((SALT311.StrType)le.res_city);
    SELF.res_state_Invalid := Hunters_Fields.InValid_res_state((SALT311.StrType)le.res_state);
    SELF.res_zip_Invalid := Hunters_Fields.InValid_res_zip((SALT311.StrType)le.res_zip);
    SELF.res_county_Invalid := Hunters_Fields.InValid_res_county((SALT311.StrType)le.res_county);
    SELF.mail_addr1_Invalid := Hunters_Fields.InValid_mail_addr1((SALT311.StrType)le.mail_addr1);
    SELF.mail_addr2_Invalid := Hunters_Fields.InValid_mail_addr2((SALT311.StrType)le.mail_addr2);
    SELF.mail_city_Invalid := Hunters_Fields.InValid_mail_city((SALT311.StrType)le.mail_city);
    SELF.mail_state_Invalid := Hunters_Fields.InValid_mail_state((SALT311.StrType)le.mail_state);
    SELF.mail_zip_Invalid := Hunters_Fields.InValid_mail_zip((SALT311.StrType)le.mail_zip);
    SELF.mail_county_Invalid := Hunters_Fields.InValid_mail_county((SALT311.StrType)le.mail_county);
    SELF.huntfishperm_Invalid := Hunters_Fields.InValid_huntfishperm((SALT311.StrType)le.huntfishperm);
    SELF.license_type_mapped_Invalid := Hunters_Fields.InValid_license_type_mapped((SALT311.StrType)le.license_type_mapped);
    SELF.datelicense_Invalid := Hunters_Fields.InValid_datelicense((SALT311.StrType)le.datelicense);
    SELF.homestate_Invalid := Hunters_Fields.InValid_homestate((SALT311.StrType)le.homestate);
    SELF.resident_Invalid := Hunters_Fields.InValid_resident((SALT311.StrType)le.resident);
    SELF.nonresident_Invalid := Hunters_Fields.InValid_nonresident((SALT311.StrType)le.nonresident);
    SELF.hunt_Invalid := Hunters_Fields.InValid_hunt((SALT311.StrType)le.hunt);
    SELF.fish_Invalid := Hunters_Fields.InValid_fish((SALT311.StrType)le.fish);
    SELF.combosuper_Invalid := Hunters_Fields.InValid_combosuper((SALT311.StrType)le.combosuper);
    SELF.sportsman_Invalid := Hunters_Fields.InValid_sportsman((SALT311.StrType)le.sportsman);
    SELF.trap_Invalid := Hunters_Fields.InValid_trap((SALT311.StrType)le.trap);
    SELF.archery_Invalid := Hunters_Fields.InValid_archery((SALT311.StrType)le.archery);
    SELF.muzzle_Invalid := Hunters_Fields.InValid_muzzle((SALT311.StrType)le.muzzle);
    SELF.drawing_Invalid := Hunters_Fields.InValid_drawing((SALT311.StrType)le.drawing);
    SELF.day1_Invalid := Hunters_Fields.InValid_day1((SALT311.StrType)le.day1);
    SELF.day3_Invalid := Hunters_Fields.InValid_day3((SALT311.StrType)le.day3);
    SELF.day7_Invalid := Hunters_Fields.InValid_day7((SALT311.StrType)le.day7);
    SELF.day14to15_Invalid := Hunters_Fields.InValid_day14to15((SALT311.StrType)le.day14to15);
    SELF.seasonannual_Invalid := Hunters_Fields.InValid_seasonannual((SALT311.StrType)le.seasonannual);
    SELF.lifetimepermit_Invalid := Hunters_Fields.InValid_lifetimepermit((SALT311.StrType)le.lifetimepermit);
    SELF.landowner_Invalid := Hunters_Fields.InValid_landowner((SALT311.StrType)le.landowner);
    SELF.family_Invalid := Hunters_Fields.InValid_family((SALT311.StrType)le.family);
    SELF.junior_Invalid := Hunters_Fields.InValid_junior((SALT311.StrType)le.junior);
    SELF.seniorcit_Invalid := Hunters_Fields.InValid_seniorcit((SALT311.StrType)le.seniorcit);
    SELF.crewmemeber_Invalid := Hunters_Fields.InValid_crewmemeber((SALT311.StrType)le.crewmemeber);
    SELF.retarded_Invalid := Hunters_Fields.InValid_retarded((SALT311.StrType)le.retarded);
    SELF.indian_Invalid := Hunters_Fields.InValid_indian((SALT311.StrType)le.indian);
    SELF.serviceman_Invalid := Hunters_Fields.InValid_serviceman((SALT311.StrType)le.serviceman);
    SELF.disabled_Invalid := Hunters_Fields.InValid_disabled((SALT311.StrType)le.disabled);
    SELF.lowincome_Invalid := Hunters_Fields.InValid_lowincome((SALT311.StrType)le.lowincome);
    SELF.regioncounty_Invalid := Hunters_Fields.InValid_regioncounty((SALT311.StrType)le.regioncounty);
    SELF.blind_Invalid := Hunters_Fields.InValid_blind((SALT311.StrType)le.blind);
    SELF.salmon_Invalid := Hunters_Fields.InValid_salmon((SALT311.StrType)le.salmon);
    SELF.freshwater_Invalid := Hunters_Fields.InValid_freshwater((SALT311.StrType)le.freshwater);
    SELF.saltwater_Invalid := Hunters_Fields.InValid_saltwater((SALT311.StrType)le.saltwater);
    SELF.lakesandresevoirs_Invalid := Hunters_Fields.InValid_lakesandresevoirs((SALT311.StrType)le.lakesandresevoirs);
    SELF.setlinefish_Invalid := Hunters_Fields.InValid_setlinefish((SALT311.StrType)le.setlinefish);
    SELF.trout_Invalid := Hunters_Fields.InValid_trout((SALT311.StrType)le.trout);
    SELF.fallfishing_Invalid := Hunters_Fields.InValid_fallfishing((SALT311.StrType)le.fallfishing);
    SELF.steelhead_Invalid := Hunters_Fields.InValid_steelhead((SALT311.StrType)le.steelhead);
    SELF.whitejubherring_Invalid := Hunters_Fields.InValid_whitejubherring((SALT311.StrType)le.whitejubherring);
    SELF.sturgeon_Invalid := Hunters_Fields.InValid_sturgeon((SALT311.StrType)le.sturgeon);
    SELF.shellfishcrab_Invalid := Hunters_Fields.InValid_shellfishcrab((SALT311.StrType)le.shellfishcrab);
    SELF.shellfishlobster_Invalid := Hunters_Fields.InValid_shellfishlobster((SALT311.StrType)le.shellfishlobster);
    SELF.deer_Invalid := Hunters_Fields.InValid_deer((SALT311.StrType)le.deer);
    SELF.bear_Invalid := Hunters_Fields.InValid_bear((SALT311.StrType)le.bear);
    SELF.elk_Invalid := Hunters_Fields.InValid_elk((SALT311.StrType)le.elk);
    SELF.moose_Invalid := Hunters_Fields.InValid_moose((SALT311.StrType)le.moose);
    SELF.buffalo_Invalid := Hunters_Fields.InValid_buffalo((SALT311.StrType)le.buffalo);
    SELF.antelope_Invalid := Hunters_Fields.InValid_antelope((SALT311.StrType)le.antelope);
    SELF.sikebull_Invalid := Hunters_Fields.InValid_sikebull((SALT311.StrType)le.sikebull);
    SELF.bighorn_Invalid := Hunters_Fields.InValid_bighorn((SALT311.StrType)le.bighorn);
    SELF.javelina_Invalid := Hunters_Fields.InValid_javelina((SALT311.StrType)le.javelina);
    SELF.cougar_Invalid := Hunters_Fields.InValid_cougar((SALT311.StrType)le.cougar);
    SELF.anterless_Invalid := Hunters_Fields.InValid_anterless((SALT311.StrType)le.anterless);
    SELF.pheasant_Invalid := Hunters_Fields.InValid_pheasant((SALT311.StrType)le.pheasant);
    SELF.goose_Invalid := Hunters_Fields.InValid_goose((SALT311.StrType)le.goose);
    SELF.duck_Invalid := Hunters_Fields.InValid_duck((SALT311.StrType)le.duck);
    SELF.turkey_Invalid := Hunters_Fields.InValid_turkey((SALT311.StrType)le.turkey);
    SELF.snowmobile_Invalid := Hunters_Fields.InValid_snowmobile((SALT311.StrType)le.snowmobile);
    SELF.biggame_Invalid := Hunters_Fields.InValid_biggame((SALT311.StrType)le.biggame);
    SELF.skipass_Invalid := Hunters_Fields.InValid_skipass((SALT311.StrType)le.skipass);
    SELF.migbird_Invalid := Hunters_Fields.InValid_migbird((SALT311.StrType)le.migbird);
    SELF.smallgame_Invalid := Hunters_Fields.InValid_smallgame((SALT311.StrType)le.smallgame);
    SELF.sturgeon2_Invalid := Hunters_Fields.InValid_sturgeon2((SALT311.StrType)le.sturgeon2);
    SELF.gun_Invalid := Hunters_Fields.InValid_gun((SALT311.StrType)le.gun);
    SELF.bonus_Invalid := Hunters_Fields.InValid_bonus((SALT311.StrType)le.bonus);
    SELF.lottery_Invalid := Hunters_Fields.InValid_lottery((SALT311.StrType)le.lottery);
    SELF.otherbirds_Invalid := Hunters_Fields.InValid_otherbirds((SALT311.StrType)le.otherbirds);
    SELF.title_Invalid := Hunters_Fields.InValid_title((SALT311.StrType)le.title);
    SELF.fname_Invalid := Hunters_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := Hunters_Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := Hunters_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.name_suffix_Invalid := Hunters_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.score_on_input_Invalid := Hunters_Fields.InValid_score_on_input((SALT311.StrType)le.score_on_input);
    SELF.prim_range_Invalid := Hunters_Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Hunters_Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Hunters_Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.suffix_Invalid := Hunters_Fields.InValid_suffix((SALT311.StrType)le.suffix);
    SELF.postdir_Invalid := Hunters_Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := Hunters_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Hunters_Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Hunters_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.city_name_Invalid := Hunters_Fields.InValid_city_name((SALT311.StrType)le.city_name);
    SELF.st_Invalid := Hunters_Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip_Invalid := Hunters_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.zip4_Invalid := Hunters_Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.cart_Invalid := Hunters_Fields.InValid_cart((SALT311.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Hunters_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Hunters_Fields.InValid_lot((SALT311.StrType)le.lot);
    SELF.lot_order_Invalid := Hunters_Fields.InValid_lot_order((SALT311.StrType)le.lot_order);
    SELF.dpbc_Invalid := Hunters_Fields.InValid_dpbc((SALT311.StrType)le.dpbc);
    SELF.chk_digit_Invalid := Hunters_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    SELF.record_type_Invalid := Hunters_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.ace_fips_st_Invalid := Hunters_Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st);
    SELF.county_Invalid := Hunters_Fields.InValid_county((SALT311.StrType)le.county);
    SELF.county_name_Invalid := Hunters_Fields.InValid_county_name((SALT311.StrType)le.county_name);
    SELF.geo_lat_Invalid := Hunters_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Hunters_Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    SELF.msa_Invalid := Hunters_Fields.InValid_msa((SALT311.StrType)le.msa);
    SELF.geo_blk_Invalid := Hunters_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Hunters_Fields.InValid_geo_match((SALT311.StrType)le.geo_match);
    SELF.err_stat_Invalid := Hunters_Fields.InValid_err_stat((SALT311.StrType)le.err_stat);
    SELF.mail_prim_range_Invalid := Hunters_Fields.InValid_mail_prim_range((SALT311.StrType)le.mail_prim_range);
    SELF.mail_predir_Invalid := Hunters_Fields.InValid_mail_predir((SALT311.StrType)le.mail_predir);
    SELF.mail_prim_name_Invalid := Hunters_Fields.InValid_mail_prim_name((SALT311.StrType)le.mail_prim_name);
    SELF.mail_addr_suffix_Invalid := Hunters_Fields.InValid_mail_addr_suffix((SALT311.StrType)le.mail_addr_suffix);
    SELF.mail_postdir_Invalid := Hunters_Fields.InValid_mail_postdir((SALT311.StrType)le.mail_postdir);
    SELF.mail_unit_desig_Invalid := Hunters_Fields.InValid_mail_unit_desig((SALT311.StrType)le.mail_unit_desig);
    SELF.mail_sec_range_Invalid := Hunters_Fields.InValid_mail_sec_range((SALT311.StrType)le.mail_sec_range);
    SELF.mail_p_city_name_Invalid := Hunters_Fields.InValid_mail_p_city_name((SALT311.StrType)le.mail_p_city_name);
    SELF.mail_v_city_name_Invalid := Hunters_Fields.InValid_mail_v_city_name((SALT311.StrType)le.mail_v_city_name);
    SELF.mail_st_Invalid := Hunters_Fields.InValid_mail_st((SALT311.StrType)le.mail_st);
    SELF.mail_ace_zip_Invalid := Hunters_Fields.InValid_mail_ace_zip((SALT311.StrType)le.mail_ace_zip);
    SELF.mail_zip4_Invalid := Hunters_Fields.InValid_mail_zip4((SALT311.StrType)le.mail_zip4);
    SELF.mail_cart_Invalid := Hunters_Fields.InValid_mail_cart((SALT311.StrType)le.mail_cart);
    SELF.mail_cr_sort_sz_Invalid := Hunters_Fields.InValid_mail_cr_sort_sz((SALT311.StrType)le.mail_cr_sort_sz);
    SELF.mail_lot_Invalid := Hunters_Fields.InValid_mail_lot((SALT311.StrType)le.mail_lot);
    SELF.mail_lot_order_Invalid := Hunters_Fields.InValid_mail_lot_order((SALT311.StrType)le.mail_lot_order);
    SELF.mail_dpbc_Invalid := Hunters_Fields.InValid_mail_dpbc((SALT311.StrType)le.mail_dpbc);
    SELF.mail_chk_digit_Invalid := Hunters_Fields.InValid_mail_chk_digit((SALT311.StrType)le.mail_chk_digit);
    SELF.mail_record_type_Invalid := Hunters_Fields.InValid_mail_record_type((SALT311.StrType)le.mail_record_type);
    SELF.mail_ace_fips_st_Invalid := Hunters_Fields.InValid_mail_ace_fips_st((SALT311.StrType)le.mail_ace_fips_st);
    SELF.mail_fipscounty_Invalid := Hunters_Fields.InValid_mail_fipscounty((SALT311.StrType)le.mail_fipscounty);
    SELF.mail_geo_lat_Invalid := Hunters_Fields.InValid_mail_geo_lat((SALT311.StrType)le.mail_geo_lat);
    SELF.mail_geo_long_Invalid := Hunters_Fields.InValid_mail_geo_long((SALT311.StrType)le.mail_geo_long);
    SELF.mail_msa_Invalid := Hunters_Fields.InValid_mail_msa((SALT311.StrType)le.mail_msa);
    SELF.mail_geo_blk_Invalid := Hunters_Fields.InValid_mail_geo_blk((SALT311.StrType)le.mail_geo_blk);
    SELF.mail_geo_match_Invalid := Hunters_Fields.InValid_mail_geo_match((SALT311.StrType)le.mail_geo_match);
    SELF.mail_err_stat_Invalid := Hunters_Fields.InValid_mail_err_stat((SALT311.StrType)le.mail_err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Hunters_Layout_eMerges);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.persistent_record_id_Invalid << 0 ) + ( le.process_date_Invalid << 1 ) + ( le.date_first_seen_Invalid << 2 ) + ( le.date_last_seen_Invalid << 3 ) + ( le.score_Invalid << 4 ) + ( le.best_ssn_Invalid << 5 ) + ( le.did_out_Invalid << 6 ) + ( le.file_id_Invalid << 7 ) + ( le.vendor_id_Invalid << 8 ) + ( le.source_state_Invalid << 9 ) + ( le.source_code_Invalid << 11 ) + ( le.file_acquired_date_Invalid << 12 ) + ( le._use_Invalid << 13 ) + ( le.title_in_Invalid << 14 ) + ( le.lname_in_Invalid << 15 ) + ( le.fname_in_Invalid << 16 ) + ( le.mname_in_Invalid << 17 ) + ( le.maiden_prior_Invalid << 18 ) + ( le.name_suffix_in_Invalid << 19 ) + ( le.source_voterid_Invalid << 20 ) + ( le.dob_Invalid << 21 ) + ( le.agecat_Invalid << 22 ) + ( le.headhousehold_Invalid << 23 ) + ( le.place_of_birth_Invalid << 24 ) + ( le.occupation_Invalid << 25 ) + ( le.maiden_name_Invalid << 26 ) + ( le.motorvoterid_Invalid << 27 ) + ( le.regsource_Invalid << 28 ) + ( le.regdate_Invalid << 29 ) + ( le.race_Invalid << 30 ) + ( le.gender_Invalid << 31 ) + ( le.poliparty_Invalid << 32 ) + ( le.phone_Invalid << 33 ) + ( le.work_phone_Invalid << 34 ) + ( le.other_phone_Invalid << 35 ) + ( le.active_status_Invalid << 36 ) + ( le.active_other_Invalid << 37 ) + ( le.voterstatus_Invalid << 38 ) + ( le.resaddr1_Invalid << 39 ) + ( le.resaddr2_Invalid << 40 ) + ( le.res_city_Invalid << 41 ) + ( le.res_state_Invalid << 42 ) + ( le.res_zip_Invalid << 44 ) + ( le.res_county_Invalid << 46 ) + ( le.mail_addr1_Invalid << 47 ) + ( le.mail_addr2_Invalid << 48 ) + ( le.mail_city_Invalid << 49 ) + ( le.mail_state_Invalid << 50 ) + ( le.mail_zip_Invalid << 52 ) + ( le.mail_county_Invalid << 54 ) + ( le.huntfishperm_Invalid << 55 ) + ( le.license_type_mapped_Invalid << 56 ) + ( le.datelicense_Invalid << 57 ) + ( le.homestate_Invalid << 58 ) + ( le.resident_Invalid << 59 ) + ( le.nonresident_Invalid << 60 ) + ( le.hunt_Invalid << 61 ) + ( le.fish_Invalid << 62 ) + ( le.combosuper_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.sportsman_Invalid << 0 ) + ( le.trap_Invalid << 1 ) + ( le.archery_Invalid << 2 ) + ( le.muzzle_Invalid << 3 ) + ( le.drawing_Invalid << 4 ) + ( le.day1_Invalid << 5 ) + ( le.day3_Invalid << 6 ) + ( le.day7_Invalid << 7 ) + ( le.day14to15_Invalid << 8 ) + ( le.seasonannual_Invalid << 9 ) + ( le.lifetimepermit_Invalid << 10 ) + ( le.landowner_Invalid << 11 ) + ( le.family_Invalid << 12 ) + ( le.junior_Invalid << 13 ) + ( le.seniorcit_Invalid << 14 ) + ( le.crewmemeber_Invalid << 15 ) + ( le.retarded_Invalid << 16 ) + ( le.indian_Invalid << 17 ) + ( le.serviceman_Invalid << 18 ) + ( le.disabled_Invalid << 19 ) + ( le.lowincome_Invalid << 20 ) + ( le.regioncounty_Invalid << 21 ) + ( le.blind_Invalid << 22 ) + ( le.salmon_Invalid << 23 ) + ( le.freshwater_Invalid << 24 ) + ( le.saltwater_Invalid << 25 ) + ( le.lakesandresevoirs_Invalid << 26 ) + ( le.setlinefish_Invalid << 27 ) + ( le.trout_Invalid << 28 ) + ( le.fallfishing_Invalid << 29 ) + ( le.steelhead_Invalid << 30 ) + ( le.whitejubherring_Invalid << 31 ) + ( le.sturgeon_Invalid << 32 ) + ( le.shellfishcrab_Invalid << 33 ) + ( le.shellfishlobster_Invalid << 34 ) + ( le.deer_Invalid << 35 ) + ( le.bear_Invalid << 36 ) + ( le.elk_Invalid << 37 ) + ( le.moose_Invalid << 38 ) + ( le.buffalo_Invalid << 39 ) + ( le.antelope_Invalid << 40 ) + ( le.sikebull_Invalid << 41 ) + ( le.bighorn_Invalid << 42 ) + ( le.javelina_Invalid << 43 ) + ( le.cougar_Invalid << 44 ) + ( le.anterless_Invalid << 45 ) + ( le.pheasant_Invalid << 46 ) + ( le.goose_Invalid << 47 ) + ( le.duck_Invalid << 48 ) + ( le.turkey_Invalid << 49 ) + ( le.snowmobile_Invalid << 50 ) + ( le.biggame_Invalid << 51 ) + ( le.skipass_Invalid << 52 ) + ( le.migbird_Invalid << 53 ) + ( le.smallgame_Invalid << 54 ) + ( le.sturgeon2_Invalid << 55 ) + ( le.gun_Invalid << 56 ) + ( le.bonus_Invalid << 57 ) + ( le.lottery_Invalid << 58 ) + ( le.otherbirds_Invalid << 59 ) + ( le.title_Invalid << 60 ) + ( le.fname_Invalid << 61 ) + ( le.mname_Invalid << 62 ) + ( le.lname_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.name_suffix_Invalid << 0 ) + ( le.score_on_input_Invalid << 1 ) + ( le.prim_range_Invalid << 2 ) + ( le.predir_Invalid << 3 ) + ( le.prim_name_Invalid << 4 ) + ( le.suffix_Invalid << 5 ) + ( le.postdir_Invalid << 6 ) + ( le.unit_desig_Invalid << 7 ) + ( le.sec_range_Invalid << 8 ) + ( le.p_city_name_Invalid << 9 ) + ( le.city_name_Invalid << 10 ) + ( le.st_Invalid << 11 ) + ( le.zip_Invalid << 12 ) + ( le.zip4_Invalid << 14 ) + ( le.cart_Invalid << 15 ) + ( le.cr_sort_sz_Invalid << 16 ) + ( le.lot_Invalid << 17 ) + ( le.lot_order_Invalid << 18 ) + ( le.dpbc_Invalid << 19 ) + ( le.chk_digit_Invalid << 20 ) + ( le.record_type_Invalid << 21 ) + ( le.ace_fips_st_Invalid << 22 ) + ( le.county_Invalid << 23 ) + ( le.county_name_Invalid << 24 ) + ( le.geo_lat_Invalid << 25 ) + ( le.geo_long_Invalid << 26 ) + ( le.msa_Invalid << 27 ) + ( le.geo_blk_Invalid << 28 ) + ( le.geo_match_Invalid << 29 ) + ( le.err_stat_Invalid << 30 ) + ( le.mail_prim_range_Invalid << 31 ) + ( le.mail_predir_Invalid << 32 ) + ( le.mail_prim_name_Invalid << 33 ) + ( le.mail_addr_suffix_Invalid << 34 ) + ( le.mail_postdir_Invalid << 35 ) + ( le.mail_unit_desig_Invalid << 36 ) + ( le.mail_sec_range_Invalid << 37 ) + ( le.mail_p_city_name_Invalid << 38 ) + ( le.mail_v_city_name_Invalid << 39 ) + ( le.mail_st_Invalid << 40 ) + ( le.mail_ace_zip_Invalid << 41 ) + ( le.mail_zip4_Invalid << 43 ) + ( le.mail_cart_Invalid << 44 ) + ( le.mail_cr_sort_sz_Invalid << 45 ) + ( le.mail_lot_Invalid << 46 ) + ( le.mail_lot_order_Invalid << 47 ) + ( le.mail_dpbc_Invalid << 48 ) + ( le.mail_chk_digit_Invalid << 49 ) + ( le.mail_record_type_Invalid << 50 ) + ( le.mail_ace_fips_st_Invalid << 51 ) + ( le.mail_fipscounty_Invalid << 52 ) + ( le.mail_geo_lat_Invalid << 53 ) + ( le.mail_geo_long_Invalid << 54 ) + ( le.mail_msa_Invalid << 55 ) + ( le.mail_geo_blk_Invalid << 56 ) + ( le.mail_geo_match_Invalid << 57 ) + ( le.mail_err_stat_Invalid << 58 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0 OR (mask&le.ScrubsBits3)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND le.ScrubsBits3=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,Hunters_Layout_eMerges);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.persistent_record_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.score_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.best_ssn_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.did_out_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.file_id_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.vendor_id_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.source_state_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.source_code_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.file_acquired_date_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF._use_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.title_in_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.lname_in_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.fname_in_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.mname_in_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.maiden_prior_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.name_suffix_in_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.source_voterid_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.agecat_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.headhousehold_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.place_of_birth_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.occupation_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.maiden_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.motorvoterid_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.regsource_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.regdate_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.race_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.poliparty_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.work_phone_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.other_phone_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.active_status_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.active_other_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.voterstatus_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.resaddr1_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.resaddr2_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.res_city_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.res_state_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.res_zip_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.res_county_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.mail_addr1_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.mail_addr2_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.mail_city_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.mail_state_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.mail_zip_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.mail_county_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.huntfishperm_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.license_type_mapped_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.datelicense_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.homestate_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.resident_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.nonresident_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.hunt_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.fish_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.combosuper_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.sportsman_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.trap_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.archery_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.muzzle_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.drawing_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.day1_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.day3_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.day7_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.day14to15_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.seasonannual_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.lifetimepermit_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.landowner_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.family_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.junior_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.seniorcit_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.crewmemeber_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.retarded_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.indian_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.serviceman_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.disabled_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.lowincome_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.regioncounty_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.blind_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.salmon_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.freshwater_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.saltwater_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.lakesandresevoirs_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.setlinefish_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.trout_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.fallfishing_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.steelhead_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.whitejubherring_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.sturgeon_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.shellfishcrab_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.shellfishlobster_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.deer_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.bear_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.elk_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.moose_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.buffalo_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.antelope_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.sikebull_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.bighorn_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.javelina_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.cougar_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.anterless_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.pheasant_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.goose_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.duck_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.turkey_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.snowmobile_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.biggame_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.skipass_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.migbird_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.smallgame_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.sturgeon2_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.gun_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.bonus_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.lottery_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.otherbirds_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.title_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.fname_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.mname_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.lname_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.score_on_input_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.predir_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits3 >> 4) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.city_name_Invalid := (le.ScrubsBits3 >> 10) & 1;
    SELF.st_Invalid := (le.ScrubsBits3 >> 11) & 1;
    SELF.zip_Invalid := (le.ScrubsBits3 >> 12) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.cart_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.lot_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.dpbc_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.county_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.county_name_Invalid := (le.ScrubsBits3 >> 24) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF.msa_Invalid := (le.ScrubsBits3 >> 27) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits3 >> 29) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.mail_prim_range_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.mail_predir_Invalid := (le.ScrubsBits3 >> 32) & 1;
    SELF.mail_prim_name_Invalid := (le.ScrubsBits3 >> 33) & 1;
    SELF.mail_addr_suffix_Invalid := (le.ScrubsBits3 >> 34) & 1;
    SELF.mail_postdir_Invalid := (le.ScrubsBits3 >> 35) & 1;
    SELF.mail_unit_desig_Invalid := (le.ScrubsBits3 >> 36) & 1;
    SELF.mail_sec_range_Invalid := (le.ScrubsBits3 >> 37) & 1;
    SELF.mail_p_city_name_Invalid := (le.ScrubsBits3 >> 38) & 1;
    SELF.mail_v_city_name_Invalid := (le.ScrubsBits3 >> 39) & 1;
    SELF.mail_st_Invalid := (le.ScrubsBits3 >> 40) & 1;
    SELF.mail_ace_zip_Invalid := (le.ScrubsBits3 >> 41) & 3;
    SELF.mail_zip4_Invalid := (le.ScrubsBits3 >> 43) & 1;
    SELF.mail_cart_Invalid := (le.ScrubsBits3 >> 44) & 1;
    SELF.mail_cr_sort_sz_Invalid := (le.ScrubsBits3 >> 45) & 1;
    SELF.mail_lot_Invalid := (le.ScrubsBits3 >> 46) & 1;
    SELF.mail_lot_order_Invalid := (le.ScrubsBits3 >> 47) & 1;
    SELF.mail_dpbc_Invalid := (le.ScrubsBits3 >> 48) & 1;
    SELF.mail_chk_digit_Invalid := (le.ScrubsBits3 >> 49) & 1;
    SELF.mail_record_type_Invalid := (le.ScrubsBits3 >> 50) & 1;
    SELF.mail_ace_fips_st_Invalid := (le.ScrubsBits3 >> 51) & 1;
    SELF.mail_fipscounty_Invalid := (le.ScrubsBits3 >> 52) & 1;
    SELF.mail_geo_lat_Invalid := (le.ScrubsBits3 >> 53) & 1;
    SELF.mail_geo_long_Invalid := (le.ScrubsBits3 >> 54) & 1;
    SELF.mail_msa_Invalid := (le.ScrubsBits3 >> 55) & 1;
    SELF.mail_geo_blk_Invalid := (le.ScrubsBits3 >> 56) & 1;
    SELF.mail_geo_match_Invalid := (le.ScrubsBits3 >> 57) & 1;
    SELF.mail_err_stat_Invalid := (le.ScrubsBits3 >> 58) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    persistent_record_id_ALLOW_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    score_ALLOW_ErrorCount := COUNT(GROUP,h.score_Invalid=1);
    best_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=1);
    did_out_ALLOW_ErrorCount := COUNT(GROUP,h.did_out_Invalid=1);
    file_id_ALLOW_ErrorCount := COUNT(GROUP,h.file_id_Invalid=1);
    vendor_id_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_id_Invalid=1);
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
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    work_phone_ALLOW_ErrorCount := COUNT(GROUP,h.work_phone_Invalid=1);
    other_phone_ALLOW_ErrorCount := COUNT(GROUP,h.other_phone_Invalid=1);
    active_status_ALLOW_ErrorCount := COUNT(GROUP,h.active_status_Invalid=1);
    active_other_ALLOW_ErrorCount := COUNT(GROUP,h.active_other_Invalid=1);
    voterstatus_ALLOW_ErrorCount := COUNT(GROUP,h.voterstatus_Invalid=1);
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
    huntfishperm_ALLOW_ErrorCount := COUNT(GROUP,h.huntfishperm_Invalid=1);
    license_type_mapped_ALLOW_ErrorCount := COUNT(GROUP,h.license_type_mapped_Invalid=1);
    datelicense_CUSTOM_ErrorCount := COUNT(GROUP,h.datelicense_Invalid=1);
    homestate_ALLOW_ErrorCount := COUNT(GROUP,h.homestate_Invalid=1);
    resident_ALLOW_ErrorCount := COUNT(GROUP,h.resident_Invalid=1);
    nonresident_ALLOW_ErrorCount := COUNT(GROUP,h.nonresident_Invalid=1);
    hunt_ALLOW_ErrorCount := COUNT(GROUP,h.hunt_Invalid=1);
    fish_ALLOW_ErrorCount := COUNT(GROUP,h.fish_Invalid=1);
    combosuper_ALLOW_ErrorCount := COUNT(GROUP,h.combosuper_Invalid=1);
    sportsman_ALLOW_ErrorCount := COUNT(GROUP,h.sportsman_Invalid=1);
    trap_ALLOW_ErrorCount := COUNT(GROUP,h.trap_Invalid=1);
    archery_ALLOW_ErrorCount := COUNT(GROUP,h.archery_Invalid=1);
    muzzle_ALLOW_ErrorCount := COUNT(GROUP,h.muzzle_Invalid=1);
    drawing_ALLOW_ErrorCount := COUNT(GROUP,h.drawing_Invalid=1);
    day1_CUSTOM_ErrorCount := COUNT(GROUP,h.day1_Invalid=1);
    day3_CUSTOM_ErrorCount := COUNT(GROUP,h.day3_Invalid=1);
    day7_CUSTOM_ErrorCount := COUNT(GROUP,h.day7_Invalid=1);
    day14to15_CUSTOM_ErrorCount := COUNT(GROUP,h.day14to15_Invalid=1);
    seasonannual_CUSTOM_ErrorCount := COUNT(GROUP,h.seasonannual_Invalid=1);
    lifetimepermit_ALLOW_ErrorCount := COUNT(GROUP,h.lifetimepermit_Invalid=1);
    landowner_ALLOW_ErrorCount := COUNT(GROUP,h.landowner_Invalid=1);
    family_ALLOW_ErrorCount := COUNT(GROUP,h.family_Invalid=1);
    junior_ALLOW_ErrorCount := COUNT(GROUP,h.junior_Invalid=1);
    seniorcit_ALLOW_ErrorCount := COUNT(GROUP,h.seniorcit_Invalid=1);
    crewmemeber_ALLOW_ErrorCount := COUNT(GROUP,h.crewmemeber_Invalid=1);
    retarded_ALLOW_ErrorCount := COUNT(GROUP,h.retarded_Invalid=1);
    indian_ALLOW_ErrorCount := COUNT(GROUP,h.indian_Invalid=1);
    serviceman_ALLOW_ErrorCount := COUNT(GROUP,h.serviceman_Invalid=1);
    disabled_ALLOW_ErrorCount := COUNT(GROUP,h.disabled_Invalid=1);
    lowincome_ALLOW_ErrorCount := COUNT(GROUP,h.lowincome_Invalid=1);
    regioncounty_ALLOW_ErrorCount := COUNT(GROUP,h.regioncounty_Invalid=1);
    blind_ALLOW_ErrorCount := COUNT(GROUP,h.blind_Invalid=1);
    salmon_ALLOW_ErrorCount := COUNT(GROUP,h.salmon_Invalid=1);
    freshwater_ALLOW_ErrorCount := COUNT(GROUP,h.freshwater_Invalid=1);
    saltwater_ALLOW_ErrorCount := COUNT(GROUP,h.saltwater_Invalid=1);
    lakesandresevoirs_ALLOW_ErrorCount := COUNT(GROUP,h.lakesandresevoirs_Invalid=1);
    setlinefish_ALLOW_ErrorCount := COUNT(GROUP,h.setlinefish_Invalid=1);
    trout_ALLOW_ErrorCount := COUNT(GROUP,h.trout_Invalid=1);
    fallfishing_ALLOW_ErrorCount := COUNT(GROUP,h.fallfishing_Invalid=1);
    steelhead_ALLOW_ErrorCount := COUNT(GROUP,h.steelhead_Invalid=1);
    whitejubherring_ALLOW_ErrorCount := COUNT(GROUP,h.whitejubherring_Invalid=1);
    sturgeon_ALLOW_ErrorCount := COUNT(GROUP,h.sturgeon_Invalid=1);
    shellfishcrab_ALLOW_ErrorCount := COUNT(GROUP,h.shellfishcrab_Invalid=1);
    shellfishlobster_ALLOW_ErrorCount := COUNT(GROUP,h.shellfishlobster_Invalid=1);
    deer_ALLOW_ErrorCount := COUNT(GROUP,h.deer_Invalid=1);
    bear_ALLOW_ErrorCount := COUNT(GROUP,h.bear_Invalid=1);
    elk_ALLOW_ErrorCount := COUNT(GROUP,h.elk_Invalid=1);
    moose_ALLOW_ErrorCount := COUNT(GROUP,h.moose_Invalid=1);
    buffalo_ALLOW_ErrorCount := COUNT(GROUP,h.buffalo_Invalid=1);
    antelope_ALLOW_ErrorCount := COUNT(GROUP,h.antelope_Invalid=1);
    sikebull_ALLOW_ErrorCount := COUNT(GROUP,h.sikebull_Invalid=1);
    bighorn_ALLOW_ErrorCount := COUNT(GROUP,h.bighorn_Invalid=1);
    javelina_ALLOW_ErrorCount := COUNT(GROUP,h.javelina_Invalid=1);
    cougar_ALLOW_ErrorCount := COUNT(GROUP,h.cougar_Invalid=1);
    anterless_ALLOW_ErrorCount := COUNT(GROUP,h.anterless_Invalid=1);
    pheasant_ALLOW_ErrorCount := COUNT(GROUP,h.pheasant_Invalid=1);
    goose_ALLOW_ErrorCount := COUNT(GROUP,h.goose_Invalid=1);
    duck_ALLOW_ErrorCount := COUNT(GROUP,h.duck_Invalid=1);
    turkey_ALLOW_ErrorCount := COUNT(GROUP,h.turkey_Invalid=1);
    snowmobile_ALLOW_ErrorCount := COUNT(GROUP,h.snowmobile_Invalid=1);
    biggame_ALLOW_ErrorCount := COUNT(GROUP,h.biggame_Invalid=1);
    skipass_ALLOW_ErrorCount := COUNT(GROUP,h.skipass_Invalid=1);
    migbird_ALLOW_ErrorCount := COUNT(GROUP,h.migbird_Invalid=1);
    smallgame_ALLOW_ErrorCount := COUNT(GROUP,h.smallgame_Invalid=1);
    sturgeon2_ALLOW_ErrorCount := COUNT(GROUP,h.sturgeon2_Invalid=1);
    gun_ALLOW_ErrorCount := COUNT(GROUP,h.gun_Invalid=1);
    bonus_ALLOW_ErrorCount := COUNT(GROUP,h.bonus_Invalid=1);
    lottery_ALLOW_ErrorCount := COUNT(GROUP,h.lottery_Invalid=1);
    otherbirds_ALLOW_ErrorCount := COUNT(GROUP,h.otherbirds_Invalid=1);
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
    AnyRule_WithErrorsCount := COUNT(GROUP, h.persistent_record_id_Invalid > 0 OR h.process_date_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.score_Invalid > 0 OR h.best_ssn_Invalid > 0 OR h.did_out_Invalid > 0 OR h.file_id_Invalid > 0 OR h.vendor_id_Invalid > 0 OR h.source_state_Invalid > 0 OR h.source_code_Invalid > 0 OR h.file_acquired_date_Invalid > 0 OR h._use_Invalid > 0 OR h.title_in_Invalid > 0 OR h.lname_in_Invalid > 0 OR h.fname_in_Invalid > 0 OR h.mname_in_Invalid > 0 OR h.maiden_prior_Invalid > 0 OR h.name_suffix_in_Invalid > 0 OR h.source_voterid_Invalid > 0 OR h.dob_Invalid > 0 OR h.agecat_Invalid > 0 OR h.headhousehold_Invalid > 0 OR h.place_of_birth_Invalid > 0 OR h.occupation_Invalid > 0 OR h.maiden_name_Invalid > 0 OR h.motorvoterid_Invalid > 0 OR h.regsource_Invalid > 0 OR h.regdate_Invalid > 0 OR h.race_Invalid > 0 OR h.gender_Invalid > 0 OR h.poliparty_Invalid > 0 OR h.phone_Invalid > 0 OR h.work_phone_Invalid > 0 OR h.other_phone_Invalid > 0 OR h.active_status_Invalid > 0 OR h.active_other_Invalid > 0 OR h.voterstatus_Invalid > 0 OR h.resaddr1_Invalid > 0 OR h.resaddr2_Invalid > 0 OR h.res_city_Invalid > 0 OR h.res_state_Invalid > 0 OR h.res_zip_Invalid > 0 OR h.res_county_Invalid > 0 OR h.mail_addr1_Invalid > 0 OR h.mail_addr2_Invalid > 0 OR h.mail_city_Invalid > 0 OR h.mail_state_Invalid > 0 OR h.mail_zip_Invalid > 0 OR h.mail_county_Invalid > 0 OR h.huntfishperm_Invalid > 0 OR h.license_type_mapped_Invalid > 0 OR h.datelicense_Invalid > 0 OR h.homestate_Invalid > 0 OR h.resident_Invalid > 0 OR h.nonresident_Invalid > 0 OR h.hunt_Invalid > 0 OR h.fish_Invalid > 0 OR h.combosuper_Invalid > 0 OR h.sportsman_Invalid > 0 OR h.trap_Invalid > 0 OR h.archery_Invalid > 0 OR h.muzzle_Invalid > 0 OR h.drawing_Invalid > 0 OR h.day1_Invalid > 0 OR h.day3_Invalid > 0 OR h.day7_Invalid > 0 OR h.day14to15_Invalid > 0 OR h.seasonannual_Invalid > 0 OR h.lifetimepermit_Invalid > 0 OR h.landowner_Invalid > 0 OR h.family_Invalid > 0 OR h.junior_Invalid > 0 OR h.seniorcit_Invalid > 0 OR h.crewmemeber_Invalid > 0 OR h.retarded_Invalid > 0 OR h.indian_Invalid > 0 OR h.serviceman_Invalid > 0 OR h.disabled_Invalid > 0 OR h.lowincome_Invalid > 0 OR h.regioncounty_Invalid > 0 OR h.blind_Invalid > 0 OR h.salmon_Invalid > 0 OR h.freshwater_Invalid > 0 OR h.saltwater_Invalid > 0 OR h.lakesandresevoirs_Invalid > 0 OR h.setlinefish_Invalid > 0 OR h.trout_Invalid > 0 OR h.fallfishing_Invalid > 0 OR h.steelhead_Invalid > 0 OR h.whitejubherring_Invalid > 0 OR h.sturgeon_Invalid > 0 OR h.shellfishcrab_Invalid > 0 OR h.shellfishlobster_Invalid > 0 OR h.deer_Invalid > 0 OR h.bear_Invalid > 0 OR h.elk_Invalid > 0 OR h.moose_Invalid > 0 OR h.buffalo_Invalid > 0 OR h.antelope_Invalid > 0 OR h.sikebull_Invalid > 0 OR h.bighorn_Invalid > 0 OR h.javelina_Invalid > 0 OR h.cougar_Invalid > 0 OR h.anterless_Invalid > 0 OR h.pheasant_Invalid > 0 OR h.goose_Invalid > 0 OR h.duck_Invalid > 0 OR h.turkey_Invalid > 0 OR h.snowmobile_Invalid > 0 OR h.biggame_Invalid > 0 OR h.skipass_Invalid > 0 OR h.migbird_Invalid > 0 OR h.smallgame_Invalid > 0 OR h.sturgeon2_Invalid > 0 OR h.gun_Invalid > 0 OR h.bonus_Invalid > 0 OR h.lottery_Invalid > 0 OR h.otherbirds_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.score_on_input_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dpbc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.record_type_Invalid > 0 OR h.ace_fips_st_Invalid > 0 OR h.county_Invalid > 0 OR h.county_name_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.mail_prim_range_Invalid > 0 OR h.mail_predir_Invalid > 0 OR h.mail_prim_name_Invalid > 0 OR h.mail_addr_suffix_Invalid > 0 OR h.mail_postdir_Invalid > 0 OR h.mail_unit_desig_Invalid > 0 OR h.mail_sec_range_Invalid > 0 OR h.mail_p_city_name_Invalid > 0 OR h.mail_v_city_name_Invalid > 0 OR h.mail_st_Invalid > 0 OR h.mail_ace_zip_Invalid > 0 OR h.mail_zip4_Invalid > 0 OR h.mail_cart_Invalid > 0 OR h.mail_cr_sort_sz_Invalid > 0 OR h.mail_lot_Invalid > 0 OR h.mail_lot_order_Invalid > 0 OR h.mail_dpbc_Invalid > 0 OR h.mail_chk_digit_Invalid > 0 OR h.mail_record_type_Invalid > 0 OR h.mail_ace_fips_st_Invalid > 0 OR h.mail_fipscounty_Invalid > 0 OR h.mail_geo_lat_Invalid > 0 OR h.mail_geo_long_Invalid > 0 OR h.mail_msa_Invalid > 0 OR h.mail_geo_blk_Invalid > 0 OR h.mail_geo_match_Invalid > 0 OR h.mail_err_stat_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.persistent_record_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_state_Total_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_acquired_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le._use_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_prior_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_voterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.agecat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.headhousehold_ALLOW_ErrorCount > 0, 1, 0) + IF(le.place_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.occupation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.motorvoterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regsource_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.race_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.poliparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.work_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voterstatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_state_Total_ErrorCount > 0, 1, 0) + IF(le.res_zip_Total_ErrorCount > 0, 1, 0) + IF(le.res_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_state_Total_ErrorCount > 0, 1, 0) + IF(le.mail_zip_Total_ErrorCount > 0, 1, 0) + IF(le.mail_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.huntfishperm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_type_mapped_ALLOW_ErrorCount > 0, 1, 0) + IF(le.datelicense_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homestate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resident_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nonresident_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hunt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.combosuper_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sportsman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.archery_ALLOW_ErrorCount > 0, 1, 0) + IF(le.muzzle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.drawing_ALLOW_ErrorCount > 0, 1, 0) + IF(le.day1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.day3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.day7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.day14to15_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seasonannual_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lifetimepermit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.landowner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.junior_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seniorcit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.crewmemeber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.retarded_ALLOW_ErrorCount > 0, 1, 0) + IF(le.indian_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serviceman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.disabled_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lowincome_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regioncounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.blind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.salmon_ALLOW_ErrorCount > 0, 1, 0) + IF(le.freshwater_ALLOW_ErrorCount > 0, 1, 0) + IF(le.saltwater_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lakesandresevoirs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.setlinefish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trout_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fallfishing_ALLOW_ErrorCount > 0, 1, 0) + IF(le.steelhead_ALLOW_ErrorCount > 0, 1, 0) + IF(le.whitejubherring_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sturgeon_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shellfishcrab_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shellfishlobster_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deer_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bear_ALLOW_ErrorCount > 0, 1, 0) + IF(le.elk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.moose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buffalo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.antelope_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sikebull_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bighorn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.javelina_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cougar_ALLOW_ErrorCount > 0, 1, 0) + IF(le.anterless_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pheasant_ALLOW_ErrorCount > 0, 1, 0) + IF(le.goose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.duck_ALLOW_ErrorCount > 0, 1, 0) + IF(le.turkey_ALLOW_ErrorCount > 0, 1, 0) + IF(le.snowmobile_ALLOW_ErrorCount > 0, 1, 0) + IF(le.biggame_ALLOW_ErrorCount > 0, 1, 0) + IF(le.skipass_ALLOW_ErrorCount > 0, 1, 0) + IF(le.migbird_ALLOW_ErrorCount > 0, 1, 0) + IF(le.smallgame_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sturgeon2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gun_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bonus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lottery_ALLOW_ErrorCount > 0, 1, 0) + IF(le.otherbirds_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.score_on_input_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_Total_ErrorCount > 0, 1, 0) + IF(le.mail_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_err_stat_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.persistent_record_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_acquired_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le._use_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_prior_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_voterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.agecat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.headhousehold_ALLOW_ErrorCount > 0, 1, 0) + IF(le.place_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.occupation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.motorvoterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regsource_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.race_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.poliparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.work_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voterstatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.res_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.res_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mail_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mail_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.huntfishperm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_type_mapped_ALLOW_ErrorCount > 0, 1, 0) + IF(le.datelicense_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homestate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resident_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nonresident_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hunt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.combosuper_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sportsman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.archery_ALLOW_ErrorCount > 0, 1, 0) + IF(le.muzzle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.drawing_ALLOW_ErrorCount > 0, 1, 0) + IF(le.day1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.day3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.day7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.day14to15_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seasonannual_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lifetimepermit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.landowner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.junior_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seniorcit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.crewmemeber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.retarded_ALLOW_ErrorCount > 0, 1, 0) + IF(le.indian_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serviceman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.disabled_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lowincome_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regioncounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.blind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.salmon_ALLOW_ErrorCount > 0, 1, 0) + IF(le.freshwater_ALLOW_ErrorCount > 0, 1, 0) + IF(le.saltwater_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lakesandresevoirs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.setlinefish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trout_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fallfishing_ALLOW_ErrorCount > 0, 1, 0) + IF(le.steelhead_ALLOW_ErrorCount > 0, 1, 0) + IF(le.whitejubherring_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sturgeon_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shellfishcrab_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shellfishlobster_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deer_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bear_ALLOW_ErrorCount > 0, 1, 0) + IF(le.elk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.moose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buffalo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.antelope_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sikebull_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bighorn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.javelina_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cougar_ALLOW_ErrorCount > 0, 1, 0) + IF(le.anterless_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pheasant_ALLOW_ErrorCount > 0, 1, 0) + IF(le.goose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.duck_ALLOW_ErrorCount > 0, 1, 0) + IF(le.turkey_ALLOW_ErrorCount > 0, 1, 0) + IF(le.snowmobile_ALLOW_ErrorCount > 0, 1, 0) + IF(le.biggame_ALLOW_ErrorCount > 0, 1, 0) + IF(le.skipass_ALLOW_ErrorCount > 0, 1, 0) + IF(le.migbird_ALLOW_ErrorCount > 0, 1, 0) + IF(le.smallgame_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sturgeon2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gun_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bonus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lottery_ALLOW_ErrorCount > 0, 1, 0) + IF(le.otherbirds_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.score_on_input_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mail_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_err_stat_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.persistent_record_id_Invalid,le.process_date_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.score_Invalid,le.best_ssn_Invalid,le.did_out_Invalid,le.file_id_Invalid,le.vendor_id_Invalid,le.source_state_Invalid,le.source_code_Invalid,le.file_acquired_date_Invalid,le._use_Invalid,le.title_in_Invalid,le.lname_in_Invalid,le.fname_in_Invalid,le.mname_in_Invalid,le.maiden_prior_Invalid,le.name_suffix_in_Invalid,le.source_voterid_Invalid,le.dob_Invalid,le.agecat_Invalid,le.headhousehold_Invalid,le.place_of_birth_Invalid,le.occupation_Invalid,le.maiden_name_Invalid,le.motorvoterid_Invalid,le.regsource_Invalid,le.regdate_Invalid,le.race_Invalid,le.gender_Invalid,le.poliparty_Invalid,le.phone_Invalid,le.work_phone_Invalid,le.other_phone_Invalid,le.active_status_Invalid,le.active_other_Invalid,le.voterstatus_Invalid,le.resaddr1_Invalid,le.resaddr2_Invalid,le.res_city_Invalid,le.res_state_Invalid,le.res_zip_Invalid,le.res_county_Invalid,le.mail_addr1_Invalid,le.mail_addr2_Invalid,le.mail_city_Invalid,le.mail_state_Invalid,le.mail_zip_Invalid,le.mail_county_Invalid,le.huntfishperm_Invalid,le.license_type_mapped_Invalid,le.datelicense_Invalid,le.homestate_Invalid,le.resident_Invalid,le.nonresident_Invalid,le.hunt_Invalid,le.fish_Invalid,le.combosuper_Invalid,le.sportsman_Invalid,le.trap_Invalid,le.archery_Invalid,le.muzzle_Invalid,le.drawing_Invalid,le.day1_Invalid,le.day3_Invalid,le.day7_Invalid,le.day14to15_Invalid,le.seasonannual_Invalid,le.lifetimepermit_Invalid,le.landowner_Invalid,le.family_Invalid,le.junior_Invalid,le.seniorcit_Invalid,le.crewmemeber_Invalid,le.retarded_Invalid,le.indian_Invalid,le.serviceman_Invalid,le.disabled_Invalid,le.lowincome_Invalid,le.regioncounty_Invalid,le.blind_Invalid,le.salmon_Invalid,le.freshwater_Invalid,le.saltwater_Invalid,le.lakesandresevoirs_Invalid,le.setlinefish_Invalid,le.trout_Invalid,le.fallfishing_Invalid,le.steelhead_Invalid,le.whitejubherring_Invalid,le.sturgeon_Invalid,le.shellfishcrab_Invalid,le.shellfishlobster_Invalid,le.deer_Invalid,le.bear_Invalid,le.elk_Invalid,le.moose_Invalid,le.buffalo_Invalid,le.antelope_Invalid,le.sikebull_Invalid,le.bighorn_Invalid,le.javelina_Invalid,le.cougar_Invalid,le.anterless_Invalid,le.pheasant_Invalid,le.goose_Invalid,le.duck_Invalid,le.turkey_Invalid,le.snowmobile_Invalid,le.biggame_Invalid,le.skipass_Invalid,le.migbird_Invalid,le.smallgame_Invalid,le.sturgeon2_Invalid,le.gun_Invalid,le.bonus_Invalid,le.lottery_Invalid,le.otherbirds_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.score_on_input_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.record_type_Invalid,le.ace_fips_st_Invalid,le.county_Invalid,le.county_name_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.mail_prim_range_Invalid,le.mail_predir_Invalid,le.mail_prim_name_Invalid,le.mail_addr_suffix_Invalid,le.mail_postdir_Invalid,le.mail_unit_desig_Invalid,le.mail_sec_range_Invalid,le.mail_p_city_name_Invalid,le.mail_v_city_name_Invalid,le.mail_st_Invalid,le.mail_ace_zip_Invalid,le.mail_zip4_Invalid,le.mail_cart_Invalid,le.mail_cr_sort_sz_Invalid,le.mail_lot_Invalid,le.mail_lot_order_Invalid,le.mail_dpbc_Invalid,le.mail_chk_digit_Invalid,le.mail_record_type_Invalid,le.mail_ace_fips_st_Invalid,le.mail_fipscounty_Invalid,le.mail_geo_lat_Invalid,le.mail_geo_long_Invalid,le.mail_msa_Invalid,le.mail_geo_blk_Invalid,le.mail_geo_match_Invalid,le.mail_err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Hunters_Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),Hunters_Fields.InvalidMessage_process_date(le.process_date_Invalid),Hunters_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Hunters_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Hunters_Fields.InvalidMessage_score(le.score_Invalid),Hunters_Fields.InvalidMessage_best_ssn(le.best_ssn_Invalid),Hunters_Fields.InvalidMessage_did_out(le.did_out_Invalid),Hunters_Fields.InvalidMessage_file_id(le.file_id_Invalid),Hunters_Fields.InvalidMessage_vendor_id(le.vendor_id_Invalid),Hunters_Fields.InvalidMessage_source_state(le.source_state_Invalid),Hunters_Fields.InvalidMessage_source_code(le.source_code_Invalid),Hunters_Fields.InvalidMessage_file_acquired_date(le.file_acquired_date_Invalid),Hunters_Fields.InvalidMessage__use(le._use_Invalid),Hunters_Fields.InvalidMessage_title_in(le.title_in_Invalid),Hunters_Fields.InvalidMessage_lname_in(le.lname_in_Invalid),Hunters_Fields.InvalidMessage_fname_in(le.fname_in_Invalid),Hunters_Fields.InvalidMessage_mname_in(le.mname_in_Invalid),Hunters_Fields.InvalidMessage_maiden_prior(le.maiden_prior_Invalid),Hunters_Fields.InvalidMessage_name_suffix_in(le.name_suffix_in_Invalid),Hunters_Fields.InvalidMessage_source_voterid(le.source_voterid_Invalid),Hunters_Fields.InvalidMessage_dob(le.dob_Invalid),Hunters_Fields.InvalidMessage_agecat(le.agecat_Invalid),Hunters_Fields.InvalidMessage_headhousehold(le.headhousehold_Invalid),Hunters_Fields.InvalidMessage_place_of_birth(le.place_of_birth_Invalid),Hunters_Fields.InvalidMessage_occupation(le.occupation_Invalid),Hunters_Fields.InvalidMessage_maiden_name(le.maiden_name_Invalid),Hunters_Fields.InvalidMessage_motorvoterid(le.motorvoterid_Invalid),Hunters_Fields.InvalidMessage_regsource(le.regsource_Invalid),Hunters_Fields.InvalidMessage_regdate(le.regdate_Invalid),Hunters_Fields.InvalidMessage_race(le.race_Invalid),Hunters_Fields.InvalidMessage_gender(le.gender_Invalid),Hunters_Fields.InvalidMessage_poliparty(le.poliparty_Invalid),Hunters_Fields.InvalidMessage_phone(le.phone_Invalid),Hunters_Fields.InvalidMessage_work_phone(le.work_phone_Invalid),Hunters_Fields.InvalidMessage_other_phone(le.other_phone_Invalid),Hunters_Fields.InvalidMessage_active_status(le.active_status_Invalid),Hunters_Fields.InvalidMessage_active_other(le.active_other_Invalid),Hunters_Fields.InvalidMessage_voterstatus(le.voterstatus_Invalid),Hunters_Fields.InvalidMessage_resaddr1(le.resaddr1_Invalid),Hunters_Fields.InvalidMessage_resaddr2(le.resaddr2_Invalid),Hunters_Fields.InvalidMessage_res_city(le.res_city_Invalid),Hunters_Fields.InvalidMessage_res_state(le.res_state_Invalid),Hunters_Fields.InvalidMessage_res_zip(le.res_zip_Invalid),Hunters_Fields.InvalidMessage_res_county(le.res_county_Invalid),Hunters_Fields.InvalidMessage_mail_addr1(le.mail_addr1_Invalid),Hunters_Fields.InvalidMessage_mail_addr2(le.mail_addr2_Invalid),Hunters_Fields.InvalidMessage_mail_city(le.mail_city_Invalid),Hunters_Fields.InvalidMessage_mail_state(le.mail_state_Invalid),Hunters_Fields.InvalidMessage_mail_zip(le.mail_zip_Invalid),Hunters_Fields.InvalidMessage_mail_county(le.mail_county_Invalid),Hunters_Fields.InvalidMessage_huntfishperm(le.huntfishperm_Invalid),Hunters_Fields.InvalidMessage_license_type_mapped(le.license_type_mapped_Invalid),Hunters_Fields.InvalidMessage_datelicense(le.datelicense_Invalid),Hunters_Fields.InvalidMessage_homestate(le.homestate_Invalid),Hunters_Fields.InvalidMessage_resident(le.resident_Invalid),Hunters_Fields.InvalidMessage_nonresident(le.nonresident_Invalid),Hunters_Fields.InvalidMessage_hunt(le.hunt_Invalid),Hunters_Fields.InvalidMessage_fish(le.fish_Invalid),Hunters_Fields.InvalidMessage_combosuper(le.combosuper_Invalid),Hunters_Fields.InvalidMessage_sportsman(le.sportsman_Invalid),Hunters_Fields.InvalidMessage_trap(le.trap_Invalid),Hunters_Fields.InvalidMessage_archery(le.archery_Invalid),Hunters_Fields.InvalidMessage_muzzle(le.muzzle_Invalid),Hunters_Fields.InvalidMessage_drawing(le.drawing_Invalid),Hunters_Fields.InvalidMessage_day1(le.day1_Invalid),Hunters_Fields.InvalidMessage_day3(le.day3_Invalid),Hunters_Fields.InvalidMessage_day7(le.day7_Invalid),Hunters_Fields.InvalidMessage_day14to15(le.day14to15_Invalid),Hunters_Fields.InvalidMessage_seasonannual(le.seasonannual_Invalid),Hunters_Fields.InvalidMessage_lifetimepermit(le.lifetimepermit_Invalid),Hunters_Fields.InvalidMessage_landowner(le.landowner_Invalid),Hunters_Fields.InvalidMessage_family(le.family_Invalid),Hunters_Fields.InvalidMessage_junior(le.junior_Invalid),Hunters_Fields.InvalidMessage_seniorcit(le.seniorcit_Invalid),Hunters_Fields.InvalidMessage_crewmemeber(le.crewmemeber_Invalid),Hunters_Fields.InvalidMessage_retarded(le.retarded_Invalid),Hunters_Fields.InvalidMessage_indian(le.indian_Invalid),Hunters_Fields.InvalidMessage_serviceman(le.serviceman_Invalid),Hunters_Fields.InvalidMessage_disabled(le.disabled_Invalid),Hunters_Fields.InvalidMessage_lowincome(le.lowincome_Invalid),Hunters_Fields.InvalidMessage_regioncounty(le.regioncounty_Invalid),Hunters_Fields.InvalidMessage_blind(le.blind_Invalid),Hunters_Fields.InvalidMessage_salmon(le.salmon_Invalid),Hunters_Fields.InvalidMessage_freshwater(le.freshwater_Invalid),Hunters_Fields.InvalidMessage_saltwater(le.saltwater_Invalid),Hunters_Fields.InvalidMessage_lakesandresevoirs(le.lakesandresevoirs_Invalid),Hunters_Fields.InvalidMessage_setlinefish(le.setlinefish_Invalid),Hunters_Fields.InvalidMessage_trout(le.trout_Invalid),Hunters_Fields.InvalidMessage_fallfishing(le.fallfishing_Invalid),Hunters_Fields.InvalidMessage_steelhead(le.steelhead_Invalid),Hunters_Fields.InvalidMessage_whitejubherring(le.whitejubherring_Invalid),Hunters_Fields.InvalidMessage_sturgeon(le.sturgeon_Invalid),Hunters_Fields.InvalidMessage_shellfishcrab(le.shellfishcrab_Invalid),Hunters_Fields.InvalidMessage_shellfishlobster(le.shellfishlobster_Invalid),Hunters_Fields.InvalidMessage_deer(le.deer_Invalid),Hunters_Fields.InvalidMessage_bear(le.bear_Invalid),Hunters_Fields.InvalidMessage_elk(le.elk_Invalid),Hunters_Fields.InvalidMessage_moose(le.moose_Invalid),Hunters_Fields.InvalidMessage_buffalo(le.buffalo_Invalid),Hunters_Fields.InvalidMessage_antelope(le.antelope_Invalid),Hunters_Fields.InvalidMessage_sikebull(le.sikebull_Invalid),Hunters_Fields.InvalidMessage_bighorn(le.bighorn_Invalid),Hunters_Fields.InvalidMessage_javelina(le.javelina_Invalid),Hunters_Fields.InvalidMessage_cougar(le.cougar_Invalid),Hunters_Fields.InvalidMessage_anterless(le.anterless_Invalid),Hunters_Fields.InvalidMessage_pheasant(le.pheasant_Invalid),Hunters_Fields.InvalidMessage_goose(le.goose_Invalid),Hunters_Fields.InvalidMessage_duck(le.duck_Invalid),Hunters_Fields.InvalidMessage_turkey(le.turkey_Invalid),Hunters_Fields.InvalidMessage_snowmobile(le.snowmobile_Invalid),Hunters_Fields.InvalidMessage_biggame(le.biggame_Invalid),Hunters_Fields.InvalidMessage_skipass(le.skipass_Invalid),Hunters_Fields.InvalidMessage_migbird(le.migbird_Invalid),Hunters_Fields.InvalidMessage_smallgame(le.smallgame_Invalid),Hunters_Fields.InvalidMessage_sturgeon2(le.sturgeon2_Invalid),Hunters_Fields.InvalidMessage_gun(le.gun_Invalid),Hunters_Fields.InvalidMessage_bonus(le.bonus_Invalid),Hunters_Fields.InvalidMessage_lottery(le.lottery_Invalid),Hunters_Fields.InvalidMessage_otherbirds(le.otherbirds_Invalid),Hunters_Fields.InvalidMessage_title(le.title_Invalid),Hunters_Fields.InvalidMessage_fname(le.fname_Invalid),Hunters_Fields.InvalidMessage_mname(le.mname_Invalid),Hunters_Fields.InvalidMessage_lname(le.lname_Invalid),Hunters_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Hunters_Fields.InvalidMessage_score_on_input(le.score_on_input_Invalid),Hunters_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Hunters_Fields.InvalidMessage_predir(le.predir_Invalid),Hunters_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Hunters_Fields.InvalidMessage_suffix(le.suffix_Invalid),Hunters_Fields.InvalidMessage_postdir(le.postdir_Invalid),Hunters_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Hunters_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Hunters_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Hunters_Fields.InvalidMessage_city_name(le.city_name_Invalid),Hunters_Fields.InvalidMessage_st(le.st_Invalid),Hunters_Fields.InvalidMessage_zip(le.zip_Invalid),Hunters_Fields.InvalidMessage_zip4(le.zip4_Invalid),Hunters_Fields.InvalidMessage_cart(le.cart_Invalid),Hunters_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Hunters_Fields.InvalidMessage_lot(le.lot_Invalid),Hunters_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Hunters_Fields.InvalidMessage_dpbc(le.dpbc_Invalid),Hunters_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Hunters_Fields.InvalidMessage_record_type(le.record_type_Invalid),Hunters_Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),Hunters_Fields.InvalidMessage_county(le.county_Invalid),Hunters_Fields.InvalidMessage_county_name(le.county_name_Invalid),Hunters_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Hunters_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Hunters_Fields.InvalidMessage_msa(le.msa_Invalid),Hunters_Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Hunters_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Hunters_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Hunters_Fields.InvalidMessage_mail_prim_range(le.mail_prim_range_Invalid),Hunters_Fields.InvalidMessage_mail_predir(le.mail_predir_Invalid),Hunters_Fields.InvalidMessage_mail_prim_name(le.mail_prim_name_Invalid),Hunters_Fields.InvalidMessage_mail_addr_suffix(le.mail_addr_suffix_Invalid),Hunters_Fields.InvalidMessage_mail_postdir(le.mail_postdir_Invalid),Hunters_Fields.InvalidMessage_mail_unit_desig(le.mail_unit_desig_Invalid),Hunters_Fields.InvalidMessage_mail_sec_range(le.mail_sec_range_Invalid),Hunters_Fields.InvalidMessage_mail_p_city_name(le.mail_p_city_name_Invalid),Hunters_Fields.InvalidMessage_mail_v_city_name(le.mail_v_city_name_Invalid),Hunters_Fields.InvalidMessage_mail_st(le.mail_st_Invalid),Hunters_Fields.InvalidMessage_mail_ace_zip(le.mail_ace_zip_Invalid),Hunters_Fields.InvalidMessage_mail_zip4(le.mail_zip4_Invalid),Hunters_Fields.InvalidMessage_mail_cart(le.mail_cart_Invalid),Hunters_Fields.InvalidMessage_mail_cr_sort_sz(le.mail_cr_sort_sz_Invalid),Hunters_Fields.InvalidMessage_mail_lot(le.mail_lot_Invalid),Hunters_Fields.InvalidMessage_mail_lot_order(le.mail_lot_order_Invalid),Hunters_Fields.InvalidMessage_mail_dpbc(le.mail_dpbc_Invalid),Hunters_Fields.InvalidMessage_mail_chk_digit(le.mail_chk_digit_Invalid),Hunters_Fields.InvalidMessage_mail_record_type(le.mail_record_type_Invalid),Hunters_Fields.InvalidMessage_mail_ace_fips_st(le.mail_ace_fips_st_Invalid),Hunters_Fields.InvalidMessage_mail_fipscounty(le.mail_fipscounty_Invalid),Hunters_Fields.InvalidMessage_mail_geo_lat(le.mail_geo_lat_Invalid),Hunters_Fields.InvalidMessage_mail_geo_long(le.mail_geo_long_Invalid),Hunters_Fields.InvalidMessage_mail_msa(le.mail_msa_Invalid),Hunters_Fields.InvalidMessage_mail_geo_blk(le.mail_geo_blk_Invalid),Hunters_Fields.InvalidMessage_mail_geo_match(le.mail_geo_match_Invalid),Hunters_Fields.InvalidMessage_mail_err_stat(le.mail_err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.persistent_record_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.best_ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_out_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.file_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendor_id_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.work_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.active_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.active_other_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.voterstatus_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.huntfishperm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_type_mapped_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.datelicense_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.homestate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.resident_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nonresident_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hunt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fish_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.combosuper_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sportsman_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.trap_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.archery_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.muzzle_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.drawing_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.day1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.day3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.day7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.day14to15_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seasonannual_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lifetimepermit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.landowner_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.family_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.junior_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seniorcit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.crewmemeber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.retarded_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.indian_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.serviceman_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.disabled_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lowincome_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.regioncounty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.blind_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.salmon_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.freshwater_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.saltwater_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lakesandresevoirs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.setlinefish_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.trout_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fallfishing_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.steelhead_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.whitejubherring_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sturgeon_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.shellfishcrab_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.shellfishlobster_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.deer_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bear_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.elk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.moose_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.buffalo_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.antelope_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sikebull_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bighorn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.javelina_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cougar_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.anterless_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pheasant_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.goose_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.duck_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.turkey_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.snowmobile_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.biggame_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.skipass_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.migbird_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.smallgame_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sturgeon2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gun_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bonus_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lottery_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.otherbirds_Invalid,'ALLOW','UNKNOWN')
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
    SELF.FieldName := CHOOSE(c,'persistent_record_id','process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','source_voterid','dob','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','gender','poliparty','phone','work_phone','other_phone','active_status','active_other','voterstatus','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','huntfishperm','license_type_mapped','datelicense','homestate','resident','nonresident','hunt','fish','combosuper','sportsman','trap','archery','muzzle','drawing','day1','day3','day7','day14to15','seasonannual','lifetimepermit','landowner','family','junior','seniorcit','crewmemeber','retarded','indian','serviceman','disabled','lowincome','regioncounty','blind','salmon','freshwater','saltwater','lakesandresevoirs','setlinefish','trout','fallfishing','steelhead','whitejubherring','sturgeon','shellfishcrab','shellfishlobster','deer','bear','elk','moose','buffalo','antelope','sikebull','bighorn','javelina','cougar','anterless','pheasant','goose','duck','turkey','snowmobile','biggame','skipass','migbird','smallgame','sturgeon2','gun','bonus','lottery','otherbirds','title','fname','mname','lname','name_suffix','score_on_input','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_No','Invalid_Float','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_State','Invalid_Alpha','Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Date','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_AlphaNum','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.persistent_record_id,(SALT311.StrType)le.process_date,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.score,(SALT311.StrType)le.best_ssn,(SALT311.StrType)le.did_out,(SALT311.StrType)le.file_id,(SALT311.StrType)le.vendor_id,(SALT311.StrType)le.source_state,(SALT311.StrType)le.source_code,(SALT311.StrType)le.file_acquired_date,(SALT311.StrType)le._use,(SALT311.StrType)le.title_in,(SALT311.StrType)le.lname_in,(SALT311.StrType)le.fname_in,(SALT311.StrType)le.mname_in,(SALT311.StrType)le.maiden_prior,(SALT311.StrType)le.name_suffix_in,(SALT311.StrType)le.source_voterid,(SALT311.StrType)le.dob,(SALT311.StrType)le.agecat,(SALT311.StrType)le.headhousehold,(SALT311.StrType)le.place_of_birth,(SALT311.StrType)le.occupation,(SALT311.StrType)le.maiden_name,(SALT311.StrType)le.motorvoterid,(SALT311.StrType)le.regsource,(SALT311.StrType)le.regdate,(SALT311.StrType)le.race,(SALT311.StrType)le.gender,(SALT311.StrType)le.poliparty,(SALT311.StrType)le.phone,(SALT311.StrType)le.work_phone,(SALT311.StrType)le.other_phone,(SALT311.StrType)le.active_status,(SALT311.StrType)le.active_other,(SALT311.StrType)le.voterstatus,(SALT311.StrType)le.resaddr1,(SALT311.StrType)le.resaddr2,(SALT311.StrType)le.res_city,(SALT311.StrType)le.res_state,(SALT311.StrType)le.res_zip,(SALT311.StrType)le.res_county,(SALT311.StrType)le.mail_addr1,(SALT311.StrType)le.mail_addr2,(SALT311.StrType)le.mail_city,(SALT311.StrType)le.mail_state,(SALT311.StrType)le.mail_zip,(SALT311.StrType)le.mail_county,(SALT311.StrType)le.huntfishperm,(SALT311.StrType)le.license_type_mapped,(SALT311.StrType)le.datelicense,(SALT311.StrType)le.homestate,(SALT311.StrType)le.resident,(SALT311.StrType)le.nonresident,(SALT311.StrType)le.hunt,(SALT311.StrType)le.fish,(SALT311.StrType)le.combosuper,(SALT311.StrType)le.sportsman,(SALT311.StrType)le.trap,(SALT311.StrType)le.archery,(SALT311.StrType)le.muzzle,(SALT311.StrType)le.drawing,(SALT311.StrType)le.day1,(SALT311.StrType)le.day3,(SALT311.StrType)le.day7,(SALT311.StrType)le.day14to15,(SALT311.StrType)le.seasonannual,(SALT311.StrType)le.lifetimepermit,(SALT311.StrType)le.landowner,(SALT311.StrType)le.family,(SALT311.StrType)le.junior,(SALT311.StrType)le.seniorcit,(SALT311.StrType)le.crewmemeber,(SALT311.StrType)le.retarded,(SALT311.StrType)le.indian,(SALT311.StrType)le.serviceman,(SALT311.StrType)le.disabled,(SALT311.StrType)le.lowincome,(SALT311.StrType)le.regioncounty,(SALT311.StrType)le.blind,(SALT311.StrType)le.salmon,(SALT311.StrType)le.freshwater,(SALT311.StrType)le.saltwater,(SALT311.StrType)le.lakesandresevoirs,(SALT311.StrType)le.setlinefish,(SALT311.StrType)le.trout,(SALT311.StrType)le.fallfishing,(SALT311.StrType)le.steelhead,(SALT311.StrType)le.whitejubherring,(SALT311.StrType)le.sturgeon,(SALT311.StrType)le.shellfishcrab,(SALT311.StrType)le.shellfishlobster,(SALT311.StrType)le.deer,(SALT311.StrType)le.bear,(SALT311.StrType)le.elk,(SALT311.StrType)le.moose,(SALT311.StrType)le.buffalo,(SALT311.StrType)le.antelope,(SALT311.StrType)le.sikebull,(SALT311.StrType)le.bighorn,(SALT311.StrType)le.javelina,(SALT311.StrType)le.cougar,(SALT311.StrType)le.anterless,(SALT311.StrType)le.pheasant,(SALT311.StrType)le.goose,(SALT311.StrType)le.duck,(SALT311.StrType)le.turkey,(SALT311.StrType)le.snowmobile,(SALT311.StrType)le.biggame,(SALT311.StrType)le.skipass,(SALT311.StrType)le.migbird,(SALT311.StrType)le.smallgame,(SALT311.StrType)le.sturgeon2,(SALT311.StrType)le.gun,(SALT311.StrType)le.bonus,(SALT311.StrType)le.lottery,(SALT311.StrType)le.otherbirds,(SALT311.StrType)le.title,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.score_on_input,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dpbc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.record_type,(SALT311.StrType)le.ace_fips_st,(SALT311.StrType)le.county,(SALT311.StrType)le.county_name,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.msa,(SALT311.StrType)le.geo_blk,(SALT311.StrType)le.geo_match,(SALT311.StrType)le.err_stat,(SALT311.StrType)le.mail_prim_range,(SALT311.StrType)le.mail_predir,(SALT311.StrType)le.mail_prim_name,(SALT311.StrType)le.mail_addr_suffix,(SALT311.StrType)le.mail_postdir,(SALT311.StrType)le.mail_unit_desig,(SALT311.StrType)le.mail_sec_range,(SALT311.StrType)le.mail_p_city_name,(SALT311.StrType)le.mail_v_city_name,(SALT311.StrType)le.mail_st,(SALT311.StrType)le.mail_ace_zip,(SALT311.StrType)le.mail_zip4,(SALT311.StrType)le.mail_cart,(SALT311.StrType)le.mail_cr_sort_sz,(SALT311.StrType)le.mail_lot,(SALT311.StrType)le.mail_lot_order,(SALT311.StrType)le.mail_dpbc,(SALT311.StrType)le.mail_chk_digit,(SALT311.StrType)le.mail_record_type,(SALT311.StrType)le.mail_ace_fips_st,(SALT311.StrType)le.mail_fipscounty,(SALT311.StrType)le.mail_geo_lat,(SALT311.StrType)le.mail_geo_long,(SALT311.StrType)le.mail_msa,(SALT311.StrType)le.mail_geo_blk,(SALT311.StrType)le.mail_geo_match,(SALT311.StrType)le.mail_err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,180,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Hunters_Layout_eMerges) prevDS = DATASET([], Hunters_Layout_eMerges), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.persistent_record_id_ALLOW_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.score_ALLOW_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount
          ,le.did_out_ALLOW_ErrorCount
          ,le.file_id_ALLOW_ErrorCount
          ,le.vendor_id_ALLOW_ErrorCount
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
          ,le.phone_ALLOW_ErrorCount
          ,le.work_phone_ALLOW_ErrorCount
          ,le.other_phone_ALLOW_ErrorCount
          ,le.active_status_ALLOW_ErrorCount
          ,le.active_other_ALLOW_ErrorCount
          ,le.voterstatus_ALLOW_ErrorCount
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
          ,le.huntfishperm_ALLOW_ErrorCount
          ,le.license_type_mapped_ALLOW_ErrorCount
          ,le.datelicense_CUSTOM_ErrorCount
          ,le.homestate_ALLOW_ErrorCount
          ,le.resident_ALLOW_ErrorCount
          ,le.nonresident_ALLOW_ErrorCount
          ,le.hunt_ALLOW_ErrorCount
          ,le.fish_ALLOW_ErrorCount
          ,le.combosuper_ALLOW_ErrorCount
          ,le.sportsman_ALLOW_ErrorCount
          ,le.trap_ALLOW_ErrorCount
          ,le.archery_ALLOW_ErrorCount
          ,le.muzzle_ALLOW_ErrorCount
          ,le.drawing_ALLOW_ErrorCount
          ,le.day1_CUSTOM_ErrorCount
          ,le.day3_CUSTOM_ErrorCount
          ,le.day7_CUSTOM_ErrorCount
          ,le.day14to15_CUSTOM_ErrorCount
          ,le.seasonannual_CUSTOM_ErrorCount
          ,le.lifetimepermit_ALLOW_ErrorCount
          ,le.landowner_ALLOW_ErrorCount
          ,le.family_ALLOW_ErrorCount
          ,le.junior_ALLOW_ErrorCount
          ,le.seniorcit_ALLOW_ErrorCount
          ,le.crewmemeber_ALLOW_ErrorCount
          ,le.retarded_ALLOW_ErrorCount
          ,le.indian_ALLOW_ErrorCount
          ,le.serviceman_ALLOW_ErrorCount
          ,le.disabled_ALLOW_ErrorCount
          ,le.lowincome_ALLOW_ErrorCount
          ,le.regioncounty_ALLOW_ErrorCount
          ,le.blind_ALLOW_ErrorCount
          ,le.salmon_ALLOW_ErrorCount
          ,le.freshwater_ALLOW_ErrorCount
          ,le.saltwater_ALLOW_ErrorCount
          ,le.lakesandresevoirs_ALLOW_ErrorCount
          ,le.setlinefish_ALLOW_ErrorCount
          ,le.trout_ALLOW_ErrorCount
          ,le.fallfishing_ALLOW_ErrorCount
          ,le.steelhead_ALLOW_ErrorCount
          ,le.whitejubherring_ALLOW_ErrorCount
          ,le.sturgeon_ALLOW_ErrorCount
          ,le.shellfishcrab_ALLOW_ErrorCount
          ,le.shellfishlobster_ALLOW_ErrorCount
          ,le.deer_ALLOW_ErrorCount
          ,le.bear_ALLOW_ErrorCount
          ,le.elk_ALLOW_ErrorCount
          ,le.moose_ALLOW_ErrorCount
          ,le.buffalo_ALLOW_ErrorCount
          ,le.antelope_ALLOW_ErrorCount
          ,le.sikebull_ALLOW_ErrorCount
          ,le.bighorn_ALLOW_ErrorCount
          ,le.javelina_ALLOW_ErrorCount
          ,le.cougar_ALLOW_ErrorCount
          ,le.anterless_ALLOW_ErrorCount
          ,le.pheasant_ALLOW_ErrorCount
          ,le.goose_ALLOW_ErrorCount
          ,le.duck_ALLOW_ErrorCount
          ,le.turkey_ALLOW_ErrorCount
          ,le.snowmobile_ALLOW_ErrorCount
          ,le.biggame_ALLOW_ErrorCount
          ,le.skipass_ALLOW_ErrorCount
          ,le.migbird_ALLOW_ErrorCount
          ,le.smallgame_ALLOW_ErrorCount
          ,le.sturgeon2_ALLOW_ErrorCount
          ,le.gun_ALLOW_ErrorCount
          ,le.bonus_ALLOW_ErrorCount
          ,le.lottery_ALLOW_ErrorCount
          ,le.otherbirds_ALLOW_ErrorCount
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
          ,le.persistent_record_id_ALLOW_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.score_ALLOW_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount
          ,le.did_out_ALLOW_ErrorCount
          ,le.file_id_ALLOW_ErrorCount
          ,le.vendor_id_ALLOW_ErrorCount
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
          ,le.phone_ALLOW_ErrorCount
          ,le.work_phone_ALLOW_ErrorCount
          ,le.other_phone_ALLOW_ErrorCount
          ,le.active_status_ALLOW_ErrorCount
          ,le.active_other_ALLOW_ErrorCount
          ,le.voterstatus_ALLOW_ErrorCount
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
          ,le.huntfishperm_ALLOW_ErrorCount
          ,le.license_type_mapped_ALLOW_ErrorCount
          ,le.datelicense_CUSTOM_ErrorCount
          ,le.homestate_ALLOW_ErrorCount
          ,le.resident_ALLOW_ErrorCount
          ,le.nonresident_ALLOW_ErrorCount
          ,le.hunt_ALLOW_ErrorCount
          ,le.fish_ALLOW_ErrorCount
          ,le.combosuper_ALLOW_ErrorCount
          ,le.sportsman_ALLOW_ErrorCount
          ,le.trap_ALLOW_ErrorCount
          ,le.archery_ALLOW_ErrorCount
          ,le.muzzle_ALLOW_ErrorCount
          ,le.drawing_ALLOW_ErrorCount
          ,le.day1_CUSTOM_ErrorCount
          ,le.day3_CUSTOM_ErrorCount
          ,le.day7_CUSTOM_ErrorCount
          ,le.day14to15_CUSTOM_ErrorCount
          ,le.seasonannual_CUSTOM_ErrorCount
          ,le.lifetimepermit_ALLOW_ErrorCount
          ,le.landowner_ALLOW_ErrorCount
          ,le.family_ALLOW_ErrorCount
          ,le.junior_ALLOW_ErrorCount
          ,le.seniorcit_ALLOW_ErrorCount
          ,le.crewmemeber_ALLOW_ErrorCount
          ,le.retarded_ALLOW_ErrorCount
          ,le.indian_ALLOW_ErrorCount
          ,le.serviceman_ALLOW_ErrorCount
          ,le.disabled_ALLOW_ErrorCount
          ,le.lowincome_ALLOW_ErrorCount
          ,le.regioncounty_ALLOW_ErrorCount
          ,le.blind_ALLOW_ErrorCount
          ,le.salmon_ALLOW_ErrorCount
          ,le.freshwater_ALLOW_ErrorCount
          ,le.saltwater_ALLOW_ErrorCount
          ,le.lakesandresevoirs_ALLOW_ErrorCount
          ,le.setlinefish_ALLOW_ErrorCount
          ,le.trout_ALLOW_ErrorCount
          ,le.fallfishing_ALLOW_ErrorCount
          ,le.steelhead_ALLOW_ErrorCount
          ,le.whitejubherring_ALLOW_ErrorCount
          ,le.sturgeon_ALLOW_ErrorCount
          ,le.shellfishcrab_ALLOW_ErrorCount
          ,le.shellfishlobster_ALLOW_ErrorCount
          ,le.deer_ALLOW_ErrorCount
          ,le.bear_ALLOW_ErrorCount
          ,le.elk_ALLOW_ErrorCount
          ,le.moose_ALLOW_ErrorCount
          ,le.buffalo_ALLOW_ErrorCount
          ,le.antelope_ALLOW_ErrorCount
          ,le.sikebull_ALLOW_ErrorCount
          ,le.bighorn_ALLOW_ErrorCount
          ,le.javelina_ALLOW_ErrorCount
          ,le.cougar_ALLOW_ErrorCount
          ,le.anterless_ALLOW_ErrorCount
          ,le.pheasant_ALLOW_ErrorCount
          ,le.goose_ALLOW_ErrorCount
          ,le.duck_ALLOW_ErrorCount
          ,le.turkey_ALLOW_ErrorCount
          ,le.snowmobile_ALLOW_ErrorCount
          ,le.biggame_ALLOW_ErrorCount
          ,le.skipass_ALLOW_ErrorCount
          ,le.migbird_ALLOW_ErrorCount
          ,le.smallgame_ALLOW_ErrorCount
          ,le.sturgeon2_ALLOW_ErrorCount
          ,le.gun_ALLOW_ErrorCount
          ,le.bonus_ALLOW_ErrorCount
          ,le.lottery_ALLOW_ErrorCount
          ,le.otherbirds_ALLOW_ErrorCount
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
    mod_hygiene := Hunters_hygiene(PROJECT(h, Hunters_Layout_eMerges));
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
          ,'persistent_record_id:' + getFieldTypeText(h.persistent_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'work_phone:' + getFieldTypeText(h.work_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_phone:' + getFieldTypeText(h.other_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_status:' + getFieldTypeText(h.active_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'votefiller2:' + getFieldTypeText(h.votefiller2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_other:' + getFieldTypeText(h.active_other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'voterstatus:' + getFieldTypeText(h.voterstatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'historyfiller:' + getFieldTypeText(h.historyfiller) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'huntfishperm:' + getFieldTypeText(h.huntfishperm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_type_mapped:' + getFieldTypeText(h.license_type_mapped) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'datelicense:' + getFieldTypeText(h.datelicense) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'homestate:' + getFieldTypeText(h.homestate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'resident:' + getFieldTypeText(h.resident) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nonresident:' + getFieldTypeText(h.nonresident) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hunt:' + getFieldTypeText(h.hunt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fish:' + getFieldTypeText(h.fish) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'combosuper:' + getFieldTypeText(h.combosuper) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sportsman:' + getFieldTypeText(h.sportsman) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trap:' + getFieldTypeText(h.trap) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'archery:' + getFieldTypeText(h.archery) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'muzzle:' + getFieldTypeText(h.muzzle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'drawing:' + getFieldTypeText(h.drawing) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'day1:' + getFieldTypeText(h.day1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'day3:' + getFieldTypeText(h.day3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'day7:' + getFieldTypeText(h.day7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'day14to15:' + getFieldTypeText(h.day14to15) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dayfiller:' + getFieldTypeText(h.dayfiller) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seasonannual:' + getFieldTypeText(h.seasonannual) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lifetimepermit:' + getFieldTypeText(h.lifetimepermit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'landowner:' + getFieldTypeText(h.landowner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'family:' + getFieldTypeText(h.family) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'junior:' + getFieldTypeText(h.junior) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seniorcit:' + getFieldTypeText(h.seniorcit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crewmemeber:' + getFieldTypeText(h.crewmemeber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'retarded:' + getFieldTypeText(h.retarded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'indian:' + getFieldTypeText(h.indian) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'serviceman:' + getFieldTypeText(h.serviceman) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'disabled:' + getFieldTypeText(h.disabled) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lowincome:' + getFieldTypeText(h.lowincome) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regioncounty:' + getFieldTypeText(h.regioncounty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'blind:' + getFieldTypeText(h.blind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'huntfiller:' + getFieldTypeText(h.huntfiller) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'salmon:' + getFieldTypeText(h.salmon) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'freshwater:' + getFieldTypeText(h.freshwater) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'saltwater:' + getFieldTypeText(h.saltwater) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lakesandresevoirs:' + getFieldTypeText(h.lakesandresevoirs) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'setlinefish:' + getFieldTypeText(h.setlinefish) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trout:' + getFieldTypeText(h.trout) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fallfishing:' + getFieldTypeText(h.fallfishing) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'steelhead:' + getFieldTypeText(h.steelhead) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'whitejubherring:' + getFieldTypeText(h.whitejubherring) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sturgeon:' + getFieldTypeText(h.sturgeon) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'shellfishcrab:' + getFieldTypeText(h.shellfishcrab) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'shellfishlobster:' + getFieldTypeText(h.shellfishlobster) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deer:' + getFieldTypeText(h.deer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bear:' + getFieldTypeText(h.bear) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'elk:' + getFieldTypeText(h.elk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'moose:' + getFieldTypeText(h.moose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buffalo:' + getFieldTypeText(h.buffalo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'antelope:' + getFieldTypeText(h.antelope) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sikebull:' + getFieldTypeText(h.sikebull) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bighorn:' + getFieldTypeText(h.bighorn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'javelina:' + getFieldTypeText(h.javelina) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cougar:' + getFieldTypeText(h.cougar) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'anterless:' + getFieldTypeText(h.anterless) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pheasant:' + getFieldTypeText(h.pheasant) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'goose:' + getFieldTypeText(h.goose) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'duck:' + getFieldTypeText(h.duck) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'turkey:' + getFieldTypeText(h.turkey) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'snowmobile:' + getFieldTypeText(h.snowmobile) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'biggame:' + getFieldTypeText(h.biggame) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'skipass:' + getFieldTypeText(h.skipass) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'migbird:' + getFieldTypeText(h.migbird) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'smallgame:' + getFieldTypeText(h.smallgame) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sturgeon2:' + getFieldTypeText(h.sturgeon2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gun:' + getFieldTypeText(h.gun) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bonus:' + getFieldTypeText(h.bonus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lottery:' + getFieldTypeText(h.lottery) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'otherbirds:' + getFieldTypeText(h.otherbirds) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'huntfill1:' + getFieldTypeText(h.huntfill1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,le.populated_persistent_record_id_cnt
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
          ,le.populated_phone_cnt
          ,le.populated_work_phone_cnt
          ,le.populated_other_phone_cnt
          ,le.populated_active_status_cnt
          ,le.populated_votefiller2_cnt
          ,le.populated_active_other_cnt
          ,le.populated_voterstatus_cnt
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
          ,le.populated_historyfiller_cnt
          ,le.populated_huntfishperm_cnt
          ,le.populated_license_type_mapped_cnt
          ,le.populated_datelicense_cnt
          ,le.populated_homestate_cnt
          ,le.populated_resident_cnt
          ,le.populated_nonresident_cnt
          ,le.populated_hunt_cnt
          ,le.populated_fish_cnt
          ,le.populated_combosuper_cnt
          ,le.populated_sportsman_cnt
          ,le.populated_trap_cnt
          ,le.populated_archery_cnt
          ,le.populated_muzzle_cnt
          ,le.populated_drawing_cnt
          ,le.populated_day1_cnt
          ,le.populated_day3_cnt
          ,le.populated_day7_cnt
          ,le.populated_day14to15_cnt
          ,le.populated_dayfiller_cnt
          ,le.populated_seasonannual_cnt
          ,le.populated_lifetimepermit_cnt
          ,le.populated_landowner_cnt
          ,le.populated_family_cnt
          ,le.populated_junior_cnt
          ,le.populated_seniorcit_cnt
          ,le.populated_crewmemeber_cnt
          ,le.populated_retarded_cnt
          ,le.populated_indian_cnt
          ,le.populated_serviceman_cnt
          ,le.populated_disabled_cnt
          ,le.populated_lowincome_cnt
          ,le.populated_regioncounty_cnt
          ,le.populated_blind_cnt
          ,le.populated_huntfiller_cnt
          ,le.populated_salmon_cnt
          ,le.populated_freshwater_cnt
          ,le.populated_saltwater_cnt
          ,le.populated_lakesandresevoirs_cnt
          ,le.populated_setlinefish_cnt
          ,le.populated_trout_cnt
          ,le.populated_fallfishing_cnt
          ,le.populated_steelhead_cnt
          ,le.populated_whitejubherring_cnt
          ,le.populated_sturgeon_cnt
          ,le.populated_shellfishcrab_cnt
          ,le.populated_shellfishlobster_cnt
          ,le.populated_deer_cnt
          ,le.populated_bear_cnt
          ,le.populated_elk_cnt
          ,le.populated_moose_cnt
          ,le.populated_buffalo_cnt
          ,le.populated_antelope_cnt
          ,le.populated_sikebull_cnt
          ,le.populated_bighorn_cnt
          ,le.populated_javelina_cnt
          ,le.populated_cougar_cnt
          ,le.populated_anterless_cnt
          ,le.populated_pheasant_cnt
          ,le.populated_goose_cnt
          ,le.populated_duck_cnt
          ,le.populated_turkey_cnt
          ,le.populated_snowmobile_cnt
          ,le.populated_biggame_cnt
          ,le.populated_skipass_cnt
          ,le.populated_migbird_cnt
          ,le.populated_smallgame_cnt
          ,le.populated_sturgeon2_cnt
          ,le.populated_gun_cnt
          ,le.populated_bonus_cnt
          ,le.populated_lottery_cnt
          ,le.populated_otherbirds_cnt
          ,le.populated_huntfill1_cnt
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
          ,le.populated_persistent_record_id_pcnt
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
          ,le.populated_phone_pcnt
          ,le.populated_work_phone_pcnt
          ,le.populated_other_phone_pcnt
          ,le.populated_active_status_pcnt
          ,le.populated_votefiller2_pcnt
          ,le.populated_active_other_pcnt
          ,le.populated_voterstatus_pcnt
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
          ,le.populated_historyfiller_pcnt
          ,le.populated_huntfishperm_pcnt
          ,le.populated_license_type_mapped_pcnt
          ,le.populated_datelicense_pcnt
          ,le.populated_homestate_pcnt
          ,le.populated_resident_pcnt
          ,le.populated_nonresident_pcnt
          ,le.populated_hunt_pcnt
          ,le.populated_fish_pcnt
          ,le.populated_combosuper_pcnt
          ,le.populated_sportsman_pcnt
          ,le.populated_trap_pcnt
          ,le.populated_archery_pcnt
          ,le.populated_muzzle_pcnt
          ,le.populated_drawing_pcnt
          ,le.populated_day1_pcnt
          ,le.populated_day3_pcnt
          ,le.populated_day7_pcnt
          ,le.populated_day14to15_pcnt
          ,le.populated_dayfiller_pcnt
          ,le.populated_seasonannual_pcnt
          ,le.populated_lifetimepermit_pcnt
          ,le.populated_landowner_pcnt
          ,le.populated_family_pcnt
          ,le.populated_junior_pcnt
          ,le.populated_seniorcit_pcnt
          ,le.populated_crewmemeber_pcnt
          ,le.populated_retarded_pcnt
          ,le.populated_indian_pcnt
          ,le.populated_serviceman_pcnt
          ,le.populated_disabled_pcnt
          ,le.populated_lowincome_pcnt
          ,le.populated_regioncounty_pcnt
          ,le.populated_blind_pcnt
          ,le.populated_huntfiller_pcnt
          ,le.populated_salmon_pcnt
          ,le.populated_freshwater_pcnt
          ,le.populated_saltwater_pcnt
          ,le.populated_lakesandresevoirs_pcnt
          ,le.populated_setlinefish_pcnt
          ,le.populated_trout_pcnt
          ,le.populated_fallfishing_pcnt
          ,le.populated_steelhead_pcnt
          ,le.populated_whitejubherring_pcnt
          ,le.populated_sturgeon_pcnt
          ,le.populated_shellfishcrab_pcnt
          ,le.populated_shellfishlobster_pcnt
          ,le.populated_deer_pcnt
          ,le.populated_bear_pcnt
          ,le.populated_elk_pcnt
          ,le.populated_moose_pcnt
          ,le.populated_buffalo_pcnt
          ,le.populated_antelope_pcnt
          ,le.populated_sikebull_pcnt
          ,le.populated_bighorn_pcnt
          ,le.populated_javelina_pcnt
          ,le.populated_cougar_pcnt
          ,le.populated_anterless_pcnt
          ,le.populated_pheasant_pcnt
          ,le.populated_goose_pcnt
          ,le.populated_duck_pcnt
          ,le.populated_turkey_pcnt
          ,le.populated_snowmobile_pcnt
          ,le.populated_biggame_pcnt
          ,le.populated_skipass_pcnt
          ,le.populated_migbird_pcnt
          ,le.populated_smallgame_pcnt
          ,le.populated_sturgeon2_pcnt
          ,le.populated_gun_pcnt
          ,le.populated_bonus_pcnt
          ,le.populated_lottery_pcnt
          ,le.populated_otherbirds_pcnt
          ,le.populated_huntfill1_pcnt
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
    FieldPopStats := NORMALIZE(hygiene_summaryStats,187,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Hunters_Delta(prevDS, PROJECT(h, Hunters_Layout_eMerges));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),187,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Hunters_Layout_eMerges) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_eMerges, Hunters_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

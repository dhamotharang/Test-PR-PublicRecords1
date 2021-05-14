IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT HVCCW_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 394;
  EXPORT NumRulesFromFieldType := 394;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 384;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(HVCCW_Layout_eMerges)
    UNSIGNED1 append_seqnum_Invalid;
    UNSIGNED1 persistent_record_id_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 score_Invalid;
    UNSIGNED1 best_ssn_Invalid;
    UNSIGNED1 did_out_Invalid;
    UNSIGNED1 source_Invalid;
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
    UNSIGNED1 dob_str_in_Invalid;
    UNSIGNED1 agecat_Invalid;
    UNSIGNED1 headhousehold_Invalid;
    UNSIGNED1 place_of_birth_Invalid;
    UNSIGNED1 occupation_Invalid;
    UNSIGNED1 maiden_name_Invalid;
    UNSIGNED1 motorvoterid_Invalid;
    UNSIGNED1 regsource_Invalid;
    UNSIGNED1 regdate_in_Invalid;
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
    UNSIGNED1 dateofcontr_in_Invalid;
    UNSIGNED1 dollaramt_Invalid;
    UNSIGNED1 officecontto_Invalid;
    UNSIGNED1 cumuldollaramt_Invalid;
    UNSIGNED1 conttype_Invalid;
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
    UNSIGNED1 lastdayvote_in_Invalid;
    UNSIGNED1 huntfishperm_Invalid;
    UNSIGNED1 datelicense_in_Invalid;
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
    UNSIGNED1 boatindexnum_Invalid;
    UNSIGNED1 boatcoowner_Invalid;
    UNSIGNED1 hullidnum_Invalid;
    UNSIGNED1 yearmade_Invalid;
    UNSIGNED1 model_Invalid;
    UNSIGNED1 manufacturer_Invalid;
    UNSIGNED1 lengt_Invalid;
    UNSIGNED1 hullconstruct_Invalid;
    UNSIGNED1 primuse_Invalid;
    UNSIGNED1 fueltype_Invalid;
    UNSIGNED1 propulsion_Invalid;
    UNSIGNED1 modeltype_Invalid;
    UNSIGNED1 regexpdate_in_Invalid;
    UNSIGNED1 titlenum_Invalid;
    UNSIGNED1 stprimuse_Invalid;
    UNSIGNED1 titlestatus_Invalid;
    UNSIGNED1 vessel_Invalid;
    UNSIGNED1 specreg_Invalid;
    UNSIGNED1 ccwpermnum_Invalid;
    UNSIGNED1 ccwweapontype_Invalid;
    UNSIGNED1 ccwregdate_in_Invalid;
    UNSIGNED1 ccwexpdate_in_Invalid;
    UNSIGNED1 ccwpermtype_Invalid;
    UNSIGNED1 dob_str_Invalid;
    UNSIGNED1 regdate_Invalid;
    UNSIGNED1 dateofcontr_Invalid;
    UNSIGNED1 lastdayvote_Invalid;
    UNSIGNED1 datelicense_Invalid;
    UNSIGNED1 regexpdate_Invalid;
    UNSIGNED1 ccwregdate_Invalid;
    UNSIGNED1 ccwexpdate_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 score_on_input_Invalid;
    UNSIGNED1 append_prep_resaddress1_Invalid;
    UNSIGNED1 append_prep_resaddress2_Invalid;
    UNSIGNED1 append_resrawaid_Invalid;
    UNSIGNED1 append_prep_mailaddress1_Invalid;
    UNSIGNED1 append_prep_mailaddress2_Invalid;
    UNSIGNED1 append_mailrawaid_Invalid;
    UNSIGNED1 append_prep_cassaddress1_Invalid;
    UNSIGNED1 append_prep_cassaddress2_Invalid;
    UNSIGNED1 append_cassrawaid_Invalid;
    UNSIGNED1 aid_resclean_prim_range_Invalid;
    UNSIGNED1 aid_resclean_predir_Invalid;
    UNSIGNED1 aid_resclean_prim_name_Invalid;
    UNSIGNED1 aid_resclean_addr_suffix_Invalid;
    UNSIGNED1 aid_resclean_postdir_Invalid;
    UNSIGNED1 aid_resclean_unit_desig_Invalid;
    UNSIGNED1 aid_resclean_sec_range_Invalid;
    UNSIGNED1 aid_resclean_p_city_name_Invalid;
    UNSIGNED1 aid_resclean_v_city_name_Invalid;
    UNSIGNED1 aid_resclean_st_Invalid;
    UNSIGNED1 aid_resclean_zip_Invalid;
    UNSIGNED1 aid_resclean_zip4_Invalid;
    UNSIGNED1 aid_resclean_cart_Invalid;
    UNSIGNED1 aid_resclean_cr_sort_sz_Invalid;
    UNSIGNED1 aid_resclean_lot_Invalid;
    UNSIGNED1 aid_resclean_lot_order_Invalid;
    UNSIGNED1 aid_resclean_dpbc_Invalid;
    UNSIGNED1 aid_resclean_chk_digit_Invalid;
    UNSIGNED1 aid_resclean_record_type_Invalid;
    UNSIGNED1 aid_resclean_ace_fips_st_Invalid;
    UNSIGNED1 aid_resclean_fipscounty_Invalid;
    UNSIGNED1 aid_resclean_geo_lat_Invalid;
    UNSIGNED1 aid_resclean_geo_long_Invalid;
    UNSIGNED1 aid_resclean_msa_Invalid;
    UNSIGNED1 aid_resclean_geo_blk_Invalid;
    UNSIGNED1 aid_resclean_geo_match_Invalid;
    UNSIGNED1 aid_resclean_err_stat_Invalid;
    UNSIGNED1 aid_mailclean_prim_range_Invalid;
    UNSIGNED1 aid_mailclean_predir_Invalid;
    UNSIGNED1 aid_mailclean_prim_name_Invalid;
    UNSIGNED1 aid_mailclean_addr_suffix_Invalid;
    UNSIGNED1 aid_mailclean_postdir_Invalid;
    UNSIGNED1 aid_mailclean_unit_desig_Invalid;
    UNSIGNED1 aid_mailclean_sec_range_Invalid;
    UNSIGNED1 aid_mailclean_p_city_name_Invalid;
    UNSIGNED1 aid_mailclean_v_city_name_Invalid;
    UNSIGNED1 aid_mailclean_st_Invalid;
    UNSIGNED1 aid_mailclean_zip_Invalid;
    UNSIGNED1 aid_mailclean_zip4_Invalid;
    UNSIGNED1 aid_mailclean_cart_Invalid;
    UNSIGNED1 aid_mailclean_cr_sort_sz_Invalid;
    UNSIGNED1 aid_mailclean_lot_Invalid;
    UNSIGNED1 aid_mailclean_lot_order_Invalid;
    UNSIGNED1 aid_mailclean_dpbc_Invalid;
    UNSIGNED1 aid_mailclean_chk_digit_Invalid;
    UNSIGNED1 aid_mailclean_record_type_Invalid;
    UNSIGNED1 aid_mailclean_ace_fips_st_Invalid;
    UNSIGNED1 aid_mailclean_fipscounty_Invalid;
    UNSIGNED1 aid_mailclean_geo_lat_Invalid;
    UNSIGNED1 aid_mailclean_geo_long_Invalid;
    UNSIGNED1 aid_mailclean_msa_Invalid;
    UNSIGNED1 aid_mailclean_geo_blk_Invalid;
    UNSIGNED1 aid_mailclean_geo_match_Invalid;
    UNSIGNED1 aid_mailclean_err_stat_Invalid;
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
    UNSIGNED1 cass_prim_range_Invalid;
    UNSIGNED1 cass_predir_Invalid;
    UNSIGNED1 cass_prim_name_Invalid;
    UNSIGNED1 cass_addr_suffix_Invalid;
    UNSIGNED1 cass_postdir_Invalid;
    UNSIGNED1 cass_unit_desig_Invalid;
    UNSIGNED1 cass_sec_range_Invalid;
    UNSIGNED1 cass_p_city_name_Invalid;
    UNSIGNED1 cass_v_city_name_Invalid;
    UNSIGNED1 cass_st_Invalid;
    UNSIGNED1 cass_ace_zip_Invalid;
    UNSIGNED1 cass_zip4_Invalid;
    UNSIGNED1 cass_cart_Invalid;
    UNSIGNED1 cass_cr_sort_sz_Invalid;
    UNSIGNED1 cass_lot_Invalid;
    UNSIGNED1 cass_lot_order_Invalid;
    UNSIGNED1 cass_dpbc_Invalid;
    UNSIGNED1 cass_chk_digit_Invalid;
    UNSIGNED1 cass_record_type_Invalid;
    UNSIGNED1 cass_ace_fips_st_Invalid;
    UNSIGNED1 cass_fipscounty_Invalid;
    UNSIGNED1 cass_geo_lat_Invalid;
    UNSIGNED1 cass_geo_long_Invalid;
    UNSIGNED1 cass_msa_Invalid;
    UNSIGNED1 cass_geo_blk_Invalid;
    UNSIGNED1 cass_geo_match_Invalid;
    UNSIGNED1 cass_err_stat_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(HVCCW_Layout_eMerges)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
    UNSIGNED8 ScrubsBits6;
    UNSIGNED8 ScrubsBits7;
  END;
  EXPORT Rule_Layout := RECORD(HVCCW_Layout_eMerges)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'append_seqnum:Invalid_No:ALLOW'
          ,'persistent_record_id:Invalid_No:ALLOW'
          ,'process_date:Invalid_Date:CUSTOM'
          ,'date_first_seen:Invalid_Date:CUSTOM'
          ,'date_last_seen:Invalid_Date:CUSTOM'
          ,'score:Invalid_No:ALLOW'
          ,'best_ssn:Invalid_No:ALLOW'
          ,'did_out:Invalid_No:ALLOW'
          ,'source:Invalid_Alpha:ALLOW'
          ,'file_id:Invalid_Alpha:ALLOW'
          ,'source_state:Invalid_Alpha:ALLOW'
          ,'source_code:Invalid_Alpha:ALLOW'
          ,'file_acquired_date:Invalid_Date:CUSTOM'
          ,'_use:Invalid_AlphaNum:ALLOW'
          ,'title_in:Invalid_Alpha:ALLOW'
          ,'lname_in:Invalid_Alpha:ALLOW'
          ,'fname_in:Invalid_Alpha:ALLOW'
          ,'mname_in:Invalid_Alpha:ALLOW'
          ,'maiden_prior:Invalid_Alpha:ALLOW'
          ,'name_suffix_in:Invalid_Alpha:ALLOW'
          ,'source_voterid:Invalid_AlphaNum:ALLOW'
          ,'dob_str_in:Invalid_Date:CUSTOM'
          ,'agecat:Invalid_No:ALLOW'
          ,'headhousehold:Invalid_Alpha:ALLOW'
          ,'place_of_birth:Invalid_Date:CUSTOM'
          ,'occupation:Invalid_Alpha:ALLOW'
          ,'maiden_name:Invalid_Alpha:ALLOW'
          ,'motorvoterid:Invalid_No:ALLOW'
          ,'regsource:Invalid_Alpha:ALLOW'
          ,'regdate_in:Invalid_Date:CUSTOM'
          ,'race:Invalid_Alpha:ALLOW'
          ,'gender:Invalid_Alpha:ALLOW'
          ,'poliparty:Invalid_AlphaNum:ALLOW'
          ,'phone:Invalid_Float:ALLOW'
          ,'work_phone:Invalid_Float:ALLOW'
          ,'other_phone:Invalid_Float:ALLOW'
          ,'active_status:Invalid_AlphaNum:ALLOW'
          ,'active_other:Invalid_No:ALLOW'
          ,'voterstatus:Invalid_AlphaNum:ALLOW'
          ,'resaddr1:Invalid_AlphaNum:ALLOW'
          ,'resaddr2:Invalid_AlphaNum:ALLOW'
          ,'res_city:Invalid_Alpha:ALLOW'
          ,'res_state:Invalid_Alpha:ALLOW'
          ,'res_zip:Invalid_Float:ALLOW'
          ,'res_county:Invalid_AlphaNum:ALLOW'
          ,'mail_addr1:Invalid_AlphaNum:ALLOW'
          ,'mail_addr2:Invalid_AlphaNum:ALLOW'
          ,'mail_city:Invalid_Alpha:ALLOW'
          ,'mail_state:Invalid_State:ALLOW','mail_state:Invalid_State:LENGTHS'
          ,'mail_zip:Invalid_Float:ALLOW'
          ,'mail_county:Invalid_AlphaNum:ALLOW'
          ,'towncode:Invalid_AlphaNum:ALLOW'
          ,'distcode:Invalid_AlphaNum:ALLOW'
          ,'countycode:Invalid_AlphaNum:ALLOW'
          ,'schoolcode:Invalid_AlphaNum:ALLOW'
          ,'cityinout:Invalid_Alpha:ALLOW'
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
          ,'statehouse:Invalid_No:ALLOW'
          ,'statesenate:Invalid_No:ALLOW'
          ,'ushouse:Invalid_AlphaNum:ALLOW'
          ,'elemschooldist:Invalid_AlphaNum:ALLOW'
          ,'schooldist:Invalid_AlphaNum:ALLOW'
          ,'commcolldist:Invalid_AlphaNum:ALLOW'
          ,'municipal:Invalid_No:ALLOW'
          ,'villagedist:Invalid_Alpha:ALLOW'
          ,'policejury:Invalid_Alpha:ALLOW'
          ,'policedist:Invalid_AlphaNum:ALLOW'
          ,'publicservcomm:Invalid_No:ALLOW'
          ,'rescue:Invalid_No:ALLOW'
          ,'fire:Invalid_No:ALLOW'
          ,'sanitary:Invalid_No:ALLOW'
          ,'sewerdist:Invalid_AlphaNum:ALLOW'
          ,'waterdist:Invalid_AlphaNum:ALLOW'
          ,'mosquitodist:Invalid_AlphaNum:ALLOW'
          ,'taxdist:Invalid_AlphaNum:ALLOW'
          ,'supremecourt:Invalid_No:ALLOW'
          ,'justiceofpeace:Invalid_AlphaNum:ALLOW'
          ,'judicialdist:Invalid_AlphaNum:ALLOW'
          ,'superiorctdist:Invalid_AlphaNum:ALLOW'
          ,'appealsct:Invalid_No:ALLOW'
          ,'contributorparty:Invalid_Alpha:ALLOW'
          ,'recptparty:Invalid_AlphaNum:ALLOW'
          ,'dateofcontr_in:Invalid_Date:CUSTOM'
          ,'dollaramt:Invalid_No:ALLOW'
          ,'officecontto:Invalid_No:ALLOW'
          ,'cumuldollaramt:Invalid_No:ALLOW'
          ,'conttype:Invalid_No:ALLOW'
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
          ,'lastdayvote_in:Invalid_Date:CUSTOM'
          ,'huntfishperm:Invalid_Alpha:ALLOW'
          ,'datelicense_in:Invalid_Date:CUSTOM'
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
          ,'day1:Invalid_Alpha:ALLOW'
          ,'day3:Invalid_Alpha:ALLOW'
          ,'day7:Invalid_Alpha:ALLOW'
          ,'day14to15:Invalid_Alpha:ALLOW'
          ,'seasonannual:Invalid_Alpha:ALLOW'
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
          ,'regioncounty:Invalid_AlphaNum:ALLOW'
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
          ,'boatindexnum:Invalid_No:ALLOW'
          ,'boatcoowner:Invalid_Alpha:ALLOW'
          ,'hullidnum:Invalid_No:ALLOW'
          ,'yearmade:Invalid_No:ALLOW'
          ,'model:Invalid_Alpha:ALLOW'
          ,'manufacturer:Invalid_Alpha:ALLOW'
          ,'lengt:Invalid_No:ALLOW'
          ,'hullconstruct:Invalid_No:ALLOW'
          ,'primuse:Invalid_Alpha:ALLOW'
          ,'fueltype:Invalid_Alpha:ALLOW'
          ,'propulsion:Invalid_Alpha:ALLOW'
          ,'modeltype:Invalid_Alpha:ALLOW'
          ,'regexpdate_in:Invalid_Date:CUSTOM'
          ,'titlenum:Invalid_No:ALLOW'
          ,'stprimuse:Invalid_Alpha:ALLOW'
          ,'titlestatus:Invalid_Alpha:ALLOW'
          ,'vessel:Invalid_Alpha:ALLOW'
          ,'specreg:Invalid_AlphaNum:ALLOW'
          ,'ccwpermnum:Invalid_No:ALLOW'
          ,'ccwweapontype:Invalid_Alpha:ALLOW'
          ,'ccwregdate_in:Invalid_Date:CUSTOM'
          ,'ccwexpdate_in:Invalid_Date:CUSTOM'
          ,'ccwpermtype:Invalid_Alpha:ALLOW'
          ,'dob_str:Invalid_Date:CUSTOM'
          ,'regdate:Invalid_Date:CUSTOM'
          ,'dateofcontr:Invalid_Date:CUSTOM'
          ,'lastdayvote:Invalid_Date:CUSTOM'
          ,'datelicense:Invalid_Date:CUSTOM'
          ,'regexpdate:Invalid_Date:CUSTOM'
          ,'ccwregdate:Invalid_Date:CUSTOM'
          ,'ccwexpdate:Invalid_Date:CUSTOM'
          ,'title:Invalid_Alpha:ALLOW'
          ,'fname:Invalid_Alpha:ALLOW'
          ,'mname:Invalid_Alpha:ALLOW'
          ,'lname:Invalid_Alpha:ALLOW'
          ,'name_suffix:Invalid_Alpha:ALLOW'
          ,'score_on_input:Invalid_No:ALLOW'
          ,'append_prep_resaddress1:Invalid_AlphaNum:ALLOW'
          ,'append_prep_resaddress2:Invalid_AlphaNum:ALLOW'
          ,'append_resrawaid:Invalid_No:ALLOW'
          ,'append_prep_mailaddress1:Invalid_AlphaNum:ALLOW'
          ,'append_prep_mailaddress2:Invalid_AlphaNum:ALLOW'
          ,'append_mailrawaid:Invalid_No:ALLOW'
          ,'append_prep_cassaddress1:Invalid_AlphaNum:ALLOW'
          ,'append_prep_cassaddress2:Invalid_AlphaNum:ALLOW'
          ,'append_cassrawaid:Invalid_No:ALLOW'
          ,'aid_resclean_prim_range:Invalid_AlphaNum:ALLOW'
          ,'aid_resclean_predir:Invalid_Alpha:ALLOW'
          ,'aid_resclean_prim_name:Invalid_AlphaNum:ALLOW'
          ,'aid_resclean_addr_suffix:Invalid_Alpha:ALLOW'
          ,'aid_resclean_postdir:Invalid_Alpha:ALLOW'
          ,'aid_resclean_unit_desig:Invalid_Alpha:ALLOW'
          ,'aid_resclean_sec_range:Invalid_AlphaNum:ALLOW'
          ,'aid_resclean_p_city_name:Invalid_Alpha:ALLOW'
          ,'aid_resclean_v_city_name:Invalid_Alpha:ALLOW'
          ,'aid_resclean_st:Invalid_State:ALLOW','aid_resclean_st:Invalid_State:LENGTHS'
          ,'aid_resclean_zip:Invalid_Zip:ALLOW','aid_resclean_zip:Invalid_Zip:LENGTHS'
          ,'aid_resclean_zip4:Invalid_No:ALLOW'
          ,'aid_resclean_cart:Invalid_AlphaNum:ALLOW'
          ,'aid_resclean_cr_sort_sz:Invalid_Alpha:ALLOW'
          ,'aid_resclean_lot:Invalid_No:ALLOW'
          ,'aid_resclean_lot_order:Invalid_Alpha:ALLOW'
          ,'aid_resclean_dpbc:Invalid_No:ALLOW'
          ,'aid_resclean_chk_digit:Invalid_No:ALLOW'
          ,'aid_resclean_record_type:Invalid_Alpha:ALLOW'
          ,'aid_resclean_ace_fips_st:Invalid_AlphaNum:ALLOW'
          ,'aid_resclean_fipscounty:Invalid_No:ALLOW'
          ,'aid_resclean_geo_lat:Invalid_Float:ALLOW'
          ,'aid_resclean_geo_long:Invalid_Float:ALLOW'
          ,'aid_resclean_msa:Invalid_No:ALLOW'
          ,'aid_resclean_geo_blk:Invalid_Float:ALLOW'
          ,'aid_resclean_geo_match:Invalid_No:ALLOW'
          ,'aid_resclean_err_stat:Invalid_AlphaNum:ALLOW'
          ,'aid_mailclean_prim_range:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_predir:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_prim_name:Invalid_AlphaNum:ALLOW'
          ,'aid_mailclean_addr_suffix:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_postdir:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_unit_desig:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_sec_range:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_p_city_name:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_v_city_name:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_st:Invalid_State:ALLOW','aid_mailclean_st:Invalid_State:LENGTHS'
          ,'aid_mailclean_zip:Invalid_Zip:ALLOW','aid_mailclean_zip:Invalid_Zip:LENGTHS'
          ,'aid_mailclean_zip4:Invalid_No:ALLOW'
          ,'aid_mailclean_cart:Invalid_AlphaNum:ALLOW'
          ,'aid_mailclean_cr_sort_sz:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_lot:Invalid_No:ALLOW'
          ,'aid_mailclean_lot_order:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_dpbc:Invalid_No:ALLOW'
          ,'aid_mailclean_chk_digit:Invalid_No:ALLOW'
          ,'aid_mailclean_record_type:Invalid_Alpha:ALLOW'
          ,'aid_mailclean_ace_fips_st:Invalid_AlphaNum:ALLOW'
          ,'aid_mailclean_fipscounty:Invalid_No:ALLOW'
          ,'aid_mailclean_geo_lat:Invalid_Float:ALLOW'
          ,'aid_mailclean_geo_long:Invalid_Float:ALLOW'
          ,'aid_mailclean_msa:Invalid_Float:ALLOW'
          ,'aid_mailclean_geo_blk:Invalid_Float:ALLOW'
          ,'aid_mailclean_geo_match:Invalid_Float:ALLOW'
          ,'aid_mailclean_err_stat:Invalid_AlphaNum:ALLOW'
          ,'prim_range:Invalid_AlphaNum:ALLOW'
          ,'predir:Invalid_Alpha:ALLOW'
          ,'prim_name:Invalid_AlphaNum:ALLOW'
          ,'suffix:Invalid_Alpha:ALLOW'
          ,'postdir:Invalid_AlphaNum:ALLOW'
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
          ,'geo_lat:Invalid_Float:ALLOW'
          ,'geo_long:Invalid_Float:ALLOW'
          ,'msa:Invalid_Float:ALLOW'
          ,'geo_blk:Invalid_Float:ALLOW'
          ,'geo_match:Invalid_Float:ALLOW'
          ,'err_stat:Invalid_AlphaNum:ALLOW'
          ,'mail_prim_range:Invalid_AlphaNum:ALLOW'
          ,'mail_predir:Invalid_Alpha:ALLOW'
          ,'mail_prim_name:Invalid_AlphaNum:ALLOW'
          ,'mail_addr_suffix:Invalid_Alpha:ALLOW'
          ,'mail_postdir:Invalid_Alpha:ALLOW'
          ,'mail_unit_desig:Invalid_Alpha:ALLOW'
          ,'mail_sec_range:Invalid_Alpha:ALLOW'
          ,'mail_p_city_name:Invalid_Alpha:ALLOW'
          ,'mail_v_city_name:Invalid_Alpha:ALLOW'
          ,'mail_st:Invalid_State:ALLOW','mail_st:Invalid_State:LENGTHS'
          ,'mail_ace_zip:Invalid_Zip:ALLOW','mail_ace_zip:Invalid_Zip:LENGTHS'
          ,'mail_zip4:Invalid_No:ALLOW'
          ,'mail_cart:Invalid_AlphaNum:ALLOW'
          ,'mail_cr_sort_sz:Invalid_Alpha:ALLOW'
          ,'mail_lot:Invalid_No:ALLOW'
          ,'mail_lot_order:Invalid_Alpha:ALLOW'
          ,'mail_dpbc:Invalid_No:ALLOW'
          ,'mail_chk_digit:Invalid_No:ALLOW'
          ,'mail_record_type:Invalid_Alpha:ALLOW'
          ,'mail_ace_fips_st:Invalid_AlphaNum:ALLOW'
          ,'mail_fipscounty:Invalid_No:ALLOW'
          ,'mail_geo_lat:Invalid_Float:ALLOW'
          ,'mail_geo_long:Invalid_Float:ALLOW'
          ,'mail_msa:Invalid_Float:ALLOW'
          ,'mail_geo_blk:Invalid_Float:ALLOW'
          ,'mail_geo_match:Invalid_Float:ALLOW'
          ,'cass_prim_range:Invalid_AlphaNum:ALLOW'
          ,'cass_predir:Invalid_Alpha:ALLOW'
          ,'cass_prim_name:Invalid_Alpha:ALLOW'
          ,'cass_addr_suffix:Invalid_Alpha:ALLOW'
          ,'cass_postdir:Invalid_Alpha:ALLOW'
          ,'cass_unit_desig:Invalid_Alpha:ALLOW'
          ,'cass_sec_range:Invalid_Alpha:ALLOW'
          ,'cass_p_city_name:Invalid_Alpha:ALLOW'
          ,'cass_v_city_name:Invalid_Alpha:ALLOW'
          ,'cass_st:Invalid_State:ALLOW','cass_st:Invalid_State:LENGTHS'
          ,'cass_ace_zip:Invalid_Zip:ALLOW','cass_ace_zip:Invalid_Zip:LENGTHS'
          ,'cass_zip4:Invalid_No:ALLOW'
          ,'cass_cart:Invalid_AlphaNum:ALLOW'
          ,'cass_cr_sort_sz:Invalid_Alpha:ALLOW'
          ,'cass_lot:Invalid_No:ALLOW'
          ,'cass_lot_order:Invalid_Alpha:ALLOW'
          ,'cass_dpbc:Invalid_No:ALLOW'
          ,'cass_chk_digit:Invalid_No:ALLOW'
          ,'cass_record_type:Invalid_Alpha:ALLOW'
          ,'cass_ace_fips_st:Invalid_AlphaNum:ALLOW'
          ,'cass_fipscounty:Invalid_No:ALLOW'
          ,'cass_geo_lat:Invalid_Float:ALLOW'
          ,'cass_geo_long:Invalid_Float:ALLOW'
          ,'cass_msa:Invalid_Float:ALLOW'
          ,'cass_geo_blk:Invalid_Float:ALLOW'
          ,'cass_geo_match:Invalid_Float:ALLOW'
          ,'cass_err_stat:Invalid_AlphaNum:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,HVCCW_Fields.InvalidMessage_append_seqnum(1)
          ,HVCCW_Fields.InvalidMessage_persistent_record_id(1)
          ,HVCCW_Fields.InvalidMessage_process_date(1)
          ,HVCCW_Fields.InvalidMessage_date_first_seen(1)
          ,HVCCW_Fields.InvalidMessage_date_last_seen(1)
          ,HVCCW_Fields.InvalidMessage_score(1)
          ,HVCCW_Fields.InvalidMessage_best_ssn(1)
          ,HVCCW_Fields.InvalidMessage_did_out(1)
          ,HVCCW_Fields.InvalidMessage_source(1)
          ,HVCCW_Fields.InvalidMessage_file_id(1)
          ,HVCCW_Fields.InvalidMessage_source_state(1)
          ,HVCCW_Fields.InvalidMessage_source_code(1)
          ,HVCCW_Fields.InvalidMessage_file_acquired_date(1)
          ,HVCCW_Fields.InvalidMessage__use(1)
          ,HVCCW_Fields.InvalidMessage_title_in(1)
          ,HVCCW_Fields.InvalidMessage_lname_in(1)
          ,HVCCW_Fields.InvalidMessage_fname_in(1)
          ,HVCCW_Fields.InvalidMessage_mname_in(1)
          ,HVCCW_Fields.InvalidMessage_maiden_prior(1)
          ,HVCCW_Fields.InvalidMessage_name_suffix_in(1)
          ,HVCCW_Fields.InvalidMessage_source_voterid(1)
          ,HVCCW_Fields.InvalidMessage_dob_str_in(1)
          ,HVCCW_Fields.InvalidMessage_agecat(1)
          ,HVCCW_Fields.InvalidMessage_headhousehold(1)
          ,HVCCW_Fields.InvalidMessage_place_of_birth(1)
          ,HVCCW_Fields.InvalidMessage_occupation(1)
          ,HVCCW_Fields.InvalidMessage_maiden_name(1)
          ,HVCCW_Fields.InvalidMessage_motorvoterid(1)
          ,HVCCW_Fields.InvalidMessage_regsource(1)
          ,HVCCW_Fields.InvalidMessage_regdate_in(1)
          ,HVCCW_Fields.InvalidMessage_race(1)
          ,HVCCW_Fields.InvalidMessage_gender(1)
          ,HVCCW_Fields.InvalidMessage_poliparty(1)
          ,HVCCW_Fields.InvalidMessage_phone(1)
          ,HVCCW_Fields.InvalidMessage_work_phone(1)
          ,HVCCW_Fields.InvalidMessage_other_phone(1)
          ,HVCCW_Fields.InvalidMessage_active_status(1)
          ,HVCCW_Fields.InvalidMessage_active_other(1)
          ,HVCCW_Fields.InvalidMessage_voterstatus(1)
          ,HVCCW_Fields.InvalidMessage_resaddr1(1)
          ,HVCCW_Fields.InvalidMessage_resaddr2(1)
          ,HVCCW_Fields.InvalidMessage_res_city(1)
          ,HVCCW_Fields.InvalidMessage_res_state(1)
          ,HVCCW_Fields.InvalidMessage_res_zip(1)
          ,HVCCW_Fields.InvalidMessage_res_county(1)
          ,HVCCW_Fields.InvalidMessage_mail_addr1(1)
          ,HVCCW_Fields.InvalidMessage_mail_addr2(1)
          ,HVCCW_Fields.InvalidMessage_mail_city(1)
          ,HVCCW_Fields.InvalidMessage_mail_state(1),HVCCW_Fields.InvalidMessage_mail_state(2)
          ,HVCCW_Fields.InvalidMessage_mail_zip(1)
          ,HVCCW_Fields.InvalidMessage_mail_county(1)
          ,HVCCW_Fields.InvalidMessage_towncode(1)
          ,HVCCW_Fields.InvalidMessage_distcode(1)
          ,HVCCW_Fields.InvalidMessage_countycode(1)
          ,HVCCW_Fields.InvalidMessage_schoolcode(1)
          ,HVCCW_Fields.InvalidMessage_cityinout(1)
          ,HVCCW_Fields.InvalidMessage_spec_dist1(1)
          ,HVCCW_Fields.InvalidMessage_spec_dist2(1)
          ,HVCCW_Fields.InvalidMessage_precinct1(1)
          ,HVCCW_Fields.InvalidMessage_precinct2(1)
          ,HVCCW_Fields.InvalidMessage_precinct3(1)
          ,HVCCW_Fields.InvalidMessage_villageprecinct(1)
          ,HVCCW_Fields.InvalidMessage_schoolprecinct(1)
          ,HVCCW_Fields.InvalidMessage_ward(1)
          ,HVCCW_Fields.InvalidMessage_precinct_citytown(1)
          ,HVCCW_Fields.InvalidMessage_ancsmdindc(1)
          ,HVCCW_Fields.InvalidMessage_citycouncildist(1)
          ,HVCCW_Fields.InvalidMessage_countycommdist(1)
          ,HVCCW_Fields.InvalidMessage_statehouse(1)
          ,HVCCW_Fields.InvalidMessage_statesenate(1)
          ,HVCCW_Fields.InvalidMessage_ushouse(1)
          ,HVCCW_Fields.InvalidMessage_elemschooldist(1)
          ,HVCCW_Fields.InvalidMessage_schooldist(1)
          ,HVCCW_Fields.InvalidMessage_commcolldist(1)
          ,HVCCW_Fields.InvalidMessage_municipal(1)
          ,HVCCW_Fields.InvalidMessage_villagedist(1)
          ,HVCCW_Fields.InvalidMessage_policejury(1)
          ,HVCCW_Fields.InvalidMessage_policedist(1)
          ,HVCCW_Fields.InvalidMessage_publicservcomm(1)
          ,HVCCW_Fields.InvalidMessage_rescue(1)
          ,HVCCW_Fields.InvalidMessage_fire(1)
          ,HVCCW_Fields.InvalidMessage_sanitary(1)
          ,HVCCW_Fields.InvalidMessage_sewerdist(1)
          ,HVCCW_Fields.InvalidMessage_waterdist(1)
          ,HVCCW_Fields.InvalidMessage_mosquitodist(1)
          ,HVCCW_Fields.InvalidMessage_taxdist(1)
          ,HVCCW_Fields.InvalidMessage_supremecourt(1)
          ,HVCCW_Fields.InvalidMessage_justiceofpeace(1)
          ,HVCCW_Fields.InvalidMessage_judicialdist(1)
          ,HVCCW_Fields.InvalidMessage_superiorctdist(1)
          ,HVCCW_Fields.InvalidMessage_appealsct(1)
          ,HVCCW_Fields.InvalidMessage_contributorparty(1)
          ,HVCCW_Fields.InvalidMessage_recptparty(1)
          ,HVCCW_Fields.InvalidMessage_dateofcontr_in(1)
          ,HVCCW_Fields.InvalidMessage_dollaramt(1)
          ,HVCCW_Fields.InvalidMessage_officecontto(1)
          ,HVCCW_Fields.InvalidMessage_cumuldollaramt(1)
          ,HVCCW_Fields.InvalidMessage_conttype(1)
          ,HVCCW_Fields.InvalidMessage_primary02(1)
          ,HVCCW_Fields.InvalidMessage_special02(1)
          ,HVCCW_Fields.InvalidMessage_other02(1)
          ,HVCCW_Fields.InvalidMessage_special202(1)
          ,HVCCW_Fields.InvalidMessage_general02(1)
          ,HVCCW_Fields.InvalidMessage_primary01(1)
          ,HVCCW_Fields.InvalidMessage_special01(1)
          ,HVCCW_Fields.InvalidMessage_other01(1)
          ,HVCCW_Fields.InvalidMessage_special201(1)
          ,HVCCW_Fields.InvalidMessage_general01(1)
          ,HVCCW_Fields.InvalidMessage_pres00(1)
          ,HVCCW_Fields.InvalidMessage_primary00(1)
          ,HVCCW_Fields.InvalidMessage_special00(1)
          ,HVCCW_Fields.InvalidMessage_other00(1)
          ,HVCCW_Fields.InvalidMessage_special200(1)
          ,HVCCW_Fields.InvalidMessage_general00(1)
          ,HVCCW_Fields.InvalidMessage_primary99(1)
          ,HVCCW_Fields.InvalidMessage_special99(1)
          ,HVCCW_Fields.InvalidMessage_other99(1)
          ,HVCCW_Fields.InvalidMessage_special299(1)
          ,HVCCW_Fields.InvalidMessage_general99(1)
          ,HVCCW_Fields.InvalidMessage_primary98(1)
          ,HVCCW_Fields.InvalidMessage_special98(1)
          ,HVCCW_Fields.InvalidMessage_other98(1)
          ,HVCCW_Fields.InvalidMessage_special298(1)
          ,HVCCW_Fields.InvalidMessage_general98(1)
          ,HVCCW_Fields.InvalidMessage_primary97(1)
          ,HVCCW_Fields.InvalidMessage_special97(1)
          ,HVCCW_Fields.InvalidMessage_other97(1)
          ,HVCCW_Fields.InvalidMessage_special297(1)
          ,HVCCW_Fields.InvalidMessage_general97(1)
          ,HVCCW_Fields.InvalidMessage_pres96(1)
          ,HVCCW_Fields.InvalidMessage_primary96(1)
          ,HVCCW_Fields.InvalidMessage_special96(1)
          ,HVCCW_Fields.InvalidMessage_other96(1)
          ,HVCCW_Fields.InvalidMessage_special296(1)
          ,HVCCW_Fields.InvalidMessage_general96(1)
          ,HVCCW_Fields.InvalidMessage_lastdayvote_in(1)
          ,HVCCW_Fields.InvalidMessage_huntfishperm(1)
          ,HVCCW_Fields.InvalidMessage_datelicense_in(1)
          ,HVCCW_Fields.InvalidMessage_homestate(1)
          ,HVCCW_Fields.InvalidMessage_resident(1)
          ,HVCCW_Fields.InvalidMessage_nonresident(1)
          ,HVCCW_Fields.InvalidMessage_hunt(1)
          ,HVCCW_Fields.InvalidMessage_fish(1)
          ,HVCCW_Fields.InvalidMessage_combosuper(1)
          ,HVCCW_Fields.InvalidMessage_sportsman(1)
          ,HVCCW_Fields.InvalidMessage_trap(1)
          ,HVCCW_Fields.InvalidMessage_archery(1)
          ,HVCCW_Fields.InvalidMessage_muzzle(1)
          ,HVCCW_Fields.InvalidMessage_drawing(1)
          ,HVCCW_Fields.InvalidMessage_day1(1)
          ,HVCCW_Fields.InvalidMessage_day3(1)
          ,HVCCW_Fields.InvalidMessage_day7(1)
          ,HVCCW_Fields.InvalidMessage_day14to15(1)
          ,HVCCW_Fields.InvalidMessage_seasonannual(1)
          ,HVCCW_Fields.InvalidMessage_lifetimepermit(1)
          ,HVCCW_Fields.InvalidMessage_landowner(1)
          ,HVCCW_Fields.InvalidMessage_family(1)
          ,HVCCW_Fields.InvalidMessage_junior(1)
          ,HVCCW_Fields.InvalidMessage_seniorcit(1)
          ,HVCCW_Fields.InvalidMessage_crewmemeber(1)
          ,HVCCW_Fields.InvalidMessage_retarded(1)
          ,HVCCW_Fields.InvalidMessage_indian(1)
          ,HVCCW_Fields.InvalidMessage_serviceman(1)
          ,HVCCW_Fields.InvalidMessage_disabled(1)
          ,HVCCW_Fields.InvalidMessage_lowincome(1)
          ,HVCCW_Fields.InvalidMessage_regioncounty(1)
          ,HVCCW_Fields.InvalidMessage_blind(1)
          ,HVCCW_Fields.InvalidMessage_salmon(1)
          ,HVCCW_Fields.InvalidMessage_freshwater(1)
          ,HVCCW_Fields.InvalidMessage_saltwater(1)
          ,HVCCW_Fields.InvalidMessage_lakesandresevoirs(1)
          ,HVCCW_Fields.InvalidMessage_setlinefish(1)
          ,HVCCW_Fields.InvalidMessage_trout(1)
          ,HVCCW_Fields.InvalidMessage_fallfishing(1)
          ,HVCCW_Fields.InvalidMessage_steelhead(1)
          ,HVCCW_Fields.InvalidMessage_whitejubherring(1)
          ,HVCCW_Fields.InvalidMessage_sturgeon(1)
          ,HVCCW_Fields.InvalidMessage_shellfishcrab(1)
          ,HVCCW_Fields.InvalidMessage_shellfishlobster(1)
          ,HVCCW_Fields.InvalidMessage_deer(1)
          ,HVCCW_Fields.InvalidMessage_bear(1)
          ,HVCCW_Fields.InvalidMessage_elk(1)
          ,HVCCW_Fields.InvalidMessage_moose(1)
          ,HVCCW_Fields.InvalidMessage_buffalo(1)
          ,HVCCW_Fields.InvalidMessage_antelope(1)
          ,HVCCW_Fields.InvalidMessage_sikebull(1)
          ,HVCCW_Fields.InvalidMessage_bighorn(1)
          ,HVCCW_Fields.InvalidMessage_javelina(1)
          ,HVCCW_Fields.InvalidMessage_cougar(1)
          ,HVCCW_Fields.InvalidMessage_anterless(1)
          ,HVCCW_Fields.InvalidMessage_pheasant(1)
          ,HVCCW_Fields.InvalidMessage_goose(1)
          ,HVCCW_Fields.InvalidMessage_duck(1)
          ,HVCCW_Fields.InvalidMessage_turkey(1)
          ,HVCCW_Fields.InvalidMessage_snowmobile(1)
          ,HVCCW_Fields.InvalidMessage_biggame(1)
          ,HVCCW_Fields.InvalidMessage_skipass(1)
          ,HVCCW_Fields.InvalidMessage_migbird(1)
          ,HVCCW_Fields.InvalidMessage_smallgame(1)
          ,HVCCW_Fields.InvalidMessage_sturgeon2(1)
          ,HVCCW_Fields.InvalidMessage_gun(1)
          ,HVCCW_Fields.InvalidMessage_bonus(1)
          ,HVCCW_Fields.InvalidMessage_lottery(1)
          ,HVCCW_Fields.InvalidMessage_otherbirds(1)
          ,HVCCW_Fields.InvalidMessage_boatindexnum(1)
          ,HVCCW_Fields.InvalidMessage_boatcoowner(1)
          ,HVCCW_Fields.InvalidMessage_hullidnum(1)
          ,HVCCW_Fields.InvalidMessage_yearmade(1)
          ,HVCCW_Fields.InvalidMessage_model(1)
          ,HVCCW_Fields.InvalidMessage_manufacturer(1)
          ,HVCCW_Fields.InvalidMessage_lengt(1)
          ,HVCCW_Fields.InvalidMessage_hullconstruct(1)
          ,HVCCW_Fields.InvalidMessage_primuse(1)
          ,HVCCW_Fields.InvalidMessage_fueltype(1)
          ,HVCCW_Fields.InvalidMessage_propulsion(1)
          ,HVCCW_Fields.InvalidMessage_modeltype(1)
          ,HVCCW_Fields.InvalidMessage_regexpdate_in(1)
          ,HVCCW_Fields.InvalidMessage_titlenum(1)
          ,HVCCW_Fields.InvalidMessage_stprimuse(1)
          ,HVCCW_Fields.InvalidMessage_titlestatus(1)
          ,HVCCW_Fields.InvalidMessage_vessel(1)
          ,HVCCW_Fields.InvalidMessage_specreg(1)
          ,HVCCW_Fields.InvalidMessage_ccwpermnum(1)
          ,HVCCW_Fields.InvalidMessage_ccwweapontype(1)
          ,HVCCW_Fields.InvalidMessage_ccwregdate_in(1)
          ,HVCCW_Fields.InvalidMessage_ccwexpdate_in(1)
          ,HVCCW_Fields.InvalidMessage_ccwpermtype(1)
          ,HVCCW_Fields.InvalidMessage_dob_str(1)
          ,HVCCW_Fields.InvalidMessage_regdate(1)
          ,HVCCW_Fields.InvalidMessage_dateofcontr(1)
          ,HVCCW_Fields.InvalidMessage_lastdayvote(1)
          ,HVCCW_Fields.InvalidMessage_datelicense(1)
          ,HVCCW_Fields.InvalidMessage_regexpdate(1)
          ,HVCCW_Fields.InvalidMessage_ccwregdate(1)
          ,HVCCW_Fields.InvalidMessage_ccwexpdate(1)
          ,HVCCW_Fields.InvalidMessage_title(1)
          ,HVCCW_Fields.InvalidMessage_fname(1)
          ,HVCCW_Fields.InvalidMessage_mname(1)
          ,HVCCW_Fields.InvalidMessage_lname(1)
          ,HVCCW_Fields.InvalidMessage_name_suffix(1)
          ,HVCCW_Fields.InvalidMessage_score_on_input(1)
          ,HVCCW_Fields.InvalidMessage_append_prep_resaddress1(1)
          ,HVCCW_Fields.InvalidMessage_append_prep_resaddress2(1)
          ,HVCCW_Fields.InvalidMessage_append_resrawaid(1)
          ,HVCCW_Fields.InvalidMessage_append_prep_mailaddress1(1)
          ,HVCCW_Fields.InvalidMessage_append_prep_mailaddress2(1)
          ,HVCCW_Fields.InvalidMessage_append_mailrawaid(1)
          ,HVCCW_Fields.InvalidMessage_append_prep_cassaddress1(1)
          ,HVCCW_Fields.InvalidMessage_append_prep_cassaddress2(1)
          ,HVCCW_Fields.InvalidMessage_append_cassrawaid(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_prim_range(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_predir(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_prim_name(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_addr_suffix(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_postdir(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_unit_desig(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_sec_range(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_p_city_name(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_v_city_name(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_st(1),HVCCW_Fields.InvalidMessage_aid_resclean_st(2)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_zip(1),HVCCW_Fields.InvalidMessage_aid_resclean_zip(2)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_zip4(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_cart(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_cr_sort_sz(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_lot(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_lot_order(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_dpbc(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_chk_digit(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_record_type(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_ace_fips_st(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_fipscounty(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_geo_lat(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_geo_long(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_msa(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_geo_blk(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_geo_match(1)
          ,HVCCW_Fields.InvalidMessage_aid_resclean_err_stat(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_prim_range(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_predir(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_prim_name(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_addr_suffix(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_postdir(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_unit_desig(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_sec_range(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_p_city_name(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_v_city_name(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_st(1),HVCCW_Fields.InvalidMessage_aid_mailclean_st(2)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_zip(1),HVCCW_Fields.InvalidMessage_aid_mailclean_zip(2)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_zip4(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_cart(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_cr_sort_sz(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_lot(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_lot_order(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_dpbc(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_chk_digit(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_record_type(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_ace_fips_st(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_fipscounty(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_geo_lat(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_geo_long(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_msa(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_geo_blk(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_geo_match(1)
          ,HVCCW_Fields.InvalidMessage_aid_mailclean_err_stat(1)
          ,HVCCW_Fields.InvalidMessage_prim_range(1)
          ,HVCCW_Fields.InvalidMessage_predir(1)
          ,HVCCW_Fields.InvalidMessage_prim_name(1)
          ,HVCCW_Fields.InvalidMessage_suffix(1)
          ,HVCCW_Fields.InvalidMessage_postdir(1)
          ,HVCCW_Fields.InvalidMessage_unit_desig(1)
          ,HVCCW_Fields.InvalidMessage_sec_range(1)
          ,HVCCW_Fields.InvalidMessage_p_city_name(1)
          ,HVCCW_Fields.InvalidMessage_city_name(1)
          ,HVCCW_Fields.InvalidMessage_st(1)
          ,HVCCW_Fields.InvalidMessage_zip(1),HVCCW_Fields.InvalidMessage_zip(2)
          ,HVCCW_Fields.InvalidMessage_zip4(1)
          ,HVCCW_Fields.InvalidMessage_cart(1)
          ,HVCCW_Fields.InvalidMessage_cr_sort_sz(1)
          ,HVCCW_Fields.InvalidMessage_lot(1)
          ,HVCCW_Fields.InvalidMessage_lot_order(1)
          ,HVCCW_Fields.InvalidMessage_dpbc(1)
          ,HVCCW_Fields.InvalidMessage_chk_digit(1)
          ,HVCCW_Fields.InvalidMessage_record_type(1)
          ,HVCCW_Fields.InvalidMessage_ace_fips_st(1)
          ,HVCCW_Fields.InvalidMessage_county(1)
          ,HVCCW_Fields.InvalidMessage_geo_lat(1)
          ,HVCCW_Fields.InvalidMessage_geo_long(1)
          ,HVCCW_Fields.InvalidMessage_msa(1)
          ,HVCCW_Fields.InvalidMessage_geo_blk(1)
          ,HVCCW_Fields.InvalidMessage_geo_match(1)
          ,HVCCW_Fields.InvalidMessage_err_stat(1)
          ,HVCCW_Fields.InvalidMessage_mail_prim_range(1)
          ,HVCCW_Fields.InvalidMessage_mail_predir(1)
          ,HVCCW_Fields.InvalidMessage_mail_prim_name(1)
          ,HVCCW_Fields.InvalidMessage_mail_addr_suffix(1)
          ,HVCCW_Fields.InvalidMessage_mail_postdir(1)
          ,HVCCW_Fields.InvalidMessage_mail_unit_desig(1)
          ,HVCCW_Fields.InvalidMessage_mail_sec_range(1)
          ,HVCCW_Fields.InvalidMessage_mail_p_city_name(1)
          ,HVCCW_Fields.InvalidMessage_mail_v_city_name(1)
          ,HVCCW_Fields.InvalidMessage_mail_st(1),HVCCW_Fields.InvalidMessage_mail_st(2)
          ,HVCCW_Fields.InvalidMessage_mail_ace_zip(1),HVCCW_Fields.InvalidMessage_mail_ace_zip(2)
          ,HVCCW_Fields.InvalidMessage_mail_zip4(1)
          ,HVCCW_Fields.InvalidMessage_mail_cart(1)
          ,HVCCW_Fields.InvalidMessage_mail_cr_sort_sz(1)
          ,HVCCW_Fields.InvalidMessage_mail_lot(1)
          ,HVCCW_Fields.InvalidMessage_mail_lot_order(1)
          ,HVCCW_Fields.InvalidMessage_mail_dpbc(1)
          ,HVCCW_Fields.InvalidMessage_mail_chk_digit(1)
          ,HVCCW_Fields.InvalidMessage_mail_record_type(1)
          ,HVCCW_Fields.InvalidMessage_mail_ace_fips_st(1)
          ,HVCCW_Fields.InvalidMessage_mail_fipscounty(1)
          ,HVCCW_Fields.InvalidMessage_mail_geo_lat(1)
          ,HVCCW_Fields.InvalidMessage_mail_geo_long(1)
          ,HVCCW_Fields.InvalidMessage_mail_msa(1)
          ,HVCCW_Fields.InvalidMessage_mail_geo_blk(1)
          ,HVCCW_Fields.InvalidMessage_mail_geo_match(1)
          ,HVCCW_Fields.InvalidMessage_cass_prim_range(1)
          ,HVCCW_Fields.InvalidMessage_cass_predir(1)
          ,HVCCW_Fields.InvalidMessage_cass_prim_name(1)
          ,HVCCW_Fields.InvalidMessage_cass_addr_suffix(1)
          ,HVCCW_Fields.InvalidMessage_cass_postdir(1)
          ,HVCCW_Fields.InvalidMessage_cass_unit_desig(1)
          ,HVCCW_Fields.InvalidMessage_cass_sec_range(1)
          ,HVCCW_Fields.InvalidMessage_cass_p_city_name(1)
          ,HVCCW_Fields.InvalidMessage_cass_v_city_name(1)
          ,HVCCW_Fields.InvalidMessage_cass_st(1),HVCCW_Fields.InvalidMessage_cass_st(2)
          ,HVCCW_Fields.InvalidMessage_cass_ace_zip(1),HVCCW_Fields.InvalidMessage_cass_ace_zip(2)
          ,HVCCW_Fields.InvalidMessage_cass_zip4(1)
          ,HVCCW_Fields.InvalidMessage_cass_cart(1)
          ,HVCCW_Fields.InvalidMessage_cass_cr_sort_sz(1)
          ,HVCCW_Fields.InvalidMessage_cass_lot(1)
          ,HVCCW_Fields.InvalidMessage_cass_lot_order(1)
          ,HVCCW_Fields.InvalidMessage_cass_dpbc(1)
          ,HVCCW_Fields.InvalidMessage_cass_chk_digit(1)
          ,HVCCW_Fields.InvalidMessage_cass_record_type(1)
          ,HVCCW_Fields.InvalidMessage_cass_ace_fips_st(1)
          ,HVCCW_Fields.InvalidMessage_cass_fipscounty(1)
          ,HVCCW_Fields.InvalidMessage_cass_geo_lat(1)
          ,HVCCW_Fields.InvalidMessage_cass_geo_long(1)
          ,HVCCW_Fields.InvalidMessage_cass_msa(1)
          ,HVCCW_Fields.InvalidMessage_cass_geo_blk(1)
          ,HVCCW_Fields.InvalidMessage_cass_geo_match(1)
          ,HVCCW_Fields.InvalidMessage_cass_err_stat(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(HVCCW_Layout_eMerges) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.append_seqnum_Invalid := HVCCW_Fields.InValid_append_seqnum((SALT311.StrType)le.append_seqnum);
    SELF.persistent_record_id_Invalid := HVCCW_Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id);
    SELF.process_date_Invalid := HVCCW_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.date_first_seen_Invalid := HVCCW_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := HVCCW_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.score_Invalid := HVCCW_Fields.InValid_score((SALT311.StrType)le.score);
    SELF.best_ssn_Invalid := HVCCW_Fields.InValid_best_ssn((SALT311.StrType)le.best_ssn);
    SELF.did_out_Invalid := HVCCW_Fields.InValid_did_out((SALT311.StrType)le.did_out);
    SELF.source_Invalid := HVCCW_Fields.InValid_source((SALT311.StrType)le.source);
    SELF.file_id_Invalid := HVCCW_Fields.InValid_file_id((SALT311.StrType)le.file_id);
    SELF.source_state_Invalid := HVCCW_Fields.InValid_source_state((SALT311.StrType)le.source_state);
    SELF.source_code_Invalid := HVCCW_Fields.InValid_source_code((SALT311.StrType)le.source_code);
    SELF.file_acquired_date_Invalid := HVCCW_Fields.InValid_file_acquired_date((SALT311.StrType)le.file_acquired_date);
    SELF._use_Invalid := HVCCW_Fields.InValid__use((SALT311.StrType)le._use);
    SELF.title_in_Invalid := HVCCW_Fields.InValid_title_in((SALT311.StrType)le.title_in);
    SELF.lname_in_Invalid := HVCCW_Fields.InValid_lname_in((SALT311.StrType)le.lname_in);
    SELF.fname_in_Invalid := HVCCW_Fields.InValid_fname_in((SALT311.StrType)le.fname_in);
    SELF.mname_in_Invalid := HVCCW_Fields.InValid_mname_in((SALT311.StrType)le.mname_in);
    SELF.maiden_prior_Invalid := HVCCW_Fields.InValid_maiden_prior((SALT311.StrType)le.maiden_prior);
    SELF.name_suffix_in_Invalid := HVCCW_Fields.InValid_name_suffix_in((SALT311.StrType)le.name_suffix_in);
    SELF.source_voterid_Invalid := HVCCW_Fields.InValid_source_voterid((SALT311.StrType)le.source_voterid);
    SELF.dob_str_in_Invalid := HVCCW_Fields.InValid_dob_str_in((SALT311.StrType)le.dob_str_in);
    SELF.agecat_Invalid := HVCCW_Fields.InValid_agecat((SALT311.StrType)le.agecat);
    SELF.headhousehold_Invalid := HVCCW_Fields.InValid_headhousehold((SALT311.StrType)le.headhousehold);
    SELF.place_of_birth_Invalid := HVCCW_Fields.InValid_place_of_birth((SALT311.StrType)le.place_of_birth);
    SELF.occupation_Invalid := HVCCW_Fields.InValid_occupation((SALT311.StrType)le.occupation);
    SELF.maiden_name_Invalid := HVCCW_Fields.InValid_maiden_name((SALT311.StrType)le.maiden_name);
    SELF.motorvoterid_Invalid := HVCCW_Fields.InValid_motorvoterid((SALT311.StrType)le.motorvoterid);
    SELF.regsource_Invalid := HVCCW_Fields.InValid_regsource((SALT311.StrType)le.regsource);
    SELF.regdate_in_Invalid := HVCCW_Fields.InValid_regdate_in((SALT311.StrType)le.regdate_in);
    SELF.race_Invalid := HVCCW_Fields.InValid_race((SALT311.StrType)le.race);
    SELF.gender_Invalid := HVCCW_Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.poliparty_Invalid := HVCCW_Fields.InValid_poliparty((SALT311.StrType)le.poliparty);
    SELF.phone_Invalid := HVCCW_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.work_phone_Invalid := HVCCW_Fields.InValid_work_phone((SALT311.StrType)le.work_phone);
    SELF.other_phone_Invalid := HVCCW_Fields.InValid_other_phone((SALT311.StrType)le.other_phone);
    SELF.active_status_Invalid := HVCCW_Fields.InValid_active_status((SALT311.StrType)le.active_status);
    SELF.active_other_Invalid := HVCCW_Fields.InValid_active_other((SALT311.StrType)le.active_other);
    SELF.voterstatus_Invalid := HVCCW_Fields.InValid_voterstatus((SALT311.StrType)le.voterstatus);
    SELF.resaddr1_Invalid := HVCCW_Fields.InValid_resaddr1((SALT311.StrType)le.resaddr1);
    SELF.resaddr2_Invalid := HVCCW_Fields.InValid_resaddr2((SALT311.StrType)le.resaddr2);
    SELF.res_city_Invalid := HVCCW_Fields.InValid_res_city((SALT311.StrType)le.res_city);
    SELF.res_state_Invalid := HVCCW_Fields.InValid_res_state((SALT311.StrType)le.res_state);
    SELF.res_zip_Invalid := HVCCW_Fields.InValid_res_zip((SALT311.StrType)le.res_zip);
    SELF.res_county_Invalid := HVCCW_Fields.InValid_res_county((SALT311.StrType)le.res_county);
    SELF.mail_addr1_Invalid := HVCCW_Fields.InValid_mail_addr1((SALT311.StrType)le.mail_addr1);
    SELF.mail_addr2_Invalid := HVCCW_Fields.InValid_mail_addr2((SALT311.StrType)le.mail_addr2);
    SELF.mail_city_Invalid := HVCCW_Fields.InValid_mail_city((SALT311.StrType)le.mail_city);
    SELF.mail_state_Invalid := HVCCW_Fields.InValid_mail_state((SALT311.StrType)le.mail_state);
    SELF.mail_zip_Invalid := HVCCW_Fields.InValid_mail_zip((SALT311.StrType)le.mail_zip);
    SELF.mail_county_Invalid := HVCCW_Fields.InValid_mail_county((SALT311.StrType)le.mail_county);
    SELF.towncode_Invalid := HVCCW_Fields.InValid_towncode((SALT311.StrType)le.towncode);
    SELF.distcode_Invalid := HVCCW_Fields.InValid_distcode((SALT311.StrType)le.distcode);
    SELF.countycode_Invalid := HVCCW_Fields.InValid_countycode((SALT311.StrType)le.countycode);
    SELF.schoolcode_Invalid := HVCCW_Fields.InValid_schoolcode((SALT311.StrType)le.schoolcode);
    SELF.cityinout_Invalid := HVCCW_Fields.InValid_cityinout((SALT311.StrType)le.cityinout);
    SELF.spec_dist1_Invalid := HVCCW_Fields.InValid_spec_dist1((SALT311.StrType)le.spec_dist1);
    SELF.spec_dist2_Invalid := HVCCW_Fields.InValid_spec_dist2((SALT311.StrType)le.spec_dist2);
    SELF.precinct1_Invalid := HVCCW_Fields.InValid_precinct1((SALT311.StrType)le.precinct1);
    SELF.precinct2_Invalid := HVCCW_Fields.InValid_precinct2((SALT311.StrType)le.precinct2);
    SELF.precinct3_Invalid := HVCCW_Fields.InValid_precinct3((SALT311.StrType)le.precinct3);
    SELF.villageprecinct_Invalid := HVCCW_Fields.InValid_villageprecinct((SALT311.StrType)le.villageprecinct);
    SELF.schoolprecinct_Invalid := HVCCW_Fields.InValid_schoolprecinct((SALT311.StrType)le.schoolprecinct);
    SELF.ward_Invalid := HVCCW_Fields.InValid_ward((SALT311.StrType)le.ward);
    SELF.precinct_citytown_Invalid := HVCCW_Fields.InValid_precinct_citytown((SALT311.StrType)le.precinct_citytown);
    SELF.ancsmdindc_Invalid := HVCCW_Fields.InValid_ancsmdindc((SALT311.StrType)le.ancsmdindc);
    SELF.citycouncildist_Invalid := HVCCW_Fields.InValid_citycouncildist((SALT311.StrType)le.citycouncildist);
    SELF.countycommdist_Invalid := HVCCW_Fields.InValid_countycommdist((SALT311.StrType)le.countycommdist);
    SELF.statehouse_Invalid := HVCCW_Fields.InValid_statehouse((SALT311.StrType)le.statehouse);
    SELF.statesenate_Invalid := HVCCW_Fields.InValid_statesenate((SALT311.StrType)le.statesenate);
    SELF.ushouse_Invalid := HVCCW_Fields.InValid_ushouse((SALT311.StrType)le.ushouse);
    SELF.elemschooldist_Invalid := HVCCW_Fields.InValid_elemschooldist((SALT311.StrType)le.elemschooldist);
    SELF.schooldist_Invalid := HVCCW_Fields.InValid_schooldist((SALT311.StrType)le.schooldist);
    SELF.commcolldist_Invalid := HVCCW_Fields.InValid_commcolldist((SALT311.StrType)le.commcolldist);
    SELF.municipal_Invalid := HVCCW_Fields.InValid_municipal((SALT311.StrType)le.municipal);
    SELF.villagedist_Invalid := HVCCW_Fields.InValid_villagedist((SALT311.StrType)le.villagedist);
    SELF.policejury_Invalid := HVCCW_Fields.InValid_policejury((SALT311.StrType)le.policejury);
    SELF.policedist_Invalid := HVCCW_Fields.InValid_policedist((SALT311.StrType)le.policedist);
    SELF.publicservcomm_Invalid := HVCCW_Fields.InValid_publicservcomm((SALT311.StrType)le.publicservcomm);
    SELF.rescue_Invalid := HVCCW_Fields.InValid_rescue((SALT311.StrType)le.rescue);
    SELF.fire_Invalid := HVCCW_Fields.InValid_fire((SALT311.StrType)le.fire);
    SELF.sanitary_Invalid := HVCCW_Fields.InValid_sanitary((SALT311.StrType)le.sanitary);
    SELF.sewerdist_Invalid := HVCCW_Fields.InValid_sewerdist((SALT311.StrType)le.sewerdist);
    SELF.waterdist_Invalid := HVCCW_Fields.InValid_waterdist((SALT311.StrType)le.waterdist);
    SELF.mosquitodist_Invalid := HVCCW_Fields.InValid_mosquitodist((SALT311.StrType)le.mosquitodist);
    SELF.taxdist_Invalid := HVCCW_Fields.InValid_taxdist((SALT311.StrType)le.taxdist);
    SELF.supremecourt_Invalid := HVCCW_Fields.InValid_supremecourt((SALT311.StrType)le.supremecourt);
    SELF.justiceofpeace_Invalid := HVCCW_Fields.InValid_justiceofpeace((SALT311.StrType)le.justiceofpeace);
    SELF.judicialdist_Invalid := HVCCW_Fields.InValid_judicialdist((SALT311.StrType)le.judicialdist);
    SELF.superiorctdist_Invalid := HVCCW_Fields.InValid_superiorctdist((SALT311.StrType)le.superiorctdist);
    SELF.appealsct_Invalid := HVCCW_Fields.InValid_appealsct((SALT311.StrType)le.appealsct);
    SELF.contributorparty_Invalid := HVCCW_Fields.InValid_contributorparty((SALT311.StrType)le.contributorparty);
    SELF.recptparty_Invalid := HVCCW_Fields.InValid_recptparty((SALT311.StrType)le.recptparty);
    SELF.dateofcontr_in_Invalid := HVCCW_Fields.InValid_dateofcontr_in((SALT311.StrType)le.dateofcontr_in);
    SELF.dollaramt_Invalid := HVCCW_Fields.InValid_dollaramt((SALT311.StrType)le.dollaramt);
    SELF.officecontto_Invalid := HVCCW_Fields.InValid_officecontto((SALT311.StrType)le.officecontto);
    SELF.cumuldollaramt_Invalid := HVCCW_Fields.InValid_cumuldollaramt((SALT311.StrType)le.cumuldollaramt);
    SELF.conttype_Invalid := HVCCW_Fields.InValid_conttype((SALT311.StrType)le.conttype);
    SELF.primary02_Invalid := HVCCW_Fields.InValid_primary02((SALT311.StrType)le.primary02);
    SELF.special02_Invalid := HVCCW_Fields.InValid_special02((SALT311.StrType)le.special02);
    SELF.other02_Invalid := HVCCW_Fields.InValid_other02((SALT311.StrType)le.other02);
    SELF.special202_Invalid := HVCCW_Fields.InValid_special202((SALT311.StrType)le.special202);
    SELF.general02_Invalid := HVCCW_Fields.InValid_general02((SALT311.StrType)le.general02);
    SELF.primary01_Invalid := HVCCW_Fields.InValid_primary01((SALT311.StrType)le.primary01);
    SELF.special01_Invalid := HVCCW_Fields.InValid_special01((SALT311.StrType)le.special01);
    SELF.other01_Invalid := HVCCW_Fields.InValid_other01((SALT311.StrType)le.other01);
    SELF.special201_Invalid := HVCCW_Fields.InValid_special201((SALT311.StrType)le.special201);
    SELF.general01_Invalid := HVCCW_Fields.InValid_general01((SALT311.StrType)le.general01);
    SELF.pres00_Invalid := HVCCW_Fields.InValid_pres00((SALT311.StrType)le.pres00);
    SELF.primary00_Invalid := HVCCW_Fields.InValid_primary00((SALT311.StrType)le.primary00);
    SELF.special00_Invalid := HVCCW_Fields.InValid_special00((SALT311.StrType)le.special00);
    SELF.other00_Invalid := HVCCW_Fields.InValid_other00((SALT311.StrType)le.other00);
    SELF.special200_Invalid := HVCCW_Fields.InValid_special200((SALT311.StrType)le.special200);
    SELF.general00_Invalid := HVCCW_Fields.InValid_general00((SALT311.StrType)le.general00);
    SELF.primary99_Invalid := HVCCW_Fields.InValid_primary99((SALT311.StrType)le.primary99);
    SELF.special99_Invalid := HVCCW_Fields.InValid_special99((SALT311.StrType)le.special99);
    SELF.other99_Invalid := HVCCW_Fields.InValid_other99((SALT311.StrType)le.other99);
    SELF.special299_Invalid := HVCCW_Fields.InValid_special299((SALT311.StrType)le.special299);
    SELF.general99_Invalid := HVCCW_Fields.InValid_general99((SALT311.StrType)le.general99);
    SELF.primary98_Invalid := HVCCW_Fields.InValid_primary98((SALT311.StrType)le.primary98);
    SELF.special98_Invalid := HVCCW_Fields.InValid_special98((SALT311.StrType)le.special98);
    SELF.other98_Invalid := HVCCW_Fields.InValid_other98((SALT311.StrType)le.other98);
    SELF.special298_Invalid := HVCCW_Fields.InValid_special298((SALT311.StrType)le.special298);
    SELF.general98_Invalid := HVCCW_Fields.InValid_general98((SALT311.StrType)le.general98);
    SELF.primary97_Invalid := HVCCW_Fields.InValid_primary97((SALT311.StrType)le.primary97);
    SELF.special97_Invalid := HVCCW_Fields.InValid_special97((SALT311.StrType)le.special97);
    SELF.other97_Invalid := HVCCW_Fields.InValid_other97((SALT311.StrType)le.other97);
    SELF.special297_Invalid := HVCCW_Fields.InValid_special297((SALT311.StrType)le.special297);
    SELF.general97_Invalid := HVCCW_Fields.InValid_general97((SALT311.StrType)le.general97);
    SELF.pres96_Invalid := HVCCW_Fields.InValid_pres96((SALT311.StrType)le.pres96);
    SELF.primary96_Invalid := HVCCW_Fields.InValid_primary96((SALT311.StrType)le.primary96);
    SELF.special96_Invalid := HVCCW_Fields.InValid_special96((SALT311.StrType)le.special96);
    SELF.other96_Invalid := HVCCW_Fields.InValid_other96((SALT311.StrType)le.other96);
    SELF.special296_Invalid := HVCCW_Fields.InValid_special296((SALT311.StrType)le.special296);
    SELF.general96_Invalid := HVCCW_Fields.InValid_general96((SALT311.StrType)le.general96);
    SELF.lastdayvote_in_Invalid := HVCCW_Fields.InValid_lastdayvote_in((SALT311.StrType)le.lastdayvote_in);
    SELF.huntfishperm_Invalid := HVCCW_Fields.InValid_huntfishperm((SALT311.StrType)le.huntfishperm);
    SELF.datelicense_in_Invalid := HVCCW_Fields.InValid_datelicense_in((SALT311.StrType)le.datelicense_in);
    SELF.homestate_Invalid := HVCCW_Fields.InValid_homestate((SALT311.StrType)le.homestate);
    SELF.resident_Invalid := HVCCW_Fields.InValid_resident((SALT311.StrType)le.resident);
    SELF.nonresident_Invalid := HVCCW_Fields.InValid_nonresident((SALT311.StrType)le.nonresident);
    SELF.hunt_Invalid := HVCCW_Fields.InValid_hunt((SALT311.StrType)le.hunt);
    SELF.fish_Invalid := HVCCW_Fields.InValid_fish((SALT311.StrType)le.fish);
    SELF.combosuper_Invalid := HVCCW_Fields.InValid_combosuper((SALT311.StrType)le.combosuper);
    SELF.sportsman_Invalid := HVCCW_Fields.InValid_sportsman((SALT311.StrType)le.sportsman);
    SELF.trap_Invalid := HVCCW_Fields.InValid_trap((SALT311.StrType)le.trap);
    SELF.archery_Invalid := HVCCW_Fields.InValid_archery((SALT311.StrType)le.archery);
    SELF.muzzle_Invalid := HVCCW_Fields.InValid_muzzle((SALT311.StrType)le.muzzle);
    SELF.drawing_Invalid := HVCCW_Fields.InValid_drawing((SALT311.StrType)le.drawing);
    SELF.day1_Invalid := HVCCW_Fields.InValid_day1((SALT311.StrType)le.day1);
    SELF.day3_Invalid := HVCCW_Fields.InValid_day3((SALT311.StrType)le.day3);
    SELF.day7_Invalid := HVCCW_Fields.InValid_day7((SALT311.StrType)le.day7);
    SELF.day14to15_Invalid := HVCCW_Fields.InValid_day14to15((SALT311.StrType)le.day14to15);
    SELF.seasonannual_Invalid := HVCCW_Fields.InValid_seasonannual((SALT311.StrType)le.seasonannual);
    SELF.lifetimepermit_Invalid := HVCCW_Fields.InValid_lifetimepermit((SALT311.StrType)le.lifetimepermit);
    SELF.landowner_Invalid := HVCCW_Fields.InValid_landowner((SALT311.StrType)le.landowner);
    SELF.family_Invalid := HVCCW_Fields.InValid_family((SALT311.StrType)le.family);
    SELF.junior_Invalid := HVCCW_Fields.InValid_junior((SALT311.StrType)le.junior);
    SELF.seniorcit_Invalid := HVCCW_Fields.InValid_seniorcit((SALT311.StrType)le.seniorcit);
    SELF.crewmemeber_Invalid := HVCCW_Fields.InValid_crewmemeber((SALT311.StrType)le.crewmemeber);
    SELF.retarded_Invalid := HVCCW_Fields.InValid_retarded((SALT311.StrType)le.retarded);
    SELF.indian_Invalid := HVCCW_Fields.InValid_indian((SALT311.StrType)le.indian);
    SELF.serviceman_Invalid := HVCCW_Fields.InValid_serviceman((SALT311.StrType)le.serviceman);
    SELF.disabled_Invalid := HVCCW_Fields.InValid_disabled((SALT311.StrType)le.disabled);
    SELF.lowincome_Invalid := HVCCW_Fields.InValid_lowincome((SALT311.StrType)le.lowincome);
    SELF.regioncounty_Invalid := HVCCW_Fields.InValid_regioncounty((SALT311.StrType)le.regioncounty);
    SELF.blind_Invalid := HVCCW_Fields.InValid_blind((SALT311.StrType)le.blind);
    SELF.salmon_Invalid := HVCCW_Fields.InValid_salmon((SALT311.StrType)le.salmon);
    SELF.freshwater_Invalid := HVCCW_Fields.InValid_freshwater((SALT311.StrType)le.freshwater);
    SELF.saltwater_Invalid := HVCCW_Fields.InValid_saltwater((SALT311.StrType)le.saltwater);
    SELF.lakesandresevoirs_Invalid := HVCCW_Fields.InValid_lakesandresevoirs((SALT311.StrType)le.lakesandresevoirs);
    SELF.setlinefish_Invalid := HVCCW_Fields.InValid_setlinefish((SALT311.StrType)le.setlinefish);
    SELF.trout_Invalid := HVCCW_Fields.InValid_trout((SALT311.StrType)le.trout);
    SELF.fallfishing_Invalid := HVCCW_Fields.InValid_fallfishing((SALT311.StrType)le.fallfishing);
    SELF.steelhead_Invalid := HVCCW_Fields.InValid_steelhead((SALT311.StrType)le.steelhead);
    SELF.whitejubherring_Invalid := HVCCW_Fields.InValid_whitejubherring((SALT311.StrType)le.whitejubherring);
    SELF.sturgeon_Invalid := HVCCW_Fields.InValid_sturgeon((SALT311.StrType)le.sturgeon);
    SELF.shellfishcrab_Invalid := HVCCW_Fields.InValid_shellfishcrab((SALT311.StrType)le.shellfishcrab);
    SELF.shellfishlobster_Invalid := HVCCW_Fields.InValid_shellfishlobster((SALT311.StrType)le.shellfishlobster);
    SELF.deer_Invalid := HVCCW_Fields.InValid_deer((SALT311.StrType)le.deer);
    SELF.bear_Invalid := HVCCW_Fields.InValid_bear((SALT311.StrType)le.bear);
    SELF.elk_Invalid := HVCCW_Fields.InValid_elk((SALT311.StrType)le.elk);
    SELF.moose_Invalid := HVCCW_Fields.InValid_moose((SALT311.StrType)le.moose);
    SELF.buffalo_Invalid := HVCCW_Fields.InValid_buffalo((SALT311.StrType)le.buffalo);
    SELF.antelope_Invalid := HVCCW_Fields.InValid_antelope((SALT311.StrType)le.antelope);
    SELF.sikebull_Invalid := HVCCW_Fields.InValid_sikebull((SALT311.StrType)le.sikebull);
    SELF.bighorn_Invalid := HVCCW_Fields.InValid_bighorn((SALT311.StrType)le.bighorn);
    SELF.javelina_Invalid := HVCCW_Fields.InValid_javelina((SALT311.StrType)le.javelina);
    SELF.cougar_Invalid := HVCCW_Fields.InValid_cougar((SALT311.StrType)le.cougar);
    SELF.anterless_Invalid := HVCCW_Fields.InValid_anterless((SALT311.StrType)le.anterless);
    SELF.pheasant_Invalid := HVCCW_Fields.InValid_pheasant((SALT311.StrType)le.pheasant);
    SELF.goose_Invalid := HVCCW_Fields.InValid_goose((SALT311.StrType)le.goose);
    SELF.duck_Invalid := HVCCW_Fields.InValid_duck((SALT311.StrType)le.duck);
    SELF.turkey_Invalid := HVCCW_Fields.InValid_turkey((SALT311.StrType)le.turkey);
    SELF.snowmobile_Invalid := HVCCW_Fields.InValid_snowmobile((SALT311.StrType)le.snowmobile);
    SELF.biggame_Invalid := HVCCW_Fields.InValid_biggame((SALT311.StrType)le.biggame);
    SELF.skipass_Invalid := HVCCW_Fields.InValid_skipass((SALT311.StrType)le.skipass);
    SELF.migbird_Invalid := HVCCW_Fields.InValid_migbird((SALT311.StrType)le.migbird);
    SELF.smallgame_Invalid := HVCCW_Fields.InValid_smallgame((SALT311.StrType)le.smallgame);
    SELF.sturgeon2_Invalid := HVCCW_Fields.InValid_sturgeon2((SALT311.StrType)le.sturgeon2);
    SELF.gun_Invalid := HVCCW_Fields.InValid_gun((SALT311.StrType)le.gun);
    SELF.bonus_Invalid := HVCCW_Fields.InValid_bonus((SALT311.StrType)le.bonus);
    SELF.lottery_Invalid := HVCCW_Fields.InValid_lottery((SALT311.StrType)le.lottery);
    SELF.otherbirds_Invalid := HVCCW_Fields.InValid_otherbirds((SALT311.StrType)le.otherbirds);
    SELF.boatindexnum_Invalid := HVCCW_Fields.InValid_boatindexnum((SALT311.StrType)le.boatindexnum);
    SELF.boatcoowner_Invalid := HVCCW_Fields.InValid_boatcoowner((SALT311.StrType)le.boatcoowner);
    SELF.hullidnum_Invalid := HVCCW_Fields.InValid_hullidnum((SALT311.StrType)le.hullidnum);
    SELF.yearmade_Invalid := HVCCW_Fields.InValid_yearmade((SALT311.StrType)le.yearmade);
    SELF.model_Invalid := HVCCW_Fields.InValid_model((SALT311.StrType)le.model);
    SELF.manufacturer_Invalid := HVCCW_Fields.InValid_manufacturer((SALT311.StrType)le.manufacturer);
    SELF.lengt_Invalid := HVCCW_Fields.InValid_lengt((SALT311.StrType)le.lengt);
    SELF.hullconstruct_Invalid := HVCCW_Fields.InValid_hullconstruct((SALT311.StrType)le.hullconstruct);
    SELF.primuse_Invalid := HVCCW_Fields.InValid_primuse((SALT311.StrType)le.primuse);
    SELF.fueltype_Invalid := HVCCW_Fields.InValid_fueltype((SALT311.StrType)le.fueltype);
    SELF.propulsion_Invalid := HVCCW_Fields.InValid_propulsion((SALT311.StrType)le.propulsion);
    SELF.modeltype_Invalid := HVCCW_Fields.InValid_modeltype((SALT311.StrType)le.modeltype);
    SELF.regexpdate_in_Invalid := HVCCW_Fields.InValid_regexpdate_in((SALT311.StrType)le.regexpdate_in);
    SELF.titlenum_Invalid := HVCCW_Fields.InValid_titlenum((SALT311.StrType)le.titlenum);
    SELF.stprimuse_Invalid := HVCCW_Fields.InValid_stprimuse((SALT311.StrType)le.stprimuse);
    SELF.titlestatus_Invalid := HVCCW_Fields.InValid_titlestatus((SALT311.StrType)le.titlestatus);
    SELF.vessel_Invalid := HVCCW_Fields.InValid_vessel((SALT311.StrType)le.vessel);
    SELF.specreg_Invalid := HVCCW_Fields.InValid_specreg((SALT311.StrType)le.specreg);
    SELF.ccwpermnum_Invalid := HVCCW_Fields.InValid_ccwpermnum((SALT311.StrType)le.ccwpermnum);
    SELF.ccwweapontype_Invalid := HVCCW_Fields.InValid_ccwweapontype((SALT311.StrType)le.ccwweapontype);
    SELF.ccwregdate_in_Invalid := HVCCW_Fields.InValid_ccwregdate_in((SALT311.StrType)le.ccwregdate_in);
    SELF.ccwexpdate_in_Invalid := HVCCW_Fields.InValid_ccwexpdate_in((SALT311.StrType)le.ccwexpdate_in);
    SELF.ccwpermtype_Invalid := HVCCW_Fields.InValid_ccwpermtype((SALT311.StrType)le.ccwpermtype);
    SELF.dob_str_Invalid := HVCCW_Fields.InValid_dob_str((SALT311.StrType)le.dob_str);
    SELF.regdate_Invalid := HVCCW_Fields.InValid_regdate((SALT311.StrType)le.regdate);
    SELF.dateofcontr_Invalid := HVCCW_Fields.InValid_dateofcontr((SALT311.StrType)le.dateofcontr);
    SELF.lastdayvote_Invalid := HVCCW_Fields.InValid_lastdayvote((SALT311.StrType)le.lastdayvote);
    SELF.datelicense_Invalid := HVCCW_Fields.InValid_datelicense((SALT311.StrType)le.datelicense);
    SELF.regexpdate_Invalid := HVCCW_Fields.InValid_regexpdate((SALT311.StrType)le.regexpdate);
    SELF.ccwregdate_Invalid := HVCCW_Fields.InValid_ccwregdate((SALT311.StrType)le.ccwregdate);
    SELF.ccwexpdate_Invalid := HVCCW_Fields.InValid_ccwexpdate((SALT311.StrType)le.ccwexpdate);
    SELF.title_Invalid := HVCCW_Fields.InValid_title((SALT311.StrType)le.title);
    SELF.fname_Invalid := HVCCW_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := HVCCW_Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := HVCCW_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.name_suffix_Invalid := HVCCW_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.score_on_input_Invalid := HVCCW_Fields.InValid_score_on_input((SALT311.StrType)le.score_on_input);
    SELF.append_prep_resaddress1_Invalid := HVCCW_Fields.InValid_append_prep_resaddress1((SALT311.StrType)le.append_prep_resaddress1);
    SELF.append_prep_resaddress2_Invalid := HVCCW_Fields.InValid_append_prep_resaddress2((SALT311.StrType)le.append_prep_resaddress2);
    SELF.append_resrawaid_Invalid := HVCCW_Fields.InValid_append_resrawaid((SALT311.StrType)le.append_resrawaid);
    SELF.append_prep_mailaddress1_Invalid := HVCCW_Fields.InValid_append_prep_mailaddress1((SALT311.StrType)le.append_prep_mailaddress1);
    SELF.append_prep_mailaddress2_Invalid := HVCCW_Fields.InValid_append_prep_mailaddress2((SALT311.StrType)le.append_prep_mailaddress2);
    SELF.append_mailrawaid_Invalid := HVCCW_Fields.InValid_append_mailrawaid((SALT311.StrType)le.append_mailrawaid);
    SELF.append_prep_cassaddress1_Invalid := HVCCW_Fields.InValid_append_prep_cassaddress1((SALT311.StrType)le.append_prep_cassaddress1);
    SELF.append_prep_cassaddress2_Invalid := HVCCW_Fields.InValid_append_prep_cassaddress2((SALT311.StrType)le.append_prep_cassaddress2);
    SELF.append_cassrawaid_Invalid := HVCCW_Fields.InValid_append_cassrawaid((SALT311.StrType)le.append_cassrawaid);
    SELF.aid_resclean_prim_range_Invalid := HVCCW_Fields.InValid_aid_resclean_prim_range((SALT311.StrType)le.aid_resclean_prim_range);
    SELF.aid_resclean_predir_Invalid := HVCCW_Fields.InValid_aid_resclean_predir((SALT311.StrType)le.aid_resclean_predir);
    SELF.aid_resclean_prim_name_Invalid := HVCCW_Fields.InValid_aid_resclean_prim_name((SALT311.StrType)le.aid_resclean_prim_name);
    SELF.aid_resclean_addr_suffix_Invalid := HVCCW_Fields.InValid_aid_resclean_addr_suffix((SALT311.StrType)le.aid_resclean_addr_suffix);
    SELF.aid_resclean_postdir_Invalid := HVCCW_Fields.InValid_aid_resclean_postdir((SALT311.StrType)le.aid_resclean_postdir);
    SELF.aid_resclean_unit_desig_Invalid := HVCCW_Fields.InValid_aid_resclean_unit_desig((SALT311.StrType)le.aid_resclean_unit_desig);
    SELF.aid_resclean_sec_range_Invalid := HVCCW_Fields.InValid_aid_resclean_sec_range((SALT311.StrType)le.aid_resclean_sec_range);
    SELF.aid_resclean_p_city_name_Invalid := HVCCW_Fields.InValid_aid_resclean_p_city_name((SALT311.StrType)le.aid_resclean_p_city_name);
    SELF.aid_resclean_v_city_name_Invalid := HVCCW_Fields.InValid_aid_resclean_v_city_name((SALT311.StrType)le.aid_resclean_v_city_name);
    SELF.aid_resclean_st_Invalid := HVCCW_Fields.InValid_aid_resclean_st((SALT311.StrType)le.aid_resclean_st);
    SELF.aid_resclean_zip_Invalid := HVCCW_Fields.InValid_aid_resclean_zip((SALT311.StrType)le.aid_resclean_zip);
    SELF.aid_resclean_zip4_Invalid := HVCCW_Fields.InValid_aid_resclean_zip4((SALT311.StrType)le.aid_resclean_zip4);
    SELF.aid_resclean_cart_Invalid := HVCCW_Fields.InValid_aid_resclean_cart((SALT311.StrType)le.aid_resclean_cart);
    SELF.aid_resclean_cr_sort_sz_Invalid := HVCCW_Fields.InValid_aid_resclean_cr_sort_sz((SALT311.StrType)le.aid_resclean_cr_sort_sz);
    SELF.aid_resclean_lot_Invalid := HVCCW_Fields.InValid_aid_resclean_lot((SALT311.StrType)le.aid_resclean_lot);
    SELF.aid_resclean_lot_order_Invalid := HVCCW_Fields.InValid_aid_resclean_lot_order((SALT311.StrType)le.aid_resclean_lot_order);
    SELF.aid_resclean_dpbc_Invalid := HVCCW_Fields.InValid_aid_resclean_dpbc((SALT311.StrType)le.aid_resclean_dpbc);
    SELF.aid_resclean_chk_digit_Invalid := HVCCW_Fields.InValid_aid_resclean_chk_digit((SALT311.StrType)le.aid_resclean_chk_digit);
    SELF.aid_resclean_record_type_Invalid := HVCCW_Fields.InValid_aid_resclean_record_type((SALT311.StrType)le.aid_resclean_record_type);
    SELF.aid_resclean_ace_fips_st_Invalid := HVCCW_Fields.InValid_aid_resclean_ace_fips_st((SALT311.StrType)le.aid_resclean_ace_fips_st);
    SELF.aid_resclean_fipscounty_Invalid := HVCCW_Fields.InValid_aid_resclean_fipscounty((SALT311.StrType)le.aid_resclean_fipscounty);
    SELF.aid_resclean_geo_lat_Invalid := HVCCW_Fields.InValid_aid_resclean_geo_lat((SALT311.StrType)le.aid_resclean_geo_lat);
    SELF.aid_resclean_geo_long_Invalid := HVCCW_Fields.InValid_aid_resclean_geo_long((SALT311.StrType)le.aid_resclean_geo_long);
    SELF.aid_resclean_msa_Invalid := HVCCW_Fields.InValid_aid_resclean_msa((SALT311.StrType)le.aid_resclean_msa);
    SELF.aid_resclean_geo_blk_Invalid := HVCCW_Fields.InValid_aid_resclean_geo_blk((SALT311.StrType)le.aid_resclean_geo_blk);
    SELF.aid_resclean_geo_match_Invalid := HVCCW_Fields.InValid_aid_resclean_geo_match((SALT311.StrType)le.aid_resclean_geo_match);
    SELF.aid_resclean_err_stat_Invalid := HVCCW_Fields.InValid_aid_resclean_err_stat((SALT311.StrType)le.aid_resclean_err_stat);
    SELF.aid_mailclean_prim_range_Invalid := HVCCW_Fields.InValid_aid_mailclean_prim_range((SALT311.StrType)le.aid_mailclean_prim_range);
    SELF.aid_mailclean_predir_Invalid := HVCCW_Fields.InValid_aid_mailclean_predir((SALT311.StrType)le.aid_mailclean_predir);
    SELF.aid_mailclean_prim_name_Invalid := HVCCW_Fields.InValid_aid_mailclean_prim_name((SALT311.StrType)le.aid_mailclean_prim_name);
    SELF.aid_mailclean_addr_suffix_Invalid := HVCCW_Fields.InValid_aid_mailclean_addr_suffix((SALT311.StrType)le.aid_mailclean_addr_suffix);
    SELF.aid_mailclean_postdir_Invalid := HVCCW_Fields.InValid_aid_mailclean_postdir((SALT311.StrType)le.aid_mailclean_postdir);
    SELF.aid_mailclean_unit_desig_Invalid := HVCCW_Fields.InValid_aid_mailclean_unit_desig((SALT311.StrType)le.aid_mailclean_unit_desig);
    SELF.aid_mailclean_sec_range_Invalid := HVCCW_Fields.InValid_aid_mailclean_sec_range((SALT311.StrType)le.aid_mailclean_sec_range);
    SELF.aid_mailclean_p_city_name_Invalid := HVCCW_Fields.InValid_aid_mailclean_p_city_name((SALT311.StrType)le.aid_mailclean_p_city_name);
    SELF.aid_mailclean_v_city_name_Invalid := HVCCW_Fields.InValid_aid_mailclean_v_city_name((SALT311.StrType)le.aid_mailclean_v_city_name);
    SELF.aid_mailclean_st_Invalid := HVCCW_Fields.InValid_aid_mailclean_st((SALT311.StrType)le.aid_mailclean_st);
    SELF.aid_mailclean_zip_Invalid := HVCCW_Fields.InValid_aid_mailclean_zip((SALT311.StrType)le.aid_mailclean_zip);
    SELF.aid_mailclean_zip4_Invalid := HVCCW_Fields.InValid_aid_mailclean_zip4((SALT311.StrType)le.aid_mailclean_zip4);
    SELF.aid_mailclean_cart_Invalid := HVCCW_Fields.InValid_aid_mailclean_cart((SALT311.StrType)le.aid_mailclean_cart);
    SELF.aid_mailclean_cr_sort_sz_Invalid := HVCCW_Fields.InValid_aid_mailclean_cr_sort_sz((SALT311.StrType)le.aid_mailclean_cr_sort_sz);
    SELF.aid_mailclean_lot_Invalid := HVCCW_Fields.InValid_aid_mailclean_lot((SALT311.StrType)le.aid_mailclean_lot);
    SELF.aid_mailclean_lot_order_Invalid := HVCCW_Fields.InValid_aid_mailclean_lot_order((SALT311.StrType)le.aid_mailclean_lot_order);
    SELF.aid_mailclean_dpbc_Invalid := HVCCW_Fields.InValid_aid_mailclean_dpbc((SALT311.StrType)le.aid_mailclean_dpbc);
    SELF.aid_mailclean_chk_digit_Invalid := HVCCW_Fields.InValid_aid_mailclean_chk_digit((SALT311.StrType)le.aid_mailclean_chk_digit);
    SELF.aid_mailclean_record_type_Invalid := HVCCW_Fields.InValid_aid_mailclean_record_type((SALT311.StrType)le.aid_mailclean_record_type);
    SELF.aid_mailclean_ace_fips_st_Invalid := HVCCW_Fields.InValid_aid_mailclean_ace_fips_st((SALT311.StrType)le.aid_mailclean_ace_fips_st);
    SELF.aid_mailclean_fipscounty_Invalid := HVCCW_Fields.InValid_aid_mailclean_fipscounty((SALT311.StrType)le.aid_mailclean_fipscounty);
    SELF.aid_mailclean_geo_lat_Invalid := HVCCW_Fields.InValid_aid_mailclean_geo_lat((SALT311.StrType)le.aid_mailclean_geo_lat);
    SELF.aid_mailclean_geo_long_Invalid := HVCCW_Fields.InValid_aid_mailclean_geo_long((SALT311.StrType)le.aid_mailclean_geo_long);
    SELF.aid_mailclean_msa_Invalid := HVCCW_Fields.InValid_aid_mailclean_msa((SALT311.StrType)le.aid_mailclean_msa);
    SELF.aid_mailclean_geo_blk_Invalid := HVCCW_Fields.InValid_aid_mailclean_geo_blk((SALT311.StrType)le.aid_mailclean_geo_blk);
    SELF.aid_mailclean_geo_match_Invalid := HVCCW_Fields.InValid_aid_mailclean_geo_match((SALT311.StrType)le.aid_mailclean_geo_match);
    SELF.aid_mailclean_err_stat_Invalid := HVCCW_Fields.InValid_aid_mailclean_err_stat((SALT311.StrType)le.aid_mailclean_err_stat);
    SELF.prim_range_Invalid := HVCCW_Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := HVCCW_Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := HVCCW_Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.suffix_Invalid := HVCCW_Fields.InValid_suffix((SALT311.StrType)le.suffix);
    SELF.postdir_Invalid := HVCCW_Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := HVCCW_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := HVCCW_Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := HVCCW_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.city_name_Invalid := HVCCW_Fields.InValid_city_name((SALT311.StrType)le.city_name);
    SELF.st_Invalid := HVCCW_Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip_Invalid := HVCCW_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.zip4_Invalid := HVCCW_Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.cart_Invalid := HVCCW_Fields.InValid_cart((SALT311.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := HVCCW_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := HVCCW_Fields.InValid_lot((SALT311.StrType)le.lot);
    SELF.lot_order_Invalid := HVCCW_Fields.InValid_lot_order((SALT311.StrType)le.lot_order);
    SELF.dpbc_Invalid := HVCCW_Fields.InValid_dpbc((SALT311.StrType)le.dpbc);
    SELF.chk_digit_Invalid := HVCCW_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    SELF.record_type_Invalid := HVCCW_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.ace_fips_st_Invalid := HVCCW_Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st);
    SELF.county_Invalid := HVCCW_Fields.InValid_county((SALT311.StrType)le.county);
    SELF.geo_lat_Invalid := HVCCW_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    SELF.geo_long_Invalid := HVCCW_Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    SELF.msa_Invalid := HVCCW_Fields.InValid_msa((SALT311.StrType)le.msa);
    SELF.geo_blk_Invalid := HVCCW_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk);
    SELF.geo_match_Invalid := HVCCW_Fields.InValid_geo_match((SALT311.StrType)le.geo_match);
    SELF.err_stat_Invalid := HVCCW_Fields.InValid_err_stat((SALT311.StrType)le.err_stat);
    SELF.mail_prim_range_Invalid := HVCCW_Fields.InValid_mail_prim_range((SALT311.StrType)le.mail_prim_range);
    SELF.mail_predir_Invalid := HVCCW_Fields.InValid_mail_predir((SALT311.StrType)le.mail_predir);
    SELF.mail_prim_name_Invalid := HVCCW_Fields.InValid_mail_prim_name((SALT311.StrType)le.mail_prim_name);
    SELF.mail_addr_suffix_Invalid := HVCCW_Fields.InValid_mail_addr_suffix((SALT311.StrType)le.mail_addr_suffix);
    SELF.mail_postdir_Invalid := HVCCW_Fields.InValid_mail_postdir((SALT311.StrType)le.mail_postdir);
    SELF.mail_unit_desig_Invalid := HVCCW_Fields.InValid_mail_unit_desig((SALT311.StrType)le.mail_unit_desig);
    SELF.mail_sec_range_Invalid := HVCCW_Fields.InValid_mail_sec_range((SALT311.StrType)le.mail_sec_range);
    SELF.mail_p_city_name_Invalid := HVCCW_Fields.InValid_mail_p_city_name((SALT311.StrType)le.mail_p_city_name);
    SELF.mail_v_city_name_Invalid := HVCCW_Fields.InValid_mail_v_city_name((SALT311.StrType)le.mail_v_city_name);
    SELF.mail_st_Invalid := HVCCW_Fields.InValid_mail_st((SALT311.StrType)le.mail_st);
    SELF.mail_ace_zip_Invalid := HVCCW_Fields.InValid_mail_ace_zip((SALT311.StrType)le.mail_ace_zip);
    SELF.mail_zip4_Invalid := HVCCW_Fields.InValid_mail_zip4((SALT311.StrType)le.mail_zip4);
    SELF.mail_cart_Invalid := HVCCW_Fields.InValid_mail_cart((SALT311.StrType)le.mail_cart);
    SELF.mail_cr_sort_sz_Invalid := HVCCW_Fields.InValid_mail_cr_sort_sz((SALT311.StrType)le.mail_cr_sort_sz);
    SELF.mail_lot_Invalid := HVCCW_Fields.InValid_mail_lot((SALT311.StrType)le.mail_lot);
    SELF.mail_lot_order_Invalid := HVCCW_Fields.InValid_mail_lot_order((SALT311.StrType)le.mail_lot_order);
    SELF.mail_dpbc_Invalid := HVCCW_Fields.InValid_mail_dpbc((SALT311.StrType)le.mail_dpbc);
    SELF.mail_chk_digit_Invalid := HVCCW_Fields.InValid_mail_chk_digit((SALT311.StrType)le.mail_chk_digit);
    SELF.mail_record_type_Invalid := HVCCW_Fields.InValid_mail_record_type((SALT311.StrType)le.mail_record_type);
    SELF.mail_ace_fips_st_Invalid := HVCCW_Fields.InValid_mail_ace_fips_st((SALT311.StrType)le.mail_ace_fips_st);
    SELF.mail_fipscounty_Invalid := HVCCW_Fields.InValid_mail_fipscounty((SALT311.StrType)le.mail_fipscounty);
    SELF.mail_geo_lat_Invalid := HVCCW_Fields.InValid_mail_geo_lat((SALT311.StrType)le.mail_geo_lat);
    SELF.mail_geo_long_Invalid := HVCCW_Fields.InValid_mail_geo_long((SALT311.StrType)le.mail_geo_long);
    SELF.mail_msa_Invalid := HVCCW_Fields.InValid_mail_msa((SALT311.StrType)le.mail_msa);
    SELF.mail_geo_blk_Invalid := HVCCW_Fields.InValid_mail_geo_blk((SALT311.StrType)le.mail_geo_blk);
    SELF.mail_geo_match_Invalid := HVCCW_Fields.InValid_mail_geo_match((SALT311.StrType)le.mail_geo_match);
    SELF.cass_prim_range_Invalid := HVCCW_Fields.InValid_cass_prim_range((SALT311.StrType)le.cass_prim_range);
    SELF.cass_predir_Invalid := HVCCW_Fields.InValid_cass_predir((SALT311.StrType)le.cass_predir);
    SELF.cass_prim_name_Invalid := HVCCW_Fields.InValid_cass_prim_name((SALT311.StrType)le.cass_prim_name);
    SELF.cass_addr_suffix_Invalid := HVCCW_Fields.InValid_cass_addr_suffix((SALT311.StrType)le.cass_addr_suffix);
    SELF.cass_postdir_Invalid := HVCCW_Fields.InValid_cass_postdir((SALT311.StrType)le.cass_postdir);
    SELF.cass_unit_desig_Invalid := HVCCW_Fields.InValid_cass_unit_desig((SALT311.StrType)le.cass_unit_desig);
    SELF.cass_sec_range_Invalid := HVCCW_Fields.InValid_cass_sec_range((SALT311.StrType)le.cass_sec_range);
    SELF.cass_p_city_name_Invalid := HVCCW_Fields.InValid_cass_p_city_name((SALT311.StrType)le.cass_p_city_name);
    SELF.cass_v_city_name_Invalid := HVCCW_Fields.InValid_cass_v_city_name((SALT311.StrType)le.cass_v_city_name);
    SELF.cass_st_Invalid := HVCCW_Fields.InValid_cass_st((SALT311.StrType)le.cass_st);
    SELF.cass_ace_zip_Invalid := HVCCW_Fields.InValid_cass_ace_zip((SALT311.StrType)le.cass_ace_zip);
    SELF.cass_zip4_Invalid := HVCCW_Fields.InValid_cass_zip4((SALT311.StrType)le.cass_zip4);
    SELF.cass_cart_Invalid := HVCCW_Fields.InValid_cass_cart((SALT311.StrType)le.cass_cart);
    SELF.cass_cr_sort_sz_Invalid := HVCCW_Fields.InValid_cass_cr_sort_sz((SALT311.StrType)le.cass_cr_sort_sz);
    SELF.cass_lot_Invalid := HVCCW_Fields.InValid_cass_lot((SALT311.StrType)le.cass_lot);
    SELF.cass_lot_order_Invalid := HVCCW_Fields.InValid_cass_lot_order((SALT311.StrType)le.cass_lot_order);
    SELF.cass_dpbc_Invalid := HVCCW_Fields.InValid_cass_dpbc((SALT311.StrType)le.cass_dpbc);
    SELF.cass_chk_digit_Invalid := HVCCW_Fields.InValid_cass_chk_digit((SALT311.StrType)le.cass_chk_digit);
    SELF.cass_record_type_Invalid := HVCCW_Fields.InValid_cass_record_type((SALT311.StrType)le.cass_record_type);
    SELF.cass_ace_fips_st_Invalid := HVCCW_Fields.InValid_cass_ace_fips_st((SALT311.StrType)le.cass_ace_fips_st);
    SELF.cass_fipscounty_Invalid := HVCCW_Fields.InValid_cass_fipscounty((SALT311.StrType)le.cass_fipscounty);
    SELF.cass_geo_lat_Invalid := HVCCW_Fields.InValid_cass_geo_lat((SALT311.StrType)le.cass_geo_lat);
    SELF.cass_geo_long_Invalid := HVCCW_Fields.InValid_cass_geo_long((SALT311.StrType)le.cass_geo_long);
    SELF.cass_msa_Invalid := HVCCW_Fields.InValid_cass_msa((SALT311.StrType)le.cass_msa);
    SELF.cass_geo_blk_Invalid := HVCCW_Fields.InValid_cass_geo_blk((SALT311.StrType)le.cass_geo_blk);
    SELF.cass_geo_match_Invalid := HVCCW_Fields.InValid_cass_geo_match((SALT311.StrType)le.cass_geo_match);
    SELF.cass_err_stat_Invalid := HVCCW_Fields.InValid_cass_err_stat((SALT311.StrType)le.cass_err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),HVCCW_Layout_eMerges);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.append_seqnum_Invalid << 0 ) + ( le.persistent_record_id_Invalid << 1 ) + ( le.process_date_Invalid << 2 ) + ( le.date_first_seen_Invalid << 3 ) + ( le.date_last_seen_Invalid << 4 ) + ( le.score_Invalid << 5 ) + ( le.best_ssn_Invalid << 6 ) + ( le.did_out_Invalid << 7 ) + ( le.source_Invalid << 8 ) + ( le.file_id_Invalid << 9 ) + ( le.source_state_Invalid << 10 ) + ( le.source_code_Invalid << 11 ) + ( le.file_acquired_date_Invalid << 12 ) + ( le._use_Invalid << 13 ) + ( le.title_in_Invalid << 14 ) + ( le.lname_in_Invalid << 15 ) + ( le.fname_in_Invalid << 16 ) + ( le.mname_in_Invalid << 17 ) + ( le.maiden_prior_Invalid << 18 ) + ( le.name_suffix_in_Invalid << 19 ) + ( le.source_voterid_Invalid << 20 ) + ( le.dob_str_in_Invalid << 21 ) + ( le.agecat_Invalid << 22 ) + ( le.headhousehold_Invalid << 23 ) + ( le.place_of_birth_Invalid << 24 ) + ( le.occupation_Invalid << 25 ) + ( le.maiden_name_Invalid << 26 ) + ( le.motorvoterid_Invalid << 27 ) + ( le.regsource_Invalid << 28 ) + ( le.regdate_in_Invalid << 29 ) + ( le.race_Invalid << 30 ) + ( le.gender_Invalid << 31 ) + ( le.poliparty_Invalid << 32 ) + ( le.phone_Invalid << 33 ) + ( le.work_phone_Invalid << 34 ) + ( le.other_phone_Invalid << 35 ) + ( le.active_status_Invalid << 36 ) + ( le.active_other_Invalid << 37 ) + ( le.voterstatus_Invalid << 38 ) + ( le.resaddr1_Invalid << 39 ) + ( le.resaddr2_Invalid << 40 ) + ( le.res_city_Invalid << 41 ) + ( le.res_state_Invalid << 42 ) + ( le.res_zip_Invalid << 43 ) + ( le.res_county_Invalid << 44 ) + ( le.mail_addr1_Invalid << 45 ) + ( le.mail_addr2_Invalid << 46 ) + ( le.mail_city_Invalid << 47 ) + ( le.mail_state_Invalid << 48 ) + ( le.mail_zip_Invalid << 50 ) + ( le.mail_county_Invalid << 51 ) + ( le.towncode_Invalid << 52 ) + ( le.distcode_Invalid << 53 ) + ( le.countycode_Invalid << 54 ) + ( le.schoolcode_Invalid << 55 ) + ( le.cityinout_Invalid << 56 ) + ( le.spec_dist1_Invalid << 57 ) + ( le.spec_dist2_Invalid << 58 ) + ( le.precinct1_Invalid << 59 ) + ( le.precinct2_Invalid << 60 ) + ( le.precinct3_Invalid << 61 ) + ( le.villageprecinct_Invalid << 62 ) + ( le.schoolprecinct_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.ward_Invalid << 0 ) + ( le.precinct_citytown_Invalid << 1 ) + ( le.ancsmdindc_Invalid << 2 ) + ( le.citycouncildist_Invalid << 3 ) + ( le.countycommdist_Invalid << 4 ) + ( le.statehouse_Invalid << 5 ) + ( le.statesenate_Invalid << 6 ) + ( le.ushouse_Invalid << 7 ) + ( le.elemschooldist_Invalid << 8 ) + ( le.schooldist_Invalid << 9 ) + ( le.commcolldist_Invalid << 10 ) + ( le.municipal_Invalid << 11 ) + ( le.villagedist_Invalid << 12 ) + ( le.policejury_Invalid << 13 ) + ( le.policedist_Invalid << 14 ) + ( le.publicservcomm_Invalid << 15 ) + ( le.rescue_Invalid << 16 ) + ( le.fire_Invalid << 17 ) + ( le.sanitary_Invalid << 18 ) + ( le.sewerdist_Invalid << 19 ) + ( le.waterdist_Invalid << 20 ) + ( le.mosquitodist_Invalid << 21 ) + ( le.taxdist_Invalid << 22 ) + ( le.supremecourt_Invalid << 23 ) + ( le.justiceofpeace_Invalid << 24 ) + ( le.judicialdist_Invalid << 25 ) + ( le.superiorctdist_Invalid << 26 ) + ( le.appealsct_Invalid << 27 ) + ( le.contributorparty_Invalid << 28 ) + ( le.recptparty_Invalid << 29 ) + ( le.dateofcontr_in_Invalid << 30 ) + ( le.dollaramt_Invalid << 31 ) + ( le.officecontto_Invalid << 32 ) + ( le.cumuldollaramt_Invalid << 33 ) + ( le.conttype_Invalid << 34 ) + ( le.primary02_Invalid << 35 ) + ( le.special02_Invalid << 36 ) + ( le.other02_Invalid << 37 ) + ( le.special202_Invalid << 38 ) + ( le.general02_Invalid << 39 ) + ( le.primary01_Invalid << 40 ) + ( le.special01_Invalid << 41 ) + ( le.other01_Invalid << 42 ) + ( le.special201_Invalid << 43 ) + ( le.general01_Invalid << 44 ) + ( le.pres00_Invalid << 45 ) + ( le.primary00_Invalid << 46 ) + ( le.special00_Invalid << 47 ) + ( le.other00_Invalid << 48 ) + ( le.special200_Invalid << 49 ) + ( le.general00_Invalid << 50 ) + ( le.primary99_Invalid << 51 ) + ( le.special99_Invalid << 52 ) + ( le.other99_Invalid << 53 ) + ( le.special299_Invalid << 54 ) + ( le.general99_Invalid << 55 ) + ( le.primary98_Invalid << 56 ) + ( le.special98_Invalid << 57 ) + ( le.other98_Invalid << 58 ) + ( le.special298_Invalid << 59 ) + ( le.general98_Invalid << 60 ) + ( le.primary97_Invalid << 61 ) + ( le.special97_Invalid << 62 ) + ( le.other97_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.special297_Invalid << 0 ) + ( le.general97_Invalid << 1 ) + ( le.pres96_Invalid << 2 ) + ( le.primary96_Invalid << 3 ) + ( le.special96_Invalid << 4 ) + ( le.other96_Invalid << 5 ) + ( le.special296_Invalid << 6 ) + ( le.general96_Invalid << 7 ) + ( le.lastdayvote_in_Invalid << 8 ) + ( le.huntfishperm_Invalid << 9 ) + ( le.datelicense_in_Invalid << 10 ) + ( le.homestate_Invalid << 11 ) + ( le.resident_Invalid << 12 ) + ( le.nonresident_Invalid << 13 ) + ( le.hunt_Invalid << 14 ) + ( le.fish_Invalid << 15 ) + ( le.combosuper_Invalid << 16 ) + ( le.sportsman_Invalid << 17 ) + ( le.trap_Invalid << 18 ) + ( le.archery_Invalid << 19 ) + ( le.muzzle_Invalid << 20 ) + ( le.drawing_Invalid << 21 ) + ( le.day1_Invalid << 22 ) + ( le.day3_Invalid << 23 ) + ( le.day7_Invalid << 24 ) + ( le.day14to15_Invalid << 25 ) + ( le.seasonannual_Invalid << 26 ) + ( le.lifetimepermit_Invalid << 27 ) + ( le.landowner_Invalid << 28 ) + ( le.family_Invalid << 29 ) + ( le.junior_Invalid << 30 ) + ( le.seniorcit_Invalid << 31 ) + ( le.crewmemeber_Invalid << 32 ) + ( le.retarded_Invalid << 33 ) + ( le.indian_Invalid << 34 ) + ( le.serviceman_Invalid << 35 ) + ( le.disabled_Invalid << 36 ) + ( le.lowincome_Invalid << 37 ) + ( le.regioncounty_Invalid << 38 ) + ( le.blind_Invalid << 39 ) + ( le.salmon_Invalid << 40 ) + ( le.freshwater_Invalid << 41 ) + ( le.saltwater_Invalid << 42 ) + ( le.lakesandresevoirs_Invalid << 43 ) + ( le.setlinefish_Invalid << 44 ) + ( le.trout_Invalid << 45 ) + ( le.fallfishing_Invalid << 46 ) + ( le.steelhead_Invalid << 47 ) + ( le.whitejubherring_Invalid << 48 ) + ( le.sturgeon_Invalid << 49 ) + ( le.shellfishcrab_Invalid << 50 ) + ( le.shellfishlobster_Invalid << 51 ) + ( le.deer_Invalid << 52 ) + ( le.bear_Invalid << 53 ) + ( le.elk_Invalid << 54 ) + ( le.moose_Invalid << 55 ) + ( le.buffalo_Invalid << 56 ) + ( le.antelope_Invalid << 57 ) + ( le.sikebull_Invalid << 58 ) + ( le.bighorn_Invalid << 59 ) + ( le.javelina_Invalid << 60 ) + ( le.cougar_Invalid << 61 ) + ( le.anterless_Invalid << 62 ) + ( le.pheasant_Invalid << 63 );
    SELF.ScrubsBits4 := ( le.goose_Invalid << 0 ) + ( le.duck_Invalid << 1 ) + ( le.turkey_Invalid << 2 ) + ( le.snowmobile_Invalid << 3 ) + ( le.biggame_Invalid << 4 ) + ( le.skipass_Invalid << 5 ) + ( le.migbird_Invalid << 6 ) + ( le.smallgame_Invalid << 7 ) + ( le.sturgeon2_Invalid << 8 ) + ( le.gun_Invalid << 9 ) + ( le.bonus_Invalid << 10 ) + ( le.lottery_Invalid << 11 ) + ( le.otherbirds_Invalid << 12 ) + ( le.boatindexnum_Invalid << 13 ) + ( le.boatcoowner_Invalid << 14 ) + ( le.hullidnum_Invalid << 15 ) + ( le.yearmade_Invalid << 16 ) + ( le.model_Invalid << 17 ) + ( le.manufacturer_Invalid << 18 ) + ( le.lengt_Invalid << 19 ) + ( le.hullconstruct_Invalid << 20 ) + ( le.primuse_Invalid << 21 ) + ( le.fueltype_Invalid << 22 ) + ( le.propulsion_Invalid << 23 ) + ( le.modeltype_Invalid << 24 ) + ( le.regexpdate_in_Invalid << 25 ) + ( le.titlenum_Invalid << 26 ) + ( le.stprimuse_Invalid << 27 ) + ( le.titlestatus_Invalid << 28 ) + ( le.vessel_Invalid << 29 ) + ( le.specreg_Invalid << 30 ) + ( le.ccwpermnum_Invalid << 31 ) + ( le.ccwweapontype_Invalid << 32 ) + ( le.ccwregdate_in_Invalid << 33 ) + ( le.ccwexpdate_in_Invalid << 34 ) + ( le.ccwpermtype_Invalid << 35 ) + ( le.dob_str_Invalid << 36 ) + ( le.regdate_Invalid << 37 ) + ( le.dateofcontr_Invalid << 38 ) + ( le.lastdayvote_Invalid << 39 ) + ( le.datelicense_Invalid << 40 ) + ( le.regexpdate_Invalid << 41 ) + ( le.ccwregdate_Invalid << 42 ) + ( le.ccwexpdate_Invalid << 43 ) + ( le.title_Invalid << 44 ) + ( le.fname_Invalid << 45 ) + ( le.mname_Invalid << 46 ) + ( le.lname_Invalid << 47 ) + ( le.name_suffix_Invalid << 48 ) + ( le.score_on_input_Invalid << 49 ) + ( le.append_prep_resaddress1_Invalid << 50 ) + ( le.append_prep_resaddress2_Invalid << 51 ) + ( le.append_resrawaid_Invalid << 52 ) + ( le.append_prep_mailaddress1_Invalid << 53 ) + ( le.append_prep_mailaddress2_Invalid << 54 ) + ( le.append_mailrawaid_Invalid << 55 ) + ( le.append_prep_cassaddress1_Invalid << 56 ) + ( le.append_prep_cassaddress2_Invalid << 57 ) + ( le.append_cassrawaid_Invalid << 58 ) + ( le.aid_resclean_prim_range_Invalid << 59 ) + ( le.aid_resclean_predir_Invalid << 60 ) + ( le.aid_resclean_prim_name_Invalid << 61 ) + ( le.aid_resclean_addr_suffix_Invalid << 62 ) + ( le.aid_resclean_postdir_Invalid << 63 );
    SELF.ScrubsBits5 := ( le.aid_resclean_unit_desig_Invalid << 0 ) + ( le.aid_resclean_sec_range_Invalid << 1 ) + ( le.aid_resclean_p_city_name_Invalid << 2 ) + ( le.aid_resclean_v_city_name_Invalid << 3 ) + ( le.aid_resclean_st_Invalid << 4 ) + ( le.aid_resclean_zip_Invalid << 6 ) + ( le.aid_resclean_zip4_Invalid << 8 ) + ( le.aid_resclean_cart_Invalid << 9 ) + ( le.aid_resclean_cr_sort_sz_Invalid << 10 ) + ( le.aid_resclean_lot_Invalid << 11 ) + ( le.aid_resclean_lot_order_Invalid << 12 ) + ( le.aid_resclean_dpbc_Invalid << 13 ) + ( le.aid_resclean_chk_digit_Invalid << 14 ) + ( le.aid_resclean_record_type_Invalid << 15 ) + ( le.aid_resclean_ace_fips_st_Invalid << 16 ) + ( le.aid_resclean_fipscounty_Invalid << 17 ) + ( le.aid_resclean_geo_lat_Invalid << 18 ) + ( le.aid_resclean_geo_long_Invalid << 19 ) + ( le.aid_resclean_msa_Invalid << 20 ) + ( le.aid_resclean_geo_blk_Invalid << 21 ) + ( le.aid_resclean_geo_match_Invalid << 22 ) + ( le.aid_resclean_err_stat_Invalid << 23 ) + ( le.aid_mailclean_prim_range_Invalid << 24 ) + ( le.aid_mailclean_predir_Invalid << 25 ) + ( le.aid_mailclean_prim_name_Invalid << 26 ) + ( le.aid_mailclean_addr_suffix_Invalid << 27 ) + ( le.aid_mailclean_postdir_Invalid << 28 ) + ( le.aid_mailclean_unit_desig_Invalid << 29 ) + ( le.aid_mailclean_sec_range_Invalid << 30 ) + ( le.aid_mailclean_p_city_name_Invalid << 31 ) + ( le.aid_mailclean_v_city_name_Invalid << 32 ) + ( le.aid_mailclean_st_Invalid << 33 ) + ( le.aid_mailclean_zip_Invalid << 35 ) + ( le.aid_mailclean_zip4_Invalid << 37 ) + ( le.aid_mailclean_cart_Invalid << 38 ) + ( le.aid_mailclean_cr_sort_sz_Invalid << 39 ) + ( le.aid_mailclean_lot_Invalid << 40 ) + ( le.aid_mailclean_lot_order_Invalid << 41 ) + ( le.aid_mailclean_dpbc_Invalid << 42 ) + ( le.aid_mailclean_chk_digit_Invalid << 43 ) + ( le.aid_mailclean_record_type_Invalid << 44 ) + ( le.aid_mailclean_ace_fips_st_Invalid << 45 ) + ( le.aid_mailclean_fipscounty_Invalid << 46 ) + ( le.aid_mailclean_geo_lat_Invalid << 47 ) + ( le.aid_mailclean_geo_long_Invalid << 48 ) + ( le.aid_mailclean_msa_Invalid << 49 ) + ( le.aid_mailclean_geo_blk_Invalid << 50 ) + ( le.aid_mailclean_geo_match_Invalid << 51 ) + ( le.aid_mailclean_err_stat_Invalid << 52 ) + ( le.prim_range_Invalid << 53 ) + ( le.predir_Invalid << 54 ) + ( le.prim_name_Invalid << 55 ) + ( le.suffix_Invalid << 56 ) + ( le.postdir_Invalid << 57 ) + ( le.unit_desig_Invalid << 58 ) + ( le.sec_range_Invalid << 59 ) + ( le.p_city_name_Invalid << 60 ) + ( le.city_name_Invalid << 61 ) + ( le.st_Invalid << 62 );
    SELF.ScrubsBits6 := ( le.zip_Invalid << 0 ) + ( le.zip4_Invalid << 2 ) + ( le.cart_Invalid << 3 ) + ( le.cr_sort_sz_Invalid << 4 ) + ( le.lot_Invalid << 5 ) + ( le.lot_order_Invalid << 6 ) + ( le.dpbc_Invalid << 7 ) + ( le.chk_digit_Invalid << 8 ) + ( le.record_type_Invalid << 9 ) + ( le.ace_fips_st_Invalid << 10 ) + ( le.county_Invalid << 11 ) + ( le.geo_lat_Invalid << 12 ) + ( le.geo_long_Invalid << 13 ) + ( le.msa_Invalid << 14 ) + ( le.geo_blk_Invalid << 15 ) + ( le.geo_match_Invalid << 16 ) + ( le.err_stat_Invalid << 17 ) + ( le.mail_prim_range_Invalid << 18 ) + ( le.mail_predir_Invalid << 19 ) + ( le.mail_prim_name_Invalid << 20 ) + ( le.mail_addr_suffix_Invalid << 21 ) + ( le.mail_postdir_Invalid << 22 ) + ( le.mail_unit_desig_Invalid << 23 ) + ( le.mail_sec_range_Invalid << 24 ) + ( le.mail_p_city_name_Invalid << 25 ) + ( le.mail_v_city_name_Invalid << 26 ) + ( le.mail_st_Invalid << 27 ) + ( le.mail_ace_zip_Invalid << 29 ) + ( le.mail_zip4_Invalid << 31 ) + ( le.mail_cart_Invalid << 32 ) + ( le.mail_cr_sort_sz_Invalid << 33 ) + ( le.mail_lot_Invalid << 34 ) + ( le.mail_lot_order_Invalid << 35 ) + ( le.mail_dpbc_Invalid << 36 ) + ( le.mail_chk_digit_Invalid << 37 ) + ( le.mail_record_type_Invalid << 38 ) + ( le.mail_ace_fips_st_Invalid << 39 ) + ( le.mail_fipscounty_Invalid << 40 ) + ( le.mail_geo_lat_Invalid << 41 ) + ( le.mail_geo_long_Invalid << 42 ) + ( le.mail_msa_Invalid << 43 ) + ( le.mail_geo_blk_Invalid << 44 ) + ( le.mail_geo_match_Invalid << 45 ) + ( le.cass_prim_range_Invalid << 46 ) + ( le.cass_predir_Invalid << 47 ) + ( le.cass_prim_name_Invalid << 48 ) + ( le.cass_addr_suffix_Invalid << 49 ) + ( le.cass_postdir_Invalid << 50 ) + ( le.cass_unit_desig_Invalid << 51 ) + ( le.cass_sec_range_Invalid << 52 ) + ( le.cass_p_city_name_Invalid << 53 ) + ( le.cass_v_city_name_Invalid << 54 ) + ( le.cass_st_Invalid << 55 ) + ( le.cass_ace_zip_Invalid << 57 ) + ( le.cass_zip4_Invalid << 59 ) + ( le.cass_cart_Invalid << 60 ) + ( le.cass_cr_sort_sz_Invalid << 61 ) + ( le.cass_lot_Invalid << 62 ) + ( le.cass_lot_order_Invalid << 63 );
    SELF.ScrubsBits7 := ( le.cass_dpbc_Invalid << 0 ) + ( le.cass_chk_digit_Invalid << 1 ) + ( le.cass_record_type_Invalid << 2 ) + ( le.cass_ace_fips_st_Invalid << 3 ) + ( le.cass_fipscounty_Invalid << 4 ) + ( le.cass_geo_lat_Invalid << 5 ) + ( le.cass_geo_long_Invalid << 6 ) + ( le.cass_msa_Invalid << 7 ) + ( le.cass_geo_blk_Invalid << 8 ) + ( le.cass_geo_match_Invalid << 9 ) + ( le.cass_err_stat_Invalid << 10 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0 OR (mask&le.ScrubsBits3)>0 OR (mask&le.ScrubsBits4)>0 OR (mask&le.ScrubsBits5)>0 OR (mask&le.ScrubsBits6)>0 OR (mask&le.ScrubsBits7)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND le.ScrubsBits3=0 AND le.ScrubsBits4=0 AND le.ScrubsBits5=0 AND le.ScrubsBits6=0 AND le.ScrubsBits7=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,HVCCW_Layout_eMerges);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.append_seqnum_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.persistent_record_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.score_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.best_ssn_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.did_out_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.source_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.file_id_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.source_state_Invalid := (le.ScrubsBits1 >> 10) & 1;
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
    SELF.dob_str_in_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.agecat_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.headhousehold_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.place_of_birth_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.occupation_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.maiden_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.motorvoterid_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.regsource_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.regdate_in_Invalid := (le.ScrubsBits1 >> 29) & 1;
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
    SELF.res_state_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.res_zip_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.res_county_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.mail_addr1_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.mail_addr2_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.mail_city_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.mail_state_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.mail_zip_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.mail_county_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.towncode_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.distcode_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.countycode_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.schoolcode_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.cityinout_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.spec_dist1_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.spec_dist2_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.precinct1_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.precinct2_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.precinct3_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.villageprecinct_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.schoolprecinct_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.ward_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.precinct_citytown_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.ancsmdindc_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.citycouncildist_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.countycommdist_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.statehouse_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.statesenate_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.ushouse_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.elemschooldist_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.schooldist_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.commcolldist_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.municipal_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.villagedist_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.policejury_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.policedist_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.publicservcomm_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.rescue_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.fire_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.sanitary_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.sewerdist_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.waterdist_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.mosquitodist_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.taxdist_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.supremecourt_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.justiceofpeace_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.judicialdist_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.superiorctdist_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.appealsct_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.contributorparty_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.recptparty_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.dateofcontr_in_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.dollaramt_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.officecontto_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.cumuldollaramt_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.conttype_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.primary02_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.special02_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.other02_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.special202_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.general02_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.primary01_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.special01_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.other01_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.special201_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.general01_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.pres00_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.primary00_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.special00_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.other00_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.special200_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.general00_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.primary99_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.special99_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.other99_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.special299_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.general99_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.primary98_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.special98_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.other98_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.special298_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.general98_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.primary97_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.special97_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.other97_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.special297_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.general97_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.pres96_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.primary96_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.special96_Invalid := (le.ScrubsBits3 >> 4) & 1;
    SELF.other96_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.special296_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.general96_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.lastdayvote_in_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.huntfishperm_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.datelicense_in_Invalid := (le.ScrubsBits3 >> 10) & 1;
    SELF.homestate_Invalid := (le.ScrubsBits3 >> 11) & 1;
    SELF.resident_Invalid := (le.ScrubsBits3 >> 12) & 1;
    SELF.nonresident_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.hunt_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.fish_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.combosuper_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.sportsman_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.trap_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.archery_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.muzzle_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.drawing_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.day1_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.day3_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.day7_Invalid := (le.ScrubsBits3 >> 24) & 1;
    SELF.day14to15_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.seasonannual_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF.lifetimepermit_Invalid := (le.ScrubsBits3 >> 27) & 1;
    SELF.landowner_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.family_Invalid := (le.ScrubsBits3 >> 29) & 1;
    SELF.junior_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.seniorcit_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.crewmemeber_Invalid := (le.ScrubsBits3 >> 32) & 1;
    SELF.retarded_Invalid := (le.ScrubsBits3 >> 33) & 1;
    SELF.indian_Invalid := (le.ScrubsBits3 >> 34) & 1;
    SELF.serviceman_Invalid := (le.ScrubsBits3 >> 35) & 1;
    SELF.disabled_Invalid := (le.ScrubsBits3 >> 36) & 1;
    SELF.lowincome_Invalid := (le.ScrubsBits3 >> 37) & 1;
    SELF.regioncounty_Invalid := (le.ScrubsBits3 >> 38) & 1;
    SELF.blind_Invalid := (le.ScrubsBits3 >> 39) & 1;
    SELF.salmon_Invalid := (le.ScrubsBits3 >> 40) & 1;
    SELF.freshwater_Invalid := (le.ScrubsBits3 >> 41) & 1;
    SELF.saltwater_Invalid := (le.ScrubsBits3 >> 42) & 1;
    SELF.lakesandresevoirs_Invalid := (le.ScrubsBits3 >> 43) & 1;
    SELF.setlinefish_Invalid := (le.ScrubsBits3 >> 44) & 1;
    SELF.trout_Invalid := (le.ScrubsBits3 >> 45) & 1;
    SELF.fallfishing_Invalid := (le.ScrubsBits3 >> 46) & 1;
    SELF.steelhead_Invalid := (le.ScrubsBits3 >> 47) & 1;
    SELF.whitejubherring_Invalid := (le.ScrubsBits3 >> 48) & 1;
    SELF.sturgeon_Invalid := (le.ScrubsBits3 >> 49) & 1;
    SELF.shellfishcrab_Invalid := (le.ScrubsBits3 >> 50) & 1;
    SELF.shellfishlobster_Invalid := (le.ScrubsBits3 >> 51) & 1;
    SELF.deer_Invalid := (le.ScrubsBits3 >> 52) & 1;
    SELF.bear_Invalid := (le.ScrubsBits3 >> 53) & 1;
    SELF.elk_Invalid := (le.ScrubsBits3 >> 54) & 1;
    SELF.moose_Invalid := (le.ScrubsBits3 >> 55) & 1;
    SELF.buffalo_Invalid := (le.ScrubsBits3 >> 56) & 1;
    SELF.antelope_Invalid := (le.ScrubsBits3 >> 57) & 1;
    SELF.sikebull_Invalid := (le.ScrubsBits3 >> 58) & 1;
    SELF.bighorn_Invalid := (le.ScrubsBits3 >> 59) & 1;
    SELF.javelina_Invalid := (le.ScrubsBits3 >> 60) & 1;
    SELF.cougar_Invalid := (le.ScrubsBits3 >> 61) & 1;
    SELF.anterless_Invalid := (le.ScrubsBits3 >> 62) & 1;
    SELF.pheasant_Invalid := (le.ScrubsBits3 >> 63) & 1;
    SELF.goose_Invalid := (le.ScrubsBits4 >> 0) & 1;
    SELF.duck_Invalid := (le.ScrubsBits4 >> 1) & 1;
    SELF.turkey_Invalid := (le.ScrubsBits4 >> 2) & 1;
    SELF.snowmobile_Invalid := (le.ScrubsBits4 >> 3) & 1;
    SELF.biggame_Invalid := (le.ScrubsBits4 >> 4) & 1;
    SELF.skipass_Invalid := (le.ScrubsBits4 >> 5) & 1;
    SELF.migbird_Invalid := (le.ScrubsBits4 >> 6) & 1;
    SELF.smallgame_Invalid := (le.ScrubsBits4 >> 7) & 1;
    SELF.sturgeon2_Invalid := (le.ScrubsBits4 >> 8) & 1;
    SELF.gun_Invalid := (le.ScrubsBits4 >> 9) & 1;
    SELF.bonus_Invalid := (le.ScrubsBits4 >> 10) & 1;
    SELF.lottery_Invalid := (le.ScrubsBits4 >> 11) & 1;
    SELF.otherbirds_Invalid := (le.ScrubsBits4 >> 12) & 1;
    SELF.boatindexnum_Invalid := (le.ScrubsBits4 >> 13) & 1;
    SELF.boatcoowner_Invalid := (le.ScrubsBits4 >> 14) & 1;
    SELF.hullidnum_Invalid := (le.ScrubsBits4 >> 15) & 1;
    SELF.yearmade_Invalid := (le.ScrubsBits4 >> 16) & 1;
    SELF.model_Invalid := (le.ScrubsBits4 >> 17) & 1;
    SELF.manufacturer_Invalid := (le.ScrubsBits4 >> 18) & 1;
    SELF.lengt_Invalid := (le.ScrubsBits4 >> 19) & 1;
    SELF.hullconstruct_Invalid := (le.ScrubsBits4 >> 20) & 1;
    SELF.primuse_Invalid := (le.ScrubsBits4 >> 21) & 1;
    SELF.fueltype_Invalid := (le.ScrubsBits4 >> 22) & 1;
    SELF.propulsion_Invalid := (le.ScrubsBits4 >> 23) & 1;
    SELF.modeltype_Invalid := (le.ScrubsBits4 >> 24) & 1;
    SELF.regexpdate_in_Invalid := (le.ScrubsBits4 >> 25) & 1;
    SELF.titlenum_Invalid := (le.ScrubsBits4 >> 26) & 1;
    SELF.stprimuse_Invalid := (le.ScrubsBits4 >> 27) & 1;
    SELF.titlestatus_Invalid := (le.ScrubsBits4 >> 28) & 1;
    SELF.vessel_Invalid := (le.ScrubsBits4 >> 29) & 1;
    SELF.specreg_Invalid := (le.ScrubsBits4 >> 30) & 1;
    SELF.ccwpermnum_Invalid := (le.ScrubsBits4 >> 31) & 1;
    SELF.ccwweapontype_Invalid := (le.ScrubsBits4 >> 32) & 1;
    SELF.ccwregdate_in_Invalid := (le.ScrubsBits4 >> 33) & 1;
    SELF.ccwexpdate_in_Invalid := (le.ScrubsBits4 >> 34) & 1;
    SELF.ccwpermtype_Invalid := (le.ScrubsBits4 >> 35) & 1;
    SELF.dob_str_Invalid := (le.ScrubsBits4 >> 36) & 1;
    SELF.regdate_Invalid := (le.ScrubsBits4 >> 37) & 1;
    SELF.dateofcontr_Invalid := (le.ScrubsBits4 >> 38) & 1;
    SELF.lastdayvote_Invalid := (le.ScrubsBits4 >> 39) & 1;
    SELF.datelicense_Invalid := (le.ScrubsBits4 >> 40) & 1;
    SELF.regexpdate_Invalid := (le.ScrubsBits4 >> 41) & 1;
    SELF.ccwregdate_Invalid := (le.ScrubsBits4 >> 42) & 1;
    SELF.ccwexpdate_Invalid := (le.ScrubsBits4 >> 43) & 1;
    SELF.title_Invalid := (le.ScrubsBits4 >> 44) & 1;
    SELF.fname_Invalid := (le.ScrubsBits4 >> 45) & 1;
    SELF.mname_Invalid := (le.ScrubsBits4 >> 46) & 1;
    SELF.lname_Invalid := (le.ScrubsBits4 >> 47) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits4 >> 48) & 1;
    SELF.score_on_input_Invalid := (le.ScrubsBits4 >> 49) & 1;
    SELF.append_prep_resaddress1_Invalid := (le.ScrubsBits4 >> 50) & 1;
    SELF.append_prep_resaddress2_Invalid := (le.ScrubsBits4 >> 51) & 1;
    SELF.append_resrawaid_Invalid := (le.ScrubsBits4 >> 52) & 1;
    SELF.append_prep_mailaddress1_Invalid := (le.ScrubsBits4 >> 53) & 1;
    SELF.append_prep_mailaddress2_Invalid := (le.ScrubsBits4 >> 54) & 1;
    SELF.append_mailrawaid_Invalid := (le.ScrubsBits4 >> 55) & 1;
    SELF.append_prep_cassaddress1_Invalid := (le.ScrubsBits4 >> 56) & 1;
    SELF.append_prep_cassaddress2_Invalid := (le.ScrubsBits4 >> 57) & 1;
    SELF.append_cassrawaid_Invalid := (le.ScrubsBits4 >> 58) & 1;
    SELF.aid_resclean_prim_range_Invalid := (le.ScrubsBits4 >> 59) & 1;
    SELF.aid_resclean_predir_Invalid := (le.ScrubsBits4 >> 60) & 1;
    SELF.aid_resclean_prim_name_Invalid := (le.ScrubsBits4 >> 61) & 1;
    SELF.aid_resclean_addr_suffix_Invalid := (le.ScrubsBits4 >> 62) & 1;
    SELF.aid_resclean_postdir_Invalid := (le.ScrubsBits4 >> 63) & 1;
    SELF.aid_resclean_unit_desig_Invalid := (le.ScrubsBits5 >> 0) & 1;
    SELF.aid_resclean_sec_range_Invalid := (le.ScrubsBits5 >> 1) & 1;
    SELF.aid_resclean_p_city_name_Invalid := (le.ScrubsBits5 >> 2) & 1;
    SELF.aid_resclean_v_city_name_Invalid := (le.ScrubsBits5 >> 3) & 1;
    SELF.aid_resclean_st_Invalid := (le.ScrubsBits5 >> 4) & 3;
    SELF.aid_resclean_zip_Invalid := (le.ScrubsBits5 >> 6) & 3;
    SELF.aid_resclean_zip4_Invalid := (le.ScrubsBits5 >> 8) & 1;
    SELF.aid_resclean_cart_Invalid := (le.ScrubsBits5 >> 9) & 1;
    SELF.aid_resclean_cr_sort_sz_Invalid := (le.ScrubsBits5 >> 10) & 1;
    SELF.aid_resclean_lot_Invalid := (le.ScrubsBits5 >> 11) & 1;
    SELF.aid_resclean_lot_order_Invalid := (le.ScrubsBits5 >> 12) & 1;
    SELF.aid_resclean_dpbc_Invalid := (le.ScrubsBits5 >> 13) & 1;
    SELF.aid_resclean_chk_digit_Invalid := (le.ScrubsBits5 >> 14) & 1;
    SELF.aid_resclean_record_type_Invalid := (le.ScrubsBits5 >> 15) & 1;
    SELF.aid_resclean_ace_fips_st_Invalid := (le.ScrubsBits5 >> 16) & 1;
    SELF.aid_resclean_fipscounty_Invalid := (le.ScrubsBits5 >> 17) & 1;
    SELF.aid_resclean_geo_lat_Invalid := (le.ScrubsBits5 >> 18) & 1;
    SELF.aid_resclean_geo_long_Invalid := (le.ScrubsBits5 >> 19) & 1;
    SELF.aid_resclean_msa_Invalid := (le.ScrubsBits5 >> 20) & 1;
    SELF.aid_resclean_geo_blk_Invalid := (le.ScrubsBits5 >> 21) & 1;
    SELF.aid_resclean_geo_match_Invalid := (le.ScrubsBits5 >> 22) & 1;
    SELF.aid_resclean_err_stat_Invalid := (le.ScrubsBits5 >> 23) & 1;
    SELF.aid_mailclean_prim_range_Invalid := (le.ScrubsBits5 >> 24) & 1;
    SELF.aid_mailclean_predir_Invalid := (le.ScrubsBits5 >> 25) & 1;
    SELF.aid_mailclean_prim_name_Invalid := (le.ScrubsBits5 >> 26) & 1;
    SELF.aid_mailclean_addr_suffix_Invalid := (le.ScrubsBits5 >> 27) & 1;
    SELF.aid_mailclean_postdir_Invalid := (le.ScrubsBits5 >> 28) & 1;
    SELF.aid_mailclean_unit_desig_Invalid := (le.ScrubsBits5 >> 29) & 1;
    SELF.aid_mailclean_sec_range_Invalid := (le.ScrubsBits5 >> 30) & 1;
    SELF.aid_mailclean_p_city_name_Invalid := (le.ScrubsBits5 >> 31) & 1;
    SELF.aid_mailclean_v_city_name_Invalid := (le.ScrubsBits5 >> 32) & 1;
    SELF.aid_mailclean_st_Invalid := (le.ScrubsBits5 >> 33) & 3;
    SELF.aid_mailclean_zip_Invalid := (le.ScrubsBits5 >> 35) & 3;
    SELF.aid_mailclean_zip4_Invalid := (le.ScrubsBits5 >> 37) & 1;
    SELF.aid_mailclean_cart_Invalid := (le.ScrubsBits5 >> 38) & 1;
    SELF.aid_mailclean_cr_sort_sz_Invalid := (le.ScrubsBits5 >> 39) & 1;
    SELF.aid_mailclean_lot_Invalid := (le.ScrubsBits5 >> 40) & 1;
    SELF.aid_mailclean_lot_order_Invalid := (le.ScrubsBits5 >> 41) & 1;
    SELF.aid_mailclean_dpbc_Invalid := (le.ScrubsBits5 >> 42) & 1;
    SELF.aid_mailclean_chk_digit_Invalid := (le.ScrubsBits5 >> 43) & 1;
    SELF.aid_mailclean_record_type_Invalid := (le.ScrubsBits5 >> 44) & 1;
    SELF.aid_mailclean_ace_fips_st_Invalid := (le.ScrubsBits5 >> 45) & 1;
    SELF.aid_mailclean_fipscounty_Invalid := (le.ScrubsBits5 >> 46) & 1;
    SELF.aid_mailclean_geo_lat_Invalid := (le.ScrubsBits5 >> 47) & 1;
    SELF.aid_mailclean_geo_long_Invalid := (le.ScrubsBits5 >> 48) & 1;
    SELF.aid_mailclean_msa_Invalid := (le.ScrubsBits5 >> 49) & 1;
    SELF.aid_mailclean_geo_blk_Invalid := (le.ScrubsBits5 >> 50) & 1;
    SELF.aid_mailclean_geo_match_Invalid := (le.ScrubsBits5 >> 51) & 1;
    SELF.aid_mailclean_err_stat_Invalid := (le.ScrubsBits5 >> 52) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits5 >> 53) & 1;
    SELF.predir_Invalid := (le.ScrubsBits5 >> 54) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits5 >> 55) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits5 >> 56) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits5 >> 57) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits5 >> 58) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits5 >> 59) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits5 >> 60) & 1;
    SELF.city_name_Invalid := (le.ScrubsBits5 >> 61) & 1;
    SELF.st_Invalid := (le.ScrubsBits5 >> 62) & 1;
    SELF.zip_Invalid := (le.ScrubsBits6 >> 0) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits6 >> 2) & 1;
    SELF.cart_Invalid := (le.ScrubsBits6 >> 3) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits6 >> 4) & 1;
    SELF.lot_Invalid := (le.ScrubsBits6 >> 5) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits6 >> 6) & 1;
    SELF.dpbc_Invalid := (le.ScrubsBits6 >> 7) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits6 >> 8) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits6 >> 9) & 1;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits6 >> 10) & 1;
    SELF.county_Invalid := (le.ScrubsBits6 >> 11) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits6 >> 12) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits6 >> 13) & 1;
    SELF.msa_Invalid := (le.ScrubsBits6 >> 14) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits6 >> 15) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits6 >> 16) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits6 >> 17) & 1;
    SELF.mail_prim_range_Invalid := (le.ScrubsBits6 >> 18) & 1;
    SELF.mail_predir_Invalid := (le.ScrubsBits6 >> 19) & 1;
    SELF.mail_prim_name_Invalid := (le.ScrubsBits6 >> 20) & 1;
    SELF.mail_addr_suffix_Invalid := (le.ScrubsBits6 >> 21) & 1;
    SELF.mail_postdir_Invalid := (le.ScrubsBits6 >> 22) & 1;
    SELF.mail_unit_desig_Invalid := (le.ScrubsBits6 >> 23) & 1;
    SELF.mail_sec_range_Invalid := (le.ScrubsBits6 >> 24) & 1;
    SELF.mail_p_city_name_Invalid := (le.ScrubsBits6 >> 25) & 1;
    SELF.mail_v_city_name_Invalid := (le.ScrubsBits6 >> 26) & 1;
    SELF.mail_st_Invalid := (le.ScrubsBits6 >> 27) & 3;
    SELF.mail_ace_zip_Invalid := (le.ScrubsBits6 >> 29) & 3;
    SELF.mail_zip4_Invalid := (le.ScrubsBits6 >> 31) & 1;
    SELF.mail_cart_Invalid := (le.ScrubsBits6 >> 32) & 1;
    SELF.mail_cr_sort_sz_Invalid := (le.ScrubsBits6 >> 33) & 1;
    SELF.mail_lot_Invalid := (le.ScrubsBits6 >> 34) & 1;
    SELF.mail_lot_order_Invalid := (le.ScrubsBits6 >> 35) & 1;
    SELF.mail_dpbc_Invalid := (le.ScrubsBits6 >> 36) & 1;
    SELF.mail_chk_digit_Invalid := (le.ScrubsBits6 >> 37) & 1;
    SELF.mail_record_type_Invalid := (le.ScrubsBits6 >> 38) & 1;
    SELF.mail_ace_fips_st_Invalid := (le.ScrubsBits6 >> 39) & 1;
    SELF.mail_fipscounty_Invalid := (le.ScrubsBits6 >> 40) & 1;
    SELF.mail_geo_lat_Invalid := (le.ScrubsBits6 >> 41) & 1;
    SELF.mail_geo_long_Invalid := (le.ScrubsBits6 >> 42) & 1;
    SELF.mail_msa_Invalid := (le.ScrubsBits6 >> 43) & 1;
    SELF.mail_geo_blk_Invalid := (le.ScrubsBits6 >> 44) & 1;
    SELF.mail_geo_match_Invalid := (le.ScrubsBits6 >> 45) & 1;
    SELF.cass_prim_range_Invalid := (le.ScrubsBits6 >> 46) & 1;
    SELF.cass_predir_Invalid := (le.ScrubsBits6 >> 47) & 1;
    SELF.cass_prim_name_Invalid := (le.ScrubsBits6 >> 48) & 1;
    SELF.cass_addr_suffix_Invalid := (le.ScrubsBits6 >> 49) & 1;
    SELF.cass_postdir_Invalid := (le.ScrubsBits6 >> 50) & 1;
    SELF.cass_unit_desig_Invalid := (le.ScrubsBits6 >> 51) & 1;
    SELF.cass_sec_range_Invalid := (le.ScrubsBits6 >> 52) & 1;
    SELF.cass_p_city_name_Invalid := (le.ScrubsBits6 >> 53) & 1;
    SELF.cass_v_city_name_Invalid := (le.ScrubsBits6 >> 54) & 1;
    SELF.cass_st_Invalid := (le.ScrubsBits6 >> 55) & 3;
    SELF.cass_ace_zip_Invalid := (le.ScrubsBits6 >> 57) & 3;
    SELF.cass_zip4_Invalid := (le.ScrubsBits6 >> 59) & 1;
    SELF.cass_cart_Invalid := (le.ScrubsBits6 >> 60) & 1;
    SELF.cass_cr_sort_sz_Invalid := (le.ScrubsBits6 >> 61) & 1;
    SELF.cass_lot_Invalid := (le.ScrubsBits6 >> 62) & 1;
    SELF.cass_lot_order_Invalid := (le.ScrubsBits6 >> 63) & 1;
    SELF.cass_dpbc_Invalid := (le.ScrubsBits7 >> 0) & 1;
    SELF.cass_chk_digit_Invalid := (le.ScrubsBits7 >> 1) & 1;
    SELF.cass_record_type_Invalid := (le.ScrubsBits7 >> 2) & 1;
    SELF.cass_ace_fips_st_Invalid := (le.ScrubsBits7 >> 3) & 1;
    SELF.cass_fipscounty_Invalid := (le.ScrubsBits7 >> 4) & 1;
    SELF.cass_geo_lat_Invalid := (le.ScrubsBits7 >> 5) & 1;
    SELF.cass_geo_long_Invalid := (le.ScrubsBits7 >> 6) & 1;
    SELF.cass_msa_Invalid := (le.ScrubsBits7 >> 7) & 1;
    SELF.cass_geo_blk_Invalid := (le.ScrubsBits7 >> 8) & 1;
    SELF.cass_geo_match_Invalid := (le.ScrubsBits7 >> 9) & 1;
    SELF.cass_err_stat_Invalid := (le.ScrubsBits7 >> 10) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    append_seqnum_ALLOW_ErrorCount := COUNT(GROUP,h.append_seqnum_Invalid=1);
    persistent_record_id_ALLOW_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    score_ALLOW_ErrorCount := COUNT(GROUP,h.score_Invalid=1);
    best_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=1);
    did_out_ALLOW_ErrorCount := COUNT(GROUP,h.did_out_Invalid=1);
    source_ALLOW_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    file_id_ALLOW_ErrorCount := COUNT(GROUP,h.file_id_Invalid=1);
    source_state_ALLOW_ErrorCount := COUNT(GROUP,h.source_state_Invalid=1);
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
    dob_str_in_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_str_in_Invalid=1);
    agecat_ALLOW_ErrorCount := COUNT(GROUP,h.agecat_Invalid=1);
    headhousehold_ALLOW_ErrorCount := COUNT(GROUP,h.headhousehold_Invalid=1);
    place_of_birth_CUSTOM_ErrorCount := COUNT(GROUP,h.place_of_birth_Invalid=1);
    occupation_ALLOW_ErrorCount := COUNT(GROUP,h.occupation_Invalid=1);
    maiden_name_ALLOW_ErrorCount := COUNT(GROUP,h.maiden_name_Invalid=1);
    motorvoterid_ALLOW_ErrorCount := COUNT(GROUP,h.motorvoterid_Invalid=1);
    regsource_ALLOW_ErrorCount := COUNT(GROUP,h.regsource_Invalid=1);
    regdate_in_CUSTOM_ErrorCount := COUNT(GROUP,h.regdate_in_Invalid=1);
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
    res_zip_ALLOW_ErrorCount := COUNT(GROUP,h.res_zip_Invalid=1);
    res_county_ALLOW_ErrorCount := COUNT(GROUP,h.res_county_Invalid=1);
    mail_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.mail_addr1_Invalid=1);
    mail_addr2_ALLOW_ErrorCount := COUNT(GROUP,h.mail_addr2_Invalid=1);
    mail_city_ALLOW_ErrorCount := COUNT(GROUP,h.mail_city_Invalid=1);
    mail_state_ALLOW_ErrorCount := COUNT(GROUP,h.mail_state_Invalid=1);
    mail_state_LENGTHS_ErrorCount := COUNT(GROUP,h.mail_state_Invalid=2);
    mail_state_Total_ErrorCount := COUNT(GROUP,h.mail_state_Invalid>0);
    mail_zip_ALLOW_ErrorCount := COUNT(GROUP,h.mail_zip_Invalid=1);
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
    dateofcontr_in_CUSTOM_ErrorCount := COUNT(GROUP,h.dateofcontr_in_Invalid=1);
    dollaramt_ALLOW_ErrorCount := COUNT(GROUP,h.dollaramt_Invalid=1);
    officecontto_ALLOW_ErrorCount := COUNT(GROUP,h.officecontto_Invalid=1);
    cumuldollaramt_ALLOW_ErrorCount := COUNT(GROUP,h.cumuldollaramt_Invalid=1);
    conttype_ALLOW_ErrorCount := COUNT(GROUP,h.conttype_Invalid=1);
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
    lastdayvote_in_CUSTOM_ErrorCount := COUNT(GROUP,h.lastdayvote_in_Invalid=1);
    huntfishperm_ALLOW_ErrorCount := COUNT(GROUP,h.huntfishperm_Invalid=1);
    datelicense_in_CUSTOM_ErrorCount := COUNT(GROUP,h.datelicense_in_Invalid=1);
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
    day1_ALLOW_ErrorCount := COUNT(GROUP,h.day1_Invalid=1);
    day3_ALLOW_ErrorCount := COUNT(GROUP,h.day3_Invalid=1);
    day7_ALLOW_ErrorCount := COUNT(GROUP,h.day7_Invalid=1);
    day14to15_ALLOW_ErrorCount := COUNT(GROUP,h.day14to15_Invalid=1);
    seasonannual_ALLOW_ErrorCount := COUNT(GROUP,h.seasonannual_Invalid=1);
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
    boatindexnum_ALLOW_ErrorCount := COUNT(GROUP,h.boatindexnum_Invalid=1);
    boatcoowner_ALLOW_ErrorCount := COUNT(GROUP,h.boatcoowner_Invalid=1);
    hullidnum_ALLOW_ErrorCount := COUNT(GROUP,h.hullidnum_Invalid=1);
    yearmade_ALLOW_ErrorCount := COUNT(GROUP,h.yearmade_Invalid=1);
    model_ALLOW_ErrorCount := COUNT(GROUP,h.model_Invalid=1);
    manufacturer_ALLOW_ErrorCount := COUNT(GROUP,h.manufacturer_Invalid=1);
    lengt_ALLOW_ErrorCount := COUNT(GROUP,h.lengt_Invalid=1);
    hullconstruct_ALLOW_ErrorCount := COUNT(GROUP,h.hullconstruct_Invalid=1);
    primuse_ALLOW_ErrorCount := COUNT(GROUP,h.primuse_Invalid=1);
    fueltype_ALLOW_ErrorCount := COUNT(GROUP,h.fueltype_Invalid=1);
    propulsion_ALLOW_ErrorCount := COUNT(GROUP,h.propulsion_Invalid=1);
    modeltype_ALLOW_ErrorCount := COUNT(GROUP,h.modeltype_Invalid=1);
    regexpdate_in_CUSTOM_ErrorCount := COUNT(GROUP,h.regexpdate_in_Invalid=1);
    titlenum_ALLOW_ErrorCount := COUNT(GROUP,h.titlenum_Invalid=1);
    stprimuse_ALLOW_ErrorCount := COUNT(GROUP,h.stprimuse_Invalid=1);
    titlestatus_ALLOW_ErrorCount := COUNT(GROUP,h.titlestatus_Invalid=1);
    vessel_ALLOW_ErrorCount := COUNT(GROUP,h.vessel_Invalid=1);
    specreg_ALLOW_ErrorCount := COUNT(GROUP,h.specreg_Invalid=1);
    ccwpermnum_ALLOW_ErrorCount := COUNT(GROUP,h.ccwpermnum_Invalid=1);
    ccwweapontype_ALLOW_ErrorCount := COUNT(GROUP,h.ccwweapontype_Invalid=1);
    ccwregdate_in_CUSTOM_ErrorCount := COUNT(GROUP,h.ccwregdate_in_Invalid=1);
    ccwexpdate_in_CUSTOM_ErrorCount := COUNT(GROUP,h.ccwexpdate_in_Invalid=1);
    ccwpermtype_ALLOW_ErrorCount := COUNT(GROUP,h.ccwpermtype_Invalid=1);
    dob_str_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_str_Invalid=1);
    regdate_CUSTOM_ErrorCount := COUNT(GROUP,h.regdate_Invalid=1);
    dateofcontr_CUSTOM_ErrorCount := COUNT(GROUP,h.dateofcontr_Invalid=1);
    lastdayvote_CUSTOM_ErrorCount := COUNT(GROUP,h.lastdayvote_Invalid=1);
    datelicense_CUSTOM_ErrorCount := COUNT(GROUP,h.datelicense_Invalid=1);
    regexpdate_CUSTOM_ErrorCount := COUNT(GROUP,h.regexpdate_Invalid=1);
    ccwregdate_CUSTOM_ErrorCount := COUNT(GROUP,h.ccwregdate_Invalid=1);
    ccwexpdate_CUSTOM_ErrorCount := COUNT(GROUP,h.ccwexpdate_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    score_on_input_ALLOW_ErrorCount := COUNT(GROUP,h.score_on_input_Invalid=1);
    append_prep_resaddress1_ALLOW_ErrorCount := COUNT(GROUP,h.append_prep_resaddress1_Invalid=1);
    append_prep_resaddress2_ALLOW_ErrorCount := COUNT(GROUP,h.append_prep_resaddress2_Invalid=1);
    append_resrawaid_ALLOW_ErrorCount := COUNT(GROUP,h.append_resrawaid_Invalid=1);
    append_prep_mailaddress1_ALLOW_ErrorCount := COUNT(GROUP,h.append_prep_mailaddress1_Invalid=1);
    append_prep_mailaddress2_ALLOW_ErrorCount := COUNT(GROUP,h.append_prep_mailaddress2_Invalid=1);
    append_mailrawaid_ALLOW_ErrorCount := COUNT(GROUP,h.append_mailrawaid_Invalid=1);
    append_prep_cassaddress1_ALLOW_ErrorCount := COUNT(GROUP,h.append_prep_cassaddress1_Invalid=1);
    append_prep_cassaddress2_ALLOW_ErrorCount := COUNT(GROUP,h.append_prep_cassaddress2_Invalid=1);
    append_cassrawaid_ALLOW_ErrorCount := COUNT(GROUP,h.append_cassrawaid_Invalid=1);
    aid_resclean_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_prim_range_Invalid=1);
    aid_resclean_predir_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_predir_Invalid=1);
    aid_resclean_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_prim_name_Invalid=1);
    aid_resclean_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_addr_suffix_Invalid=1);
    aid_resclean_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_postdir_Invalid=1);
    aid_resclean_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_unit_desig_Invalid=1);
    aid_resclean_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_sec_range_Invalid=1);
    aid_resclean_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_p_city_name_Invalid=1);
    aid_resclean_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_v_city_name_Invalid=1);
    aid_resclean_st_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_st_Invalid=1);
    aid_resclean_st_LENGTHS_ErrorCount := COUNT(GROUP,h.aid_resclean_st_Invalid=2);
    aid_resclean_st_Total_ErrorCount := COUNT(GROUP,h.aid_resclean_st_Invalid>0);
    aid_resclean_zip_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_zip_Invalid=1);
    aid_resclean_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.aid_resclean_zip_Invalid=2);
    aid_resclean_zip_Total_ErrorCount := COUNT(GROUP,h.aid_resclean_zip_Invalid>0);
    aid_resclean_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_zip4_Invalid=1);
    aid_resclean_cart_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_cart_Invalid=1);
    aid_resclean_cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_cr_sort_sz_Invalid=1);
    aid_resclean_lot_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_lot_Invalid=1);
    aid_resclean_lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_lot_order_Invalid=1);
    aid_resclean_dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_dpbc_Invalid=1);
    aid_resclean_chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_chk_digit_Invalid=1);
    aid_resclean_record_type_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_record_type_Invalid=1);
    aid_resclean_ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_ace_fips_st_Invalid=1);
    aid_resclean_fipscounty_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_fipscounty_Invalid=1);
    aid_resclean_geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_geo_lat_Invalid=1);
    aid_resclean_geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_geo_long_Invalid=1);
    aid_resclean_msa_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_msa_Invalid=1);
    aid_resclean_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_geo_blk_Invalid=1);
    aid_resclean_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_geo_match_Invalid=1);
    aid_resclean_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.aid_resclean_err_stat_Invalid=1);
    aid_mailclean_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_prim_range_Invalid=1);
    aid_mailclean_predir_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_predir_Invalid=1);
    aid_mailclean_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_prim_name_Invalid=1);
    aid_mailclean_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_addr_suffix_Invalid=1);
    aid_mailclean_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_postdir_Invalid=1);
    aid_mailclean_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_unit_desig_Invalid=1);
    aid_mailclean_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_sec_range_Invalid=1);
    aid_mailclean_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_p_city_name_Invalid=1);
    aid_mailclean_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_v_city_name_Invalid=1);
    aid_mailclean_st_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_st_Invalid=1);
    aid_mailclean_st_LENGTHS_ErrorCount := COUNT(GROUP,h.aid_mailclean_st_Invalid=2);
    aid_mailclean_st_Total_ErrorCount := COUNT(GROUP,h.aid_mailclean_st_Invalid>0);
    aid_mailclean_zip_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_zip_Invalid=1);
    aid_mailclean_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.aid_mailclean_zip_Invalid=2);
    aid_mailclean_zip_Total_ErrorCount := COUNT(GROUP,h.aid_mailclean_zip_Invalid>0);
    aid_mailclean_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_zip4_Invalid=1);
    aid_mailclean_cart_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_cart_Invalid=1);
    aid_mailclean_cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_cr_sort_sz_Invalid=1);
    aid_mailclean_lot_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_lot_Invalid=1);
    aid_mailclean_lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_lot_order_Invalid=1);
    aid_mailclean_dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_dpbc_Invalid=1);
    aid_mailclean_chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_chk_digit_Invalid=1);
    aid_mailclean_record_type_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_record_type_Invalid=1);
    aid_mailclean_ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_ace_fips_st_Invalid=1);
    aid_mailclean_fipscounty_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_fipscounty_Invalid=1);
    aid_mailclean_geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_geo_lat_Invalid=1);
    aid_mailclean_geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_geo_long_Invalid=1);
    aid_mailclean_msa_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_msa_Invalid=1);
    aid_mailclean_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_geo_blk_Invalid=1);
    aid_mailclean_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_geo_match_Invalid=1);
    aid_mailclean_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.aid_mailclean_err_stat_Invalid=1);
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
    mail_st_LENGTHS_ErrorCount := COUNT(GROUP,h.mail_st_Invalid=2);
    mail_st_Total_ErrorCount := COUNT(GROUP,h.mail_st_Invalid>0);
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
    cass_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.cass_prim_range_Invalid=1);
    cass_predir_ALLOW_ErrorCount := COUNT(GROUP,h.cass_predir_Invalid=1);
    cass_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.cass_prim_name_Invalid=1);
    cass_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.cass_addr_suffix_Invalid=1);
    cass_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.cass_postdir_Invalid=1);
    cass_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.cass_unit_desig_Invalid=1);
    cass_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.cass_sec_range_Invalid=1);
    cass_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.cass_p_city_name_Invalid=1);
    cass_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.cass_v_city_name_Invalid=1);
    cass_st_ALLOW_ErrorCount := COUNT(GROUP,h.cass_st_Invalid=1);
    cass_st_LENGTHS_ErrorCount := COUNT(GROUP,h.cass_st_Invalid=2);
    cass_st_Total_ErrorCount := COUNT(GROUP,h.cass_st_Invalid>0);
    cass_ace_zip_ALLOW_ErrorCount := COUNT(GROUP,h.cass_ace_zip_Invalid=1);
    cass_ace_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.cass_ace_zip_Invalid=2);
    cass_ace_zip_Total_ErrorCount := COUNT(GROUP,h.cass_ace_zip_Invalid>0);
    cass_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.cass_zip4_Invalid=1);
    cass_cart_ALLOW_ErrorCount := COUNT(GROUP,h.cass_cart_Invalid=1);
    cass_cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cass_cr_sort_sz_Invalid=1);
    cass_lot_ALLOW_ErrorCount := COUNT(GROUP,h.cass_lot_Invalid=1);
    cass_lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.cass_lot_order_Invalid=1);
    cass_dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.cass_dpbc_Invalid=1);
    cass_chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.cass_chk_digit_Invalid=1);
    cass_record_type_ALLOW_ErrorCount := COUNT(GROUP,h.cass_record_type_Invalid=1);
    cass_ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.cass_ace_fips_st_Invalid=1);
    cass_fipscounty_ALLOW_ErrorCount := COUNT(GROUP,h.cass_fipscounty_Invalid=1);
    cass_geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.cass_geo_lat_Invalid=1);
    cass_geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.cass_geo_long_Invalid=1);
    cass_msa_ALLOW_ErrorCount := COUNT(GROUP,h.cass_msa_Invalid=1);
    cass_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.cass_geo_blk_Invalid=1);
    cass_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.cass_geo_match_Invalid=1);
    cass_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.cass_err_stat_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.append_seqnum_Invalid > 0 OR h.persistent_record_id_Invalid > 0 OR h.process_date_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.score_Invalid > 0 OR h.best_ssn_Invalid > 0 OR h.did_out_Invalid > 0 OR h.source_Invalid > 0 OR h.file_id_Invalid > 0 OR h.source_state_Invalid > 0 OR h.source_code_Invalid > 0 OR h.file_acquired_date_Invalid > 0 OR h._use_Invalid > 0 OR h.title_in_Invalid > 0 OR h.lname_in_Invalid > 0 OR h.fname_in_Invalid > 0 OR h.mname_in_Invalid > 0 OR h.maiden_prior_Invalid > 0 OR h.name_suffix_in_Invalid > 0 OR h.source_voterid_Invalid > 0 OR h.dob_str_in_Invalid > 0 OR h.agecat_Invalid > 0 OR h.headhousehold_Invalid > 0 OR h.place_of_birth_Invalid > 0 OR h.occupation_Invalid > 0 OR h.maiden_name_Invalid > 0 OR h.motorvoterid_Invalid > 0 OR h.regsource_Invalid > 0 OR h.regdate_in_Invalid > 0 OR h.race_Invalid > 0 OR h.gender_Invalid > 0 OR h.poliparty_Invalid > 0 OR h.phone_Invalid > 0 OR h.work_phone_Invalid > 0 OR h.other_phone_Invalid > 0 OR h.active_status_Invalid > 0 OR h.active_other_Invalid > 0 OR h.voterstatus_Invalid > 0 OR h.resaddr1_Invalid > 0 OR h.resaddr2_Invalid > 0 OR h.res_city_Invalid > 0 OR h.res_state_Invalid > 0 OR h.res_zip_Invalid > 0 OR h.res_county_Invalid > 0 OR h.mail_addr1_Invalid > 0 OR h.mail_addr2_Invalid > 0 OR h.mail_city_Invalid > 0 OR h.mail_state_Invalid > 0 OR h.mail_zip_Invalid > 0 OR h.mail_county_Invalid > 0 OR h.towncode_Invalid > 0 OR h.distcode_Invalid > 0 OR h.countycode_Invalid > 0 OR h.schoolcode_Invalid > 0 OR h.cityinout_Invalid > 0 OR h.spec_dist1_Invalid > 0 OR h.spec_dist2_Invalid > 0 OR h.precinct1_Invalid > 0 OR h.precinct2_Invalid > 0 OR h.precinct3_Invalid > 0 OR h.villageprecinct_Invalid > 0 OR h.schoolprecinct_Invalid > 0 OR h.ward_Invalid > 0 OR h.precinct_citytown_Invalid > 0 OR h.ancsmdindc_Invalid > 0 OR h.citycouncildist_Invalid > 0 OR h.countycommdist_Invalid > 0 OR h.statehouse_Invalid > 0 OR h.statesenate_Invalid > 0 OR h.ushouse_Invalid > 0 OR h.elemschooldist_Invalid > 0 OR h.schooldist_Invalid > 0 OR h.commcolldist_Invalid > 0 OR h.municipal_Invalid > 0 OR h.villagedist_Invalid > 0 OR h.policejury_Invalid > 0 OR h.policedist_Invalid > 0 OR h.publicservcomm_Invalid > 0 OR h.rescue_Invalid > 0 OR h.fire_Invalid > 0 OR h.sanitary_Invalid > 0 OR h.sewerdist_Invalid > 0 OR h.waterdist_Invalid > 0 OR h.mosquitodist_Invalid > 0 OR h.taxdist_Invalid > 0 OR h.supremecourt_Invalid > 0 OR h.justiceofpeace_Invalid > 0 OR h.judicialdist_Invalid > 0 OR h.superiorctdist_Invalid > 0 OR h.appealsct_Invalid > 0 OR h.contributorparty_Invalid > 0 OR h.recptparty_Invalid > 0 OR h.dateofcontr_in_Invalid > 0 OR h.dollaramt_Invalid > 0 OR h.officecontto_Invalid > 0 OR h.cumuldollaramt_Invalid > 0 OR h.conttype_Invalid > 0 OR h.primary02_Invalid > 0 OR h.special02_Invalid > 0 OR h.other02_Invalid > 0 OR h.special202_Invalid > 0 OR h.general02_Invalid > 0 OR h.primary01_Invalid > 0 OR h.special01_Invalid > 0 OR h.other01_Invalid > 0 OR h.special201_Invalid > 0 OR h.general01_Invalid > 0 OR h.pres00_Invalid > 0 OR h.primary00_Invalid > 0 OR h.special00_Invalid > 0 OR h.other00_Invalid > 0 OR h.special200_Invalid > 0 OR h.general00_Invalid > 0 OR h.primary99_Invalid > 0 OR h.special99_Invalid > 0 OR h.other99_Invalid > 0 OR h.special299_Invalid > 0 OR h.general99_Invalid > 0 OR h.primary98_Invalid > 0 OR h.special98_Invalid > 0 OR h.other98_Invalid > 0 OR h.special298_Invalid > 0 OR h.general98_Invalid > 0 OR h.primary97_Invalid > 0 OR h.special97_Invalid > 0 OR h.other97_Invalid > 0 OR h.special297_Invalid > 0 OR h.general97_Invalid > 0 OR h.pres96_Invalid > 0 OR h.primary96_Invalid > 0 OR h.special96_Invalid > 0 OR h.other96_Invalid > 0 OR h.special296_Invalid > 0 OR h.general96_Invalid > 0 OR h.lastdayvote_in_Invalid > 0 OR h.huntfishperm_Invalid > 0 OR h.datelicense_in_Invalid > 0 OR h.homestate_Invalid > 0 OR h.resident_Invalid > 0 OR h.nonresident_Invalid > 0 OR h.hunt_Invalid > 0 OR h.fish_Invalid > 0 OR h.combosuper_Invalid > 0 OR h.sportsman_Invalid > 0 OR h.trap_Invalid > 0 OR h.archery_Invalid > 0 OR h.muzzle_Invalid > 0 OR h.drawing_Invalid > 0 OR h.day1_Invalid > 0 OR h.day3_Invalid > 0 OR h.day7_Invalid > 0 OR h.day14to15_Invalid > 0 OR h.seasonannual_Invalid > 0 OR h.lifetimepermit_Invalid > 0 OR h.landowner_Invalid > 0 OR h.family_Invalid > 0 OR h.junior_Invalid > 0 OR h.seniorcit_Invalid > 0 OR h.crewmemeber_Invalid > 0 OR h.retarded_Invalid > 0 OR h.indian_Invalid > 0 OR h.serviceman_Invalid > 0 OR h.disabled_Invalid > 0 OR h.lowincome_Invalid > 0 OR h.regioncounty_Invalid > 0 OR h.blind_Invalid > 0 OR h.salmon_Invalid > 0 OR h.freshwater_Invalid > 0 OR h.saltwater_Invalid > 0 OR h.lakesandresevoirs_Invalid > 0 OR h.setlinefish_Invalid > 0 OR h.trout_Invalid > 0 OR h.fallfishing_Invalid > 0 OR h.steelhead_Invalid > 0 OR h.whitejubherring_Invalid > 0 OR h.sturgeon_Invalid > 0 OR h.shellfishcrab_Invalid > 0 OR h.shellfishlobster_Invalid > 0 OR h.deer_Invalid > 0 OR h.bear_Invalid > 0 OR h.elk_Invalid > 0 OR h.moose_Invalid > 0 OR h.buffalo_Invalid > 0 OR h.antelope_Invalid > 0 OR h.sikebull_Invalid > 0 OR h.bighorn_Invalid > 0 OR h.javelina_Invalid > 0 OR h.cougar_Invalid > 0 OR h.anterless_Invalid > 0 OR h.pheasant_Invalid > 0 OR h.goose_Invalid > 0 OR h.duck_Invalid > 0 OR h.turkey_Invalid > 0 OR h.snowmobile_Invalid > 0 OR h.biggame_Invalid > 0 OR h.skipass_Invalid > 0 OR h.migbird_Invalid > 0 OR h.smallgame_Invalid > 0 OR h.sturgeon2_Invalid > 0 OR h.gun_Invalid > 0 OR h.bonus_Invalid > 0 OR h.lottery_Invalid > 0 OR h.otherbirds_Invalid > 0 OR h.boatindexnum_Invalid > 0 OR h.boatcoowner_Invalid > 0 OR h.hullidnum_Invalid > 0 OR h.yearmade_Invalid > 0 OR h.model_Invalid > 0 OR h.manufacturer_Invalid > 0 OR h.lengt_Invalid > 0 OR h.hullconstruct_Invalid > 0 OR h.primuse_Invalid > 0 OR h.fueltype_Invalid > 0 OR h.propulsion_Invalid > 0 OR h.modeltype_Invalid > 0 OR h.regexpdate_in_Invalid > 0 OR h.titlenum_Invalid > 0 OR h.stprimuse_Invalid > 0 OR h.titlestatus_Invalid > 0 OR h.vessel_Invalid > 0 OR h.specreg_Invalid > 0 OR h.ccwpermnum_Invalid > 0 OR h.ccwweapontype_Invalid > 0 OR h.ccwregdate_in_Invalid > 0 OR h.ccwexpdate_in_Invalid > 0 OR h.ccwpermtype_Invalid > 0 OR h.dob_str_Invalid > 0 OR h.regdate_Invalid > 0 OR h.dateofcontr_Invalid > 0 OR h.lastdayvote_Invalid > 0 OR h.datelicense_Invalid > 0 OR h.regexpdate_Invalid > 0 OR h.ccwregdate_Invalid > 0 OR h.ccwexpdate_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.score_on_input_Invalid > 0 OR h.append_prep_resaddress1_Invalid > 0 OR h.append_prep_resaddress2_Invalid > 0 OR h.append_resrawaid_Invalid > 0 OR h.append_prep_mailaddress1_Invalid > 0 OR h.append_prep_mailaddress2_Invalid > 0 OR h.append_mailrawaid_Invalid > 0 OR h.append_prep_cassaddress1_Invalid > 0 OR h.append_prep_cassaddress2_Invalid > 0 OR h.append_cassrawaid_Invalid > 0 OR h.aid_resclean_prim_range_Invalid > 0 OR h.aid_resclean_predir_Invalid > 0 OR h.aid_resclean_prim_name_Invalid > 0 OR h.aid_resclean_addr_suffix_Invalid > 0 OR h.aid_resclean_postdir_Invalid > 0 OR h.aid_resclean_unit_desig_Invalid > 0 OR h.aid_resclean_sec_range_Invalid > 0 OR h.aid_resclean_p_city_name_Invalid > 0 OR h.aid_resclean_v_city_name_Invalid > 0 OR h.aid_resclean_st_Invalid > 0 OR h.aid_resclean_zip_Invalid > 0 OR h.aid_resclean_zip4_Invalid > 0 OR h.aid_resclean_cart_Invalid > 0 OR h.aid_resclean_cr_sort_sz_Invalid > 0 OR h.aid_resclean_lot_Invalid > 0 OR h.aid_resclean_lot_order_Invalid > 0 OR h.aid_resclean_dpbc_Invalid > 0 OR h.aid_resclean_chk_digit_Invalid > 0 OR h.aid_resclean_record_type_Invalid > 0 OR h.aid_resclean_ace_fips_st_Invalid > 0 OR h.aid_resclean_fipscounty_Invalid > 0 OR h.aid_resclean_geo_lat_Invalid > 0 OR h.aid_resclean_geo_long_Invalid > 0 OR h.aid_resclean_msa_Invalid > 0 OR h.aid_resclean_geo_blk_Invalid > 0 OR h.aid_resclean_geo_match_Invalid > 0 OR h.aid_resclean_err_stat_Invalid > 0 OR h.aid_mailclean_prim_range_Invalid > 0 OR h.aid_mailclean_predir_Invalid > 0 OR h.aid_mailclean_prim_name_Invalid > 0 OR h.aid_mailclean_addr_suffix_Invalid > 0 OR h.aid_mailclean_postdir_Invalid > 0 OR h.aid_mailclean_unit_desig_Invalid > 0 OR h.aid_mailclean_sec_range_Invalid > 0 OR h.aid_mailclean_p_city_name_Invalid > 0 OR h.aid_mailclean_v_city_name_Invalid > 0 OR h.aid_mailclean_st_Invalid > 0 OR h.aid_mailclean_zip_Invalid > 0 OR h.aid_mailclean_zip4_Invalid > 0 OR h.aid_mailclean_cart_Invalid > 0 OR h.aid_mailclean_cr_sort_sz_Invalid > 0 OR h.aid_mailclean_lot_Invalid > 0 OR h.aid_mailclean_lot_order_Invalid > 0 OR h.aid_mailclean_dpbc_Invalid > 0 OR h.aid_mailclean_chk_digit_Invalid > 0 OR h.aid_mailclean_record_type_Invalid > 0 OR h.aid_mailclean_ace_fips_st_Invalid > 0 OR h.aid_mailclean_fipscounty_Invalid > 0 OR h.aid_mailclean_geo_lat_Invalid > 0 OR h.aid_mailclean_geo_long_Invalid > 0 OR h.aid_mailclean_msa_Invalid > 0 OR h.aid_mailclean_geo_blk_Invalid > 0 OR h.aid_mailclean_geo_match_Invalid > 0 OR h.aid_mailclean_err_stat_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dpbc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.record_type_Invalid > 0 OR h.ace_fips_st_Invalid > 0 OR h.county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.mail_prim_range_Invalid > 0 OR h.mail_predir_Invalid > 0 OR h.mail_prim_name_Invalid > 0 OR h.mail_addr_suffix_Invalid > 0 OR h.mail_postdir_Invalid > 0 OR h.mail_unit_desig_Invalid > 0 OR h.mail_sec_range_Invalid > 0 OR h.mail_p_city_name_Invalid > 0 OR h.mail_v_city_name_Invalid > 0 OR h.mail_st_Invalid > 0 OR h.mail_ace_zip_Invalid > 0 OR h.mail_zip4_Invalid > 0 OR h.mail_cart_Invalid > 0 OR h.mail_cr_sort_sz_Invalid > 0 OR h.mail_lot_Invalid > 0 OR h.mail_lot_order_Invalid > 0 OR h.mail_dpbc_Invalid > 0 OR h.mail_chk_digit_Invalid > 0 OR h.mail_record_type_Invalid > 0 OR h.mail_ace_fips_st_Invalid > 0 OR h.mail_fipscounty_Invalid > 0 OR h.mail_geo_lat_Invalid > 0 OR h.mail_geo_long_Invalid > 0 OR h.mail_msa_Invalid > 0 OR h.mail_geo_blk_Invalid > 0 OR h.mail_geo_match_Invalid > 0 OR h.cass_prim_range_Invalid > 0 OR h.cass_predir_Invalid > 0 OR h.cass_prim_name_Invalid > 0 OR h.cass_addr_suffix_Invalid > 0 OR h.cass_postdir_Invalid > 0 OR h.cass_unit_desig_Invalid > 0 OR h.cass_sec_range_Invalid > 0 OR h.cass_p_city_name_Invalid > 0 OR h.cass_v_city_name_Invalid > 0 OR h.cass_st_Invalid > 0 OR h.cass_ace_zip_Invalid > 0 OR h.cass_zip4_Invalid > 0 OR h.cass_cart_Invalid > 0 OR h.cass_cr_sort_sz_Invalid > 0 OR h.cass_lot_Invalid > 0 OR h.cass_lot_order_Invalid > 0 OR h.cass_dpbc_Invalid > 0 OR h.cass_chk_digit_Invalid > 0 OR h.cass_record_type_Invalid > 0 OR h.cass_ace_fips_st_Invalid > 0 OR h.cass_fipscounty_Invalid > 0 OR h.cass_geo_lat_Invalid > 0 OR h.cass_geo_long_Invalid > 0 OR h.cass_msa_Invalid > 0 OR h.cass_geo_blk_Invalid > 0 OR h.cass_geo_match_Invalid > 0 OR h.cass_err_stat_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.append_seqnum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.persistent_record_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_acquired_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le._use_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_prior_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_voterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_str_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.agecat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.headhousehold_ALLOW_ErrorCount > 0, 1, 0) + IF(le.place_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.occupation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.motorvoterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regsource_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regdate_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.race_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.poliparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.work_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voterstatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_state_Total_ErrorCount > 0, 1, 0) + IF(le.mail_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.towncode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.distcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countycode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schoolcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cityinout_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spec_dist1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spec_dist2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.villageprecinct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schoolprecinct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ward_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct_citytown_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ancsmdindc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.citycouncildist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countycommdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statehouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statesenate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ushouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.elemschooldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schooldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.commcolldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.municipal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.villagedist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policejury_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policedist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicservcomm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rescue_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fire_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sanitary_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sewerdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.waterdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mosquitodist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.taxdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.supremecourt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.justiceofpeace_ALLOW_ErrorCount > 0, 1, 0) + IF(le.judicialdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.superiorctdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.appealsct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contributorparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recptparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateofcontr_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dollaramt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officecontto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cumuldollaramt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.conttype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special202_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special201_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pres00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special200_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special299_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special298_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special297_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pres96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special296_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdayvote_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.huntfishperm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.datelicense_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homestate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resident_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nonresident_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hunt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.combosuper_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sportsman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.archery_ALLOW_ErrorCount > 0, 1, 0) + IF(le.muzzle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.drawing_ALLOW_ErrorCount > 0, 1, 0) + IF(le.day1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.day3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.day7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.day14to15_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seasonannual_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lifetimepermit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.landowner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.junior_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seniorcit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.crewmemeber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.retarded_ALLOW_ErrorCount > 0, 1, 0) + IF(le.indian_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serviceman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.disabled_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lowincome_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regioncounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.blind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.salmon_ALLOW_ErrorCount > 0, 1, 0) + IF(le.freshwater_ALLOW_ErrorCount > 0, 1, 0) + IF(le.saltwater_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lakesandresevoirs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.setlinefish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trout_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fallfishing_ALLOW_ErrorCount > 0, 1, 0) + IF(le.steelhead_ALLOW_ErrorCount > 0, 1, 0) + IF(le.whitejubherring_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sturgeon_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shellfishcrab_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shellfishlobster_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deer_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bear_ALLOW_ErrorCount > 0, 1, 0) + IF(le.elk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.moose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buffalo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.antelope_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sikebull_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bighorn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.javelina_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cougar_ALLOW_ErrorCount > 0, 1, 0) + IF(le.anterless_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pheasant_ALLOW_ErrorCount > 0, 1, 0) + IF(le.goose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.duck_ALLOW_ErrorCount > 0, 1, 0) + IF(le.turkey_ALLOW_ErrorCount > 0, 1, 0) + IF(le.snowmobile_ALLOW_ErrorCount > 0, 1, 0) + IF(le.biggame_ALLOW_ErrorCount > 0, 1, 0) + IF(le.skipass_ALLOW_ErrorCount > 0, 1, 0) + IF(le.migbird_ALLOW_ErrorCount > 0, 1, 0) + IF(le.smallgame_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sturgeon2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gun_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bonus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lottery_ALLOW_ErrorCount > 0, 1, 0) + IF(le.otherbirds_ALLOW_ErrorCount > 0, 1, 0) + IF(le.boatindexnum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.boatcoowner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hullidnum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.yearmade_ALLOW_ErrorCount > 0, 1, 0) + IF(le.model_ALLOW_ErrorCount > 0, 1, 0) + IF(le.manufacturer_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lengt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hullconstruct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primuse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fueltype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propulsion_ALLOW_ErrorCount > 0, 1, 0) + IF(le.modeltype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regexpdate_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.titlenum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.stprimuse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.titlestatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vessel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.specreg_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ccwpermnum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ccwweapontype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ccwregdate_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccwexpdate_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccwpermtype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_str_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.regdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateofcontr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lastdayvote_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.datelicense_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.regexpdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccwregdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccwexpdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.score_on_input_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_resaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_resaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_resrawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_mailaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_mailaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_mailrawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_cassaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_cassaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_cassrawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_st_Total_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_zip_Total_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_st_Total_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_zip_Total_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_st_Total_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_Total_ErrorCount > 0, 1, 0) + IF(le.mail_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_st_Total_ErrorCount > 0, 1, 0) + IF(le.cass_ace_zip_Total_ErrorCount > 0, 1, 0) + IF(le.cass_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_err_stat_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.append_seqnum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.persistent_record_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_acquired_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le._use_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_prior_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_in_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_voterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_str_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.agecat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.headhousehold_ALLOW_ErrorCount > 0, 1, 0) + IF(le.place_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.occupation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.maiden_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.motorvoterid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regsource_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regdate_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.race_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.poliparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.work_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.active_other_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voterstatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.res_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mail_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.towncode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.distcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countycode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schoolcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cityinout_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spec_dist1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spec_dist2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.villageprecinct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schoolprecinct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ward_ALLOW_ErrorCount > 0, 1, 0) + IF(le.precinct_citytown_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ancsmdindc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.citycouncildist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countycommdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statehouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statesenate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ushouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.elemschooldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.schooldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.commcolldist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.municipal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.villagedist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policejury_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policedist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.publicservcomm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rescue_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fire_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sanitary_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sewerdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.waterdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mosquitodist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.taxdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.supremecourt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.justiceofpeace_ALLOW_ErrorCount > 0, 1, 0) + IF(le.judicialdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.superiorctdist_ALLOW_ErrorCount > 0, 1, 0) + IF(le.appealsct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contributorparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recptparty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateofcontr_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dollaramt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officecontto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cumuldollaramt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.conttype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special202_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general02_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special201_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general01_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pres00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special200_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general00_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special299_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general99_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special298_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general98_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special297_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general97_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pres96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primary96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.special296_ALLOW_ErrorCount > 0, 1, 0) + IF(le.general96_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdayvote_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.huntfishperm_ALLOW_ErrorCount > 0, 1, 0) + IF(le.datelicense_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.homestate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resident_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nonresident_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hunt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.combosuper_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sportsman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.archery_ALLOW_ErrorCount > 0, 1, 0) + IF(le.muzzle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.drawing_ALLOW_ErrorCount > 0, 1, 0) + IF(le.day1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.day3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.day7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.day14to15_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seasonannual_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lifetimepermit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.landowner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.family_ALLOW_ErrorCount > 0, 1, 0) + IF(le.junior_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seniorcit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.crewmemeber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.retarded_ALLOW_ErrorCount > 0, 1, 0) + IF(le.indian_ALLOW_ErrorCount > 0, 1, 0) + IF(le.serviceman_ALLOW_ErrorCount > 0, 1, 0) + IF(le.disabled_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lowincome_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regioncounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.blind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.salmon_ALLOW_ErrorCount > 0, 1, 0) + IF(le.freshwater_ALLOW_ErrorCount > 0, 1, 0) + IF(le.saltwater_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lakesandresevoirs_ALLOW_ErrorCount > 0, 1, 0) + IF(le.setlinefish_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trout_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fallfishing_ALLOW_ErrorCount > 0, 1, 0) + IF(le.steelhead_ALLOW_ErrorCount > 0, 1, 0) + IF(le.whitejubherring_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sturgeon_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shellfishcrab_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shellfishlobster_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deer_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bear_ALLOW_ErrorCount > 0, 1, 0) + IF(le.elk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.moose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buffalo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.antelope_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sikebull_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bighorn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.javelina_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cougar_ALLOW_ErrorCount > 0, 1, 0) + IF(le.anterless_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pheasant_ALLOW_ErrorCount > 0, 1, 0) + IF(le.goose_ALLOW_ErrorCount > 0, 1, 0) + IF(le.duck_ALLOW_ErrorCount > 0, 1, 0) + IF(le.turkey_ALLOW_ErrorCount > 0, 1, 0) + IF(le.snowmobile_ALLOW_ErrorCount > 0, 1, 0) + IF(le.biggame_ALLOW_ErrorCount > 0, 1, 0) + IF(le.skipass_ALLOW_ErrorCount > 0, 1, 0) + IF(le.migbird_ALLOW_ErrorCount > 0, 1, 0) + IF(le.smallgame_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sturgeon2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gun_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bonus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lottery_ALLOW_ErrorCount > 0, 1, 0) + IF(le.otherbirds_ALLOW_ErrorCount > 0, 1, 0) + IF(le.boatindexnum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.boatcoowner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hullidnum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.yearmade_ALLOW_ErrorCount > 0, 1, 0) + IF(le.model_ALLOW_ErrorCount > 0, 1, 0) + IF(le.manufacturer_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lengt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hullconstruct_ALLOW_ErrorCount > 0, 1, 0) + IF(le.primuse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fueltype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.propulsion_ALLOW_ErrorCount > 0, 1, 0) + IF(le.modeltype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.regexpdate_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.titlenum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.stprimuse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.titlestatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vessel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.specreg_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ccwpermnum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ccwweapontype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ccwregdate_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccwexpdate_in_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccwpermtype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_str_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.regdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateofcontr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lastdayvote_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.datelicense_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.regexpdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccwregdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccwexpdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.score_on_input_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_resaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_resaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_resrawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_mailaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_mailaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_mailrawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_cassaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prep_cassaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_cassrawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_resclean_err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aid_mailclean_err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mail_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mail_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cass_ace_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_ace_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cass_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_fipscounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cass_err_stat_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.append_seqnum_Invalid,le.persistent_record_id_Invalid,le.process_date_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.score_Invalid,le.best_ssn_Invalid,le.did_out_Invalid,le.source_Invalid,le.file_id_Invalid,le.source_state_Invalid,le.source_code_Invalid,le.file_acquired_date_Invalid,le._use_Invalid,le.title_in_Invalid,le.lname_in_Invalid,le.fname_in_Invalid,le.mname_in_Invalid,le.maiden_prior_Invalid,le.name_suffix_in_Invalid,le.source_voterid_Invalid,le.dob_str_in_Invalid,le.agecat_Invalid,le.headhousehold_Invalid,le.place_of_birth_Invalid,le.occupation_Invalid,le.maiden_name_Invalid,le.motorvoterid_Invalid,le.regsource_Invalid,le.regdate_in_Invalid,le.race_Invalid,le.gender_Invalid,le.poliparty_Invalid,le.phone_Invalid,le.work_phone_Invalid,le.other_phone_Invalid,le.active_status_Invalid,le.active_other_Invalid,le.voterstatus_Invalid,le.resaddr1_Invalid,le.resaddr2_Invalid,le.res_city_Invalid,le.res_state_Invalid,le.res_zip_Invalid,le.res_county_Invalid,le.mail_addr1_Invalid,le.mail_addr2_Invalid,le.mail_city_Invalid,le.mail_state_Invalid,le.mail_zip_Invalid,le.mail_county_Invalid,le.towncode_Invalid,le.distcode_Invalid,le.countycode_Invalid,le.schoolcode_Invalid,le.cityinout_Invalid,le.spec_dist1_Invalid,le.spec_dist2_Invalid,le.precinct1_Invalid,le.precinct2_Invalid,le.precinct3_Invalid,le.villageprecinct_Invalid,le.schoolprecinct_Invalid,le.ward_Invalid,le.precinct_citytown_Invalid,le.ancsmdindc_Invalid,le.citycouncildist_Invalid,le.countycommdist_Invalid,le.statehouse_Invalid,le.statesenate_Invalid,le.ushouse_Invalid,le.elemschooldist_Invalid,le.schooldist_Invalid,le.commcolldist_Invalid,le.municipal_Invalid,le.villagedist_Invalid,le.policejury_Invalid,le.policedist_Invalid,le.publicservcomm_Invalid,le.rescue_Invalid,le.fire_Invalid,le.sanitary_Invalid,le.sewerdist_Invalid,le.waterdist_Invalid,le.mosquitodist_Invalid,le.taxdist_Invalid,le.supremecourt_Invalid,le.justiceofpeace_Invalid,le.judicialdist_Invalid,le.superiorctdist_Invalid,le.appealsct_Invalid,le.contributorparty_Invalid,le.recptparty_Invalid,le.dateofcontr_in_Invalid,le.dollaramt_Invalid,le.officecontto_Invalid,le.cumuldollaramt_Invalid,le.conttype_Invalid,le.primary02_Invalid,le.special02_Invalid,le.other02_Invalid,le.special202_Invalid,le.general02_Invalid,le.primary01_Invalid,le.special01_Invalid,le.other01_Invalid,le.special201_Invalid,le.general01_Invalid,le.pres00_Invalid,le.primary00_Invalid,le.special00_Invalid,le.other00_Invalid,le.special200_Invalid,le.general00_Invalid,le.primary99_Invalid,le.special99_Invalid,le.other99_Invalid,le.special299_Invalid,le.general99_Invalid,le.primary98_Invalid,le.special98_Invalid,le.other98_Invalid,le.special298_Invalid,le.general98_Invalid,le.primary97_Invalid,le.special97_Invalid,le.other97_Invalid,le.special297_Invalid,le.general97_Invalid,le.pres96_Invalid,le.primary96_Invalid,le.special96_Invalid,le.other96_Invalid,le.special296_Invalid,le.general96_Invalid,le.lastdayvote_in_Invalid,le.huntfishperm_Invalid,le.datelicense_in_Invalid,le.homestate_Invalid,le.resident_Invalid,le.nonresident_Invalid,le.hunt_Invalid,le.fish_Invalid,le.combosuper_Invalid,le.sportsman_Invalid,le.trap_Invalid,le.archery_Invalid,le.muzzle_Invalid,le.drawing_Invalid,le.day1_Invalid,le.day3_Invalid,le.day7_Invalid,le.day14to15_Invalid,le.seasonannual_Invalid,le.lifetimepermit_Invalid,le.landowner_Invalid,le.family_Invalid,le.junior_Invalid,le.seniorcit_Invalid,le.crewmemeber_Invalid,le.retarded_Invalid,le.indian_Invalid,le.serviceman_Invalid,le.disabled_Invalid,le.lowincome_Invalid,le.regioncounty_Invalid,le.blind_Invalid,le.salmon_Invalid,le.freshwater_Invalid,le.saltwater_Invalid,le.lakesandresevoirs_Invalid,le.setlinefish_Invalid,le.trout_Invalid,le.fallfishing_Invalid,le.steelhead_Invalid,le.whitejubherring_Invalid,le.sturgeon_Invalid,le.shellfishcrab_Invalid,le.shellfishlobster_Invalid,le.deer_Invalid,le.bear_Invalid,le.elk_Invalid,le.moose_Invalid,le.buffalo_Invalid,le.antelope_Invalid,le.sikebull_Invalid,le.bighorn_Invalid,le.javelina_Invalid,le.cougar_Invalid,le.anterless_Invalid,le.pheasant_Invalid,le.goose_Invalid,le.duck_Invalid,le.turkey_Invalid,le.snowmobile_Invalid,le.biggame_Invalid,le.skipass_Invalid,le.migbird_Invalid,le.smallgame_Invalid,le.sturgeon2_Invalid,le.gun_Invalid,le.bonus_Invalid,le.lottery_Invalid,le.otherbirds_Invalid,le.boatindexnum_Invalid,le.boatcoowner_Invalid,le.hullidnum_Invalid,le.yearmade_Invalid,le.model_Invalid,le.manufacturer_Invalid,le.lengt_Invalid,le.hullconstruct_Invalid,le.primuse_Invalid,le.fueltype_Invalid,le.propulsion_Invalid,le.modeltype_Invalid,le.regexpdate_in_Invalid,le.titlenum_Invalid,le.stprimuse_Invalid,le.titlestatus_Invalid,le.vessel_Invalid,le.specreg_Invalid,le.ccwpermnum_Invalid,le.ccwweapontype_Invalid,le.ccwregdate_in_Invalid,le.ccwexpdate_in_Invalid,le.ccwpermtype_Invalid,le.dob_str_Invalid,le.regdate_Invalid,le.dateofcontr_Invalid,le.lastdayvote_Invalid,le.datelicense_Invalid,le.regexpdate_Invalid,le.ccwregdate_Invalid,le.ccwexpdate_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.score_on_input_Invalid,le.append_prep_resaddress1_Invalid,le.append_prep_resaddress2_Invalid,le.append_resrawaid_Invalid,le.append_prep_mailaddress1_Invalid,le.append_prep_mailaddress2_Invalid,le.append_mailrawaid_Invalid,le.append_prep_cassaddress1_Invalid,le.append_prep_cassaddress2_Invalid,le.append_cassrawaid_Invalid,le.aid_resclean_prim_range_Invalid,le.aid_resclean_predir_Invalid,le.aid_resclean_prim_name_Invalid,le.aid_resclean_addr_suffix_Invalid,le.aid_resclean_postdir_Invalid,le.aid_resclean_unit_desig_Invalid,le.aid_resclean_sec_range_Invalid,le.aid_resclean_p_city_name_Invalid,le.aid_resclean_v_city_name_Invalid,le.aid_resclean_st_Invalid,le.aid_resclean_zip_Invalid,le.aid_resclean_zip4_Invalid,le.aid_resclean_cart_Invalid,le.aid_resclean_cr_sort_sz_Invalid,le.aid_resclean_lot_Invalid,le.aid_resclean_lot_order_Invalid,le.aid_resclean_dpbc_Invalid,le.aid_resclean_chk_digit_Invalid,le.aid_resclean_record_type_Invalid,le.aid_resclean_ace_fips_st_Invalid,le.aid_resclean_fipscounty_Invalid,le.aid_resclean_geo_lat_Invalid,le.aid_resclean_geo_long_Invalid,le.aid_resclean_msa_Invalid,le.aid_resclean_geo_blk_Invalid,le.aid_resclean_geo_match_Invalid,le.aid_resclean_err_stat_Invalid,le.aid_mailclean_prim_range_Invalid,le.aid_mailclean_predir_Invalid,le.aid_mailclean_prim_name_Invalid,le.aid_mailclean_addr_suffix_Invalid,le.aid_mailclean_postdir_Invalid,le.aid_mailclean_unit_desig_Invalid,le.aid_mailclean_sec_range_Invalid,le.aid_mailclean_p_city_name_Invalid,le.aid_mailclean_v_city_name_Invalid,le.aid_mailclean_st_Invalid,le.aid_mailclean_zip_Invalid,le.aid_mailclean_zip4_Invalid,le.aid_mailclean_cart_Invalid,le.aid_mailclean_cr_sort_sz_Invalid,le.aid_mailclean_lot_Invalid,le.aid_mailclean_lot_order_Invalid,le.aid_mailclean_dpbc_Invalid,le.aid_mailclean_chk_digit_Invalid,le.aid_mailclean_record_type_Invalid,le.aid_mailclean_ace_fips_st_Invalid,le.aid_mailclean_fipscounty_Invalid,le.aid_mailclean_geo_lat_Invalid,le.aid_mailclean_geo_long_Invalid,le.aid_mailclean_msa_Invalid,le.aid_mailclean_geo_blk_Invalid,le.aid_mailclean_geo_match_Invalid,le.aid_mailclean_err_stat_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.record_type_Invalid,le.ace_fips_st_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.mail_prim_range_Invalid,le.mail_predir_Invalid,le.mail_prim_name_Invalid,le.mail_addr_suffix_Invalid,le.mail_postdir_Invalid,le.mail_unit_desig_Invalid,le.mail_sec_range_Invalid,le.mail_p_city_name_Invalid,le.mail_v_city_name_Invalid,le.mail_st_Invalid,le.mail_ace_zip_Invalid,le.mail_zip4_Invalid,le.mail_cart_Invalid,le.mail_cr_sort_sz_Invalid,le.mail_lot_Invalid,le.mail_lot_order_Invalid,le.mail_dpbc_Invalid,le.mail_chk_digit_Invalid,le.mail_record_type_Invalid,le.mail_ace_fips_st_Invalid,le.mail_fipscounty_Invalid,le.mail_geo_lat_Invalid,le.mail_geo_long_Invalid,le.mail_msa_Invalid,le.mail_geo_blk_Invalid,le.mail_geo_match_Invalid,le.cass_prim_range_Invalid,le.cass_predir_Invalid,le.cass_prim_name_Invalid,le.cass_addr_suffix_Invalid,le.cass_postdir_Invalid,le.cass_unit_desig_Invalid,le.cass_sec_range_Invalid,le.cass_p_city_name_Invalid,le.cass_v_city_name_Invalid,le.cass_st_Invalid,le.cass_ace_zip_Invalid,le.cass_zip4_Invalid,le.cass_cart_Invalid,le.cass_cr_sort_sz_Invalid,le.cass_lot_Invalid,le.cass_lot_order_Invalid,le.cass_dpbc_Invalid,le.cass_chk_digit_Invalid,le.cass_record_type_Invalid,le.cass_ace_fips_st_Invalid,le.cass_fipscounty_Invalid,le.cass_geo_lat_Invalid,le.cass_geo_long_Invalid,le.cass_msa_Invalid,le.cass_geo_blk_Invalid,le.cass_geo_match_Invalid,le.cass_err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,HVCCW_Fields.InvalidMessage_append_seqnum(le.append_seqnum_Invalid),HVCCW_Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),HVCCW_Fields.InvalidMessage_process_date(le.process_date_Invalid),HVCCW_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),HVCCW_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),HVCCW_Fields.InvalidMessage_score(le.score_Invalid),HVCCW_Fields.InvalidMessage_best_ssn(le.best_ssn_Invalid),HVCCW_Fields.InvalidMessage_did_out(le.did_out_Invalid),HVCCW_Fields.InvalidMessage_source(le.source_Invalid),HVCCW_Fields.InvalidMessage_file_id(le.file_id_Invalid),HVCCW_Fields.InvalidMessage_source_state(le.source_state_Invalid),HVCCW_Fields.InvalidMessage_source_code(le.source_code_Invalid),HVCCW_Fields.InvalidMessage_file_acquired_date(le.file_acquired_date_Invalid),HVCCW_Fields.InvalidMessage__use(le._use_Invalid),HVCCW_Fields.InvalidMessage_title_in(le.title_in_Invalid),HVCCW_Fields.InvalidMessage_lname_in(le.lname_in_Invalid),HVCCW_Fields.InvalidMessage_fname_in(le.fname_in_Invalid),HVCCW_Fields.InvalidMessage_mname_in(le.mname_in_Invalid),HVCCW_Fields.InvalidMessage_maiden_prior(le.maiden_prior_Invalid),HVCCW_Fields.InvalidMessage_name_suffix_in(le.name_suffix_in_Invalid),HVCCW_Fields.InvalidMessage_source_voterid(le.source_voterid_Invalid),HVCCW_Fields.InvalidMessage_dob_str_in(le.dob_str_in_Invalid),HVCCW_Fields.InvalidMessage_agecat(le.agecat_Invalid),HVCCW_Fields.InvalidMessage_headhousehold(le.headhousehold_Invalid),HVCCW_Fields.InvalidMessage_place_of_birth(le.place_of_birth_Invalid),HVCCW_Fields.InvalidMessage_occupation(le.occupation_Invalid),HVCCW_Fields.InvalidMessage_maiden_name(le.maiden_name_Invalid),HVCCW_Fields.InvalidMessage_motorvoterid(le.motorvoterid_Invalid),HVCCW_Fields.InvalidMessage_regsource(le.regsource_Invalid),HVCCW_Fields.InvalidMessage_regdate_in(le.regdate_in_Invalid),HVCCW_Fields.InvalidMessage_race(le.race_Invalid),HVCCW_Fields.InvalidMessage_gender(le.gender_Invalid),HVCCW_Fields.InvalidMessage_poliparty(le.poliparty_Invalid),HVCCW_Fields.InvalidMessage_phone(le.phone_Invalid),HVCCW_Fields.InvalidMessage_work_phone(le.work_phone_Invalid),HVCCW_Fields.InvalidMessage_other_phone(le.other_phone_Invalid),HVCCW_Fields.InvalidMessage_active_status(le.active_status_Invalid),HVCCW_Fields.InvalidMessage_active_other(le.active_other_Invalid),HVCCW_Fields.InvalidMessage_voterstatus(le.voterstatus_Invalid),HVCCW_Fields.InvalidMessage_resaddr1(le.resaddr1_Invalid),HVCCW_Fields.InvalidMessage_resaddr2(le.resaddr2_Invalid),HVCCW_Fields.InvalidMessage_res_city(le.res_city_Invalid),HVCCW_Fields.InvalidMessage_res_state(le.res_state_Invalid),HVCCW_Fields.InvalidMessage_res_zip(le.res_zip_Invalid),HVCCW_Fields.InvalidMessage_res_county(le.res_county_Invalid),HVCCW_Fields.InvalidMessage_mail_addr1(le.mail_addr1_Invalid),HVCCW_Fields.InvalidMessage_mail_addr2(le.mail_addr2_Invalid),HVCCW_Fields.InvalidMessage_mail_city(le.mail_city_Invalid),HVCCW_Fields.InvalidMessage_mail_state(le.mail_state_Invalid),HVCCW_Fields.InvalidMessage_mail_zip(le.mail_zip_Invalid),HVCCW_Fields.InvalidMessage_mail_county(le.mail_county_Invalid),HVCCW_Fields.InvalidMessage_towncode(le.towncode_Invalid),HVCCW_Fields.InvalidMessage_distcode(le.distcode_Invalid),HVCCW_Fields.InvalidMessage_countycode(le.countycode_Invalid),HVCCW_Fields.InvalidMessage_schoolcode(le.schoolcode_Invalid),HVCCW_Fields.InvalidMessage_cityinout(le.cityinout_Invalid),HVCCW_Fields.InvalidMessage_spec_dist1(le.spec_dist1_Invalid),HVCCW_Fields.InvalidMessage_spec_dist2(le.spec_dist2_Invalid),HVCCW_Fields.InvalidMessage_precinct1(le.precinct1_Invalid),HVCCW_Fields.InvalidMessage_precinct2(le.precinct2_Invalid),HVCCW_Fields.InvalidMessage_precinct3(le.precinct3_Invalid),HVCCW_Fields.InvalidMessage_villageprecinct(le.villageprecinct_Invalid),HVCCW_Fields.InvalidMessage_schoolprecinct(le.schoolprecinct_Invalid),HVCCW_Fields.InvalidMessage_ward(le.ward_Invalid),HVCCW_Fields.InvalidMessage_precinct_citytown(le.precinct_citytown_Invalid),HVCCW_Fields.InvalidMessage_ancsmdindc(le.ancsmdindc_Invalid),HVCCW_Fields.InvalidMessage_citycouncildist(le.citycouncildist_Invalid),HVCCW_Fields.InvalidMessage_countycommdist(le.countycommdist_Invalid),HVCCW_Fields.InvalidMessage_statehouse(le.statehouse_Invalid),HVCCW_Fields.InvalidMessage_statesenate(le.statesenate_Invalid),HVCCW_Fields.InvalidMessage_ushouse(le.ushouse_Invalid),HVCCW_Fields.InvalidMessage_elemschooldist(le.elemschooldist_Invalid),HVCCW_Fields.InvalidMessage_schooldist(le.schooldist_Invalid),HVCCW_Fields.InvalidMessage_commcolldist(le.commcolldist_Invalid),HVCCW_Fields.InvalidMessage_municipal(le.municipal_Invalid),HVCCW_Fields.InvalidMessage_villagedist(le.villagedist_Invalid),HVCCW_Fields.InvalidMessage_policejury(le.policejury_Invalid),HVCCW_Fields.InvalidMessage_policedist(le.policedist_Invalid),HVCCW_Fields.InvalidMessage_publicservcomm(le.publicservcomm_Invalid),HVCCW_Fields.InvalidMessage_rescue(le.rescue_Invalid),HVCCW_Fields.InvalidMessage_fire(le.fire_Invalid),HVCCW_Fields.InvalidMessage_sanitary(le.sanitary_Invalid),HVCCW_Fields.InvalidMessage_sewerdist(le.sewerdist_Invalid),HVCCW_Fields.InvalidMessage_waterdist(le.waterdist_Invalid),HVCCW_Fields.InvalidMessage_mosquitodist(le.mosquitodist_Invalid),HVCCW_Fields.InvalidMessage_taxdist(le.taxdist_Invalid),HVCCW_Fields.InvalidMessage_supremecourt(le.supremecourt_Invalid),HVCCW_Fields.InvalidMessage_justiceofpeace(le.justiceofpeace_Invalid),HVCCW_Fields.InvalidMessage_judicialdist(le.judicialdist_Invalid),HVCCW_Fields.InvalidMessage_superiorctdist(le.superiorctdist_Invalid),HVCCW_Fields.InvalidMessage_appealsct(le.appealsct_Invalid),HVCCW_Fields.InvalidMessage_contributorparty(le.contributorparty_Invalid),HVCCW_Fields.InvalidMessage_recptparty(le.recptparty_Invalid),HVCCW_Fields.InvalidMessage_dateofcontr_in(le.dateofcontr_in_Invalid),HVCCW_Fields.InvalidMessage_dollaramt(le.dollaramt_Invalid),HVCCW_Fields.InvalidMessage_officecontto(le.officecontto_Invalid),HVCCW_Fields.InvalidMessage_cumuldollaramt(le.cumuldollaramt_Invalid),HVCCW_Fields.InvalidMessage_conttype(le.conttype_Invalid),HVCCW_Fields.InvalidMessage_primary02(le.primary02_Invalid),HVCCW_Fields.InvalidMessage_special02(le.special02_Invalid),HVCCW_Fields.InvalidMessage_other02(le.other02_Invalid),HVCCW_Fields.InvalidMessage_special202(le.special202_Invalid),HVCCW_Fields.InvalidMessage_general02(le.general02_Invalid),HVCCW_Fields.InvalidMessage_primary01(le.primary01_Invalid),HVCCW_Fields.InvalidMessage_special01(le.special01_Invalid),HVCCW_Fields.InvalidMessage_other01(le.other01_Invalid),HVCCW_Fields.InvalidMessage_special201(le.special201_Invalid),HVCCW_Fields.InvalidMessage_general01(le.general01_Invalid),HVCCW_Fields.InvalidMessage_pres00(le.pres00_Invalid),HVCCW_Fields.InvalidMessage_primary00(le.primary00_Invalid),HVCCW_Fields.InvalidMessage_special00(le.special00_Invalid),HVCCW_Fields.InvalidMessage_other00(le.other00_Invalid),HVCCW_Fields.InvalidMessage_special200(le.special200_Invalid),HVCCW_Fields.InvalidMessage_general00(le.general00_Invalid),HVCCW_Fields.InvalidMessage_primary99(le.primary99_Invalid),HVCCW_Fields.InvalidMessage_special99(le.special99_Invalid),HVCCW_Fields.InvalidMessage_other99(le.other99_Invalid),HVCCW_Fields.InvalidMessage_special299(le.special299_Invalid),HVCCW_Fields.InvalidMessage_general99(le.general99_Invalid),HVCCW_Fields.InvalidMessage_primary98(le.primary98_Invalid),HVCCW_Fields.InvalidMessage_special98(le.special98_Invalid),HVCCW_Fields.InvalidMessage_other98(le.other98_Invalid),HVCCW_Fields.InvalidMessage_special298(le.special298_Invalid),HVCCW_Fields.InvalidMessage_general98(le.general98_Invalid),HVCCW_Fields.InvalidMessage_primary97(le.primary97_Invalid),HVCCW_Fields.InvalidMessage_special97(le.special97_Invalid),HVCCW_Fields.InvalidMessage_other97(le.other97_Invalid),HVCCW_Fields.InvalidMessage_special297(le.special297_Invalid),HVCCW_Fields.InvalidMessage_general97(le.general97_Invalid),HVCCW_Fields.InvalidMessage_pres96(le.pres96_Invalid),HVCCW_Fields.InvalidMessage_primary96(le.primary96_Invalid),HVCCW_Fields.InvalidMessage_special96(le.special96_Invalid),HVCCW_Fields.InvalidMessage_other96(le.other96_Invalid),HVCCW_Fields.InvalidMessage_special296(le.special296_Invalid),HVCCW_Fields.InvalidMessage_general96(le.general96_Invalid),HVCCW_Fields.InvalidMessage_lastdayvote_in(le.lastdayvote_in_Invalid),HVCCW_Fields.InvalidMessage_huntfishperm(le.huntfishperm_Invalid),HVCCW_Fields.InvalidMessage_datelicense_in(le.datelicense_in_Invalid),HVCCW_Fields.InvalidMessage_homestate(le.homestate_Invalid),HVCCW_Fields.InvalidMessage_resident(le.resident_Invalid),HVCCW_Fields.InvalidMessage_nonresident(le.nonresident_Invalid),HVCCW_Fields.InvalidMessage_hunt(le.hunt_Invalid),HVCCW_Fields.InvalidMessage_fish(le.fish_Invalid),HVCCW_Fields.InvalidMessage_combosuper(le.combosuper_Invalid),HVCCW_Fields.InvalidMessage_sportsman(le.sportsman_Invalid),HVCCW_Fields.InvalidMessage_trap(le.trap_Invalid),HVCCW_Fields.InvalidMessage_archery(le.archery_Invalid),HVCCW_Fields.InvalidMessage_muzzle(le.muzzle_Invalid),HVCCW_Fields.InvalidMessage_drawing(le.drawing_Invalid),HVCCW_Fields.InvalidMessage_day1(le.day1_Invalid),HVCCW_Fields.InvalidMessage_day3(le.day3_Invalid),HVCCW_Fields.InvalidMessage_day7(le.day7_Invalid),HVCCW_Fields.InvalidMessage_day14to15(le.day14to15_Invalid),HVCCW_Fields.InvalidMessage_seasonannual(le.seasonannual_Invalid),HVCCW_Fields.InvalidMessage_lifetimepermit(le.lifetimepermit_Invalid),HVCCW_Fields.InvalidMessage_landowner(le.landowner_Invalid),HVCCW_Fields.InvalidMessage_family(le.family_Invalid),HVCCW_Fields.InvalidMessage_junior(le.junior_Invalid),HVCCW_Fields.InvalidMessage_seniorcit(le.seniorcit_Invalid),HVCCW_Fields.InvalidMessage_crewmemeber(le.crewmemeber_Invalid),HVCCW_Fields.InvalidMessage_retarded(le.retarded_Invalid),HVCCW_Fields.InvalidMessage_indian(le.indian_Invalid),HVCCW_Fields.InvalidMessage_serviceman(le.serviceman_Invalid),HVCCW_Fields.InvalidMessage_disabled(le.disabled_Invalid),HVCCW_Fields.InvalidMessage_lowincome(le.lowincome_Invalid),HVCCW_Fields.InvalidMessage_regioncounty(le.regioncounty_Invalid),HVCCW_Fields.InvalidMessage_blind(le.blind_Invalid),HVCCW_Fields.InvalidMessage_salmon(le.salmon_Invalid),HVCCW_Fields.InvalidMessage_freshwater(le.freshwater_Invalid),HVCCW_Fields.InvalidMessage_saltwater(le.saltwater_Invalid),HVCCW_Fields.InvalidMessage_lakesandresevoirs(le.lakesandresevoirs_Invalid),HVCCW_Fields.InvalidMessage_setlinefish(le.setlinefish_Invalid),HVCCW_Fields.InvalidMessage_trout(le.trout_Invalid),HVCCW_Fields.InvalidMessage_fallfishing(le.fallfishing_Invalid),HVCCW_Fields.InvalidMessage_steelhead(le.steelhead_Invalid),HVCCW_Fields.InvalidMessage_whitejubherring(le.whitejubherring_Invalid),HVCCW_Fields.InvalidMessage_sturgeon(le.sturgeon_Invalid),HVCCW_Fields.InvalidMessage_shellfishcrab(le.shellfishcrab_Invalid),HVCCW_Fields.InvalidMessage_shellfishlobster(le.shellfishlobster_Invalid),HVCCW_Fields.InvalidMessage_deer(le.deer_Invalid),HVCCW_Fields.InvalidMessage_bear(le.bear_Invalid),HVCCW_Fields.InvalidMessage_elk(le.elk_Invalid),HVCCW_Fields.InvalidMessage_moose(le.moose_Invalid),HVCCW_Fields.InvalidMessage_buffalo(le.buffalo_Invalid),HVCCW_Fields.InvalidMessage_antelope(le.antelope_Invalid),HVCCW_Fields.InvalidMessage_sikebull(le.sikebull_Invalid),HVCCW_Fields.InvalidMessage_bighorn(le.bighorn_Invalid),HVCCW_Fields.InvalidMessage_javelina(le.javelina_Invalid),HVCCW_Fields.InvalidMessage_cougar(le.cougar_Invalid),HVCCW_Fields.InvalidMessage_anterless(le.anterless_Invalid),HVCCW_Fields.InvalidMessage_pheasant(le.pheasant_Invalid),HVCCW_Fields.InvalidMessage_goose(le.goose_Invalid),HVCCW_Fields.InvalidMessage_duck(le.duck_Invalid),HVCCW_Fields.InvalidMessage_turkey(le.turkey_Invalid),HVCCW_Fields.InvalidMessage_snowmobile(le.snowmobile_Invalid),HVCCW_Fields.InvalidMessage_biggame(le.biggame_Invalid),HVCCW_Fields.InvalidMessage_skipass(le.skipass_Invalid),HVCCW_Fields.InvalidMessage_migbird(le.migbird_Invalid),HVCCW_Fields.InvalidMessage_smallgame(le.smallgame_Invalid),HVCCW_Fields.InvalidMessage_sturgeon2(le.sturgeon2_Invalid),HVCCW_Fields.InvalidMessage_gun(le.gun_Invalid),HVCCW_Fields.InvalidMessage_bonus(le.bonus_Invalid),HVCCW_Fields.InvalidMessage_lottery(le.lottery_Invalid),HVCCW_Fields.InvalidMessage_otherbirds(le.otherbirds_Invalid),HVCCW_Fields.InvalidMessage_boatindexnum(le.boatindexnum_Invalid),HVCCW_Fields.InvalidMessage_boatcoowner(le.boatcoowner_Invalid),HVCCW_Fields.InvalidMessage_hullidnum(le.hullidnum_Invalid),HVCCW_Fields.InvalidMessage_yearmade(le.yearmade_Invalid),HVCCW_Fields.InvalidMessage_model(le.model_Invalid),HVCCW_Fields.InvalidMessage_manufacturer(le.manufacturer_Invalid),HVCCW_Fields.InvalidMessage_lengt(le.lengt_Invalid),HVCCW_Fields.InvalidMessage_hullconstruct(le.hullconstruct_Invalid),HVCCW_Fields.InvalidMessage_primuse(le.primuse_Invalid),HVCCW_Fields.InvalidMessage_fueltype(le.fueltype_Invalid),HVCCW_Fields.InvalidMessage_propulsion(le.propulsion_Invalid),HVCCW_Fields.InvalidMessage_modeltype(le.modeltype_Invalid),HVCCW_Fields.InvalidMessage_regexpdate_in(le.regexpdate_in_Invalid),HVCCW_Fields.InvalidMessage_titlenum(le.titlenum_Invalid),HVCCW_Fields.InvalidMessage_stprimuse(le.stprimuse_Invalid),HVCCW_Fields.InvalidMessage_titlestatus(le.titlestatus_Invalid),HVCCW_Fields.InvalidMessage_vessel(le.vessel_Invalid),HVCCW_Fields.InvalidMessage_specreg(le.specreg_Invalid),HVCCW_Fields.InvalidMessage_ccwpermnum(le.ccwpermnum_Invalid),HVCCW_Fields.InvalidMessage_ccwweapontype(le.ccwweapontype_Invalid),HVCCW_Fields.InvalidMessage_ccwregdate_in(le.ccwregdate_in_Invalid),HVCCW_Fields.InvalidMessage_ccwexpdate_in(le.ccwexpdate_in_Invalid),HVCCW_Fields.InvalidMessage_ccwpermtype(le.ccwpermtype_Invalid),HVCCW_Fields.InvalidMessage_dob_str(le.dob_str_Invalid),HVCCW_Fields.InvalidMessage_regdate(le.regdate_Invalid),HVCCW_Fields.InvalidMessage_dateofcontr(le.dateofcontr_Invalid),HVCCW_Fields.InvalidMessage_lastdayvote(le.lastdayvote_Invalid),HVCCW_Fields.InvalidMessage_datelicense(le.datelicense_Invalid),HVCCW_Fields.InvalidMessage_regexpdate(le.regexpdate_Invalid),HVCCW_Fields.InvalidMessage_ccwregdate(le.ccwregdate_Invalid),HVCCW_Fields.InvalidMessage_ccwexpdate(le.ccwexpdate_Invalid),HVCCW_Fields.InvalidMessage_title(le.title_Invalid),HVCCW_Fields.InvalidMessage_fname(le.fname_Invalid),HVCCW_Fields.InvalidMessage_mname(le.mname_Invalid),HVCCW_Fields.InvalidMessage_lname(le.lname_Invalid),HVCCW_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),HVCCW_Fields.InvalidMessage_score_on_input(le.score_on_input_Invalid),HVCCW_Fields.InvalidMessage_append_prep_resaddress1(le.append_prep_resaddress1_Invalid),HVCCW_Fields.InvalidMessage_append_prep_resaddress2(le.append_prep_resaddress2_Invalid),HVCCW_Fields.InvalidMessage_append_resrawaid(le.append_resrawaid_Invalid),HVCCW_Fields.InvalidMessage_append_prep_mailaddress1(le.append_prep_mailaddress1_Invalid),HVCCW_Fields.InvalidMessage_append_prep_mailaddress2(le.append_prep_mailaddress2_Invalid),HVCCW_Fields.InvalidMessage_append_mailrawaid(le.append_mailrawaid_Invalid),HVCCW_Fields.InvalidMessage_append_prep_cassaddress1(le.append_prep_cassaddress1_Invalid),HVCCW_Fields.InvalidMessage_append_prep_cassaddress2(le.append_prep_cassaddress2_Invalid),HVCCW_Fields.InvalidMessage_append_cassrawaid(le.append_cassrawaid_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_prim_range(le.aid_resclean_prim_range_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_predir(le.aid_resclean_predir_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_prim_name(le.aid_resclean_prim_name_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_addr_suffix(le.aid_resclean_addr_suffix_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_postdir(le.aid_resclean_postdir_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_unit_desig(le.aid_resclean_unit_desig_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_sec_range(le.aid_resclean_sec_range_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_p_city_name(le.aid_resclean_p_city_name_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_v_city_name(le.aid_resclean_v_city_name_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_st(le.aid_resclean_st_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_zip(le.aid_resclean_zip_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_zip4(le.aid_resclean_zip4_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_cart(le.aid_resclean_cart_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_cr_sort_sz(le.aid_resclean_cr_sort_sz_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_lot(le.aid_resclean_lot_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_lot_order(le.aid_resclean_lot_order_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_dpbc(le.aid_resclean_dpbc_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_chk_digit(le.aid_resclean_chk_digit_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_record_type(le.aid_resclean_record_type_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_ace_fips_st(le.aid_resclean_ace_fips_st_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_fipscounty(le.aid_resclean_fipscounty_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_geo_lat(le.aid_resclean_geo_lat_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_geo_long(le.aid_resclean_geo_long_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_msa(le.aid_resclean_msa_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_geo_blk(le.aid_resclean_geo_blk_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_geo_match(le.aid_resclean_geo_match_Invalid),HVCCW_Fields.InvalidMessage_aid_resclean_err_stat(le.aid_resclean_err_stat_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_prim_range(le.aid_mailclean_prim_range_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_predir(le.aid_mailclean_predir_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_prim_name(le.aid_mailclean_prim_name_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_addr_suffix(le.aid_mailclean_addr_suffix_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_postdir(le.aid_mailclean_postdir_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_unit_desig(le.aid_mailclean_unit_desig_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_sec_range(le.aid_mailclean_sec_range_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_p_city_name(le.aid_mailclean_p_city_name_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_v_city_name(le.aid_mailclean_v_city_name_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_st(le.aid_mailclean_st_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_zip(le.aid_mailclean_zip_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_zip4(le.aid_mailclean_zip4_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_cart(le.aid_mailclean_cart_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_cr_sort_sz(le.aid_mailclean_cr_sort_sz_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_lot(le.aid_mailclean_lot_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_lot_order(le.aid_mailclean_lot_order_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_dpbc(le.aid_mailclean_dpbc_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_chk_digit(le.aid_mailclean_chk_digit_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_record_type(le.aid_mailclean_record_type_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_ace_fips_st(le.aid_mailclean_ace_fips_st_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_fipscounty(le.aid_mailclean_fipscounty_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_geo_lat(le.aid_mailclean_geo_lat_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_geo_long(le.aid_mailclean_geo_long_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_msa(le.aid_mailclean_msa_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_geo_blk(le.aid_mailclean_geo_blk_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_geo_match(le.aid_mailclean_geo_match_Invalid),HVCCW_Fields.InvalidMessage_aid_mailclean_err_stat(le.aid_mailclean_err_stat_Invalid),HVCCW_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),HVCCW_Fields.InvalidMessage_predir(le.predir_Invalid),HVCCW_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),HVCCW_Fields.InvalidMessage_suffix(le.suffix_Invalid),HVCCW_Fields.InvalidMessage_postdir(le.postdir_Invalid),HVCCW_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),HVCCW_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),HVCCW_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),HVCCW_Fields.InvalidMessage_city_name(le.city_name_Invalid),HVCCW_Fields.InvalidMessage_st(le.st_Invalid),HVCCW_Fields.InvalidMessage_zip(le.zip_Invalid),HVCCW_Fields.InvalidMessage_zip4(le.zip4_Invalid),HVCCW_Fields.InvalidMessage_cart(le.cart_Invalid),HVCCW_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),HVCCW_Fields.InvalidMessage_lot(le.lot_Invalid),HVCCW_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),HVCCW_Fields.InvalidMessage_dpbc(le.dpbc_Invalid),HVCCW_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),HVCCW_Fields.InvalidMessage_record_type(le.record_type_Invalid),HVCCW_Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),HVCCW_Fields.InvalidMessage_county(le.county_Invalid),HVCCW_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),HVCCW_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),HVCCW_Fields.InvalidMessage_msa(le.msa_Invalid),HVCCW_Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),HVCCW_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),HVCCW_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),HVCCW_Fields.InvalidMessage_mail_prim_range(le.mail_prim_range_Invalid),HVCCW_Fields.InvalidMessage_mail_predir(le.mail_predir_Invalid),HVCCW_Fields.InvalidMessage_mail_prim_name(le.mail_prim_name_Invalid),HVCCW_Fields.InvalidMessage_mail_addr_suffix(le.mail_addr_suffix_Invalid),HVCCW_Fields.InvalidMessage_mail_postdir(le.mail_postdir_Invalid),HVCCW_Fields.InvalidMessage_mail_unit_desig(le.mail_unit_desig_Invalid),HVCCW_Fields.InvalidMessage_mail_sec_range(le.mail_sec_range_Invalid),HVCCW_Fields.InvalidMessage_mail_p_city_name(le.mail_p_city_name_Invalid),HVCCW_Fields.InvalidMessage_mail_v_city_name(le.mail_v_city_name_Invalid),HVCCW_Fields.InvalidMessage_mail_st(le.mail_st_Invalid),HVCCW_Fields.InvalidMessage_mail_ace_zip(le.mail_ace_zip_Invalid),HVCCW_Fields.InvalidMessage_mail_zip4(le.mail_zip4_Invalid),HVCCW_Fields.InvalidMessage_mail_cart(le.mail_cart_Invalid),HVCCW_Fields.InvalidMessage_mail_cr_sort_sz(le.mail_cr_sort_sz_Invalid),HVCCW_Fields.InvalidMessage_mail_lot(le.mail_lot_Invalid),HVCCW_Fields.InvalidMessage_mail_lot_order(le.mail_lot_order_Invalid),HVCCW_Fields.InvalidMessage_mail_dpbc(le.mail_dpbc_Invalid),HVCCW_Fields.InvalidMessage_mail_chk_digit(le.mail_chk_digit_Invalid),HVCCW_Fields.InvalidMessage_mail_record_type(le.mail_record_type_Invalid),HVCCW_Fields.InvalidMessage_mail_ace_fips_st(le.mail_ace_fips_st_Invalid),HVCCW_Fields.InvalidMessage_mail_fipscounty(le.mail_fipscounty_Invalid),HVCCW_Fields.InvalidMessage_mail_geo_lat(le.mail_geo_lat_Invalid),HVCCW_Fields.InvalidMessage_mail_geo_long(le.mail_geo_long_Invalid),HVCCW_Fields.InvalidMessage_mail_msa(le.mail_msa_Invalid),HVCCW_Fields.InvalidMessage_mail_geo_blk(le.mail_geo_blk_Invalid),HVCCW_Fields.InvalidMessage_mail_geo_match(le.mail_geo_match_Invalid),HVCCW_Fields.InvalidMessage_cass_prim_range(le.cass_prim_range_Invalid),HVCCW_Fields.InvalidMessage_cass_predir(le.cass_predir_Invalid),HVCCW_Fields.InvalidMessage_cass_prim_name(le.cass_prim_name_Invalid),HVCCW_Fields.InvalidMessage_cass_addr_suffix(le.cass_addr_suffix_Invalid),HVCCW_Fields.InvalidMessage_cass_postdir(le.cass_postdir_Invalid),HVCCW_Fields.InvalidMessage_cass_unit_desig(le.cass_unit_desig_Invalid),HVCCW_Fields.InvalidMessage_cass_sec_range(le.cass_sec_range_Invalid),HVCCW_Fields.InvalidMessage_cass_p_city_name(le.cass_p_city_name_Invalid),HVCCW_Fields.InvalidMessage_cass_v_city_name(le.cass_v_city_name_Invalid),HVCCW_Fields.InvalidMessage_cass_st(le.cass_st_Invalid),HVCCW_Fields.InvalidMessage_cass_ace_zip(le.cass_ace_zip_Invalid),HVCCW_Fields.InvalidMessage_cass_zip4(le.cass_zip4_Invalid),HVCCW_Fields.InvalidMessage_cass_cart(le.cass_cart_Invalid),HVCCW_Fields.InvalidMessage_cass_cr_sort_sz(le.cass_cr_sort_sz_Invalid),HVCCW_Fields.InvalidMessage_cass_lot(le.cass_lot_Invalid),HVCCW_Fields.InvalidMessage_cass_lot_order(le.cass_lot_order_Invalid),HVCCW_Fields.InvalidMessage_cass_dpbc(le.cass_dpbc_Invalid),HVCCW_Fields.InvalidMessage_cass_chk_digit(le.cass_chk_digit_Invalid),HVCCW_Fields.InvalidMessage_cass_record_type(le.cass_record_type_Invalid),HVCCW_Fields.InvalidMessage_cass_ace_fips_st(le.cass_ace_fips_st_Invalid),HVCCW_Fields.InvalidMessage_cass_fipscounty(le.cass_fipscounty_Invalid),HVCCW_Fields.InvalidMessage_cass_geo_lat(le.cass_geo_lat_Invalid),HVCCW_Fields.InvalidMessage_cass_geo_long(le.cass_geo_long_Invalid),HVCCW_Fields.InvalidMessage_cass_msa(le.cass_msa_Invalid),HVCCW_Fields.InvalidMessage_cass_geo_blk(le.cass_geo_blk_Invalid),HVCCW_Fields.InvalidMessage_cass_geo_match(le.cass_geo_match_Invalid),HVCCW_Fields.InvalidMessage_cass_err_stat(le.cass_err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.append_seqnum_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.persistent_record_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.best_ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_out_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.file_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_state_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.dob_str_in_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.agecat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.headhousehold_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.place_of_birth_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.occupation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.maiden_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.motorvoterid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.regsource_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.regdate_in_Invalid,'CUSTOM','UNKNOWN')
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
          ,CHOOSE(le.res_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.res_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.res_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_addr1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_addr2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mail_zip_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.dateofcontr_in_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dollaramt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officecontto_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cumuldollaramt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.conttype_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.lastdayvote_in_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.huntfishperm_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.datelicense_in_Invalid,'CUSTOM','UNKNOWN')
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
          ,CHOOSE(le.day1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.day3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.day7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.day14to15_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seasonannual_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.boatindexnum_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.boatcoowner_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hullidnum_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.yearmade_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.model_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.manufacturer_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lengt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hullconstruct_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.primuse_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fueltype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.propulsion_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.modeltype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.regexpdate_in_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.titlenum_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.stprimuse_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.titlestatus_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vessel_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.specreg_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ccwpermnum_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ccwweapontype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ccwregdate_in_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ccwexpdate_in_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ccwpermtype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_str_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.regdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dateofcontr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lastdayvote_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.datelicense_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.regexpdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ccwregdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ccwexpdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.score_on_input_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_prep_resaddress1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_prep_resaddress2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_resrawaid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_prep_mailaddress1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_prep_mailaddress2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_mailrawaid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_prep_cassaddress1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_prep_cassaddress2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_cassrawaid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.aid_resclean_zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.aid_resclean_zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_cr_sort_sz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_lot_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_dpbc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_ace_fips_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_fipscounty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_resclean_err_stat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_cr_sort_sz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_lot_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_dpbc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_ace_fips_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_fipscounty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.aid_mailclean_err_stat_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.mail_st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
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
          ,CHOOSE(le.cass_prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cass_ace_zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cass_zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_cr_sort_sz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_lot_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_dpbc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_ace_fips_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_fipscounty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cass_err_stat_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'append_seqnum','persistent_record_id','process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','source_voterid','dob_str_in','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate_in','race','gender','poliparty','phone','work_phone','other_phone','active_status','active_other','voterstatus','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','commcolldist','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','contributorparty','recptparty','dateofcontr_in','dollaramt','officecontto','cumuldollaramt','conttype','primary02','special02','other02','special202','general02','primary01','special01','other01','special201','general01','pres00','primary00','special00','other00','special200','general00','primary99','special99','other99','special299','general99','primary98','special98','other98','special298','general98','primary97','special97','other97','special297','general97','pres96','primary96','special96','other96','special296','general96','lastdayvote_in','huntfishperm','datelicense_in','homestate','resident','nonresident','hunt','fish','combosuper','sportsman','trap','archery','muzzle','drawing','day1','day3','day7','day14to15','seasonannual','lifetimepermit','landowner','family','junior','seniorcit','crewmemeber','retarded','indian','serviceman','disabled','lowincome','regioncounty','blind','salmon','freshwater','saltwater','lakesandresevoirs','setlinefish','trout','fallfishing','steelhead','whitejubherring','sturgeon','shellfishcrab','shellfishlobster','deer','bear','elk','moose','buffalo','antelope','sikebull','bighorn','javelina','cougar','anterless','pheasant','goose','duck','turkey','snowmobile','biggame','skipass','migbird','smallgame','sturgeon2','gun','bonus','lottery','otherbirds','boatindexnum','boatcoowner','hullidnum','yearmade','model','manufacturer','lengt','hullconstruct','primuse','fueltype','propulsion','modeltype','regexpdate_in','titlenum','stprimuse','titlestatus','vessel','specreg','ccwpermnum','ccwweapontype','ccwregdate_in','ccwexpdate_in','ccwpermtype','dob_str','regdate','dateofcontr','lastdayvote','datelicense','regexpdate','ccwregdate','ccwexpdate','title','fname','mname','lname','name_suffix','score_on_input','append_prep_resaddress1','append_prep_resaddress2','append_resrawaid','append_prep_mailaddress1','append_prep_mailaddress2','append_mailrawaid','append_prep_cassaddress1','append_prep_cassaddress2','append_cassrawaid','aid_resclean_prim_range','aid_resclean_predir','aid_resclean_prim_name','aid_resclean_addr_suffix','aid_resclean_postdir','aid_resclean_unit_desig','aid_resclean_sec_range','aid_resclean_p_city_name','aid_resclean_v_city_name','aid_resclean_st','aid_resclean_zip','aid_resclean_zip4','aid_resclean_cart','aid_resclean_cr_sort_sz','aid_resclean_lot','aid_resclean_lot_order','aid_resclean_dpbc','aid_resclean_chk_digit','aid_resclean_record_type','aid_resclean_ace_fips_st','aid_resclean_fipscounty','aid_resclean_geo_lat','aid_resclean_geo_long','aid_resclean_msa','aid_resclean_geo_blk','aid_resclean_geo_match','aid_resclean_err_stat','aid_mailclean_prim_range','aid_mailclean_predir','aid_mailclean_prim_name','aid_mailclean_addr_suffix','aid_mailclean_postdir','aid_mailclean_unit_desig','aid_mailclean_sec_range','aid_mailclean_p_city_name','aid_mailclean_v_city_name','aid_mailclean_st','aid_mailclean_zip','aid_mailclean_zip4','aid_mailclean_cart','aid_mailclean_cr_sort_sz','aid_mailclean_lot','aid_mailclean_lot_order','aid_mailclean_dpbc','aid_mailclean_chk_digit','aid_mailclean_record_type','aid_mailclean_ace_fips_st','aid_mailclean_fipscounty','aid_mailclean_geo_lat','aid_mailclean_geo_long','aid_mailclean_msa','aid_mailclean_geo_blk','aid_mailclean_geo_match','aid_mailclean_err_stat','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','cass_prim_range','cass_predir','cass_prim_name','cass_addr_suffix','cass_postdir','cass_unit_desig','cass_sec_range','cass_p_city_name','cass_v_city_name','cass_st','cass_ace_zip','cass_zip4','cass_cart','cass_cr_sort_sz','cass_lot','cass_lot_order','cass_dpbc','cass_chk_digit','cass_record_type','cass_ace_fips_st','cass_fipscounty','cass_geo_lat','cass_geo_long','cass_msa','cass_geo_blk','cass_geo_match','cass_err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_No','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Date','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Float','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Float','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_Date','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_Alpha','Invalid_Date','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_Float','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaNum','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.append_seqnum,(SALT311.StrType)le.persistent_record_id,(SALT311.StrType)le.process_date,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.score,(SALT311.StrType)le.best_ssn,(SALT311.StrType)le.did_out,(SALT311.StrType)le.source,(SALT311.StrType)le.file_id,(SALT311.StrType)le.source_state,(SALT311.StrType)le.source_code,(SALT311.StrType)le.file_acquired_date,(SALT311.StrType)le._use,(SALT311.StrType)le.title_in,(SALT311.StrType)le.lname_in,(SALT311.StrType)le.fname_in,(SALT311.StrType)le.mname_in,(SALT311.StrType)le.maiden_prior,(SALT311.StrType)le.name_suffix_in,(SALT311.StrType)le.source_voterid,(SALT311.StrType)le.dob_str_in,(SALT311.StrType)le.agecat,(SALT311.StrType)le.headhousehold,(SALT311.StrType)le.place_of_birth,(SALT311.StrType)le.occupation,(SALT311.StrType)le.maiden_name,(SALT311.StrType)le.motorvoterid,(SALT311.StrType)le.regsource,(SALT311.StrType)le.regdate_in,(SALT311.StrType)le.race,(SALT311.StrType)le.gender,(SALT311.StrType)le.poliparty,(SALT311.StrType)le.phone,(SALT311.StrType)le.work_phone,(SALT311.StrType)le.other_phone,(SALT311.StrType)le.active_status,(SALT311.StrType)le.active_other,(SALT311.StrType)le.voterstatus,(SALT311.StrType)le.resaddr1,(SALT311.StrType)le.resaddr2,(SALT311.StrType)le.res_city,(SALT311.StrType)le.res_state,(SALT311.StrType)le.res_zip,(SALT311.StrType)le.res_county,(SALT311.StrType)le.mail_addr1,(SALT311.StrType)le.mail_addr2,(SALT311.StrType)le.mail_city,(SALT311.StrType)le.mail_state,(SALT311.StrType)le.mail_zip,(SALT311.StrType)le.mail_county,(SALT311.StrType)le.towncode,(SALT311.StrType)le.distcode,(SALT311.StrType)le.countycode,(SALT311.StrType)le.schoolcode,(SALT311.StrType)le.cityinout,(SALT311.StrType)le.spec_dist1,(SALT311.StrType)le.spec_dist2,(SALT311.StrType)le.precinct1,(SALT311.StrType)le.precinct2,(SALT311.StrType)le.precinct3,(SALT311.StrType)le.villageprecinct,(SALT311.StrType)le.schoolprecinct,(SALT311.StrType)le.ward,(SALT311.StrType)le.precinct_citytown,(SALT311.StrType)le.ancsmdindc,(SALT311.StrType)le.citycouncildist,(SALT311.StrType)le.countycommdist,(SALT311.StrType)le.statehouse,(SALT311.StrType)le.statesenate,(SALT311.StrType)le.ushouse,(SALT311.StrType)le.elemschooldist,(SALT311.StrType)le.schooldist,(SALT311.StrType)le.commcolldist,(SALT311.StrType)le.municipal,(SALT311.StrType)le.villagedist,(SALT311.StrType)le.policejury,(SALT311.StrType)le.policedist,(SALT311.StrType)le.publicservcomm,(SALT311.StrType)le.rescue,(SALT311.StrType)le.fire,(SALT311.StrType)le.sanitary,(SALT311.StrType)le.sewerdist,(SALT311.StrType)le.waterdist,(SALT311.StrType)le.mosquitodist,(SALT311.StrType)le.taxdist,(SALT311.StrType)le.supremecourt,(SALT311.StrType)le.justiceofpeace,(SALT311.StrType)le.judicialdist,(SALT311.StrType)le.superiorctdist,(SALT311.StrType)le.appealsct,(SALT311.StrType)le.contributorparty,(SALT311.StrType)le.recptparty,(SALT311.StrType)le.dateofcontr_in,(SALT311.StrType)le.dollaramt,(SALT311.StrType)le.officecontto,(SALT311.StrType)le.cumuldollaramt,(SALT311.StrType)le.conttype,(SALT311.StrType)le.primary02,(SALT311.StrType)le.special02,(SALT311.StrType)le.other02,(SALT311.StrType)le.special202,(SALT311.StrType)le.general02,(SALT311.StrType)le.primary01,(SALT311.StrType)le.special01,(SALT311.StrType)le.other01,(SALT311.StrType)le.special201,(SALT311.StrType)le.general01,(SALT311.StrType)le.pres00,(SALT311.StrType)le.primary00,(SALT311.StrType)le.special00,(SALT311.StrType)le.other00,(SALT311.StrType)le.special200,(SALT311.StrType)le.general00,(SALT311.StrType)le.primary99,(SALT311.StrType)le.special99,(SALT311.StrType)le.other99,(SALT311.StrType)le.special299,(SALT311.StrType)le.general99,(SALT311.StrType)le.primary98,(SALT311.StrType)le.special98,(SALT311.StrType)le.other98,(SALT311.StrType)le.special298,(SALT311.StrType)le.general98,(SALT311.StrType)le.primary97,(SALT311.StrType)le.special97,(SALT311.StrType)le.other97,(SALT311.StrType)le.special297,(SALT311.StrType)le.general97,(SALT311.StrType)le.pres96,(SALT311.StrType)le.primary96,(SALT311.StrType)le.special96,(SALT311.StrType)le.other96,(SALT311.StrType)le.special296,(SALT311.StrType)le.general96,(SALT311.StrType)le.lastdayvote_in,(SALT311.StrType)le.huntfishperm,(SALT311.StrType)le.datelicense_in,(SALT311.StrType)le.homestate,(SALT311.StrType)le.resident,(SALT311.StrType)le.nonresident,(SALT311.StrType)le.hunt,(SALT311.StrType)le.fish,(SALT311.StrType)le.combosuper,(SALT311.StrType)le.sportsman,(SALT311.StrType)le.trap,(SALT311.StrType)le.archery,(SALT311.StrType)le.muzzle,(SALT311.StrType)le.drawing,(SALT311.StrType)le.day1,(SALT311.StrType)le.day3,(SALT311.StrType)le.day7,(SALT311.StrType)le.day14to15,(SALT311.StrType)le.seasonannual,(SALT311.StrType)le.lifetimepermit,(SALT311.StrType)le.landowner,(SALT311.StrType)le.family,(SALT311.StrType)le.junior,(SALT311.StrType)le.seniorcit,(SALT311.StrType)le.crewmemeber,(SALT311.StrType)le.retarded,(SALT311.StrType)le.indian,(SALT311.StrType)le.serviceman,(SALT311.StrType)le.disabled,(SALT311.StrType)le.lowincome,(SALT311.StrType)le.regioncounty,(SALT311.StrType)le.blind,(SALT311.StrType)le.salmon,(SALT311.StrType)le.freshwater,(SALT311.StrType)le.saltwater,(SALT311.StrType)le.lakesandresevoirs,(SALT311.StrType)le.setlinefish,(SALT311.StrType)le.trout,(SALT311.StrType)le.fallfishing,(SALT311.StrType)le.steelhead,(SALT311.StrType)le.whitejubherring,(SALT311.StrType)le.sturgeon,(SALT311.StrType)le.shellfishcrab,(SALT311.StrType)le.shellfishlobster,(SALT311.StrType)le.deer,(SALT311.StrType)le.bear,(SALT311.StrType)le.elk,(SALT311.StrType)le.moose,(SALT311.StrType)le.buffalo,(SALT311.StrType)le.antelope,(SALT311.StrType)le.sikebull,(SALT311.StrType)le.bighorn,(SALT311.StrType)le.javelina,(SALT311.StrType)le.cougar,(SALT311.StrType)le.anterless,(SALT311.StrType)le.pheasant,(SALT311.StrType)le.goose,(SALT311.StrType)le.duck,(SALT311.StrType)le.turkey,(SALT311.StrType)le.snowmobile,(SALT311.StrType)le.biggame,(SALT311.StrType)le.skipass,(SALT311.StrType)le.migbird,(SALT311.StrType)le.smallgame,(SALT311.StrType)le.sturgeon2,(SALT311.StrType)le.gun,(SALT311.StrType)le.bonus,(SALT311.StrType)le.lottery,(SALT311.StrType)le.otherbirds,(SALT311.StrType)le.boatindexnum,(SALT311.StrType)le.boatcoowner,(SALT311.StrType)le.hullidnum,(SALT311.StrType)le.yearmade,(SALT311.StrType)le.model,(SALT311.StrType)le.manufacturer,(SALT311.StrType)le.lengt,(SALT311.StrType)le.hullconstruct,(SALT311.StrType)le.primuse,(SALT311.StrType)le.fueltype,(SALT311.StrType)le.propulsion,(SALT311.StrType)le.modeltype,(SALT311.StrType)le.regexpdate_in,(SALT311.StrType)le.titlenum,(SALT311.StrType)le.stprimuse,(SALT311.StrType)le.titlestatus,(SALT311.StrType)le.vessel,(SALT311.StrType)le.specreg,(SALT311.StrType)le.ccwpermnum,(SALT311.StrType)le.ccwweapontype,(SALT311.StrType)le.ccwregdate_in,(SALT311.StrType)le.ccwexpdate_in,(SALT311.StrType)le.ccwpermtype,(SALT311.StrType)le.dob_str,(SALT311.StrType)le.regdate,(SALT311.StrType)le.dateofcontr,(SALT311.StrType)le.lastdayvote,(SALT311.StrType)le.datelicense,(SALT311.StrType)le.regexpdate,(SALT311.StrType)le.ccwregdate,(SALT311.StrType)le.ccwexpdate,(SALT311.StrType)le.title,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.score_on_input,(SALT311.StrType)le.append_prep_resaddress1,(SALT311.StrType)le.append_prep_resaddress2,(SALT311.StrType)le.append_resrawaid,(SALT311.StrType)le.append_prep_mailaddress1,(SALT311.StrType)le.append_prep_mailaddress2,(SALT311.StrType)le.append_mailrawaid,(SALT311.StrType)le.append_prep_cassaddress1,(SALT311.StrType)le.append_prep_cassaddress2,(SALT311.StrType)le.append_cassrawaid,(SALT311.StrType)le.aid_resclean_prim_range,(SALT311.StrType)le.aid_resclean_predir,(SALT311.StrType)le.aid_resclean_prim_name,(SALT311.StrType)le.aid_resclean_addr_suffix,(SALT311.StrType)le.aid_resclean_postdir,(SALT311.StrType)le.aid_resclean_unit_desig,(SALT311.StrType)le.aid_resclean_sec_range,(SALT311.StrType)le.aid_resclean_p_city_name,(SALT311.StrType)le.aid_resclean_v_city_name,(SALT311.StrType)le.aid_resclean_st,(SALT311.StrType)le.aid_resclean_zip,(SALT311.StrType)le.aid_resclean_zip4,(SALT311.StrType)le.aid_resclean_cart,(SALT311.StrType)le.aid_resclean_cr_sort_sz,(SALT311.StrType)le.aid_resclean_lot,(SALT311.StrType)le.aid_resclean_lot_order,(SALT311.StrType)le.aid_resclean_dpbc,(SALT311.StrType)le.aid_resclean_chk_digit,(SALT311.StrType)le.aid_resclean_record_type,(SALT311.StrType)le.aid_resclean_ace_fips_st,(SALT311.StrType)le.aid_resclean_fipscounty,(SALT311.StrType)le.aid_resclean_geo_lat,(SALT311.StrType)le.aid_resclean_geo_long,(SALT311.StrType)le.aid_resclean_msa,(SALT311.StrType)le.aid_resclean_geo_blk,(SALT311.StrType)le.aid_resclean_geo_match,(SALT311.StrType)le.aid_resclean_err_stat,(SALT311.StrType)le.aid_mailclean_prim_range,(SALT311.StrType)le.aid_mailclean_predir,(SALT311.StrType)le.aid_mailclean_prim_name,(SALT311.StrType)le.aid_mailclean_addr_suffix,(SALT311.StrType)le.aid_mailclean_postdir,(SALT311.StrType)le.aid_mailclean_unit_desig,(SALT311.StrType)le.aid_mailclean_sec_range,(SALT311.StrType)le.aid_mailclean_p_city_name,(SALT311.StrType)le.aid_mailclean_v_city_name,(SALT311.StrType)le.aid_mailclean_st,(SALT311.StrType)le.aid_mailclean_zip,(SALT311.StrType)le.aid_mailclean_zip4,(SALT311.StrType)le.aid_mailclean_cart,(SALT311.StrType)le.aid_mailclean_cr_sort_sz,(SALT311.StrType)le.aid_mailclean_lot,(SALT311.StrType)le.aid_mailclean_lot_order,(SALT311.StrType)le.aid_mailclean_dpbc,(SALT311.StrType)le.aid_mailclean_chk_digit,(SALT311.StrType)le.aid_mailclean_record_type,(SALT311.StrType)le.aid_mailclean_ace_fips_st,(SALT311.StrType)le.aid_mailclean_fipscounty,(SALT311.StrType)le.aid_mailclean_geo_lat,(SALT311.StrType)le.aid_mailclean_geo_long,(SALT311.StrType)le.aid_mailclean_msa,(SALT311.StrType)le.aid_mailclean_geo_blk,(SALT311.StrType)le.aid_mailclean_geo_match,(SALT311.StrType)le.aid_mailclean_err_stat,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dpbc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.record_type,(SALT311.StrType)le.ace_fips_st,(SALT311.StrType)le.county,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.msa,(SALT311.StrType)le.geo_blk,(SALT311.StrType)le.geo_match,(SALT311.StrType)le.err_stat,(SALT311.StrType)le.mail_prim_range,(SALT311.StrType)le.mail_predir,(SALT311.StrType)le.mail_prim_name,(SALT311.StrType)le.mail_addr_suffix,(SALT311.StrType)le.mail_postdir,(SALT311.StrType)le.mail_unit_desig,(SALT311.StrType)le.mail_sec_range,(SALT311.StrType)le.mail_p_city_name,(SALT311.StrType)le.mail_v_city_name,(SALT311.StrType)le.mail_st,(SALT311.StrType)le.mail_ace_zip,(SALT311.StrType)le.mail_zip4,(SALT311.StrType)le.mail_cart,(SALT311.StrType)le.mail_cr_sort_sz,(SALT311.StrType)le.mail_lot,(SALT311.StrType)le.mail_lot_order,(SALT311.StrType)le.mail_dpbc,(SALT311.StrType)le.mail_chk_digit,(SALT311.StrType)le.mail_record_type,(SALT311.StrType)le.mail_ace_fips_st,(SALT311.StrType)le.mail_fipscounty,(SALT311.StrType)le.mail_geo_lat,(SALT311.StrType)le.mail_geo_long,(SALT311.StrType)le.mail_msa,(SALT311.StrType)le.mail_geo_blk,(SALT311.StrType)le.mail_geo_match,(SALT311.StrType)le.cass_prim_range,(SALT311.StrType)le.cass_predir,(SALT311.StrType)le.cass_prim_name,(SALT311.StrType)le.cass_addr_suffix,(SALT311.StrType)le.cass_postdir,(SALT311.StrType)le.cass_unit_desig,(SALT311.StrType)le.cass_sec_range,(SALT311.StrType)le.cass_p_city_name,(SALT311.StrType)le.cass_v_city_name,(SALT311.StrType)le.cass_st,(SALT311.StrType)le.cass_ace_zip,(SALT311.StrType)le.cass_zip4,(SALT311.StrType)le.cass_cart,(SALT311.StrType)le.cass_cr_sort_sz,(SALT311.StrType)le.cass_lot,(SALT311.StrType)le.cass_lot_order,(SALT311.StrType)le.cass_dpbc,(SALT311.StrType)le.cass_chk_digit,(SALT311.StrType)le.cass_record_type,(SALT311.StrType)le.cass_ace_fips_st,(SALT311.StrType)le.cass_fipscounty,(SALT311.StrType)le.cass_geo_lat,(SALT311.StrType)le.cass_geo_long,(SALT311.StrType)le.cass_msa,(SALT311.StrType)le.cass_geo_blk,(SALT311.StrType)le.cass_geo_match,(SALT311.StrType)le.cass_err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,384,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(HVCCW_Layout_eMerges) prevDS = DATASET([], HVCCW_Layout_eMerges), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.append_seqnum_ALLOW_ErrorCount
          ,le.persistent_record_id_ALLOW_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.score_ALLOW_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount
          ,le.did_out_ALLOW_ErrorCount
          ,le.source_ALLOW_ErrorCount
          ,le.file_id_ALLOW_ErrorCount
          ,le.source_state_ALLOW_ErrorCount
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
          ,le.dob_str_in_CUSTOM_ErrorCount
          ,le.agecat_ALLOW_ErrorCount
          ,le.headhousehold_ALLOW_ErrorCount
          ,le.place_of_birth_CUSTOM_ErrorCount
          ,le.occupation_ALLOW_ErrorCount
          ,le.maiden_name_ALLOW_ErrorCount
          ,le.motorvoterid_ALLOW_ErrorCount
          ,le.regsource_ALLOW_ErrorCount
          ,le.regdate_in_CUSTOM_ErrorCount
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
          ,le.res_state_ALLOW_ErrorCount
          ,le.res_zip_ALLOW_ErrorCount
          ,le.res_county_ALLOW_ErrorCount
          ,le.mail_addr1_ALLOW_ErrorCount
          ,le.mail_addr2_ALLOW_ErrorCount
          ,le.mail_city_ALLOW_ErrorCount
          ,le.mail_state_ALLOW_ErrorCount,le.mail_state_LENGTHS_ErrorCount
          ,le.mail_zip_ALLOW_ErrorCount
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
          ,le.dateofcontr_in_CUSTOM_ErrorCount
          ,le.dollaramt_ALLOW_ErrorCount
          ,le.officecontto_ALLOW_ErrorCount
          ,le.cumuldollaramt_ALLOW_ErrorCount
          ,le.conttype_ALLOW_ErrorCount
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
          ,le.lastdayvote_in_CUSTOM_ErrorCount
          ,le.huntfishperm_ALLOW_ErrorCount
          ,le.datelicense_in_CUSTOM_ErrorCount
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
          ,le.day1_ALLOW_ErrorCount
          ,le.day3_ALLOW_ErrorCount
          ,le.day7_ALLOW_ErrorCount
          ,le.day14to15_ALLOW_ErrorCount
          ,le.seasonannual_ALLOW_ErrorCount
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
          ,le.boatindexnum_ALLOW_ErrorCount
          ,le.boatcoowner_ALLOW_ErrorCount
          ,le.hullidnum_ALLOW_ErrorCount
          ,le.yearmade_ALLOW_ErrorCount
          ,le.model_ALLOW_ErrorCount
          ,le.manufacturer_ALLOW_ErrorCount
          ,le.lengt_ALLOW_ErrorCount
          ,le.hullconstruct_ALLOW_ErrorCount
          ,le.primuse_ALLOW_ErrorCount
          ,le.fueltype_ALLOW_ErrorCount
          ,le.propulsion_ALLOW_ErrorCount
          ,le.modeltype_ALLOW_ErrorCount
          ,le.regexpdate_in_CUSTOM_ErrorCount
          ,le.titlenum_ALLOW_ErrorCount
          ,le.stprimuse_ALLOW_ErrorCount
          ,le.titlestatus_ALLOW_ErrorCount
          ,le.vessel_ALLOW_ErrorCount
          ,le.specreg_ALLOW_ErrorCount
          ,le.ccwpermnum_ALLOW_ErrorCount
          ,le.ccwweapontype_ALLOW_ErrorCount
          ,le.ccwregdate_in_CUSTOM_ErrorCount
          ,le.ccwexpdate_in_CUSTOM_ErrorCount
          ,le.ccwpermtype_ALLOW_ErrorCount
          ,le.dob_str_CUSTOM_ErrorCount
          ,le.regdate_CUSTOM_ErrorCount
          ,le.dateofcontr_CUSTOM_ErrorCount
          ,le.lastdayvote_CUSTOM_ErrorCount
          ,le.datelicense_CUSTOM_ErrorCount
          ,le.regexpdate_CUSTOM_ErrorCount
          ,le.ccwregdate_CUSTOM_ErrorCount
          ,le.ccwexpdate_CUSTOM_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.score_on_input_ALLOW_ErrorCount
          ,le.append_prep_resaddress1_ALLOW_ErrorCount
          ,le.append_prep_resaddress2_ALLOW_ErrorCount
          ,le.append_resrawaid_ALLOW_ErrorCount
          ,le.append_prep_mailaddress1_ALLOW_ErrorCount
          ,le.append_prep_mailaddress2_ALLOW_ErrorCount
          ,le.append_mailrawaid_ALLOW_ErrorCount
          ,le.append_prep_cassaddress1_ALLOW_ErrorCount
          ,le.append_prep_cassaddress2_ALLOW_ErrorCount
          ,le.append_cassrawaid_ALLOW_ErrorCount
          ,le.aid_resclean_prim_range_ALLOW_ErrorCount
          ,le.aid_resclean_predir_ALLOW_ErrorCount
          ,le.aid_resclean_prim_name_ALLOW_ErrorCount
          ,le.aid_resclean_addr_suffix_ALLOW_ErrorCount
          ,le.aid_resclean_postdir_ALLOW_ErrorCount
          ,le.aid_resclean_unit_desig_ALLOW_ErrorCount
          ,le.aid_resclean_sec_range_ALLOW_ErrorCount
          ,le.aid_resclean_p_city_name_ALLOW_ErrorCount
          ,le.aid_resclean_v_city_name_ALLOW_ErrorCount
          ,le.aid_resclean_st_ALLOW_ErrorCount,le.aid_resclean_st_LENGTHS_ErrorCount
          ,le.aid_resclean_zip_ALLOW_ErrorCount,le.aid_resclean_zip_LENGTHS_ErrorCount
          ,le.aid_resclean_zip4_ALLOW_ErrorCount
          ,le.aid_resclean_cart_ALLOW_ErrorCount
          ,le.aid_resclean_cr_sort_sz_ALLOW_ErrorCount
          ,le.aid_resclean_lot_ALLOW_ErrorCount
          ,le.aid_resclean_lot_order_ALLOW_ErrorCount
          ,le.aid_resclean_dpbc_ALLOW_ErrorCount
          ,le.aid_resclean_chk_digit_ALLOW_ErrorCount
          ,le.aid_resclean_record_type_ALLOW_ErrorCount
          ,le.aid_resclean_ace_fips_st_ALLOW_ErrorCount
          ,le.aid_resclean_fipscounty_ALLOW_ErrorCount
          ,le.aid_resclean_geo_lat_ALLOW_ErrorCount
          ,le.aid_resclean_geo_long_ALLOW_ErrorCount
          ,le.aid_resclean_msa_ALLOW_ErrorCount
          ,le.aid_resclean_geo_blk_ALLOW_ErrorCount
          ,le.aid_resclean_geo_match_ALLOW_ErrorCount
          ,le.aid_resclean_err_stat_ALLOW_ErrorCount
          ,le.aid_mailclean_prim_range_ALLOW_ErrorCount
          ,le.aid_mailclean_predir_ALLOW_ErrorCount
          ,le.aid_mailclean_prim_name_ALLOW_ErrorCount
          ,le.aid_mailclean_addr_suffix_ALLOW_ErrorCount
          ,le.aid_mailclean_postdir_ALLOW_ErrorCount
          ,le.aid_mailclean_unit_desig_ALLOW_ErrorCount
          ,le.aid_mailclean_sec_range_ALLOW_ErrorCount
          ,le.aid_mailclean_p_city_name_ALLOW_ErrorCount
          ,le.aid_mailclean_v_city_name_ALLOW_ErrorCount
          ,le.aid_mailclean_st_ALLOW_ErrorCount,le.aid_mailclean_st_LENGTHS_ErrorCount
          ,le.aid_mailclean_zip_ALLOW_ErrorCount,le.aid_mailclean_zip_LENGTHS_ErrorCount
          ,le.aid_mailclean_zip4_ALLOW_ErrorCount
          ,le.aid_mailclean_cart_ALLOW_ErrorCount
          ,le.aid_mailclean_cr_sort_sz_ALLOW_ErrorCount
          ,le.aid_mailclean_lot_ALLOW_ErrorCount
          ,le.aid_mailclean_lot_order_ALLOW_ErrorCount
          ,le.aid_mailclean_dpbc_ALLOW_ErrorCount
          ,le.aid_mailclean_chk_digit_ALLOW_ErrorCount
          ,le.aid_mailclean_record_type_ALLOW_ErrorCount
          ,le.aid_mailclean_ace_fips_st_ALLOW_ErrorCount
          ,le.aid_mailclean_fipscounty_ALLOW_ErrorCount
          ,le.aid_mailclean_geo_lat_ALLOW_ErrorCount
          ,le.aid_mailclean_geo_long_ALLOW_ErrorCount
          ,le.aid_mailclean_msa_ALLOW_ErrorCount
          ,le.aid_mailclean_geo_blk_ALLOW_ErrorCount
          ,le.aid_mailclean_geo_match_ALLOW_ErrorCount
          ,le.aid_mailclean_err_stat_ALLOW_ErrorCount
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
          ,le.mail_st_ALLOW_ErrorCount,le.mail_st_LENGTHS_ErrorCount
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
          ,le.cass_prim_range_ALLOW_ErrorCount
          ,le.cass_predir_ALLOW_ErrorCount
          ,le.cass_prim_name_ALLOW_ErrorCount
          ,le.cass_addr_suffix_ALLOW_ErrorCount
          ,le.cass_postdir_ALLOW_ErrorCount
          ,le.cass_unit_desig_ALLOW_ErrorCount
          ,le.cass_sec_range_ALLOW_ErrorCount
          ,le.cass_p_city_name_ALLOW_ErrorCount
          ,le.cass_v_city_name_ALLOW_ErrorCount
          ,le.cass_st_ALLOW_ErrorCount,le.cass_st_LENGTHS_ErrorCount
          ,le.cass_ace_zip_ALLOW_ErrorCount,le.cass_ace_zip_LENGTHS_ErrorCount
          ,le.cass_zip4_ALLOW_ErrorCount
          ,le.cass_cart_ALLOW_ErrorCount
          ,le.cass_cr_sort_sz_ALLOW_ErrorCount
          ,le.cass_lot_ALLOW_ErrorCount
          ,le.cass_lot_order_ALLOW_ErrorCount
          ,le.cass_dpbc_ALLOW_ErrorCount
          ,le.cass_chk_digit_ALLOW_ErrorCount
          ,le.cass_record_type_ALLOW_ErrorCount
          ,le.cass_ace_fips_st_ALLOW_ErrorCount
          ,le.cass_fipscounty_ALLOW_ErrorCount
          ,le.cass_geo_lat_ALLOW_ErrorCount
          ,le.cass_geo_long_ALLOW_ErrorCount
          ,le.cass_msa_ALLOW_ErrorCount
          ,le.cass_geo_blk_ALLOW_ErrorCount
          ,le.cass_geo_match_ALLOW_ErrorCount
          ,le.cass_err_stat_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.append_seqnum_ALLOW_ErrorCount
          ,le.persistent_record_id_ALLOW_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.score_ALLOW_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount
          ,le.did_out_ALLOW_ErrorCount
          ,le.source_ALLOW_ErrorCount
          ,le.file_id_ALLOW_ErrorCount
          ,le.source_state_ALLOW_ErrorCount
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
          ,le.dob_str_in_CUSTOM_ErrorCount
          ,le.agecat_ALLOW_ErrorCount
          ,le.headhousehold_ALLOW_ErrorCount
          ,le.place_of_birth_CUSTOM_ErrorCount
          ,le.occupation_ALLOW_ErrorCount
          ,le.maiden_name_ALLOW_ErrorCount
          ,le.motorvoterid_ALLOW_ErrorCount
          ,le.regsource_ALLOW_ErrorCount
          ,le.regdate_in_CUSTOM_ErrorCount
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
          ,le.res_state_ALLOW_ErrorCount
          ,le.res_zip_ALLOW_ErrorCount
          ,le.res_county_ALLOW_ErrorCount
          ,le.mail_addr1_ALLOW_ErrorCount
          ,le.mail_addr2_ALLOW_ErrorCount
          ,le.mail_city_ALLOW_ErrorCount
          ,le.mail_state_ALLOW_ErrorCount,le.mail_state_LENGTHS_ErrorCount
          ,le.mail_zip_ALLOW_ErrorCount
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
          ,le.dateofcontr_in_CUSTOM_ErrorCount
          ,le.dollaramt_ALLOW_ErrorCount
          ,le.officecontto_ALLOW_ErrorCount
          ,le.cumuldollaramt_ALLOW_ErrorCount
          ,le.conttype_ALLOW_ErrorCount
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
          ,le.lastdayvote_in_CUSTOM_ErrorCount
          ,le.huntfishperm_ALLOW_ErrorCount
          ,le.datelicense_in_CUSTOM_ErrorCount
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
          ,le.day1_ALLOW_ErrorCount
          ,le.day3_ALLOW_ErrorCount
          ,le.day7_ALLOW_ErrorCount
          ,le.day14to15_ALLOW_ErrorCount
          ,le.seasonannual_ALLOW_ErrorCount
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
          ,le.boatindexnum_ALLOW_ErrorCount
          ,le.boatcoowner_ALLOW_ErrorCount
          ,le.hullidnum_ALLOW_ErrorCount
          ,le.yearmade_ALLOW_ErrorCount
          ,le.model_ALLOW_ErrorCount
          ,le.manufacturer_ALLOW_ErrorCount
          ,le.lengt_ALLOW_ErrorCount
          ,le.hullconstruct_ALLOW_ErrorCount
          ,le.primuse_ALLOW_ErrorCount
          ,le.fueltype_ALLOW_ErrorCount
          ,le.propulsion_ALLOW_ErrorCount
          ,le.modeltype_ALLOW_ErrorCount
          ,le.regexpdate_in_CUSTOM_ErrorCount
          ,le.titlenum_ALLOW_ErrorCount
          ,le.stprimuse_ALLOW_ErrorCount
          ,le.titlestatus_ALLOW_ErrorCount
          ,le.vessel_ALLOW_ErrorCount
          ,le.specreg_ALLOW_ErrorCount
          ,le.ccwpermnum_ALLOW_ErrorCount
          ,le.ccwweapontype_ALLOW_ErrorCount
          ,le.ccwregdate_in_CUSTOM_ErrorCount
          ,le.ccwexpdate_in_CUSTOM_ErrorCount
          ,le.ccwpermtype_ALLOW_ErrorCount
          ,le.dob_str_CUSTOM_ErrorCount
          ,le.regdate_CUSTOM_ErrorCount
          ,le.dateofcontr_CUSTOM_ErrorCount
          ,le.lastdayvote_CUSTOM_ErrorCount
          ,le.datelicense_CUSTOM_ErrorCount
          ,le.regexpdate_CUSTOM_ErrorCount
          ,le.ccwregdate_CUSTOM_ErrorCount
          ,le.ccwexpdate_CUSTOM_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.score_on_input_ALLOW_ErrorCount
          ,le.append_prep_resaddress1_ALLOW_ErrorCount
          ,le.append_prep_resaddress2_ALLOW_ErrorCount
          ,le.append_resrawaid_ALLOW_ErrorCount
          ,le.append_prep_mailaddress1_ALLOW_ErrorCount
          ,le.append_prep_mailaddress2_ALLOW_ErrorCount
          ,le.append_mailrawaid_ALLOW_ErrorCount
          ,le.append_prep_cassaddress1_ALLOW_ErrorCount
          ,le.append_prep_cassaddress2_ALLOW_ErrorCount
          ,le.append_cassrawaid_ALLOW_ErrorCount
          ,le.aid_resclean_prim_range_ALLOW_ErrorCount
          ,le.aid_resclean_predir_ALLOW_ErrorCount
          ,le.aid_resclean_prim_name_ALLOW_ErrorCount
          ,le.aid_resclean_addr_suffix_ALLOW_ErrorCount
          ,le.aid_resclean_postdir_ALLOW_ErrorCount
          ,le.aid_resclean_unit_desig_ALLOW_ErrorCount
          ,le.aid_resclean_sec_range_ALLOW_ErrorCount
          ,le.aid_resclean_p_city_name_ALLOW_ErrorCount
          ,le.aid_resclean_v_city_name_ALLOW_ErrorCount
          ,le.aid_resclean_st_ALLOW_ErrorCount,le.aid_resclean_st_LENGTHS_ErrorCount
          ,le.aid_resclean_zip_ALLOW_ErrorCount,le.aid_resclean_zip_LENGTHS_ErrorCount
          ,le.aid_resclean_zip4_ALLOW_ErrorCount
          ,le.aid_resclean_cart_ALLOW_ErrorCount
          ,le.aid_resclean_cr_sort_sz_ALLOW_ErrorCount
          ,le.aid_resclean_lot_ALLOW_ErrorCount
          ,le.aid_resclean_lot_order_ALLOW_ErrorCount
          ,le.aid_resclean_dpbc_ALLOW_ErrorCount
          ,le.aid_resclean_chk_digit_ALLOW_ErrorCount
          ,le.aid_resclean_record_type_ALLOW_ErrorCount
          ,le.aid_resclean_ace_fips_st_ALLOW_ErrorCount
          ,le.aid_resclean_fipscounty_ALLOW_ErrorCount
          ,le.aid_resclean_geo_lat_ALLOW_ErrorCount
          ,le.aid_resclean_geo_long_ALLOW_ErrorCount
          ,le.aid_resclean_msa_ALLOW_ErrorCount
          ,le.aid_resclean_geo_blk_ALLOW_ErrorCount
          ,le.aid_resclean_geo_match_ALLOW_ErrorCount
          ,le.aid_resclean_err_stat_ALLOW_ErrorCount
          ,le.aid_mailclean_prim_range_ALLOW_ErrorCount
          ,le.aid_mailclean_predir_ALLOW_ErrorCount
          ,le.aid_mailclean_prim_name_ALLOW_ErrorCount
          ,le.aid_mailclean_addr_suffix_ALLOW_ErrorCount
          ,le.aid_mailclean_postdir_ALLOW_ErrorCount
          ,le.aid_mailclean_unit_desig_ALLOW_ErrorCount
          ,le.aid_mailclean_sec_range_ALLOW_ErrorCount
          ,le.aid_mailclean_p_city_name_ALLOW_ErrorCount
          ,le.aid_mailclean_v_city_name_ALLOW_ErrorCount
          ,le.aid_mailclean_st_ALLOW_ErrorCount,le.aid_mailclean_st_LENGTHS_ErrorCount
          ,le.aid_mailclean_zip_ALLOW_ErrorCount,le.aid_mailclean_zip_LENGTHS_ErrorCount
          ,le.aid_mailclean_zip4_ALLOW_ErrorCount
          ,le.aid_mailclean_cart_ALLOW_ErrorCount
          ,le.aid_mailclean_cr_sort_sz_ALLOW_ErrorCount
          ,le.aid_mailclean_lot_ALLOW_ErrorCount
          ,le.aid_mailclean_lot_order_ALLOW_ErrorCount
          ,le.aid_mailclean_dpbc_ALLOW_ErrorCount
          ,le.aid_mailclean_chk_digit_ALLOW_ErrorCount
          ,le.aid_mailclean_record_type_ALLOW_ErrorCount
          ,le.aid_mailclean_ace_fips_st_ALLOW_ErrorCount
          ,le.aid_mailclean_fipscounty_ALLOW_ErrorCount
          ,le.aid_mailclean_geo_lat_ALLOW_ErrorCount
          ,le.aid_mailclean_geo_long_ALLOW_ErrorCount
          ,le.aid_mailclean_msa_ALLOW_ErrorCount
          ,le.aid_mailclean_geo_blk_ALLOW_ErrorCount
          ,le.aid_mailclean_geo_match_ALLOW_ErrorCount
          ,le.aid_mailclean_err_stat_ALLOW_ErrorCount
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
          ,le.mail_st_ALLOW_ErrorCount,le.mail_st_LENGTHS_ErrorCount
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
          ,le.cass_prim_range_ALLOW_ErrorCount
          ,le.cass_predir_ALLOW_ErrorCount
          ,le.cass_prim_name_ALLOW_ErrorCount
          ,le.cass_addr_suffix_ALLOW_ErrorCount
          ,le.cass_postdir_ALLOW_ErrorCount
          ,le.cass_unit_desig_ALLOW_ErrorCount
          ,le.cass_sec_range_ALLOW_ErrorCount
          ,le.cass_p_city_name_ALLOW_ErrorCount
          ,le.cass_v_city_name_ALLOW_ErrorCount
          ,le.cass_st_ALLOW_ErrorCount,le.cass_st_LENGTHS_ErrorCount
          ,le.cass_ace_zip_ALLOW_ErrorCount,le.cass_ace_zip_LENGTHS_ErrorCount
          ,le.cass_zip4_ALLOW_ErrorCount
          ,le.cass_cart_ALLOW_ErrorCount
          ,le.cass_cr_sort_sz_ALLOW_ErrorCount
          ,le.cass_lot_ALLOW_ErrorCount
          ,le.cass_lot_order_ALLOW_ErrorCount
          ,le.cass_dpbc_ALLOW_ErrorCount
          ,le.cass_chk_digit_ALLOW_ErrorCount
          ,le.cass_record_type_ALLOW_ErrorCount
          ,le.cass_ace_fips_st_ALLOW_ErrorCount
          ,le.cass_fipscounty_ALLOW_ErrorCount
          ,le.cass_geo_lat_ALLOW_ErrorCount
          ,le.cass_geo_long_ALLOW_ErrorCount
          ,le.cass_msa_ALLOW_ErrorCount
          ,le.cass_geo_blk_ALLOW_ErrorCount
          ,le.cass_geo_match_ALLOW_ErrorCount
          ,le.cass_err_stat_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := HVCCW_hygiene(PROJECT(h, HVCCW_Layout_eMerges));
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
          ,'append_seqnum:' + getFieldTypeText(h.append_seqnum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'dob_str_in:' + getFieldTypeText(h.dob_str_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'agecat:' + getFieldTypeText(h.agecat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'headhousehold:' + getFieldTypeText(h.headhousehold) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'place_of_birth:' + getFieldTypeText(h.place_of_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'occupation:' + getFieldTypeText(h.occupation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'maiden_name:' + getFieldTypeText(h.maiden_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'motorvoterid:' + getFieldTypeText(h.motorvoterid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regsource:' + getFieldTypeText(h.regsource) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regdate_in:' + getFieldTypeText(h.regdate_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'dateofcontr_in:' + getFieldTypeText(h.dateofcontr_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'lastdayvote_in:' + getFieldTypeText(h.lastdayvote_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'historyfiller:' + getFieldTypeText(h.historyfiller) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'huntfishperm:' + getFieldTypeText(h.huntfishperm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'datelicense_in:' + getFieldTypeText(h.datelicense_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'boatindexnum:' + getFieldTypeText(h.boatindexnum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'boatcoowner:' + getFieldTypeText(h.boatcoowner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hullidnum:' + getFieldTypeText(h.hullidnum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'yearmade:' + getFieldTypeText(h.yearmade) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model:' + getFieldTypeText(h.model) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'manufacturer:' + getFieldTypeText(h.manufacturer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lengt:' + getFieldTypeText(h.lengt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hullconstruct:' + getFieldTypeText(h.hullconstruct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primuse:' + getFieldTypeText(h.primuse) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fueltype:' + getFieldTypeText(h.fueltype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'propulsion:' + getFieldTypeText(h.propulsion) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'modeltype:' + getFieldTypeText(h.modeltype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regexpdate_in:' + getFieldTypeText(h.regexpdate_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'titlenum:' + getFieldTypeText(h.titlenum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stprimuse:' + getFieldTypeText(h.stprimuse) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'titlestatus:' + getFieldTypeText(h.titlestatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vessel:' + getFieldTypeText(h.vessel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'specreg:' + getFieldTypeText(h.specreg) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'boatfill1:' + getFieldTypeText(h.boatfill1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'boatfill2:' + getFieldTypeText(h.boatfill2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'boatfill3:' + getFieldTypeText(h.boatfill3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwpermnum:' + getFieldTypeText(h.ccwpermnum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwweapontype:' + getFieldTypeText(h.ccwweapontype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwregdate_in:' + getFieldTypeText(h.ccwregdate_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwexpdate_in:' + getFieldTypeText(h.ccwexpdate_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwpermtype:' + getFieldTypeText(h.ccwpermtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwfill1:' + getFieldTypeText(h.ccwfill1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwfill2:' + getFieldTypeText(h.ccwfill2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwfill3:' + getFieldTypeText(h.ccwfill3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwfill4:' + getFieldTypeText(h.ccwfill4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'miscfill1:' + getFieldTypeText(h.miscfill1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'miscfill2:' + getFieldTypeText(h.miscfill2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'miscfill3:' + getFieldTypeText(h.miscfill3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'miscfill4:' + getFieldTypeText(h.miscfill4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'miscfill5:' + getFieldTypeText(h.miscfill5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fillerother1:' + getFieldTypeText(h.fillerother1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fillerother2:' + getFieldTypeText(h.fillerother2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fillerother3:' + getFieldTypeText(h.fillerother3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fillerother4:' + getFieldTypeText(h.fillerother4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fillerother5:' + getFieldTypeText(h.fillerother5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fillerother6:' + getFieldTypeText(h.fillerother6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fillerother7:' + getFieldTypeText(h.fillerother7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fillerother8:' + getFieldTypeText(h.fillerother8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fillerother9:' + getFieldTypeText(h.fillerother9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fillerother10:' + getFieldTypeText(h.fillerother10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eor:' + getFieldTypeText(h.eor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stuff:' + getFieldTypeText(h.stuff) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob_str:' + getFieldTypeText(h.dob_str) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regdate:' + getFieldTypeText(h.regdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateofcontr:' + getFieldTypeText(h.dateofcontr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastdayvote:' + getFieldTypeText(h.lastdayvote) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'datelicense:' + getFieldTypeText(h.datelicense) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regexpdate:' + getFieldTypeText(h.regexpdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwregdate:' + getFieldTypeText(h.ccwregdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccwexpdate:' + getFieldTypeText(h.ccwexpdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'score_on_input:' + getFieldTypeText(h.score_on_input) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_prep_resaddress1:' + getFieldTypeText(h.append_prep_resaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_prep_resaddress2:' + getFieldTypeText(h.append_prep_resaddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_resrawaid:' + getFieldTypeText(h.append_resrawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_prep_mailaddress1:' + getFieldTypeText(h.append_prep_mailaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_prep_mailaddress2:' + getFieldTypeText(h.append_prep_mailaddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_mailrawaid:' + getFieldTypeText(h.append_mailrawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_prep_cassaddress1:' + getFieldTypeText(h.append_prep_cassaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_prep_cassaddress2:' + getFieldTypeText(h.append_prep_cassaddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_cassrawaid:' + getFieldTypeText(h.append_cassrawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_prim_range:' + getFieldTypeText(h.aid_resclean_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_predir:' + getFieldTypeText(h.aid_resclean_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_prim_name:' + getFieldTypeText(h.aid_resclean_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_addr_suffix:' + getFieldTypeText(h.aid_resclean_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_postdir:' + getFieldTypeText(h.aid_resclean_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_unit_desig:' + getFieldTypeText(h.aid_resclean_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_sec_range:' + getFieldTypeText(h.aid_resclean_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_p_city_name:' + getFieldTypeText(h.aid_resclean_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_v_city_name:' + getFieldTypeText(h.aid_resclean_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_st:' + getFieldTypeText(h.aid_resclean_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_zip:' + getFieldTypeText(h.aid_resclean_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_zip4:' + getFieldTypeText(h.aid_resclean_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_cart:' + getFieldTypeText(h.aid_resclean_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_cr_sort_sz:' + getFieldTypeText(h.aid_resclean_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_lot:' + getFieldTypeText(h.aid_resclean_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_lot_order:' + getFieldTypeText(h.aid_resclean_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_dpbc:' + getFieldTypeText(h.aid_resclean_dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_chk_digit:' + getFieldTypeText(h.aid_resclean_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_record_type:' + getFieldTypeText(h.aid_resclean_record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_ace_fips_st:' + getFieldTypeText(h.aid_resclean_ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_fipscounty:' + getFieldTypeText(h.aid_resclean_fipscounty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_geo_lat:' + getFieldTypeText(h.aid_resclean_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_geo_long:' + getFieldTypeText(h.aid_resclean_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_msa:' + getFieldTypeText(h.aid_resclean_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_geo_blk:' + getFieldTypeText(h.aid_resclean_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_geo_match:' + getFieldTypeText(h.aid_resclean_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_resclean_err_stat:' + getFieldTypeText(h.aid_resclean_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_prim_range:' + getFieldTypeText(h.aid_mailclean_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_predir:' + getFieldTypeText(h.aid_mailclean_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_prim_name:' + getFieldTypeText(h.aid_mailclean_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_addr_suffix:' + getFieldTypeText(h.aid_mailclean_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_postdir:' + getFieldTypeText(h.aid_mailclean_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_unit_desig:' + getFieldTypeText(h.aid_mailclean_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_sec_range:' + getFieldTypeText(h.aid_mailclean_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_p_city_name:' + getFieldTypeText(h.aid_mailclean_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_v_city_name:' + getFieldTypeText(h.aid_mailclean_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_st:' + getFieldTypeText(h.aid_mailclean_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_zip:' + getFieldTypeText(h.aid_mailclean_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_zip4:' + getFieldTypeText(h.aid_mailclean_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_cart:' + getFieldTypeText(h.aid_mailclean_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_cr_sort_sz:' + getFieldTypeText(h.aid_mailclean_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_lot:' + getFieldTypeText(h.aid_mailclean_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_lot_order:' + getFieldTypeText(h.aid_mailclean_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_dpbc:' + getFieldTypeText(h.aid_mailclean_dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_chk_digit:' + getFieldTypeText(h.aid_mailclean_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_record_type:' + getFieldTypeText(h.aid_mailclean_record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_ace_fips_st:' + getFieldTypeText(h.aid_mailclean_ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_fipscounty:' + getFieldTypeText(h.aid_mailclean_fipscounty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_geo_lat:' + getFieldTypeText(h.aid_mailclean_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_geo_long:' + getFieldTypeText(h.aid_mailclean_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_msa:' + getFieldTypeText(h.aid_mailclean_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_geo_blk:' + getFieldTypeText(h.aid_mailclean_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_geo_match:' + getFieldTypeText(h.aid_mailclean_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_mailclean_err_stat:' + getFieldTypeText(h.aid_mailclean_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'mail_err_stat:' + getFieldTypeText(h.mail_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_prim_range:' + getFieldTypeText(h.cass_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_predir:' + getFieldTypeText(h.cass_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_prim_name:' + getFieldTypeText(h.cass_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_addr_suffix:' + getFieldTypeText(h.cass_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_postdir:' + getFieldTypeText(h.cass_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_unit_desig:' + getFieldTypeText(h.cass_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_sec_range:' + getFieldTypeText(h.cass_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_p_city_name:' + getFieldTypeText(h.cass_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_v_city_name:' + getFieldTypeText(h.cass_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_st:' + getFieldTypeText(h.cass_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_ace_zip:' + getFieldTypeText(h.cass_ace_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_zip4:' + getFieldTypeText(h.cass_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_cart:' + getFieldTypeText(h.cass_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_cr_sort_sz:' + getFieldTypeText(h.cass_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_lot:' + getFieldTypeText(h.cass_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_lot_order:' + getFieldTypeText(h.cass_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_dpbc:' + getFieldTypeText(h.cass_dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_chk_digit:' + getFieldTypeText(h.cass_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_record_type:' + getFieldTypeText(h.cass_record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_ace_fips_st:' + getFieldTypeText(h.cass_ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_fipscounty:' + getFieldTypeText(h.cass_fipscounty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_geo_lat:' + getFieldTypeText(h.cass_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_geo_long:' + getFieldTypeText(h.cass_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_msa:' + getFieldTypeText(h.cass_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_geo_blk:' + getFieldTypeText(h.cass_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_geo_match:' + getFieldTypeText(h.cass_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cass_err_stat:' + getFieldTypeText(h.cass_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_append_seqnum_cnt
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
          ,le.populated_dob_str_in_cnt
          ,le.populated_agecat_cnt
          ,le.populated_headhousehold_cnt
          ,le.populated_place_of_birth_cnt
          ,le.populated_occupation_cnt
          ,le.populated_maiden_name_cnt
          ,le.populated_motorvoterid_cnt
          ,le.populated_regsource_cnt
          ,le.populated_regdate_in_cnt
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
          ,le.populated_dateofcontr_in_cnt
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
          ,le.populated_lastdayvote_in_cnt
          ,le.populated_historyfiller_cnt
          ,le.populated_huntfishperm_cnt
          ,le.populated_datelicense_in_cnt
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
          ,le.populated_boatindexnum_cnt
          ,le.populated_boatcoowner_cnt
          ,le.populated_hullidnum_cnt
          ,le.populated_yearmade_cnt
          ,le.populated_model_cnt
          ,le.populated_manufacturer_cnt
          ,le.populated_lengt_cnt
          ,le.populated_hullconstruct_cnt
          ,le.populated_primuse_cnt
          ,le.populated_fueltype_cnt
          ,le.populated_propulsion_cnt
          ,le.populated_modeltype_cnt
          ,le.populated_regexpdate_in_cnt
          ,le.populated_titlenum_cnt
          ,le.populated_stprimuse_cnt
          ,le.populated_titlestatus_cnt
          ,le.populated_vessel_cnt
          ,le.populated_specreg_cnt
          ,le.populated_boatfill1_cnt
          ,le.populated_boatfill2_cnt
          ,le.populated_boatfill3_cnt
          ,le.populated_ccwpermnum_cnt
          ,le.populated_ccwweapontype_cnt
          ,le.populated_ccwregdate_in_cnt
          ,le.populated_ccwexpdate_in_cnt
          ,le.populated_ccwpermtype_cnt
          ,le.populated_ccwfill1_cnt
          ,le.populated_ccwfill2_cnt
          ,le.populated_ccwfill3_cnt
          ,le.populated_ccwfill4_cnt
          ,le.populated_miscfill1_cnt
          ,le.populated_miscfill2_cnt
          ,le.populated_miscfill3_cnt
          ,le.populated_miscfill4_cnt
          ,le.populated_miscfill5_cnt
          ,le.populated_fillerother1_cnt
          ,le.populated_fillerother2_cnt
          ,le.populated_fillerother3_cnt
          ,le.populated_fillerother4_cnt
          ,le.populated_fillerother5_cnt
          ,le.populated_fillerother6_cnt
          ,le.populated_fillerother7_cnt
          ,le.populated_fillerother8_cnt
          ,le.populated_fillerother9_cnt
          ,le.populated_fillerother10_cnt
          ,le.populated_eor_cnt
          ,le.populated_stuff_cnt
          ,le.populated_dob_str_cnt
          ,le.populated_regdate_cnt
          ,le.populated_dateofcontr_cnt
          ,le.populated_lastdayvote_cnt
          ,le.populated_datelicense_cnt
          ,le.populated_regexpdate_cnt
          ,le.populated_ccwregdate_cnt
          ,le.populated_ccwexpdate_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_score_on_input_cnt
          ,le.populated_append_prep_resaddress1_cnt
          ,le.populated_append_prep_resaddress2_cnt
          ,le.populated_append_resrawaid_cnt
          ,le.populated_append_prep_mailaddress1_cnt
          ,le.populated_append_prep_mailaddress2_cnt
          ,le.populated_append_mailrawaid_cnt
          ,le.populated_append_prep_cassaddress1_cnt
          ,le.populated_append_prep_cassaddress2_cnt
          ,le.populated_append_cassrawaid_cnt
          ,le.populated_aid_resclean_prim_range_cnt
          ,le.populated_aid_resclean_predir_cnt
          ,le.populated_aid_resclean_prim_name_cnt
          ,le.populated_aid_resclean_addr_suffix_cnt
          ,le.populated_aid_resclean_postdir_cnt
          ,le.populated_aid_resclean_unit_desig_cnt
          ,le.populated_aid_resclean_sec_range_cnt
          ,le.populated_aid_resclean_p_city_name_cnt
          ,le.populated_aid_resclean_v_city_name_cnt
          ,le.populated_aid_resclean_st_cnt
          ,le.populated_aid_resclean_zip_cnt
          ,le.populated_aid_resclean_zip4_cnt
          ,le.populated_aid_resclean_cart_cnt
          ,le.populated_aid_resclean_cr_sort_sz_cnt
          ,le.populated_aid_resclean_lot_cnt
          ,le.populated_aid_resclean_lot_order_cnt
          ,le.populated_aid_resclean_dpbc_cnt
          ,le.populated_aid_resclean_chk_digit_cnt
          ,le.populated_aid_resclean_record_type_cnt
          ,le.populated_aid_resclean_ace_fips_st_cnt
          ,le.populated_aid_resclean_fipscounty_cnt
          ,le.populated_aid_resclean_geo_lat_cnt
          ,le.populated_aid_resclean_geo_long_cnt
          ,le.populated_aid_resclean_msa_cnt
          ,le.populated_aid_resclean_geo_blk_cnt
          ,le.populated_aid_resclean_geo_match_cnt
          ,le.populated_aid_resclean_err_stat_cnt
          ,le.populated_aid_mailclean_prim_range_cnt
          ,le.populated_aid_mailclean_predir_cnt
          ,le.populated_aid_mailclean_prim_name_cnt
          ,le.populated_aid_mailclean_addr_suffix_cnt
          ,le.populated_aid_mailclean_postdir_cnt
          ,le.populated_aid_mailclean_unit_desig_cnt
          ,le.populated_aid_mailclean_sec_range_cnt
          ,le.populated_aid_mailclean_p_city_name_cnt
          ,le.populated_aid_mailclean_v_city_name_cnt
          ,le.populated_aid_mailclean_st_cnt
          ,le.populated_aid_mailclean_zip_cnt
          ,le.populated_aid_mailclean_zip4_cnt
          ,le.populated_aid_mailclean_cart_cnt
          ,le.populated_aid_mailclean_cr_sort_sz_cnt
          ,le.populated_aid_mailclean_lot_cnt
          ,le.populated_aid_mailclean_lot_order_cnt
          ,le.populated_aid_mailclean_dpbc_cnt
          ,le.populated_aid_mailclean_chk_digit_cnt
          ,le.populated_aid_mailclean_record_type_cnt
          ,le.populated_aid_mailclean_ace_fips_st_cnt
          ,le.populated_aid_mailclean_fipscounty_cnt
          ,le.populated_aid_mailclean_geo_lat_cnt
          ,le.populated_aid_mailclean_geo_long_cnt
          ,le.populated_aid_mailclean_msa_cnt
          ,le.populated_aid_mailclean_geo_blk_cnt
          ,le.populated_aid_mailclean_geo_match_cnt
          ,le.populated_aid_mailclean_err_stat_cnt
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
          ,le.populated_mail_err_stat_cnt
          ,le.populated_cass_prim_range_cnt
          ,le.populated_cass_predir_cnt
          ,le.populated_cass_prim_name_cnt
          ,le.populated_cass_addr_suffix_cnt
          ,le.populated_cass_postdir_cnt
          ,le.populated_cass_unit_desig_cnt
          ,le.populated_cass_sec_range_cnt
          ,le.populated_cass_p_city_name_cnt
          ,le.populated_cass_v_city_name_cnt
          ,le.populated_cass_st_cnt
          ,le.populated_cass_ace_zip_cnt
          ,le.populated_cass_zip4_cnt
          ,le.populated_cass_cart_cnt
          ,le.populated_cass_cr_sort_sz_cnt
          ,le.populated_cass_lot_cnt
          ,le.populated_cass_lot_order_cnt
          ,le.populated_cass_dpbc_cnt
          ,le.populated_cass_chk_digit_cnt
          ,le.populated_cass_record_type_cnt
          ,le.populated_cass_ace_fips_st_cnt
          ,le.populated_cass_fipscounty_cnt
          ,le.populated_cass_geo_lat_cnt
          ,le.populated_cass_geo_long_cnt
          ,le.populated_cass_msa_cnt
          ,le.populated_cass_geo_blk_cnt
          ,le.populated_cass_geo_match_cnt
          ,le.populated_cass_err_stat_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_append_seqnum_pcnt
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
          ,le.populated_dob_str_in_pcnt
          ,le.populated_agecat_pcnt
          ,le.populated_headhousehold_pcnt
          ,le.populated_place_of_birth_pcnt
          ,le.populated_occupation_pcnt
          ,le.populated_maiden_name_pcnt
          ,le.populated_motorvoterid_pcnt
          ,le.populated_regsource_pcnt
          ,le.populated_regdate_in_pcnt
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
          ,le.populated_dateofcontr_in_pcnt
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
          ,le.populated_lastdayvote_in_pcnt
          ,le.populated_historyfiller_pcnt
          ,le.populated_huntfishperm_pcnt
          ,le.populated_datelicense_in_pcnt
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
          ,le.populated_boatindexnum_pcnt
          ,le.populated_boatcoowner_pcnt
          ,le.populated_hullidnum_pcnt
          ,le.populated_yearmade_pcnt
          ,le.populated_model_pcnt
          ,le.populated_manufacturer_pcnt
          ,le.populated_lengt_pcnt
          ,le.populated_hullconstruct_pcnt
          ,le.populated_primuse_pcnt
          ,le.populated_fueltype_pcnt
          ,le.populated_propulsion_pcnt
          ,le.populated_modeltype_pcnt
          ,le.populated_regexpdate_in_pcnt
          ,le.populated_titlenum_pcnt
          ,le.populated_stprimuse_pcnt
          ,le.populated_titlestatus_pcnt
          ,le.populated_vessel_pcnt
          ,le.populated_specreg_pcnt
          ,le.populated_boatfill1_pcnt
          ,le.populated_boatfill2_pcnt
          ,le.populated_boatfill3_pcnt
          ,le.populated_ccwpermnum_pcnt
          ,le.populated_ccwweapontype_pcnt
          ,le.populated_ccwregdate_in_pcnt
          ,le.populated_ccwexpdate_in_pcnt
          ,le.populated_ccwpermtype_pcnt
          ,le.populated_ccwfill1_pcnt
          ,le.populated_ccwfill2_pcnt
          ,le.populated_ccwfill3_pcnt
          ,le.populated_ccwfill4_pcnt
          ,le.populated_miscfill1_pcnt
          ,le.populated_miscfill2_pcnt
          ,le.populated_miscfill3_pcnt
          ,le.populated_miscfill4_pcnt
          ,le.populated_miscfill5_pcnt
          ,le.populated_fillerother1_pcnt
          ,le.populated_fillerother2_pcnt
          ,le.populated_fillerother3_pcnt
          ,le.populated_fillerother4_pcnt
          ,le.populated_fillerother5_pcnt
          ,le.populated_fillerother6_pcnt
          ,le.populated_fillerother7_pcnt
          ,le.populated_fillerother8_pcnt
          ,le.populated_fillerother9_pcnt
          ,le.populated_fillerother10_pcnt
          ,le.populated_eor_pcnt
          ,le.populated_stuff_pcnt
          ,le.populated_dob_str_pcnt
          ,le.populated_regdate_pcnt
          ,le.populated_dateofcontr_pcnt
          ,le.populated_lastdayvote_pcnt
          ,le.populated_datelicense_pcnt
          ,le.populated_regexpdate_pcnt
          ,le.populated_ccwregdate_pcnt
          ,le.populated_ccwexpdate_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_score_on_input_pcnt
          ,le.populated_append_prep_resaddress1_pcnt
          ,le.populated_append_prep_resaddress2_pcnt
          ,le.populated_append_resrawaid_pcnt
          ,le.populated_append_prep_mailaddress1_pcnt
          ,le.populated_append_prep_mailaddress2_pcnt
          ,le.populated_append_mailrawaid_pcnt
          ,le.populated_append_prep_cassaddress1_pcnt
          ,le.populated_append_prep_cassaddress2_pcnt
          ,le.populated_append_cassrawaid_pcnt
          ,le.populated_aid_resclean_prim_range_pcnt
          ,le.populated_aid_resclean_predir_pcnt
          ,le.populated_aid_resclean_prim_name_pcnt
          ,le.populated_aid_resclean_addr_suffix_pcnt
          ,le.populated_aid_resclean_postdir_pcnt
          ,le.populated_aid_resclean_unit_desig_pcnt
          ,le.populated_aid_resclean_sec_range_pcnt
          ,le.populated_aid_resclean_p_city_name_pcnt
          ,le.populated_aid_resclean_v_city_name_pcnt
          ,le.populated_aid_resclean_st_pcnt
          ,le.populated_aid_resclean_zip_pcnt
          ,le.populated_aid_resclean_zip4_pcnt
          ,le.populated_aid_resclean_cart_pcnt
          ,le.populated_aid_resclean_cr_sort_sz_pcnt
          ,le.populated_aid_resclean_lot_pcnt
          ,le.populated_aid_resclean_lot_order_pcnt
          ,le.populated_aid_resclean_dpbc_pcnt
          ,le.populated_aid_resclean_chk_digit_pcnt
          ,le.populated_aid_resclean_record_type_pcnt
          ,le.populated_aid_resclean_ace_fips_st_pcnt
          ,le.populated_aid_resclean_fipscounty_pcnt
          ,le.populated_aid_resclean_geo_lat_pcnt
          ,le.populated_aid_resclean_geo_long_pcnt
          ,le.populated_aid_resclean_msa_pcnt
          ,le.populated_aid_resclean_geo_blk_pcnt
          ,le.populated_aid_resclean_geo_match_pcnt
          ,le.populated_aid_resclean_err_stat_pcnt
          ,le.populated_aid_mailclean_prim_range_pcnt
          ,le.populated_aid_mailclean_predir_pcnt
          ,le.populated_aid_mailclean_prim_name_pcnt
          ,le.populated_aid_mailclean_addr_suffix_pcnt
          ,le.populated_aid_mailclean_postdir_pcnt
          ,le.populated_aid_mailclean_unit_desig_pcnt
          ,le.populated_aid_mailclean_sec_range_pcnt
          ,le.populated_aid_mailclean_p_city_name_pcnt
          ,le.populated_aid_mailclean_v_city_name_pcnt
          ,le.populated_aid_mailclean_st_pcnt
          ,le.populated_aid_mailclean_zip_pcnt
          ,le.populated_aid_mailclean_zip4_pcnt
          ,le.populated_aid_mailclean_cart_pcnt
          ,le.populated_aid_mailclean_cr_sort_sz_pcnt
          ,le.populated_aid_mailclean_lot_pcnt
          ,le.populated_aid_mailclean_lot_order_pcnt
          ,le.populated_aid_mailclean_dpbc_pcnt
          ,le.populated_aid_mailclean_chk_digit_pcnt
          ,le.populated_aid_mailclean_record_type_pcnt
          ,le.populated_aid_mailclean_ace_fips_st_pcnt
          ,le.populated_aid_mailclean_fipscounty_pcnt
          ,le.populated_aid_mailclean_geo_lat_pcnt
          ,le.populated_aid_mailclean_geo_long_pcnt
          ,le.populated_aid_mailclean_msa_pcnt
          ,le.populated_aid_mailclean_geo_blk_pcnt
          ,le.populated_aid_mailclean_geo_match_pcnt
          ,le.populated_aid_mailclean_err_stat_pcnt
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
          ,le.populated_mail_err_stat_pcnt
          ,le.populated_cass_prim_range_pcnt
          ,le.populated_cass_predir_pcnt
          ,le.populated_cass_prim_name_pcnt
          ,le.populated_cass_addr_suffix_pcnt
          ,le.populated_cass_postdir_pcnt
          ,le.populated_cass_unit_desig_pcnt
          ,le.populated_cass_sec_range_pcnt
          ,le.populated_cass_p_city_name_pcnt
          ,le.populated_cass_v_city_name_pcnt
          ,le.populated_cass_st_pcnt
          ,le.populated_cass_ace_zip_pcnt
          ,le.populated_cass_zip4_pcnt
          ,le.populated_cass_cart_pcnt
          ,le.populated_cass_cr_sort_sz_pcnt
          ,le.populated_cass_lot_pcnt
          ,le.populated_cass_lot_order_pcnt
          ,le.populated_cass_dpbc_pcnt
          ,le.populated_cass_chk_digit_pcnt
          ,le.populated_cass_record_type_pcnt
          ,le.populated_cass_ace_fips_st_pcnt
          ,le.populated_cass_fipscounty_pcnt
          ,le.populated_cass_geo_lat_pcnt
          ,le.populated_cass_geo_long_pcnt
          ,le.populated_cass_msa_pcnt
          ,le.populated_cass_geo_blk_pcnt
          ,le.populated_cass_geo_match_pcnt
          ,le.populated_cass_err_stat_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,428,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := HVCCW_Delta(prevDS, PROJECT(h, HVCCW_Layout_eMerges));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),428,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(HVCCW_Layout_eMerges) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_eMerges, HVCCW_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 111;
  EXPORT NumRulesFromFieldType := 111;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 109;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_LaborActions_WHD)
    UNSIGNED1 dartid_Invalid;
    UNSIGNED1 dateadded_Invalid;
    UNSIGNED1 dateupdated_Invalid;
    UNSIGNED1 website_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 caseid_Invalid;
    UNSIGNED1 employername_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 employerstate_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 naicscode_Invalid;
    UNSIGNED1 totalviolations_Invalid;
    UNSIGNED1 bw_totalagreedamount_Invalid;
    UNSIGNED1 cmp_totalassessments_Invalid;
    UNSIGNED1 ee_totalviolations_Invalid;
    UNSIGNED1 ee_totalagreedcount_Invalid;
    UNSIGNED1 ca_countviolations_Invalid;
    UNSIGNED1 ca_bw_agreedamount_Invalid;
    UNSIGNED1 ca_ee_agreedcount_Invalid;
    UNSIGNED1 ccpa_countviolations_Invalid;
    UNSIGNED1 ccpa_bw_agreedamount_Invalid;
    UNSIGNED1 ccpa_ee_agreedcount_Invalid;
    UNSIGNED1 crew_countviolations_Invalid;
    UNSIGNED1 crew_bw_agreedamount_Invalid;
    UNSIGNED1 crew_cmp_assessedamount_Invalid;
    UNSIGNED1 crew_ee_agreedcount_Invalid;
    UNSIGNED1 cwhssa_countviolations_Invalid;
    UNSIGNED1 cwhssa_bw_agreedamount_Invalid;
    UNSIGNED1 cwhssa_ee_agreedcount_Invalid;
    UNSIGNED1 dbra_cl_countviolations_Invalid;
    UNSIGNED1 dbra_bw_agreedamount_Invalid;
    UNSIGNED1 dbra_ee_agreedcount_Invalid;
    UNSIGNED1 eev_countviolations_Invalid;
    UNSIGNED1 eppa_countviolations_Invalid;
    UNSIGNED1 eppa_bw_agreedamount_Invalid;
    UNSIGNED1 eppa_cmp_assessedamount_Invalid;
    UNSIGNED1 eppa_ee_agreedcount_Invalid;
    UNSIGNED1 flsa_countviolations_Invalid;
    UNSIGNED1 flsa_bw_15a3_agreedamount_Invalid;
    UNSIGNED1 flsa_bw_agreedamount_Invalid;
    UNSIGNED1 flsa_bw_minwage_agreedamount_Invalid;
    UNSIGNED1 flsa_bw_overtime_agreedamount_Invalid;
    UNSIGNED1 flsa_cmp_assessedamount_Invalid;
    UNSIGNED1 flsa_ee_agreedcount_Invalid;
    UNSIGNED1 flsa_cl_countviolations_Invalid;
    UNSIGNED1 flsa_cl_countminorsemployed_Invalid;
    UNSIGNED1 flsa_cl_cmp_assessedamount_Invalid;
    UNSIGNED1 flsa_hmwkr_countviolations_Invalid;
    UNSIGNED1 flsa_hmwkr_bw_agreedamount_Invalid;
    UNSIGNED1 flsa_hmwkr_cmp_assessedamount_Invalid;
    UNSIGNED1 flsa_hmwkr_ee_agreedcount_Invalid;
    UNSIGNED1 flsa_smw14_bw_agreedamount_Invalid;
    UNSIGNED1 flsa_smw14_countviolations_Invalid;
    UNSIGNED1 flsa_smw14_ee_agreedcount_Invalid;
    UNSIGNED1 flsa_smwap_countviolations_Invalid;
    UNSIGNED1 flsa_smwap_bw_agreedamount_Invalid;
    UNSIGNED1 flsa_smwap_ee_agreedcount_Invalid;
    UNSIGNED1 flsa_smwft_countviolations_Invalid;
    UNSIGNED1 flsa_smwft_bw_agreedamount_Invalid;
    UNSIGNED1 flsa_smwft_ee_agreedcount_Invalid;
    UNSIGNED1 flsa_smwl_countviolations_Invalid;
    UNSIGNED1 flsa_smwl_bw_agreedamount_Invalid;
    UNSIGNED1 flsa_smwl_ee_agreedcount_Invalid;
    UNSIGNED1 flsa_smwmg_countviolations_Invalid;
    UNSIGNED1 flsa_smwmg_bw_agreedamount_Invalid;
    UNSIGNED1 flsa_smwmg_ee_agreedcount_Invalid;
    UNSIGNED1 flsa_smwpw_countviolations_Invalid;
    UNSIGNED1 flsa_smwpw_bw_agreedamount_Invalid;
    UNSIGNED1 flsa_smwpw_ee_agreedcount_Invalid;
    UNSIGNED1 flsa_smwsl_countviolations_Invalid;
    UNSIGNED1 flsa_smwsl_bw_agreedamount_Invalid;
    UNSIGNED1 flsa_smwsl_ee_agreedcount_Invalid;
    UNSIGNED1 fmla_countviolations_Invalid;
    UNSIGNED1 fmla_bw_agreedamount_Invalid;
    UNSIGNED1 fmla_cmp_assessedamount_Invalid;
    UNSIGNED1 fmla_ee_agreedcount_Invalid;
    UNSIGNED1 h1a_countviolations_Invalid;
    UNSIGNED1 h1a_bw_agreedamount_Invalid;
    UNSIGNED1 h1a_cmp_assessedamount_Invalid;
    UNSIGNED1 h1a_ee_agreedcount_Invalid;
    UNSIGNED1 h1b_countviolations_Invalid;
    UNSIGNED1 h1b_bw_agreedamount_Invalid;
    UNSIGNED1 h1b_cmp_assessedamount_Invalid;
    UNSIGNED1 h1b_ee_agreedcount_Invalid;
    UNSIGNED1 h2a_countviolations_Invalid;
    UNSIGNED1 h2a_bw_agreedamount_Invalid;
    UNSIGNED1 h2a_cmp_assessedamount_Invalid;
    UNSIGNED1 h2a_ee_agreedcount_Invalid;
    UNSIGNED1 h2b_countviolations_Invalid;
    UNSIGNED1 h2b_bw_agreedamount_Invalid;
    UNSIGNED1 h2b_ee_agreedcount_Invalid;
    UNSIGNED1 mpsa_countviolations_Invalid;
    UNSIGNED1 mpsa_bw_agreedamount_Invalid;
    UNSIGNED1 mpsa_cmp_assessedamount_Invalid;
    UNSIGNED1 mpsa_ee_agreedcount_Invalid;
    UNSIGNED1 osha_countviolations_Invalid;
    UNSIGNED1 osha_bw_agreedamount_Invalid;
    UNSIGNED1 osha_cmp_assessedamount_Invalid;
    UNSIGNED1 osha_ee_agreedcount_Invalid;
    UNSIGNED1 pca_countviolations_Invalid;
    UNSIGNED1 pca_bw_agreedamount_Invalid;
    UNSIGNED1 pca_ee_agreedcount_Invalid;
    UNSIGNED1 sca_countviolations_Invalid;
    UNSIGNED1 sca_bw_agreedamount_Invalid;
    UNSIGNED1 sca_ee_agreedcount_Invalid;
    UNSIGNED1 sraw_countviolations_Invalid;
    UNSIGNED1 sraw_bw_agreedamount_Invalid;
    UNSIGNED1 sraw_ee_agreedcount_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_LaborActions_WHD)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
  EXPORT Rule_Layout := RECORD(Layout_LaborActions_WHD)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dartid:Invalid_No:CUSTOM'
          ,'dateadded:Invalid_Date:CUSTOM'
          ,'dateupdated:Invalid_Date:CUSTOM'
          ,'website:Invalid_Alpha:CUSTOM'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTHS'
          ,'caseid:Invalid_No:CUSTOM'
          ,'employername:Invalid_AlphaNumChar:CUSTOM'
          ,'address1:Invalid_AlphaNumChar:CUSTOM'
          ,'city:Invalid_AlphaChar:CUSTOM'
          ,'employerstate:Invalid_State:ALLOW','employerstate:Invalid_State:LENGTHS'
          ,'zipcode:Invalid_Zip:CUSTOM'
          ,'naicscode:Invalid_No:CUSTOM'
          ,'totalviolations:Invalid_No:CUSTOM'
          ,'bw_totalagreedamount:Invalid_Float:ALLOW'
          ,'cmp_totalassessments:Invalid_Float:ALLOW'
          ,'ee_totalviolations:Invalid_No:CUSTOM'
          ,'ee_totalagreedcount:Invalid_No:CUSTOM'
          ,'ca_countviolations:Invalid_No:CUSTOM'
          ,'ca_bw_agreedamount:Invalid_Float:ALLOW'
          ,'ca_ee_agreedcount:Invalid_No:CUSTOM'
          ,'ccpa_countviolations:Invalid_No:CUSTOM'
          ,'ccpa_bw_agreedamount:Invalid_Float:ALLOW'
          ,'ccpa_ee_agreedcount:Invalid_No:CUSTOM'
          ,'crew_countviolations:Invalid_No:CUSTOM'
          ,'crew_bw_agreedamount:Invalid_Float:ALLOW'
          ,'crew_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'crew_ee_agreedcount:Invalid_No:CUSTOM'
          ,'cwhssa_countviolations:Invalid_No:CUSTOM'
          ,'cwhssa_bw_agreedamount:Invalid_Float:ALLOW'
          ,'cwhssa_ee_agreedcount:Invalid_No:CUSTOM'
          ,'dbra_cl_countviolations:Invalid_No:CUSTOM'
          ,'dbra_bw_agreedamount:Invalid_Float:ALLOW'
          ,'dbra_ee_agreedcount:Invalid_No:CUSTOM'
          ,'eev_countviolations:Invalid_No:CUSTOM'
          ,'eppa_countviolations:Invalid_No:CUSTOM'
          ,'eppa_bw_agreedamount:Invalid_Float:ALLOW'
          ,'eppa_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'eppa_ee_agreedcount:Invalid_No:CUSTOM'
          ,'flsa_countviolations:Invalid_No:CUSTOM'
          ,'flsa_bw_15a3_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_bw_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_bw_minwage_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_bw_overtime_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'flsa_ee_agreedcount:Invalid_No:CUSTOM'
          ,'flsa_cl_countviolations:Invalid_No:CUSTOM'
          ,'flsa_cl_countminorsemployed:Invalid_No:CUSTOM'
          ,'flsa_cl_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'flsa_hmwkr_countviolations:Invalid_No:CUSTOM'
          ,'flsa_hmwkr_bw_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_hmwkr_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'flsa_hmwkr_ee_agreedcount:Invalid_No:CUSTOM'
          ,'flsa_smw14_bw_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_smw14_countviolations:Invalid_No:CUSTOM'
          ,'flsa_smw14_ee_agreedcount:Invalid_No:CUSTOM'
          ,'flsa_smwap_countviolations:Invalid_No:CUSTOM'
          ,'flsa_smwap_bw_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_smwap_ee_agreedcount:Invalid_No:CUSTOM'
          ,'flsa_smwft_countviolations:Invalid_No:CUSTOM'
          ,'flsa_smwft_bw_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_smwft_ee_agreedcount:Invalid_No:CUSTOM'
          ,'flsa_smwl_countviolations:Invalid_No:CUSTOM'
          ,'flsa_smwl_bw_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_smwl_ee_agreedcount:Invalid_No:CUSTOM'
          ,'flsa_smwmg_countviolations:Invalid_No:CUSTOM'
          ,'flsa_smwmg_bw_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_smwmg_ee_agreedcount:Invalid_No:CUSTOM'
          ,'flsa_smwpw_countviolations:Invalid_No:CUSTOM'
          ,'flsa_smwpw_bw_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_smwpw_ee_agreedcount:Invalid_No:CUSTOM'
          ,'flsa_smwsl_countviolations:Invalid_No:CUSTOM'
          ,'flsa_smwsl_bw_agreedamount:Invalid_Float:ALLOW'
          ,'flsa_smwsl_ee_agreedcount:Invalid_No:CUSTOM'
          ,'fmla_countviolations:Invalid_No:CUSTOM'
          ,'fmla_bw_agreedamount:Invalid_Float:ALLOW'
          ,'fmla_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'fmla_ee_agreedcount:Invalid_No:CUSTOM'
          ,'h1a_countviolations:Invalid_No:CUSTOM'
          ,'h1a_bw_agreedamount:Invalid_Float:ALLOW'
          ,'h1a_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'h1a_ee_agreedcount:Invalid_No:CUSTOM'
          ,'h1b_countviolations:Invalid_No:CUSTOM'
          ,'h1b_bw_agreedamount:Invalid_Float:ALLOW'
          ,'h1b_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'h1b_ee_agreedcount:Invalid_No:CUSTOM'
          ,'h2a_countviolations:Invalid_No:CUSTOM'
          ,'h2a_bw_agreedamount:Invalid_Float:ALLOW'
          ,'h2a_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'h2a_ee_agreedcount:Invalid_No:CUSTOM'
          ,'h2b_countviolations:Invalid_No:CUSTOM'
          ,'h2b_bw_agreedamount:Invalid_Float:ALLOW'
          ,'h2b_ee_agreedcount:Invalid_No:CUSTOM'
          ,'mpsa_countviolations:Invalid_No:CUSTOM'
          ,'mpsa_bw_agreedamount:Invalid_Float:ALLOW'
          ,'mpsa_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'mpsa_ee_agreedcount:Invalid_No:CUSTOM'
          ,'osha_countviolations:Invalid_No:CUSTOM'
          ,'osha_bw_agreedamount:Invalid_Float:ALLOW'
          ,'osha_cmp_assessedamount:Invalid_Float:ALLOW'
          ,'osha_ee_agreedcount:Invalid_No:CUSTOM'
          ,'pca_countviolations:Invalid_No:CUSTOM'
          ,'pca_bw_agreedamount:Invalid_Float:ALLOW'
          ,'pca_ee_agreedcount:Invalid_No:CUSTOM'
          ,'sca_countviolations:Invalid_No:CUSTOM'
          ,'sca_bw_agreedamount:Invalid_Float:ALLOW'
          ,'sca_ee_agreedcount:Invalid_No:CUSTOM'
          ,'sraw_countviolations:Invalid_No:CUSTOM'
          ,'sraw_bw_agreedamount:Invalid_Float:ALLOW'
          ,'sraw_ee_agreedcount:Invalid_No:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_dartid(1)
          ,Fields.InvalidMessage_dateadded(1)
          ,Fields.InvalidMessage_dateupdated(1)
          ,Fields.InvalidMessage_website(1)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_caseid(1)
          ,Fields.InvalidMessage_employername(1)
          ,Fields.InvalidMessage_address1(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_employerstate(1),Fields.InvalidMessage_employerstate(2)
          ,Fields.InvalidMessage_zipcode(1)
          ,Fields.InvalidMessage_naicscode(1)
          ,Fields.InvalidMessage_totalviolations(1)
          ,Fields.InvalidMessage_bw_totalagreedamount(1)
          ,Fields.InvalidMessage_cmp_totalassessments(1)
          ,Fields.InvalidMessage_ee_totalviolations(1)
          ,Fields.InvalidMessage_ee_totalagreedcount(1)
          ,Fields.InvalidMessage_ca_countviolations(1)
          ,Fields.InvalidMessage_ca_bw_agreedamount(1)
          ,Fields.InvalidMessage_ca_ee_agreedcount(1)
          ,Fields.InvalidMessage_ccpa_countviolations(1)
          ,Fields.InvalidMessage_ccpa_bw_agreedamount(1)
          ,Fields.InvalidMessage_ccpa_ee_agreedcount(1)
          ,Fields.InvalidMessage_crew_countviolations(1)
          ,Fields.InvalidMessage_crew_bw_agreedamount(1)
          ,Fields.InvalidMessage_crew_cmp_assessedamount(1)
          ,Fields.InvalidMessage_crew_ee_agreedcount(1)
          ,Fields.InvalidMessage_cwhssa_countviolations(1)
          ,Fields.InvalidMessage_cwhssa_bw_agreedamount(1)
          ,Fields.InvalidMessage_cwhssa_ee_agreedcount(1)
          ,Fields.InvalidMessage_dbra_cl_countviolations(1)
          ,Fields.InvalidMessage_dbra_bw_agreedamount(1)
          ,Fields.InvalidMessage_dbra_ee_agreedcount(1)
          ,Fields.InvalidMessage_eev_countviolations(1)
          ,Fields.InvalidMessage_eppa_countviolations(1)
          ,Fields.InvalidMessage_eppa_bw_agreedamount(1)
          ,Fields.InvalidMessage_eppa_cmp_assessedamount(1)
          ,Fields.InvalidMessage_eppa_ee_agreedcount(1)
          ,Fields.InvalidMessage_flsa_countviolations(1)
          ,Fields.InvalidMessage_flsa_bw_15a3_agreedamount(1)
          ,Fields.InvalidMessage_flsa_bw_agreedamount(1)
          ,Fields.InvalidMessage_flsa_bw_minwage_agreedamount(1)
          ,Fields.InvalidMessage_flsa_bw_overtime_agreedamount(1)
          ,Fields.InvalidMessage_flsa_cmp_assessedamount(1)
          ,Fields.InvalidMessage_flsa_ee_agreedcount(1)
          ,Fields.InvalidMessage_flsa_cl_countviolations(1)
          ,Fields.InvalidMessage_flsa_cl_countminorsemployed(1)
          ,Fields.InvalidMessage_flsa_cl_cmp_assessedamount(1)
          ,Fields.InvalidMessage_flsa_hmwkr_countviolations(1)
          ,Fields.InvalidMessage_flsa_hmwkr_bw_agreedamount(1)
          ,Fields.InvalidMessage_flsa_hmwkr_cmp_assessedamount(1)
          ,Fields.InvalidMessage_flsa_hmwkr_ee_agreedcount(1)
          ,Fields.InvalidMessage_flsa_smw14_bw_agreedamount(1)
          ,Fields.InvalidMessage_flsa_smw14_countviolations(1)
          ,Fields.InvalidMessage_flsa_smw14_ee_agreedcount(1)
          ,Fields.InvalidMessage_flsa_smwap_countviolations(1)
          ,Fields.InvalidMessage_flsa_smwap_bw_agreedamount(1)
          ,Fields.InvalidMessage_flsa_smwap_ee_agreedcount(1)
          ,Fields.InvalidMessage_flsa_smwft_countviolations(1)
          ,Fields.InvalidMessage_flsa_smwft_bw_agreedamount(1)
          ,Fields.InvalidMessage_flsa_smwft_ee_agreedcount(1)
          ,Fields.InvalidMessage_flsa_smwl_countviolations(1)
          ,Fields.InvalidMessage_flsa_smwl_bw_agreedamount(1)
          ,Fields.InvalidMessage_flsa_smwl_ee_agreedcount(1)
          ,Fields.InvalidMessage_flsa_smwmg_countviolations(1)
          ,Fields.InvalidMessage_flsa_smwmg_bw_agreedamount(1)
          ,Fields.InvalidMessage_flsa_smwmg_ee_agreedcount(1)
          ,Fields.InvalidMessage_flsa_smwpw_countviolations(1)
          ,Fields.InvalidMessage_flsa_smwpw_bw_agreedamount(1)
          ,Fields.InvalidMessage_flsa_smwpw_ee_agreedcount(1)
          ,Fields.InvalidMessage_flsa_smwsl_countviolations(1)
          ,Fields.InvalidMessage_flsa_smwsl_bw_agreedamount(1)
          ,Fields.InvalidMessage_flsa_smwsl_ee_agreedcount(1)
          ,Fields.InvalidMessage_fmla_countviolations(1)
          ,Fields.InvalidMessage_fmla_bw_agreedamount(1)
          ,Fields.InvalidMessage_fmla_cmp_assessedamount(1)
          ,Fields.InvalidMessage_fmla_ee_agreedcount(1)
          ,Fields.InvalidMessage_h1a_countviolations(1)
          ,Fields.InvalidMessage_h1a_bw_agreedamount(1)
          ,Fields.InvalidMessage_h1a_cmp_assessedamount(1)
          ,Fields.InvalidMessage_h1a_ee_agreedcount(1)
          ,Fields.InvalidMessage_h1b_countviolations(1)
          ,Fields.InvalidMessage_h1b_bw_agreedamount(1)
          ,Fields.InvalidMessage_h1b_cmp_assessedamount(1)
          ,Fields.InvalidMessage_h1b_ee_agreedcount(1)
          ,Fields.InvalidMessage_h2a_countviolations(1)
          ,Fields.InvalidMessage_h2a_bw_agreedamount(1)
          ,Fields.InvalidMessage_h2a_cmp_assessedamount(1)
          ,Fields.InvalidMessage_h2a_ee_agreedcount(1)
          ,Fields.InvalidMessage_h2b_countviolations(1)
          ,Fields.InvalidMessage_h2b_bw_agreedamount(1)
          ,Fields.InvalidMessage_h2b_ee_agreedcount(1)
          ,Fields.InvalidMessage_mpsa_countviolations(1)
          ,Fields.InvalidMessage_mpsa_bw_agreedamount(1)
          ,Fields.InvalidMessage_mpsa_cmp_assessedamount(1)
          ,Fields.InvalidMessage_mpsa_ee_agreedcount(1)
          ,Fields.InvalidMessage_osha_countviolations(1)
          ,Fields.InvalidMessage_osha_bw_agreedamount(1)
          ,Fields.InvalidMessage_osha_cmp_assessedamount(1)
          ,Fields.InvalidMessage_osha_ee_agreedcount(1)
          ,Fields.InvalidMessage_pca_countviolations(1)
          ,Fields.InvalidMessage_pca_bw_agreedamount(1)
          ,Fields.InvalidMessage_pca_ee_agreedcount(1)
          ,Fields.InvalidMessage_sca_countviolations(1)
          ,Fields.InvalidMessage_sca_bw_agreedamount(1)
          ,Fields.InvalidMessage_sca_ee_agreedcount(1)
          ,Fields.InvalidMessage_sraw_countviolations(1)
          ,Fields.InvalidMessage_sraw_bw_agreedamount(1)
          ,Fields.InvalidMessage_sraw_ee_agreedcount(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_LaborActions_WHD) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dartid_Invalid := Fields.InValid_dartid((SALT311.StrType)le.dartid);
    SELF.dateadded_Invalid := Fields.InValid_dateadded((SALT311.StrType)le.dateadded);
    SELF.dateupdated_Invalid := Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated);
    SELF.website_Invalid := Fields.InValid_website((SALT311.StrType)le.website);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.caseid_Invalid := Fields.InValid_caseid((SALT311.StrType)le.caseid);
    SELF.employername_Invalid := Fields.InValid_employername((SALT311.StrType)le.employername);
    SELF.address1_Invalid := Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    SELF.employerstate_Invalid := Fields.InValid_employerstate((SALT311.StrType)le.employerstate);
    SELF.zipcode_Invalid := Fields.InValid_zipcode((SALT311.StrType)le.zipcode);
    SELF.naicscode_Invalid := Fields.InValid_naicscode((SALT311.StrType)le.naicscode);
    SELF.totalviolations_Invalid := Fields.InValid_totalviolations((SALT311.StrType)le.totalviolations);
    SELF.bw_totalagreedamount_Invalid := Fields.InValid_bw_totalagreedamount((SALT311.StrType)le.bw_totalagreedamount);
    SELF.cmp_totalassessments_Invalid := Fields.InValid_cmp_totalassessments((SALT311.StrType)le.cmp_totalassessments);
    SELF.ee_totalviolations_Invalid := Fields.InValid_ee_totalviolations((SALT311.StrType)le.ee_totalviolations);
    SELF.ee_totalagreedcount_Invalid := Fields.InValid_ee_totalagreedcount((SALT311.StrType)le.ee_totalagreedcount);
    SELF.ca_countviolations_Invalid := Fields.InValid_ca_countviolations((SALT311.StrType)le.ca_countviolations);
    SELF.ca_bw_agreedamount_Invalid := Fields.InValid_ca_bw_agreedamount((SALT311.StrType)le.ca_bw_agreedamount);
    SELF.ca_ee_agreedcount_Invalid := Fields.InValid_ca_ee_agreedcount((SALT311.StrType)le.ca_ee_agreedcount);
    SELF.ccpa_countviolations_Invalid := Fields.InValid_ccpa_countviolations((SALT311.StrType)le.ccpa_countviolations);
    SELF.ccpa_bw_agreedamount_Invalid := Fields.InValid_ccpa_bw_agreedamount((SALT311.StrType)le.ccpa_bw_agreedamount);
    SELF.ccpa_ee_agreedcount_Invalid := Fields.InValid_ccpa_ee_agreedcount((SALT311.StrType)le.ccpa_ee_agreedcount);
    SELF.crew_countviolations_Invalid := Fields.InValid_crew_countviolations((SALT311.StrType)le.crew_countviolations);
    SELF.crew_bw_agreedamount_Invalid := Fields.InValid_crew_bw_agreedamount((SALT311.StrType)le.crew_bw_agreedamount);
    SELF.crew_cmp_assessedamount_Invalid := Fields.InValid_crew_cmp_assessedamount((SALT311.StrType)le.crew_cmp_assessedamount);
    SELF.crew_ee_agreedcount_Invalid := Fields.InValid_crew_ee_agreedcount((SALT311.StrType)le.crew_ee_agreedcount);
    SELF.cwhssa_countviolations_Invalid := Fields.InValid_cwhssa_countviolations((SALT311.StrType)le.cwhssa_countviolations);
    SELF.cwhssa_bw_agreedamount_Invalid := Fields.InValid_cwhssa_bw_agreedamount((SALT311.StrType)le.cwhssa_bw_agreedamount);
    SELF.cwhssa_ee_agreedcount_Invalid := Fields.InValid_cwhssa_ee_agreedcount((SALT311.StrType)le.cwhssa_ee_agreedcount);
    SELF.dbra_cl_countviolations_Invalid := Fields.InValid_dbra_cl_countviolations((SALT311.StrType)le.dbra_cl_countviolations);
    SELF.dbra_bw_agreedamount_Invalid := Fields.InValid_dbra_bw_agreedamount((SALT311.StrType)le.dbra_bw_agreedamount);
    SELF.dbra_ee_agreedcount_Invalid := Fields.InValid_dbra_ee_agreedcount((SALT311.StrType)le.dbra_ee_agreedcount);
    SELF.eev_countviolations_Invalid := Fields.InValid_eev_countviolations((SALT311.StrType)le.eev_countviolations);
    SELF.eppa_countviolations_Invalid := Fields.InValid_eppa_countviolations((SALT311.StrType)le.eppa_countviolations);
    SELF.eppa_bw_agreedamount_Invalid := Fields.InValid_eppa_bw_agreedamount((SALT311.StrType)le.eppa_bw_agreedamount);
    SELF.eppa_cmp_assessedamount_Invalid := Fields.InValid_eppa_cmp_assessedamount((SALT311.StrType)le.eppa_cmp_assessedamount);
    SELF.eppa_ee_agreedcount_Invalid := Fields.InValid_eppa_ee_agreedcount((SALT311.StrType)le.eppa_ee_agreedcount);
    SELF.flsa_countviolations_Invalid := Fields.InValid_flsa_countviolations((SALT311.StrType)le.flsa_countviolations);
    SELF.flsa_bw_15a3_agreedamount_Invalid := Fields.InValid_flsa_bw_15a3_agreedamount((SALT311.StrType)le.flsa_bw_15a3_agreedamount);
    SELF.flsa_bw_agreedamount_Invalid := Fields.InValid_flsa_bw_agreedamount((SALT311.StrType)le.flsa_bw_agreedamount);
    SELF.flsa_bw_minwage_agreedamount_Invalid := Fields.InValid_flsa_bw_minwage_agreedamount((SALT311.StrType)le.flsa_bw_minwage_agreedamount);
    SELF.flsa_bw_overtime_agreedamount_Invalid := Fields.InValid_flsa_bw_overtime_agreedamount((SALT311.StrType)le.flsa_bw_overtime_agreedamount);
    SELF.flsa_cmp_assessedamount_Invalid := Fields.InValid_flsa_cmp_assessedamount((SALT311.StrType)le.flsa_cmp_assessedamount);
    SELF.flsa_ee_agreedcount_Invalid := Fields.InValid_flsa_ee_agreedcount((SALT311.StrType)le.flsa_ee_agreedcount);
    SELF.flsa_cl_countviolations_Invalid := Fields.InValid_flsa_cl_countviolations((SALT311.StrType)le.flsa_cl_countviolations);
    SELF.flsa_cl_countminorsemployed_Invalid := Fields.InValid_flsa_cl_countminorsemployed((SALT311.StrType)le.flsa_cl_countminorsemployed);
    SELF.flsa_cl_cmp_assessedamount_Invalid := Fields.InValid_flsa_cl_cmp_assessedamount((SALT311.StrType)le.flsa_cl_cmp_assessedamount);
    SELF.flsa_hmwkr_countviolations_Invalid := Fields.InValid_flsa_hmwkr_countviolations((SALT311.StrType)le.flsa_hmwkr_countviolations);
    SELF.flsa_hmwkr_bw_agreedamount_Invalid := Fields.InValid_flsa_hmwkr_bw_agreedamount((SALT311.StrType)le.flsa_hmwkr_bw_agreedamount);
    SELF.flsa_hmwkr_cmp_assessedamount_Invalid := Fields.InValid_flsa_hmwkr_cmp_assessedamount((SALT311.StrType)le.flsa_hmwkr_cmp_assessedamount);
    SELF.flsa_hmwkr_ee_agreedcount_Invalid := Fields.InValid_flsa_hmwkr_ee_agreedcount((SALT311.StrType)le.flsa_hmwkr_ee_agreedcount);
    SELF.flsa_smw14_bw_agreedamount_Invalid := Fields.InValid_flsa_smw14_bw_agreedamount((SALT311.StrType)le.flsa_smw14_bw_agreedamount);
    SELF.flsa_smw14_countviolations_Invalid := Fields.InValid_flsa_smw14_countviolations((SALT311.StrType)le.flsa_smw14_countviolations);
    SELF.flsa_smw14_ee_agreedcount_Invalid := Fields.InValid_flsa_smw14_ee_agreedcount((SALT311.StrType)le.flsa_smw14_ee_agreedcount);
    SELF.flsa_smwap_countviolations_Invalid := Fields.InValid_flsa_smwap_countviolations((SALT311.StrType)le.flsa_smwap_countviolations);
    SELF.flsa_smwap_bw_agreedamount_Invalid := Fields.InValid_flsa_smwap_bw_agreedamount((SALT311.StrType)le.flsa_smwap_bw_agreedamount);
    SELF.flsa_smwap_ee_agreedcount_Invalid := Fields.InValid_flsa_smwap_ee_agreedcount((SALT311.StrType)le.flsa_smwap_ee_agreedcount);
    SELF.flsa_smwft_countviolations_Invalid := Fields.InValid_flsa_smwft_countviolations((SALT311.StrType)le.flsa_smwft_countviolations);
    SELF.flsa_smwft_bw_agreedamount_Invalid := Fields.InValid_flsa_smwft_bw_agreedamount((SALT311.StrType)le.flsa_smwft_bw_agreedamount);
    SELF.flsa_smwft_ee_agreedcount_Invalid := Fields.InValid_flsa_smwft_ee_agreedcount((SALT311.StrType)le.flsa_smwft_ee_agreedcount);
    SELF.flsa_smwl_countviolations_Invalid := Fields.InValid_flsa_smwl_countviolations((SALT311.StrType)le.flsa_smwl_countviolations);
    SELF.flsa_smwl_bw_agreedamount_Invalid := Fields.InValid_flsa_smwl_bw_agreedamount((SALT311.StrType)le.flsa_smwl_bw_agreedamount);
    SELF.flsa_smwl_ee_agreedcount_Invalid := Fields.InValid_flsa_smwl_ee_agreedcount((SALT311.StrType)le.flsa_smwl_ee_agreedcount);
    SELF.flsa_smwmg_countviolations_Invalid := Fields.InValid_flsa_smwmg_countviolations((SALT311.StrType)le.flsa_smwmg_countviolations);
    SELF.flsa_smwmg_bw_agreedamount_Invalid := Fields.InValid_flsa_smwmg_bw_agreedamount((SALT311.StrType)le.flsa_smwmg_bw_agreedamount);
    SELF.flsa_smwmg_ee_agreedcount_Invalid := Fields.InValid_flsa_smwmg_ee_agreedcount((SALT311.StrType)le.flsa_smwmg_ee_agreedcount);
    SELF.flsa_smwpw_countviolations_Invalid := Fields.InValid_flsa_smwpw_countviolations((SALT311.StrType)le.flsa_smwpw_countviolations);
    SELF.flsa_smwpw_bw_agreedamount_Invalid := Fields.InValid_flsa_smwpw_bw_agreedamount((SALT311.StrType)le.flsa_smwpw_bw_agreedamount);
    SELF.flsa_smwpw_ee_agreedcount_Invalid := Fields.InValid_flsa_smwpw_ee_agreedcount((SALT311.StrType)le.flsa_smwpw_ee_agreedcount);
    SELF.flsa_smwsl_countviolations_Invalid := Fields.InValid_flsa_smwsl_countviolations((SALT311.StrType)le.flsa_smwsl_countviolations);
    SELF.flsa_smwsl_bw_agreedamount_Invalid := Fields.InValid_flsa_smwsl_bw_agreedamount((SALT311.StrType)le.flsa_smwsl_bw_agreedamount);
    SELF.flsa_smwsl_ee_agreedcount_Invalid := Fields.InValid_flsa_smwsl_ee_agreedcount((SALT311.StrType)le.flsa_smwsl_ee_agreedcount);
    SELF.fmla_countviolations_Invalid := Fields.InValid_fmla_countviolations((SALT311.StrType)le.fmla_countviolations);
    SELF.fmla_bw_agreedamount_Invalid := Fields.InValid_fmla_bw_agreedamount((SALT311.StrType)le.fmla_bw_agreedamount);
    SELF.fmla_cmp_assessedamount_Invalid := Fields.InValid_fmla_cmp_assessedamount((SALT311.StrType)le.fmla_cmp_assessedamount);
    SELF.fmla_ee_agreedcount_Invalid := Fields.InValid_fmla_ee_agreedcount((SALT311.StrType)le.fmla_ee_agreedcount);
    SELF.h1a_countviolations_Invalid := Fields.InValid_h1a_countviolations((SALT311.StrType)le.h1a_countviolations);
    SELF.h1a_bw_agreedamount_Invalid := Fields.InValid_h1a_bw_agreedamount((SALT311.StrType)le.h1a_bw_agreedamount);
    SELF.h1a_cmp_assessedamount_Invalid := Fields.InValid_h1a_cmp_assessedamount((SALT311.StrType)le.h1a_cmp_assessedamount);
    SELF.h1a_ee_agreedcount_Invalid := Fields.InValid_h1a_ee_agreedcount((SALT311.StrType)le.h1a_ee_agreedcount);
    SELF.h1b_countviolations_Invalid := Fields.InValid_h1b_countviolations((SALT311.StrType)le.h1b_countviolations);
    SELF.h1b_bw_agreedamount_Invalid := Fields.InValid_h1b_bw_agreedamount((SALT311.StrType)le.h1b_bw_agreedamount);
    SELF.h1b_cmp_assessedamount_Invalid := Fields.InValid_h1b_cmp_assessedamount((SALT311.StrType)le.h1b_cmp_assessedamount);
    SELF.h1b_ee_agreedcount_Invalid := Fields.InValid_h1b_ee_agreedcount((SALT311.StrType)le.h1b_ee_agreedcount);
    SELF.h2a_countviolations_Invalid := Fields.InValid_h2a_countviolations((SALT311.StrType)le.h2a_countviolations);
    SELF.h2a_bw_agreedamount_Invalid := Fields.InValid_h2a_bw_agreedamount((SALT311.StrType)le.h2a_bw_agreedamount);
    SELF.h2a_cmp_assessedamount_Invalid := Fields.InValid_h2a_cmp_assessedamount((SALT311.StrType)le.h2a_cmp_assessedamount);
    SELF.h2a_ee_agreedcount_Invalid := Fields.InValid_h2a_ee_agreedcount((SALT311.StrType)le.h2a_ee_agreedcount);
    SELF.h2b_countviolations_Invalid := Fields.InValid_h2b_countviolations((SALT311.StrType)le.h2b_countviolations);
    SELF.h2b_bw_agreedamount_Invalid := Fields.InValid_h2b_bw_agreedamount((SALT311.StrType)le.h2b_bw_agreedamount);
    SELF.h2b_ee_agreedcount_Invalid := Fields.InValid_h2b_ee_agreedcount((SALT311.StrType)le.h2b_ee_agreedcount);
    SELF.mpsa_countviolations_Invalid := Fields.InValid_mpsa_countviolations((SALT311.StrType)le.mpsa_countviolations);
    SELF.mpsa_bw_agreedamount_Invalid := Fields.InValid_mpsa_bw_agreedamount((SALT311.StrType)le.mpsa_bw_agreedamount);
    SELF.mpsa_cmp_assessedamount_Invalid := Fields.InValid_mpsa_cmp_assessedamount((SALT311.StrType)le.mpsa_cmp_assessedamount);
    SELF.mpsa_ee_agreedcount_Invalid := Fields.InValid_mpsa_ee_agreedcount((SALT311.StrType)le.mpsa_ee_agreedcount);
    SELF.osha_countviolations_Invalid := Fields.InValid_osha_countviolations((SALT311.StrType)le.osha_countviolations);
    SELF.osha_bw_agreedamount_Invalid := Fields.InValid_osha_bw_agreedamount((SALT311.StrType)le.osha_bw_agreedamount);
    SELF.osha_cmp_assessedamount_Invalid := Fields.InValid_osha_cmp_assessedamount((SALT311.StrType)le.osha_cmp_assessedamount);
    SELF.osha_ee_agreedcount_Invalid := Fields.InValid_osha_ee_agreedcount((SALT311.StrType)le.osha_ee_agreedcount);
    SELF.pca_countviolations_Invalid := Fields.InValid_pca_countviolations((SALT311.StrType)le.pca_countviolations);
    SELF.pca_bw_agreedamount_Invalid := Fields.InValid_pca_bw_agreedamount((SALT311.StrType)le.pca_bw_agreedamount);
    SELF.pca_ee_agreedcount_Invalid := Fields.InValid_pca_ee_agreedcount((SALT311.StrType)le.pca_ee_agreedcount);
    SELF.sca_countviolations_Invalid := Fields.InValid_sca_countviolations((SALT311.StrType)le.sca_countviolations);
    SELF.sca_bw_agreedamount_Invalid := Fields.InValid_sca_bw_agreedamount((SALT311.StrType)le.sca_bw_agreedamount);
    SELF.sca_ee_agreedcount_Invalid := Fields.InValid_sca_ee_agreedcount((SALT311.StrType)le.sca_ee_agreedcount);
    SELF.sraw_countviolations_Invalid := Fields.InValid_sraw_countviolations((SALT311.StrType)le.sraw_countviolations);
    SELF.sraw_bw_agreedamount_Invalid := Fields.InValid_sraw_bw_agreedamount((SALT311.StrType)le.sraw_bw_agreedamount);
    SELF.sraw_ee_agreedcount_Invalid := Fields.InValid_sraw_ee_agreedcount((SALT311.StrType)le.sraw_ee_agreedcount);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_LaborActions_WHD);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dartid_Invalid << 0 ) + ( le.dateadded_Invalid << 1 ) + ( le.dateupdated_Invalid << 2 ) + ( le.website_Invalid << 3 ) + ( le.state_Invalid << 4 ) + ( le.caseid_Invalid << 6 ) + ( le.employername_Invalid << 7 ) + ( le.address1_Invalid << 8 ) + ( le.city_Invalid << 9 ) + ( le.employerstate_Invalid << 10 ) + ( le.zipcode_Invalid << 12 ) + ( le.naicscode_Invalid << 13 ) + ( le.totalviolations_Invalid << 14 ) + ( le.bw_totalagreedamount_Invalid << 15 ) + ( le.cmp_totalassessments_Invalid << 16 ) + ( le.ee_totalviolations_Invalid << 17 ) + ( le.ee_totalagreedcount_Invalid << 18 ) + ( le.ca_countviolations_Invalid << 19 ) + ( le.ca_bw_agreedamount_Invalid << 20 ) + ( le.ca_ee_agreedcount_Invalid << 21 ) + ( le.ccpa_countviolations_Invalid << 22 ) + ( le.ccpa_bw_agreedamount_Invalid << 23 ) + ( le.ccpa_ee_agreedcount_Invalid << 24 ) + ( le.crew_countviolations_Invalid << 25 ) + ( le.crew_bw_agreedamount_Invalid << 26 ) + ( le.crew_cmp_assessedamount_Invalid << 27 ) + ( le.crew_ee_agreedcount_Invalid << 28 ) + ( le.cwhssa_countviolations_Invalid << 29 ) + ( le.cwhssa_bw_agreedamount_Invalid << 30 ) + ( le.cwhssa_ee_agreedcount_Invalid << 31 ) + ( le.dbra_cl_countviolations_Invalid << 32 ) + ( le.dbra_bw_agreedamount_Invalid << 33 ) + ( le.dbra_ee_agreedcount_Invalid << 34 ) + ( le.eev_countviolations_Invalid << 35 ) + ( le.eppa_countviolations_Invalid << 36 ) + ( le.eppa_bw_agreedamount_Invalid << 37 ) + ( le.eppa_cmp_assessedamount_Invalid << 38 ) + ( le.eppa_ee_agreedcount_Invalid << 39 ) + ( le.flsa_countviolations_Invalid << 40 ) + ( le.flsa_bw_15a3_agreedamount_Invalid << 41 ) + ( le.flsa_bw_agreedamount_Invalid << 42 ) + ( le.flsa_bw_minwage_agreedamount_Invalid << 43 ) + ( le.flsa_bw_overtime_agreedamount_Invalid << 44 ) + ( le.flsa_cmp_assessedamount_Invalid << 45 ) + ( le.flsa_ee_agreedcount_Invalid << 46 ) + ( le.flsa_cl_countviolations_Invalid << 47 ) + ( le.flsa_cl_countminorsemployed_Invalid << 48 ) + ( le.flsa_cl_cmp_assessedamount_Invalid << 49 ) + ( le.flsa_hmwkr_countviolations_Invalid << 50 ) + ( le.flsa_hmwkr_bw_agreedamount_Invalid << 51 ) + ( le.flsa_hmwkr_cmp_assessedamount_Invalid << 52 ) + ( le.flsa_hmwkr_ee_agreedcount_Invalid << 53 ) + ( le.flsa_smw14_bw_agreedamount_Invalid << 54 ) + ( le.flsa_smw14_countviolations_Invalid << 55 ) + ( le.flsa_smw14_ee_agreedcount_Invalid << 56 ) + ( le.flsa_smwap_countviolations_Invalid << 57 ) + ( le.flsa_smwap_bw_agreedamount_Invalid << 58 ) + ( le.flsa_smwap_ee_agreedcount_Invalid << 59 ) + ( le.flsa_smwft_countviolations_Invalid << 60 ) + ( le.flsa_smwft_bw_agreedamount_Invalid << 61 ) + ( le.flsa_smwft_ee_agreedcount_Invalid << 62 ) + ( le.flsa_smwl_countviolations_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.flsa_smwl_bw_agreedamount_Invalid << 0 ) + ( le.flsa_smwl_ee_agreedcount_Invalid << 1 ) + ( le.flsa_smwmg_countviolations_Invalid << 2 ) + ( le.flsa_smwmg_bw_agreedamount_Invalid << 3 ) + ( le.flsa_smwmg_ee_agreedcount_Invalid << 4 ) + ( le.flsa_smwpw_countviolations_Invalid << 5 ) + ( le.flsa_smwpw_bw_agreedamount_Invalid << 6 ) + ( le.flsa_smwpw_ee_agreedcount_Invalid << 7 ) + ( le.flsa_smwsl_countviolations_Invalid << 8 ) + ( le.flsa_smwsl_bw_agreedamount_Invalid << 9 ) + ( le.flsa_smwsl_ee_agreedcount_Invalid << 10 ) + ( le.fmla_countviolations_Invalid << 11 ) + ( le.fmla_bw_agreedamount_Invalid << 12 ) + ( le.fmla_cmp_assessedamount_Invalid << 13 ) + ( le.fmla_ee_agreedcount_Invalid << 14 ) + ( le.h1a_countviolations_Invalid << 15 ) + ( le.h1a_bw_agreedamount_Invalid << 16 ) + ( le.h1a_cmp_assessedamount_Invalid << 17 ) + ( le.h1a_ee_agreedcount_Invalid << 18 ) + ( le.h1b_countviolations_Invalid << 19 ) + ( le.h1b_bw_agreedamount_Invalid << 20 ) + ( le.h1b_cmp_assessedamount_Invalid << 21 ) + ( le.h1b_ee_agreedcount_Invalid << 22 ) + ( le.h2a_countviolations_Invalid << 23 ) + ( le.h2a_bw_agreedamount_Invalid << 24 ) + ( le.h2a_cmp_assessedamount_Invalid << 25 ) + ( le.h2a_ee_agreedcount_Invalid << 26 ) + ( le.h2b_countviolations_Invalid << 27 ) + ( le.h2b_bw_agreedamount_Invalid << 28 ) + ( le.h2b_ee_agreedcount_Invalid << 29 ) + ( le.mpsa_countviolations_Invalid << 30 ) + ( le.mpsa_bw_agreedamount_Invalid << 31 ) + ( le.mpsa_cmp_assessedamount_Invalid << 32 ) + ( le.mpsa_ee_agreedcount_Invalid << 33 ) + ( le.osha_countviolations_Invalid << 34 ) + ( le.osha_bw_agreedamount_Invalid << 35 ) + ( le.osha_cmp_assessedamount_Invalid << 36 ) + ( le.osha_ee_agreedcount_Invalid << 37 ) + ( le.pca_countviolations_Invalid << 38 ) + ( le.pca_bw_agreedamount_Invalid << 39 ) + ( le.pca_ee_agreedcount_Invalid << 40 ) + ( le.sca_countviolations_Invalid << 41 ) + ( le.sca_bw_agreedamount_Invalid << 42 ) + ( le.sca_ee_agreedcount_Invalid << 43 ) + ( le.sraw_countviolations_Invalid << 44 ) + ( le.sraw_bw_agreedamount_Invalid << 45 ) + ( le.sraw_ee_agreedcount_Invalid << 46 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,Layout_LaborActions_WHD);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dartid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dateadded_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dateupdated_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.website_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.caseid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.employername_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.employerstate_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.naicscode_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.totalviolations_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.bw_totalagreedamount_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.cmp_totalassessments_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.ee_totalviolations_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ee_totalagreedcount_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.ca_countviolations_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.ca_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.ca_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.ccpa_countviolations_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.ccpa_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.ccpa_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.crew_countviolations_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.crew_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.crew_cmp_assessedamount_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.crew_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.cwhssa_countviolations_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.cwhssa_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.cwhssa_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.dbra_cl_countviolations_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.dbra_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.dbra_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.eev_countviolations_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.eppa_countviolations_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.eppa_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.eppa_cmp_assessedamount_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.eppa_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.flsa_countviolations_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.flsa_bw_15a3_agreedamount_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.flsa_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.flsa_bw_minwage_agreedamount_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.flsa_bw_overtime_agreedamount_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.flsa_cmp_assessedamount_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.flsa_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.flsa_cl_countviolations_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.flsa_cl_countminorsemployed_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.flsa_cl_cmp_assessedamount_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.flsa_hmwkr_countviolations_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.flsa_hmwkr_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.flsa_hmwkr_cmp_assessedamount_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.flsa_hmwkr_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.flsa_smw14_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.flsa_smw14_countviolations_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.flsa_smw14_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.flsa_smwap_countviolations_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.flsa_smwap_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.flsa_smwap_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.flsa_smwft_countviolations_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.flsa_smwft_bw_agreedamount_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.flsa_smwft_ee_agreedcount_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.flsa_smwl_countviolations_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.flsa_smwl_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.flsa_smwl_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.flsa_smwmg_countviolations_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.flsa_smwmg_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.flsa_smwmg_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.flsa_smwpw_countviolations_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.flsa_smwpw_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.flsa_smwpw_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.flsa_smwsl_countviolations_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.flsa_smwsl_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.flsa_smwsl_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.fmla_countviolations_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.fmla_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.fmla_cmp_assessedamount_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.fmla_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.h1a_countviolations_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.h1a_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.h1a_cmp_assessedamount_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.h1a_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.h1b_countviolations_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.h1b_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.h1b_cmp_assessedamount_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.h1b_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.h2a_countviolations_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.h2a_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.h2a_cmp_assessedamount_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.h2a_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.h2b_countviolations_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.h2b_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.h2b_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.mpsa_countviolations_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.mpsa_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.mpsa_cmp_assessedamount_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.mpsa_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.osha_countviolations_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.osha_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.osha_cmp_assessedamount_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.osha_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.pca_countviolations_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.pca_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.pca_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.sca_countviolations_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.sca_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.sca_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.sraw_countviolations_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.sraw_bw_agreedamount_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.sraw_ee_agreedcount_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dartid_CUSTOM_ErrorCount := COUNT(GROUP,h.dartid_Invalid=1);
    dateadded_CUSTOM_ErrorCount := COUNT(GROUP,h.dateadded_Invalid=1);
    dateupdated_CUSTOM_ErrorCount := COUNT(GROUP,h.dateupdated_Invalid=1);
    website_CUSTOM_ErrorCount := COUNT(GROUP,h.website_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    caseid_CUSTOM_ErrorCount := COUNT(GROUP,h.caseid_Invalid=1);
    employername_CUSTOM_ErrorCount := COUNT(GROUP,h.employername_Invalid=1);
    address1_CUSTOM_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    employerstate_ALLOW_ErrorCount := COUNT(GROUP,h.employerstate_Invalid=1);
    employerstate_LENGTHS_ErrorCount := COUNT(GROUP,h.employerstate_Invalid=2);
    employerstate_Total_ErrorCount := COUNT(GROUP,h.employerstate_Invalid>0);
    zipcode_CUSTOM_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    naicscode_CUSTOM_ErrorCount := COUNT(GROUP,h.naicscode_Invalid=1);
    totalviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.totalviolations_Invalid=1);
    bw_totalagreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.bw_totalagreedamount_Invalid=1);
    cmp_totalassessments_ALLOW_ErrorCount := COUNT(GROUP,h.cmp_totalassessments_Invalid=1);
    ee_totalviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.ee_totalviolations_Invalid=1);
    ee_totalagreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.ee_totalagreedcount_Invalid=1);
    ca_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.ca_countviolations_Invalid=1);
    ca_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.ca_bw_agreedamount_Invalid=1);
    ca_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.ca_ee_agreedcount_Invalid=1);
    ccpa_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.ccpa_countviolations_Invalid=1);
    ccpa_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.ccpa_bw_agreedamount_Invalid=1);
    ccpa_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.ccpa_ee_agreedcount_Invalid=1);
    crew_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.crew_countviolations_Invalid=1);
    crew_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.crew_bw_agreedamount_Invalid=1);
    crew_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.crew_cmp_assessedamount_Invalid=1);
    crew_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.crew_ee_agreedcount_Invalid=1);
    cwhssa_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.cwhssa_countviolations_Invalid=1);
    cwhssa_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.cwhssa_bw_agreedamount_Invalid=1);
    cwhssa_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.cwhssa_ee_agreedcount_Invalid=1);
    dbra_cl_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.dbra_cl_countviolations_Invalid=1);
    dbra_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.dbra_bw_agreedamount_Invalid=1);
    dbra_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.dbra_ee_agreedcount_Invalid=1);
    eev_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.eev_countviolations_Invalid=1);
    eppa_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.eppa_countviolations_Invalid=1);
    eppa_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.eppa_bw_agreedamount_Invalid=1);
    eppa_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.eppa_cmp_assessedamount_Invalid=1);
    eppa_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.eppa_ee_agreedcount_Invalid=1);
    flsa_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_countviolations_Invalid=1);
    flsa_bw_15a3_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_bw_15a3_agreedamount_Invalid=1);
    flsa_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_bw_agreedamount_Invalid=1);
    flsa_bw_minwage_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_bw_minwage_agreedamount_Invalid=1);
    flsa_bw_overtime_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_bw_overtime_agreedamount_Invalid=1);
    flsa_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_cmp_assessedamount_Invalid=1);
    flsa_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_ee_agreedcount_Invalid=1);
    flsa_cl_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_cl_countviolations_Invalid=1);
    flsa_cl_countminorsemployed_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_cl_countminorsemployed_Invalid=1);
    flsa_cl_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_cl_cmp_assessedamount_Invalid=1);
    flsa_hmwkr_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_hmwkr_countviolations_Invalid=1);
    flsa_hmwkr_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_hmwkr_bw_agreedamount_Invalid=1);
    flsa_hmwkr_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_hmwkr_cmp_assessedamount_Invalid=1);
    flsa_hmwkr_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_hmwkr_ee_agreedcount_Invalid=1);
    flsa_smw14_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_smw14_bw_agreedamount_Invalid=1);
    flsa_smw14_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smw14_countviolations_Invalid=1);
    flsa_smw14_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smw14_ee_agreedcount_Invalid=1);
    flsa_smwap_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwap_countviolations_Invalid=1);
    flsa_smwap_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_smwap_bw_agreedamount_Invalid=1);
    flsa_smwap_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwap_ee_agreedcount_Invalid=1);
    flsa_smwft_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwft_countviolations_Invalid=1);
    flsa_smwft_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_smwft_bw_agreedamount_Invalid=1);
    flsa_smwft_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwft_ee_agreedcount_Invalid=1);
    flsa_smwl_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwl_countviolations_Invalid=1);
    flsa_smwl_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_smwl_bw_agreedamount_Invalid=1);
    flsa_smwl_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwl_ee_agreedcount_Invalid=1);
    flsa_smwmg_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwmg_countviolations_Invalid=1);
    flsa_smwmg_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_smwmg_bw_agreedamount_Invalid=1);
    flsa_smwmg_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwmg_ee_agreedcount_Invalid=1);
    flsa_smwpw_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwpw_countviolations_Invalid=1);
    flsa_smwpw_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_smwpw_bw_agreedamount_Invalid=1);
    flsa_smwpw_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwpw_ee_agreedcount_Invalid=1);
    flsa_smwsl_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwsl_countviolations_Invalid=1);
    flsa_smwsl_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.flsa_smwsl_bw_agreedamount_Invalid=1);
    flsa_smwsl_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.flsa_smwsl_ee_agreedcount_Invalid=1);
    fmla_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.fmla_countviolations_Invalid=1);
    fmla_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.fmla_bw_agreedamount_Invalid=1);
    fmla_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.fmla_cmp_assessedamount_Invalid=1);
    fmla_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.fmla_ee_agreedcount_Invalid=1);
    h1a_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.h1a_countviolations_Invalid=1);
    h1a_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.h1a_bw_agreedamount_Invalid=1);
    h1a_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.h1a_cmp_assessedamount_Invalid=1);
    h1a_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.h1a_ee_agreedcount_Invalid=1);
    h1b_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.h1b_countviolations_Invalid=1);
    h1b_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.h1b_bw_agreedamount_Invalid=1);
    h1b_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.h1b_cmp_assessedamount_Invalid=1);
    h1b_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.h1b_ee_agreedcount_Invalid=1);
    h2a_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.h2a_countviolations_Invalid=1);
    h2a_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.h2a_bw_agreedamount_Invalid=1);
    h2a_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.h2a_cmp_assessedamount_Invalid=1);
    h2a_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.h2a_ee_agreedcount_Invalid=1);
    h2b_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.h2b_countviolations_Invalid=1);
    h2b_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.h2b_bw_agreedamount_Invalid=1);
    h2b_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.h2b_ee_agreedcount_Invalid=1);
    mpsa_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.mpsa_countviolations_Invalid=1);
    mpsa_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.mpsa_bw_agreedamount_Invalid=1);
    mpsa_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.mpsa_cmp_assessedamount_Invalid=1);
    mpsa_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.mpsa_ee_agreedcount_Invalid=1);
    osha_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.osha_countviolations_Invalid=1);
    osha_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.osha_bw_agreedamount_Invalid=1);
    osha_cmp_assessedamount_ALLOW_ErrorCount := COUNT(GROUP,h.osha_cmp_assessedamount_Invalid=1);
    osha_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.osha_ee_agreedcount_Invalid=1);
    pca_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.pca_countviolations_Invalid=1);
    pca_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.pca_bw_agreedamount_Invalid=1);
    pca_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.pca_ee_agreedcount_Invalid=1);
    sca_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.sca_countviolations_Invalid=1);
    sca_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.sca_bw_agreedamount_Invalid=1);
    sca_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.sca_ee_agreedcount_Invalid=1);
    sraw_countviolations_CUSTOM_ErrorCount := COUNT(GROUP,h.sraw_countviolations_Invalid=1);
    sraw_bw_agreedamount_ALLOW_ErrorCount := COUNT(GROUP,h.sraw_bw_agreedamount_Invalid=1);
    sraw_ee_agreedcount_CUSTOM_ErrorCount := COUNT(GROUP,h.sraw_ee_agreedcount_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dartid_Invalid > 0 OR h.dateadded_Invalid > 0 OR h.dateupdated_Invalid > 0 OR h.website_Invalid > 0 OR h.state_Invalid > 0 OR h.caseid_Invalid > 0 OR h.employername_Invalid > 0 OR h.address1_Invalid > 0 OR h.city_Invalid > 0 OR h.employerstate_Invalid > 0 OR h.zipcode_Invalid > 0 OR h.naicscode_Invalid > 0 OR h.totalviolations_Invalid > 0 OR h.bw_totalagreedamount_Invalid > 0 OR h.cmp_totalassessments_Invalid > 0 OR h.ee_totalviolations_Invalid > 0 OR h.ee_totalagreedcount_Invalid > 0 OR h.ca_countviolations_Invalid > 0 OR h.ca_bw_agreedamount_Invalid > 0 OR h.ca_ee_agreedcount_Invalid > 0 OR h.ccpa_countviolations_Invalid > 0 OR h.ccpa_bw_agreedamount_Invalid > 0 OR h.ccpa_ee_agreedcount_Invalid > 0 OR h.crew_countviolations_Invalid > 0 OR h.crew_bw_agreedamount_Invalid > 0 OR h.crew_cmp_assessedamount_Invalid > 0 OR h.crew_ee_agreedcount_Invalid > 0 OR h.cwhssa_countviolations_Invalid > 0 OR h.cwhssa_bw_agreedamount_Invalid > 0 OR h.cwhssa_ee_agreedcount_Invalid > 0 OR h.dbra_cl_countviolations_Invalid > 0 OR h.dbra_bw_agreedamount_Invalid > 0 OR h.dbra_ee_agreedcount_Invalid > 0 OR h.eev_countviolations_Invalid > 0 OR h.eppa_countviolations_Invalid > 0 OR h.eppa_bw_agreedamount_Invalid > 0 OR h.eppa_cmp_assessedamount_Invalid > 0 OR h.eppa_ee_agreedcount_Invalid > 0 OR h.flsa_countviolations_Invalid > 0 OR h.flsa_bw_15a3_agreedamount_Invalid > 0 OR h.flsa_bw_agreedamount_Invalid > 0 OR h.flsa_bw_minwage_agreedamount_Invalid > 0 OR h.flsa_bw_overtime_agreedamount_Invalid > 0 OR h.flsa_cmp_assessedamount_Invalid > 0 OR h.flsa_ee_agreedcount_Invalid > 0 OR h.flsa_cl_countviolations_Invalid > 0 OR h.flsa_cl_countminorsemployed_Invalid > 0 OR h.flsa_cl_cmp_assessedamount_Invalid > 0 OR h.flsa_hmwkr_countviolations_Invalid > 0 OR h.flsa_hmwkr_bw_agreedamount_Invalid > 0 OR h.flsa_hmwkr_cmp_assessedamount_Invalid > 0 OR h.flsa_hmwkr_ee_agreedcount_Invalid > 0 OR h.flsa_smw14_bw_agreedamount_Invalid > 0 OR h.flsa_smw14_countviolations_Invalid > 0 OR h.flsa_smw14_ee_agreedcount_Invalid > 0 OR h.flsa_smwap_countviolations_Invalid > 0 OR h.flsa_smwap_bw_agreedamount_Invalid > 0 OR h.flsa_smwap_ee_agreedcount_Invalid > 0 OR h.flsa_smwft_countviolations_Invalid > 0 OR h.flsa_smwft_bw_agreedamount_Invalid > 0 OR h.flsa_smwft_ee_agreedcount_Invalid > 0 OR h.flsa_smwl_countviolations_Invalid > 0 OR h.flsa_smwl_bw_agreedamount_Invalid > 0 OR h.flsa_smwl_ee_agreedcount_Invalid > 0 OR h.flsa_smwmg_countviolations_Invalid > 0 OR h.flsa_smwmg_bw_agreedamount_Invalid > 0 OR h.flsa_smwmg_ee_agreedcount_Invalid > 0 OR h.flsa_smwpw_countviolations_Invalid > 0 OR h.flsa_smwpw_bw_agreedamount_Invalid > 0 OR h.flsa_smwpw_ee_agreedcount_Invalid > 0 OR h.flsa_smwsl_countviolations_Invalid > 0 OR h.flsa_smwsl_bw_agreedamount_Invalid > 0 OR h.flsa_smwsl_ee_agreedcount_Invalid > 0 OR h.fmla_countviolations_Invalid > 0 OR h.fmla_bw_agreedamount_Invalid > 0 OR h.fmla_cmp_assessedamount_Invalid > 0 OR h.fmla_ee_agreedcount_Invalid > 0 OR h.h1a_countviolations_Invalid > 0 OR h.h1a_bw_agreedamount_Invalid > 0 OR h.h1a_cmp_assessedamount_Invalid > 0 OR h.h1a_ee_agreedcount_Invalid > 0 OR h.h1b_countviolations_Invalid > 0 OR h.h1b_bw_agreedamount_Invalid > 0 OR h.h1b_cmp_assessedamount_Invalid > 0 OR h.h1b_ee_agreedcount_Invalid > 0 OR h.h2a_countviolations_Invalid > 0 OR h.h2a_bw_agreedamount_Invalid > 0 OR h.h2a_cmp_assessedamount_Invalid > 0 OR h.h2a_ee_agreedcount_Invalid > 0 OR h.h2b_countviolations_Invalid > 0 OR h.h2b_bw_agreedamount_Invalid > 0 OR h.h2b_ee_agreedcount_Invalid > 0 OR h.mpsa_countviolations_Invalid > 0 OR h.mpsa_bw_agreedamount_Invalid > 0 OR h.mpsa_cmp_assessedamount_Invalid > 0 OR h.mpsa_ee_agreedcount_Invalid > 0 OR h.osha_countviolations_Invalid > 0 OR h.osha_bw_agreedamount_Invalid > 0 OR h.osha_cmp_assessedamount_Invalid > 0 OR h.osha_ee_agreedcount_Invalid > 0 OR h.pca_countviolations_Invalid > 0 OR h.pca_bw_agreedamount_Invalid > 0 OR h.pca_ee_agreedcount_Invalid > 0 OR h.sca_countviolations_Invalid > 0 OR h.sca_bw_agreedamount_Invalid > 0 OR h.sca_ee_agreedcount_Invalid > 0 OR h.sraw_countviolations_Invalid > 0 OR h.sraw_bw_agreedamount_Invalid > 0 OR h.sraw_ee_agreedcount_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dartid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateadded_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.website_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.caseid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.employername_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.employerstate_Total_ErrorCount > 0, 1, 0) + IF(le.zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.totalviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bw_totalagreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cmp_totalassessments_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ee_totalviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ee_totalagreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ca_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ca_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ca_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccpa_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccpa_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ccpa_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.crew_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.crew_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.crew_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.crew_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cwhssa_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cwhssa_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cwhssa_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbra_cl_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbra_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbra_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eev_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eppa_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eppa_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eppa_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eppa_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_bw_15a3_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_bw_minwage_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_bw_overtime_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_cl_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_cl_countminorsemployed_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_cl_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_hmwkr_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_hmwkr_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_hmwkr_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_hmwkr_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smw14_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smw14_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smw14_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwap_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwap_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwap_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwft_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwft_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwft_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwl_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwl_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwl_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwmg_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwmg_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwmg_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwpw_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwpw_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwpw_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwsl_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwsl_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwsl_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fmla_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fmla_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fmla_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fmla_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h1a_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h1a_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h1a_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h1a_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h1b_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h1b_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h1b_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h1b_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h2a_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h2a_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h2a_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h2a_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h2b_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h2b_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h2b_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mpsa_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mpsa_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mpsa_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mpsa_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.osha_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.osha_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.osha_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.osha_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pca_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pca_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pca_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sca_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sca_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sca_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sraw_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sraw_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sraw_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dartid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateadded_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.website_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.caseid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.employername_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.employerstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.employerstate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.totalviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bw_totalagreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cmp_totalassessments_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ee_totalviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ee_totalagreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ca_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ca_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ca_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccpa_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ccpa_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ccpa_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.crew_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.crew_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.crew_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.crew_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cwhssa_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cwhssa_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cwhssa_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbra_cl_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbra_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbra_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eev_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eppa_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eppa_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eppa_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.eppa_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_bw_15a3_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_bw_minwage_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_bw_overtime_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_cl_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_cl_countminorsemployed_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_cl_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_hmwkr_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_hmwkr_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_hmwkr_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_hmwkr_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smw14_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smw14_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smw14_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwap_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwap_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwap_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwft_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwft_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwft_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwl_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwl_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwl_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwmg_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwmg_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwmg_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwpw_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwpw_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwpw_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwsl_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.flsa_smwsl_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.flsa_smwsl_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fmla_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fmla_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fmla_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fmla_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h1a_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h1a_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h1a_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h1a_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h1b_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h1b_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h1b_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h1b_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h2a_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h2a_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h2a_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h2a_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h2b_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.h2b_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.h2b_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mpsa_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mpsa_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mpsa_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mpsa_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.osha_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.osha_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.osha_cmp_assessedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.osha_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pca_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pca_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pca_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sca_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sca_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sca_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sraw_countviolations_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sraw_bw_agreedamount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sraw_ee_agreedcount_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dartid_Invalid,le.dateadded_Invalid,le.dateupdated_Invalid,le.website_Invalid,le.state_Invalid,le.caseid_Invalid,le.employername_Invalid,le.address1_Invalid,le.city_Invalid,le.employerstate_Invalid,le.zipcode_Invalid,le.naicscode_Invalid,le.totalviolations_Invalid,le.bw_totalagreedamount_Invalid,le.cmp_totalassessments_Invalid,le.ee_totalviolations_Invalid,le.ee_totalagreedcount_Invalid,le.ca_countviolations_Invalid,le.ca_bw_agreedamount_Invalid,le.ca_ee_agreedcount_Invalid,le.ccpa_countviolations_Invalid,le.ccpa_bw_agreedamount_Invalid,le.ccpa_ee_agreedcount_Invalid,le.crew_countviolations_Invalid,le.crew_bw_agreedamount_Invalid,le.crew_cmp_assessedamount_Invalid,le.crew_ee_agreedcount_Invalid,le.cwhssa_countviolations_Invalid,le.cwhssa_bw_agreedamount_Invalid,le.cwhssa_ee_agreedcount_Invalid,le.dbra_cl_countviolations_Invalid,le.dbra_bw_agreedamount_Invalid,le.dbra_ee_agreedcount_Invalid,le.eev_countviolations_Invalid,le.eppa_countviolations_Invalid,le.eppa_bw_agreedamount_Invalid,le.eppa_cmp_assessedamount_Invalid,le.eppa_ee_agreedcount_Invalid,le.flsa_countviolations_Invalid,le.flsa_bw_15a3_agreedamount_Invalid,le.flsa_bw_agreedamount_Invalid,le.flsa_bw_minwage_agreedamount_Invalid,le.flsa_bw_overtime_agreedamount_Invalid,le.flsa_cmp_assessedamount_Invalid,le.flsa_ee_agreedcount_Invalid,le.flsa_cl_countviolations_Invalid,le.flsa_cl_countminorsemployed_Invalid,le.flsa_cl_cmp_assessedamount_Invalid,le.flsa_hmwkr_countviolations_Invalid,le.flsa_hmwkr_bw_agreedamount_Invalid,le.flsa_hmwkr_cmp_assessedamount_Invalid,le.flsa_hmwkr_ee_agreedcount_Invalid,le.flsa_smw14_bw_agreedamount_Invalid,le.flsa_smw14_countviolations_Invalid,le.flsa_smw14_ee_agreedcount_Invalid,le.flsa_smwap_countviolations_Invalid,le.flsa_smwap_bw_agreedamount_Invalid,le.flsa_smwap_ee_agreedcount_Invalid,le.flsa_smwft_countviolations_Invalid,le.flsa_smwft_bw_agreedamount_Invalid,le.flsa_smwft_ee_agreedcount_Invalid,le.flsa_smwl_countviolations_Invalid,le.flsa_smwl_bw_agreedamount_Invalid,le.flsa_smwl_ee_agreedcount_Invalid,le.flsa_smwmg_countviolations_Invalid,le.flsa_smwmg_bw_agreedamount_Invalid,le.flsa_smwmg_ee_agreedcount_Invalid,le.flsa_smwpw_countviolations_Invalid,le.flsa_smwpw_bw_agreedamount_Invalid,le.flsa_smwpw_ee_agreedcount_Invalid,le.flsa_smwsl_countviolations_Invalid,le.flsa_smwsl_bw_agreedamount_Invalid,le.flsa_smwsl_ee_agreedcount_Invalid,le.fmla_countviolations_Invalid,le.fmla_bw_agreedamount_Invalid,le.fmla_cmp_assessedamount_Invalid,le.fmla_ee_agreedcount_Invalid,le.h1a_countviolations_Invalid,le.h1a_bw_agreedamount_Invalid,le.h1a_cmp_assessedamount_Invalid,le.h1a_ee_agreedcount_Invalid,le.h1b_countviolations_Invalid,le.h1b_bw_agreedamount_Invalid,le.h1b_cmp_assessedamount_Invalid,le.h1b_ee_agreedcount_Invalid,le.h2a_countviolations_Invalid,le.h2a_bw_agreedamount_Invalid,le.h2a_cmp_assessedamount_Invalid,le.h2a_ee_agreedcount_Invalid,le.h2b_countviolations_Invalid,le.h2b_bw_agreedamount_Invalid,le.h2b_ee_agreedcount_Invalid,le.mpsa_countviolations_Invalid,le.mpsa_bw_agreedamount_Invalid,le.mpsa_cmp_assessedamount_Invalid,le.mpsa_ee_agreedcount_Invalid,le.osha_countviolations_Invalid,le.osha_bw_agreedamount_Invalid,le.osha_cmp_assessedamount_Invalid,le.osha_ee_agreedcount_Invalid,le.pca_countviolations_Invalid,le.pca_bw_agreedamount_Invalid,le.pca_ee_agreedcount_Invalid,le.sca_countviolations_Invalid,le.sca_bw_agreedamount_Invalid,le.sca_ee_agreedcount_Invalid,le.sraw_countviolations_Invalid,le.sraw_bw_agreedamount_Invalid,le.sraw_ee_agreedcount_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dartid(le.dartid_Invalid),Fields.InvalidMessage_dateadded(le.dateadded_Invalid),Fields.InvalidMessage_dateupdated(le.dateupdated_Invalid),Fields.InvalidMessage_website(le.website_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_caseid(le.caseid_Invalid),Fields.InvalidMessage_employername(le.employername_Invalid),Fields.InvalidMessage_address1(le.address1_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_employerstate(le.employerstate_Invalid),Fields.InvalidMessage_zipcode(le.zipcode_Invalid),Fields.InvalidMessage_naicscode(le.naicscode_Invalid),Fields.InvalidMessage_totalviolations(le.totalviolations_Invalid),Fields.InvalidMessage_bw_totalagreedamount(le.bw_totalagreedamount_Invalid),Fields.InvalidMessage_cmp_totalassessments(le.cmp_totalassessments_Invalid),Fields.InvalidMessage_ee_totalviolations(le.ee_totalviolations_Invalid),Fields.InvalidMessage_ee_totalagreedcount(le.ee_totalagreedcount_Invalid),Fields.InvalidMessage_ca_countviolations(le.ca_countviolations_Invalid),Fields.InvalidMessage_ca_bw_agreedamount(le.ca_bw_agreedamount_Invalid),Fields.InvalidMessage_ca_ee_agreedcount(le.ca_ee_agreedcount_Invalid),Fields.InvalidMessage_ccpa_countviolations(le.ccpa_countviolations_Invalid),Fields.InvalidMessage_ccpa_bw_agreedamount(le.ccpa_bw_agreedamount_Invalid),Fields.InvalidMessage_ccpa_ee_agreedcount(le.ccpa_ee_agreedcount_Invalid),Fields.InvalidMessage_crew_countviolations(le.crew_countviolations_Invalid),Fields.InvalidMessage_crew_bw_agreedamount(le.crew_bw_agreedamount_Invalid),Fields.InvalidMessage_crew_cmp_assessedamount(le.crew_cmp_assessedamount_Invalid),Fields.InvalidMessage_crew_ee_agreedcount(le.crew_ee_agreedcount_Invalid),Fields.InvalidMessage_cwhssa_countviolations(le.cwhssa_countviolations_Invalid),Fields.InvalidMessage_cwhssa_bw_agreedamount(le.cwhssa_bw_agreedamount_Invalid),Fields.InvalidMessage_cwhssa_ee_agreedcount(le.cwhssa_ee_agreedcount_Invalid),Fields.InvalidMessage_dbra_cl_countviolations(le.dbra_cl_countviolations_Invalid),Fields.InvalidMessage_dbra_bw_agreedamount(le.dbra_bw_agreedamount_Invalid),Fields.InvalidMessage_dbra_ee_agreedcount(le.dbra_ee_agreedcount_Invalid),Fields.InvalidMessage_eev_countviolations(le.eev_countviolations_Invalid),Fields.InvalidMessage_eppa_countviolations(le.eppa_countviolations_Invalid),Fields.InvalidMessage_eppa_bw_agreedamount(le.eppa_bw_agreedamount_Invalid),Fields.InvalidMessage_eppa_cmp_assessedamount(le.eppa_cmp_assessedamount_Invalid),Fields.InvalidMessage_eppa_ee_agreedcount(le.eppa_ee_agreedcount_Invalid),Fields.InvalidMessage_flsa_countviolations(le.flsa_countviolations_Invalid),Fields.InvalidMessage_flsa_bw_15a3_agreedamount(le.flsa_bw_15a3_agreedamount_Invalid),Fields.InvalidMessage_flsa_bw_agreedamount(le.flsa_bw_agreedamount_Invalid),Fields.InvalidMessage_flsa_bw_minwage_agreedamount(le.flsa_bw_minwage_agreedamount_Invalid),Fields.InvalidMessage_flsa_bw_overtime_agreedamount(le.flsa_bw_overtime_agreedamount_Invalid),Fields.InvalidMessage_flsa_cmp_assessedamount(le.flsa_cmp_assessedamount_Invalid),Fields.InvalidMessage_flsa_ee_agreedcount(le.flsa_ee_agreedcount_Invalid),Fields.InvalidMessage_flsa_cl_countviolations(le.flsa_cl_countviolations_Invalid),Fields.InvalidMessage_flsa_cl_countminorsemployed(le.flsa_cl_countminorsemployed_Invalid),Fields.InvalidMessage_flsa_cl_cmp_assessedamount(le.flsa_cl_cmp_assessedamount_Invalid),Fields.InvalidMessage_flsa_hmwkr_countviolations(le.flsa_hmwkr_countviolations_Invalid),Fields.InvalidMessage_flsa_hmwkr_bw_agreedamount(le.flsa_hmwkr_bw_agreedamount_Invalid),Fields.InvalidMessage_flsa_hmwkr_cmp_assessedamount(le.flsa_hmwkr_cmp_assessedamount_Invalid),Fields.InvalidMessage_flsa_hmwkr_ee_agreedcount(le.flsa_hmwkr_ee_agreedcount_Invalid),Fields.InvalidMessage_flsa_smw14_bw_agreedamount(le.flsa_smw14_bw_agreedamount_Invalid),Fields.InvalidMessage_flsa_smw14_countviolations(le.flsa_smw14_countviolations_Invalid),Fields.InvalidMessage_flsa_smw14_ee_agreedcount(le.flsa_smw14_ee_agreedcount_Invalid),Fields.InvalidMessage_flsa_smwap_countviolations(le.flsa_smwap_countviolations_Invalid),Fields.InvalidMessage_flsa_smwap_bw_agreedamount(le.flsa_smwap_bw_agreedamount_Invalid),Fields.InvalidMessage_flsa_smwap_ee_agreedcount(le.flsa_smwap_ee_agreedcount_Invalid),Fields.InvalidMessage_flsa_smwft_countviolations(le.flsa_smwft_countviolations_Invalid),Fields.InvalidMessage_flsa_smwft_bw_agreedamount(le.flsa_smwft_bw_agreedamount_Invalid),Fields.InvalidMessage_flsa_smwft_ee_agreedcount(le.flsa_smwft_ee_agreedcount_Invalid),Fields.InvalidMessage_flsa_smwl_countviolations(le.flsa_smwl_countviolations_Invalid),Fields.InvalidMessage_flsa_smwl_bw_agreedamount(le.flsa_smwl_bw_agreedamount_Invalid),Fields.InvalidMessage_flsa_smwl_ee_agreedcount(le.flsa_smwl_ee_agreedcount_Invalid),Fields.InvalidMessage_flsa_smwmg_countviolations(le.flsa_smwmg_countviolations_Invalid),Fields.InvalidMessage_flsa_smwmg_bw_agreedamount(le.flsa_smwmg_bw_agreedamount_Invalid),Fields.InvalidMessage_flsa_smwmg_ee_agreedcount(le.flsa_smwmg_ee_agreedcount_Invalid),Fields.InvalidMessage_flsa_smwpw_countviolations(le.flsa_smwpw_countviolations_Invalid),Fields.InvalidMessage_flsa_smwpw_bw_agreedamount(le.flsa_smwpw_bw_agreedamount_Invalid),Fields.InvalidMessage_flsa_smwpw_ee_agreedcount(le.flsa_smwpw_ee_agreedcount_Invalid),Fields.InvalidMessage_flsa_smwsl_countviolations(le.flsa_smwsl_countviolations_Invalid),Fields.InvalidMessage_flsa_smwsl_bw_agreedamount(le.flsa_smwsl_bw_agreedamount_Invalid),Fields.InvalidMessage_flsa_smwsl_ee_agreedcount(le.flsa_smwsl_ee_agreedcount_Invalid),Fields.InvalidMessage_fmla_countviolations(le.fmla_countviolations_Invalid),Fields.InvalidMessage_fmla_bw_agreedamount(le.fmla_bw_agreedamount_Invalid),Fields.InvalidMessage_fmla_cmp_assessedamount(le.fmla_cmp_assessedamount_Invalid),Fields.InvalidMessage_fmla_ee_agreedcount(le.fmla_ee_agreedcount_Invalid),Fields.InvalidMessage_h1a_countviolations(le.h1a_countviolations_Invalid),Fields.InvalidMessage_h1a_bw_agreedamount(le.h1a_bw_agreedamount_Invalid),Fields.InvalidMessage_h1a_cmp_assessedamount(le.h1a_cmp_assessedamount_Invalid),Fields.InvalidMessage_h1a_ee_agreedcount(le.h1a_ee_agreedcount_Invalid),Fields.InvalidMessage_h1b_countviolations(le.h1b_countviolations_Invalid),Fields.InvalidMessage_h1b_bw_agreedamount(le.h1b_bw_agreedamount_Invalid),Fields.InvalidMessage_h1b_cmp_assessedamount(le.h1b_cmp_assessedamount_Invalid),Fields.InvalidMessage_h1b_ee_agreedcount(le.h1b_ee_agreedcount_Invalid),Fields.InvalidMessage_h2a_countviolations(le.h2a_countviolations_Invalid),Fields.InvalidMessage_h2a_bw_agreedamount(le.h2a_bw_agreedamount_Invalid),Fields.InvalidMessage_h2a_cmp_assessedamount(le.h2a_cmp_assessedamount_Invalid),Fields.InvalidMessage_h2a_ee_agreedcount(le.h2a_ee_agreedcount_Invalid),Fields.InvalidMessage_h2b_countviolations(le.h2b_countviolations_Invalid),Fields.InvalidMessage_h2b_bw_agreedamount(le.h2b_bw_agreedamount_Invalid),Fields.InvalidMessage_h2b_ee_agreedcount(le.h2b_ee_agreedcount_Invalid),Fields.InvalidMessage_mpsa_countviolations(le.mpsa_countviolations_Invalid),Fields.InvalidMessage_mpsa_bw_agreedamount(le.mpsa_bw_agreedamount_Invalid),Fields.InvalidMessage_mpsa_cmp_assessedamount(le.mpsa_cmp_assessedamount_Invalid),Fields.InvalidMessage_mpsa_ee_agreedcount(le.mpsa_ee_agreedcount_Invalid),Fields.InvalidMessage_osha_countviolations(le.osha_countviolations_Invalid),Fields.InvalidMessage_osha_bw_agreedamount(le.osha_bw_agreedamount_Invalid),Fields.InvalidMessage_osha_cmp_assessedamount(le.osha_cmp_assessedamount_Invalid),Fields.InvalidMessage_osha_ee_agreedcount(le.osha_ee_agreedcount_Invalid),Fields.InvalidMessage_pca_countviolations(le.pca_countviolations_Invalid),Fields.InvalidMessage_pca_bw_agreedamount(le.pca_bw_agreedamount_Invalid),Fields.InvalidMessage_pca_ee_agreedcount(le.pca_ee_agreedcount_Invalid),Fields.InvalidMessage_sca_countviolations(le.sca_countviolations_Invalid),Fields.InvalidMessage_sca_bw_agreedamount(le.sca_bw_agreedamount_Invalid),Fields.InvalidMessage_sca_ee_agreedcount(le.sca_ee_agreedcount_Invalid),Fields.InvalidMessage_sraw_countviolations(le.sraw_countviolations_Invalid),Fields.InvalidMessage_sraw_bw_agreedamount(le.sraw_bw_agreedamount_Invalid),Fields.InvalidMessage_sraw_ee_agreedcount(le.sraw_ee_agreedcount_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dartid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dateadded_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dateupdated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.website_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.caseid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.employername_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.employerstate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naicscode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.totalviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bw_totalagreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cmp_totalassessments_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ee_totalviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ee_totalagreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ca_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ca_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ca_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ccpa_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ccpa_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ccpa_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.crew_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.crew_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.crew_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.crew_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cwhssa_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cwhssa_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cwhssa_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dbra_cl_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dbra_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbra_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.eev_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.eppa_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.eppa_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.eppa_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.eppa_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_bw_15a3_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_bw_minwage_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_bw_overtime_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_cl_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_cl_countminorsemployed_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_cl_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_hmwkr_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_hmwkr_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_hmwkr_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_hmwkr_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smw14_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_smw14_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smw14_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwap_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwap_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_smwap_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwft_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwft_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_smwft_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwl_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwl_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_smwl_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwmg_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwmg_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_smwmg_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwpw_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwpw_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_smwpw_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwsl_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.flsa_smwsl_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.flsa_smwsl_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fmla_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fmla_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fmla_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fmla_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.h1a_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.h1a_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.h1a_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.h1a_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.h1b_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.h1b_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.h1b_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.h1b_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.h2a_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.h2a_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.h2a_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.h2a_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.h2b_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.h2b_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.h2b_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mpsa_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mpsa_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mpsa_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mpsa_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.osha_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.osha_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.osha_cmp_assessedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.osha_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pca_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pca_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pca_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sca_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sca_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sca_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sraw_countviolations_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sraw_bw_agreedamount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sraw_ee_agreedcount_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dartid','dateadded','dateupdated','website','state','caseid','employername','address1','city','employerstate','zipcode','naicscode','totalviolations','bw_totalagreedamount','cmp_totalassessments','ee_totalviolations','ee_totalagreedcount','ca_countviolations','ca_bw_agreedamount','ca_ee_agreedcount','ccpa_countviolations','ccpa_bw_agreedamount','ccpa_ee_agreedcount','crew_countviolations','crew_bw_agreedamount','crew_cmp_assessedamount','crew_ee_agreedcount','cwhssa_countviolations','cwhssa_bw_agreedamount','cwhssa_ee_agreedcount','dbra_cl_countviolations','dbra_bw_agreedamount','dbra_ee_agreedcount','eev_countviolations','eppa_countviolations','eppa_bw_agreedamount','eppa_cmp_assessedamount','eppa_ee_agreedcount','flsa_countviolations','flsa_bw_15a3_agreedamount','flsa_bw_agreedamount','flsa_bw_minwage_agreedamount','flsa_bw_overtime_agreedamount','flsa_cmp_assessedamount','flsa_ee_agreedcount','flsa_cl_countviolations','flsa_cl_countminorsemployed','flsa_cl_cmp_assessedamount','flsa_hmwkr_countviolations','flsa_hmwkr_bw_agreedamount','flsa_hmwkr_cmp_assessedamount','flsa_hmwkr_ee_agreedcount','flsa_smw14_bw_agreedamount','flsa_smw14_countviolations','flsa_smw14_ee_agreedcount','flsa_smwap_countviolations','flsa_smwap_bw_agreedamount','flsa_smwap_ee_agreedcount','flsa_smwft_countviolations','flsa_smwft_bw_agreedamount','flsa_smwft_ee_agreedcount','flsa_smwl_countviolations','flsa_smwl_bw_agreedamount','flsa_smwl_ee_agreedcount','flsa_smwmg_countviolations','flsa_smwmg_bw_agreedamount','flsa_smwmg_ee_agreedcount','flsa_smwpw_countviolations','flsa_smwpw_bw_agreedamount','flsa_smwpw_ee_agreedcount','flsa_smwsl_countviolations','flsa_smwsl_bw_agreedamount','flsa_smwsl_ee_agreedcount','fmla_countviolations','fmla_bw_agreedamount','fmla_cmp_assessedamount','fmla_ee_agreedcount','h1a_countviolations','h1a_bw_agreedamount','h1a_cmp_assessedamount','h1a_ee_agreedcount','h1b_countviolations','h1b_bw_agreedamount','h1b_cmp_assessedamount','h1b_ee_agreedcount','h2a_countviolations','h2a_bw_agreedamount','h2a_cmp_assessedamount','h2a_ee_agreedcount','h2b_countviolations','h2b_bw_agreedamount','h2b_ee_agreedcount','mpsa_countviolations','mpsa_bw_agreedamount','mpsa_cmp_assessedamount','mpsa_ee_agreedcount','osha_countviolations','osha_bw_agreedamount','osha_cmp_assessedamount','osha_ee_agreedcount','pca_countviolations','pca_bw_agreedamount','pca_ee_agreedcount','sca_countviolations','sca_bw_agreedamount','sca_ee_agreedcount','sraw_countviolations','sraw_bw_agreedamount','sraw_ee_agreedcount','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_State','Invalid_No','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','Invalid_No','Invalid_Float','Invalid_No','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dartid,(SALT311.StrType)le.dateadded,(SALT311.StrType)le.dateupdated,(SALT311.StrType)le.website,(SALT311.StrType)le.state,(SALT311.StrType)le.caseid,(SALT311.StrType)le.employername,(SALT311.StrType)le.address1,(SALT311.StrType)le.city,(SALT311.StrType)le.employerstate,(SALT311.StrType)le.zipcode,(SALT311.StrType)le.naicscode,(SALT311.StrType)le.totalviolations,(SALT311.StrType)le.bw_totalagreedamount,(SALT311.StrType)le.cmp_totalassessments,(SALT311.StrType)le.ee_totalviolations,(SALT311.StrType)le.ee_totalagreedcount,(SALT311.StrType)le.ca_countviolations,(SALT311.StrType)le.ca_bw_agreedamount,(SALT311.StrType)le.ca_ee_agreedcount,(SALT311.StrType)le.ccpa_countviolations,(SALT311.StrType)le.ccpa_bw_agreedamount,(SALT311.StrType)le.ccpa_ee_agreedcount,(SALT311.StrType)le.crew_countviolations,(SALT311.StrType)le.crew_bw_agreedamount,(SALT311.StrType)le.crew_cmp_assessedamount,(SALT311.StrType)le.crew_ee_agreedcount,(SALT311.StrType)le.cwhssa_countviolations,(SALT311.StrType)le.cwhssa_bw_agreedamount,(SALT311.StrType)le.cwhssa_ee_agreedcount,(SALT311.StrType)le.dbra_cl_countviolations,(SALT311.StrType)le.dbra_bw_agreedamount,(SALT311.StrType)le.dbra_ee_agreedcount,(SALT311.StrType)le.eev_countviolations,(SALT311.StrType)le.eppa_countviolations,(SALT311.StrType)le.eppa_bw_agreedamount,(SALT311.StrType)le.eppa_cmp_assessedamount,(SALT311.StrType)le.eppa_ee_agreedcount,(SALT311.StrType)le.flsa_countviolations,(SALT311.StrType)le.flsa_bw_15a3_agreedamount,(SALT311.StrType)le.flsa_bw_agreedamount,(SALT311.StrType)le.flsa_bw_minwage_agreedamount,(SALT311.StrType)le.flsa_bw_overtime_agreedamount,(SALT311.StrType)le.flsa_cmp_assessedamount,(SALT311.StrType)le.flsa_ee_agreedcount,(SALT311.StrType)le.flsa_cl_countviolations,(SALT311.StrType)le.flsa_cl_countminorsemployed,(SALT311.StrType)le.flsa_cl_cmp_assessedamount,(SALT311.StrType)le.flsa_hmwkr_countviolations,(SALT311.StrType)le.flsa_hmwkr_bw_agreedamount,(SALT311.StrType)le.flsa_hmwkr_cmp_assessedamount,(SALT311.StrType)le.flsa_hmwkr_ee_agreedcount,(SALT311.StrType)le.flsa_smw14_bw_agreedamount,(SALT311.StrType)le.flsa_smw14_countviolations,(SALT311.StrType)le.flsa_smw14_ee_agreedcount,(SALT311.StrType)le.flsa_smwap_countviolations,(SALT311.StrType)le.flsa_smwap_bw_agreedamount,(SALT311.StrType)le.flsa_smwap_ee_agreedcount,(SALT311.StrType)le.flsa_smwft_countviolations,(SALT311.StrType)le.flsa_smwft_bw_agreedamount,(SALT311.StrType)le.flsa_smwft_ee_agreedcount,(SALT311.StrType)le.flsa_smwl_countviolations,(SALT311.StrType)le.flsa_smwl_bw_agreedamount,(SALT311.StrType)le.flsa_smwl_ee_agreedcount,(SALT311.StrType)le.flsa_smwmg_countviolations,(SALT311.StrType)le.flsa_smwmg_bw_agreedamount,(SALT311.StrType)le.flsa_smwmg_ee_agreedcount,(SALT311.StrType)le.flsa_smwpw_countviolations,(SALT311.StrType)le.flsa_smwpw_bw_agreedamount,(SALT311.StrType)le.flsa_smwpw_ee_agreedcount,(SALT311.StrType)le.flsa_smwsl_countviolations,(SALT311.StrType)le.flsa_smwsl_bw_agreedamount,(SALT311.StrType)le.flsa_smwsl_ee_agreedcount,(SALT311.StrType)le.fmla_countviolations,(SALT311.StrType)le.fmla_bw_agreedamount,(SALT311.StrType)le.fmla_cmp_assessedamount,(SALT311.StrType)le.fmla_ee_agreedcount,(SALT311.StrType)le.h1a_countviolations,(SALT311.StrType)le.h1a_bw_agreedamount,(SALT311.StrType)le.h1a_cmp_assessedamount,(SALT311.StrType)le.h1a_ee_agreedcount,(SALT311.StrType)le.h1b_countviolations,(SALT311.StrType)le.h1b_bw_agreedamount,(SALT311.StrType)le.h1b_cmp_assessedamount,(SALT311.StrType)le.h1b_ee_agreedcount,(SALT311.StrType)le.h2a_countviolations,(SALT311.StrType)le.h2a_bw_agreedamount,(SALT311.StrType)le.h2a_cmp_assessedamount,(SALT311.StrType)le.h2a_ee_agreedcount,(SALT311.StrType)le.h2b_countviolations,(SALT311.StrType)le.h2b_bw_agreedamount,(SALT311.StrType)le.h2b_ee_agreedcount,(SALT311.StrType)le.mpsa_countviolations,(SALT311.StrType)le.mpsa_bw_agreedamount,(SALT311.StrType)le.mpsa_cmp_assessedamount,(SALT311.StrType)le.mpsa_ee_agreedcount,(SALT311.StrType)le.osha_countviolations,(SALT311.StrType)le.osha_bw_agreedamount,(SALT311.StrType)le.osha_cmp_assessedamount,(SALT311.StrType)le.osha_ee_agreedcount,(SALT311.StrType)le.pca_countviolations,(SALT311.StrType)le.pca_bw_agreedamount,(SALT311.StrType)le.pca_ee_agreedcount,(SALT311.StrType)le.sca_countviolations,(SALT311.StrType)le.sca_bw_agreedamount,(SALT311.StrType)le.sca_ee_agreedcount,(SALT311.StrType)le.sraw_countviolations,(SALT311.StrType)le.sraw_bw_agreedamount,(SALT311.StrType)le.sraw_ee_agreedcount,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,109,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_LaborActions_WHD) prevDS = DATASET([], Layout_LaborActions_WHD), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dartid_CUSTOM_ErrorCount
          ,le.dateadded_CUSTOM_ErrorCount
          ,le.dateupdated_CUSTOM_ErrorCount
          ,le.website_CUSTOM_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.caseid_CUSTOM_ErrorCount
          ,le.employername_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.employerstate_ALLOW_ErrorCount,le.employerstate_LENGTHS_ErrorCount
          ,le.zipcode_CUSTOM_ErrorCount
          ,le.naicscode_CUSTOM_ErrorCount
          ,le.totalviolations_CUSTOM_ErrorCount
          ,le.bw_totalagreedamount_ALLOW_ErrorCount
          ,le.cmp_totalassessments_ALLOW_ErrorCount
          ,le.ee_totalviolations_CUSTOM_ErrorCount
          ,le.ee_totalagreedcount_CUSTOM_ErrorCount
          ,le.ca_countviolations_CUSTOM_ErrorCount
          ,le.ca_bw_agreedamount_ALLOW_ErrorCount
          ,le.ca_ee_agreedcount_CUSTOM_ErrorCount
          ,le.ccpa_countviolations_CUSTOM_ErrorCount
          ,le.ccpa_bw_agreedamount_ALLOW_ErrorCount
          ,le.ccpa_ee_agreedcount_CUSTOM_ErrorCount
          ,le.crew_countviolations_CUSTOM_ErrorCount
          ,le.crew_bw_agreedamount_ALLOW_ErrorCount
          ,le.crew_cmp_assessedamount_ALLOW_ErrorCount
          ,le.crew_ee_agreedcount_CUSTOM_ErrorCount
          ,le.cwhssa_countviolations_CUSTOM_ErrorCount
          ,le.cwhssa_bw_agreedamount_ALLOW_ErrorCount
          ,le.cwhssa_ee_agreedcount_CUSTOM_ErrorCount
          ,le.dbra_cl_countviolations_CUSTOM_ErrorCount
          ,le.dbra_bw_agreedamount_ALLOW_ErrorCount
          ,le.dbra_ee_agreedcount_CUSTOM_ErrorCount
          ,le.eev_countviolations_CUSTOM_ErrorCount
          ,le.eppa_countviolations_CUSTOM_ErrorCount
          ,le.eppa_bw_agreedamount_ALLOW_ErrorCount
          ,le.eppa_cmp_assessedamount_ALLOW_ErrorCount
          ,le.eppa_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_countviolations_CUSTOM_ErrorCount
          ,le.flsa_bw_15a3_agreedamount_ALLOW_ErrorCount
          ,le.flsa_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_bw_minwage_agreedamount_ALLOW_ErrorCount
          ,le.flsa_bw_overtime_agreedamount_ALLOW_ErrorCount
          ,le.flsa_cmp_assessedamount_ALLOW_ErrorCount
          ,le.flsa_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_cl_countviolations_CUSTOM_ErrorCount
          ,le.flsa_cl_countminorsemployed_CUSTOM_ErrorCount
          ,le.flsa_cl_cmp_assessedamount_ALLOW_ErrorCount
          ,le.flsa_hmwkr_countviolations_CUSTOM_ErrorCount
          ,le.flsa_hmwkr_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_hmwkr_cmp_assessedamount_ALLOW_ErrorCount
          ,le.flsa_hmwkr_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smw14_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smw14_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smw14_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwap_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwap_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwap_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwft_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwft_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwft_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwl_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwl_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwl_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwmg_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwmg_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwmg_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwpw_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwpw_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwpw_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwsl_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwsl_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwsl_ee_agreedcount_CUSTOM_ErrorCount
          ,le.fmla_countviolations_CUSTOM_ErrorCount
          ,le.fmla_bw_agreedamount_ALLOW_ErrorCount
          ,le.fmla_cmp_assessedamount_ALLOW_ErrorCount
          ,le.fmla_ee_agreedcount_CUSTOM_ErrorCount
          ,le.h1a_countviolations_CUSTOM_ErrorCount
          ,le.h1a_bw_agreedamount_ALLOW_ErrorCount
          ,le.h1a_cmp_assessedamount_ALLOW_ErrorCount
          ,le.h1a_ee_agreedcount_CUSTOM_ErrorCount
          ,le.h1b_countviolations_CUSTOM_ErrorCount
          ,le.h1b_bw_agreedamount_ALLOW_ErrorCount
          ,le.h1b_cmp_assessedamount_ALLOW_ErrorCount
          ,le.h1b_ee_agreedcount_CUSTOM_ErrorCount
          ,le.h2a_countviolations_CUSTOM_ErrorCount
          ,le.h2a_bw_agreedamount_ALLOW_ErrorCount
          ,le.h2a_cmp_assessedamount_ALLOW_ErrorCount
          ,le.h2a_ee_agreedcount_CUSTOM_ErrorCount
          ,le.h2b_countviolations_CUSTOM_ErrorCount
          ,le.h2b_bw_agreedamount_ALLOW_ErrorCount
          ,le.h2b_ee_agreedcount_CUSTOM_ErrorCount
          ,le.mpsa_countviolations_CUSTOM_ErrorCount
          ,le.mpsa_bw_agreedamount_ALLOW_ErrorCount
          ,le.mpsa_cmp_assessedamount_ALLOW_ErrorCount
          ,le.mpsa_ee_agreedcount_CUSTOM_ErrorCount
          ,le.osha_countviolations_CUSTOM_ErrorCount
          ,le.osha_bw_agreedamount_ALLOW_ErrorCount
          ,le.osha_cmp_assessedamount_ALLOW_ErrorCount
          ,le.osha_ee_agreedcount_CUSTOM_ErrorCount
          ,le.pca_countviolations_CUSTOM_ErrorCount
          ,le.pca_bw_agreedamount_ALLOW_ErrorCount
          ,le.pca_ee_agreedcount_CUSTOM_ErrorCount
          ,le.sca_countviolations_CUSTOM_ErrorCount
          ,le.sca_bw_agreedamount_ALLOW_ErrorCount
          ,le.sca_ee_agreedcount_CUSTOM_ErrorCount
          ,le.sraw_countviolations_CUSTOM_ErrorCount
          ,le.sraw_bw_agreedamount_ALLOW_ErrorCount
          ,le.sraw_ee_agreedcount_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dartid_CUSTOM_ErrorCount
          ,le.dateadded_CUSTOM_ErrorCount
          ,le.dateupdated_CUSTOM_ErrorCount
          ,le.website_CUSTOM_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.caseid_CUSTOM_ErrorCount
          ,le.employername_CUSTOM_ErrorCount
          ,le.address1_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.employerstate_ALLOW_ErrorCount,le.employerstate_LENGTHS_ErrorCount
          ,le.zipcode_CUSTOM_ErrorCount
          ,le.naicscode_CUSTOM_ErrorCount
          ,le.totalviolations_CUSTOM_ErrorCount
          ,le.bw_totalagreedamount_ALLOW_ErrorCount
          ,le.cmp_totalassessments_ALLOW_ErrorCount
          ,le.ee_totalviolations_CUSTOM_ErrorCount
          ,le.ee_totalagreedcount_CUSTOM_ErrorCount
          ,le.ca_countviolations_CUSTOM_ErrorCount
          ,le.ca_bw_agreedamount_ALLOW_ErrorCount
          ,le.ca_ee_agreedcount_CUSTOM_ErrorCount
          ,le.ccpa_countviolations_CUSTOM_ErrorCount
          ,le.ccpa_bw_agreedamount_ALLOW_ErrorCount
          ,le.ccpa_ee_agreedcount_CUSTOM_ErrorCount
          ,le.crew_countviolations_CUSTOM_ErrorCount
          ,le.crew_bw_agreedamount_ALLOW_ErrorCount
          ,le.crew_cmp_assessedamount_ALLOW_ErrorCount
          ,le.crew_ee_agreedcount_CUSTOM_ErrorCount
          ,le.cwhssa_countviolations_CUSTOM_ErrorCount
          ,le.cwhssa_bw_agreedamount_ALLOW_ErrorCount
          ,le.cwhssa_ee_agreedcount_CUSTOM_ErrorCount
          ,le.dbra_cl_countviolations_CUSTOM_ErrorCount
          ,le.dbra_bw_agreedamount_ALLOW_ErrorCount
          ,le.dbra_ee_agreedcount_CUSTOM_ErrorCount
          ,le.eev_countviolations_CUSTOM_ErrorCount
          ,le.eppa_countviolations_CUSTOM_ErrorCount
          ,le.eppa_bw_agreedamount_ALLOW_ErrorCount
          ,le.eppa_cmp_assessedamount_ALLOW_ErrorCount
          ,le.eppa_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_countviolations_CUSTOM_ErrorCount
          ,le.flsa_bw_15a3_agreedamount_ALLOW_ErrorCount
          ,le.flsa_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_bw_minwage_agreedamount_ALLOW_ErrorCount
          ,le.flsa_bw_overtime_agreedamount_ALLOW_ErrorCount
          ,le.flsa_cmp_assessedamount_ALLOW_ErrorCount
          ,le.flsa_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_cl_countviolations_CUSTOM_ErrorCount
          ,le.flsa_cl_countminorsemployed_CUSTOM_ErrorCount
          ,le.flsa_cl_cmp_assessedamount_ALLOW_ErrorCount
          ,le.flsa_hmwkr_countviolations_CUSTOM_ErrorCount
          ,le.flsa_hmwkr_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_hmwkr_cmp_assessedamount_ALLOW_ErrorCount
          ,le.flsa_hmwkr_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smw14_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smw14_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smw14_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwap_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwap_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwap_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwft_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwft_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwft_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwl_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwl_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwl_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwmg_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwmg_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwmg_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwpw_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwpw_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwpw_ee_agreedcount_CUSTOM_ErrorCount
          ,le.flsa_smwsl_countviolations_CUSTOM_ErrorCount
          ,le.flsa_smwsl_bw_agreedamount_ALLOW_ErrorCount
          ,le.flsa_smwsl_ee_agreedcount_CUSTOM_ErrorCount
          ,le.fmla_countviolations_CUSTOM_ErrorCount
          ,le.fmla_bw_agreedamount_ALLOW_ErrorCount
          ,le.fmla_cmp_assessedamount_ALLOW_ErrorCount
          ,le.fmla_ee_agreedcount_CUSTOM_ErrorCount
          ,le.h1a_countviolations_CUSTOM_ErrorCount
          ,le.h1a_bw_agreedamount_ALLOW_ErrorCount
          ,le.h1a_cmp_assessedamount_ALLOW_ErrorCount
          ,le.h1a_ee_agreedcount_CUSTOM_ErrorCount
          ,le.h1b_countviolations_CUSTOM_ErrorCount
          ,le.h1b_bw_agreedamount_ALLOW_ErrorCount
          ,le.h1b_cmp_assessedamount_ALLOW_ErrorCount
          ,le.h1b_ee_agreedcount_CUSTOM_ErrorCount
          ,le.h2a_countviolations_CUSTOM_ErrorCount
          ,le.h2a_bw_agreedamount_ALLOW_ErrorCount
          ,le.h2a_cmp_assessedamount_ALLOW_ErrorCount
          ,le.h2a_ee_agreedcount_CUSTOM_ErrorCount
          ,le.h2b_countviolations_CUSTOM_ErrorCount
          ,le.h2b_bw_agreedamount_ALLOW_ErrorCount
          ,le.h2b_ee_agreedcount_CUSTOM_ErrorCount
          ,le.mpsa_countviolations_CUSTOM_ErrorCount
          ,le.mpsa_bw_agreedamount_ALLOW_ErrorCount
          ,le.mpsa_cmp_assessedamount_ALLOW_ErrorCount
          ,le.mpsa_ee_agreedcount_CUSTOM_ErrorCount
          ,le.osha_countviolations_CUSTOM_ErrorCount
          ,le.osha_bw_agreedamount_ALLOW_ErrorCount
          ,le.osha_cmp_assessedamount_ALLOW_ErrorCount
          ,le.osha_ee_agreedcount_CUSTOM_ErrorCount
          ,le.pca_countviolations_CUSTOM_ErrorCount
          ,le.pca_bw_agreedamount_ALLOW_ErrorCount
          ,le.pca_ee_agreedcount_CUSTOM_ErrorCount
          ,le.sca_countviolations_CUSTOM_ErrorCount
          ,le.sca_bw_agreedamount_ALLOW_ErrorCount
          ,le.sca_ee_agreedcount_CUSTOM_ErrorCount
          ,le.sraw_countviolations_CUSTOM_ErrorCount
          ,le.sraw_bw_agreedamount_ALLOW_ErrorCount
          ,le.sraw_ee_agreedcount_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_LaborActions_WHD));
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
          ,'dartid:' + getFieldTypeText(h.dartid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateadded:' + getFieldTypeText(h.dateadded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateupdated:' + getFieldTypeText(h.dateupdated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'website:' + getFieldTypeText(h.website) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'caseid:' + getFieldTypeText(h.caseid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'employername:' + getFieldTypeText(h.employername) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'employerstate:' + getFieldTypeText(h.employerstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zipcode:' + getFieldTypeText(h.zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode:' + getFieldTypeText(h.naicscode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'totalviolations:' + getFieldTypeText(h.totalviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bw_totalagreedamount:' + getFieldTypeText(h.bw_totalagreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cmp_totalassessments:' + getFieldTypeText(h.cmp_totalassessments) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ee_totalviolations:' + getFieldTypeText(h.ee_totalviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ee_totalagreedcount:' + getFieldTypeText(h.ee_totalagreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ca_countviolations:' + getFieldTypeText(h.ca_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ca_bw_agreedamount:' + getFieldTypeText(h.ca_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ca_ee_agreedcount:' + getFieldTypeText(h.ca_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccpa_countviolations:' + getFieldTypeText(h.ccpa_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccpa_bw_agreedamount:' + getFieldTypeText(h.ccpa_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ccpa_ee_agreedcount:' + getFieldTypeText(h.ccpa_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crew_countviolations:' + getFieldTypeText(h.crew_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crew_bw_agreedamount:' + getFieldTypeText(h.crew_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crew_cmp_assessedamount:' + getFieldTypeText(h.crew_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crew_ee_agreedcount:' + getFieldTypeText(h.crew_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cwhssa_countviolations:' + getFieldTypeText(h.cwhssa_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cwhssa_bw_agreedamount:' + getFieldTypeText(h.cwhssa_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cwhssa_ee_agreedcount:' + getFieldTypeText(h.cwhssa_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbra_cl_countviolations:' + getFieldTypeText(h.dbra_cl_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbra_bw_agreedamount:' + getFieldTypeText(h.dbra_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbra_ee_agreedcount:' + getFieldTypeText(h.dbra_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eev_countviolations:' + getFieldTypeText(h.eev_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eppa_countviolations:' + getFieldTypeText(h.eppa_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eppa_bw_agreedamount:' + getFieldTypeText(h.eppa_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eppa_cmp_assessedamount:' + getFieldTypeText(h.eppa_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eppa_ee_agreedcount:' + getFieldTypeText(h.eppa_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_countviolations:' + getFieldTypeText(h.flsa_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_bw_15a3_agreedamount:' + getFieldTypeText(h.flsa_bw_15a3_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_bw_agreedamount:' + getFieldTypeText(h.flsa_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_bw_minwage_agreedamount:' + getFieldTypeText(h.flsa_bw_minwage_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_bw_overtime_agreedamount:' + getFieldTypeText(h.flsa_bw_overtime_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_cmp_assessedamount:' + getFieldTypeText(h.flsa_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_ee_agreedcount:' + getFieldTypeText(h.flsa_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_cl_countviolations:' + getFieldTypeText(h.flsa_cl_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_cl_countminorsemployed:' + getFieldTypeText(h.flsa_cl_countminorsemployed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_cl_cmp_assessedamount:' + getFieldTypeText(h.flsa_cl_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_hmwkr_countviolations:' + getFieldTypeText(h.flsa_hmwkr_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_hmwkr_bw_agreedamount:' + getFieldTypeText(h.flsa_hmwkr_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_hmwkr_cmp_assessedamount:' + getFieldTypeText(h.flsa_hmwkr_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_hmwkr_ee_agreedcount:' + getFieldTypeText(h.flsa_hmwkr_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smw14_bw_agreedamount:' + getFieldTypeText(h.flsa_smw14_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smw14_countviolations:' + getFieldTypeText(h.flsa_smw14_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smw14_ee_agreedcount:' + getFieldTypeText(h.flsa_smw14_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwap_countviolations:' + getFieldTypeText(h.flsa_smwap_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwap_bw_agreedamount:' + getFieldTypeText(h.flsa_smwap_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwap_ee_agreedcount:' + getFieldTypeText(h.flsa_smwap_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwft_countviolations:' + getFieldTypeText(h.flsa_smwft_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwft_bw_agreedamount:' + getFieldTypeText(h.flsa_smwft_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwft_ee_agreedcount:' + getFieldTypeText(h.flsa_smwft_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwl_countviolations:' + getFieldTypeText(h.flsa_smwl_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwl_bw_agreedamount:' + getFieldTypeText(h.flsa_smwl_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwl_ee_agreedcount:' + getFieldTypeText(h.flsa_smwl_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwmg_countviolations:' + getFieldTypeText(h.flsa_smwmg_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwmg_bw_agreedamount:' + getFieldTypeText(h.flsa_smwmg_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwmg_ee_agreedcount:' + getFieldTypeText(h.flsa_smwmg_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwpw_countviolations:' + getFieldTypeText(h.flsa_smwpw_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwpw_bw_agreedamount:' + getFieldTypeText(h.flsa_smwpw_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwpw_ee_agreedcount:' + getFieldTypeText(h.flsa_smwpw_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwsl_countviolations:' + getFieldTypeText(h.flsa_smwsl_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwsl_bw_agreedamount:' + getFieldTypeText(h.flsa_smwsl_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flsa_smwsl_ee_agreedcount:' + getFieldTypeText(h.flsa_smwsl_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fmla_countviolations:' + getFieldTypeText(h.fmla_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fmla_bw_agreedamount:' + getFieldTypeText(h.fmla_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fmla_cmp_assessedamount:' + getFieldTypeText(h.fmla_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fmla_ee_agreedcount:' + getFieldTypeText(h.fmla_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h1a_countviolations:' + getFieldTypeText(h.h1a_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h1a_bw_agreedamount:' + getFieldTypeText(h.h1a_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h1a_cmp_assessedamount:' + getFieldTypeText(h.h1a_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h1a_ee_agreedcount:' + getFieldTypeText(h.h1a_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h1b_countviolations:' + getFieldTypeText(h.h1b_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h1b_bw_agreedamount:' + getFieldTypeText(h.h1b_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h1b_cmp_assessedamount:' + getFieldTypeText(h.h1b_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h1b_ee_agreedcount:' + getFieldTypeText(h.h1b_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h2a_countviolations:' + getFieldTypeText(h.h2a_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h2a_bw_agreedamount:' + getFieldTypeText(h.h2a_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h2a_cmp_assessedamount:' + getFieldTypeText(h.h2a_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h2a_ee_agreedcount:' + getFieldTypeText(h.h2a_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h2b_countviolations:' + getFieldTypeText(h.h2b_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h2b_bw_agreedamount:' + getFieldTypeText(h.h2b_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'h2b_ee_agreedcount:' + getFieldTypeText(h.h2b_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mpsa_countviolations:' + getFieldTypeText(h.mpsa_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mpsa_bw_agreedamount:' + getFieldTypeText(h.mpsa_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mpsa_cmp_assessedamount:' + getFieldTypeText(h.mpsa_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mpsa_ee_agreedcount:' + getFieldTypeText(h.mpsa_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'osha_countviolations:' + getFieldTypeText(h.osha_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'osha_bw_agreedamount:' + getFieldTypeText(h.osha_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'osha_cmp_assessedamount:' + getFieldTypeText(h.osha_cmp_assessedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'osha_ee_agreedcount:' + getFieldTypeText(h.osha_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pca_countviolations:' + getFieldTypeText(h.pca_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pca_bw_agreedamount:' + getFieldTypeText(h.pca_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pca_ee_agreedcount:' + getFieldTypeText(h.pca_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sca_countviolations:' + getFieldTypeText(h.sca_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sca_bw_agreedamount:' + getFieldTypeText(h.sca_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sca_ee_agreedcount:' + getFieldTypeText(h.sca_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sraw_countviolations:' + getFieldTypeText(h.sraw_countviolations) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sraw_bw_agreedamount:' + getFieldTypeText(h.sraw_bw_agreedamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sraw_ee_agreedcount:' + getFieldTypeText(h.sraw_ee_agreedcount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dartid_cnt
          ,le.populated_dateadded_cnt
          ,le.populated_dateupdated_cnt
          ,le.populated_website_cnt
          ,le.populated_state_cnt
          ,le.populated_caseid_cnt
          ,le.populated_employername_cnt
          ,le.populated_address1_cnt
          ,le.populated_city_cnt
          ,le.populated_employerstate_cnt
          ,le.populated_zipcode_cnt
          ,le.populated_naicscode_cnt
          ,le.populated_totalviolations_cnt
          ,le.populated_bw_totalagreedamount_cnt
          ,le.populated_cmp_totalassessments_cnt
          ,le.populated_ee_totalviolations_cnt
          ,le.populated_ee_totalagreedcount_cnt
          ,le.populated_ca_countviolations_cnt
          ,le.populated_ca_bw_agreedamount_cnt
          ,le.populated_ca_ee_agreedcount_cnt
          ,le.populated_ccpa_countviolations_cnt
          ,le.populated_ccpa_bw_agreedamount_cnt
          ,le.populated_ccpa_ee_agreedcount_cnt
          ,le.populated_crew_countviolations_cnt
          ,le.populated_crew_bw_agreedamount_cnt
          ,le.populated_crew_cmp_assessedamount_cnt
          ,le.populated_crew_ee_agreedcount_cnt
          ,le.populated_cwhssa_countviolations_cnt
          ,le.populated_cwhssa_bw_agreedamount_cnt
          ,le.populated_cwhssa_ee_agreedcount_cnt
          ,le.populated_dbra_cl_countviolations_cnt
          ,le.populated_dbra_bw_agreedamount_cnt
          ,le.populated_dbra_ee_agreedcount_cnt
          ,le.populated_eev_countviolations_cnt
          ,le.populated_eppa_countviolations_cnt
          ,le.populated_eppa_bw_agreedamount_cnt
          ,le.populated_eppa_cmp_assessedamount_cnt
          ,le.populated_eppa_ee_agreedcount_cnt
          ,le.populated_flsa_countviolations_cnt
          ,le.populated_flsa_bw_15a3_agreedamount_cnt
          ,le.populated_flsa_bw_agreedamount_cnt
          ,le.populated_flsa_bw_minwage_agreedamount_cnt
          ,le.populated_flsa_bw_overtime_agreedamount_cnt
          ,le.populated_flsa_cmp_assessedamount_cnt
          ,le.populated_flsa_ee_agreedcount_cnt
          ,le.populated_flsa_cl_countviolations_cnt
          ,le.populated_flsa_cl_countminorsemployed_cnt
          ,le.populated_flsa_cl_cmp_assessedamount_cnt
          ,le.populated_flsa_hmwkr_countviolations_cnt
          ,le.populated_flsa_hmwkr_bw_agreedamount_cnt
          ,le.populated_flsa_hmwkr_cmp_assessedamount_cnt
          ,le.populated_flsa_hmwkr_ee_agreedcount_cnt
          ,le.populated_flsa_smw14_bw_agreedamount_cnt
          ,le.populated_flsa_smw14_countviolations_cnt
          ,le.populated_flsa_smw14_ee_agreedcount_cnt
          ,le.populated_flsa_smwap_countviolations_cnt
          ,le.populated_flsa_smwap_bw_agreedamount_cnt
          ,le.populated_flsa_smwap_ee_agreedcount_cnt
          ,le.populated_flsa_smwft_countviolations_cnt
          ,le.populated_flsa_smwft_bw_agreedamount_cnt
          ,le.populated_flsa_smwft_ee_agreedcount_cnt
          ,le.populated_flsa_smwl_countviolations_cnt
          ,le.populated_flsa_smwl_bw_agreedamount_cnt
          ,le.populated_flsa_smwl_ee_agreedcount_cnt
          ,le.populated_flsa_smwmg_countviolations_cnt
          ,le.populated_flsa_smwmg_bw_agreedamount_cnt
          ,le.populated_flsa_smwmg_ee_agreedcount_cnt
          ,le.populated_flsa_smwpw_countviolations_cnt
          ,le.populated_flsa_smwpw_bw_agreedamount_cnt
          ,le.populated_flsa_smwpw_ee_agreedcount_cnt
          ,le.populated_flsa_smwsl_countviolations_cnt
          ,le.populated_flsa_smwsl_bw_agreedamount_cnt
          ,le.populated_flsa_smwsl_ee_agreedcount_cnt
          ,le.populated_fmla_countviolations_cnt
          ,le.populated_fmla_bw_agreedamount_cnt
          ,le.populated_fmla_cmp_assessedamount_cnt
          ,le.populated_fmla_ee_agreedcount_cnt
          ,le.populated_h1a_countviolations_cnt
          ,le.populated_h1a_bw_agreedamount_cnt
          ,le.populated_h1a_cmp_assessedamount_cnt
          ,le.populated_h1a_ee_agreedcount_cnt
          ,le.populated_h1b_countviolations_cnt
          ,le.populated_h1b_bw_agreedamount_cnt
          ,le.populated_h1b_cmp_assessedamount_cnt
          ,le.populated_h1b_ee_agreedcount_cnt
          ,le.populated_h2a_countviolations_cnt
          ,le.populated_h2a_bw_agreedamount_cnt
          ,le.populated_h2a_cmp_assessedamount_cnt
          ,le.populated_h2a_ee_agreedcount_cnt
          ,le.populated_h2b_countviolations_cnt
          ,le.populated_h2b_bw_agreedamount_cnt
          ,le.populated_h2b_ee_agreedcount_cnt
          ,le.populated_mpsa_countviolations_cnt
          ,le.populated_mpsa_bw_agreedamount_cnt
          ,le.populated_mpsa_cmp_assessedamount_cnt
          ,le.populated_mpsa_ee_agreedcount_cnt
          ,le.populated_osha_countviolations_cnt
          ,le.populated_osha_bw_agreedamount_cnt
          ,le.populated_osha_cmp_assessedamount_cnt
          ,le.populated_osha_ee_agreedcount_cnt
          ,le.populated_pca_countviolations_cnt
          ,le.populated_pca_bw_agreedamount_cnt
          ,le.populated_pca_ee_agreedcount_cnt
          ,le.populated_sca_countviolations_cnt
          ,le.populated_sca_bw_agreedamount_cnt
          ,le.populated_sca_ee_agreedcount_cnt
          ,le.populated_sraw_countviolations_cnt
          ,le.populated_sraw_bw_agreedamount_cnt
          ,le.populated_sraw_ee_agreedcount_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dartid_pcnt
          ,le.populated_dateadded_pcnt
          ,le.populated_dateupdated_pcnt
          ,le.populated_website_pcnt
          ,le.populated_state_pcnt
          ,le.populated_caseid_pcnt
          ,le.populated_employername_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_city_pcnt
          ,le.populated_employerstate_pcnt
          ,le.populated_zipcode_pcnt
          ,le.populated_naicscode_pcnt
          ,le.populated_totalviolations_pcnt
          ,le.populated_bw_totalagreedamount_pcnt
          ,le.populated_cmp_totalassessments_pcnt
          ,le.populated_ee_totalviolations_pcnt
          ,le.populated_ee_totalagreedcount_pcnt
          ,le.populated_ca_countviolations_pcnt
          ,le.populated_ca_bw_agreedamount_pcnt
          ,le.populated_ca_ee_agreedcount_pcnt
          ,le.populated_ccpa_countviolations_pcnt
          ,le.populated_ccpa_bw_agreedamount_pcnt
          ,le.populated_ccpa_ee_agreedcount_pcnt
          ,le.populated_crew_countviolations_pcnt
          ,le.populated_crew_bw_agreedamount_pcnt
          ,le.populated_crew_cmp_assessedamount_pcnt
          ,le.populated_crew_ee_agreedcount_pcnt
          ,le.populated_cwhssa_countviolations_pcnt
          ,le.populated_cwhssa_bw_agreedamount_pcnt
          ,le.populated_cwhssa_ee_agreedcount_pcnt
          ,le.populated_dbra_cl_countviolations_pcnt
          ,le.populated_dbra_bw_agreedamount_pcnt
          ,le.populated_dbra_ee_agreedcount_pcnt
          ,le.populated_eev_countviolations_pcnt
          ,le.populated_eppa_countviolations_pcnt
          ,le.populated_eppa_bw_agreedamount_pcnt
          ,le.populated_eppa_cmp_assessedamount_pcnt
          ,le.populated_eppa_ee_agreedcount_pcnt
          ,le.populated_flsa_countviolations_pcnt
          ,le.populated_flsa_bw_15a3_agreedamount_pcnt
          ,le.populated_flsa_bw_agreedamount_pcnt
          ,le.populated_flsa_bw_minwage_agreedamount_pcnt
          ,le.populated_flsa_bw_overtime_agreedamount_pcnt
          ,le.populated_flsa_cmp_assessedamount_pcnt
          ,le.populated_flsa_ee_agreedcount_pcnt
          ,le.populated_flsa_cl_countviolations_pcnt
          ,le.populated_flsa_cl_countminorsemployed_pcnt
          ,le.populated_flsa_cl_cmp_assessedamount_pcnt
          ,le.populated_flsa_hmwkr_countviolations_pcnt
          ,le.populated_flsa_hmwkr_bw_agreedamount_pcnt
          ,le.populated_flsa_hmwkr_cmp_assessedamount_pcnt
          ,le.populated_flsa_hmwkr_ee_agreedcount_pcnt
          ,le.populated_flsa_smw14_bw_agreedamount_pcnt
          ,le.populated_flsa_smw14_countviolations_pcnt
          ,le.populated_flsa_smw14_ee_agreedcount_pcnt
          ,le.populated_flsa_smwap_countviolations_pcnt
          ,le.populated_flsa_smwap_bw_agreedamount_pcnt
          ,le.populated_flsa_smwap_ee_agreedcount_pcnt
          ,le.populated_flsa_smwft_countviolations_pcnt
          ,le.populated_flsa_smwft_bw_agreedamount_pcnt
          ,le.populated_flsa_smwft_ee_agreedcount_pcnt
          ,le.populated_flsa_smwl_countviolations_pcnt
          ,le.populated_flsa_smwl_bw_agreedamount_pcnt
          ,le.populated_flsa_smwl_ee_agreedcount_pcnt
          ,le.populated_flsa_smwmg_countviolations_pcnt
          ,le.populated_flsa_smwmg_bw_agreedamount_pcnt
          ,le.populated_flsa_smwmg_ee_agreedcount_pcnt
          ,le.populated_flsa_smwpw_countviolations_pcnt
          ,le.populated_flsa_smwpw_bw_agreedamount_pcnt
          ,le.populated_flsa_smwpw_ee_agreedcount_pcnt
          ,le.populated_flsa_smwsl_countviolations_pcnt
          ,le.populated_flsa_smwsl_bw_agreedamount_pcnt
          ,le.populated_flsa_smwsl_ee_agreedcount_pcnt
          ,le.populated_fmla_countviolations_pcnt
          ,le.populated_fmla_bw_agreedamount_pcnt
          ,le.populated_fmla_cmp_assessedamount_pcnt
          ,le.populated_fmla_ee_agreedcount_pcnt
          ,le.populated_h1a_countviolations_pcnt
          ,le.populated_h1a_bw_agreedamount_pcnt
          ,le.populated_h1a_cmp_assessedamount_pcnt
          ,le.populated_h1a_ee_agreedcount_pcnt
          ,le.populated_h1b_countviolations_pcnt
          ,le.populated_h1b_bw_agreedamount_pcnt
          ,le.populated_h1b_cmp_assessedamount_pcnt
          ,le.populated_h1b_ee_agreedcount_pcnt
          ,le.populated_h2a_countviolations_pcnt
          ,le.populated_h2a_bw_agreedamount_pcnt
          ,le.populated_h2a_cmp_assessedamount_pcnt
          ,le.populated_h2a_ee_agreedcount_pcnt
          ,le.populated_h2b_countviolations_pcnt
          ,le.populated_h2b_bw_agreedamount_pcnt
          ,le.populated_h2b_ee_agreedcount_pcnt
          ,le.populated_mpsa_countviolations_pcnt
          ,le.populated_mpsa_bw_agreedamount_pcnt
          ,le.populated_mpsa_cmp_assessedamount_pcnt
          ,le.populated_mpsa_ee_agreedcount_pcnt
          ,le.populated_osha_countviolations_pcnt
          ,le.populated_osha_bw_agreedamount_pcnt
          ,le.populated_osha_cmp_assessedamount_pcnt
          ,le.populated_osha_ee_agreedcount_pcnt
          ,le.populated_pca_countviolations_pcnt
          ,le.populated_pca_bw_agreedamount_pcnt
          ,le.populated_pca_ee_agreedcount_pcnt
          ,le.populated_sca_countviolations_pcnt
          ,le.populated_sca_bw_agreedamount_pcnt
          ,le.populated_sca_ee_agreedcount_pcnt
          ,le.populated_sraw_countviolations_pcnt
          ,le.populated_sraw_bw_agreedamount_pcnt
          ,le.populated_sraw_ee_agreedcount_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,109,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_LaborActions_WHD));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),109,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_LaborActions_WHD) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_LaborActions_WHD, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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

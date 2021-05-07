IMPORT Phone_Shell;

EXPORT Luci_Get_Phone_Model(DATASET(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout) phone_data,
                            UNSIGNED2 Score_Threshold	= Phone_Shell.Constants.Default_PhoneScore,
                            BOOLEAN Validation_Mode = FALSE // not used at the moment because I needed a constant, but...
                            //shell version?
                            //phone model code (e.g. COMMON_SCORE)? 
                            // I was thinking in the future these would help us choose which model to run
                            // but right now there's only one LUCI model. (maybe make this a FUNCTIONMACRO?)
                           ) := FUNCTION
 
  BOOLEAN VALIDATION := FALSE;  
 
  // Gather the standard set of shared model intermediate variables
  shell_plus_ivs := Phone_Shell.Luci_Model_IVs_Function(phone_data); // layout is full phone shell plus full list of model ivs.
  
  // Transform phone shell into the input layout for the LUCI model (the z_Layouts_Input for that particular model)
  LUCI_input := PROJECT(shell_plus_ivs, 
                        TRANSFORM(Phone_Shell.PhoneModel_v31_2.z_layouts_Input,
                                  SELF.TransactionID := (STRING)LEFT.phone_shell.phone_shell.Unique_record_sequence;
                                  SELF.DISC_SCORE := LEFT.model_ivs.disc_score;
                                  SELF.BUR_LAST_UPDATE_MTH := LEFT.model_ivs.BUR_LAST_UPDATE_MTH;
                                  SELF.MINQ_DIDPH_LSEEN_MTH := LEFT.model_ivs.MINQ_DIDPH_LSEEN_MTH;
                                  SELF.INS_VER_FSEEN_MTH := LEFT.model_ivs.INS_VER_FSEEN_MTH;
                                  SELF.MD_CARRIER_GROUPS := LEFT.model_ivs.MD_CARRIER_GROUPS;
                                  SELF.MD_DISC_NO_PORT := LEFT.model_ivs.MD_DISC_NO_PORT;
                                  SELF.MPP_EDA_HIST_DID_DT_MTH := LEFT.model_ivs.MPP_EDA_HIST_DID_DT_MTH;
                                  SELF.MINQ_LSEEN_MTH := LEFT.model_ivs.MINQ_LSEEN_MTH;
                                  SELF.MINQ_FSEEN_MTH := LEFT.model_ivs.MINQ_FSEEN_MTH;
                                  SELF.MPP_SRC_LDATE_GOOD_MTH := LEFT.model_ivs.MPP_SRC_LDATE_GOOD_MTH;
                                  SELF.MPP_SRC_LDATE_OVERALL_MTH := LEFT.model_ivs.MPP_SRC_LDATE_OVERALL_MTH;
                                  SELF.P_SRC_LIST_LDATE_PPLA_MTH := LEFT.model_ivs.P_SRC_LIST_LDATE_PPLA_MTH;
                                  SELF.MPP_RULE_HIGH_CONF_INFUTOR := LEFT.model_ivs.MPP_RULE_HIGH_CONF_INFUTOR;
                                  SELF.MINQ_DIDPH_FSEEN_MTH := LEFT.model_ivs.MINQ_DIDPH_FSEEN_MTH;
                                  SELF.MD_OTP_COUNT_180_DAY := LEFT.model_ivs.MD_OTP_COUNT_180_DAY;
                                  SELF.MPP_CARRIER_GROUPS := LEFT.model_ivs.MPP_CARRIER_GROUPS;
                                  SELF.P_SRC_LIST_CNT := LEFT.model_ivs.P_SRC_LIST_CNT;
                                  SELF.MPP_RULE_CELLPHONE_LATEST := LEFT.model_ivs.MPP_RULE_CELLPHONE_LATEST;
                                  SELF.MPP_DID_COUNT := LEFT.model_ivs.MPP_DID_COUNT;
                                  SELF.MD_OTP_COUNT_730_DAY := LEFT.model_ivs.MD_OTP_COUNT_730_DAY;
                                  SELF.MINQ_SE_LSEEN_MTH := LEFT.model_ivs.MINQ_SE_LSEEN_MTH;
                                  SELF.MEDA_DT_LSEEN_MTH := LEFT.model_ivs.MEDA_DT_LSEEN_MTH;
                                  SELF.MD_LINE_TYPE := (REAL)LEFT.model_ivs.MD_LINE_TYPE;
                                  SELF.MD_DEACT_FLAG := (REAL)LEFT.model_ivs.MD_DEACT_FLAG;
                                  SELF.MD_SWAP_FLAG := (REAL)LEFT.model_ivs.MD_SWAP_FLAG;
                                  SELF.P_SRC_LIST_TOF_PPDID_MTH := LEFT.model_ivs.P_SRC_LIST_TOF_PPDID_MTH;
                                  SELF.P_SRC_LIST_FDATE_PPLA_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_PPLA_MTH;
                                  SELF.P_SRC_LIST_LDATE_PPFLA_MTH := LEFT.model_ivs.P_SRC_LIST_LDATE_PPFLA_MTH;
                                  SELF.MINQ_CNT := LEFT.model_ivs.MINQ_CNT;
                                  SELF.P_SRC_LIST_FDATE_PPDID_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_PPDID_MTH;
                                  SELF.P_SRC_LIST_LDATE_PPDID_MTH := LEFT.model_ivs.P_SRC_LIST_LDATE_PPDID_MTH;
                                  SELF.P_PHONE_MATCH_CODE_NAME := LEFT.model_ivs.P_PHONE_MATCH_CODE_NAME;
                                  SELF.MPP_SRC_FDATE_GOOD_MTH := LEFT.model_ivs.MPP_SRC_FDATE_GOOD_MTH;
                                  SELF.MPP_SRC_FDATE_IQ_MTH := LEFT.model_ivs.MPP_SRC_FDATE_IQ_MTH;
                                  SELF.MD_OTP_COUNT_365_DAY := LEFT.model_ivs.MD_OTP_COUNT_365_DAY;
                                  SELF.P_PHONE_MATCH_CODE_ADDR := LEFT.model_ivs.P_PHONE_MATCH_CODE_ADDR;
                                  SELF.MEDA_DAYS_PH_FIRST_SEEN := LEFT.model_ivs.MEDA_DAYS_PH_FIRST_SEEN;
                                  SELF.P_SRC_LIST_TOF_PPFLA_MTH := LEFT.model_ivs.P_SRC_LIST_TOF_PPFLA_MTH;
                                  SELF.P_SRC_LIST_LDATE_PPCA_MTH := LEFT.model_ivs.P_SRC_LIST_LDATE_PPCA_MTH;
                                  SELF.MPP_SRC_LDATE_IQ_MTH := LEFT.model_ivs.MPP_SRC_LDATE_IQ_MTH;
                                  SELF.P_SRC_LIST_FDATE_PPCA_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_PPCA_MTH;
                                  SELF.P_PHONE_SWITCH_TYPE := LEFT.model_ivs.P_PHONE_SWITCH_TYPE;
                                  SELF.INS_VER := (REAL)LEFT.model_ivs.INS_VER;
                                  SELF.MPP_SRC_FDATE_OVERALL_MTH := LEFT.model_ivs.MPP_SRC_FDATE_OVERALL_MTH;
                                  SELF.P_SRC_LIST_FDATE_PAW_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_PAW_MTH;
                                  SELF.MPP_EDA_HIST_PH_DT_MTH := LEFT.model_ivs.MPP_EDA_HIST_PH_DT_MTH;
                                  SELF.MPP_SRC_TOF_GOOD_MTH := LEFT.model_ivs.MPP_SRC_TOF_GOOD_MTH;
                                  SELF.MEDA_DT_FSEEN_MTH := LEFT.model_ivs.MEDA_DT_FSEEN_MTH;
                                  SELF.P_SRC_LIST_LDATE_EQP_MTH := LEFT.model_ivs.P_SRC_LIST_LDATE_EQP_MTH;
                                  SELF.MD_SERV_TYPE := (REAL)LEFT.model_ivs.MD_SERV_TYPE;
                                  SELF.P_SRC_LIST_TOF_EQP_MTH := LEFT.model_ivs.P_SRC_LIST_TOF_EQP_MTH;
                                  SELF.MEDA_TOF_MTH := LEFT.model_ivs.MEDA_TOF_MTH;
                                  SELF.P_SRC_LIST_TOF_PPCA_MTH := LEFT.model_ivs.P_SRC_LIST_TOF_PPCA_MTH;
                                  SELF.MPP_ORIGPHONETYPE := LEFT.model_ivs.MPP_ORIGPHONETYPE;
                                  SELF.P_SRC_LIST_FDATE_UTILDID_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_UTILDID_MTH;
                                  SELF.MD_ACTIVE := LEFT.model_ivs.MD_ACTIVE;
                                  SELF.P_SRC_LIST_FDATE_PPFLA_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_PPFLA_MTH;
                                  SELF.MEDA_MAX_DAYS_INTERRUPT := LEFT.model_ivs.MEDA_MAX_DAYS_INTERRUPT;
                                  SELF.MD_GOOD_RECENT_ACT := LEFT.model_ivs.MD_GOOD_RECENT_ACT;
                                  SELF.INS_VER_TOF_MTH := LEFT.model_ivs.INS_VER_TOF_MTH;
                                  SELF.MPP_APP_COMPANY_TYPE := LEFT.model_ivs.MPP_APP_COMPANY_TYPE;
                                  SELF.MD_REACT_FLAG := (REAL)LEFT.model_ivs.MD_REACT_FLAG;
                                  SELF.MPP_MIN_SCORE_INFUTOR := LEFT.model_ivs.MPP_MIN_SCORE_INFUTOR;
                                  SELF.MEDA_DAYS_IN_SERVICE := LEFT.model_ivs.MEDA_DAYS_IN_SERVICE;
                                  SELF.MEDA_AVG_DAYS_INTERRUPT := LEFT.model_ivs.MEDA_AVG_DAYS_INTERRUPT;
                                  SELF.MPP_RULE_NEU_ACTIVE_MTH := LEFT.model_ivs.MPP_RULE_NEU_ACTIVE_MTH;
                                  SELF.P_SRC_LIST_TOF_INF_MTH := LEFT.model_ivs.P_SRC_LIST_TOF_INF_MTH;
                                  SELF.MINQ_DIDPH_CNT := LEFT.model_ivs.MINQ_DIDPH_CNT;
                                  SELF.MINQ_SE_DID_CNT := LEFT.model_ivs.MINQ_SE_DID_CNT;
                                  SELF.MEDA_NUM_PHS_DISCON_HHID := LEFT.model_ivs.MEDA_NUM_PHS_DISCON_HHID;
                                  SELF.MPP_MAX_SCORE_INFUTOR := LEFT.model_ivs.MPP_MAX_SCORE_INFUTOR;
                                  SELF.MEDA_NUM_PHS_DISCON_ADDR := LEFT.model_ivs.MEDA_NUM_PHS_DISCON_ADDR;
                                  SELF.MPP_RULE_INS_VER_ABOVE := LEFT.model_ivs.MPP_RULE_INS_VER_ABOVE;
                                  SELF.MEDA_MIN_DAYS_INTERRUPT := LEFT.model_ivs.MEDA_MIN_DAYS_INTERRUPT;
                                  SELF.P_PHONE_SUBJECT_TITLE_GROUP2 := LEFT.model_ivs.P_PHONE_SUBJECT_TITLE_GROUP2;
                                  SELF.MEDA_BDID_FLAG := LEFT.model_ivs.MEDA_BDID_FLAG;
                                  SELF.MINQ_ADDR_CNT := LEFT.model_ivs.MINQ_ADDR_CNT;
                                  SELF.P_SRC_LIST_TOF_PPLA_MTH := LEFT.model_ivs.P_SRC_LIST_TOF_PPLA_MTH;
                                  SELF.P_PHONE_ZIP_MATCH := LEFT.model_ivs.P_PHONE_ZIP_MATCH;
                                  SELF.MINQ_DID_CNT := LEFT.model_ivs.MINQ_DID_CNT;
                                  SELF.P_PHONE_SUBJECT_LEVEL := LEFT.model_ivs.P_PHONE_SUBJECT_LEVEL;
                                  SELF.MD_PORT_FLAG := (REAL)LEFT.model_ivs.MD_PORT_FLAG;
                                  SELF.MD_OTP_COUNT_90_DAY := LEFT.model_ivs.MD_OTP_COUNT_90_DAY;
                                  SELF.P_PHONE_MATCH_CODE_SSN := LEFT.model_ivs.P_PHONE_MATCH_CODE_SSN;
                                  SELF.P_PHONE_TIMEZONE_MATCH := LEFT.model_ivs.P_PHONE_TIMEZONE_MATCH;
                                  SELF.MEDA_NUM_INTERRUPTS_CUR := LEFT.model_ivs.MEDA_NUM_INTERRUPTS_CUR;
                                  SELF.MPP_RULE_INS_VER := LEFT.model_ivs.MPP_RULE_INS_VER;
                                  SELF.MD_CARRIER_GROUPS_DISC := LEFT.model_ivs.MD_CARRIER_GROUPS_DISC;
                                  SELF.MPP_ORIGLISTING_TYPE := LEFT.model_ivs.MPP_ORIGLISTING_TYPE;
                                  SELF.MEDA_DID_FLAG := LEFT.model_ivs.MEDA_DID_FLAG;
                                  SELF.MPP_ORIG_SCORE_INFUTOR := LEFT.model_ivs.MPP_ORIG_SCORE_INFUTOR;
                                  SELF.MPP_EDA_HIST_NM_ADDR_DT_MTH := LEFT.model_ivs.MPP_EDA_HIST_NM_ADDR_DT_MTH;
                                  SELF.MPP_RULE_F1_VER_BELOW := LEFT.model_ivs.MPP_RULE_F1_VER_BELOW;
                                  SELF.P_SRC_LIST_LDATE_PAW_MTH := LEFT.model_ivs.P_SRC_LIST_LDATE_PAW_MTH;
                                  SELF.P_SRC_LIST_FDATE_EQP_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_EQP_MTH;
                                  SELF.MPP_CARRIER_GROUPS_DISC := LEFT.model_ivs.MPP_CARRIER_GROUPS_DISC;
                                  SELF.MPP_SRC_VEND_FDATE_N2_MTH := LEFT.model_ivs.MPP_SRC_VEND_FDATE_N2_MTH;
                                  SELF.MINQ_CNT_06 := LEFT.model_ivs.MINQ_CNT_06;
                                  SELF.P_PHONE_MATCH_CODE_CITY := LEFT.model_ivs.P_PHONE_MATCH_CODE_CITY;
                                  SELF.MPP_SRC_LDATE_EN_MTH := LEFT.model_ivs.MPP_SRC_LDATE_EN_MTH;
                                  SELF.MEDA_NUM_PHS_CONNECTED_HHID := LEFT.model_ivs.MEDA_NUM_PHS_CONNECTED_HHID;
                                  SELF.MPP_SRC_LDATE_IR_MTH := LEFT.model_ivs.MPP_SRC_LDATE_IR_MTH;
                                  SELF.MPP_SRC_GOOD_CNT := LEFT.model_ivs.MPP_SRC_GOOD_CNT;
                                  SELF.MPP_SRC_N2 := (REAL)LEFT.model_ivs.MPP_SRC_N2;
                                  SELF.MEDA_DT_DELETION_MTH := LEFT.model_ivs.MEDA_DT_DELETION_MTH;
                                  SELF.P_SRC_LIST_FDATE_EDADID_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_EDADID_MTH;
                                  SELF.MPP_SRC_FDATE_IR_MTH := LEFT.model_ivs.MPP_SRC_FDATE_IR_MTH;
                                  SELF.MPP_SRC_LDATE_UT_MTH := LEFT.model_ivs.MPP_SRC_LDATE_UT_MTH;
                                  SELF.MPP_SRC_VEND_FDATE_UW_MTH := LEFT.model_ivs.MPP_SRC_VEND_FDATE_UW_MTH;
                                  SELF.MPP_RP_CARRIER_GROUPS := LEFT.model_ivs.MPP_RP_CARRIER_GROUPS;
                                  SELF.MPP_RULE_INFUTOR := LEFT.model_ivs.MPP_RULE_INFUTOR;
                                  SELF.MEDA_NUM_PH_OWNERS_HIST := LEFT.model_ivs.MEDA_NUM_PH_OWNERS_HIST;
                                  SELF.MINQ_INDUS_12_AUTO := (REAL)LEFT.model_ivs.MINQ_INDUS_12_AUTO;
                                  SELF.MPP_SRC_LDATE_BAD_MTH := LEFT.model_ivs.MPP_SRC_LDATE_BAD_MTH;
                                  SELF.MPP_ORIGPHONEUSAGE := LEFT.model_ivs.MPP_ORIGPHONEUSAGE;
                                  SELF.P_PHONE_MATCH_CODE_ZIP := LEFT.model_ivs.P_PHONE_MATCH_CODE_ZIP;
                                  SELF.MEDA_PFRD_ADDR_LISTTYPE_ZIP := LEFT.model_ivs.MEDA_PFRD_ADDR_LISTTYPE_ZIP;
                                  SELF.P_SRC_LIST_FDATE_INF_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_INF_MTH;
                                  SELF.MPP_SRC_VEND_FDATE_UT_MTH := LEFT.model_ivs.MPP_SRC_VEND_FDATE_UT_MTH;
                                  SELF.MEDA_MIN_DAYS_CONNECTED_IND := LEFT.model_ivs.MEDA_MIN_DAYS_CONNECTED_IND;
                                  SELF.P_SRC_LIST_TOF_UTILDID_MTH := LEFT.model_ivs.P_SRC_LIST_TOF_UTILDID_MTH;
                                  SELF.P_SOURCE_PP_ANY := LEFT.model_ivs.P_SOURCE_PP_ANY;
                                  SELF.P_SRC_LIST_FDATE_SX_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_SX_MTH;
                                  SELF.MPP_SRC_CNT := LEFT.model_ivs.MPP_SRC_CNT;
                                  SELF.P_PHONE_SUBJECT_TITLE_GROUP := LEFT.model_ivs.P_PHONE_SUBJECT_TITLE_GROUP;
                                  SELF.MPP_RULE_INQ_LEX_MATCH := LEFT.model_ivs.MPP_RULE_INQ_LEX_MATCH;
                                  SELF.MPP_SRC_VEND_LDATE_IR_MTH := LEFT.model_ivs.MPP_SRC_VEND_LDATE_IR_MTH;
                                  SELF.MEDA_HAS_CUR_DISCON_15_DAYS := (REAL)LEFT.model_ivs.MEDA_HAS_CUR_DISCON_15_DAYS;
                                  SELF.MPP_SRC_VEND_LDATE_UT_MTH := LEFT.model_ivs.MPP_SRC_VEND_LDATE_UT_MTH;
                                  SELF.MINQ_INDUS_12_DAY := (REAL)LEFT.model_ivs.MINQ_INDUS_12_DAY;
                                  SELF.MD_PHONE_TYPE := LEFT.model_ivs.MD_PHONE_TYPE;
                                  SELF.PF_RP_RESULT := LEFT.model_ivs.PF_RP_RESULT;
                                  SELF.MEDA_NUM_PHS_IND := LEFT.model_ivs.MEDA_NUM_PHS_IND;
                                  SELF.MEDA_CURRENT_EDA_FLAG := (REAL)LEFT.model_ivs.MEDA_CURRENT_EDA_FLAG;
                                  SELF.MEDA_HAS_CUR_DISCON_180_DAYS := (REAL)LEFT.model_ivs.MEDA_HAS_CUR_DISCON_180_DAYS;
                                  SELF.P_PHONE_MATCH_CODE_LEX := LEFT.model_ivs.P_PHONE_MATCH_CODE_LEX;
                                  SELF.P_SRC_LIST_TOF_PAW_MTH := LEFT.model_ivs.P_SRC_LIST_TOF_PAW_MTH;
                                  SELF.MPP_RULE_F1_VER := LEFT.model_ivs.MPP_RULE_F1_VER;
                                  SELF.MPP_SRC_VEND_FDATE_IR_MTH := LEFT.model_ivs.MPP_SRC_VEND_FDATE_IR_MTH;
                                  SELF.MPP_RULE_F1_VER_ABOVE := LEFT.model_ivs.MPP_RULE_F1_VER_ABOVE;
                                  SELF.MPP_SRC_VEND_FDATE_IQ_MTH := LEFT.model_ivs.MPP_SRC_VEND_FDATE_IQ_MTH;
                                  SELF.MPP_SRC_FDATE_UT_MTH := LEFT.model_ivs.MPP_SRC_FDATE_UT_MTH;
                                  SELF.MPP_RULE_MED_VEND_CONF_CELL := LEFT.model_ivs.MPP_RULE_MED_VEND_CONF_CELL;
                                  SELF.MPP_APP_COMPANY_TYPE_CELL := LEFT.model_ivs.MPP_APP_COMPANY_TYPE_CELL;
                                  SELF.P_SRC_LIST_FDATE_NE_MTH := LEFT.model_ivs.P_SRC_LIST_FDATE_NE_MTH;
                                  SELF.MPP_RP_TYPE := LEFT.model_ivs.MPP_RP_TYPE;
                                  SELF.P_DISCONNECT_FLAG := LEFT.model_ivs.P_DISCONNECT_FLAG;
                                  SELF.MPP_RULE_SOURCE_LATEST := LEFT.model_ivs.MPP_RULE_SOURCE_LATEST;
                                  SELF.MPP_TYPE_MOBILE := LEFT.model_ivs.MPP_TYPE_MOBILE;
                                  SELF.P_SRC_LIST_LDATE_INF_MTH := LEFT.model_ivs.P_SRC_LIST_LDATE_INF_MTH;
                                  SELF.MPP_EDA_MATCH_DID := LEFT.model_ivs.MPP_EDA_MATCH_DID;
                                  SELF.MEDA_IS_CURRENT_IN_HIST := (REAL)LEFT.model_ivs.MEDA_IS_CURRENT_IN_HIST;
                                  SELF.MPP_SRC_VEND_LDATE_UW_MTH := LEFT.model_ivs.MPP_SRC_VEND_LDATE_UW_MTH;
                                  SELF.MEDA_HHID_FLAG := LEFT.model_ivs.MEDA_HHID_FLAG;
                                  SELF.MEDA_HAS_CUR_DISCON_90_DAYS := (REAL)LEFT.model_ivs.MEDA_HAS_CUR_DISCON_90_DAYS;
                                  SELF.MINQ_INDUS_12_PAY := (REAL)LEFT.model_ivs.MINQ_INDUS_12_PAY;
                                  SELF.MPP_SRC_VEND_LDATE_IQ_MTH := LEFT.model_ivs.MPP_SRC_VEND_LDATE_IQ_MTH;
                                  SELF.PF_RP_DATE_MTH := LEFT.model_ivs.PF_RP_DATE_MTH;
                                  SELF.P_SRC_LIST_UTILDID := (REAL)LEFT.model_ivs.P_SRC_LIST_UTILDID;
                                  SELF.MEDA_AVG_DAYS_CONNECTED_IND := LEFT.model_ivs.MEDA_AVG_DAYS_CONNECTED_IND;
                                  SELF.MPP_SRC_UW := (REAL)LEFT.model_ivs.MPP_SRC_UW;
                                  SELF.MEDA_HAS_CUR_DISCON_60_DAYS := (REAL)LEFT.model_ivs.MEDA_HAS_CUR_DISCON_60_DAYS;
                                  SELF.MPP_RULE_INQ_1YR := LEFT.model_ivs.MPP_RULE_INQ_1YR;
                                  SELF.P_PHONE_SWITCH_TYPE_CELL := LEFT.model_ivs.P_PHONE_SWITCH_TYPE_CELL;
                                  SELF.MINQ_ADDR_CNT_06 := LEFT.model_ivs.MINQ_ADDR_CNT_06;
                                  SELF.P_PHONE_MATCH_CODE_ST := LEFT.model_ivs.P_PHONE_MATCH_CODE_ST;
                                  SELF.MPP_SRC_BAD := LEFT.model_ivs.MPP_SRC_BAD;
                                  SELF.P_SRC_LIST_PPLA := (REAL)LEFT.model_ivs.P_SRC_LIST_PPLA;
                                  SELF.MEDA_DAYS_IND_FIRST_SEEN := LEFT.model_ivs.MEDA_DAYS_IND_FIRST_SEEN;
                                  SELF.MPP_RULE_INQ_LEX_DIFF := LEFT.model_ivs.MPP_RULE_INQ_LEX_DIFF;
                                  SELF.MEDA_MONTHS_ADDR_LAST_SEEN := LEFT.model_ivs.MEDA_MONTHS_ADDR_LAST_SEEN;
                                  SELF.MPP_RP_CARRIER_GROUPS_DISC := LEFT.model_ivs.MPP_RP_CARRIER_GROUPS_DISC;
                                  SELF.MPP_LISTING_TYPE := LEFT.model_ivs.MPP_LISTING_TYPE;
                                  SELF.MPP_RULE_DISCONNECTED_EDA := LEFT.model_ivs.MPP_RULE_DISCONNECTED_EDA;
                                  SELF.PF_RP_LAST_RPC_DATE_MTH := LEFT.model_ivs.PF_RP_LAST_RPC_DATE_MTH;
                                  SELF.MEDA_HAS_CUR_DISCON_30_DAYS := (REAL)LEFT.model_ivs.MEDA_HAS_CUR_DISCON_30_DAYS;
                                  SELF.P_SOURCE_EDA_ANY := LEFT.model_ivs.P_SOURCE_EDA_ANY;
                                  SELF.MEDA_NUM_PH_OWNERS_CUR := LEFT.model_ivs.MEDA_NUM_PH_OWNERS_CUR;

                                  SELF := []) // because z_layouts_Input includes LUCI intermediate variables too, we'll leave those blank
                       );
              
 // need a validation mode constant so I can use #IF, like Frank's example. Or maybe split this out into a couple functions?
 #IF(VALIDATION)
  // In validation mode, just return the 'debug' layout of the LUCI model (includes the intermediate variables, does not include original shell)
  // This is *not* in z_layouts_Input, but should easily be turned into it for validation purposes.
  model_output := Phone_Shell.PhoneModel_v31_2.AsResults(LUCI_input).ValidationF();
 #ELSE
  // Normal mode, get the score from the LUCI model
  model_output_score := Phone_Shell.PhoneModel_v31_2.AsResults(LUCI_input).Base();
  
  // Add the score back in to the original phone shell data (this will also remove our temporary counter/transaction id)
  model_output_all := JOIN(shell_plus_ivs, model_output_score,
                           (STRING)LEFT.phone_shell.Phone_Shell.Unique_Record_Sequence = RIGHT.TransactionID,
                           TRANSFORM(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout,
                                     SELF.Phone_Shell.Phone_Model_Score := RIGHT.Score;
                                     SELF := LEFT.Phone_Shell), ATMOST(1)); // inner join, expect one score per record of data

  // Now apply the Score Threshold as we usually do (any phones that score too low are dropped; send in a 0 threshold to get all phones).
  model_output := model_output_all((INTEGER)Phone_Shell.Phone_Model_Score >= Score_Threshold);
 #END 
 
  RETURN model_output;
END;
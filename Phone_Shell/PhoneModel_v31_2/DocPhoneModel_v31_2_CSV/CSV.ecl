

Phone Scoring Model 07(PhoneModel_v31_2)

Whole Model Information

This is a single scorecard model.
This model uses reason method DescendingNoFilter.
LUCI made the following notes while compiling the .CSV: 
Line: 1, Severity: WARNING, Message: No valid reason method specified; DescendingNoFilter assumed
Line: 8038, Severity: WARNING, Message: Contributions provided without reason codes defined for variables
Line: 8038, Severity: WARNING, Message: No usages were found for the following split variables: [P_SRC_LIST_FDATE_EQP_MTH,MPP_SRC_N2,P_SRC_LIST_FDATE_EDADID_MTH,MPP_RP_CARRIER_GROUPS,P_SOURCE_PP_ANY,MEDA_CURRENT_EDA_FLAG,MEDA_HAS_CUR_DISCON_180_DAYS,P_SRC_LIST_FDATE_NE_MTH,MPP_TYPE_MOBILE,P_SRC_LIST_LDATE_INF_MTH,MEDA_HHID_FLAG,MEDA_HAS_CUR_DISCON_90_DAYS,PF_RP_DATE_MTH,P_SRC_LIST_UTILDID,MEDA_AVG_DAYS_CONNECTED_IND,MPP_SRC_UW,MINQ_ADDR_CNT_06,P_PHONE_MATCH_CODE_ST,MPP_SRC_BAD,P_SRC_LIST_PPLA,MEDA_DAYS_IND_FIRST_SEEN,MPP_RULE_INQ_LEX_DIFF,MPP_RP_CARRIER_GROUPS_DISC,MPP_LISTING_TYPE,PF_RP_LAST_RPC_DATE_MTH,MEDA_HAS_CUR_DISCON_30_DAYS,P_SOURCE_EDA_ANY]






ScoreCard - OVERALL
This scorecard is a forest; there are 291 trees and the maximum depth is 26.
The individual tree scores are combined using addition. This is typical of boosted trees or simple decision trees.
Raw_point is then calculated by adding the Combined_score to the Constant 0.0
The score is then processed according to the formula (700 + 50 * ((Raw_point - 0.0 - -1.074512) / LN(2))).
The value is then rounded to the nearest integer.
If the value is less than 1 it is set to 1.
If the value is greater than 999 it is set to 999.



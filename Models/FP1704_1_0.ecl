import Std, risk_indicators, riskwise, riskwisefcra, ut, easi, Models;


export FP1704_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		FP_DEBUG := False;
		// FP_DEBUG := True;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	                   INTEGER  sysdate                                ;    // sysdate;
                      INTEGER ver_src_am_pos                         ;    // ver_src_am_pos;
                      BOOLEAN ver_src_am                             ;    // ver_src_am;
                      INTEGER ver_src_ar_pos                         ;    // ver_src_ar_pos;
                      BOOLEAN ver_src_ar                             ;    // ver_src_ar;
                      INTEGER ver_src_ba_pos                         ;    // ver_src_ba_pos;
                      BOOLEAN ver_src_ba                             ;    // ver_src_ba;
                      INTEGER ver_src_cg_pos                         ;    // ver_src_cg_pos;
                      BOOLEAN ver_src_cg                             ;    // ver_src_cg;
                      INTEGER ver_src_da_pos                         ;    // ver_src_da_pos;
                      BOOLEAN ver_src_da                             ;    // ver_src_da;
                      INTEGER ver_src_d_pos                          ;    // ver_src_d_pos;
                      BOOLEAN ver_src_d                              ;    // ver_src_d;
                      INTEGER ver_src_dl_pos                         ;    // ver_src_dl_pos;
                      BOOLEAN ver_src_dl                             ;    // ver_src_dl;
                      INTEGER ver_src_eb_pos                         ;    // ver_src_eb_pos;
                      BOOLEAN ver_src_eb                             ;    // ver_src_eb;
                      INTEGER ver_src_e1_pos                         ;    // ver_src_e1_pos;
                      BOOLEAN ver_src_e1                             ;    // ver_src_e1;
                      INTEGER ver_src_e2_pos                         ;    // ver_src_e2_pos;
                      BOOLEAN ver_src_e2                             ;    // ver_src_e2;
                      INTEGER  ver_src_e3_pos                         ;    // ver_src_e3_pos;
                      BOOLEAN ver_src_e3                             ;    // ver_src_e3;
                      INTEGER ver_src_en_pos                         ;    // ver_src_en_pos;
                      STRING _ver_src_fdate_en                      ;    // _ver_src_fdate_en;
                      INTEGER  ver_src_fdate_en                       ;    // ver_src_fdate_en;
                      INTEGER  ver_src_eq_pos                         ;    // ver_src_eq_pos;
                      STRING _ver_src_fdate_eq                      ;    // _ver_src_fdate_eq;
                      INTEGER  ver_src_fdate_eq                       ;    // ver_src_fdate_eq;
                      INTEGER  ver_src_fe_pos                         ;    // ver_src_fe_pos;
                      BOOLEAN ver_src_fe                             ;    // ver_src_fe;
                      INTEGER  ver_src_ff_pos                         ;    // ver_src_ff_pos;
                      BOOLEAN ver_src_ff                             ;    // ver_src_ff;
                      INTEGER  ver_src_p_pos                          ;    // ver_src_p_pos;
                      BOOLEAN ver_src_p                              ;    // ver_src_p;
                      INTEGER  ver_src_pl_pos                         ;    // ver_src_pl_pos;
                      BOOLEAN ver_src_pl                             ;    // ver_src_pl;
                      INTEGER   ver_src_tn_pos                         ;    // ver_src_tn_pos;
                      STRING _ver_src_fdate_tn                      ;    // _ver_src_fdate_tn;
                      INTEGER ver_src_fdate_tn                       ;    // ver_src_fdate_tn;
                      INTEGER ver_src_sl_pos                         ;    // ver_src_sl_pos;
                      BOOLEAN ver_src_sl                             ;    // ver_src_sl;
                      INTEGER ver_src_v_pos                          ;    // ver_src_v_pos;
                      BOOLEAN ver_src_v                              ;    // ver_src_v;
                      INTEGER ver_src_vo_pos                         ;    // ver_src_vo_pos;
                      BOOLEAN ver_src_vo                             ;    // ver_src_vo;
                      INTEGER ver_src_w_pos                          ;    // ver_src_w_pos;
                      BOOLEAN ver_src_w                              ;    // ver_src_w;
                      INTEGER ver_fname_src_en_pos                   ;    // ver_fname_src_en_pos;
                      BOOLEAN ver_fname_src_en                       ;    // ver_fname_src_en;
                      INTEGER ver_fname_src_eq_pos                   ;    // ver_fname_src_eq_pos;
                      BOOLEAN ver_fname_src_eq                       ;    // ver_fname_src_eq;
                      INTEGER ver_fname_src_tn_pos                   ;    // ver_fname_src_tn_pos;
                      BOOLEAN ver_fname_src_tn                       ;    // ver_fname_src_tn;
                      INTEGER ver_fname_src_ts_pos                   ;    // ver_fname_src_ts_pos;
                      BOOLEAN ver_fname_src_ts                       ;    // ver_fname_src_ts;
                      INTEGER ver_fname_src_tu_pos                   ;    // ver_fname_src_tu_pos;
                      BOOLEAN ver_fname_src_tu                       ;    // ver_fname_src_tu;
                      INTEGER ver_lname_src_en_pos                   ;    // ver_lname_src_en_pos;
                      BOOLEAN ver_lname_src_en                       ;    // ver_lname_src_en;
                      INTEGER ver_lname_src_eq_pos                   ;    // ver_lname_src_eq_pos;
                      BOOLEAN ver_lname_src_eq                       ;    // ver_lname_src_eq;
                      INTEGER ver_lname_src_tn_pos                   ;    // ver_lname_src_tn_pos;
                      BOOLEAN ver_lname_src_tn                       ;    // ver_lname_src_tn;
                      INTEGER ver_lname_src_ts_pos                   ;    // ver_lname_src_ts_pos;
                      BOOLEAN ver_lname_src_ts                       ;    // ver_lname_src_ts;
                      INTEGER ver_lname_src_tu_pos                   ;    // ver_lname_src_tu_pos;
                      BOOLEAN ver_lname_src_tu                       ;    // ver_lname_src_tu;
                      INTEGER ver_addr_src_en_pos                    ;    // ver_addr_src_en_pos;
                      BOOLEAN ver_addr_src_en                        ;    // ver_addr_src_en;
                      INTEGER ver_addr_src_eq_pos                    ;    // ver_addr_src_eq_pos;
                      BOOLEAN ver_addr_src_eq                        ;    // ver_addr_src_eq;
                      INTEGER ver_addr_src_tn_pos                    ;    // ver_addr_src_tn_pos;
                      BOOLEAN ver_addr_src_tn                        ;    // ver_addr_src_tn;
                      INTEGER ver_addr_src_ts_pos                    ;    // ver_addr_src_ts_pos;
                      BOOLEAN ver_addr_src_ts                        ;    // ver_addr_src_ts;
                      INTEGER ver_addr_src_tu_pos                    ;    // ver_addr_src_tu_pos;
                      BOOLEAN ver_addr_src_tu                        ;    // ver_addr_src_tu;
                      INTEGER ver_ssn_src_en_pos                     ;    // ver_ssn_src_en_pos;
                      BOOLEAN ver_ssn_src_en                         ;    // ver_ssn_src_en;
                      INTEGER ver_ssn_src_eq_pos                     ;    // ver_ssn_src_eq_pos;
                      BOOLEAN ver_ssn_src_eq                         ;    // ver_ssn_src_eq;
                      INTEGER ver_ssn_src_tn_pos                     ;    // ver_ssn_src_tn_pos;
                      BOOLEAN ver_ssn_src_tn                         ;    // ver_ssn_src_tn;
                      INTEGER ver_ssn_src_ts_pos                     ;    // ver_ssn_src_ts_pos;
                      BOOLEAN ver_ssn_src_ts                         ;    // ver_ssn_src_ts;
                      INTEGER ver_ssn_src_tu_pos                     ;    // ver_ssn_src_tu_pos;
                      BOOLEAN ver_ssn_src_tu                         ;    // ver_ssn_src_tu;
                      INTEGER ver_dob_src_en_pos                     ;    // ver_dob_src_en_pos;
                      BOOLEAN ver_dob_src_en                         ;    // ver_dob_src_en;
                      INTEGER ver_dob_src_eq_pos                     ;    // ver_dob_src_eq_pos;
                      BOOLEAN ver_dob_src_eq                         ;    // ver_dob_src_eq;
                      INTEGER ver_dob_src_tn_pos                     ;    // ver_dob_src_tn_pos;
                      BOOLEAN ver_dob_src_tn                         ;    // ver_dob_src_tn;
                      INTEGER ver_dob_src_ts_pos                     ;    // ver_dob_src_ts_pos;
                      BOOLEAN ver_dob_src_ts                         ;    // ver_dob_src_ts;
                      INTEGER ver_dob_src_tu_pos                     ;    // ver_dob_src_tu_pos;
                      BOOLEAN ver_dob_src_tu                         ;    // ver_dob_src_tu;
                      STRING iv_add_apt                             ;    // iv_add_apt;
                      INTEGER sum_src_credentialed                   ;    // sum_src_credentialed;
                      Boolean beta_synthid_trigger_v2                ;    // beta_synthid_trigger_v2;
                      INTEGER earliest_bur_date_all                  ;    // earliest_bur_date_all;
                      Integer ca_m_bureau_fs                         ;    // ca_m_bureau_fs;
                      Integer nf_addrs_per_ssn                       ;    // nf_addrs_per_ssn;
                      INTEGER rv_a41_a42_prop_owner_history          ;    // rv_a41_a42_prop_owner_history;
                     Integer ca_inq_perssn_count01                  ;    // ca_inq_perssn_count01;
                      INTEGER rv_s66_adlperssn_count                 ;    // rv_s66_adlperssn_count;
                      INTEGER rv_i60_inq_count12                     ;    // rv_i60_inq_count12;
                      INTEGER rv_i60_credit_seeking                  ;    // rv_i60_credit_seeking;
                      INTEGER rv_i60_inq_recency                     ;    // rv_i60_inq_recency;
                      INTEGER rv_i61_inq_collection_count12          ;    // rv_i61_inq_collection_count12;
                      INTEGER rv_i61_inq_collection_recency          ;    // rv_i61_inq_collection_recency;
                      INTEGER rv_i60_inq_auto_count12                ;    // rv_i60_inq_auto_count12;
                      INTEGER rv_i60_inq_auto_recency                ;    // rv_i60_inq_auto_recency;
                      INTEGER rv_i60_inq_banking_count12             ;    // rv_i60_inq_banking_count12;
                      INTEGER rv_i60_inq_banking_recency             ;    // rv_i60_inq_banking_recency;
                      INTEGER rv_i60_inq_mortgage_count12            ;    // rv_i60_inq_mortgage_count12;
                      INTEGER rv_i60_inq_mortgage_recency            ;    // rv_i60_inq_mortgage_recency;
                      INTEGER rv_i60_inq_hiriskcred_count12          ;    // rv_i60_inq_hiriskcred_count12;
                      INTEGER rv_i60_inq_hiriskcred_recency          ;    // rv_i60_inq_hiriskcred_recency;
                      INTEGER rv_i60_inq_prepaidcards_count12        ;    // rv_i60_inq_prepaidcards_count12;
                      INTEGER rv_i60_inq_prepaidcards_recency        ;    // rv_i60_inq_prepaidcards_recency;
                      INTEGER rv_i60_inq_retail_count12              ;    // rv_i60_inq_retail_count12;
                      INTEGER rv_i60_inq_retail_recency              ;    // rv_i60_inq_retail_recency;
                      INTEGER rv_i60_inq_retpymt_count12             ;    // rv_i60_inq_retpymt_count12;
                      INTEGER rv_i60_inq_retpymt_recency             ;    // rv_i60_inq_retpymt_recency;
                      INTEGER rv_i60_inq_comm_count12                ;    // rv_i60_inq_comm_count12;
                      INTEGER rv_i60_inq_comm_recency                ;    // rv_i60_inq_comm_recency;
                      INTEGER rv_i60_inq_stdloan_count12             ;    // rv_i60_inq_stdloan_count12;
                      INTEGER rv_i60_inq_util_count12                ;    // rv_i60_inq_util_count12;
                      INTEGER rv_i60_inq_util_recency                ;    // rv_i60_inq_util_recency;
                      INTEGER rv_i60_inq_other_count12               ;    // rv_i60_inq_other_count12;
                      INTEGER rv_i60_inq_other_recency               ;    // rv_i60_inq_other_recency;
                      INTEGER rv_i62_inq_ssns_per_adl                ;    // rv_i62_inq_ssns_per_adl;
                      INTEGER rv_i62_inq_addrs_per_adl               ;    // rv_i62_inq_addrs_per_adl;
                      INTEGER rv_i62_inq_num_names_per_adl           ;    // rv_i62_inq_num_names_per_adl;
                      INTEGER rv_i62_inq_phones_per_adl              ;    // rv_i62_inq_phones_per_adl;
                      INTEGER rv_i62_inq_dobs_per_adl                ;    // rv_i62_inq_dobs_per_adl;
                      INTEGER nf_inq_fname_ver_count                 ;    // nf_inq_fname_ver_count;
                      INTEGER nf_inq_lname_ver_count                 ;    // nf_inq_lname_ver_count;
                      INTEGER nf_inq_addr_ver_count                  ;    // nf_inq_addr_ver_count;
                      INTEGER nf_inq_dob_ver_count                   ;    // nf_inq_dob_ver_count;
                      INTEGER nf_inq_ssn_ver_count                   ;    // nf_inq_ssn_ver_count;
                      INTEGER nf_inquiry_verification_index          ;    // nf_inquiry_verification_index;
                      INTEGER	nf_inquiry_adl_vel_risk_index          ;    // nf_inquiry_adl_vel_risk_index;
                    INTEGER	 nf_inquiry_ssn_vel_risk_index          ;    // nf_inquiry_ssn_vel_risk_index;
                    INTEGER	 nf_inq_addr_recency_risk_index         ;    // nf_inq_addr_recency_risk_index;
                    INTEGER	 nf_inquiry_ssn_vel_risk_indexv2        ;    // nf_inquiry_ssn_vel_risk_indexv2;
                    INTEGER	 nf_inquiry_addr_vel_risk_index         ;    // nf_inquiry_addr_vel_risk_index;
                    INTEGER	 nf_inquiry_addr_vel_risk_indexv2       ;    // nf_inquiry_addr_vel_risk_indexv2;
                    INTEGER	 nf_inq_count                           ;    // nf_inq_count;
                    INTEGER	 nf_inq_count_day                       ;    // nf_inq_count_day;
                    INTEGER	 nf_inq_count_week                      ;    // nf_inq_count_week;
                    INTEGER	 nf_inq_count24                         ;    // nf_inq_count24;
                    INTEGER	 nf_inq_auto_count                      ;    // nf_inq_auto_count;
                    INTEGER	 nf_inq_auto_count_day                  ;    // nf_inq_auto_count_day;
                    INTEGER	 nf_inq_auto_count_week                 ;    // nf_inq_auto_count_week;
                    INTEGER	 nf_inq_auto_count24                    ;    // nf_inq_auto_count24;
                    INTEGER	 nf_inq_banking_count                   ;    // nf_inq_banking_count;
                    INTEGER	 nf_inq_banking_count_day               ;    // nf_inq_banking_count_day;
                    INTEGER	 nf_inq_banking_count_week              ;    // nf_inq_banking_count_week;
                    INTEGER	 nf_inq_banking_count24                 ;    // nf_inq_banking_count24;
                    INTEGER	 nf_inq_collection_count                ;    // nf_inq_collection_count;
                    INTEGER	 nf_inq_collection_count_week           ;    // nf_inq_collection_count_week;
                    INTEGER	 nf_inq_collection_count24              ;    // nf_inq_collection_count24;
                    INTEGER	 nf_inq_communications_count            ;    // nf_inq_communications_count;
                    INTEGER	 nf_inq_communications_count_week       ;    // nf_inq_communications_count_week;
                    INTEGER	 nf_inq_communications_count24          ;    // nf_inq_communications_count24;
                    INTEGER	 nf_inq_highriskcredit_count            ;    // nf_inq_highriskcredit_count;
                    INTEGER	 nf_inq_highriskcredit_count_day        ;    // nf_inq_highriskcredit_count_day;
                    INTEGER	 nf_inq_highriskcredit_count_week       ;    // nf_inq_highriskcredit_count_week;
                    INTEGER	 nf_inq_highriskcredit_count24          ;    // nf_inq_highriskcredit_count24;
                    INTEGER	 nf_inq_mortgage_count                  ;    // nf_inq_mortgage_count;
                    INTEGER	 nf_inq_mortgage_count_week             ;    // nf_inq_mortgage_count_week;
                    INTEGER	 nf_inq_mortgage_count24                ;    // nf_inq_mortgage_count24;
                    INTEGER	 nf_inq_other_count                     ;    // nf_inq_other_count;
                    INTEGER	 nf_inq_other_count_day                 ;    // nf_inq_other_count_day;
                    INTEGER	 nf_inq_other_count_week                ;    // nf_inq_other_count_week;
                    INTEGER	 nf_inq_other_count24                   ;    // nf_inq_other_count24;
                    INTEGER	 nf_inq_prepaidcards_count              ;    // nf_inq_prepaidcards_count;
                    INTEGER	 nf_inq_prepaidcards_count_day          ;    // nf_inq_prepaidcards_count_day;
                    INTEGER	 nf_inq_prepaidcards_count24            ;    // nf_inq_prepaidcards_count24;
                    INTEGER	 nf_inq_quizprovider_count              ;    // nf_inq_quizprovider_count;
                    INTEGER	 nf_inq_quizprovider_count_day          ;    // nf_inq_quizprovider_count_day;
                    INTEGER	 nf_inq_quizprovider_count_week         ;    // nf_inq_quizprovider_count_week;
                    INTEGER	 nf_inq_quizprovider_count24            ;    // nf_inq_quizprovider_count24;
                    INTEGER	 nf_inq_retail_count                    ;    // nf_inq_retail_count;
                    INTEGER	 nf_inq_retail_count24                  ;    // nf_inq_retail_count24;
                    INTEGER	 nf_inq_retailpayments_count            ;    // nf_inq_retailpayments_count;
                    INTEGER	 nf_inq_retailpayments_count_week       ;    // nf_inq_retailpayments_count_week;
                    INTEGER	 nf_inq_retailpayments_count24          ;    // nf_inq_retailpayments_count24;
                    INTEGER	 nf_inq_utilities_count                 ;    // nf_inq_utilities_count;
                    INTEGER	 nf_inq_utilities_count24               ;    // nf_inq_utilities_count24;
                    INTEGER	 nf_inq_per_ssn                         ;    // nf_inq_per_ssn;
                    INTEGER	 nf_inq_adls_per_ssn                    ;    // nf_inq_adls_per_ssn;
                    INTEGER	 nf_inq_lnames_per_ssn                  ;    // nf_inq_lnames_per_ssn;
                    INTEGER	 nf_inq_addrs_per_ssn                   ;    // nf_inq_addrs_per_ssn;
                    INTEGER	 nf_inq_dobs_per_ssn                    ;    // nf_inq_dobs_per_ssn;
                    INTEGER	 nf_inq_per_addr                        ;    // nf_inq_per_addr;
                    INTEGER	 nf_inq_per_apt_addr                    ;    // nf_inq_per_apt_addr;
                    INTEGER	 nf_inq_per_sfd_addr                    ;    // nf_inq_per_sfd_addr;
                    INTEGER	 nf_inq_adls_per_addr                   ;    // nf_inq_adls_per_addr;
                    INTEGER	 nf_inq_adls_per_apt_addr               ;    // nf_inq_adls_per_apt_addr;
                    INTEGER	 nf_inq_adls_per_sfd_addr               ;    // nf_inq_adls_per_sfd_addr;
                    INTEGER	 nf_inq_lnames_per_addr                 ;    // nf_inq_lnames_per_addr;
                    INTEGER	 nf_inq_lnames_per_apt_addr             ;    // nf_inq_lnames_per_apt_addr;
                    INTEGER	 nf_inq_lnames_per_sfd_addr             ;    // nf_inq_lnames_per_sfd_addr;
                    INTEGER	 nf_inq_ssns_per_addr                   ;    // nf_inq_ssns_per_addr;
                    INTEGER	 nf_inq_ssns_per_apt_addr               ;    // nf_inq_ssns_per_apt_addr;
                    INTEGER	 nf_inq_ssns_per_sfd_addr               ;    // nf_inq_ssns_per_sfd_addr;
                    INTEGER	 nf_inq_email_per_adl                   ;    // nf_inq_email_per_adl;
                    INTEGER	 rv_i60_inq_peradl_recency              ;    // rv_i60_inq_peradl_recency;
                    INTEGER	 rv_i60_inq_peradl_count12              ;    // rv_i60_inq_peradl_count12;
                    INTEGER	 nf_inq_peradl_count_day                ;    // nf_inq_peradl_count_day;
                    INTEGER	 nf_inq_peradl_count_week               ;    // nf_inq_peradl_count_week;
                    INTEGER	 rv_i62_inq_ssnsperadl_recency          ;    // rv_i62_inq_ssnsperadl_recency;
                    INTEGER	 rv_i62_inq_ssnsperadl_count12          ;    // rv_i62_inq_ssnsperadl_count12;
                    INTEGER	 nf_inq_ssnsperadl_count_day            ;    // nf_inq_ssnsperadl_count_day;
                    INTEGER	 nf_inq_ssnsperadl_count_week           ;    // nf_inq_ssnsperadl_count_week;
                    INTEGER	 rv_i62_inq_addrsperadl_recency         ;    // rv_i62_inq_addrsperadl_recency;
                    INTEGER	 rv_i62_inq_addrsperadl_count12         ;    // rv_i62_inq_addrsperadl_count12;
                    INTEGER	 nf_inq_addrsperadl_count_day           ;    // nf_inq_addrsperadl_count_day;
                    INTEGER	 nf_inq_addrsperadl_count_week          ;    // nf_inq_addrsperadl_count_week;
                    INTEGER	 rv_i62_inq_lnamesperadl_recency        ;    // rv_i62_inq_lnamesperadl_recency;
                    INTEGER	 rv_i62_inq_lnamesperadl_count12        ;    // rv_i62_inq_lnamesperadl_count12;
                    INTEGER	 nf_inq_lnamesperadl_count_day          ;    // nf_inq_lnamesperadl_count_day;
                    INTEGER	 nf_inq_lnamesperadl_count_week         ;    // nf_inq_lnamesperadl_count_week;
                    INTEGER	 rv_i62_inq_fnamesperadl_recency        ;    // rv_i62_inq_fnamesperadl_recency;
                    INTEGER	 rv_i62_inq_fnamesperadl_count12        ;    // rv_i62_inq_fnamesperadl_count12;
                    INTEGER	 nf_inq_fnamesperadl_count_day          ;    // nf_inq_fnamesperadl_count_day;
                    INTEGER	 nf_inq_fnamesperadl_count_week         ;    // nf_inq_fnamesperadl_count_week;
                    INTEGER	 rv_i62_inq_phonesperadl_recency        ;    // rv_i62_inq_phonesperadl_recency;
                    INTEGER	 rv_i62_inq_phonesperadl_count12        ;    // rv_i62_inq_phonesperadl_count12;
                    INTEGER	 nf_inq_phonesperadl_count_day          ;    // nf_inq_phonesperadl_count_day;
                    INTEGER	 nf_inq_phonesperadl_count_week         ;    // nf_inq_phonesperadl_count_week;
                    INTEGER	 rv_i62_inq_dobsperadl_recency          ;    // rv_i62_inq_dobsperadl_recency;
                    INTEGER	 rv_i62_inq_dobsperadl_count12          ;    // rv_i62_inq_dobsperadl_count12;
                    INTEGER	 nf_inq_dobsperadl_count_day            ;    // nf_inq_dobsperadl_count_day;
                    INTEGER	 nf_inq_dobsperadl_count_week           ;    // nf_inq_dobsperadl_count_week;
                    INTEGER	 nf_inq_perssn_recency                  ;    // nf_inq_perssn_recency;
                    INTEGER	 nf_inq_perssn_count12                  ;    // nf_inq_perssn_count12;
                    INTEGER	 nf_inq_perssn_count_day                ;    // nf_inq_perssn_count_day;
                    INTEGER	 nf_inq_perssn_count_week               ;    // nf_inq_perssn_count_week;
                    INTEGER	 nf_inq_adlsperssn_recency              ;    // nf_inq_adlsperssn_recency;
                    INTEGER	 nf_inq_adlsperssn_count12              ;    // nf_inq_adlsperssn_count12;
                    INTEGER	 nf_inq_adlsperssn_count_day            ;    // nf_inq_adlsperssn_count_day;
                    INTEGER	 nf_inq_adlsperssn_count_week           ;    // nf_inq_adlsperssn_count_week;
                    INTEGER	 nf_inq_lnamesperssn_recency            ;    // nf_inq_lnamesperssn_recency;
                    INTEGER	 nf_inq_lnamesperssn_count12            ;    // nf_inq_lnamesperssn_count12;
                    INTEGER	 nf_inq_lnamesperssn_count_day          ;    // nf_inq_lnamesperssn_count_day;
                    INTEGER	 nf_inq_lnamesperssn_count_week         ;    // nf_inq_lnamesperssn_count_week;
                    INTEGER	 nf_inq_addrsperssn_recency             ;    // nf_inq_addrsperssn_recency;
                    INTEGER	 nf_inq_addrsperssn_count12             ;    // nf_inq_addrsperssn_count12;
                    INTEGER	 nf_inq_addrsperssn_count_day           ;    // nf_inq_addrsperssn_count_day;
                    INTEGER	 nf_inq_addrsperssn_count_week          ;    // nf_inq_addrsperssn_count_week;
                    INTEGER	 nf_inq_dobsperssn_recency              ;    // nf_inq_dobsperssn_recency;
                    INTEGER	 nf_inq_dobsperssn_count12              ;    // nf_inq_dobsperssn_count12;
                    INTEGER	 nf_inq_dobsperssn_count_day            ;    // nf_inq_dobsperssn_count_day;
                    INTEGER	 nf_inq_dobsperssn_count_week           ;    // nf_inq_dobsperssn_count_week;
                    INTEGER	 nf_inq_peraddr_recency                 ;    // nf_inq_peraddr_recency;
                    INTEGER	 nf_inq_peraddr_count12                 ;    // nf_inq_peraddr_count12;
                    INTEGER	 nf_inq_peraddr_count_day               ;    // nf_inq_peraddr_count_day;
                    INTEGER	 nf_inq_peraddr_count_week              ;    // nf_inq_peraddr_count_week;
                    INTEGER	 nf_inq_adlsperaddr_recency             ;    // nf_inq_adlsperaddr_recency;
                    INTEGER	 nf_inq_adlsperaddr_count12             ;    // nf_inq_adlsperaddr_count12;
                    INTEGER	 nf_inq_adlsperaddr_count_day           ;    // nf_inq_adlsperaddr_count_day;
                    INTEGER	 nf_inq_adlsperaddr_count_week          ;    // nf_inq_adlsperaddr_count_week;
                    INTEGER	 nf_inq_lnamesperaddr_recency           ;    // nf_inq_lnamesperaddr_recency;
                    INTEGER	 nf_inq_lnamesperaddr_count12           ;    // nf_inq_lnamesperaddr_count12;
                    INTEGER	 nf_inq_lnamesperaddr_count_day         ;    // nf_inq_lnamesperaddr_count_day;
                    INTEGER	 nf_inq_lnamesperaddr_count_week        ;    // nf_inq_lnamesperaddr_count_week;
                    INTEGER	 nf_inq_ssnsperaddr_recency             ;    // nf_inq_ssnsperaddr_recency;
                    INTEGER	 nf_inq_ssnsperaddr_count12             ;    // nf_inq_ssnsperaddr_count12;
                    INTEGER	 nf_inq_ssnsperaddr_count_day           ;    // nf_inq_ssnsperaddr_count_day;
                    INTEGER	 nf_inq_ssnsperaddr_count_week          ;    // nf_inq_ssnsperaddr_count_week;
                    INTEGER	 nf_inq_emailsperadl_count12            ;    // nf_inq_emailsperadl_count12;
                    INTEGER	 nf_inq_adlsperemail_count12            ;    // nf_inq_adlsperemail_count12;
                    INTEGER	 nf_inq_adlsperemail_count_week         ;    // nf_inq_adlsperemail_count_week;
                    INTEGER	 nf_inq_perbestssn_count12              ;    // nf_inq_perbestssn_count12;
                    INTEGER	 nf_inq_adlsperbestssn_count12          ;    // nf_inq_adlsperbestssn_count12;
                    INTEGER	 nf_inq_lnamesperbestssn_count12        ;    // nf_inq_lnamesperbestssn_count12;
                    INTEGER	 nf_inq_addrsperbestssn_count12         ;    // nf_inq_addrsperbestssn_count12;
                    INTEGER	 nf_inq_dobsperbestssn_count12          ;    // nf_inq_dobsperbestssn_count12;
                    INTEGER	 nf_inq_percurraddr_count12             ;    // nf_inq_percurraddr_count12;
                    INTEGER	 nf_inq_adlspercurraddr_count12         ;    // nf_inq_adlspercurraddr_count12;
                    INTEGER	 nf_inq_lnamespercurraddr_count12       ;    // nf_inq_lnamespercurraddr_count12;
                    INTEGER	 nf_inq_ssnspercurraddr_count12         ;    // nf_inq_ssnspercurraddr_count12;
                    INTEGER	 nf_inq_perbestphone_count12            ;    // nf_inq_perbestphone_count12;
                    REAL	 nf_inq_adlsperbestphone_count12        ;    // nf_inq_adlsperbestphone_count12;
                    INTEGER	 nf_inq_curraddr_ver_count              ;    // nf_inq_curraddr_ver_count;
                    INTEGER	 nf_inq_bestfname_ver_count             ;    // nf_inq_bestfname_ver_count;
                    INTEGER	 nf_inq_bestlname_ver_count             ;    // nf_inq_bestlname_ver_count;
                    INTEGER	 nf_inq_bestssn_ver_count               ;    // nf_inq_bestssn_ver_count;
                    INTEGER	 nf_inq_bestdob_ver_count               ;    // nf_inq_bestdob_ver_count;
                    INTEGER	 nf_inq_bestphone_ver_count             ;    // nf_inq_bestphone_ver_count;
                    INTEGER	 nf_invbest_inq_perssn_diff             ;    // nf_invbest_inq_perssn_diff;
                    INTEGER	 nf_invbest_inq_adlsperssn_diff         ;    // nf_invbest_inq_adlsperssn_diff;
                    INTEGER	 nf_invbest_inq_lnamesperssn_diff       ;    // nf_invbest_inq_lnamesperssn_diff;
                    INTEGER	 nf_invbest_inq_addrsperssn_diff        ;    // nf_invbest_inq_addrsperssn_diff;
                    INTEGER	 nf_invbest_inq_dobsperssn_diff         ;    // nf_invbest_inq_dobsperssn_diff;
                    INTEGER	 nf_invbest_inq_peraddr_diff            ;    // nf_invbest_inq_peraddr_diff;
                    INTEGER	 nf_invbest_inq_adlsperaddr_diff        ;    // nf_invbest_inq_adlsperaddr_diff;
                    INTEGER	 nf_invbest_inq_lastperaddr_diff        ;    // nf_invbest_inq_lastperaddr_diff;
                    INTEGER	 nf_invbest_inq_ssnsperaddr_diff        ;    // nf_invbest_inq_ssnsperaddr_diff;


                      real  modinq_size_1                          ;    // modinq_size_1;	
                    real  modinq_size_2                          ;    // modinq_size_2;	
                    real  modinq_size_3                          ;    // modinq_size_3;	
                    real  modinq_size_4                          ;    // modinq_size_4;	
                    real  modinq_size_5                          ;    // modinq_size_5;	
                    real  modinq_size_6                          ;    // modinq_size_6;	
                    real  modinq_size_7                          ;    // modinq_size_7;	
                    real  modinq_size_8                          ;    // modinq_size_8;	
                    real  modinq_size_9                          ;    // modinq_size_9;	
                    real  modinq_size_10                         ;    // modinq_size_10;	
                    real  modinq_size_11                         ;    // modinq_size_11;	
                    real  modinq_size_12                         ;    // modinq_size_12;	
                    real  modinq_size_13                         ;    // modinq_size_13;	
                    real  modinq_size_14                         ;    // modinq_size_14;	
                    real  modinq_size_15                         ;    // modinq_size_15;	
                    real  modinq_size_16                         ;    // modinq_size_16;	
                    real  modinq_size_17                         ;    // modinq_size_17;	
                    real  modinq_size_18                         ;    // modinq_size_18;	
                    real  modinq_size_19                         ;    // modinq_size_19;	
                    real  modinq_size_20                         ;    // modinq_size_20;	
                    real  modinq_size_21                         ;    // modinq_size_21;	
                    real  modinq_size_22                         ;    // modinq_size_22;	
                    real  modinq_size_23                         ;    // modinq_size_23;	
                    real  modinq_size_24                         ;    // modinq_size_24;	
                    real  modinq_size_25                         ;    // modinq_size_25;	
                    real  modinq_size_26                         ;    // modinq_size_26;	
                    real  modinq_size_27                         ;    // modinq_size_27;	
                    real  modinq_size_28                         ;    // modinq_size_28;	
                    real  modinq_size_29                         ;    // modinq_size_29;	
                    real  modinq_size_30                         ;    // modinq_size_30;	
                    real  modinq_size_31                         ;    // modinq_size_31;	
                    real  modinq_size_32                         ;    // modinq_size_32;	
                    real  modinq_size_33                         ;    // modinq_size_33;	
                    real  modinq_size_34                         ;    // modinq_size_34;	
                    real  modinq_size_35                         ;    // modinq_size_35;	
                    real  modinq_size_36                         ;    // modinq_size_36;	
                    real  modinq_size_37                         ;    // modinq_size_37;	
                    real  modinq_size_38                         ;    // modinq_size_38;	
                    real  modinq_size_39                         ;    // modinq_size_39;	
                    real  modinq_size_40                         ;    // modinq_size_40;	
                    real  modinq_size_41                         ;    // modinq_size_41;	
                    real  modinq_size_42                         ;    // modinq_size_42;	
                    real  modinq_size_43                         ;    // modinq_size_43;	
                    real  modinq_size_44                         ;    // modinq_size_44;	
                    real  modinq_size_45                         ;    // modinq_size_45;	
                    real  modinq_size_46                         ;    // modinq_size_46;	
                    real  modinq_size_47                         ;    // modinq_size_47;	
                    real  modinq_size_48                         ;    // modinq_size_48;	
                    real  modinq_size_49                         ;    // modinq_size_49;	
                    real  modinq_size_50                         ;    // modinq_size_50;	
                    real  modinq_size_51                         ;    // modinq_size_51;	
                    real  modinq_size_52                         ;    // modinq_size_52;	
                    real  modinq_size_53                         ;    // modinq_size_53;	
                    real  modinq_size_54                         ;    // modinq_size_54;	
                    real  modinq_size_55                         ;    // modinq_size_55;	
                    real  modinq_size_56                         ;    // modinq_size_56;	
                    real  modinq_size_57                         ;    // modinq_size_57;	
                    real  modinq_size_58                         ;    // modinq_size_58;	
                    real  modinq_size_59                         ;    // modinq_size_59;	
                    real  modinq_size_60                         ;    // modinq_size_60;	
                    real  modinq_size_61                         ;    // modinq_size_61;	
                    real  modinq_size_62                         ;    // modinq_size_62;	
                    real  modinq_size_63                         ;    // modinq_size_63;	
                    real  modinq_size_64                         ;    // modinq_size_64;	
                    real  modinq_size_65                         ;    // modinq_size_65;	
                    real  modinq_size_66                         ;    // modinq_size_66;	
                    real  modinq_size_67                         ;    // modinq_size_67;	
                    real  modinq_size_68                         ;    // modinq_size_68;	
                    real  modinq_size_69                         ;    // modinq_size_69;	
                    real  modinq_size_70                         ;    // modinq_size_70;	
                    real  modinq_size_71                         ;    // modinq_size_71;	
                    real  modinq_size_72                         ;    // modinq_size_72;	
                    real  modinq_size_73                         ;    // modinq_size_73;	
                    real  modinq_size_74                         ;    // modinq_size_74;	
                    real  modinq_size_75                         ;    // modinq_size_75;	
                    real  modinq_size_76                         ;    // modinq_size_76;	
                    real  modinq_size_77                         ;    // modinq_size_77;	
                    real  modinq_size_78                         ;    // modinq_size_78;	
                    real  modinq_size_79                         ;    // modinq_size_79;	
                    real  modinq_size_80                         ;    // modinq_size_80;	
                    real  modinq_size_81                         ;    // modinq_size_81;	
                    real  modinq_size_82                         ;    // modinq_size_82;	
                    real  modinq_size_83                         ;    // modinq_size_83;	
                    real  modinq_size_84                         ;    // modinq_size_84;	
                    real  modinq_size_85                         ;    // modinq_size_85;	
                    real  modinq_size_86                         ;    // modinq_size_86;	
                    real  modinq_size_87                         ;    // modinq_size_87;	
                    real  modinq_size_88                         ;    // modinq_size_88;	
                    real  modinq_size_89                         ;    // modinq_size_89;	
                    real  modinq_size_90                         ;    // modinq_size_90;	
                    real  modinq_size_91                         ;    // modinq_size_91;	
                    real  modinq_size_92                         ;    // modinq_size_92;	
                    real  modinq_size_93                         ;    // modinq_size_93;	
                    real  modinq_size_94                         ;    // modinq_size_94;	
                    real  modinq_size_95                         ;    // modinq_size_95;	
                    real  modinq_size_96                         ;    // modinq_size_96;	
                    real  modinq_size_97                         ;    // modinq_size_97;	
                    real  modinq_size_98                         ;    // modinq_size_98;	
                    real  modinq_size_99                         ;    // modinq_size_99;	
                    real  modinq_size_100                        ;    // modinq_size_100;	
                    real  modinq_avg_path_length                 ;    // modinq_avg_path_length;	
                    real  modinq_anomaly_score                   ;    // modinq_anomaly_score;	
                                           Integer nf_fp_srchfraudsrchcountyr             ;    // nf_fp_srchfraudsrchcountyr;		
                    integer _in_dob                                ;    // _in_dob;		
                    integer earliest_bureau_date                   ;    // earliest_bureau_date;		
                    integer earliest_bureau_yrs                    ;    // earliest_bureau_yrs;		
                    integer calc_dob                               ;    // calc_dob;		
                    integer _bureau_emergence_age                  ;    // _bureau_emergence_age;		
                    Boolean ca_bureau_emergence_age_32_59          ;    // ca_bureau_emergence_age_32_59;		
                    integer num_bureau_fname                       ;    // num_bureau_fname;		
                    integer num_bureau_lname                       ;    // num_bureau_lname;		
                    integer num_bureau_addr                        ;    // num_bureau_addr;		
                    integer num_bureau_ssn                         ;    // num_bureau_ssn;		
                    integer num_bureau_dob                         ;    // num_bureau_dob;		
                    integer iv_bureau_verification_index           ;    // iv_bureau_verification_index;		
                    integer rv_c15_ssns_per_adl_c6_v2              ;    // rv_c15_ssns_per_adl_c6_v2;		
                    integer rv_s65_ssn_prior_dob                   ;    // rv_s65_ssn_prior_dob;		
                    integer rv_c15_ssns_per_adl                    ;    // rv_c15_ssns_per_adl;		
                    integer _rc_ssnhighissue                       ;    // _rc_ssnhighissue;		
                    integer ca_m_snc_ssn_high_issue                ;    // ca_m_snc_ssn_high_issue;		
                    boolean co_tgr_fla_bureau_no_ssn               ;    // co_tgr_fla_bureau_no_ssn;		
                    boolean sc_tgr_ssn_fs_6mo                      ;    // sc_tgr_ssn_fs_6mo;		
                    boolean sc_tgr_ssn_input_not_best              ;    // sc_tgr_ssn_input_not_best;		
                    boolean sc_tgr_ssn_prior_dob                   ;    // sc_tgr_ssn_prior_dob;		
                    boolean co_tgr_ssns_per_adl                    ;    // co_tgr_ssns_per_adl;		
                    boolean co_did_count                           ;    // co_did_count;		
                    boolean co_ssn_high_issue                      ;    // co_ssn_high_issue;		
                    integer beta_cpn_trigger                       ;    // beta_cpn_trigger;		
                    integer rv_s66_ssns_per_adl_c6                 ;    // rv_s66_ssns_per_adl_c6;		
                    integer nf_ssns_per_curraddr_curr              ;    // nf_ssns_per_curraddr_curr;		
                    integer rv_d30_derog_count                     ;    // rv_d30_derog_count;		
                    Real sid_subscore0                          ;    // sid_subscore0;		
                    Real sid_subscore1                          ;    // sid_subscore1;		
                    Real sid_subscore2                          ;    // sid_subscore2;		
                    Real sid_subscore3                          ;    // sid_subscore3;		
                    Real sid_subscore4                          ;    // sid_subscore4;		
                    Real sid_subscore5                          ;    // sid_subscore5;		
                    Real sid_subscore6                          ;    // sid_subscore6;		
                    Real sid_subscore7                          ;    // sid_subscore7;		
                    Real sid_subscore8                          ;    // sid_subscore8;		
                    Real sid_rawscore                           ;    // sid_rawscore;		
                    Real sid_lnoddsscore                        ;    // sid_lnoddsscore;		
                    Real sid_probscore                          ;    // sid_probscore;		
                    integer cust_auto_synthid_score                ;    // cust_auto_synthid_score;		
                    integer fp1704_1_0_synthidindex                ;    // fp1704_1_0_synthidindex;		
                    Real cpn_subscore0                          ;    // cpn_subscore0;		
                    Real cpn_subscore1                          ;    // cpn_subscore1;		
                    Real cpn_subscore2                          ;    // cpn_subscore2;		
                    Real cpn_subscore3                          ;    // cpn_subscore3;		
                    Real cpn_subscore4                          ;    // cpn_subscore4;		
                    Real cpn_rawscore                           ;    // cpn_rawscore;		
                    Real cpn_lnoddsscore                        ;    // cpn_lnoddsscore;		
                    Real cpn_probscore                          ;    // cpn_probscore;		

                     Integer  base           ;    // base;
                      Integer pdo                     ;    // pdo;
                      Integer odds                   ;    // odds;
                      Integer cust_auto_cpn_score      ;    // cust_auto_cpn_score;
                      Integer fp1704_1_0_suspactindex   ;    // fp1704_1_0_suspactindex;


			models.layouts.layout_fp1109;
			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layouts.layout_fp1109 doModel( clam le ) := TRANSFORM
		
  #end	

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
  inq_perssn_count01               := le.acc_logs.inq_perssn_count01;
	inq_adlsperaddr_count01          := le.acc_logs.inq_adlsperaddr_count01;
	inq_lnamesperaddr_count01        := le.acc_logs.inq_lnamesperaddr_count01;
	inq_ssnsperaddr_count01          := le.acc_logs.inq_ssnsperaddr_count01;
	inq_peradl_count01               := le.acc_logs.inq_peradl_count01;
	inq_peradl_count03               := le.acc_logs.inq_peradl_count03;
	inq_peradl_count06               := le.acc_logs.inq_peradl_count06;
	inq_peradl_count_day             := le.acc_logs.inq_peradl_count_day;
	inq_peradl_count_week            := le.acc_logs.inq_peradl_count_week;
	inq_ssnsperadl_count01           := le.acc_logs.inq_ssnsperadl_count01;
	inq_ssnsperadl_count03           := le.acc_logs.inq_ssnsperadl_count03;
	inq_ssnsperadl_count06           := le.acc_logs.inq_ssnsperadl_count06;
	inq_ssnsperadl_count_day         := if(isFCRA, 0, le.acc_logs.inq_ssnsperadl_count_day );
	inq_ssnsperadl_count_week        := if(isFCRA, 0, le.acc_logs.inq_ssnsperadl_count_week );
	inq_addrsperadl_count01          := le.acc_logs.inq_addrsperadl_count01;
	inq_addrsperadl_count03          := le.acc_logs.inq_addrsperadl_count03;
	inq_addrsperadl_count06          := le.acc_logs.inq_addrsperadl_count06;
	inq_addrsperadl_count_day        := if(isFCRA, 0, le.acc_logs.inq_addrsperadl_count_day );
	inq_addrsperadl_count_week       := if(isFCRA, 0, le.acc_logs.inq_addrsperadl_count_week );
	inq_lnamesperadl_count01         := le.acc_logs.inq_lnamesperadl_count01;
	inq_lnamesperadl_count03         := le.acc_logs.inq_lnamesperadl_count03;
	inq_lnamesperadl_count06         := le.acc_logs.inq_lnamesperadl_count06;
	inq_lnamesperadl_count_day       := le.acc_logs.inq_lnamesperadl_count_day;
	inq_lnamesperadl_count_week      := if(isFCRA, 0, le.acc_logs.inq_lnamesperadl_count_week  );
	inq_fnamesperadl_count01         := le.acc_logs.inq_fnamesperadl_count01;
	inq_fnamesperadl_count03         := le.acc_logs.inq_fnamesperadl_count03;
	inq_fnamesperadl_count06         := le.acc_logs.inq_fnamesperadl_count06;
	inq_fnamesperadl_count_day       := if(isFCRA, 0, le.acc_logs.inq_fnamesperadl_count_day  );
	inq_fnamesperadl_count_week      := if(isFCRA, 0, le.acc_logs.inq_fnamesperadl_count_week  );
	inq_phonesperadl_count01         := le.acc_logs.inq_phonesperadl_count01;
	inq_phonesperadl_count03         := le.acc_logs.inq_phonesperadl_count03;
	inq_phonesperadl_count06         := le.acc_logs.inq_phonesperadl_count06;
	inq_phonesperadl_count_day       := if(isFCRA, 0, le.acc_logs.inq_phonesperadl_count_day  );
	inq_phonesperadl_count_week      :=if(isFCRA, 0, le.acc_logs.inq_phonesperadl_count_week  ) ;
	inq_dobsperadl_count01           := le.acc_logs.inq_dobsperadl_count01;
	inq_dobsperadl_count03           := le.acc_logs.inq_dobsperadl_count03;
	inq_dobsperadl_count06           := le.acc_logs.inq_dobsperadl_count06;
	inq_dobsperadl_count_day         := if(isFCRA, 0, le.acc_logs.inq_dobsperadl_count_day  );
	inq_dobsperadl_count_week        := if(isFCRA, 0, le.acc_logs.inq_dobsperadl_count_week  );
	inq_perssn_count03               := if(isFCRA, 0, le.acc_logs.inq_perssn_count03 );
	inq_perssn_count06               := if(isFCRA, 0, le.acc_logs.inq_perssn_count06 );
	inq_perssn_count_day             := if(isFCRA, 0, le.acc_logs.inq_perssn_count_day );
	inq_perssn_count_week            := if(isFCRA, 0, le.acc_logs.inq_perssn_count_week );
	inq_adlsperssn_count01           := if(isFCRA, 0, le.acc_logs.inq_adlsperssn_count01 );
	inq_adlsperssn_count03           := if(isFCRA, 0, le.acc_logs.inq_adlsperssn_count03 );
	inq_adlsperssn_count06           := if(isFCRA, 0, le.acc_logs.inq_adlsperssn_count06 );
	inq_adlsperssn_count_day         := if(isFCRA, 0, le.acc_logs.inq_adlsperssn_count_day );
	inq_adlsperssn_count_week        := if(isFCRA, 0, le.acc_logs.inq_adlsperssn_count_week );
	inq_lnamesperssn_count01         := if(isFCRA, 0, le.acc_logs.inq_lnamesperssn_count01 );
	inq_lnamesperssn_count03         := if(isFCRA, 0, le.acc_logs.inq_lnamesperssn_count03 );
	inq_lnamesperssn_count06         := if(isFCRA, 0, le.acc_logs.inq_lnamesperssn_count06 );
	inq_lnamesperssn_count_day       := if(isFCRA, 0, le.acc_logs.inq_lnamesperssn_count_day );
	inq_lnamesperssn_count_week      := if(isFCRA, 0, le.acc_logs.inq_lnamesperssn_count_week );
	inq_addrsperssn_count01          := if(isFCRA, 0, le.acc_logs.inq_addrsperssn_count01 );
	inq_addrsperssn_count03          := if(isFCRA, 0, le.acc_logs.inq_addrsperssn_count03 );
	inq_addrsperssn_count06          := if(isFCRA, 0, le.acc_logs.inq_addrsperssn_count06 );
	inq_addrsperssn_count_day        := if(isFCRA, 0, le.acc_logs.inq_addrsperssn_count_day );
	inq_addrsperssn_count_week       := if(isFCRA, 0, le.acc_logs.inq_addrsperssn_count_week );
	inq_dobsperssn_count01           := if(isFCRA, 0, le.acc_logs.inq_dobsperssn_count01 );
	inq_dobsperssn_count03           := if(isFCRA, 0, le.acc_logs.inq_dobsperssn_count03 );
	inq_dobsperssn_count06           := if(isFCRA, 0, le.acc_logs.inq_dobsperssn_count06 );
	inq_dobsperssn_count_day         := if(isFCRA, 0, le.acc_logs.inq_dobsperssn_count_day );
	inq_dobsperssn_count_week        := if(isFCRA, 0, le.acc_logs.inq_dobsperssn_count_week );
	inq_peraddr_count01              := if(isFCRA, 0, le.acc_logs.inq_peraddr_count01 );
	inq_peraddr_count03              := if(isFCRA, 0, le.acc_logs.inq_peraddr_count03 );
	inq_peraddr_count06              := if(isFCRA, 0, le.acc_logs.inq_peraddr_count06 );
	inq_peraddr_count_day            := if(isFCRA, 0, le.acc_logs.inq_peraddr_count_day );
	inq_peraddr_count_week           := if(isFCRA, 0, le.acc_logs.inq_peraddr_count_week );
	inq_adlsperaddr_count03          := if(isFCRA, 0, le.acc_logs.inq_adlsperaddr_count03 );
	inq_adlsperaddr_count06          := if(isFCRA, 0, le.acc_logs.inq_adlsperaddr_count06 );
	inq_adlsperaddr_count_day        := if(isFCRA, 0, le.acc_logs.inq_adlsperaddr_count_day );
	inq_adlsperaddr_count_week       := if(isFCRA, 0, le.acc_logs.inq_adlsperaddr_count_week );
	inq_lnamesperaddr_count03        := if(isFCRA, 0, le.acc_logs.inq_lnamesperaddr_count03 );
	inq_lnamesperaddr_count06        := if(isFCRA, 0, le.acc_logs.inq_lnamesperaddr_count06 );
	inq_lnamesperaddr_count_day      := if(isFCRA, 0, le.acc_logs.inq_lnamesperaddr_count_day );
	inq_lnamesperaddr_count_week     := if(isFCRA, 0, le.acc_logs.inq_lnamesperaddr_count_week );
	inq_ssnsperaddr_count03          := if(isFCRA, 0, le.acc_logs.inq_ssnsperaddr_count03 );
	inq_ssnsperaddr_count06          := if(isFCRA, 0, le.acc_logs.inq_ssnsperaddr_count06 );
	inq_ssnsperaddr_count_day        := if(isFCRA, 0, le.acc_logs.inq_ssnsperaddr_count_day );
	inq_ssnsperaddr_count_week       := if(isFCRA, 0, le.acc_logs.inq_ssnsperaddr_count_week );
	inq_adlsperemail_count_week      := if(isFCRA, 0, le.acc_logs.inq_adlsperemail_count_week );
	inq_perbestssn                   := le.best_flags.inq_perbestssn;
	inq_adlsperbestssn               := le.best_flags.inq_adlsperbestssn;
	inq_lnamesperbestssn             := le.best_flags.inq_lnamesperbestssn;
	inq_addrsperbestssn              := le.best_flags.inq_addrsperbestssn;
	inq_dobsperbestssn               := le.best_flags.inq_dobsperbestssn;
	inq_percurraddr                  := le.best_flags.inq_percurraddr;
	inq_adlspercurraddr              := le.best_flags.inq_adlspercurraddr;
	inq_lnamespercurraddr            := le.best_flags.inq_lnamespercurraddr;
	inq_ssnspercurraddr              := le.best_flags.inq_ssnspercurraddr;
	inq_perbestphone                 := le.best_flags.inq_perbestphone;
	inq_adlsperbestphone             := le.best_flags.inq_adlsperbestphone;
	inq_curraddr_ver_count           := le.best_flags.inq_curraddr_ver_count;
	inq_bestfname_ver_count          := le.best_flags.inq_bestfname_ver_count;
	inq_bestlname_ver_count          := le.best_flags.inq_bestlname_ver_count;
	inq_bestssn_ver_count            := le.best_flags.inq_bestssn_ver_count;
	inq_bestdob_ver_count            := le.best_flags.inq_bestdob_ver_count;
	inq_bestphone_ver_count          := le.best_flags.inq_bestphone_ver_count;
	input_ssn_isbestmatch            := le.best_flags.input_ssn_isbestmatch;
	ssns_per_curraddr_curr           := le.best_flags.ssns_per_curraddr_curr;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	did_count                        := if(isFCRA, 0, le.iid.didcount);
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnhighissue                  := (unsigned)le.iid.soclhighissue;
	rc_dwelltype                     := le.iid.dwelltype;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_fname_sources                := le.header_summary.ver_fname_sources;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	addrs_per_ssn                    := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn );
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	inq_addr_ver_count               := le.acc_logs.inquiry_addr_ver_ct;
	inq_fname_ver_count              := le.acc_logs.inquiry_fname_ver_ct;
	inq_lname_ver_count              := le.acc_logs.inquiry_lname_ver_ct;
	inq_ssn_ver_count                := le.acc_logs.inquiry_ssn_ver_ct;
	inq_dob_ver_count                := le.acc_logs.inquiry_dob_ver_ct;
	inq_phone_ver_count              := le.acc_logs.inquiry_phone_ver_ct;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count_day                    := if(isFCRA, 0, le.acc_logs.inquiries.countday);
	inq_count_week                   := if(isFCRA, 0, le.acc_logs.inquiries.countweek);
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count_day               := if(isFCRA, 0, le.acc_logs.auto.countday);
	inq_auto_count_week              := if(isFCRA, 0, le.acc_logs.auto.countweek);
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_banking_count                := le.acc_logs.banking.counttotal;
	inq_banking_count_day            := if(isFCRA, 0, le.acc_logs.banking.countday);
	inq_banking_count_week           := if(isFCRA, 0, le.acc_logs.banking.countweek);
	inq_banking_count01              := le.acc_logs.banking.count01;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_banking_count06              := le.acc_logs.banking.count06;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_banking_count24              := le.acc_logs.banking.count24;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count_week        := if(isFCRA, 0, le.acc_logs.collection.countweek);
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count_week    := if(isFCRA, 0, le.acc_logs.communications.countweek);
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count_day     := if(isFCRA, 0, le.acc_logs.highriskcredit.countday);
	inq_highriskcredit_count_week    := if(isFCRA, 0, le.acc_logs.highriskcredit.countweek);
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_mortgage_count               := le.acc_logs.mortgage.counttotal;
	inq_mortgage_count_week          := if(isFCRA, 0, le.acc_logs.mortgage.countweek);
	inq_mortgage_count01             := le.acc_logs.mortgage.count01;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_mortgage_count06             := le.acc_logs.mortgage.count06;
	inq_mortgage_count12             := le.acc_logs.mortgage.count12;
	inq_mortgage_count24             := le.acc_logs.mortgage.count24;
	inq_other_count                  := le.acc_logs.other.counttotal;
	inq_other_count_day              := if(isFCRA, 0, le.acc_logs.other.countday);
	inq_other_count_week             := if(isFCRA, 0, le.acc_logs.other.countweek);
	inq_other_count01                := le.acc_logs.other.count01;
	inq_other_count03                := le.acc_logs.other.count03;
	inq_other_count06                := le.acc_logs.other.count06;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count_day       := if(isFCRA, 0, le.acc_logs.prepaidCards.countday);
	inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
	inq_quizprovider_count           := le.acc_logs.quizprovider.counttotal;
	inq_quizprovider_count_day       := if(isFCRA, 0, le.acc_logs.QuizProvider.countday);
	inq_quizprovider_count_week      := if(isFCRA, 0, le.acc_logs.QuizProvider.countweek);
	inq_quizprovider_count24         := le.acc_logs.quizprovider.count24;
	inq_retail_count                 := le.acc_logs.retail.counttotal;
	inq_retail_count01               := le.acc_logs.retail.count01;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_retail_count06               := le.acc_logs.retail.count06;
	inq_retail_count12               := le.acc_logs.retail.count12;
	inq_retail_count24               := le.acc_logs.retail.count24;
	inq_retailpayments_count         := le.acc_logs.retailpayments.counttotal;
	inq_retailpayments_count_week    := if(isFCRA, 0, le.acc_logs.retailPayments.countweek);
	inq_retailpayments_count01       := le.acc_logs.retailpayments.count01;
	inq_retailpayments_count03       := le.acc_logs.retailpayments.count03;
	inq_retailpayments_count06       := le.acc_logs.retailpayments.count06;
	inq_retailpayments_count12       := le.acc_logs.retailpayments.count12;
	inq_retailpayments_count24       := le.acc_logs.retailpayments.count24;
	inq_studentloan_count12          := le.acc_logs.studentloans.count12;
	inq_utilities_count              := le.acc_logs.utilities.counttotal;
	inq_utilities_count01            := le.acc_logs.utilities.count01;
	inq_utilities_count03            := le.acc_logs.utilities.count03;
	inq_utilities_count06            := le.acc_logs.utilities.count06;
	inq_utilities_count12            := le.acc_logs.utilities.count12;
	inq_utilities_count24            := le.acc_logs.utilities.count24;
	inq_peradl                       := le.acc_logs.inquiryperadl;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_lnamesperadl                 := if(isFCRA, 0, le.acc_logs.inquirylnamesperadl);
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
	inq_perssn                       := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
	inq_adlsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryADLsPerSSN );
	inq_lnamesperssn                 := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerSSN );
	inq_addrsperssn                  := if(isFCRA, 0, le.acc_logs.inquiryAddrsPerSSN );
	inq_dobsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryDOBsPerSSN );
	inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
	inq_adlsperaddr                  := if(isFCRA, 0, le.acc_logs.inquiryADLsPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
	inq_email_per_adl                := le.acc_logs.inquiryemailsperadl;
	inq_adls_per_email               := if(isFCRA, 0, le.acc_logs.inquiryADLsPerEmail );
	attr_total_number_derogs         := le.total_number_derogs;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	inferred_age                     := le.inferred_age;



	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

NULL := -999999999;

sysdate := common.sas_date(if(le.historydate=999999, (string)Std.Date.Today(), (string6)le.historydate+'01'));

ver_src_am_pos := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');

ver_src_am := ver_src_am_pos > 0;

ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');

ver_src_ar := ver_src_ar_pos > 0;

ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

ver_src_ba := ver_src_ba_pos > 0;

ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');

ver_src_cg := ver_src_cg_pos > 0;

ver_src_da_pos := Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie');

ver_src_da := ver_src_da_pos > 0;

ver_src_d_pos := Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie');

ver_src_d := ver_src_d_pos > 0;

ver_src_dl_pos := Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie');

ver_src_dl := ver_src_dl_pos > 0;

ver_src_eb_pos := Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie');

ver_src_eb := ver_src_eb_pos > 0;

ver_src_e1_pos := Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie');

ver_src_e1 := ver_src_e1_pos > 0;

ver_src_e2_pos := Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie');

ver_src_e2 := ver_src_e2_pos > 0;

ver_src_e3_pos := Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie');

ver_src_e3 := ver_src_e3_pos > 0;

ver_src_en_pos := Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie');

_ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

ver_src_fdate_en := common.sas_date((string)(_ver_src_fdate_en));

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');

_ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_fdate_eq := common.sas_date((string)(_ver_src_fdate_eq));

ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie');

ver_src_fe := ver_src_fe_pos > 0;

ver_src_ff_pos := Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie');

ver_src_ff := ver_src_ff_pos > 0;

ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');

ver_src_p := ver_src_p_pos > 0;

ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');

ver_src_pl := ver_src_pl_pos > 0;

ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie');

_ver_src_fdate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0');

ver_src_fdate_tn := common.sas_date((string)(_ver_src_fdate_tn));

ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie');

ver_src_sl := ver_src_sl_pos > 0;

ver_src_v_pos := Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie');

ver_src_v := ver_src_v_pos > 0;

ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie');

ver_src_vo := ver_src_vo_pos > 0;

ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');

ver_src_w := ver_src_w_pos > 0;

ver_fname_src_en_pos := Models.Common.findw_cpp(ver_fname_sources, 'EN' , '  ,', 'ie');

ver_fname_src_en := ver_fname_src_en_pos > 0;

ver_fname_src_eq_pos := Models.Common.findw_cpp(ver_fname_sources, 'EQ' , '  ,', 'ie');

ver_fname_src_eq := ver_fname_src_eq_pos > 0;

ver_fname_src_tn_pos := Models.Common.findw_cpp(ver_fname_sources, 'TN' , '  ,', 'ie');

ver_fname_src_tn := ver_fname_src_tn_pos > 0;

ver_fname_src_ts_pos := Models.Common.findw_cpp(ver_fname_sources, 'TS' , '  ,', 'ie');

ver_fname_src_ts := ver_fname_src_ts_pos > 0;

ver_fname_src_tu_pos := Models.Common.findw_cpp(ver_fname_sources, 'TU' , '  ,', 'ie');

ver_fname_src_tu := ver_fname_src_tu_pos > 0;

ver_lname_src_en_pos := Models.Common.findw_cpp(ver_lname_sources, 'EN' , '  ,', 'ie');

ver_lname_src_en := ver_lname_src_en_pos > 0;

ver_lname_src_eq_pos := Models.Common.findw_cpp(ver_lname_sources, 'EQ' , '  ,', 'ie');

ver_lname_src_eq := ver_lname_src_eq_pos > 0;

ver_lname_src_tn_pos := Models.Common.findw_cpp(ver_lname_sources, 'TN' , '  ,', 'ie');

ver_lname_src_tn := ver_lname_src_tn_pos > 0;

ver_lname_src_ts_pos := Models.Common.findw_cpp(ver_lname_sources, 'TS' , '  ,', 'ie');

ver_lname_src_ts := ver_lname_src_ts_pos > 0;

ver_lname_src_tu_pos := Models.Common.findw_cpp(ver_lname_sources, 'TU' , '  ,', 'ie');

ver_lname_src_tu := ver_lname_src_tu_pos > 0;

ver_addr_src_en_pos := Models.Common.findw_cpp(ver_addr_sources, 'EN' , '  ,', 'ie');

ver_addr_src_en := ver_addr_src_en_pos > 0;

ver_addr_src_eq_pos := Models.Common.findw_cpp(ver_addr_sources, 'EQ' , '  ,', 'ie');

ver_addr_src_eq := ver_addr_src_eq_pos > 0;

ver_addr_src_tn_pos := Models.Common.findw_cpp(ver_addr_sources, 'TN' , '  ,', 'ie');

ver_addr_src_tn := ver_addr_src_tn_pos > 0;

ver_addr_src_ts_pos := Models.Common.findw_cpp(ver_addr_sources, 'TS' , '  ,', 'ie');

ver_addr_src_ts := ver_addr_src_ts_pos > 0;

ver_addr_src_tu_pos := Models.Common.findw_cpp(ver_addr_sources, 'TU' , '  ,', 'ie');

ver_addr_src_tu := ver_addr_src_tu_pos > 0;

ver_ssn_src_en_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EN' , '  ,', 'ie');

ver_ssn_src_en := ver_ssn_src_en_pos > 0;

ver_ssn_src_eq_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , '  ,', 'ie');

ver_ssn_src_eq := ver_ssn_src_eq_pos > 0;

ver_ssn_src_tn_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TN' , '  ,', 'ie');

ver_ssn_src_tn := ver_ssn_src_tn_pos > 0;

ver_ssn_src_ts_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TS' , '  ,', 'ie');

ver_ssn_src_ts := ver_ssn_src_ts_pos > 0;

ver_ssn_src_tu_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TU' , '  ,', 'ie');

ver_ssn_src_tu := ver_ssn_src_tu_pos > 0;

ver_dob_src_en_pos := Models.Common.findw_cpp(ver_dob_sources, 'EN' , '  ,', 'ie');

ver_dob_src_en := ver_dob_src_en_pos > 0;

ver_dob_src_eq_pos := Models.Common.findw_cpp(ver_dob_sources, 'EQ' , '  ,', 'ie');

ver_dob_src_eq := ver_dob_src_eq_pos > 0;

ver_dob_src_tn_pos := Models.Common.findw_cpp(ver_dob_sources, 'TN' , '  ,', 'ie');

ver_dob_src_tn := ver_dob_src_tn_pos > 0;

ver_dob_src_ts_pos := Models.Common.findw_cpp(ver_dob_sources, 'TS' , '  ,', 'ie');

ver_dob_src_ts := ver_dob_src_ts_pos > 0;

ver_dob_src_tu_pos := Models.Common.findw_cpp(ver_dob_sources, 'TU' , '  ,', 'ie');

ver_dob_src_tu := ver_dob_src_tu_pos > 0;





iv_add_apt := __common__(if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' 
                          or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' 
                          or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0'));

sum_src_credentialed := if(max((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w) = NULL, NULL, sum((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w));

beta_synthid_trigger_v2 := sum_src_credentialed = 0;

earliest_bur_date_all := if(ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL and ver_src_fdate_tn = NULL, NULL, if(max(ver_src_fdate_en, ver_src_fdate_eq, ver_src_fdate_tn) = NULL, NULL, min(if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq), if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn))));

ca_m_bureau_fs := map(
    not(truedid)                 => NULL,
    earliest_bur_date_all = NULL => -1,
                                    min(if(if ((sysdate - earliest_bur_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_bur_date_all) / (365.25 / 12)), roundup((sysdate - earliest_bur_date_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - earliest_bur_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_bur_date_all) / (365.25 / 12)), roundup((sysdate - earliest_bur_date_all) / (365.25 / 12)))), 999));

nf_addrs_per_ssn := if(not(ssnlength > '0'), NULL, min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 999));

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

ca_inq_perssn_count01 := if(not(truedid), NULL, min(if(Inq_PerSSN_count01 = NULL, -NULL, Inq_PerSSN_count01), 999));

rv_s66_adlperssn_count := map(
    not(ssnlength > '0') => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

rv_i60_credit_seeking := if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))))));

rv_i60_inq_recency := map(
    not(truedid) => NULL,
   (boolean) inq_count01  => 1,
   (boolean) inq_count03  => 3,
   (boolean) inq_count06  => 6,
   (boolean) inq_count12  => 12,
   (boolean) inq_count24  => 24,
   (boolean) inq_count    => 99,
                    0);

rv_i61_inq_collection_count12 := if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999));

rv_i61_inq_collection_recency := map(
    not(truedid)           => NULL,
   (boolean) inq_collection_count01 => 1,
   (boolean) inq_collection_count03 => 3,
   (boolean) inq_collection_count06 => 6,
   (boolean) inq_collection_count12 => 12,
   (boolean) inq_collection_count24 => 24,
   (boolean) inq_collection_count   => 99,
                              0);

rv_i60_inq_auto_count12 := if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999));

rv_i60_inq_auto_recency := map(
    not(truedid)     => NULL,
   (boolean) inq_auto_count01 => 1,
   (boolean) inq_auto_count03 => 3,
   (boolean) inq_auto_count06 => 6,
   (boolean) inq_auto_count12 => 12,
   (boolean) inq_auto_count24 => 24,
   (boolean) inq_auto_count   => 99,
                        0);

rv_i60_inq_banking_count12 := if(not(truedid), NULL, min(if(inq_banking_count12 = NULL, -NULL, inq_banking_count12), 999));

rv_i60_inq_banking_recency := map(
    not(truedid)        => NULL,
   (boolean) inq_banking_count01 => 1,
   (boolean) inq_banking_count03 => 3,
   (boolean) inq_banking_count06 => 6,
   (boolean) inq_banking_count12 => 12,
   (boolean) inq_banking_count24 => 24,
   (boolean) inq_banking_count   => 99,
                           0);

rv_i60_inq_mortgage_count12 := if(not(truedid), NULL, min(if(inq_mortgage_count12 = NULL, -NULL, inq_mortgage_count12), 999));

rv_i60_inq_mortgage_recency := map(
    not(truedid)         => NULL,
   (boolean) inq_mortgage_count01 => 1,
   (boolean) inq_mortgage_count03 => 3,
   (boolean) inq_mortgage_count06 => 6,
   (boolean) inq_mortgage_count12 => 12,
   (boolean) inq_mortgage_count24 => 24,
   (boolean) inq_mortgage_count   => 99,
                            0);

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

rv_i60_inq_hiriskcred_recency := map(
    not(truedid)               => NULL,
   (boolean) inq_highRiskCredit_count01 => 1,
   (boolean) inq_highRiskCredit_count03 => 3,
   (boolean) inq_highRiskCredit_count06 => 6,
   (boolean) inq_highRiskCredit_count12 => 12,
   (boolean) inq_highRiskCredit_count24 => 24,
   (boolean) inq_highRiskCredit_count   => 99,
                                  0);

rv_i60_inq_prepaidcards_count12 := if(not(truedid), NULL, min(if(inq_PrepaidCards_count12 = NULL, -NULL, inq_PrepaidCards_count12), 999));

rv_i60_inq_prepaidcards_recency := map(
    not(truedid)             => NULL,
   (boolean) inq_PrepaidCards_count01 => 1,
   (boolean) inq_PrepaidCards_count03 => 3,
   (boolean) inq_PrepaidCards_count06 => 6,
   (boolean) inq_PrepaidCards_count12 => 12,
   (boolean) inq_PrepaidCards_count24 => 24,
   (boolean) inq_PrepaidCards_count   => 99,
                                0);

rv_i60_inq_retail_count12 := if(not(truedid), NULL, min(if(inq_retail_count12 = NULL, -NULL, inq_retail_count12), 999));

rv_i60_inq_retail_recency := map(
    not(truedid)       => NULL,
   (boolean) inq_retail_count01 => 1,
   (boolean) inq_retail_count03 => 3,
   (boolean) inq_retail_count06 => 6,
   (boolean) inq_retail_count12 => 12,
   (boolean) inq_retail_count24 => 24,
   (boolean) inq_retail_count   => 99,
                          0);

rv_i60_inq_retpymt_count12 := if(not(truedid), NULL, min(if(inq_retailpayments_count12 = NULL, -NULL, inq_retailpayments_count12), 999));

rv_i60_inq_retpymt_recency := map(
    not(truedid)               => NULL,
   (boolean) inq_retailpayments_count01 => 1,
   (boolean) inq_retailpayments_count03 => 3,
   (boolean) inq_retailpayments_count06 => 6,
   (boolean) inq_retailpayments_count12 => 12,
   (boolean) inq_retailpayments_count24 => 24,
   (boolean) inq_retailpayments_count   => 99,
                                  0);

rv_i60_inq_comm_count12 := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999));

rv_i60_inq_comm_recency := map(
    not(truedid)               => NULL,
   (boolean) inq_communications_count01 => 1,
   (boolean) inq_communications_count03 => 3,
   (boolean) inq_communications_count06 => 6,
   (boolean) inq_communications_count12 => 12,
   (boolean) inq_communications_count24 => 24,
   (boolean) inq_communications_count   => 99,
                                  0);

rv_i60_inq_stdloan_count12 := if(not(truedid), NULL, min(if(inq_studentloan_count12 = NULL, -NULL, inq_studentloan_count12), 999));

rv_i60_inq_util_count12 := if(not(truedid), NULL, min(if(inq_utilities_count12 = NULL, -NULL, inq_utilities_count12), 999));

rv_i60_inq_util_recency := map(
    not(truedid)          => NULL,
   (boolean) inq_utilities_count01 => 1,
   (boolean) inq_utilities_count03 => 3,
   (boolean) inq_utilities_count06 => 6,
   (boolean) inq_utilities_count12 => 12,
   (boolean) inq_utilities_count24 => 24,
   (boolean) inq_utilities_count   => 99,
                             0);

rv_i60_inq_other_count12 := if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999));

rv_i60_inq_other_recency := map(
    not(truedid)      => NULL,
   (boolean) inq_other_count01 => 1,
   (boolean) inq_other_count03 => 3,
   (boolean) inq_other_count06 => 6,
   (boolean) inq_other_count12 => 12,
   (boolean) inq_other_count24 => 24,
   (boolean) inq_other_count   => 99,
                         0);

rv_i62_inq_ssns_per_adl := if(not(truedid), NULL, min(if(inq_ssnsperadl = NULL, -NULL, inq_ssnsperadl), 999));

rv_i62_inq_addrs_per_adl := if(not(truedid), NULL, min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 999));

rv_i62_inq_num_names_per_adl := if(not(truedid), NULL, max(inq_fnamesperadl, inq_lnamesperadl));

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

rv_i62_inq_dobs_per_adl := if(not(truedid), NULL, min(if(inq_dobsperadl = NULL, -NULL, inq_dobsperadl), 999));

nf_inq_fname_ver_count := if(not(truedid), NULL, inq_fname_ver_count);

nf_inq_lname_ver_count := if(not(truedid), NULL, inq_lname_ver_count);

nf_inq_addr_ver_count := if(not(truedid), NULL, inq_addr_ver_count);

nf_inq_dob_ver_count := if(not(truedid), NULL, inq_dob_ver_count);

nf_inq_ssn_ver_count := if(not(truedid), NULL, inq_ssn_ver_count);

//nf_inquiry_verification_index := if(not(truedid), NULL, if(max( (integer)(max(inq_fname_ver_count, inq_lname_ver_count) > 0), 2  * (integer)(inq_phone_ver_count > 0), 4 * (integer)(inq_addr_ver_count > 0), 8 * (integer)(inq_dob_ver_count > 0), 16* (integer)(inq_ssn_ver_count > 0)) = NULL, NULL, sum(if((integer)(max(inq_fname_ver_count, inq_lname_ver_count) > 0) = NULL, 0,  (integer)(max(inq_fname_ver_count, inq_lname_ver_count) > 0)), if(2  * (integer)(inq_phone_ver_count > 0) = NULL, 0, 2 ** 1 * (integer)(inq_phone_ver_count > 0)), if(4 * (integer)(inq_addr_ver_count > 0) = NULL, 0, 4 * (integer)(inq_addr_ver_count > 0)), if(8 * (integer)(inq_dob_ver_count > 0) = NULL, 0, 8* (integer)(inq_dob_ver_count > 0)), if(16 * (integer)(inq_ssn_ver_count > 0) = NULL, 0, 16 * (integer)(inq_ssn_ver_count > 0)))));


// nf_inquiry_verification_index := if(not(truedid), NULL, 
                                 // if(max((integer)(max((integer)(inq_fname_ver_count < 255), (integer)(inq_lname_ver_count < 255)) > 0), 
																                     // 2 * (integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255), 
																										 // 4 * (integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255), 
																										 // 8 * (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255), 
																										 // 16 * (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255)) = NULL, NULL, 
																// sum(if( (integer)(max((integer)(inq_fname_ver_count < 255), (integer)inq_lname_ver_count < 255) > 0) = NULL, 0, 
																   // (integer)(max((integer)(inq_fname_ver_count < 255), (integer)(integer)inq_lname_ver_count < 255) > 0)), 
																	 // if(2 * (integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255) = NULL, 0, 2 * (integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255)), 
																	 // if(4 * (integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255) = NULL, 0, 4 * (integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255)), 
																	 // if(8 * (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255) = NULL, 0, 8 * (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255)), 
																	 // if(16 * (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255) = NULL, 0, 16 * (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255)))));


nf_inquiry_verification_index := __common__(  IF(NOT(truedid), NULL, 
                                    IF(MAX(POWER(2,0) * (INTEGER)(MAX(inq_fname_ver_count, inq_lname_ver_count) > 0), 
                                           POWER(2,1) * (INTEGER)(inq_phone_ver_count > 0), 
                                           POWER(2,2) * (INTEGER)(inq_addr_ver_count > 0), 
                                           POWER(2,3) * (INTEGER)(inq_dob_ver_count > 0), 
                                           POWER(2,4) * (INTEGER)(inq_ssn_ver_count > 0)) = NULL, NULL, 
                                    SUM(IF(POWER(2,0) * (INTEGER)(MAX(inq_fname_ver_count, inq_lname_ver_count) > 0) = NULL, 0, 
                                           POWER(2,0) * (INTEGER)(MAX(inq_fname_ver_count, inq_lname_ver_count) > 0)), 
                                        IF(POWER(2,1) * (INTEGER)(inq_phone_ver_count > 0) = NULL, 0, 
                                           POWER(2,1) * (INTEGER)(inq_phone_ver_count > 0)), 
                                        IF(POWER(2,2) * (INTEGER)(inq_addr_ver_count > 0) = NULL, 0, 
                                           POWER(2,2) * (INTEGER)(inq_addr_ver_count > 0)), 
                                        IF(POWER(2,3) * (INTEGER)(inq_dob_ver_count > 0) = NULL, 0, 
                                           POWER(2,3) * (INTEGER)(inq_dob_ver_count > 0)), 
                                        IF(POWER(2,4) * (INTEGER)(inq_ssn_ver_count > 0) = NULL, 0, 
                                           POWER(2,4) * (INTEGER)(inq_ssn_ver_count > 0))))));



//nf_inquiry_adl_vel_risk_index := if(not(truedid), NULL, if(max(2 ** 0 * (integer)(inq_lnamesperadl > 2), 2 ** 1 * (integer)(inq_phonesperadl > 2), 2 ** 2 * (integer)(inq_addrsperadl > 2), 2 ** 3 * (integer)(inq_dobsperadl > 2), 2 ** 4 * (integer)(inq_ssnsperadl > 2)) = NULL, NULL, sum(if(2 ** 0 * (integer)(inq_lnamesperadl > 2) = NULL, 0, 2 ** 0 * (integer)(inq_lnamesperadl > 2)), if(2 ** 1 * (integer)(inq_phonesperadl > 2) = NULL, 0, 2 ** 1 * (integer)(inq_phonesperadl > 2)), if(2 ** 2 * (integer)(inq_addrsperadl > 2) = NULL, 0, 2 ** 2 * (integer)(inq_addrsperadl > 2)), if(2 ** 3 * (integer)(inq_dobsperadl > 2) = NULL, 0, 2 ** 3 * (integer)(inq_dobsperadl > 2)), if(2 ** 4 * (integer)(inq_ssnsperadl > 2) = NULL, 0, 2 ** 4 * (integer)(inq_ssnsperadl > 2)))));

nf_inquiry_adl_vel_risk_index := if(not(truedid), NULL, 
                                 if(max((integer)(inq_lnamesperadl > 2), 
                                    2* (integer)(inq_phonesperadl > 2), 
                                    4* (integer)(inq_addrsperadl > 2), 
                                    8* (integer)(inq_dobsperadl > 2), 
                                    16* (integer)(inq_ssnsperadl > 2)) = NULL, NULL, 
                                    sum(if((integer)(inq_lnamesperadl > 2) = NULL, 0, 
                                          (integer)(inq_lnamesperadl > 2)), 
                                             if(2*(integer)(inq_phonesperadl > 2) = NULL, 0, 
                                                2*(integer)(inq_phonesperadl > 2)), 
                                                   if(4* (integer)(inq_addrsperadl > 2) = NULL, 0, 
                                                      4* (integer)(inq_addrsperadl > 2)), 
                                                         if(8* (integer)(inq_dobsperadl > 2) = NULL, 0, 
                                                            8* (integer)(inq_dobsperadl > 2)), 
                                                                if(16* (integer)(inq_ssnsperadl > 2) = NULL, 0, 
                                                                   16* (integer)(inq_ssnsperadl > 2)))));





nf_inquiry_ssn_vel_risk_index := if(not((integer)ssnlength in [4, 9]), -1, 
                               if(max((integer)(inq_adlsperssn > 1), 
                                      2 * (integer)(inq_lnamesperssn > 1), 
                                      4 * (integer)(inq_addrsperssn > 2), 
                                      8 * (integer)(inq_dobsperssn > 1)) = NULL, NULL,
                                           sum(if( (integer)(inq_adlsperssn > 1) = NULL, 0, 
                                                   (integer)(inq_adlsperssn > 1)), 
                                               if(2 * (integer)(inq_lnamesperssn > 1) = NULL, 0, 
                                                  2 * (integer)(inq_lnamesperssn > 1)), 
                                               if(4 * (integer)(inq_addrsperssn > 2) = NULL, 0, 
                                                  4 * (integer)(inq_addrsperssn > 2)), 
                                               if(8 * (integer)(inq_dobsperssn > 1) = NULL, 0, 
                                                  8 * (integer)(inq_dobsperssn > 1)))));



// ssnlengthNot49   :=   ssnlength NOT IN ['4', '9'];
// nf_inquiry_ssn_vel_risk_index := if(ssnlengthNot49, -1, 
                                      // if(max((integer)(inq_adlsperssn > 1), 
                                      // 2 * (integer)(inq_lnamesperssn > 1), 
                                      // 4 * (integer)(inq_addrsperssn > 2), 
                                      // 8 * (integer)(inq_dobsperssn > 1)) = NULL, NULL, 
																			   // sum(if((integer)(inq_adlsperssn > 1) = NULL, 0, 
                                                // (integer)(inq_adlsperssn > 1)), 
																				     // if(2 * (integer)(inq_lnamesperssn > 1) = NULL, 0,
                                                // 2 * (integer)(inq_lnamesperssn > 1)), 
																						 // if(4 * (integer)(inq_addrsperssn > 2) = NULL, 0,
                                                // 4 * (integer)(inq_addrsperssn > 2)), 
																						 // if(8 * (integer)(inq_dobsperssn > 1) = NULL, 0,
                                                // 8 * (integer)(inq_dobsperssn > 1)))));





//nf_inq_addr_recency_risk_index := if(not(addrpop), -1, if(max(2 ** 0 * (integer)(inq_adlsperaddr_count01 > 1), 2 ** 1 * (integer)(inq_lnamesperaddr_count01 > 1), 2 ** 2 * (integer)(inq_ssnsperaddr_count01 > 1)) = NULL, NULL, sum(if(2 ** 0 * (integer)(inq_adlsperaddr_count01 > 1) = NULL, 0, 2 ** 0 * (integer)(inq_adlsperaddr_count01 > 1)), if(2 ** 1 * (integer)(inq_lnamesperaddr_count01 > 1) = NULL, 0, 2 ** 1 * (integer)(inq_lnamesperaddr_count01 > 1)), if(2 ** 2 * (integer)(inq_ssnsperaddr_count01 > 1) = NULL, 0, 2 ** 2 * (integer)(inq_ssnsperaddr_count01 > 1)))));

nf_inq_addr_recency_risk_index :=   __common__(if(not(addrpop), -1, if(max((integer)(inq_adlsperaddr_count01 > 1), 
                              2*(integer)(inq_lnamesperaddr_count01 > 1), 
                              4*(integer)(inq_ssnsperaddr_count01 > 1)) = NULL, NULL, 
                              sum(if( (integer)(inq_adlsperaddr_count01 > 1) = NULL, 0,  (integer)(inq_adlsperaddr_count01 > 1)), 
                              if(2*(integer)(inq_lnamesperaddr_count01 > 1) = NULL, 0, 2*(integer)(inq_lnamesperaddr_count01 > 1)), 
                                if(4* (integer)(inq_ssnsperaddr_count01 > 1) = NULL, 0, 4*(integer)(inq_ssnsperaddr_count01 > 1))))));


 //ssnlengthNot49   :=   ssnlength NOT IN ['4', '9'];      
     

nf_inquiry_ssn_vel_risk_indexv2 := map(
    not((integer)ssnlength in [4, 9])     => -1,
    nf_inquiry_ssn_vel_risk_index = 0                 => 0,
    (nf_inquiry_ssn_vel_risk_index in [1, 2, 3])      => 1,
    (nf_inquiry_ssn_vel_risk_index in [4, 5, 6, 7])   => 3,
    (nf_inquiry_ssn_vel_risk_index in [8, 9, 10, 11]) => 2,
                                                        4);
     
     
      
     
     
     
     
     

//nf_inquiry_addr_vel_risk_index := if(not(addrpop), -1, if(max(2 ** 0 * (integer)(inq_adlsperaddr > 2), 2 ** 1 * (integer)(inq_lnamesperaddr > 2), 2 ** 2 * (integer)(inq_ssnsperaddr > 2)) = NULL, NULL, sum(if(2 ** 0 * (integer)(inq_adlsperaddr > 2) = NULL, 0, 2 ** 0 * (integer)(inq_adlsperaddr > 2)), if(2 ** 1 * (integer)(inq_lnamesperaddr > 2) = NULL, 0, 2 ** 1 * (integer)(inq_lnamesperaddr > 2)), if(2 ** 2 * (integer)(inq_ssnsperaddr > 2) = NULL, 0, 2 ** 2 * (integer)(inq_ssnsperaddr > 2)))));

nf_inquiry_addr_vel_risk_index := if(not(addrpop), -1, 
                                      if(max((integer)(inq_adlsperaddr > 2), 2 * (integer)(inq_lnamesperaddr > 2), 4 * (integer)(inq_ssnsperaddr > 2)) = NULL, NULL, 
																			   sum(if((integer)(inq_adlsperaddr > 2) = NULL, 0, (integer)(inq_adlsperaddr > 2)), 
																				     if(2 * (integer)(inq_lnamesperaddr > 2) = NULL, 0, 2 * (integer)(inq_lnamesperaddr > 2)), 
																						 if(4 * (integer)(inq_ssnsperaddr > 2) = NULL, 0, 4 * (integer)(inq_ssnsperaddr > 2)))));



nf_inquiry_addr_vel_risk_indexv2 := map(
    not(addrpop)                               => -1,
    nf_inquiry_addr_vel_risk_index = 0         => 0,
    nf_inquiry_addr_vel_risk_index = 1         => 1,
    (nf_inquiry_addr_vel_risk_index in [3, 5]) => 2,
    (nf_inquiry_addr_vel_risk_index in [2, 4]) => 3,
                                                  4);

nf_inq_count := if(not(truedid), NULL, min(if(inq_count = NULL, -NULL, inq_count), 999));

nf_inq_count_day := if(not(truedid), NULL, min(if(inq_count_day = NULL, -NULL, inq_count_day), 999));

nf_inq_count_week := if(not(truedid), NULL, min(if(inq_count_week = NULL, -NULL, inq_count_week), 999));

nf_inq_count24 := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

nf_inq_auto_count := if(not(truedid), NULL, min(if(inq_Auto_count = NULL, -NULL, inq_Auto_count), 999));

nf_inq_auto_count_day := if(not(truedid), NULL, min(if(inq_Auto_count_day = NULL, -NULL, inq_Auto_count_day), 999));

nf_inq_auto_count_week := if(not(truedid), NULL, min(if(inq_Auto_count_week = NULL, -NULL, inq_Auto_count_week), 999));

nf_inq_auto_count24 := if(not(truedid), NULL, min(if(inq_Auto_count24 = NULL, -NULL, inq_Auto_count24), 999));

nf_inq_banking_count := if(not(truedid), NULL, min(if(inq_Banking_count = NULL, -NULL, inq_Banking_count), 999));

nf_inq_banking_count_day := if(not(truedid), NULL, min(if(inq_Banking_count_day = NULL, -NULL, inq_Banking_count_day), 999));

nf_inq_banking_count_week := if(not(truedid), NULL, min(if(inq_Banking_count_week = NULL, -NULL, inq_Banking_count_week), 999));

nf_inq_banking_count24 := if(not(truedid), NULL, min(if(inq_Banking_count24 = NULL, -NULL, inq_Banking_count24), 999));

nf_inq_collection_count := if(not(truedid), NULL, min(if(inq_Collection_count = NULL, -NULL, inq_Collection_count), 999));

nf_inq_collection_count_week := if(not(truedid), NULL, min(if(inq_Collection_count_week = NULL, -NULL, inq_Collection_count_week), 999));

nf_inq_collection_count24 := if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999));

nf_inq_communications_count := if(not(truedid), NULL, min(if(inq_Communications_count = NULL, -NULL, inq_Communications_count), 999));

nf_inq_communications_count_week := if(not(truedid), NULL, min(if(inq_Communications_count_week = NULL, -NULL, inq_Communications_count_week), 999));

nf_inq_communications_count24 := if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999));

nf_inq_highriskcredit_count := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count = NULL, -NULL, inq_HighRiskCredit_count), 999));

nf_inq_highriskcredit_count_day := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count_day = NULL, -NULL, inq_HighRiskCredit_count_day), 999));

nf_inq_highriskcredit_count_week := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count_week = NULL, -NULL, inq_HighRiskCredit_count_week), 999));

nf_inq_highriskcredit_count24 := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999));

nf_inq_mortgage_count := if(not(truedid), NULL, min(if(inq_Mortgage_count = NULL, -NULL, inq_Mortgage_count), 999));

nf_inq_mortgage_count_week := if(not(truedid), NULL, min(if(inq_Mortgage_count_week = NULL, -NULL, inq_Mortgage_count_week), 999));

nf_inq_mortgage_count24 := if(not(truedid), NULL, min(if(inq_Mortgage_count24 = NULL, -NULL, inq_Mortgage_count24), 999));

nf_inq_other_count := if(not(truedid), NULL, min(if(inq_Other_count = NULL, -NULL, inq_Other_count), 999));

nf_inq_other_count_day := if(not(truedid), NULL, min(if(inq_Other_count_day = NULL, -NULL, inq_Other_count_day), 999));

nf_inq_other_count_week := if(not(truedid), NULL, min(if(inq_Other_count_week = NULL, -NULL, inq_Other_count_week), 999));

nf_inq_other_count24 := if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999));

nf_inq_prepaidcards_count := if(not(truedid), NULL, min(if(inq_PrepaidCards_count = NULL, -NULL, inq_PrepaidCards_count), 999));

nf_inq_prepaidcards_count_day := if(not(truedid), NULL, min(if(inq_PrepaidCards_count_day = NULL, -NULL, inq_PrepaidCards_count_day), 999));

nf_inq_prepaidcards_count24 := if(not(truedid), NULL, min(if(inq_PrepaidCards_count24 = NULL, -NULL, inq_PrepaidCards_count24), 999));

nf_inq_quizprovider_count := if(not(truedid), NULL, min(if(inq_QuizProvider_count = NULL, -NULL, inq_QuizProvider_count), 999));

nf_inq_quizprovider_count_day := if(not(truedid), NULL, min(if(inq_QuizProvider_count_day = NULL, -NULL, inq_QuizProvider_count_day), 999));

nf_inq_quizprovider_count_week := if(not(truedid), NULL, min(if(inq_QuizProvider_count_week = NULL, -NULL, inq_QuizProvider_count_week), 999));

nf_inq_quizprovider_count24 := if(not(truedid), NULL, min(if(inq_QuizProvider_count24 = NULL, -NULL, inq_QuizProvider_count24), 999));

nf_inq_retail_count := if(not(truedid), NULL, min(if(inq_Retail_count = NULL, -NULL, inq_Retail_count), 999));

nf_inq_retail_count24 := if(not(truedid), NULL, min(if(inq_Retail_count24 = NULL, -NULL, inq_Retail_count24), 999));

nf_inq_retailpayments_count := if(not(truedid), NULL, min(if(inq_RetailPayments_count = NULL, -NULL, inq_RetailPayments_count), 999));

nf_inq_retailpayments_count_week := if(not(truedid), NULL, min(if(inq_RetailPayments_count_week = NULL, -NULL, inq_RetailPayments_count_week), 999));

nf_inq_retailpayments_count24 := if(not(truedid), NULL, min(if(inq_RetailPayments_count24 = NULL, -NULL, inq_RetailPayments_count24), 999));

nf_inq_utilities_count := if(not(truedid), NULL, min(if(inq_Utilities_count = NULL, -NULL, inq_Utilities_count), 999));

nf_inq_utilities_count24 := if(not(truedid), NULL, min(if(inq_Utilities_count24 = NULL, -NULL, inq_Utilities_count24), 999));

nf_inq_per_ssn := if(not(ssnlength > '0'), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

nf_inq_adls_per_ssn := if(not(ssnlength > '0'), NULL, min(if(inq_adlsperssn = NULL, -NULL, inq_adlsperssn), 999));

nf_inq_lnames_per_ssn := if(not(ssnlength > '0'), NULL, min(if(inq_lnamesperssn = NULL, -NULL, inq_lnamesperssn), 999));

nf_inq_addrs_per_ssn := if(not(ssnlength > '0'), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999));

nf_inq_dobs_per_ssn := if(not(ssnlength > '0'), NULL, min(if(inq_dobsperssn = NULL, -NULL, inq_dobsperssn), 999));

nf_inq_per_addr := if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

nf_inq_per_apt_addr := map(
    not(addrpop)                      => NULL,
    iv_add_apt= '0' => -1,
                                         min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

nf_inq_per_sfd_addr := map(
    not(addrpop) => NULL,
    iv_add_apt = '1'  => -1,
                    min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

nf_inq_adls_per_addr := if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

nf_inq_adls_per_apt_addr := map(
    not(addrpop)                      => NULL,
    iv_add_apt= '0' => -1,
                                         min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

nf_inq_adls_per_sfd_addr := map(
    not(addrpop) => NULL,
    iv_add_apt ='1'  => -1,
                    min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

nf_inq_lnames_per_addr := if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

nf_inq_lnames_per_apt_addr := map(
    not(addrpop)                      => NULL,
    iv_add_apt= '0' => -1,
                                         min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

nf_inq_lnames_per_sfd_addr := map(
    not(addrpop) => NULL,
    iv_add_apt ='1'  => -1,
                    min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

nf_inq_ssns_per_addr := if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

nf_inq_ssns_per_apt_addr := map(
    not(addrpop)                      => NULL,
   (integer)iv_add_apt= 0 => -1,
                                         min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

nf_inq_ssns_per_sfd_addr := map(
    not(addrpop) => NULL,
   (integer) iv_add_apt =1  => -1,
                    min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));




nf_inq_email_per_adl := if(not(truedid), NULL, min(if(inq_email_per_adl = NULL, -NULL, inq_email_per_adl), 999));

rv_i60_inq_peradl_recency := map(
    not(truedid)       => NULL,
    (boolean)inq_peradl_count01 => 1,
    (boolean)inq_peradl_count03 => 3,
    (boolean)inq_peradl_count06 => 6,
    (boolean)Inq_PerADL         => 12,
                          0);

rv_i60_inq_peradl_count12 := if(not(truedid), NULL, min(if(Inq_PerADL = NULL, -NULL, Inq_PerADL), 999));

nf_inq_peradl_count_day := if(not(truedid), NULL, min(if(inq_peradl_count_day = NULL, -NULL, inq_peradl_count_day), 999));

nf_inq_peradl_count_week := if(not(truedid), NULL, min(if(inq_peradl_count_week = NULL, -NULL, inq_peradl_count_week), 999));

rv_i62_inq_ssnsperadl_recency := map(
    not(truedid)           => NULL,
    (boolean)inq_ssnsperadl_count01 => 1,
   (boolean) inq_ssnsperadl_count03 => 3,
   (boolean) inq_ssnsperadl_count06 => 6,
    (boolean)Inq_SSNsPerADL         => 12,
                              0);

rv_i62_inq_ssnsperadl_count12 := if(not(truedid), NULL, min(if(Inq_SSNsPerADL = NULL, -NULL, Inq_SSNsPerADL), 999));

nf_inq_ssnsperadl_count_day := if(not(truedid), NULL, min(if(inq_ssnsperadl_count_day = NULL, -NULL, inq_ssnsperadl_count_day), 999));

nf_inq_ssnsperadl_count_week := if(not(truedid), NULL, min(if(inq_ssnsperadl_count_week = NULL, -NULL, inq_ssnsperadl_count_week), 999));

rv_i62_inq_addrsperadl_recency := map(
    not(truedid)            => NULL,
   (boolean) inq_addrsperadl_count01 => 1,
   (boolean) inq_addrsperadl_count03 => 3,
   (boolean) inq_addrsperadl_count06 => 6,
   (boolean) Inq_AddrsPerADL         => 12,
                               0);

rv_i62_inq_addrsperadl_count12 := if(not(truedid), NULL, min(if(Inq_AddrsPerADL = NULL, -NULL, Inq_AddrsPerADL), 999));

nf_inq_addrsperadl_count_day := if(not(truedid), NULL, min(if(inq_addrsperadl_count_day = NULL, -NULL, inq_addrsperadl_count_day), 999));

nf_inq_addrsperadl_count_week := if(not(truedid), NULL, min(if(inq_addrsperadl_count_week = NULL, -NULL, inq_addrsperadl_count_week), 999));

rv_i62_inq_lnamesperadl_recency := map(
    not(truedid)             => NULL,
   (boolean) inq_lnamesperadl_count01 => 1,
    (boolean)inq_lnamesperadl_count03 => 3,
   (boolean) inq_lnamesperadl_count06 => 6,
   (boolean) Inq_LnamesPerADL         => 12,
                                0);

rv_i62_inq_lnamesperadl_count12 := if(not(truedid), NULL, min(if(Inq_LnamesPerADL = NULL, -NULL, Inq_LnamesPerADL), 999));

nf_inq_lnamesperadl_count_day := if(not(truedid), NULL, min(if(inq_lnamesperadl_count_day = NULL, -NULL, inq_lnamesperadl_count_day), 999));

nf_inq_lnamesperadl_count_week := if(not(truedid), NULL, min(if(inq_lnamesperadl_count_week = NULL, -NULL, inq_lnamesperadl_count_week), 999));

rv_i62_inq_fnamesperadl_recency := map(
    not(truedid)             => NULL,
   (boolean) inq_fnamesperadl_count01 => 1,
   (boolean) inq_fnamesperadl_count03 => 3,
    (boolean)inq_fnamesperadl_count06 => 6,
   (boolean) Inq_FnamesPerADL         => 12,
                                0);

rv_i62_inq_fnamesperadl_count12 := if(not(truedid), NULL, min(if(Inq_FnamesPerADL = NULL, -NULL, Inq_FnamesPerADL), 999));

nf_inq_fnamesperadl_count_day := if(not(truedid), NULL, min(if(inq_fnamesperadl_count_day = NULL, -NULL, inq_fnamesperadl_count_day), 999));

nf_inq_fnamesperadl_count_week := if(not(truedid), NULL, min(if(inq_fnamesperadl_count_week = NULL, -NULL, inq_fnamesperadl_count_week), 999));

rv_i62_inq_phonesperadl_recency := map(
    not(truedid)             => NULL,
   (boolean) inq_phonesperadl_count01 => 1,
   (boolean) inq_phonesperadl_count03 => 3,
   (boolean) inq_phonesperadl_count06 => 6,
   (boolean) Inq_PhonesPerADL         => 12,
                                0);

rv_i62_inq_phonesperadl_count12 := if(not(truedid), NULL, min(if(Inq_PhonesPerADL = NULL, -NULL, Inq_PhonesPerADL), 999));

nf_inq_phonesperadl_count_day := if(not(truedid), NULL, min(if(inq_phonesperadl_count_day = NULL, -NULL, inq_phonesperadl_count_day), 999));

nf_inq_phonesperadl_count_week := if(not(truedid), NULL, min(if(inq_phonesperadl_count_week = NULL, -NULL, inq_phonesperadl_count_week), 999));

rv_i62_inq_dobsperadl_recency := map(
    not(truedid)           => NULL,
   (boolean) inq_dobsperadl_count01 => 1,
   (boolean) inq_dobsperadl_count03 => 3,
   (boolean) inq_dobsperadl_count06 => 6,
   (boolean) Inq_DOBsPerADL         => 12,
                              0);

rv_i62_inq_dobsperadl_count12 := if(not(truedid), NULL, min(if(Inq_DOBsPerADL = NULL, -NULL, Inq_DOBsPerADL), 999));

nf_inq_dobsperadl_count_day := if(not(truedid), NULL, min(if(inq_dobsperadl_count_day = NULL, -NULL, inq_dobsperadl_count_day), 999));

nf_inq_dobsperadl_count_week := if(not(truedid), NULL, min(if(inq_dobsperadl_count_week = NULL, -NULL, inq_dobsperadl_count_week), 999));

nf_inq_perssn_recency := map(
    not(truedid)       => NULL,
   (boolean) inq_perssn_count01 => 1,
   (boolean) inq_perssn_count03 => 3,
   (boolean) inq_perssn_count06 => 6,
   (boolean) Inq_PerSSN         => 12,
                          0);

nf_inq_perssn_count12 := if(not(truedid), NULL, min(if(Inq_PerSSN = NULL, -NULL, Inq_PerSSN), 999));

nf_inq_perssn_count_day := if(not(truedid), NULL, min(if(inq_perssn_count_day = NULL, -NULL, inq_perssn_count_day), 999));

nf_inq_perssn_count_week := if(not(truedid), NULL, min(if(inq_perssn_count_week = NULL, -NULL, inq_perssn_count_week), 999));

nf_inq_adlsperssn_recency := map(
    not(truedid)           => NULL,
    (boolean)inq_adlsperssn_count01 => 1,
    (boolean)inq_adlsperssn_count03 => 3,
    (boolean)inq_adlsperssn_count06 => 6,
    (boolean)Inq_ADLsPerSSN         => 12,
                              0);

nf_inq_adlsperssn_count12 := if(not(truedid), NULL, min(if(Inq_ADLsPerSSN = NULL, -NULL, Inq_ADLsPerSSN), 999));

nf_inq_adlsperssn_count_day := if(not(truedid), NULL, min(if(inq_adlsperssn_count_day = NULL, -NULL, inq_adlsperssn_count_day), 999));

nf_inq_adlsperssn_count_week := if(not(truedid), NULL, min(if(inq_adlsperssn_count_week = NULL, -NULL, inq_adlsperssn_count_week), 999));

nf_inq_lnamesperssn_recency := map(
    not(truedid)             => NULL,
   (boolean) inq_lnamesperssn_count01 => 1,
   (boolean) inq_lnamesperssn_count03 => 3,
   (boolean) inq_lnamesperssn_count06 => 6,
   (boolean) Inq_LNamesPerSSN         => 12,
                                0);

nf_inq_lnamesperssn_count12 := if(not(truedid), NULL, min(if(Inq_LNamesPerSSN = NULL, -NULL, Inq_LNamesPerSSN), 999));

nf_inq_lnamesperssn_count_day := if(not(truedid), NULL, min(if(inq_lnamesperssn_count_day = NULL, -NULL, inq_lnamesperssn_count_day), 999));

nf_inq_lnamesperssn_count_week := if(not(truedid), NULL, min(if(inq_lnamesperssn_count_week = NULL, -NULL, inq_lnamesperssn_count_week), 999));

nf_inq_addrsperssn_recency := map(
    not(truedid)            => NULL,
    (boolean)inq_addrsperssn_count01 => 1,
    (boolean)inq_addrsperssn_count03 => 3,
    (boolean)inq_addrsperssn_count06 => 6,
    (boolean)Inq_AddrsPerSSN         => 12,
                               0);

nf_inq_addrsperssn_count12 := if(not(truedid), NULL, min(if(Inq_AddrsPerSSN = NULL, -NULL, Inq_AddrsPerSSN), 999));

nf_inq_addrsperssn_count_day := if(not(truedid), NULL, min(if(inq_addrsperssn_count_day = NULL, -NULL, inq_addrsperssn_count_day), 999));

nf_inq_addrsperssn_count_week := if(not(truedid), NULL, min(if(inq_addrsperssn_count_week = NULL, -NULL, inq_addrsperssn_count_week), 999));

nf_inq_dobsperssn_recency := map(
    not(truedid)           => NULL,
    (boolean)inq_dobsperssn_count01 => 1,
    (boolean)inq_dobsperssn_count03 => 3,
    (boolean)inq_dobsperssn_count06 => 6,
    (boolean)Inq_DOBsPerSSN         => 12,
                              0);

nf_inq_dobsperssn_count12 := if(not(truedid), NULL, min(if(Inq_DOBsPerSSN = NULL, -NULL, Inq_DOBsPerSSN), 999));

nf_inq_dobsperssn_count_day := if(not(truedid), NULL, min(if(inq_dobsperssn_count_day = NULL, -NULL, inq_dobsperssn_count_day), 999));

nf_inq_dobsperssn_count_week := if(not(truedid), NULL, min(if(inq_dobsperssn_count_week = NULL, -NULL, inq_dobsperssn_count_week), 999));

nf_inq_peraddr_recency := map(
    not(truedid)        => NULL,
    (boolean)inq_peraddr_count01 => 1,
    (boolean)inq_peraddr_count03 => 3,
    (boolean)inq_peraddr_count06 => 6,
    (boolean)Inq_PerAddr         => 12,
                           0);

nf_inq_peraddr_count12 := if(not(truedid), NULL, min(if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr), 999));

nf_inq_peraddr_count_day := if(not(truedid), NULL, min(if(inq_peraddr_count_day = NULL, -NULL, inq_peraddr_count_day), 999));

nf_inq_peraddr_count_week := if(not(truedid), NULL, min(if(inq_peraddr_count_week = NULL, -NULL, inq_peraddr_count_week), 999));

nf_inq_adlsperaddr_recency := map(
    not(truedid)            => NULL,
   (boolean) inq_adlsperaddr_count01 => 1,
    (boolean)inq_adlsperaddr_count03 => 3,
   (boolean) inq_adlsperaddr_count06 => 6,
    (boolean)Inq_ADLsPerAddr         => 12,
                               0);

nf_inq_adlsperaddr_count12 := if(not(truedid), NULL, min(if(Inq_ADLsPerAddr = NULL, -NULL, Inq_ADLsPerAddr), 999));

nf_inq_adlsperaddr_count_day := if(not(truedid), NULL, min(if(inq_adlsperaddr_count_day = NULL, -NULL, inq_adlsperaddr_count_day), 999));

nf_inq_adlsperaddr_count_week := if(not(truedid), NULL, min(if(inq_adlsperaddr_count_week = NULL, -NULL, inq_adlsperaddr_count_week), 999));

nf_inq_lnamesperaddr_recency := map(
    not(truedid)              => NULL,
   (boolean) inq_lnamesperaddr_count01 => 1,
   (boolean)inq_lnamesperaddr_count03 => 3,
    (boolean)inq_lnamesperaddr_count06 => 6,
    (boolean)Inq_LNamesPerAddr         => 12,
                                 0);

nf_inq_lnamesperaddr_count12 := if(not(truedid), NULL, min(if(Inq_LNamesPerAddr = NULL, -NULL, Inq_LNamesPerAddr), 999));

nf_inq_lnamesperaddr_count_day := if(not(truedid), NULL, min(if(inq_lnamesperaddr_count_day = NULL, -NULL, inq_lnamesperaddr_count_day), 999));

nf_inq_lnamesperaddr_count_week := if(not(truedid), NULL, min(if(inq_lnamesperaddr_count_week = NULL, -NULL, inq_lnamesperaddr_count_week), 999));

nf_inq_ssnsperaddr_recency := map(
    not(truedid)            => NULL,
    (boolean)inq_ssnsperaddr_count01 => 1,
    (boolean)inq_ssnsperaddr_count03 => 3,
    (boolean)inq_ssnsperaddr_count06 => 6,
    (boolean)Inq_SSNsPerAddr         => 12,
                               0);

nf_inq_ssnsperaddr_count12 := if(not(truedid), NULL, min(if(Inq_SSNsPerAddr = NULL, -NULL, Inq_SSNsPerAddr), 999));

nf_inq_ssnsperaddr_count_day := if(not(truedid), NULL, min(if(inq_ssnsperaddr_count_day = NULL, -NULL, inq_ssnsperaddr_count_day), 999));

nf_inq_ssnsperaddr_count_week := if(not(truedid), NULL, min(if(inq_ssnsperaddr_count_week = NULL, -NULL, inq_ssnsperaddr_count_week), 999));

nf_inq_emailsperadl_count12 := if(not(truedid), NULL, min(if(inq_email_per_adl = NULL, -NULL, inq_email_per_adl), 999));

nf_inq_adlsperemail_count12 := if(not(truedid), NULL, min(if(inq_adls_per_email = NULL, -NULL, inq_adls_per_email), 999));

nf_inq_adlsperemail_count_week := if(not(truedid), NULL, min(if(inq_adlsperemail_count_week = NULL, -NULL, inq_adlsperemail_count_week), 999));

nf_inq_perbestssn_count12 := if(not(truedid), NULL, min(if(inq_perbestssn = NULL, -NULL, inq_perbestssn), 999));

nf_inq_adlsperbestssn_count12 := if(not(truedid), NULL, min(if(inq_adlsperbestssn = NULL, -NULL, inq_adlsperbestssn), 999));

nf_inq_lnamesperbestssn_count12 := if(not(truedid), NULL, min(if(inq_lnamesperbestssn = NULL, -NULL, inq_lnamesperbestssn), 999));

nf_inq_addrsperbestssn_count12 := if(not(truedid), NULL, min(if(inq_addrsperbestssn = NULL, -NULL, inq_addrsperbestssn), 999));

nf_inq_dobsperbestssn_count12 := if(not(truedid), NULL, min(if(inq_dobsperbestssn = NULL, -NULL, inq_dobsperbestssn), 999));

nf_inq_percurraddr_count12 := if(not(truedid), NULL, min(if(inq_percurraddr = NULL, -NULL, inq_percurraddr), 999));

nf_inq_adlspercurraddr_count12 := if(not(truedid), NULL, min(if(inq_adlspercurraddr = NULL, -NULL, inq_adlspercurraddr), 999));

nf_inq_lnamespercurraddr_count12 := if(not(truedid), NULL, min(if(inq_lnamespercurraddr = NULL, -NULL, inq_lnamespercurraddr), 999));

nf_inq_ssnspercurraddr_count12 := if(not(truedid), NULL, min(if(inq_ssnspercurraddr = NULL, -NULL, inq_ssnspercurraddr), 999));

nf_inq_perbestphone_count12 := if(not(truedid), NULL, min(if(inq_perbestphone = NULL, -NULL, inq_perbestphone), 999));

nf_inq_adlsperbestphone_count12 := if(not(truedid), NULL, min(if(inq_adlsperbestphone = NULL, -NULL, inq_adlsperbestphone), 999));

nf_inq_curraddr_ver_count := if(not(truedid), NULL, min(if(inq_curraddr_ver_count = NULL, -NULL, inq_curraddr_ver_count), 999));

nf_inq_bestfname_ver_count := if(not(truedid), NULL, min(if(inq_bestfname_ver_count = NULL, -NULL, inq_bestfname_ver_count), 999));

nf_inq_bestlname_ver_count := if(not(truedid), NULL, min(if(inq_bestlname_ver_count = NULL, -NULL, inq_bestlname_ver_count), 999));

nf_inq_bestssn_ver_count := if(not(truedid), NULL, min(if(inq_bestssn_ver_count = NULL, -NULL, inq_bestssn_ver_count), 999));

nf_inq_bestdob_ver_count := if(not(truedid), NULL, min(if(inq_bestdob_ver_count = NULL, -NULL, inq_bestdob_ver_count), 999));
//nf_inq_bestssn_ver_count := if(not(truedid) or inq_bestssn_ver_count = 255, NULL, min(if(inq_bestssn_ver_count = NULL, -NULL, inq_bestssn_ver_count), 999)));

nf_inq_bestphone_ver_count := if(not(truedid), NULL, min(if(inq_bestphone_ver_count = NULL, -NULL, inq_bestphone_ver_count), 999));

nf_invbest_inq_perssn_diff := map(
    not(truedid) or (integer)ssnlength = 0 => NULL,
    (integer)input_ssn_isbestmatch = 1     => -1,
                                     inq_perssn - inq_perbestssn);

nf_invbest_inq_adlsperssn_diff := map(
    not(truedid) or (integer)ssnlength = 0 => NULL,
    (integer)input_ssn_isbestmatch = 1     => -1,
                                     inq_adlsperssn - inq_adlsperbestssn);

nf_invbest_inq_lnamesperssn_diff := map(
    not(truedid) or (integer)ssnlength = 0 => NULL,
    (integer)input_ssn_isbestmatch = 1     => -1,
                                     inq_lnamesperssn - inq_lnamesperbestssn);

nf_invbest_inq_addrsperssn_diff := map(
    not(truedid) or (integer)ssnlength = 0 => NULL,
    (integer)input_ssn_isbestmatch = 1     => -1,
                                     inq_addrsperssn - inq_addrsperbestssn);

nf_invbest_inq_dobsperssn_diff := map(
    not(truedid) or (integer)ssnlength = 0 => NULL,
    (integer)input_ssn_isbestmatch = 1     => -1,
                                     inq_dobsperssn - inq_dobsperbestssn);

nf_invbest_inq_peraddr_diff := map(
    not(truedid) or (integer)addrpop = 0 => NULL,
    (integer)add_input_isbestmatch = 1   => -1,
                                   inq_peraddr - inq_percurraddr);

nf_invbest_inq_adlsperaddr_diff := map(
    not(truedid) or (integer)addrpop = 0 => NULL,
    (integer)add_input_isbestmatch = 1   => -1,
                                   inq_adlsperaddr - inq_adlspercurraddr);

nf_invbest_inq_lastperaddr_diff := map(
    not(truedid) or (integer)addrpop = 0 => NULL,
    (integer)add_input_isbestmatch = 1   => -1,
                                   inq_lnamesperaddr - inq_lnamespercurraddr);

nf_invbest_inq_ssnsperaddr_diff := map(
    not(truedid) or (integer)addrpop = 0 => NULL,
    (integer)add_input_isbestmatch = 1   => -1,
                                   inq_ssnsperaddr - inq_ssnspercurraddr);

modinq_size_1_c395 := if(nf_inq_highriskcredit_count < 11.384373, 16.500001, 8.000000);

modinq_size_1_c396 := if(nf_inq_mortgage_count < 2.398388, 9.000000, 8.000000);

modinq_size_1_c394 := if(rv_i60_inq_auto_count12 < 0.747624, modinq_size_1_c395, modinq_size_1_c396);

modinq_size_1_c398 := if(nf_inq_lnamesperaddr_count12 < 0.544757, 11.748880, 9.000000);

modinq_size_1_c397 := if(rv_i61_inq_collection_count12 < 1.012717, modinq_size_1_c398, 7.000000);

modinq_size_1_c393 := if(nf_inq_lnamesperssn_count12 < 0.015961, modinq_size_1_c394, modinq_size_1_c397);

modinq_size_1_c392 := if(rv_i60_inq_retpymt_count12 < 0.100705, modinq_size_1_c393, 5.000000);

modinq_size_1_c391 := if(nf_inq_peradl_count_day < 0.268420, modinq_size_1_c392, 4.000000);

modinq_size_1_c403 := if(nf_inq_retail_count < 0.862613, 13.334385, 11.296252);

modinq_size_1_c404 := if(rv_i62_inq_phonesperadl_recency < 9.849076, 13.143309, 8.000000);

modinq_size_1_c402 := if(nf_inq_lnamesperssn_count12 < 0.842318, modinq_size_1_c403, modinq_size_1_c404);

modinq_size_1_c401 := if(nf_inq_perbestphone_count12 < 1.568690, modinq_size_1_c402, 6.000000);

modinq_size_1_c406 := if(nf_inq_bestssn_ver_count < 17.243109, 7.000000, 7.000000);

modinq_size_1_c405 := if(rv_i62_inq_fnamesperadl_count12 < 0.413505, 6.000000, modinq_size_1_c406);

modinq_size_1_c400 := if(nf_inq_highriskcredit_count < 3.434017, modinq_size_1_c401, modinq_size_1_c405);

modinq_size_1_c410 := if(nf_inq_lnames_per_ssn < 0.980958, 8.000000, 9.000000);

modinq_size_1_c409 := if(nf_inq_phonesperadl_count_week < 0.309025, modinq_size_1_c410, 7.000000);

modinq_size_1_c412 := if(nf_inq_bestdob_ver_count < 13.669534, 9.000000, 8.000000);

modinq_size_1_c413 := if(nf_inq_addr_ver_count < 13.983218, 8.000000, 8.000000);

modinq_size_1_c411 := if(nf_inq_per_addr < 7.440339, modinq_size_1_c412, modinq_size_1_c413);

modinq_size_1_c408 := if(rv_i62_inq_dobsperadl_recency < 1.385134, modinq_size_1_c409, modinq_size_1_c411);

modinq_size_1_c407 := if(rv_i62_inq_addrsperadl_recency < 9.095418, modinq_size_1_c408, 5.000000);

modinq_size_1_c399 := if(nf_inquiry_addr_vel_risk_indexv2 < 1.378549, modinq_size_1_c400, modinq_size_1_c407);

modinq_size_1_c390 := if(nf_inq_ssnsperaddr_recency < 0.354682, modinq_size_1_c391, modinq_size_1_c399);

modinq_size_1_c419 := if(nf_inq_highriskcredit_count24 < 0.834543, 9.851656, 8.000000);

modinq_size_1_c420 := if(rv_i62_inq_dobs_per_adl < 1.861805, 12.427187, 9.000000);

modinq_size_1_c418 := if(rv_i62_inq_dobs_per_adl < 0.816829, modinq_size_1_c419, modinq_size_1_c420);

modinq_size_1_c422 := if(nf_inq_banking_count24 < 0.367180, 9.000000, 8.000000);

modinq_size_1_c423 := if(nf_inq_retail_count < 0.186337, 10.706640, 9.000000);

modinq_size_1_c421 := if(nf_inq_other_count < 1.379284, modinq_size_1_c422, modinq_size_1_c423);

modinq_size_1_c417 := if(rv_i60_inq_comm_recency < 19.470104, modinq_size_1_c418, modinq_size_1_c421);

modinq_size_1_c426 := if(nf_inq_bestfname_ver_count < 19.550175, 9.000000, 9.207392);

modinq_size_1_c425 := if(nf_inq_lnamesperssn_count12 < 1.882319, modinq_size_1_c426, 7.000000);

modinq_size_1_c427 := if(nf_inq_retailpayments_count24 < 0.386051, 7.000000, 7.000000);

modinq_size_1_c424 := if(rv_i62_inq_fnamesperadl_count12 < 1.920411, modinq_size_1_c425, modinq_size_1_c427);

modinq_size_1_c416 := if(nf_inq_other_count24 < 3.260738, modinq_size_1_c417, modinq_size_1_c424);

modinq_size_1_c415 := if(nf_inq_perbestphone_count12 < 2.046336, modinq_size_1_c416, 4.000000);

modinq_size_1_c430 := if(nf_inq_bestssn_ver_count < 5.088611, 6.000000, 6.000000);

modinq_size_1_c429 := if(nf_inq_curraddr_ver_count < 10.515822, modinq_size_1_c430, 5.000000);

modinq_size_1_c428 := if(nf_inq_banking_count24 < 0.027856, modinq_size_1_c429, 4.000000);

modinq_size_1_c414 := if(nf_inq_adls_per_sfd_addr < 3.612895, modinq_size_1_c415, modinq_size_1_c428);

modinq_size_1_c389 := if(rv_i62_inq_ssnsperadl_recency < 6.240614, modinq_size_1_c390, modinq_size_1_c414);

modinq_size_1_c435 := if(nf_inquiry_addr_vel_risk_index < 1.743515, 6.000000, 6.000000);

modinq_size_1_c438 := if(rv_i62_inq_fnamesperadl_recency < 9.044252, 11.296252, 9.000000);

modinq_size_1_c437 := if(nf_invbest_inq_lastperaddr_diff < -1.112174, 7.000000, modinq_size_1_c438);

modinq_size_1_c436 := if(rv_i62_inq_addrs_per_adl < 5.253302, modinq_size_1_c437, 6.000000);

modinq_size_1_c434 := if(nf_inq_adlspercurraddr_count12 < 0.134969, modinq_size_1_c435, modinq_size_1_c436);

modinq_size_1_c433 := if(rv_i60_inq_banking_count12 < 1.335132, modinq_size_1_c434, 4.000000);

modinq_size_1_c441 := if(nf_inq_retailpayments_count < 0.329715, 6.000000, 6.000000);

modinq_size_1_c440 := if(rv_i60_inq_count12 < 5.673824, 5.000000, modinq_size_1_c441);

modinq_size_1_c439 := if(nf_inq_peradl_count_week < 1.768152, 4.000000, modinq_size_1_c440);

modinq_size_1_c432 := if(nf_inq_quizprovider_count24 < 0.620861, modinq_size_1_c433, modinq_size_1_c439);

modinq_size_1_c431 := if(nf_inq_peradl_count_day < 2.934930, modinq_size_1_c432, 2.000000);

modinq_size_1 := if(nf_inq_auto_count_week < 0.036106, modinq_size_1_c389, modinq_size_1_c431);

modinq_size_2_c449 := if(nf_inq_bestdob_ver_count < 212.800458, 17.819846, 13.817534);

modinq_size_2_c448 := if(nf_inq_per_addr < 13.441431, modinq_size_2_c449, 7.000000);

modinq_size_2_c451 := if(nf_inq_count < 5.768743, 11.023665, 10.327020);

modinq_size_2_c450 := if(nf_inq_auto_count < 17.714762, modinq_size_2_c451, 7.000000);

modinq_size_2_c447 := if(nf_inq_adlspercurraddr_count12 < 2.429454, modinq_size_2_c448, modinq_size_2_c450);

modinq_size_2_c452 := if(nf_inq_adls_per_sfd_addr < 0.375752, 6.000000, 6.000000);

modinq_size_2_c446 := if(nf_inq_highriskcredit_count < 43.730787, modinq_size_2_c447, modinq_size_2_c452);

modinq_size_2_c453 := if(nf_inq_retailpayments_count24 < 0.927073, 5.000000, 5.000000);

modinq_size_2_c445 := if(nf_inq_lnames_per_sfd_addr < 5.622329, modinq_size_2_c446, modinq_size_2_c453);

modinq_size_2_c444 := if(nf_inq_mortgage_count24 < 2.794562, modinq_size_2_c445, 3.000000);

modinq_size_2_c443 := if(nf_inq_perssn_count_day < 3.302048, modinq_size_2_c444, 2.000000);

//modinq_size_2 := if(nf_inq_adlsperbestphone_count12 < -9501121555.336464, 1.000000, modinq_size_2_c443);
modinq_size_2 := if(nf_inq_adlsperbestphone_count12 < -999999998, 1.000000, modinq_size_2_c443);

modinq_size_3_c455 := if(nf_inq_ssns_per_sfd_addr < 0.902844, 2.000000, 2.000000);
// modinq_size_3_c455 := if(nf_inq_ssns_per_sfd_addr < 1, 2.000000, 2.000000);

modinq_size_3_c462 := if(nf_inq_per_ssn < 6.876979, 16.712607, 9.000000);

modinq_size_3_c463 := if(nf_invbest_inq_peraddr_diff < 1.392787, 8.000000, 8.000000);

modinq_size_3_c461 := if(rv_i60_inq_comm_count12 < 0.159957, modinq_size_3_c462, modinq_size_3_c463);

modinq_size_3_c465 := if(nf_inq_fname_ver_count < 19.070670, 9.000000, 9.000000);

modinq_size_3_c466 := if(rv_i62_inq_addrsperadl_count12 < 0.516476, 13.334385, 11.748880);

modinq_size_3_c464 := if(nf_inq_lnames_per_sfd_addr < -0.088449, modinq_size_3_c465, modinq_size_3_c466);

modinq_size_3_c460 := if(rv_i60_inq_mortgage_recency < 22.432956, modinq_size_3_c461, modinq_size_3_c464);

modinq_size_3_c459 := if(nf_inquiry_addr_vel_risk_indexv2 < 1.414008, modinq_size_3_c460, 5.000000);

modinq_size_3_c469 := if(nf_inq_lname_ver_count < 17.849091, 7.000000, 7.000000);

modinq_size_3_c468 := if(rv_i62_inq_ssns_per_adl < 0.150506, 6.000000, modinq_size_3_c469);

modinq_size_3_c467 := if(nf_inq_adlsperaddr_recency < 6.618553, modinq_size_3_c468, 5.000000);

modinq_size_3_c458 := if(nf_inq_addrsperssn_count_week < 0.592109, modinq_size_3_c459, modinq_size_3_c467);

modinq_size_3_c470 := if(rv_i61_inq_collection_recency < 69.505076, 4.000000, 4.000000);

modinq_size_3_c457 := if(nf_inq_highriskcredit_count < 5.889783, modinq_size_3_c458, modinq_size_3_c470);

modinq_size_3_c476 := if(nf_inq_lnamesperadl_count_week < 0.533782, 15.815723, 9.207392);

modinq_size_3_c475 := if(nf_inq_peraddr_count_week < 3.070132, modinq_size_3_c476, 7.000000);

modinq_size_3_c474 := if(nf_inq_adlspercurraddr_count12 < 3.501348, modinq_size_3_c475, 6.000000);

modinq_size_3_c473 := if(nf_inq_prepaidcards_count < 1.177331, modinq_size_3_c474, 5.000000);

modinq_size_3_c480 := if(nf_inq_per_addr < 5.282900, 8.000000, 8.000000);

modinq_size_3_c479 := if(nf_inq_ssnsperaddr_recency < 5.854706, modinq_size_3_c480, 7.000000);

modinq_size_3_c478 := if(nf_inq_ssns_per_sfd_addr < 0.102070, 6.000000, modinq_size_3_c479);

modinq_size_3_c477 := if(nf_inq_banking_count < 0.248377, modinq_size_3_c478, 5.000000);

modinq_size_3_c472 := if(nf_inq_ssn_ver_count < 129.341582, modinq_size_3_c473, modinq_size_3_c477);

modinq_size_3_c471 := if(rv_i60_inq_comm_count12 < 2.037702, modinq_size_3_c472, 3.000000);

modinq_size_3_c456 := if(nf_inq_percurraddr_count12 < 1.238689, modinq_size_3_c457, modinq_size_3_c471);

// modinq_size_3 := if(rv_i62_inq_dobsperadl_recency < -5904757130.508592, modinq_size_3_c455, modinq_size_3_c456);
modinq_size_3 := if(rv_i62_inq_dobsperadl_recency < -999999998, modinq_size_3_c455, modinq_size_3_c456);

modinq_size_4_c488 := if(nf_inq_lnamesperadl_count_week < 0.569403, 15.841872, 9.000000);

modinq_size_4_c489 := if(nf_inq_lnames_per_addr < 1.268473, 11.296252, 9.207392);

modinq_size_4_c487 := if(nf_inq_adls_per_sfd_addr < 0.519070, modinq_size_4_c488, modinq_size_4_c489);

modinq_size_4_c486 := if(nf_inquiry_ssn_vel_risk_index < 0.970197, modinq_size_4_c487, 6.000000);

modinq_size_4_c492 := if(nf_inq_bestdob_ver_count < 2.434748, 11.748880, 8.000000);

modinq_size_4_c493 := if(nf_inq_adls_per_sfd_addr < 0.755809, 9.000000, 11.535537);

modinq_size_4_c491 := if(nf_inq_count < 4.255163, modinq_size_4_c492, modinq_size_4_c493);

modinq_size_4_c490 := if(rv_i60_inq_mortgage_count12 < 0.953602, modinq_size_4_c491, 6.000000);

modinq_size_4_c485 := if(nf_inq_ssnsperaddr_recency < 1.937186, modinq_size_4_c486, modinq_size_4_c490);

modinq_size_4_c497 := if(nf_inq_adls_per_apt_addr < -0.380470, 8.000000, 8.000000);

modinq_size_4_c496 := if(nf_inq_ssnsperaddr_count12 < 0.051362, modinq_size_4_c497, 7.000000);

modinq_size_4_c499 := if(nf_inq_addrs_per_ssn < 0.334407, 9.207392, 8.000000);

modinq_size_4_c498 := if(rv_i62_inq_addrs_per_adl < 0.057035, modinq_size_4_c499, 7.000000);

modinq_size_4_c495 := if(nf_inq_count < 2.595499, modinq_size_4_c496, modinq_size_4_c498);

modinq_size_4_c502 := if(rv_i62_inq_ssns_per_adl < 0.819812, 8.000000, 8.000000);

modinq_size_4_c501 := if(nf_inq_bestlname_ver_count < 17.210585, 7.000000, modinq_size_4_c502);

modinq_size_4_c500 := if(nf_inq_lnamesperssn_recency < 9.157611, modinq_size_4_c501, 6.000000);

modinq_size_4_c494 := if(nf_inq_lname_ver_count < 13.490751, modinq_size_4_c495, modinq_size_4_c500);

modinq_size_4_c484 := if(rv_i60_inq_retpymt_recency < 76.610333, modinq_size_4_c485, modinq_size_4_c494);

modinq_size_4_c507 := if(nf_inq_lnamespercurraddr_count12 < 0.877074, 9.000000, 8.000000);

modinq_size_4_c508 := if(rv_i60_inq_banking_recency < 47.416324, 12.427187, 8.000000);

modinq_size_4_c506 := if(nf_inq_bestphone_ver_count < 115.794510, modinq_size_4_c507, modinq_size_4_c508);

modinq_size_4_c505 := if(nf_inq_other_count < 1.806700, modinq_size_4_c506, 6.000000);

modinq_size_4_c511 := if(nf_inq_per_sfd_addr < 1.243600, 9.851656, 8.000000);

modinq_size_4_c510 := if(nf_inq_per_apt_addr < -0.422072, modinq_size_4_c511, 7.000000);

modinq_size_4_c509 := if(nf_inq_lnamesperaddr_count12 < 1.265550, modinq_size_4_c510, 6.000000);

modinq_size_4_c504 := if(nf_inq_bestlname_ver_count < 122.288251, modinq_size_4_c505, modinq_size_4_c509);

modinq_size_4_c515 := if(nf_inq_bestlname_ver_count < 214.509471, 8.000000, 9.000000);

modinq_size_4_c516 := if(rv_i62_inq_addrsperadl_recency < 1.587081, 8.000000, 8.000000);

modinq_size_4_c514 := if(nf_inq_adls_per_sfd_addr < 0.736690, modinq_size_4_c515, modinq_size_4_c516);

modinq_size_4_c513 := if(nf_inq_lnames_per_apt_addr < -0.334864, modinq_size_4_c514, 6.000000);

modinq_size_4_c512 := if(nf_inq_ssns_per_addr < 1.245375, modinq_size_4_c513, 5.000000);

modinq_size_4_c503 := if(nf_inq_per_ssn < 0.423107, modinq_size_4_c504, modinq_size_4_c512);

modinq_size_4_c483 := if(nf_inq_bestdob_ver_count < 212.926875, modinq_size_4_c484, modinq_size_4_c503);

modinq_size_4_c522 := if(nf_inq_quizprovider_count24 < 0.887056, 11.748880, 8.000000);

modinq_size_4_c521 := if(rv_i60_inq_comm_recency < 21.440985, modinq_size_4_c522, 7.000000);

modinq_size_4_c524 := if(nf_inq_ssn_ver_count < 9.797359, 8.000000, 8.000000);

modinq_size_4_c523 := if(nf_inq_per_addr < 5.852794, modinq_size_4_c524, 7.000000);

modinq_size_4_c520 := if(nf_inq_lnames_per_ssn < 0.086758, modinq_size_4_c521, modinq_size_4_c523);

modinq_size_4_c519 := if(nf_inq_auto_count_week < 1.351963, modinq_size_4_c520, 5.000000);

modinq_size_4_c527 := if(nf_inq_count24 < 0.116315, 7.000000, 7.000000);

modinq_size_4_c526 := if(nf_inq_count24 < 2.480813, modinq_size_4_c527, 6.000000);

modinq_size_4_c525 := if(nf_inq_ssns_per_addr < 1.947617, modinq_size_4_c526, 5.000000);

modinq_size_4_c518 := if(nf_inq_ssns_per_apt_addr < -0.748206, modinq_size_4_c519, modinq_size_4_c525);

modinq_size_4_c517 := if(nf_inq_count < 0.082150, 3.000000, modinq_size_4_c518);

modinq_size_4_c482 := if(nf_inq_percurraddr_count12 < 3.790645, modinq_size_4_c483, modinq_size_4_c517);

modinq_size_4_c534 := if(nf_inq_per_addr < 9.258291, 14.854267, 9.000000);

modinq_size_4_c535 := if(nf_inq_adlsperssn_recency < 1.536853, 8.000000, 9.000000);

modinq_size_4_c533 := if(nf_inq_other_count24 < 5.869017, modinq_size_4_c534, modinq_size_4_c535);

modinq_size_4_c536 := if(rv_i62_inq_addrs_per_adl < 2.525624, 7.000000, 7.000000);

modinq_size_4_c532 := if(nf_inq_lnamesperaddr_count_week < 0.371798, modinq_size_4_c533, modinq_size_4_c536);

modinq_size_4_c539 := if(rv_i60_inq_comm_recency < 1.081368, 8.000000, 8.000000);

modinq_size_4_c538 := if(nf_inquiry_addr_vel_risk_index < 2.308917, modinq_size_4_c539, 7.000000);

modinq_size_4_c537 := if(nf_inq_phonesperadl_count_week < 0.740486, modinq_size_4_c538, 6.000000);

modinq_size_4_c531 := if(rv_i62_inq_ssnsperadl_count12 < 1.615595, modinq_size_4_c532, modinq_size_4_c537);

modinq_size_4_c542 := if(rv_i60_inq_comm_count12 < 0.315049, 7.000000, 7.000000);

modinq_size_4_c543 := if(rv_i60_inq_retpymt_recency < 42.034732, 7.000000, 7.000000);

modinq_size_4_c541 := if(nf_inquiry_ssn_vel_risk_index < 4.962622, modinq_size_4_c542, modinq_size_4_c543);

modinq_size_4_c544 := if(nf_inq_bestlname_ver_count < 34.081741, 6.000000, 6.000000);

modinq_size_4_c540 := if(rv_i61_inq_collection_recency < 39.394042, modinq_size_4_c541, modinq_size_4_c544);

modinq_size_4_c530 := if(nf_inq_retailpayments_count < 0.607507, modinq_size_4_c531, modinq_size_4_c540);

modinq_size_4_c549 := if(nf_inq_banking_count_week < 0.366791, 9.851656, 8.000000);

modinq_size_4_c548 := if(nf_inq_addr_recency_risk_index < 4.193954, modinq_size_4_c549, 7.000000);

modinq_size_4_c550 := if(nf_inq_banking_count24 < 0.272181, 7.000000, 7.000000);

modinq_size_4_c547 := if(nf_inq_perssn_count_week < 4.996188, modinq_size_4_c548, modinq_size_4_c550);

modinq_size_4_c551 := if(rv_i62_inq_phonesperadl_count12 < 1.884879, 6.000000, 6.000000);

modinq_size_4_c546 := if(nf_inq_lnamesperaddr_count_day < 0.780052, modinq_size_4_c547, modinq_size_4_c551);

modinq_size_4_c545 := if(rv_i62_inq_addrs_per_adl < 3.533236, modinq_size_4_c546, 4.000000);

modinq_size_4_c529 := if(nf_inq_perssn_count_week < 1.693853, modinq_size_4_c530, modinq_size_4_c545);

modinq_size_4_c528 := if(nf_inq_adls_per_ssn < 1.804237, modinq_size_4_c529, 2.000000);

modinq_size_4 := if(nf_inq_dobs_per_ssn < 0.340635, modinq_size_4_c482, modinq_size_4_c528);

modinq_size_5_c559 := if(nf_inq_dobsperssn_count_week < 0.892620, 17.690121, 9.000000);

modinq_size_5_c560 := if(nf_inq_auto_count_day < 0.463320, 8.000000, 8.000000);

modinq_size_5_c558 := if(nf_inq_peraddr_count_week < 1.433601, modinq_size_5_c559, modinq_size_5_c560);

modinq_size_5_c562 := if(nf_inq_bestphone_ver_count < 165.406285, 8.000000, 8.000000);

modinq_size_5_c563 := if(nf_inq_communications_count < 1.808404, 8.000000, 8.000000);

modinq_size_5_c561 := if(nf_inq_dob_ver_count < 8.782405, modinq_size_5_c562, modinq_size_5_c563);

modinq_size_5_c557 := if(nf_inq_other_count < 9.295329, modinq_size_5_c558, modinq_size_5_c561);

modinq_size_5_c556 := if(nf_inq_lnamesperssn_count_day < 0.572499, modinq_size_5_c557, 5.000000);

modinq_size_5_c564 := if(nf_inq_lnames_per_addr < 0.499438, 5.000000, 5.000000);

modinq_size_5_c555 := if(nf_inq_utilities_count24 < 0.418517, modinq_size_5_c556, modinq_size_5_c564);

modinq_size_5_c569 := if(nf_inq_adlsperaddr_count_week < 0.208522, 13.887806, 8.000000);

modinq_size_5_c568 := if(rv_i60_inq_util_count12 < 0.119532, modinq_size_5_c569, 7.000000);

modinq_size_5_c570 := if(nf_inq_addr_ver_count < 2.863125, 7.000000, 7.000000);

modinq_size_5_c567 := if(nf_inq_fname_ver_count < 35.006137, modinq_size_5_c568, modinq_size_5_c570);

modinq_size_5_c566 := if(nf_inq_auto_count24 < 4.440694, modinq_size_5_c567, 5.000000);

modinq_size_5_c565 := if(nf_inq_per_apt_addr < 0.729113, modinq_size_5_c566, 4.000000);

modinq_size_5_c554 := if(rv_i60_inq_other_recency < 27.925309, modinq_size_5_c555, modinq_size_5_c565);

modinq_size_5_c575 := if(nf_inq_count < 2.468200, 7.000000, 7.000000);

modinq_size_5_c574 := if(nf_inq_per_sfd_addr < 2.951113, modinq_size_5_c575, 6.000000);

modinq_size_5_c578 := if(nf_inq_prepaidcards_count < 0.441124, 10.327020, 8.000000);

modinq_size_5_c577 := if(nf_inq_per_sfd_addr < 30.539049, modinq_size_5_c578, 7.000000);

modinq_size_5_c576 := if(rv_i60_inq_other_recency < 94.524169, modinq_size_5_c577, 6.000000);

modinq_size_5_c573 := if(nf_inq_lnamesperbestssn_count12 < 0.715146, modinq_size_5_c574, modinq_size_5_c576);

modinq_size_5_c579 := if(rv_i62_inq_lnamesperadl_count12 < 0.439700, 5.000000, 5.000000);

modinq_size_5_c572 := if(nf_inq_perbestphone_count12 < 0.319202, modinq_size_5_c573, modinq_size_5_c579);

modinq_size_5_c580 := if(nf_inq_count24 < 10.163042, 4.000000, 4.000000);

modinq_size_5_c571 := if(nf_inq_addrsperssn_count_week < 0.940246, modinq_size_5_c572, modinq_size_5_c580);

modinq_size_5_c553 := if(nf_inq_peraddr_count12 < 6.639430, modinq_size_5_c554, modinq_size_5_c571);

//modinq_size_5 := if(nf_inq_per_sfd_addr < -4390556488.888959, 1.000000, modinq_size_5_c553);
modinq_size_5 := if(nf_inq_per_sfd_addr < -999999998, 1.000000, modinq_size_5_c553);

modinq_size_6_c588 := if(nf_inq_quizprovider_count < 5.215464, 16.500001, 8.000000);

modinq_size_6_c589 := if(rv_i62_inq_ssns_per_adl < 0.053265, 9.851656, 9.000000);

modinq_size_6_c587 := if(rv_i62_inq_lnamesperadl_recency < 7.666068, modinq_size_6_c588, modinq_size_6_c589);

modinq_size_6_c590 := if(nf_inq_fname_ver_count < 34.834832, 7.000000, 7.000000);

modinq_size_6_c586 := if(rv_i60_inq_count12 < 3.942669, modinq_size_6_c587, modinq_size_6_c590);

modinq_size_6_c593 := if(nf_inq_lnames_per_apt_addr < -0.387432, 12.278091, 9.851656);

modinq_size_6_c592 := if(nf_invbest_inq_ssnsperaddr_diff < -1.447217, 7.000000, modinq_size_6_c593);

modinq_size_6_c595 := if(nf_invbest_inq_peraddr_diff < -1.048702, 8.000000, 12.695532);

modinq_size_6_c594 := if(rv_i62_inq_num_names_per_adl < 2.028352, modinq_size_6_c595, 7.000000);

modinq_size_6_c591 := if(nf_inq_adls_per_addr < 0.584621, modinq_size_6_c592, modinq_size_6_c594);

modinq_size_6_c585 := if(nf_inq_adls_per_ssn < 0.161482, modinq_size_6_c586, modinq_size_6_c591);

modinq_size_6_c599 := if(nf_inquiry_verification_index < 25.624225, 8.000000, 13.040438);

modinq_size_6_c600 := if(nf_invbest_inq_peraddr_diff < -1.594938, 9.000000, 11.296252);

modinq_size_6_c598 := if(rv_i60_inq_retail_recency < 59.329783, modinq_size_6_c599, modinq_size_6_c600);

modinq_size_6_c597 := if(nf_inq_fname_ver_count < 103.819599, modinq_size_6_c598, 6.000000);

modinq_size_6_c596 := if(nf_inq_collection_count24 < 1.722516, modinq_size_6_c597, 5.000000);

modinq_size_6_c584 := if(nf_inq_lnamesperaddr_recency < 10.409009, modinq_size_6_c585, modinq_size_6_c596);

//modinq_size_6_c583 := if(nf_inq_per_sfd_addr < -8871497301.203279, 3.000000, modinq_size_6_c584);
modinq_size_6_c583 := if(nf_inq_per_sfd_addr < -999999998, 3.000000, modinq_size_6_c584);

modinq_size_6_c606 := if(nf_inq_ssns_per_sfd_addr < 3.550613, 14.146509, 9.207392);

modinq_size_6_c607 := if(nf_inq_addrs_per_ssn < 1.769388, 9.000000, 9.000000);

modinq_size_6_c605 := if(nf_inq_adlsperssn_recency < 9.722196, modinq_size_6_c606, modinq_size_6_c607);

modinq_size_6_c609 := if(nf_inq_retail_count24 < 1.872864, 13.423473, 8.000000);

modinq_size_6_c610 := if(rv_i62_inq_phonesperadl_count12 < 1.301260, 8.000000, 8.000000);

modinq_size_6_c608 := if(nf_inq_lnamesperbestssn_count12 < 1.015759, modinq_size_6_c609, modinq_size_6_c610);

modinq_size_6_c604 := if(rv_i62_inq_addrsperadl_recency < 5.023211, modinq_size_6_c605, modinq_size_6_c608);

modinq_size_6_c603 := if(nf_inq_peradl_count_day < 0.813585, modinq_size_6_c604, 5.000000);

modinq_size_6_c602 := if(nf_inq_dobsperssn_count_week < 0.889818, modinq_size_6_c603, 4.000000);

modinq_size_6_c611 := if(nf_inq_count < 3.098130, 4.000000, 4.000000);

modinq_size_6_c601 := if(nf_inq_lnamesperaddr_count_day < 0.820789, modinq_size_6_c602, modinq_size_6_c611);

modinq_size_6_c582 := if(nf_inq_peraddr_count12 < 2.021616, modinq_size_6_c583, modinq_size_6_c601);

//modinq_size_6 := if(rv_i60_inq_auto_count12 < -7596273703.852360, 1.000000, modinq_size_6_c582);
modinq_size_6 := if(rv_i60_inq_auto_count12 < -999999998, 1.000000, modinq_size_6_c582);

modinq_size_7_c613 := if(nf_inq_dobs_per_ssn < 0.688121, 2.000000, 2.000000);

modinq_size_7_c620 := if(nf_inq_perbestssn_count12 < 1.209917, 17.175657, 12.116889);

modinq_size_7_c621 := if(nf_inq_addr_ver_count < 8.437193, 9.000000, 8.000000);

modinq_size_7_c619 := if(rv_i60_inq_auto_count12 < 0.745124, modinq_size_7_c620, modinq_size_7_c621);

modinq_size_7_c618 := if(nf_inq_highriskcredit_count < 3.455912, modinq_size_7_c619, 6.000000);

modinq_size_7_c617 := if(nf_inq_addrsperadl_count_week < 0.492325, modinq_size_7_c618, 5.000000);

modinq_size_7_c625 := if(nf_inq_ssnsperadl_count_week < 0.880496, 14.021342, 9.207392);

modinq_size_7_c626 := if(nf_inq_addrsperssn_count12 < 1.029569, 9.000000, 9.851656);

modinq_size_7_c624 := if(nf_inq_curraddr_ver_count < 8.292286, modinq_size_7_c625, modinq_size_7_c626);

modinq_size_7_c628 := if(nf_inq_collection_count < 8.636518, 11.941420, 9.000000);

modinq_size_7_c629 := if(rv_i60_inq_auto_recency < 9.028947, 10.327020, 8.000000);

modinq_size_7_c627 := if(nf_inq_addrsperbestssn_count12 < 1.487388, modinq_size_7_c628, modinq_size_7_c629);

modinq_size_7_c623 := if(rv_i62_inq_phonesperadl_recency < 4.997278, modinq_size_7_c624, modinq_size_7_c627);

modinq_size_7_c632 := if(rv_i60_inq_hiriskcred_recency < 12.735741, 13.040438, 8.000000);

modinq_size_7_c633 := if(nf_inq_perbestssn_count12 < 10.986946, 8.000000, 8.000000);

modinq_size_7_c631 := if(nf_inq_ssnspercurraddr_count12 < 2.876086, modinq_size_7_c632, modinq_size_7_c633);

modinq_size_7_c635 := if(nf_inq_per_apt_addr < 1.011611, 8.000000, 8.000000);

modinq_size_7_c634 := if(nf_inq_retail_count < 0.619572, modinq_size_7_c635, 7.000000);

modinq_size_7_c630 := if(nf_inq_ssns_per_addr < 2.600900, modinq_size_7_c631, modinq_size_7_c634);

modinq_size_7_c622 := if(rv_i62_inq_phonesperadl_recency < 9.495612, modinq_size_7_c623, modinq_size_7_c630);

modinq_size_7_c616 := if(rv_i62_inq_dobs_per_adl < 0.978460, modinq_size_7_c617, modinq_size_7_c622);

modinq_size_7_c615 := if(rv_i60_inq_other_count12 < 6.277103, modinq_size_7_c616, 3.000000);

modinq_size_7_c636 := if(nf_inq_communications_count < 0.530434, 3.000000, 3.000000);

modinq_size_7_c614 := if(nf_inq_lnamesperssn_count_day < 0.010270, modinq_size_7_c615, modinq_size_7_c636);

modinq_size_7 := if(rv_i60_inq_count12 < -827384824.272337, modinq_size_7_c613, modinq_size_7_c614);

modinq_size_8_c644 := if(rv_i60_inq_retail_count12 < 0.783083, 15.094655, 9.207392);

modinq_size_8_c645 := if(rv_i62_inq_dobs_per_adl < 0.887720, 8.000000, 9.207392);

modinq_size_8_c643 := if(rv_i60_inq_auto_count12 < 0.278444, modinq_size_8_c644, modinq_size_8_c645);

modinq_size_8_c646 := if(rv_i61_inq_collection_recency < 21.350350, 7.000000, 7.000000);

modinq_size_8_c642 := if(nf_invbest_inq_lnamesperssn_diff < -0.619978, modinq_size_8_c643, modinq_size_8_c646);

modinq_size_8_c647 := if(nf_inq_bestdob_ver_count < 1.846910, 6.000000, 6.000000);

modinq_size_8_c641 := if(rv_i62_inq_phones_per_adl < 0.124998, modinq_size_8_c642, modinq_size_8_c647);

modinq_size_8_c651 := if(nf_inq_auto_count < 1.369108, 9.000000, 8.000000);

modinq_size_8_c652 := if(nf_inq_bestfname_ver_count < 25.334753, 9.000000, 8.000000);

modinq_size_8_c650 := if(nf_inq_fname_ver_count < 10.824340, modinq_size_8_c651, modinq_size_8_c652);

modinq_size_8_c649 := if(nf_inq_bestlname_ver_count < 96.212753, modinq_size_8_c650, 7.000000);

modinq_size_8_c653 := if(nf_inq_perbestssn_count12 < 1.540404, 6.000000, 6.000000);

modinq_size_8_c648 := if(nf_inq_perbestssn_count12 < 0.037857, modinq_size_8_c649, modinq_size_8_c653);

modinq_size_8_c640 := if(nf_invbest_inq_lastperaddr_diff < -0.334941, modinq_size_8_c641, modinq_size_8_c648);

modinq_size_8_c658 := if(nf_inq_count24 < 0.741412, 10.327020, 8.000000);

modinq_size_8_c657 := if(nf_inq_retailpayments_count < 0.506820, modinq_size_8_c658, 7.000000);

modinq_size_8_c656 := if(rv_i60_inq_retail_recency < 25.021712, modinq_size_8_c657, 6.000000);

modinq_size_8_c659 := if(nf_inq_addr_ver_count < 1.134037, 6.000000, 6.000000);

modinq_size_8_c655 := if(nf_inq_other_count24 < 0.630213, modinq_size_8_c656, modinq_size_8_c659);

modinq_size_8_c660 := if(nf_invbest_inq_lastperaddr_diff < -1.058346, 5.000000, 5.000000);

modinq_size_8_c654 := if(nf_inq_percurraddr_count12 < 0.335816, modinq_size_8_c655, modinq_size_8_c660);

modinq_size_8_c639 := if(nf_inq_per_apt_addr < -0.519184, modinq_size_8_c640, modinq_size_8_c654);

modinq_size_8_c666 := if(nf_inq_bestssn_ver_count < 207.647473, 12.116889, 8.000000);

modinq_size_8_c667 := if(rv_i60_inq_peradl_count12 < 1.609337, 8.000000, 8.000000);

modinq_size_8_c665 := if(rv_i62_inq_addrsperadl_recency < 11.474164, modinq_size_8_c666, modinq_size_8_c667);

modinq_size_8_c664 := if(nf_inq_ssnsperaddr_count12 < 0.844317, modinq_size_8_c665, 6.000000);

modinq_size_8_c663 := if(rv_i62_inq_phonesperadl_count12 < 0.769590, modinq_size_8_c664, 5.000000);

modinq_size_8_c671 := if(rv_i60_inq_recency < 14.529755, 11.296252, 11.535537);

modinq_size_8_c670 := if(nf_inq_lnamesperaddr_recency < 1.641262, 7.000000, modinq_size_8_c671);

modinq_size_8_c672 := if(nf_inq_mortgage_count < 1.199748, 7.000000, 7.000000);

modinq_size_8_c669 := if(nf_inq_lnames_per_sfd_addr < 1.667496, modinq_size_8_c670, modinq_size_8_c672);

modinq_size_8_c675 := if(nf_inq_other_count24 < 0.610322, 9.207392, 8.000000);

modinq_size_8_c674 := if(nf_inq_banking_count24 < 0.749599, modinq_size_8_c675, 7.000000);

modinq_size_8_c677 := if(rv_i62_inq_lnamesperadl_recency < 3.114758, 8.000000, 8.000000);

modinq_size_8_c676 := if(rv_i60_inq_recency < 7.764311, 7.000000, modinq_size_8_c677);

modinq_size_8_c673 := if(nf_inq_adls_per_addr < 1.451911, modinq_size_8_c674, modinq_size_8_c676);

modinq_size_8_c668 := if(nf_inq_auto_count < 0.766763, modinq_size_8_c669, modinq_size_8_c673);

modinq_size_8_c662 := if(nf_inq_ssns_per_sfd_addr < 0.546441, modinq_size_8_c663, modinq_size_8_c668);

modinq_size_8_c661 := if(nf_inquiry_addr_vel_risk_index < 6.448299, modinq_size_8_c662, 3.000000);

modinq_size_8_c638 := if(nf_inq_lnamesperaddr_count12 < 0.360809, modinq_size_8_c639, modinq_size_8_c661);

modinq_size_8_c684 := if(nf_inq_auto_count < 4.936844, 11.941420, 8.000000);

modinq_size_8_c685 := if(rv_i62_inq_phonesperadl_count12 < 0.203850, 11.941420, 9.207392);

modinq_size_8_c683 := if(nf_inq_adls_per_sfd_addr < -0.940218, modinq_size_8_c684, modinq_size_8_c685);

modinq_size_8_c687 := if(nf_inq_addrsperssn_count_day < 0.442771, 9.000000, 8.000000);

modinq_size_8_c688 := if(nf_inq_lnamesperaddr_count12 < 1.809490, 11.023665, 8.000000);

modinq_size_8_c686 := if(nf_inquiry_verification_index < 30.988888, modinq_size_8_c687, modinq_size_8_c688);

modinq_size_8_c682 := if(rv_i62_inq_addrsperadl_count12 < 1.089317, modinq_size_8_c683, modinq_size_8_c686);

modinq_size_8_c691 := if(nf_inq_addr_ver_count < 0.890729, 8.000000, 8.000000);

modinq_size_8_c690 := if(nf_inq_retail_count24 < 0.021087, 7.000000, modinq_size_8_c691);

modinq_size_8_c692 := if(nf_inq_other_count24 < 0.466551, 7.000000, 7.000000);

modinq_size_8_c689 := if(nf_inq_dobsperssn_recency < 0.048396, modinq_size_8_c690, modinq_size_8_c692);

modinq_size_8_c681 := if(nf_inq_quizprovider_count < 1.578140, modinq_size_8_c682, modinq_size_8_c689);

modinq_size_8_c696 := if(nf_inq_bestfname_ver_count < 15.254253, 8.000000, 8.000000);

modinq_size_8_c695 := if(rv_i62_inq_addrsperadl_recency < 1.692539, 7.000000, modinq_size_8_c696);

modinq_size_8_c698 := if(nf_inq_per_addr < 0.583997, 8.000000, 8.000000);

modinq_size_8_c697 := if(nf_inquiry_ssn_vel_risk_index < 1.725358, 7.000000, modinq_size_8_c698);

modinq_size_8_c694 := if(nf_inq_perssn_count12 < 8.167459, modinq_size_8_c695, modinq_size_8_c697);

modinq_size_8_c699 := if(nf_inq_ssnspercurraddr_count12 < 2.953592, 6.000000, 6.000000);

modinq_size_8_c693 := if(nf_inq_percurraddr_count12 < 1.975560, modinq_size_8_c694, modinq_size_8_c699);

modinq_size_8_c680 := if(rv_i60_inq_count12 < 6.460751, modinq_size_8_c681, modinq_size_8_c693);

modinq_size_8_c703 := if(nf_inq_bestlname_ver_count < 6.363084, 7.000000, 7.000000);

modinq_size_8_c704 := if(nf_inq_highriskcredit_count24 < 0.844479, 7.000000, 7.000000);

modinq_size_8_c702 := if(nf_inq_communications_count24 < 1.941671, modinq_size_8_c703, modinq_size_8_c704);

modinq_size_8_c705 := if(nf_inq_ssns_per_addr < 0.752765, 6.000000, 6.000000);

modinq_size_8_c701 := if(nf_inq_lnames_per_addr < 0.296526, modinq_size_8_c702, modinq_size_8_c705);

modinq_size_8_c700 := if(nf_inq_mortgage_count < 0.886079, modinq_size_8_c701, 4.000000);

modinq_size_8_c679 := if(nf_inq_communications_count24 < 0.506812, modinq_size_8_c680, modinq_size_8_c700);

modinq_size_8_c711 := if(rv_i60_inq_hiriskcred_recency < 92.818537, 13.887806, 8.000000);

modinq_size_8_c712 := if(nf_inq_dobsperadl_count_week < 0.924431, 12.695532, 9.000000);

modinq_size_8_c710 := if(nf_inq_adlsperaddr_count12 < 1.149992, modinq_size_8_c711, modinq_size_8_c712);

modinq_size_8_c714 := if(nf_inq_ssns_per_addr < 1.411490, 8.000000, 8.000000);

modinq_size_8_c715 := if(nf_inq_adls_per_sfd_addr < 1.167217, 9.000000, 10.327020);

modinq_size_8_c713 := if(rv_i62_inq_lnamesperadl_recency < 4.066250, modinq_size_8_c714, modinq_size_8_c715);

modinq_size_8_c709 := if(rv_i62_inq_dobsperadl_count12 < 1.943198, modinq_size_8_c710, modinq_size_8_c713);

modinq_size_8_c708 := if(rv_i60_inq_mortgage_count12 < 0.636065, modinq_size_8_c709, 5.000000);

modinq_size_8_c707 := if(nf_inq_communications_count < 2.440632, modinq_size_8_c708, 4.000000);

modinq_size_8_c718 := if(nf_inq_bestlname_ver_count < 5.462554, 6.000000, 6.000000);

modinq_size_8_c720 := if(nf_inq_perssn_count_week < 0.043151, 7.000000, 7.000000);

modinq_size_8_c719 := if(rv_i62_inq_dobsperadl_recency < 4.057706, 6.000000, modinq_size_8_c720);

modinq_size_8_c717 := if(rv_i62_inq_addrsperadl_count12 < 1.443551, modinq_size_8_c718, modinq_size_8_c719);

modinq_size_8_c722 := if(nf_invbest_inq_ssnsperaddr_diff < 5.127561, 6.000000, 6.000000);

modinq_size_8_c721 := if(nf_inq_count < 10.354227, modinq_size_8_c722, 5.000000);

modinq_size_8_c716 := if(nf_inq_bestssn_ver_count < 13.668787, modinq_size_8_c717, modinq_size_8_c721);

modinq_size_8_c706 := if(nf_inquiry_addr_vel_risk_index < 4.389419, modinq_size_8_c707, modinq_size_8_c716);

modinq_size_8_c678 := if(nf_inq_lnames_per_sfd_addr < 0.772046, modinq_size_8_c679, modinq_size_8_c706);

modinq_size_8 := if(rv_i62_inq_ssnsperadl_count12 < 0.864432, modinq_size_8_c638, modinq_size_8_c678);

modinq_size_9_c730 := if(nf_inq_prepaidcards_count < 1.844010, 16.661537, 9.000000);

modinq_size_9_c731 := if(nf_inq_per_sfd_addr < 0.473078, 10.327020, 8.000000);

modinq_size_9_c729 := if(nf_inq_retail_count24 < 0.197904, modinq_size_9_c730, modinq_size_9_c731);

modinq_size_9_c732 := if(nf_inq_ssnspercurraddr_count12 < 0.022882, 7.000000, 7.000000);

modinq_size_9_c728 := if(rv_i62_inq_dobs_per_adl < 1.455843, modinq_size_9_c729, modinq_size_9_c732);

modinq_size_9_c727 := if(nf_inq_per_ssn < 17.817456, modinq_size_9_c728, 5.000000);

modinq_size_9_c736 := if(nf_inq_bestdob_ver_count < 4.548772, 15.309216, 14.531555);

modinq_size_9_c737 := if(rv_i60_inq_prepaidcards_recency < 21.386774, 11.296252, 9.000000);

modinq_size_9_c735 := if(nf_inq_perbestssn_count12 < 5.896942, modinq_size_9_c736, modinq_size_9_c737);

modinq_size_9_c739 := if(nf_inq_count < 1.804114, 8.000000, 8.000000);

modinq_size_9_c740 := if(nf_inq_banking_count24 < 0.912817, 8.000000, 8.000000);

modinq_size_9_c738 := if(nf_inquiry_addr_vel_risk_indexv2 < 0.591483, modinq_size_9_c739, modinq_size_9_c740);

modinq_size_9_c734 := if(nf_inq_bestdob_ver_count < 121.184250, modinq_size_9_c735, modinq_size_9_c738);

modinq_size_9_c743 := if(rv_i60_inq_hiriskcred_count12 < 1.785816, 9.207392, 8.000000);

modinq_size_9_c742 := if(nf_inq_dobsperadl_count_week < 0.350315, modinq_size_9_c743, 7.000000);

modinq_size_9_c741 := if(nf_inq_collection_count < 8.383384, modinq_size_9_c742, 6.000000);

modinq_size_9_c733 := if(nf_inq_perssn_count12 < 8.969854, modinq_size_9_c734, modinq_size_9_c741);

modinq_size_9_c726 := if(nf_inq_lnamesperaddr_count12 < 0.579476, modinq_size_9_c727, modinq_size_9_c733);

modinq_size_9_c747 := if(nf_inq_count_week < 1.919631, 7.000000, 7.000000);

modinq_size_9_c746 := if(nf_inq_highriskcredit_count < 0.881332, modinq_size_9_c747, 6.000000);

modinq_size_9_c745 := if(nf_inq_auto_count < 5.006929, 5.000000, modinq_size_9_c746);

modinq_size_9_c744 := if(nf_inq_auto_count24 < 13.977983, modinq_size_9_c745, 4.000000);

modinq_size_9_c725 := if(nf_inq_ssnsperadl_count_week < 0.030725, modinq_size_9_c726, modinq_size_9_c744);

modinq_size_9_c724 := if(rv_i62_inq_lnamesperadl_recency < -843565790.552132, 2.000000, modinq_size_9_c725);

modinq_size_9_c750 := if(rv_i62_inq_addrsperadl_recency < 6.146489, 4.000000, 4.000000);

modinq_size_9_c749 := if(nf_inq_peraddr_count12 < 18.446127, modinq_size_9_c750, 3.000000);

modinq_size_9_c748 := if(nf_inq_perbestssn_count12 < -573449489.001566, 2.000000, modinq_size_9_c749);

modinq_size_9 := if(nf_inq_per_addr < 14.989414, modinq_size_9_c724, modinq_size_9_c748);

modinq_size_10_c753 := if(nf_inq_ssns_per_sfd_addr < -0.001368, 3.000000, 3.000000);

modinq_size_10_c752 := if(nf_inq_ssns_per_addr < 0.777334, modinq_size_10_c753, 2.000000);

modinq_size_10_c760 := if(nf_inq_adls_per_apt_addr < -0.642654, 17.437724, 13.669106);

modinq_size_10_c759 := if(nf_inq_retail_count24 < 3.811787, modinq_size_10_c760, 7.000000);

modinq_size_10_c762 := if(nf_inq_adls_per_addr < 0.908580, 8.000000, 10.327020);

modinq_size_10_c763 := if(rv_i62_inq_dobsperadl_count12 < 1.304846, 8.000000, 8.000000);

modinq_size_10_c761 := if(rv_i60_inq_recency < 5.232035, modinq_size_10_c762, modinq_size_10_c763);

modinq_size_10_c758 := if(nf_inq_quizprovider_count < 4.610289, modinq_size_10_c759, modinq_size_10_c761);

modinq_size_10_c766 := if(nf_inq_retailpayments_count < 0.575884, 9.000000, 8.000000);

modinq_size_10_c765 := if(rv_i60_inq_auto_recency < 10.343985, modinq_size_10_c766, 7.000000);

modinq_size_10_c764 := if(nf_inq_dob_ver_count < 35.565513, modinq_size_10_c765, 6.000000);

modinq_size_10_c757 := if(nf_inq_per_apt_addr < 1.309761, modinq_size_10_c758, modinq_size_10_c764);

modinq_size_10_c756 := if(nf_inq_lnames_per_ssn < 2.907913, modinq_size_10_c757, 4.000000);

modinq_size_10_c771 := if(nf_inq_retailpayments_count < 0.413341, 10.706640, 8.000000);

modinq_size_10_c772 := if(nf_inq_quizprovider_count24 < 0.341571, 10.327020, 8.000000);

modinq_size_10_c770 := if(rv_i62_inq_addrs_per_adl < 0.476870, modinq_size_10_c771, modinq_size_10_c772);

modinq_size_10_c774 := if(rv_i62_inq_phones_per_adl < 1.585845, 12.565879, 8.000000);

modinq_size_10_c773 := if(rv_i60_inq_auto_recency < 74.110055, modinq_size_10_c774, 7.000000);

modinq_size_10_c769 := if(nf_inq_lnamesperssn_count12 < 0.065784, modinq_size_10_c770, modinq_size_10_c773);

modinq_size_10_c777 := if(nf_inq_adls_per_sfd_addr < 1.050562, 8.000000, 9.000000);

modinq_size_10_c776 := if(nf_inq_dob_ver_count < 171.261888, 7.000000, modinq_size_10_c777);

modinq_size_10_c775 := if(nf_inq_curraddr_ver_count < 177.309652, 6.000000, modinq_size_10_c776);

modinq_size_10_c768 := if(nf_inq_bestssn_ver_count < 226.768561, modinq_size_10_c769, modinq_size_10_c775);

modinq_size_10_c780 := if(nf_inq_other_count < 3.066016, 7.000000, 7.000000);

modinq_size_10_c781 := if(nf_inq_perssn_count_week < 2.640917, 7.000000, 7.000000);

modinq_size_10_c779 := if(nf_inq_lnamespercurraddr_count12 < 0.891429, modinq_size_10_c780, modinq_size_10_c781);

modinq_size_10_c778 := if(nf_inquiry_ssn_vel_risk_indexv2 < 1.288076, modinq_size_10_c779, 5.000000);

modinq_size_10_c767 := if(rv_i60_inq_count12 < 4.589293, modinq_size_10_c768, modinq_size_10_c778);

modinq_size_10_c755 := if(nf_inq_lnamesperaddr_recency < 6.176783, modinq_size_10_c756, modinq_size_10_c767);

modinq_size_10_c754 := if(nf_invbest_inq_peraddr_diff < 34.084401, modinq_size_10_c755, 2.000000);

//modinq_size_10 := if(rv_i62_inq_phones_per_adl < -4688834188.641170, modinq_size_10_c752, modinq_size_10_c754);
modinq_size_10 := if(rv_i62_inq_phones_per_adl < -999999998, modinq_size_10_c752, modinq_size_10_c754);

modinq_size_11_c783 := if(nf_inq_adls_per_sfd_addr < 0.684051, 2.000000, 2.000000);

modinq_size_11_c790 := if(nf_inq_banking_count24 < 0.060765, 16.873996, 12.278091);

modinq_size_11_c791 := if(rv_i60_inq_retpymt_recency < 2.484228, 11.748880, 9.207392);

modinq_size_11_c789 := if(nf_inq_count < 12.687852, modinq_size_11_c790, modinq_size_11_c791);

modinq_size_11_c793 := if(nf_inq_auto_count < 11.226633, 14.428899, 9.000000);

modinq_size_11_c794 := if(nf_invbest_inq_ssnsperaddr_diff < 1.449809, 9.000000, 8.000000);

modinq_size_11_c792 := if(nf_inq_lnamesperssn_count12 < 1.603346, modinq_size_11_c793, modinq_size_11_c794);

modinq_size_11_c788 := if(nf_inq_perssn_count12 < 1.889954, modinq_size_11_c789, modinq_size_11_c792);

modinq_size_11_c797 := if(nf_inq_adls_per_apt_addr < -0.812724, 9.851656, 8.000000);

modinq_size_11_c798 := if(nf_inq_ssn_ver_count < 29.310647, 8.000000, 8.000000);

modinq_size_11_c796 := if(nf_inq_per_ssn < 4.948170, modinq_size_11_c797, modinq_size_11_c798);

modinq_size_11_c795 := if(nf_inq_lnamesperaddr_count_week < 0.446293, modinq_size_11_c796, 6.000000);

modinq_size_11_c787 := if(nf_inq_other_count24 < 3.367661, modinq_size_11_c788, modinq_size_11_c795);

modinq_size_11_c786 := if(rv_i60_inq_mortgage_count12 < 2.701232, modinq_size_11_c787, 4.000000);

modinq_size_11_c785 := if(nf_inq_addrs_per_ssn < 2.377999, modinq_size_11_c786, 3.000000);

modinq_size_11_c804 := if(rv_i60_inq_count12 < 1.829353, 8.000000, 9.207392);

modinq_size_11_c805 := if(nf_inq_collection_count_week < 0.964178, 12.116889, 8.000000);

modinq_size_11_c803 := if(nf_inq_perssn_recency < 6.323491, modinq_size_11_c804, modinq_size_11_c805);

modinq_size_11_c807 := if(rv_i60_inq_banking_count12 < 0.546791, 12.565879, 8.000000);

modinq_size_11_c806 := if(nf_inq_bestlname_ver_count < 119.867955, modinq_size_11_c807, 7.000000);

modinq_size_11_c802 := if(rv_i60_inq_auto_count12 < 1.854061, modinq_size_11_c803, modinq_size_11_c806);

modinq_size_11_c810 := if(rv_i62_inq_dobsperadl_count12 < 0.046006, 8.000000, 9.207392);

modinq_size_11_c811 := if(nf_inq_curraddr_ver_count < 1.136470, 9.000000, 8.000000);

modinq_size_11_c809 := if(nf_inq_bestssn_ver_count < 9.610104, modinq_size_11_c810, modinq_size_11_c811);

modinq_size_11_c808 := if(rv_i60_inq_peradl_count12 < 10.701482, modinq_size_11_c809, 6.000000);

modinq_size_11_c801 := if(rv_i60_inq_auto_recency < 98.060842, modinq_size_11_c802, modinq_size_11_c808);

modinq_size_11_c812 := if(nf_inq_lname_ver_count < 4.486318, 5.000000, 5.000000);

modinq_size_11_c800 := if(nf_inq_adls_per_addr < 3.280414, modinq_size_11_c801, modinq_size_11_c812);

modinq_size_11_c813 := if(nf_inq_lnamesperssn_count_week < 0.525073, 4.000000, 4.000000);

modinq_size_11_c799 := if(nf_inq_lnamesperadl_count_week < 0.958589, modinq_size_11_c800, modinq_size_11_c813);

modinq_size_11_c784 := if(nf_inq_adlsperssn_recency < 9.732939, modinq_size_11_c785, modinq_size_11_c799);

//modinq_size_11 := if(rv_i62_inq_addrs_per_adl < -6183991287.675547, modinq_size_11_c783, modinq_size_11_c784);
modinq_size_11 := if(rv_i62_inq_addrs_per_adl < -999999998, modinq_size_11_c783, modinq_size_11_c784);

modinq_size_12_c821 := if(nf_inq_bestdob_ver_count < 250.038008, 13.744698, 9.000000);

modinq_size_12_c822 := if(nf_inq_auto_count24 < 0.861753, 10.327020, 8.000000);

modinq_size_12_c820 := if(rv_i60_inq_retail_recency < 17.082597, modinq_size_12_c821, modinq_size_12_c822);

modinq_size_12_c824 := if(nf_invbest_inq_ssnsperaddr_diff < -1.311317, 8.000000, 8.000000);

modinq_size_12_c823 := if(rv_i60_inq_auto_recency < 25.273855, modinq_size_12_c824, 7.000000);

modinq_size_12_c819 := if(nf_inq_bestfname_ver_count < 30.661008, modinq_size_12_c820, modinq_size_12_c823);

modinq_size_12_c827 := if(nf_inq_other_count24 < 1.713001, 15.735161, 12.695532);

modinq_size_12_c828 := if(nf_inquiry_adl_vel_risk_index < 3.686777, 9.207392, 8.000000);

modinq_size_12_c826 := if(rv_i62_inq_ssns_per_adl < 1.035292, modinq_size_12_c827, modinq_size_12_c828);

modinq_size_12_c825 := if(nf_inq_phonesperadl_count_day < 0.342972, modinq_size_12_c826, 6.000000);

modinq_size_12_c818 := if(nf_inquiry_verification_index < 28.754669, modinq_size_12_c819, modinq_size_12_c825);

modinq_size_12_c829 := if(rv_i62_inq_fnamesperadl_recency < 1.096259, 5.000000, 5.000000);

modinq_size_12_c817 := if(nf_inq_mortgage_count24 < 0.710025, modinq_size_12_c818, modinq_size_12_c829);

modinq_size_12_c834 := if(nf_inq_adlsperaddr_count12 < 1.232151, 13.241134, 8.000000);

modinq_size_12_c833 := if(nf_inq_auto_count < 14.014570, modinq_size_12_c834, 7.000000);

modinq_size_12_c836 := if(nf_inq_adls_per_addr < 2.067535, 13.590539, 8.000000);

modinq_size_12_c837 := if(nf_inq_fname_ver_count < 5.328237, 9.000000, 8.000000);

modinq_size_12_c835 := if(nf_inq_addrsperssn_count12 < 1.326472, modinq_size_12_c836, modinq_size_12_c837);

modinq_size_12_c832 := if(rv_i62_inq_addrsperadl_count12 < 0.563438, modinq_size_12_c833, modinq_size_12_c835);

modinq_size_12_c839 := if(rv_i60_inq_retpymt_count12 < 0.095764, 7.000000, 7.000000);

modinq_size_12_c838 := if(nf_inq_count24 < 1.502176, 6.000000, modinq_size_12_c839);

modinq_size_12_c831 := if(rv_i60_inq_retail_count12 < 0.038260, modinq_size_12_c832, modinq_size_12_c838);

modinq_size_12_c841 := if(nf_inq_bestdob_ver_count < 53.251979, 6.000000, 6.000000);

modinq_size_12_c840 := if(nf_inq_lnamesperaddr_recency < 4.519835, 5.000000, modinq_size_12_c841);

modinq_size_12_c830 := if(nf_inq_ssns_per_apt_addr < 1.117131, modinq_size_12_c831, modinq_size_12_c840);

modinq_size_12_c816 := if(nf_inq_perssn_recency < 5.768268, modinq_size_12_c817, modinq_size_12_c830);

modinq_size_12_c847 := if(nf_inq_lnames_per_sfd_addr < -0.397215, 8.000000, 9.207392);

modinq_size_12_c846 := if(nf_invbest_inq_peraddr_diff < -0.148164, modinq_size_12_c847, 7.000000);

modinq_size_12_c845 := if(nf_inq_peradl_count_week < 0.833129, modinq_size_12_c846, 6.000000);

modinq_size_12_c844 := if(nf_inq_quizprovider_count24 < 0.385314, modinq_size_12_c845, 5.000000);

modinq_size_12_c843 := if(rv_i62_inq_addrsperadl_count12 < 2.356141, modinq_size_12_c844, 4.000000);

modinq_size_12_c848 := if(nf_inq_lnamesperbestssn_count12 < 1.005596, 4.000000, 4.000000);

modinq_size_12_c842 := if(nf_inq_adls_per_addr < 2.161270, modinq_size_12_c843, modinq_size_12_c848);

modinq_size_12_c815 := if(rv_i62_inq_dobsperadl_count12 < 1.477314, modinq_size_12_c816, modinq_size_12_c842);

modinq_size_12_c855 := if(nf_inq_dobsperbestssn_count12 < 0.777507, 13.887806, 11.535537);

modinq_size_12_c854 := if(nf_inq_per_apt_addr < 0.894794, modinq_size_12_c855, 7.000000);

modinq_size_12_c857 := if(rv_i62_inq_phones_per_adl < 0.423941, 9.000000, 9.000000);

modinq_size_12_c856 := if(rv_i61_inq_collection_recency < 15.340570, modinq_size_12_c857, 7.000000);

modinq_size_12_c853 := if(nf_inq_per_addr < 7.661643, modinq_size_12_c854, modinq_size_12_c856);

modinq_size_12_c859 := if(nf_inq_addrsperssn_recency < 4.430505, 7.000000, 7.000000);

modinq_size_12_c860 := if(nf_inq_collection_count < 6.462285, 7.000000, 7.000000);

modinq_size_12_c858 := if(rv_i60_inq_auto_count12 < 2.322479, modinq_size_12_c859, modinq_size_12_c860);

modinq_size_12_c852 := if(nf_inq_fname_ver_count < 21.022790, modinq_size_12_c853, modinq_size_12_c858);

modinq_size_12_c861 := if(rv_i60_inq_auto_recency < 11.446208, 5.000000, 5.000000);

modinq_size_12_c851 := if(rv_i60_inq_comm_count12 < 2.467878, modinq_size_12_c852, modinq_size_12_c861);

modinq_size_12_c863 := if(nf_inq_dob_ver_count < 5.513506, 5.000000, 5.000000);

modinq_size_12_c862 := if(nf_inq_ssn_ver_count < 8.297962, modinq_size_12_c863, 4.000000);

modinq_size_12_c850 := if(rv_i60_inq_hiriskcred_recency < 57.830106, modinq_size_12_c851, modinq_size_12_c862);

modinq_size_12_c849 := if(nf_inq_fnamesperadl_count_day < 0.007011, modinq_size_12_c850, 2.000000);

modinq_size_12 := if(rv_i60_inq_other_recency < 80.575050, modinq_size_12_c815, modinq_size_12_c849);

modinq_size_13_c871 := if(nf_inq_addrsperadl_count_week < 0.801093, 17.810160, 9.207392);

modinq_size_13_c872 := if(nf_inq_peraddr_count12 < 0.687743, 8.000000, 10.706640);

modinq_size_13_c870 := if(nf_inq_ssnsperadl_count_week < 0.454932, modinq_size_13_c871, modinq_size_13_c872);

modinq_size_13_c874 := if(nf_inq_quizprovider_count < 1.511791, 8.000000, 8.000000);

modinq_size_13_c873 := if(rv_i60_inq_retail_count12 < 0.359363, modinq_size_13_c874, 7.000000);

modinq_size_13_c869 := if(rv_i60_inq_hiriskcred_count12 < 1.210619, modinq_size_13_c870, modinq_size_13_c873);

modinq_size_13_c868 := if(rv_i60_inq_retail_count12 < 5.591877, modinq_size_13_c869, 5.000000);

modinq_size_13_c875 := if(rv_i62_inq_phonesperadl_count12 < 0.332997, 5.000000, 5.000000);

modinq_size_13_c867 := if(nf_inq_adlspercurraddr_count12 < 3.743807, modinq_size_13_c868, modinq_size_13_c875);

modinq_size_13_c866 := if(nf_invbest_inq_perssn_diff < -3.682292, 3.000000, modinq_size_13_c867);

modinq_size_13_c881 := if(nf_inq_ssnsperaddr_count12 < 1.980658, 8.000000, 9.000000);

modinq_size_13_c882 := if(nf_inq_ssnsperaddr_count12 < 2.679822, 8.000000, 9.207392);

modinq_size_13_c880 := if(nf_inq_lnamespercurraddr_count12 < 1.578752, modinq_size_13_c881, modinq_size_13_c882);

modinq_size_13_c884 := if(nf_inq_mortgage_count < 0.947736, 8.000000, 8.000000);

modinq_size_13_c885 := if(rv_i62_inq_ssnsperadl_recency < 2.102279, 9.000000, 9.000000);

modinq_size_13_c883 := if(nf_inq_lnamespercurraddr_count12 < 0.834944, modinq_size_13_c884, modinq_size_13_c885);

modinq_size_13_c879 := if(rv_i60_inq_banking_recency < 93.647210, modinq_size_13_c880, modinq_size_13_c883);

modinq_size_13_c888 := if(nf_inq_perssn_count12 < 0.971249, 11.023665, 9.000000);

modinq_size_13_c889 := if(nf_inq_lnamesperaddr_recency < 7.766023, 8.000000, 8.000000);

modinq_size_13_c887 := if(nf_inq_lnamesperaddr_recency < 1.761591, modinq_size_13_c888, modinq_size_13_c889);

modinq_size_13_c886 := if(nf_inq_adls_per_addr < 1.682627, modinq_size_13_c887, 6.000000);

modinq_size_13_c878 := if(nf_inq_bestlname_ver_count < 253.322150, modinq_size_13_c879, modinq_size_13_c886);

modinq_size_13_c890 := if(nf_inq_lnamesperaddr_count12 < 4.373535, 5.000000, 5.000000);

modinq_size_13_c877 := if(nf_inq_ssns_per_apt_addr < 1.561357, modinq_size_13_c878, modinq_size_13_c890);

modinq_size_13_c892 := if(rv_i60_inq_hiriskcred_count12 < 0.948148, 5.000000, 5.000000);

modinq_size_13_c891 := if(nf_inq_lnamesperbestssn_count12 < 0.426156, modinq_size_13_c892, 4.000000);

modinq_size_13_c876 := if(rv_i60_inq_auto_recency < 96.753791, modinq_size_13_c877, modinq_size_13_c891);

modinq_size_13_c865 := if(nf_inq_bestlname_ver_count < 30.815257, modinq_size_13_c866, modinq_size_13_c876);

modinq_size_13_c894 := if(nf_inq_auto_count24 < 2.832544, 3.000000, 3.000000);

modinq_size_13_c893 := if(rv_i62_inq_phonesperadl_count12 < 1.739369, 2.000000, modinq_size_13_c894);

modinq_size_13 := if(nf_inq_retailpayments_count24 < 1.638774, modinq_size_13_c865, modinq_size_13_c893);

modinq_size_14_c896 := if(nf_inq_adls_per_sfd_addr < 0.908153, 2.000000, 2.000000);

modinq_size_14_c903 := if(rv_i60_inq_auto_count12 < 0.233360, 16.591349, 8.000000);

modinq_size_14_c904 := if(nf_inq_addrs_per_ssn < 0.285463, 10.706640, 8.000000);

modinq_size_14_c902 := if(rv_i62_inq_ssnsperadl_recency < 9.751246, modinq_size_14_c903, modinq_size_14_c904);

modinq_size_14_c906 := if(rv_i62_inq_ssns_per_adl < 1.943378, 13.241134, 9.000000);

modinq_size_14_c907 := if(nf_inq_fnamesperadl_count_week < 0.838651, 8.000000, 9.000000);

modinq_size_14_c905 := if(nf_inq_collection_count < 6.828223, modinq_size_14_c906, modinq_size_14_c907);

modinq_size_14_c901 := if(rv_i62_inq_dobsperadl_count12 < 0.310057, modinq_size_14_c902, modinq_size_14_c905);

modinq_size_14_c910 := if(nf_inq_bestfname_ver_count < 22.325223, 12.565879, 8.000000);

modinq_size_14_c909 := if(nf_inq_perbestssn_count12 < 8.368419, modinq_size_14_c910, 7.000000);

modinq_size_14_c908 := if(rv_i60_credit_seeking < 2.464917, modinq_size_14_c909, 6.000000);

modinq_size_14_c900 := if(rv_i60_inq_comm_recency < 6.895337, modinq_size_14_c901, modinq_size_14_c908);

modinq_size_14_c911 := if(nf_inq_bestlname_ver_count < 8.465773, 5.000000, 5.000000);

modinq_size_14_c899 := if(nf_invbest_inq_adlsperssn_diff < -0.312862, modinq_size_14_c900, modinq_size_14_c911);

modinq_size_14_c913 := if(nf_inq_ssns_per_apt_addr < 0.840217, 5.000000, 5.000000);

modinq_size_14_c917 := if(rv_i60_inq_peradl_count12 < 1.679524, 12.427187, 9.000000);

modinq_size_14_c918 := if(nf_inq_dobsperssn_count12 < 0.004800, 11.535537, 8.000000);

modinq_size_14_c916 := if(nf_inq_addr_ver_count < 4.320842, modinq_size_14_c917, modinq_size_14_c918);

modinq_size_14_c915 := if(nf_inq_retailpayments_count24 < 0.328992, modinq_size_14_c916, 6.000000);

modinq_size_14_c914 := if(rv_i60_inq_peradl_count12 < 5.553803, modinq_size_14_c915, 5.000000);

modinq_size_14_c912 := if(nf_inq_lnamesperaddr_recency < 8.071035, modinq_size_14_c913, modinq_size_14_c914);

modinq_size_14_c898 := if(nf_inq_adlsperaddr_recency < 9.017255, modinq_size_14_c899, modinq_size_14_c912);

modinq_size_14_c924 := if(nf_inq_lnamesperaddr_recency < 1.166463, 12.116889, 13.887806);

modinq_size_14_c925 := if(nf_inquiry_addr_vel_risk_index < 0.123639, 8.000000, 8.000000);

modinq_size_14_c923 := if(rv_i62_inq_phones_per_adl < 2.088085, modinq_size_14_c924, modinq_size_14_c925);

modinq_size_14_c922 := if(nf_inq_peradl_count_day < 0.006814, modinq_size_14_c923, 6.000000);

modinq_size_14_c926 := if(nf_inq_bestfname_ver_count < 18.644555, 6.000000, 6.000000);

modinq_size_14_c921 := if(nf_inq_collection_count24 < 5.553846, modinq_size_14_c922, modinq_size_14_c926);

modinq_size_14_c929 := if(nf_inq_addrs_per_ssn < 0.103204, 7.000000, 7.000000);

modinq_size_14_c931 := if(rv_i62_inq_fnamesperadl_recency < 9.400691, 8.000000, 8.000000);

modinq_size_14_c930 := if(nf_inq_lnamesperaddr_count12 < 1.005896, 7.000000, modinq_size_14_c931);

modinq_size_14_c928 := if(nf_inq_bestfname_ver_count < 22.561970, modinq_size_14_c929, modinq_size_14_c930);

modinq_size_14_c932 := if(nf_inq_lnames_per_ssn < 1.120743, 6.000000, 6.000000);

modinq_size_14_c927 := if(nf_inq_banking_count24 < 0.189247, modinq_size_14_c928, modinq_size_14_c932);

modinq_size_14_c920 := if(nf_inq_other_count24 < 3.064960, modinq_size_14_c921, modinq_size_14_c927);

modinq_size_14_c936 := if(nf_inq_highriskcredit_count24 < 0.124147, 7.000000, 7.000000);

modinq_size_14_c935 := if(rv_i62_inq_phonesperadl_recency < 7.189774, 6.000000, modinq_size_14_c936);

modinq_size_14_c934 := if(nf_inq_ssns_per_apt_addr < -0.342880, modinq_size_14_c935, 5.000000);

modinq_size_14_c933 := if(nf_inq_curraddr_ver_count < 2.853157, 4.000000, modinq_size_14_c934);

modinq_size_14_c919 := if(rv_i60_inq_retail_count12 < 0.454549, modinq_size_14_c920, modinq_size_14_c933);

modinq_size_14_c897 := if(nf_inq_dobsperssn_recency < 1.829519, modinq_size_14_c898, modinq_size_14_c919);

//modinq_size_14 := if(nf_inq_prepaidcards_count_day < -5393288940.583262, modinq_size_14_c896, modinq_size_14_c897);
modinq_size_14 := if(nf_inq_prepaidcards_count_day < -999999998, modinq_size_14_c896, modinq_size_14_c897);

modinq_size_15_c944 := if(rv_i60_inq_retail_count12 < 0.980118, 15.375907, 9.207392);

modinq_size_15_c945 := if(nf_inq_count24 < 3.606843, 9.851656, 8.000000);

modinq_size_15_c943 := if(nf_inq_ssnsperaddr_recency < 2.763331, modinq_size_15_c944, modinq_size_15_c945);

modinq_size_15_c947 := if(rv_i60_inq_auto_recency < 93.967999, 9.207392, 9.000000);

modinq_size_15_c946 := if(nf_inq_utilities_count < 0.175639, modinq_size_15_c947, 7.000000);

modinq_size_15_c942 := if(nf_inq_adls_per_addr < 1.086427, modinq_size_15_c943, modinq_size_15_c946);

modinq_size_15_c950 := if(nf_inq_fname_ver_count < 10.445698, 11.023665, 8.000000);

modinq_size_15_c949 := if(nf_inq_ssns_per_sfd_addr < 0.977932, modinq_size_15_c950, 7.000000);

modinq_size_15_c948 := if(nf_inq_adlsperaddr_count_week < 0.675726, modinq_size_15_c949, 6.000000);

modinq_size_15_c941 := if(rv_i62_inq_fnamesperadl_recency < 0.721406, modinq_size_15_c942, modinq_size_15_c948);

modinq_size_15_c954 := if(rv_i62_inq_fnamesperadl_recency < 4.576931, 10.327020, 9.207392);

modinq_size_15_c955 := if(nf_inq_count < 3.868158, 10.327020, 11.296252);

modinq_size_15_c953 := if(nf_inq_count24 < 1.579444, modinq_size_15_c954, modinq_size_15_c955);

modinq_size_15_c957 := if(nf_inq_fname_ver_count < 3.660468, 8.000000, 8.000000);

modinq_size_15_c958 := if(nf_inq_addrs_per_ssn < 0.186946, 9.000000, 8.000000);

modinq_size_15_c956 := if(nf_inq_peraddr_recency < 0.830358, modinq_size_15_c957, modinq_size_15_c958);

modinq_size_15_c952 := if(rv_i62_inq_lnamesperadl_recency < 7.512770, modinq_size_15_c953, modinq_size_15_c956);

modinq_size_15_c961 := if(nf_inq_lname_ver_count < 5.939802, 8.000000, 8.000000);

modinq_size_15_c962 := if(rv_i60_inq_other_recency < 26.349976, 11.023665, 9.207392);

modinq_size_15_c960 := if(rv_i60_inq_peradl_recency < 11.988415, modinq_size_15_c961, modinq_size_15_c962);

modinq_size_15_c959 := if(nf_inq_adlsperaddr_count12 < 2.857115, modinq_size_15_c960, 6.000000);

modinq_size_15_c951 := if(rv_i62_inq_dobsperadl_recency < 8.614894, modinq_size_15_c952, modinq_size_15_c959);

modinq_size_15_c940 := if(rv_i62_inq_ssnsperadl_count12 < 0.096938, modinq_size_15_c941, modinq_size_15_c951);

modinq_size_15_c967 := if(nf_inq_addrsperssn_recency < 2.303952, 13.817534, 9.000000);

modinq_size_15_c968 := if(rv_i60_inq_prepaidcards_recency < 17.045603, 12.565879, 9.000000);

modinq_size_15_c966 := if(nf_inq_ssns_per_addr < 0.163577, modinq_size_15_c967, modinq_size_15_c968);

modinq_size_15_c970 := if(rv_i60_inq_retail_count12 < 1.434595, 13.143309, 8.000000);

modinq_size_15_c969 := if(nf_inq_perssn_count_week < 0.654099, modinq_size_15_c970, 7.000000);

modinq_size_15_c965 := if(rv_i62_inq_ssnsperadl_recency < 5.867689, modinq_size_15_c966, modinq_size_15_c969);

modinq_size_15_c973 := if(rv_i60_inq_banking_count12 < 0.536303, 13.143309, 9.851656);

modinq_size_15_c972 := if(rv_i60_inq_recency < 90.582692, modinq_size_15_c973, 7.000000);

modinq_size_15_c971 := if(nf_inq_prepaidcards_count < 1.252831, modinq_size_15_c972, 6.000000);

modinq_size_15_c964 := if(rv_i62_inq_dobsperadl_recency < 7.693336, modinq_size_15_c965, modinq_size_15_c971);

modinq_size_15_c977 := if(nf_inq_percurraddr_count12 < 1.904909, 11.535537, 8.000000);

modinq_size_15_c978 := if(nf_inq_adlsperssn_recency < 2.191388, 9.851656, 11.535537);

modinq_size_15_c976 := if(rv_i62_inq_lnamesperadl_recency < 2.491645, modinq_size_15_c977, modinq_size_15_c978);

modinq_size_15_c980 := if(rv_i60_inq_comm_recency < 11.236137, 8.000000, 8.000000);

modinq_size_15_c979 := if(rv_i62_inq_dobsperadl_recency < 10.715212, 7.000000, modinq_size_15_c980);

modinq_size_15_c975 := if(rv_i62_inq_phonesperadl_count12 < 1.678860, modinq_size_15_c976, modinq_size_15_c979);

modinq_size_15_c982 := if(nf_inq_count24 < 9.549273, 7.000000, 7.000000);

modinq_size_15_c983 := if(rv_i60_inq_auto_count12 < 4.544140, 7.000000, 7.000000);

modinq_size_15_c981 := if(rv_i62_inq_phones_per_adl < 1.969569, modinq_size_15_c982, modinq_size_15_c983);

modinq_size_15_c974 := if(nf_inq_count_week < 0.574307, modinq_size_15_c975, modinq_size_15_c981);

modinq_size_15_c963 := if(rv_i60_inq_banking_recency < 27.815270, modinq_size_15_c964, modinq_size_15_c974);

modinq_size_15_c939 := if(nf_inq_bestfname_ver_count < 8.823067, modinq_size_15_c940, modinq_size_15_c963);

modinq_size_15_c986 := if(nf_inq_auto_count < 4.260468, 5.000000, 5.000000);

modinq_size_15_c988 := if(rv_i60_inq_auto_recency < 5.776046, 6.000000, 6.000000);

modinq_size_15_c987 := if(nf_inq_lnamesperadl_count_day < 0.198762, modinq_size_15_c988, 5.000000);

modinq_size_15_c985 := if(nf_inq_adls_per_addr < 3.649890, modinq_size_15_c986, modinq_size_15_c987);

modinq_size_15_c984 := if(rv_i60_inq_peradl_count12 < 1.830951, 3.000000, modinq_size_15_c985);

modinq_size_15_c938 := if(nf_inq_ssns_per_sfd_addr < 3.154657, modinq_size_15_c939, modinq_size_15_c984);

modinq_size_15 := if(nf_inq_lnamesperssn_recency < -377009231.653427, 1.000000, modinq_size_15_c938);

modinq_size_16_c996 := if(nf_inq_lnamesperssn_count12 < 0.296732, 16.500001, 12.278091);

modinq_size_16_c997 := if(nf_inq_peraddr_count12 < 2.932693, 9.851656, 9.207392);

modinq_size_16_c995 := if(nf_inq_ssnsperaddr_recency < 3.354616, modinq_size_16_c996, modinq_size_16_c997);

modinq_size_16_c999 := if(nf_inq_adls_per_sfd_addr < 0.029438, 12.427187, 12.565879);

modinq_size_16_c998 := if(rv_i60_inq_auto_count12 < 15.135914, modinq_size_16_c999, 7.000000);

modinq_size_16_c994 := if(nf_inq_dobsperbestssn_count12 < 0.493497, modinq_size_16_c995, modinq_size_16_c998);

modinq_size_16_c1002 := if(nf_inq_ssns_per_addr < 2.289720, 12.278091, 8.000000);

modinq_size_16_c1001 := if(rv_i60_inq_banking_count12 < 1.105148, modinq_size_16_c1002, 7.000000);

modinq_size_16_c1003 := if(nf_inq_addrsperssn_recency < 4.234680, 7.000000, 7.000000);

modinq_size_16_c1000 := if(nf_inq_communications_count < 4.893265, modinq_size_16_c1001, modinq_size_16_c1003);

modinq_size_16_c993 := if(rv_i62_inq_addrsperadl_recency < 10.341760, modinq_size_16_c994, modinq_size_16_c1000);

modinq_size_16_c1007 := if(rv_i62_inq_phonesperadl_recency < 6.173994, 13.241134, 9.000000);

modinq_size_16_c1008 := if(nf_invbest_inq_peraddr_diff < 2.144055, 12.278091, 8.000000);

modinq_size_16_c1006 := if(rv_i62_inq_lnamesperadl_recency < 8.028948, modinq_size_16_c1007, modinq_size_16_c1008);

modinq_size_16_c1005 := if(nf_inquiry_adl_vel_risk_index < 5.023517, modinq_size_16_c1006, 6.000000);

modinq_size_16_c1004 := if(nf_inq_adlsperssn_count_day < 0.486426, modinq_size_16_c1005, 5.000000);

modinq_size_16_c992 := if(nf_inq_lnamesperaddr_recency < 8.798554, modinq_size_16_c993, modinq_size_16_c1004);

modinq_size_16_c1013 := if(rv_i62_inq_phones_per_adl < 0.043540, 11.023665, 9.851656);

modinq_size_16_c1014 := if(rv_i62_inq_phones_per_adl < 0.021260, 10.706640, 11.748880);

modinq_size_16_c1012 := if(rv_i62_inq_lnamesperadl_recency < 1.727796, modinq_size_16_c1013, modinq_size_16_c1014);

modinq_size_16_c1011 := if(nf_inq_other_count < 5.867813, modinq_size_16_c1012, 6.000000);

modinq_size_16_c1016 := if(nf_inq_quizprovider_count < 0.652305, 7.000000, 7.000000);

modinq_size_16_c1015 := if(rv_i60_inq_banking_count12 < 0.825456, modinq_size_16_c1016, 6.000000);

modinq_size_16_c1010 := if(nf_inq_addrsperssn_count_day < 0.841483, modinq_size_16_c1011, modinq_size_16_c1015);

modinq_size_16_c1009 := if(rv_i62_inq_ssns_per_adl < 5.567716, modinq_size_16_c1010, 4.000000);

modinq_size_16_c991 := if(nf_inq_lnames_per_addr < 1.128505, modinq_size_16_c992, modinq_size_16_c1009);

modinq_size_16_c1022 := if(nf_inq_retail_count < 2.289593, 9.000000, 8.000000);

modinq_size_16_c1023 := if(nf_inq_ssnspercurraddr_count12 < 2.652744, 8.000000, 8.000000);

modinq_size_16_c1021 := if(nf_inq_lnamesperaddr_count12 < 3.235423, modinq_size_16_c1022, modinq_size_16_c1023);

modinq_size_16_c1024 := if(rv_i62_inq_addrs_per_adl < 1.881022, 7.000000, 7.000000);

modinq_size_16_c1020 := if(nf_inq_lnamesperssn_recency < 1.987163, modinq_size_16_c1021, modinq_size_16_c1024);

modinq_size_16_c1019 := if(nf_inq_dob_ver_count < 53.817254, modinq_size_16_c1020, 5.000000);

modinq_size_16_c1018 := if(nf_inq_other_count < 23.800116, modinq_size_16_c1019, 4.000000);

modinq_size_16_c1017 := if(nf_inq_peradl_count_day < 0.405556, modinq_size_16_c1018, 3.000000);

modinq_size_16_c990 := if(nf_inq_lnamesperaddr_count12 < 2.759700, modinq_size_16_c991, modinq_size_16_c1017);

modinq_size_16 := if(nf_inq_quizprovider_count24 < -549215980.599220, 1.000000, modinq_size_16_c990);

modinq_size_17_c1026 := if(nf_inq_lnames_per_ssn < 0.975680, 2.000000, 2.000000);

modinq_size_17_c1033 := if(nf_inq_lnamespercurraddr_count12 < 0.492741, 16.500001, 15.017693);

modinq_size_17_c1034 := if(rv_i62_inq_lnamesperadl_recency < 4.003755, 10.706640, 11.023665);

modinq_size_17_c1032 := if(nf_inq_lnamesperaddr_recency < 4.404930, modinq_size_17_c1033, modinq_size_17_c1034);

modinq_size_17_c1036 := if(nf_inq_banking_count24 < 0.803271, 10.327020, 9.000000);

modinq_size_17_c1037 := if(rv_i60_inq_prepaidcards_recency < 4.708405, 10.327020, 9.000000);

modinq_size_17_c1035 := if(nf_inq_lnames_per_ssn < 0.292850, modinq_size_17_c1036, modinq_size_17_c1037);

modinq_size_17_c1031 := if(rv_i60_inq_comm_recency < 97.464068, modinq_size_17_c1032, modinq_size_17_c1035);

modinq_size_17_c1040 := if(nf_inq_percurraddr_count12 < 20.048559, 15.204812, 8.000000);

modinq_size_17_c1039 := if(nf_inq_utilities_count < 0.306252, modinq_size_17_c1040, 7.000000);

modinq_size_17_c1041 := if(rv_i62_inq_ssns_per_adl < 0.039987, 7.000000, 7.000000);

modinq_size_17_c1038 := if(nf_inq_retail_count < 3.150663, modinq_size_17_c1039, modinq_size_17_c1041);

modinq_size_17_c1030 := if(nf_inq_ssnsperaddr_recency < 4.032617, modinq_size_17_c1031, modinq_size_17_c1038);

modinq_size_17_c1029 := if(nf_inq_collection_count24 < 5.336303, modinq_size_17_c1030, 4.000000);

modinq_size_17_c1043 := if(nf_inq_auto_count24 < 1.880056, 5.000000, 5.000000);

modinq_size_17_c1046 := if(nf_inq_lnames_per_sfd_addr < 0.224485, 7.000000, 7.000000);

modinq_size_17_c1045 := if(nf_inq_ssnsperaddr_count12 < 1.315287, 6.000000, modinq_size_17_c1046);

modinq_size_17_c1047 := if(nf_inq_addrsperadl_count_week < 1.827696, 6.000000, 6.000000);

modinq_size_17_c1044 := if(nf_inq_other_count < 2.305897, modinq_size_17_c1045, modinq_size_17_c1047);

modinq_size_17_c1042 := if(nf_inq_ssns_per_addr < 0.490593, modinq_size_17_c1043, modinq_size_17_c1044);

modinq_size_17_c1028 := if(nf_inq_adlsperaddr_count_week < 0.666380, modinq_size_17_c1029, modinq_size_17_c1042);

modinq_size_17_c1027 := if(nf_inq_lnamesperaddr_count_day < 0.822719, modinq_size_17_c1028, 2.000000);

//modinq_size_17 := if(nf_inq_adlsperemail_count12 < -9624272034.472414, modinq_size_17_c1026, modinq_size_17_c1027);
modinq_size_17 := if(nf_inq_adlsperemail_count12 < -999999998, modinq_size_17_c1026, modinq_size_17_c1027);

modinq_size_18_c1055 := if(nf_inq_perssn_recency < 4.213512, 16.842743, 13.590539);

modinq_size_18_c1054 := if(nf_inq_count_day < 0.221341, modinq_size_18_c1055, 7.000000);

modinq_size_18_c1056 := if(nf_inq_peraddr_count_week < 1.354746, 7.000000, 7.000000);

modinq_size_18_c1053 := if(nf_inq_peraddr_count_day < 0.723500, modinq_size_18_c1054, modinq_size_18_c1056);

modinq_size_18_c1059 := if(nf_inq_adlspercurraddr_count12 < 0.462062, 8.000000, 8.000000);

modinq_size_18_c1058 := if(nf_inq_communications_count24 < 0.108524, modinq_size_18_c1059, 7.000000);

modinq_size_18_c1060 := if(nf_inq_curraddr_ver_count < 4.641434, 7.000000, 7.000000);

modinq_size_18_c1057 := if(nf_inq_lnamesperaddr_recency < 0.925459, modinq_size_18_c1058, modinq_size_18_c1060);

modinq_size_18_c1052 := if(nf_inq_addrsperssn_recency < 9.966852, modinq_size_18_c1053, modinq_size_18_c1057);

modinq_size_18_c1061 := if(nf_inq_fname_ver_count < 18.231928, 5.000000, 5.000000);

modinq_size_18_c1051 := if(nf_inq_communications_count < 5.412208, modinq_size_18_c1052, modinq_size_18_c1061);

modinq_size_18_c1065 := if(nf_inq_dob_ver_count < 2.535004, 7.000000, 7.000000);

modinq_size_18_c1064 := if(rv_i62_inq_dobs_per_adl < 0.128318, modinq_size_18_c1065, 6.000000);

modinq_size_18_c1063 := if(nf_inq_ssnsperaddr_recency < 0.080098, modinq_size_18_c1064, 5.000000);

modinq_size_18_c1062 := if(rv_i60_credit_seeking < 3.279902, modinq_size_18_c1063, 4.000000);

modinq_size_18_c1050 := if(nf_inq_perssn_count12 < 6.777515, modinq_size_18_c1051, modinq_size_18_c1062);

modinq_size_18_c1071 := if(nf_inq_banking_count24 < 2.106103, 15.132052, 8.000000);

modinq_size_18_c1072 := if(nf_inq_ssns_per_apt_addr < 0.191413, 9.000000, 8.000000);

modinq_size_18_c1070 := if(rv_i60_inq_comm_recency < 36.324107, modinq_size_18_c1071, modinq_size_18_c1072);

modinq_size_18_c1074 := if(rv_i60_inq_other_recency < 13.171225, 8.000000, 8.000000);

modinq_size_18_c1075 := if(rv_i60_inq_peradl_count12 < 1.842981, 9.000000, 9.207392);

modinq_size_18_c1073 := if(rv_i60_inq_peradl_count12 < 0.640042, modinq_size_18_c1074, modinq_size_18_c1075);

modinq_size_18_c1069 := if(nf_invbest_inq_lastperaddr_diff < -0.702308, modinq_size_18_c1070, modinq_size_18_c1073);

modinq_size_18_c1078 := if(nf_inq_dobsperbestssn_count12 < 0.783342, 8.000000, 8.000000);

modinq_size_18_c1079 := if(nf_inq_bestlname_ver_count < 13.650064, 8.000000, 8.000000);

modinq_size_18_c1077 := if(rv_i62_inq_addrs_per_adl < 2.236799, modinq_size_18_c1078, modinq_size_18_c1079);

modinq_size_18_c1080 := if(rv_i60_inq_auto_count12 < 4.387046, 7.000000, 7.000000);

modinq_size_18_c1076 := if(nf_inq_collection_count < 4.836870, modinq_size_18_c1077, modinq_size_18_c1080);

modinq_size_18_c1068 := if(rv_i60_inq_peradl_count12 < 6.757254, modinq_size_18_c1069, modinq_size_18_c1076);

modinq_size_18_c1084 := if(nf_inq_communications_count < 0.323056, 9.207392, 8.000000);

modinq_size_18_c1083 := if(nf_inq_lnamesperaddr_recency < 11.561098, 7.000000, modinq_size_18_c1084);

modinq_size_18_c1086 := if(rv_i60_inq_peradl_count12 < 3.720185, 8.000000, 8.000000);

modinq_size_18_c1087 := if(nf_inq_bestssn_ver_count < 8.541082, 9.000000, 8.000000);

modinq_size_18_c1085 := if(rv_i62_inq_dobsperadl_count12 < 0.496133, modinq_size_18_c1086, modinq_size_18_c1087);

modinq_size_18_c1082 := if(rv_i62_inq_addrsperadl_count12 < 0.266904, modinq_size_18_c1083, modinq_size_18_c1085);

modinq_size_18_c1089 := if(nf_inq_count < 8.832537, 7.000000, 7.000000);

modinq_size_18_c1088 := if(nf_inq_curraddr_ver_count < 6.846826, modinq_size_18_c1089, 6.000000);

modinq_size_18_c1081 := if(nf_inq_dobsperbestssn_count12 < 0.360071, modinq_size_18_c1082, modinq_size_18_c1088);

modinq_size_18_c1067 := if(rv_i60_inq_mortgage_recency < 42.080134, modinq_size_18_c1068, modinq_size_18_c1081);

modinq_size_18_c1092 := if(rv_i60_inq_retail_recency < 0.344187, 6.000000, 6.000000);

modinq_size_18_c1091 := if(nf_inq_lnamesperssn_recency < 2.766410, 5.000000, modinq_size_18_c1092);

modinq_size_18_c1090 := if(nf_inq_fname_ver_count < 14.085755, 4.000000, modinq_size_18_c1091);

modinq_size_18_c1066 := if(nf_inq_peraddr_count_week < 0.024931, modinq_size_18_c1067, modinq_size_18_c1090);

modinq_size_18_c1049 := if(nf_inq_lnamesperaddr_recency < 3.407523, modinq_size_18_c1050, modinq_size_18_c1066);

//modinq_size_18 := if(nf_inq_ssnsperadl_count_week < -9135351552.559303, 1.000000, modinq_size_18_c1049);
modinq_size_18 := if(nf_inq_ssnsperadl_count_week < -999999998, 1.000000, modinq_size_18_c1049);

modinq_size_19_c1100 := if(rv_i60_inq_auto_count12 < 0.587569, 16.695728, 10.327020);

modinq_size_19_c1101 := if(rv_i62_inq_dobs_per_adl < 1.239512, 15.707569, 9.851656);

modinq_size_19_c1099 := if(rv_i62_inq_ssnsperadl_recency < 0.556719, modinq_size_19_c1100, modinq_size_19_c1101);

//modinq_size_19_c1098 := if(nf_invbest_inq_adlsperaddr_diff < -2809764632.592091, 6.000000, modinq_size_19_c1099);
modinq_size_19_c1098 := if(nf_invbest_inq_adlsperaddr_diff < -999999998, 6.000000, modinq_size_19_c1099);

modinq_size_19_c1104 := if(nf_inq_adlsperaddr_count_week < 0.129577, 9.851656, 8.000000);

modinq_size_19_c1103 := if(nf_inq_per_sfd_addr < 8.154570, modinq_size_19_c1104, 7.000000);

modinq_size_19_c1102 := if(nf_inq_addrsperssn_count12 < 4.140663, modinq_size_19_c1103, 6.000000);

modinq_size_19_c1097 := if(nf_inq_dobsperssn_count12 < 1.601762, modinq_size_19_c1098, modinq_size_19_c1102);

modinq_size_19_c1108 := if(nf_inq_per_ssn < 3.813641, 13.669106, 10.706640);

modinq_size_19_c1109 := if(nf_inquiry_ssn_vel_risk_indexv2 < 0.419355, 8.000000, 8.000000);

modinq_size_19_c1107 := if(nf_inq_addrsperadl_count_week < 0.844359, modinq_size_19_c1108, modinq_size_19_c1109);

modinq_size_19_c1110 := if(rv_i60_inq_peradl_recency < 9.507502, 7.000000, 7.000000);

modinq_size_19_c1106 := if(nf_invbest_inq_lastperaddr_diff < 0.047382, modinq_size_19_c1107, modinq_size_19_c1110);

modinq_size_19_c1113 := if(rv_i62_inq_fnamesperadl_count12 < 0.464051, 9.000000, 8.000000);

modinq_size_19_c1114 := if(rv_i60_inq_banking_count12 < 1.848527, 9.000000, 8.000000);

modinq_size_19_c1112 := if(nf_inq_ssnspercurraddr_count12 < 1.950394, modinq_size_19_c1113, modinq_size_19_c1114);

modinq_size_19_c1116 := if(rv_i60_inq_auto_recency < 13.417252, 9.000000, 8.000000);

modinq_size_19_c1115 := if(rv_i60_inq_retail_recency < 15.415915, modinq_size_19_c1116, 7.000000);

modinq_size_19_c1111 := if(rv_i62_inq_lnamesperadl_count12 < 1.765940, modinq_size_19_c1112, modinq_size_19_c1115);

modinq_size_19_c1105 := if(nf_inq_lnamesperaddr_count12 < 1.287746, modinq_size_19_c1106, modinq_size_19_c1111);

modinq_size_19_c1096 := if(nf_inq_adlsperaddr_recency < 7.629815, modinq_size_19_c1097, modinq_size_19_c1105);

modinq_size_19_c1095 := if(nf_inq_auto_count24 < 16.380802, modinq_size_19_c1096, 3.000000);

modinq_size_19_c1094 := if(nf_inq_auto_count24 < 24.856599, modinq_size_19_c1095, 2.000000);

//modinq_size_19 := if(nf_inq_phonesperadl_count_day < -94942544.983940, 1.000000, modinq_size_19_c1094);
modinq_size_19 := if(nf_inq_phonesperadl_count_day < -999999998, 1.000000, modinq_size_19_c1094);

modinq_size_20_c1124 := if(nf_inq_bestlname_ver_count < 15.891125, 16.131577, 13.744698);

modinq_size_20_c1123 := if(nf_inq_addrs_per_ssn < 2.839345, modinq_size_20_c1124, 7.000000);

modinq_size_20_c1125 := if(nf_inq_adlsperbestphone_count12 < 0.053733, 7.000000, 7.000000);

modinq_size_20_c1122 := if(nf_inq_per_ssn < 19.008087, modinq_size_20_c1123, modinq_size_20_c1125);

modinq_size_20_c1121 := if(nf_inq_collection_count24 < 5.324340, modinq_size_20_c1122, 5.000000);

modinq_size_20_c1120 := if(nf_inq_lnamesperadl_count_week < 0.574727, modinq_size_20_c1121, 4.000000);

modinq_size_20_c1130 := if(nf_inq_adlsperssn_recency < 0.015762, 15.094655, 10.327020);

modinq_size_20_c1131 := if(nf_inq_banking_count < 0.008468, 10.706640, 8.000000);

modinq_size_20_c1129 := if(nf_inq_lnamesperaddr_count12 < 1.262103, modinq_size_20_c1130, modinq_size_20_c1131);

modinq_size_20_c1133 := if(nf_inq_lnamesperssn_recency < 6.462735, 8.000000, 9.851656);

modinq_size_20_c1132 := if(nf_inq_ssnsperaddr_count12 < 1.853802, modinq_size_20_c1133, 7.000000);

modinq_size_20_c1128 := if(nf_inq_adlsperssn_recency < 5.119610, modinq_size_20_c1129, modinq_size_20_c1132);

modinq_size_20_c1136 := if(rv_i62_inq_dobs_per_adl < 1.627433, 14.978072, 11.535537);

modinq_size_20_c1135 := if(nf_inq_highriskcredit_count < 39.201804, modinq_size_20_c1136, 7.000000);

modinq_size_20_c1134 := if(nf_inq_banking_count_week < 1.430636, modinq_size_20_c1135, 6.000000);

modinq_size_20_c1127 := if(rv_i62_inq_dobsperadl_count12 < 0.688506, modinq_size_20_c1128, modinq_size_20_c1134);

modinq_size_20_c1126 := if(nf_inq_lnamesperaddr_count_week < 1.529466, modinq_size_20_c1127, 4.000000);

modinq_size_20_c1119 := if(nf_inq_per_sfd_addr < 0.977992, modinq_size_20_c1120, modinq_size_20_c1126);

modinq_size_20_c1118 := if(nf_inq_lnamesperadl_count_day < 0.821882, modinq_size_20_c1119, 2.000000);

modinq_size_20 := if(nf_inq_dobsperssn_count12 < 2.753359, modinq_size_20_c1118, 1.000000);

modinq_size_21_c1144 := if(rv_i62_inq_dobsperadl_count12 < 0.979321, 14.722286, 12.278091);

modinq_size_21_c1145 := if(nf_inq_percurraddr_count12 < 0.228206, 8.000000, 8.000000);

modinq_size_21_c1143 := if(nf_inq_ssnsperadl_count_day < 0.749735, modinq_size_21_c1144, modinq_size_21_c1145);

modinq_size_21_c1147 := if(rv_i62_inq_lnamesperadl_count12 < 1.552831, 10.706640, 8.000000);

modinq_size_21_c1146 := if(nf_inq_utilities_count24 < 0.681086, modinq_size_21_c1147, 7.000000);

modinq_size_21_c1142 := if(nf_inq_perssn_count12 < 3.366013, modinq_size_21_c1143, modinq_size_21_c1146);

modinq_size_21_c1150 := if(nf_inq_adls_per_sfd_addr < 0.387405, 9.000000, 9.000000);

modinq_size_21_c1149 := if(nf_inq_addrsperadl_count_week < 0.224747, modinq_size_21_c1150, 7.000000);

modinq_size_21_c1148 := if(nf_inq_lname_ver_count < 15.135275, modinq_size_21_c1149, 6.000000);

modinq_size_21_c1141 := if(rv_i61_inq_collection_count12 < 1.426039, modinq_size_21_c1142, modinq_size_21_c1148);

modinq_size_21_c1154 := if(rv_i60_inq_retpymt_count12 < 0.471744, 17.162279, 8.000000);

modinq_size_21_c1155 := if(rv_i62_inq_addrs_per_adl < 1.747383, 8.000000, 9.000000);

modinq_size_21_c1153 := if(nf_inq_other_count_week < 0.514457, modinq_size_21_c1154, modinq_size_21_c1155);

modinq_size_21_c1152 := if(nf_inq_adlsperaddr_count_day < 0.976000, modinq_size_21_c1153, 6.000000);

modinq_size_21_c1151 := if(nf_inq_dobsperssn_count_day < 0.018798, modinq_size_21_c1152, 5.000000);

modinq_size_21_c1140 := if(nf_inq_bestphone_ver_count < 139.869947, modinq_size_21_c1141, modinq_size_21_c1151);

modinq_size_21_c1139 := if(rv_i60_inq_count12 < 16.781116, modinq_size_21_c1140, 3.000000);

modinq_size_21_c1161 := if(nf_inq_banking_count24 < 0.460117, 10.706640, 9.851656);

modinq_size_21_c1162 := if(nf_inq_dobsperssn_recency < 9.593080, 10.327020, 8.000000);

modinq_size_21_c1160 := if(nf_inq_percurraddr_count12 < 6.107704, modinq_size_21_c1161, modinq_size_21_c1162);

modinq_size_21_c1159 := if(nf_inq_ssns_per_apt_addr < -0.512068, modinq_size_21_c1160, 6.000000);

modinq_size_21_c1165 := if(nf_inq_auto_count24 < 19.352308, 8.000000, 8.000000);

modinq_size_21_c1164 := if(nf_inq_collection_count < 2.597457, 7.000000, modinq_size_21_c1165);

modinq_size_21_c1166 := if(nf_inq_per_ssn < 12.346101, 7.000000, 7.000000);

modinq_size_21_c1163 := if(nf_inq_other_count < 5.844490, modinq_size_21_c1164, modinq_size_21_c1166);

modinq_size_21_c1158 := if(nf_inquiry_adl_vel_risk_index < 1.894682, modinq_size_21_c1159, modinq_size_21_c1163);

modinq_size_21_c1168 := if(nf_inq_lnamesperaddr_count12 < 2.756150, 6.000000, 6.000000);

modinq_size_21_c1167 := if(nf_inq_auto_count24 < 2.585094, modinq_size_21_c1168, 5.000000);

modinq_size_21_c1157 := if(nf_inq_addrsperadl_count_week < 0.908879, modinq_size_21_c1158, modinq_size_21_c1167);

modinq_size_21_c1156 := if(nf_inquiry_verification_index < 28.074204, 3.000000, modinq_size_21_c1157);

modinq_size_21_c1138 := if(nf_inquiry_addr_vel_risk_indexv2 < 1.936978, modinq_size_21_c1139, modinq_size_21_c1156);

//modinq_size_21 := if(nf_inq_emailsperadl_count12 < -1967366178.451346, 1.000000, modinq_size_21_c1138);
modinq_size_21 := if(nf_inq_emailsperadl_count12 < -999999998, 1.000000, modinq_size_21_c1138);

modinq_size_22_c1170 := if(nf_inq_per_sfd_addr < 0.234026, 2.000000, 2.000000);

modinq_size_22_c1177 := if(nf_inq_peraddr_count_day < 1.782802, 16.555309, 8.000000);

modinq_size_22_c1178 := if(nf_inq_per_sfd_addr < 0.219784, 8.000000, 9.851656);

modinq_size_22_c1176 := if(rv_i60_inq_retail_count12 < 0.071359, modinq_size_22_c1177, modinq_size_22_c1178);

modinq_size_22_c1179 := if(rv_i60_inq_auto_recency < 80.753190, 7.000000, 7.000000);

modinq_size_22_c1175 := if(nf_inq_communications_count < 1.862062, modinq_size_22_c1176, modinq_size_22_c1179);

modinq_size_22_c1182 := if(rv_i62_inq_ssnsperadl_recency < 9.708530, 15.440446, 10.327020);

modinq_size_22_c1181 := if(nf_inq_per_ssn < 17.123537, modinq_size_22_c1182, 7.000000);

modinq_size_22_c1183 := if(nf_inq_lnamesperaddr_recency < 2.041220, 7.000000, 7.000000);

modinq_size_22_c1180 := if(nf_inquiry_addr_vel_risk_indexv2 < 0.862325, modinq_size_22_c1181, modinq_size_22_c1183);

modinq_size_22_c1174 := if(rv_i60_inq_other_recency < 17.452901, modinq_size_22_c1175, modinq_size_22_c1180);

modinq_size_22_c1187 := if(nf_inq_adls_per_ssn < 0.017767, 10.327020, 8.000000);

modinq_size_22_c1188 := if(rv_i62_inq_addrs_per_adl < 1.503564, 9.851656, 8.000000);

modinq_size_22_c1186 := if(nf_inq_lnamesperssn_recency < 4.459456, modinq_size_22_c1187, modinq_size_22_c1188);

modinq_size_22_c1189 := if(nf_inq_bestfname_ver_count < 14.129520, 7.000000, 7.000000);

modinq_size_22_c1185 := if(rv_i60_inq_auto_recency < 78.900408, modinq_size_22_c1186, modinq_size_22_c1189);

modinq_size_22_c1190 := if(nf_inq_dob_ver_count < 8.214143, 6.000000, 6.000000);

modinq_size_22_c1184 := if(nf_inq_lnames_per_addr < 1.870475, modinq_size_22_c1185, modinq_size_22_c1190);

modinq_size_22_c1173 := if(rv_i60_inq_hiriskcred_recency < 85.391695, modinq_size_22_c1174, modinq_size_22_c1184);

modinq_size_22_c1195 := if(nf_inq_mortgage_count < 0.348706, 11.296252, 9.000000);

modinq_size_22_c1196 := if(nf_inq_bestlname_ver_count < 7.912697, 8.000000, 8.000000);

modinq_size_22_c1194 := if(nf_inq_perssn_count12 < 0.424511, modinq_size_22_c1195, modinq_size_22_c1196);

modinq_size_22_c1198 := if(nf_inq_count24 < 19.098124, 8.000000, 8.000000);

modinq_size_22_c1197 := if(nf_inq_dobsperssn_count_day < 0.593737, modinq_size_22_c1198, 7.000000);

modinq_size_22_c1193 := if(nf_inq_ssnsperaddr_count12 < 1.515782, modinq_size_22_c1194, modinq_size_22_c1197);

modinq_size_22_c1192 := if(nf_inq_lnames_per_apt_addr < -0.675691, modinq_size_22_c1193, 5.000000);

modinq_size_22_c1202 := if(nf_inq_ssnsperaddr_count_week < 0.584909, 12.278091, 8.000000);

modinq_size_22_c1201 := if(nf_inq_perbestssn_count12 < 7.213107, modinq_size_22_c1202, 7.000000);

modinq_size_22_c1203 := if(nf_invbest_inq_peraddr_diff < -0.759122, 7.000000, 7.000000);

modinq_size_22_c1200 := if(nf_inq_retail_count24 < 0.223730, modinq_size_22_c1201, modinq_size_22_c1203);

modinq_size_22_c1199 := if(nf_inq_retail_count < 3.960674, modinq_size_22_c1200, 5.000000);

modinq_size_22_c1191 := if(nf_inq_dobsperbestssn_count12 < 0.280743, modinq_size_22_c1192, modinq_size_22_c1199);

modinq_size_22_c1172 := if(rv_i60_inq_comm_recency < 4.344280, modinq_size_22_c1173, modinq_size_22_c1191);

modinq_size_22_c1205 := if(rv_i62_inq_fnamesperadl_recency < 5.555027, 4.000000, 4.000000);

modinq_size_22_c1210 := if(nf_inq_highriskcredit_count < 6.654623, 8.000000, 8.000000);

modinq_size_22_c1209 := if(nf_inq_adlsperaddr_recency < 1.771574, 7.000000, modinq_size_22_c1210);

modinq_size_22_c1208 := if(nf_inq_peraddr_count12 < 3.809940, 6.000000, modinq_size_22_c1209);

modinq_size_22_c1213 := if(nf_inq_addrsperbestssn_count12 < 0.753465, 8.000000, 8.000000);

modinq_size_22_c1214 := if(nf_inq_per_ssn < 1.259712, 8.000000, 8.000000);

modinq_size_22_c1212 := if(nf_inq_addrsperssn_recency < 1.775918, modinq_size_22_c1213, modinq_size_22_c1214);

modinq_size_22_c1211 := if(nf_inq_bestfname_ver_count < 11.288645, modinq_size_22_c1212, 6.000000);

modinq_size_22_c1207 := if(nf_inq_lnamesperbestssn_count12 < 0.885246, modinq_size_22_c1208, modinq_size_22_c1211);

modinq_size_22_c1217 := if(nf_inq_lnamesperaddr_count12 < 1.662019, 7.000000, 7.000000);

modinq_size_22_c1216 := if(nf_inq_dob_ver_count < 2.709380, 6.000000, modinq_size_22_c1217);

modinq_size_22_c1218 := if(rv_i60_inq_hiriskcred_recency < 26.290157, 6.000000, 6.000000);

modinq_size_22_c1215 := if(rv_i60_inq_peradl_recency < 4.825553, modinq_size_22_c1216, modinq_size_22_c1218);

modinq_size_22_c1206 := if(rv_i60_inq_peradl_count12 < 1.182120, modinq_size_22_c1207, modinq_size_22_c1215);

modinq_size_22_c1204 := if(nf_invbest_inq_peraddr_diff < 0.103411, modinq_size_22_c1205, modinq_size_22_c1206);

modinq_size_22_c1171 := if(nf_invbest_inq_ssnsperaddr_diff < 0.322810, modinq_size_22_c1172, modinq_size_22_c1204);

//modinq_size_22 := if(rv_i60_inq_retpymt_count12 < -1122142696.262342, modinq_size_22_c1170, modinq_size_22_c1171);
modinq_size_22 := if(rv_i60_inq_retpymt_count12 < -999999998, modinq_size_22_c1170, modinq_size_22_c1171);

modinq_size_23_c1226 := if(nf_inq_bestlname_ver_count < 250.518031, 15.502967, 10.706640);

modinq_size_23_c1225 := if(nf_inq_auto_count24 < 5.744548, modinq_size_23_c1226, 7.000000);

modinq_size_23_c1227 := if(nf_inq_perssn_count12 < 0.492807, 7.000000, 7.000000);

modinq_size_23_c1224 := if(nf_inq_communications_count < 0.831754, modinq_size_23_c1225, modinq_size_23_c1227);

modinq_size_23_c1230 := if(rv_i60_inq_recency < 2.004094, 8.000000, 8.000000);

modinq_size_23_c1229 := if(rv_i60_inq_count12 < 1.052792, modinq_size_23_c1230, 7.000000);

modinq_size_23_c1231 := if(nf_inq_addr_ver_count < 18.333070, 7.000000, 7.000000);

modinq_size_23_c1228 := if(rv_i62_inq_fnamesperadl_recency < 8.714432, modinq_size_23_c1229, modinq_size_23_c1231);

modinq_size_23_c1223 := if(nf_inq_lnamesperbestssn_count12 < 0.761014, modinq_size_23_c1224, modinq_size_23_c1228);

modinq_size_23_c1235 := if(nf_inq_fname_ver_count < 8.540096, 8.000000, 9.000000);

modinq_size_23_c1234 := if(nf_inq_adls_per_apt_addr < -0.244565, modinq_size_23_c1235, 7.000000);

modinq_size_23_c1236 := if(rv_i60_inq_mortgage_recency < 39.612825, 7.000000, 7.000000);

modinq_size_23_c1233 := if(nf_inq_dobsperbestssn_count12 < 0.194512, modinq_size_23_c1234, modinq_size_23_c1236);

modinq_size_23_c1232 := if(nf_inq_retail_count < 2.890370, modinq_size_23_c1233, 5.000000);

modinq_size_23_c1222 := if(nf_inq_perssn_recency < 11.552750, modinq_size_23_c1223, modinq_size_23_c1232);

modinq_size_23_c1241 := if(nf_inq_banking_count < 1.037251, 9.851656, 9.000000);

modinq_size_23_c1242 := if(rv_i60_inq_other_recency < 35.116601, 13.590539, 10.327020);

modinq_size_23_c1240 := if(nf_inq_adlspercurraddr_count12 < 0.833582, modinq_size_23_c1241, modinq_size_23_c1242);

modinq_size_23_c1239 := if(rv_i62_inq_fnamesperadl_recency < 1.594432, modinq_size_23_c1240, 6.000000);

modinq_size_23_c1245 := if(nf_invbest_inq_dobsperssn_diff < -0.198589, 8.000000, 8.000000);

modinq_size_23_c1244 := if(rv_i62_inq_num_names_per_adl < 0.457540, 7.000000, modinq_size_23_c1245);

modinq_size_23_c1243 := if(nf_inq_count < 6.326400, 6.000000, modinq_size_23_c1244);

modinq_size_23_c1238 := if(nf_inq_lnamesperbestssn_count12 < 0.204859, modinq_size_23_c1239, modinq_size_23_c1243);

modinq_size_23_c1249 := if(nf_inq_lnames_per_addr < 1.537773, 8.000000, 8.000000);

modinq_size_23_c1250 := if(rv_i61_inq_collection_recency < 49.045090, 8.000000, 8.000000);

modinq_size_23_c1248 := if(nf_inq_lnamesperaddr_recency < 6.856998, modinq_size_23_c1249, modinq_size_23_c1250);

modinq_size_23_c1247 := if(nf_inq_count24 < 0.487968, modinq_size_23_c1248, 6.000000);

modinq_size_23_c1246 := if(rv_i60_inq_other_recency < 72.759456, modinq_size_23_c1247, 5.000000);

modinq_size_23_c1237 := if(nf_invbest_inq_lastperaddr_diff < 0.247343, modinq_size_23_c1238, modinq_size_23_c1246);

modinq_size_23_c1221 := if(nf_inq_peraddr_recency < 0.820972, modinq_size_23_c1222, modinq_size_23_c1237);

modinq_size_23_c1256 := if(nf_inq_mortgage_count < 0.824677, 10.706640, 8.000000);

modinq_size_23_c1255 := if(nf_inq_percurraddr_count12 < 0.863694, 7.000000, modinq_size_23_c1256);

modinq_size_23_c1254 := if(rv_i60_inq_retpymt_count12 < 0.698059, modinq_size_23_c1255, 6.000000);

modinq_size_23_c1257 := if(nf_inq_perssn_count12 < 0.629240, 6.000000, 6.000000);

modinq_size_23_c1253 := if(rv_i60_inq_banking_recency < 80.801899, modinq_size_23_c1254, modinq_size_23_c1257);

modinq_size_23_c1258 := if(nf_inq_count_week < 0.468825, 5.000000, 5.000000);

modinq_size_23_c1252 := if(rv_i60_inq_comm_recency < 72.832407, modinq_size_23_c1253, modinq_size_23_c1258);

modinq_size_23_c1259 := if(nf_inq_adls_per_apt_addr < -0.788389, 4.000000, 4.000000);

modinq_size_23_c1251 := if(rv_i62_inq_ssnsperadl_count12 < 0.944080, modinq_size_23_c1252, modinq_size_23_c1259);

modinq_size_23_c1220 := if(rv_i62_inq_addrs_per_adl < 0.355961, modinq_size_23_c1221, modinq_size_23_c1251);

modinq_size_23_c1266 := if(nf_inq_retailpayments_count24 < 0.082246, 12.427187, 8.000000);

modinq_size_23_c1265 := if(nf_inq_auto_count24 < 2.349343, modinq_size_23_c1266, 7.000000);

modinq_size_23_c1264 := if(rv_i60_inq_comm_count12 < 1.099992, modinq_size_23_c1265, 6.000000);

modinq_size_23_c1263 := if(rv_i62_inq_dobsperadl_count12 < 1.647482, modinq_size_23_c1264, 5.000000);

modinq_size_23_c1262 := if(nf_invbest_inq_ssnsperaddr_diff < 0.286532, modinq_size_23_c1263, 4.000000);

modinq_size_23_c1261 := if(nf_invbest_inq_peraddr_diff < 8.460766, modinq_size_23_c1262, 3.000000);

modinq_size_23_c1272 := if(rv_i62_inq_dobsperadl_recency < 6.371353, 14.084906, 14.428899);

modinq_size_23_c1273 := if(rv_i61_inq_collection_recency < 93.070895, 8.000000, 9.000000);

modinq_size_23_c1271 := if(nf_inq_prepaidcards_count < 0.645323, modinq_size_23_c1272, modinq_size_23_c1273);

modinq_size_23_c1274 := if(nf_inq_addrsperadl_count_week < 1.515388, 7.000000, 7.000000);

modinq_size_23_c1270 := if(nf_inq_lnamesperssn_count_week < 0.252649, modinq_size_23_c1271, modinq_size_23_c1274);

modinq_size_23_c1277 := if(nf_inq_count24 < 11.614386, 9.851656, 8.000000);

modinq_size_23_c1278 := if(nf_inq_other_count < 1.044788, 8.000000, 8.000000);

modinq_size_23_c1276 := if(nf_inq_collection_count < 5.564964, modinq_size_23_c1277, modinq_size_23_c1278);

modinq_size_23_c1275 := if(nf_inq_dobsperssn_count12 < 1.706933, modinq_size_23_c1276, 6.000000);

modinq_size_23_c1269 := if(nf_inq_perssn_count_week < 1.538293, modinq_size_23_c1270, modinq_size_23_c1275);

modinq_size_23_c1268 := if(nf_inq_lname_ver_count < 197.337846, modinq_size_23_c1269, 4.000000);

modinq_size_23_c1281 := if(nf_inq_addrs_per_ssn < 1.125739, 6.000000, 6.000000);

modinq_size_23_c1280 := if(nf_inq_collection_count < 7.564618, modinq_size_23_c1281, 5.000000);

modinq_size_23_c1279 := if(nf_inq_bestphone_ver_count < 185.540672, modinq_size_23_c1280, 4.000000);

modinq_size_23_c1267 := if(rv_i62_inq_phonesperadl_count12 < 2.976303, modinq_size_23_c1268, modinq_size_23_c1279);

modinq_size_23_c1260 := if(nf_inq_lnames_per_ssn < 0.665939, modinq_size_23_c1261, modinq_size_23_c1267);

modinq_size_23 := if(rv_i62_inq_dobs_per_adl < 0.006297, modinq_size_23_c1220, modinq_size_23_c1260);

modinq_size_24_c1283 := if(nf_inq_ssns_per_sfd_addr < -0.109249, 2.000000, 2.000000);

modinq_size_24_c1290 := if(rv_i60_inq_hiriskcred_recency < 6.928584, 14.722286, 8.000000);

modinq_size_24_c1291 := if(nf_invbest_inq_perssn_diff < 0.200382, 8.000000, 8.000000);

modinq_size_24_c1289 := if(nf_inq_addrsperssn_count12 < 0.698317, modinq_size_24_c1290, modinq_size_24_c1291);

modinq_size_24_c1293 := if(nf_inq_perbestssn_count12 < 0.624622, 14.264295, 11.023665);

modinq_size_24_c1294 := if(nf_inq_lnamesperaddr_recency < 4.746015, 8.000000, 9.000000);

modinq_size_24_c1292 := if(nf_inq_per_ssn < 1.855969, modinq_size_24_c1293, modinq_size_24_c1294);

modinq_size_24_c1288 := if(rv_i61_inq_collection_recency < 6.327955, modinq_size_24_c1289, modinq_size_24_c1292);

modinq_size_24_c1297 := if(nf_inq_dob_ver_count < 253.613371, 8.000000, 11.023665);

modinq_size_24_c1298 := if(nf_inq_lnamesperaddr_count12 < 0.019146, 9.000000, 8.000000);

modinq_size_24_c1296 := if(nf_inq_perssn_recency < 0.754739, modinq_size_24_c1297, modinq_size_24_c1298);

modinq_size_24_c1295 := if(nf_inquiry_verification_index < 21.423676, 6.000000, modinq_size_24_c1296);

modinq_size_24_c1287 := if(nf_inq_addr_ver_count < 145.949193, modinq_size_24_c1288, modinq_size_24_c1295);

modinq_size_24_c1286 := if(nf_inq_per_addr < 7.356729, modinq_size_24_c1287, 4.000000);

modinq_size_24_c1303 := if(nf_inq_count24 < 2.179503, 11.941420, 8.000000);

modinq_size_24_c1302 := if(nf_inq_bestdob_ver_count < 7.764489, modinq_size_24_c1303, 7.000000);

modinq_size_24_c1301 := if(rv_i60_inq_count12 < 0.875954, modinq_size_24_c1302, 6.000000);

modinq_size_24_c1300 := if(nf_inq_other_count < 1.458860, modinq_size_24_c1301, 5.000000);

modinq_size_24_c1306 := if(nf_inq_adls_per_addr < 1.040690, 7.000000, 7.000000);

modinq_size_24_c1307 := if(nf_inq_lname_ver_count < 10.954392, 7.000000, 7.000000);

modinq_size_24_c1305 := if(nf_inq_adlsperaddr_recency < 2.161401, modinq_size_24_c1306, modinq_size_24_c1307);

modinq_size_24_c1304 := if(nf_inq_bestlname_ver_count < 13.817396, modinq_size_24_c1305, 5.000000);

modinq_size_24_c1299 := if(nf_inq_ssnspercurraddr_count12 < 0.509015, modinq_size_24_c1300, modinq_size_24_c1304);

modinq_size_24_c1285 := if(rv_i60_inq_auto_recency < 64.276710, modinq_size_24_c1286, modinq_size_24_c1299);

modinq_size_24_c1313 := if(nf_inq_lnamesperaddr_count_week < 0.037899, 14.375523, 9.851656);

modinq_size_24_c1314 := if(rv_i62_inq_ssns_per_adl < 1.668195, 15.533509, 11.023665);

modinq_size_24_c1312 := if(rv_i62_inq_addrsperadl_recency < 4.595478, modinq_size_24_c1313, modinq_size_24_c1314);

modinq_size_24_c1315 := if(nf_inq_ssn_ver_count < 12.868196, 7.000000, 7.000000);

modinq_size_24_c1311 := if(nf_inq_lnamesperssn_count_day < 0.548671, modinq_size_24_c1312, modinq_size_24_c1315);

modinq_size_24_c1317 := if(nf_inq_count < 8.381527, 7.000000, 7.000000);

modinq_size_24_c1316 := if(nf_inquiry_adl_vel_risk_index < 1.858204, modinq_size_24_c1317, 6.000000);

modinq_size_24_c1310 := if(nf_inq_addrsperssn_count_week < 1.345787, modinq_size_24_c1311, modinq_size_24_c1316);

modinq_size_24_c1318 := if(nf_inq_mortgage_count < 2.406185, 5.000000, 5.000000);

modinq_size_24_c1309 := if(rv_i60_inq_util_count12 < 0.510893, modinq_size_24_c1310, modinq_size_24_c1318);

modinq_size_24_c1321 := if(nf_inq_percurraddr_count12 < 2.577416, 6.000000, 6.000000);

modinq_size_24_c1323 := if(rv_i60_inq_comm_count12 < 0.805536, 7.000000, 7.000000);

modinq_size_24_c1325 := if(nf_inq_highriskcredit_count < 0.868635, 8.000000, 8.000000);

modinq_size_24_c1324 := if(nf_inq_perssn_count12 < 5.923159, modinq_size_24_c1325, 7.000000);

modinq_size_24_c1322 := if(nf_inq_quizprovider_count24 < 0.923463, modinq_size_24_c1323, modinq_size_24_c1324);

modinq_size_24_c1320 := if(nf_inq_lnamesperssn_recency < 5.217930, modinq_size_24_c1321, modinq_size_24_c1322);

modinq_size_24_c1319 := if(nf_inq_bestssn_ver_count < 27.307962, modinq_size_24_c1320, 4.000000);

modinq_size_24_c1308 := if(rv_i62_inq_lnamesperadl_count12 < 1.902579, modinq_size_24_c1309, modinq_size_24_c1319);

modinq_size_24_c1284 := if(rv_i62_inq_num_names_per_adl < 0.137855, modinq_size_24_c1285, modinq_size_24_c1308);

//modinq_size_24 := if(nf_inq_ssnsperaddr_count12 < -7583901133.455862, modinq_size_24_c1283, modinq_size_24_c1284);
modinq_size_24 := if(nf_inq_ssnsperaddr_count12 < -999999998, modinq_size_24_c1283, modinq_size_24_c1284);

modinq_size_25_c1333 := if(nf_inq_retail_count < 3.218099, 15.867683, 8.000000);

modinq_size_25_c1334 := if(nf_inquiry_verification_index < 28.634322, 8.000000, 9.000000);

modinq_size_25_c1332 := if(rv_i61_inq_collection_count12 < 1.879579, modinq_size_25_c1333, modinq_size_25_c1334);

modinq_size_25_c1336 := if(rv_i60_inq_auto_recency < 6.414898, 8.000000, 8.000000);

modinq_size_25_c1335 := if(nf_inq_retailpayments_count24 < 0.530090, modinq_size_25_c1336, 7.000000);

modinq_size_25_c1331 := if(rv_i62_inq_phonesperadl_recency < 10.220596, modinq_size_25_c1332, modinq_size_25_c1335);

modinq_size_25_c1339 := if(nf_inquiry_addr_vel_risk_indexv2 < 1.802636, 15.240222, 11.941420);

modinq_size_25_c1340 := if(nf_inquiry_ssn_vel_risk_indexv2 < 1.675505, 13.887806, 10.327020);

modinq_size_25_c1338 := if(nf_inq_addrsperssn_recency < 3.884541, modinq_size_25_c1339, modinq_size_25_c1340);

modinq_size_25_c1342 := if(nf_inq_perbestssn_count12 < 2.597514, 8.000000, 8.000000);

modinq_size_25_c1341 := if(rv_i62_inq_dobsperadl_count12 < 0.111572, 7.000000, modinq_size_25_c1342);

modinq_size_25_c1337 := if(nf_inq_retail_count24 < 1.999418, modinq_size_25_c1338, modinq_size_25_c1341);

modinq_size_25_c1330 := if(nf_inq_peraddr_recency < 0.386870, modinq_size_25_c1331, modinq_size_25_c1337);

modinq_size_25_c1343 := if(nf_inq_addr_ver_count < 2.044897, 5.000000, 5.000000);

modinq_size_25_c1329 := if(nf_inq_dobsperadl_count_week < 0.545743, modinq_size_25_c1330, modinq_size_25_c1343);

modinq_size_25_c1346 := if(nf_inq_bestssn_ver_count < 1.513518, 6.000000, 6.000000);

modinq_size_25_c1348 := if(nf_inq_adlsperbestphone_count12 < 0.496742, 7.000000, 7.000000);

modinq_size_25_c1347 := if(nf_invbest_inq_lastperaddr_diff < -0.163682, modinq_size_25_c1348, 6.000000);

modinq_size_25_c1345 := if(nf_inq_peradl_count_day < 1.984417, modinq_size_25_c1346, modinq_size_25_c1347);

modinq_size_25_c1344 := if(nf_inq_dobsperbestssn_count12 < 1.216051, modinq_size_25_c1345, 4.000000);

modinq_size_25_c1328 := if(nf_inq_adlsperssn_count_week < 0.535990, modinq_size_25_c1329, modinq_size_25_c1344);

modinq_size_25_c1354 := if(nf_inq_ssn_ver_count < 5.536223, 9.000000, 8.000000);

modinq_size_25_c1355 := if(nf_inq_retail_count24 < 0.824785, 8.000000, 8.000000);

modinq_size_25_c1353 := if(nf_inq_bestdob_ver_count < 52.625853, modinq_size_25_c1354, modinq_size_25_c1355);

modinq_size_25_c1357 := if(nf_inq_lname_ver_count < 12.775067, 9.000000, 9.000000);

modinq_size_25_c1356 := if(nf_inq_auto_count24 < 1.753916, modinq_size_25_c1357, 7.000000);

modinq_size_25_c1352 := if(nf_inq_lnamespercurraddr_count12 < 0.163104, modinq_size_25_c1353, modinq_size_25_c1356);

modinq_size_25_c1359 := if(rv_i61_inq_collection_recency < 74.455277, 7.000000, 7.000000);

modinq_size_25_c1358 := if(nf_invbest_inq_peraddr_diff < -0.953577, modinq_size_25_c1359, 6.000000);

modinq_size_25_c1351 := if(rv_i60_inq_retail_recency < 75.975573, modinq_size_25_c1352, modinq_size_25_c1358);

modinq_size_25_c1363 := if(nf_inq_highriskcredit_count24 < 0.472273, 9.000000, 8.000000);

modinq_size_25_c1364 := if(nf_inq_banking_count_day < 0.214268, 8.000000, 8.000000);

modinq_size_25_c1362 := if(nf_inq_dobs_per_ssn < 1.658130, modinq_size_25_c1363, modinq_size_25_c1364);

modinq_size_25_c1361 := if(rv_i60_inq_retpymt_recency < 62.868230, modinq_size_25_c1362, 6.000000);

modinq_size_25_c1360 := if(nf_inq_ssnsperaddr_count12 < 3.084485, modinq_size_25_c1361, 5.000000);

modinq_size_25_c1350 := if(rv_i62_inq_dobsperadl_count12 < 0.698685, modinq_size_25_c1351, modinq_size_25_c1360);

modinq_size_25_c1367 := if(nf_inq_ssnsperaddr_recency < 9.456251, 6.000000, 6.000000);

modinq_size_25_c1366 := if(nf_inq_per_ssn < 3.590916, 5.000000, modinq_size_25_c1367);

modinq_size_25_c1368 := if(nf_inq_ssnsperaddr_count12 < 2.024238, 5.000000, 5.000000);

modinq_size_25_c1365 := if(rv_i62_inq_phonesperadl_recency < 9.809208, modinq_size_25_c1366, modinq_size_25_c1368);

modinq_size_25_c1349 := if(rv_i62_inq_lnamesperadl_recency < 9.483329, modinq_size_25_c1350, modinq_size_25_c1365);

modinq_size_25_c1327 := if(nf_inq_adls_per_apt_addr < -0.686921, modinq_size_25_c1328, modinq_size_25_c1349);

modinq_size_25_c1375 := if(nf_inq_quizprovider_count < 0.650456, 12.278091, 11.023665);

modinq_size_25_c1376 := if(rv_i60_inq_retail_recency < 77.347817, 9.000000, 9.000000);

modinq_size_25_c1374 := if(nf_inq_lnamesperaddr_recency < 8.911381, modinq_size_25_c1375, modinq_size_25_c1376);

modinq_size_25_c1373 := if(rv_i60_inq_mortgage_count12 < 0.839360, modinq_size_25_c1374, 6.000000);

modinq_size_25_c1379 := if(nf_inq_per_sfd_addr < -0.743565, 8.000000, 9.000000);

modinq_size_25_c1378 := if(rv_i62_inq_lnamesperadl_count12 < 0.377789, modinq_size_25_c1379, 7.000000);

modinq_size_25_c1377 := if(nf_inq_ssnsperaddr_recency < 0.105972, modinq_size_25_c1378, 6.000000);

modinq_size_25_c1372 := if(nf_invbest_inq_peraddr_diff < -0.392745, modinq_size_25_c1373, modinq_size_25_c1377);

modinq_size_25_c1371 := if(nf_inq_retail_count < 3.696800, modinq_size_25_c1372, 4.000000);

modinq_size_25_c1370 := if(nf_inq_percurraddr_count12 < 7.238447, modinq_size_25_c1371, 3.000000);

modinq_size_25_c1369 := if(nf_invbest_inq_addrsperssn_diff < -0.226072, modinq_size_25_c1370, 2.000000);

modinq_size_25 := if(rv_i60_inq_auto_recency < 52.164006, modinq_size_25_c1327, modinq_size_25_c1369);

modinq_size_26_c1387 := if(nf_inq_adlsperssn_count_day < 0.016850, 17.037665, 8.000000);

//modinq_size_26_c1386 := if(nf_inq_ssns_per_sfd_addr < -1051719789.470547, 7.000000, modinq_size_26_c1387);
modinq_size_26_c1386 := if(nf_inq_ssns_per_sfd_addr < -999999998, 7.000000, modinq_size_26_c1387);

modinq_size_26_c1389 := if(nf_inq_prepaidcards_count < 0.400423, 15.622432, 9.000000);

modinq_size_26_c1388 := if(nf_inq_lnamespercurraddr_count12 < 2.079769, modinq_size_26_c1389, 7.000000);

modinq_size_26_c1385 := if(rv_i61_inq_collection_recency < 87.649773, modinq_size_26_c1386, modinq_size_26_c1388);

modinq_size_26_c1392 := if(nf_inq_per_sfd_addr < 0.183326, 8.000000, 8.000000);

modinq_size_26_c1391 := if(rv_i62_inq_dobsperadl_count12 < 1.431563, modinq_size_26_c1392, 7.000000);

modinq_size_26_c1390 := if(nf_inq_lnamesperssn_recency < 11.845157, modinq_size_26_c1391, 6.000000);

modinq_size_26_c1384 := if(nf_inq_highriskcredit_count24 < 1.605174, modinq_size_26_c1385, modinq_size_26_c1390);

modinq_size_26_c1396 := if(nf_inquiry_ssn_vel_risk_indexv2 < 0.485993, 13.040438, 10.706640);

modinq_size_26_c1395 := if(nf_inq_highriskcredit_count < 10.346551, modinq_size_26_c1396, 7.000000);

modinq_size_26_c1394 := if(nf_inq_per_addr < 10.510599, modinq_size_26_c1395, 6.000000);

modinq_size_26_c1393 := if(nf_invbest_inq_peraddr_diff < -7.673725, 5.000000, modinq_size_26_c1394);

modinq_size_26_c1383 := if(nf_inq_perbestssn_count12 < 4.132637, modinq_size_26_c1384, modinq_size_26_c1393);

modinq_size_26_c1397 := if(nf_inq_adls_per_sfd_addr < -0.509547, 4.000000, 4.000000);

modinq_size_26_c1382 := if(rv_i60_inq_comm_count12 < 2.464992, modinq_size_26_c1383, modinq_size_26_c1397);

modinq_size_26_c1399 := if(nf_inq_addr_ver_count < 4.166002, 4.000000, 4.000000);

modinq_size_26_c1398 := if(nf_inq_addrs_per_ssn < 1.548171, 3.000000, modinq_size_26_c1399);

modinq_size_26_c1381 := if(nf_inq_adlsperaddr_count_day < 0.985161, modinq_size_26_c1382, modinq_size_26_c1398);

modinq_size_26_c1402 := if(rv_i62_inq_phonesperadl_recency < 2.702782, 4.000000, 4.000000);

modinq_size_26_c1401 := if(nf_inq_percurraddr_count12 < 0.202046, modinq_size_26_c1402, 3.000000);

modinq_size_26_c1403 := if(nf_inq_count_week < 1.329466, 3.000000, 3.000000);

modinq_size_26_c1400 := if(nf_inq_ssn_ver_count < 8.579611, modinq_size_26_c1401, modinq_size_26_c1403);

modinq_size_26 := if(rv_i62_inq_fnamesperadl_count12 < 1.523837, modinq_size_26_c1381, modinq_size_26_c1400);

modinq_size_27_c1411 := if(nf_inq_peradl_count_week < 0.106050, 16.153926, 11.296252);

modinq_size_27_c1412 := if(nf_inq_dobsperssn_recency < 0.756917, 12.931969, 8.000000);

modinq_size_27_c1410 := if(rv_i60_inq_other_recency < 84.116675, modinq_size_27_c1411, modinq_size_27_c1412);

modinq_size_27_c1414 := if(rv_i60_inq_peradl_count12 < 14.752777, 10.327020, 9.207392);

modinq_size_27_c1415 := if(rv_i60_inq_hiriskcred_recency < 17.357902, 8.000000, 8.000000);

modinq_size_27_c1413 := if(nf_inq_highriskcredit_count < 11.097505, modinq_size_27_c1414, modinq_size_27_c1415);

modinq_size_27_c1409 := if(rv_i62_inq_addrsperadl_count12 < 1.092789, modinq_size_27_c1410, modinq_size_27_c1413);

modinq_size_27_c1418 := if(nf_inq_per_sfd_addr < 11.175151, 14.531555, 8.000000);

modinq_size_27_c1419 := if(nf_inq_quizprovider_count24 < 1.055526, 14.084906, 8.000000);

modinq_size_27_c1417 := if(rv_i60_inq_auto_recency < 16.531020, modinq_size_27_c1418, modinq_size_27_c1419);

modinq_size_27_c1420 := if(nf_inq_adlspercurraddr_count12 < 1.772156, 7.000000, 7.000000);

modinq_size_27_c1416 := if(nf_inq_count24 < 24.596468, modinq_size_27_c1417, modinq_size_27_c1420);

modinq_size_27_c1408 := if(rv_i61_inq_collection_recency < 91.807793, modinq_size_27_c1409, modinq_size_27_c1416);

modinq_size_27_c1424 := if(rv_i62_inq_dobs_per_adl < 0.414370, 9.207392, 8.000000);

modinq_size_27_c1425 := if(nf_inq_per_sfd_addr < 0.745113, 10.327020, 11.941420);

modinq_size_27_c1423 := if(rv_i62_inq_phonesperadl_recency < 10.251923, modinq_size_27_c1424, modinq_size_27_c1425);

modinq_size_27_c1427 := if(rv_i60_inq_auto_recency < 48.423121, 9.000000, 8.000000);

modinq_size_27_c1426 := if(rv_i60_inq_banking_count12 < 0.105428, modinq_size_27_c1427, 7.000000);

modinq_size_27_c1422 := if(nf_inq_addrs_per_ssn < 1.851440, modinq_size_27_c1423, modinq_size_27_c1426);

modinq_size_27_c1428 := if(nf_inq_perbestssn_count12 < 5.824190, 6.000000, 6.000000);

modinq_size_27_c1421 := if(rv_i62_inq_fnamesperadl_count12 < 1.047610, modinq_size_27_c1422, modinq_size_27_c1428);

modinq_size_27_c1407 := if(nf_inq_addrsperssn_recency < 11.954534, modinq_size_27_c1408, modinq_size_27_c1421);

modinq_size_27_c1429 := if(nf_inq_adls_per_apt_addr < -0.500168, 4.000000, 4.000000);

modinq_size_27_c1406 := if(nf_inq_quizprovider_count24 < 4.174302, modinq_size_27_c1407, modinq_size_27_c1429);

modinq_size_27_c1435 := if(rv_i60_inq_auto_count12 < 7.748796, 8.000000, 8.000000);

modinq_size_27_c1434 := if(nf_inq_bestlname_ver_count < 44.718859, modinq_size_27_c1435, 7.000000);

modinq_size_27_c1433 := if(nf_inq_lname_ver_count < 9.371456, 6.000000, modinq_size_27_c1434);

modinq_size_27_c1432 := if(rv_i60_inq_prepaidcards_recency < 3.559569, modinq_size_27_c1433, 5.000000);

modinq_size_27_c1431 := if(nf_inq_retailpayments_count24 < 2.462100, modinq_size_27_c1432, 4.000000);

modinq_size_27_c1430 := if(nf_inq_perbestphone_count12 < 0.954162, modinq_size_27_c1431, 3.000000);

modinq_size_27_c1405 := if(nf_inq_dobsperssn_count12 < 1.733116, modinq_size_27_c1406, modinq_size_27_c1430);

modinq_size_27_c1441 := if(nf_inq_ssnsperaddr_recency < 9.425861, 7.000000, 7.000000);

modinq_size_27_c1440 := if(nf_inq_retailpayments_count < 0.651947, modinq_size_27_c1441, 6.000000);

modinq_size_27_c1439 := if(rv_i61_inq_collection_recency < 94.958082, modinq_size_27_c1440, 5.000000);

modinq_size_27_c1438 := if(nf_inq_addrs_per_ssn < 0.517432, modinq_size_27_c1439, 4.000000);

modinq_size_27_c1437 := if(nf_inq_adlspercurraddr_count12 < 2.727562, 3.000000, modinq_size_27_c1438);

modinq_size_27_c1447 := if(nf_inquiry_ssn_vel_risk_indexv2 < 1.259048, 9.207392, 9.000000);

modinq_size_27_c1446 := if(nf_inq_perssn_count12 < 5.318084, modinq_size_27_c1447, 7.000000);

modinq_size_27_c1445 := if(nf_inq_per_addr < 5.033595, 6.000000, modinq_size_27_c1446);

modinq_size_27_c1444 := if(nf_invbest_inq_peraddr_diff < 1.638236, modinq_size_27_c1445, 5.000000);

modinq_size_27_c1443 := if(rv_i62_inq_ssns_per_adl < 2.491133, modinq_size_27_c1444, 4.000000);

modinq_size_27_c1449 := if(nf_inq_lnamespercurraddr_count12 < 2.218969, 5.000000, 5.000000);

modinq_size_27_c1448 := if(nf_inq_addrsperbestssn_count12 < 2.220337, 4.000000, modinq_size_27_c1449);

modinq_size_27_c1442 := if(nf_inq_perbestssn_count12 < 8.956651, modinq_size_27_c1443, modinq_size_27_c1448);

modinq_size_27_c1436 := if(rv_i62_inq_dobs_per_adl < 0.316107, modinq_size_27_c1437, modinq_size_27_c1442);

modinq_size_27 := if(nf_inquiry_addr_vel_risk_indexv2 < 0.200643, modinq_size_27_c1405, modinq_size_27_c1436);

modinq_size_28_c1457 := if(nf_inq_dobsperadl_count_week < 0.339677, 17.366285, 8.000000);

modinq_size_28_c1458 := if(nf_invbest_inq_peraddr_diff < -3.440760, 8.000000, 14.937650);

modinq_size_28_c1456 := if(nf_inq_addrsperbestssn_count12 < 0.645546, modinq_size_28_c1457, modinq_size_28_c1458);

modinq_size_28_c1460 := if(nf_inq_auto_count < 0.020688, 8.000000, 8.000000);

modinq_size_28_c1459 := if(rv_i60_inq_prepaidcards_recency < 13.991972, modinq_size_28_c1460, 7.000000);

modinq_size_28_c1455 := if(nf_inq_collection_count24 < 4.268168, modinq_size_28_c1456, modinq_size_28_c1459);

modinq_size_28_c1454 := if(nf_inq_addrsperssn_count_week < 0.171083, modinq_size_28_c1455, 5.000000);

modinq_size_28_c1464 := if(nf_inq_highriskcredit_count24 < 0.811210, 11.023665, 8.000000);

modinq_size_28_c1465 := if(nf_inq_collection_count24 < 1.311561, 8.000000, 8.000000);

modinq_size_28_c1463 := if(nf_inq_perbestssn_count12 < 4.965951, modinq_size_28_c1464, modinq_size_28_c1465);

modinq_size_28_c1462 := if(nf_inq_other_count24 < 4.810620, modinq_size_28_c1463, 6.000000);

modinq_size_28_c1468 := if(nf_inq_adls_per_sfd_addr < 1.660525, 9.207392, 9.207392);

modinq_size_28_c1469 := if(rv_i60_inq_hiriskcred_recency < 34.667366, 9.000000, 8.000000);

modinq_size_28_c1467 := if(nf_inq_lnames_per_ssn < 1.028344, modinq_size_28_c1468, modinq_size_28_c1469);

modinq_size_28_c1470 := if(nf_inq_collection_count < 9.371666, 7.000000, 7.000000);

modinq_size_28_c1466 := if(nf_inq_other_count24 < 3.292639, modinq_size_28_c1467, modinq_size_28_c1470);

modinq_size_28_c1461 := if(rv_i62_inq_phonesperadl_count12 < 1.540403, modinq_size_28_c1462, modinq_size_28_c1466);

modinq_size_28_c1453 := if(rv_i62_inq_addrsperadl_count12 < 1.447575, modinq_size_28_c1454, modinq_size_28_c1461);

modinq_size_28_c1452 := if(rv_i60_inq_peradl_count12 < 20.629028, modinq_size_28_c1453, 3.000000);

modinq_size_28_c1451 := if(nf_inq_highriskcredit_count24 < 7.485941, modinq_size_28_c1452, 2.000000);

modinq_size_28_c1474 := if(rv_i60_inq_hiriskcred_recency < 0.248658, 5.000000, 5.000000);

modinq_size_28_c1473 := if(nf_inq_lnamesperadl_count_week < 0.371451, modinq_size_28_c1474, 4.000000);

modinq_size_28_c1477 := if(nf_inq_dobs_per_ssn < 0.436946, 6.000000, 6.000000);

modinq_size_28_c1476 := if(nf_inq_lnamesperbestssn_count12 < 2.339532, modinq_size_28_c1477, 5.000000);

modinq_size_28_c1475 := if(nf_inq_ssnspercurraddr_count12 < 1.496256, 4.000000, modinq_size_28_c1476);

modinq_size_28_c1472 := if(nf_inq_bestssn_ver_count < 12.049067, modinq_size_28_c1473, modinq_size_28_c1475);

modinq_size_28_c1479 := if(nf_inq_addrsperbestssn_count12 < 1.611355, 4.000000, 4.000000);

modinq_size_28_c1481 := if(nf_inq_lnamesperbestssn_count12 < 1.692584, 5.000000, 5.000000);

modinq_size_28_c1480 := if(nf_inq_adlsperaddr_count_day < 0.711851, modinq_size_28_c1481, 4.000000);

modinq_size_28_c1478 := if(nf_inq_perssn_count_week < 1.853868, modinq_size_28_c1479, modinq_size_28_c1480);

modinq_size_28_c1471 := if(nf_inq_ssnsperaddr_count_week < 0.161575, modinq_size_28_c1472, modinq_size_28_c1478);

modinq_size_28 := if(nf_inq_peraddr_count_week < 0.185452, modinq_size_28_c1451, modinq_size_28_c1471);

modinq_size_29_c1489 := if(nf_inq_lname_ver_count < 241.072129, 14.320683, 11.023665);

modinq_size_29_c1490 := if(nf_inq_perssn_recency < 4.321546, 12.565879, 9.851656);

modinq_size_29_c1488 := if(nf_inq_peraddr_recency < 0.965674, modinq_size_29_c1489, modinq_size_29_c1490);

modinq_size_29_c1492 := if(nf_inq_collection_count24 < 1.248649, 12.278091, 9.000000);

modinq_size_29_c1491 := if(rv_i60_inq_auto_count12 < 1.696337, modinq_size_29_c1492, 7.000000);

modinq_size_29_c1487 := if(rv_i62_inq_fnamesperadl_count12 < 0.106537, modinq_size_29_c1488, modinq_size_29_c1491);

modinq_size_29_c1495 := if(nf_inq_peraddr_count_day < 0.890417, 12.116889, 8.000000);

modinq_size_29_c1494 := if(nf_inq_adls_per_sfd_addr < 1.604936, modinq_size_29_c1495, 7.000000);

modinq_size_29_c1496 := if(nf_inq_addr_ver_count < 6.713966, 7.000000, 7.000000);

modinq_size_29_c1493 := if(nf_inq_lnamesperbestssn_count12 < 0.590075, modinq_size_29_c1494, modinq_size_29_c1496);

modinq_size_29_c1486 := if(rv_i60_inq_mortgage_recency < 35.076526, modinq_size_29_c1487, modinq_size_29_c1493);

modinq_size_29_c1500 := if(rv_i62_inq_ssns_per_adl < 0.853936, 14.767255, 11.535537);

modinq_size_29_c1501 := if(rv_i60_inq_auto_recency < 27.318182, 9.000000, 8.000000);

modinq_size_29_c1499 := if(nf_inq_lnames_per_apt_addr < -0.421973, modinq_size_29_c1500, modinq_size_29_c1501);

modinq_size_29_c1502 := if(nf_inq_fname_ver_count < 18.237073, 7.000000, 7.000000);

modinq_size_29_c1498 := if(rv_i60_inq_mortgage_count12 < 1.284669, modinq_size_29_c1499, modinq_size_29_c1502);

modinq_size_29_c1497 := if(rv_i60_inq_peradl_count12 < 8.969480, modinq_size_29_c1498, 5.000000);

modinq_size_29_c1485 := if(rv_i61_inq_collection_recency < 24.115795, modinq_size_29_c1486, modinq_size_29_c1497);

modinq_size_29_c1507 := if(nf_inq_addr_recency_risk_index < 3.913167, 12.116889, 8.000000);

modinq_size_29_c1506 := if(nf_inq_auto_count24 < 0.832480, modinq_size_29_c1507, 7.000000);

modinq_size_29_c1505 := if(nf_inq_collection_count < 4.247972, modinq_size_29_c1506, 6.000000);

modinq_size_29_c1508 := if(nf_inq_dob_ver_count < 185.023283, 6.000000, 6.000000);

modinq_size_29_c1504 := if(nf_inq_banking_count24 < 0.900714, modinq_size_29_c1505, modinq_size_29_c1508);

modinq_size_29_c1503 := if(nf_invbest_inq_adlsperaddr_diff < 2.572791, modinq_size_29_c1504, 4.000000);

modinq_size_29_c1484 := if(nf_inq_ssnsperaddr_count12 < 1.886400, modinq_size_29_c1485, modinq_size_29_c1503);

modinq_size_29_c1514 := if(nf_inq_quizprovider_count24 < 3.832957, 9.207392, 8.000000);

modinq_size_29_c1515 := if(nf_inq_lnames_per_sfd_addr < -0.323309, 10.706640, 12.278091);

modinq_size_29_c1513 := if(rv_i62_inq_lnamesperadl_recency < 4.203349, modinq_size_29_c1514, modinq_size_29_c1515);

modinq_size_29_c1512 := if(nf_inq_lnamesperssn_count12 < 1.726503, modinq_size_29_c1513, 6.000000);

modinq_size_29_c1518 := if(nf_inq_adls_per_apt_addr < 1.472047, 11.941420, 8.000000);

modinq_size_29_c1517 := if(nf_inq_retail_count24 < 0.984714, modinq_size_29_c1518, 7.000000);

modinq_size_29_c1520 := if(rv_i62_inq_addrs_per_adl < 2.976505, 10.327020, 9.207392);

modinq_size_29_c1521 := if(rv_i62_inq_fnamesperadl_recency < 4.367536, 8.000000, 8.000000);

modinq_size_29_c1519 := if(rv_i60_inq_auto_count12 < 7.311799, modinq_size_29_c1520, modinq_size_29_c1521);

modinq_size_29_c1516 := if(nf_inq_addrsperbestssn_count12 < 1.775223, modinq_size_29_c1517, modinq_size_29_c1519);

modinq_size_29_c1511 := if(nf_inq_peraddr_recency < 0.795623, modinq_size_29_c1512, modinq_size_29_c1516);

modinq_size_29_c1525 := if(nf_inq_adlsperaddr_recency < 2.039369, 8.000000, 8.000000);

modinq_size_29_c1524 := if(nf_inq_collection_count24 < 0.472301, 7.000000, modinq_size_29_c1525);

modinq_size_29_c1523 := if(nf_inq_addrs_per_ssn < 1.648292, modinq_size_29_c1524, 6.000000);

modinq_size_29_c1526 := if(nf_inq_lnamesperssn_recency < 7.557222, 6.000000, 6.000000);

modinq_size_29_c1522 := if(rv_i60_inq_banking_count12 < 0.684998, modinq_size_29_c1523, modinq_size_29_c1526);

modinq_size_29_c1510 := if(nf_inq_retailpayments_count < 0.941051, modinq_size_29_c1511, modinq_size_29_c1522);

modinq_size_29_c1531 := if(nf_inq_dobsperbestssn_count12 < 1.519774, 12.278091, 8.000000);

modinq_size_29_c1532 := if(rv_i62_inq_lnamesperadl_recency < 9.348322, 9.851656, 9.000000);

modinq_size_29_c1530 := if(nf_inq_ssns_per_addr < 2.651570, modinq_size_29_c1531, modinq_size_29_c1532);

modinq_size_29_c1529 := if(nf_inq_phonesperadl_count_week < 0.745747, modinq_size_29_c1530, 6.000000);

modinq_size_29_c1533 := if(nf_inq_addrsperbestssn_count12 < 1.063339, 6.000000, 6.000000);

modinq_size_29_c1528 := if(nf_inq_lnamesperaddr_count12 < 3.551732, modinq_size_29_c1529, modinq_size_29_c1533);

modinq_size_29_c1527 := if(nf_inq_banking_count < 6.953821, modinq_size_29_c1528, 4.000000);

modinq_size_29_c1509 := if(nf_inq_ssns_per_sfd_addr < 1.444495, modinq_size_29_c1510, modinq_size_29_c1527);

modinq_size_29_c1483 := if(nf_inq_dobsperssn_count12 < 0.170428, modinq_size_29_c1484, modinq_size_29_c1509);

modinq_size_29_c1536 := if(nf_inq_dobsperssn_count_week < 0.233374, 4.000000, 4.000000);

modinq_size_29_c1538 := if(nf_inq_prepaidcards_count < 0.318332, 5.000000, 5.000000);

modinq_size_29_c1537 := if(nf_inq_auto_count < 1.681975, 4.000000, modinq_size_29_c1538);

modinq_size_29_c1535 := if(nf_inq_lnamesperssn_count_day < 0.269288, modinq_size_29_c1536, modinq_size_29_c1537);

modinq_size_29_c1539 := if(rv_i60_inq_hiriskcred_count12 < 3.151869, 3.000000, 3.000000);

modinq_size_29_c1534 := if(nf_inq_adls_per_addr < 1.706711, modinq_size_29_c1535, modinq_size_29_c1539);

modinq_size_29 := if(nf_inq_ssnsperadl_count_week < 0.394359, modinq_size_29_c1483, modinq_size_29_c1534);

modinq_size_30_c1547 := if(nf_inq_quizprovider_count < 10.889679, 17.175657, 9.000000);

modinq_size_30_c1548 := if(nf_inquiry_adl_vel_risk_index < 2.905476, 9.207392, 9.000000);

modinq_size_30_c1546 := if(nf_inq_lnames_per_apt_addr < 1.839363, modinq_size_30_c1547, modinq_size_30_c1548);

modinq_size_30_c1549 := if(nf_inq_lnamesperssn_count12 < 0.959207, 7.000000, 7.000000);

modinq_size_30_c1545 := if(nf_inq_other_count_week < 0.270278, modinq_size_30_c1546, modinq_size_30_c1549);

modinq_size_30_c1544 := if(nf_inq_addrsperadl_count_week < 1.765993, modinq_size_30_c1545, 5.000000);

modinq_size_30_c1543 := if(rv_i60_inq_util_recency < 4.900681, modinq_size_30_c1544, 4.000000);

modinq_size_30_c1554 := if(nf_inq_lnamespercurraddr_count12 < 0.053049, 10.706640, 9.000000);

modinq_size_30_c1555 := if(nf_inq_count24 < 1.741177, 9.000000, 8.000000);

modinq_size_30_c1553 := if(nf_inq_lnamesperaddr_recency < 7.447949, modinq_size_30_c1554, modinq_size_30_c1555);

modinq_size_30_c1557 := if(nf_inq_bestssn_ver_count < 6.784147, 8.000000, 8.000000);

modinq_size_30_c1556 := if(nf_inq_ssnsperaddr_count12 < 1.543964, 7.000000, modinq_size_30_c1557);

modinq_size_30_c1552 := if(nf_inq_auto_count < 2.826673, modinq_size_30_c1553, modinq_size_30_c1556);

modinq_size_30_c1560 := if(nf_inq_adlspercurraddr_count12 < 0.574052, 8.000000, 8.000000);

modinq_size_30_c1559 := if(rv_i62_inq_fnamesperadl_count12 < 0.073003, modinq_size_30_c1560, 7.000000);

modinq_size_30_c1558 := if(nf_inq_perssn_count12 < 0.471980, modinq_size_30_c1559, 6.000000);

modinq_size_30_c1551 := if(nf_inq_highriskcredit_count < 0.153051, modinq_size_30_c1552, modinq_size_30_c1558);

modinq_size_30_c1563 := if(nf_inq_perbestssn_count12 < 1.477937, 7.000000, 7.000000);

modinq_size_30_c1565 := if(nf_inq_adls_per_sfd_addr < 1.724759, 11.296252, 9.851656);

modinq_size_30_c1564 := if(nf_inq_retail_count < 1.566874, modinq_size_30_c1565, 7.000000);

modinq_size_30_c1562 := if(rv_i62_inq_addrs_per_adl < 0.969251, modinq_size_30_c1563, modinq_size_30_c1564);

modinq_size_30_c1561 := if(nf_inq_mortgage_count < 2.123583, modinq_size_30_c1562, 5.000000);

modinq_size_30_c1550 := if(rv_i62_inq_dobs_per_adl < 0.576838, modinq_size_30_c1551, modinq_size_30_c1561);

modinq_size_30_c1542 := if(rv_i60_inq_comm_recency < 48.699880, modinq_size_30_c1543, modinq_size_30_c1550);

modinq_size_30_c1571 := if(rv_i60_inq_auto_count12 < 0.816988, 12.817256, 8.000000);

modinq_size_30_c1572 := if(nf_inq_perssn_count12 < 0.875644, 8.000000, 8.000000);

modinq_size_30_c1570 := if(nf_inq_prepaidcards_count < 0.667525, modinq_size_30_c1571, modinq_size_30_c1572);

modinq_size_30_c1573 := if(nf_inq_ssn_ver_count < 4.477495, 7.000000, 7.000000);

modinq_size_30_c1569 := if(rv_i62_inq_ssnsperadl_count12 < 0.888118, modinq_size_30_c1570, modinq_size_30_c1573);

modinq_size_30_c1576 := if(nf_inq_adlsperbestphone_count12 < 0.776464, 10.706640, 8.000000);

modinq_size_30_c1575 := if(nf_inq_lnamesperbestssn_count12 < 0.601366, modinq_size_30_c1576, 7.000000);

modinq_size_30_c1574 := if(nf_inq_auto_count24 < 1.336954, modinq_size_30_c1575, 6.000000);

modinq_size_30_c1568 := if(nf_inq_peraddr_recency < 0.265741, modinq_size_30_c1569, modinq_size_30_c1574);

modinq_size_30_c1578 := if(nf_inq_banking_count < 1.597239, 6.000000, 6.000000);

modinq_size_30_c1581 := if(nf_inq_addr_ver_count < 2.182628, 8.000000, 9.000000);

modinq_size_30_c1582 := if(nf_inq_highriskcredit_count < 0.021925, 8.000000, 9.000000);

modinq_size_30_c1580 := if(nf_inq_quizprovider_count < 0.723196, modinq_size_30_c1581, modinq_size_30_c1582);

modinq_size_30_c1579 := if(nf_inq_addrsperadl_count_week < 1.356504, modinq_size_30_c1580, 6.000000);

modinq_size_30_c1577 := if(nf_inq_perssn_count12 < 0.439165, modinq_size_30_c1578, modinq_size_30_c1579);

modinq_size_30_c1567 := if(rv_i60_credit_seeking < 0.464349, modinq_size_30_c1568, modinq_size_30_c1577);

modinq_size_30_c1585 := if(rv_i60_inq_peradl_recency < 2.855907, 6.000000, 6.000000);

modinq_size_30_c1584 := if(rv_i60_inq_peradl_count12 < 0.031000, 5.000000, modinq_size_30_c1585);

modinq_size_30_c1583 := if(rv_i62_inq_lnamesperadl_recency < 9.933578, modinq_size_30_c1584, 4.000000);

modinq_size_30_c1566 := if(nf_inquiry_addr_vel_risk_indexv2 < 0.569466, modinq_size_30_c1567, modinq_size_30_c1583);

modinq_size_30_c1541 := if(rv_i60_inq_other_recency < 68.499036, modinq_size_30_c1542, modinq_size_30_c1566);

modinq_size_30_c1590 := if(nf_inq_peraddr_count12 < 3.057658, 9.748880, 6.000000);

modinq_size_30_c1589 := if(nf_inq_adlspercurraddr_count12 < 1.428054, modinq_size_30_c1590, 5.000000);

modinq_size_30_c1588 := if(nf_inq_per_apt_addr < 0.509425, modinq_size_30_c1589, 4.000000);

modinq_size_30_c1587 := if(rv_i61_inq_collection_count12 < 0.226690, modinq_size_30_c1588, 3.000000);

modinq_size_30_c1586 := if(nf_invbest_inq_lastperaddr_diff < -0.271117, modinq_size_30_c1587, 3.207392);

modinq_size_30 := if(nf_inq_bestfname_ver_count < 111.848568, modinq_size_30_c1541, modinq_size_30_c1586);

modinq_size_31_c1598 := if(nf_inq_count_week < 2.273461, 17.080071, 8.000000);

modinq_size_31_c1599 := if(nf_inq_addrsperbestssn_count12 < 1.073945, 14.206270, 8.000000);

modinq_size_31_c1597 := if(nf_inq_banking_count < 1.089806, modinq_size_31_c1598, modinq_size_31_c1599);

modinq_size_31_c1601 := if(nf_inq_other_count24 < 9.124029, 9.000000, 8.000000);

modinq_size_31_c1600 := if(nf_inq_collection_count < 5.477059, modinq_size_31_c1601, 7.000000);

modinq_size_31_c1596 := if(rv_i62_inq_num_names_per_adl < 1.773687, modinq_size_31_c1597, modinq_size_31_c1600);

modinq_size_31_c1603 := if(nf_inq_peradl_count_day < 1.867010, 7.000000, 7.000000);

modinq_size_31_c1602 := if(rv_i60_inq_banking_count12 < 0.310636, modinq_size_31_c1603, 6.000000);

modinq_size_31_c1595 := if(nf_inq_lnamesperadl_count_day < 0.124737, modinq_size_31_c1596, modinq_size_31_c1602);

modinq_size_31_c1605 := if(nf_inq_perbestssn_count12 < 0.378581, 6.000000, 6.000000);

modinq_size_31_c1604 := if(nf_inquiry_verification_index < 29.037251, 5.000000, modinq_size_31_c1605);

modinq_size_31_c1594 := if(nf_inq_utilities_count < 0.185381, modinq_size_31_c1595, modinq_size_31_c1604);

modinq_size_31_c1610 := if(nf_inq_per_sfd_addr < 2.878642, 11.748880, 8.000000);

modinq_size_31_c1609 := if(nf_inq_other_count24 < 2.919881, modinq_size_31_c1610, 7.000000);

modinq_size_31_c1608 := if(rv_i60_inq_mortgage_count12 < 0.677123, modinq_size_31_c1609, 6.000000);

modinq_size_31_c1613 := if(nf_inq_perssn_count12 < 1.276174, 8.000000, 8.000000);

modinq_size_31_c1612 := if(nf_inq_count < 9.851141, 7.000000, modinq_size_31_c1613);

modinq_size_31_c1611 := if(rv_i62_inq_addrs_per_adl < 0.681711, modinq_size_31_c1612, 6.000000);

modinq_size_31_c1607 := if(nf_inq_other_count < 3.486755, modinq_size_31_c1608, modinq_size_31_c1611);

modinq_size_31_c1617 := if(rv_i60_credit_seeking < 0.578620, 12.565879, 8.000000);

modinq_size_31_c1618 := if(nf_inq_adlsperaddr_count12 < 1.049266, 8.000000, 8.000000);

modinq_size_31_c1616 := if(nf_inq_count24 < 6.647069, modinq_size_31_c1617, modinq_size_31_c1618);

modinq_size_31_c1620 := if(nf_inq_lnamesperaddr_recency < 11.221552, 8.000000, 9.207392);

modinq_size_31_c1619 := if(nf_inq_addrsperssn_recency < 1.176058, modinq_size_31_c1620, 7.000000);

modinq_size_31_c1615 := if(rv_i60_inq_hiriskcred_recency < 16.520236, modinq_size_31_c1616, modinq_size_31_c1619);

modinq_size_31_c1621 := if(rv_i62_inq_ssnsperadl_count12 < 0.138047, 6.000000, 6.000000);

modinq_size_31_c1614 := if(nf_inq_curraddr_ver_count < 102.544015, modinq_size_31_c1615, modinq_size_31_c1621);

modinq_size_31_c1606 := if(nf_inq_percurraddr_count12 < 0.889205, modinq_size_31_c1607, modinq_size_31_c1614);

modinq_size_31_c1593 := if(rv_i60_inq_peradl_recency < 8.525904, modinq_size_31_c1594, modinq_size_31_c1606);

modinq_size_31_c1622 := if(nf_inq_auto_count < 0.536427, 3.000000, 3.000000);

modinq_size_31_c1592 := if(rv_i60_inq_retail_count12 < 2.940617, modinq_size_31_c1593, modinq_size_31_c1622);

modinq_size_31_c1629 := if(nf_inq_per_ssn < 3.921875, 9.207392, 11.941420);

modinq_size_31_c1628 := if(nf_inq_ssn_ver_count < 54.630651, modinq_size_31_c1629, 7.000000);

modinq_size_31_c1627 := if(nf_inquiry_addr_vel_risk_index < 6.741552, modinq_size_31_c1628, 6.000000);

modinq_size_31_c1626 := if(nf_inq_adlsperssn_count12 < 1.785708, modinq_size_31_c1627, 5.000000);

modinq_size_31_c1631 := if(rv_i62_inq_lnamesperadl_count12 < 1.801869, 6.000000, 6.000000);

modinq_size_31_c1630 := if(nf_inq_per_sfd_addr < 22.666911, modinq_size_31_c1631, 5.000000);

modinq_size_31_c1625 := if(nf_inq_percurraddr_count12 < 13.017518, modinq_size_31_c1626, modinq_size_31_c1630);

modinq_size_31_c1632 := if(nf_inq_ssnspercurraddr_count12 < 1.365850, 4.000000, 4.000000);

modinq_size_31_c1624 := if(nf_inq_lnamesperssn_count_week < 0.756572, modinq_size_31_c1625, modinq_size_31_c1632);

modinq_size_31_c1623 := if(rv_i61_inq_collection_count12 < 4.307417, modinq_size_31_c1624, 2.000000);

modinq_size_31 := if(rv_i60_inq_peradl_count12 < 5.405214, modinq_size_31_c1592, modinq_size_31_c1623);

modinq_size_32_c1640 := if(nf_inq_perbestssn_count12 < 2.614712, 17.437724, 13.334385);

modinq_size_32_c1639 := if(nf_inq_lnamesperaddr_count_day < 0.679344, modinq_size_32_c1640, 7.000000);

modinq_size_32_c1642 := if(rv_i60_inq_count12 < 1.599245, 8.000000, 8.000000);

modinq_size_32_c1641 := if(nf_inq_per_apt_addr < 0.467591, modinq_size_32_c1642, 7.000000);

modinq_size_32_c1638 := if(nf_inq_ssnsperaddr_count_week < 0.901735, modinq_size_32_c1639, modinq_size_32_c1641);

modinq_size_32_c1644 := if(nf_inq_bestdob_ver_count < 5.563710, 7.000000, 7.000000);

modinq_size_32_c1643 := if(rv_i62_inq_phonesperadl_recency < 2.555886, 6.000000, modinq_size_32_c1644);

modinq_size_32_c1637 := if(rv_i60_inq_count12 < 9.499177, modinq_size_32_c1638, modinq_size_32_c1643);

modinq_size_32_c1646 := if(nf_inq_per_ssn < 0.583240, 6.000000, 6.000000);

modinq_size_32_c1645 := if(nf_inq_highriskcredit_count24 < 0.530325, modinq_size_32_c1646, 5.000000);

modinq_size_32_c1636 := if(nf_inq_addr_recency_risk_index < 1.856138, modinq_size_32_c1637, modinq_size_32_c1645);

modinq_size_32_c1647 := if(nf_inq_lnames_per_addr < 3.960206, 4.000000, 4.000000);

modinq_size_32_c1635 := if(nf_inq_adlsperaddr_count12 < 3.880999, modinq_size_32_c1636, modinq_size_32_c1647);

modinq_size_32_c1653 := if(nf_inq_peraddr_count12 < 4.490721, 8.000000, 8.000000);

modinq_size_32_c1652 := if(rv_i62_inq_phones_per_adl < 2.663846, modinq_size_32_c1653, 7.000000);

modinq_size_32_c1655 := if(rv_i60_inq_other_count12 < 0.991481, 8.000000, 8.000000);

modinq_size_32_c1654 := if(nf_inq_lnames_per_sfd_addr < 2.543616, 7.000000, modinq_size_32_c1655);

modinq_size_32_c1651 := if(nf_inq_dobsperbestssn_count12 < 0.970359, modinq_size_32_c1652, modinq_size_32_c1654);

modinq_size_32_c1656 := if(nf_inq_bestssn_ver_count < 2.112546, 6.000000, 6.000000);

modinq_size_32_c1650 := if(nf_inq_dobsperssn_count_week < 0.770295, modinq_size_32_c1651, modinq_size_32_c1656);

modinq_size_32_c1649 := if(nf_inq_retailpayments_count < 0.383305, modinq_size_32_c1650, 4.000000);

modinq_size_32_c1658 := if(nf_inq_curraddr_ver_count < 12.669517, 5.000000, 5.000000);

modinq_size_32_c1657 := if(rv_i62_inq_dobsperadl_recency < 7.209882, modinq_size_32_c1658, 4.000000);

modinq_size_32_c1648 := if(rv_i62_inq_addrsperadl_recency < 7.941151, modinq_size_32_c1649, modinq_size_32_c1657);

modinq_size_32_c1634 := if(nf_inq_ssns_per_sfd_addr < 2.606829, modinq_size_32_c1635, modinq_size_32_c1648);

modinq_size_32_c1665 := if(nf_inq_banking_count < 1.258948, 9.207392, 8.000000);

modinq_size_32_c1666 := if(nf_inq_retail_count24 < 0.158234, 12.817256, 9.000000);

modinq_size_32_c1664 := if(nf_inq_lnamespercurraddr_count12 < 0.649179, modinq_size_32_c1665, modinq_size_32_c1666);

modinq_size_32_c1663 := if(nf_inq_lnamesperadl_count_day < 0.567700, modinq_size_32_c1664, 6.000000);

modinq_size_32_c1668 := if(nf_inq_per_addr < 1.195516, 7.000000, 7.000000);

modinq_size_32_c1667 := if(nf_inquiry_addr_vel_risk_index < 1.315573, modinq_size_32_c1668, 6.000000);

modinq_size_32_c1662 := if(nf_inq_lnamesperssn_count12 < 1.189927, modinq_size_32_c1663, modinq_size_32_c1667);

modinq_size_32_c1671 := if(rv_i60_inq_comm_recency < 4.645310, 7.000000, 7.000000);

modinq_size_32_c1670 := if(nf_inq_bestfname_ver_count < 78.810862, modinq_size_32_c1671, 6.000000);

modinq_size_32_c1669 := if(nf_inq_collection_count24 < 3.159504, modinq_size_32_c1670, 5.000000);

modinq_size_32_c1661 := if(nf_inq_per_ssn < 13.935127, modinq_size_32_c1662, modinq_size_32_c1669);

modinq_size_32_c1660 := if(nf_inq_utilities_count24 < 0.367503, modinq_size_32_c1661, 3.000000);

modinq_size_32_c1677 := if(nf_inq_peraddr_recency < 0.272262, 8.000000, 8.000000);

modinq_size_32_c1676 := if(nf_inq_other_count < 1.390379, 7.000000, modinq_size_32_c1677);

modinq_size_32_c1675 := if(nf_inq_ssn_ver_count < 10.292351, 6.000000, modinq_size_32_c1676);

modinq_size_32_c1674 := if(rv_i62_inq_dobs_per_adl < 1.380912, modinq_size_32_c1675, 5.000000);

modinq_size_32_c1673 := if(nf_inq_adlspercurraddr_count12 < 2.426928, modinq_size_32_c1674, 4.000000);

modinq_size_32_c1672 := if(nf_inq_ssnsperaddr_count_week < 0.571034, modinq_size_32_c1673, 3.000000);

modinq_size_32_c1659 := if(nf_inq_banking_count24 < 2.877869, modinq_size_32_c1660, modinq_size_32_c1672);

modinq_size_32 := if(nf_inq_addrs_per_ssn < 1.964642, modinq_size_32_c1634, modinq_size_32_c1659);

modinq_size_33_c1685 := if(nf_inq_lnames_per_apt_addr < 1.619981, 16.950055, 9.207392);

modinq_size_33_c1686 := if(nf_inq_highriskcredit_count24 < 2.099160, 15.440446, 11.023665);

modinq_size_33_c1684 := if(rv_i60_inq_peradl_count12 < 1.227046, modinq_size_33_c1685, modinq_size_33_c1686);

modinq_size_33_c1683 := if(rv_i60_inq_hiriskcred_count12 < 4.529810, modinq_size_33_c1684, 6.000000);

modinq_size_33_c1689 := if(nf_inq_ssns_per_addr < 1.151254, 13.744698, 8.000000);

modinq_size_33_c1688 := if(nf_inq_perssn_recency < 7.483179, modinq_size_33_c1689, 7.000000);

modinq_size_33_c1691 := if(nf_inquiry_verification_index < 28.851200, 8.000000, 8.000000);

modinq_size_33_c1690 := if(rv_i60_inq_retail_count12 < 0.489276, modinq_size_33_c1691, 7.000000);

modinq_size_33_c1687 := if(rv_i60_inq_mortgage_recency < 85.306241, modinq_size_33_c1688, modinq_size_33_c1690);

modinq_size_33_c1682 := if(nf_inq_bestdob_ver_count < 139.161771, modinq_size_33_c1683, modinq_size_33_c1687);

modinq_size_33_c1695 := if(nf_inq_addrsperssn_count_week < 0.944196, 8.000000, 9.851656);

modinq_size_33_c1694 := if(nf_inq_collection_count24 < 0.384586, modinq_size_33_c1695, 7.000000);

modinq_size_33_c1696 := if(rv_i62_inq_addrs_per_adl < 4.743234, 7.000000, 7.000000);

modinq_size_33_c1693 := if(nf_inq_perbestssn_count12 < 4.780457, modinq_size_33_c1694, modinq_size_33_c1696);

modinq_size_33_c1697 := if(nf_inq_banking_count < 0.739827, 6.000000, 6.000000);

modinq_size_33_c1692 := if(nf_inq_lnamesperadl_count_day < 0.975526, modinq_size_33_c1693, modinq_size_33_c1697);

modinq_size_33_c1681 := if(nf_inq_phonesperadl_count_week < 0.155503, modinq_size_33_c1682, modinq_size_33_c1692);

modinq_size_33_c1680 := if(nf_inq_count24 < 66.317126, modinq_size_33_c1681, 3.000000);

modinq_size_33_c1700 := if(rv_i61_inq_collection_recency < 15.470905, 5.000000, 5.000000);

modinq_size_33_c1699 := if(nf_inq_perssn_recency < 0.126622, modinq_size_33_c1700, 4.000000);

modinq_size_33_c1698 := if(nf_inq_perssn_recency < 7.148260, modinq_size_33_c1699, 3.000000);

modinq_size_33_c1679 := if(nf_invbest_inq_addrsperssn_diff < -0.214115, modinq_size_33_c1680, modinq_size_33_c1698);

//modinq_size_33 := if(nf_inq_dobsperssn_recency < -9766867306.223978, 1.000000, modinq_size_33_c1679);
modinq_size_33 := if(nf_inq_dobsperssn_recency < -999999998, 1.000000, modinq_size_33_c1679);

modinq_size_34_c1703 := if(nf_inq_adls_per_apt_addr < 1.764980, 3.000000, 3.000000);

modinq_size_34_c1702 := if(nf_inq_ssns_per_addr < 0.155975, 2.000000, modinq_size_34_c1703);

modinq_size_34_c1709 := if(rv_i62_inq_num_names_per_adl < 0.870224, 7.000000, 7.000000);

modinq_size_34_c1711 := if(rv_i62_inq_fnamesperadl_recency < 5.898524, 8.000000, 8.000000);

modinq_size_34_c1710 := if(rv_i62_inq_dobsperadl_recency < 2.364168, modinq_size_34_c1711, 7.000000);

modinq_size_34_c1708 := if(nf_inq_bestfname_ver_count < 1.671963, modinq_size_34_c1709, modinq_size_34_c1710);

modinq_size_34_c1707 := if(nf_inq_ssns_per_addr < 0.600414, modinq_size_34_c1708, 5.000000);

modinq_size_34_c1715 := if(nf_inq_ssns_per_addr < 2.849010, 16.979687, 9.207392);

modinq_size_34_c1716 := if(nf_inq_bestfname_ver_count < 25.159110, 10.706640, 8.000000);

modinq_size_34_c1714 := if(nf_inq_retailpayments_count24 < 0.945780, modinq_size_34_c1715, modinq_size_34_c1716);

modinq_size_34_c1718 := if(nf_inq_peraddr_count_week < 0.323140, 13.955690, 9.851656);

modinq_size_34_c1719 := if(rv_i60_inq_banking_recency < 18.297738, 8.000000, 8.000000);

modinq_size_34_c1717 := if(rv_i60_inq_auto_recency < 14.248695, modinq_size_34_c1718, modinq_size_34_c1719);

modinq_size_34_c1713 := if(rv_i62_inq_ssnsperadl_recency < 9.767970, modinq_size_34_c1714, modinq_size_34_c1717);

modinq_size_34_c1722 := if(rv_i62_inq_dobsperadl_recency < 4.318793, 12.695532, 11.941420);

modinq_size_34_c1721 := if(nf_inq_ssnsperaddr_count12 < 5.605471, modinq_size_34_c1722, 7.000000);

modinq_size_34_c1720 := if(nf_inq_perssn_count_day < 0.106801, modinq_size_34_c1721, 6.000000);

modinq_size_34_c1712 := if(rv_i61_inq_collection_count12 < 0.033527, modinq_size_34_c1713, modinq_size_34_c1720);

modinq_size_34_c1706 := if(nf_inquiry_verification_index < 20.870913, modinq_size_34_c1707, modinq_size_34_c1712);

modinq_size_34_c1727 := if(nf_invbest_inq_peraddr_diff < -1.963849, 9.000000, 13.590539);

modinq_size_34_c1728 := if(nf_inq_peraddr_count12 < 4.499282, 9.207392, 8.000000);

modinq_size_34_c1726 := if(rv_i62_inq_dobs_per_adl < 0.182519, modinq_size_34_c1727, modinq_size_34_c1728);

modinq_size_34_c1725 := if(nf_inq_per_ssn < 13.972341, modinq_size_34_c1726, 6.000000);

modinq_size_34_c1724 := if(nf_invbest_inq_lastperaddr_diff < -0.581362, modinq_size_34_c1725, 5.000000);

modinq_size_34_c1729 := if(rv_i60_inq_mortgage_recency < 89.975337, 5.000000, 5.000000);

modinq_size_34_c1723 := if(nf_inq_utilities_count < 0.964036, modinq_size_34_c1724, modinq_size_34_c1729);

modinq_size_34_c1705 := if(rv_i60_inq_auto_recency < 41.841836, modinq_size_34_c1706, modinq_size_34_c1723);

//modinq_size_34_c1704 := if(nf_inq_adls_per_addr < -2988548454.283608, 2.000000, modinq_size_34_c1705);
modinq_size_34_c1704 := if(nf_inq_adls_per_addr < -999999998, 2.000000, modinq_size_34_c1705);

//modinq_size_34 := if(rv_i62_inq_addrsperadl_recency < -8968434226.892757, modinq_size_34_c1702, modinq_size_34_c1704);
modinq_size_34 := if(rv_i62_inq_addrsperadl_recency < -999999998, modinq_size_34_c1702, modinq_size_34_c1704);

modinq_size_35_c1737 := if(nf_invbest_inq_lastperaddr_diff < -3.404439, 8.000000, 17.304740);

modinq_size_35_c1738 := if(nf_inq_auto_count < 1.738259, 13.955690, 9.000000);

modinq_size_35_c1736 := if(nf_inq_bestssn_ver_count < 20.965710, modinq_size_35_c1737, modinq_size_35_c1738);

modinq_size_35_c1740 := if(nf_inq_bestfname_ver_count < 4.230478, 8.000000, 9.851656);

modinq_size_35_c1739 := if(nf_inq_adlsperaddr_count_week < 0.007777, modinq_size_35_c1740, 7.000000);

modinq_size_35_c1735 := if(rv_i62_inq_addrsperadl_count12 < 1.635257, modinq_size_35_c1736, modinq_size_35_c1739);

modinq_size_35_c1743 := if(nf_inq_lnamesperssn_count_week < 0.167318, 12.278091, 9.000000);

modinq_size_35_c1744 := if(nf_inq_addrsperbestssn_count12 < 0.490712, 9.207392, 11.296252);

modinq_size_35_c1742 := if(nf_inq_adlspercurraddr_count12 < 0.823216, modinq_size_35_c1743, modinq_size_35_c1744);

modinq_size_35_c1745 := if(nf_invbest_inq_perssn_diff < -1.257904, 7.000000, 7.000000);

modinq_size_35_c1741 := if(nf_inq_prepaidcards_count < 0.122672, modinq_size_35_c1742, modinq_size_35_c1745);

modinq_size_35_c1734 := if(rv_i60_inq_peradl_count12 < 3.531849, modinq_size_35_c1735, modinq_size_35_c1741);

modinq_size_35_c1749 := if(rv_i62_inq_dobsperadl_recency < 4.686806, 8.000000, 9.207392);

modinq_size_35_c1748 := if(nf_inq_addrsperssn_count12 < 2.956314, modinq_size_35_c1749, 7.000000);

modinq_size_35_c1751 := if(nf_inq_addrsperbestssn_count12 < 2.861745, 12.116889, 9.000000);

modinq_size_35_c1752 := if(nf_inq_adlsperaddr_count12 < 0.107889, 8.000000, 9.000000);

modinq_size_35_c1750 := if(rv_i62_inq_dobs_per_adl < 1.221589, modinq_size_35_c1751, modinq_size_35_c1752);

modinq_size_35_c1747 := if(nf_inq_peraddr_recency < 0.074193, modinq_size_35_c1748, modinq_size_35_c1750);

modinq_size_35_c1753 := if(rv_i62_inq_addrsperadl_recency < 9.601864, 6.000000, 6.000000);

modinq_size_35_c1746 := if(rv_i62_inq_phonesperadl_count12 < 2.001509, modinq_size_35_c1747, modinq_size_35_c1753);

modinq_size_35_c1733 := if(nf_inq_addrs_per_ssn < 1.062244, modinq_size_35_c1734, modinq_size_35_c1746);

modinq_size_35_c1755 := if(nf_inq_collection_count < 2.413960, 5.000000, 5.000000);

modinq_size_35_c1754 := if(nf_invbest_inq_adlsperaddr_diff < 0.471319, modinq_size_35_c1755, 4.000000);

modinq_size_35_c1732 := if(nf_inq_addrs_per_ssn < 3.129704, modinq_size_35_c1733, modinq_size_35_c1754);

modinq_size_35_c1731 := if(nf_inq_prepaidcards_count24 < 1.526168, modinq_size_35_c1732, 2.000000);

modinq_size_35 := if(nf_inq_addrsperssn_count_day < 1.108760, modinq_size_35_c1731, 1.000000);

modinq_size_36_c1757 := if(nf_inq_adls_per_addr < 0.316620, 2.000000, 2.000000);

modinq_size_36_c1764 := if(nf_inq_adls_per_apt_addr < 1.749439, 15.622432, 9.000000);

modinq_size_36_c1765 := if(nf_inq_quizprovider_count < 6.595152, 12.695532, 8.000000);

modinq_size_36_c1763 := if(rv_i60_inq_other_recency < 27.440909, modinq_size_36_c1764, modinq_size_36_c1765);

modinq_size_36_c1767 := if(nf_inq_highriskcredit_count24 < 0.671399, 12.931969, 8.000000);

modinq_size_36_c1766 := if(rv_i62_inq_fnamesperadl_count12 < 0.082349, modinq_size_36_c1767, 7.000000);

modinq_size_36_c1762 := if(rv_i61_inq_collection_recency < 53.931473, modinq_size_36_c1763, modinq_size_36_c1766);

modinq_size_36_c1770 := if(rv_i62_inq_dobs_per_adl < 0.623765, 8.000000, 10.706640);

modinq_size_36_c1771 := if(nf_inq_collection_count < 0.130160, 8.000000, 8.000000);

modinq_size_36_c1769 := if(rv_i60_inq_peradl_count12 < 3.298730, modinq_size_36_c1770, modinq_size_36_c1771);

modinq_size_36_c1773 := if(rv_i60_inq_comm_count12 < 2.218361, 11.296252, 8.000000);

modinq_size_36_c1774 := if(nf_inq_addrs_per_ssn < 1.638260, 8.000000, 8.000000);

modinq_size_36_c1772 := if(nf_inq_retail_count < 0.553113, modinq_size_36_c1773, modinq_size_36_c1774);

modinq_size_36_c1768 := if(nf_inq_per_sfd_addr < 1.035435, modinq_size_36_c1769, modinq_size_36_c1772);

modinq_size_36_c1761 := if(rv_i62_inq_ssnsperadl_count12 < 0.233411, modinq_size_36_c1762, modinq_size_36_c1768);

modinq_size_36_c1760 := if(nf_inq_communications_count_week < 0.397209, modinq_size_36_c1761, 4.000000);

modinq_size_36_c1779 := if(nf_inq_retail_count24 < 0.393872, 15.893165, 10.706640);

modinq_size_36_c1780 := if(nf_inq_ssns_per_sfd_addr < 0.044478, 9.207392, 8.000000);

modinq_size_36_c1778 := if(nf_inq_highriskcredit_count24 < 2.450456, modinq_size_36_c1779, modinq_size_36_c1780);

modinq_size_36_c1782 := if(nf_inq_lname_ver_count < 31.365709, 8.000000, 8.000000);

modinq_size_36_c1781 := if(nf_inq_per_ssn < 8.995853, modinq_size_36_c1782, 7.000000);

modinq_size_36_c1777 := if(nf_inq_auto_count_week < 2.621895, modinq_size_36_c1778, modinq_size_36_c1781);

modinq_size_36_c1784 := if(nf_inq_other_count < 13.480972, 7.000000, 7.000000);

modinq_size_36_c1786 := if(nf_inq_banking_count < 1.751376, 10.706640, 8.000000);

modinq_size_36_c1785 := if(rv_i62_inq_addrsperadl_count12 < 3.361359, modinq_size_36_c1786, 7.000000);

modinq_size_36_c1783 := if(nf_inq_lnames_per_sfd_addr < -0.618844, modinq_size_36_c1784, modinq_size_36_c1785);

modinq_size_36_c1776 := if(rv_i62_inq_ssnsperadl_count12 < 1.001323, modinq_size_36_c1777, modinq_size_36_c1783);

modinq_size_36_c1787 := if(nf_inq_adlsperssn_recency < 10.924025, 5.000000, 5.000000);

modinq_size_36_c1775 := if(nf_inq_mortgage_count < 3.867739, modinq_size_36_c1776, modinq_size_36_c1787);

modinq_size_36_c1759 := if(nf_inq_auto_count < 0.411602, modinq_size_36_c1760, modinq_size_36_c1775);

modinq_size_36_c1793 := if(rv_i61_inq_collection_recency < 17.378099, 10.327020, 8.000000);

modinq_size_36_c1792 := if(nf_inq_collection_count < 11.662388, modinq_size_36_c1793, 7.000000);

modinq_size_36_c1791 := if(nf_inq_retail_count < 5.121964, modinq_size_36_c1792, 6.000000);

modinq_size_36_c1795 := if(nf_inq_bestphone_ver_count < 1.531130, 7.000000, 7.000000);

modinq_size_36_c1794 := if(rv_i60_inq_other_count12 < 2.799208, modinq_size_36_c1795, 6.000000);

modinq_size_36_c1790 := if(nf_inq_ssnspercurraddr_count12 < 0.768290, modinq_size_36_c1791, modinq_size_36_c1794);

modinq_size_36_c1799 := if(rv_i60_inq_banking_recency < 63.125479, 9.851656, 9.000000);

modinq_size_36_c1798 := if(nf_inq_quizprovider_count24 < 0.458879, modinq_size_36_c1799, 7.000000);

modinq_size_36_c1797 := if(nf_inq_mortgage_count < 0.191299, modinq_size_36_c1798, 6.000000);

modinq_size_36_c1796 := if(nf_invbest_inq_lastperaddr_diff < -1.808998, 5.000000, modinq_size_36_c1797);

modinq_size_36_c1789 := if(nf_inq_addrs_per_ssn < 0.733811, modinq_size_36_c1790, modinq_size_36_c1796);

modinq_size_36_c1788 := if(nf_invbest_inq_peraddr_diff < 0.877954, modinq_size_36_c1789, 3.000000);

modinq_size_36_c1758 := if(rv_i60_inq_retpymt_recency < 55.187961, modinq_size_36_c1759, modinq_size_36_c1788);

//modinq_size_36 := if(nf_inq_prepaidcards_count_day < -1018182597.952591, modinq_size_36_c1757, modinq_size_36_c1758);
modinq_size_36 := if(nf_inq_prepaidcards_count_day < -999999998, modinq_size_36_c1757, modinq_size_36_c1758);

modinq_size_37_c1807 := if(nf_inq_adlsperaddr_recency < 7.079182, 14.206270, 10.327020);

modinq_size_37_c1808 := if(nf_inq_ssn_ver_count < 1.654109, 8.000000, 9.000000);

modinq_size_37_c1806 := if(rv_i62_inq_phones_per_adl < 0.403145, modinq_size_37_c1807, modinq_size_37_c1808);

modinq_size_37_c1810 := if(nf_inquiry_verification_index < 27.445769, 9.000000, 8.000000);

modinq_size_37_c1811 := if(nf_inq_lnamesperbestssn_count12 < 0.067346, 8.000000, 8.000000);

modinq_size_37_c1809 := if(nf_inq_lnamespercurraddr_count12 < 1.446405, modinq_size_37_c1810, modinq_size_37_c1811);

modinq_size_37_c1805 := if(nf_inq_ssns_per_addr < 1.826543, modinq_size_37_c1806, modinq_size_37_c1809);

modinq_size_37_c1804 := if(nf_inq_highriskcredit_count24 < 0.626490, modinq_size_37_c1805, 5.000000);

modinq_size_37_c1812 := if(rv_i62_inq_fnamesperadl_count12 < 0.028581, 5.000000, 5.000000);

modinq_size_37_c1803 := if(nf_inq_collection_count24 < 0.900656, modinq_size_37_c1804, modinq_size_37_c1812);

modinq_size_37_c1813 := if(rv_i60_inq_count12 < 0.260786, 4.000000, 4.000000);

modinq_size_37_c1802 := if(nf_inq_lnames_per_apt_addr < 0.711770, modinq_size_37_c1803, modinq_size_37_c1813);

modinq_size_37_c1817 := if(nf_inq_lnamesperaddr_count_week < 1.581250, 6.000000, 6.000000);

modinq_size_37_c1816 := if(nf_inq_dobs_per_ssn < 0.076597, 5.000000, modinq_size_37_c1817);

modinq_size_37_c1815 := if(nf_inq_ssnspercurraddr_count12 < 1.918019, modinq_size_37_c1816, 4.000000);

modinq_size_37_c1814 := if(nf_inq_bestfname_ver_count < 2.907641, 3.000000, modinq_size_37_c1815);

modinq_size_37_c1801 := if(rv_i60_inq_auto_count12 < 0.220231, modinq_size_37_c1802, modinq_size_37_c1814);

modinq_size_37_c1824 := if(rv_i62_inq_fnamesperadl_count12 < 0.887659, 15.017693, 9.851656);

modinq_size_37_c1823 := if(nf_inq_ssnsperaddr_count12 < 0.422680, modinq_size_37_c1824, 7.000000);

modinq_size_37_c1826 := if(rv_i60_inq_banking_recency < 11.655433, 9.207392, 8.000000);

modinq_size_37_c1827 := if(rv_i60_inq_banking_recency < 91.035913, 8.000000, 8.000000);

modinq_size_37_c1825 := if(nf_invbest_inq_lastperaddr_diff < -0.323305, modinq_size_37_c1826, modinq_size_37_c1827);

modinq_size_37_c1822 := if(rv_i60_inq_hiriskcred_recency < 66.655398, modinq_size_37_c1823, modinq_size_37_c1825);

modinq_size_37_c1830 := if(nf_inq_quizprovider_count24 < 0.910085, 12.116889, 9.000000);

modinq_size_37_c1831 := if(nf_inq_collection_count < 4.795227, 9.851656, 8.000000);

modinq_size_37_c1829 := if(rv_i60_inq_retpymt_recency < 24.526256, modinq_size_37_c1830, modinq_size_37_c1831);

modinq_size_37_c1832 := if(nf_inq_bestlname_ver_count < 7.036436, 7.000000, 7.000000);

modinq_size_37_c1828 := if(nf_inq_perssn_recency < 8.224859, modinq_size_37_c1829, modinq_size_37_c1832);

modinq_size_37_c1821 := if(rv_i60_inq_mortgage_recency < 70.244920, modinq_size_37_c1822, modinq_size_37_c1828);

modinq_size_37_c1833 := if(rv_i60_inq_other_recency < 16.529199, 5.000000, 5.000000);

modinq_size_37_c1820 := if(rv_i60_inq_banking_count12 < 0.049375, modinq_size_37_c1821, modinq_size_37_c1833);

modinq_size_37_c1838 := if(nf_inq_adls_per_addr < 3.976205, 13.143309, 8.000000);

modinq_size_37_c1839 := if(nf_inq_highriskcredit_count < 1.391096, 11.023665, 9.000000);

modinq_size_37_c1837 := if(nf_inq_bestlname_ver_count < 18.934506, modinq_size_37_c1838, modinq_size_37_c1839);

modinq_size_37_c1841 := if(rv_i60_inq_other_count12 < 0.370307, 11.023665, 9.851656);

modinq_size_37_c1840 := if(nf_inq_lnames_per_sfd_addr < 2.035068, modinq_size_37_c1841, 7.000000);

modinq_size_37_c1836 := if(rv_i60_inq_peradl_recency < 2.174894, modinq_size_37_c1837, modinq_size_37_c1840);

modinq_size_37_c1842 := if(nf_inq_fnamesperadl_count_week < 0.018480, 6.000000, 6.000000);

modinq_size_37_c1835 := if(nf_inq_peraddr_count_week < 0.471395, modinq_size_37_c1836, modinq_size_37_c1842);

modinq_size_37_c1834 := if(nf_inq_ssns_per_sfd_addr < 3.404159, modinq_size_37_c1835, 4.000000);

modinq_size_37_c1819 := if(nf_inq_adlsperaddr_recency < 0.564832, modinq_size_37_c1820, modinq_size_37_c1834);

modinq_size_37_c1848 := if(nf_inq_ssnsperadl_count_day < 0.611133, 14.896393, 9.000000);

modinq_size_37_c1847 := if(nf_inq_other_count_week < 0.652489, modinq_size_37_c1848, 7.000000);

modinq_size_37_c1850 := if(rv_i60_inq_auto_count12 < 8.791111, 12.278091, 8.000000);

modinq_size_37_c1849 := if(nf_inq_lnamesperadl_count_day < 0.415346, modinq_size_37_c1850, 7.000000);

modinq_size_37_c1846 := if(nf_inquiry_ssn_vel_risk_indexv2 < 1.803911, modinq_size_37_c1847, modinq_size_37_c1849);

modinq_size_37_c1845 := if(rv_i62_inq_addrs_per_adl < 4.353298, modinq_size_37_c1846, 5.000000);

modinq_size_37_c1844 := if(nf_inq_adlsperbestphone_count12 < 1.592023, modinq_size_37_c1845, 4.000000);

modinq_size_37_c1843 := if(nf_inq_bestfname_ver_count < 89.053186, modinq_size_37_c1844, 3.000000);

modinq_size_37_c1818 := if(nf_inq_addrsperssn_recency < 0.550739, modinq_size_37_c1819, modinq_size_37_c1843);

modinq_size_37 := if(nf_inq_bestfname_ver_count < 3.500093, modinq_size_37_c1801, modinq_size_37_c1818);

modinq_size_38_c1852 := if(nf_inq_lnames_per_sfd_addr < -1047270012.413004, 2.000000, 2.000000);

modinq_size_38_c1859 := if(nf_inq_count24 < 3.100885, 17.354127, 14.531555);

modinq_size_38_c1860 := if(nf_inq_per_addr < 2.564141, 9.000000, 9.000000);

modinq_size_38_c1858 := if(nf_inq_auto_count < 13.218253, modinq_size_38_c1859, modinq_size_38_c1860);

modinq_size_38_c1862 := if(nf_inq_ssns_per_sfd_addr < 2.646070, 8.000000, 8.000000);

modinq_size_38_c1861 := if(nf_inq_addrsperbestssn_count12 < 0.474081, 7.000000, modinq_size_38_c1862);

modinq_size_38_c1857 := if(nf_inq_other_count_week < 0.665065, modinq_size_38_c1858, modinq_size_38_c1861);

modinq_size_38_c1865 := if(rv_i61_inq_collection_recency < 22.569268, 8.000000, 9.851656);

modinq_size_38_c1864 := if(rv_i60_inq_prepaidcards_recency < 56.370623, modinq_size_38_c1865, 7.000000);

modinq_size_38_c1863 := if(nf_inq_bestdob_ver_count < 2.310689, 6.000000, modinq_size_38_c1864);

modinq_size_38_c1856 := if(nf_inq_ssns_per_apt_addr < 0.766421, modinq_size_38_c1857, modinq_size_38_c1863);

modinq_size_38_c1867 := if(nf_inq_peraddr_recency < 0.369608, 6.000000, 6.000000);

modinq_size_38_c1866 := if(nf_inq_lnamespercurraddr_count12 < 0.169466, modinq_size_38_c1867, 5.000000);

modinq_size_38_c1855 := if(rv_i60_inq_util_recency < 3.557203, modinq_size_38_c1856, modinq_size_38_c1866);

modinq_size_38_c1872 := if(nf_inq_lnames_per_apt_addr < 0.441993, 13.143309, 9.000000);

modinq_size_38_c1873 := if(nf_invbest_inq_adlsperaddr_diff < 1.162803, 10.327020, 8.000000);

modinq_size_38_c1871 := if(rv_i60_inq_hiriskcred_count12 < 0.540427, modinq_size_38_c1872, modinq_size_38_c1873);

modinq_size_38_c1870 := if(nf_inq_mortgage_count24 < 1.075679, modinq_size_38_c1871, 6.000000);

modinq_size_38_c1869 := if(nf_inq_phonesperadl_count_day < 0.320979, modinq_size_38_c1870, 5.000000);

modinq_size_38_c1868 := if(nf_inquiry_verification_index < 26.632146, 4.000000, modinq_size_38_c1869);

modinq_size_38_c1854 := if(nf_inq_perbestssn_count12 < 5.311658, modinq_size_38_c1855, modinq_size_38_c1868);

modinq_size_38_c1874 := if(nf_inq_addrsperssn_count_week < 1.231434, 3.000000, 3.000000);

modinq_size_38_c1853 := if(nf_inq_peraddr_count_day < 1.474328, modinq_size_38_c1854, modinq_size_38_c1874);

//modinq_size_38 := if(nf_inq_mortgage_count_week < -1445738614.857909, modinq_size_38_c1852, modinq_size_38_c1853);
modinq_size_38 := if(nf_inq_mortgage_count_week < -999999998, modinq_size_38_c1852, modinq_size_38_c1853);

modinq_size_39_c1882 := if(rv_i60_inq_mortgage_recency < 36.012612, 16.039594, 12.116889);

modinq_size_39_c1883 := if(rv_i60_inq_peradl_recency < 4.283036, 8.000000, 9.000000);

modinq_size_39_c1881 := if(rv_i62_inq_fnamesperadl_count12 < 0.488633, modinq_size_39_c1882, modinq_size_39_c1883);

modinq_size_39_c1885 := if(nf_inq_per_apt_addr < 1.816038, 9.207392, 8.000000);

modinq_size_39_c1884 := if(nf_inq_retail_count24 < 0.484568, modinq_size_39_c1885, 7.000000);

modinq_size_39_c1880 := if(nf_inq_ssns_per_apt_addr < 0.368558, modinq_size_39_c1881, modinq_size_39_c1884);

modinq_size_39_c1888 := if(nf_inquiry_ssn_vel_risk_index < 2.454507, 14.580971, 10.327020);

modinq_size_39_c1889 := if(nf_inq_addr_ver_count < 11.308281, 12.427187, 8.000000);

modinq_size_39_c1887 := if(rv_i60_inq_other_count12 < 1.185058, modinq_size_39_c1888, modinq_size_39_c1889);

modinq_size_39_c1890 := if(rv_i60_inq_comm_recency < 5.747434, 7.000000, 7.000000);

modinq_size_39_c1886 := if(nf_inq_lname_ver_count < 47.348836, modinq_size_39_c1887, modinq_size_39_c1890);

modinq_size_39_c1879 := if(rv_i60_inq_count12 < 0.754183, modinq_size_39_c1880, modinq_size_39_c1886);

modinq_size_39_c1894 := if(nf_inquiry_addr_vel_risk_index < 3.413000, 9.207392, 8.000000);

modinq_size_39_c1895 := if(nf_inq_per_addr < 19.290386, 8.000000, 8.000000);

modinq_size_39_c1893 := if(nf_inq_other_count24 < 3.146770, modinq_size_39_c1894, modinq_size_39_c1895);

modinq_size_39_c1892 := if(rv_i62_inq_dobs_per_adl < 0.185356, 6.000000, modinq_size_39_c1893);

modinq_size_39_c1891 := if(rv_i62_inq_num_names_per_adl < 0.531861, 5.000000, modinq_size_39_c1892);

modinq_size_39_c1878 := if(nf_inq_adlsperaddr_count12 < 2.305857, modinq_size_39_c1879, modinq_size_39_c1891);

modinq_size_39_c1899 := if(nf_inq_auto_count < 1.714369, 7.000000, 7.000000);

modinq_size_39_c1901 := if(rv_i60_inq_comm_count12 < 0.973235, 9.000000, 8.000000);

modinq_size_39_c1900 := if(nf_inq_adlspercurraddr_count12 < 0.043759, modinq_size_39_c1901, 7.000000);

modinq_size_39_c1898 := if(nf_inq_lnamesperssn_recency < 8.244149, modinq_size_39_c1899, modinq_size_39_c1900);

modinq_size_39_c1897 := if(rv_i60_inq_mortgage_count12 < 1.317466, modinq_size_39_c1898, 5.000000);

modinq_size_39_c1902 := if(rv_i62_inq_dobsperadl_count12 < 0.328986, 5.000000, 5.000000);

modinq_size_39_c1896 := if(nf_inq_ssns_per_addr < 0.595874, modinq_size_39_c1897, modinq_size_39_c1902);

modinq_size_39_c1877 := if(rv_i60_inq_mortgage_count12 < 0.443452, modinq_size_39_c1878, modinq_size_39_c1896);

modinq_size_39_c1906 := if(nf_inq_curraddr_ver_count < 7.040020, 6.000000, 6.000000);

modinq_size_39_c1907 := if(nf_inq_quizprovider_count < 0.505824, 6.000000, 6.000000);

modinq_size_39_c1905 := if(nf_inq_lname_ver_count < 14.787285, modinq_size_39_c1906, modinq_size_39_c1907);

modinq_size_39_c1911 := if(nf_inq_adls_per_ssn < 0.228178, 8.000000, 8.000000);

modinq_size_39_c1910 := if(rv_i60_inq_auto_count12 < 1.671510, modinq_size_39_c1911, 7.000000);

modinq_size_39_c1909 := if(nf_invbest_inq_peraddr_diff < 2.448090, modinq_size_39_c1910, 6.000000);

modinq_size_39_c1908 := if(nf_inq_dobs_per_ssn < 1.883522, modinq_size_39_c1909, 5.000000);

modinq_size_39_c1904 := if(nf_inq_lnames_per_sfd_addr < 0.880283, modinq_size_39_c1905, modinq_size_39_c1908);

modinq_size_39_c1912 := if(nf_inq_adls_per_sfd_addr < 2.367371, 4.000000, 4.000000);

modinq_size_39_c1903 := if(nf_inq_lnamesperaddr_recency < 5.895484, modinq_size_39_c1904, modinq_size_39_c1912);

modinq_size_39_c1876 := if(nf_inq_lnamesperadl_count_week < 0.313393, modinq_size_39_c1877, modinq_size_39_c1903);

modinq_size_39_c1916 := if(rv_i62_inq_phonesperadl_count12 < 0.647015, 5.000000, 5.000000);

modinq_size_39_c1920 := if(nf_inq_peraddr_count12 < 3.417538, 13.241134, 9.207392);

modinq_size_39_c1921 := if(nf_inq_auto_count24 < 4.845297, 12.565879, 9.000000);

modinq_size_39_c1919 := if(nf_inq_adlsperbestssn_count12 < 0.328708, modinq_size_39_c1920, modinq_size_39_c1921);

modinq_size_39_c1923 := if(nf_inq_lnamesperssn_recency < 10.689575, 8.000000, 9.207392);

modinq_size_39_c1922 := if(nf_inq_curraddr_ver_count < 4.920723, modinq_size_39_c1923, 7.000000);

modinq_size_39_c1918 := if(nf_inq_perssn_count12 < 4.600217, modinq_size_39_c1919, modinq_size_39_c1922);

modinq_size_39_c1926 := if(nf_inq_bestssn_ver_count < 115.153247, 8.000000, 9.207392);

modinq_size_39_c1927 := if(nf_inq_retailpayments_count < 0.932271, 8.000000, 8.000000);

modinq_size_39_c1925 := if(nf_inq_perssn_count12 < 0.093291, modinq_size_39_c1926, modinq_size_39_c1927);

modinq_size_39_c1924 := if(nf_inq_per_sfd_addr < 3.338145, modinq_size_39_c1925, 6.000000);

modinq_size_39_c1917 := if(nf_inq_bestdob_ver_count < 159.122927, modinq_size_39_c1918, modinq_size_39_c1924);

modinq_size_39_c1915 := if(nf_invbest_inq_ssnsperaddr_diff < -1.674522, modinq_size_39_c1916, modinq_size_39_c1917);

modinq_size_39_c1914 := if(nf_inq_per_addr < 8.317113, modinq_size_39_c1915, 3.000000);

modinq_size_39_c1930 := if(nf_inq_lnamespercurraddr_count12 < 1.120720, 5.000000, 5.000000);

modinq_size_39_c1929 := if(rv_i62_inq_phones_per_adl < 0.864539, 4.000000, modinq_size_39_c1930);

modinq_size_39_c1928 := if(nf_inquiry_adl_vel_risk_index < 3.328185, modinq_size_39_c1929, 3.000000);

modinq_size_39_c1913 := if(nf_inq_ssns_per_sfd_addr < 2.814340, modinq_size_39_c1914, modinq_size_39_c1928);

modinq_size_39 := if(nf_inq_adlsperaddr_recency < 11.598539, modinq_size_39_c1876, modinq_size_39_c1913);

modinq_size_40_c1938 := if(nf_inq_perssn_count_week < 2.349050, 17.266882, 9.000000);

modinq_size_40_c1937 := if(rv_i62_inq_phones_per_adl < 2.106397, modinq_size_40_c1938, 7.000000);

modinq_size_40_c1940 := if(nf_inq_lname_ver_count < 36.105943, 8.000000, 8.000000);

modinq_size_40_c1939 := if(nf_inq_adls_per_sfd_addr < 2.627215, modinq_size_40_c1940, 7.000000);

modinq_size_40_c1936 := if(nf_inq_banking_count < 9.179859, modinq_size_40_c1937, modinq_size_40_c1939);

modinq_size_40_c1943 := if(nf_inq_ssnsperaddr_count12 < 3.724523, 11.296252, 8.000000);

modinq_size_40_c1944 := if(nf_inq_adlsperbestssn_count12 < 1.900837, 10.327020, 8.000000);

modinq_size_40_c1942 := if(nf_inq_highriskcredit_count24 < 0.009041, modinq_size_40_c1943, modinq_size_40_c1944);

modinq_size_40_c1941 := if(nf_inq_prepaidcards_count < 0.795598, modinq_size_40_c1942, 6.000000);

modinq_size_40_c1935 := if(nf_inquiry_ssn_vel_risk_indexv2 < 0.180533, modinq_size_40_c1936, modinq_size_40_c1941);

modinq_size_40_c1948 := if(rv_i60_inq_recency < 2.565307, 8.000000, 9.000000);

modinq_size_40_c1949 := if(nf_inq_utilities_count < 0.251724, 8.000000, 8.000000);

modinq_size_40_c1947 := if(nf_inq_other_count < 0.770768, modinq_size_40_c1948, modinq_size_40_c1949);

modinq_size_40_c1951 := if(nf_inq_adlspercurraddr_count12 < 0.394780, 8.000000, 8.000000);

modinq_size_40_c1950 := if(nf_inq_per_ssn < 2.249895, modinq_size_40_c1951, 7.000000);

modinq_size_40_c1946 := if(rv_i62_inq_phonesperadl_recency < 1.866971, modinq_size_40_c1947, modinq_size_40_c1950);

modinq_size_40_c1954 := if(nf_inq_other_count < 0.931112, 9.000000, 9.851656);

modinq_size_40_c1953 := if(rv_i62_inq_num_names_per_adl < 0.514506, 7.000000, modinq_size_40_c1954);

modinq_size_40_c1952 := if(nf_inq_mortgage_count < 2.640855, modinq_size_40_c1953, 6.000000);

modinq_size_40_c1945 := if(nf_inq_lnamesperaddr_recency < 7.474525, modinq_size_40_c1946, modinq_size_40_c1952);

modinq_size_40_c1934 := if(nf_inq_adlsperbestphone_count12 < 0.090523, modinq_size_40_c1935, modinq_size_40_c1945);

modinq_size_40_c1959 := if(nf_inq_ssn_ver_count < 6.442456, 14.021342, 9.207392);

modinq_size_40_c1960 := if(nf_inq_peraddr_count_week < 2.948200, 12.565879, 8.000000);

modinq_size_40_c1958 := if(rv_i60_inq_other_recency < 22.481764, modinq_size_40_c1959, modinq_size_40_c1960);

modinq_size_40_c1957 := if(nf_inq_bestssn_ver_count < 68.957986, modinq_size_40_c1958, 6.000000);

modinq_size_40_c1963 := if(rv_i60_inq_other_recency < 82.565104, 8.000000, 8.000000);

modinq_size_40_c1964 := if(nf_inq_per_addr < 3.203095, 9.000000, 8.000000);

modinq_size_40_c1962 := if(rv_i60_inq_auto_recency < 4.007757, modinq_size_40_c1963, modinq_size_40_c1964);

modinq_size_40_c1961 := if(nf_inq_lnames_per_apt_addr < 0.805824, modinq_size_40_c1962, 6.000000);

modinq_size_40_c1956 := if(nf_inq_retailpayments_count < 0.767638, modinq_size_40_c1957, modinq_size_40_c1961);

//modinq_size_40_c1955 := if(nf_inq_per_sfd_addr < -4315627528.340405, 4.000000, modinq_size_40_c1956);
modinq_size_40_c1955 := if(nf_inq_per_sfd_addr < -999999998, 4.000000, modinq_size_40_c1956);

modinq_size_40_c1933 := if(rv_i60_inq_recency < 30.817635, modinq_size_40_c1934, modinq_size_40_c1955);

modinq_size_40_c1965 := if(rv_i60_inq_count12 < 2.942917, 3.000000, 3.000000);

modinq_size_40_c1932 := if(nf_inq_addrsperadl_count_day < 0.564150, modinq_size_40_c1933, modinq_size_40_c1965);

//modinq_size_40 := if(nf_inq_prepaidcards_count < -2577357566.759231, 1.000000, modinq_size_40_c1932);
modinq_size_40 := if(nf_inq_prepaidcards_count < -999999998, 1.000000, modinq_size_40_c1932);

modinq_size_41_c1973 := if(rv_i60_inq_auto_count12 < 6.992497, 16.858431, 8.000000);

modinq_size_41_c1974 := if(nf_inq_lnamespercurraddr_count12 < 2.971439, 12.817256, 9.851656);

modinq_size_41_c1972 := if(nf_inq_ssnspercurraddr_count12 < 1.467502, modinq_size_41_c1973, modinq_size_41_c1974);

modinq_size_41_c1976 := if(nf_inq_per_ssn < 7.345988, 9.207392, 8.000000);

modinq_size_41_c1977 := if(nf_inq_peradl_count_day < 5.038957, 8.000000, 8.000000);

modinq_size_41_c1975 := if(nf_inq_addrsperssn_count_day < 0.105649, modinq_size_41_c1976, modinq_size_41_c1977);

modinq_size_41_c1971 := if(nf_inq_addrsperadl_count_week < 0.553072, modinq_size_41_c1972, modinq_size_41_c1975);

modinq_size_41_c1980 := if(rv_i60_inq_hiriskcred_recency < 17.032550, 13.040438, 8.000000);

modinq_size_41_c1981 := if(nf_inq_lnames_per_apt_addr < -0.763073, 13.040438, 8.000000);

modinq_size_41_c1979 := if(rv_i61_inq_collection_recency < 31.120079, modinq_size_41_c1980, modinq_size_41_c1981);

modinq_size_41_c1983 := if(nf_inq_peradl_count_day < 1.686906, 10.327020, 8.000000);

modinq_size_41_c1982 := if(rv_i62_inq_dobsperadl_count12 < 1.956361, modinq_size_41_c1983, 7.000000);

modinq_size_41_c1978 := if(rv_i60_inq_hiriskcred_recency < 71.943394, modinq_size_41_c1979, modinq_size_41_c1982);

modinq_size_41_c1970 := if(rv_i62_inq_addrsperadl_recency < 8.249232, modinq_size_41_c1971, modinq_size_41_c1978);

modinq_size_41_c1985 := if(nf_inq_addr_ver_count < 2.200177, 6.000000, 6.000000);

modinq_size_41_c1984 := if(nf_inq_count24 < 8.375895, modinq_size_41_c1985, 5.000000);

modinq_size_41_c1969 := if(rv_i60_inq_retail_count12 < 1.913302, modinq_size_41_c1970, modinq_size_41_c1984);

modinq_size_41_c1968 := if(nf_inq_addrsperssn_count12 < 4.544978, modinq_size_41_c1969, 3.000000);

modinq_size_41_c1991 := if(nf_inq_adls_per_ssn < 0.789062, 11.748880, 9.000000);

modinq_size_41_c1992 := if(rv_i60_inq_peradl_recency < 4.305188, 9.000000, 8.000000);

modinq_size_41_c1990 := if(nf_inq_addrsperssn_count12 < 0.954049, modinq_size_41_c1991, modinq_size_41_c1992);

modinq_size_41_c1994 := if(nf_inq_curraddr_ver_count < 14.215217, 8.000000, 8.000000);

modinq_size_41_c1995 := if(nf_inq_ssns_per_addr < 2.577407, 11.296252, 8.000000);

modinq_size_41_c1993 := if(nf_inq_lnamesperaddr_recency < 2.969613, modinq_size_41_c1994, modinq_size_41_c1995);

modinq_size_41_c1989 := if(nf_inq_peraddr_recency < 0.590157, modinq_size_41_c1990, modinq_size_41_c1993);

modinq_size_41_c1998 := if(nf_inq_peraddr_recency < 0.707036, 8.000000, 8.000000);

modinq_size_41_c1997 := if(nf_inq_perbestssn_count12 < 3.924777, modinq_size_41_c1998, 7.000000);

modinq_size_41_c1996 := if(nf_inq_mortgage_count < 1.189853, modinq_size_41_c1997, 6.000000);

modinq_size_41_c1988 := if(rv_i60_inq_comm_recency < 43.006572, modinq_size_41_c1989, modinq_size_41_c1996);

modinq_size_41_c1987 := if(nf_inq_per_apt_addr < 8.194911, modinq_size_41_c1988, 4.000000);

modinq_size_41_c2003 := if(nf_inq_lname_ver_count < 5.904226, 8.000000, 9.000000);

modinq_size_41_c2002 := if(nf_inq_retail_count < 3.608982, modinq_size_41_c2003, 7.000000);

modinq_size_41_c2005 := if(rv_i60_inq_count12 < 0.418976, 9.207392, 8.000000);

modinq_size_41_c2006 := if(nf_inq_curraddr_ver_count < 9.779373, 9.207392, 9.000000);

modinq_size_41_c2004 := if(rv_i62_inq_ssnsperadl_count12 < 0.539287, modinq_size_41_c2005, modinq_size_41_c2006);

modinq_size_41_c2001 := if(nf_inq_count24 < 0.092942, modinq_size_41_c2002, modinq_size_41_c2004);

modinq_size_41_c2007 := if(nf_inq_perbestssn_count12 < 6.335378, 6.000000, 6.000000);

modinq_size_41_c2000 := if(nf_inq_bestlname_ver_count < 25.488112, modinq_size_41_c2001, modinq_size_41_c2007);

modinq_size_41_c2008 := if(nf_inq_lnames_per_sfd_addr < 0.852265, 5.000000, 5.000000);

modinq_size_41_c1999 := if(nf_inq_adlsperaddr_count_week < 0.775042, modinq_size_41_c2000, modinq_size_41_c2008);

modinq_size_41_c1986 := if(rv_i60_inq_retail_recency < 40.264757, modinq_size_41_c1987, modinq_size_41_c1999);

modinq_size_41_c1967 := if(rv_i60_inq_other_recency < 25.261707, modinq_size_41_c1968, modinq_size_41_c1986);

//modinq_size_41 := if(nf_inq_peradl_count_day < -2629383593.691849, 1.000000, modinq_size_41_c1967);
modinq_size_41 := if(nf_inq_peradl_count_day < -999999998, 1.000000, modinq_size_41_c1967);

modinq_size_42_c2016 := if(nf_inq_perbestphone_count12 < 0.228530, 17.584273, 11.023665);

modinq_size_42_c2015 := if(nf_inq_ssnsperaddr_count_day < 0.205539, modinq_size_42_c2016, 7.000000);

modinq_size_42_c2018 := if(nf_inq_other_count < 1.975061, 9.000000, 8.000000);

modinq_size_42_c2019 := if(nf_inq_perbestphone_count12 < 1.347093, 8.000000, 8.000000);

modinq_size_42_c2017 := if(nf_inq_adls_per_ssn < 0.919305, modinq_size_42_c2018, modinq_size_42_c2019);

modinq_size_42_c2014 := if(nf_inq_banking_count < 4.745475, modinq_size_42_c2015, modinq_size_42_c2017);

modinq_size_42_c2022 := if(nf_inq_ssn_ver_count < 78.222330, 12.278091, 8.000000);

modinq_size_42_c2023 := if(nf_inq_retailpayments_count24 < 1.386170, 14.146509, 8.000000);

modinq_size_42_c2021 := if(nf_inq_ssns_per_addr < 0.041836, modinq_size_42_c2022, modinq_size_42_c2023);

modinq_size_42_c2025 := if(nf_inq_addrsperssn_count12 < 1.358996, 8.000000, 8.000000);

modinq_size_42_c2026 := if(rv_i60_inq_retail_recency < 0.861959, 9.000000, 8.000000);

modinq_size_42_c2024 := if(nf_inq_bestdob_ver_count < 13.937665, modinq_size_42_c2025, modinq_size_42_c2026);

modinq_size_42_c2020 := if(rv_i62_inq_ssnsperadl_count12 < 1.327814, modinq_size_42_c2021, modinq_size_42_c2024);

modinq_size_42_c2013 := if(nf_inq_adlsperssn_recency < 6.892258, modinq_size_42_c2014, modinq_size_42_c2020);

modinq_size_42_c2027 := if(rv_i62_inq_phones_per_adl < 4.829585, 5.000000, 5.000000);

modinq_size_42_c2012 := if(rv_i62_inq_lnamesperadl_count12 < 2.106555, modinq_size_42_c2013, modinq_size_42_c2027);

modinq_size_42_c2011 := if(nf_inq_banking_count < 25.760346, modinq_size_42_c2012, 3.000000);

modinq_size_42_c2028 := if(nf_inq_fname_ver_count < 15.773536, 3.000000, 3.000000);

modinq_size_42_c2010 := if(nf_inq_fnamesperadl_count_day < 0.113687, modinq_size_42_c2011, modinq_size_42_c2028);

//modinq_size_42 := if(nf_inq_prepaidcards_count_day < -7957047593.449819, 1.000000, modinq_size_42_c2010);
modinq_size_42 := if(nf_inq_prepaidcards_count_day < -999999998, 1.000000, modinq_size_42_c2010);

modinq_size_43_c2036 := if(nf_inq_adlspercurraddr_count12 < 1.902254, 16.842743, 8.000000);

modinq_size_43_c2035 := if(nf_inq_highriskcredit_count24 < 5.949768, modinq_size_43_c2036, 7.000000);

modinq_size_43_c2038 := if(rv_i62_inq_ssns_per_adl < 1.495577, 12.116889, 8.000000);

modinq_size_43_c2039 := if(rv_i60_inq_retail_recency < 86.581765, 10.706640, 8.000000);

modinq_size_43_c2037 := if(rv_i60_inq_auto_recency < 10.063556, modinq_size_43_c2038, modinq_size_43_c2039);

modinq_size_43_c2034 := if(nf_inq_lnamesperaddr_recency < 2.653264, modinq_size_43_c2035, modinq_size_43_c2037);

modinq_size_43_c2033 := if(nf_inq_utilities_count24 < 0.163270, modinq_size_43_c2034, 5.000000);

modinq_size_43_c2043 := if(nf_inq_bestfname_ver_count < 175.134198, 15.943176, 9.000000);

modinq_size_43_c2044 := if(nf_inquiry_addr_vel_risk_indexv2 < 0.496949, 9.000000, 8.000000);

modinq_size_43_c2042 := if(nf_inq_perssn_count12 < 5.800270, modinq_size_43_c2043, modinq_size_43_c2044);

modinq_size_43_c2046 := if(nf_inq_collection_count_week < 0.521924, 11.296252, 8.000000);

modinq_size_43_c2045 := if(nf_invbest_inq_lastperaddr_diff < -0.253942, modinq_size_43_c2046, 7.000000);

modinq_size_43_c2041 := if(rv_i60_inq_comm_recency < 93.685198, modinq_size_43_c2042, modinq_size_43_c2045);

modinq_size_43_c2040 := if(nf_inq_fnamesperadl_count_week < 0.103265, modinq_size_43_c2041, 5.000000);

modinq_size_43_c2032 := if(nf_inq_ssnspercurraddr_count12 < 0.217940, modinq_size_43_c2033, modinq_size_43_c2040);

modinq_size_43_c2031 := if(nf_invbest_inq_adlsperssn_diff < -0.232643, modinq_size_43_c2032, 3.000000);

modinq_size_43_c2030 := if(rv_i60_inq_mortgage_count12 < 1.120227, modinq_size_43_c2031, 2.000000);

modinq_size_43_c2052 := if(rv_i60_inq_other_count12 < 0.494928, 7.000000, 7.000000);

modinq_size_43_c2051 := if(rv_i60_inq_peradl_count12 < 3.547683, modinq_size_43_c2052, 6.000000);

modinq_size_43_c2050 := if(nf_inq_ssnsperaddr_count12 < 2.395648, modinq_size_43_c2051, 5.000000);

modinq_size_43_c2049 := if(nf_inq_communications_count < 0.929901, modinq_size_43_c2050, 4.000000);

modinq_size_43_c2048 := if(nf_inq_percurraddr_count12 < 3.941884, modinq_size_43_c2049, 3.000000);

modinq_size_43_c2047 := if(rv_i62_inq_ssns_per_adl < 1.954360, modinq_size_43_c2048, 2.000000);

modinq_size_43 := if(nf_inq_ssnsperadl_count_week < 0.164875, modinq_size_43_c2030, modinq_size_43_c2047);

modinq_size_44_c2060 := if(nf_inq_quizprovider_count24 < 0.833407, 8.000000, 8.000000);

modinq_size_44_c2059 := if(nf_inq_ssn_ver_count < 0.926497, modinq_size_44_c2060, 7.000000);

modinq_size_44_c2058 := if(nf_inq_retail_count24 < 0.154196, modinq_size_44_c2059, 6.000000);

modinq_size_44_c2061 := if(nf_inq_adls_per_addr < 0.667722, 6.000000, 6.000000);

modinq_size_44_c2057 := if(nf_inq_ssnspercurraddr_count12 < 0.835650, modinq_size_44_c2058, modinq_size_44_c2061);

modinq_size_44_c2062 := if(nf_inquiry_verification_index < 15.488713, 5.000000, 5.000000);

modinq_size_44_c2056 := if(nf_inq_count < 2.996590, modinq_size_44_c2057, modinq_size_44_c2062);

modinq_size_44_c2063 := if(nf_inq_count < 8.304543, 4.000000, 4.000000);

modinq_size_44_c2055 := if(rv_i60_inq_peradl_count12 < 1.674297, modinq_size_44_c2056, modinq_size_44_c2063);

modinq_size_44_c2054 := if(rv_i60_inq_comm_count12 < 4.610003, modinq_size_44_c2055, 2.000000);

modinq_size_44_c2070 := if(nf_inq_perbestphone_count12 < 1.627988, 17.094009, 8.000000);

modinq_size_44_c2071 := if(nf_inq_count_week < 2.487136, 8.000000, 8.000000);

modinq_size_44_c2069 := if(nf_inq_addrsperadl_count_week < 0.803619, modinq_size_44_c2070, modinq_size_44_c2071);

modinq_size_44_c2068 := if(nf_inq_lnames_per_sfd_addr < 2.629619, modinq_size_44_c2069, 6.000000);

modinq_size_44_c2074 := if(nf_inq_phonesperadl_count_day < 0.604390, 12.695532, 8.000000);

modinq_size_44_c2073 := if(rv_i60_inq_count12 < 2.152359, 7.000000, modinq_size_44_c2074);

modinq_size_44_c2072 := if(nf_invbest_inq_peraddr_diff < -6.747342, 6.000000, modinq_size_44_c2073);

modinq_size_44_c2067 := if(rv_i62_inq_addrs_per_adl < 1.732820, modinq_size_44_c2068, modinq_size_44_c2072);

modinq_size_44_c2078 := if(nf_inq_perbestssn_count12 < 2.925376, 12.116889, 9.000000);

modinq_size_44_c2079 := if(nf_inq_retail_count < 3.323010, 10.327020, 8.000000);

modinq_size_44_c2077 := if(nf_inq_addrsperssn_count12 < 0.592914, modinq_size_44_c2078, modinq_size_44_c2079);

modinq_size_44_c2081 := if(nf_inq_ssnspercurraddr_count12 < 2.806686, 8.000000, 8.000000);

modinq_size_44_c2082 := if(nf_inq_highriskcredit_count < 15.089775, 13.423473, 8.000000);

modinq_size_44_c2080 := if(nf_inquiry_verification_index < 30.151856, modinq_size_44_c2081, modinq_size_44_c2082);

modinq_size_44_c2076 := if(rv_i62_inq_lnamesperadl_recency < 6.951914, modinq_size_44_c2077, modinq_size_44_c2080);

modinq_size_44_c2084 := if(rv_i60_inq_auto_recency < 20.314502, 7.000000, 7.000000);

modinq_size_44_c2086 := if(nf_inq_peraddr_count12 < 3.986640, 8.000000, 9.000000);

modinq_size_44_c2085 := if(rv_i62_inq_phones_per_adl < 2.992910, modinq_size_44_c2086, 7.000000);

modinq_size_44_c2083 := if(nf_inq_lnamesperssn_count12 < 0.370728, modinq_size_44_c2084, modinq_size_44_c2085);

modinq_size_44_c2075 := if(rv_i60_inq_retpymt_recency < 15.994971, modinq_size_44_c2076, modinq_size_44_c2083);

modinq_size_44_c2066 := if(nf_inq_ssnsperaddr_recency < 3.276683, modinq_size_44_c2067, modinq_size_44_c2075);

modinq_size_44_c2090 := if(nf_inq_curraddr_ver_count < 1.062596, 7.000000, 7.000000);

modinq_size_44_c2089 := if(nf_inq_count24 < 2.261765, 6.000000, modinq_size_44_c2090);

modinq_size_44_c2088 := if(rv_i62_inq_phonesperadl_recency < 1.361237, modinq_size_44_c2089, 5.000000);

modinq_size_44_c2087 := if(nf_inq_peradl_count_week < 6.550134, modinq_size_44_c2088, 4.000000);

modinq_size_44_c2065 := if(nf_inq_ssnsperaddr_count_week < 1.103879, modinq_size_44_c2066, modinq_size_44_c2087);

modinq_size_44_c2096 := if(rv_i60_inq_other_recency < 0.384886, 10.327020, 8.000000);

modinq_size_44_c2097 := if(nf_inq_adls_per_addr < 0.335313, 10.706640, 8.000000);

modinq_size_44_c2095 := if(nf_inq_curraddr_ver_count < 95.049919, modinq_size_44_c2096, modinq_size_44_c2097);

modinq_size_44_c2094 := if(nf_inq_perssn_recency < 0.033419, modinq_size_44_c2095, 6.000000);

modinq_size_44_c2100 := if(nf_inq_perssn_recency < 5.370186, 9.000000, 8.000000);

modinq_size_44_c2099 := if(nf_inq_per_sfd_addr < -0.961695, 7.000000, modinq_size_44_c2100);

modinq_size_44_c2098 := if(nf_inq_lnamesperaddr_count12 < 1.896503, modinq_size_44_c2099, 6.000000);

modinq_size_44_c2093 := if(nf_inq_ssnsperaddr_recency < 2.312363, modinq_size_44_c2094, modinq_size_44_c2098);

modinq_size_44_c2092 := if(rv_i60_inq_retpymt_recency < 44.605053, modinq_size_44_c2093, 4.000000);

modinq_size_44_c2091 := if(rv_i60_inq_count12 < 0.851391, modinq_size_44_c2092, 3.000000);

modinq_size_44_c2064 := if(nf_inq_ssn_ver_count < 234.261962, modinq_size_44_c2065, modinq_size_44_c2091);

modinq_size_44 := if(nf_inquiry_verification_index < 24.103521, modinq_size_44_c2054, modinq_size_44_c2064);

modinq_size_45_c2102 := if(nf_inq_per_addr < 0.847382, 2.000000, 2.000000);

modinq_size_45_c2109 := if(nf_inq_adlsperaddr_recency < 10.402661, 15.991966, 10.706640);

modinq_size_45_c2108 := if(nf_inq_adlsperaddr_count12 < 3.352466, modinq_size_45_c2109, 7.000000);

modinq_size_45_c2107 := if(nf_inq_lnamespercurraddr_count12 < 2.274712, modinq_size_45_c2108, 6.000000);

modinq_size_45_c2112 := if(nf_inq_count24 < 3.111527, 13.508753, 8.000000);

modinq_size_45_c2113 := if(nf_inq_adlsperaddr_count12 < 0.208986, 9.851656, 9.000000);

modinq_size_45_c2111 := if(nf_invbest_inq_ssnsperaddr_diff < -0.590625, modinq_size_45_c2112, modinq_size_45_c2113);

modinq_size_45_c2114 := if(nf_inq_other_count < 2.910038, 7.000000, 7.000000);

modinq_size_45_c2110 := if(nf_inq_mortgage_count < 2.286690, modinq_size_45_c2111, modinq_size_45_c2114);

modinq_size_45_c2106 := if(rv_i60_inq_auto_recency < 88.344066, modinq_size_45_c2107, modinq_size_45_c2110);

modinq_size_45_c2105 := if(rv_i61_inq_collection_count12 < 2.378928, modinq_size_45_c2106, 4.000000);

modinq_size_45_c2116 := if(rv_i60_inq_banking_recency < 13.736452, 5.000000, 5.000000);

modinq_size_45_c2115 := if(nf_inq_adlsperaddr_count12 < 0.875387, modinq_size_45_c2116, 4.000000);

modinq_size_45_c2104 := if(nf_inq_retail_count24 < 1.836409, modinq_size_45_c2105, modinq_size_45_c2115);

modinq_size_45_c2122 := if(nf_inq_utilities_count < 0.920309, 16.240907, 10.706640);

modinq_size_45_c2123 := if(nf_inq_addrsperbestssn_count12 < 1.954888, 9.851656, 9.851656);

modinq_size_45_c2121 := if(nf_inq_dobsperssn_count_week < 0.014860, modinq_size_45_c2122, modinq_size_45_c2123);

modinq_size_45_c2125 := if(rv_i60_inq_count12 < 5.117503, 9.000000, 8.000000);

modinq_size_45_c2124 := if(rv_i60_inq_hiriskcred_recency < 46.153418, modinq_size_45_c2125, 7.000000);

modinq_size_45_c2120 := if(rv_i60_inq_banking_count12 < 1.536448, modinq_size_45_c2121, modinq_size_45_c2124);

modinq_size_45_c2126 := if(nf_inq_ssns_per_sfd_addr < 0.169015, 6.000000, 6.000000);

modinq_size_45_c2119 := if(nf_inq_bestssn_ver_count < 210.847219, modinq_size_45_c2120, modinq_size_45_c2126);

modinq_size_45_c2128 := if(nf_inq_ssn_ver_count < 7.238467, 6.000000, 6.000000);

modinq_size_45_c2129 := if(nf_inq_fname_ver_count < 9.405310, 6.000000, 6.000000);

modinq_size_45_c2127 := if(nf_inq_addrsperssn_count12 < 1.748625, modinq_size_45_c2128, modinq_size_45_c2129);

modinq_size_45_c2118 := if(nf_inq_adlspercurraddr_count12 < 3.611340, modinq_size_45_c2119, modinq_size_45_c2127);

modinq_size_45_c2134 := if(rv_i60_inq_peradl_recency < 1.540795, 8.000000, 8.000000);

modinq_size_45_c2133 := if(nf_inq_retailpayments_count24 < 0.599268, modinq_size_45_c2134, 7.000000);

modinq_size_45_c2132 := if(nf_inq_other_count < 0.619180, 6.000000, modinq_size_45_c2133);

modinq_size_45_c2136 := if(nf_inq_perbestssn_count12 < 12.706138, 7.000000, 7.000000);

modinq_size_45_c2135 := if(rv_i62_inq_addrs_per_adl < 1.365853, 6.000000, modinq_size_45_c2136);

modinq_size_45_c2131 := if(nf_inq_fname_ver_count < 20.450256, modinq_size_45_c2132, modinq_size_45_c2135);

modinq_size_45_c2130 := if(nf_inq_retail_count24 < 0.187744, modinq_size_45_c2131, 4.000000);

modinq_size_45_c2117 := if(rv_i62_inq_lnamesperadl_count12 < 1.481204, modinq_size_45_c2118, modinq_size_45_c2130);

modinq_size_45_c2103 := if(rv_i62_inq_num_names_per_adl < 0.922301, modinq_size_45_c2104, modinq_size_45_c2117);

//modinq_size_45 := if(nf_inq_lnamesperssn_recency < -6250616458.242575, modinq_size_45_c2102, modinq_size_45_c2103);
modinq_size_45 := if(nf_inq_lnamesperssn_recency < -999999998, modinq_size_45_c2102, modinq_size_45_c2103);

modinq_size_46_c2139 := if(nf_inq_per_sfd_addr < 4.162661, 3.000000, 3.000000);

modinq_size_46_c2145 := if(nf_inq_ssnsperaddr_recency < 10.051757, 16.262074, 12.278091);

modinq_size_46_c2146 := if(nf_inq_other_count24 < 0.486747, 13.669106, 8.000000);

modinq_size_46_c2144 := if(nf_inq_ssn_ver_count < 242.150455, modinq_size_46_c2145, modinq_size_46_c2146);

modinq_size_46_c2143 := if(nf_inq_highriskcredit_count24 < 1.768602, modinq_size_46_c2144, 6.000000);

modinq_size_46_c2149 := if(nf_inq_ssnsperaddr_count12 < 0.413455, 9.000000, 9.851656);

modinq_size_46_c2150 := if(nf_inq_lnames_per_apt_addr < -0.892174, 8.000000, 9.000000);

modinq_size_46_c2148 := if(nf_inq_ssnsperaddr_count12 < 1.110178, modinq_size_46_c2149, modinq_size_46_c2150);

modinq_size_46_c2147 := if(nf_inq_curraddr_ver_count < 186.648265, modinq_size_46_c2148, 6.000000);

modinq_size_46_c2142 := if(nf_invbest_inq_adlsperaddr_diff < 0.043534, modinq_size_46_c2143, modinq_size_46_c2147);

modinq_size_46_c2154 := if(nf_inq_adlsperssn_count12 < 1.544109, 15.918327, 8.000000);

modinq_size_46_c2155 := if(rv_i62_inq_fnamesperadl_recency < 10.508549, 9.000000, 9.851656);

modinq_size_46_c2153 := if(rv_i62_inq_ssnsperadl_count12 < 1.466388, modinq_size_46_c2154, modinq_size_46_c2155);

modinq_size_46_c2152 := if(nf_inq_retail_count < 18.549147, modinq_size_46_c2153, 6.000000);

modinq_size_46_c2151 := if(nf_inq_email_per_adl < 0.967444, modinq_size_46_c2152, 5.000000);

modinq_size_46_c2141 := if(nf_inq_adlsperssn_count12 < 0.897059, modinq_size_46_c2142, modinq_size_46_c2151);

modinq_size_46_c2159 := if(rv_i60_inq_retail_count12 < 0.725724, 7.000000, 7.000000);

modinq_size_46_c2158 := if(rv_i62_inq_dobsperadl_recency < 11.214943, 6.000000, modinq_size_46_c2159);

modinq_size_46_c2157 := if(nf_inq_dobs_per_ssn < 1.617621, modinq_size_46_c2158, 5.000000);

modinq_size_46_c2156 := if(nf_inq_per_addr < 8.372947, modinq_size_46_c2157, 4.000000);

modinq_size_46_c2140 := if(nf_inq_addrs_per_ssn < 2.202492, modinq_size_46_c2141, modinq_size_46_c2156);

//modinq_size_46_c2138 := if(nf_inq_addrsperssn_count_day < -6302957086.755203, modinq_size_46_c2139, modinq_size_46_c2140);
modinq_size_46_c2138 := if(nf_inq_addrsperssn_count_day < -999999998, modinq_size_46_c2139, modinq_size_46_c2140);

modinq_size_46_c2166 := if(nf_inq_ssnsperaddr_count12 < 5.568789, 9.000000, 8.000000);

modinq_size_46_c2167 := if(nf_inq_percurraddr_count12 < 4.791695, 8.000000, 8.000000);

modinq_size_46_c2165 := if(rv_i62_inq_dobsperadl_count12 < 0.803670, modinq_size_46_c2166, modinq_size_46_c2167);

modinq_size_46_c2164 := if(rv_i60_inq_auto_count12 < 0.978772, modinq_size_46_c2165, 6.000000);

modinq_size_46_c2169 := if(nf_inq_count < 8.348413, 7.000000, 7.000000);

modinq_size_46_c2168 := if(nf_inq_addr_recency_risk_index < 0.923132, modinq_size_46_c2169, 6.000000);

modinq_size_46_c2163 := if(nf_inq_adls_per_ssn < 0.133737, modinq_size_46_c2164, modinq_size_46_c2168);

modinq_size_46_c2162 := if(nf_inq_retail_count24 < 1.368657, modinq_size_46_c2163, 4.000000);

modinq_size_46_c2161 := if(nf_inq_prepaidcards_count < 0.067535, modinq_size_46_c2162, 3.000000);

modinq_size_46_c2171 := if(rv_i62_inq_phonesperadl_recency < 4.423550, 4.000000, 4.000000);

modinq_size_46_c2170 := if(nf_inq_addrsperadl_count_week < 0.380719, modinq_size_46_c2171, 3.000000);

modinq_size_46_c2160 := if(nf_inq_per_ssn < 4.902760, modinq_size_46_c2161, modinq_size_46_c2170);

modinq_size_46 := if(nf_inquiry_addr_vel_risk_index < 4.059534, modinq_size_46_c2138, modinq_size_46_c2160);

modinq_size_47_c2179 := if(nf_inquiry_ssn_vel_risk_indexv2 < 3.984153, 17.876994, 8.000000);

modinq_size_47_c2180 := if(nf_inq_lnamesperaddr_count_day < 0.191319, 11.023665, 8.000000);

modinq_size_47_c2178 := if(nf_inquiry_addr_vel_risk_indexv2 < 3.729360, modinq_size_47_c2179, modinq_size_47_c2180);

modinq_size_47_c2182 := if(nf_inq_collection_count < 2.755582, 9.000000, 8.000000);

modinq_size_47_c2183 := if(nf_inq_dobsperbestssn_count12 < 1.763179, 8.000000, 9.000000);

modinq_size_47_c2181 := if(nf_inq_dobsperssn_recency < 10.717002, modinq_size_47_c2182, modinq_size_47_c2183);

modinq_size_47_c2177 := if(rv_i62_inq_dobsperadl_count12 < 1.641717, modinq_size_47_c2178, modinq_size_47_c2181);

modinq_size_47_c2186 := if(nf_inq_lname_ver_count < 12.707426, 9.207392, 9.851656);

modinq_size_47_c2185 := if(nf_inq_peraddr_recency < 0.010878, 7.000000, modinq_size_47_c2186);

modinq_size_47_c2184 := if(nf_inquiry_ssn_vel_risk_index < 2.319235, modinq_size_47_c2185, 6.000000);

modinq_size_47_c2176 := if(nf_inq_ssnsperadl_count_week < 0.959319, modinq_size_47_c2177, modinq_size_47_c2184);

modinq_size_47_c2188 := if(nf_inq_lnames_per_addr < 1.888023, 6.000000, 6.000000);

modinq_size_47_c2189 := if(nf_inq_collection_count24 < 0.312402, 6.000000, 6.000000);

modinq_size_47_c2187 := if(nf_inq_peraddr_count_week < 1.451833, modinq_size_47_c2188, modinq_size_47_c2189);

modinq_size_47_c2175 := if(nf_inq_phonesperadl_count_day < 0.283176, modinq_size_47_c2176, modinq_size_47_c2187);

modinq_size_47_c2194 := if(nf_inq_lnames_per_sfd_addr < -0.762354, 8.000000, 9.207392);

modinq_size_47_c2193 := if(nf_inq_dobsperssn_count12 < 1.912945, modinq_size_47_c2194, 7.000000);

modinq_size_47_c2192 := if(nf_inq_banking_count24 < 2.011478, modinq_size_47_c2193, 6.000000);

modinq_size_47_c2191 := if(rv_i60_inq_peradl_count12 < 15.357942, modinq_size_47_c2192, 5.000000);

modinq_size_47_c2190 := if(nf_inq_dobsperssn_recency < 1.128334, 4.000000, modinq_size_47_c2191);

modinq_size_47_c2174 := if(rv_i62_inq_lnamesperadl_count12 < 1.132104, modinq_size_47_c2175, modinq_size_47_c2190);

modinq_size_47_c2198 := if(nf_inq_lname_ver_count < 6.051884, 6.000000, 6.000000);

modinq_size_47_c2197 := if(nf_inq_retailpayments_count_week < 0.470289, modinq_size_47_c2198, 5.000000);

modinq_size_47_c2199 := if(rv_i60_credit_seeking < 1.668483, 5.000000, 5.000000);

modinq_size_47_c2196 := if(rv_i62_inq_ssnsperadl_count12 < 0.584003, modinq_size_47_c2197, modinq_size_47_c2199);

modinq_size_47_c2195 := if(nf_inq_prepaidcards_count < 2.035897, modinq_size_47_c2196, 3.000000);

modinq_size_47_c2173 := if(rv_i60_inq_retpymt_count12 < 0.564652, modinq_size_47_c2174, modinq_size_47_c2195);

//modinq_size_47 := if(nf_inq_lnamesperaddr_count12 < -7201791384.182337, 1.000000, modinq_size_47_c2173);
modinq_size_47 := if(nf_inq_lnamesperaddr_count12 < -999999998, 1.000000, modinq_size_47_c2173);

modinq_size_48_c2207 := if(nf_inq_dobsperssn_count12 < 0.062074, 9.000000, 9.000000);

modinq_size_48_c2208 := if(nf_inq_perssn_count12 < 9.469255, 16.324261, 9.000000);

modinq_size_48_c2206 := if(nf_invbest_inq_peraddr_diff < -3.882310, modinq_size_48_c2207, modinq_size_48_c2208);

modinq_size_48_c2210 := if(nf_inq_mortgage_count < 0.429846, 11.023665, 8.000000);

modinq_size_48_c2209 := if(nf_invbest_inq_peraddr_diff < -4.913690, 7.000000, modinq_size_48_c2210);

modinq_size_48_c2205 := if(rv_i60_inq_hiriskcred_recency < 71.761477, modinq_size_48_c2206, modinq_size_48_c2209);

modinq_size_48_c2213 := if(nf_inq_lnamesperbestssn_count12 < 0.461136, 11.296252, 8.000000);

modinq_size_48_c2214 := if(nf_inq_other_count < 5.266345, 11.296252, 9.851656);

modinq_size_48_c2212 := if(nf_inq_adlsperssn_recency < 3.972529, modinq_size_48_c2213, modinq_size_48_c2214);

modinq_size_48_c2215 := if(nf_inq_ssnsperaddr_recency < 9.514536, 7.000000, 7.000000);

modinq_size_48_c2211 := if(nf_inq_communications_count < 2.673410, modinq_size_48_c2212, modinq_size_48_c2215);

modinq_size_48_c2204 := if(nf_inq_per_addr < 0.341803, modinq_size_48_c2205, modinq_size_48_c2211);

modinq_size_48_c2203 := if(nf_inq_fnamesperadl_count_week < 0.675777, modinq_size_48_c2204, 4.000000);

modinq_size_48_c2220 := if(nf_invbest_inq_peraddr_diff < -0.960220, 11.023665, 8.000000);

modinq_size_48_c2221 := if(nf_inq_retailpayments_count < 0.132308, 13.817534, 8.000000);

modinq_size_48_c2219 := if(nf_inq_ssns_per_sfd_addr < 0.023372, modinq_size_48_c2220, modinq_size_48_c2221);

modinq_size_48_c2223 := if(nf_inq_fname_ver_count < 57.782279, 11.296252, 8.000000);

modinq_size_48_c2222 := if(nf_inq_adlsperbestphone_count12 < 0.314922, modinq_size_48_c2223, 7.000000);

modinq_size_48_c2218 := if(rv_i61_inq_collection_recency < 30.960626, modinq_size_48_c2219, modinq_size_48_c2222);

modinq_size_48_c2226 := if(nf_inq_ssnspercurraddr_count12 < 1.780211, 14.206270, 11.941420);

modinq_size_48_c2227 := if(nf_inq_dobsperbestssn_count12 < 0.745181, 9.000000, 8.000000);

modinq_size_48_c2225 := if(nf_inq_communications_count < 3.686637, modinq_size_48_c2226, modinq_size_48_c2227);

modinq_size_48_c2229 := if(nf_inq_perssn_count12 < 6.842858, 8.000000, 8.000000);

modinq_size_48_c2228 := if(nf_inq_bestssn_ver_count < 10.332592, modinq_size_48_c2229, 7.000000);

modinq_size_48_c2224 := if(nf_inq_addr_recency_risk_index < 3.915422, modinq_size_48_c2225, modinq_size_48_c2228);

modinq_size_48_c2217 := if(rv_i62_inq_dobs_per_adl < 0.447730, modinq_size_48_c2218, modinq_size_48_c2224);

modinq_size_48_c2233 := if(rv_i60_inq_retpymt_recency < 85.474813, 9.851656, 9.000000);

modinq_size_48_c2232 := if(nf_inq_adlspercurraddr_count12 < 0.195699, 7.000000, modinq_size_48_c2233);

modinq_size_48_c2231 := if(rv_i60_inq_retail_count12 < 4.103552, modinq_size_48_c2232, 6.000000);

modinq_size_48_c2230 := if(nf_inquiry_adl_vel_risk_index < 1.837847, modinq_size_48_c2231, 5.000000);

modinq_size_48_c2216 := if(rv_i60_inq_comm_recency < 60.224037, modinq_size_48_c2217, modinq_size_48_c2230);

modinq_size_48_c2202 := if(nf_inq_lnames_per_sfd_addr < 0.099908, modinq_size_48_c2203, modinq_size_48_c2216);

//modinq_size_48_c2201 := if(rv_i62_inq_ssns_per_adl < -5594916837.737219, 2.000000, modinq_size_48_c2202);
modinq_size_48_c2201 := if(rv_i62_inq_ssns_per_adl < -999999998, 2.000000, modinq_size_48_c2202);

modinq_size_48_c2239 := if(nf_inq_peraddr_count_week < 1.966358, 7.000000, 7.000000);

modinq_size_48_c2238 := if(rv_i60_inq_auto_recency < 0.166691, modinq_size_48_c2239, 6.000000);

modinq_size_48_c2237 := if(nf_inq_bestlname_ver_count < 9.489727, modinq_size_48_c2238, 5.000000);

modinq_size_48_c2240 := if(nf_inq_addrsperssn_count_week < 1.791569, 5.000000, 5.000000);

modinq_size_48_c2236 := if(nf_inq_peraddr_count_week < 5.586490, modinq_size_48_c2237, modinq_size_48_c2240);

modinq_size_48_c2242 := if(nf_invbest_inq_ssnsperaddr_diff < 1.375678, 5.000000, 5.000000);

modinq_size_48_c2241 := if(nf_inq_ssn_ver_count < 23.029404, modinq_size_48_c2242, 4.000000);

modinq_size_48_c2235 := if(rv_i62_inq_ssnsperadl_recency < 11.174007, modinq_size_48_c2236, modinq_size_48_c2241);

modinq_size_48_c2243 := if(rv_i62_inq_lnamesperadl_recency < 11.266731, 3.000000, 3.000000);

modinq_size_48_c2234 := if(nf_inq_per_ssn < 15.603098, modinq_size_48_c2235, modinq_size_48_c2243);

modinq_size_48 := if(nf_inq_per_sfd_addr < 8.292797, modinq_size_48_c2201, modinq_size_48_c2234);

modinq_size_49_c2245 := if(nf_inq_lnames_per_addr < 0.193857, 2.000000, 2.000000);

modinq_size_49_c2252 := if(nf_inq_per_apt_addr < 5.385791, 16.481220, 8.000000);

modinq_size_49_c2253 := if(nf_invbest_inq_ssnsperaddr_diff < -0.543751, 13.040438, 9.207392);

modinq_size_49_c2251 := if(nf_inq_per_sfd_addr < 2.421005, modinq_size_49_c2252, modinq_size_49_c2253);

modinq_size_49_c2255 := if(nf_inq_utilities_count < 0.745416, 13.955690, 9.000000);

modinq_size_49_c2256 := if(nf_inq_addr_recency_risk_index < 3.765555, 13.744698, 9.000000);

modinq_size_49_c2254 := if(rv_i60_inq_auto_count12 < 0.503318, modinq_size_49_c2255, modinq_size_49_c2256);

modinq_size_49_c2250 := if(rv_i62_inq_phones_per_adl < 0.164709, modinq_size_49_c2251, modinq_size_49_c2254);

modinq_size_49_c2249 := if(nf_inq_communications_count24 < 4.755442, modinq_size_49_c2250, 5.000000);

modinq_size_49_c2260 := if(rv_i60_inq_hiriskcred_recency < 65.371932, 13.955690, 8.000000);

modinq_size_49_c2259 := if(nf_inq_auto_count24 < 1.847091, modinq_size_49_c2260, 7.000000);

modinq_size_49_c2262 := if(nf_inq_adls_per_addr < 1.472841, 8.000000, 8.000000);

modinq_size_49_c2261 := if(nf_inq_adlsperaddr_recency < 7.899302, modinq_size_49_c2262, 7.000000);

modinq_size_49_c2258 := if(nf_inq_lnamespercurraddr_count12 < 1.772730, modinq_size_49_c2259, modinq_size_49_c2261);

modinq_size_49_c2265 := if(rv_i60_inq_peradl_count12 < 5.578108, 11.748880, 8.000000);

modinq_size_49_c2266 := if(nf_inq_ssns_per_addr < 1.366412, 10.706640, 9.000000);

modinq_size_49_c2264 := if(rv_i62_inq_ssnsperadl_recency < 8.838039, modinq_size_49_c2265, modinq_size_49_c2266);

modinq_size_49_c2267 := if(nf_inq_quizprovider_count < 5.385438, 7.000000, 7.000000);

modinq_size_49_c2263 := if(nf_inq_collection_count24 < 1.956116, modinq_size_49_c2264, modinq_size_49_c2267);

modinq_size_49_c2257 := if(nf_inq_fname_ver_count < 14.997137, modinq_size_49_c2258, modinq_size_49_c2263);

modinq_size_49_c2248 := if(rv_i60_inq_retail_recency < 37.239072, modinq_size_49_c2249, modinq_size_49_c2257);

modinq_size_49_c2247 := if(nf_inq_ssnsperaddr_count12 < 24.545642, modinq_size_49_c2248, 3.000000);

modinq_size_49_c2271 := if(nf_inq_adls_per_apt_addr < -0.619543, 6.000000, 6.000000);

modinq_size_49_c2272 := if(nf_inq_phonesperadl_count_day < 0.372701, 6.000000, 6.000000);

modinq_size_49_c2270 := if(nf_inq_ssnsperaddr_count12 < 1.375463, modinq_size_49_c2271, modinq_size_49_c2272);

modinq_size_49_c2269 := if(rv_i62_inq_dobsperadl_count12 < 0.980488, 4.000000, modinq_size_49_c2270);

modinq_size_49_c2268 := if(nf_inq_count < 11.511736, modinq_size_49_c2269, 3.000000);

modinq_size_49_c2246 := if(nf_inq_collection_count < 15.665164, modinq_size_49_c2247, modinq_size_49_c2268);

//modinq_size_49 := if(nf_inq_other_count_week < -7794771449.571716, modinq_size_49_c2245, modinq_size_49_c2246);
modinq_size_49 := if(nf_inq_other_count_week < -999999998, modinq_size_49_c2245, modinq_size_49_c2246);

modinq_size_50_c2280 := if(nf_inq_adls_per_ssn < 1.645053, 17.904967, 8.000000);

modinq_size_50_c2279 := if(nf_inq_count < 50.469925, modinq_size_50_c2280, 7.000000);

modinq_size_50_c2282 := if(nf_inq_addr_ver_count < 7.651808, 8.000000, 8.000000);

modinq_size_50_c2283 := if(nf_inq_adlsperssn_count12 < 0.240270, 8.000000, 8.000000);

modinq_size_50_c2281 := if(rv_i62_inq_ssnsperadl_recency < 1.445336, modinq_size_50_c2282, modinq_size_50_c2283);

modinq_size_50_c2278 := if(nf_invbest_inq_lastperaddr_diff < 1.343965, modinq_size_50_c2279, modinq_size_50_c2281);

modinq_size_50_c2277 := if(nf_inq_per_ssn < 27.061321, modinq_size_50_c2278, 5.000000);

modinq_size_50_c2287 := if(nf_invbest_inq_peraddr_diff < 0.640617, 8.000000, 8.000000);

modinq_size_50_c2288 := if(nf_inq_prepaidcards_count < 0.850448, 9.851656, 8.000000);

modinq_size_50_c2286 := if(nf_inq_adls_per_sfd_addr < 0.226028, modinq_size_50_c2287, modinq_size_50_c2288);

modinq_size_50_c2290 := if(nf_inq_addrsperadl_count_week < 0.778798, 8.000000, 8.000000);

modinq_size_50_c2291 := if(nf_inq_lname_ver_count < 16.276184, 8.000000, 8.000000);

modinq_size_50_c2289 := if(rv_i62_inq_addrs_per_adl < 4.784022, modinq_size_50_c2290, modinq_size_50_c2291);

modinq_size_50_c2285 := if(rv_i62_inq_phones_per_adl < 1.662765, modinq_size_50_c2286, modinq_size_50_c2289);

modinq_size_50_c2284 := if(rv_i60_inq_mortgage_recency < 5.944650, modinq_size_50_c2285, 5.000000);

modinq_size_50_c2276 := if(nf_inq_phonesperadl_count_week < 0.401383, modinq_size_50_c2277, modinq_size_50_c2284);

modinq_size_50_c2296 := if(nf_inq_per_addr < 0.159301, 11.535537, 9.207392);

modinq_size_50_c2295 := if(rv_i62_inq_dobs_per_adl < 0.860712, modinq_size_50_c2296, 7.000000);

modinq_size_50_c2294 := if(nf_inq_perssn_count12 < 3.586477, modinq_size_50_c2295, 6.000000);

modinq_size_50_c2293 := if(nf_invbest_inq_peraddr_diff < -1.107472, 5.000000, modinq_size_50_c2294);

modinq_size_50_c2297 := if(nf_invbest_inq_ssnsperaddr_diff < -0.923895, 5.000000, 5.000000);

modinq_size_50_c2292 := if(rv_i62_inq_ssnsperadl_recency < 1.136098, modinq_size_50_c2293, modinq_size_50_c2297);

modinq_size_50_c2275 := if(nf_inq_curraddr_ver_count < 64.949577, modinq_size_50_c2276, modinq_size_50_c2292);

//modinq_size_50_c2274 := if(nf_inq_other_count_day < -2664662209.736423, 2.000000, modinq_size_50_c2275);
modinq_size_50_c2274 := if(nf_inq_other_count_day < -999999998, 2.000000, modinq_size_50_c2275);

modinq_size_50_c2299 := if(nf_inq_bestphone_ver_count < 254.375391, 3.000000, 3.000000);

modinq_size_50_c2298 := if(nf_inq_addr_ver_count < 20.553660, modinq_size_50_c2299, 2.000000);

modinq_size_50 := if(nf_inq_per_addr < 15.922645, modinq_size_50_c2274, modinq_size_50_c2298);

modinq_size_51_c2307 := if(nf_inq_utilities_count < 0.738672, 16.919977, 8.000000);

modinq_size_51_c2308 := if(rv_i60_inq_recency < 15.671732, 9.851656, 8.000000);

modinq_size_51_c2306 := if(nf_inq_quizprovider_count24 < 1.298556, modinq_size_51_c2307, modinq_size_51_c2308);

modinq_size_51_c2310 := if(nf_inquiry_ssn_vel_risk_indexv2 < 0.236451, 13.669106, 9.207392);

modinq_size_51_c2311 := if(nf_inq_auto_count_day < 0.456055, 9.207392, 8.000000);

modinq_size_51_c2309 := if(nf_inq_dobsperbestssn_count12 < 1.169407, modinq_size_51_c2310, modinq_size_51_c2311);

modinq_size_51_c2305 := if(nf_inq_addrsperssn_count12 < 0.471385, modinq_size_51_c2306, modinq_size_51_c2309);

modinq_size_51_c2314 := if(nf_inq_adlsperssn_count_week < 0.812073, 9.000000, 9.851656);

modinq_size_51_c2315 := if(nf_inq_banking_count < 0.953059, 9.000000, 8.000000);

modinq_size_51_c2313 := if(nf_inq_percurraddr_count12 < 0.323978, modinq_size_51_c2314, modinq_size_51_c2315);

modinq_size_51_c2312 := if(nf_inq_peraddr_count_day < 0.625015, modinq_size_51_c2313, 6.000000);

modinq_size_51_c2304 := if(nf_inq_fnamesperadl_count_week < 0.723739, modinq_size_51_c2305, modinq_size_51_c2312);

modinq_size_51_c2319 := if(nf_inq_adls_per_sfd_addr < 1.245249, 9.851656, 9.000000);

modinq_size_51_c2320 := if(nf_inq_addrsperssn_recency < 0.467514, 8.000000, 8.000000);

modinq_size_51_c2318 := if(rv_i62_inq_dobsperadl_count12 < 0.551555, modinq_size_51_c2319, modinq_size_51_c2320);

modinq_size_51_c2322 := if(nf_inq_curraddr_ver_count < 2.497382, 8.000000, 8.000000);

modinq_size_51_c2323 := if(nf_inq_adlsperaddr_recency < 4.159639, 8.000000, 8.000000);

modinq_size_51_c2321 := if(nf_inq_lnamesperaddr_recency < 9.256255, modinq_size_51_c2322, modinq_size_51_c2323);

modinq_size_51_c2317 := if(nf_inq_perssn_recency < 1.766534, modinq_size_51_c2318, modinq_size_51_c2321);

modinq_size_51_c2324 := if(rv_i60_inq_peradl_count12 < 1.143165, 6.000000, 6.000000);

modinq_size_51_c2316 := if(nf_inq_addrsperadl_count_week < 0.145223, modinq_size_51_c2317, modinq_size_51_c2324);

modinq_size_51_c2303 := if(nf_inq_ssns_per_sfd_addr < 1.414199, modinq_size_51_c2304, modinq_size_51_c2316);

modinq_size_51_c2325 := if(nf_inq_addr_ver_count < 201.598082, 4.000000, 4.000000);

modinq_size_51_c2302 := if(nf_inq_lnames_per_apt_addr < 2.072521, modinq_size_51_c2303, modinq_size_51_c2325);

modinq_size_51_c2331 := if(nf_inq_banking_count < 1.800078, 8.000000, 8.000000);

modinq_size_51_c2332 := if(rv_i62_inq_lnamesperadl_recency < 8.744161, 9.000000, 12.278091);

modinq_size_51_c2330 := if(nf_inq_dobs_per_ssn < 0.773047, modinq_size_51_c2331, modinq_size_51_c2332);

modinq_size_51_c2329 := if(rv_i60_inq_retpymt_recency < 86.445399, modinq_size_51_c2330, 6.000000);

modinq_size_51_c2328 := if(rv_i62_inq_fnamesperadl_count12 < 1.703777, modinq_size_51_c2329, 5.000000);

modinq_size_51_c2334 := if(nf_inq_bestlname_ver_count < 138.812867, 6.000000, 6.000000);

modinq_size_51_c2333 := if(rv_i60_inq_hiriskcred_recency < 66.698551, 5.000000, modinq_size_51_c2334);

modinq_size_51_c2327 := if(nf_inq_retail_count < 2.543514, modinq_size_51_c2328, modinq_size_51_c2333);

modinq_size_51_c2338 := if(nf_inq_peraddr_count12 < 6.624038, 7.000000, 7.000000);

modinq_size_51_c2337 := if(nf_inq_bestdob_ver_count < 6.229837, 6.000000, modinq_size_51_c2338);

modinq_size_51_c2336 := if(rv_i60_credit_seeking < 0.430036, 5.000000, modinq_size_51_c2337);

modinq_size_51_c2335 := if(nf_invbest_inq_ssnsperaddr_diff < -0.475764, modinq_size_51_c2336, 4.000000);

modinq_size_51_c2326 := if(nf_inq_peraddr_count12 < 5.473662, modinq_size_51_c2327, modinq_size_51_c2335);

modinq_size_51_c2301 := if(rv_i62_inq_dobsperadl_recency < 6.088867, modinq_size_51_c2302, modinq_size_51_c2326);

modinq_size_51_c2341 := if(rv_i62_inq_ssnsperadl_recency < 9.051410, 4.000000, 4.000000);

modinq_size_51_c2342 := if(rv_i60_inq_prepaidcards_recency < 39.978733, 4.000000, 4.000000);

modinq_size_51_c2340 := if(nf_inq_addrsperssn_count12 < 0.615364, modinq_size_51_c2341, modinq_size_51_c2342);

modinq_size_51_c2348 := if(nf_inq_mortgage_count < 0.892033, 8.000000, 8.000000);

modinq_size_51_c2349 := if(nf_inq_lnamesperaddr_recency < 3.314875, 9.000000, 8.000000);

modinq_size_51_c2347 := if(nf_inq_ssnsperaddr_count12 < 2.830146, modinq_size_51_c2348, modinq_size_51_c2349);

modinq_size_51_c2346 := if(nf_inq_per_ssn < 4.988676, modinq_size_51_c2347, 6.000000);

modinq_size_51_c2352 := if(rv_i60_inq_recency < 66.877043, 11.023665, 8.000000);

modinq_size_51_c2353 := if(rv_i62_inq_lnamesperadl_count12 < 1.444563, 10.706640, 9.000000);

modinq_size_51_c2351 := if(nf_inq_perssn_recency < 1.760903, modinq_size_51_c2352, modinq_size_51_c2353);

modinq_size_51_c2350 := if(rv_i60_inq_retail_recency < 72.384659, modinq_size_51_c2351, 6.000000);

modinq_size_51_c2345 := if(rv_i62_inq_addrs_per_adl < 0.872145, modinq_size_51_c2346, modinq_size_51_c2350);

modinq_size_51_c2356 := if(rv_i60_inq_auto_recency < 7.215979, 7.000000, 7.000000);

modinq_size_51_c2355 := if(nf_inq_lnames_per_sfd_addr < 2.421413, modinq_size_51_c2356, 6.000000);

modinq_size_51_c2354 := if(nf_inq_communications_count < 1.345509, modinq_size_51_c2355, 5.000000);

modinq_size_51_c2344 := if(rv_i60_inq_banking_recency < 63.969754, modinq_size_51_c2345, modinq_size_51_c2354);

modinq_size_51_c2343 := if(nf_inq_per_ssn < 14.323801, modinq_size_51_c2344, 3.000000);

modinq_size_51_c2339 := if(nf_invbest_inq_lastperaddr_diff < -1.441818, modinq_size_51_c2340, modinq_size_51_c2343);

modinq_size_51 := if(nf_inq_lnamespercurraddr_count12 < 1.442255, modinq_size_51_c2301, modinq_size_51_c2339);

modinq_size_52_c2364 := if(nf_inq_addrsperssn_count12 < 2.170041, 17.148810, 9.207392);

modinq_size_52_c2363 := if(nf_inq_adls_per_ssn < 1.113501, modinq_size_52_c2364, 7.000000);

modinq_size_52_c2366 := if(nf_inq_lnames_per_addr < 0.525499, 11.535537, 9.000000);

modinq_size_52_c2365 := if(nf_inq_addrsperbestssn_count12 < 0.062289, modinq_size_52_c2366, 7.000000);

modinq_size_52_c2362 := if(nf_inq_fname_ver_count < 90.887883, modinq_size_52_c2363, modinq_size_52_c2365);

modinq_size_52_c2369 := if(nf_inq_lnamesperbestssn_count12 < 0.633554, 11.023665, 12.278091);

modinq_size_52_c2370 := if(rv_i62_inq_ssnsperadl_count12 < 0.931288, 8.000000, 9.000000);

modinq_size_52_c2368 := if(nf_inq_quizprovider_count < 1.264758, modinq_size_52_c2369, modinq_size_52_c2370);

modinq_size_52_c2371 := if(rv_i62_inq_dobsperadl_count12 < 1.739328, 7.000000, 7.000000);

modinq_size_52_c2367 := if(nf_inquiry_adl_vel_risk_index < 1.751956, modinq_size_52_c2368, modinq_size_52_c2371);

modinq_size_52_c2361 := if(nf_inq_lnamespercurraddr_count12 < 1.649165, modinq_size_52_c2362, modinq_size_52_c2367);

modinq_size_52_c2372 := if(nf_inq_peraddr_count_week < 3.049306, 5.000000, 5.000000);

modinq_size_52_c2360 := if(nf_inq_phonesperadl_count_week < 1.076896, modinq_size_52_c2361, modinq_size_52_c2372);

modinq_size_52_c2377 := if(rv_i62_inq_fnamesperadl_count12 < 0.118381, 12.116889, 9.207392);

modinq_size_52_c2378 := if(rv_i60_inq_other_recency < 18.005371, 9.000000, 9.000000);

modinq_size_52_c2376 := if(rv_i62_inq_addrsperadl_recency < 0.063565, modinq_size_52_c2377, modinq_size_52_c2378);

modinq_size_52_c2375 := if(rv_i60_inq_retpymt_recency < 70.709393, modinq_size_52_c2376, 6.000000);

modinq_size_52_c2381 := if(rv_i60_inq_count12 < 6.575306, 13.040438, 8.000000);

modinq_size_52_c2380 := if(nf_inq_ssns_per_sfd_addr < -0.084833, 7.000000, modinq_size_52_c2381);

modinq_size_52_c2379 := if(nf_inq_communications_count < 2.461961, modinq_size_52_c2380, 6.000000);

modinq_size_52_c2374 := if(nf_inq_per_ssn < 1.540135, modinq_size_52_c2375, modinq_size_52_c2379);

modinq_size_52_c2385 := if(nf_inq_perssn_recency < 0.229638, 9.851656, 10.327020);

modinq_size_52_c2384 := if(nf_inq_addrs_per_ssn < 0.347069, modinq_size_52_c2385, 7.000000);

modinq_size_52_c2387 := if(rv_i61_inq_collection_count12 < 0.773693, 9.000000, 8.000000);

modinq_size_52_c2386 := if(rv_i62_inq_ssnsperadl_count12 < 0.531022, modinq_size_52_c2387, 7.000000);

modinq_size_52_c2383 := if(nf_inq_adlsperaddr_count12 < 0.397039, modinq_size_52_c2384, modinq_size_52_c2386);

modinq_size_52_c2390 := if(rv_i60_inq_count12 < 0.877486, 8.000000, 8.000000);

modinq_size_52_c2389 := if(nf_inq_addr_ver_count < 6.365666, modinq_size_52_c2390, 7.000000);

modinq_size_52_c2391 := if(rv_i62_inq_dobsperadl_recency < 5.367696, 7.000000, 7.000000);

modinq_size_52_c2388 := if(rv_i60_inq_auto_recency < 16.064135, modinq_size_52_c2389, modinq_size_52_c2391);

modinq_size_52_c2382 := if(nf_inq_peraddr_count12 < 1.432046, modinq_size_52_c2383, modinq_size_52_c2388);

modinq_size_52_c2373 := if(rv_i60_inq_banking_recency < 53.634176, modinq_size_52_c2374, modinq_size_52_c2382);

modinq_size_52_c2359 := if(rv_i60_inq_mortgage_recency < 8.346584, modinq_size_52_c2360, modinq_size_52_c2373);

modinq_size_52_c2392 := if(nf_inquiry_adl_vel_risk_index < 1.273139, 3.000000, 3.000000);

modinq_size_52_c2358 := if(nf_inq_banking_count_week < 0.521271, modinq_size_52_c2359, modinq_size_52_c2392);

//modinq_size_52 := if(nf_inq_count_day < -8509959986.998024, 2.000000, modinq_size_52_c2358);
modinq_size_52 := if(nf_inq_count_day < -999999998, 2.000000, modinq_size_52_c2358);

modinq_size_53_c2400 := if(nf_inq_per_sfd_addr < 12.723505, 16.644220, 9.000000);

modinq_size_53_c2401 := if(rv_i62_inq_fnamesperadl_count12 < 0.242716, 14.084906, 11.535537);

modinq_size_53_c2399 := if(nf_inq_collection_count < 2.123551, modinq_size_53_c2400, modinq_size_53_c2401);

modinq_size_53_c2403 := if(rv_i62_inq_lnamesperadl_recency < 6.274141, 13.040438, 13.334385);

modinq_size_53_c2404 := if(nf_inq_per_sfd_addr < 2.500811, 8.000000, 9.000000);

modinq_size_53_c2402 := if(nf_inq_peraddr_count_day < 0.661933, modinq_size_53_c2403, modinq_size_53_c2404);

modinq_size_53_c2398 := if(rv_i62_inq_phones_per_adl < 0.490815, modinq_size_53_c2399, modinq_size_53_c2402);

modinq_size_53_c2397 := if(rv_i60_inq_count12 < 11.432201, modinq_size_53_c2398, 5.000000);

modinq_size_53_c2405 := if(nf_inq_bestphone_ver_count < 213.651657, 5.000000, 5.000000);

modinq_size_53_c2396 := if(nf_inq_banking_count < 10.492683, modinq_size_53_c2397, modinq_size_53_c2405);

modinq_size_53_c2410 := if(nf_inq_quizprovider_count < 3.329107, 13.143309, 8.000000);

modinq_size_53_c2409 := if(rv_i60_credit_seeking < 1.161190, modinq_size_53_c2410, 7.000000);

modinq_size_53_c2412 := if(nf_inq_ssnsperaddr_recency < 0.116882, 8.000000, 12.116889);

modinq_size_53_c2413 := if(nf_inq_banking_count_day < 0.675157, 8.000000, 8.000000);

modinq_size_53_c2411 := if(nf_inq_addrsperssn_count_day < 1.939589, modinq_size_53_c2412, modinq_size_53_c2413);

modinq_size_53_c2408 := if(nf_inq_percurraddr_count12 < 2.482742, modinq_size_53_c2409, modinq_size_53_c2411);

modinq_size_53_c2416 := if(nf_inq_highriskcredit_count24 < 7.500700, 8.000000, 8.000000);

modinq_size_53_c2415 := if(nf_inq_dob_ver_count < 29.847725, modinq_size_53_c2416, 7.000000);

modinq_size_53_c2414 := if(rv_i60_inq_hiriskcred_count12 < 4.103792, 6.000000, modinq_size_53_c2415);

modinq_size_53_c2407 := if(rv_i60_inq_hiriskcred_count12 < 3.454998, modinq_size_53_c2408, modinq_size_53_c2414);

modinq_size_53_c2406 := if(rv_i60_inq_retail_count12 < 0.965139, modinq_size_53_c2407, 4.000000);

modinq_size_53_c2395 := if(rv_i60_inq_other_count12 < 0.516553, modinq_size_53_c2396, modinq_size_53_c2406);

modinq_size_53_c2421 := if(nf_inq_ssnsperaddr_count12 < 1.631314, 7.000000, 7.000000);

modinq_size_53_c2420 := if(nf_inq_retail_count < 0.189448, 6.000000, modinq_size_53_c2421);

modinq_size_53_c2423 := if(rv_i60_inq_hiriskcred_recency < 6.892876, 7.000000, 7.000000);

modinq_size_53_c2422 := if(nf_inq_ssn_ver_count < 50.385336, modinq_size_53_c2423, 6.000000);

modinq_size_53_c2419 := if(nf_inquiry_adl_vel_risk_index < 3.441274, modinq_size_53_c2420, modinq_size_53_c2422);

modinq_size_53_c2418 := if(rv_i60_inq_peradl_count12 < 28.626204, modinq_size_53_c2419, 4.000000);

modinq_size_53_c2417 := if(nf_inq_adlsperssn_recency < 5.075497, 3.000000, modinq_size_53_c2418);

modinq_size_53_c2394 := if(nf_inq_count < 28.957400, modinq_size_53_c2395, modinq_size_53_c2417);

//modinq_size_53 := if(nf_inq_ssnsperaddr_count_week < -1143775259.121628, 1.000000, modinq_size_53_c2394);
modinq_size_53 := if(nf_inq_ssnsperaddr_count_week < -999999998, 1.000000, modinq_size_53_c2394);

modinq_size_54_c2431 := if(rv_i60_inq_comm_count12 < 0.876368, 17.148810, 9.000000);

modinq_size_54_c2432 := if(rv_i62_inq_dobsperadl_recency < 5.175493, 11.535537, 12.427187);

modinq_size_54_c2430 := if(rv_i62_inq_fnamesperadl_recency < 9.218626, modinq_size_54_c2431, modinq_size_54_c2432);

modinq_size_54_c2429 := if(nf_inq_mortgage_count24 < 1.213577, modinq_size_54_c2430, 6.000000);

modinq_size_54_c2433 := if(nf_inq_lnamesperaddr_recency < 9.674892, 6.000000, 6.000000);

modinq_size_54_c2428 := if(nf_inq_other_count_week < 0.303175, modinq_size_54_c2429, modinq_size_54_c2433);

modinq_size_54_c2427 := if(rv_i60_inq_prepaidcards_count12 < 0.203718, modinq_size_54_c2428, 4.000000);

modinq_size_54_c2438 := if(nf_inq_adlsperaddr_count12 < 7.103258, 13.817534, 8.000000);

modinq_size_54_c2439 := if(nf_inq_other_count < 1.148180, 8.000000, 8.000000);

modinq_size_54_c2437 := if(rv_i62_inq_addrs_per_adl < 1.081307, modinq_size_54_c2438, modinq_size_54_c2439);

modinq_size_54_c2441 := if(rv_i60_inq_other_recency < 88.685885, 12.695532, 9.851656);

modinq_size_54_c2440 := if(nf_inq_collection_count24 < 1.283088, modinq_size_54_c2441, 7.000000);

modinq_size_54_c2436 := if(nf_inq_per_sfd_addr < 0.334968, modinq_size_54_c2437, modinq_size_54_c2440);

modinq_size_54_c2443 := if(nf_inq_lnames_per_sfd_addr < 1.166218, 7.000000, 7.000000);

modinq_size_54_c2442 := if(nf_inq_bestphone_ver_count < 252.588769, 6.000000, modinq_size_54_c2443);

modinq_size_54_c2435 := if(rv_i60_inq_comm_count12 < 1.383178, modinq_size_54_c2436, modinq_size_54_c2442);

modinq_size_54_c2446 := if(nf_inq_bestlname_ver_count < 13.782445, 7.000000, 7.000000);

modinq_size_54_c2447 := if(rv_i60_inq_peradl_count12 < 2.136976, 7.000000, 7.000000);

modinq_size_54_c2445 := if(rv_i62_inq_phonesperadl_recency < 4.296166, modinq_size_54_c2446, modinq_size_54_c2447);

modinq_size_54_c2444 := if(nf_inq_adls_per_ssn < 0.043795, 5.000000, modinq_size_54_c2445);

modinq_size_54_c2434 := if(nf_inq_perbestssn_count12 < 3.286661, modinq_size_54_c2435, modinq_size_54_c2444);

modinq_size_54_c2426 := if(nf_inq_perssn_recency < 4.701740, modinq_size_54_c2427, modinq_size_54_c2434);

modinq_size_54_c2453 := if(rv_i62_inq_fnamesperadl_recency < 0.154332, 9.000000, 8.000000);

modinq_size_54_c2452 := if(nf_inq_perbestssn_count12 < 0.996302, modinq_size_54_c2453, 7.000000);

modinq_size_54_c2455 := if(rv_i62_inq_addrsperadl_count12 < 1.620566, 9.207392, 9.207392);

modinq_size_54_c2454 := if(nf_inq_dobsperbestssn_count12 < 1.845397, modinq_size_54_c2455, 7.000000);

modinq_size_54_c2451 := if(nf_inq_perssn_count12 < 1.023737, modinq_size_54_c2452, modinq_size_54_c2454);

modinq_size_54_c2457 := if(nf_inq_per_ssn < 0.343076, 7.000000, 7.000000);

modinq_size_54_c2456 := if(rv_i62_inq_addrsperadl_count12 < 0.224218, 6.000000, modinq_size_54_c2457);

modinq_size_54_c2450 := if(nf_inq_adls_per_addr < 4.671816, modinq_size_54_c2451, modinq_size_54_c2456);

modinq_size_54_c2459 := if(nf_inq_per_ssn < 3.103321, 6.000000, 6.000000);

modinq_size_54_c2458 := if(nf_inq_lnamesperadl_count_week < 0.903459, modinq_size_54_c2459, 5.000000);

modinq_size_54_c2449 := if(nf_inq_peraddr_count_week < 2.306263, modinq_size_54_c2450, modinq_size_54_c2458);

modinq_size_54_c2448 := if(nf_inq_adlspercurraddr_count12 < 0.540863, 3.000000, modinq_size_54_c2449);

modinq_size_54_c2425 := if(nf_inq_adls_per_sfd_addr < 2.165557, modinq_size_54_c2426, modinq_size_54_c2448);

//modinq_size_54 := if(rv_i62_inq_addrsperadl_recency < -8721293772.026857, 1.000000, modinq_size_54_c2425);
modinq_size_54 := if(rv_i62_inq_addrsperadl_recency < -999999998, 1.000000, modinq_size_54_c2425);

modinq_size_55_c2467 := if(rv_i60_inq_banking_count12 < 1.739212, 17.551395, 9.851656);

modinq_size_55_c2468 := if(rv_i60_inq_mortgage_recency < 96.440593, 13.143309, 9.851656);

modinq_size_55_c2466 := if(nf_inq_ssns_per_apt_addr < -0.487653, modinq_size_55_c2467, modinq_size_55_c2468);

modinq_size_55_c2465 := if(rv_i62_inq_ssns_per_adl < 2.155656, modinq_size_55_c2466, 6.000000);

modinq_size_55_c2471 := if(nf_inquiry_ssn_vel_risk_indexv2 < 0.536434, 9.207392, 8.000000);

modinq_size_55_c2470 := if(nf_inq_count_day < 3.801986, modinq_size_55_c2471, 7.000000);

modinq_size_55_c2469 := if(nf_inq_lnamespercurraddr_count12 < 1.798113, modinq_size_55_c2470, 6.000000);

modinq_size_55_c2464 := if(nf_inq_ssnsperadl_count_week < 0.474892, modinq_size_55_c2465, modinq_size_55_c2469);

modinq_size_55_c2463 := if(nf_invbest_inq_ssnsperaddr_diff < 1.742610, modinq_size_55_c2464, 4.000000);

modinq_size_55_c2476 := if(nf_inq_lnamesperssn_recency < 9.360420, 8.000000, 9.000000);

modinq_size_55_c2475 := if(nf_inq_communications_count < 0.757578, modinq_size_55_c2476, 7.000000);

modinq_size_55_c2474 := if(nf_inq_per_sfd_addr < -0.854826, 6.000000, modinq_size_55_c2475);

modinq_size_55_c2479 := if(nf_inq_retail_count24 < 0.262770, 13.143309, 8.000000);

modinq_size_55_c2480 := if(rv_i62_inq_fnamesperadl_recency < 9.278159, 8.000000, 9.000000);

modinq_size_55_c2478 := if(nf_inq_per_addr < 8.544844, modinq_size_55_c2479, modinq_size_55_c2480);

modinq_size_55_c2482 := if(nf_inq_count24 < 10.383816, 8.000000, 8.000000);

modinq_size_55_c2483 := if(nf_inq_adls_per_sfd_addr < 0.542905, 8.000000, 9.851656);

modinq_size_55_c2481 := if(nf_inq_banking_count < 0.084368, modinq_size_55_c2482, modinq_size_55_c2483);

modinq_size_55_c2477 := if(nf_inq_communications_count24 < 0.476886, modinq_size_55_c2478, modinq_size_55_c2481);

modinq_size_55_c2473 := if(nf_inq_dobsperssn_recency < 8.253173, modinq_size_55_c2474, modinq_size_55_c2477);

modinq_size_55_c2472 := if(rv_i62_inq_lnamesperadl_count12 < 2.636362, modinq_size_55_c2473, 4.000000);

modinq_size_55_c2462 := if(nf_inq_addrsperssn_recency < 9.875277, modinq_size_55_c2463, modinq_size_55_c2472);

modinq_size_55_c2461 := if(nf_inq_highriskcredit_count_day < 0.539384, modinq_size_55_c2462, 2.000000);

//modinq_size_55 := if(rv_i60_inq_retail_count12 < -5078770882.354905, 1.000000, modinq_size_55_c2461);
modinq_size_55 := if(rv_i60_inq_retail_count12 < -999999998, 1.000000, modinq_size_55_c2461);

modinq_size_56_c2485 := if(nf_inq_adls_per_addr < 0.354547, 3.000000, 2.000000);

modinq_size_56_c2492 := if(nf_inq_dob_ver_count < 162.542534, 17.254102, 14.206270);

modinq_size_56_c2493 := if(nf_inq_ssnsperaddr_recency < 0.003867, 10.706640, 9.207392);

modinq_size_56_c2491 := if(rv_i62_inq_num_names_per_adl < 1.270780, modinq_size_56_c2492, modinq_size_56_c2493);

modinq_size_56_c2495 := if(nf_inq_ssnspercurraddr_count12 < 2.600124, 12.565879, 8.000000);

modinq_size_56_c2496 := if(nf_inq_addr_recency_risk_index < 0.178726, 9.851656, 8.000000);

modinq_size_56_c2494 := if(rv_i62_inq_fnamesperadl_recency < 6.949447, modinq_size_56_c2495, modinq_size_56_c2496);

modinq_size_56_c2490 := if(nf_inq_adlsperaddr_count12 < 1.677602, modinq_size_56_c2491, modinq_size_56_c2494);

modinq_size_56_c2499 := if(nf_inq_adlsperbestssn_count12 < 0.633648, 9.000000, 11.748880);

modinq_size_56_c2500 := if(nf_inq_bestphone_ver_count < 249.632246, 8.000000, 8.000000);

modinq_size_56_c2498 := if(nf_inq_highriskcredit_count < 5.993142, modinq_size_56_c2499, modinq_size_56_c2500);

modinq_size_56_c2501 := if(rv_i62_inq_dobsperadl_recency < 2.742801, 7.000000, 7.000000);

modinq_size_56_c2497 := if(rv_i60_inq_peradl_recency < 10.799742, modinq_size_56_c2498, modinq_size_56_c2501);

modinq_size_56_c2489 := if(nf_inq_per_sfd_addr < 5.040370, modinq_size_56_c2490, modinq_size_56_c2497);

modinq_size_56_c2505 := if(nf_inq_lnamesperssn_recency < 0.783023, 8.000000, 9.000000);

modinq_size_56_c2504 := if(nf_inq_quizprovider_count24 < 0.757722, modinq_size_56_c2505, 7.000000);

modinq_size_56_c2507 := if(nf_inq_lnamesperssn_recency < 2.906908, 8.000000, 8.000000);

modinq_size_56_c2508 := if(nf_inq_lnamesperaddr_count12 < 1.631852, 8.000000, 8.000000);

modinq_size_56_c2506 := if(nf_inq_ssns_per_sfd_addr < 0.512437, modinq_size_56_c2507, modinq_size_56_c2508);

modinq_size_56_c2503 := if(nf_inq_ssns_per_sfd_addr < -0.883569, modinq_size_56_c2504, modinq_size_56_c2506);

modinq_size_56_c2502 := if(rv_i60_inq_auto_count12 < 12.506646, modinq_size_56_c2503, 5.000000);

modinq_size_56_c2488 := if(rv_i60_inq_prepaidcards_recency < 16.906227, modinq_size_56_c2489, modinq_size_56_c2502);

modinq_size_56_c2487 := if(nf_inq_adls_per_addr < 5.928012, modinq_size_56_c2488, 3.000000);

modinq_size_56_c2512 := if(nf_inq_ssns_per_apt_addr < -0.432268, 6.000000, 6.000000);

modinq_size_56_c2513 := if(rv_i60_inq_peradl_count12 < 3.530216, 6.000000, 6.000000);

modinq_size_56_c2511 := if(nf_inq_adlsperaddr_count12 < 0.847077, modinq_size_56_c2512, modinq_size_56_c2513);

modinq_size_56_c2514 := if(rv_i60_inq_peradl_recency < 1.600428, 5.000000, 5.000000);

modinq_size_56_c2510 := if(nf_inq_lnamesperaddr_count12 < 1.872004, modinq_size_56_c2511, modinq_size_56_c2514);

modinq_size_56_c2509 := if(nf_inq_lnamesperaddr_count_week < 0.856380, modinq_size_56_c2510, 3.000000);

modinq_size_56_c2486 := if(nf_inq_retail_count < 3.129190, modinq_size_56_c2487, modinq_size_56_c2509);

//modinq_size_56 := if(nf_inq_adlsperssn_count_week < -1303477065.103369, modinq_size_56_c2485, modinq_size_56_c2486);
modinq_size_56 := if(nf_inq_adlsperssn_count_week < -999999998, modinq_size_56_c2485, modinq_size_56_c2486);

modinq_size_57_c2522 := if(nf_inq_peraddr_count_week < 1.195625, 17.175657, 9.207392);

modinq_size_57_c2523 := if(rv_i62_inq_addrsperadl_recency < 1.459692, 12.931969, 10.327020);

modinq_size_57_c2521 := if(nf_inq_adls_per_apt_addr < -0.434246, modinq_size_57_c2522, modinq_size_57_c2523);

modinq_size_57_c2524 := if(nf_inq_ssns_per_addr < 0.913788, 7.000000, 7.000000);

modinq_size_57_c2520 := if(nf_inq_lnamesperbestssn_count12 < 2.177387, modinq_size_57_c2521, modinq_size_57_c2524);

modinq_size_57_c2519 := if(rv_i60_inq_retpymt_count12 < 1.924765, modinq_size_57_c2520, 5.000000);

modinq_size_57_c2526 := if(nf_inq_ssns_per_sfd_addr < 0.749473, 6.000000, 6.000000);

modinq_size_57_c2525 := if(nf_inq_adls_per_apt_addr < -0.355499, modinq_size_57_c2526, 5.000000);

modinq_size_57_c2518 := if(rv_i60_inq_peradl_count12 < 23.607238, modinq_size_57_c2519, modinq_size_57_c2525);

modinq_size_57_c2531 := if(rv_i60_inq_retpymt_recency < 92.795154, 13.334385, 8.000000);

modinq_size_57_c2532 := if(nf_inq_quizprovider_count24 < 0.015849, 12.695532, 9.207392);

modinq_size_57_c2530 := if(nf_inq_adlsperaddr_count12 < 0.910794, modinq_size_57_c2531, modinq_size_57_c2532);

modinq_size_57_c2534 := if(nf_inq_adlspercurraddr_count12 < 0.121371, 8.000000, 9.000000);

modinq_size_57_c2533 := if(rv_i62_inq_phones_per_adl < 0.019818, modinq_size_57_c2534, 7.000000);

modinq_size_57_c2529 := if(nf_inq_ssn_ver_count < 16.652403, modinq_size_57_c2530, modinq_size_57_c2533);

modinq_size_57_c2535 := if(nf_inq_lnames_per_ssn < 0.897962, 6.000000, 6.000000);

modinq_size_57_c2528 := if(nf_inq_quizprovider_count < 6.702555, modinq_size_57_c2529, modinq_size_57_c2535);

modinq_size_57_c2536 := if(rv_i60_inq_count12 < 8.021082, 5.000000, 5.000000);

modinq_size_57_c2527 := if(nf_inq_lnames_per_ssn < 1.783508, modinq_size_57_c2528, modinq_size_57_c2536);

modinq_size_57_c2517 := if(nf_inq_mortgage_count < 0.144904, modinq_size_57_c2518, modinq_size_57_c2527);

modinq_size_57_c2542 := if(rv_i62_inq_addrs_per_adl < 0.157114, 8.000000, 9.000000);

modinq_size_57_c2541 := if(nf_inq_ssn_ver_count < 50.056030, modinq_size_57_c2542, 7.000000);

modinq_size_57_c2543 := if(nf_inq_addrsperssn_count12 < 1.073343, 7.000000, 7.000000);

modinq_size_57_c2540 := if(nf_inq_adlsperssn_recency < 7.276364, modinq_size_57_c2541, modinq_size_57_c2543);

modinq_size_57_c2539 := if(nf_inq_retail_count < 0.737414, modinq_size_57_c2540, 5.000000);

modinq_size_57_c2544 := if(rv_i62_inq_dobs_per_adl < 0.438248, 5.000000, 5.000000);

modinq_size_57_c2538 := if(rv_i60_inq_mortgage_recency < 60.839414, modinq_size_57_c2539, modinq_size_57_c2544);

modinq_size_57_c2537 := if(nf_inq_perssn_count_week < 0.346834, modinq_size_57_c2538, 3.000000);

modinq_size_57_c2516 := if(nf_inq_highriskcredit_count < 8.263213, modinq_size_57_c2517, modinq_size_57_c2537);

modinq_size_57_c2550 := if(nf_invbest_inq_adlsperaddr_diff < -0.842232, 7.000000, 7.000000);

modinq_size_57_c2549 := if(rv_i60_inq_peradl_count12 < 1.557136, 6.000000, modinq_size_57_c2550);

modinq_size_57_c2548 := if(nf_inq_per_apt_addr < -0.055729, 5.000000, modinq_size_57_c2549);

modinq_size_57_c2547 := if(nf_inq_highriskcredit_count < 0.680855, modinq_size_57_c2548, 4.000000);

modinq_size_57_c2546 := if(nf_inq_perbestssn_count12 < 0.497625, 3.000000, modinq_size_57_c2547);

modinq_size_57_c2555 := if(nf_inq_ssns_per_addr < 1.166527, 7.000000, 7.000000);

modinq_size_57_c2554 := if(rv_i60_inq_retail_recency < 55.207287, modinq_size_57_c2555, 6.000000);

modinq_size_57_c2553 := if(nf_inq_lnamesperaddr_count_week < 1.533887, modinq_size_57_c2554, 5.000000);

modinq_size_57_c2557 := if(nf_inq_adlspercurraddr_count12 < 1.092039, 6.000000, 6.000000);

modinq_size_57_c2556 := if(nf_inq_addr_recency_risk_index < 3.868880, modinq_size_57_c2557, 5.000000);

modinq_size_57_c2552 := if(nf_inq_other_count < 1.817822, modinq_size_57_c2553, modinq_size_57_c2556);

modinq_size_57_c2551 := if(rv_i62_inq_phonesperadl_recency < 1.030856, modinq_size_57_c2552, 3.000000);

modinq_size_57_c2545 := if(nf_inq_lnames_per_sfd_addr < 0.417175, modinq_size_57_c2546, modinq_size_57_c2551);

modinq_size_57 := if(nf_inq_ssnsperadl_count_week < 0.124441, modinq_size_57_c2516, modinq_size_57_c2545);

modinq_size_58_c2565 := if(nf_inq_collection_count < 34.342913, 17.023327, 8.000000);

modinq_size_58_c2566 := if(nf_inq_other_count_week < 0.916577, 11.535537, 8.000000);

modinq_size_58_c2564 := if(nf_inq_ssnsperaddr_count_week < 0.371037, modinq_size_58_c2565, modinq_size_58_c2566);

modinq_size_58_c2568 := if(nf_inq_addrs_per_ssn < 0.728297, 14.978072, 13.744698);

modinq_size_58_c2569 := if(nf_inq_dobsperbestssn_count12 < 0.092486, 8.000000, 8.000000);

modinq_size_58_c2567 := if(nf_inq_per_ssn < 9.996115, modinq_size_58_c2568, modinq_size_58_c2569);

modinq_size_58_c2563 := if(rv_i61_inq_collection_recency < 39.229418, modinq_size_58_c2564, modinq_size_58_c2567);

modinq_size_58_c2572 := if(nf_inq_ssnspercurraddr_count12 < 0.729765, 10.706640, 8.000000);

modinq_size_58_c2573 := if(rv_i60_inq_comm_recency < 83.899885, 8.000000, 8.000000);

modinq_size_58_c2571 := if(nf_inq_per_apt_addr < -0.229265, modinq_size_58_c2572, modinq_size_58_c2573);

modinq_size_58_c2575 := if(rv_i62_inq_fnamesperadl_recency < 2.858238, 8.000000, 11.296252);

modinq_size_58_c2574 := if(nf_inq_ssn_ver_count < 27.924258, modinq_size_58_c2575, 7.000000);

modinq_size_58_c2570 := if(rv_i62_inq_ssns_per_adl < 0.139753, modinq_size_58_c2571, modinq_size_58_c2574);

modinq_size_58_c2562 := if(nf_inq_retail_count24 < 0.184694, modinq_size_58_c2563, modinq_size_58_c2570);

modinq_size_58_c2561 := if(rv_i61_inq_collection_count12 < 2.083264, modinq_size_58_c2562, 4.000000);

modinq_size_58_c2576 := if(rv_i60_inq_mortgage_count12 < 0.190115, 4.000000, 4.000000);

modinq_size_58_c2560 := if(nf_inq_adlsperaddr_count_week < 1.897427, modinq_size_58_c2561, modinq_size_58_c2576);

modinq_size_58_c2578 := if(nf_inq_bestssn_ver_count < 3.468053, 4.000000, 4.000000);

modinq_size_58_c2577 := if(rv_i60_inq_auto_count12 < 1.465708, modinq_size_58_c2578, 3.000000);

modinq_size_58_c2559 := if(nf_inq_perbestphone_count12 < 2.865691, modinq_size_58_c2560, modinq_size_58_c2577);

modinq_size_58_c2579 := if(nf_inq_banking_count < 1.798965, 2.000000, 2.000000);

modinq_size_58 := if(nf_inq_highriskcredit_count < 52.799518, modinq_size_58_c2559, modinq_size_58_c2579);

modinq_size_59_c2581 := if(nf_inq_adls_per_sfd_addr < 2.284328, 2.000000, 2.000000);

modinq_size_59_c2588 := if(nf_inq_lnamespercurraddr_count12 < 2.845220, 17.573374, 9.207392);

modinq_size_59_c2589 := if(nf_inq_collection_count < 3.540600, 10.327020, 9.000000);

modinq_size_59_c2587 := if(nf_inq_per_apt_addr < 0.142401, modinq_size_59_c2588, modinq_size_59_c2589);

modinq_size_59_c2591 := if(nf_inq_lnames_per_sfd_addr < 1.305608, 8.000000, 8.000000);

modinq_size_59_c2592 := if(nf_inq_retail_count < 0.886692, 8.000000, 8.000000);

modinq_size_59_c2590 := if(nf_inq_dobsperssn_count_day < 0.800885, modinq_size_59_c2591, modinq_size_59_c2592);

modinq_size_59_c2586 := if(nf_inq_ssnsperadl_count_week < 0.210092, modinq_size_59_c2587, modinq_size_59_c2590);

modinq_size_59_c2595 := if(rv_i62_inq_num_names_per_adl < 0.471502, 9.000000, 8.000000);

modinq_size_59_c2594 := if(nf_inq_addrsperssn_count_week < 0.699444, modinq_size_59_c2595, 7.000000);

modinq_size_59_c2596 := if(nf_inq_perssn_recency < 0.691352, 7.000000, 7.000000);

modinq_size_59_c2593 := if(nf_inq_lnames_per_addr < 1.095796, modinq_size_59_c2594, modinq_size_59_c2596);

modinq_size_59_c2585 := if(nf_inq_prepaidcards_count < 0.502136, modinq_size_59_c2586, modinq_size_59_c2593);

modinq_size_59_c2598 := if(nf_invbest_inq_peraddr_diff < 2.618880, 6.000000, 6.000000);

modinq_size_59_c2601 := if(rv_i60_inq_retpymt_recency < 48.926740, 8.000000, 8.000000);

modinq_size_59_c2600 := if(nf_inq_ssnsperaddr_recency < 0.730162, modinq_size_59_c2601, 7.000000);

modinq_size_59_c2599 := if(nf_inq_peradl_count_week < 4.647882, modinq_size_59_c2600, 6.000000);

modinq_size_59_c2597 := if(nf_inq_bestlname_ver_count < 16.351422, modinq_size_59_c2598, modinq_size_59_c2599);

modinq_size_59_c2584 := if(nf_inq_perssn_count_week < 1.919846, modinq_size_59_c2585, modinq_size_59_c2597);

modinq_size_59_c2606 := if(nf_inq_bestssn_ver_count < 4.411754, 8.000000, 9.207392);

modinq_size_59_c2605 := if(rv_i62_inq_dobsperadl_count12 < 0.349457, modinq_size_59_c2606, 7.000000);

modinq_size_59_c2608 := if(rv_i60_inq_count12 < 10.840510, 9.000000, 8.000000);

modinq_size_59_c2607 := if(nf_inq_adlsperaddr_recency < 0.066368, 7.000000, modinq_size_59_c2608);

modinq_size_59_c2604 := if(nf_inq_peraddr_count12 < 0.610265, modinq_size_59_c2605, modinq_size_59_c2607);

modinq_size_59_c2611 := if(nf_inq_per_apt_addr < 0.817118, 13.817534, 9.000000);

modinq_size_59_c2610 := if(rv_i62_inq_fnamesperadl_count12 < 1.886596, modinq_size_59_c2611, 7.000000);

modinq_size_59_c2612 := if(nf_inq_dob_ver_count < 29.438380, 7.000000, 7.000000);

modinq_size_59_c2609 := if(nf_inq_peraddr_count_day < 0.147177, modinq_size_59_c2610, modinq_size_59_c2612);

modinq_size_59_c2603 := if(nf_inq_dobs_per_ssn < 0.680684, modinq_size_59_c2604, modinq_size_59_c2609);

modinq_size_59_c2602 := if(nf_invbest_inq_perssn_diff < -0.275569, modinq_size_59_c2603, 4.000000);

modinq_size_59_c2583 := if(nf_inq_lnamesperssn_recency < 11.535113, modinq_size_59_c2584, modinq_size_59_c2602);

modinq_size_59_c2613 := if(rv_i62_inq_addrsperadl_count12 < 3.294484, 3.000000, 3.000000);

modinq_size_59_c2582 := if(nf_inq_peradl_count_week < 8.362638, modinq_size_59_c2583, modinq_size_59_c2613);

//modinq_size_59 := if(nf_inq_quizprovider_count_day < -2986983449.365269, modinq_size_59_c2581, modinq_size_59_c2582);
modinq_size_59 := if(nf_inq_quizprovider_count_day < -999999998, modinq_size_59_c2581, modinq_size_59_c2582);

modinq_size_60_c2621 := if(nf_inq_communications_count < 2.450407, 13.955690, 8.000000);

modinq_size_60_c2622 := if(nf_inq_bestfname_ver_count < 29.581223, 12.427187, 8.000000);

modinq_size_60_c2620 := if(rv_i62_inq_ssnsperadl_count12 < 0.994334, modinq_size_60_c2621, modinq_size_60_c2622);

modinq_size_60_c2624 := if(nf_inq_dob_ver_count < 48.194368, 10.706640, 8.000000);

modinq_size_60_c2625 := if(nf_inq_fname_ver_count < 20.088059, 11.296252, 8.000000);

modinq_size_60_c2623 := if(nf_inq_adlsperssn_count12 < 0.296076, modinq_size_60_c2624, modinq_size_60_c2625);

modinq_size_60_c2619 := if(nf_inq_retail_count < 0.961530, modinq_size_60_c2620, modinq_size_60_c2623);

modinq_size_60_c2627 := if(nf_inq_adlsperaddr_count12 < 1.380135, 7.000000, 7.000000);

modinq_size_60_c2629 := if(nf_inq_per_ssn < 2.099469, 8.000000, 8.000000);

modinq_size_60_c2630 := if(nf_inq_collection_count24 < 2.882800, 8.000000, 8.000000);

modinq_size_60_c2628 := if(nf_inq_bestlname_ver_count < 11.230358, modinq_size_60_c2629, modinq_size_60_c2630);

modinq_size_60_c2626 := if(rv_i62_inq_dobsperadl_recency < 7.675777, modinq_size_60_c2627, modinq_size_60_c2628);

modinq_size_60_c2618 := if(rv_i62_inq_ssns_per_adl < 1.019321, modinq_size_60_c2619, modinq_size_60_c2626);

modinq_size_60_c2634 := if(nf_inq_per_sfd_addr < 0.246136, 16.015922, 15.762377);

modinq_size_60_c2633 := if(nf_inq_other_count24 < 29.319870, modinq_size_60_c2634, 7.000000);

modinq_size_60_c2636 := if(nf_inq_quizprovider_count < 3.915204, 9.000000, 8.000000);

modinq_size_60_c2635 := if(nf_inq_dobs_per_ssn < 0.026263, 7.000000, modinq_size_60_c2636);

modinq_size_60_c2632 := if(nf_inq_retailpayments_count < 1.950567, modinq_size_60_c2633, modinq_size_60_c2635);

modinq_size_60_c2637 := if(nf_inq_fname_ver_count < 1.200761, 6.000000, 6.000000);

modinq_size_60_c2631 := if(nf_inq_per_addr < 19.229621, modinq_size_60_c2632, modinq_size_60_c2637);

modinq_size_60_c2617 := if(nf_inq_bestphone_ver_count < 6.360913, modinq_size_60_c2618, modinq_size_60_c2631);

modinq_size_60_c2642 := if(rv_i60_inq_retail_recency < 59.081630, 9.000000, 8.000000);

modinq_size_60_c2641 := if(nf_inq_other_count24 < 7.268635, modinq_size_60_c2642, 7.000000);

modinq_size_60_c2640 := if(nf_inq_count_week < 0.947252, modinq_size_60_c2641, 6.000000);

modinq_size_60_c2639 := if(nf_inq_retailpayments_count24 < 0.534614, modinq_size_60_c2640, 5.000000);

modinq_size_60_c2638 := if(rv_i60_inq_comm_recency < 25.367482, modinq_size_60_c2639, 4.000000);

modinq_size_60_c2616 := if(nf_inq_lnames_per_ssn < 1.022694, modinq_size_60_c2617, modinq_size_60_c2638);

modinq_size_60_c2615 := if(nf_inq_other_count_week < 0.803750, modinq_size_60_c2616, 2.000000);

modinq_size_60_c2649 := if(rv_i61_inq_collection_recency < 88.783123, 8.000000, 8.000000);

modinq_size_60_c2648 := if(nf_inq_bestdob_ver_count < 2.783880, 7.000000, modinq_size_60_c2649);

modinq_size_60_c2647 := if(nf_inq_phonesperadl_count_week < 0.664943, 6.000000, modinq_size_60_c2648);

modinq_size_60_c2646 := if(nf_inq_count_day < 0.942340, modinq_size_60_c2647, 5.000000);

modinq_size_60_c2645 := if(nf_inq_retail_count24 < 0.711881, modinq_size_60_c2646, 4.000000);

modinq_size_60_c2644 := if(nf_inq_lnames_per_ssn < 0.054431, 3.000000, modinq_size_60_c2645);

modinq_size_60_c2653 := if(nf_inq_retailpayments_count < 0.406715, 6.000000, 6.000000);

modinq_size_60_c2652 := if(nf_inq_bestssn_ver_count < 3.814122, modinq_size_60_c2653, 5.000000);

modinq_size_60_c2651 := if(rv_i60_inq_retail_recency < 12.222873, 4.000000, modinq_size_60_c2652);

modinq_size_60_c2655 := if(nf_inq_peraddr_count_week < 2.348356, 5.000000, 5.000000);

modinq_size_60_c2656 := if(rv_i60_inq_auto_count12 < 4.477468, 5.000000, 5.000000);

modinq_size_60_c2654 := if(nf_inq_banking_count < 2.422048, modinq_size_60_c2655, modinq_size_60_c2656);

modinq_size_60_c2650 := if(nf_inq_adlsperssn_count_week < 0.456785, modinq_size_60_c2651, modinq_size_60_c2654);

modinq_size_60_c2643 := if(rv_i60_inq_banking_recency < 9.217635, modinq_size_60_c2644, modinq_size_60_c2650);

modinq_size_60 := if(nf_inq_fnamesperadl_count_week < 0.939913, modinq_size_60_c2615, modinq_size_60_c2643);

modinq_size_61_c2664 := if(rv_i60_inq_auto_recency < 87.499785, 13.334385, 8.000000);

modinq_size_61_c2665 := if(rv_i62_inq_phones_per_adl < 0.023496, 14.767255, 12.817256);

modinq_size_61_c2663 := if(nf_inq_lname_ver_count < 3.218889, modinq_size_61_c2664, modinq_size_61_c2665);

modinq_size_61_c2662 := if(nf_inq_lnamesperaddr_count12 < 13.861856, modinq_size_61_c2663, 6.000000);

modinq_size_61_c2668 := if(nf_invbest_inq_adlsperaddr_diff < -0.863386, 10.327020, 8.000000);

modinq_size_61_c2669 := if(rv_i62_inq_dobs_per_adl < 0.000000, 8.000000, 9.000000);

modinq_size_61_c2667 := if(nf_inq_per_addr < 0.762267, modinq_size_61_c2668, modinq_size_61_c2669);

modinq_size_61_c2666 := if(nf_inq_bestlname_ver_count < 181.621531, 6.000000, modinq_size_61_c2667);

modinq_size_61_c2661 := if(nf_inq_bestfname_ver_count < 56.694648, modinq_size_61_c2662, modinq_size_61_c2666);

modinq_size_61_c2673 := if(nf_inq_auto_count24 < 1.383822, 14.629195, 11.941420);

modinq_size_61_c2674 := if(rv_i60_inq_prepaidcards_recency < 36.113455, 10.706640, 8.000000);

modinq_size_61_c2672 := if(nf_inq_peradl_count_week < 1.398853, modinq_size_61_c2673, modinq_size_61_c2674);

modinq_size_61_c2676 := if(nf_inq_percurraddr_count12 < 1.122359, 11.748880, 13.143309);

modinq_size_61_c2677 := if(nf_inq_bestdob_ver_count < 253.167120, 10.327020, 8.000000);

modinq_size_61_c2675 := if(rv_i60_inq_retail_recency < 78.086569, modinq_size_61_c2676, modinq_size_61_c2677);

modinq_size_61_c2671 := if(rv_i60_inq_peradl_recency < 4.815148, modinq_size_61_c2672, modinq_size_61_c2675);

modinq_size_61_c2679 := if(nf_inq_per_addr < 2.765853, 7.000000, 7.000000);

modinq_size_61_c2678 := if(nf_inq_ssnsperaddr_count_day < 0.285534, 6.000000, modinq_size_61_c2679);

modinq_size_61_c2670 := if(nf_inq_fnamesperadl_count_day < 0.431823, modinq_size_61_c2671, modinq_size_61_c2678);

modinq_size_61_c2660 := if(nf_inq_adlspercurraddr_count12 < 0.673692, modinq_size_61_c2661, modinq_size_61_c2670);

//modinq_size_61_c2659 := if(nf_inq_lnames_per_apt_addr < -1211121828.291552, 3.000000, modinq_size_61_c2660);
modinq_size_61_c2659 := if(nf_inq_lnames_per_apt_addr < -999999998, 3.000000, modinq_size_61_c2660);

modinq_size_61_c2680 := if(nf_inq_lnames_per_ssn < 0.937534, 3.000000, 3.000000);

modinq_size_61_c2658 := if(rv_i60_inq_util_count12 < 0.704001, modinq_size_61_c2659, modinq_size_61_c2680);

modinq_size_61_c2687 := if(nf_inq_lnames_per_addr < 0.666647, 14.480886, 12.116889);

modinq_size_61_c2688 := if(nf_inq_addr_ver_count < 217.876244, 8.000000, 8.000000);

modinq_size_61_c2686 := if(nf_inq_ssns_per_addr < 1.455954, modinq_size_61_c2687, modinq_size_61_c2688);

modinq_size_61_c2685 := if(nf_inq_highriskcredit_count < 3.815379, modinq_size_61_c2686, 6.000000);

modinq_size_61_c2684 := if(nf_inq_percurraddr_count12 < 4.725145, modinq_size_61_c2685, 5.000000);

modinq_size_61_c2683 := if(nf_inq_ssns_per_addr < 4.784521, modinq_size_61_c2684, 4.000000);

modinq_size_61_c2689 := if(nf_inq_lnames_per_sfd_addr < 0.229975, 4.000000, 4.000000);

modinq_size_61_c2682 := if(nf_inq_lnamesperssn_count12 < 0.689388, modinq_size_61_c2683, modinq_size_61_c2689);

modinq_size_61_c2681 := if(nf_inq_peraddr_count_week < 0.082930, modinq_size_61_c2682, 2.000000);

modinq_size_61 := if(rv_i60_inq_recency < 46.654132, modinq_size_61_c2658, modinq_size_61_c2681);

modinq_size_62_c2697 := if(nf_inq_lnamesperbestssn_count12 < 0.310868, 16.810994, 14.320683);

modinq_size_62_c2698 := if(nf_inq_adlsperaddr_count12 < 2.429954, 12.817256, 8.000000);

modinq_size_62_c2696 := if(nf_inq_bestlname_ver_count < 166.360224, modinq_size_62_c2697, modinq_size_62_c2698);

modinq_size_62_c2700 := if(rv_i60_inq_banking_recency < 92.191292, 14.320683, 12.278091);

modinq_size_62_c2701 := if(rv_i60_inq_other_count12 < 3.740075, 9.000000, 8.000000);

modinq_size_62_c2699 := if(nf_inq_banking_count24 < 4.530762, modinq_size_62_c2700, modinq_size_62_c2701);

modinq_size_62_c2695 := if(rv_i60_inq_count12 < 2.097315, modinq_size_62_c2696, modinq_size_62_c2699);

modinq_size_62_c2694 := if(nf_inq_auto_count_week < 1.284683, modinq_size_62_c2695, 5.000000);

modinq_size_62_c2693 := if(rv_i60_inq_prepaidcards_count12 < 0.722554, modinq_size_62_c2694, 4.000000);

modinq_size_62_c2706 := if(rv_i62_inq_phonesperadl_recency < 3.854757, 9.207392, 9.207392);

modinq_size_62_c2705 := if(rv_i62_inq_ssns_per_adl < 9.419495, modinq_size_62_c2706, 7.000000);

modinq_size_62_c2707 := if(nf_inq_addrs_per_ssn < 0.344302, 7.000000, 7.000000);

modinq_size_62_c2704 := if(rv_i60_inq_banking_recency < 49.454466, modinq_size_62_c2705, modinq_size_62_c2707);

modinq_size_62_c2708 := if(nf_inq_peraddr_count_day < 0.144603, 6.000000, 6.000000);

modinq_size_62_c2703 := if(nf_inq_ssnsperaddr_recency < 9.995612, modinq_size_62_c2704, modinq_size_62_c2708);

modinq_size_62_c2709 := if(nf_inq_lnamesperssn_recency < 11.364043, 5.000000, 5.000000);

modinq_size_62_c2702 := if(nf_inq_lnames_per_addr < 1.316776, modinq_size_62_c2703, modinq_size_62_c2709);

modinq_size_62_c2692 := if(rv_i61_inq_collection_count12 < 1.700786, modinq_size_62_c2693, modinq_size_62_c2702);

modinq_size_62_c2711 := if(nf_inq_other_count < 0.940019, 4.000000, 4.000000);

modinq_size_62_c2715 := if(rv_i62_inq_addrsperadl_count12 < 1.749518, 7.000000, 7.000000);

modinq_size_62_c2714 := if(nf_inq_auto_count < 4.160672, 6.000000, modinq_size_62_c2715);

modinq_size_62_c2713 := if(nf_inq_lnamesperaddr_recency < 0.789128, 5.000000, modinq_size_62_c2714);

modinq_size_62_c2712 := if(rv_i62_inq_num_names_per_adl < 1.547850, modinq_size_62_c2713, 4.000000);

modinq_size_62_c2710 := if(nf_inq_addrsperssn_recency < 0.944660, modinq_size_62_c2711, modinq_size_62_c2712);

modinq_size_62_c2691 := if(nf_inq_dobsperadl_count_week < 0.184638, modinq_size_62_c2692, modinq_size_62_c2710);

modinq_size_62_c2717 := if(nf_inq_ssn_ver_count < 78.563402, 3.000000, 3.000000);

modinq_size_62_c2716 := if(nf_inq_dobs_per_ssn < 1.183172, modinq_size_62_c2717, 2.000000);

modinq_size_62 := if(nf_inq_per_sfd_addr < 14.334671, modinq_size_62_c2691, modinq_size_62_c2716);

modinq_size_63_c2725 := if(rv_i60_inq_retpymt_recency < 43.055000, 17.605896, 11.941420);

modinq_size_63_c2726 := if(nf_inq_banking_count24 < 1.978815, 9.000000, 8.000000);

modinq_size_63_c2724 := if(nf_inq_adlsperaddr_count_day < 0.817381, modinq_size_63_c2725, modinq_size_63_c2726);

modinq_size_63_c2723 := if(nf_inq_perssn_count_day < 5.379419, modinq_size_63_c2724, 6.000000);

modinq_size_63_c2729 := if(rv_i62_inq_phones_per_adl < 1.849031, 10.327020, 8.000000);

modinq_size_63_c2728 := if(rv_i60_inq_count12 < 6.967391, modinq_size_63_c2729, 7.000000);

modinq_size_63_c2727 := if(rv_i62_inq_dobsperadl_count12 < 1.351786, modinq_size_63_c2728, 6.000000);

modinq_size_63_c2722 := if(nf_inq_communications_count24 < 1.922297, modinq_size_63_c2723, modinq_size_63_c2727);

modinq_size_63_c2733 := if(nf_inq_ssns_per_apt_addr < -0.250915, 11.535537, 9.000000);

modinq_size_63_c2734 := if(nf_inq_per_ssn < 1.498106, 8.000000, 8.000000);

modinq_size_63_c2732 := if(nf_inq_perssn_recency < 4.951584, modinq_size_63_c2733, modinq_size_63_c2734);

modinq_size_63_c2731 := if(nf_inq_addrsperssn_count12 < 0.183247, modinq_size_63_c2732, 6.000000);

modinq_size_63_c2736 := if(nf_inq_lnamesperaddr_recency < 6.572775, 7.000000, 7.000000);

modinq_size_63_c2737 := if(nf_invbest_inq_lastperaddr_diff < -0.748548, 7.000000, 7.000000);

modinq_size_63_c2735 := if(nf_inq_perssn_recency < 2.030256, modinq_size_63_c2736, modinq_size_63_c2737);

modinq_size_63_c2730 := if(nf_inq_adls_per_sfd_addr < 0.810565, modinq_size_63_c2731, modinq_size_63_c2735);

modinq_size_63_c2721 := if(nf_inq_fname_ver_count < 141.418451, modinq_size_63_c2722, modinq_size_63_c2730);

modinq_size_63_c2720 := if(nf_inq_quizprovider_count < 9.590871, modinq_size_63_c2721, 3.000000);

modinq_size_63_c2743 := if(nf_inq_lnames_per_addr < 0.530431, 11.023665, 9.851656);

modinq_size_63_c2742 := if(nf_inq_perssn_count12 < 13.552217, modinq_size_63_c2743, 7.000000);

modinq_size_63_c2745 := if(rv_i62_inq_addrs_per_adl < 1.689411, 8.000000, 8.000000);

modinq_size_63_c2744 := if(nf_inq_lnamesperssn_count12 < 0.756512, 7.000000, modinq_size_63_c2745);

modinq_size_63_c2741 := if(nf_inq_communications_count < 1.545458, modinq_size_63_c2742, modinq_size_63_c2744);

modinq_size_63_c2747 := if(nf_inq_adlsperssn_recency < 11.289940, 7.000000, 7.000000);

modinq_size_63_c2749 := if(nf_invbest_inq_adlsperaddr_diff < -0.509051, 8.000000, 9.000000);

modinq_size_63_c2748 := if(rv_i62_inq_dobs_per_adl < 0.418739, modinq_size_63_c2749, 7.000000);

modinq_size_63_c2746 := if(nf_inq_auto_count < 0.483220, modinq_size_63_c2747, modinq_size_63_c2748);

modinq_size_63_c2740 := if(nf_inq_mortgage_count < 0.102883, modinq_size_63_c2741, modinq_size_63_c2746);

modinq_size_63_c2739 := if(nf_inq_lnames_per_apt_addr < 1.069483, modinq_size_63_c2740, 4.000000);

modinq_size_63_c2750 := if(nf_inq_retail_count24 < 0.032891, 4.000000, 4.000000);

modinq_size_63_c2738 := if(nf_inq_adlsperbestphone_count12 < 0.070260, modinq_size_63_c2739, modinq_size_63_c2750);

modinq_size_63_c2719 := if(nf_inq_other_count24 < 3.216632, modinq_size_63_c2720, modinq_size_63_c2738);

modinq_size_63_c2752 := if(nf_inq_count_day < 5.675139, 3.000000, 3.000000);

modinq_size_63_c2753 := if(nf_inq_auto_count < 38.103405, 3.000000, 3.000000);

modinq_size_63_c2751 := if(nf_inq_addrsperssn_recency < 3.959653, modinq_size_63_c2752, modinq_size_63_c2753);

modinq_size_63 := if(nf_inquiry_ssn_vel_risk_indexv2 < 3.139615, modinq_size_63_c2719, modinq_size_63_c2751);

modinq_size_64_c2761 := if(nf_inq_dobsperssn_recency < 7.084264, 17.266882, 13.241134);

modinq_size_64_c2762 := if(nf_inq_adlsperssn_count_week < 0.721564, 13.508753, 9.000000);

modinq_size_64_c2760 := if(rv_i62_inq_addrsperadl_count12 < 1.336256, modinq_size_64_c2761, modinq_size_64_c2762);

modinq_size_64_c2763 := if(rv_i62_inq_addrs_per_adl < 2.072370, 7.000000, 7.000000);

modinq_size_64_c2759 := if(rv_i60_inq_hiriskcred_count12 < 3.160728, modinq_size_64_c2760, modinq_size_64_c2763);

modinq_size_64_c2766 := if(rv_i62_inq_lnamesperadl_count12 < 0.889588, 13.817534, 9.000000);

modinq_size_64_c2765 := if(nf_inq_retail_count < 5.851386, modinq_size_64_c2766, 7.000000);

modinq_size_64_c2764 := if(nf_invbest_inq_dobsperssn_diff < -0.797046, modinq_size_64_c2765, 6.000000);

modinq_size_64_c2758 := if(nf_inq_bestdob_ver_count < 114.756326, modinq_size_64_c2759, modinq_size_64_c2764);

modinq_size_64_c2769 := if(rv_i61_inq_collection_recency < 65.192931, 7.000000, 7.000000);

modinq_size_64_c2768 := if(nf_inq_adlsperaddr_count_week < 0.224593, modinq_size_64_c2769, 6.000000);

modinq_size_64_c2767 := if(nf_inq_dob_ver_count < 2.425952, 5.000000, modinq_size_64_c2768);

modinq_size_64_c2757 := if(nf_inq_banking_count_week < 0.983582, modinq_size_64_c2758, modinq_size_64_c2767);

modinq_size_64_c2770 := if(nf_inq_mortgage_count < 0.294870, 4.000000, 4.000000);

modinq_size_64_c2756 := if(nf_inq_adlsperssn_count12 < 1.404276, modinq_size_64_c2757, modinq_size_64_c2770);

modinq_size_64_c2775 := if(nf_inq_lnamespercurraddr_count12 < 1.926434, 7.000000, 7.000000);

modinq_size_64_c2774 := if(nf_inq_lnamesperssn_count12 < 0.200144, modinq_size_64_c2775, 6.000000);

modinq_size_64_c2777 := if(nf_inq_peradl_count_week < 9.268234, 7.000000, 7.000000);

modinq_size_64_c2776 := if(rv_i60_inq_other_recency < 29.545529, modinq_size_64_c2777, 6.000000);

modinq_size_64_c2773 := if(nf_inq_other_count < 0.356209, modinq_size_64_c2774, modinq_size_64_c2776);

modinq_size_64_c2779 := if(nf_invbest_inq_peraddr_diff < 4.463579, 6.000000, 6.000000);

modinq_size_64_c2778 := if(nf_inq_addrsperssn_count12 < 0.405566, modinq_size_64_c2779, 5.000000);

modinq_size_64_c2772 := if(nf_inq_quizprovider_count < 0.387265, modinq_size_64_c2773, modinq_size_64_c2778);

modinq_size_64_c2780 := if(nf_inq_addrsperssn_count_week < 1.827558, 4.000000, 4.000000);

modinq_size_64_c2771 := if(nf_inq_ssns_per_addr < 3.549481, modinq_size_64_c2772, modinq_size_64_c2780);

modinq_size_64_c2755 := if(nf_inquiry_addr_vel_risk_indexv2 < 2.986355, modinq_size_64_c2756, modinq_size_64_c2771);

//modinq_size_64 := if(nf_inq_banking_count_day < -2739234558.703618, 1.000000, modinq_size_64_c2755);
modinq_size_64 := if(nf_inq_banking_count_day < -999999998, 1.000000, modinq_size_64_c2755);

modinq_size_65_c2788 := if(nf_inq_ssnsperaddr_count_week < 0.607615, 16.404280, 9.000000);

modinq_size_65_c2789 := if(rv_i60_inq_recency < 20.164372, 9.851656, 9.851656);

modinq_size_65_c2787 := if(nf_inq_retail_count < 1.444193, modinq_size_65_c2788, modinq_size_65_c2789);

modinq_size_65_c2791 := if(nf_inq_per_apt_addr < -0.470386, 8.000000, 8.000000);

modinq_size_65_c2790 := if(nf_inq_ssn_ver_count < 3.463363, 7.000000, modinq_size_65_c2791);

modinq_size_65_c2786 := if(nf_inq_count24 < 5.228443, modinq_size_65_c2787, modinq_size_65_c2790);

modinq_size_65_c2794 := if(nf_inq_perssn_count12 < 5.103663, 14.146509, 11.296252);

modinq_size_65_c2795 := if(nf_inq_quizprovider_count < 1.724131, 9.000000, 9.000000);

modinq_size_65_c2793 := if(rv_i62_inq_addrs_per_adl < 2.548370, modinq_size_65_c2794, modinq_size_65_c2795);

modinq_size_65_c2796 := if(rv_i60_inq_count12 < 9.012565, 7.000000, 7.000000);

modinq_size_65_c2792 := if(nf_inq_utilities_count < 0.097598, modinq_size_65_c2793, modinq_size_65_c2796);

modinq_size_65_c2785 := if(nf_inq_dobsperssn_count12 < 0.638039, modinq_size_65_c2786, modinq_size_65_c2792);

modinq_size_65_c2797 := if(nf_inq_lnamesperaddr_recency < 1.430067, 5.000000, 5.000000);

modinq_size_65_c2784 := if(nf_invbest_inq_addrsperssn_diff < -0.397213, modinq_size_65_c2785, modinq_size_65_c2797);

modinq_size_65_c2802 := if(rv_i62_inq_phones_per_adl < 0.583824, 13.241134, 10.327020);

modinq_size_65_c2803 := if(nf_inq_lnamespercurraddr_count12 < 1.972672, 12.565879, 11.296252);

modinq_size_65_c2801 := if(nf_inq_lnamesperaddr_recency < 0.615359, modinq_size_65_c2802, modinq_size_65_c2803);

modinq_size_65_c2800 := if(nf_inq_addrs_per_ssn < 3.322962, modinq_size_65_c2801, 6.000000);

modinq_size_65_c2806 := if(nf_inq_quizprovider_count < 1.177264, 11.941420, 8.000000);

modinq_size_65_c2807 := if(rv_i60_inq_peradl_recency < 6.086749, 9.000000, 11.535537);

modinq_size_65_c2805 := if(nf_inq_adlsperssn_recency < 6.523264, modinq_size_65_c2806, modinq_size_65_c2807);

modinq_size_65_c2809 := if(nf_inq_bestfname_ver_count < 46.692251, 9.000000, 8.000000);

modinq_size_65_c2808 := if(nf_inquiry_ssn_vel_risk_index < 4.320254, modinq_size_65_c2809, 7.000000);

modinq_size_65_c2804 := if(nf_inq_count24 < 7.506414, modinq_size_65_c2805, modinq_size_65_c2808);

modinq_size_65_c2799 := if(nf_inq_perssn_recency < 5.576040, modinq_size_65_c2800, modinq_size_65_c2804);

modinq_size_65_c2813 := if(nf_inq_ssns_per_addr < 1.112086, 8.000000, 8.000000);

modinq_size_65_c2812 := if(nf_inq_count24 < 0.523006, 7.000000, modinq_size_65_c2813);

modinq_size_65_c2811 := if(nf_inq_adlsperssn_recency < 6.973695, 6.000000, modinq_size_65_c2812);

modinq_size_65_c2810 := if(rv_i62_inq_lnamesperadl_recency < 3.032091, 5.000000, modinq_size_65_c2811);

modinq_size_65_c2798 := if(nf_inq_perbestphone_count12 < 0.051313, modinq_size_65_c2799, modinq_size_65_c2810);

modinq_size_65_c2783 := if(rv_i60_inq_auto_recency < 8.073760, modinq_size_65_c2784, modinq_size_65_c2798);

modinq_size_65_c2819 := if(rv_i60_inq_other_recency < 51.392507, 9.207392, 8.000000);

modinq_size_65_c2818 := if(nf_inq_addr_ver_count < 7.711658, modinq_size_65_c2819, 7.000000);

modinq_size_65_c2817 := if(nf_inq_addrsperbestssn_count12 < 0.928441, 6.000000, modinq_size_65_c2818);

modinq_size_65_c2816 := if(nf_inq_other_count < 3.779497, modinq_size_65_c2817, 5.000000);

modinq_size_65_c2815 := if(nf_inq_per_ssn < 0.236098, 4.000000, modinq_size_65_c2816);

modinq_size_65_c2814 := if(nf_inq_adlsperaddr_recency < 3.798263, modinq_size_65_c2815, 3.000000);

modinq_size_65_c2782 := if(nf_inq_lnamesperadl_count_week < 0.996183, modinq_size_65_c2783, modinq_size_65_c2814);

//modinq_size_65 := if(nf_inq_lnamesperaddr_count12 < -4796181171.105668, 1.000000, modinq_size_65_c2782);
modinq_size_65 := if(nf_inq_lnamesperaddr_count12 < -999999998, 1.000000, modinq_size_65_c2782);

modinq_size_66_c2824 := if(nf_inq_lnames_per_sfd_addr < -0.017643, 5.000000, 6.000000);

modinq_size_66_c2823 := if(nf_inq_per_sfd_addr < 0.061116, modinq_size_66_c2824, 4.000000);

modinq_size_66_c2822 := if(nf_inq_lnames_per_ssn < 0.734747, modinq_size_66_c2823, 3.000000);

//modinq_size_66_c2821 := if(nf_inq_lnames_per_apt_addr < -1889868178.215880, 2.000000, modinq_size_66_c2822);
modinq_size_66_c2821 := if(nf_inq_lnames_per_apt_addr < -999999998, 2.000000, modinq_size_66_c2822);

modinq_size_66_c2831 := if(rv_i62_inq_addrsperadl_count12 < 0.731119, 16.762406, 11.296252);

modinq_size_66_c2830 := if(nf_inq_perbestphone_count12 < 1.281444, modinq_size_66_c2831, 7.000000);

modinq_size_66_c2829 := if(nf_invbest_inq_perssn_diff < -0.401519, modinq_size_66_c2830, 6.000000);

modinq_size_66_c2828 := if(nf_inq_peradl_count_day < 0.081107, modinq_size_66_c2829, 5.000000);

modinq_size_66_c2835 := if(nf_inq_perbestphone_count12 < 0.519741, 10.706640, 8.000000);

modinq_size_66_c2836 := if(nf_inq_ssns_per_sfd_addr < 1.866182, 8.000000, 8.000000);

modinq_size_66_c2834 := if(rv_i60_inq_comm_recency < 51.177148, modinq_size_66_c2835, modinq_size_66_c2836);

modinq_size_66_c2833 := if(rv_i60_inq_retail_count12 < 0.946934, modinq_size_66_c2834, 6.000000);

modinq_size_66_c2832 := if(nf_inquiry_addr_vel_risk_indexv2 < 3.929907, modinq_size_66_c2833, 5.000000);

modinq_size_66_c2827 := if(nf_inq_lnames_per_sfd_addr < 1.104599, modinq_size_66_c2828, modinq_size_66_c2832);

modinq_size_66_c2837 := if(nf_inq_auto_count < 5.755190, 4.000000, 4.000000);

modinq_size_66_c2826 := if(nf_inq_lnamesperaddr_count_week < 0.675019, modinq_size_66_c2827, modinq_size_66_c2837);

modinq_size_66_c2843 := if(rv_i62_inq_ssnsperadl_recency < 10.821925, 9.207392, 9.207392);

modinq_size_66_c2842 := if(nf_inq_per_ssn < 0.908346, modinq_size_66_c2843, 7.000000);

modinq_size_66_c2845 := if(nf_inq_bestdob_ver_count < 121.346160, 9.000000, 8.000000);

modinq_size_66_c2844 := if(rv_i62_inq_phonesperadl_count12 < 0.798474, modinq_size_66_c2845, 7.000000);

modinq_size_66_c2841 := if(nf_inq_other_count24 < 0.582190, modinq_size_66_c2842, modinq_size_66_c2844);

modinq_size_66_c2848 := if(rv_i62_inq_ssnsperadl_recency < 4.750690, 13.508753, 15.132052);

modinq_size_66_c2849 := if(nf_inq_banking_count24 < 31.884668, 9.851656, 8.000000);

modinq_size_66_c2847 := if(rv_i60_inq_peradl_count12 < 13.697047, modinq_size_66_c2848, modinq_size_66_c2849);

modinq_size_66_c2851 := if(rv_i60_inq_peradl_count12 < 6.827155, 10.327020, 8.000000);

modinq_size_66_c2852 := if(rv_i62_inq_addrs_per_adl < 3.601245, 8.000000, 8.000000);

modinq_size_66_c2850 := if(rv_i62_inq_ssnsperadl_count12 < 1.036143, modinq_size_66_c2851, modinq_size_66_c2852);

modinq_size_66_c2846 := if(nf_inq_lnamesperaddr_count_week < 0.813515, modinq_size_66_c2847, modinq_size_66_c2850);

modinq_size_66_c2840 := if(nf_inq_lnames_per_ssn < 0.862189, modinq_size_66_c2841, modinq_size_66_c2846);

modinq_size_66_c2839 := if(nf_inquiry_verification_index < 7.681494, 4.000000, modinq_size_66_c2840);

modinq_size_66_c2838 := if(nf_inq_per_addr < 29.538238, modinq_size_66_c2839, 3.000000);

modinq_size_66_c2825 := if(rv_i62_inq_ssns_per_adl < 0.788270, modinq_size_66_c2826, modinq_size_66_c2838);

//modinq_size_66 := if(nf_inq_dobsperssn_count12 < -6769909459.240204, modinq_size_66_c2821, modinq_size_66_c2825);
modinq_size_66 := if(nf_inq_dobsperssn_count12 < -999999998, modinq_size_66_c2821, modinq_size_66_c2825);

modinq_size_67_c2854 := if(nf_inq_ssns_per_sfd_addr < -6293760651.929460, 2.000000, 2.000000);

modinq_size_67_c2856 := if(nf_inq_adls_per_ssn < 0.395783, 3.000000, 3.000000);

modinq_size_67_c2862 := if(nf_inq_lnamesperaddr_count_week < 0.616355, 15.991966, 8.000000);

modinq_size_67_c2863 := if(nf_inq_per_apt_addr < -0.578069, 14.811235, 9.851656);

modinq_size_67_c2861 := if(rv_i61_inq_collection_recency < 62.173930, modinq_size_67_c2862, modinq_size_67_c2863);

modinq_size_67_c2865 := if(nf_inq_lnamesperaddr_count_week < 0.030024, 9.851656, 10.327020);

modinq_size_67_c2864 := if(nf_inq_other_count < 1.723921, modinq_size_67_c2865, 7.000000);

modinq_size_67_c2860 := if(nf_inq_peradl_count_week < 1.960966, modinq_size_67_c2861, modinq_size_67_c2864);

modinq_size_67_c2866 := if(nf_inq_per_ssn < 0.547231, 6.000000, 6.000000);

modinq_size_67_c2859 := if(rv_i60_inq_other_count12 < 1.898143, modinq_size_67_c2860, modinq_size_67_c2866);

modinq_size_67_c2870 := if(rv_i60_credit_seeking < 0.815607, 13.040438, 9.000000);

modinq_size_67_c2871 := if(nf_inq_addr_ver_count < 1.813470, 9.000000, 9.000000);

modinq_size_67_c2869 := if(rv_i60_inq_retail_recency < 38.560718, modinq_size_67_c2870, modinq_size_67_c2871);

modinq_size_67_c2872 := if(rv_i60_credit_seeking < 1.182922, 7.000000, 7.000000);

modinq_size_67_c2868 := if(nf_inq_peradl_count_week < 0.269293, modinq_size_67_c2869, modinq_size_67_c2872);

modinq_size_67_c2867 := if(nf_inq_highriskcredit_count24 < 1.918122, modinq_size_67_c2868, 5.000000);

modinq_size_67_c2858 := if(nf_invbest_inq_lastperaddr_diff < -0.035618, modinq_size_67_c2859, modinq_size_67_c2867);

modinq_size_67_c2877 := if(nf_inq_lnamesperssn_recency < 5.631194, 10.706640, 13.143309);

modinq_size_67_c2878 := if(nf_inq_bestfname_ver_count < 215.325685, 13.040438, 8.000000);

modinq_size_67_c2876 := if(nf_inq_addrsperssn_recency < 11.973113, modinq_size_67_c2877, modinq_size_67_c2878);

modinq_size_67_c2879 := if(nf_inq_banking_count < 0.591120, 7.000000, 7.000000);

modinq_size_67_c2875 := if(nf_inq_percurraddr_count12 < 5.455230, modinq_size_67_c2876, modinq_size_67_c2879);

modinq_size_67_c2882 := if(nf_invbest_inq_lastperaddr_diff < -0.340731, 13.423473, 9.207392);

modinq_size_67_c2881 := if(nf_inq_count24 < 23.880713, modinq_size_67_c2882, 7.000000);

modinq_size_67_c2880 := if(nf_invbest_inq_ssnsperaddr_diff < 2.349840, modinq_size_67_c2881, 6.000000);

modinq_size_67_c2874 := if(nf_inq_adls_per_addr < 1.741969, modinq_size_67_c2875, modinq_size_67_c2880);

modinq_size_67_c2883 := if(rv_i60_inq_banking_recency < 32.318205, 5.000000, 5.000000);

modinq_size_67_c2873 := if(nf_inq_collection_count < 27.076660, modinq_size_67_c2874, modinq_size_67_c2883);

modinq_size_67_c2857 := if(nf_inq_adlsperssn_recency < 2.687903, modinq_size_67_c2858, modinq_size_67_c2873);

modinq_size_67_c2855 := if(nf_invbest_inq_ssnsperaddr_diff < -3.895187, modinq_size_67_c2856, modinq_size_67_c2857);

//modinq_size_67 := if(nf_inq_addrsperssn_count_day < -3632829532.253173, modinq_size_67_c2854, modinq_size_67_c2855);
modinq_size_67 := if(nf_inq_addrsperssn_count_day < -999999998, modinq_size_67_c2854, modinq_size_67_c2855);

modinq_size_68_c2891 := if(nf_inq_fname_ver_count < 46.872122, 15.918327, 8.000000);

modinq_size_68_c2892 := if(nf_inq_retailpayments_count < 0.805868, 11.941420, 8.000000);

modinq_size_68_c2890 := if(nf_inq_dob_ver_count < 158.875188, modinq_size_68_c2891, modinq_size_68_c2892);

modinq_size_68_c2894 := if(rv_i60_inq_recency < 76.103472, 10.706640, 11.748880);

modinq_size_68_c2893 := if(rv_i61_inq_collection_count12 < 0.152723, modinq_size_68_c2894, 7.000000);

modinq_size_68_c2889 := if(rv_i60_inq_auto_recency < 80.813004, modinq_size_68_c2890, modinq_size_68_c2893);

modinq_size_68_c2896 := if(nf_inq_peraddr_count12 < 13.371635, 7.000000, 7.000000);

modinq_size_68_c2895 := if(nf_inq_per_apt_addr < 3.291821, modinq_size_68_c2896, 6.000000);

modinq_size_68_c2888 := if(nf_inq_per_addr < 8.194466, modinq_size_68_c2889, modinq_size_68_c2895);

modinq_size_68_c2900 := if(nf_inq_retailpayments_count < 0.850336, 13.955690, 9.000000);

modinq_size_68_c2899 := if(nf_inq_lnamesperadl_count_day < 0.235404, modinq_size_68_c2900, 7.000000);

modinq_size_68_c2898 := if(nf_inq_count < 44.738347, modinq_size_68_c2899, 6.000000);

modinq_size_68_c2903 := if(nf_inq_dob_ver_count < 33.973411, 8.000000, 8.000000);

modinq_size_68_c2904 := if(nf_invbest_inq_ssnsperaddr_diff < 0.665734, 8.000000, 8.000000);

modinq_size_68_c2902 := if(nf_inq_lnames_per_addr < 1.762362, modinq_size_68_c2903, modinq_size_68_c2904);

modinq_size_68_c2906 := if(nf_inquiry_addr_vel_risk_indexv2 < 3.475442, 8.000000, 8.000000);

modinq_size_68_c2905 := if(nf_inq_lname_ver_count < 23.234904, modinq_size_68_c2906, 7.000000);

modinq_size_68_c2901 := if(rv_i62_inq_dobsperadl_recency < 11.916193, modinq_size_68_c2902, modinq_size_68_c2905);

modinq_size_68_c2897 := if(nf_inquiry_adl_vel_risk_index < 3.222343, modinq_size_68_c2898, modinq_size_68_c2901);

modinq_size_68_c2887 := if(rv_i62_inq_addrs_per_adl < 0.818736, modinq_size_68_c2888, modinq_size_68_c2897);

modinq_size_68_c2886 := if(nf_inquiry_adl_vel_risk_index < 4.741826, modinq_size_68_c2887, 3.000000);

modinq_size_68_c2912 := if(nf_inq_perssn_count12 < 1.063199, 11.535537, 14.021342);

modinq_size_68_c2911 := if(nf_invbest_inq_addrsperssn_diff < 0.065711, modinq_size_68_c2912, 7.000000);

modinq_size_68_c2910 := if(nf_inquiry_adl_vel_risk_index < 5.783281, modinq_size_68_c2911, 6.000000);

modinq_size_68_c2914 := if(nf_inq_banking_count < 1.058901, 7.000000, 7.000000);

modinq_size_68_c2916 := if(nf_inq_other_count < 3.830036, 11.296252, 8.000000);

modinq_size_68_c2915 := if(nf_inq_retailpayments_count < 0.367079, modinq_size_68_c2916, 7.000000);

modinq_size_68_c2913 := if(nf_inq_ssnsperaddr_recency < 3.180884, modinq_size_68_c2914, modinq_size_68_c2915);

modinq_size_68_c2909 := if(nf_inq_percurraddr_count12 < 4.219053, modinq_size_68_c2910, modinq_size_68_c2913);

modinq_size_68_c2920 := if(nf_inq_perssn_count12 < 1.507837, 9.207392, 9.207392);

modinq_size_68_c2919 := if(nf_inq_ssns_per_sfd_addr < 0.905069, 7.000000, modinq_size_68_c2920);

modinq_size_68_c2918 := if(rv_i60_inq_recency < 19.179759, modinq_size_68_c2919, 6.000000);

modinq_size_68_c2917 := if(nf_inq_lnamesperssn_count12 < 1.784138, modinq_size_68_c2918, 5.000000);

modinq_size_68_c2908 := if(rv_i60_inq_retpymt_recency < 54.422870, modinq_size_68_c2909, modinq_size_68_c2917);

modinq_size_68_c2907 := if(rv_i60_inq_hiriskcred_count12 < 2.627215, modinq_size_68_c2908, 3.000000);

modinq_size_68_c2885 := if(rv_i62_inq_addrsperadl_recency < 5.298400, modinq_size_68_c2886, modinq_size_68_c2907);

modinq_size_68_c2927 := if(nf_invbest_inq_dobsperssn_diff < -0.609566, 13.143309, 8.000000);

modinq_size_68_c2926 := if(nf_inq_retail_count < 1.697926, modinq_size_68_c2927, 7.000000);

modinq_size_68_c2928 := if(rv_i60_inq_peradl_count12 < 1.467242, 7.000000, 7.000000);

modinq_size_68_c2925 := if(nf_inq_lnamesperaddr_recency < 0.927491, modinq_size_68_c2926, modinq_size_68_c2928);

modinq_size_68_c2924 := if(rv_i62_inq_lnamesperadl_count12 < 1.216245, modinq_size_68_c2925, 5.000000);

modinq_size_68_c2923 := if(rv_i60_inq_comm_count12 < 9.381857, modinq_size_68_c2924, 4.000000);

modinq_size_68_c2930 := if(rv_i60_inq_count12 < 0.052732, 5.000000, 5.000000);

modinq_size_68_c2932 := if(nf_inq_lnamesperaddr_recency < 6.778959, 6.000000, 6.000000);

modinq_size_68_c2931 := if(nf_inq_ssnsperaddr_count12 < 0.704720, 5.000000, modinq_size_68_c2932);

modinq_size_68_c2929 := if(nf_inq_bestfname_ver_count < 106.594551, modinq_size_68_c2930, modinq_size_68_c2931);

modinq_size_68_c2922 := if(nf_inq_adlspercurraddr_count12 < 0.696064, modinq_size_68_c2923, modinq_size_68_c2929);

modinq_size_68_c2937 := if(nf_inq_ssns_per_sfd_addr < 2.090365, 7.000000, 7.000000);

modinq_size_68_c2936 := if(nf_inq_per_sfd_addr < 2.427272, 6.000000, modinq_size_68_c2937);

modinq_size_68_c2935 := if(nf_inq_bestdob_ver_count < 190.840394, 5.000000, modinq_size_68_c2936);

modinq_size_68_c2934 := if(nf_inq_quizprovider_count < 0.877058, modinq_size_68_c2935, 4.000000);

modinq_size_68_c2933 := if(nf_inq_adlsperaddr_count12 < 1.497541, 3.000000, modinq_size_68_c2934);

modinq_size_68_c2921 := if(nf_inq_adlspercurraddr_count12 < 1.933538, modinq_size_68_c2922, modinq_size_68_c2933);

modinq_size_68 := if(nf_inq_bestssn_ver_count < 51.998527, modinq_size_68_c2885, modinq_size_68_c2921);

modinq_size_69_c2945 := if(nf_inq_utilities_count24 < 0.731654, 16.609128, 8.000000);

modinq_size_69_c2946 := if(nf_inq_lnamesperbestssn_count12 < 1.616747, 16.344568, 9.000000);

modinq_size_69_c2944 := if(nf_inq_adls_per_addr < 0.714576, modinq_size_69_c2945, modinq_size_69_c2946);

modinq_size_69_c2948 := if(nf_inq_bestssn_ver_count < 3.914416, 8.000000, 9.000000);

modinq_size_69_c2949 := if(nf_inq_addrsperssn_count12 < 0.759754, 8.000000, 8.000000);

modinq_size_69_c2947 := if(nf_inq_ssn_ver_count < 7.787982, modinq_size_69_c2948, modinq_size_69_c2949);

modinq_size_69_c2943 := if(nf_invbest_inq_ssnsperaddr_diff < 1.531399, modinq_size_69_c2944, modinq_size_69_c2947);

modinq_size_69_c2952 := if(nf_inq_adlsperbestssn_count12 < 0.281844, 8.000000, 11.748880);

modinq_size_69_c2951 := if(nf_invbest_inq_adlsperaddr_diff < -6.025191, 7.000000, modinq_size_69_c2952);

modinq_size_69_c2950 := if(nf_inq_auto_count_day < 2.441950, modinq_size_69_c2951, 6.000000);

modinq_size_69_c2942 := if(nf_inq_auto_count_week < 0.981889, modinq_size_69_c2943, modinq_size_69_c2950);

modinq_size_69_c2954 := if(nf_inq_fname_ver_count < 66.621775, 6.000000, 6.000000);

modinq_size_69_c2957 := if(nf_inq_lnames_per_addr < 1.047604, 8.000000, 8.000000);

modinq_size_69_c2956 := if(nf_inq_per_sfd_addr < 1.928383, 7.000000, modinq_size_69_c2957);

modinq_size_69_c2959 := if(rv_i60_inq_count12 < 13.057834, 9.000000, 8.000000);

modinq_size_69_c2958 := if(nf_inq_lnamespercurraddr_count12 < 1.536740, 7.000000, modinq_size_69_c2959);

modinq_size_69_c2955 := if(nf_inq_adls_per_ssn < 0.374597, modinq_size_69_c2956, modinq_size_69_c2958);

modinq_size_69_c2953 := if(nf_inq_ssnspercurraddr_count12 < 0.712957, modinq_size_69_c2954, modinq_size_69_c2955);

modinq_size_69_c2941 := if(rv_i60_inq_retpymt_count12 < 0.378425, modinq_size_69_c2942, modinq_size_69_c2953);

modinq_size_69_c2964 := if(rv_i62_inq_addrsperadl_count12 < 0.226164, 8.000000, 8.000000);

modinq_size_69_c2963 := if(nf_inq_retail_count < 3.350266, modinq_size_69_c2964, 7.000000);

modinq_size_69_c2965 := if(nf_inq_collection_count < 0.310482, 7.000000, 7.000000);

modinq_size_69_c2962 := if(nf_inq_dobsperssn_count12 < 0.065611, modinq_size_69_c2963, modinq_size_69_c2965);

modinq_size_69_c2967 := if(nf_inq_lnamesperaddr_count12 < 1.612295, 7.000000, 7.000000);

modinq_size_69_c2966 := if(nf_inq_banking_count < 4.179162, modinq_size_69_c2967, 6.000000);

modinq_size_69_c2961 := if(nf_inq_communications_count < 0.222652, modinq_size_69_c2962, modinq_size_69_c2966);

modinq_size_69_c2968 := if(nf_inq_lnamesperaddr_recency < 11.450392, 5.000000, 5.000000);

modinq_size_69_c2960 := if(nf_invbest_inq_peraddr_diff < 0.882933, modinq_size_69_c2961, modinq_size_69_c2968);

modinq_size_69_c2940 := if(nf_inq_ssns_per_apt_addr < 0.389600, modinq_size_69_c2941, modinq_size_69_c2960);

modinq_size_69_c2969 := if(nf_inq_bestlname_ver_count < 7.990297, 3.000000, 3.000000);

modinq_size_69_c2939 := if(nf_inq_lnamesperaddr_count_day < 0.833200, modinq_size_69_c2940, modinq_size_69_c2969);

modinq_size_69_c2970 := if(nf_inq_lname_ver_count < 21.990222, 2.000000, 2.000000);

modinq_size_69 := if(nf_inq_addrsperadl_count_week < 1.457084, modinq_size_69_c2939, modinq_size_69_c2970);

modinq_size_70_c2978 := if(nf_inq_peraddr_count_day < 0.722342, 15.918327, 8.000000);

modinq_size_70_c2979 := if(nf_inq_lname_ver_count < 9.407636, 10.327020, 9.000000);

modinq_size_70_c2977 := if(nf_inq_adls_per_apt_addr < -0.223593, modinq_size_70_c2978, modinq_size_70_c2979);

modinq_size_70_c2981 := if(nf_inq_bestssn_ver_count < 15.540433, 13.241134, 8.000000);

modinq_size_70_c2980 := if(nf_inq_count24 < 4.053306, modinq_size_70_c2981, 7.000000);

modinq_size_70_c2976 := if(nf_inq_lnamesperaddr_recency < 1.871466, modinq_size_70_c2977, modinq_size_70_c2980);

modinq_size_70_c2984 := if(nf_inq_per_addr < 0.101674, 12.695532, 8.000000);

modinq_size_70_c2983 := if(nf_inq_per_apt_addr < -0.484808, modinq_size_70_c2984, 7.000000);

modinq_size_70_c2985 := if(nf_inq_adlspercurraddr_count12 < 2.946111, 7.000000, 7.000000);

modinq_size_70_c2982 := if(nf_inq_per_sfd_addr < 3.788992, modinq_size_70_c2983, modinq_size_70_c2985);

modinq_size_70_c2975 := if(nf_inq_bestssn_ver_count < 103.169045, modinq_size_70_c2976, modinq_size_70_c2982);

modinq_size_70_c2986 := if(nf_inq_ssns_per_addr < 1.300617, 5.000000, 5.000000);

modinq_size_70_c2974 := if(nf_inq_per_apt_addr < 1.496206, modinq_size_70_c2975, modinq_size_70_c2986);

modinq_size_70_c2989 := if(nf_inq_peradl_count_day < 0.228348, 6.000000, 6.000000);

modinq_size_70_c2992 := if(nf_inq_count_day < 0.595757, 9.000000, 8.000000);

modinq_size_70_c2993 := if(nf_inq_lnamesperssn_recency < 0.450697, 9.000000, 8.000000);

modinq_size_70_c2991 := if(nf_inq_lnames_per_addr < 1.395208, modinq_size_70_c2992, modinq_size_70_c2993);

modinq_size_70_c2990 := if(rv_i62_inq_fnamesperadl_recency < 2.568188, 6.000000, modinq_size_70_c2991);

modinq_size_70_c2988 := if(rv_i62_inq_addrs_per_adl < 0.298330, modinq_size_70_c2989, modinq_size_70_c2990);

modinq_size_70_c2997 := if(nf_invbest_inq_lastperaddr_diff < -0.287495, 11.748880, 9.000000);

modinq_size_70_c2998 := if(nf_inq_ssns_per_addr < 1.284743, 8.000000, 9.000000);

modinq_size_70_c2996 := if(nf_inq_percurraddr_count12 < 3.190164, modinq_size_70_c2997, modinq_size_70_c2998);

modinq_size_70_c2995 := if(nf_inq_communications_count24 < 0.550702, modinq_size_70_c2996, 6.000000);

modinq_size_70_c3001 := if(nf_inq_adlsperaddr_count_week < 1.655654, 15.132052, 8.000000);

modinq_size_70_c3000 := if(nf_invbest_inq_lastperaddr_diff < -2.479141, 7.000000, modinq_size_70_c3001);

modinq_size_70_c3003 := if(nf_inq_highriskcredit_count24 < 3.269181, 8.000000, 8.000000);

modinq_size_70_c3002 := if(nf_inq_lnamesperbestssn_count12 < 1.693497, 7.000000, modinq_size_70_c3003);

modinq_size_70_c2999 := if(nf_inq_addr_recency_risk_index < 5.574633, modinq_size_70_c3000, modinq_size_70_c3002);

modinq_size_70_c2994 := if(nf_inq_adlsperssn_count12 < 0.854766, modinq_size_70_c2995, modinq_size_70_c2999);

modinq_size_70_c2987 := if(nf_inq_lnames_per_sfd_addr < -0.918129, modinq_size_70_c2988, modinq_size_70_c2994);

modinq_size_70_c2973 := if(rv_i60_inq_peradl_recency < 0.632069, modinq_size_70_c2974, modinq_size_70_c2987);

modinq_size_70_c3005 := if(rv_i60_inq_retpymt_recency < 52.471899, 4.000000, 4.000000);

modinq_size_70_c3007 := if(nf_inq_fname_ver_count < 4.809802, 5.000000, 5.000000);

modinq_size_70_c3011 := if(rv_i62_inq_fnamesperadl_count12 < 1.203830, 13.669106, 8.000000);

modinq_size_70_c3012 := if(nf_inq_count24 < 9.497395, 9.207392, 8.000000);

modinq_size_70_c3010 := if(rv_i60_inq_auto_count12 < 3.107403, modinq_size_70_c3011, modinq_size_70_c3012);

modinq_size_70_c3009 := if(rv_i60_inq_count12 < 0.141515, 6.000000, modinq_size_70_c3010);

modinq_size_70_c3013 := if(nf_inq_count24 < 3.431610, 6.000000, 6.000000);

modinq_size_70_c3008 := if(nf_inq_perssn_count_week < 0.698122, modinq_size_70_c3009, modinq_size_70_c3013);

modinq_size_70_c3006 := if(rv_i62_inq_fnamesperadl_recency < 4.556961, modinq_size_70_c3007, modinq_size_70_c3008);

modinq_size_70_c3004 := if(nf_inq_dobsperssn_count12 < 0.177503, modinq_size_70_c3005, modinq_size_70_c3006);

modinq_size_70_c2972 := if(nf_inq_addrsperssn_recency < 9.428234, modinq_size_70_c2973, modinq_size_70_c3004);

//modinq_size_70 := if(nf_inq_dobsperssn_count12 < -4753860520.071311, 1.000000, modinq_size_70_c2972);
modinq_size_70 := if(nf_inq_dobsperssn_count12 < -999999998, 1.000000, modinq_size_70_c2972);

modinq_size_71_c3015 := if(nf_inq_per_addr < 10.095842, 2.000000, 2.000000);

modinq_size_71_c3022 := if(nf_inq_addrs_per_ssn < 0.947647, 16.994340, 10.327020);

modinq_size_71_c3023 := if(rv_i60_inq_banking_recency < 20.613281, 8.000000, 9.000000);

modinq_size_71_c3021 := if(nf_inq_communications_count24 < 0.520554, modinq_size_71_c3022, modinq_size_71_c3023);

modinq_size_71_c3025 := if(nf_inq_communications_count < 0.371998, 12.427187, 9.207392);

modinq_size_71_c3024 := if(nf_inq_other_count24 < 1.339207, modinq_size_71_c3025, 7.000000);

modinq_size_71_c3020 := if(nf_inq_lnames_per_apt_addr < -0.887658, modinq_size_71_c3021, modinq_size_71_c3024);

modinq_size_71_c3019 := if(nf_inq_adls_per_addr < 3.234867, modinq_size_71_c3020, 5.000000);

modinq_size_71_c3029 := if(nf_inq_dobsperssn_count_day < 1.031125, 14.480886, 8.000000);

modinq_size_71_c3028 := if(nf_inq_adlsperbestssn_count12 < 1.787426, modinq_size_71_c3029, 7.000000);

modinq_size_71_c3027 := if(nf_invbest_inq_lastperaddr_diff < 3.901487, modinq_size_71_c3028, 6.000000);

modinq_size_71_c3031 := if(nf_inq_bestssn_ver_count < 28.938832, 7.000000, 7.000000);

modinq_size_71_c3032 := if(nf_inq_addr_ver_count < 7.004062, 7.000000, 7.000000);

modinq_size_71_c3030 := if(nf_inq_lnamesperssn_count_week < 0.710572, modinq_size_71_c3031, modinq_size_71_c3032);

modinq_size_71_c3026 := if(nf_inq_banking_count < 2.231195, modinq_size_71_c3027, modinq_size_71_c3030);

modinq_size_71_c3018 := if(nf_inq_dobsperbestssn_count12 < 0.890002, modinq_size_71_c3019, modinq_size_71_c3026);

modinq_size_71_c3034 := if(nf_inq_lnamespercurraddr_count12 < 1.545081, 5.000000, 5.000000);

modinq_size_71_c3033 := if(rv_i60_inq_peradl_count12 < 4.019082, 4.000000, modinq_size_71_c3034);

modinq_size_71_c3017 := if(rv_i62_inq_phonesperadl_count12 < 2.963612, modinq_size_71_c3018, modinq_size_71_c3033);

modinq_size_71_c3040 := if(nf_inq_peradl_count_day < 0.248835, 11.535537, 8.000000);

modinq_size_71_c3039 := if(nf_inq_ssns_per_apt_addr < -0.319674, modinq_size_71_c3040, 7.000000);

modinq_size_71_c3038 := if(rv_i62_inq_addrsperadl_recency < 9.742335, 6.000000, modinq_size_71_c3039);

modinq_size_71_c3037 := if(rv_i62_inq_ssnsperadl_count12 < 1.700799, modinq_size_71_c3038, 5.000000);

modinq_size_71_c3036 := if(rv_i62_inq_fnamesperadl_count12 < 0.005363, 4.000000, modinq_size_71_c3037);

modinq_size_71_c3045 := if(rv_i62_inq_phones_per_adl < 1.344798, 12.817256, 9.000000);

modinq_size_71_c3044 := if(nf_inquiry_ssn_vel_risk_indexv2 < 3.078503, modinq_size_71_c3045, 7.000000);

modinq_size_71_c3047 := if(nf_inq_bestlname_ver_count < 11.878170, 9.000000, 8.000000);

modinq_size_71_c3048 := if(nf_inq_curraddr_ver_count < 24.276638, 8.000000, 8.000000);

modinq_size_71_c3046 := if(nf_inq_highriskcredit_count24 < 0.795179, modinq_size_71_c3047, modinq_size_71_c3048);

modinq_size_71_c3043 := if(nf_inq_per_sfd_addr < 2.579623, modinq_size_71_c3044, modinq_size_71_c3046);

modinq_size_71_c3042 := if(nf_inq_per_ssn < 11.715213, modinq_size_71_c3043, 5.000000);

modinq_size_71_c3041 := if(rv_i62_inq_dobs_per_adl < 0.991604, 4.000000, modinq_size_71_c3042);

modinq_size_71_c3035 := if(nf_inq_bestphone_ver_count < 189.631563, modinq_size_71_c3036, modinq_size_71_c3041);

modinq_size_71_c3016 := if(nf_inq_dobsperssn_recency < 10.913062, modinq_size_71_c3017, modinq_size_71_c3035);

//modinq_size_71 := if(nf_inq_perssn_count_week < -6318183075.492205, modinq_size_71_c3015, modinq_size_71_c3016);
modinq_size_71 := if(nf_inq_perssn_count_week < -999999998, modinq_size_71_c3015, modinq_size_71_c3016);

modinq_size_72_c3055 := if(nf_inq_lnamesperaddr_count12 < 0.235968, 7.000000, 7.000000);

modinq_size_72_c3054 := if(nf_inq_bestlname_ver_count < 3.516732, modinq_size_72_c3055, 6.000000);

modinq_size_72_c3053 := if(rv_i60_inq_recency < 13.665617, 5.000000, modinq_size_72_c3054);

modinq_size_72_c3056 := if(nf_inq_ssns_per_addr < 0.374469, 5.000000, 5.000000);

modinq_size_72_c3052 := if(nf_inq_quizprovider_count24 < 0.468672, modinq_size_72_c3053, modinq_size_72_c3056);

modinq_size_72_c3061 := if(nf_inq_lnamesperssn_recency < 9.049224, 17.304740, 13.744698);

modinq_size_72_c3062 := if(nf_inq_percurraddr_count12 < 3.521428, 12.817256, 10.706640);

modinq_size_72_c3060 := if(rv_i60_inq_comm_recency < 89.608939, modinq_size_72_c3061, modinq_size_72_c3062);

modinq_size_72_c3063 := if(nf_inq_peraddr_count12 < 7.006157, 7.000000, 7.000000);

modinq_size_72_c3059 := if(nf_inq_adlsperbestphone_count12 < 1.748599, modinq_size_72_c3060, modinq_size_72_c3063);

modinq_size_72_c3066 := if(nf_inq_per_sfd_addr < 0.036925, 8.000000, 9.000000);

modinq_size_72_c3067 := if(nf_invbest_inq_adlsperaddr_diff < 3.421947, 8.000000, 8.000000);

modinq_size_72_c3065 := if(rv_i60_inq_banking_recency < 15.984117, modinq_size_72_c3066, modinq_size_72_c3067);

modinq_size_72_c3068 := if(rv_i60_inq_auto_count12 < 0.577188, 7.000000, 7.000000);

modinq_size_72_c3064 := if(nf_inq_perssn_count12 < 2.172667, modinq_size_72_c3065, modinq_size_72_c3068);

modinq_size_72_c3058 := if(nf_inq_lnamesperssn_count_week < 0.175896, modinq_size_72_c3059, modinq_size_72_c3064);

modinq_size_72_c3072 := if(nf_inq_bestfname_ver_count < 37.451092, 11.023665, 8.000000);

modinq_size_72_c3073 := if(rv_i60_inq_mortgage_recency < 8.558684, 10.706640, 9.851656);

modinq_size_72_c3071 := if(rv_i60_inq_auto_recency < 8.308228, modinq_size_72_c3072, modinq_size_72_c3073);

modinq_size_72_c3070 := if(nf_invbest_inq_adlsperaddr_diff < -0.740204, modinq_size_72_c3071, 6.000000);

modinq_size_72_c3069 := if(rv_i60_inq_hiriskcred_count12 < 6.330672, modinq_size_72_c3070, 5.000000);

modinq_size_72_c3057 := if(nf_inq_addrsperssn_count12 < 1.511317, modinq_size_72_c3058, modinq_size_72_c3069);

modinq_size_72_c3051 := if(nf_inquiry_verification_index < 19.868585, modinq_size_72_c3052, modinq_size_72_c3057);

modinq_size_72_c3078 := if(nf_inq_perssn_recency < 2.250022, 8.851656, 7.000000);

modinq_size_72_c3077 := if(nf_inq_ssns_per_sfd_addr < 0.809711, modinq_size_72_c3078, 6.000000);

modinq_size_72_c3079 := if(nf_inq_percurraddr_count12 < 0.741171, 6.000000, 6.000000);

modinq_size_72_c3076 := if(nf_inq_ssns_per_apt_addr < -0.116567, modinq_size_72_c3077, modinq_size_72_c3079);

modinq_size_72_c3075 := if(nf_invbest_inq_peraddr_diff < 3.536639, modinq_size_72_c3076, 4.000000);

modinq_size_72_c3074 := if(nf_inquiry_addr_vel_risk_indexv2 < 2.865676, modinq_size_72_c3075, 3.000000);

modinq_size_72_c3050 := if(nf_inq_bestlname_ver_count < 164.052669, modinq_size_72_c3051, modinq_size_72_c3074);

//modinq_size_72 := if(nf_inq_adls_per_sfd_addr < -6273152139.248100, 1.000000, modinq_size_72_c3050);
modinq_size_72 := if(nf_inq_adls_per_sfd_addr < -999999998, 1.000000, modinq_size_72_c3050);

modinq_size_73_c3087 := if(nf_inq_other_count < 2.254163, 12.427187, 8.000000);

modinq_size_73_c3088 := if(rv_i62_inq_phones_per_adl < 1.168427, 11.941420, 9.000000);

modinq_size_73_c3086 := if(rv_i62_inq_ssns_per_adl < 0.639626, modinq_size_73_c3087, modinq_size_73_c3088);

modinq_size_73_c3090 := if(nf_inq_highriskcredit_count < 3.906534, 9.000000, 8.000000);

modinq_size_73_c3091 := if(nf_inq_adlsperssn_recency < 7.152017, 8.000000, 9.000000);

modinq_size_73_c3089 := if(rv_i62_inq_num_names_per_adl < 0.358077, modinq_size_73_c3090, modinq_size_73_c3091);

modinq_size_73_c3085 := if(nf_inq_adlsperaddr_recency < 9.341527, modinq_size_73_c3086, modinq_size_73_c3089);

modinq_size_73_c3084 := if(rv_i60_inq_hiriskcred_count12 < 0.033296, modinq_size_73_c3085, 5.000000);

modinq_size_73_c3083 := if(nf_inq_communications_count24 < 3.438358, modinq_size_73_c3084, 4.000000);

modinq_size_73_c3082 := if(nf_inq_adlsperaddr_count12 < 2.411083, modinq_size_73_c3083, 3.000000);

modinq_size_73_c3097 := if(nf_inquiry_adl_vel_risk_index < 2.115375, 16.197889, 10.706640);

modinq_size_73_c3098 := if(rv_i60_inq_other_count12 < 0.178877, 8.000000, 9.207392);

modinq_size_73_c3096 := if(nf_invbest_inq_dobsperssn_diff < -0.149318, modinq_size_73_c3097, modinq_size_73_c3098);

modinq_size_73_c3100 := if(nf_inq_dob_ver_count < 89.145982, 15.168763, 10.327020);

modinq_size_73_c3101 := if(nf_invbest_inq_ssnsperaddr_diff < -0.027482, 10.327020, 9.207392);

modinq_size_73_c3099 := if(rv_i60_inq_hiriskcred_recency < 31.953407, modinq_size_73_c3100, modinq_size_73_c3101);

modinq_size_73_c3095 := if(rv_i60_inq_recency < 23.722194, modinq_size_73_c3096, modinq_size_73_c3099);

modinq_size_73_c3104 := if(nf_inq_per_sfd_addr < 3.346187, 12.817256, 11.023665);

modinq_size_73_c3105 := if(nf_inq_dobs_per_ssn < 1.898279, 12.565879, 9.000000);

modinq_size_73_c3103 := if(nf_inq_lnamesperssn_recency < 1.930531, modinq_size_73_c3104, modinq_size_73_c3105);

modinq_size_73_c3107 := if(nf_inq_ssns_per_addr < 2.407093, 8.000000, 8.000000);

modinq_size_73_c3108 := if(nf_inq_curraddr_ver_count < 4.946585, 8.000000, 8.000000);

modinq_size_73_c3106 := if(rv_i62_inq_fnamesperadl_count12 < 0.222761, modinq_size_73_c3107, modinq_size_73_c3108);

modinq_size_73_c3102 := if(nf_inq_prepaidcards_count < 0.295282, modinq_size_73_c3103, modinq_size_73_c3106);

modinq_size_73_c3094 := if(nf_inq_lnamesperaddr_recency < 9.308667, modinq_size_73_c3095, modinq_size_73_c3102);

modinq_size_73_c3109 := if(nf_inq_dobsperbestssn_count12 < 1.169669, 5.000000, 5.000000);

modinq_size_73_c3093 := if(nf_inq_addrsperbestssn_count12 < 4.612576, modinq_size_73_c3094, modinq_size_73_c3109);

modinq_size_73_c3092 := if(nf_inq_lnamesperaddr_count_week < 1.923043, modinq_size_73_c3093, 3.000000);

modinq_size_73_c3081 := if(nf_inq_adls_per_sfd_addr < -0.329051, modinq_size_73_c3082, modinq_size_73_c3092);

//modinq_size_73 := if(rv_i62_inq_dobsperadl_count12 < -8419312742.619596, 1.000000, modinq_size_73_c3081);
modinq_size_73 := if(rv_i62_inq_dobsperadl_count12 < -999999998, 1.000000, modinq_size_73_c3081);

modinq_size_74_c3117 := if(nf_inq_lnames_per_sfd_addr < -0.869008, 11.535537, 15.651216);

modinq_size_74_c3118 := if(nf_invbest_inq_ssnsperaddr_diff < 1.601999, 15.440446, 8.000000);

modinq_size_74_c3116 := if(nf_inq_peraddr_recency < 0.433014, modinq_size_74_c3117, modinq_size_74_c3118);

modinq_size_74_c3120 := if(nf_inq_adls_per_apt_addr < -0.461322, 13.040438, 9.000000);

modinq_size_74_c3119 := if(nf_inq_adls_per_addr < 2.292386, modinq_size_74_c3120, 7.000000);

modinq_size_74_c3115 := if(nf_inq_adlsperssn_recency < 11.164540, modinq_size_74_c3116, modinq_size_74_c3119);

modinq_size_74_c3121 := if(nf_inq_ssns_per_addr < 1.657051, 6.000000, 6.000000);

modinq_size_74_c3114 := if(nf_inq_highriskcredit_count < 4.719302, modinq_size_74_c3115, modinq_size_74_c3121);

modinq_size_74_c3125 := if(rv_i60_inq_banking_recency < 22.381119, 9.000000, 8.000000);

modinq_size_74_c3124 := if(nf_inq_fname_ver_count < 6.937109, 7.000000, modinq_size_74_c3125);

modinq_size_74_c3127 := if(nf_inq_curraddr_ver_count < 3.936823, 9.000000, 8.000000);

modinq_size_74_c3126 := if(rv_i62_inq_dobsperadl_recency < 2.110165, modinq_size_74_c3127, 7.000000);

modinq_size_74_c3123 := if(rv_i62_inq_num_names_per_adl < 0.032625, modinq_size_74_c3124, modinq_size_74_c3126);

modinq_size_74_c3122 := if(nf_inq_dobsperssn_recency < 1.038852, modinq_size_74_c3123, 5.000000);

modinq_size_74_c3113 := if(rv_i60_inq_retail_count12 < 0.372807, modinq_size_74_c3114, modinq_size_74_c3122);

modinq_size_74_c3132 := if(nf_inq_adls_per_ssn < 0.915379, 11.023665, 12.931969);

modinq_size_74_c3133 := if(nf_inq_auto_count < 4.187185, 13.955690, 12.817256);

modinq_size_74_c3131 := if(nf_inq_bestphone_ver_count < 191.769192, modinq_size_74_c3132, modinq_size_74_c3133);

modinq_size_74_c3130 := if(rv_i62_inq_ssns_per_adl < 2.170272, modinq_size_74_c3131, 6.000000);

modinq_size_74_c3129 := if(nf_inq_lnamesperaddr_count_day < 0.398406, modinq_size_74_c3130, 5.000000);

modinq_size_74_c3128 := if(nf_inq_peradl_count_day < 3.037851, modinq_size_74_c3129, 4.000000);

modinq_size_74_c3112 := if(nf_inq_auto_count24 < 0.677481, modinq_size_74_c3113, modinq_size_74_c3128);

modinq_size_74_c3136 := if(nf_inq_lname_ver_count < 34.413908, 5.000000, 5.000000);

modinq_size_74_c3135 := if(rv_i60_inq_mortgage_recency < 1.375799, modinq_size_74_c3136, 4.000000);

modinq_size_74_c3134 := if(nf_inq_collection_count < 3.939430, modinq_size_74_c3135, 3.000000);

modinq_size_74_c3111 := if(nf_inq_dobsperssn_count12 < 1.074092, modinq_size_74_c3112, modinq_size_74_c3134);

//modinq_size_74 := if(nf_inq_other_count < -63035388.774141, 1.000000, modinq_size_74_c3111);
modinq_size_74 := if(nf_inq_other_count < -999999998, 1.000000, modinq_size_74_c3111);

//modinq_size_75_c3144 := if(nf_inq_per_apt_addr < -6388828477.601538, 8.000000, 17.162279);
modinq_size_75_c3144 := if(nf_inq_per_apt_addr < -999999998, 8.000000, 17.162279);

modinq_size_75_c3143 := if(nf_inq_bestfname_ver_count < 36.403441, modinq_size_75_c3144, 7.000000);

modinq_size_75_c3145 := if(nf_inq_ssnspercurraddr_count12 < 0.084546, 7.000000, 7.000000);

modinq_size_75_c3142 := if(nf_inq_lnamesperaddr_count_day < 0.693756, modinq_size_75_c3143, modinq_size_75_c3145);

modinq_size_75_c3148 := if(nf_inq_other_count24 < 4.350650, 13.241134, 9.207392);

modinq_size_75_c3149 := if(nf_inq_retailpayments_count24 < 0.823954, 14.375523, 9.207392);

modinq_size_75_c3147 := if(nf_inq_bestphone_ver_count < 106.604440, modinq_size_75_c3148, modinq_size_75_c3149);

modinq_size_75_c3150 := if(nf_inq_adlspercurraddr_count12 < 1.427976, 7.000000, 7.000000);

modinq_size_75_c3146 := if(nf_inq_lnamesperbestssn_count12 < 2.301128, modinq_size_75_c3147, modinq_size_75_c3150);

modinq_size_75_c3141 := if(nf_inq_adls_per_ssn < 0.439590, modinq_size_75_c3142, modinq_size_75_c3146);

modinq_size_75_c3154 := if(nf_invbest_inq_peraddr_diff < -0.095534, 10.327020, 8.000000);

modinq_size_75_c3153 := if(nf_inq_perbestssn_count12 < 0.304424, modinq_size_75_c3154, 7.000000);

modinq_size_75_c3152 := if(nf_inq_per_sfd_addr < 0.853674, modinq_size_75_c3153, 6.000000);

modinq_size_75_c3151 := if(nf_invbest_inq_adlsperssn_diff < -0.121380, modinq_size_75_c3152, 5.000000);

modinq_size_75_c3140 := if(nf_inq_bestlname_ver_count < 238.640962, modinq_size_75_c3141, modinq_size_75_c3151);

modinq_size_75_c3159 := if(nf_inq_count < 20.746936, 8.000000, 8.000000);

modinq_size_75_c3158 := if(nf_inq_lname_ver_count < 84.317833, modinq_size_75_c3159, 7.000000);

modinq_size_75_c3161 := if(nf_inq_lnamespercurraddr_count12 < 0.903491, 8.000000, 8.000000);

modinq_size_75_c3160 := if(rv_i60_inq_other_count12 < 0.113779, modinq_size_75_c3161, 7.000000);

modinq_size_75_c3157 := if(nf_inq_addrsperssn_recency < 3.870511, modinq_size_75_c3158, modinq_size_75_c3160);

modinq_size_75_c3156 := if(nf_inq_auto_count24 < 0.012081, 5.000000, modinq_size_75_c3157);

modinq_size_75_c3162 := if(nf_inq_lname_ver_count < 67.690357, 5.000000, 5.000000);

modinq_size_75_c3155 := if(rv_i60_inq_retail_recency < 0.713865, modinq_size_75_c3156, modinq_size_75_c3162);

modinq_size_75_c3139 := if(rv_i62_inq_phones_per_adl < 1.634551, modinq_size_75_c3140, modinq_size_75_c3155);

modinq_size_75_c3164 := if(nf_inq_auto_count24 < 4.228030, 4.000000, 4.000000);

modinq_size_75_c3163 := if(rv_i62_inq_addrsperadl_count12 < 1.860983, 3.000000, modinq_size_75_c3164);

modinq_size_75_c3138 := if(nf_inq_phonesperadl_count_week < 0.110348, modinq_size_75_c3139, modinq_size_75_c3163);

modinq_size_75_c3168 := if(nf_inq_adlsperbestssn_count12 < 0.990174, 5.000000, 5.000000);

modinq_size_75_c3169 := if(nf_inq_lnamesperssn_count12 < 0.954426, 5.000000, 5.000000);

modinq_size_75_c3167 := if(nf_inq_adlsperaddr_recency < 3.064689, modinq_size_75_c3168, modinq_size_75_c3169);

modinq_size_75_c3171 := if(nf_inq_fname_ver_count < 21.698316, 5.000000, 5.000000);

modinq_size_75_c3173 := if(rv_i60_inq_comm_recency < 49.828265, 6.000000, 6.000000);

modinq_size_75_c3175 := if(nf_inq_adlsperaddr_count12 < 2.507130, 7.000000, 7.000000);

modinq_size_75_c3177 := if(nf_inquiry_ssn_vel_risk_indexv2 < 1.014908, 8.000000, 8.000000);

modinq_size_75_c3176 := if(nf_inq_dob_ver_count < 12.426510, 7.000000, modinq_size_75_c3177);

modinq_size_75_c3174 := if(nf_inq_count < 7.481858, modinq_size_75_c3175, modinq_size_75_c3176);

modinq_size_75_c3172 := if(nf_inq_dobsperbestssn_count12 < 0.837963, modinq_size_75_c3173, modinq_size_75_c3174);

modinq_size_75_c3170 := if(nf_inq_lnamesperaddr_recency < 2.929492, modinq_size_75_c3171, modinq_size_75_c3172);

modinq_size_75_c3166 := if(nf_inq_fname_ver_count < 7.130953, modinq_size_75_c3167, modinq_size_75_c3170);

modinq_size_75_c3179 := if(nf_inq_other_count24 < 0.358962, 4.000000, 4.000000);

modinq_size_75_c3178 := if(nf_inq_quizprovider_count24 < 0.909279, modinq_size_75_c3179, 3.000000);

modinq_size_75_c3165 := if(nf_invbest_inq_adlsperaddr_diff < -0.269580, modinq_size_75_c3166, modinq_size_75_c3178);

modinq_size_75 := if(nf_inquiry_addr_vel_risk_indexv2 < 1.905066, modinq_size_75_c3138, modinq_size_75_c3165);

modinq_size_76_c3187 := if(rv_i62_inq_phonesperadl_recency < 1.957533, 17.094009, 13.669106);

modinq_size_76_c3188 := if(rv_i62_inq_ssnsperadl_recency < 0.854411, 12.695532, 11.748880);

modinq_size_76_c3186 := if(nf_inq_lname_ver_count < 22.915035, modinq_size_76_c3187, modinq_size_76_c3188);

modinq_size_76_c3190 := if(rv_i60_inq_peradl_recency < 9.362129, 9.207392, 8.000000);

modinq_size_76_c3191 := if(rv_i60_inq_recency < 11.987739, 8.000000, 8.000000);

modinq_size_76_c3189 := if(nf_inq_collection_count24 < 0.053862, modinq_size_76_c3190, modinq_size_76_c3191);

modinq_size_76_c3185 := if(rv_i60_inq_retail_count12 < 0.734494, modinq_size_76_c3186, modinq_size_76_c3189);

modinq_size_76_c3194 := if(rv_i62_inq_phones_per_adl < 0.662716, 8.000000, 8.000000);

modinq_size_76_c3195 := if(nf_inq_count < 6.135807, 9.207392, 9.000000);

modinq_size_76_c3193 := if(nf_inq_fname_ver_count < 4.065868, modinq_size_76_c3194, modinq_size_76_c3195);

modinq_size_76_c3192 := if(nf_inq_dob_ver_count < 72.098382, modinq_size_76_c3193, 6.000000);

modinq_size_76_c3184 := if(nf_inq_adlspercurraddr_count12 < 2.022616, modinq_size_76_c3185, modinq_size_76_c3192);

modinq_size_76_c3197 := if(nf_inq_retail_count < 0.671005, 6.000000, 6.000000);

modinq_size_76_c3196 := if(nf_inq_ssn_ver_count < 31.162228, modinq_size_76_c3197, 5.000000);

modinq_size_76_c3183 := if(nf_inq_other_count < 10.101046, modinq_size_76_c3184, modinq_size_76_c3196);

modinq_size_76_c3202 := if(nf_inq_curraddr_ver_count < 16.017326, 13.590539, 9.000000);

modinq_size_76_c3201 := if(nf_inquiry_ssn_vel_risk_index < 9.960702, modinq_size_76_c3202, 7.000000);

modinq_size_76_c3204 := if(nf_inq_collection_count < 1.133403, 9.000000, 8.000000);

modinq_size_76_c3203 := if(nf_inq_auto_count24 < 3.577634, modinq_size_76_c3204, 7.000000);

modinq_size_76_c3200 := if(rv_i60_inq_other_recency < 69.788738, modinq_size_76_c3201, modinq_size_76_c3203);

modinq_size_76_c3199 := if(nf_inq_lnames_per_ssn < 1.497763, modinq_size_76_c3200, 5.000000);

modinq_size_76_c3208 := if(rv_i60_inq_peradl_recency < 1.807626, 9.207392, 8.000000);

modinq_size_76_c3207 := if(nf_inq_adlsperssn_count_week < 0.153224, modinq_size_76_c3208, 7.000000);

modinq_size_76_c3206 := if(nf_inq_adlsperbestssn_count12 < 0.665076, 6.000000, modinq_size_76_c3207);

modinq_size_76_c3209 := if(rv_i62_inq_fnamesperadl_recency < 9.994812, 6.000000, 6.000000);

modinq_size_76_c3205 := if(nf_inq_banking_count < 1.631066, modinq_size_76_c3206, modinq_size_76_c3209);

modinq_size_76_c3198 := if(nf_inq_lnamespercurraddr_count12 < 1.416188, modinq_size_76_c3199, modinq_size_76_c3205);

modinq_size_76_c3182 := if(rv_i60_credit_seeking < 0.295755, modinq_size_76_c3183, modinq_size_76_c3198);

modinq_size_76_c3181 := if(nf_inq_count_day < 0.215868, modinq_size_76_c3182, 2.000000);

//modinq_size_76 := if(rv_i60_inq_stdloan_count12 < -1853896118.515115, 1.000000, modinq_size_76_c3181);
modinq_size_76 := if(rv_i60_inq_stdloan_count12 < -999999998, 1.000000, modinq_size_76_c3181);

modinq_size_77_c3217 := if(nf_inq_lnamesperbestssn_count12 < 0.123484, 17.080071, 12.931969);

modinq_size_77_c3218 := if(nf_inq_retailpayments_count < 0.060647, 11.023665, 8.000000);

modinq_size_77_c3216 := if(nf_inq_addrsperssn_recency < 7.300900, modinq_size_77_c3217, modinq_size_77_c3218);

modinq_size_77_c3220 := if(nf_inq_lnames_per_sfd_addr < 2.935115, 8.000000, 8.000000);

modinq_size_77_c3219 := if(nf_inq_adls_per_sfd_addr < 1.568898, 7.000000, modinq_size_77_c3220);

modinq_size_77_c3215 := if(nf_inq_adlsperaddr_count12 < 3.942315, modinq_size_77_c3216, modinq_size_77_c3219);

//modinq_size_77_c3214 := if(nf_inq_ssns_per_addr < -1351457685.429358, 5.000000, modinq_size_77_c3215);
modinq_size_77_c3214 := if(nf_inq_ssns_per_addr < -999999998, 5.000000, modinq_size_77_c3215);

modinq_size_77_c3221 := if(nf_inq_ssn_ver_count < 8.725703, 5.000000, 5.000000);

modinq_size_77_c3213 := if(nf_inq_retail_count24 < 2.936810, modinq_size_77_c3214, modinq_size_77_c3221);

modinq_size_77_c3212 := if(nf_invbest_inq_addrsperssn_diff < 1.553876, modinq_size_77_c3213, 3.000000);

modinq_size_77_c3222 := if(rv_i60_inq_banking_recency < 45.579140, 3.000000, 3.000000);

modinq_size_77_c3211 := if(rv_i62_inq_fnamesperadl_count12 < 1.726521, modinq_size_77_c3212, modinq_size_77_c3222);

modinq_size_77_c3229 := if(nf_inq_per_sfd_addr < 0.351417, 8.000000, 8.000000);

modinq_size_77_c3228 := if(nf_inq_lname_ver_count < 8.074078, 7.000000, modinq_size_77_c3229);

modinq_size_77_c3227 := if(rv_i60_inq_prepaidcards_recency < 41.288714, modinq_size_77_c3228, 6.000000);

modinq_size_77_c3232 := if(nf_inq_dob_ver_count < 4.245648, 8.000000, 8.000000);

modinq_size_77_c3231 := if(rv_i60_inq_auto_recency < 77.340133, 7.000000, modinq_size_77_c3232);

modinq_size_77_c3230 := if(nf_inquiry_verification_index < 30.098496, 6.000000, modinq_size_77_c3231);

modinq_size_77_c3226 := if(nf_inq_lnames_per_addr < 0.741114, modinq_size_77_c3227, modinq_size_77_c3230);

modinq_size_77_c3225 := if(nf_inq_retailpayments_count < 1.727954, modinq_size_77_c3226, 4.000000);

modinq_size_77_c3224 := if(nf_invbest_inq_peraddr_diff < -3.403173, 3.000000, modinq_size_77_c3225);

modinq_size_77_c3237 := if(nf_inq_dob_ver_count < 1.635134, 7.000000, 7.000000);

modinq_size_77_c3239 := if(nf_inq_lnamespercurraddr_count12 < 1.475532, 8.000000, 8.000000);

modinq_size_77_c3238 := if(nf_inq_mortgage_count < 1.363439, modinq_size_77_c3239, 7.000000);

modinq_size_77_c3236 := if(nf_inq_lname_ver_count < 6.729635, modinq_size_77_c3237, modinq_size_77_c3238);

modinq_size_77_c3242 := if(rv_i62_inq_phonesperadl_recency < 8.661649, 8.000000, 8.000000);

modinq_size_77_c3243 := if(rv_i60_inq_hiriskcred_recency < 5.099058, 11.535537, 8.000000);

modinq_size_77_c3241 := if(nf_inq_adls_per_addr < 0.592150, modinq_size_77_c3242, modinq_size_77_c3243);

modinq_size_77_c3240 := if(nf_inq_per_addr < 8.683893, modinq_size_77_c3241, 6.000000);

modinq_size_77_c3235 := if(rv_i62_inq_phonesperadl_count12 < 0.294097, modinq_size_77_c3236, modinq_size_77_c3240);

modinq_size_77_c3247 := if(nf_inq_per_sfd_addr < 2.403261, 12.695532, 12.817256);

modinq_size_77_c3248 := if(rv_i60_inq_peradl_count12 < 12.720034, 8.000000, 8.000000);

modinq_size_77_c3246 := if(rv_i61_inq_collection_count12 < 0.300763, modinq_size_77_c3247, modinq_size_77_c3248);

modinq_size_77_c3250 := if(nf_inq_adlsperbestphone_count12 < 0.477392, 11.535537, 9.000000);

modinq_size_77_c3249 := if(nf_inq_adlsperbestphone_count12 < 1.486586, modinq_size_77_c3250, 7.000000);

modinq_size_77_c3245 := if(nf_inq_dobsperbestssn_count12 < 1.547269, modinq_size_77_c3246, modinq_size_77_c3249);

modinq_size_77_c3251 := if(nf_inq_communications_count < 1.834031, 6.000000, 6.000000);

modinq_size_77_c3244 := if(nf_inq_adlsperssn_count_week < 0.798734, modinq_size_77_c3245, modinq_size_77_c3251);

modinq_size_77_c3234 := if(nf_inq_lname_ver_count < 10.582941, modinq_size_77_c3235, modinq_size_77_c3244);

modinq_size_77_c3233 := if(nf_inq_adlspercurraddr_count12 < 8.432036, modinq_size_77_c3234, 3.000000);

modinq_size_77_c3223 := if(nf_inq_adlsperbestssn_count12 < 0.441668, modinq_size_77_c3224, modinq_size_77_c3233);

modinq_size_77 := if(nf_inq_perbestssn_count12 < 1.883804, modinq_size_77_c3211, modinq_size_77_c3223);

modinq_size_78_c3253 := if(nf_inq_ssns_per_sfd_addr < 0.611809, 2.000000, 2.000000);

modinq_size_78_c3260 := if(nf_inq_auto_count < 7.564177, 16.950055, 11.296252);

modinq_size_78_c3261 := if(nf_inq_banking_count24 < 2.093035, 12.565879, 8.000000);

modinq_size_78_c3259 := if(rv_i62_inq_addrsperadl_recency < 11.886861, modinq_size_78_c3260, modinq_size_78_c3261);

modinq_size_78_c3263 := if(rv_i60_inq_comm_recency < 41.461089, 8.000000, 8.000000);

modinq_size_78_c3262 := if(nf_inq_dobsperssn_recency < 5.669403, modinq_size_78_c3263, 7.000000);

modinq_size_78_c3258 := if(rv_i60_inq_prepaidcards_recency < 82.128816, modinq_size_78_c3259, modinq_size_78_c3262);

modinq_size_78_c3257 := if(nf_inq_fnamesperadl_count_day < 0.233852, modinq_size_78_c3258, 5.000000);

modinq_size_78_c3267 := if(rv_i62_inq_dobs_per_adl < 0.784938, 11.023665, 9.207392);

modinq_size_78_c3268 := if(nf_inq_retailpayments_count24 < 0.475879, 14.811235, 8.000000);

modinq_size_78_c3266 := if(nf_inquiry_verification_index < 30.508212, modinq_size_78_c3267, modinq_size_78_c3268);

modinq_size_78_c3269 := if(nf_inq_dob_ver_count < 10.223510, 7.000000, 7.000000);

modinq_size_78_c3265 := if(nf_inq_lnames_per_addr < 2.516637, modinq_size_78_c3266, modinq_size_78_c3269);

modinq_size_78_c3272 := if(nf_inq_lnames_per_ssn < 0.934436, 8.000000, 13.508753);

modinq_size_78_c3271 := if(rv_i62_inq_fnamesperadl_recency < 7.717786, 7.000000, modinq_size_78_c3272);

modinq_size_78_c3270 := if(rv_i61_inq_collection_count12 < 1.472746, modinq_size_78_c3271, 6.000000);

modinq_size_78_c3264 := if(rv_i62_inq_addrsperadl_recency < 7.264015, modinq_size_78_c3265, modinq_size_78_c3270);

modinq_size_78_c3256 := if(nf_inq_perssn_recency < 1.007262, modinq_size_78_c3257, modinq_size_78_c3264);

modinq_size_78_c3255 := if(nf_invbest_inq_lnamesperssn_diff < -0.675664, modinq_size_78_c3256, 3.000000);

modinq_size_78_c3276 := if(rv_i60_inq_peradl_count12 < 2.327727, 6.000000, 6.000000);

modinq_size_78_c3275 := if(rv_i60_inq_auto_count12 < 2.211272, modinq_size_78_c3276, 5.000000);

modinq_size_78_c3274 := if(nf_inq_count_week < 3.186017, modinq_size_78_c3275, 4.000000);

modinq_size_78_c3273 := if(nf_inq_dobsperssn_count12 < 1.995808, modinq_size_78_c3274, 3.000000);

modinq_size_78_c3254 := if(nf_inq_ssnsperaddr_count_day < 0.520570, modinq_size_78_c3255, modinq_size_78_c3273);

//modinq_size_78 := if(nf_inq_adlsperemail_count_week < -3077169335.139535, modinq_size_78_c3253, modinq_size_78_c3254);
modinq_size_78 := if(nf_inq_adlsperemail_count_week < -999999998, modinq_size_78_c3253, modinq_size_78_c3254);

modinq_size_79_c3278 := if(nf_inquiry_ssn_vel_risk_indexv2 < 1.525977, 2.000000, 2.000000);

modinq_size_79_c3285 := if(nf_inq_peraddr_recency < 0.133410, 15.679591, 14.978072);

modinq_size_79_c3286 := if(nf_inq_count < 16.295120, 15.622432, 11.941420);

modinq_size_79_c3284 := if(rv_i61_inq_collection_recency < 26.110279, modinq_size_79_c3285, modinq_size_79_c3286);

modinq_size_79_c3288 := if(rv_i62_inq_lnamesperadl_recency < 10.094793, 12.116889, 11.535537);

modinq_size_79_c3287 := if(nf_inq_count_week < 1.548153, modinq_size_79_c3288, 7.000000);

modinq_size_79_c3283 := if(nf_inq_adls_per_apt_addr < -0.452493, modinq_size_79_c3284, modinq_size_79_c3287);

modinq_size_79_c3291 := if(nf_invbest_inq_adlsperaddr_diff < 1.126786, 8.000000, 8.000000);

modinq_size_79_c3292 := if(nf_inq_collection_count < 2.969913, 9.207392, 8.000000);

modinq_size_79_c3290 := if(nf_inq_adlspercurraddr_count12 < 0.375272, modinq_size_79_c3291, modinq_size_79_c3292);

modinq_size_79_c3289 := if(nf_inq_addrsperbestssn_count12 < 0.484840, 6.000000, modinq_size_79_c3290);

modinq_size_79_c3282 := if(nf_inquiry_adl_vel_risk_index < 2.888608, modinq_size_79_c3283, modinq_size_79_c3289);

modinq_size_79_c3296 := if(nf_inq_per_sfd_addr < 3.082196, 11.296252, 9.207392);

modinq_size_79_c3295 := if(nf_inq_fnamesperadl_count_day < 0.043427, modinq_size_79_c3296, 7.000000);

modinq_size_79_c3294 := if(nf_inq_highriskcredit_count < 12.134382, modinq_size_79_c3295, 6.000000);

modinq_size_79_c3293 := if(nf_inq_bestlname_ver_count < 58.442703, modinq_size_79_c3294, 5.000000);

modinq_size_79_c3281 := if(rv_i62_inq_num_names_per_adl < 1.570193, modinq_size_79_c3282, modinq_size_79_c3293);

modinq_size_79_c3299 := if(rv_i60_inq_retpymt_count12 < 0.367381, 6.000000, 6.000000);

modinq_size_79_c3298 := if(nf_inq_lname_ver_count < 1.504992, 5.000000, modinq_size_79_c3299);

modinq_size_79_c3297 := if(nf_inq_ssnspercurraddr_count12 < 1.802771, 4.000000, modinq_size_79_c3298);

modinq_size_79_c3280 := if(nf_inq_lnamespercurraddr_count12 < 3.426997, modinq_size_79_c3281, modinq_size_79_c3297);

modinq_size_79_c3304 := if(rv_i60_inq_retail_count12 < 1.677906, 7.000000, 7.000000);

modinq_size_79_c3303 := if(nf_inq_lnamesperaddr_count_week < 0.527605, modinq_size_79_c3304, 6.000000);

modinq_size_79_c3302 := if(nf_inq_adlsperaddr_recency < 3.219103, modinq_size_79_c3303, 5.000000);

modinq_size_79_c3301 := if(nf_inq_bestlname_ver_count < 10.301626, 4.000000, modinq_size_79_c3302);

modinq_size_79_c3300 := if(rv_i62_inq_dobsperadl_count12 < 1.473096, modinq_size_79_c3301, 3.000000);

modinq_size_79_c3279 := if(nf_inq_dobsperssn_count_week < 0.902807, modinq_size_79_c3280, modinq_size_79_c3300);

//modinq_size_79 := if(nf_inq_fnamesperadl_count_week < -5229671801.371740, modinq_size_79_c3278, modinq_size_79_c3279);
modinq_size_79 := if(nf_inq_fnamesperadl_count_week < -999999998, modinq_size_79_c3278, modinq_size_79_c3279);

modinq_size_80_c3312 := if(nf_inq_dobsperssn_count12 < 1.771807, 16.964926, 8.000000);

modinq_size_80_c3313 := if(rv_i62_inq_ssnsperadl_count12 < 0.149853, 12.931969, 12.695532);

modinq_size_80_c3311 := if(nf_inq_banking_count24 < 0.296729, modinq_size_80_c3312, modinq_size_80_c3313);

modinq_size_80_c3315 := if(nf_inq_collection_count < 7.743422, 13.143309, 8.000000);

modinq_size_80_c3316 := if(nf_inq_lnamesperssn_recency < 2.233260, 8.000000, 13.143309);

modinq_size_80_c3314 := if(rv_i61_inq_collection_recency < 16.000475, modinq_size_80_c3315, modinq_size_80_c3316);

modinq_size_80_c3310 := if(nf_inq_addrsperssn_recency < 2.860668, modinq_size_80_c3311, modinq_size_80_c3314);

modinq_size_80_c3319 := if(nf_inq_dobsperbestssn_count12 < 0.815632, 9.207392, 10.706640);

modinq_size_80_c3320 := if(nf_inq_dob_ver_count < 1.247863, 8.000000, 9.000000);

modinq_size_80_c3318 := if(rv_i60_inq_recency < 69.212668, modinq_size_80_c3319, modinq_size_80_c3320);

modinq_size_80_c3317 := if(rv_i60_inq_prepaidcards_recency < 73.979497, modinq_size_80_c3318, 6.000000);

modinq_size_80_c3309 := if(nf_inq_perbestphone_count12 < 0.345840, modinq_size_80_c3310, modinq_size_80_c3317);

modinq_size_80_c3322 := if(nf_inq_peraddr_count12 < 6.454435, 6.000000, 6.000000);

modinq_size_80_c3325 := if(nf_inq_auto_count < 0.216652, 8.000000, 8.000000);

modinq_size_80_c3324 := if(nf_inq_ssns_per_sfd_addr < 0.632866, modinq_size_80_c3325, 7.000000);

modinq_size_80_c3326 := if(rv_i60_credit_seeking < 0.714216, 7.000000, 7.000000);

modinq_size_80_c3323 := if(nf_inq_per_addr < 3.016442, modinq_size_80_c3324, modinq_size_80_c3326);

modinq_size_80_c3321 := if(rv_i62_inq_ssnsperadl_recency < 6.535592, modinq_size_80_c3322, modinq_size_80_c3323);

modinq_size_80_c3308 := if(rv_i60_inq_hiriskcred_count12 < 0.879340, modinq_size_80_c3309, modinq_size_80_c3321);

modinq_size_80_c3331 := if(nf_inq_other_count < 10.159163, 10.706640, 9.000000);

modinq_size_80_c3330 := if(nf_inq_phonesperadl_count_week < 0.019495, modinq_size_80_c3331, 7.000000);

modinq_size_80_c3329 := if(nf_inq_retailpayments_count < 1.153053, modinq_size_80_c3330, 6.000000);

modinq_size_80_c3334 := if(nf_inq_retailpayments_count < 0.219258, 9.000000, 8.000000);

modinq_size_80_c3333 := if(nf_inq_perssn_count_week < 2.205121, modinq_size_80_c3334, 7.000000);

modinq_size_80_c3332 := if(nf_inq_bestssn_ver_count < 27.631849, modinq_size_80_c3333, 6.000000);

modinq_size_80_c3328 := if(nf_inq_lnames_per_apt_addr < -0.306291, modinq_size_80_c3329, modinq_size_80_c3332);

modinq_size_80_c3337 := if(rv_i62_inq_addrs_per_adl < 1.295917, 7.000000, 7.000000);

modinq_size_80_c3338 := if(nf_inq_auto_count < 4.933658, 7.000000, 7.000000);

modinq_size_80_c3336 := if(nf_inq_peradl_count_week < 0.666713, modinq_size_80_c3337, modinq_size_80_c3338);

modinq_size_80_c3335 := if(nf_inq_lnames_per_apt_addr < 0.892503, modinq_size_80_c3336, 5.000000);

modinq_size_80_c3327 := if(nf_inq_adlsperaddr_count12 < 1.144032, modinq_size_80_c3328, modinq_size_80_c3335);

modinq_size_80_c3307 := if(nf_inq_highriskcredit_count < 2.160280, modinq_size_80_c3308, modinq_size_80_c3327);

modinq_size_80_c3340 := if(nf_inq_bestdob_ver_count < 3.180376, 4.000000, 4.000000);

modinq_size_80_c3339 := if(rv_i62_inq_num_names_per_adl < 2.443606, modinq_size_80_c3340, 3.000000);

modinq_size_80_c3306 := if(nf_inq_communications_count24 < 2.872321, modinq_size_80_c3307, modinq_size_80_c3339);

//modinq_size_80 := if(nf_inq_other_count24 < -1048974012.318222, 1.000000, modinq_size_80_c3306);
modinq_size_80 := if(nf_inq_other_count24 < -999999998, 1.000000, modinq_size_80_c3306);

modinq_size_81_c3348 := if(rv_i60_inq_peradl_recency < 2.064853, 16.062990, 15.017693);

modinq_size_81_c3349 := if(nf_invbest_inq_ssnsperaddr_diff < -0.798277, 12.817256, 8.000000);

modinq_size_81_c3347 := if(nf_inq_bestlname_ver_count < 203.898794, modinq_size_81_c3348, modinq_size_81_c3349);

modinq_size_81_c3351 := if(nf_inq_collection_count < 8.804273, 8.000000, 8.000000);

modinq_size_81_c3350 := if(rv_i60_inq_recency < 4.290068, modinq_size_81_c3351, 7.000000);

modinq_size_81_c3346 := if(nf_inquiry_ssn_vel_risk_indexv2 < 3.647514, modinq_size_81_c3347, modinq_size_81_c3350);

modinq_size_81_c3352 := if(nf_inq_lnamesperaddr_recency < 0.355653, 6.000000, 6.000000);

modinq_size_81_c3345 := if(rv_i60_inq_mortgage_count12 < 0.265066, modinq_size_81_c3346, modinq_size_81_c3352);

modinq_size_81_c3344 := if(nf_inq_lnamesperbestssn_count12 < 1.880173, modinq_size_81_c3345, 4.000000);

modinq_size_81_c3357 := if(rv_i62_inq_lnamesperadl_count12 < 0.236159, 12.695532, 8.000000);

modinq_size_81_c3358 := if(rv_i62_inq_phonesperadl_count12 < 0.738685, 11.535537, 8.000000);

modinq_size_81_c3356 := if(nf_inq_perssn_count12 < 0.992662, modinq_size_81_c3357, modinq_size_81_c3358);

modinq_size_81_c3360 := if(nf_inq_bestphone_ver_count < 40.627836, 9.207392, 11.535537);

modinq_size_81_c3361 := if(nf_inq_dobsperssn_recency < 9.414910, 11.748880, 9.207392);

modinq_size_81_c3359 := if(rv_i62_inq_num_names_per_adl < 0.493963, modinq_size_81_c3360, modinq_size_81_c3361);

modinq_size_81_c3355 := if(rv_i60_inq_auto_recency < 0.759300, modinq_size_81_c3356, modinq_size_81_c3359);

modinq_size_81_c3354 := if(nf_inq_retailpayments_count24 < 0.630369, modinq_size_81_c3355, 5.000000);

modinq_size_81_c3353 := if(nf_inq_lnamesperaddr_count_day < 0.126626, modinq_size_81_c3354, 4.000000);

modinq_size_81_c3343 := if(rv_i60_inq_banking_recency < 55.045247, modinq_size_81_c3344, modinq_size_81_c3353);

modinq_size_81_c3367 := if(nf_inq_collection_count < 1.229650, 9.000000, 8.000000);

modinq_size_81_c3368 := if(nf_inq_perbestssn_count12 < 0.622965, 10.706640, 8.000000);

modinq_size_81_c3366 := if(nf_inquiry_verification_index < 29.102902, modinq_size_81_c3367, modinq_size_81_c3368);

modinq_size_81_c3370 := if(nf_inq_bestphone_ver_count < 216.598509, 8.000000, 9.000000);

modinq_size_81_c3371 := if(nf_inq_ssnsperaddr_count12 < 0.894409, 8.000000, 8.000000);

modinq_size_81_c3369 := if(nf_inq_addrsperbestssn_count12 < 0.861235, modinq_size_81_c3370, modinq_size_81_c3371);

modinq_size_81_c3365 := if(rv_i62_inq_num_names_per_adl < 0.795141, modinq_size_81_c3366, modinq_size_81_c3369);

modinq_size_81_c3364 := if(nf_inquiry_ssn_vel_risk_index < 1.706319, modinq_size_81_c3365, 5.000000);

modinq_size_81_c3375 := if(nf_inq_quizprovider_count < 0.034936, 8.000000, 8.000000);

modinq_size_81_c3376 := if(nf_inq_fname_ver_count < 14.948861, 9.000000, 9.000000);

modinq_size_81_c3374 := if(nf_inq_addrsperssn_recency < 8.670066, modinq_size_81_c3375, modinq_size_81_c3376);

modinq_size_81_c3373 := if(nf_inq_per_apt_addr < 0.988908, modinq_size_81_c3374, 6.000000);

modinq_size_81_c3372 := if(nf_inq_per_sfd_addr < 9.953271, modinq_size_81_c3373, 5.000000);

modinq_size_81_c3363 := if(rv_i62_inq_fnamesperadl_recency < 11.771117, modinq_size_81_c3364, modinq_size_81_c3372);

modinq_size_81_c3381 := if(nf_inq_ssns_per_addr < 1.268599, 10.706640, 8.000000);

modinq_size_81_c3382 := if(nf_inq_addrsperadl_count_week < 1.618358, 8.000000, 8.000000);

modinq_size_81_c3380 := if(nf_inq_dobs_per_ssn < 0.017327, modinq_size_81_c3381, modinq_size_81_c3382);

modinq_size_81_c3383 := if(nf_inq_other_count24 < 2.951876, 7.000000, 7.000000);

modinq_size_81_c3379 := if(nf_inq_ssnsperaddr_recency < 8.913475, modinq_size_81_c3380, modinq_size_81_c3383);

modinq_size_81_c3385 := if(nf_inq_addr_ver_count < 2.053932, 7.000000, 7.000000);

modinq_size_81_c3386 := if(nf_inq_bestlname_ver_count < 19.341321, 7.000000, 7.000000);

modinq_size_81_c3384 := if(rv_i62_inq_addrsperadl_count12 < 0.790887, modinq_size_81_c3385, modinq_size_81_c3386);

modinq_size_81_c3378 := if(rv_i60_inq_auto_recency < 76.148895, modinq_size_81_c3379, modinq_size_81_c3384);

modinq_size_81_c3377 := if(nf_inq_lname_ver_count < 48.216086, modinq_size_81_c3378, 4.000000);

modinq_size_81_c3362 := if(rv_i60_inq_banking_recency < 76.831968, modinq_size_81_c3363, modinq_size_81_c3377);

modinq_size_81_c3342 := if(nf_invbest_inq_lastperaddr_diff < -0.216261, modinq_size_81_c3343, modinq_size_81_c3362);

//modinq_size_81 := if(nf_inq_count < -6057924524.935784, 1.000000, modinq_size_81_c3342);
modinq_size_81 := if(nf_inq_count < -999999998, 1.000000, modinq_size_81_c3342);

modinq_size_82_c3394 := if(rv_i61_inq_collection_recency < 48.074482, 15.309216, 14.676282);

modinq_size_82_c3393 := if(rv_i60_inq_count12 < 2.138332, modinq_size_82_c3394, 7.000000);

modinq_size_82_c3396 := if(nf_inq_ssn_ver_count < 4.419940, 8.000000, 8.000000);

modinq_size_82_c3395 := if(nf_inq_lnames_per_apt_addr < -0.877872, modinq_size_82_c3396, 7.000000);

modinq_size_82_c3392 := if(nf_inq_curraddr_ver_count < 47.719538, modinq_size_82_c3393, modinq_size_82_c3395);

modinq_size_82_c3399 := if(nf_inq_retail_count24 < 0.790016, 13.669106, 8.000000);

modinq_size_82_c3400 := if(nf_inq_bestssn_ver_count < 141.083678, 8.000000, 9.207392);

modinq_size_82_c3398 := if(nf_inq_adls_per_apt_addr < -0.153725, modinq_size_82_c3399, modinq_size_82_c3400);

modinq_size_82_c3397 := if(rv_i62_inq_lnamesperadl_recency < 9.684255, modinq_size_82_c3398, 6.000000);

modinq_size_82_c3391 := if(nf_inq_bestdob_ver_count < 210.219748, modinq_size_82_c3392, modinq_size_82_c3397);

modinq_size_82_c3402 := if(nf_inq_peraddr_count12 < 1.157966, 6.000000, 6.000000);

modinq_size_82_c3401 := if(nf_inq_addr_ver_count < 3.662635, modinq_size_82_c3402, 5.000000);

modinq_size_82_c3390 := if(rv_i60_inq_util_recency < 27.405850, modinq_size_82_c3391, modinq_size_82_c3401);

modinq_size_82_c3406 := if(nf_inq_per_ssn < 0.122109, 7.000000, 7.000000);

modinq_size_82_c3408 := if(nf_inq_highriskcredit_count < 0.877354, 9.000000, 8.000000);

modinq_size_82_c3409 := if(nf_inq_other_count < 4.889383, 8.000000, 8.000000);

modinq_size_82_c3407 := if(nf_inq_bestlname_ver_count < 11.803729, modinq_size_82_c3408, modinq_size_82_c3409);

modinq_size_82_c3405 := if(nf_inq_lnamesperaddr_count12 < 0.254854, modinq_size_82_c3406, modinq_size_82_c3407);

modinq_size_82_c3404 := if(nf_inq_adls_per_sfd_addr < -0.197946, 5.000000, modinq_size_82_c3405);

modinq_size_82_c3403 := if(rv_i60_inq_other_count12 < 105.656984, modinq_size_82_c3404, 4.000000);

modinq_size_82_c3389 := if(rv_i62_inq_dobsperadl_recency < 8.223066, modinq_size_82_c3390, modinq_size_82_c3403);

modinq_size_82_c3415 := if(nf_inq_communications_count < 3.386215, 15.342840, 9.851656);

modinq_size_82_c3414 := if(nf_inq_mortgage_count_week < 0.437392, modinq_size_82_c3415, 7.000000);

modinq_size_82_c3417 := if(nf_inq_per_addr < 6.883407, 8.000000, 8.000000);

modinq_size_82_c3418 := if(nf_inq_addrs_per_ssn < 2.985240, 8.000000, 8.000000);

modinq_size_82_c3416 := if(rv_i61_inq_collection_recency < 78.951268, modinq_size_82_c3417, modinq_size_82_c3418);

modinq_size_82_c3413 := if(nf_inq_dobsperbestssn_count12 < 1.215676, modinq_size_82_c3414, modinq_size_82_c3416);

modinq_size_82_c3421 := if(nf_inq_other_count < 36.457960, 9.000000, 8.000000);

modinq_size_82_c3420 := if(nf_inq_utilities_count < 0.670506, modinq_size_82_c3421, 7.000000);

modinq_size_82_c3419 := if(nf_inq_fname_ver_count < 67.692710, 6.000000, modinq_size_82_c3420);

modinq_size_82_c3412 := if(nf_inq_count < 35.243130, modinq_size_82_c3413, modinq_size_82_c3419);

modinq_size_82_c3425 := if(nf_inq_per_ssn < 1.701469, 8.000000, 8.000000);

modinq_size_82_c3424 := if(nf_inq_lnamesperaddr_recency < 2.114662, 7.000000, modinq_size_82_c3425);

modinq_size_82_c3427 := if(rv_i60_inq_other_count12 < 1.807490, 9.000000, 8.000000);

modinq_size_82_c3426 := if(nf_inq_adlspercurraddr_count12 < 0.704414, 7.000000, modinq_size_82_c3427);

modinq_size_82_c3423 := if(nf_inq_dobs_per_ssn < 0.393728, modinq_size_82_c3424, modinq_size_82_c3426);

modinq_size_82_c3429 := if(rv_i60_inq_retpymt_recency < 11.849529, 7.000000, 7.000000);

modinq_size_82_c3428 := if(nf_inq_communications_count < 2.656534, modinq_size_82_c3429, 6.000000);

modinq_size_82_c3422 := if(rv_i62_inq_addrs_per_adl < 1.506720, modinq_size_82_c3423, modinq_size_82_c3428);

modinq_size_82_c3411 := if(rv_i60_inq_auto_recency < 39.368576, modinq_size_82_c3412, modinq_size_82_c3422);

modinq_size_82_c3434 := if(nf_inq_mortgage_count < 0.633858, 11.023665, 10.706640);

modinq_size_82_c3435 := if(nf_inq_percurraddr_count12 < 1.646638, 8.000000, 8.000000);

modinq_size_82_c3433 := if(rv_i62_inq_phones_per_adl < 1.630751, modinq_size_82_c3434, modinq_size_82_c3435);

modinq_size_82_c3432 := if(rv_i60_inq_retpymt_recency < 74.502169, modinq_size_82_c3433, 6.000000);

modinq_size_82_c3431 := if(nf_inquiry_addr_vel_risk_index < 0.944499, modinq_size_82_c3432, 5.000000);

modinq_size_82_c3437 := if(nf_inq_peraddr_count12 < 8.857225, 6.000000, 6.000000);

modinq_size_82_c3436 := if(nf_inq_count < 14.663878, modinq_size_82_c3437, 5.000000);

modinq_size_82_c3430 := if(nf_inq_lnamesperaddr_count12 < 2.368947, modinq_size_82_c3431, modinq_size_82_c3436);

modinq_size_82_c3410 := if(nf_inq_adlsperaddr_recency < 6.285067, modinq_size_82_c3411, modinq_size_82_c3430);

modinq_size_82_c3388 := if(nf_inq_lnamesperbestssn_count12 < 0.125319, modinq_size_82_c3389, modinq_size_82_c3410);

modinq_size_82_c3438 := if(nf_inq_bestfname_ver_count < 12.287791, 2.000000, 2.000000);

modinq_size_82 := if(nf_inq_adls_per_addr < 4.739904, modinq_size_82_c3388, modinq_size_82_c3438);

modinq_size_83_c3446 := if(nf_inq_ssns_per_sfd_addr < -0.653660, 13.590539, 17.202149);

modinq_size_83_c3447 := if(rv_i62_inq_fnamesperadl_recency < 5.059586, 11.748880, 9.000000);

modinq_size_83_c3445 := if(nf_inq_dobsperssn_recency < 0.333452, modinq_size_83_c3446, modinq_size_83_c3447);

modinq_size_83_c3449 := if(nf_inq_highriskcredit_count24 < 0.651853, 9.851656, 9.000000);

modinq_size_83_c3450 := if(nf_inq_retailpayments_count24 < 0.240765, 8.000000, 8.000000);

modinq_size_83_c3448 := if(nf_inq_addrsperbestssn_count12 < 1.830655, modinq_size_83_c3449, modinq_size_83_c3450);

modinq_size_83_c3444 := if(nf_inq_dobsperssn_recency < 2.602745, modinq_size_83_c3445, modinq_size_83_c3448);

modinq_size_83_c3452 := if(nf_inq_per_ssn < 11.123198, 7.000000, 7.000000);

modinq_size_83_c3451 := if(rv_i62_inq_ssnsperadl_recency < 1.077664, 6.000000, modinq_size_83_c3452);

modinq_size_83_c3443 := if(nf_inq_per_sfd_addr < 10.417654, modinq_size_83_c3444, modinq_size_83_c3451);

modinq_size_83_c3442 := if(nf_inq_other_count24 < 40.755105, modinq_size_83_c3443, 4.000000);

modinq_size_83_c3457 := if(rv_i62_inq_fnamesperadl_recency < 11.237890, 9.000000, 8.000000);

modinq_size_83_c3458 := if(nf_inq_dob_ver_count < 10.496442, 8.000000, 8.000000);

modinq_size_83_c3456 := if(rv_i60_inq_banking_recency < 8.338218, modinq_size_83_c3457, modinq_size_83_c3458);

modinq_size_83_c3460 := if(rv_i62_inq_num_names_per_adl < 1.760793, 13.955690, 9.851656);

modinq_size_83_c3459 := if(nf_inq_communications_count24 < 2.042250, modinq_size_83_c3460, 7.000000);

modinq_size_83_c3455 := if(nf_inquiry_verification_index < 30.691126, modinq_size_83_c3456, modinq_size_83_c3459);

modinq_size_83_c3454 := if(nf_inq_bestssn_ver_count < 39.117399, modinq_size_83_c3455, 5.000000);

modinq_size_83_c3464 := if(nf_inq_retailpayments_count < 0.604067, 8.000000, 8.000000);

modinq_size_83_c3463 := if(nf_inq_bestlname_ver_count < 9.077600, 7.000000, modinq_size_83_c3464);

modinq_size_83_c3462 := if(nf_inq_bestfname_ver_count < 26.085260, modinq_size_83_c3463, 6.000000);

modinq_size_83_c3461 := if(nf_inq_quizprovider_count24 < 1.930129, modinq_size_83_c3462, 5.000000);

modinq_size_83_c3453 := if(nf_inq_percurraddr_count12 < 10.152367, modinq_size_83_c3454, modinq_size_83_c3461);

modinq_size_83_c3441 := if(nf_inq_dobsperssn_recency < 5.316763, modinq_size_83_c3442, modinq_size_83_c3453);

modinq_size_83_c3468 := if(rv_i60_inq_peradl_count12 < 2.331037, 6.000000, 6.000000);

modinq_size_83_c3471 := if(nf_inquiry_adl_vel_risk_index < 1.000072, 8.000000, 8.000000);

modinq_size_83_c3470 := if(nf_inq_ssn_ver_count < 56.940242, modinq_size_83_c3471, 7.000000);

modinq_size_83_c3469 := if(nf_inq_addrsperssn_recency < 9.433067, modinq_size_83_c3470, 6.000000);

modinq_size_83_c3467 := if(rv_i60_inq_comm_recency < 14.357768, modinq_size_83_c3468, modinq_size_83_c3469);

modinq_size_83_c3466 := if(nf_inq_dobsperssn_count_day < 0.004134, modinq_size_83_c3467, 4.000000);

modinq_size_83_c3465 := if(nf_inq_quizprovider_count < 7.350603, modinq_size_83_c3466, 3.000000);

modinq_size_83_c3440 := if(nf_inquiry_ssn_vel_risk_indexv2 < 1.265972, modinq_size_83_c3441, modinq_size_83_c3465);

//modinq_size_83 := if(nf_inq_collection_count24 < -5143034583.659988, 1.000000, modinq_size_83_c3440);
modinq_size_83 := if(nf_inq_collection_count24 < -999999998, 1.000000, modinq_size_83_c3440);

modinq_size_84_c3479 := if(rv_i60_inq_count12 < 6.400213, 17.437724, 10.327020);

modinq_size_84_c3478 := if(nf_inq_fnamesperadl_count_week < 0.559927, modinq_size_84_c3479, 7.000000);

modinq_size_84_c3480 := if(rv_i60_inq_banking_recency < 0.077707, 7.000000, 7.000000);

modinq_size_84_c3477 := if(nf_inq_lnamesperssn_count_week < 0.929721, modinq_size_84_c3478, modinq_size_84_c3480);

modinq_size_84_c3483 := if(nf_inq_dobsperadl_count_week < 0.460119, 11.535537, 8.000000);

modinq_size_84_c3484 := if(nf_inquiry_adl_vel_risk_index < 3.328884, 9.207392, 8.000000);

modinq_size_84_c3482 := if(rv_i62_inq_fnamesperadl_recency < 3.633204, modinq_size_84_c3483, modinq_size_84_c3484);

modinq_size_84_c3486 := if(nf_inq_retailpayments_count24 < 0.420065, 11.296252, 8.000000);

modinq_size_84_c3487 := if(rv_i62_inq_addrsperadl_count12 < 1.951225, 8.000000, 8.000000);

modinq_size_84_c3485 := if(nf_inq_count_week < 2.708963, modinq_size_84_c3486, modinq_size_84_c3487);

modinq_size_84_c3481 := if(rv_i61_inq_collection_recency < 75.752318, modinq_size_84_c3482, modinq_size_84_c3485);

modinq_size_84_c3476 := if(nf_inq_lnames_per_apt_addr < -0.223888, modinq_size_84_c3477, modinq_size_84_c3481);

modinq_size_84_c3491 := if(nf_inq_lnamesperadl_count_week < 0.328948, 14.021342, 8.000000);

modinq_size_84_c3492 := if(nf_inq_lnamesperaddr_count12 < 3.813692, 9.207392, 8.000000);

modinq_size_84_c3490 := if(nf_inq_ssnsperaddr_count12 < 3.042216, modinq_size_84_c3491, modinq_size_84_c3492);

modinq_size_84_c3489 := if(nf_inq_lnamesperssn_count_day < 0.269334, modinq_size_84_c3490, 6.000000);

modinq_size_84_c3488 := if(rv_i60_inq_auto_count12 < 10.753800, modinq_size_84_c3489, 5.000000);

modinq_size_84_c3475 := if(nf_inq_ssnsperaddr_count12 < 1.165766, modinq_size_84_c3476, modinq_size_84_c3488);

modinq_size_84_c3497 := if(nf_inq_retail_count24 < 0.095142, 8.000000, 8.000000);

modinq_size_84_c3498 := if(rv_i62_inq_addrs_per_adl < 0.821293, 8.000000, 8.000000);

modinq_size_84_c3496 := if(nf_inq_adls_per_addr < 0.450562, modinq_size_84_c3497, modinq_size_84_c3498);

modinq_size_84_c3500 := if(nf_inq_perssn_recency < 5.659055, 8.000000, 8.000000);

modinq_size_84_c3501 := if(nf_inq_curraddr_ver_count < 8.214546, 8.000000, 8.000000);

modinq_size_84_c3499 := if(rv_i62_inq_addrsperadl_count12 < 1.405827, modinq_size_84_c3500, modinq_size_84_c3501);

modinq_size_84_c3495 := if(nf_inq_addrsperssn_count12 < 0.016211, modinq_size_84_c3496, modinq_size_84_c3499);

modinq_size_84_c3494 := if(nf_inq_prepaidcards_count < 0.338111, modinq_size_84_c3495, 5.000000);

modinq_size_84_c3493 := if(rv_i62_inq_ssnsperadl_count12 < 0.833662, 4.000000, modinq_size_84_c3494);

modinq_size_84_c3474 := if(nf_inq_mortgage_count24 < 0.341114, modinq_size_84_c3475, modinq_size_84_c3493);

modinq_size_84_c3502 := if(nf_inq_adls_per_sfd_addr < -0.301407, 3.000000, 3.000000);

modinq_size_84_c3473 := if(nf_inq_mortgage_count < 4.463135, modinq_size_84_c3474, modinq_size_84_c3502);

modinq_size_84_c3503 := if(nf_inq_addrsperssn_count12 < 4.296426, 2.000000, 2.000000);

modinq_size_84 := if(nf_inq_auto_count < 21.010521, modinq_size_84_c3473, modinq_size_84_c3503);

modinq_size_85_c3506 := if(nf_inq_lnames_per_apt_addr < 0.531715, 3.000000, 3.000000);

modinq_size_85_c3505 := if(nf_inq_per_addr < 2.023651, modinq_size_85_c3506, 2.000000);

modinq_size_85_c3513 := if(nf_inq_bestdob_ver_count < 130.242351, 17.008886, 13.334385);

modinq_size_85_c3514 := if(rv_i62_inq_addrsperadl_count12 < 2.710575, 10.327020, 8.000000);

modinq_size_85_c3512 := if(rv_i60_inq_prepaidcards_recency < 43.868766, modinq_size_85_c3513, modinq_size_85_c3514);

modinq_size_85_c3516 := if(nf_inq_per_apt_addr < -0.837354, 13.241134, 9.207392);

modinq_size_85_c3515 := if(nf_inq_lnames_per_addr < 5.925931, modinq_size_85_c3516, 7.000000);

modinq_size_85_c3511 := if(nf_inq_dobsperssn_recency < 5.987188, modinq_size_85_c3512, modinq_size_85_c3515);

modinq_size_85_c3519 := if(nf_inq_adlsperbestphone_count12 < 0.551739, 13.887806, 8.000000);

modinq_size_85_c3520 := if(nf_invbest_inq_peraddr_diff < -3.648583, 8.000000, 9.000000);

modinq_size_85_c3518 := if(rv_i60_inq_recency < 75.869177, modinq_size_85_c3519, modinq_size_85_c3520);

modinq_size_85_c3522 := if(rv_i60_credit_seeking < 0.346330, 9.207392, 9.851656);

modinq_size_85_c3521 := if(nf_inq_ssn_ver_count < 63.828321, modinq_size_85_c3522, 7.000000);

modinq_size_85_c3517 := if(nf_inq_fname_ver_count < 41.408172, modinq_size_85_c3518, modinq_size_85_c3521);

modinq_size_85_c3510 := if(nf_inq_bestlname_ver_count < 15.472310, modinq_size_85_c3511, modinq_size_85_c3517);

modinq_size_85_c3526 := if(nf_inq_mortgage_count < 1.070818, 12.278091, 8.000000);

modinq_size_85_c3525 := if(nf_inq_lnames_per_sfd_addr < 0.295856, modinq_size_85_c3526, 7.000000);

modinq_size_85_c3524 := if(nf_inq_per_addr < 8.518985, modinq_size_85_c3525, 6.000000);

modinq_size_85_c3527 := if(nf_inq_adlsperaddr_recency < 4.672581, 6.000000, 6.000000);

modinq_size_85_c3523 := if(nf_invbest_inq_adlsperaddr_diff < -0.202064, modinq_size_85_c3524, modinq_size_85_c3527);

modinq_size_85_c3509 := if(nf_inq_curraddr_ver_count < 206.724168, modinq_size_85_c3510, modinq_size_85_c3523);

modinq_size_85_c3508 := if(nf_inq_lnamesperaddr_count12 < 6.557516, modinq_size_85_c3509, 3.000000);

modinq_size_85_c3528 := if(nf_inq_fname_ver_count < 12.634213, 3.000000, 3.000000);

modinq_size_85_c3507 := if(nf_inq_addrsperssn_count_day < 0.813682, modinq_size_85_c3508, modinq_size_85_c3528);

//modinq_size_85 := if(nf_inq_perbestssn_count12 < -1352704985.798178, modinq_size_85_c3505, modinq_size_85_c3507);
modinq_size_85 := if(nf_inq_perbestssn_count12 < -999999998, modinq_size_85_c3505, modinq_size_85_c3507);

modinq_size_86_c3536 := if(nf_inq_ssn_ver_count < 10.011047, 14.676282, 13.423473);

modinq_size_86_c3537 := if(nf_inq_utilities_count < 0.578529, 14.580971, 9.207392);

modinq_size_86_c3535 := if(rv_i62_inq_num_names_per_adl < 0.479333, modinq_size_86_c3536, modinq_size_86_c3537);

modinq_size_86_c3539 := if(nf_inq_dobsperbestssn_count12 < 0.045854, 8.000000, 9.000000);

modinq_size_86_c3538 := if(rv_i60_inq_banking_count12 < 1.378025, modinq_size_86_c3539, 7.000000);

modinq_size_86_c3534 := if(rv_i62_inq_ssns_per_adl < 1.260472, modinq_size_86_c3535, modinq_size_86_c3538);

modinq_size_86_c3542 := if(rv_i60_inq_banking_recency < 91.620191, 15.967720, 14.629195);

modinq_size_86_c3543 := if(nf_inq_adlsperaddr_count_week < 0.565830, 8.000000, 8.000000);

modinq_size_86_c3541 := if(nf_inq_addrsperadl_count_week < 0.610776, modinq_size_86_c3542, modinq_size_86_c3543);

modinq_size_86_c3545 := if(rv_i62_inq_ssnsperadl_count12 < 1.028855, 10.327020, 8.000000);

modinq_size_86_c3546 := if(nf_inq_phonesperadl_count_week < 0.765104, 8.000000, 8.000000);

modinq_size_86_c3544 := if(nf_inq_bestssn_ver_count < 8.322724, modinq_size_86_c3545, modinq_size_86_c3546);

modinq_size_86_c3540 := if(nf_inq_lnamesperssn_count_week < 0.285099, modinq_size_86_c3541, modinq_size_86_c3544);

modinq_size_86_c3533 := if(rv_i61_inq_collection_recency < 0.577403, modinq_size_86_c3534, modinq_size_86_c3540);

modinq_size_86_c3548 := if(rv_i60_inq_peradl_count12 < 30.976313, 6.000000, 6.000000);

modinq_size_86_c3547 := if(nf_inq_per_addr < 16.030970, modinq_size_86_c3548, 5.000000);

modinq_size_86_c3532 := if(nf_inq_perssn_count12 < 18.535336, modinq_size_86_c3533, modinq_size_86_c3547);

modinq_size_86_c3531 := if(nf_inq_fnamesperadl_count_day < 0.693476, modinq_size_86_c3532, 3.000000);

modinq_size_86_c3550 := if(rv_i61_inq_collection_recency < 87.435612, 4.000000, 4.000000);

modinq_size_86_c3549 := if(nf_inq_dobsperadl_count_day < 0.339402, 3.000000, modinq_size_86_c3550);

modinq_size_86_c3530 := if(nf_inq_addrsperadl_count_day < 0.649283, modinq_size_86_c3531, modinq_size_86_c3549);

//modinq_size_86 := if(nf_inq_peraddr_count_week < -4159182296.862715, 1.000000, modinq_size_86_c3530);
modinq_size_86 := if(nf_inq_peraddr_count_week < -999999998, 1.000000, modinq_size_86_c3530);

modinq_size_87_c3558 := if(rv_i60_inq_mortgage_recency < 17.614003, 15.893165, 13.508753);

modinq_size_87_c3559 := if(nf_inq_adlsperaddr_recency < 6.755193, 11.941420, 9.000000);

modinq_size_87_c3557 := if(nf_inq_bestfname_ver_count < 149.592459, modinq_size_87_c3558, modinq_size_87_c3559);

modinq_size_87_c3556 := if(nf_inq_adls_per_addr < 3.104515, modinq_size_87_c3557, 6.000000);

modinq_size_87_c3555 := if(nf_inq_dobs_per_ssn < 0.140585, modinq_size_87_c3556, 5.000000);

modinq_size_87_c3562 := if(nf_inq_other_count < 0.912433, 7.000000, 7.000000);

modinq_size_87_c3561 := if(nf_inq_dob_ver_count < 218.116804, modinq_size_87_c3562, 6.000000);

modinq_size_87_c3565 := if(nf_inq_prepaidcards_count < 0.780935, 9.207392, 8.000000);

modinq_size_87_c3566 := if(nf_inq_bestssn_ver_count < 3.508525, 9.000000, 8.000000);

modinq_size_87_c3564 := if(nf_inquiry_verification_index < 27.127422, modinq_size_87_c3565, modinq_size_87_c3566);

modinq_size_87_c3563 := if(nf_inq_addr_ver_count < 17.160316, modinq_size_87_c3564, 6.000000);

modinq_size_87_c3560 := if(nf_inq_banking_count < 0.716876, modinq_size_87_c3561, modinq_size_87_c3563);

modinq_size_87_c3554 := if(nf_inq_retailpayments_count < 0.254981, modinq_size_87_c3555, modinq_size_87_c3560);

modinq_size_87_c3553 := if(nf_inq_lnamespercurraddr_count12 < 4.230492, modinq_size_87_c3554, 3.000000);

modinq_size_87_c3572 := if(nf_inq_ssnsperaddr_count12 < 2.811297, 14.146509, 9.207392);

modinq_size_87_c3573 := if(rv_i60_inq_auto_recency < 0.246819, 8.000000, 10.327020);

modinq_size_87_c3571 := if(nf_inq_fname_ver_count < 25.129700, modinq_size_87_c3572, modinq_size_87_c3573);

modinq_size_87_c3570 := if(nf_inq_peraddr_count_week < 3.316288, modinq_size_87_c3571, 6.000000);

modinq_size_87_c3569 := if(nf_inq_perbestphone_count12 < 2.566692, modinq_size_87_c3570, 5.000000);

modinq_size_87_c3575 := if(rv_i60_inq_mortgage_recency < 49.688385, 6.000000, 6.000000);

modinq_size_87_c3574 := if(nf_inq_peraddr_count12 < 9.021818, modinq_size_87_c3575, 5.000000);

modinq_size_87_c3568 := if(nf_inq_lnames_per_apt_addr < 0.568455, modinq_size_87_c3569, modinq_size_87_c3574);

modinq_size_87_c3576 := if(rv_i60_inq_auto_count12 < 3.288115, 4.000000, 4.000000);

modinq_size_87_c3567 := if(nf_inq_perbestssn_count12 < 6.542535, modinq_size_87_c3568, modinq_size_87_c3576);

modinq_size_87_c3552 := if(rv_i62_inq_addrsperadl_count12 < 0.792576, modinq_size_87_c3553, modinq_size_87_c3567);

modinq_size_87_c3583 := if(nf_inq_bestphone_ver_count < 11.292443, 8.000000, 8.000000);

modinq_size_87_c3582 := if(nf_inq_ssnsperaddr_recency < 10.595405, modinq_size_87_c3583, 7.000000);

modinq_size_87_c3581 := if(nf_inq_dobsperssn_recency < 7.466736, modinq_size_87_c3582, 6.000000);

modinq_size_87_c3586 := if(nf_inq_other_count < 2.687669, 9.000000, 9.851656);

modinq_size_87_c3585 := if(nf_inq_banking_count_week < 0.065891, modinq_size_87_c3586, 7.000000);

modinq_size_87_c3587 := if(nf_invbest_inq_adlsperaddr_diff < -0.878525, 7.000000, 7.000000);

modinq_size_87_c3584 := if(nf_inq_auto_count < 6.342685, modinq_size_87_c3585, modinq_size_87_c3587);

modinq_size_87_c3580 := if(nf_inq_ssn_ver_count < 5.989221, modinq_size_87_c3581, modinq_size_87_c3584);

modinq_size_87_c3591 := if(nf_inq_retailpayments_count24 < 0.507599, 14.896393, 9.207392);

modinq_size_87_c3590 := if(nf_inq_banking_count < 14.540567, modinq_size_87_c3591, 7.000000);

modinq_size_87_c3589 := if(nf_inq_highriskcredit_count_week < 0.565862, modinq_size_87_c3590, 6.000000);

modinq_size_87_c3594 := if(rv_i60_inq_banking_recency < 42.035626, 9.000000, 8.000000);

modinq_size_87_c3593 := if(nf_inq_perbestphone_count12 < 0.827325, modinq_size_87_c3594, 7.000000);

modinq_size_87_c3596 := if(nf_inq_addrsperssn_recency < 9.312209, 8.000000, 8.000000);

modinq_size_87_c3595 := if(rv_i60_inq_count12 < 6.280552, 7.000000, modinq_size_87_c3596);

modinq_size_87_c3592 := if(nf_inq_bestdob_ver_count < 9.093247, modinq_size_87_c3593, modinq_size_87_c3595);

modinq_size_87_c3588 := if(nf_inquiry_addr_vel_risk_indexv2 < 2.960215, modinq_size_87_c3589, modinq_size_87_c3592);

modinq_size_87_c3579 := if(rv_i62_inq_dobs_per_adl < 0.921731, modinq_size_87_c3580, modinq_size_87_c3588);

modinq_size_87_c3597 := if(nf_inq_ssn_ver_count < 16.523275, 4.000000, 4.000000);

modinq_size_87_c3578 := if(nf_inq_quizprovider_count24 < 2.068892, modinq_size_87_c3579, modinq_size_87_c3597);

modinq_size_87_c3598 := if(nf_inq_per_addr < 5.824956, 3.000000, 3.000000);

modinq_size_87_c3577 := if(rv_i60_inq_util_recency < 72.589076, modinq_size_87_c3578, modinq_size_87_c3598);

modinq_size_87 := if(nf_inq_adlsperssn_recency < 1.576144, modinq_size_87_c3552, modinq_size_87_c3577);

modinq_size_88_c3606 := if(rv_i60_inq_peradl_count12 < 0.707226, 14.896393, 13.040438);

modinq_size_88_c3607 := if(nf_invbest_inq_lastperaddr_diff < -0.147663, 11.748880, 8.000000);

modinq_size_88_c3605 := if(nf_inq_per_ssn < 2.377469, modinq_size_88_c3606, modinq_size_88_c3607);

modinq_size_88_c3609 := if(nf_inq_communications_count < 0.466455, 8.000000, 8.000000);

modinq_size_88_c3608 := if(nf_inq_addrsperssn_recency < 9.123227, modinq_size_88_c3609, 7.000000);

modinq_size_88_c3604 := if(nf_inq_peradl_count_week < 0.710306, modinq_size_88_c3605, modinq_size_88_c3608);

modinq_size_88_c3611 := if(nf_inq_ssns_per_addr < 3.975682, 7.000000, 7.000000);

modinq_size_88_c3610 := if(nf_inq_lnamesperssn_count_day < 0.898261, modinq_size_88_c3611, 6.000000);

modinq_size_88_c3603 := if(nf_inq_ssnsperadl_count_week < 0.324129, modinq_size_88_c3604, modinq_size_88_c3610);

modinq_size_88_c3602 := if(nf_inq_utilities_count24 < 0.750675, modinq_size_88_c3603, 4.000000);

modinq_size_88_c3612 := if(rv_i62_inq_dobsperadl_count12 < 0.868575, 4.000000, 4.000000);

modinq_size_88_c3601 := if(nf_inq_per_apt_addr < 0.832173, modinq_size_88_c3602, modinq_size_88_c3612);

modinq_size_88_c3618 := if(nf_inq_ssnsperaddr_count_week < 0.326300, 16.462261, 9.207392);

modinq_size_88_c3619 := if(nf_inq_lnamesperssn_count_week < 0.423435, 12.931969, 8.000000);

modinq_size_88_c3617 := if(nf_inq_quizprovider_count24 < 0.697416, modinq_size_88_c3618, modinq_size_88_c3619);

modinq_size_88_c3621 := if(nf_inq_lnamesperbestssn_count12 < 0.933894, 9.851656, 9.207392);

modinq_size_88_c3622 := if(nf_inq_percurraddr_count12 < 5.460977, 9.851656, 9.000000);

modinq_size_88_c3620 := if(nf_inq_ssn_ver_count < 8.878217, modinq_size_88_c3621, modinq_size_88_c3622);

modinq_size_88_c3616 := if(nf_inq_retailpayments_count24 < 0.955670, modinq_size_88_c3617, modinq_size_88_c3620);

modinq_size_88_c3625 := if(nf_inq_mortgage_count < 0.252876, 13.241134, 8.000000);

modinq_size_88_c3626 := if(nf_inq_adlsperaddr_count12 < 1.846888, 8.000000, 8.000000);

modinq_size_88_c3624 := if(nf_inq_lnamesperaddr_count_week < 0.001294, modinq_size_88_c3625, modinq_size_88_c3626);

modinq_size_88_c3627 := if(nf_inq_lnames_per_addr < 0.072181, 7.000000, 7.000000);

modinq_size_88_c3623 := if(nf_inq_perssn_count12 < 7.563314, modinq_size_88_c3624, modinq_size_88_c3627);

modinq_size_88_c3615 := if(rv_i60_inq_comm_recency < 95.035092, modinq_size_88_c3616, modinq_size_88_c3623);

modinq_size_88_c3614 := if(rv_i60_inq_other_count12 < 11.812505, modinq_size_88_c3615, 4.000000);

modinq_size_88_c3613 := if(nf_inq_utilities_count24 < 0.023724, modinq_size_88_c3614, 3.000000);

modinq_size_88_c3600 := if(nf_inq_bestphone_ver_count < 175.724730, modinq_size_88_c3601, modinq_size_88_c3613);

modinq_size_88 := if(rv_i60_inq_count12 < 77.768336, modinq_size_88_c3600, 1.000000);

modinq_size_89_c3635 := if(rv_i62_inq_phonesperadl_count12 < 0.746986, 16.481220, 9.000000);

modinq_size_89_c3636 := if(rv_i62_inq_ssnsperadl_recency < 9.571242, 14.767255, 13.040438);

modinq_size_89_c3634 := if(rv_i62_inq_ssns_per_adl < 0.677324, modinq_size_89_c3635, modinq_size_89_c3636);

modinq_size_89_c3638 := if(nf_inq_addrs_per_ssn < 1.270110, 9.000000, 8.000000);

modinq_size_89_c3637 := if(nf_inq_lnamesperssn_recency < 0.180478, 7.000000, modinq_size_89_c3638);

modinq_size_89_c3633 := if(nf_inq_lnamesperaddr_count_day < 0.827127, modinq_size_89_c3634, modinq_size_89_c3637);

modinq_size_89_c3641 := if(nf_inq_quizprovider_count < 0.479406, 8.000000, 8.000000);

modinq_size_89_c3640 := if(nf_inq_banking_count24 < 0.472497, 7.000000, modinq_size_89_c3641);

modinq_size_89_c3642 := if(rv_i62_inq_addrs_per_adl < 5.137230, 7.000000, 7.000000);

modinq_size_89_c3639 := if(nf_inq_retail_count < 0.711522, modinq_size_89_c3640, modinq_size_89_c3642);

modinq_size_89_c3632 := if(rv_i60_inq_other_count12 < 4.184794, modinq_size_89_c3633, modinq_size_89_c3639);

modinq_size_89_c3646 := if(nf_inq_perbestssn_count12 < 0.439284, 13.669106, 8.000000);

modinq_size_89_c3645 := if(nf_inq_auto_count < 0.052233, modinq_size_89_c3646, 7.000000);

modinq_size_89_c3648 := if(nf_inq_adls_per_sfd_addr < 1.721144, 8.000000, 9.000000);

modinq_size_89_c3649 := if(rv_i60_inq_recency < 7.713337, 8.000000, 9.000000);

modinq_size_89_c3647 := if(nf_inq_perbestssn_count12 < 1.844878, modinq_size_89_c3648, modinq_size_89_c3649);

modinq_size_89_c3644 := if(rv_i62_inq_lnamesperadl_count12 < 0.699080, modinq_size_89_c3645, modinq_size_89_c3647);

modinq_size_89_c3643 := if(nf_inq_communications_count < 1.269938, modinq_size_89_c3644, 5.000000);

modinq_size_89_c3631 := if(nf_inq_dob_ver_count < 87.940866, modinq_size_89_c3632, modinq_size_89_c3643);

modinq_size_89_c3652 := if(nf_inq_lnamesperssn_recency < 3.640965, 6.000000, 6.000000);

modinq_size_89_c3651 := if(nf_inq_addrsperbestssn_count12 < 0.478167, 5.000000, modinq_size_89_c3652);

modinq_size_89_c3656 := if(nf_inquiry_ssn_vel_risk_indexv2 < 2.990694, 13.508753, 8.000000);

modinq_size_89_c3657 := if(nf_inq_dob_ver_count < 14.374749, 8.000000, 8.000000);

modinq_size_89_c3655 := if(nf_inq_highriskcredit_count24 < 1.500371, modinq_size_89_c3656, modinq_size_89_c3657);

modinq_size_89_c3659 := if(rv_i62_inq_addrsperadl_recency < 5.044475, 8.000000, 9.207392);

modinq_size_89_c3658 := if(nf_inq_dob_ver_count < 58.719770, modinq_size_89_c3659, 7.000000);

modinq_size_89_c3654 := if(rv_i62_inq_phonesperadl_count12 < 1.621549, modinq_size_89_c3655, modinq_size_89_c3658);

modinq_size_89_c3653 := if(nf_inq_highriskcredit_count24 < 14.574439, modinq_size_89_c3654, 5.000000);

modinq_size_89_c3650 := if(rv_i62_inq_dobsperadl_recency < 7.600685, modinq_size_89_c3651, modinq_size_89_c3653);

modinq_size_89_c3630 := if(rv_i62_inq_phonesperadl_recency < 10.787267, modinq_size_89_c3631, modinq_size_89_c3650);

modinq_size_89_c3661 := if(nf_inq_lnames_per_addr < 3.402062, 4.000000, 4.000000);

modinq_size_89_c3660 := if(nf_inq_collection_count < 0.592989, 3.000000, modinq_size_89_c3661);

modinq_size_89_c3629 := if(nf_inq_ssns_per_sfd_addr < 5.803510, modinq_size_89_c3630, modinq_size_89_c3660);

//modinq_size_89 := if(nf_inq_banking_count < -7549867154.031731, 1.000000, modinq_size_89_c3629);
modinq_size_89 := if(nf_inq_banking_count < -999999998, 1.000000, modinq_size_89_c3629);

//modinq_size_90_c3669 := if(rv_i60_inq_auto_recency < -9999999999.000000, 8.000000, 9.000000);
modinq_size_90_c3669 := if(rv_i60_inq_auto_recency < -999999998, 8.000000, 9.000000);

//modinq_size_90_c3668 := if(nf_inq_auto_count_day < -9999999999.000000, 7.000000, modinq_size_90_c3669);
modinq_size_90_c3668 := if(nf_inq_auto_count_day < -999999998, 7.000000, modinq_size_90_c3669);

//modinq_size_90_c3667 := if(nf_inq_fname_ver_count < -9999999999.000000, 6.000000, modinq_size_90_c3668);
modinq_size_90_c3667 := if(nf_inq_fname_ver_count < -999999998, 6.000000, modinq_size_90_c3668);

//modinq_size_90_c3666 := if(nf_inq_highriskcredit_count_day < -9999999999.000000, 5.000000, modinq_size_90_c3667);
modinq_size_90_c3666 := if(nf_inq_highriskcredit_count_day < -999999998, 5.000000, modinq_size_90_c3667);

//modinq_size_90_c3665 := if(nf_inq_lname_ver_count < -9999999999.000000, 4.000000, modinq_size_90_c3666);
modinq_size_90_c3665 := if(nf_inq_lname_ver_count < -999999998, 4.000000, modinq_size_90_c3666);

//modinq_size_90_c3664 := if(nf_inq_quizprovider_count_week < -9999999999.000000, 3.000000, modinq_size_90_c3665);
modinq_size_90_c3664 := if(nf_inq_quizprovider_count_week < -999999998, 3.000000, modinq_size_90_c3665);

modinq_size_90_c3663 := if(nf_inq_adls_per_sfd_addr < 0.381089, modinq_size_90_c3664, 2.000000);

modinq_size_90_c3676 := if(nf_inq_perbestssn_count12 < 9.183351, 17.162279, 9.000000);

modinq_size_90_c3677 := if(nf_inq_bestssn_ver_count < 120.560292, 13.669106, 8.000000);

modinq_size_90_c3675 := if(nf_inq_ssns_per_apt_addr < -0.841935, modinq_size_90_c3676, modinq_size_90_c3677);

modinq_size_90_c3678 := if(rv_i60_inq_count12 < 2.221900, 7.000000, 7.000000);

modinq_size_90_c3674 := if(nf_inq_adlsperaddr_count12 < 3.982314, modinq_size_90_c3675, modinq_size_90_c3678);

modinq_size_90_c3681 := if(nf_inq_adlsperaddr_count12 < 1.688035, 12.278091, 9.207392);

modinq_size_90_c3680 := if(nf_inq_dobsperbestssn_count12 < 0.971059, modinq_size_90_c3681, 7.000000);

modinq_size_90_c3682 := if(nf_invbest_inq_ssnsperaddr_diff < 0.993305, 7.000000, 7.000000);

modinq_size_90_c3679 := if(rv_i62_inq_ssnsperadl_recency < 5.371924, modinq_size_90_c3680, modinq_size_90_c3682);

modinq_size_90_c3673 := if(nf_inq_curraddr_ver_count < 213.593638, modinq_size_90_c3674, modinq_size_90_c3679);

modinq_size_90_c3686 := if(nf_inq_lnamesperaddr_count12 < 1.475854, 13.508753, 9.207392);

modinq_size_90_c3687 := if(nf_inq_addrsperssn_count12 < 3.799592, 8.000000, 8.000000);

modinq_size_90_c3685 := if(nf_inquiry_ssn_vel_risk_index < 1.539596, modinq_size_90_c3686, modinq_size_90_c3687);

modinq_size_90_c3684 := if(nf_inq_perssn_count12 < 23.363621, modinq_size_90_c3685, 6.000000);

modinq_size_90_c3688 := if(nf_inq_count < 8.765370, 6.000000, 6.000000);

modinq_size_90_c3683 := if(nf_inq_peradl_count_week < 0.497717, modinq_size_90_c3684, modinq_size_90_c3688);

modinq_size_90_c3672 := if(rv_i60_inq_mortgage_recency < 81.958122, modinq_size_90_c3673, modinq_size_90_c3683);

modinq_size_90_c3671 := if(nf_invbest_inq_lastperaddr_diff < -4.849307, 3.000000, modinq_size_90_c3672);

modinq_size_90_c3693 := if(nf_inq_communications_count < 0.192368, 7.000000, 7.000000);

modinq_size_90_c3695 := if(nf_inq_bestdob_ver_count < 1.075654, 8.000000, 9.000000);

modinq_size_90_c3694 := if(rv_i62_inq_ssnsperadl_recency < 4.212842, modinq_size_90_c3695, 7.000000);

modinq_size_90_c3692 := if(nf_inq_adls_per_sfd_addr < 0.001685, modinq_size_90_c3693, modinq_size_90_c3694);

modinq_size_90_c3698 := if(rv_i60_inq_count12 < 8.628548, 8.000000, 8.000000);

modinq_size_90_c3697 := if(nf_inq_per_ssn < 0.036384, 7.000000, modinq_size_90_c3698);

modinq_size_90_c3696 := if(nf_inq_curraddr_ver_count < 3.858697, 6.000000, modinq_size_90_c3697);

modinq_size_90_c3691 := if(rv_i60_credit_seeking < 0.263593, modinq_size_90_c3692, modinq_size_90_c3696);

modinq_size_90_c3699 := if(nf_invbest_inq_dobsperssn_diff < -0.425012, 5.000000, 5.000000);

modinq_size_90_c3690 := if(nf_invbest_inq_lastperaddr_diff < -0.039667, modinq_size_90_c3691, modinq_size_90_c3699);

modinq_size_90_c3704 := if(nf_inq_mortgage_count24 < 0.782785, 8.000000, 8.000000);

modinq_size_90_c3703 := if(rv_i60_inq_retail_count12 < 1.280284, modinq_size_90_c3704, 7.000000);

modinq_size_90_c3705 := if(rv_i62_inq_phonesperadl_recency < 10.252987, 7.000000, 7.000000);

modinq_size_90_c3702 := if(nf_inq_perssn_recency < 5.120467, modinq_size_90_c3703, modinq_size_90_c3705);

modinq_size_90_c3706 := if(rv_i60_inq_mortgage_recency < 14.161839, 6.000000, 6.000000);

modinq_size_90_c3701 := if(nf_inq_ssnspercurraddr_count12 < 1.018264, modinq_size_90_c3702, modinq_size_90_c3706);

modinq_size_90_c3707 := if(rv_i61_inq_collection_recency < 92.983755, 5.000000, 5.000000);

modinq_size_90_c3700 := if(rv_i60_inq_retail_recency < 20.237490, modinq_size_90_c3701, modinq_size_90_c3707);

modinq_size_90_c3689 := if(nf_inq_dobsperssn_count12 < 0.708470, modinq_size_90_c3690, modinq_size_90_c3700);

modinq_size_90_c3670 := if(nf_inq_retail_count24 < 0.082295, modinq_size_90_c3671, modinq_size_90_c3689);

//modinq_size_90 := if(nf_inq_peradl_count_week < -4404497384.393013, modinq_size_90_c3663, modinq_size_90_c3670);
modinq_size_90 := if(nf_inq_peradl_count_week < -999999998, modinq_size_90_c3663, modinq_size_90_c3670);

modinq_size_91_c3715 := if(nf_inquiry_addr_vel_risk_indexv2 < 2.135338, 17.562414, 11.748880);

modinq_size_91_c3714 := if(nf_inq_dobsperadl_count_day < 0.607505, modinq_size_91_c3715, 7.000000);

modinq_size_91_c3717 := if(nf_inquiry_verification_index < 30.725262, 10.706640, 14.021342);

modinq_size_91_c3716 := if(nf_inq_addrsperssn_count_week < 0.299563, modinq_size_91_c3717, 7.000000);

modinq_size_91_c3713 := if(rv_i60_inq_other_recency < 31.019974, modinq_size_91_c3714, modinq_size_91_c3716);

modinq_size_91_c3720 := if(nf_inq_per_sfd_addr < -0.510278, 8.000000, 9.207392);

modinq_size_91_c3719 := if(nf_inq_adlsperbestssn_count12 < 1.026034, modinq_size_91_c3720, 7.000000);

modinq_size_91_c3718 := if(nf_inq_lnames_per_addr < 0.898875, modinq_size_91_c3719, 6.000000);

modinq_size_91_c3712 := if(rv_i60_inq_prepaidcards_recency < 86.569625, modinq_size_91_c3713, modinq_size_91_c3718);

modinq_size_91_c3724 := if(nf_inq_other_count_week < 0.782195, 8.000000, 8.000000);

modinq_size_91_c3723 := if(nf_inq_dobsperadl_count_week < 0.114476, modinq_size_91_c3724, 7.000000);

modinq_size_91_c3722 := if(rv_i62_inq_ssns_per_adl < 1.328993, modinq_size_91_c3723, 6.000000);

modinq_size_91_c3721 := if(rv_i60_inq_peradl_recency < 2.453250, modinq_size_91_c3722, 5.000000);

modinq_size_91_c3711 := if(nf_inq_peraddr_count_day < 0.271754, modinq_size_91_c3712, modinq_size_91_c3721);

modinq_size_91_c3727 := if(nf_invbest_inq_peraddr_diff < -12.133351, 6.000000, 6.000000);

modinq_size_91_c3726 := if(nf_invbest_inq_lastperaddr_diff < -1.510477, modinq_size_91_c3727, 5.000000);

modinq_size_91_c3725 := if(rv_i62_inq_phones_per_adl < 1.932842, modinq_size_91_c3726, 4.000000);

modinq_size_91_c3710 := if(nf_inq_addrsperbestssn_count12 < 2.707945, modinq_size_91_c3711, modinq_size_91_c3725);

modinq_size_91_c3709 := if(nf_inq_highriskcredit_count < 37.125700, modinq_size_91_c3710, 2.000000);

modinq_size_91_c3732 := if(rv_i62_inq_fnamesperadl_recency < 7.839903, 6.000000, 6.000000);

modinq_size_91_c3733 := if(rv_i62_inq_dobsperadl_recency < 1.245560, 6.000000, 6.000000);

modinq_size_91_c3731 := if(nf_inq_lname_ver_count < 2.966040, modinq_size_91_c3732, modinq_size_91_c3733);

modinq_size_91_c3730 := if(nf_inq_fname_ver_count < 9.959373, modinq_size_91_c3731, 4.000000);

modinq_size_91_c3735 := if(nf_inq_lnamesperaddr_count12 < 0.434046, 5.000000, 5.000000);

modinq_size_91_c3734 := if(nf_inq_banking_count < 0.134681, modinq_size_91_c3735, 4.000000);

modinq_size_91_c3729 := if(rv_i60_inq_other_recency < 2.861787, modinq_size_91_c3730, modinq_size_91_c3734);

modinq_size_91_c3728 := if(nf_inq_lnamesperaddr_count_week < 0.659749, modinq_size_91_c3729, 2.000000);

modinq_size_91 := if(rv_i60_inq_mortgage_count12 < 0.226628, modinq_size_91_c3709, modinq_size_91_c3728);

modinq_size_92_c3743 := if(nf_inq_fnamesperadl_count_day < 0.479896, 16.826932, 9.000000);

modinq_size_92_c3744 := if(nf_inq_banking_count_week < 0.956600, 16.240907, 8.000000);

modinq_size_92_c3742 := if(nf_inq_ssnsperaddr_count12 < 0.450628, modinq_size_92_c3743, modinq_size_92_c3744);

modinq_size_92_c3741 := if(nf_inq_banking_count24 < 31.831174, modinq_size_92_c3742, 6.000000);

modinq_size_92_c3747 := if(nf_inq_banking_count24 < 0.912537, 8.000000, 8.000000);

modinq_size_92_c3748 := if(rv_i60_inq_prepaidcards_recency < 61.082444, 8.000000, 8.000000);

modinq_size_92_c3746 := if(nf_inq_bestdob_ver_count < 2.404436, modinq_size_92_c3747, modinq_size_92_c3748);

modinq_size_92_c3750 := if(nf_inq_bestfname_ver_count < 8.801371, 8.000000, 8.000000);

modinq_size_92_c3749 := if(nf_inq_adlspercurraddr_count12 < 1.011348, modinq_size_92_c3750, 7.000000);

modinq_size_92_c3745 := if(rv_i62_inq_num_names_per_adl < 0.420574, modinq_size_92_c3746, modinq_size_92_c3749);

modinq_size_92_c3740 := if(nf_inq_ssns_per_apt_addr < 0.417184, modinq_size_92_c3741, modinq_size_92_c3745);

modinq_size_92_c3739 := if(rv_i60_inq_other_count12 < 8.241115, modinq_size_92_c3740, 4.000000);

modinq_size_92_c3753 := if(nf_inquiry_verification_index < 23.526268, 6.000000, 6.000000);

modinq_size_92_c3756 := if(nf_inq_fname_ver_count < 235.012167, 8.000000, 11.535537);

modinq_size_92_c3755 := if(nf_inq_adlspercurraddr_count12 < 0.457077, modinq_size_92_c3756, 7.000000);

modinq_size_92_c3754 := if(nf_inq_per_ssn < 0.138162, modinq_size_92_c3755, 6.000000);

modinq_size_92_c3752 := if(nf_inq_bestssn_ver_count < 202.915025, modinq_size_92_c3753, modinq_size_92_c3754);

modinq_size_92_c3751 := if(nf_inq_other_count < 0.829214, modinq_size_92_c3752, 4.000000);

modinq_size_92_c3738 := if(nf_inq_addr_ver_count < 48.895542, modinq_size_92_c3739, modinq_size_92_c3751);

modinq_size_92_c3758 := if(rv_i60_inq_count12 < 3.712414, 4.000000, 4.000000);

modinq_size_92_c3757 := if(nf_inq_mortgage_count < 0.275484, modinq_size_92_c3758, 3.000000);

modinq_size_92_c3737 := if(nf_invbest_inq_adlsperssn_diff < -0.780636, modinq_size_92_c3738, modinq_size_92_c3757);

modinq_size_92_c3760 := if(nf_inq_lnamespercurraddr_count12 < 1.983562, 3.000000, 3.000000);

modinq_size_92_c3763 := if(rv_i60_inq_comm_recency < 83.649919, 5.000000, 5.000000);

modinq_size_92_c3762 := if(nf_inq_per_apt_addr < 5.921314, 4.000000, modinq_size_92_c3763);

modinq_size_92_c3761 := if(rv_i62_inq_ssnsperadl_count12 < 1.199818, modinq_size_92_c3762, 3.000000);

modinq_size_92_c3759 := if(rv_i62_inq_lnamesperadl_count12 < 0.781362, modinq_size_92_c3760, modinq_size_92_c3761);

modinq_size_92 := if(nf_inq_per_apt_addr < 4.201926, modinq_size_92_c3737, modinq_size_92_c3759);

modinq_size_93_c3771 := if(nf_inq_lnamesperssn_recency < 5.303979, 16.950055, 10.706640);

modinq_size_93_c3770 := if(nf_inq_banking_count < 10.975687, modinq_size_93_c3771, 7.000000);

modinq_size_93_c3773 := if(nf_inq_per_sfd_addr < 1.753999, 8.000000, 8.000000);

modinq_size_93_c3772 := if(nf_inq_banking_count < 0.440728, 7.000000, modinq_size_93_c3773);

modinq_size_93_c3769 := if(nf_inq_addrsperssn_recency < 3.935774, modinq_size_93_c3770, modinq_size_93_c3772);

modinq_size_93_c3768 := if(nf_inq_perssn_count_week < 0.429277, modinq_size_93_c3769, 5.000000);

modinq_size_93_c3775 := if(rv_i60_inq_other_count12 < 0.946536, 6.000000, 6.000000);

modinq_size_93_c3776 := if(nf_inq_count < 10.952880, 6.000000, 6.000000);

modinq_size_93_c3774 := if(nf_inq_adls_per_sfd_addr < 0.776581, modinq_size_93_c3775, modinq_size_93_c3776);

modinq_size_93_c3767 := if(rv_i60_inq_peradl_count12 < 2.640033, modinq_size_93_c3768, modinq_size_93_c3774);

modinq_size_93_c3777 := if(nf_inq_peradl_count_day < 0.618941, 4.000000, 4.000000);

modinq_size_93_c3766 := if(nf_inq_fnamesperadl_count_week < 0.762166, modinq_size_93_c3767, modinq_size_93_c3777);

modinq_size_93_c3783 := if(nf_inq_ssnsperadl_count_week < 0.284037, 13.508753, 9.207392);

modinq_size_93_c3784 := if(nf_inquiry_adl_vel_risk_index < 0.085302, 12.565879, 8.000000);

modinq_size_93_c3782 := if(nf_inq_adlsperaddr_recency < 10.255409, modinq_size_93_c3783, modinq_size_93_c3784);

modinq_size_93_c3785 := if(rv_i60_inq_auto_recency < 0.650144, 7.000000, 7.000000);

modinq_size_93_c3781 := if(nf_inq_ssnsperaddr_count_week < 0.992664, modinq_size_93_c3782, modinq_size_93_c3785);

modinq_size_93_c3787 := if(rv_i62_inq_dobs_per_adl < 1.496288, 7.000000, 7.000000);

modinq_size_93_c3788 := if(rv_i62_inq_ssnsperadl_count12 < 1.244144, 7.000000, 7.000000);

modinq_size_93_c3786 := if(nf_inq_collection_count < 5.185981, modinq_size_93_c3787, modinq_size_93_c3788);

modinq_size_93_c3780 := if(rv_i60_inq_banking_count12 < 1.724913, modinq_size_93_c3781, modinq_size_93_c3786);

modinq_size_93_c3779 := if(nf_inq_dobsperssn_count12 < 1.717821, modinq_size_93_c3780, 4.000000);

modinq_size_93_c3790 := if(rv_i62_inq_ssnsperadl_recency < 6.228986, 5.000000, 5.000000);

modinq_size_93_c3789 := if(nf_inq_count24 < 8.237987, modinq_size_93_c3790, 4.000000);

modinq_size_93_c3778 := if(nf_inq_lnamesperbestssn_count12 < 1.673002, modinq_size_93_c3779, modinq_size_93_c3789);

modinq_size_93_c3765 := if(rv_i62_inq_dobs_per_adl < 0.989922, modinq_size_93_c3766, modinq_size_93_c3778);

modinq_size_93_c3797 := if(nf_invbest_inq_adlsperaddr_diff < 0.520000, 12.817256, 8.000000);

modinq_size_93_c3798 := if(rv_i62_inq_lnamesperadl_recency < 9.601465, 9.207392, 9.207392);

modinq_size_93_c3796 := if(rv_i60_inq_count12 < 3.762057, modinq_size_93_c3797, modinq_size_93_c3798);

modinq_size_93_c3795 := if(nf_inq_peradl_count_week < 0.458417, modinq_size_93_c3796, 6.000000);

modinq_size_93_c3800 := if(nf_inq_peradl_count_week < 1.136506, 7.000000, 7.000000);

modinq_size_93_c3799 := if(nf_inq_count_day < 0.725024, modinq_size_93_c3800, 6.000000);

modinq_size_93_c3794 := if(nf_inq_count < 24.590752, modinq_size_93_c3795, modinq_size_93_c3799);

modinq_size_93_c3793 := if(rv_i60_inq_util_recency < 2.309564, modinq_size_93_c3794, 4.000000);

modinq_size_93_c3803 := if(rv_i60_inq_peradl_recency < 2.006568, 6.000000, 6.000000);

modinq_size_93_c3804 := if(nf_inq_bestfname_ver_count < 20.444637, 6.000000, 6.000000);

modinq_size_93_c3802 := if(nf_inq_other_count < 3.369676, modinq_size_93_c3803, modinq_size_93_c3804);

modinq_size_93_c3806 := if(rv_i60_inq_hiriskcred_count12 < 0.638352, 6.000000, 6.000000);

modinq_size_93_c3805 := if(nf_inq_per_addr < 4.063907, 5.000000, modinq_size_93_c3806);

modinq_size_93_c3801 := if(nf_inq_peraddr_count12 < 3.948812, modinq_size_93_c3802, modinq_size_93_c3805);

modinq_size_93_c3792 := if(nf_inq_retail_count < 0.295900, modinq_size_93_c3793, modinq_size_93_c3801);

modinq_size_93_c3810 := if(nf_inq_peraddr_count12 < 4.887947, 6.000000, 6.000000);

modinq_size_93_c3813 := if(nf_inq_ssnsperaddr_recency < 4.767040, 8.000000, 8.000000);

modinq_size_93_c3812 := if(nf_inq_per_addr < 5.823856, modinq_size_93_c3813, 7.000000);

modinq_size_93_c3814 := if(nf_inq_lnamespercurraddr_count12 < 2.550206, 7.000000, 7.000000);

modinq_size_93_c3811 := if(nf_inq_lname_ver_count < 5.256760, modinq_size_93_c3812, modinq_size_93_c3814);

modinq_size_93_c3809 := if(nf_inq_lname_ver_count < 1.331119, modinq_size_93_c3810, modinq_size_93_c3811);

modinq_size_93_c3816 := if(nf_inq_lnamesperaddr_count12 < 0.859136, 6.000000, 6.000000);

modinq_size_93_c3819 := if(nf_inq_collection_count24 < 0.422823, 9.000000, 8.000000);

modinq_size_93_c3818 := if(nf_inq_adlsperaddr_recency < 7.719811, modinq_size_93_c3819, 7.000000);

modinq_size_93_c3817 := if(rv_i60_inq_recency < 12.409104, modinq_size_93_c3818, 6.000000);

modinq_size_93_c3815 := if(nf_inq_bestdob_ver_count < 5.347753, modinq_size_93_c3816, modinq_size_93_c3817);

modinq_size_93_c3808 := if(nf_inq_adlsperssn_recency < 1.331316, modinq_size_93_c3809, modinq_size_93_c3815);

modinq_size_93_c3820 := if(rv_i61_inq_collection_recency < 33.701282, 4.000000, 4.000000);

modinq_size_93_c3807 := if(nf_inq_lnamesperssn_count_week < 0.242760, modinq_size_93_c3808, modinq_size_93_c3820);

modinq_size_93_c3791 := if(nf_inq_adlspercurraddr_count12 < 2.244413, modinq_size_93_c3792, modinq_size_93_c3807);

modinq_size_93 := if(nf_inq_adlspercurraddr_count12 < 1.783011, modinq_size_93_c3765, modinq_size_93_c3791);

modinq_size_94_c3828 := if(nf_inq_peradl_count_week < 0.433458, 16.794929, 9.851656);

modinq_size_94_c3829 := if(rv_i62_inq_ssnsperadl_recency < 4.523360, 13.241134, 9.851656);

modinq_size_94_c3827 := if(nf_inq_ssnsperaddr_recency < 5.710548, modinq_size_94_c3828, modinq_size_94_c3829);

modinq_size_94_c3831 := if(nf_inq_lnames_per_ssn < 1.843989, 11.941420, 8.000000);

modinq_size_94_c3832 := if(nf_inq_peraddr_recency < 0.485274, 8.000000, 8.000000);

modinq_size_94_c3830 := if(nf_inq_collection_count24 < 1.589424, modinq_size_94_c3831, modinq_size_94_c3832);

modinq_size_94_c3826 := if(nf_inq_banking_count < 2.978952, modinq_size_94_c3827, modinq_size_94_c3830);

modinq_size_94_c3835 := if(nf_inq_peraddr_recency < 0.207927, 8.000000, 10.327020);

modinq_size_94_c3834 := if(nf_inq_ssns_per_apt_addr < 0.965076, modinq_size_94_c3835, 7.000000);

modinq_size_94_c3837 := if(nf_inq_lnamesperssn_count12 < 0.944013, 8.000000, 13.817534);

modinq_size_94_c3836 := if(nf_inq_bestlname_ver_count < 102.247304, modinq_size_94_c3837, 7.000000);

modinq_size_94_c3833 := if(nf_inq_bestssn_ver_count < 4.038656, modinq_size_94_c3834, modinq_size_94_c3836);

modinq_size_94_c3825 := if(nf_inq_dobsperbestssn_count12 < 0.599836, modinq_size_94_c3826, modinq_size_94_c3833);

modinq_size_94_c3841 := if(nf_inq_count < 1.542278, 8.000000, 8.000000);

modinq_size_94_c3840 := if(nf_inq_per_addr < 2.489712, modinq_size_94_c3841, 7.000000);

modinq_size_94_c3839 := if(nf_inq_fnamesperadl_count_week < 0.129217, 6.000000, modinq_size_94_c3840);

modinq_size_94_c3842 := if(nf_inq_peraddr_count12 < 5.815188, 6.000000, 6.000000);

modinq_size_94_c3838 := if(nf_inq_addrsperadl_count_day < 0.762659, modinq_size_94_c3839, modinq_size_94_c3842);

modinq_size_94_c3824 := if(nf_inq_phonesperadl_count_week < 0.661268, modinq_size_94_c3825, modinq_size_94_c3838);

modinq_size_94_c3844 := if(nf_inq_bestlname_ver_count < 22.750895, 5.000000, 5.000000);

modinq_size_94_c3843 := if(nf_inq_adlspercurraddr_count12 < 2.232036, modinq_size_94_c3844, 4.000000);

modinq_size_94_c3823 := if(nf_inq_dobsperssn_count12 < 1.396213, modinq_size_94_c3824, modinq_size_94_c3843);

modinq_size_94_c3850 := if(nf_invbest_inq_peraddr_diff < -1.113984, 8.000000, 10.327020);

modinq_size_94_c3849 := if(rv_i61_inq_collection_recency < 31.700484, modinq_size_94_c3850, 7.000000);

modinq_size_94_c3848 := if(nf_inq_adls_per_sfd_addr < -0.564182, 6.000000, modinq_size_94_c3849);

modinq_size_94_c3852 := if(rv_i60_inq_peradl_count12 < 1.634300, 7.000000, 7.000000);

modinq_size_94_c3851 := if(nf_inq_ssn_ver_count < 8.419651, modinq_size_94_c3852, 6.000000);

modinq_size_94_c3847 := if(nf_inq_perssn_count12 < 0.092800, modinq_size_94_c3848, modinq_size_94_c3851);

modinq_size_94_c3855 := if(nf_inq_collection_count < 0.456543, 7.000000, 7.000000);

modinq_size_94_c3857 := if(nf_inq_fname_ver_count < 10.973402, 9.851656, 11.023665);

modinq_size_94_c3856 := if(nf_inquiry_addr_vel_risk_index < 4.514398, modinq_size_94_c3857, 7.000000);

modinq_size_94_c3854 := if(rv_i60_inq_peradl_recency < 10.070731, modinq_size_94_c3855, modinq_size_94_c3856);

modinq_size_94_c3860 := if(nf_inq_bestlname_ver_count < 41.602732, 8.000000, 8.000000);

modinq_size_94_c3861 := if(nf_inq_lnamespercurraddr_count12 < 0.652897, 8.000000, 9.000000);

modinq_size_94_c3859 := if(nf_inq_addrsperbestssn_count12 < 1.608608, modinq_size_94_c3860, modinq_size_94_c3861);

modinq_size_94_c3858 := if(nf_inquiry_adl_vel_risk_index < 1.930354, modinq_size_94_c3859, 6.000000);

modinq_size_94_c3853 := if(nf_inq_dob_ver_count < 16.121749, modinq_size_94_c3854, modinq_size_94_c3858);

modinq_size_94_c3846 := if(nf_inq_addrsperssn_recency < 5.834210, modinq_size_94_c3847, modinq_size_94_c3853);

modinq_size_94_c3866 := if(nf_inq_addr_ver_count < 3.141000, 9.000000, 8.000000);

modinq_size_94_c3865 := if(nf_inq_banking_count24 < 0.778091, 7.000000, modinq_size_94_c3866);

modinq_size_94_c3864 := if(nf_inq_collection_count24 < 0.574073, modinq_size_94_c3865, 6.000000);

modinq_size_94_c3867 := if(nf_inq_dob_ver_count < 17.149666, 6.000000, 6.000000);

modinq_size_94_c3863 := if(rv_i60_inq_hiriskcred_count12 < 0.799610, modinq_size_94_c3864, modinq_size_94_c3867);

modinq_size_94_c3862 := if(nf_inq_adlspercurraddr_count12 < 0.161853, 4.000000, modinq_size_94_c3863);

modinq_size_94_c3845 := if(rv_i60_inq_retail_recency < 94.396980, modinq_size_94_c3846, modinq_size_94_c3862);

modinq_size_94_c3822 := if(rv_i62_inq_addrsperadl_recency < 7.085372, modinq_size_94_c3823, modinq_size_94_c3845);

modinq_size_94_c3870 := if(nf_inq_communications_count < 2.120354, 4.000000, 4.000000);

modinq_size_94_c3869 := if(nf_inquiry_addr_vel_risk_index < 3.837640, modinq_size_94_c3870, 3.000000);

modinq_size_94_c3868 := if(nf_inq_bestssn_ver_count < 1.545482, 2.000000, modinq_size_94_c3869);

modinq_size_94 := if(nf_inq_dobsperssn_count_day < 0.536866, modinq_size_94_c3822, modinq_size_94_c3868);

modinq_size_95_c3878 := if(rv_i60_inq_banking_recency < 64.882514, 15.502967, 14.146509);

modinq_size_95_c3877 := if(nf_inq_banking_count_week < 0.854258, modinq_size_95_c3878, 7.000000);

modinq_size_95_c3876 := if(nf_inq_other_count_week < 0.054017, modinq_size_95_c3877, 6.000000);

modinq_size_95_c3879 := if(nf_inq_banking_count < 0.499640, 6.000000, 6.000000);

modinq_size_95_c3875 := if(nf_inq_lnames_per_apt_addr < 0.436014, modinq_size_95_c3876, modinq_size_95_c3879);

modinq_size_95_c3883 := if(nf_inq_per_ssn < 1.058521, 11.296252, 8.000000);

modinq_size_95_c3884 := if(nf_invbest_inq_lastperaddr_diff < 1.574874, 8.000000, 8.000000);

modinq_size_95_c3882 := if(nf_inq_ssns_per_addr < 1.414786, modinq_size_95_c3883, modinq_size_95_c3884);

modinq_size_95_c3886 := if(nf_inq_perbestphone_count12 < 1.013304, 8.000000, 8.000000);

modinq_size_95_c3887 := if(nf_inq_peraddr_count12 < 3.446421, 8.000000, 8.000000);

modinq_size_95_c3885 := if(nf_inq_adlsperaddr_count12 < 1.612606, modinq_size_95_c3886, modinq_size_95_c3887);

modinq_size_95_c3881 := if(nf_inq_lnamesperaddr_recency < 7.334122, modinq_size_95_c3882, modinq_size_95_c3885);

modinq_size_95_c3880 := if(nf_invbest_inq_adlsperssn_diff < -0.053001, modinq_size_95_c3881, 5.000000);

modinq_size_95_c3874 := if(nf_inq_bestlname_ver_count < 190.268111, modinq_size_95_c3875, modinq_size_95_c3880);

modinq_size_95_c3892 := if(nf_inq_dobs_per_ssn < 0.624542, 8.000000, 10.327020);

modinq_size_95_c3891 := if(rv_i60_inq_recency < 8.251924, modinq_size_95_c3892, 7.000000);

modinq_size_95_c3890 := if(nf_inq_per_ssn < 7.459453, modinq_size_95_c3891, 6.000000);

modinq_size_95_c3893 := if(nf_inq_bestssn_ver_count < 2.839247, 6.000000, 6.000000);

modinq_size_95_c3889 := if(nf_inq_adlsperaddr_count_week < 0.048314, modinq_size_95_c3890, modinq_size_95_c3893);

modinq_size_95_c3897 := if(nf_inq_auto_count < 4.661197, 11.296252, 9.851656);

modinq_size_95_c3896 := if(nf_inq_per_apt_addr < 3.584907, modinq_size_95_c3897, 7.000000);

modinq_size_95_c3895 := if(rv_i60_inq_retpymt_count12 < 1.305907, modinq_size_95_c3896, 6.000000);

modinq_size_95_c3894 := if(nf_inq_fnamesperadl_count_day < 0.374087, modinq_size_95_c3895, 5.000000);

modinq_size_95_c3888 := if(nf_inq_bestdob_ver_count < 5.749370, modinq_size_95_c3889, modinq_size_95_c3894);

modinq_size_95_c3873 := if(rv_i60_inq_count12 < 2.803116, modinq_size_95_c3874, modinq_size_95_c3888);

modinq_size_95_c3903 := if(nf_inq_adls_per_ssn < 0.051193, 14.531555, 11.296252);

modinq_size_95_c3904 := if(nf_inq_ssnsperaddr_recency < 1.229112, 9.207392, 11.535537);

modinq_size_95_c3902 := if(nf_inq_dobsperssn_recency < 10.989091, modinq_size_95_c3903, modinq_size_95_c3904);

modinq_size_95_c3906 := if(nf_invbest_inq_lastperaddr_diff < -0.687480, 13.143309, 9.851656);

modinq_size_95_c3907 := if(nf_inq_auto_count < 3.289586, 8.000000, 8.000000);

modinq_size_95_c3905 := if(nf_inq_count_week < 1.336470, modinq_size_95_c3906, modinq_size_95_c3907);

modinq_size_95_c3901 := if(nf_inq_other_count < 1.130798, modinq_size_95_c3902, modinq_size_95_c3905);

modinq_size_95_c3910 := if(nf_inq_lnamespercurraddr_count12 < 0.978037, 11.535537, 8.000000);

modinq_size_95_c3911 := if(nf_inq_lnamespercurraddr_count12 < 0.297065, 8.000000, 8.000000);

modinq_size_95_c3909 := if(nf_inq_peraddr_count12 < 1.838395, modinq_size_95_c3910, modinq_size_95_c3911);

modinq_size_95_c3913 := if(nf_inq_per_ssn < 9.108942, 9.851656, 8.000000);

modinq_size_95_c3914 := if(rv_i60_inq_banking_count12 < 0.649251, 9.000000, 8.000000);

modinq_size_95_c3912 := if(rv_i62_inq_phones_per_adl < 0.181097, modinq_size_95_c3913, modinq_size_95_c3914);

modinq_size_95_c3908 := if(nf_inq_banking_count < 0.335233, modinq_size_95_c3909, modinq_size_95_c3912);

modinq_size_95_c3900 := if(rv_i60_inq_auto_recency < 87.135841, modinq_size_95_c3901, modinq_size_95_c3908);

modinq_size_95_c3915 := if(nf_inq_addrsperssn_count12 < 1.045030, 5.000000, 5.000000);

modinq_size_95_c3899 := if(nf_inq_addrsperssn_count_day < 0.680657, modinq_size_95_c3900, modinq_size_95_c3915);

modinq_size_95_c3918 := if(nf_inq_ssn_ver_count < 12.684802, 6.000000, 6.000000);

modinq_size_95_c3917 := if(nf_inq_addrs_per_ssn < 1.053289, 5.000000, modinq_size_95_c3918);

modinq_size_95_c3916 := if(nf_inq_bestdob_ver_count < 10.848212, 4.000000, modinq_size_95_c3917);

modinq_size_95_c3898 := if(nf_inquiry_ssn_vel_risk_index < 5.206341, modinq_size_95_c3899, modinq_size_95_c3916);

modinq_size_95_c3872 := if(rv_i61_inq_collection_recency < 19.364526, modinq_size_95_c3873, modinq_size_95_c3898);

//modinq_size_95 := if(nf_inq_prepaidcards_count24 < -2030292452.709990, 1.000000, modinq_size_95_c3872);
modinq_size_95 := if(nf_inq_prepaidcards_count24 < -999999998, 1.000000, modinq_size_95_c3872);

modinq_size_96_c3926 := if(nf_inq_lnames_per_sfd_addr < -0.858239, 8.000000, 9.000000);

modinq_size_96_c3925 := if(nf_inq_percurraddr_count12 < 3.324716, 7.000000, modinq_size_96_c3926);

modinq_size_96_c3924 := if(nf_inq_perbestssn_count12 < 0.869452, modinq_size_96_c3925, 6.000000);

modinq_size_96_c3923 := if(nf_inq_dobsperssn_recency < 2.650836, modinq_size_96_c3924, 5.000000);

modinq_size_96_c3922 := if(rv_i60_inq_banking_recency < 77.735867, modinq_size_96_c3923, 4.000000);

modinq_size_96_c3930 := if(nf_inq_auto_count < 1.861885, 7.000000, 7.000000);

modinq_size_96_c3929 := if(rv_i60_inq_comm_recency < 2.315088, modinq_size_96_c3930, 6.000000);

modinq_size_96_c3928 := if(nf_inq_ssnspercurraddr_count12 < 1.120525, 5.000000, modinq_size_96_c3929);

modinq_size_96_c3927 := if(nf_inq_banking_count < 6.195906, modinq_size_96_c3928, 4.000000);

modinq_size_96_c3921 := if(rv_i60_inq_other_count12 < 0.266410, modinq_size_96_c3922, modinq_size_96_c3927);

modinq_size_96_c3936 := if(nf_invbest_inq_adlsperaddr_diff < 0.314978, 17.780819, 11.535537);

modinq_size_96_c3937 := if(nf_inq_other_count < 1.084766, 8.000000, 8.000000);

modinq_size_96_c3935 := if(nf_inq_prepaidcards_count < 2.974581, modinq_size_96_c3936, modinq_size_96_c3937);

modinq_size_96_c3938 := if(nf_inq_peraddr_count12 < 12.249866, 7.000000, 7.000000);

modinq_size_96_c3934 := if(nf_inq_per_sfd_addr < 10.051014, modinq_size_96_c3935, modinq_size_96_c3938);

modinq_size_96_c3941 := if(rv_i61_inq_collection_count12 < 0.757015, 8.000000, 8.000000);

modinq_size_96_c3940 := if(nf_inq_bestssn_ver_count < 14.842192, modinq_size_96_c3941, 7.000000);

modinq_size_96_c3942 := if(nf_inq_ssn_ver_count < 10.826456, 7.000000, 7.000000);

modinq_size_96_c3939 := if(nf_inq_lnamesperaddr_recency < 10.382077, modinq_size_96_c3940, modinq_size_96_c3942);

modinq_size_96_c3933 := if(nf_inq_adls_per_sfd_addr < 2.260275, modinq_size_96_c3934, modinq_size_96_c3939);

modinq_size_96_c3946 := if(rv_i62_inq_ssnsperadl_count12 < 0.759927, 8.000000, 9.851656);

modinq_size_96_c3945 := if(nf_inq_adlsperaddr_count12 < 3.528352, modinq_size_96_c3946, 7.000000);

modinq_size_96_c3947 := if(nf_inq_perbestssn_count12 < 15.614485, 7.000000, 7.000000);

modinq_size_96_c3944 := if(nf_inq_per_addr < 11.168417, modinq_size_96_c3945, modinq_size_96_c3947);

modinq_size_96_c3943 := if(nf_inq_bestssn_ver_count < 95.970679, modinq_size_96_c3944, 5.000000);

modinq_size_96_c3932 := if(nf_inq_lnames_per_sfd_addr < 2.918597, modinq_size_96_c3933, modinq_size_96_c3943);

modinq_size_96_c3952 := if(nf_inq_addrsperssn_count12 < 1.447919, 9.851656, 9.000000);

modinq_size_96_c3951 := if(nf_inq_ssns_per_addr < 0.770611, 7.000000, modinq_size_96_c3952);

modinq_size_96_c3950 := if(nf_inq_bestssn_ver_count < 11.087767, modinq_size_96_c3951, 6.000000);

modinq_size_96_c3953 := if(nf_inq_phonesperadl_count_week < 0.259519, 6.000000, 6.000000);

modinq_size_96_c3949 := if(nf_inq_collection_count < 12.266674, modinq_size_96_c3950, modinq_size_96_c3953);

modinq_size_96_c3955 := if(nf_inq_peraddr_count_week < 8.460897, 6.000000, 6.000000);

modinq_size_96_c3954 := if(nf_inq_lnamesperaddr_recency < 1.281704, modinq_size_96_c3955, 5.000000);

modinq_size_96_c3948 := if(nf_inq_dobsperbestssn_count12 < 1.207527, modinq_size_96_c3949, modinq_size_96_c3954);

modinq_size_96_c3931 := if(nf_inq_dobsperadl_count_week < 0.648418, modinq_size_96_c3932, modinq_size_96_c3948);

modinq_size_96_c3920 := if(nf_invbest_inq_peraddr_diff < -1.072940, modinq_size_96_c3921, modinq_size_96_c3931);

//modinq_size_96 := if(nf_inq_adlsperssn_count_day < -4527209379.175919, 1.000000, modinq_size_96_c3920);
modinq_size_96 := if(nf_inq_adlsperssn_count_day < -999999998, 1.000000, modinq_size_96_c3920);

modinq_size_97_c3957 := if(nf_inq_per_addr < 0.424598, 2.000000, 2.000000);

modinq_size_97_c3964 := if(nf_inq_addrsperadl_count_day < 0.416326, 16.964926, 9.851656);

modinq_size_97_c3963 := if(nf_inq_lnames_per_apt_addr < 4.445315, modinq_size_97_c3964, 7.000000);

modinq_size_97_c3966 := if(rv_i60_inq_retail_recency < 90.911741, 13.423473, 8.000000);

modinq_size_97_c3965 := if(rv_i60_inq_retpymt_recency < 57.432282, modinq_size_97_c3966, 7.000000);

modinq_size_97_c3962 := if(nf_inq_ssn_ver_count < 109.099646, modinq_size_97_c3963, modinq_size_97_c3965);

modinq_size_97_c3968 := if(nf_inq_adlsperaddr_count12 < 0.646001, 7.000000, 7.000000);

modinq_size_97_c3969 := if(rv_i60_inq_recency < 3.312079, 7.000000, 7.000000);

modinq_size_97_c3967 := if(nf_inq_auto_count < 6.995958, modinq_size_97_c3968, modinq_size_97_c3969);

modinq_size_97_c3961 := if(nf_inq_collection_count < 11.765357, modinq_size_97_c3962, modinq_size_97_c3967);

modinq_size_97_c3973 := if(nf_inq_communications_count24 < 0.778126, 15.132052, 10.327020);

modinq_size_97_c3972 := if(nf_inq_ssnsperaddr_count_week < 0.590007, modinq_size_97_c3973, 7.000000);

modinq_size_97_c3971 := if(nf_invbest_inq_perssn_diff < -1.276370, 6.000000, modinq_size_97_c3972);

modinq_size_97_c3970 := if(rv_i60_inq_other_count12 < 15.943446, modinq_size_97_c3971, 5.000000);

modinq_size_97_c3960 := if(rv_i60_inq_banking_recency < 85.255621, modinq_size_97_c3961, modinq_size_97_c3970);

modinq_size_97_c3978 := if(nf_inq_count < 17.300256, 9.851656, 9.207392);

modinq_size_97_c3979 := if(nf_inq_auto_count < 0.085099, 8.000000, 9.207392);

modinq_size_97_c3977 := if(nf_inq_adlsperaddr_recency < 5.191816, modinq_size_97_c3978, modinq_size_97_c3979);

modinq_size_97_c3980 := if(rv_i60_inq_hiriskcred_recency < 62.558815, 7.000000, 7.000000);

modinq_size_97_c3976 := if(rv_i60_inq_auto_count12 < 1.119752, modinq_size_97_c3977, modinq_size_97_c3980);

modinq_size_97_c3975 := if(nf_invbest_inq_ssnsperaddr_diff < -2.554967, 5.000000, modinq_size_97_c3976);

modinq_size_97_c3974 := if(nf_inq_retail_count24 < 3.081854, modinq_size_97_c3975, 4.000000);

modinq_size_97_c3959 := if(nf_inq_quizprovider_count < 2.757432, modinq_size_97_c3960, modinq_size_97_c3974);

modinq_size_97_c3985 := if(rv_i62_inq_dobsperadl_count12 < 1.922159, 7.000000, 7.000000);

modinq_size_97_c3984 := if(nf_inq_perssn_recency < 3.352384, modinq_size_97_c3985, 6.000000);

modinq_size_97_c3983 := if(nf_inq_dobsperssn_count12 < 0.378721, 5.000000, modinq_size_97_c3984);

modinq_size_97_c3987 := if(rv_i62_inq_ssnsperadl_count12 < 2.922136, 6.000000, 6.000000);

modinq_size_97_c3986 := if(nf_inq_addr_ver_count < 16.733816, modinq_size_97_c3987, 5.000000);

modinq_size_97_c3982 := if(nf_inquiry_ssn_vel_risk_index < 6.795526, modinq_size_97_c3983, modinq_size_97_c3986);

modinq_size_97_c3981 := if(nf_inq_adlsperaddr_count_week < 0.000192, modinq_size_97_c3982, 3.000000);

modinq_size_97_c3958 := if(nf_inq_perssn_count12 < 10.786355, modinq_size_97_c3959, modinq_size_97_c3981);

//modinq_size_97 := if(nf_inq_mortgage_count < -9306237810.480206, modinq_size_97_c3957, modinq_size_97_c3958);
modinq_size_97 := if(nf_inq_mortgage_count < -999999998, modinq_size_97_c3957, modinq_size_97_c3958);

modinq_size_98_c3995 := if(nf_inq_retailpayments_count24 < 0.647921, 17.266882, 11.296252);

modinq_size_98_c3994 := if(nf_inq_adlsperbestssn_count12 < 1.556262, modinq_size_98_c3995, 7.000000);

modinq_size_98_c3997 := if(nf_inq_auto_count_week < 0.832525, 12.427187, 8.000000);

modinq_size_98_c3998 := if(nf_inq_lname_ver_count < 8.918341, 8.000000, 9.851656);

modinq_size_98_c3996 := if(rv_i60_inq_auto_recency < 35.002394, modinq_size_98_c3997, modinq_size_98_c3998);

modinq_size_98_c3993 := if(nf_inq_perbestssn_count12 < 3.389444, modinq_size_98_c3994, modinq_size_98_c3996);

modinq_size_98_c3999 := if(nf_inq_ssn_ver_count < 9.221624, 6.000000, 6.000000);

modinq_size_98_c3992 := if(nf_inq_collection_count24 < 3.533198, modinq_size_98_c3993, modinq_size_98_c3999);

modinq_size_98_c4003 := if(nf_inq_adls_per_apt_addr < 1.766972, 13.334385, 8.000000);

modinq_size_98_c4004 := if(nf_inq_mortgage_count < 3.720553, 12.278091, 8.000000);

modinq_size_98_c4002 := if(nf_inq_perbestssn_count12 < 1.157905, modinq_size_98_c4003, modinq_size_98_c4004);

modinq_size_98_c4005 := if(rv_i60_inq_auto_recency < 1.039062, 7.000000, 7.000000);

modinq_size_98_c4001 := if(nf_inq_adlsperaddr_count12 < 2.580968, modinq_size_98_c4002, modinq_size_98_c4005);

modinq_size_98_c4006 := if(nf_inq_bestdob_ver_count < 27.058628, 6.000000, 6.000000);

modinq_size_98_c4000 := if(nf_inq_count < 32.486048, modinq_size_98_c4001, modinq_size_98_c4006);

modinq_size_98_c3991 := if(nf_inq_ssnsperaddr_recency < 7.884011, modinq_size_98_c3992, modinq_size_98_c4000);

modinq_size_98_c4011 := if(nf_invbest_inq_lastperaddr_diff < 0.083117, 8.000000, 8.000000);

modinq_size_98_c4010 := if(nf_inq_quizprovider_count < 0.278330, modinq_size_98_c4011, 7.000000);

modinq_size_98_c4012 := if(rv_i60_inq_recency < 11.320527, 7.000000, 7.000000);

modinq_size_98_c4009 := if(nf_inq_lnames_per_sfd_addr < -0.383740, modinq_size_98_c4010, modinq_size_98_c4012);

modinq_size_98_c4008 := if(nf_inq_ssn_ver_count < 45.384896, modinq_size_98_c4009, 5.000000);

modinq_size_98_c4016 := if(nf_inq_ssns_per_apt_addr < -0.834481, 9.851656, 8.000000);

modinq_size_98_c4015 := if(nf_inq_communications_count24 < 5.652938, modinq_size_98_c4016, 7.000000);

modinq_size_98_c4014 := if(nf_inq_count < 9.433044, 6.000000, modinq_size_98_c4015);

modinq_size_98_c4018 := if(nf_inq_ssns_per_addr < 0.530828, 7.000000, 7.000000);

modinq_size_98_c4017 := if(nf_inq_lnamesperaddr_count12 < 1.158956, modinq_size_98_c4018, 6.000000);

modinq_size_98_c4013 := if(nf_inq_addrsperssn_recency < 8.376956, modinq_size_98_c4014, modinq_size_98_c4017);

modinq_size_98_c4007 := if(nf_inq_addrsperssn_recency < 5.500624, modinq_size_98_c4008, modinq_size_98_c4013);

modinq_size_98_c3990 := if(nf_inq_communications_count < 3.808746, modinq_size_98_c3991, modinq_size_98_c4007);

modinq_size_98_c3989 := if(nf_inquiry_adl_vel_risk_index < 9.223615, modinq_size_98_c3990, 2.000000);

modinq_size_98_c4022 := if(nf_inq_perbestssn_count12 < 4.256789, 5.000000, 5.000000);

modinq_size_98_c4026 := if(nf_inq_count < 6.787945, 8.000000, 8.000000);

modinq_size_98_c4025 := if(nf_inq_ssnsperaddr_count_week < 0.808999, 7.000000, modinq_size_98_c4026);

modinq_size_98_c4024 := if(nf_inq_banking_count_week < 0.979606, modinq_size_98_c4025, 6.000000);

modinq_size_98_c4027 := if(rv_i62_inq_phonesperadl_count12 < 1.801691, 6.000000, 6.000000);

modinq_size_98_c4023 := if(nf_inq_peradl_count_week < 2.487410, modinq_size_98_c4024, modinq_size_98_c4027);

modinq_size_98_c4021 := if(nf_inq_adlspercurraddr_count12 < 0.142038, modinq_size_98_c4022, modinq_size_98_c4023);

modinq_size_98_c4020 := if(nf_inq_phonesperadl_count_day < 0.144037, modinq_size_98_c4021, 3.000000);

modinq_size_98_c4019 := if(nf_inq_lnames_per_apt_addr < 0.968887, modinq_size_98_c4020, 2.000000);

modinq_size_98 := if(nf_inq_ssnsperadl_count_week < 0.356844, modinq_size_98_c3989, modinq_size_98_c4019);

modinq_size_99_c4035 := if(rv_i60_inq_hiriskcred_count12 < 1.001337, 16.794929, 8.000000);

modinq_size_99_c4036 := if(nf_inq_addrs_per_ssn < 1.455032, 15.168763, 10.327020);

modinq_size_99_c4034 := if(nf_inq_ssns_per_addr < 0.219528, modinq_size_99_c4035, modinq_size_99_c4036);

modinq_size_99_c4038 := if(nf_inq_other_count24 < 0.023669, 8.000000, 8.000000);

modinq_size_99_c4039 := if(nf_inq_ssns_per_addr < 0.507343, 8.000000, 13.590539);

modinq_size_99_c4037 := if(nf_inq_bestssn_ver_count < 2.803475, modinq_size_99_c4038, modinq_size_99_c4039);

modinq_size_99_c4033 := if(nf_inq_lnames_per_sfd_addr < 1.784060, modinq_size_99_c4034, modinq_size_99_c4037);

modinq_size_99_c4040 := if(nf_inq_count < 4.856586, 6.000000, 6.000000);

modinq_size_99_c4032 := if(nf_inq_dobsperadl_count_week < 0.636574, modinq_size_99_c4033, modinq_size_99_c4040);

modinq_size_99_c4043 := if(nf_inq_bestfname_ver_count < 14.599858, 7.000000, 7.000000);

modinq_size_99_c4042 := if(nf_inq_banking_count24 < 0.147834, modinq_size_99_c4043, 6.000000);

modinq_size_99_c4044 := if(nf_inq_count < 23.511030, 6.000000, 6.000000);

modinq_size_99_c4041 := if(nf_inq_lnames_per_ssn < 0.001996, modinq_size_99_c4042, modinq_size_99_c4044);

modinq_size_99_c4031 := if(nf_inq_other_count < 7.551820, modinq_size_99_c4032, modinq_size_99_c4041);

modinq_size_99_c4046 := if(nf_inq_auto_count_day < 0.281494, 5.000000, 5.000000);

modinq_size_99_c4045 := if(nf_inq_dobsperadl_count_day < 0.792515, 4.000000, modinq_size_99_c4046);

modinq_size_99_c4030 := if(nf_inq_adlsperssn_count_day < 0.236526, modinq_size_99_c4031, modinq_size_99_c4045);

modinq_size_99_c4052 := if(rv_i60_inq_other_recency < 6.619526, 11.535537, 9.207392);

modinq_size_99_c4053 := if(nf_invbest_inq_ssnsperaddr_diff < 1.297129, 10.327020, 8.000000);

modinq_size_99_c4051 := if(nf_inq_ssns_per_sfd_addr < 1.147109, modinq_size_99_c4052, modinq_size_99_c4053);

modinq_size_99_c4054 := if(nf_inq_adlsperaddr_count12 < 0.734136, 7.000000, 7.000000);

modinq_size_99_c4050 := if(nf_inq_bestdob_ver_count < 35.106122, modinq_size_99_c4051, modinq_size_99_c4054);

modinq_size_99_c4057 := if(rv_i62_inq_fnamesperadl_count12 < 1.873512, 8.000000, 8.000000);

modinq_size_99_c4056 := if(nf_inq_bestssn_ver_count < 17.211635, modinq_size_99_c4057, 7.000000);

modinq_size_99_c4055 := if(rv_i62_inq_dobsperadl_count12 < 2.397662, modinq_size_99_c4056, 6.000000);

modinq_size_99_c4049 := if(nf_inq_count_week < 1.292165, modinq_size_99_c4050, modinq_size_99_c4055);

modinq_size_99_c4059 := if(nf_inq_lnames_per_ssn < 1.222184, 6.000000, 6.000000);

modinq_size_99_c4058 := if(rv_i61_inq_collection_recency < 43.716771, 5.000000, modinq_size_99_c4059);

modinq_size_99_c4048 := if(nf_inq_lnamesperaddr_count12 < 2.597999, modinq_size_99_c4049, modinq_size_99_c4058);

modinq_size_99_c4062 := if(nf_inq_addrsperssn_count_week < 0.392749, 6.000000, 6.000000);

modinq_size_99_c4061 := if(rv_i60_inq_peradl_recency < 2.703648, modinq_size_99_c4062, 5.000000);

modinq_size_99_c4060 := if(nf_inq_lnamesperssn_count12 < 1.097871, modinq_size_99_c4061, 4.000000);

modinq_size_99_c4047 := if(nf_inq_per_addr < 13.426189, modinq_size_99_c4048, modinq_size_99_c4060);

modinq_size_99_c4029 := if(rv_i60_inq_count12 < 4.249585, modinq_size_99_c4030, modinq_size_99_c4047);

modinq_size_99_c4063 := if(nf_inq_perbestssn_count12 < 8.252791, 2.000000, 2.000000);

modinq_size_99 := if(rv_i60_inq_comm_count12 < 3.201656, modinq_size_99_c4029, modinq_size_99_c4063);

modinq_size_100_c4071 := if(nf_inq_collection_count24 < 0.478121, 13.040438, 11.023665);

modinq_size_100_c4072 := if(rv_i62_inq_phones_per_adl < 0.031773, 8.000000, 9.207392);

modinq_size_100_c4070 := if(rv_i60_inq_peradl_count12 < 0.216307, modinq_size_100_c4071, modinq_size_100_c4072);

modinq_size_100_c4074 := if(rv_i60_inq_peradl_count12 < 2.161609, 10.327020, 8.000000);

modinq_size_100_c4073 := if(nf_inq_adlsperbestphone_count12 < 0.257898, modinq_size_100_c4074, 7.000000);

modinq_size_100_c4069 := if(nf_inq_lnamesperssn_recency < 3.412008, modinq_size_100_c4070, modinq_size_100_c4073);

modinq_size_100_c4076 := if(rv_i62_inq_ssnsperadl_count12 < 0.897266, 7.000000, 7.000000);

modinq_size_100_c4075 := if(nf_inq_curraddr_ver_count < 6.545331, modinq_size_100_c4076, 6.000000);

modinq_size_100_c4068 := if(rv_i60_credit_seeking < 1.838464, modinq_size_100_c4069, modinq_size_100_c4075);

modinq_size_100_c4080 := if(nf_inq_adls_per_sfd_addr < -0.188154, 10.706640, 15.375907);

modinq_size_100_c4081 := if(rv_i62_inq_ssnsperadl_recency < 0.445151, 8.000000, 8.000000);

modinq_size_100_c4079 := if(rv_i60_inq_prepaidcards_recency < 55.287651, modinq_size_100_c4080, modinq_size_100_c4081);

modinq_size_100_c4078 := if(rv_i62_inq_dobs_per_adl < 1.449180, modinq_size_100_c4079, 6.000000);

modinq_size_100_c4083 := if(rv_i60_inq_hiriskcred_recency < 34.256582, 7.000000, 7.000000);

modinq_size_100_c4084 := if(nf_inq_count < 19.080682, 7.000000, 7.000000);

modinq_size_100_c4082 := if(nf_inq_adls_per_apt_addr < -0.204897, modinq_size_100_c4083, modinq_size_100_c4084);

modinq_size_100_c4077 := if(nf_inq_lnamesperssn_count_week < 0.166643, modinq_size_100_c4078, modinq_size_100_c4082);

modinq_size_100_c4067 := if(nf_inq_bestphone_ver_count < 133.720853, modinq_size_100_c4068, modinq_size_100_c4077);

modinq_size_100_c4089 := if(nf_inq_communications_count < 0.623669, 9.000000, 8.000000);

modinq_size_100_c4090 := if(nf_inq_auto_count < 8.240418, 13.669106, 8.000000);

modinq_size_100_c4088 := if(nf_inq_lnames_per_addr < 0.429374, modinq_size_100_c4089, modinq_size_100_c4090);

modinq_size_100_c4092 := if(rv_i60_inq_retail_recency < 57.644052, 10.706640, 9.000000);

modinq_size_100_c4091 := if(nf_inq_highriskcredit_count24 < 0.177114, modinq_size_100_c4092, 7.000000);

modinq_size_100_c4087 := if(nf_inq_ssnsperaddr_recency < 10.977211, modinq_size_100_c4088, modinq_size_100_c4091);

modinq_size_100_c4095 := if(nf_inq_addrsperssn_count12 < 0.303013, 11.748880, 8.000000);

modinq_size_100_c4094 := if(nf_inq_ssns_per_sfd_addr < -0.592991, 7.000000, modinq_size_100_c4095);

modinq_size_100_c4096 := if(nf_inq_adls_per_sfd_addr < 4.034063, 7.000000, 7.000000);

modinq_size_100_c4093 := if(nf_inq_auto_count < 2.560977, modinq_size_100_c4094, modinq_size_100_c4096);

modinq_size_100_c4086 := if(nf_inq_perssn_recency < 2.166605, modinq_size_100_c4087, modinq_size_100_c4093);

modinq_size_100_c4100 := if(rv_i62_inq_addrsperadl_count12 < 0.852060, 9.851656, 15.815723);

modinq_size_100_c4099 := if(nf_inq_mortgage_count24 < 2.456560, modinq_size_100_c4100, 7.000000);

modinq_size_100_c4102 := if(nf_inq_dobsperssn_count12 < 1.710757, 9.000000, 8.000000);

modinq_size_100_c4103 := if(nf_inq_ssnsperaddr_count12 < 5.459416, 8.000000, 8.000000);

modinq_size_100_c4101 := if(nf_inq_addrs_per_ssn < 1.354580, modinq_size_100_c4102, modinq_size_100_c4103);

modinq_size_100_c4098 := if(nf_inq_ssnsperaddr_count_week < 0.059054, modinq_size_100_c4099, modinq_size_100_c4101);

modinq_size_100_c4097 := if(nf_invbest_inq_lnamesperssn_diff < -0.906449, modinq_size_100_c4098, 5.000000);

modinq_size_100_c4085 := if(rv_i62_inq_lnamesperadl_count12 < 0.186774, modinq_size_100_c4086, modinq_size_100_c4097);

modinq_size_100_c4066 := if(nf_inq_peraddr_recency < 0.569619, modinq_size_100_c4067, modinq_size_100_c4085);

//modinq_size_100_c4065 := if(nf_invbest_inq_lastperaddr_diff < -9523585204.754765, 2.000000, modinq_size_100_c4066);
modinq_size_100_c4065 := if(nf_invbest_inq_lastperaddr_diff < -999999998, 2.000000, modinq_size_100_c4066);

//modinq_size_100 := if(nf_inq_addrsperssn_count_day < -4509885852.622108, 1.000000, modinq_size_100_c4065);
modinq_size_100 := if(nf_inq_addrsperssn_count_day < -999999998, 1.000000, modinq_size_100_c4065);

modinq_avg_path_length := (modinq_size_1 +
    modinq_size_2 +
    modinq_size_3 +
    modinq_size_4 +
    modinq_size_5 +
    modinq_size_6 +
    modinq_size_7 +
    modinq_size_8 +
    modinq_size_9 +
    modinq_size_10 +
    modinq_size_11 +
    modinq_size_12 +
    modinq_size_13 +
    modinq_size_14 +
    modinq_size_15 +
    modinq_size_16 +
    modinq_size_17 +
    modinq_size_18 +
    modinq_size_19 +
    modinq_size_20 +
    modinq_size_21 +
    modinq_size_22 +
    modinq_size_23 +
    modinq_size_24 +
    modinq_size_25 +
    modinq_size_26 +
    modinq_size_27 +
    modinq_size_28 +
    modinq_size_29 +
    modinq_size_30 +
    modinq_size_31 +
    modinq_size_32 +
    modinq_size_33 +
    modinq_size_34 +
    modinq_size_35 +
    modinq_size_36 +
    modinq_size_37 +
    modinq_size_38 +
    modinq_size_39 +
    modinq_size_40 +
    modinq_size_41 +
    modinq_size_42 +
    modinq_size_43 +
    modinq_size_44 +
    modinq_size_45 +
    modinq_size_46 +
    modinq_size_47 +
    modinq_size_48 +
    modinq_size_49 +
    modinq_size_50 +
    modinq_size_51 +
    modinq_size_52 +
    modinq_size_53 +
    modinq_size_54 +
    modinq_size_55 +
    modinq_size_56 +
    modinq_size_57 +
    modinq_size_58 +
    modinq_size_59 +
    modinq_size_60 +
    modinq_size_61 +
    modinq_size_62 +
    modinq_size_63 +
    modinq_size_64 +
    modinq_size_65 +
    modinq_size_66 +
    modinq_size_67 +
    modinq_size_68 +
    modinq_size_69 +
    modinq_size_70 +
    modinq_size_71 +
    modinq_size_72 +
    modinq_size_73 +
    modinq_size_74 +
    modinq_size_75 +
    modinq_size_76 +
    modinq_size_77 +
    modinq_size_78 +
    modinq_size_79 +
    modinq_size_80 +
    modinq_size_81 +
    modinq_size_82 +
    modinq_size_83 +
    modinq_size_84 +
    modinq_size_85 +
    modinq_size_86 +
    modinq_size_87 +
    modinq_size_88 +
    modinq_size_89 +
    modinq_size_90 +
    modinq_size_91 +
    modinq_size_92 +
    modinq_size_93 +
    modinq_size_94 +
    modinq_size_95 +
    modinq_size_96 +
    modinq_size_97 +
    modinq_size_98 +
    modinq_size_99 +
    modinq_size_100) / 100;

modinq_anomaly_score := power(2,(-1 * modinq_avg_path_length / 10.244771));

nf_fp_srchfraudsrchcountyr := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (integer)fp_srchfraudsrchcountyr), 999));

_in_dob := common.sas_date((string)(in_dob));

earliest_bureau_date := if(ver_src_fdate_tn = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, if(max(ver_src_fdate_tn, ver_src_fdate_en, ver_src_fdate_eq) = NULL, NULL, min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq))));

earliest_bureau_yrs := if(earliest_bureau_date = NULL or sysdate = NULL, NULL, if ((sysdate - earliest_bureau_date) / 365.25 >= 0, roundup((sysdate - earliest_bureau_date) / 365.25), truncate((sysdate - earliest_bureau_date) / 365.25)));

calc_dob := if(_in_dob = NULL, NULL, if ((sysdate - _in_dob) / 365.25 >= 0, roundup((sysdate - _in_dob) / 365.25), truncate((sysdate - _in_dob) / 365.25)));

_bureau_emergence_age := map(
    not(truedid) or earliest_bureau_yrs = NULL => NULL,
    not(calc_dob = NULL)                       => calc_dob - earliest_bureau_yrs,
    inferred_age = 0                           => NULL,
                                                  inferred_age - earliest_bureau_yrs);

ca_bureau_emergence_age_32_59 := 32 <= _bureau_emergence_age AND _bureau_emergence_age <= 59;

num_bureau_fname := (integer)ver_fname_src_eq +
    (integer)ver_fname_src_en +
    (integer)ver_fname_src_tn +
    (integer)ver_fname_src_ts +
    (integer)ver_fname_src_tu;

num_bureau_lname := (integer)ver_lname_src_eq +
    (integer)ver_lname_src_en +
    (integer)ver_lname_src_tn +
    (integer)ver_lname_src_ts +
    (integer)ver_lname_src_tu;

num_bureau_addr := (integer)ver_addr_src_eq +
    (integer)ver_addr_src_en +
    (integer)ver_addr_src_tn +
    (integer)ver_addr_src_ts +
    (integer)ver_addr_src_tu;

num_bureau_ssn := (integer)ver_ssn_src_eq +
    (integer)ver_ssn_src_en +
    (integer)ver_ssn_src_tn +
    (integer)ver_ssn_src_ts +
    (integer)ver_ssn_src_tu;

num_bureau_dob := (integer)ver_dob_src_eq +
    (integer)ver_dob_src_en +
    (integer)ver_dob_src_tn +
    (integer)ver_dob_src_ts +
    (integer)ver_dob_src_tu;

iv_bureau_verification_index := if(not(truedid), NULL, if(max( (integer)(max(num_bureau_fname, num_bureau_lname) > 0), 2* (integer)(num_bureau_addr > 0), 4 * (integer)(num_bureau_dob > 0), 8 * (integer)(num_bureau_ssn > 0)) = NULL, NULL, sum(if( (integer)(max(num_bureau_fname, num_bureau_lname) > 0) = NULL, 0,  (integer)(max(num_bureau_fname, num_bureau_lname) > 0)), if(2  * (integer)(num_bureau_addr > 0) = NULL, 0, 2  * (integer)(num_bureau_addr > 0)), if(4 * (integer)(num_bureau_dob > 0) = NULL, 0, 4 * (integer)(num_bureau_dob > 0)), if(8 * (integer)(num_bureau_ssn > 0) = NULL, 0, 8 * (integer)(num_bureau_ssn > 0)))));

rv_c15_ssns_per_adl_c6_v2 := if(not(truedid), NULL, min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 999));

rv_s65_ssn_prior_dob := map(
    not((integer)ssnlength > 0 and dobpop)            => NULL,
    rc_ssndobflag = '1' or rc_pwssndobflag = '1' => 1,
    rc_ssndobflag = '0' or rc_pwssndobflag = '0' => 0,
                                                NULL);

rv_c15_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 999));

_rc_ssnhighissue := common.sas_date((string)(rc_ssnhighissue));

ca_m_snc_ssn_high_issue := map(
    not((integer)ssnlength > 0)      => NULL,
    _rc_ssnhighissue = NULL => -1,
                               min(if(if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12)))), 999));

co_tgr_fla_bureau_no_ssn := (iv_bureau_verification_index in [3, 5, 7]);

sc_tgr_ssn_fs_6mo := rv_c15_ssns_per_adl_c6_v2 > 0;

sc_tgr_ssn_input_not_best := input_ssn_isbestmatch = '0';

sc_tgr_ssn_prior_dob := rv_s65_ssn_prior_dob = 1;

co_tgr_ssns_per_adl := rv_c15_ssns_per_adl > 4;

co_did_count := did_count > 14;

co_ssn_high_issue := 0 <= ca_m_snc_ssn_high_issue AND ca_m_snc_ssn_high_issue <= 181;

beta_cpn_trigger := map(
    co_tgr_fla_bureau_no_ssn   => 1,
    sc_tgr_ssn_fs_6mo => 1,
    sc_tgr_ssn_input_not_best  => 1,
    sc_tgr_ssn_prior_dob       => 1,
    co_tgr_ssns_per_adl        => 1,
    co_did_count               => 1,
    co_ssn_high_issue          => 1,
                                     0);

rv_s66_ssns_per_adl_c6 := if(not(truedid), NULL, min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 999));

nf_ssns_per_curraddr_curr := if(not(add_curr_pop) or not(truedid), NULL, min(if(ssns_per_curraddr_curr = NULL, -NULL, ssns_per_curraddr_curr), 999));

rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

sid_subscore0 := map(
    NULL < ca_m_bureau_fs AND ca_m_bureau_fs < 0  => 0,
    0 <= ca_m_bureau_fs AND ca_m_bureau_fs < 8    => -0.913097,
    8 <= ca_m_bureau_fs AND ca_m_bureau_fs < 26   => -0.545879,
    26 <= ca_m_bureau_fs AND ca_m_bureau_fs < 65  => -0.221254,
    65 <= ca_m_bureau_fs AND ca_m_bureau_fs < 240 => 0.179201,
    240 <= ca_m_bureau_fs                         => 0.563879,
                                                     0);

sid_subscore1 := map(
    NULL < nf_addrs_per_ssn AND nf_addrs_per_ssn < 2 => 0.8563,
    2 <= nf_addrs_per_ssn AND nf_addrs_per_ssn < 4   => 0.342154,
    4 <= nf_addrs_per_ssn                            => -0.237173,
                                                        0);

sid_subscore2 := map(
    NULL < rv_a41_a42_prop_owner_history AND rv_a41_a42_prop_owner_history < 1 => -0.230003,
    1 <= rv_a41_a42_prop_owner_history AND rv_a41_a42_prop_owner_history < 2   => -0.101292,
    2 <= rv_a41_a42_prop_owner_history                                         => 0.393191,
                                                                                  0);

sid_subscore3 := map(
    (rv_i60_inq_comm_recency in [0, 99])           => 0.0922,
    (rv_i60_inq_comm_recency in [1, 3, 6, 12, 24]) => -0.840929,
                                                      0);

sid_subscore4 := map(
    NULL < ca_inq_perssn_count01 AND ca_inq_perssn_count01 < 1 => 0.134321,
    1 <= ca_inq_perssn_count01 AND ca_inq_perssn_count01 < 2   => -0.291475,
    2 <= ca_inq_perssn_count01 AND ca_inq_perssn_count01 < 4   => -0.579603,
    4 <= ca_inq_perssn_count01                                 => -0.638407,
                                                                  0);

sid_subscore5 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.113383,
    2 <= rv_s66_adlperssn_count                                  => -0.13818,
                                                                    0);

sid_subscore6 := map(
    NULL < modinq_anomaly_score AND modinq_anomaly_score < 0.5 => 0.042561,
    0.5 <= modinq_anomaly_score                                => -0.388323,
                                                                  0);

sid_subscore7 := map(
    NULL < nf_fp_srchfraudsrchcountyr AND nf_fp_srchfraudsrchcountyr < 1 => 0.085061,
    1 <= nf_fp_srchfraudsrchcountyr AND nf_fp_srchfraudsrchcountyr < 2   => -0.064023,
    2 <= nf_fp_srchfraudsrchcountyr AND nf_fp_srchfraudsrchcountyr < 3   => -0.085576,
    3 <= nf_fp_srchfraudsrchcountyr                                      => -0.288966,
                                                                            0);

sid_subscore8 := map(
    (ca_bureau_emergence_age_32_59 in [0]) => 0.031685,
    (ca_bureau_emergence_age_32_59 in [1]) => -0.1462,
                                              0);

sid_rawscore := sid_subscore0 +
    sid_subscore1 +
    sid_subscore2 +
    sid_subscore3 +
    sid_subscore4 +
    sid_subscore5 +
    sid_subscore6 +
    sid_subscore7 +
    sid_subscore8;

sid_lnoddsscore := sid_rawscore + 3.913270;

sid_probscore := exp(sid_lnoddsscore) / (1 + exp(sid_lnoddsscore));

base_1 := 650;

pdo_1 := 40;

odds_1 := (1 - 0.02) / 0.02;

cust_auto_synthid_score := max(min(if(round(pdo_1 * (ln(sid_probscore / (1 - sid_probscore)) - ln(odds_1)) / ln(2) + base_1) = NULL, -NULL, round(pdo_1 * (ln(sid_probscore / (1 - sid_probscore)) - ln(odds_1)) / ln(2) + base_1)), 999), 300);

fp1704_1_0_synthidindex := map(
    not beta_synthid_trigger_v2                                      => 1,
    300 <= cust_auto_synthid_score AND cust_auto_synthid_score <= 516 => 9,
    517 <= cust_auto_synthid_score AND cust_auto_synthid_score <= 544 => 8,
    545 <= cust_auto_synthid_score AND cust_auto_synthid_score <= 581 => 7,
    582 <= cust_auto_synthid_score AND cust_auto_synthid_score <= 626 => 6,
    627 <= cust_auto_synthid_score AND cust_auto_synthid_score <= 649 => 5,
    650 <= cust_auto_synthid_score AND cust_auto_synthid_score <= 671 => 4,
    672 <= cust_auto_synthid_score AND cust_auto_synthid_score <= 704 => 3,
                                                                         2);

cpn_subscore0 := map(
    NULL < rv_a41_a42_prop_owner_history AND rv_a41_a42_prop_owner_history < 1 => -0.484571,
    1 <= rv_a41_a42_prop_owner_history AND rv_a41_a42_prop_owner_history < 2   => -0.278477,
    2 <= rv_a41_a42_prop_owner_history                                         => 0.586683,
                                                                                  0);

cpn_subscore1 := map(
    NULL < rv_s66_ssns_per_adl_c6 AND rv_s66_ssns_per_adl_c6 < 1 => 0.202656,
    1 <= rv_s66_ssns_per_adl_c6                                  => -0.992586,
                                                                    0);

cpn_subscore2 := map(
    NULL < ca_inq_perssn_count01 AND ca_inq_perssn_count01 < 1 => 0.205342,
    1 <= ca_inq_perssn_count01 AND ca_inq_perssn_count01 < 3   => 0.034467,
    3 <= ca_inq_perssn_count01 AND ca_inq_perssn_count01 < 6   => -0.831003,
    6 <= ca_inq_perssn_count01                                 => -1.485018,
                                                                  0);

cpn_subscore3 := map(
    NULL < nf_ssns_per_curraddr_curr AND nf_ssns_per_curraddr_curr < 1 => 0.170681,
    1 <= nf_ssns_per_curraddr_curr AND nf_ssns_per_curraddr_curr < 4   => 0.32995,
    4 <= nf_ssns_per_curraddr_curr AND nf_ssns_per_curraddr_curr < 6   => -0.195178,
    6 <= nf_ssns_per_curraddr_curr                                     => -0.627171,
                                                                          0);

cpn_subscore4 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 0.18731,
    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => -0.387524,
    2 <= rv_d30_derog_count                              => -0.705707,
                                                            0);

cpn_rawscore := cpn_subscore0 +
    cpn_subscore1 +
    cpn_subscore2 +
    cpn_subscore3 +
    cpn_subscore4;

cpn_lnoddsscore := cpn_rawscore + 4.105991;

cpn_probscore := exp(cpn_lnoddsscore) / (1 + exp(cpn_lnoddsscore));

base := 650;

pdo := 40;

odds := (1 - 0.02) / 0.02;

cust_auto_cpn_score := max(min(if(round(pdo * (ln(cpn_probscore / (1 - cpn_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(pdo * (ln(cpn_probscore / (1 - cpn_probscore)) - ln(odds)) / ln(2) + base)), 999), 300);

fp1704_1_0_suspactindex := map(
    beta_cpn_trigger = 0                                      => 1,
    300 <= cust_auto_cpn_score AND cust_auto_cpn_score <= 504 => 9,
    505 <= cust_auto_cpn_score AND cust_auto_cpn_score <= 545 => 8,
    546 <= cust_auto_cpn_score AND cust_auto_cpn_score <= 559 => 7,
    560 <= cust_auto_cpn_score AND cust_auto_cpn_score <= 589 => 6,
    590 <= cust_auto_cpn_score AND cust_auto_cpn_score <= 650 => 5,
    651 <= cust_auto_cpn_score AND cust_auto_cpn_score <= 686 => 4,
    687 <= cust_auto_cpn_score AND cust_auto_cpn_score <= 698 => 3,
                                                                 2);



																																	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
                     self.sysdate                          := sysdate;
                    self.ver_src_am_pos                   := ver_src_am_pos;
                    self.ver_src_am                       := ver_src_am;
                    self.ver_src_ar_pos                   := ver_src_ar_pos;
                    self.ver_src_ar                       := ver_src_ar;
                    self.ver_src_ba_pos                   := ver_src_ba_pos;
                    self.ver_src_ba                       := ver_src_ba;
                    self.ver_src_cg_pos                   := ver_src_cg_pos;
                    self.ver_src_cg                       := ver_src_cg;
                    self.ver_src_da_pos                   := ver_src_da_pos;
                    self.ver_src_da                       := ver_src_da;
                    self.ver_src_d_pos                    := ver_src_d_pos;
                    self.ver_src_d                        := ver_src_d;
                    self.ver_src_dl_pos                   := ver_src_dl_pos;
                    self.ver_src_dl                       := ver_src_dl;
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self.ver_src_eb                       := ver_src_eb;
                    self.ver_src_e1_pos                   := ver_src_e1_pos;
                    self.ver_src_e1                       := ver_src_e1;
                    self.ver_src_e2_pos                   := ver_src_e2_pos;
                    self.ver_src_e2                       := ver_src_e2;
                    self.ver_src_e3_pos                   := ver_src_e3_pos;
                    self.ver_src_e3                       := ver_src_e3;
                    self.ver_src_en_pos                   := ver_src_en_pos;
                    self._ver_src_fdate_en                := _ver_src_fdate_en;
                    self.ver_src_fdate_en                 := ver_src_fdate_en;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self._ver_src_fdate_eq                := _ver_src_fdate_eq;
                    self.ver_src_fdate_eq                 := ver_src_fdate_eq;
                    self.ver_src_fe_pos                   := ver_src_fe_pos;
                    self.ver_src_fe                       := ver_src_fe;
                    self.ver_src_ff_pos                   := ver_src_ff_pos;
                    self.ver_src_ff                       := ver_src_ff;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self.ver_src_p                        := ver_src_p;
                    self.ver_src_pl_pos                   := ver_src_pl_pos;
                    self.ver_src_pl                       := ver_src_pl;
                    self.ver_src_tn_pos                   := ver_src_tn_pos;
                    self._ver_src_fdate_tn                := _ver_src_fdate_tn;
                    self.ver_src_fdate_tn                 := ver_src_fdate_tn;
                    self.ver_src_sl_pos                   := ver_src_sl_pos;
                    self.ver_src_sl                       := ver_src_sl;
                    self.ver_src_v_pos                    := ver_src_v_pos;
                    self.ver_src_v                        := ver_src_v;
                    self.ver_src_vo_pos                   := ver_src_vo_pos;
                    self.ver_src_vo                       := ver_src_vo;
                    self.ver_src_w_pos                    := ver_src_w_pos;
                    self.ver_src_w                        := ver_src_w;
                    self.ver_fname_src_en_pos             := ver_fname_src_en_pos;
                    self.ver_fname_src_en                 := ver_fname_src_en;
                    self.ver_fname_src_eq_pos             := ver_fname_src_eq_pos;
                    self.ver_fname_src_eq                 := ver_fname_src_eq;
                    self.ver_fname_src_tn_pos             := ver_fname_src_tn_pos;
                    self.ver_fname_src_tn                 := ver_fname_src_tn;
                    self.ver_fname_src_ts_pos             := ver_fname_src_ts_pos;
                    self.ver_fname_src_ts                 := ver_fname_src_ts;
                    self.ver_fname_src_tu_pos             := ver_fname_src_tu_pos;
                    self.ver_fname_src_tu                 := ver_fname_src_tu;
                    self.ver_lname_src_en_pos             := ver_lname_src_en_pos;
                    self.ver_lname_src_en                 := ver_lname_src_en;
                    self.ver_lname_src_eq_pos             := ver_lname_src_eq_pos;
                    self.ver_lname_src_eq                 := ver_lname_src_eq;
                    self.ver_lname_src_tn_pos             := ver_lname_src_tn_pos;
                    self.ver_lname_src_tn                 := ver_lname_src_tn;
                    self.ver_lname_src_ts_pos             := ver_lname_src_ts_pos;
                    self.ver_lname_src_ts                 := ver_lname_src_ts;
                    self.ver_lname_src_tu_pos             := ver_lname_src_tu_pos;
                    self.ver_lname_src_tu                 := ver_lname_src_tu;
                    self.ver_addr_src_en_pos              := ver_addr_src_en_pos;
                    self.ver_addr_src_en                  := ver_addr_src_en;
                    self.ver_addr_src_eq_pos              := ver_addr_src_eq_pos;
                    self.ver_addr_src_eq                  := ver_addr_src_eq;
                    self.ver_addr_src_tn_pos              := ver_addr_src_tn_pos;
                    self.ver_addr_src_tn                  := ver_addr_src_tn;
                    self.ver_addr_src_ts_pos              := ver_addr_src_ts_pos;
                    self.ver_addr_src_ts                  := ver_addr_src_ts;
                    self.ver_addr_src_tu_pos              := ver_addr_src_tu_pos;
                    self.ver_addr_src_tu                  := ver_addr_src_tu;
                    self.ver_ssn_src_en_pos               := ver_ssn_src_en_pos;
                    self.ver_ssn_src_en                   := ver_ssn_src_en;
                    self.ver_ssn_src_eq_pos               := ver_ssn_src_eq_pos;
                    self.ver_ssn_src_eq                   := ver_ssn_src_eq;
                    self.ver_ssn_src_tn_pos               := ver_ssn_src_tn_pos;
                    self.ver_ssn_src_tn                   := ver_ssn_src_tn;
                    self.ver_ssn_src_ts_pos               := ver_ssn_src_ts_pos;
                    self.ver_ssn_src_ts                   := ver_ssn_src_ts;
                    self.ver_ssn_src_tu_pos               := ver_ssn_src_tu_pos;
                    self.ver_ssn_src_tu                   := ver_ssn_src_tu;
                    self.ver_dob_src_en_pos               := ver_dob_src_en_pos;
                    self.ver_dob_src_en                   := ver_dob_src_en;
                    self.ver_dob_src_eq_pos               := ver_dob_src_eq_pos;
                    self.ver_dob_src_eq                   := ver_dob_src_eq;
                    self.ver_dob_src_tn_pos               := ver_dob_src_tn_pos;
                    self.ver_dob_src_tn                   := ver_dob_src_tn;
                    self.ver_dob_src_ts_pos               := ver_dob_src_ts_pos;
                    self.ver_dob_src_ts                   := ver_dob_src_ts;
                    self.ver_dob_src_tu_pos               := ver_dob_src_tu_pos;
                    self.ver_dob_src_tu                   := ver_dob_src_tu;
                    self.iv_add_apt                       := iv_add_apt;
                    self.sum_src_credentialed             := sum_src_credentialed;
                    self.beta_synthid_trigger_v2          := beta_synthid_trigger_v2;
                    self.earliest_bur_date_all            := earliest_bur_date_all;
                    self.ca_m_bureau_fs                   := ca_m_bureau_fs;
                    self.nf_addrs_per_ssn                 := nf_addrs_per_ssn;
                    self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
                    self.ca_inq_perssn_count01            := ca_inq_perssn_count01;
                    self.rv_s66_adlperssn_count           := rv_s66_adlperssn_count;
                    self.rv_i60_inq_count12               := rv_i60_inq_count12;
                    self.rv_i60_credit_seeking            := rv_i60_credit_seeking;
                    self.rv_i60_inq_recency               := rv_i60_inq_recency;
                    self.rv_i61_inq_collection_count12    := rv_i61_inq_collection_count12;
                    self.rv_i61_inq_collection_recency    := rv_i61_inq_collection_recency;
                    self.rv_i60_inq_auto_count12          := rv_i60_inq_auto_count12;
                    self.rv_i60_inq_auto_recency          := rv_i60_inq_auto_recency;
                    self.rv_i60_inq_banking_count12       := rv_i60_inq_banking_count12;
                    self.rv_i60_inq_banking_recency       := rv_i60_inq_banking_recency;
                    self.rv_i60_inq_mortgage_count12      := rv_i60_inq_mortgage_count12;
                    self.rv_i60_inq_mortgage_recency      := rv_i60_inq_mortgage_recency;
                    self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
                    self.rv_i60_inq_hiriskcred_recency    := rv_i60_inq_hiriskcred_recency;
                    self.rv_i60_inq_prepaidcards_count12  := rv_i60_inq_prepaidcards_count12;
                    self.rv_i60_inq_prepaidcards_recency  := rv_i60_inq_prepaidcards_recency;
                    self.rv_i60_inq_retail_count12        := rv_i60_inq_retail_count12;
                    self.rv_i60_inq_retail_recency        := rv_i60_inq_retail_recency;
                    self.rv_i60_inq_retpymt_count12       := rv_i60_inq_retpymt_count12;
                    self.rv_i60_inq_retpymt_recency       := rv_i60_inq_retpymt_recency;
                    self.rv_i60_inq_comm_count12          := rv_i60_inq_comm_count12;
                    self.rv_i60_inq_comm_recency          := rv_i60_inq_comm_recency;
                    self.rv_i60_inq_stdloan_count12       := rv_i60_inq_stdloan_count12;
                    self.rv_i60_inq_util_count12          := rv_i60_inq_util_count12;
                    self.rv_i60_inq_util_recency          := rv_i60_inq_util_recency;
                    self.rv_i60_inq_other_count12         := rv_i60_inq_other_count12;
                    self.rv_i60_inq_other_recency         := rv_i60_inq_other_recency;
                    self.rv_i62_inq_ssns_per_adl          := rv_i62_inq_ssns_per_adl;
                    self.rv_i62_inq_addrs_per_adl         := rv_i62_inq_addrs_per_adl;
                    self.rv_i62_inq_num_names_per_adl     := rv_i62_inq_num_names_per_adl;
                    self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
                    self.rv_i62_inq_dobs_per_adl          := rv_i62_inq_dobs_per_adl;
                    self.nf_inq_fname_ver_count           := nf_inq_fname_ver_count;
                    self.nf_inq_lname_ver_count           := nf_inq_lname_ver_count;
                    self.nf_inq_addr_ver_count            := nf_inq_addr_ver_count;
                    self.nf_inq_dob_ver_count             := nf_inq_dob_ver_count;
                    self.nf_inq_ssn_ver_count             := nf_inq_ssn_ver_count;
                    self.nf_inquiry_verification_index    := nf_inquiry_verification_index;
                    self.nf_inquiry_adl_vel_risk_index    := nf_inquiry_adl_vel_risk_index;
                    self.nf_inquiry_ssn_vel_risk_index    := nf_inquiry_ssn_vel_risk_index;
                    self.nf_inq_addr_recency_risk_index   := nf_inq_addr_recency_risk_index;
                    self.nf_inquiry_ssn_vel_risk_indexv2  := nf_inquiry_ssn_vel_risk_indexv2;
                    self.nf_inquiry_addr_vel_risk_index   := nf_inquiry_addr_vel_risk_index;
                    self.nf_inquiry_addr_vel_risk_indexv2 := nf_inquiry_addr_vel_risk_indexv2;
                    self.nf_inq_count                     := nf_inq_count;
                    self.nf_inq_count_day                 := nf_inq_count_day;
                    self.nf_inq_count_week                := nf_inq_count_week;
                    self.nf_inq_count24                   := nf_inq_count24;
                    self.nf_inq_auto_count                := nf_inq_auto_count;
                    self.nf_inq_auto_count_day            := nf_inq_auto_count_day;
                    self.nf_inq_auto_count_week           := nf_inq_auto_count_week;
                    self.nf_inq_auto_count24              := nf_inq_auto_count24;
                    self.nf_inq_banking_count             := nf_inq_banking_count;
                    self.nf_inq_banking_count_day         := nf_inq_banking_count_day;
                    self.nf_inq_banking_count_week        := nf_inq_banking_count_week;
                    self.nf_inq_banking_count24           := nf_inq_banking_count24;
                    self.nf_inq_collection_count          := nf_inq_collection_count;
                    self.nf_inq_collection_count_week     := nf_inq_collection_count_week;
                    self.nf_inq_collection_count24        := nf_inq_collection_count24;
                    self.nf_inq_communications_count      := nf_inq_communications_count;
                    self.nf_inq_communications_count_week := nf_inq_communications_count_week;
                    self.nf_inq_communications_count24    := nf_inq_communications_count24;
                    self.nf_inq_highriskcredit_count      := nf_inq_highriskcredit_count;
                    self.nf_inq_highriskcredit_count_day  := nf_inq_highriskcredit_count_day;
                    self.nf_inq_highriskcredit_count_week := nf_inq_highriskcredit_count_week;
                    self.nf_inq_highriskcredit_count24    := nf_inq_highriskcredit_count24;
                    self.nf_inq_mortgage_count            := nf_inq_mortgage_count;
                    self.nf_inq_mortgage_count_week       := nf_inq_mortgage_count_week;
                    self.nf_inq_mortgage_count24          := nf_inq_mortgage_count24;
                    self.nf_inq_other_count               := nf_inq_other_count;
                    self.nf_inq_other_count_day           := nf_inq_other_count_day;
                    self.nf_inq_other_count_week          := nf_inq_other_count_week;
                    self.nf_inq_other_count24             := nf_inq_other_count24;
                    self.nf_inq_prepaidcards_count        := nf_inq_prepaidcards_count;
                    self.nf_inq_prepaidcards_count_day    := nf_inq_prepaidcards_count_day;
                    self.nf_inq_prepaidcards_count24      := nf_inq_prepaidcards_count24;
                    self.nf_inq_quizprovider_count        := nf_inq_quizprovider_count;
                    self.nf_inq_quizprovider_count_day    := nf_inq_quizprovider_count_day;
                    self.nf_inq_quizprovider_count_week   := nf_inq_quizprovider_count_week;
                    self.nf_inq_quizprovider_count24      := nf_inq_quizprovider_count24;
                    self.nf_inq_retail_count              := nf_inq_retail_count;
                    self.nf_inq_retail_count24            := nf_inq_retail_count24;
                    self.nf_inq_retailpayments_count      := nf_inq_retailpayments_count;
                    self.nf_inq_retailpayments_count_week := nf_inq_retailpayments_count_week;
                    self.nf_inq_retailpayments_count24    := nf_inq_retailpayments_count24;
                    self.nf_inq_utilities_count           := nf_inq_utilities_count;
                    self.nf_inq_utilities_count24         := nf_inq_utilities_count24;
                    self.nf_inq_per_ssn                   := nf_inq_per_ssn;
                    self.nf_inq_adls_per_ssn              := nf_inq_adls_per_ssn;
                    self.nf_inq_lnames_per_ssn            := nf_inq_lnames_per_ssn;
                    self.nf_inq_addrs_per_ssn             := nf_inq_addrs_per_ssn;
                    self.nf_inq_dobs_per_ssn              := nf_inq_dobs_per_ssn;
                    self.nf_inq_per_addr                  := nf_inq_per_addr;
                    self.nf_inq_per_apt_addr              := nf_inq_per_apt_addr;
                    self.nf_inq_per_sfd_addr              := nf_inq_per_sfd_addr;
                    self.nf_inq_adls_per_addr             := nf_inq_adls_per_addr;
                    self.nf_inq_adls_per_apt_addr         := nf_inq_adls_per_apt_addr;
                    self.nf_inq_adls_per_sfd_addr         := nf_inq_adls_per_sfd_addr;
                    self.nf_inq_lnames_per_addr           := nf_inq_lnames_per_addr;
                    self.nf_inq_lnames_per_apt_addr       := nf_inq_lnames_per_apt_addr;
                    self.nf_inq_lnames_per_sfd_addr       := nf_inq_lnames_per_sfd_addr;
                    self.nf_inq_ssns_per_addr             := nf_inq_ssns_per_addr;
                    self.nf_inq_ssns_per_apt_addr         := nf_inq_ssns_per_apt_addr;
                    self.nf_inq_ssns_per_sfd_addr         := nf_inq_ssns_per_sfd_addr;
                    self.nf_inq_email_per_adl             := nf_inq_email_per_adl;
                    self.rv_i60_inq_peradl_recency        := rv_i60_inq_peradl_recency;
                    self.rv_i60_inq_peradl_count12        := rv_i60_inq_peradl_count12;
                    self.nf_inq_peradl_count_day          := nf_inq_peradl_count_day;
                    self.nf_inq_peradl_count_week         := nf_inq_peradl_count_week;
                    self.rv_i62_inq_ssnsperadl_recency    := rv_i62_inq_ssnsperadl_recency;
                    self.rv_i62_inq_ssnsperadl_count12    := rv_i62_inq_ssnsperadl_count12;
                    self.nf_inq_ssnsperadl_count_day      := nf_inq_ssnsperadl_count_day;
                    self.nf_inq_ssnsperadl_count_week     := nf_inq_ssnsperadl_count_week;
                    self.rv_i62_inq_addrsperadl_recency   := rv_i62_inq_addrsperadl_recency;
                    self.rv_i62_inq_addrsperadl_count12   := rv_i62_inq_addrsperadl_count12;
                    self.nf_inq_addrsperadl_count_day     := nf_inq_addrsperadl_count_day;
                    self.nf_inq_addrsperadl_count_week    := nf_inq_addrsperadl_count_week;
                    self.rv_i62_inq_lnamesperadl_recency  := rv_i62_inq_lnamesperadl_recency;
                    self.rv_i62_inq_lnamesperadl_count12  := rv_i62_inq_lnamesperadl_count12;
                    self.nf_inq_lnamesperadl_count_day    := nf_inq_lnamesperadl_count_day;
                    self.nf_inq_lnamesperadl_count_week   := nf_inq_lnamesperadl_count_week;
                    self.rv_i62_inq_fnamesperadl_recency  := rv_i62_inq_fnamesperadl_recency;
                    self.rv_i62_inq_fnamesperadl_count12  := rv_i62_inq_fnamesperadl_count12;
                    self.nf_inq_fnamesperadl_count_day    := nf_inq_fnamesperadl_count_day;
                    self.nf_inq_fnamesperadl_count_week   := nf_inq_fnamesperadl_count_week;
                    self.rv_i62_inq_phonesperadl_recency  := rv_i62_inq_phonesperadl_recency;
                    self.rv_i62_inq_phonesperadl_count12  := rv_i62_inq_phonesperadl_count12;
                    self.nf_inq_phonesperadl_count_day    := nf_inq_phonesperadl_count_day;
                    self.nf_inq_phonesperadl_count_week   := nf_inq_phonesperadl_count_week;
                    self.rv_i62_inq_dobsperadl_recency    := rv_i62_inq_dobsperadl_recency;
                    self.rv_i62_inq_dobsperadl_count12    := rv_i62_inq_dobsperadl_count12;
                    self.nf_inq_dobsperadl_count_day      := nf_inq_dobsperadl_count_day;
                    self.nf_inq_dobsperadl_count_week     := nf_inq_dobsperadl_count_week;
                    self.nf_inq_perssn_recency            := nf_inq_perssn_recency;
                    self.nf_inq_perssn_count12            := nf_inq_perssn_count12;
                    self.nf_inq_perssn_count_day          := nf_inq_perssn_count_day;
                    self.nf_inq_perssn_count_week         := nf_inq_perssn_count_week;
                    self.nf_inq_adlsperssn_recency        := nf_inq_adlsperssn_recency;
                    self.nf_inq_adlsperssn_count12        := nf_inq_adlsperssn_count12;
                    self.nf_inq_adlsperssn_count_day      := nf_inq_adlsperssn_count_day;
                    self.nf_inq_adlsperssn_count_week     := nf_inq_adlsperssn_count_week;
                    self.nf_inq_lnamesperssn_recency      := nf_inq_lnamesperssn_recency;
                    self.nf_inq_lnamesperssn_count12      := nf_inq_lnamesperssn_count12;
                    self.nf_inq_lnamesperssn_count_day    := nf_inq_lnamesperssn_count_day;
                    self.nf_inq_lnamesperssn_count_week   := nf_inq_lnamesperssn_count_week;
                    self.nf_inq_addrsperssn_recency       := nf_inq_addrsperssn_recency;
                    self.nf_inq_addrsperssn_count12       := nf_inq_addrsperssn_count12;
                    self.nf_inq_addrsperssn_count_day     := nf_inq_addrsperssn_count_day;
                    self.nf_inq_addrsperssn_count_week    := nf_inq_addrsperssn_count_week;
                    self.nf_inq_dobsperssn_recency        := nf_inq_dobsperssn_recency;
                    self.nf_inq_dobsperssn_count12        := nf_inq_dobsperssn_count12;
                    self.nf_inq_dobsperssn_count_day      := nf_inq_dobsperssn_count_day;
                    self.nf_inq_dobsperssn_count_week     := nf_inq_dobsperssn_count_week;
                    self.nf_inq_peraddr_recency           := nf_inq_peraddr_recency;
                    self.nf_inq_peraddr_count12           := nf_inq_peraddr_count12;
                    self.nf_inq_peraddr_count_day         := nf_inq_peraddr_count_day;
                    self.nf_inq_peraddr_count_week        := nf_inq_peraddr_count_week;
                    self.nf_inq_adlsperaddr_recency       := nf_inq_adlsperaddr_recency;
                    self.nf_inq_adlsperaddr_count12       := nf_inq_adlsperaddr_count12;
                    self.nf_inq_adlsperaddr_count_day     := nf_inq_adlsperaddr_count_day;
                    self.nf_inq_adlsperaddr_count_week    := nf_inq_adlsperaddr_count_week;
                    self.nf_inq_lnamesperaddr_recency     := nf_inq_lnamesperaddr_recency;
                    self.nf_inq_lnamesperaddr_count12     := nf_inq_lnamesperaddr_count12;
                    self.nf_inq_lnamesperaddr_count_day   := nf_inq_lnamesperaddr_count_day;
                    self.nf_inq_lnamesperaddr_count_week  := nf_inq_lnamesperaddr_count_week;
                    self.nf_inq_ssnsperaddr_recency       := nf_inq_ssnsperaddr_recency;
                    self.nf_inq_ssnsperaddr_count12       := nf_inq_ssnsperaddr_count12;
                    self.nf_inq_ssnsperaddr_count_day     := nf_inq_ssnsperaddr_count_day;
                    self.nf_inq_ssnsperaddr_count_week    := nf_inq_ssnsperaddr_count_week;
                    self.nf_inq_emailsperadl_count12      := nf_inq_emailsperadl_count12;
                    self.nf_inq_adlsperemail_count12      := nf_inq_adlsperemail_count12;
                    self.nf_inq_adlsperemail_count_week   := nf_inq_adlsperemail_count_week;
                    self.nf_inq_perbestssn_count12        := nf_inq_perbestssn_count12;
                    self.nf_inq_adlsperbestssn_count12    := nf_inq_adlsperbestssn_count12;
                    self.nf_inq_lnamesperbestssn_count12  := nf_inq_lnamesperbestssn_count12;
                    self.nf_inq_addrsperbestssn_count12   := nf_inq_addrsperbestssn_count12;
                    self.nf_inq_dobsperbestssn_count12    := nf_inq_dobsperbestssn_count12;
                    self.nf_inq_percurraddr_count12       := nf_inq_percurraddr_count12;
                    self.nf_inq_adlspercurraddr_count12   := nf_inq_adlspercurraddr_count12;
                    self.nf_inq_lnamespercurraddr_count12 := nf_inq_lnamespercurraddr_count12;
                    self.nf_inq_ssnspercurraddr_count12   := nf_inq_ssnspercurraddr_count12;
                    self.nf_inq_perbestphone_count12      := nf_inq_perbestphone_count12;
                    self.nf_inq_adlsperbestphone_count12  := nf_inq_adlsperbestphone_count12;
                    self.nf_inq_curraddr_ver_count        := nf_inq_curraddr_ver_count;
                    self.nf_inq_bestfname_ver_count       := nf_inq_bestfname_ver_count;
                    self.nf_inq_bestlname_ver_count       := nf_inq_bestlname_ver_count;
                    self.nf_inq_bestssn_ver_count         := nf_inq_bestssn_ver_count;
                    self.nf_inq_bestdob_ver_count         := nf_inq_bestdob_ver_count;
                    self.nf_inq_bestphone_ver_count       := nf_inq_bestphone_ver_count;
                    self.nf_invbest_inq_perssn_diff       := nf_invbest_inq_perssn_diff;
                    self.nf_invbest_inq_adlsperssn_diff   := nf_invbest_inq_adlsperssn_diff;
                    self.nf_invbest_inq_lnamesperssn_diff := nf_invbest_inq_lnamesperssn_diff;
                    self.nf_invbest_inq_addrsperssn_diff  := nf_invbest_inq_addrsperssn_diff;
                    self.nf_invbest_inq_dobsperssn_diff   := nf_invbest_inq_dobsperssn_diff;
                    self.nf_invbest_inq_peraddr_diff      := nf_invbest_inq_peraddr_diff;
                    self.nf_invbest_inq_adlsperaddr_diff  := nf_invbest_inq_adlsperaddr_diff;
                    self.nf_invbest_inq_lastperaddr_diff  := nf_invbest_inq_lastperaddr_diff;
                    self.nf_invbest_inq_ssnsperaddr_diff  := nf_invbest_inq_ssnsperaddr_diff;
                    self.modinq_size_1                    := modinq_size_1;
                    self.modinq_size_2                    := modinq_size_2;
                    self.modinq_size_3                    := modinq_size_3;
                    self.modinq_size_4                    := modinq_size_4;
                    self.modinq_size_5                    := modinq_size_5;
                    self.modinq_size_6                    := modinq_size_6;
                    self.modinq_size_7                    := modinq_size_7;
                    self.modinq_size_8                    := modinq_size_8;
                    self.modinq_size_9                    := modinq_size_9;
                    self.modinq_size_10                   := modinq_size_10;
                    self.modinq_size_11                   := modinq_size_11;
                    self.modinq_size_12                   := modinq_size_12;
                    self.modinq_size_13                   := modinq_size_13;
                    self.modinq_size_14                   := modinq_size_14;
                    self.modinq_size_15                   := modinq_size_15;
                    self.modinq_size_16                   := modinq_size_16;
                    self.modinq_size_17                   := modinq_size_17;
                    self.modinq_size_18                   := modinq_size_18;
                    self.modinq_size_19                   := modinq_size_19;
                    self.modinq_size_20                   := modinq_size_20;
                    self.modinq_size_21                   := modinq_size_21;
                    self.modinq_size_22                   := modinq_size_22;
                    self.modinq_size_23                   := modinq_size_23;
                    self.modinq_size_24                   := modinq_size_24;
                    self.modinq_size_25                   := modinq_size_25;
                    self.modinq_size_26                   := modinq_size_26;
                    self.modinq_size_27                   := modinq_size_27;
                    self.modinq_size_28                   := modinq_size_28;
                    self.modinq_size_29                   := modinq_size_29;
                    self.modinq_size_30                   := modinq_size_30;
                    self.modinq_size_31                   := modinq_size_31;
                    self.modinq_size_32                   := modinq_size_32;
                    self.modinq_size_33                   := modinq_size_33;
                    self.modinq_size_34                   := modinq_size_34;
                    self.modinq_size_35                   := modinq_size_35;
                    self.modinq_size_36                   := modinq_size_36;
                    self.modinq_size_37                   := modinq_size_37;
                    self.modinq_size_38                   := modinq_size_38;
                    self.modinq_size_39                   := modinq_size_39;
                    self.modinq_size_40                   := modinq_size_40;
                    self.modinq_size_41                   := modinq_size_41;
                    self.modinq_size_42                   := modinq_size_42;
                    self.modinq_size_43                   := modinq_size_43;
                    self.modinq_size_44                   := modinq_size_44;
                    self.modinq_size_45                   := modinq_size_45;
                    self.modinq_size_46                   := modinq_size_46;
                    self.modinq_size_47                   := modinq_size_47;
                    self.modinq_size_48                   := modinq_size_48;
                    self.modinq_size_49                   := modinq_size_49;
                    self.modinq_size_50                   := modinq_size_50;
                    self.modinq_size_51                   := modinq_size_51;
                    self.modinq_size_52                   := modinq_size_52;
                    self.modinq_size_53                   := modinq_size_53;
                    self.modinq_size_54                   := modinq_size_54;
                    self.modinq_size_55                   := modinq_size_55;
                    self.modinq_size_56                   := modinq_size_56;
                    self.modinq_size_57                   := modinq_size_57;
                    self.modinq_size_58                   := modinq_size_58;
                    self.modinq_size_59                   := modinq_size_59;
                    self.modinq_size_60                   := modinq_size_60;
                    self.modinq_size_61                   := modinq_size_61;
                    self.modinq_size_62                   := modinq_size_62;
                    self.modinq_size_63                   := modinq_size_63;
                    self.modinq_size_64                   := modinq_size_64;
                    self.modinq_size_65                   := modinq_size_65;
                    self.modinq_size_66                   := modinq_size_66;
                    self.modinq_size_67                   := modinq_size_67;
                    self.modinq_size_68                   := modinq_size_68;
                    self.modinq_size_69                   := modinq_size_69;
                    self.modinq_size_70                   := modinq_size_70;
                    self.modinq_size_71                   := modinq_size_71;
                    self.modinq_size_72                   := modinq_size_72;
                    self.modinq_size_73                   := modinq_size_73;
                    self.modinq_size_74                   := modinq_size_74;
                    self.modinq_size_75                   := modinq_size_75;
                    self.modinq_size_76                   := modinq_size_76;
                    self.modinq_size_77                   := modinq_size_77;
                    self.modinq_size_78                   := modinq_size_78;
                    self.modinq_size_79                   := modinq_size_79;
                    self.modinq_size_80                   := modinq_size_80;
                    self.modinq_size_81                   := modinq_size_81;
                    self.modinq_size_82                   := modinq_size_82;
                    self.modinq_size_83                   := modinq_size_83;
                    self.modinq_size_84                   := modinq_size_84;
                    self.modinq_size_85                   := modinq_size_85;
                    self.modinq_size_86                   := modinq_size_86;
                    self.modinq_size_87                   := modinq_size_87;
                    self.modinq_size_88                   := modinq_size_88;
                    self.modinq_size_89                   := modinq_size_89;
                    self.modinq_size_90                   := modinq_size_90;
                    self.modinq_size_91                   := modinq_size_91;
                    self.modinq_size_92                   := modinq_size_92;
                    self.modinq_size_93                   := modinq_size_93;
                    self.modinq_size_94                   := modinq_size_94;
                    self.modinq_size_95                   := modinq_size_95;
                    self.modinq_size_96                   := modinq_size_96;
                    self.modinq_size_97                   := modinq_size_97;
                    self.modinq_size_98                   := modinq_size_98;
                    self.modinq_size_99                   := modinq_size_99;
                    self.modinq_size_100                  := modinq_size_100;
                    self.modinq_avg_path_length           := modinq_avg_path_length;
                    self.modinq_anomaly_score             := modinq_anomaly_score;
                    self.nf_fp_srchfraudsrchcountyr       := nf_fp_srchfraudsrchcountyr;
                    self._in_dob                          := _in_dob;
                    self.earliest_bureau_date             := earliest_bureau_date;
                    self.earliest_bureau_yrs              := earliest_bureau_yrs;
                    self.calc_dob                         := calc_dob;
                    self._bureau_emergence_age            := _bureau_emergence_age;
                    self.ca_bureau_emergence_age_32_59    := ca_bureau_emergence_age_32_59;
                    self.num_bureau_fname                 := num_bureau_fname;
                    self.num_bureau_lname                 := num_bureau_lname;
                    self.num_bureau_addr                  := num_bureau_addr;
                    self.num_bureau_ssn                   := num_bureau_ssn;
                    self.num_bureau_dob                   := num_bureau_dob;
                    self.iv_bureau_verification_index     := iv_bureau_verification_index;
                    self.rv_c15_ssns_per_adl_c6_v2        := rv_c15_ssns_per_adl_c6_v2;
                    self.rv_s65_ssn_prior_dob             := rv_s65_ssn_prior_dob;
                    self.rv_c15_ssns_per_adl              := rv_c15_ssns_per_adl;
                    self._rc_ssnhighissue                 := _rc_ssnhighissue;
                    self.ca_m_snc_ssn_high_issue          := ca_m_snc_ssn_high_issue;
                    self.co_tgr_fla_bureau_no_ssn         := co_tgr_fla_bureau_no_ssn;
                    self.sc_tgr_ssn_fs_6mo                := sc_tgr_ssn_fs_6mo;
                    self.sc_tgr_ssn_input_not_best        := sc_tgr_ssn_input_not_best;
                    self.sc_tgr_ssn_prior_dob             := sc_tgr_ssn_prior_dob;
                    self.co_tgr_ssns_per_adl              := co_tgr_ssns_per_adl;
                    self.co_did_count                     := co_did_count;
                    self.co_ssn_high_issue                := co_ssn_high_issue;
                    self.beta_cpn_trigger                 := beta_cpn_trigger;
                    self.rv_s66_ssns_per_adl_c6           := rv_s66_ssns_per_adl_c6;
                    self.nf_ssns_per_curraddr_curr        := nf_ssns_per_curraddr_curr;
                    self.rv_d30_derog_count               := rv_d30_derog_count;
                    self.sid_subscore0                    := sid_subscore0;
                    self.sid_subscore1                    := sid_subscore1;
                    self.sid_subscore2                    := sid_subscore2;
                    self.sid_subscore3                    := sid_subscore3;
                    self.sid_subscore4                    := sid_subscore4;
                    self.sid_subscore5                    := sid_subscore5;
                    self.sid_subscore6                    := sid_subscore6;
                    self.sid_subscore7                    := sid_subscore7;
                    self.sid_subscore8                    := sid_subscore8;
                    self.sid_rawscore                     := sid_rawscore;
                    self.sid_lnoddsscore                  := sid_lnoddsscore;
                    self.sid_probscore                    := sid_probscore;
                    self.cust_auto_synthid_score          := cust_auto_synthid_score;
                    self.fp1704_1_0_synthidindex          := fp1704_1_0_synthidindex;
                    self.cpn_subscore0                    := cpn_subscore0;
                    self.cpn_subscore1                    := cpn_subscore1;
                    self.cpn_subscore2                    := cpn_subscore2;
                    self.cpn_subscore3                    := cpn_subscore3;
                    self.cpn_subscore4                    := cpn_subscore4;
                    self.cpn_rawscore                     := cpn_rawscore;
                    self.cpn_lnoddsscore                  := cpn_lnoddsscore;
                    self.cpn_probscore                    := cpn_probscore;
                    self.base                             := base;
                    self.pdo                              := pdo;
                    self.odds                             := odds;
                    self.cust_auto_cpn_score              := cust_auto_cpn_score;
                    self.fp1704_1_0_suspactindex          := fp1704_1_0_suspactindex;

	 SELF.clam := le;
#end

	 self.seq := le.seq;
	
	 self.SyntheticIdentityIndex:= (string)fp1704_1_0_synthidindex;

	 self.SuspiciousActivityIndex := (string)fp1704_1_0_suspactindex;

	 self := [];
	
END;

model :=   project(clam, doModel(left) );
	
	return model;
END;


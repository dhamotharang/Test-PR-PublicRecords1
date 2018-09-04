import Std, risk_indicators, riskwise, riskwisefcra, ut, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1710_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		// FP_DEBUG := True;
		FP_DEBUG := False;    //***Make sure this is set to FALSE before promoting this to PROD
		ROUND1VALIDATION := False;
		// ROUND1VALIDATION := False;   //***Make sure this is set to FALSE before promoting this to PROD
		isFCRA := False;

	#if(FP_DEBUG)
Layout_Debug := RECORD
  /* Layout of the Debug/Validation record */
STRING10 model_name;
unsigned4 seq;
INTEGER sysdate;
INTEGER ver_src_ak_pos;
STRING _ver_src_fdate_ak;
INTEGER ver_src_fdate_ak;
INTEGER ver_src_am_pos;
BOOLEAN ver_src_am;
STRING _ver_src_fdate_am;
INTEGER ver_src_fdate_am;
INTEGER ver_src_ar_pos;
BOOLEAN ver_src_ar;
STRING _ver_src_fdate_ar;
INTEGER ver_src_fdate_ar;
INTEGER ver_src_ba_pos;
BOOLEAN ver_src_ba;
STRING _ver_src_fdate_ba;
INTEGER ver_src_fdate_ba;
INTEGER ver_src_cg_pos;
BOOLEAN ver_src_cg;
STRING _ver_src_fdate_cg;
INTEGER ver_src_fdate_cg;
INTEGER ver_src_co_pos;
STRING _ver_src_fdate_co;
INTEGER ver_src_fdate_co;
INTEGER ver_src_cy_pos;
STRING _ver_src_fdate_cy;
INTEGER ver_src_fdate_cy;
INTEGER ver_src_da_pos;
BOOLEAN ver_src_da;
STRING _ver_src_fdate_da;
INTEGER ver_src_fdate_da;
INTEGER ver_src_d_pos;
BOOLEAN ver_src_d;
STRING _ver_src_fdate_d;
INTEGER ver_src_fdate_d;
BOOLEAN ver_src_dl_pos;
BOOLEAN ver_src_dl;
STRING _ver_src_fdate_dl;
INTEGER ver_src_fdate_dl;
BOOLEAN ver_src_ds_pos;
STRING _ver_src_fdate_ds;
INTEGER ver_src_fdate_ds;
BOOLEAN ver_src_de_pos;
STRING _ver_src_fdate_de;
INTEGER ver_src_fdate_de;
INTEGER ver_src_eb_pos;
BOOLEAN ver_src_eb;
STRING _ver_src_fdate_eb;
INTEGER ver_src_fdate_eb;
INTEGER ver_src_em_pos;
STRING _ver_src_fdate_em;
INTEGER ver_src_fdate_em;
INTEGER ver_src_e1_pos;
BOOLEAN ver_src_e1;
STRING _ver_src_fdate_e1;
INTEGER ver_src_fdate_e1;
INTEGER ver_src_e2_pos;
BOOLEAN ver_src_e2;
STRING _ver_src_fdate_e2;
INTEGER ver_src_fdate_e2;
INTEGER ver_src_e3_pos;
BOOLEAN ver_src_e3;
STRING _ver_src_fdate_e3;
INTEGER ver_src_fdate_e3;
INTEGER ver_src_e4_pos;
STRING _ver_src_fdate_e4;
INTEGER ver_src_fdate_e4;
INTEGER ver_src_en_pos;
BOOLEAN ver_src_en;
STRING _ver_src_fdate_en;
INTEGER ver_src_fdate_en;
INTEGER ver_src_eq_pos;
BOOLEAN ver_src_eq;
STRING _ver_src_fdate_eq;
INTEGER ver_src_fdate_eq;
INTEGER ver_src_fe_pos;
BOOLEAN ver_src_fe;
STRING _ver_src_fdate_fe;
INTEGER ver_src_fdate_fe;
INTEGER ver_src_ff_pos;
BOOLEAN ver_src_ff;
STRING _ver_src_fdate_ff;
INTEGER ver_src_fdate_ff;
INTEGER ver_src_fr_pos;
STRING _ver_src_fdate_fr;
INTEGER ver_src_fdate_fr;
INTEGER ver_src_l2_pos;
STRING _ver_src_fdate_l2;
INTEGER ver_src_fdate_l2;
INTEGER ver_src_li_pos;
STRING _ver_src_fdate_li;
INTEGER ver_src_fdate_li;
INTEGER ver_src_mw_pos;
STRING _ver_src_fdate_mw;
INTEGER ver_src_fdate_mw;
INTEGER ver_src_nt_pos;
STRING _ver_src_fdate_nt;
INTEGER ver_src_fdate_nt;
INTEGER ver_src_p_pos;
BOOLEAN ver_src_p;
STRING _ver_src_fdate_p;
INTEGER ver_src_fdate_p;
BOOLEAN ver_src_pl_pos;
BOOLEAN ver_src_pl;
STRING _ver_src_fdate_pl;
INTEGER ver_src_fdate_pl;
INTEGER ver_src_tn_pos;
BOOLEAN ver_src_tn;
STRING _ver_src_fdate_tn;
INTEGER ver_src_fdate_tn;
INTEGER ver_src_ts_pos;
STRING _ver_src_fdate_ts;
INTEGER ver_src_fdate_ts;
INTEGER ver_src_tu_pos;
STRING _ver_src_fdate_tu;
INTEGER ver_src_fdate_tu;
INTEGER ver_src_sl_pos;
BOOLEAN ver_src_sl;
STRING _ver_src_fdate_sl;
INTEGER ver_src_fdate_sl;
INTEGER ver_src_v_pos;
BOOLEAN ver_src_v;
STRING _ver_src_fdate_v;
INTEGER ver_src_fdate_v;
BOOLEAN ver_src_vo_pos;
BOOLEAN ver_src_vo;
STRING _ver_src_fdate_vo;
INTEGER ver_src_fdate_vo;
INTEGER ver_src_w_pos;
BOOLEAN ver_src_w;
STRING _ver_src_fdate_w;
INTEGER ver_src_fdate_w;
BOOLEAN ver_src_wp_pos;
STRING _ver_src_fdate_wp;
INTEGER ver_src_fdate_wp;
INTEGER ver_dob_src_en_pos;
BOOLEAN ver_dob_src_en;
INTEGER ver_dob_src_eq_pos;
BOOLEAN ver_dob_src_eq;
INTEGER ver_dob_src_tn_pos;
BOOLEAN ver_dob_src_tn;
INTEGER rv_s65_ssn_problem;
INTEGER _rc_ssnhighissue;
INTEGER nf_m_snc_ssn_high_issue;
STRING rv_p86_hi_risk_phone_type;
INTEGER rv_d30_derog_count;
INTEGER rv_d31_attr_bankruptcy_recency;
INTEGER rv_d33_eviction_recency;
INTEGER rv_c13_curr_addr_lres;
INTEGER rv_i61_inq_collection_recency;
INTEGER rv_i60_inq_mortgage_recency;
INTEGER rv_i60_inq_hiriskcred_recency;
INTEGER rv_i60_inq_prepaidcards_recency;
INTEGER rv_i60_inq_retail_recency;
INTEGER rv_i60_inq_comm_recency;
INTEGER rv_i60_inq_other_recency;
INTEGER nf_inq_phone_ver_count;
INTEGER nf_inquiry_verification_index;
INTEGER nf_inquiry_ssn_vel_risk_index;
INTEGER nf_inquiry_addr_vel_risk_index;
INTEGER nf_inq_communications_count24;
INTEGER nf_inq_other_count24;
INTEGER rv_d34_attr_unrel_liens_recency;
BOOLEAN iv_nap_phn_verd;
INTEGER iv_input_best_ssn_match;
INTEGER rv_bus_addr_only_curr;
STRING rv_e58_br_dead_bus_x_active_phn;
STRING iv_college_tier;
STRING iv_prof_license_category_pl;
INTEGER nf_attr_arrests;
INTEGER _liens_unrel_sc_first_seen;
INTEGER nf_mos_liens_unrel_sc_fseen;
INTEGER _foreclosure_last_date;
INTEGER nf_mos_foreclosure_lseen;
STRING nf_historic_x_current_ct;
INTEGER nf_fp_srchfraudsrchcountyr;
INTEGER nf_fp_srchcomponentrisktype;
STRING nf_fp_prevaddroccupantowned;
INTEGER num_dob_sources;
INTEGER iv_dob_bureau_only;
INTEGER earliest_header_date;
INTEGER earliest_header_yrs;
INTEGER _in_dob;
INTEGER calc_dob;
INTEGER iv_header_emergence_age;
INTEGER iv_ssnsperadl_ssnunver;
INTEGER corrssndob_src_ak_pos;
BOOLEAN corrssndob_src_ak;
INTEGER corrssndob_src_am_pos;
BOOLEAN corrssndob_src_am;
INTEGER corrssndob_src_ar_pos;
BOOLEAN corrssndob_src_ar;
INTEGER corrssndob_src_ba_pos;
BOOLEAN corrssndob_src_ba;
INTEGER corrssndob_src_cg_pos;
BOOLEAN corrssndob_src_cg;
INTEGER corrssndob_src_co_pos;
BOOLEAN corrssndob_src_co;
INTEGER corrssndob_src_cy_pos;
BOOLEAN corrssndob_src_cy;
INTEGER corrssndob_src_da_pos;
BOOLEAN corrssndob_src_da;
INTEGER corrssndob_src_d_pos;
BOOLEAN corrssndob_src_d;
BOOLEAN corrssndob_src_dl_pos;
BOOLEAN corrssndob_src_dl;
BOOLEAN corrssndob_src_ds_pos;
BOOLEAN corrssndob_src_ds;
BOOLEAN corrssndob_src_de_pos;
BOOLEAN corrssndob_src_de;
INTEGER corrssndob_src_eb_pos;
BOOLEAN corrssndob_src_eb;
INTEGER corrssndob_src_em_pos;
BOOLEAN corrssndob_src_em;
INTEGER corrssndob_src_e1_pos;
BOOLEAN corrssndob_src_e1;
INTEGER corrssndob_src_e2_pos;
BOOLEAN corrssndob_src_e2;
INTEGER corrssndob_src_e3_pos;
BOOLEAN corrssndob_src_e3;
INTEGER corrssndob_src_e4_pos;
BOOLEAN corrssndob_src_e4;
INTEGER corrssndob_src_en_pos;
BOOLEAN corrssndob_src_en;
INTEGER corrssndob_src_eq_pos;
BOOLEAN corrssndob_src_eq;
INTEGER corrssndob_src_fe_pos;
BOOLEAN corrssndob_src_fe;
INTEGER corrssndob_src_ff_pos;
BOOLEAN corrssndob_src_ff;
INTEGER corrssndob_src_fr_pos;
BOOLEAN corrssndob_src_fr;
INTEGER corrssndob_src_l2_pos;
BOOLEAN corrssndob_src_l2;
INTEGER corrssndob_src_li_pos;
BOOLEAN corrssndob_src_li;
INTEGER corrssndob_src_mw_pos;
BOOLEAN corrssndob_src_mw;
INTEGER corrssndob_src_nt_pos;
BOOLEAN corrssndob_src_nt;
INTEGER corrssndob_src_p_pos;
BOOLEAN corrssndob_src_p;
BOOLEAN corrssndob_src_pl_pos;
BOOLEAN corrssndob_src_pl;
INTEGER corrssndob_src_tn_pos;
BOOLEAN corrssndob_src_tn;
INTEGER corrssndob_src_ts_pos;
BOOLEAN corrssndob_src_ts;
INTEGER corrssndob_src_tu_pos;
BOOLEAN corrssndob_src_tu;
INTEGER corrssndob_src_sl_pos;
BOOLEAN corrssndob_src_sl;
INTEGER corrssndob_src_v_pos;
BOOLEAN corrssndob_src_v;
BOOLEAN corrssndob_src_vo_pos;
BOOLEAN corrssndob_src_vo;
INTEGER corrssndob_src_w_pos;
BOOLEAN corrssndob_src_w;
BOOLEAN corrssndob_src_wp_pos;
BOOLEAN corrssndob_src_wp;
INTEGER corrssndob_ct;
INTEGER nf_corrssndob;
INTEGER nf_factact_curr_fraud_alert;
REAL mod1_v01_w;
REAL mod1_v02_w;
REAL mod1_v03_w;
REAL mod1_v04_w;
REAL mod1_v05_w;
REAL mod1_v06_w;
REAL mod1_v07_w;
REAL mod1_v08_w;
REAL mod1_v09_w;
REAL mod1_v10_w;
REAL mod1_v11_w;
REAL mod1_v12_w;
REAL mod1_v13_w;
REAL mod1_v14_w;
REAL mod1_v15_w;
REAL mod1_v16_w;
REAL mod1_v17_w;
REAL mod1_v18_w;
REAL mod1_v19_w;
REAL mod1_v20_w;
REAL mod1_v21_w;
REAL mod1_v22_w;
REAL mod1_v23_w;
REAL mod1_v24_w;
REAL mod1_v25_w;
REAL mod1_v26_w;
REAL mod1_v27_w;
REAL mod1_v28_w;
REAL mod1_v29_w;
REAL mod1_v30_w;
REAL mod1_v31_w;
REAL mod1_v32_w;
REAL mod1_v33_w;
REAL mod1_v34_w;
REAL mod1_v35_w;
REAL mod1_v36_w;
REAL mod1_v37_w;
REAL mod1_v38_w;
REAL mod1_v39_w;
REAL mod1_lgt;
INTEGER base;
INTEGER pts;
REAL lgt;
INTEGER fp1710_1_0_nooverrides;
BOOLEAN or_decssn;
BOOLEAN or_ssnpriordob;
BOOLEAN or_prisonaddr;
BOOLEAN or_prisonphone;
BOOLEAN or_hraddr;
BOOLEAN or_hrphone;
BOOLEAN or_invalidssn;
BOOLEAN or_invalidaddr;
BOOLEAN or_invalidphone;
INTEGER fp1710_1_0_score;
INTEGER fp1710_1_0;
BOOLEAN _ver_src_ds;
BOOLEAN _ver_src_de;
BOOLEAN _derog;
BOOLEAN _deceased;
BOOLEAN _ssnpriortodob;
BOOLEAN _inputmiskeys;
BOOLEAN _multiplessns;
INTEGER _hh_strikes;
INTEGER stolenid;
INTEGER manipulatedid;
INTEGER manipulatedidpt2;
INTEGER rv_a41_prop_owner;
INTEGER _sum_bureau;
INTEGER _sum_credentialed;
BOOLEAN syntheticid;
INTEGER suspiciousactivity;
INTEGER vulnerablevictim;
INTEGER friendlyfraud;
INTEGER stolenc_redev;
INTEGER manip2c_redev;
INTEGER synthc_redev;
INTEGER suspactc_redev;
INTEGER vulnvicc_redev;
INTEGER friendlyc_redev;
INTEGER custstolidindex;
INTEGER custmanipidindex;
INTEGER custsynthidindex;
INTEGER custsuspactindex;
INTEGER custvulnvicindex;
INTEGER custfriendfrdindex;

models.layouts.layout_fp1109;
Risk_Indicators.Layout_Boca_Shell clam;
END;
			
    layout_debug doModel( clam le ) := TRANSFORM
#else
    models.layouts.layout_fp1109 doModel( clam le ) := TRANSFORM
		
#end	
		

		
  /* Input Variable Assignments  */
	
	input_ssn_isbestmatch            := le.best_flags.input_ssn_isbestmatch;
	bus_addr_only_curr               := le.Address_Verification.bus_addr_only_curr;
	corrssndob_sources               := le.header_summary.corrssndob_sources;
	factact_curr_fraud_alert         := le.eqfx_fraudflags.factact_curr_fraud_alert;
	truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_ssnhighissue                  := (unsigned)le.iid.soclhighissue;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_hrisksicphone                 := le.iid.hrisksicphone;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;   //***this is a boolean
	hphnpop                          := le.input_validation.homephone;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_lres                    := le.lres2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_prison_history             := le.other_address_info.isprison;
	telcordia_type                   := le.phone_verification.telcordia_type;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	//lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl)_created_6months;
	//lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl);
  lnames_per_adl_c6                :=   if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_ssns_per_adl_c6          := le.velocity_counters.invalid_ssns_per_adl_created_6months;
	inq_addr_ver_count               := le.acc_logs.inquiry_addr_ver_ct;
	inq_fname_ver_count              := le.acc_logs.inquiry_fname_ver_ct;
	inq_lname_ver_count              := le.acc_logs.inquiry_lname_ver_ct;
	inq_ssn_ver_count                := le.acc_logs.inquiry_ssn_ver_ct;
	inq_dob_ver_count                := le.acc_logs.inquiry_dob_ver_ct;
	inq_phone_ver_count              := le.acc_logs.inquiry_phone_ver_ct;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_mortgage_count               := le.acc_logs.mortgage.counttotal;
	inq_mortgage_count01             := le.acc_logs.mortgage.count01;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_mortgage_count06             := le.acc_logs.mortgage.count06;
	inq_mortgage_count12             := le.acc_logs.mortgage.count12;
	inq_mortgage_count24             := le.acc_logs.mortgage.count24;
	inq_other_count                  := le.acc_logs.other.counttotal;
	inq_other_count01                := le.acc_logs.other.count01;
	inq_other_count03                := le.acc_logs.other.count03;
	inq_other_count06                := le.acc_logs.other.count06;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
	inq_retail_count                 := le.acc_logs.retail.counttotal;
	inq_retail_count01               := le.acc_logs.retail.count01;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_retail_count06               := le.acc_logs.retail.count06;
	inq_retail_count12               := le.acc_logs.retail.count12;
	inq_retail_count24               := le.acc_logs.retail.count24;
	inq_adlsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryADLsPerSSN );
	inq_lnamesperssn                 := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerSSN );
	inq_addrsperssn                  := if(isFCRA, 0, le.acc_logs.inquiryAddrsPerSSN );
	inq_dobsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryDOBsPerSSN );
	inq_adlsperaddr                  := if(isFCRA, 0, le.acc_logs.inquiryADLsPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
	br_dead_business_count           := le.employment.dead_business_ct;
	br_active_phone_count            := le.employment.business_active_phone_ct;
	stl_inq_count                    := le.impulse.count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_arrests                     := le.bjl.arrests_count;
	attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
	attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
	attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
	attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
	attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
	attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_bankruptcy_count30          := le.bjl.bk_count30;
	attr_bankruptcy_count90          := le.bjl.bk_count90;
	attr_bankruptcy_count180         := le.bjl.bk_count180;
	attr_bankruptcy_count12          := le.bjl.bk_count12;
	attr_bankruptcy_count24          := le.bjl.bk_count24;
	attr_bankruptcy_count36          := le.bjl.bk_count36;
	attr_bankruptcy_count60          := le.bjl.bk_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_prevaddroccupantowned         := le.fdattributesv2.prevaddroccupantowned;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	//liens_historical_unreleased_ct   := le.liens_historical_unreleased_count; 
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count; 
	liens_unrel_sc_first_seen        := le.liens.liens_unreleased_small_claims.earliest_filing_date;
	felony_count                     := le.bjl.felony_count;
	foreclosure_last_date            := le.bjl.last_foreclosure_date;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_criminals                     := le.hhid_summary.hh_criminals;
	rel_felony_count                 := le.relatives.relative_felony_count;
	current_count                    := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	college_tier                     := le.student.college_tier;
	prof_license_category            := le.professional_license.plcategory;
	prof_license_source              := le.professional_license.proflic_source;
	inferred_age                     := le.inferred_age;

 /*  Start of the ECL code that was converted from SAS code  */
 
 NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

//============================================================================================ 
//===   for round 1 validation set the sysdate to the same value seen in the validation file
#if(ROUND1VALIDATION)
     sysdate := common.sas_date('20160501');	 
#else
    sysdate := common.sas_date(if(le.historydate=999999, (    STRING)ut.getdate, (    STRING6)le.historydate+'01'));
#end
//========================================================================================

ver_src_ak_pos := Models.Common.findw_cpp(ver_sources, 'AK' , '  ,', 'ie');

_ver_src_fdate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), '0');

ver_src_fdate_ak := common.sas_date((string)(_ver_src_fdate_ak));

ver_src_am_pos := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');

ver_src_am := ver_src_am_pos > 0;

_ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0');

ver_src_fdate_am := common.sas_date((string)(_ver_src_fdate_am));

ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');

ver_src_ar := ver_src_ar_pos > 0;

_ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0');

ver_src_fdate_ar := common.sas_date((string)(_ver_src_fdate_ar));

ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

ver_src_ba := ver_src_ba_pos > 0;

_ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0');

ver_src_fdate_ba := common.sas_date((string)(_ver_src_fdate_ba));

ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');

ver_src_cg := ver_src_cg_pos > 0;

_ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0');

ver_src_fdate_cg := common.sas_date((string)(_ver_src_fdate_cg));

ver_src_co_pos := Models.Common.findw_cpp(ver_sources, 'CO' , '  ,', 'ie');

_ver_src_fdate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0');

ver_src_fdate_co := common.sas_date((string)(_ver_src_fdate_co));

ver_src_cy_pos := Models.Common.findw_cpp(ver_sources, 'CY' , '  ,', 'ie');

_ver_src_fdate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), '0');

ver_src_fdate_cy := common.sas_date((string)(_ver_src_fdate_cy));

ver_src_da_pos := Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie');

ver_src_da := ver_src_da_pos > 0;

_ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0');

ver_src_fdate_da := common.sas_date((string)(_ver_src_fdate_da));

ver_src_d_pos := Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie');

ver_src_d := ver_src_d_pos > 0;

_ver_src_fdate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0');

ver_src_fdate_d := common.sas_date((string)(_ver_src_fdate_d));

ver_src_dl_pos := Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie');

ver_src_dl := ver_src_dl_pos > 0;

_ver_src_fdate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0');

ver_src_fdate_dl := common.sas_date((string)(_ver_src_fdate_dl));

ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');

_ver_src_fdate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), '0');

ver_src_fdate_ds := common.sas_date((string)(_ver_src_fdate_ds));

ver_src_de_pos := Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie');

_ver_src_fdate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), '0');

ver_src_fdate_de := common.sas_date((string)(_ver_src_fdate_de));

ver_src_eb_pos := Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie');

ver_src_eb := ver_src_eb_pos > 0;

_ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0');

ver_src_fdate_eb := common.sas_date((string)(_ver_src_fdate_eb));

ver_src_em_pos := Models.Common.findw_cpp(ver_sources, 'EM' , '  ,', 'ie');

_ver_src_fdate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), '0');

ver_src_fdate_em := common.sas_date((string)(_ver_src_fdate_em));

ver_src_e1_pos := Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie');

ver_src_e1 := ver_src_e1_pos > 0;

_ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0');

ver_src_fdate_e1 := common.sas_date((string)(_ver_src_fdate_e1));

ver_src_e2_pos := Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie');

ver_src_e2 := ver_src_e2_pos > 0;

_ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0');

ver_src_fdate_e2 := common.sas_date((string)(_ver_src_fdate_e2));

ver_src_e3_pos := Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie');

ver_src_e3 := ver_src_e3_pos > 0;

_ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0');

ver_src_fdate_e3 := common.sas_date((string)(_ver_src_fdate_e3));

ver_src_e4_pos := Models.Common.findw_cpp(ver_sources, 'E4' , '  ,', 'ie');

_ver_src_fdate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), '0');

ver_src_fdate_e4 := common.sas_date((string)(_ver_src_fdate_e4));

ver_src_en_pos := Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie');

ver_src_en := ver_src_en_pos > 0;

_ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

ver_src_fdate_en := common.sas_date((string)(_ver_src_fdate_en));

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');

ver_src_eq := ver_src_eq_pos > 0;

_ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_fdate_eq := common.sas_date((string)(_ver_src_fdate_eq));

ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie');

ver_src_fe := ver_src_fe_pos > 0;

_ver_src_fdate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0');

ver_src_fdate_fe := common.sas_date((string)(_ver_src_fdate_fe));

ver_src_ff_pos := Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie');

ver_src_ff := ver_src_ff_pos > 0;

_ver_src_fdate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0');

ver_src_fdate_ff := common.sas_date((string)(_ver_src_fdate_ff));

ver_src_fr_pos := Models.Common.findw_cpp(ver_sources, 'FR' , '  ,', 'ie');

_ver_src_fdate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0');

ver_src_fdate_fr := common.sas_date((string)(_ver_src_fdate_fr));

ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');

_ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0');

ver_src_fdate_l2 := common.sas_date((string)(_ver_src_fdate_l2));

ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');

_ver_src_fdate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0');

ver_src_fdate_li := common.sas_date((string)(_ver_src_fdate_li));

ver_src_mw_pos := Models.Common.findw_cpp(ver_sources, 'MW' , '  ,', 'ie');

_ver_src_fdate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0');

ver_src_fdate_mw := common.sas_date((string)(_ver_src_fdate_mw));

ver_src_nt_pos := Models.Common.findw_cpp(ver_sources, 'NT' , '  ,', 'ie');

_ver_src_fdate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), '0');

ver_src_fdate_nt := common.sas_date((string)(_ver_src_fdate_nt));

ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');

ver_src_p := ver_src_p_pos > 0;

_ver_src_fdate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0');

ver_src_fdate_p := common.sas_date((string)(_ver_src_fdate_p));

ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');

ver_src_pl := ver_src_pl_pos > 0;

_ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0');

ver_src_fdate_pl := common.sas_date((string)(_ver_src_fdate_pl));

ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie');

ver_src_tn := ver_src_tn_pos > 0;

_ver_src_fdate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0');

ver_src_fdate_tn := common.sas_date((string)(_ver_src_fdate_tn));

ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, 'TS' , '  ,', 'ie');

_ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0');

ver_src_fdate_ts := common.sas_date((string)(_ver_src_fdate_ts));

ver_src_tu_pos := Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie');

_ver_src_fdate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0');

ver_src_fdate_tu := common.sas_date((string)(_ver_src_fdate_tu));

ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie');

ver_src_sl := ver_src_sl_pos > 0;

_ver_src_fdate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0');

ver_src_fdate_sl := common.sas_date((string)(_ver_src_fdate_sl));

ver_src_v_pos := Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie');

ver_src_v := ver_src_v_pos > 0;

_ver_src_fdate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0');

ver_src_fdate_v := common.sas_date((string)(_ver_src_fdate_v));

ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie');

ver_src_vo := ver_src_vo_pos > 0;

_ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0');

ver_src_fdate_vo := common.sas_date((string)(_ver_src_fdate_vo));

ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');

ver_src_w := ver_src_w_pos > 0;

_ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0');

ver_src_fdate_w := common.sas_date((string)(_ver_src_fdate_w));

ver_src_wp_pos := Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie');

_ver_src_fdate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0');

ver_src_fdate_wp := common.sas_date((string)(_ver_src_fdate_wp));

ver_dob_src_en_pos := Models.Common.findw_cpp(ver_dob_sources, 'EN' , '  ,', 'ie');

ver_dob_src_en := ver_dob_src_en_pos > 0;

ver_dob_src_eq_pos := Models.Common.findw_cpp(ver_dob_sources, 'EQ' , '  ,', 'ie');

ver_dob_src_eq := ver_dob_src_eq_pos > 0;

ver_dob_src_tn_pos := Models.Common.findw_cpp(ver_dob_sources, 'TN' , '  ,', 'ie');

ver_dob_src_tn := ver_dob_src_tn_pos > 0;

rv_s65_ssn_problem := map(
    ((Integer)ssnlength < 1)                                                                  => NULL,
    dobpop and (rc_ssndobflag = '1' or rc_pwssndobflag = '1') or 
		   truedid and invalid_ssns_per_adl >= 2 or truedid and invalid_ssns_per_adl_c6 >= 1      => 2,
			 
    rc_decsflag = '1' or contains_i(ver_sources, 'DE') > 0 or 
		   contains_i(ver_sources, 'DS') > 0 or rc_ssnvalflag = '1' or 
		   (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) or 
		   truedid and invalid_ssns_per_adl >= 1                                                  => 1,
			 
    rc_decsflag = '0' or dobpop and (rc_ssndobflag = '0' or rc_pwssndobflag = '0') or 
		   rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or 
		   (inputssncharflag in ['0', '4', '5']) or truedid and invalid_ssns_per_adl = 0 or 
		   truedid and invalid_ssns_per_adl_c6 = 0                                                => 0,
                                                                                                 NULL);

_rc_ssnhighissue := common.sas_date((string)(rc_ssnhighissue));

nf_m_snc_ssn_high_issue := map(
    not((Integer)ssnlength > 0)      => NULL,
    _rc_ssnhighissue = NULL => -1,
                               min(if(if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _rc_ssnhighissue) / (365.25 / 12) >= 0, truncate((sysdate - _rc_ssnhighissue) / (365.25 / 12)), roundup((sysdate - _rc_ssnhighissue) / (365.25 / 12)))), 999));

rv_p86_hi_risk_phone_type := map(
    not(hphnpop)                                                                                                                                                                                                                                            => '',
    rc_hrisksicphone = '2225'                                                                                                                                                                                                                                 => 'CORRECTIONS',
    trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = 'B'                                                                                                                                                                                                  => 'FAX',
    trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = 'A'                                                                                                                                                                                                  => 'PAY PHONE',
    rc_hriskphoneflag = '2' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '2' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '02' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '56' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '61' => 'PAGER',
                                                                                                                                                                                                                                                               'LAND/CELL');

rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

rv_d31_attr_bankruptcy_recency := map(
    not(truedid)             => NULL,
    (boolean)attr_bankruptcy_count30  => 1,
    (boolean)attr_bankruptcy_count90  => 3,
    (boolean)attr_bankruptcy_count180 => 6,
    (boolean)attr_bankruptcy_count12  => 12,
    (boolean)attr_bankruptcy_count24  => 24,
    (boolean)attr_bankruptcy_count36  => 36,
    (boolean)attr_bankruptcy_count60  => 60,
    bankrupt                 => 99,
    filing_count > 0         => 99,
                                0);

rv_d33_eviction_recency := map(
    not(truedid)                                                         => NULL,
    (boolean)attr_eviction_count90                                       => 3,
    (boolean)attr_eviction_count180                                      => 6,
    (boolean)attr_eviction_count12                                       => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2          => 24,
    (boolean)attr_eviction_count24                                       => 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2          => 36,
    (boolean)attr_eviction_count36                                       => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2          => 60,
    (boolean)attr_eviction_count60                                       => 61,
    attr_eviction_count >= 2                                             => 98,
    attr_eviction_count >= 1                                             => 99,
                                                                         0);

rv_c13_curr_addr_lres := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

rv_i61_inq_collection_recency := map(
    not(truedid)           => NULL,
    (boolean)inq_collection_count01 => 1,
    (boolean)inq_collection_count03 => 3,
    (boolean)inq_collection_count06 => 6,
    (boolean)inq_collection_count12 => 12,
    (boolean)inq_collection_count24 => 24,
    (boolean)inq_collection_count   => 99,
                                     0);

rv_i60_inq_mortgage_recency := map(
    not(truedid)         => NULL,
    (boolean)inq_mortgage_count01 => 1,
    (boolean)inq_mortgage_count03 => 3,
    (boolean)inq_mortgage_count06 => 6,
    (boolean)inq_mortgage_count12 => 12,
    (boolean)inq_mortgage_count24 => 24,
    (boolean)inq_mortgage_count   => 99,
                            0);

rv_i60_inq_hiriskcred_recency := map(
    not(truedid)               => NULL,
    (boolean)inq_highRiskCredit_count01 => 1,
    (boolean)inq_highRiskCredit_count03 => 3,
    (boolean)inq_highRiskCredit_count06 => 6,
    (boolean)inq_highRiskCredit_count12 => 12,
    (boolean)inq_highriskcredit_count24 => 24,
    (boolean)inq_highRiskCredit_count   => 99,
                                  0);

rv_i60_inq_prepaidcards_recency := map(
    not(truedid)             => NULL,
    (boolean)inq_PrepaidCards_count01 => 1,
    (boolean)inq_PrepaidCards_count03 => 3,
    (boolean)inq_PrepaidCards_count06 => 6,
    (boolean)inq_PrepaidCards_count12 => 12,
    (boolean)inq_PrepaidCards_count24 => 24,
    (boolean)inq_PrepaidCards_count   => 99,
                                0);

rv_i60_inq_retail_recency := map(
    not(truedid)       => NULL,
    (boolean)inq_retail_count01 => 1,
    (boolean)inq_retail_count03 => 3,
    (boolean)inq_retail_count06 => 6,
    (boolean)inq_retail_count12 => 12,
    (boolean)inq_retail_count24 => 24,
    (boolean)inq_retail_count   => 99,
                                  0);

rv_i60_inq_comm_recency := map(
    not(truedid)               => NULL,
    (boolean)inq_communications_count01 => 1,
    (boolean)inq_communications_count03 => 3,
    (boolean)inq_communications_count06 => 6,
    (boolean)inq_communications_count12 => 12,
    (boolean)inq_communications_count24 => 24,
    (boolean)inq_communications_count   => 99,
                                  0);

rv_i60_inq_other_recency := map(
    not(truedid)      => NULL,
    (boolean)inq_other_count01 => 1,
    (boolean)inq_other_count03 => 3,
    (boolean)inq_other_count06 => 6,
    (boolean)inq_other_count12 => 12,
    (boolean)inq_other_count24 => 24,
    (boolean)inq_other_count   => 99,
                                  0);

nf_inq_phone_ver_count := if(not(truedid) or inq_phone_ver_count = 255, NULL, inq_phone_ver_count);

nf_inquiry_verification_index := if(not(truedid), NULL, 
                                 if(max((integer)(max((integer)(inq_fname_ver_count < 255), (integer)(inq_lname_ver_count < 255)) > 0), 
																                     2 * (integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255), 
																										 4 * (integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255), 
																										 8 * (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255), 
																										 16 * (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255)) = NULL, NULL, 
																sum(if( (integer)(max((integer)(inq_fname_ver_count < 255), (integer)inq_lname_ver_count < 255) > 0) = NULL, 0, 
																   (integer)(max((integer)(inq_fname_ver_count < 255), (integer)(integer)inq_lname_ver_count < 255) > 0)), 
																	 if(2 * (integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255) = NULL, 0, 2 * (integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255)), 
																	 if(4 * (integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255) = NULL, 0, 4 * (integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255)), 
																	 if(8 * (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255) = NULL, 0, 8 * (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255)), 
																	 if(16 * (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255) = NULL, 0, 16 * (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255)))));

// nf_inquiry_verification_index :=  __common__( (STRING)if(not(truedid), NULL, 
                                 // if(max((integer)(max((integer)(inq_fname_ver_count < 255), (integer)(inq_lname_ver_count < 255)) > 0), 
                                                      // 2* (integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255), 
                                                      // 4* (integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255), 
                                                      // 8* (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255), 
                                                     // 16* (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255)) = NULL, NULL,
                             // sum(if( (integer)(max((integer)(inq_fname_ver_count < 255), (integer)inq_lname_ver_count < 255) > 0) = NULL, 0, 
                                    // (integer)(max((integer)(inq_fname_ver_count < 255), (integer)(integer)inq_lname_ver_count < 255) > 0)), 
                                    // if(2* (integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255) = NULL, 0, 2*(integer)(0 < inq_phone_ver_count AND inq_phone_ver_count < 255)), 
                                    // if(4* (integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255) = NULL, 0,   4*(integer)(0 < inq_addr_ver_count AND inq_addr_ver_count < 255)), 
                                    // if(8* (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255) = NULL, 0,     8* (integer)(0 < inq_dob_ver_count AND inq_dob_ver_count < 255)), 
                                    // if(16* (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255) = NULL, 0,    16* (integer)(0 < inq_ssn_ver_count AND inq_ssn_ver_count < 255))))));






ssnlengthNot49   :=   ssnlength NOT IN ['4', '9'];  
//nf_inquiry_ssn_vel_risk_index := if((not((boolean)(integer)ssnlength) in [4, 9]), -1, 
nf_inquiry_ssn_vel_risk_index := if(ssnlengthNot49, -1, 
                                      if(max((integer)(inq_adlsperssn > 1), 2 * (integer)(inq_lnamesperssn > 1), 4 * (integer)(inq_addrsperssn > 2), 8 * (integer)(inq_dobsperssn > 1)) = NULL, NULL, 
																			   sum(if((integer)(inq_adlsperssn > 1) = NULL, 0, (integer)(inq_adlsperssn > 1)), 
																				     if(2 * (integer)(inq_lnamesperssn > 1) = NULL, 0, 2 * (integer)(inq_lnamesperssn > 1)), 
																						 if(4 * (integer)(inq_addrsperssn > 2) = NULL, 0, 4 * (integer)(inq_addrsperssn > 2)), 
																						 if(8 * (integer)(inq_dobsperssn > 1) = NULL, 0, 8 * (integer)(inq_dobsperssn > 1)))));

nf_inquiry_addr_vel_risk_index := if(not(addrpop), -1, 
                                      if(max((integer)(inq_adlsperaddr > 2), 2 * (integer)(inq_lnamesperaddr > 2), 4 * (integer)(inq_ssnsperaddr > 2)) = NULL, NULL, 
																			   sum(if((integer)(inq_adlsperaddr > 2) = NULL, 0, (integer)(inq_adlsperaddr > 2)), 
																				     if(2 * (integer)(inq_lnamesperaddr > 2) = NULL, 0, 2 * (integer)(inq_lnamesperaddr > 2)), 
																						 if(4 * (integer)(inq_ssnsperaddr > 2) = NULL, 0, 4 * (integer)(inq_ssnsperaddr > 2)))));

nf_inq_communications_count24 := if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999));

nf_inq_other_count24 := if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999));

rv_d34_attr_unrel_liens_recency := map(
    not(truedid)                       => NULL,
    (boolean)attr_num_unrel_liens30             => 1,
    (boolean)attr_num_unrel_liens90             => 3,
    (boolean)attr_num_unrel_liens180            => 6,
    (boolean)attr_num_unrel_liens12             => 12,
    (boolean)attr_num_unrel_liens24             => 24,
    (boolean)attr_num_unrel_liens36             => 36,
    (boolean)attr_num_unrel_liens60             => 60,
    liens_historical_unreleased_ct > 0          => 99,
                                                   0);

iv_nap_phn_verd := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

iv_input_best_ssn_match := map(
    not(truedid) or (integer)input_ssn_isbestmatch = -3 => NULL,
    (integer)input_ssn_isbestmatch = 1                  => 1,
    (integer)input_ssn_isbestmatch = 0                  => 0,
    (integer)input_ssn_isbestmatch = -2                 => -1,
                                                          NULL);

rv_bus_addr_only_curr := if(not(truedid), NULL, bus_addr_only_curr);

rv_e58_br_dead_bus_x_active_phn := if(not(truedid), '', (string)min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 3) + '-' + (string)min(if(br_active_phone_count = NULL, -NULL, br_active_phone_count), 3));

iv_college_tier := map(
    not(truedid)        => '',
    college_tier = ''   => '-1',
                           trim(college_tier, LEFT));

iv_prof_license_category_pl := map(
    not(truedid) or prof_license_source != 'PL' => '',
    prof_license_category = ''                  => '-1',
                                                   trim(prof_license_category, LEFT));

nf_attr_arrests := if(not(truedid), NULL, min(if(attr_arrests = NULL, -NULL, attr_arrests), 999));

_liens_unrel_sc_first_seen := common.sas_date((string)(liens_unrel_sc_first_seen));

nf_mos_liens_unrel_sc_fseen := map(
    not(truedid)                      => NULL,
    _liens_unrel_sc_first_seen = NULL => -1,
                                         min(if(if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)))), 999));

_foreclosure_last_date := common.sas_date((string)(foreclosure_last_date));

nf_mos_foreclosure_lseen := map(
    not(truedid)                  => NULL,
    _foreclosure_last_date = NULL => -1,
                                     min(if(if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12)))), 999));

nf_historic_x_current_ct := if(not(truedid), '', (string)min(if(historical_count = NULL, -NULL, historical_count), 3) + '-' + (string)min(if(current_count = NULL, -NULL, current_count), 3));

nf_fp_srchfraudsrchcountyr := if(not(truedid), NULL, (integer)min(if(fp_srchfraudsrchcountyr = '', -NULL, (integer)fp_srchfraudsrchcountyr), 999));

nf_fp_srchcomponentrisktype := if(not(truedid), NULL, (integer)fp_srchcomponentrisktype); 

nf_fp_prevaddroccupantowned := map(
    not(truedid)                    => '',
    fp_prevaddroccupantowned = ''   => '',
                                       fp_prevaddroccupantowned);

//num_dob_sources := length(StringLib.StringFilterOut(ver_dob_sources, ','));
num_dob_sources_temp :=  models.Common.countw(trim(ver_dob_sources,left,right));
num_dob_sources      :=  IF(num_dob_sources_temp = 0, 1, num_dob_sources_temp);  


// iv_dob_bureau_only := if(not(dobpop), -1, num_dob_sources = if(max((integer)ver_dob_src_eq +
                                                                   // (integer)ver_dob_src_en +
                                                                   // (integer)ver_dob_src_tn) = NULL, NULL, 
																																// sum(if((integer)ver_dob_src_eq +
                                                                       // (integer)ver_dob_src_en +
                                                                       // (integer)ver_dob_src_tn = NULL, 0, (integer)ver_dob_src_eq +
                                                                       // (integer)ver_dob_src_en +
                                                                       // (integer)ver_dob_src_tn))));


_sum_dob_bureau := if(max((integer)ver_dob_src_eq, (integer)ver_dob_src_en, (integer)ver_dob_src_tn) = NULL, NULL, 
                      sum((integer)ver_dob_src_eq, (integer)ver_dob_src_en, (integer)ver_dob_src_tn));
											
num_dob_source_same_as_sum_dob_bureau  := If(num_dob_sources = _sum_dob_bureau, true, false);
iv_dob_bureau_only := map(
     not(dobpop)                           => -1,
		 num_dob_source_same_as_sum_dob_bureau  => 1,
		                                           0);  

//iv_dob_bureau_only := if(not(dobpop), -1, _sum_dob_bureau);


earliest_header_date := if(max(ver_src_fdate_en, 
                               ver_src_fdate_ar, 
															 ver_src_fdate_ff, 
															 ver_src_fdate_am, 
															 ver_src_fdate_eb, 
															 ver_src_fdate_pl, 
															 ver_src_fdate_e2, 
															 ver_src_fdate_w, 
															 ver_src_fdate_nt, 
															 ver_src_fdate_e4, 
															 ver_src_fdate_de, 
															 ver_src_fdate_l2, 
															 ver_src_fdate_fr, 
															 ver_src_fdate_li, 
															 ver_src_fdate_da, 
															 ver_src_fdate_wp, 
															 ver_src_fdate_ba, 
															 ver_src_fdate_e1, 
															 ver_src_fdate_tu, 
															 ver_src_fdate_e3, 
															 ver_src_fdate_ts, 
															 ver_src_fdate_tn, 
															 ver_src_fdate_sl, 
															 ver_src_fdate_eq, 
															 ver_src_fdate_fe, 
															 ver_src_fdate_ak, 
															 ver_src_fdate_ds, 
															 ver_src_fdate_cy, 
															 ver_src_fdate_em, 
															 ver_src_fdate_p, 
															 ver_src_fdate_vo, 
															 ver_src_fdate_mw, 
															 ver_src_fdate_co, 
															 ver_src_fdate_d, 
															 ver_src_fdate_v, 
															 ver_src_fdate_dl, 
															 ver_src_fdate_cg) = NULL, NULL, 
                           min(if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), 
													    if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), 
															if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), 
															if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), 
															if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), 
															if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), 
															if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), 
															if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w), 
															if(ver_src_fdate_nt = NULL, -NULL, ver_src_fdate_nt), 
															if(ver_src_fdate_e4 = NULL, -NULL, ver_src_fdate_e4), 
															if(ver_src_fdate_de = NULL, -NULL, ver_src_fdate_de), 
															if(ver_src_fdate_l2 = NULL, -NULL, ver_src_fdate_l2), 
															if(ver_src_fdate_fr = NULL, -NULL, ver_src_fdate_fr), 
															if(ver_src_fdate_li = NULL, -NULL, ver_src_fdate_li), 
															if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), 
															if(ver_src_fdate_wp = NULL, -NULL, ver_src_fdate_wp), 
															if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), 
															if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), 
															if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), 
															if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), 
															if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), 
															if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), 
															if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), 
															if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq), 
															if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), 
															if(ver_src_fdate_ak = NULL, -NULL, ver_src_fdate_ak), 
															if(ver_src_fdate_ds = NULL, -NULL, ver_src_fdate_ds), 
															if(ver_src_fdate_cy = NULL, -NULL, ver_src_fdate_cy), 
															if(ver_src_fdate_em = NULL, -NULL, ver_src_fdate_em), 
															if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), 
															if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), 
															if(ver_src_fdate_mw = NULL, -NULL, ver_src_fdate_mw), 
															if(ver_src_fdate_co = NULL, -NULL, ver_src_fdate_co), 
															if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), 
															if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), 
															if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), 
															if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg)));

earliest_header_yrs := if(min(sysdate, earliest_header_date) = NULL, NULL, if ((sysdate - earliest_header_date) / 365.25 >= 0, roundup((sysdate - earliest_header_date) / 365.25), truncate((sysdate - earliest_header_date) / 365.25)));

_in_dob := common.sas_date((string)(in_dob));

calc_dob := if(_in_dob = NULL or sysdate = NULL, NULL, if ((sysdate - _in_dob) / 365.25 >= 0, roundup((sysdate - _in_dob) / 365.25), truncate((sysdate - _in_dob) / 365.25)));

iv_header_emergence_age := map(
    not(truedid)               => NULL,
		earliest_header_yrs = NULL => NULL,   //***added
    not(_in_dob = NULL)        => calc_dob - earliest_header_yrs,
    inferred_age = 0           => NULL,
                                  inferred_age - earliest_header_yrs);

iv_ssnsperadl_ssnunver := map(
    not(truedid and (ssnlength in ['4', '9'])) => NULL,
    (nas_summary in [4, 6, 7, 9, 10, 11, 12])  => -1,
                                                  ssns_per_adl);

corrssndob_src_ak_pos := Models.Common.findw_cpp(corrssndob_sources, 'AK' , '  ,', 'ie');

corrssndob_src_ak := corrssndob_src_ak_pos > 0;

corrssndob_src_am_pos := Models.Common.findw_cpp(corrssndob_sources, 'AM' , '  ,', 'ie');

corrssndob_src_am := corrssndob_src_am_pos > 0;

corrssndob_src_ar_pos := Models.Common.findw_cpp(corrssndob_sources, 'AR' , '  ,', 'ie');

corrssndob_src_ar := corrssndob_src_ar_pos > 0;

corrssndob_src_ba_pos := Models.Common.findw_cpp(corrssndob_sources, 'BA' , '  ,', 'ie');

corrssndob_src_ba := corrssndob_src_ba_pos > 0;

corrssndob_src_cg_pos := Models.Common.findw_cpp(corrssndob_sources, 'CG' , '  ,', 'ie');

corrssndob_src_cg := corrssndob_src_cg_pos > 0;

corrssndob_src_co_pos := Models.Common.findw_cpp(corrssndob_sources, 'CO' , '  ,', 'ie');

corrssndob_src_co := corrssndob_src_co_pos > 0;

corrssndob_src_cy_pos := Models.Common.findw_cpp(corrssndob_sources, 'CY' , '  ,', 'ie');

corrssndob_src_cy := corrssndob_src_cy_pos > 0;

corrssndob_src_da_pos := Models.Common.findw_cpp(corrssndob_sources, 'DA' , '  ,', 'ie');

corrssndob_src_da := corrssndob_src_da_pos > 0;

corrssndob_src_d_pos := Models.Common.findw_cpp(corrssndob_sources, 'D' , '  ,', 'ie');

corrssndob_src_d := corrssndob_src_d_pos > 0;

corrssndob_src_dl_pos := Models.Common.findw_cpp(corrssndob_sources, 'DL' , '  ,', 'ie');

corrssndob_src_dl := corrssndob_src_dl_pos > 0;

corrssndob_src_ds_pos := Models.Common.findw_cpp(corrssndob_sources, 'DS' , '  ,', 'ie');

corrssndob_src_ds := corrssndob_src_ds_pos > 0;

corrssndob_src_de_pos := Models.Common.findw_cpp(corrssndob_sources, 'DE' , '  ,', 'ie');

corrssndob_src_de := corrssndob_src_de_pos > 0;

corrssndob_src_eb_pos := Models.Common.findw_cpp(corrssndob_sources, 'EB' , '  ,', 'ie');

corrssndob_src_eb := corrssndob_src_eb_pos > 0;

corrssndob_src_em_pos := Models.Common.findw_cpp(corrssndob_sources, 'EM' , '  ,', 'ie');

corrssndob_src_em := corrssndob_src_em_pos > 0;

corrssndob_src_e1_pos := Models.Common.findw_cpp(corrssndob_sources, 'E1' , '  ,', 'ie');

corrssndob_src_e1 := corrssndob_src_e1_pos > 0;

corrssndob_src_e2_pos := Models.Common.findw_cpp(corrssndob_sources, 'E2' , '  ,', 'ie');

corrssndob_src_e2 := corrssndob_src_e2_pos > 0;

corrssndob_src_e3_pos := Models.Common.findw_cpp(corrssndob_sources, 'E3' , '  ,', 'ie');

corrssndob_src_e3 := corrssndob_src_e3_pos > 0;

corrssndob_src_e4_pos := Models.Common.findw_cpp(corrssndob_sources, 'E4' , '  ,', 'ie');

corrssndob_src_e4 := corrssndob_src_e4_pos > 0;

corrssndob_src_en_pos := Models.Common.findw_cpp(corrssndob_sources, 'EN' , '  ,', 'ie');

corrssndob_src_en := corrssndob_src_en_pos > 0;

corrssndob_src_eq_pos := Models.Common.findw_cpp(corrssndob_sources, 'EQ' , '  ,', 'ie');

corrssndob_src_eq := corrssndob_src_eq_pos > 0;

corrssndob_src_fe_pos := Models.Common.findw_cpp(corrssndob_sources, 'FE' , '  ,', 'ie');

corrssndob_src_fe := corrssndob_src_fe_pos > 0;

corrssndob_src_ff_pos := Models.Common.findw_cpp(corrssndob_sources, 'FF' , '  ,', 'ie');

corrssndob_src_ff := corrssndob_src_ff_pos > 0;

corrssndob_src_fr_pos := Models.Common.findw_cpp(corrssndob_sources, 'FR' , '  ,', 'ie');

corrssndob_src_fr := corrssndob_src_fr_pos > 0;

corrssndob_src_l2_pos := Models.Common.findw_cpp(corrssndob_sources, 'L2' , '  ,', 'ie');

corrssndob_src_l2 := corrssndob_src_l2_pos > 0;

corrssndob_src_li_pos := Models.Common.findw_cpp(corrssndob_sources, 'LI' , '  ,', 'ie');

corrssndob_src_li := corrssndob_src_li_pos > 0;

corrssndob_src_mw_pos := Models.Common.findw_cpp(corrssndob_sources, 'MW' , '  ,', 'ie');

corrssndob_src_mw := corrssndob_src_mw_pos > 0;

corrssndob_src_nt_pos := Models.Common.findw_cpp(corrssndob_sources, 'NT' , '  ,', 'ie');

corrssndob_src_nt := corrssndob_src_nt_pos > 0;

corrssndob_src_p_pos := Models.Common.findw_cpp(corrssndob_sources, 'P' , '  ,', 'ie');

corrssndob_src_p := corrssndob_src_p_pos > 0;

corrssndob_src_pl_pos := Models.Common.findw_cpp(corrssndob_sources, 'PL' , '  ,', 'ie');

corrssndob_src_pl := corrssndob_src_pl_pos > 0;

corrssndob_src_tn_pos := Models.Common.findw_cpp(corrssndob_sources, 'TN' , '  ,', 'ie');

corrssndob_src_tn := corrssndob_src_tn_pos > 0;

corrssndob_src_ts_pos := Models.Common.findw_cpp(corrssndob_sources, 'TS' , '  ,', 'ie');

corrssndob_src_ts := corrssndob_src_ts_pos > 0;

corrssndob_src_tu_pos := Models.Common.findw_cpp(corrssndob_sources, 'TU' , '  ,', 'ie');

corrssndob_src_tu := corrssndob_src_tu_pos > 0;

corrssndob_src_sl_pos := Models.Common.findw_cpp(corrssndob_sources, 'SL' , '  ,', 'ie');

corrssndob_src_sl := corrssndob_src_sl_pos > 0;

corrssndob_src_v_pos := Models.Common.findw_cpp(corrssndob_sources, 'V' , '  ,', 'ie');

corrssndob_src_v := corrssndob_src_v_pos > 0;

corrssndob_src_vo_pos := Models.Common.findw_cpp(corrssndob_sources, 'VO' , '  ,', 'ie');

corrssndob_src_vo := corrssndob_src_vo_pos > 0;

corrssndob_src_w_pos := Models.Common.findw_cpp(corrssndob_sources, 'W' , '  ,', 'ie');

corrssndob_src_w := corrssndob_src_w_pos > 0;

corrssndob_src_wp_pos := Models.Common.findw_cpp(corrssndob_sources, 'WP' , '  ,', 'ie');

corrssndob_src_wp := corrssndob_src_wp_pos > 0;

corrssndob_ct := if(max((integer)corrssndob_src_ak, (integer)corrssndob_src_am, (integer)corrssndob_src_ar, (integer)corrssndob_src_ba, (integer)corrssndob_src_cg, (integer)corrssndob_src_co, (integer)corrssndob_src_cy, (integer)corrssndob_src_d, (integer)corrssndob_src_da, (integer)corrssndob_src_de, (integer)corrssndob_src_dl, (integer)corrssndob_src_ds, (integer)corrssndob_src_e1, (integer)corrssndob_src_e2, (integer)corrssndob_src_e3, (integer)corrssndob_src_e4, (integer)corrssndob_src_eb, (integer)corrssndob_src_em, (integer)corrssndob_src_en, (integer)corrssndob_src_eq, (integer)corrssndob_src_fe, (integer)corrssndob_src_ff, (integer)corrssndob_src_fr, (integer)corrssndob_src_l2, (integer)corrssndob_src_li, (integer)corrssndob_src_mw, (integer)corrssndob_src_nt, (integer)corrssndob_src_p, (integer)corrssndob_src_pl, (integer)corrssndob_src_sl, (integer)corrssndob_src_tn, (integer)corrssndob_src_ts, (integer)corrssndob_src_tu, (integer)corrssndob_src_v, (integer)corrssndob_src_vo, (integer)corrssndob_src_w, (integer)corrssndob_src_wp) = NULL, NULL, sum((integer)corrssndob_src_ak, (integer)corrssndob_src_am, (integer)corrssndob_src_ar, (integer)corrssndob_src_ba, (integer)corrssndob_src_cg, (integer)corrssndob_src_co, (integer)corrssndob_src_cy, (integer)corrssndob_src_d, (integer)corrssndob_src_da, (integer)corrssndob_src_de, (integer)corrssndob_src_dl, (integer)corrssndob_src_ds, (integer)corrssndob_src_e1, (integer)corrssndob_src_e2, (integer)corrssndob_src_e3, (integer)corrssndob_src_e4, (integer)corrssndob_src_eb, (integer)corrssndob_src_em, (integer)corrssndob_src_en, (integer)corrssndob_src_eq, (integer)corrssndob_src_fe, (integer)corrssndob_src_ff, (integer)corrssndob_src_fr, (integer)corrssndob_src_l2, (integer)corrssndob_src_li, (integer)corrssndob_src_mw, (integer)corrssndob_src_nt, (integer)corrssndob_src_p, (integer)corrssndob_src_pl, (integer)corrssndob_src_sl, (integer)corrssndob_src_tn, (integer)corrssndob_src_ts, (integer)corrssndob_src_tu, (integer)corrssndob_src_v, (integer)corrssndob_src_vo, (integer)corrssndob_src_w, (integer)corrssndob_src_wp));

nf_corrssndob := map(
    not(truedid)                => NULL,
    (integer)dobpop = 0 or (Integer)ssnlength < 9 => NULL,
                                   min(if(corrssndob_ct = NULL, -NULL, corrssndob_ct), 999));

nf_factact_curr_fraud_alert := map(
    not(truedid)                           => NULL,
    factact_curr_fraud_alert = -1          => NULL,
    (factact_curr_fraud_alert in [-2, -3]) => 0,
                                              factact_curr_fraud_alert);

mod1_v01_w := map(
    rv_s65_ssn_problem = NULL     => 0,
    (rv_s65_ssn_problem in [0]) => 0.001503438949172,
    (rv_s65_ssn_problem in [1]) => 0.234786653331241,
    (rv_s65_ssn_problem in [2]) => -0.81316221444087,
                                     0);

mod1_v02_w := map(
    nf_m_snc_ssn_high_issue = NULL => 0,
    nf_m_snc_ssn_high_issue = -1   => 0,
                                      0.00337825192412011);

mod1_v03_w := map(
    rv_p86_hi_risk_phone_type = ''               => 0,
    (rv_p86_hi_risk_phone_type in ['LAND/CELL']) => 0.00180126093673115,
    (rv_p86_hi_risk_phone_type in ['PAGER'])     => 0,
    (rv_p86_hi_risk_phone_type in ['PAY PHONE']) => 0,
                                                    0);

mod1_v04_w := map(
    rv_d30_derog_count = NULL  => 0,
    rv_d30_derog_count = -1    => 0,
    rv_d30_derog_count <= 6.5  => -0.0581437498512362,
    rv_d30_derog_count <= 23.5 => 0.113412163989115,
                                  0.495919806070788);

mod1_v05_w := map(
    rv_d31_attr_bankruptcy_recency = NULL      => 0,
    (rv_d31_attr_bankruptcy_recency in [0])  => 0.030680919993421,
    (rv_d31_attr_bankruptcy_recency in [1])  => -0.278388442259166,
    (rv_d31_attr_bankruptcy_recency in [3])  => 0.0531787103779524,
    (rv_d31_attr_bankruptcy_recency in [6])  => -0.245397476259733,
    (rv_d31_attr_bankruptcy_recency in [12]) => 0.14407239518158,
    (rv_d31_attr_bankruptcy_recency in [24]) => 0.0702225923922805,
    (rv_d31_attr_bankruptcy_recency in [36]) => 0.0140727904592911,
    (rv_d31_attr_bankruptcy_recency in [60]) => -0.00158682487775097,
    (rv_d31_attr_bankruptcy_recency in [99]) => -0.125012917521544,
                                                  0);

mod1_v06_w := map(
    rv_d33_eviction_recency = NULL      => 0,
    (rv_d33_eviction_recency in [0])  => -0.036963152768316,
    (rv_d33_eviction_recency in [3])  => 0.148116485360349,
    (rv_d33_eviction_recency in [6])  => 0.280538445950673,
    (rv_d33_eviction_recency in [12]) => 0.134004133486072,
    (rv_d33_eviction_recency in [24]) => 0.150515107938966,
    (rv_d33_eviction_recency in [25]) => 0.312809130294512,
    (rv_d33_eviction_recency in [36]) => 0.166965179373274,
    (rv_d33_eviction_recency in [37]) => 0.00506311326467594,
    (rv_d33_eviction_recency in [60]) => 0.0649592279216476,
    (rv_d33_eviction_recency in [61]) => 0.0133056970624953,
    (rv_d33_eviction_recency in [98]) => 0.0655756377906667,
    (rv_d33_eviction_recency in [99]) => -0.0347255757324341,
                                           0);

mod1_v07_w := map(
    rv_c13_curr_addr_lres = NULL => 0,
    rv_c13_curr_addr_lres = -1   => 0,
    rv_c13_curr_addr_lres <= 3.5 => 0.357366583848514,
                                    -0.0237041276220213);

mod1_v08_w := map(
    rv_i61_inq_collection_recency = NULL      => 0,
    (rv_i61_inq_collection_recency in [0])  => 0.0529210021875778,
    (rv_i61_inq_collection_recency in [1])  => 0.0972267478893477,
    (rv_i61_inq_collection_recency in [3])  => 0.100603461114865,
    (rv_i61_inq_collection_recency in [6])  => -0.0934251920268131,
    (rv_i61_inq_collection_recency in [12]) => 0.0517517223533608,
    (rv_i61_inq_collection_recency in [24]) => 0.018856049027963,
    (rv_i61_inq_collection_recency in [99]) => -0.0375820940891683,
                                                 0);

mod1_v09_w := map(
    rv_i60_inq_mortgage_recency = NULL      => 0,
    (rv_i60_inq_mortgage_recency in [0])  => 0.00493640026290783,
    (rv_i60_inq_mortgage_recency in [1])  => -0.244407466013161,
    (rv_i60_inq_mortgage_recency in [3])  => -1.22170896548266,
    (rv_i60_inq_mortgage_recency in [6])  => 0.299104956778076,
    (rv_i60_inq_mortgage_recency in [12]) => 0.174803144555208,
    (rv_i60_inq_mortgage_recency in [24]) => -0.0593911553466701,
    (rv_i60_inq_mortgage_recency in [99]) => -0.0425429233931269,
                                               0);

mod1_v10_w := map(
    rv_i60_inq_hiriskcred_recency = NULL      => 0,
    (rv_i60_inq_hiriskcred_recency in [0])  => 0.0337091950724459,
    (rv_i60_inq_hiriskcred_recency in [1])  => 0.0509992591267902,
    (rv_i60_inq_hiriskcred_recency in [3])  => -0.0758892921763781,
    (rv_i60_inq_hiriskcred_recency in [6])  => -0.00441255413442786,
    (rv_i60_inq_hiriskcred_recency in [12]) => 0.0409846134671809,
    (rv_i60_inq_hiriskcred_recency in [24]) => 0.00777541289580367,
    (rv_i60_inq_hiriskcred_recency in [99]) => -0.0817994121009187,
                                                 0);

mod1_v11_w := map(
    rv_i60_inq_prepaidcards_recency = NULL      => 0,
    (rv_i60_inq_prepaidcards_recency in [0])  => -0.0379568378504371,
    (rv_i60_inq_prepaidcards_recency in [1])  => 0.762840674816385,
    (rv_i60_inq_prepaidcards_recency in [3])  => 0.762840674816385,
    (rv_i60_inq_prepaidcards_recency in [6])  => 0,
    (rv_i60_inq_prepaidcards_recency in [12]) => 0.0369462590300494,
    (rv_i60_inq_prepaidcards_recency in [24]) => 0.296651903439805,
    (rv_i60_inq_prepaidcards_recency in [99]) => 0.200415059435347,
                                                   0);

mod1_v12_w := map(
    rv_i60_inq_retail_recency = NULL      => 0,
    (rv_i60_inq_retail_recency in [0])  => 0.0250986121845791,
    (rv_i60_inq_retail_recency in [1])  => -0.0528979982116641,
    (rv_i60_inq_retail_recency in [3])  => -0.0616185828776724,
    (rv_i60_inq_retail_recency in [6])  => -0.0324098863429767,
    (rv_i60_inq_retail_recency in [12]) => -0.444229306527697,
    (rv_i60_inq_retail_recency in [24]) => -0.0440423814194708,
    (rv_i60_inq_retail_recency in [99]) => -0.079115031189892,
                                             0);

mod1_v13_w := map(
    rv_i60_inq_comm_recency = NULL      => 0,
    (rv_i60_inq_comm_recency in [0])  => -0.0706727609760173,
    (rv_i60_inq_comm_recency in [1])  => 0.263891443853937,
    (rv_i60_inq_comm_recency in [3])  => 0.183070776769387,
    (rv_i60_inq_comm_recency in [6])  => 0.115201514642415,
    (rv_i60_inq_comm_recency in [12]) => 0.147404363791163,
    (rv_i60_inq_comm_recency in [24]) => 0.122605477933134,
    (rv_i60_inq_comm_recency in [99]) => 0.0495366733918154,
                                           0);

mod1_v14_w := map(
    rv_i60_inq_other_recency = NULL      => 0,
    (rv_i60_inq_other_recency in [0])  => -0.100684627371614,
    (rv_i60_inq_other_recency in [1])  => 0.173222373238132,
    (rv_i60_inq_other_recency in [3])  => 0.167961140605423,
    (rv_i60_inq_other_recency in [6])  => 0.0587316695904107,
    (rv_i60_inq_other_recency in [12]) => 0.0166731588395746,
    (rv_i60_inq_other_recency in [24]) => -0.0567804392309268,
    (rv_i60_inq_other_recency in [99]) => -0.0948877818576551,
                                            0);

mod1_v15_w := map(
    nf_inq_phone_ver_count = NULL => 0,
    nf_inq_phone_ver_count = -1   => 0,
    nf_inq_phone_ver_count <= 0.5 => 0.169693900196398,
    nf_inq_phone_ver_count <= 1.5 => 0.069626331393815,
                                     -0.0540977694849641);

mod1_v16_w := map(
    nf_inquiry_verification_index = NULL      => 0,
    (nf_inquiry_verification_index in [0])  => -0.10369270468273,
    (nf_inquiry_verification_index in [1])  => 0.167258914129156,
    (nf_inquiry_verification_index in [3])  => 0,
    (nf_inquiry_verification_index in [5])  => 0.158812325363445,
    (nf_inquiry_verification_index in [7])  => 0.350766712787142,
    (nf_inquiry_verification_index in [9])  => -0.0509056266804341,
    (nf_inquiry_verification_index in [11]) => 0,
    (nf_inquiry_verification_index in [13]) => 0.0928132190341883,
    (nf_inquiry_verification_index in [15]) => 0.0680891368612117,
    (nf_inquiry_verification_index in [17]) => 0.158812325363445,
    (nf_inquiry_verification_index in [19]) => 0.0235400684145334,
    (nf_inquiry_verification_index in [21]) => 0.0709045327731997,
    (nf_inquiry_verification_index in [23]) => -0.0509056266804341,
    (nf_inquiry_verification_index in [25]) => 0.0900065492697369,
    (nf_inquiry_verification_index in [27]) => -0.0599967187650433,
    (nf_inquiry_verification_index in [29]) => 0.0903243320808482,
    (nf_inquiry_verification_index in [31]) => -0.01761825451736,
                                                 0);

mod1_v17_w := map(
    nf_inquiry_ssn_vel_risk_index = NULL      => 0,
    (nf_inquiry_ssn_vel_risk_index in [0])  => -0.0218447083331803,
    (nf_inquiry_ssn_vel_risk_index in [1])  => 0.016569528261732,
    (nf_inquiry_ssn_vel_risk_index in [2])  => 0.0350534878119225,
    (nf_inquiry_ssn_vel_risk_index in [3])  => 0.208009694964057,
    (nf_inquiry_ssn_vel_risk_index in [4])  => 0.180824489963537,
    (nf_inquiry_ssn_vel_risk_index in [5])  => -0.290856059836414,
    (nf_inquiry_ssn_vel_risk_index in [6])  => 0.220304417143758,
    (nf_inquiry_ssn_vel_risk_index in [7])  => 0.680601801110729,
    (nf_inquiry_ssn_vel_risk_index in [8])  => 0.0242049271110724,
    (nf_inquiry_ssn_vel_risk_index in [9])  => -0.0220617656615629,
    (nf_inquiry_ssn_vel_risk_index in [10]) => 0.171269790180822,
    (nf_inquiry_ssn_vel_risk_index in [11]) => 0.132739169133572,
    (nf_inquiry_ssn_vel_risk_index in [12]) => 0.0838355483486705,
    (nf_inquiry_ssn_vel_risk_index in [13]) => 0,
    (nf_inquiry_ssn_vel_risk_index in [14]) => -0.200985205767257,
    (nf_inquiry_ssn_vel_risk_index in [15]) => 0.167360374233392,
                                                 0);

mod1_v18_w := map(
    nf_inquiry_addr_vel_risk_index = NULL      => 0,
    (nf_inquiry_addr_vel_risk_index in [-1]) => 0.181292885889323,
    (nf_inquiry_addr_vel_risk_index in [0])  => -0.033513320338211,
    (nf_inquiry_addr_vel_risk_index in [1])  => 0.134611376881307,
    (nf_inquiry_addr_vel_risk_index in [2])  => 0.0982568230624117,
    (nf_inquiry_addr_vel_risk_index in [3])  => -0.0842371891612217,
    (nf_inquiry_addr_vel_risk_index in [4])  => 0.230921127043716,
    (nf_inquiry_addr_vel_risk_index in [5])  => 0.131657914512159,
    (nf_inquiry_addr_vel_risk_index in [6])  => 0.208093126490671,
    (nf_inquiry_addr_vel_risk_index in [7])  => 0.155131098637413,
                                                  0);

mod1_v19_w := map(
    nf_inq_communications_count24 = NULL => 0,
    nf_inq_communications_count24 = -1   => 0,
    nf_inq_communications_count24 <= 1.5 => -0.0352436184625238,
    nf_inq_communications_count24 <= 2.5 => 0.233634165735048,
    nf_inq_communications_count24 <= 4.5 => 0.339570387300172,
                                            0.432885805932672);

mod1_v20_w := map(
    nf_inq_other_count24 = NULL => 0,
    nf_inq_other_count24 = -1   => 0,
    nf_inq_other_count24 <= 0.5 => -0.0422100848887158,
    nf_inq_other_count24 <= 2.5 => -0.00100256064327947,
    nf_inq_other_count24 <= 4.5 => 0.0455822991384594,
                                   0.0573867701682994);

mod1_v21_w := map(
    rv_d34_attr_unrel_liens_recency = NULL      => 0,
    (rv_d34_attr_unrel_liens_recency in [0])  => 0.0419021522224936,
    (rv_d34_attr_unrel_liens_recency in [1])  => 0.152617233283553,
    (rv_d34_attr_unrel_liens_recency in [3])  => -0.174308727866603,
    (rv_d34_attr_unrel_liens_recency in [6])  => 0.0237564664007498,
    (rv_d34_attr_unrel_liens_recency in [12]) => 0.204263140327466,
    (rv_d34_attr_unrel_liens_recency in [24]) => 0.0609863403229275,
    (rv_d34_attr_unrel_liens_recency in [36]) => -0.102829433079449,
    (rv_d34_attr_unrel_liens_recency in [60]) => -0.057822040855586,
    (rv_d34_attr_unrel_liens_recency in [99]) => -0.0694296242853594,
                                                   0);

mod1_v22_w := map(
    (integer)iv_nap_phn_verd = NULL => 0,
    (integer)iv_nap_phn_verd = -1   => 0,
    (real)iv_nap_phn_verd <= 0.5    => 0.174437453114732,
                                      -0.0458554866940748);

mod1_v23_w := map(
    iv_input_best_ssn_match = NULL => 0,
    iv_input_best_ssn_match = -1   => -1.14745131391799,
                                      0.000987093080028901);

mod1_v24_w := map(
    rv_bus_addr_only_curr = NULL      => 0,
    (rv_bus_addr_only_curr in [-2]) => -0.0998529429766252,
    (rv_bus_addr_only_curr in [0])  => -3.24024976165554e-05,
    (rv_bus_addr_only_curr in [1])  => 0.612068460371636,
                                         0);

mod1_v25_w := map(
    rv_e58_br_dead_bus_x_active_phn = ''         => 0,
    (rv_e58_br_dead_bus_x_active_phn in ['0-0']) => 0.0236558174819211,
    (rv_e58_br_dead_bus_x_active_phn in ['0-1']) => -0.236074032881131,
    (rv_e58_br_dead_bus_x_active_phn in ['0-2']) => -0.134284098907427,
    (rv_e58_br_dead_bus_x_active_phn in ['0-3']) => -0.306776122139597,
    (rv_e58_br_dead_bus_x_active_phn in ['1-0']) => 0.104115730704879,
    (rv_e58_br_dead_bus_x_active_phn in ['1-1']) => -0.0211933014254755,
    (rv_e58_br_dead_bus_x_active_phn in ['1-2']) => -0.042054150468273,
    (rv_e58_br_dead_bus_x_active_phn in ['1-3']) => 0.169970729037249,
    (rv_e58_br_dead_bus_x_active_phn in ['2-0']) => -0.332959200910227,
    (rv_e58_br_dead_bus_x_active_phn in ['2-1']) => 0.253227117399072,
    (rv_e58_br_dead_bus_x_active_phn in ['2-2']) => 0.430871814067668,
    (rv_e58_br_dead_bus_x_active_phn in ['2-3']) => -0.440084111593314,
    (rv_e58_br_dead_bus_x_active_phn in ['3-0']) => 0.0153875758301775,
    (rv_e58_br_dead_bus_x_active_phn in ['3-1']) => 0.0954953518258742,
    (rv_e58_br_dead_bus_x_active_phn in ['3-2']) => 0.777674660873311,
    (rv_e58_br_dead_bus_x_active_phn in ['3-3']) => 0.472463945685034,
                                                    0);

mod1_v26_w := map(
    iv_college_tier = ''        => 0,
    (iv_college_tier in ['-1']) => 0.00300342000633461,
    (iv_college_tier in ['0'])  => -0.111066730331078,
    (iv_college_tier in ['1'])  => 0.609847354764854,
    (iv_college_tier in ['2'])  => -0.57532107606415,
    (iv_college_tier in ['3'])  => -0.108788472144952,
    (iv_college_tier in ['4'])  => -0.0818936753201365,
    (iv_college_tier in ['5'])  => 0.175030107900245,
    (iv_college_tier in ['6'])  => 0.137501028921321,
                                   0);

mod1_v27_w := map(
    iv_prof_license_category_pl = ''       => 0,
    (iv_prof_license_category_pl in ['0']) => 0.0922969985338347,
    (iv_prof_license_category_pl in ['1']) => 0.220495479545105,
    (iv_prof_license_category_pl in ['2']) => -0.0683308348094833,
    (iv_prof_license_category_pl in ['3']) => -0.500534263362073,
    (iv_prof_license_category_pl in ['4']) => 0.155325261200394,
    (iv_prof_license_category_pl in ['5']) => 0.428504400558788,
                                              0);

mod1_v28_w := map(
    nf_attr_arrests = NULL => 0,
    nf_attr_arrests = -1   => 0,
    nf_attr_arrests <= 0.5 => -0.0207960167458357,
                              0.398000434659675);

mod1_v29_w := map(
    nf_mos_liens_unrel_sc_fseen = NULL => 0,
    nf_mos_liens_unrel_sc_fseen = -1   => -0.00870441059898914,
                                          0.0345875130620095);

mod1_v30_w := map(
    nf_mos_foreclosure_lseen = NULL => 0,
    nf_mos_foreclosure_lseen = -1   => 0.00988396905634316,
                                       -0.176934800706927);

mod1_v31_w := map(
    nf_historic_x_current_ct = ''         => 0,
    (nf_historic_x_current_ct in ['0-0']) => 0.0517086200703619,
    (nf_historic_x_current_ct in ['1-0']) => 0.0197748497080909,
    (nf_historic_x_current_ct in ['1-1']) => -0.100058827362219,
    (nf_historic_x_current_ct in ['2-0']) => 0.097593997473272,
    (nf_historic_x_current_ct in ['2-1']) => -0.1562356382194,
    (nf_historic_x_current_ct in ['2-2']) => -0.0897206720321076,
    (nf_historic_x_current_ct in ['3-0']) => 0.201178913941336,
    (nf_historic_x_current_ct in ['3-1']) => 0.0227218658905749,
    (nf_historic_x_current_ct in ['3-2']) => -0.0201316420298672,
    (nf_historic_x_current_ct in ['3-3']) => -0.0185875284418055,
                                             0);

mod1_v32_w := map(
    nf_fp_srchfraudsrchcountyr = NULL  => 0,
    nf_fp_srchfraudsrchcountyr = -1    => 0,
    nf_fp_srchfraudsrchcountyr <= 3.5  => -0.0704094406619362,
    nf_fp_srchfraudsrchcountyr <= 10.5 => 0.0649869541292971,
                                          0.230687498190738);

mod1_v33_w := map(
    nf_fp_srchcomponentrisktype = NULL => 0,
    nf_fp_srchcomponentrisktype = -1   => 0,
    nf_fp_srchcomponentrisktype <= 1.5 => -0.0403867810448249,
    nf_fp_srchcomponentrisktype <= 6.5 => 0.0938526831642713,
                                          0.260361714203639);

mod1_v34_w := map(
    nf_fp_prevaddroccupantowned = ''        => 0,
    (nf_fp_prevaddroccupantowned in ['-1']) => -0.0412301516929142,
    (nf_fp_prevaddroccupantowned in ['0'])  => -0.00954240684895301,
    (nf_fp_prevaddroccupantowned in ['1'])  => 0.284376384816252,
                                               0);

mod1_v35_w := map(
    iv_dob_bureau_only = NULL => 0,
    iv_dob_bureau_only = -1   => 0,
    iv_dob_bureau_only <= 0.5 => -0.0226136046549751,
                                 0.19511990716669);

mod1_v36_w := map(
    iv_header_emergence_age = NULL  => 0,
    iv_header_emergence_age = -1    => 0.580866548636282,
    iv_header_emergence_age <= 17.5 => 0.113181790527284,
                                       -0.0314461024595491);

mod1_v37_w := map(
    iv_ssnsperadl_ssnunver = NULL => 0,
    iv_ssnsperadl_ssnunver = -1   => 0.000639464977477857,
                                     -0.154386423977577);

mod1_v38_w := map(
    nf_corrssndob = NULL => 0,
    nf_corrssndob = -1   => 0,
    nf_corrssndob <= 1.5 => 0.0709155938081496,
    nf_corrssndob <= 2.5 => -0.0420190426080437,
                            -0.0721986608368775);

mod1_v39_w := map(
    nf_factact_curr_fraud_alert = NULL     => 0,
    (nf_factact_curr_fraud_alert in [0]) => -0.00983417716110875,
    (nf_factact_curr_fraud_alert in [1]) => 0.402709554729615,
                                              0);

mod1_lgt := -1.46229264755577 +
    mod1_v01_w +
    mod1_v02_w +
    mod1_v03_w +
    mod1_v04_w +
    mod1_v05_w +
    mod1_v06_w +
    mod1_v07_w +
    mod1_v08_w +
    mod1_v09_w +
    mod1_v10_w +
    mod1_v11_w +
    mod1_v12_w +
    mod1_v13_w +
    mod1_v14_w +
    mod1_v15_w +
    mod1_v16_w +
    mod1_v17_w +
    mod1_v18_w +
    mod1_v19_w +
    mod1_v20_w +
    mod1_v21_w +
    mod1_v22_w +
    mod1_v23_w +
    mod1_v24_w +
    mod1_v25_w +
    mod1_v26_w +
    mod1_v27_w +
    mod1_v28_w +
    mod1_v29_w +
    mod1_v30_w +
    mod1_v31_w +
    mod1_v32_w +
    mod1_v33_w +
    mod1_v34_w +
    mod1_v35_w +
    mod1_v36_w +
    mod1_v37_w +
    mod1_v38_w +
    mod1_v39_w;

base := 630;

pts := -100;

lgt := ln(0.1889491 / (1 - 0.1889491));

fp1710_1_0_nooverrides := round(max((real)300, min(999, if(base + pts * (mod1_lgt - lgt) / ln(2) = NULL, -NULL, base + pts * (mod1_lgt - lgt) / ln(2)))));

or_decssn := (Integer)ssnlength > 0 and (integer)rc_decsflag = 1;

or_ssnpriordob := (Integer)ssnlength > 0 and (integer)dobpop = 1 and (integer)rc_ssndobflag = 1;

or_prisonaddr := (integer)addrpop = 1 and (integer)rc_hrisksic = 2225;

or_prisonphone := (integer)hphnpop = 1 and (integer)rc_hrisksicphone = 2225;

or_hraddr := (Integer)addrpop = 1 and (Integer)rc_hriskaddrflag = 4 or (integer)rc_addrcommflag = 2;

or_hrphone := (Integer)hphnpop = 1 and ((integer)rc_hriskphoneflag = 6 or rc_hphonetypeflag = '5' or (integer)rc_hphonevalflag = 3 or (integer)rc_addrcommflag = 1);

or_invalidssn := (Integer)ssnlength > 0 and ((integer)rc_ssnvalflag = 1 or (rc_pwssnvalflag in ['1', '2', '3']));

or_invalidaddr := (Integer)addrpop = 1 and rc_addrvalflag != 'V';

or_invalidphone := (Integer)hphnpop = 1 and ((Integer)rc_phonevalflag = 0 or (Integer)rc_hphonevalflag = 0);

fp1710_1_0_score := map(
    or_decssn or or_ssnpriordob or or_prisonaddr                                                    => min(if(fp1710_1_0_nooverrides = NULL, -NULL, fp1710_1_0_nooverrides), 600),
    or_prisonphone or or_hraddr or or_hrphone or or_invalidssn or or_invalidaddr or or_invalidphone => min(if(fp1710_1_0_nooverrides = NULL, -NULL, fp1710_1_0_nooverrides), 700),
                                                                                                       fp1710_1_0_nooverrides);

fp1710_1_0 := fp1710_1_0_score;

_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;

_derog := felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

_deceased := (integer)rc_decsflag = 1 OR (integer)rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;

_ssnpriortodob := (integer)rc_ssndobflag = 1 OR (integer)rc_pwssndobflag = 1;

_inputmiskeys := rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0;

_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

_hh_strikes := if((Integer)max((integer)hh_members_w_derog > 0, 
                      (integer)hh_criminals > 0, 
											(integer)hh_payday_loan_users > 0) = NULL, NULL, 
									        (Integer)sum((integer)hh_members_w_derog > 0, 
									             (integer)hh_criminals > 0, 
											          (integer)hh_payday_loan_users > 0));

stolenid := if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (Integer)ssnlength = 9 or _deceased or _ssnpriortodob, 1, 0);

manipulatedid := if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0);

manipulatedidpt2 := if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (Integer)ssnlength = 9, 1, 0);

rv_a41_prop_owner := map(
    not(truedid)                                                                                   => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                                                                                                      0);

_sum_bureau := if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn));

_sum_credentialed := if(max((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w) = NULL, NULL, sum((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w));

syntheticid := _sum_credentialed = 0 and _sum_bureau > 0 and rv_a41_prop_owner = 0 OR (Integer)truedid = 0;

suspiciousactivity := if(_derog, 1, 0);

vulnerablevictim := if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0);

friendlyfraud := if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0);

     /* if stolenid is true , pass score, else pass in the value of 299*/ 
stolenc_redev := if(stolenid = 1, fp1710_1_0, 299);

manip2c_redev := if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1710_1_0, 299);

synthc_redev    := if(syntheticid, fp1710_1_0, 299);
suspactc_redev  := if(suspiciousactivity = 1, fp1710_1_0, 299);
vulnvicc_redev  := if(vulnerablevictim = 1, fp1710_1_0, 299);
friendlyc_redev := if(friendlyfraud = 1, fp1710_1_0, 299);

custstolidindex := map(
    stolenc_redev = 299                           => 1,
    300 <= stolenc_redev AND stolenc_redev <= 530 => 9,
    530 < stolenc_redev AND stolenc_redev <= 560  => 8,
    560 < stolenc_redev AND stolenc_redev <= 640  => 7,
    640 < stolenc_redev AND stolenc_redev <= 670  => 6,
    670 < stolenc_redev AND stolenc_redev <= 730  => 5,
    730 < stolenc_redev AND stolenc_redev <= 760  => 4,
    760 < stolenc_redev AND stolenc_redev <= 800  => 3,
    800 < stolenc_redev AND stolenc_redev <= 999  => 2,
                                                     99);

custmanipidindex := map(
    manip2c_redev = 299                           => 1,
    300 <= manip2c_redev AND manip2c_redev <= 530 => 9,
    530 < manip2c_redev AND manip2c_redev <= 560  => 8,
    560 < manip2c_redev AND manip2c_redev <= 650  => 7,
    650 < manip2c_redev AND manip2c_redev <= 690  => 6,
    690 < manip2c_redev AND manip2c_redev <= 720  => 5,
    720 < manip2c_redev AND manip2c_redev <= 750  => 4,
    750 < manip2c_redev AND manip2c_redev <= 810  => 3,
    810 < manip2c_redev AND manip2c_redev <= 999  => 2,
                                                     99);

custsynthidindex := map(
    synthc_redev = 299                          => 1,
    300 <= synthc_redev AND synthc_redev <= 470 => 9,
    470 < synthc_redev AND synthc_redev <= 520  => 8,
    520 < synthc_redev AND synthc_redev <= 570  => 7,
    570 < synthc_redev AND synthc_redev <= 610  => 6,
    610 < synthc_redev AND synthc_redev <= 640  => 5,
    640 < synthc_redev AND synthc_redev <= 680  => 4,
    680 < synthc_redev AND synthc_redev <= 710  => 3,
    710 < synthc_redev AND synthc_redev <= 999  => 2,
                                                   99);

custsuspactindex := map(
    suspactc_redev = 299                            => 1,
    300 <= suspactc_redev AND suspactc_redev <= 450 => 9,
    450 < suspactc_redev AND suspactc_redev <= 500  => 8,
    500 < suspactc_redev AND suspactc_redev <= 530  => 7,
    530 < suspactc_redev AND suspactc_redev <= 570  => 6,
    570 < suspactc_redev AND suspactc_redev <= 610  => 5,
    610 < suspactc_redev AND suspactc_redev <= 670  => 4,
    670 < suspactc_redev AND suspactc_redev <= 720  => 3,
    720 < suspactc_redev AND suspactc_redev <= 999  => 2,
                                                       99);

custvulnvicindex := map(
    vulnvicc_redev = 299                            => 1,
    300 <= vulnvicc_redev AND vulnvicc_redev <= 580 => 9,
    580 < vulnvicc_redev AND vulnvicc_redev <= 620  => 8,
    620 < vulnvicc_redev AND vulnvicc_redev <= 660  => 7,
    660 < vulnvicc_redev AND vulnvicc_redev <= 680  => 6,
    680 < vulnvicc_redev AND vulnvicc_redev <= 720  => 5,
    720 < vulnvicc_redev AND vulnvicc_redev <= 750  => 4,
    750 < vulnvicc_redev AND vulnvicc_redev <= 790  => 3,
    790 < vulnvicc_redev AND vulnvicc_redev <= 999  => 2,
                                                       99);

custfriendfrdindex := map(
    friendlyc_redev = 299                             => 1,
    300 <= friendlyc_redev AND friendlyc_redev <= 460 => 9,
    460 < friendlyc_redev AND friendlyc_redev <= 500  => 8,
    500 < friendlyc_redev AND friendlyc_redev <= 540  => 7,
    540 < friendlyc_redev AND friendlyc_redev <= 570  => 6,
    570 < friendlyc_redev AND friendlyc_redev <= 610  => 5,
    610 < friendlyc_redev AND friendlyc_redev <= 660  => 4,
    660 < friendlyc_redev AND friendlyc_redev <= 720  => 3,
    720 < friendlyc_redev AND friendlyc_redev <= 999  => 2,
                                                         99);
  //*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */

    /*  Finish up the TRANSFORM by populating the results  */

                    self.sysdate                          := sysdate;
										self.model_name                       := 'FP1710_10';   
                    self.ver_src_ak_pos                   := ver_src_ak_pos;
                    self._ver_src_fdate_ak                := _ver_src_fdate_ak;
                    self.ver_src_fdate_ak                 := ver_src_fdate_ak;
                    self.ver_src_am_pos                   := ver_src_am_pos;
                    self.ver_src_am                       := ver_src_am;
                    self._ver_src_fdate_am                := _ver_src_fdate_am;
                    self.ver_src_fdate_am                 := ver_src_fdate_am;
                    self.ver_src_ar_pos                   := ver_src_ar_pos;
                    self.ver_src_ar                       := ver_src_ar;
                    self._ver_src_fdate_ar                := _ver_src_fdate_ar;
                    self.ver_src_fdate_ar                 := ver_src_fdate_ar;
                    self.ver_src_ba_pos                   := ver_src_ba_pos;
                    self.ver_src_ba                       := ver_src_ba;
                    self._ver_src_fdate_ba                := _ver_src_fdate_ba;
                    self.ver_src_fdate_ba                 := ver_src_fdate_ba;
                    self.ver_src_cg_pos                   := ver_src_cg_pos;
                    self.ver_src_cg                       := ver_src_cg;
                    self._ver_src_fdate_cg                := _ver_src_fdate_cg;
                    self.ver_src_fdate_cg                 := ver_src_fdate_cg;
                    self.ver_src_co_pos                   := ver_src_co_pos;
                    self._ver_src_fdate_co                := _ver_src_fdate_co;
                    self.ver_src_fdate_co                 := ver_src_fdate_co;
                    self.ver_src_cy_pos                   := ver_src_cy_pos;
                    self._ver_src_fdate_cy                := _ver_src_fdate_cy;
                    self.ver_src_fdate_cy                 := ver_src_fdate_cy;
                    self.ver_src_da_pos                   := ver_src_da_pos;
                    self.ver_src_da                       := ver_src_da;
                    self._ver_src_fdate_da                := _ver_src_fdate_da;
                    self.ver_src_fdate_da                 := ver_src_fdate_da;
                    self.ver_src_d_pos                    := ver_src_d_pos;
                    self.ver_src_d                        := ver_src_d;
                    self._ver_src_fdate_d                 := _ver_src_fdate_d;
                    self.ver_src_fdate_d                  := ver_src_fdate_d;
                    self.ver_src_dl_pos                   := ver_src_dl_pos;
                    self.ver_src_dl                       := ver_src_dl;
                    self._ver_src_fdate_dl                := _ver_src_fdate_dl;
                    self.ver_src_fdate_dl                 := ver_src_fdate_dl;
                    self.ver_src_ds_pos                   := ver_src_ds_pos;
                    self._ver_src_fdate_ds                := _ver_src_fdate_ds;
                    self.ver_src_fdate_ds                 := ver_src_fdate_ds;
                    self.ver_src_de_pos                   := ver_src_de_pos;
                    self._ver_src_fdate_de                := _ver_src_fdate_de;
                    self.ver_src_fdate_de                 := ver_src_fdate_de;
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self.ver_src_eb                       := ver_src_eb;
                    self._ver_src_fdate_eb                := _ver_src_fdate_eb;
                    self.ver_src_fdate_eb                 := ver_src_fdate_eb;
                    self.ver_src_em_pos                   := ver_src_em_pos;
                    self._ver_src_fdate_em                := _ver_src_fdate_em;
                    self.ver_src_fdate_em                 := ver_src_fdate_em;
                    self.ver_src_e1_pos                   := ver_src_e1_pos;
                    self.ver_src_e1                       := ver_src_e1;
                    self._ver_src_fdate_e1                := _ver_src_fdate_e1;
                    self.ver_src_fdate_e1                 := ver_src_fdate_e1;
                    self.ver_src_e2_pos                   := ver_src_e2_pos;
                    self.ver_src_e2                       := ver_src_e2;
                    self._ver_src_fdate_e2                := _ver_src_fdate_e2;
                    self.ver_src_fdate_e2                 := ver_src_fdate_e2;
                    self.ver_src_e3_pos                   := ver_src_e3_pos;
                    self.ver_src_e3                       := ver_src_e3;
                    self._ver_src_fdate_e3                := _ver_src_fdate_e3;
                    self.ver_src_fdate_e3                 := ver_src_fdate_e3;
                    self.ver_src_e4_pos                   := ver_src_e4_pos;
                    self._ver_src_fdate_e4                := _ver_src_fdate_e4;
                    self.ver_src_fdate_e4                 := ver_src_fdate_e4;
                    self.ver_src_en_pos                   := ver_src_en_pos;
                    self.ver_src_en                       := ver_src_en;
                    self._ver_src_fdate_en                := _ver_src_fdate_en;
                    self.ver_src_fdate_en                 := ver_src_fdate_en;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self.ver_src_eq                       := ver_src_eq;
                    self._ver_src_fdate_eq                := _ver_src_fdate_eq;
                    self.ver_src_fdate_eq                 := ver_src_fdate_eq;
                    self.ver_src_fe_pos                   := ver_src_fe_pos;
                    self.ver_src_fe                       := ver_src_fe;
                    self._ver_src_fdate_fe                := _ver_src_fdate_fe;
                    self.ver_src_fdate_fe                 := ver_src_fdate_fe;
                    self.ver_src_ff_pos                   := ver_src_ff_pos;
                    self.ver_src_ff                       := ver_src_ff;
                    self._ver_src_fdate_ff                := _ver_src_fdate_ff;
                    self.ver_src_fdate_ff                 := ver_src_fdate_ff;
                    self.ver_src_fr_pos                   := ver_src_fr_pos;
                    self._ver_src_fdate_fr                := _ver_src_fdate_fr;
                    self.ver_src_fdate_fr                 := ver_src_fdate_fr;
                    self.ver_src_l2_pos                   := ver_src_l2_pos;
                    self._ver_src_fdate_l2                := _ver_src_fdate_l2;
                    self.ver_src_fdate_l2                 := ver_src_fdate_l2;
                    self.ver_src_li_pos                   := ver_src_li_pos;
                    self._ver_src_fdate_li                := _ver_src_fdate_li;
                    self.ver_src_fdate_li                 := ver_src_fdate_li;
                    self.ver_src_mw_pos                   := ver_src_mw_pos;
                    self._ver_src_fdate_mw                := _ver_src_fdate_mw;
                    self.ver_src_fdate_mw                 := ver_src_fdate_mw;
                    self.ver_src_nt_pos                   := ver_src_nt_pos;
                    self._ver_src_fdate_nt                := _ver_src_fdate_nt;
                    self.ver_src_fdate_nt                 := ver_src_fdate_nt;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self.ver_src_p                        := ver_src_p;
                    self._ver_src_fdate_p                 := _ver_src_fdate_p;
                    self.ver_src_fdate_p                  := ver_src_fdate_p;
                    self.ver_src_pl_pos                   := ver_src_pl_pos;
                    self.ver_src_pl                       := ver_src_pl;
                    self._ver_src_fdate_pl                := _ver_src_fdate_pl;
                    self.ver_src_fdate_pl                 := ver_src_fdate_pl;
                    self.ver_src_tn_pos                   := ver_src_tn_pos;
                    self.ver_src_tn                       := ver_src_tn;
                    self._ver_src_fdate_tn                := _ver_src_fdate_tn;
                    self.ver_src_fdate_tn                 := ver_src_fdate_tn;
                    self.ver_src_ts_pos                   := ver_src_ts_pos;
                    self._ver_src_fdate_ts                := _ver_src_fdate_ts;
                    self.ver_src_fdate_ts                 := ver_src_fdate_ts;
                    self.ver_src_tu_pos                   := ver_src_tu_pos;
                    self._ver_src_fdate_tu                := _ver_src_fdate_tu;
                    self.ver_src_fdate_tu                 := ver_src_fdate_tu;
                    self.ver_src_sl_pos                   := ver_src_sl_pos;
                    self.ver_src_sl                       := ver_src_sl;
                    self._ver_src_fdate_sl                := _ver_src_fdate_sl;
                    self.ver_src_fdate_sl                 := ver_src_fdate_sl;
                    self.ver_src_v_pos                    := ver_src_v_pos;
                    self.ver_src_v                        := ver_src_v;
                    self._ver_src_fdate_v                 := _ver_src_fdate_v;
                    self.ver_src_fdate_v                  := ver_src_fdate_v;
                    self.ver_src_vo_pos                   := ver_src_vo_pos;
                    self.ver_src_vo                       := ver_src_vo;
                    self._ver_src_fdate_vo                := _ver_src_fdate_vo;
                    self.ver_src_fdate_vo                 := ver_src_fdate_vo;
                    self.ver_src_w_pos                    := ver_src_w_pos;
                    self.ver_src_w                        := ver_src_w;
                    self._ver_src_fdate_w                 := _ver_src_fdate_w;
                    self.ver_src_fdate_w                  := ver_src_fdate_w;
                    self.ver_src_wp_pos                   := ver_src_wp_pos;
                    self._ver_src_fdate_wp                := _ver_src_fdate_wp;
                    self.ver_src_fdate_wp                 := ver_src_fdate_wp;
                    self.ver_dob_src_en_pos               := ver_dob_src_en_pos;
                    self.ver_dob_src_en                   := ver_dob_src_en;
                    self.ver_dob_src_eq_pos               := ver_dob_src_eq_pos;
                    self.ver_dob_src_eq                   := ver_dob_src_eq;
                    self.ver_dob_src_tn_pos               := ver_dob_src_tn_pos;
                    self.ver_dob_src_tn                   := ver_dob_src_tn;
                    self.rv_s65_ssn_problem               := rv_s65_ssn_problem;
                    self._rc_ssnhighissue                 := _rc_ssnhighissue;
                    self.nf_m_snc_ssn_high_issue          := nf_m_snc_ssn_high_issue;
                    self.rv_p86_hi_risk_phone_type        := rv_p86_hi_risk_phone_type;
                    self.rv_d30_derog_count               := rv_d30_derog_count;
                    self.rv_d31_attr_bankruptcy_recency   := rv_d31_attr_bankruptcy_recency;
                    self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
                    self.rv_c13_curr_addr_lres            := rv_c13_curr_addr_lres;
                    self.rv_i61_inq_collection_recency    := rv_i61_inq_collection_recency;
                    self.rv_i60_inq_mortgage_recency      := rv_i60_inq_mortgage_recency;
                    self.rv_i60_inq_hiriskcred_recency    := rv_i60_inq_hiriskcred_recency;
                    self.rv_i60_inq_prepaidcards_recency  := rv_i60_inq_prepaidcards_recency;
                    self.rv_i60_inq_retail_recency        := rv_i60_inq_retail_recency;
                    self.rv_i60_inq_comm_recency          := rv_i60_inq_comm_recency;
                    self.rv_i60_inq_other_recency         := rv_i60_inq_other_recency;
                    self.nf_inq_phone_ver_count           := nf_inq_phone_ver_count;
                    self.nf_inquiry_verification_index    := nf_inquiry_verification_index;
                    self.nf_inquiry_ssn_vel_risk_index    := nf_inquiry_ssn_vel_risk_index;
                    self.nf_inquiry_addr_vel_risk_index   := nf_inquiry_addr_vel_risk_index;
                    self.nf_inq_communications_count24    := nf_inq_communications_count24;
                    self.nf_inq_other_count24             := nf_inq_other_count24;
                    self.rv_d34_attr_unrel_liens_recency  := rv_d34_attr_unrel_liens_recency;
                    self.iv_nap_phn_verd                  := iv_nap_phn_verd;
                    self.iv_input_best_ssn_match          := iv_input_best_ssn_match;
                    self.rv_bus_addr_only_curr            := rv_bus_addr_only_curr;
                    self.rv_e58_br_dead_bus_x_active_phn  := rv_e58_br_dead_bus_x_active_phn;
                    self.iv_college_tier                  := iv_college_tier;
                    self.iv_prof_license_category_pl      := iv_prof_license_category_pl;
                    self.nf_attr_arrests                  := nf_attr_arrests;
                    self._liens_unrel_sc_first_seen       := _liens_unrel_sc_first_seen;
                    self.nf_mos_liens_unrel_sc_fseen      := nf_mos_liens_unrel_sc_fseen;
                    self._foreclosure_last_date           := _foreclosure_last_date;
                    self.nf_mos_foreclosure_lseen         := nf_mos_foreclosure_lseen;
                    self.nf_historic_x_current_ct         := nf_historic_x_current_ct;
                    self.nf_fp_srchfraudsrchcountyr       := nf_fp_srchfraudsrchcountyr;
                    self.nf_fp_srchcomponentrisktype      := nf_fp_srchcomponentrisktype;
                    self.nf_fp_prevaddroccupantowned      := nf_fp_prevaddroccupantowned;
                    self.num_dob_sources                  := num_dob_sources;
                    self.iv_dob_bureau_only               := iv_dob_bureau_only;
                    self.earliest_header_date             := earliest_header_date;
                    self.earliest_header_yrs              := earliest_header_yrs;
                    self._in_dob                          := _in_dob;
                    self.calc_dob                         := calc_dob;
                    self.iv_header_emergence_age          := iv_header_emergence_age;
                    self.iv_ssnsperadl_ssnunver           := iv_ssnsperadl_ssnunver;
                    self.corrssndob_src_ak_pos            := corrssndob_src_ak_pos;
                    self.corrssndob_src_ak                := corrssndob_src_ak;
                    self.corrssndob_src_am_pos            := corrssndob_src_am_pos;
                    self.corrssndob_src_am                := corrssndob_src_am;
                    self.corrssndob_src_ar_pos            := corrssndob_src_ar_pos;
                    self.corrssndob_src_ar                := corrssndob_src_ar;
                    self.corrssndob_src_ba_pos            := corrssndob_src_ba_pos;
                    self.corrssndob_src_ba                := corrssndob_src_ba;
                    self.corrssndob_src_cg_pos            := corrssndob_src_cg_pos;
                    self.corrssndob_src_cg                := corrssndob_src_cg;
                    self.corrssndob_src_co_pos            := corrssndob_src_co_pos;
                    self.corrssndob_src_co                := corrssndob_src_co;
                    self.corrssndob_src_cy_pos            := corrssndob_src_cy_pos;
                    self.corrssndob_src_cy                := corrssndob_src_cy;
                    self.corrssndob_src_da_pos            := corrssndob_src_da_pos;
                    self.corrssndob_src_da                := corrssndob_src_da;
                    self.corrssndob_src_d_pos             := corrssndob_src_d_pos;
                    self.corrssndob_src_d                 := corrssndob_src_d;
                    self.corrssndob_src_dl_pos            := corrssndob_src_dl_pos;
                    self.corrssndob_src_dl                := corrssndob_src_dl;
                    self.corrssndob_src_ds_pos            := corrssndob_src_ds_pos;
                    self.corrssndob_src_ds                := corrssndob_src_ds;
                    self.corrssndob_src_de_pos            := corrssndob_src_de_pos;
                    self.corrssndob_src_de                := corrssndob_src_de;
                    self.corrssndob_src_eb_pos            := corrssndob_src_eb_pos;
                    self.corrssndob_src_eb                := corrssndob_src_eb;
                    self.corrssndob_src_em_pos            := corrssndob_src_em_pos;
                    self.corrssndob_src_em                := corrssndob_src_em;
                    self.corrssndob_src_e1_pos            := corrssndob_src_e1_pos;
                    self.corrssndob_src_e1                := corrssndob_src_e1;
                    self.corrssndob_src_e2_pos            := corrssndob_src_e2_pos;
                    self.corrssndob_src_e2                := corrssndob_src_e2;
                    self.corrssndob_src_e3_pos            := corrssndob_src_e3_pos;
                    self.corrssndob_src_e3                := corrssndob_src_e3;
                    self.corrssndob_src_e4_pos            := corrssndob_src_e4_pos;
                    self.corrssndob_src_e4                := corrssndob_src_e4;
                    self.corrssndob_src_en_pos            := corrssndob_src_en_pos;
                    self.corrssndob_src_en                := corrssndob_src_en;
                    self.corrssndob_src_eq_pos            := corrssndob_src_eq_pos;
                    self.corrssndob_src_eq                := corrssndob_src_eq;
                    self.corrssndob_src_fe_pos            := corrssndob_src_fe_pos;
                    self.corrssndob_src_fe                := corrssndob_src_fe;
                    self.corrssndob_src_ff_pos            := corrssndob_src_ff_pos;
                    self.corrssndob_src_ff                := corrssndob_src_ff;
                    self.corrssndob_src_fr_pos            := corrssndob_src_fr_pos;
                    self.corrssndob_src_fr                := corrssndob_src_fr;
                    self.corrssndob_src_l2_pos            := corrssndob_src_l2_pos;
                    self.corrssndob_src_l2                := corrssndob_src_l2;
                    self.corrssndob_src_li_pos            := corrssndob_src_li_pos;
                    self.corrssndob_src_li                := corrssndob_src_li;
                    self.corrssndob_src_mw_pos            := corrssndob_src_mw_pos;
                    self.corrssndob_src_mw                := corrssndob_src_mw;
                    self.corrssndob_src_nt_pos            := corrssndob_src_nt_pos;
                    self.corrssndob_src_nt                := corrssndob_src_nt;
                    self.corrssndob_src_p_pos             := corrssndob_src_p_pos;
                    self.corrssndob_src_p                 := corrssndob_src_p;
                    self.corrssndob_src_pl_pos            := corrssndob_src_pl_pos;
                    self.corrssndob_src_pl                := corrssndob_src_pl;
                    self.corrssndob_src_tn_pos            := corrssndob_src_tn_pos;
                    self.corrssndob_src_tn                := corrssndob_src_tn;
                    self.corrssndob_src_ts_pos            := corrssndob_src_ts_pos;
                    self.corrssndob_src_ts                := corrssndob_src_ts;
                    self.corrssndob_src_tu_pos            := corrssndob_src_tu_pos;
                    self.corrssndob_src_tu                := corrssndob_src_tu;
                    self.corrssndob_src_sl_pos            := corrssndob_src_sl_pos;
                    self.corrssndob_src_sl                := corrssndob_src_sl;
                    self.corrssndob_src_v_pos             := corrssndob_src_v_pos;
                    self.corrssndob_src_v                 := corrssndob_src_v;
                    self.corrssndob_src_vo_pos            := corrssndob_src_vo_pos;
                    self.corrssndob_src_vo                := corrssndob_src_vo;
                    self.corrssndob_src_w_pos             := corrssndob_src_w_pos;
                    self.corrssndob_src_w                 := corrssndob_src_w;
                    self.corrssndob_src_wp_pos            := corrssndob_src_wp_pos;
                    self.corrssndob_src_wp                := corrssndob_src_wp;
                    self.corrssndob_ct                    := corrssndob_ct;
                    self.nf_corrssndob                    := nf_corrssndob;
                    self.nf_factact_curr_fraud_alert      := nf_factact_curr_fraud_alert;
                    self.mod1_v01_w                       := mod1_v01_w;
                    self.mod1_v02_w                       := mod1_v02_w;
                    self.mod1_v03_w                       := mod1_v03_w;
                    self.mod1_v04_w                       := mod1_v04_w;
                    self.mod1_v05_w                       := mod1_v05_w;
                    self.mod1_v06_w                       := mod1_v06_w;
                    self.mod1_v07_w                       := mod1_v07_w;
                    self.mod1_v08_w                       := mod1_v08_w;
                    self.mod1_v09_w                       := mod1_v09_w;
                    self.mod1_v10_w                       := mod1_v10_w;
                    self.mod1_v11_w                       := mod1_v11_w;
                    self.mod1_v12_w                       := mod1_v12_w;
                    self.mod1_v13_w                       := mod1_v13_w;
                    self.mod1_v14_w                       := mod1_v14_w;
                    self.mod1_v15_w                       := mod1_v15_w;
                    self.mod1_v16_w                       := mod1_v16_w;
                    self.mod1_v17_w                       := mod1_v17_w;
                    self.mod1_v18_w                       := mod1_v18_w;
                    self.mod1_v19_w                       := mod1_v19_w;
                    self.mod1_v20_w                       := mod1_v20_w;
                    self.mod1_v21_w                       := mod1_v21_w;
                    self.mod1_v22_w                       := mod1_v22_w;
                    self.mod1_v23_w                       := mod1_v23_w;
                    self.mod1_v24_w                       := mod1_v24_w;
                    self.mod1_v25_w                       := mod1_v25_w;
                    self.mod1_v26_w                       := mod1_v26_w;
                    self.mod1_v27_w                       := mod1_v27_w;
                    self.mod1_v28_w                       := mod1_v28_w;
                    self.mod1_v29_w                       := mod1_v29_w;
                    self.mod1_v30_w                       := mod1_v30_w;
                    self.mod1_v31_w                       := mod1_v31_w;
                    self.mod1_v32_w                       := mod1_v32_w;
                    self.mod1_v33_w                       := mod1_v33_w;
                    self.mod1_v34_w                       := mod1_v34_w;
                    self.mod1_v35_w                       := mod1_v35_w;
                    self.mod1_v36_w                       := mod1_v36_w;
                    self.mod1_v37_w                       := mod1_v37_w;
                    self.mod1_v38_w                       := mod1_v38_w;
                    self.mod1_v39_w                       := mod1_v39_w;
                    self.mod1_lgt                         := mod1_lgt;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.fp1710_1_0_nooverrides           := fp1710_1_0_nooverrides;
                    self.or_decssn                        := or_decssn;
                    self.or_ssnpriordob                   := or_ssnpriordob;
                    self.or_prisonaddr                    := or_prisonaddr;
                    self.or_prisonphone                   := or_prisonphone;
                    self.or_hraddr                        := or_hraddr;
                    self.or_hrphone                       := or_hrphone;
                    self.or_invalidssn                    := or_invalidssn;
                    self.or_invalidaddr                   := or_invalidaddr;
                    self.or_invalidphone                  := or_invalidphone;
                    self.fp1710_1_0_score                 := fp1710_1_0_score;
                    self.fp1710_1_0                       := fp1710_1_0;
                    self._ver_src_ds                      := _ver_src_ds;
                    self._ver_src_de                      := _ver_src_de;
                    self._derog                           := _derog;
                    self._deceased                        := _deceased;
                    self._ssnpriortodob                   := _ssnpriortodob;
                    self._inputmiskeys                    := _inputmiskeys;
                    self._multiplessns                    := _multiplessns;
                    self._hh_strikes                      := _hh_strikes;
                    self.stolenid                         := stolenid;
                    self.manipulatedid                    := manipulatedid;
                    self.manipulatedidpt2                 := manipulatedidpt2;
                    self.rv_a41_prop_owner                := rv_a41_prop_owner;
                    self._sum_bureau                      := _sum_bureau;
                    self._sum_credentialed                := _sum_credentialed;
                    self.syntheticid                      := syntheticid;
                    self.suspiciousactivity               := suspiciousactivity;
                    self.vulnerablevictim                 := vulnerablevictim;
                    self.friendlyfraud                    := friendlyfraud;
                    self.stolenc_redev                    := stolenc_redev;
                    self.manip2c_redev                    := manip2c_redev;
                    self.synthc_redev                     := synthc_redev;
                    self.suspactc_redev                   := suspactc_redev;
                    self.vulnvicc_redev                   := vulnvicc_redev;
                    self.friendlyc_redev                  := friendlyc_redev;
                    self.custstolidindex                  := custstolidindex;
                    self.custmanipidindex                 := custmanipidindex;
                    self.custsynthidindex                 := custsynthidindex;
                    self.custsuspactindex                 := custsuspactindex;
                    self.custvulnvicindex                 := custvulnvicindex;
                    self.custfriendfrdindex               := custfriendfrdindex;
	
	                  SELF.clam                             := le;                     //***Attach the entire Boca Shell when DEBUG MODE is TRUE
#end

	           self.seq                                     := le.seq;
	           self.StolenIdentityIndex                     := (STRING)custstolidindex;
             self.ManipulatedIdentityIndex                := (STRING)custmanipidindex;
             self.SyntheticIdentityIndex                  := (STRING)custsynthidindex;
             self.SuspiciousActivityIndex                 := (STRING)custsuspactindex;
             self.VulnerableVictimIndex                   := (STRING)custvulnvicindex;
             self.FriendlyFraudIndex                      := (STRING)custfriendfrdindex;
             ritmp                                        :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons);
	           reasons                                      := Models.Common.checkFraudPointRC34(fp1710_1_0, ritmp, num_reasons);
	           self.ri                                      := reasons;
	           self.score                                   := (STRING)fp1710_1_0_score;
	           self                                         := [];
	
      END;

   model :=   project(clam, doModel(left) );
	
	return model;
END;

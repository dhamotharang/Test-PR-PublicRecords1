IMPORT Models, Risk_Indicators, STD, Business_Risk_BIP;



EXPORT BBFM1906_1_0 (GROUPED DATASET(risk_indicators.Layout_Boca_Shell) clam,
                    GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell
                    ) := FUNCTION
num_reasons   := 4;
boolean business_only := FALSE;


businessplus_layout := record 
risk_indicators.Layout_Boca_Shell clam;
Business_Risk_BIP.Layouts.Shell busShell;

end;


busshellplusclam := join ( busShell ,clam,
left.input_echo.seq = right.seq,

transform (businessplus_layout, self.busShell := left, self.clam :=right));


	MODEL_DEBUG := FALSE;
	// MODEL_DEBUG := TRUE;

	isFCRA := False;


	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
  unsigned seq ;
  integer	sysdate;
  integer	_b_ver_src_id_br_pos;
  string	__b_ver_src_id_fdate_br;
  integer	_b_ver_src_id_fdate_br;
  string	__b_ver_src_id_ldate_br;
  integer	_b_ver_src_id_ldate_br;
  integer	_b_ver_src_id_c_pos;
  string	__b_ver_src_id_fdate_c;
  integer	_b_ver_src_id_fdate_c;
  string	__b_ver_src_id_ldate_c;
  integer	_b_ver_src_id_ldate_c;
  integer	_b_ver_src_id_p_pos;
  string	__b_ver_src_id_fdate_p;
  integer	_b_ver_src_id_fdate_p;
  boolean	truebiz_ln;
  boolean	source_ar;
  boolean	source_ba;
  boolean	source_bm;
  boolean	source_c;
  boolean	source_cs;
  boolean	source_dn;
  boolean	source_ef;
  boolean	source_ft;
  boolean	source_i;
  boolean	source_ia;
  boolean	source_in;
  boolean	source_l2;
  boolean	source_p;
  boolean	source_ut;
  boolean	source_v2;
  boolean	source_wk;
  integer	num_pos_sources;
  integer	num_neg_sources;
  integer	bv_assoc_bus_total;
  integer	bv_empl_ct_max;
  integer	bv_empl_ct_min;
  integer	bv_inq_other_count12;
  real	bv_inq_other_pct12;
  integer	bv_inq_total_count12;
  integer	bv_lien_filed_count;
  integer	bv_mth_bureau_fs;
  integer	bv_mth_bureau_ls;
  integer	bv_mth_ver_src_br_fs;
  integer	bv_mth_ver_src_br_ls;
  integer	bv_mth_ver_src_c_fs;
  integer	bv_mth_ver_src_c_ls;
  integer	bv_mth_ver_src_p_fs;
  string fin_reported_sales;
  integer	bv_sales;
  integer	bv_sos_current_standing;
  integer	_sos_inc_filing_firstseen;
  integer	bv_sos_mth_fs;
  integer	_sos_inc_filing_lastseen;
  integer	bv_sos_mth_ls;
  integer	bv_ucc_active_count;
  integer	bv_ucc_count;
  integer	_ucc_firstseen;
  integer	bv_ucc_mth_fs;
  integer	_ucc_lastseen;
  integer	bv_ucc_mth_ls;
  integer	bv_ucc_other_count;
  string	ucc_active_count;
  integer	bv_ucc_index;
  real	bv_ver_src_derog_ratio;
  integer	bv_ver_src_id_count;
  integer	bv_ver_src_id_mth_since_fs;
  integer	bv_ver_src_id_mth_since_ls;
  integer	bx_addr_assessed_value;
  integer	bx_addr_bldg_size;
  integer	bx_addr_lot_size;
  integer	bx_addr_lres;
  integer	bx_addr_src_count;
  integer	bx_assoc_city_match_ct;
  integer	bx_assoc_county_match_ct;
  integer	bx_consumer_addr;
  integer	bx_fein_contradictory_id;
  integer	bx_fein_contradictory_in;
  integer	bx_fein_src_count;
  integer	bx_inq_consumer_addr_cnt;
  integer	bx_inq_consumer_phn_cnt;
  integer	bx_irs_retirementplan;
  integer	bx_name_src_count;
  integer	bx_phn_contradictory;
  integer	bx_phn_distance_addr;
  integer	bx_phn_mobile;
  integer	bx_phn_not_in_zipcode;
  integer	bx_phn_problems;
  integer	bx_phn_src_count;
  integer	bx_phn_verification;
  integer	bx_rep_addr_distance;
  integer	bx_tin_match_consumer_associate;
  integer	ver_src_am_pos;
  string	_ver_src_fdate_am;
  integer	ver_src_fdate_am;
  integer	ver_src_ar_pos;
  string	_ver_src_fdate_ar;
  integer	ver_src_fdate_ar;
  integer	ver_src_ba_pos;
  string	_ver_src_fdate_ba;
  integer	ver_src_fdate_ba;
  integer	ver_src_cg_pos;
  string	_ver_src_fdate_cg;
  integer	ver_src_fdate_cg;
  integer	ver_src_da_pos;
  string	_ver_src_fdate_da;
  integer	ver_src_fdate_da;
  integer	ver_src_d_pos;
  string	_ver_src_fdate_d;
  integer	ver_src_fdate_d;
  integer	ver_src_dl_pos;
  string	_ver_src_fdate_dl;
  integer	ver_src_fdate_dl;
  integer	ver_src_eb_pos;
  string	_ver_src_fdate_eb;
  integer	ver_src_fdate_eb;
  integer	ver_src_e1_pos;
  string	_ver_src_fdate_e1;
  integer	ver_src_fdate_e1;
  integer	ver_src_e2_pos;
  string	_ver_src_fdate_e2;
  integer	ver_src_fdate_e2;
  integer	ver_src_e3_pos;
  string	_ver_src_fdate_e3;
  integer	ver_src_fdate_e3;
  integer	ver_src_eq_pos;
  string	_ver_src_fdate_eq;
  integer	ver_src_fdate_eq;
  integer	ver_src_fe_pos;
  string	_ver_src_fdate_fe;
  integer	ver_src_fdate_fe;
  integer	ver_src_ff_pos;
  string	_ver_src_fdate_ff;
  integer	ver_src_fdate_ff;
  integer	ver_src_p_pos;
  string	_ver_src_fdate_p;
  integer	ver_src_fdate_p;
  integer	ver_src_pl_pos;
  string	_ver_src_fdate_pl;
  integer	ver_src_fdate_pl;
  integer	ver_src_sl_pos;
  string	_ver_src_fdate_sl;
  integer	ver_src_fdate_sl;
  integer	ver_src_v_pos;
  string	_ver_src_fdate_v;
  integer	ver_src_fdate_v;
  integer	ver_src_vo_pos;
  string	_ver_src_fdate_vo;
  integer	ver_src_fdate_vo;
  integer	ver_src_w_pos;
  string	_ver_src_fdate_w;
  integer	ver_src_fdate_w;
  integer	ver_fname_src_en_pos;
  boolean	ver_fname_src_en;
  integer	ver_fname_src_eq_pos;
  boolean	ver_fname_src_eq;
  integer	ver_fname_src_tn_pos;
  boolean	ver_fname_src_tn;
  integer	ver_lname_src_en_pos;
  boolean	ver_lname_src_en;
  integer	ver_lname_src_eq_pos;
  boolean	ver_lname_src_eq;
  integer	ver_lname_src_tn_pos;
  boolean	ver_lname_src_tn;
  integer	ver_addr_src_en_pos;
  boolean	ver_addr_src_en;
  integer	ver_addr_src_eq_pos;
  boolean	ver_addr_src_eq;
  integer	ver_addr_src_tn_pos;
  boolean	ver_addr_src_tn;
  integer	ver_ssn_src_en_pos;
  boolean	ver_ssn_src_en;
  integer	ver_ssn_src_eq_pos;
  boolean	ver_ssn_src_eq;
  integer	ver_ssn_src_tn_pos;
  boolean	ver_ssn_src_tn;
  integer	ver_dob_src_en_pos;
  boolean	ver_dob_src_en;
  integer	ver_dob_src_eq_pos;
  boolean	ver_dob_src_eq;
  integer	ver_dob_src_tn_pos;
  boolean	ver_dob_src_tn;
  integer	num_bureau_fname;
  integer	num_bureau_lname;
  integer	num_bureau_addr;
  integer	num_bureau_ssn;
  integer	num_bureau_dob;
  integer	iv_addr_non_phn_src_ct;
  integer	iv_bureau_verification_index;
  integer	vo_pos;
  string	vote_adl_lseen_vo;
  integer	_vote_adl_lseen_vo;
  integer	iv_mos_src_voter_adl_lseen;
  integer	nf_add_dist_input_to_curr;
  integer	nf_average_rel_distance;
  integer	nf_bus_sos_filings_not_instate;
  integer	nf_fp_sourcerisktype;
  integer	nf_fp_srchfraudsrchcountyr;
  integer	nf_fp_srchunvrfdphonecount;
  integer	nf_fp_srchvelocityrisktype;
  integer	nf_historical_count;
  integer	nf_inq_perbestssn_count12;
  integer	nf_link_candidate_cnt;
  integer	earliest_cred_date_all;
  integer	nf_m_src_credentialed_fs;
  real	nf_pct_rel_prop_owned;
  integer	nf_ssns_per_curraddr_c6;
  integer	rv_i60_inq_count12;
  integer	rv_c20_m_bureau_adl_fs;
  real	bus_tree_0;
  real	bus_tree_1;
  real	bus_tree_2;
  real	bus_tree_3;
  real	bus_tree_4;
  real	bus_tree_5;
  real	bus_tree_6;
  real	bus_tree_7;
  real	bus_tree_8;
  real	bus_tree_9;
  real	bus_tree_10;
  real	bus_tree_11;
  real	bus_tree_12;
  real	bus_tree_13;
  real	bus_tree_14;
  real	bus_tree_15;
  real	bus_tree_16;
  real	bus_tree_17;
  real	bus_tree_18;
  real	bus_tree_19;
  real	bus_tree_20;
  real	bus_tree_21;
  real	bus_tree_22;
  real	bus_tree_23;
  real	bus_tree_24;
  real	bus_tree_25;
  real	bus_tree_26;
  real	bus_tree_27;
  real	bus_tree_28;
  real	bus_tree_29;
  real	bus_tree_30;
  real	bus_tree_31;
  real	bus_tree_32;
  real	bus_tree_33;
  real	bus_tree_34;
  real	bus_tree_35;
  real	bus_tree_36;
  real	bus_tree_37;
  real	bus_tree_38;
  real	bus_tree_39;
  real	bus_tree_40;
  real	bus_tree_41;
  real	bus_tree_42;
  real	bus_tree_43;
  real	bus_tree_44;
  real	bus_tree_45;
  real	bus_tree_46;
  real	bus_tree_47;
  real	bus_tree_48;
  real	bus_tree_49;
  real	bus_tree_50;
  real	bus_tree_51;
  real	bus_tree_52;
  real	bus_tree_53;
  real	bus_tree_54;
  real	bus_tree_55;
  real	bus_tree_56;
  real	bus_tree_57;
  real	bus_tree_58;
  real	bus_tree_59;
  real	bus_tree_60;
  real	bus_tree_61;
  real	bus_tree_62;
  real	bus_tree_63;
  real	bus_tree_64;
  real	bus_tree_65;
  real	bus_tree_66;
  real	bus_tree_67;
  real	bus_tree_68;
  real	bus_tree_69;
  real	bus_tree_70;
  real	bus_tree_71;
  real	bus_tree_72;
  real	bus_tree_73;
  real	bus_tree_74;
  real	bus_tree_75;
  real	bus_tree_76;
  real	bus_tree_77;
  real	bus_tree_78;
  real	bus_tree_79;
  real	bus_tree_80;
  real	bus_tree_81;
  real	bus_tree_82;
  real	bus_tree_83;
  real	bus_tree_84;
  real	bus_tree_85;
  real	bus_tree_86;
  real	bus_tree_87;
  real	bus_tree_88;
  real	bus_tree_89;
  real	bus_tree_90;
  real	bus_tree_91;
  real	bus_tree_92;
  real	bus_tree_93;
  real	bus_tree_94;
  real	bus_tree_95;
  real	bus_tree_96;
  real	bus_tree_97;
  real	bus_tree_98;
  real	bus_tree_99;
  real	bus_tree_100;
  real	bus_tree_101;
  real	bus_tree_102;
  real	bus_tree_103;
  real	bus_tree_104;
  real	bus_tree_105;
  real	bus_tree_106;
  real	bus_tree_107;
  real	bus_tree_108;
  real	bus_tree_109;
  real	bus_tree_110;
  real	bus_tree_111;
  real	bus_tree_112;
  real	bus_tree_113;
  real	bus_tree_114;
  real	bus_tree_115;
  real	bus_tree_116;
  real	bus_tree_117;
  real	bus_tree_118;
  real	bus_tree_119;
  real	bus_tree_120;
  real	bus_tree_121;
  real	bus_tree_122;
  real	bus_tree_123;
  real	bus_tree_124;
  real	bus_tree_125;
  real	bus_tree_126;
  real	bus_tree_127;
  real	bus_tree_128;
  real	bus_tree_129;
  real	bus_tree_130;
  real	bus_tree_131;
  real	bus_tree_132;
  real	bus_tree_133;
  real	bus_tree_134;
  real	bus_tree_135;
  real	bus_tree_136;
  real	bus_tree_137;
  real	bus_tree_138;
  real	bus_tree_139;
  real	bus_tree_140;
  real	bus_tree_141;
  real	bus_tree_142;
  real	bus_tree_143;
  real	bus_tree_144;
  real	bus_tree_145;
  real	bus_tree_146;
  real	bus_tree_147;
  real	bus_tree_148;
  real	bus_tree_149;
  real	bus_tree_150;
  real	bus_tree_151;
  real	bus_tree_152;
  real	bus_tree_153;
  real	bus_tree_154;
  real	bus_tree_155;
  real	bus_tree_156;
  real	bus_tree_157;
  real	bus_tree_158;
  real	bus_tree_159;
  real	bus_tree_160;
  real	bus_tree_161;
  real	bus_tree_162;
  real	bus_tree_163;
  real	bus_tree_164;
  real	bus_tree_165;
  real	bus_tree_166;
  real	bus_tree_167;
  real	bus_tree_168;
  real	bus_tree_169;
  real	bus_tree_170;
  real	bus_tree_171;
  real	bus_tree_172;
  real	bus_tree_173;
  real	bus_tree_174;
  real	bus_tree_175;
  real	bus_tree_176;
  real	bus_tree_177;
  real	bus_tree_178;
  real	bus_tree_179;
  real	bus_tree_180;
  real	bus_tree_181;
  real	bus_tree_182;
  real	bus_tree_183;
  real	bus_tree_184;
  real	bus_tree_185;
  real	bus_tree_186;
  real	bus_tree_187;
  real	bus_tree_188;
  real	bus_tree_189;
  real	bus_tree_190;
  real	bus_tree_191;
  real	bus_tree_192;
  real	bus_tree_193;
  real	bus_tree_194;
  real	bus_tree_195;
  real	bus_tree_196;
  real	bus_tree_197;
  real	bus_tree_198;
  real	bus_tree_199;
  real	bus_tree_200;
  real	bus_tree_201;
  real	bus_tree_202;
  real	bus_tree_203;
  real	bus_tree_204;
  real	bus_tree_205;
  real	bus_tree_206;
  real	bus_tree_207;
  real	bus_tree_208;
  real	bus_tree_209;
  real	bus_tree_210;
  real	bus_tree_211;
  real	bus_tree_212;
  real	bus_tree_213;
  real	bus_tree_214;
  real	bus_tree_215;
  real	bus_tree_216;
  real	bus_tree_217;
  real	bus_tree_218;
  real	bus_tree_219;
  real	bus_tree_220;
  real	bus_tree_221;
  real	bus_tree_222;
  real	bus_tree_223;
  real	bus_tree_224;
  real	bus_tree_225;
  real	bus_tree_226;
  real	bus_tree_227;
  real	bus_tree_228;
  real	bus_tree_229;
  real	bus_tree_230;
  real	bus_tree_231;
  real	bus_tree_232;
  real	bus_tree_233;
  real	bus_tree_234;
  real	bus_tree_235;
  real	bus_tree_236;
  real	bus_tree_237;
  real	bus_tree_238;
  real	bus_tree_239;
  real	bus_tree_240;
  real	bus_tree_241;
  real	bus_tree_242;
  real	bus_tree_243;
  real	bus_tree_244;
  real	bus_tree_245;
  real	bus_tree_246;
  real	bus_tree_247;
  real	bus_tree_248;
  real	bus_tree_249;
  real	bus_tree_250;
  real	bus_tree_251;
  real	bus_tree_252;
  real	bus_tree_253;
  real	bus_tree_254;
  real	bus_tree_255;
  real	bus_tree_256;
  real	bus_tree_257;
  real	bus_tree_258;
  real	bus_tree_259;
  real	bus_tree_260;
  real	bus_tree_261;
  real	bus_tree_262;
  real	bus_tree_263;
  real	bus_tree_264;
  real	bus_tree_265;
  real	bus_tree_266;
  real	bus_tree_267;
  real	bus_gbm_logit;
  real	pbr;
  integer	offset;
  real	lgt;
  integer	bus_score;
  real	con_v01_w;
  real	con_v02_w;
  real	con_v03_w;
  real	con_v04_w;
  real	con_v05_w;
  real	con_v06_w;
  real	con_v07_w;
  real	con_v08_w;
  real	con_v09_w;
  real	con_v10_w;
  real	con_v11_w;
  real	con_v12_w;
  real	con_v13_w;
  real	con_v14_w;
  real	con_v15_w;
  real	con_lgt;
  integer	con_score;
  real	bln_v01_w;
  real	bln_v02_w;
  real	bln_v03_w;
  real	bln_v04_w;
  real	bln_v05_w;
  real	bln_v06_w;
  real	bln_v07_w;
  real	bln_v08_w;
  real	bln_v09_w;
  real	bln_v10_w;
  real	bln_v11_w;
  real	bln_v12_w;
  real	bln_v13_w;
  real	bln_v14_w;
  real	bln_v15_w;
  real	bln_v16_w;
  real	bln_v17_w;
  real	bln_v18_w;
  real	bln_lgt;
  integer	base;
  integer	pts;
  real	odds;
  integer	bln_score;
  integer	unscrbl_bus;
  integer	unscrbl_con;
  integer	bbfm1906_1_0;
  string5 bbfm_wc1;
  string5 bbfm_wc2;
  string5 bbfm_wc3;
  string5 bbfm_wc4;

Risk_Indicators.Layout_Boca_Shell clam;
Business_Risk_BIP.Layouts.OutputLayout busShell;
			 
END;

    //layout_debug doModel (businessplus_layout le, easi.Key_Easi_Census rt) := TRANSFORM
    layout_debug doModel (businessplus_layout le) := TRANSFORM
  #else
  //  models.layout_ModelOut doModel(businessplus_layout le, easi.Key_Easi_Census rt) := TRANSFORM
    models.layout_ModelOut doModel(businessplus_layout le) := TRANSFORM
		
  #end	    
    
  /* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */  
  // MaxSASLength := 1000;  
   
  id_weight                        := le.busShell.Verification.InputIDMatchConfidence;
  pop_bus_name                     := le.busShell.Input.InputCheckBusName;
	pop_bus_addr                     := le.busShell.Input.InputCheckBusAddr;
	pop_bus_city                     := le.busShell.Input.InputCheckBusCity;
	pop_bus_state                    := le.busShell.Input.InputCheckBusState;
	pop_bus_zip                      := le.busShell.Input.InputCheckBusZip;
	pop_bus_fein                     := le.busShell.Input.InputCheckBusFEIN;
	pop_bus_phone                    := le.busShell.Input.InputCheckBusPhone;
	pop_rep1_first                   := le.busShell.Input.InputCheckAuthRepFirstName;
	pop_rep1_last                    := le.busShell.Input.InputCheckAuthRepLastName;
	pop_rep1_addr                    := le.busShell.Input.InputCheckAuthRepAddr;
	ver_src_id_mth_since_ls          := le.busShell.Business_Activity.SourceBusinessRecordTimeNewestID;
	ver_src_id_mth_since_fs          := le.busShell.Business_Activity.SourceBusinessRecordTimeOldestID;
	ver_src_id_count                 := le.busShell.Verification.SourceCountID;
	ver_src_count                    := le.busShell.Verification.SourceCount;
	ver_src_bureau_mth_since_fs      := le.busShell.Tradeline.TradeTimeOldest;
	ver_src_bureau_mth_since_ls      := le.busShell.Tradeline.TradeTimeNewest;
	ver_src_irsretirementplan        := le.busShell.Firmographic.FirmIRSRetirementPlan;
	ver_src_id_list                  := le.busShell.Verification.sourcelistID;
	ver_src_id_firstseen_list        := le.busShell.Verification.sourcedatefirstseenlistID;
	ver_src_id_lastseen_list         := le.busShell.Verification.sourcedatelastseenlistID;
	ver_src_list                     := le.busShell.Verification.sourcelist;
	ver_name_src_count               := le.busShell.Verification.NameMatchSourceCount;
	ver_addr_src_count               := le.busShell.Verification.AddrVerificationSourceCount;
	ver_addr_src_firstseen_list      := le.busShell.Verification.AddrVerificationDateFirstSeenList;
	ver_addr_src_lastseen_list       := le.busShell.Verification.AddrVerificationDateLastSeenList;
	ver_fein_src_count               := le.busShell.Verification.FEINMatchSourceCount;
	ver_phn_src_count                := le.busShell.Verification.PhoneMatchSourceCount;
	addr_input_lres                  := le.busShell.Verification.InputAddrLengthOfResidence;
	addr_input_assessed_value        := le.busShell.Input_Characteristics.InputAddrAssessedTotal;
	addr_input_lot_size              := le.busShell.Input_Characteristics.InputAddrLotSize;
	addr_input_bldg_size             := le.busShell.Input_Characteristics.InputAddrSqFootage;
	phn_input_ver_index              := le.busShell.Verification.VerificationBusInputPhone;
	phn_input_contradictory          := le.busShell.Verification.PhoneNameMismatch;
	phn_input_type                   := le.busShell.Input_Characteristics.InputPhoneMobile;
	phn_input_distance_addr          := le.busShell.Verification.PhoneDistance;
	fein_input_contradictory_id      := le.busShell.Verification.FEINBusinessMismatch;
	fein_input_contradictory_in      := le.busShell.Verification.FEINAddrNameMismatch;
	cons_record_match_addr           := le.busShell.Business_To_Person_Link.BusFEINPersonAddrOverlap;
	tin_match_cons_associate         := le.busShell.Verification.FEINAssociateSSNMatch;
	e2b_rep1_distance_addr           := le.busShell.Business_To_Executive_Link.AR2BBusRep1AddrDistance;
	assoc_count                      := le.busShell.Associates.AssociateCount;
	assoc_business_total             := le.busShell.Associates.AssociateBusinessCount;
	assoc_city_match_count           := le.busShell.Associates.AssociateCityCount;
	assoc_county_match_count         := le.busShell.Associates.AssociateCountyCount;
	sos_inc_filing_count             := le.busShell.SOS.SOSIncorporationCount;
	sos_inc_filing_firstseen         := le.busShell.SOS.SOSIncorporationDateFirstSeen;
	sos_inc_filing_lastseen          := le.busShell.SOS.SOSIncorporationDateLastSeen;
	sos_standing                     := le.busShell.SOS.SOSStanding;
	ucc_count                        := le.busShell.Public_Record.ucccount;
	ucc_firstseen                    := le.busShell.Public_Record.UCCInitialFilingDateFirstSeen;
	ucc_lastseen                     := le.busShell.Public_Record.UCCInitialFilingDateLastSeen;
	ucc_active_count                 := le.busShell.Public_Record.UCCActiveCount;
	ucc_terminated_count             := le.busShell.Public_Record.UCCTerminatedCount;
	ucc_other_count                  := le.busShell.Public_Record.UCCOtherCount;
	empl_ct_min                      := le.busShell.Firmographic.FirmEmployeeCountsmallest;
	empl_ct_max                      := le.busShell.Firmographic.FirmEmployeeCountlargest;
	inq_total_count12                := le.busShell.Inquiry.Inquiry12Month;
	inq_oth_count12                  := le.busShell.Inquiry.InquiryOther12Month;
	inq_consumer_addr                := le.busShell.Inquiry.inquiryconsumeraddress;
	inq_consumer_phone               := le.busShell.Inquiry.inquiryconsumerphone;
	id_seleid                        := le.busShell.Verification.inputidmatchseleid;
	lien_filed_count                 := le.busShell.Lien_And_Judgment.LienCount;
	fin_reported_sales               := le.busShell.Firmographic.FirmReportedSales;
	phn_input_problems               := le.busShell.Input_Characteristics.InputPhoneProblems;
  truedid                          := le.clam.truedid;
	in_zipcode                       := le.clam.shell_input.in_zipcode;
	rc_addrcount                     := le.clam.iid.addrcount;
	ver_sources                      := le.clam.header_summary.ver_sources;
	ver_sources_first_seen           := le.clam.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.clam.header_summary.ver_sources_last_seen_date;
	ver_fname_sources                := le.clam.header_summary.ver_fname_sources;
	ver_lname_sources                := le.clam.header_summary.ver_lname_sources;
	ver_addr_sources                 := le.clam.header_summary.ver_addr_sources;
	ver_ssn_sources                  := le.clam.header_summary.ver_ssn_sources;
	ver_dob_sources                  := le.clam.header_summary.ver_dob_sources;
	bus_sos_filings_not_instate      := le.clam.BIP_Header54.bus_sos_filings_not_instate;
	fnamepop                         := le.clam.input_validation.firstname;
	lnamepop                         := le.clam.input_validation.lastname;
	addrpop                          := le.clam.input_validation.address;
	ssnlength                        := le.clam.input_validation.ssn_length;
	add_input_isbestmatch            := le.clam.address_verification.input_address_information.isbestmatch;
	add_input_pop                    := le.clam.addrpop;
	add_dist_input_to_curr           := le.clam.address_verification.distance_in_2_h1;
	add_curr_pop                     := le.clam.addrpop2;
	ssns_per_curraddr_c6             := le.clam.best_flags.ssns_per_curraddr_c6;
	inq_count12                      := le.clam.acc_logs.inquiries.count12;
	inq_perbestssn                   := le.clam.best_flags.inq_perbestssn;
	link_candidate_cnt               := le.clam.pii_stability.link_candidate_cnt;
	fp_sourcerisktype                := le.clam.fdattributesv2.sourcerisklevel;
	fp_srchvelocityrisktype          := le.clam.fdattributesv2.searchvelocityrisklevel;
	fp_srchunvrfdphonecount          := le.clam.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcountyr          := le.clam.fdattributesv2.searchfraudsearchcountyear;
	rel_count                        := le.clam.relatives.relative_count;
	rel_prop_owned_count             := le.clam.relatives.owned.relatives_property_count;
	rel_within25miles_count          := le.clam.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.clam.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.clam.relatives.relative_within500miles_count;
	rel_withinother_count            := le.clam.relatives.relative_withinother_count;
	historical_count                 := le.clam.vehicles.historical_count;

business_only_check := if(le.clam.did = 0 and le.clam.Shell_Input.fname = '' and le.clam.Shell_Input.mname = '' and le.clam.Shell_Input.lname = '', true, false);

//***Begining of the SAS code that was converted to ECL ****//

NULL := Models.Common.Null;

sysdate :=   __common__( common.sas_date(if(le.clam.historydate=999999, (string8)Std.Date.Today(), (string6)le.clam.historydate+'01')));

_b_ver_src_id_br_pos :=   __common__( Models.Common.findw_cpp(ver_src_id_list, 'BR' , '  ,', 'ie'));

__b_ver_src_id_fdate_br :=   __common__( if(_b_ver_src_id_br_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _b_ver_src_id_br_pos), '0'));

_b_ver_src_id_fdate_br :=   __common__( common.sas_date((string)(__b_ver_src_id_fdate_br)));

__b_ver_src_id_ldate_br :=   __common__( if(_b_ver_src_id_br_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _b_ver_src_id_br_pos), '0'));

_b_ver_src_id_ldate_br :=   __common__( common.sas_date((string)(__b_ver_src_id_ldate_br)));

_b_ver_src_id_c_pos :=   __common__( Models.Common.findw_cpp(ver_src_id_list, 'C' , '  ,', 'ie'));

__b_ver_src_id_fdate_c :=   __common__( if(_b_ver_src_id_c_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _b_ver_src_id_c_pos), '0'));

_b_ver_src_id_fdate_c :=   __common__( common.sas_date((string)(__b_ver_src_id_fdate_c)));

__b_ver_src_id_ldate_c :=   __common__( if(_b_ver_src_id_c_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _b_ver_src_id_c_pos), '0'));

_b_ver_src_id_ldate_c :=   __common__( common.sas_date((string)(__b_ver_src_id_ldate_c)));

_b_ver_src_id_p_pos :=   __common__( Models.Common.findw_cpp(ver_src_id_list, 'P' , '  ,', 'ie'));

__b_ver_src_id_fdate_p :=   __common__( if(_b_ver_src_id_p_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _b_ver_src_id_p_pos), '0'));

_b_ver_src_id_fdate_p :=   __common__( common.sas_date((string)(__b_ver_src_id_fdate_p)));

truebiz_ln :=   __common__( id_seleID != '0' and NOT(((integer)ver_src_id_count in [-1, 0])) and (integer)id_weight > 43);

source_ar :=   __common__( Models.Common.findw_cpp(ver_src_list, 'AR' ,  , '') > 0);

source_ba :=   __common__( Models.Common.findw_cpp(ver_src_list, 'BA' ,  , '') > 0);

source_bm :=   __common__( Models.Common.findw_cpp(ver_src_list, 'BM' ,  , '') > 0);

source_c :=   __common__( Models.Common.findw_cpp(ver_src_list, 'C' ,  , '') > 0);

source_cs :=   __common__( Models.Common.findw_cpp(ver_src_list, 'C#' ,  , '') > 0);

source_dn :=   __common__( Models.Common.findw_cpp(ver_src_list, 'DN' ,  , '') > 0);

source_ef :=   __common__( Models.Common.findw_cpp(ver_src_list, 'EF' ,  , '') > 0);

source_ft :=   __common__( Models.Common.findw_cpp(ver_src_list, 'FT' ,  , '') > 0);

source_i :=   __common__( Models.Common.findw_cpp(ver_src_list, 'I' ,  , '') > 0);

source_ia :=   __common__( Models.Common.findw_cpp(ver_src_list, 'IA' ,  , '') > 0);

source_in :=   __common__( Models.Common.findw_cpp(ver_src_list, 'IN' ,  , '') > 0);

source_l2 :=   __common__( Models.Common.findw_cpp(ver_src_list, 'L2' ,  , '') > 0);

source_p :=   __common__( Models.Common.findw_cpp(ver_src_list, 'P' ,  , '') > 0);

source_ut :=   __common__( Models.Common.findw_cpp(ver_src_list, 'UT' ,  , '') > 0);

source_v2 :=   __common__( Models.Common.findw_cpp(ver_src_list, 'V2' ,  , '') > 0);

source_wk :=   __common__( Models.Common.findw_cpp(ver_src_list, 'WK' ,  , '') > 0);

num_pos_sources :=   __common__( if(max((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, (integer)source_dn, (integer)source_ef, (integer)source_ft, (integer)source_i, (integer)source_ia, (integer)source_in, (integer)source_p, (integer)source_v2, (integer)source_wk) = NULL, NULL, sum((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, (integer)source_dn, (integer)source_ef, (integer)source_ft, (integer)source_i, (integer)source_ia, (integer)source_in, (integer)source_p, (integer)source_v2, (integer)source_wk)));

num_neg_sources :=   __common__( if(max((integer)source_ba, (integer)source_l2, (integer)source_ut) = NULL, NULL, sum((integer)source_ba, (integer)source_l2, (integer)source_ut)));

bv_assoc_bus_total :=   __common__( map(
    not(truebiz_ln) => NULL,
    assoc_count = '0' => -1,
                       (integer)assoc_business_total));

bv_empl_ct_max :=   __common__( if(not(truebiz_ln), NULL, (integer)empl_ct_max));

bv_empl_ct_min :=   __common__( if(not(truebiz_ln), NULL, (integer)empl_ct_min));

bv_inq_other_count12 :=   __common__( if(not(truebiz_ln), NULL, (integer)inq_oth_count12));

bv_inq_other_pct12 :=   __common__( map(
    not(truebiz_ln)       => NULL,
    inq_total_count12 = '0' => -1,
                             round((Real)inq_oth_count12 / (Real)inq_total_count12 / 0.001)*0.001));

bv_inq_total_count12 :=   __common__( if(not(truebiz_ln), NULL, (Integer)inq_total_count12));

bv_lien_filed_count :=   __common__( if(not(truebiz_ln), NULL, (Integer)lien_filed_count));

bv_mth_bureau_fs :=   __common__( map(
    not(truebiz_ln)                  => NULL,
    ver_src_bureau_mth_since_fs = '-1' => -1,
                                        (integer)ver_src_bureau_mth_since_fs));

bv_mth_bureau_ls :=   __common__( map(
    not(truebiz_ln)                  => NULL,
    ver_src_bureau_mth_since_ls = '-1' => -1,
                                        (integer)ver_src_bureau_mth_since_ls));

bv_mth_ver_src_br_fs :=   __common__( if(_b_ver_src_id_fdate_br = NULL, -1, if ((sysdate - _b_ver_src_id_fdate_br) / 30.5 >= 0, roundup((sysdate - _b_ver_src_id_fdate_br) / 30.5), truncate((sysdate - _b_ver_src_id_fdate_br) / 30.5))));

bv_mth_ver_src_br_ls :=   __common__( if(_b_ver_src_id_ldate_br = NULL, -1, if ((sysdate - _b_ver_src_id_ldate_br) / 30.5 >= 0, roundup((sysdate - _b_ver_src_id_ldate_br) / 30.5), truncate((sysdate - _b_ver_src_id_ldate_br) / 30.5))));

bv_mth_ver_src_c_fs :=   __common__( if(_b_ver_src_id_fdate_c = NULL, -1, if ((sysdate - _b_ver_src_id_fdate_c) / 30.5 >= 0, roundup((sysdate - _b_ver_src_id_fdate_c) / 30.5), truncate((sysdate - _b_ver_src_id_fdate_c) / 30.5))));

bv_mth_ver_src_c_ls :=   __common__( if(_b_ver_src_id_ldate_c = NULL, -1, if ((sysdate - _b_ver_src_id_ldate_c) / 30.5 >= 0, roundup((sysdate - _b_ver_src_id_ldate_c) / 30.5), truncate((sysdate - _b_ver_src_id_ldate_c) / 30.5))));

bv_mth_ver_src_p_fs :=   __common__( if(_b_ver_src_id_fdate_p = NULL, -1, if ((sysdate - _b_ver_src_id_fdate_p) / 30.5 >= 0, roundup((sysdate - _b_ver_src_id_fdate_p) / 30.5), truncate((sysdate - _b_ver_src_id_fdate_p) / 30.5))));

bv_sales :=   __common__( if(not(truebiz_ln), NULL, (integer)fin_reported_sales));

bv_sos_current_standing :=   __common__( map(
    not(truebiz_ln)          => NULL,
    sos_inc_filing_count = '0' => -1,
                                (integer)sos_standing));

_sos_inc_filing_firstseen :=   __common__( common.sas_date((string)(sos_inc_filing_firstseen)));

bv_sos_mth_fs :=   __common__( map(
    not(truebiz_ln)                  => NULL,
    _sos_inc_filing_firstseen = NULL => -1,
                                        if ((sysdate - _sos_inc_filing_firstseen) / (365.25 / 12) >= 0, roundup((sysdate - _sos_inc_filing_firstseen) / (365.25 / 12)), truncate((sysdate - _sos_inc_filing_firstseen) / (365.25 / 12)))));

_sos_inc_filing_lastseen :=   __common__( common.sas_date((string)(sos_inc_filing_lastseen)));

bv_sos_mth_ls :=   __common__( map(
    not(truebiz_ln)                 => NULL,
    _sos_inc_filing_lastseen = NULL => -1,
                                       if ((sysdate - _sos_inc_filing_lastseen) / (365.25 / 12) >= 0, roundup((sysdate - _sos_inc_filing_lastseen) / (365.25 / 12)), truncate((sysdate - _sos_inc_filing_lastseen) / (365.25 / 12)))));

bv_ucc_active_count :=   __common__( map(
    not(truebiz_ln) => NULL,
    ucc_count = '0'   => -1,
                       (integer)ucc_active_count));

bv_ucc_count :=   __common__( if(not(truebiz_ln), NULL, (integer)ucc_count));

_ucc_firstseen :=   __common__( common.sas_date((string)(ucc_firstseen)));

bv_ucc_mth_fs :=   __common__( map(
    not(truebiz_ln)       => NULL,
    _ucc_firstseen = NULL => -1,
                             if ((sysdate - _ucc_firstseen) / (365.25 / 12) >= 0, roundup((sysdate - _ucc_firstseen) / (365.25 / 12)), truncate((sysdate - _ucc_firstseen) / (365.25 / 12)))));

_ucc_lastseen :=   __common__( common.sas_date((string)(ucc_lastseen)));

bv_ucc_mth_ls :=   __common__( map(
    not(truebiz_ln)      => NULL,
    _ucc_lastseen = NULL => -1,
                            if ((sysdate - _ucc_lastseen) / (365.25 / 12) >= 0, roundup((sysdate - _ucc_lastseen) / (365.25 / 12)), truncate((sysdate - _ucc_lastseen) / (365.25 / 12)))));

bv_ucc_other_count :=   __common__( map(
    not(truebiz_ln) => NULL,
    ucc_count = '0'   => -1,
                       (integer)ucc_other_count));

bv_ucc_index :=   __common__( map(
    not(truebiz_ln)                                                         => NULL,
    0 <= bv_ucc_mth_ls AND bv_ucc_mth_ls <= 12 and (integer)ucc_terminated_count = 0 => 0,
    (integer)ucc_count = 0                                                          => 1,
    0 <= bv_ucc_mth_ls AND bv_ucc_mth_ls <= 12 or (integer)ucc_terminated_count = 0  => 2,
    (integer)ucc_active_count > 3                                                    => 3,
                                                                               4));

bv_ver_src_derog_ratio :=   __common__( map(
    not(truebiz_ln)                                                                                                                                                 => NULL,
    ver_src_list = ''                                                                                                                                             => -1,
    if(max(num_pos_sources, num_neg_sources) = NULL, NULL, sum(if(num_pos_sources = NULL, 0, num_pos_sources), if(num_neg_sources = NULL, 0, num_neg_sources))) = 0 => -2,
    num_neg_sources > 0                                                                                                                                             => round(num_neg_sources / if(max(num_pos_sources, num_neg_sources) = NULL, NULL, sum(if(num_pos_sources = NULL, 0, num_pos_sources), if(num_neg_sources = NULL, 0, num_neg_sources)))/.1)*.1,
                                                                                                                                                                       100 + num_pos_sources));

bv_ver_src_id_count :=   __common__( if(not(truebiz_ln), NULL, (integer)ver_src_id_count));

bv_ver_src_id_mth_since_fs :=   __common__( if(not(truebiz_ln), NULL, (integer)ver_src_id_mth_since_fs));

bv_ver_src_id_mth_since_ls :=   __common__( if(not(truebiz_ln), NULL, (integer)ver_src_id_mth_since_ls));

bx_addr_assessed_value :=   __common__( if(not(truebiz_ln) or pop_bus_addr = '0', NULL, (integer)addr_input_assessed_value));

bx_addr_bldg_size :=   __common__( if(not(truebiz_ln) or pop_bus_addr = '0', NULL, (integer)addr_input_bldg_size));

bx_addr_lot_size :=   __common__( if(not(truebiz_ln) or pop_bus_addr = '0', NULL, (integer)addr_input_lot_size));

bx_addr_lres :=   __common__( map(
    not(truebiz_ln) or pop_bus_addr = '0'                                                                       => NULL,
    trim((string)ver_addr_src_firstseen_list, ALL) = '' or trim((string)ver_addr_src_lastseen_list, ALL) = '' => -1,
                                                                                                                 (integer)addr_input_lres));

bx_addr_src_count :=   __common__( map(
    not(truebiz_ln) or pop_bus_addr = '0' => NULL,
    ver_src_id_count = '0'                => -1,
                                           (integer)ver_addr_src_count));

bx_assoc_city_match_ct :=   __common__( map(
    not(truebiz_ln) => NULL,
    assoc_count = '0' => -1,
                       (integer)assoc_city_match_count));

bx_assoc_county_match_ct :=   __common__( map(
    not(truebiz_ln) => NULL,
    assoc_count = '0' => -1,
                       (integer)assoc_county_match_count));

bx_consumer_addr :=   __common__( if(pop_bus_fein = '0' or pop_bus_addr = '0' or pop_bus_city = '0' or pop_bus_state = '0' or pop_bus_zip = '0', NULL, (integer)cons_record_match_addr));

bx_fein_contradictory_id :=   __common__( if(not(truebiz_ln) or pop_bus_fein = '0', NULL, (integer)fein_input_contradictory_id));

bx_fein_contradictory_in :=   __common__( if(not(truebiz_ln) or pop_bus_fein = '0', NULL, (integer)fein_input_contradictory_in));

bx_fein_src_count :=   __common__( map(
    not(truebiz_ln) or pop_bus_fein = '0' => NULL,
    ver_src_id_count = '0'                => -1,
                                           (integer)ver_fein_src_count));

bx_inq_consumer_addr_cnt :=   __common__( if(not(truebiz_ln) or pop_bus_addr = '0', NULL, (integer)inq_consumer_addr));

bx_inq_consumer_phn_cnt :=   __common__( if(not(truebiz_ln) or pop_bus_phone = '0', NULL, (integer)inq_consumer_phone));

bx_irs_retirementplan :=   __common__( if(not(truebiz_ln), NULL, (integer)ver_src_irsretirementplan));

bx_name_src_count :=   __common__( map(
    not(truebiz_ln) or pop_bus_name = '0' => NULL,
    ver_src_id_count = '0'                => -1,
                                           (integer)ver_name_src_count));

bx_phn_contradictory :=   __common__( if(not(truebiz_ln) or pop_bus_phone = '0', NULL, (integer)phn_input_contradictory));

bx_phn_distance_addr :=   __common__( if(not(truebiz_ln) or pop_bus_phone = '0', NULL, (integer)phn_input_distance_addr));

bx_phn_mobile := if(not(truebiz_ln) or pop_bus_phone = '0', NULL, (integer)(phn_input_type = '1'));

bx_phn_not_in_zipcode := if(not(truebiz_ln) or pop_bus_phone = '0' or pop_bus_zip = '0', NULL, (integer)(phn_input_problems = '4'));

bx_phn_problems :=   __common__( if(not(truebiz_ln) or pop_bus_phone = '0', NULL, (integer)phn_input_problems));

bx_phn_src_count :=   __common__( map(
    not(truebiz_ln) or pop_bus_phone = '0' => NULL,
    ver_src_count = '0'                    => -1,
                                            (integer)ver_phn_src_count));

bx_phn_verification :=   __common__( if(not(truebiz_ln) or pop_bus_phone = '0', NULL, (integer)phn_input_ver_index));

bx_rep_addr_distance :=   __common__( if(not(truebiz_ln) or pop_rep1_addr = '0', NULL, (integer)e2b_rep1_distance_addr));

bx_tin_match_consumer_associate :=   __common__( if(pop_bus_fein = '0', NULL, (integer)tin_match_cons_associate));

ver_src_am_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie'));

_ver_src_fdate_am :=   __common__( if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0'));

ver_src_fdate_am :=   __common__( common.sas_date((string)(_ver_src_fdate_am)));

ver_src_ar_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie'));

_ver_src_fdate_ar :=   __common__( if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0'));

ver_src_fdate_ar :=   __common__( common.sas_date((string)(_ver_src_fdate_ar)));

ver_src_ba_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie'));

_ver_src_fdate_ba :=   __common__( if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0'));

ver_src_fdate_ba :=   __common__( common.sas_date((string)(_ver_src_fdate_ba)));

ver_src_cg_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie'));

_ver_src_fdate_cg :=   __common__( if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0'));

ver_src_fdate_cg :=   __common__( common.sas_date((string)(_ver_src_fdate_cg)));

ver_src_da_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie'));

_ver_src_fdate_da :=   __common__( if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0'));

ver_src_fdate_da :=   __common__( common.sas_date((string)(_ver_src_fdate_da)));

ver_src_d_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie'));

_ver_src_fdate_d :=   __common__( if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0'));

ver_src_fdate_d :=   __common__( common.sas_date((string)(_ver_src_fdate_d)));

ver_src_dl_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie'));

_ver_src_fdate_dl :=   __common__( if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0'));

ver_src_fdate_dl :=   __common__( common.sas_date((string)(_ver_src_fdate_dl)));

ver_src_eb_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie'));

_ver_src_fdate_eb :=   __common__( if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0'));

ver_src_fdate_eb :=   __common__( common.sas_date((string)(_ver_src_fdate_eb)));

ver_src_e1_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie'));

_ver_src_fdate_e1 :=   __common__( if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0'));

ver_src_fdate_e1 :=   __common__( common.sas_date((string)(_ver_src_fdate_e1)));

ver_src_e2_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie'));

_ver_src_fdate_e2 :=   __common__( if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0'));

ver_src_fdate_e2 :=   __common__( common.sas_date((string)(_ver_src_fdate_e2)));

ver_src_e3_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie'));

_ver_src_fdate_e3 :=   __common__( if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0'));

ver_src_fdate_e3 :=   __common__( common.sas_date((string)(_ver_src_fdate_e3)));

ver_src_eq_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie'));

_ver_src_fdate_eq :=   __common__( if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0'));

ver_src_fdate_eq :=   __common__( common.sas_date((string)(_ver_src_fdate_eq)));

ver_src_fe_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie'));

_ver_src_fdate_fe :=   __common__( if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0'));

ver_src_fdate_fe :=   __common__( common.sas_date((string)(_ver_src_fdate_fe)));

ver_src_ff_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie'));

_ver_src_fdate_ff :=   __common__( if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0'));

ver_src_fdate_ff :=   __common__( common.sas_date((string)(_ver_src_fdate_ff)));

ver_src_p_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie'));

_ver_src_fdate_p :=   __common__( if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0'));

ver_src_fdate_p :=   __common__( common.sas_date((string)(_ver_src_fdate_p)));

ver_src_pl_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie'));

_ver_src_fdate_pl :=   __common__( if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0'));

ver_src_fdate_pl :=   __common__( common.sas_date((string)(_ver_src_fdate_pl)));

ver_src_sl_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie'));

_ver_src_fdate_sl :=   __common__( if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0'));

ver_src_fdate_sl :=   __common__( common.sas_date((string)(_ver_src_fdate_sl)));

ver_src_v_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie'));

_ver_src_fdate_v :=   __common__( if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0'));

ver_src_fdate_v :=   __common__( common.sas_date((string)(_ver_src_fdate_v)));

ver_src_vo_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie'));

_ver_src_fdate_vo :=   __common__( if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0'));

ver_src_fdate_vo :=   __common__( common.sas_date((string)(_ver_src_fdate_vo)));

ver_src_w_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie'));

_ver_src_fdate_w :=   __common__( if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0'));

ver_src_fdate_w :=   __common__( common.sas_date((string)(_ver_src_fdate_w)));

ver_fname_src_en_pos :=   __common__( Models.Common.findw_cpp(ver_fname_sources, 'EN' , '  ,', 'ie'));

ver_fname_src_en :=   __common__( ver_fname_src_en_pos > 0);

ver_fname_src_eq_pos :=   __common__( Models.Common.findw_cpp(ver_fname_sources, 'EQ' , '  ,', 'ie'));

ver_fname_src_eq :=   __common__( ver_fname_src_eq_pos > 0);

ver_fname_src_tn_pos :=   __common__( Models.Common.findw_cpp(ver_fname_sources, 'TN' , '  ,', 'ie'));

ver_fname_src_tn :=   __common__( ver_fname_src_tn_pos > 0);

ver_lname_src_en_pos :=   __common__( Models.Common.findw_cpp(ver_lname_sources, 'EN' , '  ,', 'ie'));

ver_lname_src_en :=   __common__( ver_lname_src_en_pos > 0);

ver_lname_src_eq_pos :=   __common__( Models.Common.findw_cpp(ver_lname_sources, 'EQ' , '  ,', 'ie'));

ver_lname_src_eq :=   __common__( ver_lname_src_eq_pos > 0);

ver_lname_src_tn_pos :=   __common__( Models.Common.findw_cpp(ver_lname_sources, 'TN' , '  ,', 'ie'));

ver_lname_src_tn :=   __common__( ver_lname_src_tn_pos > 0);

ver_addr_src_en_pos :=   __common__( Models.Common.findw_cpp(ver_addr_sources, 'EN' , '  ,', 'ie'));

ver_addr_src_en :=   __common__( ver_addr_src_en_pos > 0);

ver_addr_src_eq_pos :=   __common__( Models.Common.findw_cpp(ver_addr_sources, 'EQ' , '  ,', 'ie'));

ver_addr_src_eq :=   __common__( ver_addr_src_eq_pos > 0);

ver_addr_src_tn_pos :=   __common__( Models.Common.findw_cpp(ver_addr_sources, 'TN' , '  ,', 'ie'));

ver_addr_src_tn :=   __common__( ver_addr_src_tn_pos > 0);

ver_ssn_src_en_pos :=   __common__( Models.Common.findw_cpp(ver_ssn_sources, 'EN' , '  ,', 'ie'));

ver_ssn_src_en :=   __common__( ver_ssn_src_en_pos > 0);

ver_ssn_src_eq_pos :=   __common__( Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , '  ,', 'ie'));

ver_ssn_src_eq :=   __common__( ver_ssn_src_eq_pos > 0);

ver_ssn_src_tn_pos :=   __common__( Models.Common.findw_cpp(ver_ssn_sources, 'TN' , '  ,', 'ie'));

ver_ssn_src_tn :=   __common__( ver_ssn_src_tn_pos > 0);

ver_dob_src_en_pos :=   __common__( Models.Common.findw_cpp(ver_dob_sources, 'EN' , '  ,', 'ie'));

ver_dob_src_en :=   __common__( ver_dob_src_en_pos > 0);

ver_dob_src_eq_pos :=   __common__( Models.Common.findw_cpp(ver_dob_sources, 'EQ' , '  ,', 'ie'));

ver_dob_src_eq :=   __common__( ver_dob_src_eq_pos > 0);

ver_dob_src_tn_pos :=   __common__( Models.Common.findw_cpp(ver_dob_sources, 'TN' , '  ,', 'ie'));

ver_dob_src_tn :=   __common__( ver_dob_src_tn_pos > 0);

num_bureau_fname :=   __common__( (integer)ver_fname_src_eq +
    (integer)ver_fname_src_en +
    (integer)ver_fname_src_tn);

num_bureau_lname :=   __common__( (integer)ver_lname_src_eq +
    (integer)ver_lname_src_en +
    (integer)ver_lname_src_tn);

num_bureau_addr :=   __common__( (integer)ver_addr_src_eq +
    (integer)ver_addr_src_en +
    (integer)ver_addr_src_tn);

num_bureau_ssn :=   __common__( (integer)ver_ssn_src_eq +
    (integer)ver_ssn_src_en +
    (integer)ver_ssn_src_tn);

num_bureau_dob :=   __common__( (integer)ver_dob_src_eq +
    (integer)ver_dob_src_en +
    (integer)ver_dob_src_tn);

iv_addr_non_phn_src_ct :=   __common__( if(not(truedid and (boolean)(integer)add_input_pop), NULL, min(if(rc_addrcount = NULL, -NULL, rc_addrcount), 999)));
                                                        // )));
iv_bureau_verification_index :=  __common__( if(not(truedid), NULL, 
                                                        sum(1 * (integer)(max(num_bureau_fname, num_bureau_lname) > 0), 
                                                            2 * (integer)(num_bureau_addr > 0), 
                                                            4 * (integer)(num_bureau_dob > 0), 
                                                            8 * (integer)(num_bureau_ssn > 0))));


vo_pos :=   __common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

vote_adl_lseen_vo :=   __common__( if(vo_pos > 0, Models.Common.getw(ver_sources_last_seen, vo_pos, ','), ''));

_vote_adl_lseen_vo :=   __common__( common.sas_date((string)(vote_adl_lseen_vo)));

iv_mos_src_voter_adl_lseen :=   __common__( map(
    not(truedid)                  => NULL,
    _vote_adl_lseen_vo <> NULL => if ((sysdate - _vote_adl_lseen_vo) / (365.25 / 12) >= 0, truncate((sysdate - _vote_adl_lseen_vo) / (365.25 / 12)), roundup((sysdate - _vote_adl_lseen_vo) / (365.25 / 12))),
                                     -1));

nf_add_dist_input_to_curr :=   __common__( map(
    not((boolean)(integer)add_curr_pop and (boolean)(integer)add_input_pop) => NULL,
    add_input_isbestmatch                                                   => -1,
                                                                               min(9999, if(add_dist_input_to_curr = NULL, -NULL, add_dist_input_to_curr))));

nf_average_rel_distance :=   __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                      => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                     => -1,
    if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                         if (if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) >= 0, truncate(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))), roundup(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))))));

nf_bus_sos_filings_not_instate :=   __common__( if(not(truedid), NULL, bus_sos_filings_not_instate));

nf_fp_sourcerisktype :=   __common__( if(not(truedid), NULL, (integer)fp_sourcerisktype));

nf_fp_srchfraudsrchcountyr :=   __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = (string)NULL, -NULL, (integer)fp_srchfraudsrchcountyr), 999)));

nf_fp_srchunvrfdphonecount :=   __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = (string)NULL, -NULL, (integer)fp_srchunvrfdphonecount), 999)));

nf_fp_srchvelocityrisktype :=   __common__( if(not(truedid), NULL, (integer)fp_srchvelocityrisktype));

nf_historical_count :=   __common__( if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999)));

nf_inq_perbestssn_count12 :=   __common__( if(not(truedid), NULL, min(if(inq_perbestssn = NULL, -NULL, inq_perbestssn), 999)));

nf_link_candidate_cnt :=   __common__( if(not(truedid), NULL, link_candidate_cnt));

earliest_cred_date_all :=   __common__( if(ver_src_fdate_ar = NULL and ver_src_fdate_am = NULL and ver_src_fdate_ba = NULL and ver_src_fdate_cg = NULL and ver_src_fdate_da = NULL and ver_src_fdate_d = NULL and ver_src_fdate_dl = NULL and ver_src_fdate_eb = NULL and ver_src_fdate_e1 = NULL and ver_src_fdate_e2 = NULL and ver_src_fdate_e3 = NULL and ver_src_fdate_fe = NULL and ver_src_fdate_ff = NULL and ver_src_fdate_p = NULL and ver_src_fdate_pl = NULL and ver_src_fdate_sl = NULL and ver_src_fdate_v = NULL and ver_src_fdate_vo = NULL and ver_src_fdate_w = NULL, NULL, if(max(ver_src_fdate_ar, ver_src_fdate_am, ver_src_fdate_ba, ver_src_fdate_cg, ver_src_fdate_da, ver_src_fdate_d, ver_src_fdate_dl, ver_src_fdate_eb, ver_src_fdate_e1, ver_src_fdate_e2, ver_src_fdate_e3, ver_src_fdate_fe, ver_src_fdate_ff, ver_src_fdate_p, ver_src_fdate_pl, ver_src_fdate_sl, ver_src_fdate_v, ver_src_fdate_vo, ver_src_fdate_w) = NULL, NULL, min(if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w)))));

nf_m_src_credentialed_fs :=   __common__( map(
    not(truedid)                  => NULL,
    earliest_cred_date_all = NULL => -1,
                                     min(if(if ((sysdate - earliest_cred_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_cred_date_all) / (365.25 / 12)), roundup((sysdate - earliest_cred_date_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - earliest_cred_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_cred_date_all) / (365.25 / 12)), roundup((sysdate - earliest_cred_date_all) / (365.25 / 12)))), 999)));

nf_pct_rel_prop_owned :=   __common__( map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_prop_owned_count / rel_count));

nf_ssns_per_curraddr_c6 :=   __common__( if(not((boolean)(integer)add_curr_pop) or not(truedid), NULL, min(if(ssns_per_curraddr_c6 = NULL, -NULL, ssns_per_curraddr_c6), 999)));

rv_i60_inq_count12 :=   __common__( if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999)));

rv_c20_m_bureau_adl_fs :=   __common__( map(
    not(truedid)            => NULL,
    ver_src_fdate_eq = NULL => -1,
                               min(if(if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12)))), 999)));

bus_tree_0 :=   __common__( -2.93809201827476);

bus_tree_1_c984 :=   __common__( map(
    (bx_fein_contradictory_id in [1])      => 0.0725105273851908,
    (bx_fein_contradictory_id in [0, 2]) => 0.364413960516117,
    bx_fein_contradictory_id = NULL          => 0.155277060983863,
                                                0.155277060983863));

bus_tree_1_c983 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 17.5 => -0.0147833179220698,
    bv_empl_ct_max >= 17.5                          => bus_tree_1_c984,
    bv_empl_ct_max = NULL                           => -0.00498954759028798,
                                                       -0.00498954759028798));

bus_tree_1 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 4.5 => bus_tree_1_c983,
    bx_inq_consumer_phn_cnt >= 4.5                                   => 0.184713098708314,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00313108728396026,
                                                                        0.00313108728396026));

bus_tree_2_c987 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => 0.0985190600717687,
    bx_phn_mobile >= 0.5                         => 0.00993183586844012,
    bx_phn_mobile = NULL                         => 0.0289196494035367,
                                                    0.0289196494035367));

bus_tree_2_c986 :=   __common__( map(
    NULL < bx_phn_src_count AND bx_phn_src_count < 0.5 => bus_tree_2_c987,
    bx_phn_src_count >= 0.5                            => -0.0371681349326966,
    bx_phn_src_count = NULL                            => -0.00346470460809797,
                                                          -0.00346470460809797));

bus_tree_2 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 2322432 => bus_tree_2_c986,
    bv_sales >= 2322432                    => 0.207928122474682,
    bv_sales = NULL                        => 0.00198389358050581,
                                              0.00198389358050581));

bus_tree_3_c990 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3, 4]) => -0.0296305519915169,
    (bx_phn_contradictory in [0])                => 0.0404731847651156,
    bx_phn_contradictory = NULL                    => -0.0150591009747567,
                                                      -0.0150591009747567));

bus_tree_3_c989 :=   __common__( map(
    NULL < bx_irs_retirementplan AND bx_irs_retirementplan < 0.5 => bus_tree_3_c990,
    bx_irs_retirementplan >= 0.5                                 => 0.111444121976285,
    bx_irs_retirementplan = NULL                                 => -0.00774612743158993,
                                                                    -0.00774612743158993));

bus_tree_3 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 3.5 => bus_tree_3_c989,
    bx_inq_consumer_phn_cnt >= 3.5                                   => 0.114322811999727,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.000637025188323432,
                                                                        -0.000637025188323432));

bus_tree_4_c993 :=   __common__( map(
    NULL < bx_phn_src_count AND bx_phn_src_count < 0.5 => 0.0146196574137285,
    bx_phn_src_count >= 0.5                            => -0.0380795208922477,
    bx_phn_src_count = NULL                            => -0.0111480006560899,
                                                          -0.0111480006560899));

bus_tree_4_c992 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 6.5 => bus_tree_4_c993,
    bx_inq_consumer_phn_cnt >= 6.5                                   => 0.148407722352968,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00742277233380649,
                                                                        -0.00742277233380649));

bus_tree_4 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 1.5 => bus_tree_4_c992,
    bv_ucc_other_count >= 1.5                              => 0.206432288615519,
    bv_ucc_other_count = NULL                              => -0.00391509673093395,
                                                              -0.00391509673093395));

bus_tree_5_c996 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 3.5 => 0.00774623920270259,
    bx_inq_consumer_phn_cnt >= 3.5                                   => 0.101460643580698,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.0143663376333792,
                                                                        0.0143663376333792));

bus_tree_5_c995 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 171760 => bus_tree_5_c996,
    bv_sales >= 171760                    => 0.185974685574462,
    bv_sales = NULL                       => 0.0201586986124886,
                                             0.0201586986124886));

bus_tree_5 :=   __common__( map(
    NULL < bx_phn_verification AND bx_phn_verification < 0.5 => bus_tree_5_c995,
    bx_phn_verification >= 0.5                               => -0.0293815499724585,
    bx_phn_verification = NULL                               => -0.00429911817333519,
                                                                -0.00429911817333519));

bus_tree_6_c999 :=   __common__( map(
    NULL < bx_phn_src_count AND bx_phn_src_count < 0.5 => 0.0147807266697968,
    bx_phn_src_count >= 0.5                            => -0.0317393771855497,
    bx_phn_src_count = NULL                            => -0.00800425453294454,
                                                          -0.00800425453294454));

bus_tree_6_c998 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 2828800 => bus_tree_6_c999,
    bv_sales >= 2828800                    => 0.0963473316521723,
    bv_sales = NULL                        => -0.00567025496576718,
                                              -0.00567025496576718));

bus_tree_6 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 7.5 => bus_tree_6_c998,
    bx_inq_consumer_phn_cnt >= 7.5                                   => 0.128544164856304,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00322276155665715,
                                                                        -0.00322276155665715));

bus_tree_7_c1002 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 0 => 0.0607686263296778,
    bv_empl_ct_max >= 0                          => 0.202815316705555,
    bv_empl_ct_max = NULL                        => 0.138783907054253,
                                                    0.138783907054253));

bus_tree_7_c1001 :=   __common__( map(
    NULL < bx_phn_src_count AND bx_phn_src_count < 0.5 => bus_tree_7_c1002,
    bx_phn_src_count >= 0.5                            => 0.0118084043447578,
    bx_phn_src_count = NULL                            => 0.0560968477596962,
                                                          0.0560968477596962));

bus_tree_7 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 4.5 => -0.0117617263608344,
    bv_mth_bureau_fs >= 4.5                            => bus_tree_7_c1001,
    bv_mth_bureau_fs = NULL                            => -0.00321657258269347,
                                                          -0.00321657258269347));

bus_tree_8_c1005 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 8.5 => 0.0226045608568685,
    bv_ver_src_id_count >= 8.5                               => 0.145232617243967,
    bv_ver_src_id_count = NULL                               => 0.033978898889589,
                                                                0.033978898889589));

bus_tree_8_c1004 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3, 4]) => -0.0171515592000542,
    (bx_phn_contradictory in [0])                => bus_tree_8_c1005,
    bx_phn_contradictory = NULL                    => -0.00676419885058523,
                                                      -0.00676419885058523));

bus_tree_8 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 3.5 => bus_tree_8_c1004,
    bx_inq_consumer_phn_cnt >= 3.5                                   => 0.066796876883285,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00234661999617569,
                                                                        -0.00234661999617569));

bus_tree_9_c1008 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 11605 => 0.000423239870304582,
    bx_addr_lot_size >= 11605                            => -0.0434244140904478,
    bx_addr_lot_size = NULL                              => -0.0158446461640528,
                                                            -0.0158446461640528));

bus_tree_9_c1007 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 1445120 => bus_tree_9_c1008,
    bx_addr_assessed_value >= 1445120                                  => 0.0587838666037652,
    bx_addr_assessed_value = NULL                                      => -0.00939107896821566,
                                                                          -0.00939107896821566));

bus_tree_9 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 5.5 => bus_tree_9_c1007,
    bx_inq_consumer_phn_cnt >= 5.5                                   => 0.0849079166291525,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.006509860131844,
                                                                        -0.006509860131844));

bus_tree_10_c1011 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 1.5 => 0.105387342943216,
    bv_assoc_bus_total >= 1.5                              => 0.0101000873600244,
    bv_assoc_bus_total = NULL                              => 0.0613801628097107,
                                                              0.0613801628097107));

bus_tree_10_c1010 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 3.5 => -0.0129581574369872,
    bx_inq_consumer_phn_cnt >= 3.5                                   => bus_tree_10_c1011,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00850362088266953,
                                                                        -0.00850362088266953));

bus_tree_10 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 59 => bus_tree_10_c1010,
    bv_empl_ct_max >= 59                          => 0.119116572512159,
    bv_empl_ct_max = NULL                         => -0.00599558987113095,
                                                     -0.00599558987113095));

bus_tree_11_c1013 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 140.5 => -0.0224234376968345,
    bv_sos_mth_ls >= 140.5                         => 0.0341378434182808,
    bv_sos_mth_ls = NULL                           => -0.013773631611825,
                                                      -0.013773631611825));

bus_tree_11_c1014 :=   __common__( map(
    (bx_fein_contradictory_in in [1, 2, 3, 4]) => 0.0069475973177324,
    (bx_fein_contradictory_in in [0])                => 0.102661461737829,
    bx_fein_contradictory_in = NULL                    => 0.0601823918594653,
                                                          0.0601823918594653));

bus_tree_11 :=   __common__( map(
    NULL < bv_inq_other_count12 AND bv_inq_other_count12 < 1.5 => bus_tree_11_c1013,
    bv_inq_other_count12 >= 1.5                                => bus_tree_11_c1014,
    bv_inq_other_count12 = NULL                                => -0.00491903288328959,
                                                                  -0.00491903288328959));

bus_tree_12_c1017 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 7.5 => -0.00939508823743451,
    bx_inq_consumer_phn_cnt >= 7.5                                   => 0.0615133162641754,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00805318498239694,
                                                                        -0.00805318498239694));

bus_tree_12_c1016 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 5.5 => bus_tree_12_c1017,
    bx_phn_problems >= 5.5                           => 0.118962229923502,
    bx_phn_problems = NULL                           => -0.00546303593750607,
                                                        -0.00546303593750607));

bus_tree_12 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 1.5 => bus_tree_12_c1016,
    bv_ucc_other_count >= 1.5                              => 0.113820873494172,
    bv_ucc_other_count = NULL                              => -0.00347947886456812,
                                                              -0.00347947886456812));

bus_tree_13_c1020 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 0.5 => -0.0224733521397611,
    bx_phn_problems >= 0.5                           => 0.0883507850962073,
    bx_phn_problems = NULL                           => 0.0617529921595749,
                                                        0.0617529921595749));

bus_tree_13_c1019 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => bus_tree_13_c1020,
    bx_phn_mobile >= 0.5                         => 0.00188211178983039,
    bx_phn_mobile = NULL                         => 0.0153060759982933,
                                                    0.0153060759982933));

bus_tree_13 :=   __common__( map(
    NULL < bx_phn_verification AND bx_phn_verification < 0.5 => bus_tree_13_c1019,
    bx_phn_verification >= 0.5                               => -0.0273859555889792,
    bx_phn_verification = NULL                               => -0.00567484260388967,
                                                                -0.00567484260388967));

bus_tree_14_c1023 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3, 4]) => 0.00675188361103668,
    (bx_phn_contradictory in [0])                => 0.0661620393937914,
    bx_phn_contradictory = NULL                    => 0.0171357800854074,
                                                      0.0171357800854074));

bus_tree_14_c1022 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 31.5 => -0.0171569173197854,
    bv_mth_ver_src_c_fs >= 31.5                               => bus_tree_14_c1023,
    bv_mth_ver_src_c_fs = NULL                                => -0.00117825062138997,
                                                                 -0.00117825062138997));

bus_tree_14 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 78784 => bus_tree_14_c1022,
    bx_addr_bldg_size >= 78784                             => 0.105382854069173,
    bx_addr_bldg_size = NULL                               => 0.00130253700103585,
                                                              0.00130253700103585));

bus_tree_15_c1026 :=   __common__( map(
    NULL < bx_name_src_count AND bx_name_src_count < 9.5 => 0.0122563181361215,
    bx_name_src_count >= 9.5                             => 0.121701747808895,
    bx_name_src_count = NULL                             => 0.0155823263795246,
                                                            0.0155823263795246));

bus_tree_15_c1025 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3]) => -0.0249700571684312,
    (bx_phn_contradictory in [0, 4])      => bus_tree_15_c1026,
    bx_phn_contradictory = NULL               => -0.00404213065886114,
                                                 -0.00404213065886114));

bus_tree_15 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 20.5 => bus_tree_15_c1025,
    bx_phn_distance_addr >= 20.5                                => 0.157876575740996,
    bx_phn_distance_addr = NULL                                 => -0.000512802130209286,
                                                                   -0.000512802130209286));

bus_tree_16_c1029 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 23.5 => 0.0615808813185427,
    bv_sos_mth_fs >= 23.5                         => 0.201034439230385,
    bv_sos_mth_fs = NULL                          => 0.111729205099649,
                                                     0.111729205099649));

bus_tree_16_c1028 :=   __common__( map(
    NULL < bx_phn_not_in_zipcode AND bx_phn_not_in_zipcode < 0.5 => 0.0119354117436591,
    bx_phn_not_in_zipcode >= 0.5                                 => bus_tree_16_c1029,
    bx_phn_not_in_zipcode = NULL                                 => 0.0257540611647136,
                                                                    0.0257540611647136));

bus_tree_16 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => bus_tree_16_c1028,
    bx_phn_mobile >= 0.5                         => -0.0117899874926449,
    bx_phn_mobile = NULL                         => 0.000757028160475382,
                                                    0.000757028160475382));

bus_tree_17_c1031 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 3.5 => -0.0233818877276382,
    bv_ver_src_id_mth_since_ls >= 3.5                                      => 0.0186546526853467,
    bv_ver_src_id_mth_since_ls = NULL                                      => -0.0114918795857976,
                                                                              -0.0114918795857976));

bus_tree_17_c1032 :=   __common__( map(
    (bx_fein_contradictory_in in [1, 2])      => 0.013777935362733,
    (bx_fein_contradictory_in in [0, 3, 4]) => 0.144067620248066,
    bx_fein_contradictory_in = NULL               => 0.0544720889095957,
                                                     0.0544720889095957));

bus_tree_17 :=   __common__( map(
    NULL < bx_name_src_count AND bx_name_src_count < 9.5 => bus_tree_17_c1031,
    bx_name_src_count >= 9.5                             => bus_tree_17_c1032,
    bx_name_src_count = NULL                             => -0.00768262244819512,
                                                            -0.00768262244819512));

bus_tree_18_c1035 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 2.5 => 0.0947082384889733,
    bv_ver_src_id_count >= 2.5                               => 0.00843434902506238,
    bv_ver_src_id_count = NULL                               => 0.053296771546296,
                                                                0.053296771546296));

bus_tree_18_c1034 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 3.5 => -0.00218587609670947,
    bx_inq_consumer_phn_cnt >= 3.5                                   => bus_tree_18_c1035,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00105569013623079,
                                                                        0.00105569013623079));

bus_tree_18 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 410.5 => bus_tree_18_c1034,
    bv_sos_mth_ls >= 410.5                         => 0.120199551058727,
    bv_sos_mth_ls = NULL                           => 0.00394648222664056,
                                                      0.00394648222664056));

bus_tree_19_c1038 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 134128 => 0.144645081049211,
    bx_addr_assessed_value >= 134128                                  => 0.0431720302913768,
    bx_addr_assessed_value = NULL                                     => 0.0869007482975153,
                                                                         0.0869007482975153));

bus_tree_19_c1037 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 86.5 => 0.0188724021854136,
    bv_sos_mth_ls >= 86.5                         => bus_tree_19_c1038,
    bv_sos_mth_ls = NULL                          => 0.0325638002354029,
                                                     0.0325638002354029));

bus_tree_19 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3, 4]) => -0.0135526046338197,
    (bx_phn_contradictory in [0])                => bus_tree_19_c1037,
    bx_phn_contradictory = NULL                    => -0.00409444725357169,
                                                      -0.00409444725357169));

bus_tree_20_c1041 :=   __common__( map(
    NULL < bx_name_src_count AND bx_name_src_count < 9.5 => -0.00670873470554346,
    bx_name_src_count >= 9.5                             => 0.0431587045345827,
    bx_name_src_count = NULL                             => -0.00372280315776299,
                                                            -0.00372280315776299));

bus_tree_20_c1040 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 4.5 => bus_tree_20_c1041,
    bx_phn_problems >= 4.5                           => 0.0679882621768775,
    bx_phn_problems = NULL                           => -0.00201712216340621,
                                                        -0.00201712216340621));

bus_tree_20 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 9881600 => bus_tree_20_c1040,
    bx_addr_assessed_value >= 9881600                                  => 0.10846819362682,
    bx_addr_assessed_value = NULL                                      => 0.000529969394871878,
                                                                          0.000529969394871878));

bus_tree_21_c1044 :=   __common__( map(
    (bx_fein_contradictory_id in [0, 2]) => 0.0044782036631796,
    (bx_fein_contradictory_id in [1])      => 0.0626263051436676,
    bx_fein_contradictory_id = NULL          => 0.0174825714064197,
                                                0.0174825714064197));

bus_tree_21_c1043 :=   __common__( map(
    NULL < bv_inq_other_count12 AND bv_inq_other_count12 < 2.5 => bus_tree_21_c1044,
    bv_inq_other_count12 >= 2.5                                => 0.0955362183585396,
    bv_inq_other_count12 = NULL                                => 0.0237268631625893,
                                                                  0.0237268631625893));

bus_tree_21 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3, 4]) => -0.00942302138942793,
    (bx_phn_contradictory in [0])                => bus_tree_21_c1043,
    bx_phn_contradictory = NULL                    => -0.00255773522099451,
                                                      -0.00255773522099451));

bus_tree_22_c1047 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => 0.0484131276169245,
    bx_consumer_addr >= 0.5                            => -0.0223329388648725,
    bx_consumer_addr = NULL                            => 0.0143655073003808,
                                                          0.0143655073003808));

bus_tree_22_c1046 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 6.5 => bus_tree_22_c1047,
    bv_ver_src_id_mth_since_ls >= 6.5                                      => 0.123594901381966,
    bv_ver_src_id_mth_since_ls = NULL                                      => 0.0289570445628598,
                                                                              0.0289570445628598));

bus_tree_22 :=   __common__( map(
    NULL < bv_inq_other_pct12 AND bv_inq_other_pct12 < 0.796 => -0.00904437396081632,
    bv_inq_other_pct12 >= 0.796                              => bus_tree_22_c1046,
    bv_inq_other_pct12 = NULL                                => -0.00222824651133156,
                                                                -0.00222824651133156));

bus_tree_23_c1050 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 15.5 => -0.0328677926367005,
    bv_ver_src_id_mth_since_ls >= 15.5                                      => 0.0759178337278643,
    bv_ver_src_id_mth_since_ls = NULL                                       => -0.00788115386917996,
                                                                               -0.00788115386917996));

bus_tree_23_c1049 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 3.5 => bus_tree_23_c1050,
    bv_sos_mth_ls >= 3.5                         => 0.0538278940219747,
    bv_sos_mth_ls = NULL                         => 0.0212970534592911,
                                                    0.0212970534592911));

bus_tree_23 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 0.5 => bus_tree_23_c1049,
    bx_assoc_county_match_ct >= 0.5                                    => -0.0176503249477275,
    bx_assoc_county_match_ct = NULL                                    => -0.00177404288052786,
                                                                          -0.00177404288052786));

bus_tree_24_c1053 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 7.5 => -0.0188364634105157,
    bv_mth_ver_src_br_ls >= 7.5                                => 0.031943721495127,
    bv_mth_ver_src_br_ls = NULL                                => 0.00567726133506312,
                                                                  0.00567726133506312));

bus_tree_24_c1052 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 8.5 => bus_tree_24_c1053,
    bv_mth_bureau_ls >= 8.5                            => 0.108554163164725,
    bv_mth_bureau_ls = NULL                            => 0.01004655060196,
                                                          0.01004655060196));

bus_tree_24 :=   __common__( map(
    NULL < bx_assoc_city_match_ct AND bx_assoc_city_match_ct < 0.5 => bus_tree_24_c1052,
    bx_assoc_city_match_ct >= 0.5                                  => -0.0250486747549016,
    bx_assoc_city_match_ct = NULL                                  => -0.00787244012257518,
                                                                      -0.00787244012257518));

bus_tree_25_c1055 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 35.5 => -0.00638362554045805,
    bx_phn_distance_addr >= 35.5                                => 0.085488864509749,
    bx_phn_distance_addr = NULL                                 => -0.00482943283291344,
                                                                   -0.00482943283291344));

bus_tree_25_c1056 :=   __common__( map(
    NULL < bv_ucc_mth_fs AND bv_ucc_mth_fs < 18.5 => 0.0122211308570241,
    bv_ucc_mth_fs >= 18.5                         => 0.126805265583099,
    bv_ucc_mth_fs = NULL                          => 0.0521459164758656,
                                                     0.0521459164758656));

bus_tree_25 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 3772928 => bus_tree_25_c1055,
    bx_addr_assessed_value >= 3772928                                  => bus_tree_25_c1056,
    bx_addr_assessed_value = NULL                                      => -0.00235748646078652,
                                                                          -0.00235748646078652));

bus_tree_26_c1059 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 2.5 => 0.0251010622477022,
    bx_inq_consumer_phn_cnt >= 2.5                                   => 0.108842898901844,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.0341726405189543,
                                                                        0.0341726405189543));

bus_tree_26_c1058 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 3.5 => -0.00227175065949277,
    bv_ver_src_id_mth_since_ls >= 3.5                                      => bus_tree_26_c1059,
    bv_ver_src_id_mth_since_ls = NULL                                      => 0.00687192908431951,
                                                                              0.00687192908431951));

bus_tree_26 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 1.5 => bus_tree_26_c1058,
    bx_consumer_addr >= 1.5                            => -0.0616895987907809,
    bx_consumer_addr = NULL                            => 0.00212137238737609,
                                                          0.00212137238737609));

bus_tree_27_c1062 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2, 3]) => -0.0150225003821633,
    (bx_fein_contradictory_in in [4])                => 0.060677769136148,
    bx_fein_contradictory_in = NULL                    => -0.0125843695075739,
                                                          -0.0125843695075739));

bus_tree_27_c1061 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3, 4]) => bus_tree_27_c1062,
    (bx_phn_contradictory in [0])                => 0.0235452763990394,
    bx_phn_contradictory = NULL                    => -0.00505433751514537,
                                                      -0.00505433751514537));

bus_tree_27 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 1.5 => bus_tree_27_c1061,
    bv_ucc_other_count >= 1.5                              => 0.0819794758697577,
    bv_ucc_other_count = NULL                              => -0.0036728484137977,
                                                              -0.0036728484137977));

bus_tree_28_c1065 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 592512 => 0.0234431704274376,
    bx_addr_assessed_value >= 592512                                  => 0.127390355184887,
    bx_addr_assessed_value = NULL                                     => 0.0496224614033878,
                                                                         0.0496224614033878));

bus_tree_28_c1064 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 27.5 => 0.00279620275447452,
    bv_mth_ver_src_c_ls >= 27.5                               => bus_tree_28_c1065,
    bv_mth_ver_src_c_ls = NULL                                => 0.00810675188193712,
                                                                 0.00810675188193712));

bus_tree_28 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 50.5 => bus_tree_28_c1064,
    bx_addr_lres >= 50.5                        => -0.0291117820863813,
    bx_addr_lres = NULL                         => -0.00232175192914046,
                                                   -0.00232175192914046));

bus_tree_29_c1067 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 116776 => -0.00876339411979842,
    bx_addr_bldg_size >= 116776                             => 0.0836042067936078,
    bx_addr_bldg_size = NULL                                => -0.00716602964226437,
                                                               -0.00716602964226437));

bus_tree_29_c1068 :=   __common__( map(
    NULL < bv_inq_other_count12 AND bv_inq_other_count12 < 1.5 => 0.0203095571947744,
    bv_inq_other_count12 >= 1.5                                => 0.124671653887353,
    bv_inq_other_count12 = NULL                                => 0.0372958203801732,
                                                                  0.0372958203801732));

bus_tree_29 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 3.5 => bus_tree_29_c1067,
    bx_inq_consumer_addr_cnt >= 3.5                                    => bus_tree_29_c1068,
    bx_inq_consumer_addr_cnt = NULL                                    => -0.00157049069386237,
                                                                          -0.00157049069386237));

bus_tree_30_c1070 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 1.5 => -0.013494698169229,
    bx_inq_consumer_phn_cnt >= 1.5                                   => 0.0232381521848523,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00737663108030466,
                                                                        -0.00737663108030466));

bus_tree_30_c1071 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 1.5 => 0.0101264910603691,
    bv_mth_ver_src_c_ls >= 1.5                               => 0.102555994769425,
    bv_mth_ver_src_c_ls = NULL                               => 0.0382257042959619,
                                                                0.0382257042959619));

bus_tree_30 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 6.5 => bus_tree_30_c1070,
    bv_empl_ct_min >= 6.5                          => bus_tree_30_c1071,
    bv_empl_ct_min = NULL                          => -0.00341960303707306,
                                                      -0.00341960303707306));

bus_tree_31_c1074 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 3.5 => -0.000636324017079003,
    bx_phn_problems >= 3.5                           => 0.0654258595726105,
    bx_phn_problems = NULL                           => 0.0135761944677133,
                                                        0.0135761944677133));

bus_tree_31_c1073 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => bus_tree_31_c1074,
    bx_phn_mobile >= 0.5                         => -0.0128680371433467,
    bx_phn_mobile = NULL                         => -0.00382513341287234,
                                                    -0.00382513341287234));

bus_tree_31 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 1.5 => bus_tree_31_c1073,
    bx_consumer_addr >= 1.5                            => -0.0642284808290585,
    bx_consumer_addr = NULL                            => -0.00798206044521972,
                                                          -0.00798206044521972));

bus_tree_32_c1077 :=   __common__( map(
    NULL < bv_ucc_mth_fs AND bv_ucc_mth_fs < 6.5 => 0.0621621058669233,
    bv_ucc_mth_fs >= 6.5                         => -0.056126528365055,
    bv_ucc_mth_fs = NULL                         => 0.0354346963424718,
                                                    0.0354346963424718));

bus_tree_32_c1076 :=   __common__( map(
    NULL < bv_inq_total_count12 AND bv_inq_total_count12 < 1.5 => -0.0306716338538318,
    bv_inq_total_count12 >= 1.5                                => bus_tree_32_c1077,
    bv_inq_total_count12 = NULL                                => -0.0212818881920117,
                                                                  -0.0212818881920117));

bus_tree_32 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 22.5 => bus_tree_32_c1076,
    bv_mth_ver_src_c_fs >= 22.5                               => 0.0132266551496,
    bv_mth_ver_src_c_fs = NULL                                => -0.00319033440384702,
                                                                 -0.00319033440384702));

bus_tree_33_c1079 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 398.5 => -0.00697000092467446,
    bv_sos_mth_ls >= 398.5                         => 0.0768041580002745,
    bv_sos_mth_ls = NULL                           => -0.00474510075885603,
                                                      -0.00474510075885603));

bus_tree_33_c1080 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 4.5 => 0.0600353912691584,
    bx_inq_consumer_addr_cnt >= 4.5                                    => -0.0187519944921891,
    bx_inq_consumer_addr_cnt = NULL                                    => 0.0422488339293921,
                                                                          0.0422488339293921));

bus_tree_33 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 2.5 => bus_tree_33_c1079,
    bx_inq_consumer_phn_cnt >= 2.5                                   => bus_tree_33_c1080,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.000364522025855913,
                                                                        -0.000364522025855913));

bus_tree_34_c1082 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 453.5 => -0.0120154308338585,
    bv_sos_mth_ls >= 453.5                         => 0.0658843148885213,
    bv_sos_mth_ls = NULL                           => -0.0102075460698012,
                                                      -0.0102075460698012));

bus_tree_34_c1083 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 153.5 => 0.0171227507449965,
    bv_mth_ver_src_c_fs >= 153.5                               => 0.12766581589293,
    bv_mth_ver_src_c_fs = NULL                                 => 0.0246277961864403,
                                                                  0.0246277961864403));

bus_tree_34 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 3.5 => bus_tree_34_c1082,
    bv_ver_src_id_mth_since_ls >= 3.5                                      => bus_tree_34_c1083,
    bv_ver_src_id_mth_since_ls = NULL                                      => -0.000899690070117628,
                                                                              -0.000899690070117628));

bus_tree_35_c1086 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 3.5 => 0.00162094229168788,
    bx_inq_consumer_phn_cnt >= 3.5                                   => 0.0637539898195961,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.0058518843192195,
                                                                        0.0058518843192195));

bus_tree_35_c1085 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 0.5 => bus_tree_35_c1086,
    bx_assoc_county_match_ct >= 0.5                                    => -0.0194908379348369,
    bx_assoc_county_match_ct = NULL                                    => -0.00907425557699046,
                                                                          -0.00907425557699046));

bus_tree_35 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2, 3]) => bus_tree_35_c1085,
    (bx_fein_contradictory_in in [4])                => 0.0511942723526186,
    bx_fein_contradictory_in = NULL                    => -0.00708232192812953,
                                                          -0.00708232192812953));

bus_tree_36_c1089 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 1889792 => -0.000956684022271259,
    bv_sales >= 1889792                    => 0.0940739104272297,
    bv_sales = NULL                        => 0.000572998806618762,
                                              0.000572998806618762));

bus_tree_36_c1088 :=   __common__( map(
    NULL < bv_ucc_mth_fs AND bv_ucc_mth_fs < 265.5 => bus_tree_36_c1089,
    bv_ucc_mth_fs >= 265.5                         => -0.0606229854272878,
    bv_ucc_mth_fs = NULL                           => -0.00141376063813615,
                                                      -0.00141376063813615));

bus_tree_36 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 397.5 => bus_tree_36_c1088,
    bv_sos_mth_ls >= 397.5                         => 0.0588576145037784,
    bv_sos_mth_ls = NULL                           => 6.22730388087008e-05,
                                                      6.22730388087008e-05));

bus_tree_37_c1092 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 16.5 => 0.0869242992660055,
    bv_mth_ver_src_c_ls >= 16.5                               => -0.00589103503275983,
    bv_mth_ver_src_c_ls = NULL                                => 0.0553851079994347,
                                                                 0.0553851079994347));

bus_tree_37_c1091 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 137.5 => -2.84554346819278e-05,
    bv_sos_mth_ls >= 137.5                         => bus_tree_37_c1092,
    bv_sos_mth_ls = NULL                           => 0.0066932840426789,
                                                      0.0066932840426789));

bus_tree_37 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3]) => -0.0204050398952799,
    (bx_phn_contradictory in [0, 4])      => bus_tree_37_c1091,
    bx_phn_contradictory = NULL               => -0.0064119639157623,
                                                 -0.0064119639157623));

bus_tree_38_c1095 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 13.5 => -0.0161000563313792,
    bv_mth_ver_src_c_fs >= 13.5                               => 0.0163148859926919,
    bv_mth_ver_src_c_fs = NULL                                => 0.00225377256964227,
                                                                 0.00225377256964227));

bus_tree_38_c1094 :=   __common__( map(
    (bx_fein_contradictory_in in [2, 3])      => -0.0366407996784119,
    (bx_fein_contradictory_in in [0, 1, 4]) => bus_tree_38_c1095,
    bx_fein_contradictory_in = NULL               => -0.00117288999965969,
                                                     -0.00117288999965969));

bus_tree_38 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 46.5 => bus_tree_38_c1094,
    bx_phn_distance_addr >= 46.5                                => 0.100286272267888,
    bx_phn_distance_addr = NULL                                 => 0.000376399038992362,
                                                                   0.000376399038992362));

bus_tree_39_c1098 :=   __common__( map(
    NULL < bv_inq_total_count12 AND bv_inq_total_count12 < 1.5 => -0.0101874048046874,
    bv_inq_total_count12 >= 1.5                                => 0.0331876737913782,
    bv_inq_total_count12 = NULL                                => -0.00392615808594297,
                                                                  -0.00392615808594297));

bus_tree_39_c1097 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 2, 3]) => bus_tree_39_c1098,
    (bx_fein_contradictory_in in [1, 4])      => 0.032601291753066,
    bx_fein_contradictory_in = NULL               => 0.00435452821244223,
                                                     0.00435452821244223));

bus_tree_39 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 9.5 => bus_tree_39_c1097,
    bv_ucc_count >= 9.5                        => -0.0354340290690413,
    bv_ucc_count = NULL                        => 0.00215307515650528,
                                                  0.00215307515650528));

bus_tree_40_c1101 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 20.5 => -0.0234013455080277,
    bv_mth_ver_src_br_ls >= 20.5                                => 0.00674814532606262,
    bv_mth_ver_src_br_ls = NULL                                 => -0.00991148831491201,
                                                                   -0.00991148831491201));

bus_tree_40_c1100 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 2.5 => bus_tree_40_c1101,
    bx_inq_consumer_phn_cnt >= 2.5                                   => 0.0250075181106252,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00666908765531696,
                                                                        -0.00666908765531696));

bus_tree_40 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2, 3]) => bus_tree_40_c1100,
    (bx_fein_contradictory_in in [4])                => 0.0604585959599722,
    bx_fein_contradictory_in = NULL                    => -0.00444012970152285,
                                                          -0.00444012970152285));

bus_tree_41_c1104 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 365.5 => 0.00467005414686776,
    bv_mth_ver_src_c_fs >= 365.5                               => -0.0508225832882067,
    bv_mth_ver_src_c_fs = NULL                                 => -7.89483055214258e-05,
                                                                  -7.89483055214258e-05));

bus_tree_41_c1103 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 0.5 => 0.0344491774072632,
    bx_assoc_county_match_ct >= 0.5                                    => bus_tree_41_c1104,
    bx_assoc_county_match_ct = NULL                                    => 0.0107159360804356,
                                                                          0.0107159360804356));

bus_tree_41 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 3.5 => -0.0200227676139629,
    bv_mth_ver_src_c_fs >= 3.5                               => bus_tree_41_c1103,
    bv_mth_ver_src_c_fs = NULL                               => 0.000674161525092414,
                                                                0.000674161525092414));

bus_tree_42_c1106 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 3.5 => -0.0114555430550966,
    bx_inq_consumer_addr_cnt >= 3.5                                    => 0.025696795412057,
    bx_inq_consumer_addr_cnt = NULL                                    => -0.00690449783923597,
                                                                          -0.00690449783923597));

bus_tree_42_c1107 :=   __common__( map(
    NULL < bx_phn_not_in_zipcode AND bx_phn_not_in_zipcode < 0.5 => 0.0904092479922734,
    bx_phn_not_in_zipcode >= 0.5                                 => 0.00721231182184677,
    bx_phn_not_in_zipcode = NULL                                 => 0.0458462913768495,
                                                                    0.0458462913768495));

bus_tree_42 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2, 3]) => bus_tree_42_c1106,
    (bx_fein_contradictory_in in [4])                => bus_tree_42_c1107,
    bx_fein_contradictory_in = NULL                    => -0.0051609009186226,
                                                          -0.0051609009186226));

bus_tree_43_c1110 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 32.5 => 0.00133070997560404,
    bv_ver_src_id_mth_since_ls >= 32.5                                      => 0.0576831830806791,
    bv_ver_src_id_mth_since_ls = NULL                                       => 0.0065203207910013,
                                                                               0.0065203207910013));

bus_tree_43_c1109 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 426.5 => bus_tree_43_c1110,
    bv_sos_mth_ls >= 426.5                         => 0.0746769337588477,
    bv_sos_mth_ls = NULL                           => 0.00818358678923174,
                                                      0.00818358678923174));

bus_tree_43 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 41.5 => bus_tree_43_c1109,
    bx_addr_lres >= 41.5                        => -0.0281067819918416,
    bx_addr_lres = NULL                         => -0.00304091729634286,
                                                   -0.00304091729634286));

bus_tree_44_c1112 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 6430720 => -0.00766744032838675,
    bx_addr_assessed_value >= 6430720                                  => 0.0433798196864837,
    bx_addr_assessed_value = NULL                                      => -0.0062155888811315,
                                                                          -0.0062155888811315));

bus_tree_44_c1113 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 136576 => 0.141709794153632,
    bx_addr_assessed_value >= 136576                                  => -0.000153502303857848,
    bx_addr_assessed_value = NULL                                     => 0.0487923194753043,
                                                                         0.0487923194753043));

bus_tree_44 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 6.5 => bus_tree_44_c1112,
    bx_inq_consumer_addr_cnt >= 6.5                                    => bus_tree_44_c1113,
    bx_inq_consumer_addr_cnt = NULL                                    => -0.00325106592889123,
                                                                          -0.00325106592889123));

bus_tree_45_c1116 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 328.5 => 0.0872881279465872,
    bv_mth_ver_src_c_fs >= 328.5                               => -0.0204887092613637,
    bv_mth_ver_src_c_fs = NULL                                 => 0.0494007073581267,
                                                                  0.0494007073581267));

bus_tree_45_c1115 :=   __common__( map(
    NULL < bx_irs_retirementplan AND bx_irs_retirementplan < 0.5 => -0.0020025834931954,
    bx_irs_retirementplan >= 0.5                                 => bus_tree_45_c1116,
    bx_irs_retirementplan = NULL                                 => 0.000332842808469562,
                                                                    0.000332842808469562));

bus_tree_45 :=   __common__( map(
    NULL < bv_ucc_active_count AND bv_ucc_active_count < 14.5 => bus_tree_45_c1115,
    bv_ucc_active_count >= 14.5                               => -0.0557524623656626,
    bv_ucc_active_count = NULL                                => -0.00107458888599846,
                                                                 -0.00107458888599846));

bus_tree_46_c1119 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 20370 => 0.0218042155377338,
    bx_addr_lot_size >= 20370                            => 0.141071654278903,
    bx_addr_lot_size = NULL                              => 0.0330766106239208,
                                                            0.0330766106239208));

bus_tree_46_c1118 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 2, 3]) => 1.15445085632426e-05,
    (bx_fein_contradictory_in in [1, 4])      => bus_tree_46_c1119,
    bx_fein_contradictory_in = NULL               => 0.0073567030915426,
                                                     0.0073567030915426));

bus_tree_46 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 33988 => bus_tree_46_c1118,
    bx_addr_lot_size >= 33988                            => -0.0246925287799726,
    bx_addr_lot_size = NULL                              => -0.00102745348497396,
                                                            -0.00102745348497396));

bus_tree_47_c1122 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => 0.0668900096087135,
    bx_consumer_addr >= 0.5                            => 0.061387045592917,
    bx_consumer_addr = NULL                            => 0.0647436530484818,
                                                          0.0647436530484818));

bus_tree_47_c1121 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 3.5 => 0.00307982978939105,
    bx_inq_consumer_addr_cnt >= 3.5                                    => bus_tree_47_c1122,
    bx_inq_consumer_addr_cnt = NULL                                    => 0.00977164993498447,
                                                                          0.00977164993498447));

bus_tree_47 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 10908 => bus_tree_47_c1121,
    bx_addr_lot_size >= 10908                            => -0.0196677940534235,
    bx_addr_lot_size = NULL                              => -0.00277182291177713,
                                                            -0.00277182291177713));

bus_tree_48_c1125 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 9.5 => -0.0110680188623698,
    bv_assoc_bus_total >= 9.5                              => -0.0646997966712485,
    bv_assoc_bus_total = NULL                              => -0.0154621258994007,
                                                              -0.0154621258994007));

bus_tree_48_c1124 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 20.5 => bus_tree_48_c1125,
    bv_mth_ver_src_br_ls >= 20.5                                => 0.00765017496759417,
    bv_mth_ver_src_br_ls = NULL                                 => -0.00521068782200694,
                                                                   -0.00521068782200694));

bus_tree_48 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 50.5 => bus_tree_48_c1124,
    bv_empl_ct_min >= 50.5                          => 0.0479481132297948,
    bv_empl_ct_min = NULL                           => -0.0044030597788163,
                                                       -0.0044030597788163));

bus_tree_49_c1128 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 203 => 0.0212359793530918,
    bv_ver_src_id_mth_since_fs >= 203                                      => 0.0886144968081984,
    bv_ver_src_id_mth_since_fs = NULL                                      => 0.038573337091912,
                                                                              0.038573337091912));

bus_tree_49_c1127 :=   __common__( map(
    (bx_fein_contradictory_in in [2, 3, 4]) => -0.065003453633837,
    (bx_fein_contradictory_in in [0, 1])      => bus_tree_49_c1128,
    bx_fein_contradictory_in = NULL               => 0.0259475201989169,
                                                     0.0259475201989169));

bus_tree_49 :=   __common__( map(
    NULL < bv_inq_other_pct12 AND bv_inq_other_pct12 < 0.822 => -0.00180640079538044,
    bv_inq_other_pct12 >= 0.822                              => bus_tree_49_c1127,
    bv_inq_other_pct12 = NULL                                => 0.00301644609546535,
                                                                0.00301644609546535));

bus_tree_50_c1131 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 182.5 => 0.127290398670655,
    bv_sos_mth_ls >= 182.5                         => 0.016734385504013,
    bv_sos_mth_ls = NULL                           => 0.054138479846285,
                                                      0.054138479846285));

bus_tree_50_c1130 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 141.5 => 0.00868873561755899,
    bv_sos_mth_ls >= 141.5                         => bus_tree_50_c1131,
    bv_sos_mth_ls = NULL                           => 0.0140049221139389,
                                                      0.0140049221139389));

bus_tree_50 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3]) => -0.0175663726020267,
    (bx_phn_contradictory in [0, 4])      => bus_tree_50_c1130,
    bx_phn_contradictory = NULL               => -0.00113778398387075,
                                                 -0.00113778398387075));

bus_tree_51_c1134 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 3.5 => 0.115083928183522,
    bv_ver_src_id_count >= 3.5                               => 0.0170055213323949,
    bv_ver_src_id_count = NULL                               => 0.0599861022417188,
                                                                0.0599861022417188));

bus_tree_51_c1133 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < -0.5 => 0.00980942985423858,
    bv_assoc_bus_total >= -0.5                              => bus_tree_51_c1134,
    bv_assoc_bus_total = NULL                               => 0.0225058441986985,
                                                               0.0225058441986985));

bus_tree_51 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 0.5 => bus_tree_51_c1133,
    bx_assoc_county_match_ct >= 0.5                                    => -0.0131414552462715,
    bx_assoc_county_match_ct = NULL                                    => 0.00151085120737526,
                                                                          0.00151085120737526));

bus_tree_52_c1136 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 171392 => -0.00206290599799142,
    bv_sales >= 171392                    => 0.0801680543921231,
    bv_sales = NULL                       => 9.33374968621788e-05,
                                             9.33374968621788e-05));

bus_tree_52_c1137 :=   __common__( map(
    (bx_fein_contradictory_in in [1, 2, 3]) => -0.0567788136298605,
    (bx_fein_contradictory_in in [0, 4])      => 0.00652783519979104,
    bx_fein_contradictory_in = NULL               => -0.0341201731682471,
                                                     -0.0341201731682471));

bus_tree_52 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 188.5 => bus_tree_52_c1136,
    bv_mth_ver_src_c_fs >= 188.5                               => bus_tree_52_c1137,
    bv_mth_ver_src_c_fs = NULL                                 => -0.00443484520718969,
                                                                  -0.00443484520718969));

bus_tree_53_c1140 :=   __common__( map(
    NULL < bv_inq_other_count12 AND bv_inq_other_count12 < 1.5 => 0.0291099830033361,
    bv_inq_other_count12 >= 1.5                                => 0.101810541093833,
    bv_inq_other_count12 = NULL                                => 0.0385320356330013,
                                                                  0.0385320356330013));

bus_tree_53_c1139 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 0.5 => bus_tree_53_c1140,
    bx_inq_consumer_addr_cnt >= 0.5                                    => -0.0175315215632316,
    bx_inq_consumer_addr_cnt = NULL                                    => 0.0208319413071243,
                                                                          0.0208319413071243));

bus_tree_53 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 107.5 => -0.0138168956437361,
    bv_sos_mth_ls >= 107.5                         => bus_tree_53_c1139,
    bv_sos_mth_ls = NULL                           => -0.00643404822389666,
                                                      -0.00643404822389666));

bus_tree_54_c1143 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 222912 => 0.00975477359214865,
    bv_sales >= 222912                    => 0.0942796605762503,
    bv_sales = NULL                       => 0.0114435825228999,
                                             0.0114435825228999));

bus_tree_54_c1142 :=   __common__( map(
    NULL < bv_ucc_active_count AND bv_ucc_active_count < 1.5 => bus_tree_54_c1143,
    bv_ucc_active_count >= 1.5                               => -0.0180673777952707,
    bv_ucc_active_count = NULL                               => 0.00597271927381198,
                                                                0.00597271927381198));

bus_tree_54 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 1.5 => bus_tree_54_c1142,
    bx_consumer_addr >= 1.5                            => -0.0375290490164176,
    bx_consumer_addr = NULL                            => 0.00290893636449934,
                                                          0.00290893636449934));

bus_tree_55_c1146 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 11037 => 0.0586920309056345,
    bx_addr_lot_size >= 11037                            => -0.0207285754734498,
    bx_addr_lot_size = NULL                              => 0.0281861026275756,
                                                            0.0281861026275756));

bus_tree_55_c1145 :=   __common__( map(
    NULL < bx_tin_match_consumer_associate AND bx_tin_match_consumer_associate < 1.5 => bus_tree_55_c1146,
    bx_tin_match_consumer_associate >= 1.5                                           => -0.0281537714828262,
    bx_tin_match_consumer_associate = NULL                                           => 0.0234265902229378,
                                                                                        0.0234265902229378));

bus_tree_55 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 10.5 => -0.00634794020621227,
    bv_ver_src_id_mth_since_ls >= 10.5                                      => bus_tree_55_c1145,
    bv_ver_src_id_mth_since_ls = NULL                                       => -0.00077787498987467,
                                                                               -0.00077787498987467));

bus_tree_56_c1149 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 21.5 => 0.0195433138428906,
    bv_mth_bureau_fs >= 21.5                            => 0.0698441308010083,
    bv_mth_bureau_fs = NULL                             => 0.0234993143147099,
                                                           0.0234993143147099));

bus_tree_56_c1148 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 41.5 => bus_tree_56_c1149,
    bx_addr_lres >= 41.5                        => -0.0119877401455981,
    bx_addr_lres = NULL                         => 0.0131067928043164,
                                                   0.0131067928043164));

bus_tree_56 :=   __common__( map(
    NULL < bx_assoc_city_match_ct AND bx_assoc_city_match_ct < 0.5 => bus_tree_56_c1148,
    bx_assoc_city_match_ct >= 0.5                                  => -0.0101332486884962,
    bx_assoc_city_match_ct = NULL                                  => 0.00139542797948033,
                                                                      0.00139542797948033));

bus_tree_57_c1152 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 3.5 => -0.00568831237929096,
    bx_fein_src_count >= 3.5                             => -0.0362177083364707,
    bx_fein_src_count = NULL                             => -0.00643499461379852,
                                                            -0.00643499461379852));

bus_tree_57_c1151 :=   __common__( map(
    NULL < bv_ucc_mth_ls AND bv_ucc_mth_ls < 165.5 => bus_tree_57_c1152,
    bv_ucc_mth_ls >= 165.5                         => 0.0591601149975999,
    bv_ucc_mth_ls = NULL                           => -0.00481561218241082,
                                                      -0.00481561218241082));

bus_tree_57 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 35.5 => bus_tree_57_c1151,
    bx_phn_distance_addr >= 35.5                                => 0.0596174841396006,
    bx_phn_distance_addr = NULL                                 => -0.00382207488249678,
                                                                   -0.00382207488249678));

bus_tree_58_c1155 :=   __common__( map(
    NULL < bv_ucc_active_count AND bv_ucc_active_count < 1.5 => 0.0832571787450824,
    bv_ucc_active_count >= 1.5                               => -0.0409607378540937,
    bv_ucc_active_count = NULL                               => 6.65211852683382e-05,
                                                                6.65211852683382e-05));

bus_tree_58_c1154 :=   __common__( map(
    (bx_fein_contradictory_in in [1, 2, 3]) => bus_tree_58_c1155,
    (bx_fein_contradictory_in in [0, 4])      => 0.0998176900053042,
    bx_fein_contradictory_in = NULL               => 0.0307915647458701,
                                                     0.0307915647458701));

bus_tree_58 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 7.5 => -0.00189624764939207,
    bx_addr_src_count >= 7.5                             => bus_tree_58_c1154,
    bx_addr_src_count = NULL                             => 0.00162207773615996,
                                                            0.00162207773615996));

bus_tree_59_c1158 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 17.5 => -0.00123106146874202,
    bv_empl_ct_max >= 17.5                          => 0.0351137169373929,
    bv_empl_ct_max = NULL                           => 0.000436515424624128,
                                                       0.000436515424624128));

bus_tree_59_c1157 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 669.5 => bus_tree_59_c1158,
    bv_ver_src_id_mth_since_fs >= 669.5                                      => -0.0553477760131881,
    bv_ver_src_id_mth_since_fs = NULL                                        => -0.000473675546964495,
                                                                                -0.000473675546964495));

bus_tree_59 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 1.5 => bus_tree_59_c1157,
    bx_consumer_addr >= 1.5                            => -0.0524690947154517,
    bx_consumer_addr = NULL                            => -0.00402471650212589,
                                                          -0.00402471650212589));

bus_tree_60_c1161 :=   __common__( map(
    NULL < bx_phn_verification AND bx_phn_verification < 1.5 => 0.0707202984037674,
    bx_phn_verification >= 1.5                               => -0.0302121972381487,
    bx_phn_verification = NULL                               => 0.0337814579686987,
                                                                0.0337814579686987));

bus_tree_60_c1160 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < -0.5 => -0.00280069310056921,
    bv_assoc_bus_total >= -0.5                              => bus_tree_60_c1161,
    bv_assoc_bus_total = NULL                               => 0.0067578470227147,
                                                               0.0067578470227147));

bus_tree_60 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 0.5 => bus_tree_60_c1160,
    bx_assoc_county_match_ct >= 0.5                                    => -0.0151644198589809,
    bx_assoc_county_match_ct = NULL                                    => -0.00624803905093825,
                                                                          -0.00624803905093825));

bus_tree_61_c1163 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 2.5 => -0.0436391719022631,
    bv_mth_ver_src_c_fs >= 2.5                               => 0.00435315037869796,
    bv_mth_ver_src_c_fs = NULL                               => -0.00817729295756264,
                                                                -0.00817729295756264));

bus_tree_61_c1164 :=   __common__( map(
    NULL < bv_inq_other_pct12 AND bv_inq_other_pct12 < 0.646 => 0.0123930348139226,
    bv_inq_other_pct12 >= 0.646                              => 0.070283587272844,
    bv_inq_other_pct12 = NULL                                => 0.0193413083542671,
                                                                0.0193413083542671));

bus_tree_61 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 4.5 => bus_tree_61_c1163,
    bv_ver_src_id_mth_since_ls >= 4.5                                      => bus_tree_61_c1164,
    bv_ver_src_id_mth_since_ls = NULL                                      => -0.00133196288067437,
                                                                              -0.00133196288067437));

bus_tree_62_c1167 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 8.5 => 0.00622399995204095,
    bv_empl_ct_min >= 8.5                          => 0.0617214461819553,
    bv_empl_ct_min = NULL                          => 0.00904033984477945,
                                                      0.00904033984477945));

bus_tree_62_c1166 :=   __common__( map(
    NULL < bx_assoc_city_match_ct AND bx_assoc_city_match_ct < 0.5 => bus_tree_62_c1167,
    bx_assoc_city_match_ct >= 0.5                                  => -0.0171100633340487,
    bx_assoc_city_match_ct = NULL                                  => -0.00420759098222134,
                                                                      -0.00420759098222134));

bus_tree_62 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 117688 => bus_tree_62_c1166,
    bx_addr_bldg_size >= 117688                             => 0.0778674991246126,
    bx_addr_bldg_size = NULL                                => -0.00290481177417635,
                                                               -0.00290481177417635));

bus_tree_63_c1170 :=   __common__( map(
    NULL < bv_ucc_mth_ls AND bv_ucc_mth_ls < 30.5 => -0.00911374192573126,
    bv_ucc_mth_ls >= 30.5                         => -0.0957497018927838,
    bv_ucc_mth_ls = NULL                          => -0.040829917444573,
                                                     -0.040829917444573));

bus_tree_63_c1169 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 360.5 => -0.00206335345330515,
    bv_mth_ver_src_c_fs >= 360.5                               => bus_tree_63_c1170,
    bv_mth_ver_src_c_fs = NULL                                 => -0.00394574682602466,
                                                                  -0.00394574682602466));

bus_tree_63 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 1.5 => bus_tree_63_c1169,
    bv_ucc_other_count >= 1.5                              => 0.0512826392333028,
    bv_ucc_other_count = NULL                              => -0.00296474374787334,
                                                              -0.00296474374787334));

bus_tree_64_c1172 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 327.5 => -0.00703380461233152,
    bv_mth_ver_src_c_fs >= 327.5                               => -0.0629431113493518,
    bv_mth_ver_src_c_fs = NULL                                 => -0.0147368028546367,
                                                                  -0.0147368028546367));

bus_tree_64_c1173 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 14.5 => -0.0046833240552976,
    bv_empl_ct_max >= 14.5                          => 0.0815836216451208,
    bv_empl_ct_max = NULL                           => -0.00265836640790677,
                                                       -0.00265836640790677));

bus_tree_64 :=   __common__( map(
    (bx_fein_contradictory_in in [1, 2, 3]) => bus_tree_64_c1172,
    (bx_fein_contradictory_in in [0, 4])      => bus_tree_64_c1173,
    bx_fein_contradictory_in = NULL               => -0.00633131452499829,
                                                     -0.00633131452499829));

bus_tree_65_c1176 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 12.5 => -0.0141359456619393,
    bv_mth_ver_src_c_fs >= 12.5                               => 0.0108684070057983,
    bv_mth_ver_src_c_fs = NULL                                => 0.000501273379966381,
                                                                 0.000501273379966381));

bus_tree_65_c1175 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 2979328 => bus_tree_65_c1176,
    bx_addr_lot_size >= 2979328                            => -0.0898296881029296,
    bx_addr_lot_size = NULL                                => -0.00116342989546133,
                                                              -0.00116342989546133));

bus_tree_65 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 72.5 => bus_tree_65_c1175,
    bv_empl_ct_max >= 72.5                          => 0.0449050156466456,
    bv_empl_ct_max = NULL                           => -0.000442631087659653,
                                                       -0.000442631087659653));

bus_tree_66_c1178 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 9.5 => -0.000224434574424791,
    bv_ucc_count >= 9.5                        => -0.0555203720026601,
    bv_ucc_count = NULL                        => -0.00252900581468831,
                                                  -0.00252900581468831));

bus_tree_66_c1179 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 2004352 => 0.133130866252035,
    bx_addr_assessed_value >= 2004352                                  => 0.0126327265816098,
    bx_addr_assessed_value = NULL                                      => 0.0374441578723977,
                                                                          0.0374441578723977));

bus_tree_66 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 1445120 => bus_tree_66_c1178,
    bx_addr_assessed_value >= 1445120                                  => bus_tree_66_c1179,
    bx_addr_assessed_value = NULL                                      => 0.001051356919189,
                                                                          0.001051356919189));

bus_tree_67_c1182 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 44.5 => 0.00471167801935932,
    bv_ver_src_id_mth_since_ls >= 44.5                                      => -0.0383958753586501,
    bv_ver_src_id_mth_since_ls = NULL                                       => 0.00229610677087426,
                                                                               0.00229610677087426));

bus_tree_67_c1181 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 37.5 => bus_tree_67_c1182,
    bx_phn_distance_addr >= 37.5                                => 0.0637984933388979,
    bx_phn_distance_addr = NULL                                 => 0.00334652752700051,
                                                                   0.00334652752700051));

bus_tree_67 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 1.5 => bus_tree_67_c1181,
    bx_consumer_addr >= 1.5                            => -0.0437501683926748,
    bx_consumer_addr = NULL                            => 8.34934552644422e-05,
                                                          8.34934552644422e-05));

bus_tree_68_c1185 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 3267328 => 0.00360085482050176,
    bv_sales >= 3267328                    => 0.0546037531481936,
    bv_sales = NULL                        => 0.00450454587056036,
                                              0.00450454587056036));

bus_tree_68_c1184 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 150.5 => bus_tree_68_c1185,
    bx_addr_lres >= 150.5                        => -0.0411580908140985,
    bx_addr_lres = NULL                          => 0.000113353529238246,
                                                    0.000113353529238246));

bus_tree_68 :=   __common__( map(
    (bx_fein_contradictory_id in [2])      => -0.0252861275001948,
    (bx_fein_contradictory_id in [0, 1]) => bus_tree_68_c1184,
    bx_fein_contradictory_id = NULL          => -0.000935513256578608,
                                                -0.000935513256578608));

bus_tree_69_c1188 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < -0.5 => 0.00592896773742914,
    bv_mth_ver_src_p_fs >= -0.5                               => -0.0275947227866886,
    bv_mth_ver_src_p_fs = NULL                                => -0.000465118026621487,
                                                                 -0.000465118026621487));

bus_tree_69_c1187 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 224.5 => bus_tree_69_c1188,
    bv_mth_bureau_fs >= 224.5                            => 0.0681910145947989,
    bv_mth_bureau_fs = NULL                              => 0.000619037510845096,
                                                            0.000619037510845096));

bus_tree_69 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 254.5 => bus_tree_69_c1187,
    bv_mth_bureau_fs >= 254.5                            => -0.060965548356766,
    bv_mth_bureau_fs = NULL                              => -0.000535382541699692,
                                                            -0.000535382541699692));

bus_tree_70_c1190 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 154.5 => 0.00405558740629808,
    bv_mth_ver_src_br_fs >= 154.5                                => -0.0797229133502097,
    bv_mth_ver_src_br_fs = NULL                                  => -0.0117188280384096,
                                                                    -0.0117188280384096));

bus_tree_70_c1191 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 34.5 => 0.000691895864472165,
    bv_empl_ct_min >= 34.5                          => 0.0495513603093707,
    bv_empl_ct_min = NULL                           => 0.00168353962169577,
                                                       0.00168353962169577));

bus_tree_70 :=   __common__( map(
    (bx_fein_contradictory_in in [2, 3, 4]) => bus_tree_70_c1190,
    (bx_fein_contradictory_in in [0, 1])      => bus_tree_70_c1191,
    bx_fein_contradictory_in = NULL               => 7.31461710111934e-05,
                                                     7.31461710111934e-05));

bus_tree_71_c1193 :=   __common__( map(
    NULL < bv_ucc_active_count AND bv_ucc_active_count < 5.5 => 0.000168056683391654,
    bv_ucc_active_count >= 5.5                               => -0.0474576979990498,
    bv_ucc_active_count = NULL                               => -0.00196738451429397,
                                                                -0.00196738451429397));

bus_tree_71_c1194 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 7 => 0.120320214844284,
    bv_mth_ver_src_p_fs >= 7                               => -0.0159165872601385,
    bv_mth_ver_src_p_fs = NULL                             => 0.0420470575960412,
                                                              0.0420470575960412));

bus_tree_71 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 7.5 => bus_tree_71_c1193,
    bv_mth_bureau_ls >= 7.5                            => bus_tree_71_c1194,
    bv_mth_bureau_ls = NULL                            => 0.00109000568218359,
                                                          0.00109000568218359));

bus_tree_72_c1197 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 0.75 => 0.0612879039609472,
    bv_ver_src_derog_ratio >= 0.75                                  => -0.00411366391086475,
    bv_ver_src_derog_ratio = NULL                                   => 0.0183675795956455,
                                                                       0.0183675795956455));

bus_tree_72_c1196 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 2.5 => -0.00721674516802968,
    bv_ver_src_id_mth_since_ls >= 2.5                                      => bus_tree_72_c1197,
    bv_ver_src_id_mth_since_ls = NULL                                      => 0.00015290926689427,
                                                                              0.00015290926689427));

bus_tree_72 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 171.5 => bus_tree_72_c1196,
    bv_mth_ver_src_c_ls >= 171.5                               => -0.0721787325099908,
    bv_mth_ver_src_c_ls = NULL                                 => -0.00106081896246843,
                                                                  -0.00106081896246843));

bus_tree_73_c1200 :=   __common__( map(
    NULL < bv_sales AND bv_sales < -0.5 => -0.0113714880616353,
    bv_sales >= -0.5                    => 0.0229266195588017,
    bv_sales = NULL                     => -0.00712103730715412,
                                           -0.00712103730715412));

bus_tree_73_c1199 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 3.5 => bus_tree_73_c1200,
    bx_inq_consumer_phn_cnt >= 3.5                                   => 0.0243218174106904,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00546123227590793,
                                                                        -0.00546123227590793));

bus_tree_73 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 9.5 => bus_tree_73_c1199,
    bx_inq_consumer_addr_cnt >= 9.5                                    => 0.0649367979655099,
    bx_inq_consumer_addr_cnt = NULL                                    => -0.00348710761834436,
                                                                          -0.00348710761834436));

bus_tree_74_c1203 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 7960 => 0.0232764520035096,
    bx_addr_bldg_size >= 7960                             => 0.104954253881962,
    bx_addr_bldg_size = NULL                              => 0.0383969706983635,
                                                             0.0383969706983635));

bus_tree_74_c1202 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 161.5 => 0.00300024020306388,
    bv_sos_mth_ls >= 161.5                         => bus_tree_74_c1203,
    bv_sos_mth_ls = NULL                           => 0.00809541554202564,
                                                      0.00809541554202564));

bus_tree_74 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 0.5 => bus_tree_74_c1202,
    bx_inq_consumer_addr_cnt >= 0.5                                    => -0.0174904827245406,
    bx_inq_consumer_addr_cnt = NULL                                    => -0.00123386437013728,
                                                                          -0.00123386437013728));

bus_tree_75_c1206 :=   __common__( map(
    (bx_phn_contradictory in [0, 2])      => -0.00213408546923999,
    (bx_phn_contradictory in [1, 3, 4]) => 0.0358898573638621,
    bx_phn_contradictory = NULL               => 0.0142218017052929,
                                                 0.0142218017052929));

bus_tree_75_c1205 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => bus_tree_75_c1206,
    bx_consumer_addr >= 0.5                            => 0.0428245299139536,
    bx_consumer_addr = NULL                            => 0.0310393456595581,
                                                          0.0310393456595581));

bus_tree_75 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 14.5 => -0.010809054404553,
    bv_ver_src_id_mth_since_ls >= 14.5                                      => bus_tree_75_c1205,
    bv_ver_src_id_mth_since_ls = NULL                                       => -0.00449541823463875,
                                                                               -0.00449541823463875));

bus_tree_76_c1208 :=   __common__( map(
    NULL < bx_phn_not_in_zipcode AND bx_phn_not_in_zipcode < 0.5 => 0.00830630184492017,
    bx_phn_not_in_zipcode >= 0.5                                 => 0.0531080864410615,
    bx_phn_not_in_zipcode = NULL                                 => 0.0147833019256745,
                                                                    0.0147833019256745));

bus_tree_76_c1209 :=   __common__( map(
    NULL < bx_tin_match_consumer_associate AND bx_tin_match_consumer_associate < 1.5 => -0.00706443342526972,
    bx_tin_match_consumer_associate >= 1.5                                           => -0.0558664361217478,
    bx_tin_match_consumer_associate = NULL                                           => -0.00960562262496044,
                                                                                        -0.00960562262496044));

bus_tree_76 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => bus_tree_76_c1208,
    bx_phn_mobile >= 0.5                         => bus_tree_76_c1209,
    bx_phn_mobile = NULL                         => -0.00141358322122106,
                                                    -0.00141358322122106));

bus_tree_77_c1212 :=   __common__( map(
    NULL < bx_irs_retirementplan AND bx_irs_retirementplan < 0.5 => 0.000782218143391164,
    bx_irs_retirementplan >= 0.5                                 => 0.0646210132524324,
    bx_irs_retirementplan = NULL                                 => 0.00369701342905846,
                                                                    0.00369701342905846));

bus_tree_77_c1211 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => bus_tree_77_c1212,
    bx_consumer_addr >= 0.5                            => -0.010267169363755,
    bx_consumer_addr = NULL                            => -0.00308067159364761,
                                                          -0.00308067159364761));

bus_tree_77 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 47.5 => bus_tree_77_c1211,
    bv_assoc_bus_total >= 47.5                              => -0.0600345690954157,
    bv_assoc_bus_total = NULL                               => -0.00411815377792019,
                                                               -0.00411815377792019));

bus_tree_78_c1214 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 8.5 => 0.000203996745143217,
    bv_ucc_count >= 8.5                        => -0.0318474725043304,
    bv_ucc_count = NULL                        => -0.00170746730342239,
                                                  -0.00170746730342239));

bus_tree_78_c1215 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 28.5 => 0.00051122697362253,
    bv_sos_mth_ls >= 28.5                         => 0.0924666154279929,
    bv_sos_mth_ls = NULL                          => 0.0440123709262755,
                                                     0.0440123709262755));

bus_tree_78 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2, 3]) => bus_tree_78_c1214,
    (bx_fein_contradictory_in in [4])                => bus_tree_78_c1215,
    bx_fein_contradictory_in = NULL                    => -0.000230848974696803,
                                                          -0.000230848974696803));

bus_tree_79_c1218 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 158.5 => 0.0871014158127191,
    bv_mth_ver_src_br_fs >= 158.5                                => -0.0170487495589135,
    bv_mth_ver_src_br_fs = NULL                                  => 0.0554625780922623,
                                                                    0.0554625780922623));

bus_tree_79_c1217 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 2.5 => -0.00036997408996565,
    bx_fein_src_count >= 2.5                             => bus_tree_79_c1218,
    bx_fein_src_count = NULL                             => 0.00304307823519326,
                                                            0.00304307823519326));

bus_tree_79 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 354.5 => bus_tree_79_c1217,
    bv_mth_ver_src_c_fs >= 354.5                               => -0.0293434142270939,
    bv_mth_ver_src_c_fs = NULL                                 => 0.00138825821217692,
                                                                  0.00138825821217692));

bus_tree_80_c1221 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 228.5 => -0.00445619710236523,
    bv_sos_mth_ls >= 228.5                         => 0.0859717428252116,
    bv_sos_mth_ls = NULL                           => 0.0300562415090472,
                                                      0.0300562415090472));

bus_tree_80_c1220 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 9.5 => -0.00783297333219555,
    bx_addr_src_count >= 9.5                             => bus_tree_80_c1221,
    bx_addr_src_count = NULL                             => -0.00585359858469322,
                                                            -0.00585359858469322));

bus_tree_80 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 10990592 => bus_tree_80_c1220,
    bx_addr_assessed_value >= 10990592                                  => 0.047660013974582,
    bx_addr_assessed_value = NULL                                       => -0.00468058666918378,
                                                                           -0.00468058666918378));

bus_tree_81_c1224 :=   __common__( map(
    NULL < bv_inq_total_count12 AND bv_inq_total_count12 < 5.5 => 0.0021307642812907,
    bv_inq_total_count12 >= 5.5                                => 0.0530589974218001,
    bv_inq_total_count12 = NULL                                => 0.0039003104661701,
                                                                  0.0039003104661701));

bus_tree_81_c1223 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 44.5 => bus_tree_81_c1224,
    bv_empl_ct_max >= 44.5                          => 0.047990630740483,
    bv_empl_ct_max = NULL                           => 0.0055039106127017,
                                                       0.0055039106127017));

bus_tree_81 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 18.5 => bus_tree_81_c1223,
    bx_addr_lres >= 18.5                        => -0.0192861274905153,
    bx_addr_lres = NULL                         => -0.00501546005331947,
                                                   -0.00501546005331947));

bus_tree_82_c1226 :=   __common__( map(
    NULL < bx_irs_retirementplan AND bx_irs_retirementplan < 0.5 => 0.00438168114776209,
    bx_irs_retirementplan >= 0.5                                 => 0.0518431284198854,
    bx_irs_retirementplan = NULL                                 => 0.00672744462314735,
                                                                    0.00672744462314735));

bus_tree_82_c1227 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 1511936 => -0.00107166529692529,
    bv_sales >= 1511936                    => -0.0581416015085418,
    bv_sales = NULL                        => -0.00300323587511694,
                                              -0.00300323587511694));

bus_tree_82 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => bus_tree_82_c1226,
    bx_consumer_addr >= 0.5                            => bus_tree_82_c1227,
    bx_consumer_addr = NULL                            => 0.00198613944958503,
                                                          0.00198613944958503));

bus_tree_83_c1229 :=   __common__( map(
    NULL < bv_ucc_mth_fs AND bv_ucc_mth_fs < 17.5 => -0.00414817112145281,
    bv_ucc_mth_fs >= 17.5                         => -0.0713953308829457,
    bv_ucc_mth_fs = NULL                          => -0.0288286917593064,
                                                     -0.0288286917593064));

bus_tree_83_c1230 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 47.5 => -0.00100456369702996,
    bv_assoc_bus_total >= 47.5                              => -0.0762951314180298,
    bv_assoc_bus_total = NULL                               => -0.00227136728156066,
                                                               -0.00227136728156066));

bus_tree_83 :=   __common__( map(
    (bx_fein_contradictory_in in [2, 3])      => bus_tree_83_c1229,
    (bx_fein_contradictory_in in [0, 1, 4]) => bus_tree_83_c1230,
    bx_fein_contradictory_in = NULL               => -0.00459711648712896,
                                                     -0.00459711648712896));

bus_tree_84_c1233 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => 0.0802114284228621,
    bx_consumer_addr >= 0.5                            => -0.00667202775283172,
    bx_consumer_addr = NULL                            => 0.0358253149418012,
                                                          0.0358253149418012));

bus_tree_84_c1232 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 191.5 => -0.00705519759585004,
    bv_mth_ver_src_br_fs >= 191.5                                => bus_tree_84_c1233,
    bv_mth_ver_src_br_fs = NULL                                  => -0.00551230064940184,
                                                                    -0.00551230064940184));

bus_tree_84 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 13.5 => bus_tree_84_c1232,
    bv_ver_src_id_count >= 13.5                               => -0.0518303569518276,
    bv_ver_src_id_count = NULL                                => -0.00687768552906519,
                                                                 -0.00687768552906519));

bus_tree_85_c1236 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 2972672 => 0.0250215454473829,
    bx_addr_assessed_value >= 2972672                                  => -0.0381007651661401,
    bx_addr_assessed_value = NULL                                      => 0.0186831466847168,
                                                                          0.0186831466847168));

bus_tree_85_c1235 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 6.5 => bus_tree_85_c1236,
    bv_ver_src_id_mth_since_ls >= 6.5                                      => 0.0791082060545132,
    bv_ver_src_id_mth_since_ls = NULL                                      => 0.0264243490698433,
                                                                              0.0264243490698433));

bus_tree_85 :=   __common__( map(
    NULL < bv_inq_other_pct12 AND bv_inq_other_pct12 < 0.707 => -0.00216910133279721,
    bv_inq_other_pct12 >= 0.707                              => bus_tree_85_c1235,
    bv_inq_other_pct12 = NULL                                => 0.0032124324164526,
                                                                0.0032124324164526));

bus_tree_86_c1239 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 8.5 => 0.00229126018261365,
    bv_ucc_count >= 8.5                        => -0.0512001587203483,
    bv_ucc_count = NULL                        => 0.000195711349514437,
                                                  0.000195711349514437));

bus_tree_86_c1238 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 2840832 => bus_tree_86_c1239,
    bv_sales >= 2840832                    => 0.0465367537381365,
    bv_sales = NULL                        => 0.000923449090515887,
                                              0.000923449090515887));

bus_tree_86 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 3.5 => bus_tree_86_c1238,
    bx_fein_src_count >= 3.5                             => -0.029735582368209,
    bx_fein_src_count = NULL                             => 8.6492771958742e-05,
                                                            8.6492771958742e-05));

bus_tree_87_c1242 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 7.5 => 0.00827107280388357,
    bv_mth_bureau_ls >= 7.5                            => 0.0603916636121936,
    bv_mth_bureau_ls = NULL                            => 0.0116223517992021,
                                                          0.0116223517992021));

bus_tree_87_c1241 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 374.5 => bus_tree_87_c1242,
    bv_sos_mth_ls >= 374.5                         => 0.0659770909352391,
    bv_sos_mth_ls = NULL                           => 0.0132272990056916,
                                                      0.0132272990056916));

bus_tree_87 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => bus_tree_87_c1241,
    bx_consumer_addr >= 0.5                            => -0.00906012990754134,
    bx_consumer_addr = NULL                            => 0.00253034465966565,
                                                          0.00253034465966565));

bus_tree_88_c1245 :=   __common__( map(
    NULL < bx_phn_not_in_zipcode AND bx_phn_not_in_zipcode < 0.5 => 0.0222419436412641,
    bx_phn_not_in_zipcode >= 0.5                                 => 0.10434594684785,
    bx_phn_not_in_zipcode = NULL                                 => 0.0332836646376495,
                                                                    0.0332836646376495));

bus_tree_88_c1244 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => bus_tree_88_c1245,
    bx_phn_mobile >= 0.5                         => 0.00699170408000776,
    bx_phn_mobile = NULL                         => 0.0163099415847654,
                                                    0.0163099415847654));

bus_tree_88 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 25.5 => -0.00964572935048885,
    bv_mth_ver_src_br_ls >= 25.5                                => bus_tree_88_c1244,
    bv_mth_ver_src_br_ls = NULL                                 => 0.000968040850548613,
                                                                   0.000968040850548613));

bus_tree_89_c1248 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2]) => -2.23507176054916e-05,
    (bx_fein_contradictory_in in [3, 4])      => 0.0259618609338047,
    bx_fein_contradictory_in = NULL               => 0.00236742239040086,
                                                     0.00236742239040086));

bus_tree_89_c1247 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 272.5 => bus_tree_89_c1248,
    bv_sos_mth_ls >= 272.5                         => 0.073963871311725,
    bv_sos_mth_ls = NULL                           => 0.00366441736273679,
                                                      0.00366441736273679));

bus_tree_89 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 298.5 => bus_tree_89_c1247,
    bv_mth_ver_src_c_fs >= 298.5                               => -0.0351401841705499,
    bv_mth_ver_src_c_fs = NULL                                 => 0.000965987021797725,
                                                                  0.000965987021797725));

bus_tree_90_c1251 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 216.5 => 0.0879837921111087,
    bv_mth_ver_src_c_fs >= 216.5                               => -0.0037940566163501,
    bv_mth_ver_src_c_fs = NULL                                 => 0.0488387649190655,
                                                                  0.0488387649190655));

bus_tree_90_c1250 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 1.5 => 0.00811787368989211,
    bv_mth_bureau_fs >= 1.5                            => bus_tree_90_c1251,
    bv_mth_bureau_fs = NULL                            => 0.0135017168692058,
                                                          0.0135017168692058));

bus_tree_90 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => bus_tree_90_c1250,
    bx_consumer_addr >= 0.5                            => -0.00990078236851639,
    bx_consumer_addr = NULL                            => 0.00221463944983243,
                                                          0.00221463944983243));

bus_tree_91_c1254 :=   __common__( map(
    NULL < bx_assoc_city_match_ct AND bx_assoc_city_match_ct < 0.5 => 0.126425222778182,
    bx_assoc_city_match_ct >= 0.5                                  => 0.00864933862706215,
    bx_assoc_city_match_ct = NULL                                  => 0.0675372807026223,
                                                                      0.0675372807026223));

bus_tree_91_c1253 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 8.5 => -0.00283492874901388,
    bx_inq_consumer_addr_cnt >= 8.5                                    => bus_tree_91_c1254,
    bx_inq_consumer_addr_cnt = NULL                                    => -0.000549056516246117,
                                                                          -0.000549056516246117));

bus_tree_91 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 7.5 => bus_tree_91_c1253,
    bx_inq_consumer_phn_cnt >= 7.5                                   => 0.0393281563678394,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.000156815291243964,
                                                                        0.000156815291243964));

bus_tree_92_c1257 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3]) => -0.00930881718364607,
    (bx_phn_contradictory in [0, 4])      => 0.0109097837506162,
    bx_phn_contradictory = NULL               => 0.00135211177913633,
                                                 0.00135211177913633));

bus_tree_92_c1256 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 0.5 => bus_tree_92_c1257,
    bv_ucc_other_count >= 0.5                              => 0.0510084451405941,
    bv_ucc_other_count = NULL                              => 0.00236436769196219,
                                                              0.00236436769196219));

bus_tree_92 :=   __common__( map(
    NULL < bv_ucc_mth_fs AND bv_ucc_mth_fs < 220.5 => bus_tree_92_c1256,
    bv_ucc_mth_fs >= 220.5                         => -0.0383177474838848,
    bv_ucc_mth_fs = NULL                           => -3.37446112943151e-06,
                                                      -3.37446112943151e-06));

bus_tree_93_c1260 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 32.5 => -0.000627042282058475,
    bv_sos_mth_fs >= 32.5                         => -0.0575043924031229,
    bv_sos_mth_fs = NULL                          => -0.00588074206677935,
                                                     -0.00588074206677935));

bus_tree_93_c1259 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 35.5 => bus_tree_93_c1260,
    bv_mth_ver_src_c_fs >= 35.5                               => 0.0184067928466612,
    bv_mth_ver_src_c_fs = NULL                                => 0.00467626992771893,
                                                                 0.00467626992771893));

bus_tree_93 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 204.5 => bus_tree_93_c1259,
    bv_mth_ver_src_br_fs >= 204.5                                => -0.0489346392510857,
    bv_mth_ver_src_br_fs = NULL                                  => 0.0032904096904437,
                                                                    0.0032904096904437));

bus_tree_94_c1262 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 149.5 => 0.00965198288561798,
    bv_mth_bureau_ls >= 149.5                            => -0.0581715887302851,
    bv_mth_bureau_ls = NULL                              => 0.00814644050857825,
                                                            0.00814644050857825));

bus_tree_94_c1263 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 1147648 => -0.0311031783732508,
    bx_addr_assessed_value >= 1147648                                  => 0.047927596683485,
    bx_addr_assessed_value = NULL                                      => -0.0232097741570578,
                                                                          -0.0232097741570578));

bus_tree_94 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 41.5 => bus_tree_94_c1262,
    bx_addr_lres >= 41.5                        => bus_tree_94_c1263,
    bx_addr_lres = NULL                         => -0.00153535366444694,
                                                   -0.00153535366444694));

bus_tree_95_c1265 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 3.5 => 0.00582654633733406,
    bx_inq_consumer_phn_cnt >= 3.5                                   => 0.0644881018765384,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.0104707740241427,
                                                                        0.0104707740241427));

bus_tree_95_c1266 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 4.5 => -0.00940814421930129,
    bx_inq_consumer_phn_cnt >= 4.5                                   => -0.0606314868440145,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.0109590017032907,
                                                                        -0.0109590017032907));

bus_tree_95 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 2.5 => bus_tree_95_c1265,
    bv_ver_src_id_count >= 2.5                               => bus_tree_95_c1266,
    bv_ver_src_id_count = NULL                               => -0.00247455988467422,
                                                                -0.00247455988467422));

bus_tree_96_c1269 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 0.5 => 0.0445876532815585,
    bx_inq_consumer_addr_cnt >= 0.5                                    => -0.00723951389370269,
    bx_inq_consumer_addr_cnt = NULL                                    => 0.0192611088043273,
                                                                          0.0192611088043273));

bus_tree_96_c1268 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 2.5 => -0.00441836025365612,
    bx_inq_consumer_phn_cnt >= 2.5                                   => bus_tree_96_c1269,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00216056315763919,
                                                                        -0.00216056315763919));

bus_tree_96 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 37.5 => bus_tree_96_c1268,
    bx_phn_distance_addr >= 37.5                                => 0.0683973295197979,
    bx_phn_distance_addr = NULL                                 => -0.00108322067601013,
                                                                   -0.00108322067601013));

bus_tree_97_c1272 :=   __common__( map(
    (bx_phn_contradictory in [0, 2])      => -0.0805981483524107,
    (bx_phn_contradictory in [1, 3, 4]) => -0.0289650860545513,
    bx_phn_contradictory = NULL               => -0.0484634710065793,
                                                 -0.0484634710065793));

bus_tree_97_c1271 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 140.5 => -0.00205090289362578,
    bv_mth_ver_src_br_ls >= 140.5                                => bus_tree_97_c1272,
    bv_mth_ver_src_br_ls = NULL                                  => -0.0042596680325597,
                                                                    -0.0042596680325597));

bus_tree_97 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 188.5 => bus_tree_97_c1271,
    bv_mth_ver_src_br_ls >= 188.5                                => 0.0666173905997542,
    bv_mth_ver_src_br_ls = NULL                                  => -0.00317749374354024,
                                                                    -0.00317749374354024));

bus_tree_98_c1274 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 172.5 => -0.00478617482778265,
    bv_mth_ver_src_br_fs >= 172.5                                => -0.0528800394023438,
    bv_mth_ver_src_br_fs = NULL                                  => -0.00657787301191523,
                                                                    -0.00657787301191523));

bus_tree_98_c1275 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 162.5 => 0.00369167480308351,
    bv_mth_ver_src_p_fs >= 162.5                               => 0.0865510013415236,
    bv_mth_ver_src_p_fs = NULL                                 => 0.0174500331275633,
                                                                  0.0174500331275633));

bus_tree_98 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 82.5 => bus_tree_98_c1274,
    bv_mth_ver_src_br_ls >= 82.5                                => bus_tree_98_c1275,
    bv_mth_ver_src_br_ls = NULL                                 => -0.00268400825280397,
                                                                   -0.00268400825280397));

bus_tree_99_c1278 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 58.5 => 0.0167854402825416,
    bv_mth_ver_src_br_ls >= 58.5                                => 0.0949093283879848,
    bv_mth_ver_src_br_ls = NULL                                 => 0.0339555255804412,
                                                                   0.0339555255804412));

bus_tree_99_c1277 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => bus_tree_99_c1278,
    bx_phn_mobile >= 0.5                         => 0.00407728205245118,
    bx_phn_mobile = NULL                         => 0.00756263029119889,
                                                    0.00756263029119889));

bus_tree_99 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 3.5 => -0.0159182906837317,
    bx_phn_problems >= 3.5                           => bus_tree_99_c1277,
    bx_phn_problems = NULL                           => -0.00198653950291077,
                                                        -0.00198653950291077));

bus_tree_100_c1281 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 702.5 => 0.00322087128061793,
    bx_addr_lot_size >= 702.5                            => 0.0743996141029189,
    bx_addr_lot_size = NULL                              => 0.042230242346894,
                                                            0.042230242346894));

bus_tree_100_c1280 :=   __common__( map(
    NULL < bx_phn_not_in_zipcode AND bx_phn_not_in_zipcode < 0.5 => 0.00110821565247192,
    bx_phn_not_in_zipcode >= 0.5                                 => bus_tree_100_c1281,
    bx_phn_not_in_zipcode = NULL                                 => 0.00732129863307198,
                                                                    0.00732129863307198));

bus_tree_100 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => bus_tree_100_c1280,
    bx_phn_mobile >= 0.5                         => -0.00912194505239729,
    bx_phn_mobile = NULL                         => -0.00361671809162343,
                                                    -0.00361671809162343));

bus_tree_101_c1284 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 5435.5 => 0.00799897871676828,
    bv_sales >= 5435.5                    => 0.0946581774534173,
    bv_sales = NULL                       => 0.0105996712224821,
                                             0.0105996712224821));

bus_tree_101_c1283 :=   __common__( map(
    NULL < bv_ucc_mth_ls AND bv_ucc_mth_ls < 4.5 => bus_tree_101_c1284,
    bv_ucc_mth_ls >= 4.5                         => -0.0265638940452839,
    bv_ucc_mth_ls = NULL                         => 0.00317639453759613,
                                                    0.00317639453759613));

bus_tree_101 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 26664 => bus_tree_101_c1283,
    bx_addr_lot_size >= 26664                            => -0.0262211664493067,
    bx_addr_lot_size = NULL                              => -0.00521846452578398,
                                                            -0.00521846452578398));

bus_tree_102_c1286 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 44928 => -0.0316779775843335,
    bx_addr_lot_size >= 44928                            => 0.0569267033646379,
    bx_addr_lot_size = NULL                              => -0.0125766061478705,
                                                            -0.0125766061478705));

bus_tree_102_c1287 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => 0.0210730252206428,
    bx_phn_mobile >= 0.5                         => -0.00579984378450139,
    bx_phn_mobile = NULL                         => 0.00286339724063118,
                                                    0.00286339724063118));

bus_tree_102 :=   __common__( map(
    (bx_fein_contradictory_in in [2, 3, 4]) => bus_tree_102_c1286,
    (bx_fein_contradictory_in in [0, 1])      => bus_tree_102_c1287,
    bx_fein_contradictory_in = NULL               => 0.000929162759100147,
                                                     0.000929162759100147));

bus_tree_103_c1289 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 5.5 => 0.00276591863304171,
    bx_inq_consumer_phn_cnt >= 5.5                                   => -0.0210353861033123,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00201995526520935,
                                                                        0.00201995526520935));

bus_tree_103_c1290 :=   __common__( map(
    (bx_phn_contradictory in [0, 2, 3, 4]) => -0.0596577785144467,
    (bx_phn_contradictory in [1])                => -0.0154909235591011,
    bx_phn_contradictory = NULL                    => -0.0383889036896388,
                                                      -0.0383889036896388));

bus_tree_103 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 1451520 => bus_tree_103_c1289,
    bv_sales >= 1451520                    => bus_tree_103_c1290,
    bv_sales = NULL                        => 0.00052027652395232,
                                              0.00052027652395232));

bus_tree_104_c1293 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 1.5 => -0.00622621680565017,
    bx_inq_consumer_phn_cnt >= 1.5                                   => 0.0268540695576262,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.000690483158671022,
                                                                        -0.000690483158671022));

bus_tree_104_c1292 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 208224 => bus_tree_104_c1293,
    bx_addr_assessed_value >= 208224                                  => -0.0217219813124548,
    bx_addr_assessed_value = NULL                                     => -0.0101175600346119,
                                                                         -0.0101175600346119));

bus_tree_104 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 466.5 => bus_tree_104_c1292,
    bv_sos_mth_ls >= 466.5                         => 0.0455548585994438,
    bv_sos_mth_ls = NULL                           => -0.00919599845631574,
                                                      -0.00919599845631574));

bus_tree_105_c1296 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 1.5 => 0.0655346070387991,
    bx_fein_src_count >= 1.5                             => 0.0220512042752232,
    bx_fein_src_count = NULL                             => 0.0383406523693182,
                                                            0.0383406523693182));

bus_tree_105_c1295 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 9.5 => 0.00181815432431769,
    bx_addr_src_count >= 9.5                             => bus_tree_105_c1296,
    bx_addr_src_count = NULL                             => 0.0036466814646965,
                                                            0.0036466814646965));

bus_tree_105 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 148.5 => bus_tree_105_c1295,
    bv_mth_bureau_ls >= 148.5                            => -0.0590322911104862,
    bv_mth_bureau_ls = NULL                              => 0.00219222609201463,
                                                            0.00219222609201463));

bus_tree_106_c1299 :=   __common__( map(
    NULL < bx_irs_retirementplan AND bx_irs_retirementplan < 0.5 => -0.00100803494049546,
    bx_irs_retirementplan >= 0.5                                 => 0.0464086090564737,
    bx_irs_retirementplan = NULL                                 => 0.000518695285036392,
                                                                    0.000518695285036392));

bus_tree_106_c1298 :=   __common__( map(
    NULL < bv_ucc_active_count AND bv_ucc_active_count < 6.5 => bus_tree_106_c1299,
    bv_ucc_active_count >= 6.5                               => -0.0417456496305064,
    bv_ucc_active_count = NULL                               => -0.0014889423135651,
                                                                -0.0014889423135651));

bus_tree_106 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 4243968 => bus_tree_106_c1298,
    bv_sales >= 4243968                    => -0.0470056149441459,
    bv_sales = NULL                        => -0.00224583331724823,
                                              -0.00224583331724823));

bus_tree_107_c1302 :=   __common__( map(
    NULL < bv_ucc_active_count AND bv_ucc_active_count < 1.5 => 0.00437546929203534,
    bv_ucc_active_count >= 1.5                               => -0.0234921738249945,
    bv_ucc_active_count = NULL                               => -5.89598901665133e-05,
                                                                -5.89598901665133e-05));

bus_tree_107_c1301 :=   __common__( map(
    NULL < bx_assoc_city_match_ct AND bx_assoc_city_match_ct < 3.5 => bus_tree_107_c1302,
    bx_assoc_city_match_ct >= 3.5                                  => 0.0712799112700576,
    bx_assoc_city_match_ct = NULL                                  => 0.00117923877984429,
                                                                      0.00117923877984429));

bus_tree_107 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 1.5 => bus_tree_107_c1301,
    bv_ucc_other_count >= 1.5                              => 0.0460242882548726,
    bv_ucc_other_count = NULL                              => 0.0018876753135012,
                                                              0.0018876753135012));

bus_tree_108_c1305 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 412.5 => -0.00120617549657623,
    bv_ver_src_id_mth_since_fs >= 412.5                                      => 0.0491187796308984,
    bv_ver_src_id_mth_since_fs = NULL                                        => 0.000722092122975973,
                                                                                0.000722092122975973));

bus_tree_108_c1304 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 198.5 => bus_tree_108_c1305,
    bv_mth_ver_src_br_fs >= 198.5                                => -0.0497680048631134,
    bv_mth_ver_src_br_fs = NULL                                  => -0.000845898902666122,
                                                                    -0.000845898902666122));

bus_tree_108 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 3.5 => bus_tree_108_c1304,
    bx_fein_src_count >= 3.5                             => -0.0244276787175102,
    bx_fein_src_count = NULL                             => -0.00151293759959183,
                                                            -0.00151293759959183));

bus_tree_109_c1308 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 15.5 => 0.0445726516001428,
    bv_assoc_bus_total >= 15.5                              => -0.0421156187959449,
    bv_assoc_bus_total = NULL                               => 0.0290765618143137,
                                                               0.0290765618143137));

bus_tree_109_c1307 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 1402496 => -0.00466689361674869,
    bx_addr_assessed_value >= 1402496                                  => bus_tree_109_c1308,
    bx_addr_assessed_value = NULL                                      => -0.00165673096447458,
                                                                          -0.00165673096447458));

bus_tree_109 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 687.5 => bus_tree_109_c1307,
    bv_ver_src_id_mth_since_fs >= 687.5                                      => -0.0546776307159698,
    bv_ver_src_id_mth_since_fs = NULL                                        => -0.00265462998474082,
                                                                                -0.00265462998474082));

bus_tree_110_c1311 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 552576 => -0.00198365206960453,
    bx_addr_assessed_value >= 552576                                  => 0.08589123198402,
    bx_addr_assessed_value = NULL                                     => 0.0264349020878269,
                                                                         0.0264349020878269));

bus_tree_110_c1310 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 268.5 => -0.00389576219667688,
    bv_sos_mth_ls >= 268.5                         => bus_tree_110_c1311,
    bv_sos_mth_ls = NULL                           => -0.00231760806090594,
                                                      -0.00231760806090594));

bus_tree_110 :=   __common__( map(
    (bx_fein_contradictory_in in [2])                => -0.0521031539566968,
    (bx_fein_contradictory_in in [0, 1, 3, 4]) => bus_tree_110_c1310,
    bx_fein_contradictory_in = NULL                    => -0.0035304198159706,
                                                          -0.0035304198159706));

bus_tree_111_c1314 :=   __common__( map(
    (bx_phn_contradictory in [2, 3])      => -0.0199835141487893,
    (bx_phn_contradictory in [0, 1, 4]) => 0.00691003186641242,
    bx_phn_contradictory = NULL               => -0.000997733365684914,
                                                 -0.000997733365684914));

bus_tree_111_c1313 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 174.5 => bus_tree_111_c1314,
    bv_mth_bureau_ls >= 174.5                            => -0.05953791791366,
    bv_mth_bureau_ls = NULL                              => -0.00202417056532471,
                                                            -0.00202417056532471));

bus_tree_111 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 1.5 => bus_tree_111_c1313,
    bx_consumer_addr >= 1.5                            => -0.0384174286729419,
    bx_consumer_addr = NULL                            => -0.00450452802031435,
                                                          -0.00450452802031435));

bus_tree_112_c1317 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 164.5 => -0.0137438218239433,
    bv_sos_mth_ls >= 164.5                         => 0.0262923905094648,
    bv_sos_mth_ls = NULL                           => -0.00499945053812674,
                                                      -0.00499945053812674));

bus_tree_112_c1316 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 32.5 => 0.035338802477743,
    bv_sos_mth_ls >= 32.5                         => bus_tree_112_c1317,
    bv_sos_mth_ls = NULL                          => 0.0136603455493141,
                                                     0.0136603455493141));

bus_tree_112 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 9.5 => -0.0132366569323253,
    bv_mth_ver_src_br_ls >= 9.5                                => bus_tree_112_c1316,
    bv_mth_ver_src_br_ls = NULL                                => 0.00143369604632245,
                                                                  0.00143369604632245));

bus_tree_113_c1320 :=   __common__( map(
    NULL < bv_inq_total_count12 AND bv_inq_total_count12 < 1.5 => 0.00845224173398478,
    bv_inq_total_count12 >= 1.5                                => 0.0405874862016514,
    bv_inq_total_count12 = NULL                                => 0.0142488773993347,
                                                                  0.0142488773993347));

bus_tree_113_c1319 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 10505 => bus_tree_113_c1320,
    bx_addr_lot_size >= 10505                            => -0.0108445256769039,
    bx_addr_lot_size = NULL                              => 0.00330305380620332,
                                                            0.00330305380620332));

bus_tree_113 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 4.5 => -0.0516567177610032,
    bv_ver_src_id_mth_since_fs >= 4.5                                      => bus_tree_113_c1319,
    bv_ver_src_id_mth_since_fs = NULL                                      => -0.000801273805920648,
                                                                              -0.000801273805920648));

bus_tree_114_c1323 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 411.5 => 0.0018607257260435,
    bv_sos_mth_fs >= 411.5                         => -0.0484309474708028,
    bv_sos_mth_fs = NULL                           => 0.000829303543845953,
                                                      0.000829303543845953));

bus_tree_114_c1322 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 544 => bus_tree_114_c1323,
    bv_mth_ver_src_c_fs >= 544                               => 0.0652898977561183,
    bv_mth_ver_src_c_fs = NULL                               => 0.00182291578603897,
                                                                0.00182291578603897));

bus_tree_114 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 44.5 => bus_tree_114_c1322,
    bv_assoc_bus_total >= 44.5                              => -0.0549449037778456,
    bv_assoc_bus_total = NULL                               => 0.000728751463379069,
                                                               0.000728751463379069));

bus_tree_115_c1326 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 8116 => 0.0172516668396545,
    bx_addr_bldg_size >= 8116                             => 0.105867569197607,
    bx_addr_bldg_size = NULL                              => 0.0335413547731016,
                                                             0.0335413547731016));

bus_tree_115_c1325 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 149.5 => -0.00216812305646943,
    bv_mth_ver_src_c_fs >= 149.5                               => bus_tree_115_c1326,
    bv_mth_ver_src_c_fs = NULL                                 => 0.00115710048671555,
                                                                  0.00115710048671555));

bus_tree_115 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 182.5 => bus_tree_115_c1325,
    bv_sos_mth_fs >= 182.5                         => -0.0279650274306487,
    bv_sos_mth_fs = NULL                           => -0.00224598415124705,
                                                      -0.00224598415124705));

bus_tree_116_c1328 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 163.5 => 0.00144570199810428,
    bv_sos_mth_ls >= 163.5                         => 0.0597445263468029,
    bv_sos_mth_ls = NULL                           => 0.00397373139873532,
                                                      0.00397373139873532));

bus_tree_116_c1329 :=   __common__( map(
    (bx_fein_contradictory_id in [1])      => -0.0395128507074122,
    (bx_fein_contradictory_id in [0, 2]) => 0.00648001022556993,
    bx_fein_contradictory_id = NULL          => -0.0221127885478568,
                                                -0.0221127885478568));

bus_tree_116 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 177.5 => bus_tree_116_c1328,
    bv_mth_ver_src_c_fs >= 177.5                               => bus_tree_116_c1329,
    bv_mth_ver_src_c_fs = NULL                                 => 0.00025891631337027,
                                                                  0.00025891631337027));

bus_tree_117_c1332 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < -0.5 => 0.0472870537283844,
    bx_phn_distance_addr >= -0.5                                => 0.0235338871141383,
    bx_phn_distance_addr = NULL                                 => 0.0324372178920922,
                                                                   0.0324372178920922));

bus_tree_117_c1331 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 11.5 => -0.00326989206352071,
    bv_ver_src_id_count >= 11.5                               => bus_tree_117_c1332,
    bv_ver_src_id_count = NULL                                => -0.00126181783578545,
                                                                 -0.00126181783578545));

bus_tree_117 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 204.5 => bus_tree_117_c1331,
    bv_mth_ver_src_br_fs >= 204.5                                => -0.046299151148295,
    bv_mth_ver_src_br_fs = NULL                                  => -0.00247370677450452,
                                                                    -0.00247370677450452));

bus_tree_118_c1335 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 4.5 => -0.00525375975225737,
    bx_phn_problems >= 4.5                           => 0.0429833988800547,
    bx_phn_problems = NULL                           => -0.00412081411046932,
                                                        -0.00412081411046932));

bus_tree_118_c1334 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 2, 3, 4]) => bus_tree_118_c1335,
    (bx_fein_contradictory_in in [1])                => 0.015958429783319,
    bx_fein_contradictory_in = NULL                    => 1.44214234177624e-05,
                                                          1.44214234177624e-05));

bus_tree_118 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 254.5 => bus_tree_118_c1334,
    bv_mth_bureau_fs >= 254.5                            => -0.0635857285984456,
    bv_mth_bureau_fs = NULL                              => -0.00110567192163848,
                                                            -0.00110567192163848));

bus_tree_119_c1338 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 2.5 => 0.0165852538575321,
    bv_ver_src_id_count >= 2.5                               => -0.0223391379549491,
    bv_ver_src_id_count = NULL                               => -0.00252284695631905,
                                                                -0.00252284695631905));

bus_tree_119_c1337 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 3.5 => bus_tree_119_c1338,
    bv_assoc_bus_total >= 3.5                              => 0.0209447519342881,
    bv_assoc_bus_total = NULL                              => 0.00475702338016511,
                                                              0.00475702338016511));

bus_tree_119 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 382.5 => bus_tree_119_c1337,
    bv_mth_ver_src_p_fs >= 382.5                               => -0.0599228255509679,
    bv_mth_ver_src_p_fs = NULL                                 => 0.00357391503236963,
                                                                  0.00357391503236963));

bus_tree_120_c1341 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 101.5 => 0.0281106752512225,
    bv_sos_mth_ls >= 101.5                         => 0.109544812286333,
    bv_sos_mth_ls = NULL                           => 0.0394841580773552,
                                                      0.0394841580773552));

bus_tree_120_c1340 :=   __common__( map(
    (bx_fein_contradictory_id in [1, 2]) => -0.0046033838200281,
    (bx_fein_contradictory_id in [0])      => bus_tree_120_c1341,
    bx_fein_contradictory_id = NULL          => 0.0208228586274358,
                                                0.0208228586274358));

bus_tree_120 :=   __common__( map(
    NULL < bv_inq_other_pct12 AND bv_inq_other_pct12 < 0.687 => -0.00376440169613696,
    bv_inq_other_pct12 >= 0.687                              => bus_tree_120_c1340,
    bv_inq_other_pct12 = NULL                                => 0.000853840322311892,
                                                                0.000853840322311892));

bus_tree_121_c1343 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 14.5 => -0.00677404755367636,
    bv_mth_ver_src_c_ls >= 14.5                               => -0.0625060075417609,
    bv_mth_ver_src_c_ls = NULL                                => -0.0169187317415475,
                                                                 -0.0169187317415475));

bus_tree_121_c1344 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 3.5 => 0.00536462380602715,
    bx_fein_src_count >= 3.5                             => -0.0276263866956973,
    bx_fein_src_count = NULL                             => 0.00450196337279109,
                                                            0.00450196337279109));

bus_tree_121 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 0.5 => bus_tree_121_c1343,
    bx_addr_src_count >= 0.5                             => bus_tree_121_c1344,
    bx_addr_src_count = NULL                             => 0.00167339539359611,
                                                            0.00167339539359611));

bus_tree_122_c1347 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 17.5 => 0.00297566958458593,
    bv_empl_ct_max >= 17.5                          => 0.0579633123657163,
    bv_empl_ct_max = NULL                           => 0.00435183722883978,
                                                       0.00435183722883978));

bus_tree_122_c1346 :=   __common__( map(
    (bx_fein_contradictory_in in [1, 2, 4]) => -0.0118555025537814,
    (bx_fein_contradictory_in in [0, 3])      => bus_tree_122_c1347,
    bx_fein_contradictory_in = NULL               => -2.09666027066296e-05,
                                                     -2.09666027066296e-05));

bus_tree_122 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 5.5 => bus_tree_122_c1346,
    bx_inq_consumer_phn_cnt >= 5.5                                   => -0.0345486931158498,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00107823229564765,
                                                                        -0.00107823229564765));

bus_tree_123_c1350 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 133040 => 0.133733911126167,
    bx_addr_assessed_value >= 133040                                  => -0.00446744997759948,
    bx_addr_assessed_value = NULL                                     => 0.0429587935067677,
                                                                         0.0429587935067677));

bus_tree_123_c1349 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 6.5 => 0.00043266401340656,
    bx_inq_consumer_addr_cnt >= 6.5                                    => bus_tree_123_c1350,
    bx_inq_consumer_addr_cnt = NULL                                    => 0.00257560825391709,
                                                                          0.00257560825391709));

bus_tree_123 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 5.5 => bus_tree_123_c1349,
    bx_inq_consumer_phn_cnt >= 5.5                                   => -0.0264288724635184,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00173167327596542,
                                                                        0.00173167327596542));

bus_tree_124_c1353 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 2, 3, 4]) => 0.0106659192389788,
    (bx_fein_contradictory_in in [1])                => 0.0477759608167493,
    bx_fein_contradictory_in = NULL                    => 0.0165936714433131,
                                                          0.0165936714433131));

bus_tree_124_c1352 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 16.5 => bus_tree_124_c1353,
    bv_mth_ver_src_p_fs >= 16.5                               => -0.021218934807711,
    bv_mth_ver_src_p_fs = NULL                                => 0.010665753153446,
                                                                 0.010665753153446));

bus_tree_124 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 17838 => bus_tree_124_c1352,
    bx_addr_lot_size >= 17838                            => -0.0166960477577764,
    bx_addr_lot_size = NULL                              => 0.00141692672298594,
                                                            0.00141692672298594));

bus_tree_125_c1356 :=   __common__( map(
    NULL < bx_tin_match_consumer_associate AND bx_tin_match_consumer_associate < 0.5 => 0.100737519711336,
    bx_tin_match_consumer_associate >= 0.5                                           => 0.0176340573620775,
    bx_tin_match_consumer_associate = NULL                                           => 0.0558262868672685,
                                                                                        0.0558262868672685));

bus_tree_125_c1355 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 84.5 => bus_tree_125_c1356,
    bv_mth_ver_src_br_ls >= 84.5                                => -0.0250002501322411,
    bv_mth_ver_src_br_ls = NULL                                 => 0.029384462620286,
                                                                   0.029384462620286));

bus_tree_125 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 9.5 => -0.00700274552203539,
    bx_addr_src_count >= 9.5                             => bus_tree_125_c1355,
    bx_addr_src_count = NULL                             => -0.00507749641397606,
                                                            -0.00507749641397606));

bus_tree_126_c1359 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3]) => -0.00168691430950968,
    (bx_phn_contradictory in [0, 4])      => 0.0211167843807836,
    bx_phn_contradictory = NULL               => 0.00876634316312064,
                                                 0.00876634316312064));

bus_tree_126_c1358 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 28.5 => -0.0132886990422405,
    bv_ver_src_id_mth_since_fs >= 28.5                                      => bus_tree_126_c1359,
    bv_ver_src_id_mth_since_fs = NULL                                       => 0.00227647044520996,
                                                                               0.00227647044520996));

bus_tree_126 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 2709248 => bus_tree_126_c1358,
    bx_addr_lot_size >= 2709248                            => -0.0814518047853817,
    bx_addr_lot_size = NULL                                => 0.000770247504553816,
                                                              0.000770247504553816));

bus_tree_127_c1362 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => 0.0171909136126685,
    bx_consumer_addr >= 0.5                            => -0.00424221861387982,
    bx_consumer_addr = NULL                            => 0.00689797425954761,
                                                          0.00689797425954761));

bus_tree_127_c1361 :=   __common__( map(
    NULL < bx_assoc_city_match_ct AND bx_assoc_city_match_ct < 0.5 => bus_tree_127_c1362,
    bx_assoc_city_match_ct >= 0.5                                  => -0.0175483781079571,
    bx_assoc_city_match_ct = NULL                                  => -0.00562489616585138,
                                                                      -0.00562489616585138));

bus_tree_127 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 7.5 => bus_tree_127_c1361,
    bx_inq_consumer_phn_cnt >= 7.5                                   => 0.0350154249707003,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00486607119434537,
                                                                        -0.00486607119434537));

bus_tree_128_c1364 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 5.5 => -0.00261648619761997,
    bx_inq_consumer_phn_cnt >= 5.5                                   => -0.0329456937956696,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00354231988422489,
                                                                        -0.00354231988422489));

bus_tree_128_c1365 :=   __common__( map(
    (bx_fein_contradictory_id in [1])      => 0.00141748111559604,
    (bx_fein_contradictory_id in [0, 2]) => 0.094985913503339,
    bx_fein_contradictory_id = NULL          => 0.0296102084115298,
                                                0.0296102084115298));

bus_tree_128 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 220.5 => bus_tree_128_c1364,
    bv_sos_mth_ls >= 220.5                         => bus_tree_128_c1365,
    bv_sos_mth_ls = NULL                           => -0.000853532064017428,
                                                      -0.000853532064017428));

bus_tree_129_c1368 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 3.5 => 0.135853025184448,
    bv_assoc_bus_total >= 3.5                              => 0.0014192749576987,
    bv_assoc_bus_total = NULL                              => 0.0437677083401199,
                                                              0.0437677083401199));

bus_tree_129_c1367 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 104.5 => 0.00157682630939859,
    bv_ver_src_derog_ratio >= 104.5                                  => bus_tree_129_c1368,
    bv_ver_src_derog_ratio = NULL                                    => 0.00402219947348204,
                                                                        0.00402219947348204));

bus_tree_129 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 3.5 => bus_tree_129_c1367,
    bx_fein_src_count >= 3.5                             => -0.0237254341832409,
    bx_fein_src_count = NULL                             => 0.00330194532301617,
                                                            0.00330194532301617));

bus_tree_130_c1371 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 11.5 => 0.00276797918884466,
    bx_addr_src_count >= 11.5                             => -0.0378789351266957,
    bx_addr_src_count = NULL                              => 0.00178853547039791,
                                                             0.00178853547039791));

bus_tree_130_c1370 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 124.5 => bus_tree_130_c1371,
    bv_mth_ver_src_c_ls >= 124.5                               => -0.0593400135864613,
    bv_mth_ver_src_c_ls = NULL                                 => -0.000155750754367272,
                                                                  -0.000155750754367272));

bus_tree_130 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 20.5 => bus_tree_130_c1370,
    bx_phn_distance_addr >= 20.5                                => 0.0514958985683234,
    bx_phn_distance_addr = NULL                                 => 0.00101797193506004,
                                                                   0.00101797193506004));

bus_tree_131_c1374 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 2.5 => -0.0639347069360139,
    bv_empl_ct_min >= 2.5                          => 0.0579391735169143,
    bv_empl_ct_min = NULL                          => -0.000289458255040245,
                                                      -0.000289458255040245));

bus_tree_131_c1373 :=   __common__( map(
    (bv_ucc_index in [2, 4])      => -0.0618067214876566,
    (bv_ucc_index in [0, 1, 3]) => bus_tree_131_c1374,
    bv_ucc_index = NULL               => -0.0302594070093918,
                                         -0.0302594070093918));

bus_tree_131 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 231.5 => 0.00754659911605255,
    bv_sos_mth_fs >= 231.5                         => bus_tree_131_c1373,
    bv_sos_mth_fs = NULL                           => 0.00453754964892534,
                                                      0.00453754964892534));

bus_tree_132_c1377 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 176.5 => 0.0217819149662706,
    bv_mth_ver_src_c_fs >= 176.5                               => -0.0113150800874093,
    bv_mth_ver_src_c_fs = NULL                                 => 0.0140047438176765,
                                                                  0.0140047438176765));

bus_tree_132_c1376 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 5925376 => bus_tree_132_c1377,
    bx_addr_assessed_value >= 5925376                                  => -0.0396480964122329,
    bx_addr_assessed_value = NULL                                      => 0.0121692519150744,
                                                                          0.0121692519150744));

bus_tree_132 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 11.5 => -0.0182010777922244,
    bv_mth_ver_src_c_fs >= 11.5                               => bus_tree_132_c1376,
    bv_mth_ver_src_c_fs = NULL                                => 0.000117533777257396,
                                                                 0.000117533777257396));

bus_tree_133_c1380 :=   __common__( map(
    (bx_fein_contradictory_id in [1])      => -0.0505189965577673,
    (bx_fein_contradictory_id in [0, 2]) => 0.0168106273411453,
    bx_fein_contradictory_id = NULL          => -0.0258734854211092,
                                                -0.0258734854211092));

bus_tree_133_c1379 :=   __common__( map(
    NULL < bv_ucc_active_count AND bv_ucc_active_count < 2.5 => 0.00670953061989501,
    bv_ucc_active_count >= 2.5                               => bus_tree_133_c1380,
    bv_ucc_active_count = NULL                               => 0.00279170278580955,
                                                                0.00279170278580955));

bus_tree_133 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 9959424 => bus_tree_133_c1379,
    bx_addr_assessed_value >= 9959424                                  => 0.0467512977974059,
    bx_addr_assessed_value = NULL                                      => 0.00380845532349273,
                                                                          0.00380845532349273));

bus_tree_134_c1383 :=   __common__( map(
    (bx_phn_contradictory in [1, 2])      => 0.00143771666665589,
    (bx_phn_contradictory in [0, 3, 4]) => 0.0634331890747661,
    bx_phn_contradictory = NULL               => 0.031524826072707,
                                                 0.031524826072707));

bus_tree_134_c1382 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 164.5 => 0.0112761651512913,
    bv_sos_mth_ls >= 164.5                         => bus_tree_134_c1383,
    bv_sos_mth_ls = NULL                           => 0.0134946284494779,
                                                      0.0134946284494779));

bus_tree_134 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 5.5 => -0.00879127710122744,
    bv_mth_ver_src_br_ls >= 5.5                                => bus_tree_134_c1382,
    bv_mth_ver_src_br_ls = NULL                                => 0.00436970400743929,
                                                                  0.00436970400743929));

bus_tree_135_c1386 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 139.5 => -0.00512248488261781,
    bv_mth_ver_src_p_fs >= 139.5                               => -0.0730772058062572,
    bv_mth_ver_src_p_fs = NULL                                 => -0.0400894772025488,
                                                                  -0.0400894772025488));

bus_tree_135_c1385 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 941056 => -0.00623112617453412,
    bv_sales >= 941056                    => bus_tree_135_c1386,
    bv_sales = NULL                       => -0.00732085671305002,
                                             -0.00732085671305002));

bus_tree_135 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 224.5 => bus_tree_135_c1385,
    bv_mth_bureau_fs >= 224.5                            => 0.030322145523112,
    bv_mth_bureau_fs = NULL                              => -0.00610023328453048,
                                                            -0.00610023328453048));

bus_tree_136_c1389 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 280.5 => -0.00145253695933774,
    bv_mth_ver_src_c_fs >= 280.5                               => 0.0383197224794277,
    bv_mth_ver_src_c_fs = NULL                                 => 0.000649497585795097,
                                                                  0.000649497585795097));

bus_tree_136_c1388 :=   __common__( map(
    (bv_ucc_index in [0, 3])      => -0.0294152166267183,
    (bv_ucc_index in [1, 2, 4]) => bus_tree_136_c1389,
    bv_ucc_index = NULL               => -0.00198101850775009,
                                         -0.00198101850775009));

bus_tree_136 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 3.5 => bus_tree_136_c1388,
    bx_fein_src_count >= 3.5                             => -0.0275749299936717,
    bx_fein_src_count = NULL                             => -0.00273013692743333,
                                                            -0.00273013692743333));

bus_tree_137_c1391 :=   __common__( map(
    (bx_phn_contradictory in [0, 4])      => -0.0774745445766034,
    (bx_phn_contradictory in [1, 2, 3]) => 0.00725065844725707,
    bx_phn_contradictory = NULL               => -0.0356976011500915,
                                                 -0.0356976011500915));

bus_tree_137_c1392 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 34.5 => -0.00219637844453289,
    bv_empl_ct_min >= 34.5                          => 0.0435583280126477,
    bv_empl_ct_min = NULL                           => -0.00130884092389301,
                                                       -0.00130884092389301));

bus_tree_137 :=   __common__( map(
    (bx_fein_contradictory_in in [4])                => bus_tree_137_c1391,
    (bx_fein_contradictory_in in [0, 1, 2, 3]) => bus_tree_137_c1392,
    bx_fein_contradictory_in = NULL                    => -0.00244793772333905,
                                                          -0.00244793772333905));

bus_tree_138_c1394 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 412.5 => -0.0044825903370567,
    bv_ver_src_id_mth_since_fs >= 412.5                                      => 0.0414374912616809,
    bv_ver_src_id_mth_since_fs = NULL                                        => -0.00243129004426047,
                                                                                -0.00243129004426047));

bus_tree_138_c1395 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < -0.5 => -0.0774120480665876,
    bx_phn_distance_addr >= -0.5                                => -0.00980857736233624,
    bx_phn_distance_addr = NULL                                 => -0.0347089951432481,
                                                                   -0.0347089951432481));

bus_tree_138 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 87.5 => bus_tree_138_c1394,
    bv_mth_bureau_ls >= 87.5                            => bus_tree_138_c1395,
    bv_mth_bureau_ls = NULL                             => -0.0038512163003157,
                                                           -0.0038512163003157));

bus_tree_139_c1398 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 0.5 => 0.0018229107170717,
    bx_fein_src_count >= 0.5                             => -0.0476353556502014,
    bx_fein_src_count = NULL                             => -0.0283688918247711,
                                                            -0.0283688918247711));

bus_tree_139_c1397 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 168.5 => 0.000177248540156078,
    bv_mth_ver_src_c_fs >= 168.5                               => bus_tree_139_c1398,
    bv_mth_ver_src_c_fs = NULL                                 => -0.00406633349260401,
                                                                  -0.00406633349260401));

bus_tree_139 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 1.5 => bus_tree_139_c1397,
    bv_ucc_other_count >= 1.5                              => 0.0336954532038691,
    bv_ucc_other_count = NULL                              => -0.00349548259772158,
                                                              -0.00349548259772158));

bus_tree_140_c1401 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 7313.5 => -0.0015126556031475,
    bx_addr_lot_size >= 7313.5                            => 0.0982156749217327,
    bx_addr_lot_size = NULL                               => 0.048547825270562,
                                                             0.048547825270562));

bus_tree_140_c1400 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 12.5 => 0.00498965283205719,
    bv_ver_src_id_mth_since_ls >= 12.5                                      => bus_tree_140_c1401,
    bv_ver_src_id_mth_since_ls = NULL                                       => 0.00997445832851146,
                                                                               0.00997445832851146));

bus_tree_140 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => bus_tree_140_c1400,
    bx_phn_mobile >= 0.5                         => -0.00963679456141662,
    bx_phn_mobile = NULL                         => -0.00301870488691527,
                                                    -0.00301870488691527));

bus_tree_141_c1404 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 6549504 => 0.00545222299197294,
    bx_addr_assessed_value >= 6549504                                  => 0.0580775666172429,
    bx_addr_assessed_value = NULL                                      => 0.00687803279462804,
                                                                          0.00687803279462804));

bus_tree_141_c1403 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 2.5 => -0.0171892770916447,
    bx_phn_problems >= 2.5                           => bus_tree_141_c1404,
    bx_phn_problems = NULL                           => -0.002844104130533,
                                                        -0.002844104130533));

bus_tree_141 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 394 => bus_tree_141_c1403,
    bv_mth_ver_src_p_fs >= 394                               => 0.0698906685384702,
    bv_mth_ver_src_p_fs = NULL                               => -0.0016840862141944,
                                                                -0.0016840862141944));

bus_tree_142_c1407 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < -0.5 => 0.0799831796763973,
    bv_mth_ver_src_p_fs >= -0.5                               => -0.0116066334469241,
    bv_mth_ver_src_p_fs = NULL                                => 0.0391948811823178,
                                                                 0.0391948811823178));

bus_tree_142_c1406 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 3.5 => -0.0136169505090907,
    bv_assoc_bus_total >= 3.5                              => bus_tree_142_c1407,
    bv_assoc_bus_total = NULL                              => 0.0127726653885606,
                                                              0.0127726653885606));

bus_tree_142 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 2, 3]) => -0.00520886061712987,
    (bx_fein_contradictory_in in [1, 4])      => bus_tree_142_c1406,
    bx_fein_contradictory_in = NULL               => -0.000801557170693892,
                                                     -0.000801557170693892));

bus_tree_143_c1410 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 111824 => -0.00959394891351784,
    bv_sales >= 111824                    => 0.0414679986217377,
    bv_sales = NULL                       => -0.00818835187647711,
                                             -0.00818835187647711));

bus_tree_143_c1409 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 12.5 => bus_tree_143_c1410,
    bv_ver_src_id_count >= 12.5                               => -0.040805152134182,
    bv_ver_src_id_count = NULL                                => -0.00930224214427404,
                                                                 -0.00930224214427404));

bus_tree_143 :=   __common__( map(
    NULL < bx_tin_match_consumer_associate AND bx_tin_match_consumer_associate < 0.5 => bus_tree_143_c1409,
    bx_tin_match_consumer_associate >= 0.5                                           => 0.000537489136526082,
    bx_tin_match_consumer_associate = NULL                                           => -0.00595880315039696,
                                                                                        -0.00595880315039696));

bus_tree_144_c1413 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 0.5 => 0.00348101984085343,
    bv_ucc_other_count >= 0.5                              => -0.0633217629567542,
    bv_ucc_other_count = NULL                              => 0.00214987116433629,
                                                              0.00214987116433629));

bus_tree_144_c1412 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 57 => bus_tree_144_c1413,
    bv_empl_ct_max >= 57                          => 0.0331838850533002,
    bv_empl_ct_max = NULL                         => 0.0026884327199614,
                                                     0.0026884327199614));

bus_tree_144 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 106.5 => bus_tree_144_c1412,
    bv_ver_src_derog_ratio >= 106.5                                  => 0.0585227882084554,
    bv_ver_src_derog_ratio = NULL                                    => 0.00356203147930518,
                                                                        0.00356203147930518));

bus_tree_145_c1416 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 13.5 => 0.00146380315533555,
    bv_ver_src_id_count >= 13.5                               => -0.0462884697413867,
    bv_ver_src_id_count = NULL                                => 0.000498169279613265,
                                                                 0.000498169279613265));

bus_tree_145_c1415 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 667 => bus_tree_145_c1416,
    bv_ver_src_id_mth_since_fs >= 667                                      => -0.0691110887078375,
    bv_ver_src_id_mth_since_fs = NULL                                      => -0.000635253354283783,
                                                                              -0.000635253354283783));

bus_tree_145 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 1.5 => bus_tree_145_c1415,
    bv_ucc_other_count >= 1.5                              => 0.0366993805063623,
    bv_ucc_other_count = NULL                              => -4.26401184005122e-05,
                                                              -4.26401184005122e-05));

bus_tree_146_c1419 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 141.5 => -0.00565971069566123,
    bv_sos_mth_ls >= 141.5                         => 0.0211692769676633,
    bv_sos_mth_ls = NULL                           => -0.00172676049397878,
                                                      -0.00172676049397878));

bus_tree_146_c1418 :=   __common__( map(
    (bx_fein_contradictory_in in [2, 3])      => -0.027521367721764,
    (bx_fein_contradictory_in in [0, 1, 4]) => bus_tree_146_c1419,
    bx_fein_contradictory_in = NULL               => -0.00392739974187065,
                                                     -0.00392739974187065));

bus_tree_146 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 30.5 => bus_tree_146_c1418,
    bx_phn_distance_addr >= 30.5                                => 0.0467511198206359,
    bx_phn_distance_addr = NULL                                 => -0.00299610642163931,
                                                                   -0.00299610642163931));

bus_tree_147_c1422 :=   __common__( map(
    NULL < bv_ucc_mth_fs AND bv_ucc_mth_fs < 142.5 => 0.0809033349483133,
    bv_ucc_mth_fs >= 142.5                         => -0.0116782557585169,
    bv_ucc_mth_fs = NULL                           => 0.0290639853573313,
                                                      0.0290639853573313));

bus_tree_147_c1421 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 172112 => -0.00186076916568913,
    bv_sales >= 172112                    => bus_tree_147_c1422,
    bv_sales = NULL                       => -0.000473454936049865,
                                             -0.000473454936049865));

bus_tree_147 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 233.5 => bus_tree_147_c1421,
    bv_mth_ver_src_br_fs >= 233.5                                => -0.0705643950895583,
    bv_mth_ver_src_br_fs = NULL                                  => -0.00159660529980979,
                                                                    -0.00159660529980979));

bus_tree_148_c1424 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 2.5 => -0.0219524313857019,
    bx_assoc_county_match_ct >= 2.5                                    => 0.0320953375187307,
    bx_assoc_county_match_ct = NULL                                    => -0.0149760954496126,
                                                                          -0.0149760954496126));

bus_tree_148_c1425 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 6.5 => 0.00714804146778172,
    bx_inq_consumer_phn_cnt >= 6.5                                   => 0.0360434251706456,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.0078499414263688,
                                                                        0.0078499414263688));

bus_tree_148 :=   __common__( map(
    (bv_ucc_index in [0, 2, 4]) => bus_tree_148_c1424,
    (bv_ucc_index in [1, 3])      => bus_tree_148_c1425,
    bv_ucc_index = NULL               => 0.0016612041418529,
                                         0.0016612041418529));

bus_tree_149_c1428 :=   __common__( map(
    NULL < bx_name_src_count AND bx_name_src_count < 2.5 => -0.0188666839799483,
    bx_name_src_count >= 2.5                             => 0.0867781277458372,
    bx_name_src_count = NULL                             => 0.0305478247304997,
                                                            0.0305478247304997));

bus_tree_149_c1427 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2, 3]) => -0.00354488331118171,
    (bx_fein_contradictory_in in [4])                => bus_tree_149_c1428,
    bx_fein_contradictory_in = NULL                    => -0.00240407873985636,
                                                          -0.00240407873985636));

bus_tree_149 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 42.5 => bus_tree_149_c1427,
    bx_phn_distance_addr >= 42.5                                => 0.0548759943468708,
    bx_phn_distance_addr = NULL                                 => -0.00153455201368213,
                                                                   -0.00153455201368213));

bus_tree_150_c1431 :=   __common__( map(
    NULL < bx_tin_match_consumer_associate AND bx_tin_match_consumer_associate < 0.5 => 0.0121811118806704,
    bx_tin_match_consumer_associate >= 0.5                                           => 0.0652862539381876,
    bx_tin_match_consumer_associate = NULL                                           => 0.0171685144525339,
                                                                                        0.0171685144525339));

bus_tree_150_c1430 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 1.5 => bus_tree_150_c1431,
    bv_ucc_count >= 1.5                        => -0.0366029453431861,
    bv_ucc_count = NULL                        => 0.0103699385472253,
                                                  0.0103699385472253));

bus_tree_150 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 0.5 => bus_tree_150_c1430,
    bx_assoc_county_match_ct >= 0.5                                    => -0.0120852121368528,
    bx_assoc_county_match_ct = NULL                                    => -0.00291644993009617,
                                                                          -0.00291644993009617));

bus_tree_151_c1434 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 37.5 => 0.00232974604964227,
    bv_mth_bureau_ls >= 37.5                            => 0.0395665043427153,
    bv_mth_bureau_ls = NULL                             => 0.00410680293608041,
                                                           0.00410680293608041));

bus_tree_151_c1433 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 31.5 => bus_tree_151_c1434,
    bv_empl_ct_min >= 31.5                          => -0.052601324097819,
    bv_empl_ct_min = NULL                           => 0.00320881891202143,
                                                       0.00320881891202143));

bus_tree_151 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 31.5 => bus_tree_151_c1433,
    bv_ucc_count >= 31.5                        => 0.0558888884230626,
    bv_ucc_count = NULL                         => 0.00408881100287103,
                                                   0.00408881100287103));

bus_tree_152_c1437 :=   __common__( map(
    NULL < bx_phn_verification AND bx_phn_verification < 1.5 => -0.0585516088899651,
    bx_phn_verification >= 1.5                               => -0.0697554907150939,
    bx_phn_verification = NULL                               => -0.0650425767542366,
                                                                -0.0650425767542366));

bus_tree_152_c1436 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 71.5 => 0.0177924492220573,
    bv_mth_ver_src_br_fs >= 71.5                                => bus_tree_152_c1437,
    bv_mth_ver_src_br_fs = NULL                                 => -0.0330711632195267,
                                                                   -0.0330711632195267));

bus_tree_152 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 7.5 => 0.00983136925631793,
    bv_ucc_count >= 7.5                        => bus_tree_152_c1436,
    bv_ucc_count = NULL                        => 0.00705875661332117,
                                                  0.00705875661332117));

bus_tree_153_c1439 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 34148 => 0.004453681588052,
    bx_addr_bldg_size >= 34148                             => 0.0458240728270985,
    bx_addr_bldg_size = NULL                               => 0.0063092969384444,
                                                              0.0063092969384444));

bus_tree_153_c1440 :=   __common__( map(
    NULL < bv_ucc_mth_fs AND bv_ucc_mth_fs < 41.5 => 0.00310421555125752,
    bv_ucc_mth_fs >= 41.5                         => -0.0400546071021894,
    bv_ucc_mth_fs = NULL                          => -0.00461649216841149,
                                                     -0.00461649216841149));

bus_tree_153 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => bus_tree_153_c1439,
    bx_consumer_addr >= 0.5                            => bus_tree_153_c1440,
    bx_consumer_addr = NULL                            => 0.00094679438202795,
                                                          0.00094679438202795));

bus_tree_154_c1443 :=   __common__( map(
    NULL < bx_assoc_city_match_ct AND bx_assoc_city_match_ct < 2.5 => 0.0157490253925218,
    bx_assoc_city_match_ct >= 2.5                                  => -0.0278579498537432,
    bx_assoc_city_match_ct = NULL                                  => 0.0123748463242863,
                                                                      0.0123748463242863));

bus_tree_154_c1442 :=   __common__( map(
    (bx_fein_contradictory_id in [0, 1]) => bus_tree_154_c1443,
    (bx_fein_contradictory_id in [2])      => 0.0583960443622281,
    bx_fein_contradictory_id = NULL          => 0.0140680310934068,
                                                0.0140680310934068));

bus_tree_154 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 28.5 => -0.0121837787952242,
    bv_mth_ver_src_c_fs >= 28.5                               => bus_tree_154_c1442,
    bv_mth_ver_src_c_fs = NULL                                => 0.000396453607944408,
                                                                 0.000396453607944408));

bus_tree_155_c1445 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 343.5 => 0.000259512906925183,
    bv_mth_ver_src_c_fs >= 343.5                               => -0.0407668073845975,
    bv_mth_ver_src_c_fs = NULL                                 => -0.00159824524010398,
                                                                  -0.00159824524010398));

bus_tree_155_c1446 :=   __common__( map(
    NULL < bv_ucc_mth_ls AND bv_ucc_mth_ls < 28.5 => -0.0615228540343852,
    bv_ucc_mth_ls >= 28.5                         => 0.0222237733827741,
    bv_ucc_mth_ls = NULL                          => -0.0377232773962151,
                                                     -0.0377232773962151));

bus_tree_155 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 180.5 => bus_tree_155_c1445,
    bv_mth_ver_src_br_fs >= 180.5                                => bus_tree_155_c1446,
    bv_mth_ver_src_br_fs = NULL                                  => -0.00389462861450227,
                                                                    -0.00389462861450227));

bus_tree_156_c1448 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 23.5 => -0.011613551627021,
    bv_empl_ct_min >= 23.5                          => 0.0280322511363421,
    bv_empl_ct_min = NULL                           => -0.01059972894532,
                                                       -0.01059972894532));

bus_tree_156_c1449 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 156 => 0.0931620149145447,
    bv_mth_ver_src_c_fs >= 156                               => -0.00698154295256544,
    bv_mth_ver_src_c_fs = NULL                               => 0.0264553711933812,
                                                                0.0264553711933812));

bus_tree_156 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 193.5 => bus_tree_156_c1448,
    bv_mth_ver_src_br_fs >= 193.5                                => bus_tree_156_c1449,
    bv_mth_ver_src_br_fs = NULL                                  => -0.00892202637668186,
                                                                    -0.00892202637668186));

bus_tree_157_c1452 :=   __common__( map(
    NULL < bv_inq_other_count12 AND bv_inq_other_count12 < 2.5 => -0.00669133139596657,
    bv_inq_other_count12 >= 2.5                                => 0.0231041179137184,
    bv_inq_other_count12 = NULL                                => -0.00454579841693427,
                                                                  -0.00454579841693427));

bus_tree_157_c1451 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 52012 => bus_tree_157_c1452,
    bx_addr_bldg_size >= 52012                             => -0.0537314508254115,
    bx_addr_bldg_size = NULL                               => -0.00532460275176488,
                                                              -0.00532460275176488));

bus_tree_157 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 126904 => bus_tree_157_c1451,
    bx_addr_bldg_size >= 126904                             => 0.0418864962698136,
    bx_addr_bldg_size = NULL                                => -0.00453953534551037,
                                                               -0.00453953534551037));

bus_tree_158_c1455 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 33.5 => -0.00566298657673995,
    bv_mth_ver_src_c_ls >= 33.5                               => 0.0199526643289905,
    bv_mth_ver_src_c_ls = NULL                                => -0.00284326375438259,
                                                                 -0.00284326375438259));

bus_tree_158_c1454 :=   __common__( map(
    NULL < bv_ucc_mth_ls AND bv_ucc_mth_ls < 194.5 => bus_tree_158_c1455,
    bv_ucc_mth_ls >= 194.5                         => 0.0744244383664015,
    bv_ucc_mth_ls = NULL                           => -0.00163697724123031,
                                                      -0.00163697724123031));

bus_tree_158 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 456.5 => bus_tree_158_c1454,
    bv_sos_mth_ls >= 456.5                         => -0.0547923393572986,
    bv_sos_mth_ls = NULL                           => -0.0025490155783692,
                                                      -0.0025490155783692));

bus_tree_159_c1458 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 80736 => 0.00103338975240322,
    bx_addr_bldg_size >= 80736                             => -0.048092262247443,
    bx_addr_bldg_size = NULL                               => 6.96863451738991e-05,
                                                              6.96863451738991e-05));

bus_tree_159_c1457 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 29.5 => bus_tree_159_c1458,
    bv_empl_ct_min >= 29.5                          => 0.0427070737715243,
    bv_empl_ct_min = NULL                           => 0.00100922658740645,
                                                       0.00100922658740645));

bus_tree_159 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 254.5 => bus_tree_159_c1457,
    bv_mth_bureau_fs >= 254.5                            => -0.0601603851160249,
    bv_mth_bureau_fs = NULL                              => -0.000151285320194557,
                                                            -0.000151285320194557));

bus_tree_160_c1461 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 2764 => -0.0591867793603618,
    bx_addr_bldg_size >= 2764                             => 0.0107024362579881,
    bx_addr_bldg_size = NULL                              => -0.0371768920536874,
                                                             -0.0371768920536874));

bus_tree_160_c1460 :=   __common__( map(
    NULL < bv_inq_other_count12 AND bv_inq_other_count12 < 3.5 => -0.00142867775668814,
    bv_inq_other_count12 >= 3.5                                => bus_tree_160_c1461,
    bv_inq_other_count12 = NULL                                => -0.00326698488532345,
                                                                  -0.00326698488532345));

bus_tree_160 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 415.5 => bus_tree_160_c1460,
    bv_mth_ver_src_p_fs >= 415.5                               => 0.0563245183167162,
    bv_mth_ver_src_p_fs = NULL                                 => -0.00236162644665301,
                                                                  -0.00236162644665301));

bus_tree_161_c1463 :=   __common__( map(
    NULL < bv_sales AND bv_sales < -0.5 => -0.00730222197888426,
    bv_sales >= -0.5                    => -0.0489825952152686,
    bv_sales = NULL                     => -0.0109023137848564,
                                           -0.0109023137848564));

bus_tree_161_c1464 :=   __common__( map(
    (bx_fein_contradictory_in in [1, 2, 3]) => -0.0137518286261211,
    (bx_fein_contradictory_in in [0, 4])      => 0.0133046520216874,
    bx_fein_contradictory_in = NULL               => 0.00476199577743467,
                                                     0.00476199577743467));

bus_tree_161 :=   __common__( map(
    (bx_phn_contradictory in [0])                => bus_tree_161_c1463,
    (bx_phn_contradictory in [1, 2, 3, 4]) => bus_tree_161_c1464,
    bx_phn_contradictory = NULL                    => 0.00156752797056247,
                                                      0.00156752797056247));

bus_tree_162_c1467 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 13.5 => 0.0453997066521528,
    bv_ver_src_id_count >= 13.5                               => -0.022844988795035,
    bv_ver_src_id_count = NULL                                => 0.0174763451762167,
                                                                 0.0174763451762167));

bus_tree_162_c1466 :=   __common__( map(
    NULL < bx_phn_src_count AND bx_phn_src_count < 5.5 => bus_tree_162_c1467,
    bx_phn_src_count >= 5.5                            => 0.0595313189951838,
    bx_phn_src_count = NULL                            => 0.0318421067070492,
                                                          0.0318421067070492));

bus_tree_162 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 11.5 => -0.00199936084784106,
    bv_ver_src_id_count >= 11.5                               => bus_tree_162_c1466,
    bv_ver_src_id_count = NULL                                => 0.00037695988976235,
                                                                 0.00037695988976235));

bus_tree_163_c1470 :=   __common__( map(
    NULL < bx_phn_not_in_zipcode AND bx_phn_not_in_zipcode < 0.5 => -0.0609139551244575,
    bx_phn_not_in_zipcode >= 0.5                                 => 0.0175388447480032,
    bx_phn_not_in_zipcode = NULL                                 => -0.0264111530863072,
                                                                    -0.0264111530863072));

bus_tree_163_c1469 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 1878784 => 0.00415471533253204,
    bx_addr_assessed_value >= 1878784                                  => bus_tree_163_c1470,
    bx_addr_assessed_value = NULL                                      => 0.00190039456887091,
                                                                          0.00190039456887091));

bus_tree_163 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 34.5 => bus_tree_163_c1469,
    bv_ucc_count >= 34.5                        => 0.0441285161939288,
    bv_ucc_count = NULL                         => 0.0025387637544349,
                                                   0.0025387637544349));

bus_tree_164_c1473 :=   __common__( map(
    NULL < bv_ucc_active_count AND bv_ucc_active_count < 0.5 => 0.102307129158659,
    bv_ucc_active_count >= 0.5                               => 0.0105219683691683,
    bv_ucc_active_count = NULL                               => 0.0469575442072215,
                                                                0.0469575442072215));

bus_tree_164_c1472 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 0.5 => -0.0215317494158633,
    bx_phn_problems >= 0.5                           => bus_tree_164_c1473,
    bx_phn_problems = NULL                           => 0.0311676973310823,
                                                        0.0311676973310823));

bus_tree_164 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 2.5 => -0.00343545471255933,
    bx_fein_src_count >= 2.5                             => bus_tree_164_c1472,
    bx_fein_src_count = NULL                             => -0.000731797193379098,
                                                            -0.000731797193379098));

bus_tree_165_c1475 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 45.5 => -0.000530068027287741,
    bv_empl_ct_min >= 45.5                          => -0.0353561458261318,
    bv_empl_ct_min = NULL                           => -0.00119154756792978,
                                                       -0.00119154756792978));

bus_tree_165_c1476 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 0.5 => 0.0898989874496131,
    bx_inq_consumer_phn_cnt >= 0.5                                   => -0.00571537548987872,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.0431716396475617,
                                                                        0.0431716396475617));

bus_tree_165 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 8.5 => bus_tree_165_c1475,
    bx_inq_consumer_addr_cnt >= 8.5                                    => bus_tree_165_c1476,
    bx_inq_consumer_addr_cnt = NULL                                    => 0.000448180213504482,
                                                                          0.000448180213504482));

bus_tree_166_c1479 :=   __common__( map(
    NULL < bx_name_src_count AND bx_name_src_count < 7.5 => -0.000672313216265204,
    bx_name_src_count >= 7.5                             => 0.0340471084054753,
    bx_name_src_count = NULL                             => 0.002408778695005,
                                                            0.002408778695005));

bus_tree_166_c1478 :=   __common__( map(
    NULL < bv_inq_other_count12 AND bv_inq_other_count12 < 6.5 => bus_tree_166_c1479,
    bv_inq_other_count12 >= 6.5                                => 0.0725457535686137,
    bv_inq_other_count12 = NULL                                => 0.0037333078967548,
                                                                  0.0037333078967548));

bus_tree_166 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 172.5 => bus_tree_166_c1478,
    bv_mth_ver_src_br_fs >= 172.5                                => -0.0265865166936902,
    bv_mth_ver_src_br_fs = NULL                                  => 0.00144614350210143,
                                                                    0.00144614350210143));

bus_tree_167_c1482 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 41 => 0.000991342524001805,
    bv_empl_ct_max >= 41                          => -0.0365938698760255,
    bv_empl_ct_max = NULL                         => 0.000314452442863872,
                                                     0.000314452442863872));

bus_tree_167_c1481 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 7.5 => bus_tree_167_c1482,
    bx_inq_consumer_phn_cnt >= 7.5                                   => 0.0301067047181064,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.000877790133127293,
                                                                        0.000877790133127293));

bus_tree_167 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 27.5 => bus_tree_167_c1481,
    bv_ucc_count >= 27.5                        => 0.0655842479244984,
    bv_ucc_count = NULL                         => 0.00212985764594596,
                                                   0.00212985764594596));

bus_tree_168_c1485 :=   __common__( map(
    NULL < bx_tin_match_consumer_associate AND bx_tin_match_consumer_associate < 0.5 => -0.0661851502118526,
    bx_tin_match_consumer_associate >= 0.5                                           => -0.0463579045570998,
    bx_tin_match_consumer_associate = NULL                                           => -0.0581514640461479,
                                                                                        -0.0581514640461479));

bus_tree_168_c1484 :=   __common__( map(
    NULL < bv_ucc_mth_ls AND bv_ucc_mth_ls < 11.5 => 0.000923208445315614,
    bv_ucc_mth_ls >= 11.5                         => bus_tree_168_c1485,
    bv_ucc_mth_ls = NULL                          => -0.00281575935745529,
                                                     -0.00281575935745529));

bus_tree_168 :=   __common__( map(
    NULL < bv_ucc_mth_ls AND bv_ucc_mth_ls < 25.5 => bus_tree_168_c1484,
    bv_ucc_mth_ls >= 25.5                         => 0.0230062431580727,
    bv_ucc_mth_ls = NULL                          => 0.00037149159551956,
                                                     0.00037149159551956));

bus_tree_169_c1488 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 21.5 => 0.0165322072525091,
    bv_mth_ver_src_br_ls >= 21.5                                => -0.0558564504935776,
    bv_mth_ver_src_br_ls = NULL                                 => -0.0199419746788309,
                                                                   -0.0199419746788309));

bus_tree_169_c1487 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 11.5 => 0.00190520353598892,
    bv_empl_ct_max >= 11.5                          => bus_tree_169_c1488,
    bv_empl_ct_max = NULL                           => 0.000499564675637351,
                                                       0.000499564675637351));

bus_tree_169 :=   __common__( map(
    (bx_fein_contradictory_in in [2, 3])      => -0.0275297382691744,
    (bx_fein_contradictory_in in [0, 1, 4]) => bus_tree_169_c1487,
    bx_fein_contradictory_in = NULL               => -0.0019519654903763,
                                                     -0.0019519654903763));

bus_tree_170_c1490 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 0.15 => 0.0379681491029955,
    bv_ver_src_derog_ratio >= 0.15                                  => -0.0249273650662724,
    bv_ver_src_derog_ratio = NULL                                   => -0.0150085318269467,
                                                                       -0.0150085318269467));

bus_tree_170_c1491 :=   __common__( map(
    (bx_fein_contradictory_id in [2])      => -0.0265731513658062,
    (bx_fein_contradictory_id in [0, 1]) => 0.0104751659448395,
    bx_fein_contradictory_id = NULL          => 0.00915234563208244,
                                                0.00915234563208244));

bus_tree_170 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 2.5 => bus_tree_170_c1490,
    bx_phn_problems >= 2.5                           => bus_tree_170_c1491,
    bx_phn_problems = NULL                           => -0.000445509208898872,
                                                        -0.000445509208898872));

bus_tree_171_c1494 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => 0.0349537517269439,
    bx_phn_mobile >= 0.5                         => -0.00623036746863888,
    bx_phn_mobile = NULL                         => 0.00272270192170521,
                                                    0.00272270192170521));

bus_tree_171_c1493 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 2, 3, 4]) => bus_tree_171_c1494,
    (bx_fein_contradictory_in in [1])                => 0.104039188579197,
    bx_fein_contradictory_in = NULL                    => 0.00878255474382174,
                                                          0.00878255474382174));

bus_tree_171 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 2.5 => -0.00763823308146796,
    bv_ver_src_id_mth_since_ls >= 2.5                                      => bus_tree_171_c1493,
    bv_ver_src_id_mth_since_ls = NULL                                      => -0.00290437935768452,
                                                                              -0.00290437935768452));

bus_tree_172_c1497 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 2.5 => 0.0029867255666911,
    bv_empl_ct_min >= 2.5                          => 0.052161674609082,
    bv_empl_ct_min = NULL                          => 0.00639155920317848,
                                                      0.00639155920317848));

bus_tree_172_c1496 :=   __common__( map(
    NULL < bx_phn_not_in_zipcode AND bx_phn_not_in_zipcode < 0.5 => -0.0172166583352831,
    bx_phn_not_in_zipcode >= 0.5                                 => bus_tree_172_c1497,
    bx_phn_not_in_zipcode = NULL                                 => -0.00367648773639148,
                                                                    -0.00367648773639148));

bus_tree_172 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2, 3]) => bus_tree_172_c1496,
    (bx_fein_contradictory_in in [4])                => 0.0188493026310748,
    bx_fein_contradictory_in = NULL                    => -0.00297942726425002,
                                                          -0.00297942726425002));

bus_tree_173_c1499 :=   __common__( map(
    (bx_fein_contradictory_id in [0, 1]) => -0.00155057228828686,
    (bx_fein_contradictory_id in [2])      => 0.0183768521702393,
    bx_fein_contradictory_id = NULL          => -0.00074266099835455,
                                                -0.00074266099835455));

bus_tree_173_c1500 :=   __common__( map(
    NULL < bx_assoc_city_match_ct AND bx_assoc_city_match_ct < 0.5 => -0.0693477539794029,
    bx_assoc_city_match_ct >= 0.5                                  => -0.0184687888119295,
    bx_assoc_city_match_ct = NULL                                  => -0.0353465131670012,
                                                                      -0.0353465131670012));

bus_tree_173 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 954176 => bus_tree_173_c1499,
    bv_sales >= 954176                    => bus_tree_173_c1500,
    bv_sales = NULL                       => -0.00236692344708695,
                                             -0.00236692344708695));

bus_tree_174_c1503 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 181.5 => -0.0220264676226594,
    bv_sos_mth_fs >= 181.5                         => -0.0866820192242891,
    bv_sos_mth_fs = NULL                           => -0.0318703519601113,
                                                      -0.0318703519601113));

bus_tree_174_c1502 :=   __common__( map(
    NULL < bx_phn_verification AND bx_phn_verification < 1.5 => bus_tree_174_c1503,
    bx_phn_verification >= 1.5                               => -0.000212048314826535,
    bx_phn_verification = NULL                               => -0.0185886702382243,
                                                                -0.0185886702382243));

bus_tree_174 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 6.5 => 0.00523524584295907,
    bv_mth_ver_src_c_ls >= 6.5                               => bus_tree_174_c1502,
    bv_mth_ver_src_c_ls = NULL                               => -3.91494859741181e-05,
                                                                -3.91494859741181e-05));

bus_tree_175_c1506 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 212.5 => 0.0447605156200329,
    bv_mth_ver_src_c_fs >= 212.5                               => -0.0176710694279853,
    bv_mth_ver_src_c_fs = NULL                                 => 0.00800117779498894,
                                                                  0.00800117779498894));

bus_tree_175_c1505 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 31.5 => bus_tree_175_c1506,
    bv_mth_ver_src_c_ls >= 31.5                               => 0.0792686770878381,
    bv_mth_ver_src_c_ls = NULL                                => 0.022200481836606,
                                                                 0.022200481836606));

bus_tree_175 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 341.5 => -0.00513337600470225,
    bv_ver_src_id_mth_since_fs >= 341.5                                      => bus_tree_175_c1505,
    bv_ver_src_id_mth_since_fs = NULL                                        => -0.00241651863045279,
                                                                                -0.00241651863045279));

bus_tree_176_c1509 :=   __common__( map(
    (bx_phn_contradictory in [1, 2, 3, 4]) => 0.0126378622286159,
    (bx_phn_contradictory in [0])                => 0.0436830201841802,
    bx_phn_contradictory = NULL                    => 0.0175527888646797,
                                                      0.0175527888646797));

bus_tree_176_c1508 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 81.5 => 0.00222374902306775,
    bv_sos_mth_ls >= 81.5                         => bus_tree_176_c1509,
    bv_sos_mth_ls = NULL                          => 0.00629554469911326,
                                                     0.00629554469911326));

bus_tree_176 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 1.5 => bus_tree_176_c1508,
    bx_consumer_addr >= 1.5                            => -0.034886836330714,
    bx_consumer_addr = NULL                            => 0.00344474437816517,
                                                          0.00344474437816517));

bus_tree_177_c1512 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 1147648 => 0.0189001904235332,
    bx_addr_assessed_value >= 1147648                                  => 0.114835351592326,
    bx_addr_assessed_value = NULL                                      => 0.0303921838553483,
                                                                          0.0303921838553483));

bus_tree_177_c1511 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 95.5 => 0.000119673862943737,
    bx_addr_lres >= 95.5                        => bus_tree_177_c1512,
    bx_addr_lres = NULL                         => 0.00526117193863941,
                                                   0.00526117193863941));

bus_tree_177 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 1.5 => bus_tree_177_c1511,
    bx_consumer_addr >= 1.5                            => -0.0483909800775175,
    bx_consumer_addr = NULL                            => 0.00149382954525308,
                                                          0.00149382954525308));

bus_tree_178_c1514 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 15.5 => -0.00557950312706789,
    bv_sos_mth_fs >= 15.5                         => -0.0849382510734422,
    bv_sos_mth_fs = NULL                          => -0.0118921308046204,
                                                     -0.0118921308046204));

bus_tree_178_c1515 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 0.5 => 0.0250334699213611,
    bx_assoc_county_match_ct >= 0.5                                    => 0.00241209263816608,
    bx_assoc_county_match_ct = NULL                                    => 0.00935729683208713,
                                                                          0.00935729683208713));

bus_tree_178 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 3.5 => bus_tree_178_c1514,
    bv_mth_ver_src_c_fs >= 3.5                               => bus_tree_178_c1515,
    bv_mth_ver_src_c_fs = NULL                               => 0.00243155745419727,
                                                                0.00243155745419727));

bus_tree_179_c1518 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 1597440 => 0.000551780562382137,
    bx_addr_assessed_value >= 1597440                                  => -0.0252153293257093,
    bx_addr_assessed_value = NULL                                      => -0.00130646361833093,
                                                                          -0.00130646361833093));

bus_tree_179_c1517 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 35.5 => bus_tree_179_c1518,
    bv_empl_ct_max >= 35.5                          => 0.041308547690537,
    bv_empl_ct_max = NULL                           => -0.000416590992391698,
                                                       -0.000416590992391698));

bus_tree_179 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 11.5 => bus_tree_179_c1517,
    bx_addr_src_count >= 11.5                             => -0.0466976946815337,
    bx_addr_src_count = NULL                              => -0.00146604912593233,
                                                             -0.00146604912593233));

bus_tree_180_c1521 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 0.35 => 0.0926964484387768,
    bv_ver_src_derog_ratio >= 0.35                                  => 0.00288193199628647,
    bv_ver_src_derog_ratio = NULL                                   => 0.0251196608269992,
                                                                       0.0251196608269992));

bus_tree_180_c1520 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 69.5 => -0.00593613108446973,
    bv_mth_ver_src_c_ls >= 69.5                               => bus_tree_180_c1521,
    bv_mth_ver_src_c_ls = NULL                                => -0.0039308211216958,
                                                                 -0.0039308211216958));

bus_tree_180 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 5.5 => bus_tree_180_c1520,
    bx_phn_problems >= 5.5                           => 0.0310307973419352,
    bx_phn_problems = NULL                           => -0.00321325084536129,
                                                        -0.00321325084536129));

bus_tree_181_c1524 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 250.5 => 0.0703826964541286,
    bv_sos_mth_ls >= 250.5                         => -0.0192452187650587,
    bv_sos_mth_ls = NULL                           => 0.00349619255921272,
                                                      0.00349619255921272));

bus_tree_181_c1523 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 0.5 => 0.0813228625421268,
    bx_fein_src_count >= 0.5                             => bus_tree_181_c1524,
    bx_fein_src_count = NULL                             => 0.0262413108992897,
                                                            0.0262413108992897));

bus_tree_181 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 208.5 => -0.00278226758265579,
    bv_sos_mth_ls >= 208.5                         => bus_tree_181_c1523,
    bv_sos_mth_ls = NULL                           => -0.000290144743994405,
                                                      -0.000290144743994405));

bus_tree_182_c1527 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 7.5 => 0.00233597654107715,
    bx_inq_consumer_phn_cnt >= 7.5                                   => -0.0257761390887387,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00182186564511962,
                                                                        0.00182186564511962));

bus_tree_182_c1526 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 505.5 => bus_tree_182_c1527,
    bv_ver_src_id_mth_since_fs >= 505.5                                      => -0.0572760651271753,
    bv_ver_src_id_mth_since_fs = NULL                                        => 0.000583191165208945,
                                                                                0.000583191165208945));

bus_tree_182 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 574.5 => bus_tree_182_c1526,
    bv_mth_ver_src_c_fs >= 574.5                               => 0.0624998842977703,
    bv_mth_ver_src_c_fs = NULL                                 => 0.00154259570732346,
                                                                  0.00154259570732346));

bus_tree_183_c1530 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 36.5 => -0.0647956991551599,
    bv_mth_ver_src_br_ls >= 36.5                                => 0.0364897533088224,
    bv_mth_ver_src_br_ls = NULL                                 => -0.023405009446321,
                                                                   -0.023405009446321));

bus_tree_183_c1529 :=   __common__( map(
    (bx_phn_contradictory in [3, 4])      => bus_tree_183_c1530,
    (bx_phn_contradictory in [0, 1, 2]) => 0.0363441144799849,
    bx_phn_contradictory = NULL               => 0.00746459989438082,
                                                 0.00746459989438082));

bus_tree_183 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2]) => -0.00408421076332623,
    (bx_fein_contradictory_in in [3, 4])      => bus_tree_183_c1529,
    bx_fein_contradictory_in = NULL               => -0.00295396110434326,
                                                     -0.00295396110434326));

bus_tree_184_c1533 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 13447 => 0.0050075597051375,
    bx_addr_bldg_size >= 13447                             => 0.084214791684063,
    bx_addr_bldg_size = NULL                               => 0.00648403151003566,
                                                              0.00648403151003566));

bus_tree_184_c1532 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 21778 => bus_tree_184_c1533,
    bx_addr_bldg_size >= 21778                             => -0.0360395087045423,
    bx_addr_bldg_size = NULL                               => 0.0043565392026716,
                                                              0.0043565392026716));

bus_tree_184 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 47 => bus_tree_184_c1532,
    bv_empl_ct_max >= 47                          => -0.0487662881023398,
    bv_empl_ct_max = NULL                         => 0.00315997060577868,
                                                     0.00315997060577868));

bus_tree_185_c1535 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 3.5 => -0.00313492405887481,
    bx_inq_consumer_phn_cnt >= 3.5                                   => 0.0217334050826484,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00158574294471554,
                                                                        -0.00158574294471554));

bus_tree_185_c1536 :=   __common__( map(
    NULL < bx_phn_verification AND bx_phn_verification < 1.5 => -0.0355348565807967,
    bx_phn_verification >= 1.5                               => -0.0193584892378991,
    bx_phn_verification = NULL                               => -0.0264529458330735,
                                                                -0.0264529458330735));

bus_tree_185 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 319232 => bus_tree_185_c1535,
    bv_sales >= 319232                    => bus_tree_185_c1536,
    bv_sales = NULL                       => -0.00279996917796416,
                                             -0.00279996917796416));

bus_tree_186_c1539 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 1.5 => 0.079096860316143,
    bv_assoc_bus_total >= 1.5                              => 0.00867910147808268,
    bv_assoc_bus_total = NULL                              => 0.0457062798342459,
                                                              0.0457062798342459));

bus_tree_186_c1538 :=   __common__( map(
    (bx_phn_contradictory in [0, 1, 2]) => 0.00358239438111697,
    (bx_phn_contradictory in [3, 4])      => bus_tree_186_c1539,
    bx_phn_contradictory = NULL               => 0.0209707424460713,
                                                 0.0209707424460713));

bus_tree_186 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 1.5 => -0.00256068008785943,
    bx_inq_consumer_phn_cnt >= 1.5                                   => bus_tree_186_c1538,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00113304993800057,
                                                                        0.00113304993800057));

bus_tree_187_c1542 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 30140 => 0.00752822361748776,
    bx_addr_lot_size >= 30140                            => -0.0231195630386002,
    bx_addr_lot_size = NULL                              => -0.000803585161207261,
                                                            -0.000803585161207261));

bus_tree_187_c1541 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 193.5 => bus_tree_187_c1542,
    bv_mth_ver_src_br_fs >= 193.5                                => 0.0404050707411635,
    bv_mth_ver_src_br_fs = NULL                                  => 0.00116028782248355,
                                                                    0.00116028782248355));

bus_tree_187 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 4.5 => bus_tree_187_c1541,
    bx_inq_consumer_phn_cnt >= 4.5                                   => -0.0259470848720139,
    bx_inq_consumer_phn_cnt = NULL                                   => 3.33891400173611e-05,
                                                                        3.33891400173611e-05));

bus_tree_188_c1545 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 122.5 => 0.00164311980685991,
    bv_ver_src_id_mth_since_fs >= 122.5                                      => -0.0307638081498292,
    bv_ver_src_id_mth_since_fs = NULL                                        => -0.00757647196191676,
                                                                                -0.00757647196191676));

bus_tree_188_c1544 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 19.5 => bus_tree_188_c1545,
    bx_phn_distance_addr >= 19.5                                => 0.0469960664298804,
    bx_phn_distance_addr = NULL                                 => -0.00633959792913918,
                                                                   -0.00633959792913918));

bus_tree_188 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 102.5 => bus_tree_188_c1544,
    bv_ver_src_derog_ratio >= 102.5                                  => 0.0226528997311598,
    bv_ver_src_derog_ratio = NULL                                    => -0.000602458180487428,
                                                                        -0.000602458180487428));

bus_tree_189_c1548 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 11286528 => 0.00529476334049595,
    bx_addr_assessed_value >= 11286528                                  => 0.0542270108074067,
    bx_addr_assessed_value = NULL                                       => 0.00627261543678312,
                                                                           0.00627261543678312));

bus_tree_189_c1547 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 0.5 => -0.0229124976423545,
    bx_addr_src_count >= 0.5                             => bus_tree_189_c1548,
    bx_addr_src_count = NULL                             => 0.00240512075497018,
                                                            0.00240512075497018));

bus_tree_189 :=   __common__( map(
    NULL < bv_inq_total_count12 AND bv_inq_total_count12 < 6.5 => bus_tree_189_c1547,
    bv_inq_total_count12 >= 6.5                                => -0.0386041300904378,
    bv_inq_total_count12 = NULL                                => 0.00109084090928213,
                                                                  0.00109084090928213));

bus_tree_190_c1550 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 354.5 => -0.000973696203407984,
    bv_mth_ver_src_c_fs >= 354.5                               => -0.0625152211989591,
    bv_mth_ver_src_c_fs = NULL                                 => -0.00259766167882659,
                                                                  -0.00259766167882659));

bus_tree_190_c1551 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 56.5 => 0.120753491178103,
    bv_mth_bureau_fs >= 56.5                            => -0.00278134216798929,
    bv_mth_bureau_fs = NULL                             => 0.0469308644099152,
                                                           0.0469308644099152));

bus_tree_190 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 492.5 => bus_tree_190_c1550,
    bv_ver_src_id_mth_since_fs >= 492.5                                      => bus_tree_190_c1551,
    bv_ver_src_id_mth_since_fs = NULL                                        => -0.000737066254328887,
                                                                                -0.000737066254328887));

bus_tree_191_c1553 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 3.5 => -0.00173934970970632,
    bx_inq_consumer_phn_cnt >= 3.5                                   => 0.018567976610311,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.000553016575280013,
                                                                        -0.000553016575280013));

bus_tree_191_c1554 :=   __common__( map(
    (bx_fein_contradictory_id in [1, 2]) => -0.0203479294697504,
    (bx_fein_contradictory_id in [0])      => 0.0690828517004628,
    bx_fein_contradictory_id = NULL          => 0.0284963871615252,
                                                0.0284963871615252));

bus_tree_191 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 35856 => bus_tree_191_c1553,
    bx_addr_bldg_size >= 35856                             => bus_tree_191_c1554,
    bx_addr_bldg_size = NULL                               => 0.000566801709358736,
                                                              0.000566801709358736));

bus_tree_192_c1557 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 2.5 => -0.0558557031174135,
    bv_ver_src_id_mth_since_fs >= 2.5                                      => 0.000373276523599682,
    bv_ver_src_id_mth_since_fs = NULL                                      => -0.00247466166651178,
                                                                              -0.00247466166651178));

bus_tree_192_c1556 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 406.5 => bus_tree_192_c1557,
    bv_sos_mth_ls >= 406.5                         => 0.0319649919533644,
    bv_sos_mth_ls = NULL                           => -0.00158260773371203,
                                                      -0.00158260773371203));

bus_tree_192 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 108.5 => bus_tree_192_c1556,
    bv_ver_src_id_mth_since_ls >= 108.5                                      => 0.0813865123889553,
    bv_ver_src_id_mth_since_ls = NULL                                        => 3.53841779771767e-05,
                                                                                3.53841779771767e-05));

bus_tree_193_c1560 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => 0.0163504810485732,
    bx_consumer_addr >= 0.5                            => 0.0820082537236705,
    bx_consumer_addr = NULL                            => 0.0502859590604212,
                                                          0.0502859590604212));

bus_tree_193_c1559 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 289.5 => -0.00206885003481583,
    bv_mth_ver_src_c_fs >= 289.5                               => bus_tree_193_c1560,
    bv_mth_ver_src_c_fs = NULL                                 => 0.000143557539691189,
                                                                  0.000143557539691189));

bus_tree_193 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 306.5 => bus_tree_193_c1559,
    bv_sos_mth_ls >= 306.5                         => -0.0317596690771501,
    bv_sos_mth_ls = NULL                           => -0.00117308355878162,
                                                      -0.00117308355878162));

bus_tree_194_c1563 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 5.5 => 0.0890178665473658,
    bv_ver_src_id_count >= 5.5                               => -0.0181849350442163,
    bv_ver_src_id_count = NULL                               => 0.0398043813865432,
                                                                0.0398043813865432));

bus_tree_194_c1562 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 0.5 => bus_tree_194_c1563,
    bx_assoc_county_match_ct >= 0.5                                    => 0.00411822007829321,
    bx_assoc_county_match_ct = NULL                                    => 0.00907418942627354,
                                                                          0.00907418942627354));

bus_tree_194 :=   __common__( map(
    NULL < bx_tin_match_consumer_associate AND bx_tin_match_consumer_associate < 0.5 => -0.00479372699977541,
    bx_tin_match_consumer_associate >= 0.5                                           => bus_tree_194_c1562,
    bx_tin_match_consumer_associate = NULL                                           => -8.78667057318707e-05,
                                                                                        -8.78667057318707e-05));

bus_tree_195_c1566 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 245.5 => 0.000803206219476401,
    bv_mth_bureau_fs >= 245.5                            => 0.0515054971707614,
    bv_mth_bureau_fs = NULL                              => 0.00213293114657214,
                                                            0.00213293114657214));

bus_tree_195_c1565 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 166.5 => bus_tree_195_c1566,
    bv_mth_ver_src_c_ls >= 166.5                               => -0.0675043875592433,
    bv_mth_ver_src_c_ls = NULL                                 => 0.000875959393693499,
                                                                  0.000875959393693499));

bus_tree_195 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 6.5 => bus_tree_195_c1565,
    bx_inq_consumer_phn_cnt >= 6.5                                   => -0.0307836173865344,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.000128000689754659,
                                                                        0.000128000689754659));

bus_tree_196_c1569 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 11.5 => 0.0572743722585103,
    bv_mth_ver_src_p_fs >= 11.5                               => -0.00386321575654025,
    bv_mth_ver_src_p_fs = NULL                                => 0.0301504601379541,
                                                                 0.0301504601379541));

bus_tree_196_c1568 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 4.5 => -0.00537411581924745,
    bv_mth_bureau_fs >= 4.5                            => bus_tree_196_c1569,
    bv_mth_bureau_fs = NULL                            => -0.00282888230472078,
                                                          -0.00282888230472078));

bus_tree_196 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 216.5 => bus_tree_196_c1568,
    bv_mth_ver_src_c_fs >= 216.5                               => -0.0251086557231094,
    bv_mth_ver_src_c_fs = NULL                                 => -0.00529430847890981,
                                                                  -0.00529430847890981));

bus_tree_197_c1571 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 2, 3, 4]) => -0.00738116064319177,
    (bx_fein_contradictory_in in [1])                => 0.000652048000224806,
    bx_fein_contradictory_in = NULL                    => -0.00587422230734217,
                                                          -0.00587422230734217));

bus_tree_197_c1572 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 175.5 => -0.0109345968115761,
    bv_sos_mth_ls >= 175.5                         => 0.0681898588520933,
    bv_sos_mth_ls = NULL                           => 0.0296147883366,
                                                      0.0296147883366));

bus_tree_197 :=   __common__( map(
    NULL < bx_name_src_count AND bx_name_src_count < 10.5 => bus_tree_197_c1571,
    bx_name_src_count >= 10.5                             => bus_tree_197_c1572,
    bx_name_src_count = NULL                              => -0.00447665809377498,
                                                             -0.00447665809377498));

bus_tree_198_c1575 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 143424 => 0.0483845876847367,
    bx_addr_assessed_value >= 143424                                  => -0.0091000840171335,
    bx_addr_assessed_value = NULL                                     => 0.0185160960697868,
                                                                         0.0185160960697868));

bus_tree_198_c1574 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 18.5 => bus_tree_198_c1575,
    bv_ver_src_id_mth_since_fs >= 18.5                                      => -0.00532174424379717,
    bv_ver_src_id_mth_since_fs = NULL                                       => -0.000136103330921225,
                                                                               -0.000136103330921225));

bus_tree_198 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 74.5 => bus_tree_198_c1574,
    bv_empl_ct_max >= 74.5                          => 0.0424268138827194,
    bv_empl_ct_max = NULL                           => 0.000529847074462269,
                                                       0.000529847074462269));

bus_tree_199_c1578 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 30.5 => -0.00439134200438284,
    bv_mth_bureau_ls >= 30.5                            => 0.0450614431531521,
    bv_mth_bureau_ls = NULL                             => -0.00286369161139761,
                                                           -0.00286369161139761));

bus_tree_199_c1577 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 131.5 => bus_tree_199_c1578,
    bv_mth_bureau_ls >= 131.5                            => -0.0505008308125296,
    bv_mth_bureau_ls = NULL                              => -0.00432309106941754,
                                                            -0.00432309106941754));

bus_tree_199 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 38.5 => bus_tree_199_c1577,
    bv_ucc_count >= 38.5                        => 0.0501811369395795,
    bv_ucc_count = NULL                         => -0.00347442357358584,
                                                   -0.00347442357358584));

bus_tree_200_c1581 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 153 => -0.0142935793020551,
    bv_mth_bureau_fs >= 153                            => -0.0566985589915038,
    bv_mth_bureau_fs = NULL                            => -0.0204300769356179,
                                                          -0.0204300769356179));

bus_tree_200_c1580 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 4]) => bus_tree_200_c1581,
    (bx_fein_contradictory_in in [2, 3])      => 0.01038449879749,
    bx_fein_contradictory_in = NULL               => -0.0164629309580022,
                                                     -0.0164629309580022));

bus_tree_200 :=   __common__( map(
    (bv_ucc_index in [0, 2])      => bus_tree_200_c1580,
    (bv_ucc_index in [1, 3, 4]) => 0.00628723759335484,
    bv_ucc_index = NULL               => 0.00111299290922533,
                                         0.00111299290922533));

bus_tree_201_c1584 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 85.5 => 0.0207925309359919,
    bv_sos_mth_ls >= 85.5                         => 0.119555917348856,
    bv_sos_mth_ls = NULL                          => 0.0482390523833168,
                                                     0.0482390523833168));

bus_tree_201_c1583 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 182.5 => bus_tree_201_c1584,
    bv_mth_ver_src_c_fs >= 182.5                               => -0.0587490320790525,
    bv_mth_ver_src_c_fs = NULL                                 => 0.0206721142989781,
                                                                  0.0206721142989781));

bus_tree_201 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 4]) => -0.000221470751979152,
    (bx_fein_contradictory_in in [2, 3])      => bus_tree_201_c1583,
    bx_fein_contradictory_in = NULL               => 0.00168627999743498,
                                                     0.00168627999743498));

bus_tree_202_c1587 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 166.5 => 0.00301758371510034,
    bv_mth_ver_src_c_ls >= 166.5                               => -0.0677401052110295,
    bv_mth_ver_src_c_ls = NULL                                 => 0.00189877507175924,
                                                                  0.00189877507175924));

bus_tree_202_c1586 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 0.5 => bus_tree_202_c1587,
    bv_ucc_other_count >= 0.5                              => 0.0463929363705828,
    bv_ucc_other_count = NULL                              => 0.00294798833842633,
                                                              0.00294798833842633));

bus_tree_202 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 79.5 => bus_tree_202_c1586,
    bv_empl_ct_max >= 79.5                          => -0.0381669304593381,
    bv_empl_ct_max = NULL                           => 0.00229226287611882,
                                                       0.00229226287611882));

bus_tree_203_c1590 :=   __common__( map(
    NULL < bx_phn_src_count AND bx_phn_src_count < 0.5 => -0.0332180474678128,
    bx_phn_src_count >= 0.5                            => -0.0152977870171177,
    bx_phn_src_count = NULL                            => -0.0212389793812678,
                                                          -0.0212389793812678));

bus_tree_203_c1589 :=   __common__( map(
    NULL < bv_ucc_mth_ls AND bv_ucc_mth_ls < 154.5 => bus_tree_203_c1590,
    bv_ucc_mth_ls >= 154.5                         => 0.0457336908305012,
    bv_ucc_mth_ls = NULL                           => -0.0159839456047503,
                                                      -0.0159839456047503));

bus_tree_203 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 5.5 => 0.00922288865141811,
    bv_ver_src_id_count >= 5.5                               => bus_tree_203_c1589,
    bv_ver_src_id_count = NULL                               => 0.00152556360267131,
                                                                0.00152556360267131));

bus_tree_204_c1593 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 57952 => 0.0457624312668167,
    bx_addr_assessed_value >= 57952                                  => -0.00353672362684097,
    bx_addr_assessed_value = NULL                                    => 0.0162161364147256,
                                                                        0.0162161364147256));

bus_tree_204_c1592 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 2.5 => -0.00440388602109867,
    bx_inq_consumer_phn_cnt >= 2.5                                   => bus_tree_204_c1593,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00249605216955979,
                                                                        -0.00249605216955979));

bus_tree_204 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 205.5 => bus_tree_204_c1592,
    bv_mth_ver_src_br_fs >= 205.5                                => -0.0574962060381102,
    bv_mth_ver_src_br_fs = NULL                                  => -0.00381805133284014,
                                                                    -0.00381805133284014));

bus_tree_205_c1596 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 50.75 => 0.0341417993530814,
    bv_ver_src_derog_ratio >= 50.75                                  => -0.0527693819201117,
    bv_ver_src_derog_ratio = NULL                                    => -0.0137383605119686,
                                                                        -0.0137383605119686));

bus_tree_205_c1595 :=   __common__( map(
    (bx_fein_contradictory_id in [1, 2]) => bus_tree_205_c1596,
    (bx_fein_contradictory_id in [0])      => 0.0944727359810907,
    bx_fein_contradictory_id = NULL          => 0.0170785837428818,
                                                0.0170785837428818));

bus_tree_205 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 412.5 => -0.00400077582581015,
    bv_ver_src_id_mth_since_fs >= 412.5                                      => bus_tree_205_c1595,
    bv_ver_src_id_mth_since_fs = NULL                                        => -0.0027707481926257,
                                                                                -0.0027707481926257));

bus_tree_206_c1599 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 423.5 => 0.080125735031217,
    bv_ver_src_id_mth_since_fs >= 423.5                                      => -0.0190873511733423,
    bv_ver_src_id_mth_since_fs = NULL                                        => 0.0401225947992051,
                                                                                0.0401225947992051));

bus_tree_206_c1598 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 203.5 => -0.0327731230154816,
    bv_ver_src_id_mth_since_fs >= 203.5                                      => bus_tree_206_c1599,
    bv_ver_src_id_mth_since_fs = NULL                                        => 0.021500130108972,
                                                                                0.021500130108972));

bus_tree_206 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 2.5 => 0.00211543123859243,
    bx_fein_src_count >= 2.5                             => bus_tree_206_c1598,
    bx_fein_src_count = NULL                             => 0.00359088005932345,
                                                            0.00359088005932345));

bus_tree_207_c1601 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 2.5 => -0.00134251012714457,
    bx_fein_src_count >= 2.5                             => 0.0196151872696695,
    bx_fein_src_count = NULL                             => 0.000310901217388141,
                                                            0.000310901217388141));

bus_tree_207_c1602 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 124968 => 0.0268797727747185,
    bx_addr_lot_size >= 124968                            => -0.0495591382270565,
    bx_addr_lot_size = NULL                               => 0.0186819765223542,
                                                             0.0186819765223542));

bus_tree_207 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 1.5 => bus_tree_207_c1601,
    bx_inq_consumer_phn_cnt >= 1.5                                   => bus_tree_207_c1602,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00319991784591353,
                                                                        0.00319991784591353));

bus_tree_208_c1604 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 0.5 => -0.0343134279777501,
    bx_addr_src_count >= 0.5                             => -0.0034856742419333,
    bx_addr_src_count = NULL                             => -0.00763103415042894,
                                                            -0.00763103415042894));

bus_tree_208_c1605 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 16.5 => 0.0129702306962183,
    bv_mth_ver_src_c_ls >= 16.5                               => 0.0750158239691545,
    bv_mth_ver_src_c_ls = NULL                                => 0.0233980614983925,
                                                                 0.0233980614983925));

bus_tree_208 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 1452416 => bus_tree_208_c1604,
    bx_addr_assessed_value >= 1452416                                  => bus_tree_208_c1605,
    bx_addr_assessed_value = NULL                                      => -0.00484005729312754,
                                                                          -0.00484005729312754));

bus_tree_209_c1608 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 10.5 => -0.0218400960506661,
    bv_empl_ct_max >= 10.5                          => -0.0830077470583275,
    bv_empl_ct_max = NULL                           => -0.0326284005545132,
                                                       -0.0326284005545132));

bus_tree_209_c1607 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 0.5 => 0.0219636584311786,
    bx_inq_consumer_phn_cnt >= 0.5                                   => bus_tree_209_c1608,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00707040947502754,
                                                                        0.00707040947502754));

bus_tree_209 :=   __common__( map(
    (bx_fein_contradictory_id in [0])      => -0.00892963686310933,
    (bx_fein_contradictory_id in [1, 2]) => bus_tree_209_c1607,
    bx_fein_contradictory_id = NULL          => -0.0035724892954999,
                                                -0.0035724892954999));

bus_tree_210_c1611 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 346688 => -0.00754079383751226,
    bx_addr_assessed_value >= 346688                                  => 0.119711412822321,
    bx_addr_assessed_value = NULL                                     => 0.0443214375049643,
                                                                         0.0443214375049643));

bus_tree_210_c1610 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 195.5 => -0.00834869356208692,
    bv_mth_ver_src_p_fs >= 195.5                               => bus_tree_210_c1611,
    bv_mth_ver_src_p_fs = NULL                                 => -0.00567882800462177,
                                                                  -0.00567882800462177));

bus_tree_210 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 2, 3]) => bus_tree_210_c1610,
    (bx_fein_contradictory_in in [1, 4])      => 0.00627851943219352,
    bx_fein_contradictory_in = NULL               => -0.00269740602476374,
                                                     -0.00269740602476374));

bus_tree_211_c1614 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 663424 => 0.0126287747232141,
    bx_addr_assessed_value >= 663424                                  => 0.0467564116041654,
    bx_addr_assessed_value = NULL                                     => 0.0181275366153407,
                                                                         0.0181275366153407));

bus_tree_211_c1613 :=   __common__( map(
    (bx_phn_contradictory in [2])                => -0.0249006537132056,
    (bx_phn_contradictory in [0, 1, 3, 4]) => bus_tree_211_c1614,
    bx_phn_contradictory = NULL                    => 0.00771399139296985,
                                                      0.00771399139296985));

bus_tree_211 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 0.5 => bus_tree_211_c1613,
    bx_assoc_county_match_ct >= 0.5                                    => -0.0137499135008188,
    bx_assoc_county_match_ct = NULL                                    => -0.00501347148622683,
                                                                          -0.00501347148622683));

bus_tree_212_c1617 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 137424 => 0.0109495844429646,
    bx_addr_assessed_value >= 137424                                  => -0.0133172842991611,
    bx_addr_assessed_value = NULL                                     => -0.00247160770774811,
                                                                         -0.00247160770774811));

bus_tree_212_c1616 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 26.5 => bus_tree_212_c1617,
    bv_ucc_count >= 26.5                        => 0.0509394960157644,
    bv_ucc_count = NULL                         => -0.00155065572298429,
                                                   -0.00155065572298429));

bus_tree_212 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 444.5 => bus_tree_212_c1616,
    bv_sos_mth_ls >= 444.5                         => 0.0529133283579638,
    bv_sos_mth_ls = NULL                           => -0.000566763644726794,
                                                      -0.000566763644726794));

bus_tree_213_c1620 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 393088 => -0.0138345638003965,
    bx_addr_assessed_value >= 393088                                  => -0.0719276231938863,
    bx_addr_assessed_value = NULL                                     => -0.0167133200091969,
                                                                         -0.0167133200091969));

bus_tree_213_c1619 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 449 => bus_tree_213_c1620,
    bv_ver_src_id_mth_since_fs >= 449                                      => 0.0785644084059051,
    bv_ver_src_id_mth_since_fs = NULL                                      => -0.0128832501306196,
                                                                              -0.0128832501306196));

bus_tree_213 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 2052.5 => bus_tree_213_c1619,
    bx_addr_lot_size >= 2052.5                            => 0.00864790301371796,
    bx_addr_lot_size = NULL                               => 0.000469970696991098,
                                                             0.000469970696991098));

bus_tree_214_c1623 :=   __common__( map(
    NULL < bv_sales AND bv_sales < -0.5 => -0.00244797033907904,
    bv_sales >= -0.5                    => 0.0505294066093983,
    bv_sales = NULL                     => 0.000908197459052248,
                                           0.000908197459052248));

bus_tree_214_c1622 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 111.5 => bus_tree_214_c1623,
    bv_mth_ver_src_p_fs >= 111.5                               => -0.0344417386370534,
    bv_mth_ver_src_p_fs = NULL                                 => -0.00326630129597065,
                                                                  -0.00326630129597065));

bus_tree_214 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 58.5 => bus_tree_214_c1622,
    bv_mth_ver_src_br_ls >= 58.5                                => 0.0232388503121264,
    bv_mth_ver_src_br_ls = NULL                                 => 0.0030504593253695,
                                                                   0.0030504593253695));

bus_tree_215_c1626 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 421.5 => -0.00191326211102733,
    bx_addr_lot_size >= 421.5                            => 0.0860645426425552,
    bx_addr_lot_size = NULL                              => 0.0430342362013357,
                                                            0.0430342362013357));

bus_tree_215_c1625 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 15.5 => bus_tree_215_c1626,
    bx_addr_lres >= 15.5                        => -0.0157442671437645,
    bx_addr_lres = NULL                         => 0.0193359667890771,
                                                   0.0193359667890771));

bus_tree_215 :=   __common__( map(
    NULL < bv_inq_total_count12 AND bv_inq_total_count12 < 4.5 => -0.00251165616821799,
    bv_inq_total_count12 >= 4.5                                => bus_tree_215_c1625,
    bv_inq_total_count12 = NULL                                => -0.00136890824029296,
                                                                  -0.00136890824029296));

bus_tree_216_c1629 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => 0.045785110808746,
    bx_phn_mobile >= 0.5                         => 0.00314947981386771,
    bx_phn_mobile = NULL                         => 0.0200473224289358,
                                                    0.0200473224289358));

bus_tree_216_c1628 :=   __common__( map(
    NULL < bv_ucc_active_count AND bv_ucc_active_count < 3.5 => bus_tree_216_c1629,
    bv_ucc_active_count >= 3.5                               => -0.0311191409797459,
    bv_ucc_active_count = NULL                               => 0.00925881638750635,
                                                                0.00925881638750635));

bus_tree_216 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 0.5 => -0.00609053229214528,
    bx_fein_src_count >= 0.5                             => bus_tree_216_c1628,
    bx_fein_src_count = NULL                             => -0.00157581311084403,
                                                            -0.00157581311084403));

bus_tree_217_c1632 :=   __common__( map(
    NULL < bv_inq_total_count12 AND bv_inq_total_count12 < 2.5 => 0.002677000334676,
    bv_inq_total_count12 >= 2.5                                => -0.0257399859681789,
    bv_inq_total_count12 = NULL                                => -0.000107366380473914,
                                                                  -0.000107366380473914));

bus_tree_217_c1631 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 35992 => bus_tree_217_c1632,
    bx_addr_bldg_size >= 35992                             => 0.034665706842366,
    bx_addr_bldg_size = NULL                               => 0.00129803974129763,
                                                              0.00129803974129763));

bus_tree_217 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 158.5 => bus_tree_217_c1631,
    bv_mth_ver_src_c_ls >= 158.5                               => -0.0739067103121874,
    bv_mth_ver_src_c_ls = NULL                                 => -0.000208329023946021,
                                                                  -0.000208329023946021));

bus_tree_218_c1635 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 8.5 => -0.0220853620101338,
    bx_addr_lres >= 8.5                        => 0.0208825389569552,
    bx_addr_lres = NULL                        => -0.000225893736624823,
                                                  -0.000225893736624823));

bus_tree_218_c1634 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => 0.0115118333756045,
    bx_consumer_addr >= 0.5                            => bus_tree_218_c1635,
    bx_consumer_addr = NULL                            => 0.00591078466939192,
                                                          0.00591078466939192));

bus_tree_218 :=   __common__( map(
    NULL < bx_name_src_count AND bx_name_src_count < 0.5 => -0.0400272577131286,
    bx_name_src_count >= 0.5                             => bus_tree_218_c1634,
    bx_name_src_count = NULL                             => 0.00329964272897956,
                                                            0.00329964272897956));

bus_tree_219_c1638 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 10.5 => -0.0188921556100738,
    bv_mth_ver_src_br_ls >= 10.5                                => 0.0647750164440289,
    bv_mth_ver_src_br_ls = NULL                                 => 0.023349562963583,
                                                                   0.023349562963583));

bus_tree_219_c1637 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2, 3]) => -0.00398799475777662,
    (bx_fein_contradictory_in in [4])                => bus_tree_219_c1638,
    bx_fein_contradictory_in = NULL                    => -0.00312494719746574,
                                                          -0.00312494719746574));

bus_tree_219 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 669 => bus_tree_219_c1637,
    bv_ver_src_id_mth_since_fs >= 669                                      => -0.0577185177699979,
    bv_ver_src_id_mth_since_fs = NULL                                      => -0.00409467426356892,
                                                                              -0.00409467426356892));

bus_tree_220_c1641 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 0.5 => 0.00318740225300294,
    bx_fein_src_count >= 0.5                             => 0.114976028846239,
    bx_fein_src_count = NULL                             => 0.0384519532287871,
                                                            0.0384519532287871));

bus_tree_220_c1640 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 609152 => -0.000521483988528615,
    bx_addr_lot_size >= 609152                            => bus_tree_220_c1641,
    bx_addr_lot_size = NULL                               => 0.00137863591271548,
                                                             0.00137863591271548));

bus_tree_220 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 480.5 => bus_tree_220_c1640,
    bv_sos_mth_fs >= 480.5                         => -0.0569740426621263,
    bv_sos_mth_fs = NULL                           => 0.000381832786644864,
                                                      0.000381832786644864));

bus_tree_221_c1644 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 11.5 => 0.0857705363636659,
    bv_sos_mth_fs >= 11.5                         => 0.000948593594804572,
    bv_sos_mth_fs = NULL                          => 0.0473640343803403,
                                                     0.0473640343803403));

bus_tree_221_c1643 :=   __common__( map(
    NULL < bx_inq_consumer_addr_cnt AND bx_inq_consumer_addr_cnt < 8.5 => -0.0010152720343651,
    bx_inq_consumer_addr_cnt >= 8.5                                    => bus_tree_221_c1644,
    bx_inq_consumer_addr_cnt = NULL                                    => 0.000737274357834272,
                                                                          0.000737274357834272));

bus_tree_221 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 4.5 => bus_tree_221_c1643,
    bx_phn_problems >= 4.5                           => -0.0390267751190246,
    bx_phn_problems = NULL                           => -0.000148251711689149,
                                                        -0.000148251711689149));

bus_tree_222_c1647 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 196.5 => 0.00637493811264793,
    bv_mth_ver_src_p_fs >= 196.5                               => 0.0803418267582836,
    bv_mth_ver_src_p_fs = NULL                                 => 0.0340958621456069,
                                                                  0.0340958621456069));

bus_tree_222_c1646 :=   __common__( map(
    NULL < bv_mth_ver_src_br_fs AND bv_mth_ver_src_br_fs < 193.5 => -0.00257249829352736,
    bv_mth_ver_src_br_fs >= 193.5                                => bus_tree_222_c1647,
    bv_mth_ver_src_br_fs = NULL                                  => -0.000967914201142318,
                                                                    -0.000967914201142318));

bus_tree_222 :=   __common__( map(
    (bx_fein_contradictory_id in [2])      => -0.0312327974630161,
    (bx_fein_contradictory_id in [0, 1]) => bus_tree_222_c1646,
    bx_fein_contradictory_id = NULL          => -0.00219728200081147,
                                                -0.00219728200081147));

bus_tree_223_c1650 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 42.5 => 0.0359769561257088,
    bv_ver_src_id_mth_since_ls >= 42.5                                      => -0.0532589463132028,
    bv_ver_src_id_mth_since_ls = NULL                                       => 0.0265288320996831,
                                                                               0.0265288320996831));

bus_tree_223_c1649 :=   __common__( map(
    NULL < bv_ucc_mth_ls AND bv_ucc_mth_ls < 12.5 => bus_tree_223_c1650,
    bv_ucc_mth_ls >= 12.5                         => -0.020030752945152,
    bv_ucc_mth_ls = NULL                          => 0.0151490273135524,
                                                     0.0151490273135524));

bus_tree_223 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 0.6 => bus_tree_223_c1649,
    bv_ver_src_derog_ratio >= 0.6                                  => -0.00766689559846777,
    bv_ver_src_derog_ratio = NULL                                  => -0.00141536721176534,
                                                                      -0.00141536721176534));

bus_tree_224_c1653 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 16.5 => -0.0190809327223874,
    bv_mth_ver_src_br_ls >= 16.5                                => -0.0918095353587642,
    bv_mth_ver_src_br_ls = NULL                                 => -0.0544719802340063,
                                                                   -0.0544719802340063));

bus_tree_224_c1652 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 300.5 => 0.0213516162077658,
    bv_ver_src_id_mth_since_fs >= 300.5                                      => bus_tree_224_c1653,
    bv_ver_src_id_mth_since_fs = NULL                                        => -0.0270389088505701,
                                                                                -0.0270389088505701));

bus_tree_224 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 14.5 => 0.00330203302378908,
    bv_empl_ct_min >= 14.5                          => bus_tree_224_c1652,
    bv_empl_ct_min = NULL                           => 0.00182511945106895,
                                                       0.00182511945106895));

bus_tree_225_c1656 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 2.5 => -0.0208130353175495,
    bv_sos_mth_fs >= 2.5                         => 0.0219065833006403,
    bv_sos_mth_fs = NULL                         => 0.00552242077405004,
                                                    0.00552242077405004));

bus_tree_225_c1655 :=   __common__( map(
    NULL < bx_tin_match_consumer_associate AND bx_tin_match_consumer_associate < 0.5 => -0.00497954349274116,
    bx_tin_match_consumer_associate >= 0.5                                           => bus_tree_225_c1656,
    bx_tin_match_consumer_associate = NULL                                           => -0.00138559888227947,
                                                                                        -0.00138559888227947));

bus_tree_225 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 1.5 => bus_tree_225_c1655,
    bv_ucc_other_count >= 1.5                              => 0.0432444459088196,
    bv_ucc_other_count = NULL                              => -0.000697425856022161,
                                                              -0.000697425856022161));

bus_tree_226_c1659 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 141.5 => -0.00668230743267805,
    bv_sos_mth_ls >= 141.5                         => 0.0163105379993187,
    bv_sos_mth_ls = NULL                           => -0.00319281623718698,
                                                      -0.00319281623718698));

bus_tree_226_c1658 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 7.5 => bus_tree_226_c1659,
    bx_inq_consumer_phn_cnt >= 7.5                                   => 0.035650741149713,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00250851574003582,
                                                                        -0.00250851574003582));

bus_tree_226 :=   __common__( map(
    (bx_fein_contradictory_in in [3])                => -0.024514970218007,
    (bx_fein_contradictory_in in [0, 1, 2, 4]) => bus_tree_226_c1658,
    bx_fein_contradictory_in = NULL                    => -0.00399147981051474,
                                                          -0.00399147981051474));

bus_tree_227_c1662 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 0.5 => 0.0038255910052216,
    bv_ucc_other_count >= 0.5                              => 0.0415870441739582,
    bv_ucc_other_count = NULL                              => 0.00471921029990869,
                                                              0.00471921029990869));

bus_tree_227_c1661 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 4.5 => bus_tree_227_c1662,
    bx_phn_problems >= 4.5                           => 0.0324526299250873,
    bx_phn_problems = NULL                           => 0.00536034527406152,
                                                        0.00536034527406152));

bus_tree_227 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 61096 => bus_tree_227_c1661,
    bx_addr_bldg_size >= 61096                             => -0.03976429809867,
    bx_addr_bldg_size = NULL                               => 0.0041324638217423,
                                                              0.0041324638217423));

bus_tree_228_c1664 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 412.5 => -0.00372413411410352,
    bv_ver_src_id_mth_since_fs >= 412.5                                      => 0.043464621845405,
    bv_ver_src_id_mth_since_fs = NULL                                        => -0.00163274966692177,
                                                                                -0.00163274966692177));

bus_tree_228_c1665 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 3.5 => -0.0817536920207256,
    bv_ucc_count >= 3.5                        => 0.00469511658644992,
    bv_ucc_count = NULL                        => -0.035015561947943,
                                                  -0.035015561947943));

bus_tree_228 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 33.5 => bus_tree_228_c1664,
    bv_mth_bureau_ls >= 33.5                            => bus_tree_228_c1665,
    bv_mth_bureau_ls = NULL                             => -0.00358828099857645,
                                                           -0.00358828099857645));

bus_tree_229_c1668 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 1158528 => 0.00186991107749582,
    bx_addr_assessed_value >= 1158528                                  => 0.0266119345891072,
    bx_addr_assessed_value = NULL                                      => 0.00441642423986784,
                                                                          0.00441642423986784));

bus_tree_229_c1667 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 498.5 => bus_tree_229_c1668,
    bv_sos_mth_fs >= 498.5                         => 0.0627930480283458,
    bv_sos_mth_fs = NULL                           => 0.00537787888896334,
                                                      0.00537787888896334));

bus_tree_229 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 6.5 => bus_tree_229_c1667,
    bx_inq_consumer_phn_cnt >= 6.5                                   => -0.0389958375293973,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00437712000246831,
                                                                        0.00437712000246831));

bus_tree_230_c1670 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 104.5 => 0.0042752902848814,
    bv_ver_src_derog_ratio >= 104.5                                  => 0.0699146498636791,
    bv_ver_src_derog_ratio = NULL                                    => 0.00603206146582246,
                                                                        0.00603206146582246));

bus_tree_230_c1671 :=   __common__( map(
    (bv_ucc_index in [1, 2, 4]) => -0.0378676742444176,
    (bv_ucc_index in [0, 3])      => 0.0229148981865132,
    bv_ucc_index = NULL               => -0.0215013523007726,
                                         -0.0215013523007726));

bus_tree_230 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 79.5 => bus_tree_230_c1670,
    bv_mth_bureau_fs >= 79.5                            => bus_tree_230_c1671,
    bv_mth_bureau_fs = NULL                             => 0.00330369370709183,
                                                           0.00330369370709183));

bus_tree_231_c1674 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 12.5 => 0.0196548866301256,
    bv_sos_mth_fs >= 12.5                         => 0.055545190512112,
    bv_sos_mth_fs = NULL                          => 0.0315641062969076,
                                                     0.0315641062969076));

bus_tree_231_c1673 :=   __common__( map(
    NULL < bx_assoc_county_match_ct AND bx_assoc_county_match_ct < 0.5 => bus_tree_231_c1674,
    bx_assoc_county_match_ct >= 0.5                                    => 0.00124999033900304,
    bx_assoc_county_match_ct = NULL                                    => 0.0163065951389026,
                                                                          0.0163065951389026));

bus_tree_231 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 116.5 => bus_tree_231_c1673,
    bv_ver_src_id_mth_since_fs >= 116.5                                      => -0.00350975894046303,
    bv_ver_src_id_mth_since_fs = NULL                                        => 0.00846842575890863,
                                                                                0.00846842575890863));

bus_tree_232_c1676 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 5.5 => -0.00198841066660567,
    bv_ucc_count >= 5.5                        => 0.0604211174317497,
    bv_ucc_count = NULL                        => -0.000738803545959284,
                                                  -0.000738803545959284));

bus_tree_232_c1677 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 7.5 => -0.0745251972055142,
    bv_assoc_bus_total >= 7.5                              => 0.00321953615771333,
    bv_assoc_bus_total = NULL                              => -0.0366094212028663,
                                                              -0.0366094212028663));

bus_tree_232 :=   __common__( map(
    NULL < bv_ucc_active_count AND bv_ucc_active_count < 5.5 => bus_tree_232_c1676,
    bv_ucc_active_count >= 5.5                               => bus_tree_232_c1677,
    bv_ucc_active_count = NULL                               => -0.00316271376404507,
                                                                -0.00316271376404507));

bus_tree_233_c1680 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 0.5 => -0.00478335955487505,
    bx_phn_distance_addr >= 0.5                                => 0.0561247316810434,
    bx_phn_distance_addr = NULL                                => 0.0101616813502346,
                                                                  0.0101616813502346));

bus_tree_233_c1679 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 1270400 => bus_tree_233_c1680,
    bx_addr_assessed_value >= 1270400                                  => 0.0646731097270533,
    bx_addr_assessed_value = NULL                                      => 0.0228600920350028,
                                                                          0.0228600920350028));

bus_tree_233 :=   __common__( map(
    NULL < bv_ucc_mth_fs AND bv_ucc_mth_fs < 166.5 => -0.00387070477442138,
    bv_ucc_mth_fs >= 166.5                         => bus_tree_233_c1679,
    bv_ucc_mth_fs = NULL                           => -0.00158959596128155,
                                                      -0.00158959596128155));

bus_tree_234_c1683 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 7.5 => 0.00175481722201011,
    bx_addr_src_count >= 7.5                             => 0.0318242369288245,
    bx_addr_src_count = NULL                             => 0.00456051295430203,
                                                            0.00456051295430203));

bus_tree_234_c1682 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 711488 => bus_tree_234_c1683,
    bx_addr_lot_size >= 711488                            => -0.0504461650141573,
    bx_addr_lot_size = NULL                               => 0.00200663147719499,
                                                             0.00200663147719499));

bus_tree_234 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 2262272 => bus_tree_234_c1682,
    bv_sales >= 2262272                    => -0.0353379091292149,
    bv_sales = NULL                        => 0.0010186806675016,
                                              0.0010186806675016));

bus_tree_235_c1686 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 2.5 => 0.0245135801997061,
    bv_mth_bureau_ls >= 2.5                            => -0.0485823129868073,
    bv_mth_bureau_ls = NULL                            => -0.0076486128023598,
                                                          -0.0076486128023598));

bus_tree_235_c1685 :=   __common__( map(
    NULL < bx_addr_src_count AND bx_addr_src_count < 4.5 => 0.0561008283329043,
    bx_addr_src_count >= 4.5                             => bus_tree_235_c1686,
    bx_addr_src_count = NULL                             => 0.0103853537304647,
                                                            0.0103853537304647));

bus_tree_235 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 2.5 => -0.00517613732869548,
    bx_fein_src_count >= 2.5                             => bus_tree_235_c1685,
    bx_fein_src_count = NULL                             => -0.00398616172467075,
                                                            -0.00398616172467075));

bus_tree_236_c1688 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 11.5 => -0.00287475856116018,
    bv_empl_ct_max >= 11.5                          => -0.0257919111683742,
    bv_empl_ct_max = NULL                           => -0.00464512996661891,
                                                       -0.00464512996661891));

bus_tree_236_c1689 :=   __common__( map(
    NULL < bx_name_src_count AND bx_name_src_count < 3.5 => 0.0148255422237481,
    bx_name_src_count >= 3.5                             => 0.111568732650395,
    bx_name_src_count = NULL                             => 0.0251979066444912,
                                                            0.0251979066444912));

bus_tree_236 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_ls AND bv_ver_src_id_mth_since_ls < 15.5 => bus_tree_236_c1688,
    bv_ver_src_id_mth_since_ls >= 15.5                                      => bus_tree_236_c1689,
    bv_ver_src_id_mth_since_ls = NULL                                       => -0.000205893681610235,
                                                                               -0.000205893681610235));

bus_tree_237_c1691 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 347.5 => 0.00321285054318111,
    bv_mth_ver_src_p_fs >= 347.5                               => -0.0799591313647627,
    bv_mth_ver_src_p_fs = NULL                                 => 0.00178080312504962,
                                                                  0.00178080312504962));

bus_tree_237_c1692 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 11.5 => 0.0236127191504176,
    bv_ver_src_id_count >= 11.5                               => 0.082303447370417,
    bv_ver_src_id_count = NULL                                => 0.0415438030076718,
                                                                 0.0415438030076718));

bus_tree_237 :=   __common__( map(
    NULL < bv_sos_mth_ls AND bv_sos_mth_ls < 263.5 => bus_tree_237_c1691,
    bv_sos_mth_ls >= 263.5                         => bus_tree_237_c1692,
    bv_sos_mth_ls = NULL                           => 0.0040139028161145,
                                                      0.0040139028161145));

bus_tree_238_c1695 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 217.5 => 0.110529181892651,
    bv_mth_ver_src_p_fs >= 217.5                               => 4.12228155736695e-05,
    bv_mth_ver_src_p_fs = NULL                                 => 0.0225440793457507,
                                                                  0.0225440793457507));

bus_tree_238_c1694 :=   __common__( map(
    NULL < bv_mth_ver_src_p_fs AND bv_mth_ver_src_p_fs < 193.5 => -0.00879696649154094,
    bv_mth_ver_src_p_fs >= 193.5                               => bus_tree_238_c1695,
    bv_mth_ver_src_p_fs = NULL                                 => -0.00628890813471767,
                                                                  -0.00628890813471767));

bus_tree_238 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 7.5 => bus_tree_238_c1694,
    bx_inq_consumer_phn_cnt >= 7.5                                   => 0.0246508214314314,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00578809786056387,
                                                                        -0.00578809786056387));

bus_tree_239_c1698 :=   __common__( map(
    (bx_fein_contradictory_in in [1, 2])      => -0.00344922558308182,
    (bx_fein_contradictory_in in [0, 3, 4]) => 0.0430295789846296,
    bx_fein_contradictory_in = NULL               => 0.0199852836229331,
                                                     0.0199852836229331));

bus_tree_239_c1697 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 241.5 => -0.00115701744666464,
    bv_ver_src_id_mth_since_fs >= 241.5                                      => bus_tree_239_c1698,
    bv_ver_src_id_mth_since_fs = NULL                                        => 0.00233853133125271,
                                                                                0.00233853133125271));

bus_tree_239 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 171.5 => bus_tree_239_c1697,
    bv_mth_ver_src_c_ls >= 171.5                               => -0.0716881614960479,
    bv_mth_ver_src_c_ls = NULL                                 => 0.00110755080048883,
                                                                  0.00110755080048883));

bus_tree_240_c1701 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 26.5 => -0.000606822982054476,
    bv_sos_mth_fs >= 26.5                         => -0.0625625806087706,
    bv_sos_mth_fs = NULL                          => -0.023781625294318,
                                                     -0.023781625294318));

bus_tree_240_c1700 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 11136 => 0.00469327149929136,
    bx_addr_bldg_size >= 11136                             => bus_tree_240_c1701,
    bx_addr_bldg_size = NULL                               => 0.0021751759415391,
                                                              0.0021751759415391));

bus_tree_240 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 79.5 => bus_tree_240_c1700,
    bx_addr_lres >= 79.5                        => -0.0335031967169636,
    bx_addr_lres = NULL                         => -0.00529489905952306,
                                                   -0.00529489905952306));

bus_tree_241_c1704 :=   __common__( map(
    (bx_phn_contradictory in [1, 3, 4]) => -0.0478938810914997,
    (bx_phn_contradictory in [0, 2])      => -0.0139159112893111,
    bx_phn_contradictory = NULL               => -0.0360349033958339,
                                                 -0.0360349033958339));

bus_tree_241_c1703 :=   __common__( map(
    NULL < bv_assoc_bus_total AND bv_assoc_bus_total < 13.5 => 0.00727874066671312,
    bv_assoc_bus_total >= 13.5                              => bus_tree_241_c1704,
    bv_assoc_bus_total = NULL                               => 0.00387578713964257,
                                                               0.00387578713964257));

bus_tree_241 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 1.5 => bus_tree_241_c1703,
    bv_ucc_other_count >= 1.5                              => -0.0425057613414055,
    bv_ucc_other_count = NULL                              => 0.00314307787036525,
                                                              0.00314307787036525));

bus_tree_242_c1706 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 954176 => 0.000644830217006525,
    bv_sales >= 954176                    => -0.035552736237207,
    bv_sales = NULL                       => -0.000425581500396878,
                                             -0.000425581500396878));

bus_tree_242_c1707 :=   __common__( map(
    NULL < bx_addr_lot_size AND bx_addr_lot_size < 8988 => 0.0752009721807694,
    bx_addr_lot_size >= 8988                            => -0.00707563141330593,
    bx_addr_lot_size = NULL                             => 0.0274326139776072,
                                                           0.0274326139776072));

bus_tree_242 :=   __common__( map(
    NULL < bx_name_src_count AND bx_name_src_count < 10.5 => bus_tree_242_c1706,
    bx_name_src_count >= 10.5                             => bus_tree_242_c1707,
    bx_name_src_count = NULL                              => 0.00065884561004697,
                                                             0.00065884561004697));

bus_tree_243_c1710 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 143296 => 0.0764769423396197,
    bx_addr_assessed_value >= 143296                                  => 0.00616204978583289,
    bx_addr_assessed_value = NULL                                     => 0.037803751435037,
                                                                         0.037803751435037));

bus_tree_243_c1709 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 14.5 => -0.00957048228297457,
    bv_mth_ver_src_br_ls >= 14.5                                => bus_tree_243_c1710,
    bv_mth_ver_src_br_ls = NULL                                 => 0.0131946468462957,
                                                                   0.0131946468462957));

bus_tree_243 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 1.5 => -6.38327421470058e-05,
    bx_inq_consumer_phn_cnt >= 1.5                                   => bus_tree_243_c1709,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00203305858051216,
                                                                        0.00203305858051216));

bus_tree_244_c1712 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 17.5 => 0.00499546426089226,
    bx_phn_distance_addr >= 17.5                                => 0.0382885379620517,
    bx_phn_distance_addr = NULL                                 => 0.00588718848770739,
                                                                   0.00588718848770739));

bus_tree_244_c1713 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => 0.0085359049818047,
    bx_phn_mobile >= 0.5                         => -0.0436051878593233,
    bx_phn_mobile = NULL                         => -0.0240204846946069,
                                                    -0.0240204846946069));

bus_tree_244 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 14.5 => bus_tree_244_c1712,
    bv_mth_ver_src_c_ls >= 14.5                               => bus_tree_244_c1713,
    bv_mth_ver_src_c_ls = NULL                                => 0.000755637609109239,
                                                                 0.000755637609109239));

bus_tree_245_c1715 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 175.5 => 0.00176743748717125,
    bv_sos_mth_fs >= 175.5                         => -0.0379761537602332,
    bv_sos_mth_fs = NULL                           => -0.00227008731649447,
                                                      -0.00227008731649447));

bus_tree_245_c1716 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 2.5 => 0.00676034727951082,
    bv_mth_ver_src_c_ls >= 2.5                               => 0.0874601917098494,
    bv_mth_ver_src_c_ls = NULL                               => 0.0298662265733877,
                                                                0.0298662265733877));

bus_tree_245 :=   __common__( map(
    NULL < bx_irs_retirementplan AND bx_irs_retirementplan < 0.5 => bus_tree_245_c1715,
    bx_irs_retirementplan >= 0.5                                 => bus_tree_245_c1716,
    bx_irs_retirementplan = NULL                                 => -0.000547891810226403,
                                                                    -0.000547891810226403));

bus_tree_246_c1719 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 501.5 => 0.0111467524048541,
    bv_ver_src_id_mth_since_fs >= 501.5                                      => -0.0574176532744861,
    bv_ver_src_id_mth_since_fs = NULL                                        => 0.00896671207465064,
                                                                                0.00896671207465064));

bus_tree_246_c1718 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => bus_tree_246_c1719,
    bx_consumer_addr >= 0.5                            => -0.00371603382781975,
    bx_consumer_addr = NULL                            => 0.00274928459822903,
                                                          0.00274928459822903));

bus_tree_246 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 4.5 => bus_tree_246_c1718,
    bx_inq_consumer_phn_cnt >= 4.5                                   => -0.0204079383391536,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00173480448017651,
                                                                        0.00173480448017651));

bus_tree_247_c1722 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 8.5 => 0.0569798161538133,
    bv_mth_ver_src_br_ls >= 8.5                                => 0.00398174002231916,
    bv_mth_ver_src_br_ls = NULL                                => 0.0241521444759402,
                                                                  0.0241521444759402));

bus_tree_247_c1721 :=   __common__( map(
    NULL < bv_inq_other_count12 AND bv_inq_other_count12 < 1.5 => -0.00295647541432521,
    bv_inq_other_count12 >= 1.5                                => bus_tree_247_c1722,
    bv_inq_other_count12 = NULL                                => 0.00033056281627143,
                                                                  0.00033056281627143));

bus_tree_247 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 5.5 => bus_tree_247_c1721,
    bx_phn_problems >= 5.5                           => -0.0377912124937961,
    bx_phn_problems = NULL                           => -0.000396200483350851,
                                                        -0.000396200483350851));

bus_tree_248_c1725 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 0.5 => -0.016075188546566,
    bx_addr_lres >= 0.5                        => 0.0383748307332382,
    bx_addr_lres = NULL                        => 0.0167228152311809,
                                                  0.0167228152311809));

bus_tree_248_c1724 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 1.5 => -0.00620181426798731,
    bx_inq_consumer_phn_cnt >= 1.5                                   => bus_tree_248_c1725,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00254718912650073,
                                                                        -0.00254718912650073));

bus_tree_248 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 3.5 => bus_tree_248_c1724,
    bx_fein_src_count >= 3.5                             => -0.0436845620495488,
    bx_fein_src_count = NULL                             => -0.00360247247276735,
                                                            -0.00360247247276735));

bus_tree_249_c1728 :=   __common__( map(
    NULL < bv_ucc_mth_fs AND bv_ucc_mth_fs < 85.5 => -0.00531206126384729,
    bv_ucc_mth_fs >= 85.5                         => 0.0694239538211177,
    bv_ucc_mth_fs = NULL                          => -0.00231681489656498,
                                                     -0.00231681489656498));

bus_tree_249_c1727 :=   __common__( map(
    NULL < bx_fein_src_count AND bx_fein_src_count < 0.5 => bus_tree_249_c1728,
    bx_fein_src_count >= 0.5                             => 0.00976929059812656,
    bx_fein_src_count = NULL                             => 0.000623572291923104,
                                                            0.000623572291923104));

bus_tree_249 :=   __common__( map(
    NULL < bx_phn_not_in_zipcode AND bx_phn_not_in_zipcode < 0.5 => -0.013462084021461,
    bx_phn_not_in_zipcode >= 0.5                                 => bus_tree_249_c1727,
    bx_phn_not_in_zipcode = NULL                                 => -0.00545089374355863,
                                                                    -0.00545089374355863));

bus_tree_250_c1731 :=   __common__( map(
    NULL < bv_mth_ver_src_br_ls AND bv_mth_ver_src_br_ls < 30.5 => -0.0308200671163951,
    bv_mth_ver_src_br_ls >= 30.5                                => 0.0181755397646107,
    bv_mth_ver_src_br_ls = NULL                                 => -0.00865326679114005,
                                                                   -0.00865326679114005));

bus_tree_250_c1730 :=   __common__( map(
    NULL < bx_addr_assessed_value AND bx_addr_assessed_value < 2980096 => bus_tree_250_c1731,
    bx_addr_assessed_value >= 2980096                                  => -0.0591843007786484,
    bx_addr_assessed_value = NULL                                      => -0.0124487592543273,
                                                                          -0.0124487592543273));

bus_tree_250 :=   __common__( map(
    (bx_fein_contradictory_in in [1, 2, 4]) => bus_tree_250_c1730,
    (bx_fein_contradictory_in in [0, 3])      => 0.00143949334120981,
    bx_fein_contradictory_in = NULL               => -0.0023091476498543,
                                                     -0.0023091476498543));

bus_tree_251_c1734 :=   __common__( map(
    NULL < bv_mth_ver_src_c_fs AND bv_mth_ver_src_c_fs < 302.5 => 0.0850334444592687,
    bv_mth_ver_src_c_fs >= 302.5                               => -0.00211435576297114,
    bv_mth_ver_src_c_fs = NULL                                 => 0.0257784911234464,
                                                                  0.0257784911234464));

bus_tree_251_c1733 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 285.5 => 7.21898757923582e-05,
    bv_sos_mth_fs >= 285.5                         => bus_tree_251_c1734,
    bv_sos_mth_fs = NULL                           => 0.00141457780058254,
                                                      0.00141457780058254));

bus_tree_251 :=   __common__( map(
    (bx_fein_contradictory_in in [2, 3])      => -0.0274084273965087,
    (bx_fein_contradictory_in in [0, 1, 4]) => bus_tree_251_c1733,
    bx_fein_contradictory_in = NULL               => -0.00118666625722288,
                                                     -0.00118666625722288));

bus_tree_252_c1736 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 81.5 => -0.0093973079460906,
    bv_ver_src_id_mth_since_fs >= 81.5                                      => 0.0119423154128363,
    bv_ver_src_id_mth_since_fs = NULL                                       => 0.00095050783239261,
                                                                               0.00095050783239261));

bus_tree_252_c1737 :=   __common__( map(
    NULL < bv_inq_other_pct12 AND bv_inq_other_pct12 < -0.5 => 0.0245568820205257,
    bv_inq_other_pct12 >= -0.5                              => -0.0664857300613491,
    bv_inq_other_pct12 = NULL                               => -0.0204411906176423,
                                                               -0.0204411906176423));

bus_tree_252 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 4.5 => bus_tree_252_c1736,
    bx_inq_consumer_phn_cnt >= 4.5                                   => bus_tree_252_c1737,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00010115310576918,
                                                                        0.00010115310576918));

bus_tree_253_c1740 :=   __common__( map(
    NULL < bv_inq_total_count12 AND bv_inq_total_count12 < 2.5 => -0.000364356303277802,
    bv_inq_total_count12 >= 2.5                                => -0.0438826058218455,
    bv_inq_total_count12 = NULL                                => -0.00537375752120461,
                                                                  -0.00537375752120461));

bus_tree_253_c1739 :=   __common__( map(
    (bx_fein_contradictory_id in [1])      => -0.0445170795461596,
    (bx_fein_contradictory_id in [0, 2]) => bus_tree_253_c1740,
    bx_fein_contradictory_id = NULL          => -0.0153699029687911,
                                                -0.0153699029687911));

bus_tree_253 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 0.5 => 0.00875240383253387,
    bx_inq_consumer_phn_cnt >= 0.5                                   => bus_tree_253_c1739,
    bx_inq_consumer_phn_cnt = NULL                                   => 0.00149738177177063,
                                                                        0.00149738177177063));

bus_tree_254_c1742 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 278016 => -0.00439919888720617,
    bv_sales >= 278016                    => 0.0598559241276749,
    bv_sales = NULL                       => -0.00338406242161834,
                                             -0.00338406242161834));

bus_tree_254_c1743 :=   __common__( map(
    NULL < bx_consumer_addr AND bx_consumer_addr < 0.5 => 9.51965228862964e-05,
    bx_consumer_addr >= 0.5                            => -0.0675756374832078,
    bx_consumer_addr = NULL                            => -0.0347376364008855,
                                                          -0.0347376364008855));

bus_tree_254 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 1522176 => bus_tree_254_c1742,
    bv_sales >= 1522176                    => bus_tree_254_c1743,
    bv_sales = NULL                        => -0.00443629120822413,
                                              -0.00443629120822413));

bus_tree_255_c1746 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 332.5 => 0.0402664193225889,
    bv_ver_src_id_mth_since_fs >= 332.5                                      => -0.0084298062561645,
    bv_ver_src_id_mth_since_fs = NULL                                        => 0.0173104735661814,
                                                                                0.0173104735661814));

bus_tree_255_c1745 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 1.5 => -0.00530273466581769,
    bv_mth_bureau_fs >= 1.5                            => bus_tree_255_c1746,
    bv_mth_bureau_fs = NULL                            => -0.00242577178596886,
                                                          -0.00242577178596886));

bus_tree_255 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 7.5 => bus_tree_255_c1745,
    bx_inq_consumer_phn_cnt >= 7.5                                   => 0.0293494866249863,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00186297169400744,
                                                                        -0.00186297169400744));

bus_tree_256_c1749 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 3, 4]) => 0.00396071289751713,
    (bx_fein_contradictory_in in [1, 2])      => 0.0334671508709252,
    bx_fein_contradictory_in = NULL               => 0.00884378302851046,
                                                     0.00884378302851046));

bus_tree_256_c1748 :=   __common__( map(
    NULL < bv_ver_src_id_count AND bv_ver_src_id_count < 8.5 => bus_tree_256_c1749,
    bv_ver_src_id_count >= 8.5                               => -0.024583407906934,
    bv_ver_src_id_count = NULL                               => 0.00406551181379538,
                                                                0.00406551181379538));

bus_tree_256 :=   __common__( map(
    NULL < bv_sales AND bv_sales < 2842368 => bus_tree_256_c1748,
    bv_sales >= 2842368                    => 0.035560133974407,
    bv_sales = NULL                        => 0.00481776431589313,
                                              0.00481776431589313));

bus_tree_257_c1752 :=   __common__( map(
    NULL < bv_inq_other_count12 AND bv_inq_other_count12 < 2.5 => 0.00225185222249416,
    bv_inq_other_count12 >= 2.5                                => 0.0254941267280697,
    bv_inq_other_count12 = NULL                                => 0.0039197225360408,
                                                                  0.0039197225360408));

bus_tree_257_c1751 :=   __common__( map(
    NULL < bx_tin_match_consumer_associate AND bx_tin_match_consumer_associate < 1.5 => bus_tree_257_c1752,
    bx_tin_match_consumer_associate >= 1.5                                           => -0.0485200080959959,
    bx_tin_match_consumer_associate = NULL                                           => 0.00160476401312233,
                                                                                        0.00160476401312233));

bus_tree_257 :=   __common__( map(
    NULL < bv_ucc_other_count AND bv_ucc_other_count < 0.5 => bus_tree_257_c1751,
    bv_ucc_other_count >= 0.5                              => -0.0268047889171858,
    bv_ucc_other_count = NULL                              => 0.000803799293318482,
                                                              0.000803799293318482));

bus_tree_258_c1755 :=   __common__( map(
    NULL < bv_inq_other_pct12 AND bv_inq_other_pct12 < -0.5 => 0.0920241880627297,
    bv_inq_other_pct12 >= -0.5                              => -0.0251254136788486,
    bv_inq_other_pct12 = NULL                               => 0.0563554225467401,
                                                               0.0563554225467401));

bus_tree_258_c1754 :=   __common__( map(
    NULL < bx_name_src_count AND bx_name_src_count < 4.5 => bus_tree_258_c1755,
    bx_name_src_count >= 4.5                             => -0.0133996258122742,
    bx_name_src_count = NULL                             => 0.0127927842718001,
                                                            0.0127927842718001));

bus_tree_258 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 2, 3, 4]) => -0.00192187928894616,
    (bx_fein_contradictory_in in [1])                => bus_tree_258_c1754,
    bx_fein_contradictory_in = NULL                    => 0.00119287101783209,
                                                          0.00119287101783209));

bus_tree_259_c1758 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 103.5 => -0.00872066590115522,
    bv_ver_src_derog_ratio >= 103.5                                  => 0.0208083824981664,
    bv_ver_src_derog_ratio = NULL                                    => -0.00552928977198355,
                                                                        -0.00552928977198355));

bus_tree_259_c1757 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 58288 => bus_tree_259_c1758,
    bx_addr_bldg_size >= 58288                             => -0.0454066725991634,
    bx_addr_bldg_size = NULL                               => -0.00654448548506295,
                                                              -0.00654448548506295));

bus_tree_259 :=   __common__( map(
    NULL < bv_mth_bureau_fs AND bv_mth_bureau_fs < 247.5 => bus_tree_259_c1757,
    bv_mth_bureau_fs >= 247.5                            => 0.0458039389148249,
    bv_mth_bureau_fs = NULL                              => -0.00517543372071214,
                                                            -0.00517543372071214));

bus_tree_260_c1761 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 108.5 => -0.0525691306862619,
    bv_ver_src_id_mth_since_fs >= 108.5                                      => -0.00459728134690041,
    bv_ver_src_id_mth_since_fs = NULL                                        => -0.0217869215214455,
                                                                                -0.0217869215214455));

bus_tree_260_c1760 :=   __common__( map(
    NULL < bv_ver_src_derog_ratio AND bv_ver_src_derog_ratio < 101.5 => 0.00515492011195117,
    bv_ver_src_derog_ratio >= 101.5                                  => bus_tree_260_c1761,
    bv_ver_src_derog_ratio = NULL                                    => -0.00414258204664515,
                                                                        -0.00414258204664515));

bus_tree_260 :=   __common__( map(
    NULL < bx_inq_consumer_phn_cnt AND bx_inq_consumer_phn_cnt < 5.5 => bus_tree_260_c1760,
    bx_inq_consumer_phn_cnt >= 5.5                                   => -0.0365579713158813,
    bx_inq_consumer_phn_cnt = NULL                                   => -0.00513554357564349,
                                                                        -0.00513554357564349));

bus_tree_261_c1764 :=   __common__( map(
    NULL < bv_sos_mth_fs AND bv_sos_mth_fs < 201.5 => -0.0131009910909154,
    bv_sos_mth_fs >= 201.5                         => 0.0497137324389371,
    bv_sos_mth_fs = NULL                           => -0.00955955167631067,
                                                      -0.00955955167631067));

bus_tree_261_c1763 :=   __common__( map(
    NULL < bv_mth_bureau_ls AND bv_mth_bureau_ls < 94 => bus_tree_261_c1764,
    bv_mth_bureau_ls >= 94                            => -0.0770749903017849,
    bv_mth_bureau_ls = NULL                           => -0.0111974546862453,
                                                         -0.0111974546862453));

bus_tree_261 :=   __common__( map(
    NULL < bx_phn_mobile AND bx_phn_mobile < 0.5 => 0.0135045440413741,
    bx_phn_mobile >= 0.5                         => bus_tree_261_c1763,
    bx_phn_mobile = NULL                         => -0.00298097958499396,
                                                    -0.00298097958499396));

bus_tree_262_c1766 :=   __common__( map(
    NULL < bx_phn_distance_addr AND bx_phn_distance_addr < 20.5 => 0.00620477705347492,
    bx_phn_distance_addr >= 20.5                                => 0.0547773096114548,
    bx_phn_distance_addr = NULL                                 => 0.00713571813457814,
                                                                   0.00713571813457814));

bus_tree_262_c1767 :=   __common__( map(
    NULL < bv_sales AND bv_sales < -0.5 => -0.00381703177547342,
    bv_sales >= -0.5                    => -0.0554381449713841,
    bv_sales = NULL                     => -0.0357659155872692,
                                           -0.0357659155872692));

bus_tree_262 :=   __common__( map(
    NULL < bv_ucc_count AND bv_ucc_count < 9.5 => bus_tree_262_c1766,
    bv_ucc_count >= 9.5                        => bus_tree_262_c1767,
    bv_ucc_count = NULL                        => 0.00487227593217078,
                                                  0.00487227593217078));

bus_tree_263_c1770 :=   __common__( map(
    NULL < bx_addr_lres AND bx_addr_lres < 12.5 => 0.0103260269714569,
    bx_addr_lres >= 12.5                        => 0.132543242405307,
    bx_addr_lres = NULL                         => 0.0646150745274121,
                                                   0.0646150745274121));

bus_tree_263_c1769 :=   __common__( map(
    (bx_fein_contradictory_id in [1, 2]) => -0.00101688079847486,
    (bx_fein_contradictory_id in [0])      => bus_tree_263_c1770,
    bx_fein_contradictory_id = NULL          => 0.0328361706506564,
                                                0.0328361706506564));

bus_tree_263 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 16622 => -0.00275374088769085,
    bx_addr_bldg_size >= 16622                             => bus_tree_263_c1769,
    bx_addr_bldg_size = NULL                               => -0.000367629660592283,
                                                              -0.000367629660592283));

bus_tree_264_c1772 :=   __common__( map(
    (bx_phn_contradictory in [0, 4])      => -0.0655926795531062,
    (bx_phn_contradictory in [1, 2, 3]) => -0.00360125487242458,
    bx_phn_contradictory = NULL               => -0.0335935088995889,
                                                 -0.0335935088995889));

bus_tree_264_c1773 :=   __common__( map(
    NULL < bv_empl_ct_max AND bv_empl_ct_max < 39.5 => -0.00335942604235017,
    bv_empl_ct_max >= 39.5                          => 0.0355462240901097,
    bv_empl_ct_max = NULL                           => -0.00222255267724117,
                                                       -0.00222255267724117));

bus_tree_264 :=   __common__( map(
    (bx_fein_contradictory_id in [2])      => bus_tree_264_c1772,
    (bx_fein_contradictory_id in [0, 1]) => bus_tree_264_c1773,
    bx_fein_contradictory_id = NULL          => -0.00354668229691364,
                                                -0.00354668229691364));

bus_tree_265_c1776 :=   __common__( map(
    NULL < bx_assoc_city_match_ct AND bx_assoc_city_match_ct < 1.5 => 0.0531370152726129,
    bx_assoc_city_match_ct >= 1.5                                  => -0.0268785577168028,
    bx_assoc_city_match_ct = NULL                                  => 0.0254977845336092,
                                                                      0.0254977845336092));

bus_tree_265_c1775 :=   __common__( map(
    NULL < bx_irs_retirementplan AND bx_irs_retirementplan < 0.5 => -0.000616372426749548,
    bx_irs_retirementplan >= 0.5                                 => bus_tree_265_c1776,
    bx_irs_retirementplan = NULL                                 => 0.000547338562248199,
                                                                    0.000547338562248199));

bus_tree_265 :=   __common__( map(
    NULL < bv_empl_ct_min AND bv_empl_ct_min < 45.5 => bus_tree_265_c1775,
    bv_empl_ct_min >= 45.5                          => -0.0428431913589564,
    bv_empl_ct_min = NULL                           => -0.000229952109809662,
                                                       -0.000229952109809662));

bus_tree_266_c1779 :=   __common__( map(
    NULL < bv_ver_src_id_mth_since_fs AND bv_ver_src_id_mth_since_fs < 292 => 0.0318414302498589,
    bv_ver_src_id_mth_since_fs >= 292                                      => 0.0822615633282857,
    bv_ver_src_id_mth_since_fs = NULL                                      => 0.0362013010870087,
                                                                              0.0362013010870087));

bus_tree_266_c1778 :=   __common__( map(
    NULL < bx_phn_problems AND bx_phn_problems < 3.5 => -0.00113865853340255,
    bx_phn_problems >= 3.5                           => bus_tree_266_c1779,
    bx_phn_problems = NULL                           => 0.0193728601944461,
                                                        0.0193728601944461));

bus_tree_266 :=   __common__( map(
    NULL < bx_addr_bldg_size AND bx_addr_bldg_size < 2361 => -0.00414231458998941,
    bx_addr_bldg_size >= 2361                             => bus_tree_266_c1778,
    bx_addr_bldg_size = NULL                              => 0.00372273820072314,
                                                             0.00372273820072314));

bus_tree_267_c1782 :=   __common__( map(
    NULL < bv_mth_ver_src_c_ls AND bv_mth_ver_src_c_ls < 19.5 => 0.0446571678321586,
    bv_mth_ver_src_c_ls >= 19.5                               => -0.0425853814484485,
    bv_mth_ver_src_c_ls = NULL                                => 0.0300948776514859,
                                                                 0.0300948776514859));

bus_tree_267_c1781 :=   __common__( map(
    (bx_fein_contradictory_in in [0, 1, 2]) => 0.00283048015029319,
    (bx_fein_contradictory_in in [3, 4])      => bus_tree_267_c1782,
    bx_fein_contradictory_in = NULL               => 0.00561640890540891,
                                                     0.00561640890540891));

bus_tree_267 :=   __common__( map(
    NULL < bv_inq_other_count12 AND bv_inq_other_count12 < 8.5 => bus_tree_267_c1781,
    bv_inq_other_count12 >= 8.5                                => -0.0601603469455889,
    bv_inq_other_count12 = NULL                                => 0.00461210772008,
                                                                  0.00461210772008));

bus_gbm_logit :=   __common__( bus_tree_0 +
    bus_tree_1 +
    bus_tree_2 +
    bus_tree_3 +
    bus_tree_4 +
    bus_tree_5 +
    bus_tree_6 +
    bus_tree_7 +
    bus_tree_8 +
    bus_tree_9 +
    bus_tree_10 +
    bus_tree_11 +
    bus_tree_12 +
    bus_tree_13 +
    bus_tree_14 +
    bus_tree_15 +
    bus_tree_16 +
    bus_tree_17 +
    bus_tree_18 +
    bus_tree_19 +
    bus_tree_20 +
    bus_tree_21 +
    bus_tree_22 +
    bus_tree_23 +
    bus_tree_24 +
    bus_tree_25 +
    bus_tree_26 +
    bus_tree_27 +
    bus_tree_28 +
    bus_tree_29 +
    bus_tree_30 +
    bus_tree_31 +
    bus_tree_32 +
    bus_tree_33 +
    bus_tree_34 +
    bus_tree_35 +
    bus_tree_36 +
    bus_tree_37 +
    bus_tree_38 +
    bus_tree_39 +
    bus_tree_40 +
    bus_tree_41 +
    bus_tree_42 +
    bus_tree_43 +
    bus_tree_44 +
    bus_tree_45 +
    bus_tree_46 +
    bus_tree_47 +
    bus_tree_48 +
    bus_tree_49 +
    bus_tree_50 +
    bus_tree_51 +
    bus_tree_52 +
    bus_tree_53 +
    bus_tree_54 +
    bus_tree_55 +
    bus_tree_56 +
    bus_tree_57 +
    bus_tree_58 +
    bus_tree_59 +
    bus_tree_60 +
    bus_tree_61 +
    bus_tree_62 +
    bus_tree_63 +
    bus_tree_64 +
    bus_tree_65 +
    bus_tree_66 +
    bus_tree_67 +
    bus_tree_68 +
    bus_tree_69 +
    bus_tree_70 +
    bus_tree_71 +
    bus_tree_72 +
    bus_tree_73 +
    bus_tree_74 +
    bus_tree_75 +
    bus_tree_76 +
    bus_tree_77 +
    bus_tree_78 +
    bus_tree_79 +
    bus_tree_80 +
    bus_tree_81 +
    bus_tree_82 +
    bus_tree_83 +
    bus_tree_84 +
    bus_tree_85 +
    bus_tree_86 +
    bus_tree_87 +
    bus_tree_88 +
    bus_tree_89 +
    bus_tree_90 +
    bus_tree_91 +
    bus_tree_92 +
    bus_tree_93 +
    bus_tree_94 +
    bus_tree_95 +
    bus_tree_96 +
    bus_tree_97 +
    bus_tree_98 +
    bus_tree_99 +
    bus_tree_100 +
    bus_tree_101 +
    bus_tree_102 +
    bus_tree_103 +
    bus_tree_104 +
    bus_tree_105 +
    bus_tree_106 +
    bus_tree_107 +
    bus_tree_108 +
    bus_tree_109 +
    bus_tree_110 +
    bus_tree_111 +
    bus_tree_112 +
    bus_tree_113 +
    bus_tree_114 +
    bus_tree_115 +
    bus_tree_116 +
    bus_tree_117 +
    bus_tree_118 +
    bus_tree_119 +
    bus_tree_120 +
    bus_tree_121 +
    bus_tree_122 +
    bus_tree_123 +
    bus_tree_124 +
    bus_tree_125 +
    bus_tree_126 +
    bus_tree_127 +
    bus_tree_128 +
    bus_tree_129 +
    bus_tree_130 +
    bus_tree_131 +
    bus_tree_132 +
    bus_tree_133 +
    bus_tree_134 +
    bus_tree_135 +
    bus_tree_136 +
    bus_tree_137 +
    bus_tree_138 +
    bus_tree_139 +
    bus_tree_140 +
    bus_tree_141 +
    bus_tree_142 +
    bus_tree_143 +
    bus_tree_144 +
    bus_tree_145 +
    bus_tree_146 +
    bus_tree_147 +
    bus_tree_148 +
    bus_tree_149 +
    bus_tree_150 +
    bus_tree_151 +
    bus_tree_152 +
    bus_tree_153 +
    bus_tree_154 +
    bus_tree_155 +
    bus_tree_156 +
    bus_tree_157 +
    bus_tree_158 +
    bus_tree_159 +
    bus_tree_160 +
    bus_tree_161 +
    bus_tree_162 +
    bus_tree_163 +
    bus_tree_164 +
    bus_tree_165 +
    bus_tree_166 +
    bus_tree_167 +
    bus_tree_168 +
    bus_tree_169 +
    bus_tree_170 +
    bus_tree_171 +
    bus_tree_172 +
    bus_tree_173 +
    bus_tree_174 +
    bus_tree_175 +
    bus_tree_176 +
    bus_tree_177 +
    bus_tree_178 +
    bus_tree_179 +
    bus_tree_180 +
    bus_tree_181 +
    bus_tree_182 +
    bus_tree_183 +
    bus_tree_184 +
    bus_tree_185 +
    bus_tree_186 +
    bus_tree_187 +
    bus_tree_188 +
    bus_tree_189 +
    bus_tree_190 +
    bus_tree_191 +
    bus_tree_192 +
    bus_tree_193 +
    bus_tree_194 +
    bus_tree_195 +
    bus_tree_196 +
    bus_tree_197 +
    bus_tree_198 +
    bus_tree_199 +
    bus_tree_200 +
    bus_tree_201 +
    bus_tree_202 +
    bus_tree_203 +
    bus_tree_204 +
    bus_tree_205 +
    bus_tree_206 +
    bus_tree_207 +
    bus_tree_208 +
    bus_tree_209 +
    bus_tree_210 +
    bus_tree_211 +
    bus_tree_212 +
    bus_tree_213 +
    bus_tree_214 +
    bus_tree_215 +
    bus_tree_216 +
    bus_tree_217 +
    bus_tree_218 +
    bus_tree_219 +
    bus_tree_220 +
    bus_tree_221 +
    bus_tree_222 +
    bus_tree_223 +
    bus_tree_224 +
    bus_tree_225 +
    bus_tree_226 +
    bus_tree_227 +
    bus_tree_228 +
    bus_tree_229 +
    bus_tree_230 +
    bus_tree_231 +
    bus_tree_232 +
    bus_tree_233 +
    bus_tree_234 +
    bus_tree_235 +
    bus_tree_236 +
    bus_tree_237 +
    bus_tree_238 +
    bus_tree_239 +
    bus_tree_240 +
    bus_tree_241 +
    bus_tree_242 +
    bus_tree_243 +
    bus_tree_244 +
    bus_tree_245 +
    bus_tree_246 +
    bus_tree_247 +
    bus_tree_248 +
    bus_tree_249 +
    bus_tree_250 +
    bus_tree_251 +
    bus_tree_252 +
    bus_tree_253 +
    bus_tree_254 +
    bus_tree_255 +
    bus_tree_256 +
    bus_tree_257 +
    bus_tree_258 +
    bus_tree_259 +
    bus_tree_260 +
    bus_tree_261 +
    bus_tree_262 +
    bus_tree_263 +
    bus_tree_264 +
    bus_tree_265 +
    bus_tree_266 +
    bus_tree_267);

pbr :=   __common__( 0.028);

offset :=   __common__( 0);

base_2 :=   __common__( 700);

pts_2 :=   __common__( -70);

lgt :=   __common__( ln(pbr / (1 - pbr)));

bus_score :=   __common__( min(if(max(round(base_2 + pts_2 * (bus_gbm_logit - offset - lgt) / ln(2)), 300) = NULL, -NULL, max(round(base_2 + pts_2 * (bus_gbm_logit - offset - lgt) / ln(2)), 300)), 999));

con_v01_w :=   __common__( map(
    nf_add_dist_input_to_curr = NULL  => 0,
    nf_add_dist_input_to_curr = -1    => -0.150716139759907,
    nf_add_dist_input_to_curr <= 0.5  => -0.127440263083188,
    nf_add_dist_input_to_curr <= 66.5 => -0.073721256716071,
                                         0.6410922818332));

con_v02_w :=   __common__( map(
    iv_mos_src_voter_adl_lseen = NULL => 0,
    iv_mos_src_voter_adl_lseen = -1   => -0.199846644248509,
    iv_mos_src_voter_adl_lseen <= 48  => 0.00333888130333904,
                                         0.386633109212703));

con_v03_w :=   __common__( map(
    nf_bus_sos_filings_not_instate = NULL => 0,
    nf_bus_sos_filings_not_instate = -1   => 0,
    nf_bus_sos_filings_not_instate <= -1  => 0,
    nf_bus_sos_filings_not_instate <= 0   => -0.0925965026326713,
                                             0.668772646643138));

con_v04_w :=   __common__( map(
    iv_bureau_verification_index = NULL  => 0,
    iv_bureau_verification_index = -1    => 0,
    iv_bureau_verification_index <= 10.5 => 0.419407874017791,
    iv_bureau_verification_index <= 13.5 => 0.0436864767566196,
                                            -0.20764352194867));

con_v05_w :=   __common__( map(
    nf_historical_count = NULL  => 0,
    nf_historical_count = -1    => 0,
    nf_historical_count <= 0.5  => 0.309794971642366,
    nf_historical_count <= 3.5  => 0.0238882464443114,
    nf_historical_count <= 16.5 => -0.208434638030989,
                                   -0.222123920576308));

con_v06_w :=   __common__( map(
    nf_link_candidate_cnt = NULL => 0,
    nf_link_candidate_cnt = -1   => 0,
    nf_link_candidate_cnt <= 1.5 => -0.210904809897179,
    nf_link_candidate_cnt <= 2.5 => -0.106441423424726,
    nf_link_candidate_cnt <= 4.5 => -0.0338657241993115,
                                    0.205731810240041));

con_v07_w :=   __common__( map(
    nf_m_src_credentialed_fs = NULL   => 0,
    nf_m_src_credentialed_fs = -1     => 0.169343489808654,
    nf_m_src_credentialed_fs <= 76.5  => -0.369509611055098,
    nf_m_src_credentialed_fs <= 316.5 => -0.0659399878468263,
                                         0.0940205902211479));

con_v08_w :=   __common__( map(
    nf_fp_srchfraudsrchcountyr = NULL => 0,
    nf_fp_srchfraudsrchcountyr = -1   => 0,
    nf_fp_srchfraudsrchcountyr <= 0.5 => -0.189867331388734,
    nf_fp_srchfraudsrchcountyr <= 3.5 => 0.0607368289047387,
                                         0.218917444308591));

con_v09_w :=   __common__( map(
    nf_ssns_per_curraddr_c6 = NULL => 0,
    nf_ssns_per_curraddr_c6 = -1   => 0,
    nf_ssns_per_curraddr_c6 <= 0.5 => -0.122386678061519,
    nf_ssns_per_curraddr_c6 <= 1.5 => -0.072231083531947,
                                      0.290814274905731));

con_v10_w :=   __common__( map(
    nf_inq_perbestssn_count12 = NULL => 0,
    nf_inq_perbestssn_count12 = -1   => 0,
    nf_inq_perbestssn_count12 <= 1.5 => -0.0995741656917527,
    nf_inq_perbestssn_count12 <= 4.5 => -0.107188856451098,
                                        0.238526198018004));

con_v11_w :=   __common__( map(
    nf_fp_srchvelocityrisktype = NULL => 0,
    nf_fp_srchvelocityrisktype = -1   => 0,
    nf_fp_srchvelocityrisktype <= 1.5 => -0.229419195602131,
    nf_fp_srchvelocityrisktype <= 2.5 => -0.077324216771724,
    nf_fp_srchvelocityrisktype <= 4.5 => 0.0647406979541894,
                                         0.137588693858464));

con_v12_w :=   __common__( map(
    nf_fp_srchunvrfdphonecount = NULL => 0,
    nf_fp_srchunvrfdphonecount = -1   => 0,
    nf_fp_srchunvrfdphonecount <= 0.5 => -0.0418345055756616,
    nf_fp_srchunvrfdphonecount <= 1   => -0.0612041941377164,
                                         0.172798420532335));

con_v13_w :=   __common__( map(
    rv_i60_inq_count12 = NULL => 0,
    rv_i60_inq_count12 = -1   => 0,
    rv_i60_inq_count12 <= 0.5 => -0.0665199928903953,
                                 0.0141961919952481));

con_v14_w :=   __common__( map(
    nf_pct_rel_prop_owned = NULL          => 0,
    nf_pct_rel_prop_owned = -1            => 0,
    nf_pct_rel_prop_owned <= 0.3956442831 => 0.290441584773184,
    nf_pct_rel_prop_owned <= 0.6015873016 => 0.0962290644766898,
    nf_pct_rel_prop_owned <= 0.9298029557 => -0.114267003483215,
                                             -0.220192459340667));

con_v15_w :=   __common__( map(
    nf_average_rel_distance = NULL   => 0,
    nf_average_rel_distance = -1     => 0,
    nf_average_rel_distance <= 113.5 => -0.400465894013696,
    nf_average_rel_distance <= 262.5 => -0.183002256452871,
    nf_average_rel_distance <= 431.5 => 0.0911133175566968,
    nf_average_rel_distance <= 656.5 => 0.226212229225139,
                                        0.49520437659259));

con_lgt :=   __common__( -3.99073581561031 +
    con_v01_w +
    con_v02_w +
    con_v03_w +
    con_v04_w +
    con_v05_w +
    con_v06_w +
    con_v07_w +
    con_v08_w +
    con_v09_w +
    con_v10_w +
    con_v11_w +
    con_v12_w +
    con_v13_w +
    con_v14_w +
    con_v15_w);

base_1 :=   __common__( 700);

pts_1 :=   __common__( -70);

odds_1 :=   __common__( 0.028);

con_score :=   __common__( min(if(max(round(pts_1 * (con_lgt - ln(odds_1)) / ln(2) + base_1), 300) = NULL, -NULL, max(round(pts_1 * (con_lgt - ln(odds_1)) / ln(2) + base_1), 300)), 999));

bln_v01_w :=   __common__( map(
    bx_rep_addr_distance = NULL  => 0,
    bx_rep_addr_distance = -1    => 0.102335613397139,
    bx_rep_addr_distance <= 1.5  => -0.203868878018338,
    bx_rep_addr_distance <= 18.5 => -0.107143555269394,
    bx_rep_addr_distance <= 99.5 => 0.12821027451745,
                                    1.38194507274049));

bln_v02_w :=   __common__( map(
    nf_fp_srchvelocityrisktype = NULL => 0,
    nf_fp_srchvelocityrisktype = -1   => 0,
    nf_fp_srchvelocityrisktype <= 2.5 => -0.235093347169815,
    nf_fp_srchvelocityrisktype <= 4.5 => 0.0349170801205206,
    nf_fp_srchvelocityrisktype <= 6.5 => 0.0667849282732708,
                                         0.522858900583584));

bln_v03_w :=   __common__( map(
    nf_add_dist_input_to_curr = NULL  => 0,
    nf_add_dist_input_to_curr = -1    => -0.122891704153343,
    nf_add_dist_input_to_curr <= 66.5 => -0.0429787903389998,
                                         0.586394864782555));

bln_v04_w :=   __common__( map(
    nf_average_rel_distance = NULL   => 0,
    nf_average_rel_distance = -1     => 0,
    nf_average_rel_distance <= 117.5 => -0.277358357039932,
    nf_average_rel_distance <= 264.5 => -0.0679529425409873,
    nf_average_rel_distance <= 431.5 => 0.028178984504951,
                                        0.261439759919983));

bln_v05_w :=   __common__( map(
    bx_assoc_county_match_ct = NULL => 0,
    bx_assoc_county_match_ct = -1   => -0.0814321737902161,
    bx_assoc_county_match_ct <= 0.5 => 0.396490036050824,
                                       -0.0456465653123872));

bln_v06_w :=   __common__( map(
    bx_phn_not_in_zipcode = NULL => 0,
    bx_phn_not_in_zipcode = -1   => 0,
    bx_phn_not_in_zipcode <= 0.5 => -0.171001601451544,
                                    0.175863984800933));

bln_v07_w :=   __common__( map(
    bv_ucc_count = NULL => 0,
    bv_ucc_count = -1   => 0,
    bv_ucc_count <= 1.5 => -0.200422675406838,
                           0.200543118240847));

bln_v08_w :=   __common__( map(
    nf_pct_rel_prop_owned = NULL           => 0,
    nf_pct_rel_prop_owned = -1             => 0,
    nf_pct_rel_prop_owned <= 0.4301948052  => 0.241831880778267,
    nf_pct_rel_prop_owned <= 0.57979626485 => 0.0249031636982735,
    nf_pct_rel_prop_owned <= 0.92390405295 => -0.0391448418285202,
                                              -0.178076316775268));

bln_v09_w :=   __common__( map(
    bv_sos_current_standing = NULL => 0,
    bv_sos_current_standing = -1   => -0.0521985281391689,
    bv_sos_current_standing <= 2.5 => 0.59682682428753,
                                      -0.0395580009688251));

bln_v10_w :=   __common__( map(
    nf_historical_count = NULL => 0,
    nf_historical_count = -1   => 0,
    nf_historical_count <= 0.5 => 0.181297405185275,
    nf_historical_count <= 3.5 => 0.0620658719544585,
                                  -0.179190993972605));

bln_v11_w :=   __common__( map(
    nf_fp_sourcerisktype = NULL => 0,
    nf_fp_sourcerisktype = -1   => 0,
    nf_fp_sourcerisktype <= 4.5 => -0.160370759390658,
    nf_fp_sourcerisktype <= 6.5 => 0.0766529854364833,
                                   0.292088503619261));

bln_v12_w :=   __common__( map(
    rv_c20_m_bureau_adl_fs = NULL => 0,
    rv_c20_m_bureau_adl_fs = -1   => 0,
    rv_c20_m_bureau_adl_fs <= 144 => 0.223126830295219,
    rv_c20_m_bureau_adl_fs <= 180 => 0.11945974345195,
    rv_c20_m_bureau_adl_fs <= 360 => -0.0401949229778935,
                                     -0.135667599306406));

bln_v13_w :=   __common__( map(
    nf_inq_perbestssn_count12 = NULL => 0,
    nf_inq_perbestssn_count12 = -1   => 0,
    nf_inq_perbestssn_count12 <= 0.5 => -0.0940643422657156,
    nf_inq_perbestssn_count12 <= 2.5 => -0.0590689789961669,
    nf_inq_perbestssn_count12 <= 4.5 => 0.0604720042097777,
                                        0.215862068182798));

bln_v14_w :=   __common__( map(
    bv_mth_ver_src_br_ls = NULL => 0,
    bv_mth_ver_src_br_ls = -1   => -0.0926937147459434,
    bv_mth_ver_src_br_ls <= 6   => -0.0837470746606963,
    bv_mth_ver_src_br_ls <= 48  => 0.00876063452452768,
                                   0.186692470815984));

bln_v15_w :=   __common__( map(
    bv_sos_mth_ls = NULL => 0,
    bv_sos_mth_ls = -1   => -0.0396873975737677,
    bv_sos_mth_ls <= 12  => -0.121040022197877,
    bv_sos_mth_ls <= 56  => 0.0165656936486397,
                            0.157430116792747));

bln_v16_w :=   __common__( map(
    iv_addr_non_phn_src_ct = NULL => 0,
    iv_addr_non_phn_src_ct = -1   => 0,
    iv_addr_non_phn_src_ct <= 2   => 0.0974120955628755,
    iv_addr_non_phn_src_ct <= 4.5 => -0.0170020787849045,
                                     -0.0822312535232359));

bln_v17_w :=   __common__( map(
    bv_ucc_mth_ls = NULL  => 0,
    bv_ucc_mth_ls = -1    => 0.0298641352717102,
    bv_ucc_mth_ls <= 11.5 => 0.164570283478877,
                             -0.143251382379186));

bln_v18_w :=   __common__( map(
    bv_lien_filed_count = NULL => 0,
    bv_lien_filed_count = -1   => 0,
    bv_lien_filed_count <= 0   => -0.0498875108120702,
                                  0.0498529937909229));

bln_lgt :=   __common__( -4.10253798451409 +
    bln_v01_w +
    bln_v02_w +
    bln_v03_w +
    bln_v04_w +
    bln_v05_w +
    bln_v06_w +
    bln_v07_w +
    bln_v08_w +
    bln_v09_w +
    bln_v10_w +
    bln_v11_w +
    bln_v12_w +
    bln_v13_w +
    bln_v14_w +
    bln_v15_w +
    bln_v16_w +
    bln_v17_w +
    bln_v18_w);

base :=   __common__( 700);

pts :=   __common__( -70);

odds :=   __common__( 0.028);

bln_score :=   __common__( min(if(max(round(pts * (bln_lgt - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(pts * (bln_lgt - ln(odds)) / ln(2) + base), 300)), 999));

unscrbl_bus :=   __common__( if((integer)truebiz_ln = 0, 1, 0));

unscrbl_con :=   __common__( if(not(fnamepop and lnamepop and addrpop and not(in_zipcode = (string)NULL)) and not(fnamepop and lnamepop and ssnlength > '0'), 1, 0));

bbfm1906_1_0 :=   __common__( map(
    unscrbl_bus = 0 and unscrbl_con = 0 => bln_score,
    unscrbl_bus = 0 and unscrbl_con = 1 => bus_score,
    unscrbl_bus = 1 and unscrbl_con = 0 => con_score,
                                           222));


 //*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//
 #if(MODEL_DEBUG) 


                    self.seq                              := le.busshell.input_echo.seq;
                    self.sysdate                          := sysdate;
                    self._b_ver_src_id_br_pos             := _b_ver_src_id_br_pos;
                    self.__b_ver_src_id_fdate_br          := __b_ver_src_id_fdate_br;
                    self._b_ver_src_id_fdate_br           := _b_ver_src_id_fdate_br;
                    self.__b_ver_src_id_ldate_br          := __b_ver_src_id_ldate_br;
                    self._b_ver_src_id_ldate_br           := _b_ver_src_id_ldate_br;
                    self._b_ver_src_id_c_pos              := _b_ver_src_id_c_pos;
                    self.__b_ver_src_id_fdate_c           := __b_ver_src_id_fdate_c;
                    self._b_ver_src_id_fdate_c            := _b_ver_src_id_fdate_c;
                    self.__b_ver_src_id_ldate_c           := __b_ver_src_id_ldate_c;
                    self._b_ver_src_id_ldate_c            := _b_ver_src_id_ldate_c;
                    self._b_ver_src_id_p_pos              := _b_ver_src_id_p_pos;
                    self.__b_ver_src_id_fdate_p           := __b_ver_src_id_fdate_p;
                    self._b_ver_src_id_fdate_p            := _b_ver_src_id_fdate_p;
                    self.truebiz_ln                       := truebiz_ln;
                    self.source_ar                        := source_ar;
                    self.source_ba                        := source_ba;
                    self.source_bm                        := source_bm;
                    self.source_c                         := source_c;
                    self.source_cs                        := source_cs;
                    self.source_dn                        := source_dn;
                    self.source_ef                        := source_ef;
                    self.source_ft                        := source_ft;
                    self.source_i                         := source_i;
                    self.source_ia                        := source_ia;
                    self.source_in                        := source_in;
                    self.source_l2                        := source_l2;
                    self.source_p                         := source_p;
                    self.source_ut                        := source_ut;
                    self.source_v2                        := source_v2;
                    self.source_wk                        := source_wk;
                    self.num_pos_sources                  := num_pos_sources;
                    self.num_neg_sources                  := num_neg_sources;
                    self.bv_assoc_bus_total               := bv_assoc_bus_total;
                    self.bv_empl_ct_max                   := bv_empl_ct_max;
                    self.bv_empl_ct_min                   := bv_empl_ct_min;
                    self.bv_inq_other_count12             := bv_inq_other_count12;
                    self.bv_inq_other_pct12               := bv_inq_other_pct12;
                    self.bv_inq_total_count12             := bv_inq_total_count12;
                    self.bv_lien_filed_count              := bv_lien_filed_count;
                    self.bv_mth_bureau_fs                 := bv_mth_bureau_fs;
                    self.bv_mth_bureau_ls                 := bv_mth_bureau_ls;
                    self.bv_mth_ver_src_br_fs             := bv_mth_ver_src_br_fs;
                    self.bv_mth_ver_src_br_ls             := bv_mth_ver_src_br_ls;
                    self.bv_mth_ver_src_c_fs              := bv_mth_ver_src_c_fs;
                    self.bv_mth_ver_src_c_ls              := bv_mth_ver_src_c_ls;
                    self.bv_mth_ver_src_p_fs              := bv_mth_ver_src_p_fs;
                    self.fin_reported_sales               := fin_reported_sales;
                    self.bv_sales                         := bv_sales;
                    self.bv_sos_current_standing          := bv_sos_current_standing;
                    self._sos_inc_filing_firstseen        := _sos_inc_filing_firstseen;
                    self.bv_sos_mth_fs                    := bv_sos_mth_fs;
                    self._sos_inc_filing_lastseen         := _sos_inc_filing_lastseen;
                    self.bv_sos_mth_ls                    := bv_sos_mth_ls;
                    self.bv_ucc_active_count              := bv_ucc_active_count;
                    self.bv_ucc_count                     := bv_ucc_count;
                    self._ucc_firstseen                   := _ucc_firstseen;
                    self.bv_ucc_mth_fs                    := bv_ucc_mth_fs;
                    self._ucc_lastseen                    := _ucc_lastseen;
                    self.bv_ucc_mth_ls                    := bv_ucc_mth_ls;
                    self.bv_ucc_other_count               := bv_ucc_other_count;
                    self.ucc_active_count                 := ucc_active_count;
                    self.bv_ucc_index                     := bv_ucc_index;
                    self.bv_ver_src_derog_ratio           := bv_ver_src_derog_ratio;
                    self.bv_ver_src_id_count              := bv_ver_src_id_count;
                    self.bv_ver_src_id_mth_since_fs       := bv_ver_src_id_mth_since_fs;
                    self.bv_ver_src_id_mth_since_ls       := bv_ver_src_id_mth_since_ls;
                    self.bx_addr_assessed_value           := bx_addr_assessed_value;
                    self.bx_addr_bldg_size                := bx_addr_bldg_size;
                    self.bx_addr_lot_size                 := bx_addr_lot_size;
                    self.bx_addr_lres                     := bx_addr_lres;
                    self.bx_addr_src_count                := bx_addr_src_count;
                    self.bx_assoc_city_match_ct           := bx_assoc_city_match_ct;
                    self.bx_assoc_county_match_ct         := bx_assoc_county_match_ct;
                    self.bx_consumer_addr                 := bx_consumer_addr;
                    self.bx_fein_contradictory_id         := bx_fein_contradictory_id;
                    self.bx_fein_contradictory_in         := bx_fein_contradictory_in;
                    self.bx_fein_src_count                := bx_fein_src_count;
                    self.bx_inq_consumer_addr_cnt         := bx_inq_consumer_addr_cnt;
                    self.bx_inq_consumer_phn_cnt          := bx_inq_consumer_phn_cnt;
                    self.bx_irs_retirementplan            := bx_irs_retirementplan;
                    self.bx_name_src_count                := bx_name_src_count;
                    self.bx_phn_contradictory             := bx_phn_contradictory;
                    self.bx_phn_distance_addr             := bx_phn_distance_addr;
                    self.bx_phn_mobile                    := bx_phn_mobile;
                    self.bx_phn_not_in_zipcode            := bx_phn_not_in_zipcode;
                    self.bx_phn_problems                  := bx_phn_problems;
                    self.bx_phn_src_count                 := bx_phn_src_count;
                    self.bx_phn_verification              := bx_phn_verification;
                    self.bx_rep_addr_distance             := bx_rep_addr_distance;
                    self.bx_tin_match_consumer_associate  := bx_tin_match_consumer_associate;
                    self.ver_src_am_pos                   := ver_src_am_pos;
                    self._ver_src_fdate_am                := _ver_src_fdate_am;
                    self.ver_src_fdate_am                 := ver_src_fdate_am;
                    self.ver_src_ar_pos                   := ver_src_ar_pos;
                    self._ver_src_fdate_ar                := _ver_src_fdate_ar;
                    self.ver_src_fdate_ar                 := ver_src_fdate_ar;
                    self.ver_src_ba_pos                   := ver_src_ba_pos;
                    self._ver_src_fdate_ba                := _ver_src_fdate_ba;
                    self.ver_src_fdate_ba                 := ver_src_fdate_ba;
                    self.ver_src_cg_pos                   := ver_src_cg_pos;
                    self._ver_src_fdate_cg                := _ver_src_fdate_cg;
                    self.ver_src_fdate_cg                 := ver_src_fdate_cg;
                    self.ver_src_da_pos                   := ver_src_da_pos;
                    self._ver_src_fdate_da                := _ver_src_fdate_da;
                    self.ver_src_fdate_da                 := ver_src_fdate_da;
                    self.ver_src_d_pos                    := ver_src_d_pos;
                    self._ver_src_fdate_d                 := _ver_src_fdate_d;
                    self.ver_src_fdate_d                  := ver_src_fdate_d;
                    self.ver_src_dl_pos                   := ver_src_dl_pos;
                    self._ver_src_fdate_dl                := _ver_src_fdate_dl;
                    self.ver_src_fdate_dl                 := ver_src_fdate_dl;
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self._ver_src_fdate_eb                := _ver_src_fdate_eb;
                    self.ver_src_fdate_eb                 := ver_src_fdate_eb;
                    self.ver_src_e1_pos                   := ver_src_e1_pos;
                    self._ver_src_fdate_e1                := _ver_src_fdate_e1;
                    self.ver_src_fdate_e1                 := ver_src_fdate_e1;
                    self.ver_src_e2_pos                   := ver_src_e2_pos;
                    self._ver_src_fdate_e2                := _ver_src_fdate_e2;
                    self.ver_src_fdate_e2                 := ver_src_fdate_e2;
                    self.ver_src_e3_pos                   := ver_src_e3_pos;
                    self._ver_src_fdate_e3                := _ver_src_fdate_e3;
                    self.ver_src_fdate_e3                 := ver_src_fdate_e3;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self._ver_src_fdate_eq                := _ver_src_fdate_eq;
                    self.ver_src_fdate_eq                 := ver_src_fdate_eq;
                    self.ver_src_fe_pos                   := ver_src_fe_pos;
                    self._ver_src_fdate_fe                := _ver_src_fdate_fe;
                    self.ver_src_fdate_fe                 := ver_src_fdate_fe;
                    self.ver_src_ff_pos                   := ver_src_ff_pos;
                    self._ver_src_fdate_ff                := _ver_src_fdate_ff;
                    self.ver_src_fdate_ff                 := ver_src_fdate_ff;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self._ver_src_fdate_p                 := _ver_src_fdate_p;
                    self.ver_src_fdate_p                  := ver_src_fdate_p;
                    self.ver_src_pl_pos                   := ver_src_pl_pos;
                    self._ver_src_fdate_pl                := _ver_src_fdate_pl;
                    self.ver_src_fdate_pl                 := ver_src_fdate_pl;
                    self.ver_src_sl_pos                   := ver_src_sl_pos;
                    self._ver_src_fdate_sl                := _ver_src_fdate_sl;
                    self.ver_src_fdate_sl                 := ver_src_fdate_sl;
                    self.ver_src_v_pos                    := ver_src_v_pos;
                    self._ver_src_fdate_v                 := _ver_src_fdate_v;
                    self.ver_src_fdate_v                  := ver_src_fdate_v;
                    self.ver_src_vo_pos                   := ver_src_vo_pos;
                    self._ver_src_fdate_vo                := _ver_src_fdate_vo;
                    self.ver_src_fdate_vo                 := ver_src_fdate_vo;
                    self.ver_src_w_pos                    := ver_src_w_pos;
                    self._ver_src_fdate_w                 := _ver_src_fdate_w;
                    self.ver_src_fdate_w                  := ver_src_fdate_w;
                    self.ver_fname_src_en_pos             := ver_fname_src_en_pos;
                    self.ver_fname_src_en                 := ver_fname_src_en;
                    self.ver_fname_src_eq_pos             := ver_fname_src_eq_pos;
                    self.ver_fname_src_eq                 := ver_fname_src_eq;
                    self.ver_fname_src_tn_pos             := ver_fname_src_tn_pos;
                    self.ver_fname_src_tn                 := ver_fname_src_tn;
                    self.ver_lname_src_en_pos             := ver_lname_src_en_pos;
                    self.ver_lname_src_en                 := ver_lname_src_en;
                    self.ver_lname_src_eq_pos             := ver_lname_src_eq_pos;
                    self.ver_lname_src_eq                 := ver_lname_src_eq;
                    self.ver_lname_src_tn_pos             := ver_lname_src_tn_pos;
                    self.ver_lname_src_tn                 := ver_lname_src_tn;
                    self.ver_addr_src_en_pos              := ver_addr_src_en_pos;
                    self.ver_addr_src_en                  := ver_addr_src_en;
                    self.ver_addr_src_eq_pos              := ver_addr_src_eq_pos;
                    self.ver_addr_src_eq                  := ver_addr_src_eq;
                    self.ver_addr_src_tn_pos              := ver_addr_src_tn_pos;
                    self.ver_addr_src_tn                  := ver_addr_src_tn;
                    self.ver_ssn_src_en_pos               := ver_ssn_src_en_pos;
                    self.ver_ssn_src_en                   := ver_ssn_src_en;
                    self.ver_ssn_src_eq_pos               := ver_ssn_src_eq_pos;
                    self.ver_ssn_src_eq                   := ver_ssn_src_eq;
                    self.ver_ssn_src_tn_pos               := ver_ssn_src_tn_pos;
                    self.ver_ssn_src_tn                   := ver_ssn_src_tn;
                    self.ver_dob_src_en_pos               := ver_dob_src_en_pos;
                    self.ver_dob_src_en                   := ver_dob_src_en;
                    self.ver_dob_src_eq_pos               := ver_dob_src_eq_pos;
                    self.ver_dob_src_eq                   := ver_dob_src_eq;
                    self.ver_dob_src_tn_pos               := ver_dob_src_tn_pos;
                    self.ver_dob_src_tn                   := ver_dob_src_tn;
                    self.num_bureau_fname                 := num_bureau_fname;
                    self.num_bureau_lname                 := num_bureau_lname;
                    self.num_bureau_addr                  := num_bureau_addr;
                    self.num_bureau_ssn                   := num_bureau_ssn;
                    self.num_bureau_dob                   := num_bureau_dob;
                    self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
                    self.iv_bureau_verification_index     := iv_bureau_verification_index;
                    self.vo_pos                           := vo_pos;
                    self.vote_adl_lseen_vo                := vote_adl_lseen_vo;
                    self._vote_adl_lseen_vo               := _vote_adl_lseen_vo;
                    self.iv_mos_src_voter_adl_lseen       := iv_mos_src_voter_adl_lseen;
                    self.nf_add_dist_input_to_curr        := nf_add_dist_input_to_curr;
                    self.nf_average_rel_distance          := nf_average_rel_distance;
                    self.nf_bus_sos_filings_not_instate   := nf_bus_sos_filings_not_instate;
                    self.nf_fp_sourcerisktype             := nf_fp_sourcerisktype;
                    self.nf_fp_srchfraudsrchcountyr       := nf_fp_srchfraudsrchcountyr;
                    self.nf_fp_srchunvrfdphonecount       := nf_fp_srchunvrfdphonecount;
                    self.nf_fp_srchvelocityrisktype       := nf_fp_srchvelocityrisktype;
                    self.nf_historical_count              := nf_historical_count;
                    self.nf_inq_perbestssn_count12        := nf_inq_perbestssn_count12;
                    self.nf_link_candidate_cnt            := nf_link_candidate_cnt;
                    self.earliest_cred_date_all           := earliest_cred_date_all;
                    self.nf_m_src_credentialed_fs         := nf_m_src_credentialed_fs;
                    self.nf_pct_rel_prop_owned            := nf_pct_rel_prop_owned;
                    self.nf_ssns_per_curraddr_c6          := nf_ssns_per_curraddr_c6;
                    self.rv_i60_inq_count12               := rv_i60_inq_count12;
                    self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
                    self.bus_tree_0                       := bus_tree_0;
                    self.bus_tree_1                       := bus_tree_1;
                    self.bus_tree_2                       := bus_tree_2;
                    self.bus_tree_3                       := bus_tree_3;
                    self.bus_tree_4                       := bus_tree_4;
                    self.bus_tree_5                       := bus_tree_5;
                    self.bus_tree_6                       := bus_tree_6;
                    self.bus_tree_7                       := bus_tree_7;
                    self.bus_tree_8                       := bus_tree_8;
                    self.bus_tree_9                       := bus_tree_9;
                    self.bus_tree_10                      := bus_tree_10;
                    self.bus_tree_11                      := bus_tree_11;
                    self.bus_tree_12                      := bus_tree_12;
                    self.bus_tree_13                      := bus_tree_13;
                    self.bus_tree_14                      := bus_tree_14;
                    self.bus_tree_15                      := bus_tree_15;
                    self.bus_tree_16                      := bus_tree_16;
                    self.bus_tree_17                      := bus_tree_17;
                    self.bus_tree_18                      := bus_tree_18;
                    self.bus_tree_19                      := bus_tree_19;
                    self.bus_tree_20                      := bus_tree_20;
                    self.bus_tree_21                      := bus_tree_21;
                    self.bus_tree_22                      := bus_tree_22;
                    self.bus_tree_23                      := bus_tree_23;
                    self.bus_tree_24                      := bus_tree_24;
                    self.bus_tree_25                      := bus_tree_25;
                    self.bus_tree_26                      := bus_tree_26;
                    self.bus_tree_27                      := bus_tree_27;
                    self.bus_tree_28                      := bus_tree_28;
                    self.bus_tree_29                      := bus_tree_29;
                    self.bus_tree_30                      := bus_tree_30;
                    self.bus_tree_31                      := bus_tree_31;
                    self.bus_tree_32                      := bus_tree_32;
                    self.bus_tree_33                      := bus_tree_33;
                    self.bus_tree_34                      := bus_tree_34;
                    self.bus_tree_35                      := bus_tree_35;
                    self.bus_tree_36                      := bus_tree_36;
                    self.bus_tree_37                      := bus_tree_37;
                    self.bus_tree_38                      := bus_tree_38;
                    self.bus_tree_39                      := bus_tree_39;
                    self.bus_tree_40                      := bus_tree_40;
                    self.bus_tree_41                      := bus_tree_41;
                    self.bus_tree_42                      := bus_tree_42;
                    self.bus_tree_43                      := bus_tree_43;
                    self.bus_tree_44                      := bus_tree_44;
                    self.bus_tree_45                      := bus_tree_45;
                    self.bus_tree_46                      := bus_tree_46;
                    self.bus_tree_47                      := bus_tree_47;
                    self.bus_tree_48                      := bus_tree_48;
                    self.bus_tree_49                      := bus_tree_49;
                    self.bus_tree_50                      := bus_tree_50;
                    self.bus_tree_51                      := bus_tree_51;
                    self.bus_tree_52                      := bus_tree_52;
                    self.bus_tree_53                      := bus_tree_53;
                    self.bus_tree_54                      := bus_tree_54;
                    self.bus_tree_55                      := bus_tree_55;
                    self.bus_tree_56                      := bus_tree_56;
                    self.bus_tree_57                      := bus_tree_57;
                    self.bus_tree_58                      := bus_tree_58;
                    self.bus_tree_59                      := bus_tree_59;
                    self.bus_tree_60                      := bus_tree_60;
                    self.bus_tree_61                      := bus_tree_61;
                    self.bus_tree_62                      := bus_tree_62;
                    self.bus_tree_63                      := bus_tree_63;
                    self.bus_tree_64                      := bus_tree_64;
                    self.bus_tree_65                      := bus_tree_65;
                    self.bus_tree_66                      := bus_tree_66;
                    self.bus_tree_67                      := bus_tree_67;
                    self.bus_tree_68                      := bus_tree_68;
                    self.bus_tree_69                      := bus_tree_69;
                    self.bus_tree_70                      := bus_tree_70;
                    self.bus_tree_71                      := bus_tree_71;
                    self.bus_tree_72                      := bus_tree_72;
                    self.bus_tree_73                      := bus_tree_73;
                    self.bus_tree_74                      := bus_tree_74;
                    self.bus_tree_75                      := bus_tree_75;
                    self.bus_tree_76                      := bus_tree_76;
                    self.bus_tree_77                      := bus_tree_77;
                    self.bus_tree_78                      := bus_tree_78;
                    self.bus_tree_79                      := bus_tree_79;
                    self.bus_tree_80                      := bus_tree_80;
                    self.bus_tree_81                      := bus_tree_81;
                    self.bus_tree_82                      := bus_tree_82;
                    self.bus_tree_83                      := bus_tree_83;
                    self.bus_tree_84                      := bus_tree_84;
                    self.bus_tree_85                      := bus_tree_85;
                    self.bus_tree_86                      := bus_tree_86;
                    self.bus_tree_87                      := bus_tree_87;
                    self.bus_tree_88                      := bus_tree_88;
                    self.bus_tree_89                      := bus_tree_89;
                    self.bus_tree_90                      := bus_tree_90;
                    self.bus_tree_91                      := bus_tree_91;
                    self.bus_tree_92                      := bus_tree_92;
                    self.bus_tree_93                      := bus_tree_93;
                    self.bus_tree_94                      := bus_tree_94;
                    self.bus_tree_95                      := bus_tree_95;
                    self.bus_tree_96                      := bus_tree_96;
                    self.bus_tree_97                      := bus_tree_97;
                    self.bus_tree_98                      := bus_tree_98;
                    self.bus_tree_99                      := bus_tree_99;
                    self.bus_tree_100                     := bus_tree_100;
                    self.bus_tree_101                     := bus_tree_101;
                    self.bus_tree_102                     := bus_tree_102;
                    self.bus_tree_103                     := bus_tree_103;
                    self.bus_tree_104                     := bus_tree_104;
                    self.bus_tree_105                     := bus_tree_105;
                    self.bus_tree_106                     := bus_tree_106;
                    self.bus_tree_107                     := bus_tree_107;
                    self.bus_tree_108                     := bus_tree_108;
                    self.bus_tree_109                     := bus_tree_109;
                    self.bus_tree_110                     := bus_tree_110;
                    self.bus_tree_111                     := bus_tree_111;
                    self.bus_tree_112                     := bus_tree_112;
                    self.bus_tree_113                     := bus_tree_113;
                    self.bus_tree_114                     := bus_tree_114;
                    self.bus_tree_115                     := bus_tree_115;
                    self.bus_tree_116                     := bus_tree_116;
                    self.bus_tree_117                     := bus_tree_117;
                    self.bus_tree_118                     := bus_tree_118;
                    self.bus_tree_119                     := bus_tree_119;
                    self.bus_tree_120                     := bus_tree_120;
                    self.bus_tree_121                     := bus_tree_121;
                    self.bus_tree_122                     := bus_tree_122;
                    self.bus_tree_123                     := bus_tree_123;
                    self.bus_tree_124                     := bus_tree_124;
                    self.bus_tree_125                     := bus_tree_125;
                    self.bus_tree_126                     := bus_tree_126;
                    self.bus_tree_127                     := bus_tree_127;
                    self.bus_tree_128                     := bus_tree_128;
                    self.bus_tree_129                     := bus_tree_129;
                    self.bus_tree_130                     := bus_tree_130;
                    self.bus_tree_131                     := bus_tree_131;
                    self.bus_tree_132                     := bus_tree_132;
                    self.bus_tree_133                     := bus_tree_133;
                    self.bus_tree_134                     := bus_tree_134;
                    self.bus_tree_135                     := bus_tree_135;
                    self.bus_tree_136                     := bus_tree_136;
                    self.bus_tree_137                     := bus_tree_137;
                    self.bus_tree_138                     := bus_tree_138;
                    self.bus_tree_139                     := bus_tree_139;
                    self.bus_tree_140                     := bus_tree_140;
                    self.bus_tree_141                     := bus_tree_141;
                    self.bus_tree_142                     := bus_tree_142;
                    self.bus_tree_143                     := bus_tree_143;
                    self.bus_tree_144                     := bus_tree_144;
                    self.bus_tree_145                     := bus_tree_145;
                    self.bus_tree_146                     := bus_tree_146;
                    self.bus_tree_147                     := bus_tree_147;
                    self.bus_tree_148                     := bus_tree_148;
                    self.bus_tree_149                     := bus_tree_149;
                    self.bus_tree_150                     := bus_tree_150;
                    self.bus_tree_151                     := bus_tree_151;
                    self.bus_tree_152                     := bus_tree_152;
                    self.bus_tree_153                     := bus_tree_153;
                    self.bus_tree_154                     := bus_tree_154;
                    self.bus_tree_155                     := bus_tree_155;
                    self.bus_tree_156                     := bus_tree_156;
                    self.bus_tree_157                     := bus_tree_157;
                    self.bus_tree_158                     := bus_tree_158;
                    self.bus_tree_159                     := bus_tree_159;
                    self.bus_tree_160                     := bus_tree_160;
                    self.bus_tree_161                     := bus_tree_161;
                    self.bus_tree_162                     := bus_tree_162;
                    self.bus_tree_163                     := bus_tree_163;
                    self.bus_tree_164                     := bus_tree_164;
                    self.bus_tree_165                     := bus_tree_165;
                    self.bus_tree_166                     := bus_tree_166;
                    self.bus_tree_167                     := bus_tree_167;
                    self.bus_tree_168                     := bus_tree_168;
                    self.bus_tree_169                     := bus_tree_169;
                    self.bus_tree_170                     := bus_tree_170;
                    self.bus_tree_171                     := bus_tree_171;
                    self.bus_tree_172                     := bus_tree_172;
                    self.bus_tree_173                     := bus_tree_173;
                    self.bus_tree_174                     := bus_tree_174;
                    self.bus_tree_175                     := bus_tree_175;
                    self.bus_tree_176                     := bus_tree_176;
                    self.bus_tree_177                     := bus_tree_177;
                    self.bus_tree_178                     := bus_tree_178;
                    self.bus_tree_179                     := bus_tree_179;
                    self.bus_tree_180                     := bus_tree_180;
                    self.bus_tree_181                     := bus_tree_181;
                    self.bus_tree_182                     := bus_tree_182;
                    self.bus_tree_183                     := bus_tree_183;
                    self.bus_tree_184                     := bus_tree_184;
                    self.bus_tree_185                     := bus_tree_185;
                    self.bus_tree_186                     := bus_tree_186;
                    self.bus_tree_187                     := bus_tree_187;
                    self.bus_tree_188                     := bus_tree_188;
                    self.bus_tree_189                     := bus_tree_189;
                    self.bus_tree_190                     := bus_tree_190;
                    self.bus_tree_191                     := bus_tree_191;
                    self.bus_tree_192                     := bus_tree_192;
                    self.bus_tree_193                     := bus_tree_193;
                    self.bus_tree_194                     := bus_tree_194;
                    self.bus_tree_195                     := bus_tree_195;
                    self.bus_tree_196                     := bus_tree_196;
                    self.bus_tree_197                     := bus_tree_197;
                    self.bus_tree_198                     := bus_tree_198;
                    self.bus_tree_199                     := bus_tree_199;
                    self.bus_tree_200                     := bus_tree_200;
                    self.bus_tree_201                     := bus_tree_201;
                    self.bus_tree_202                     := bus_tree_202;
                    self.bus_tree_203                     := bus_tree_203;
                    self.bus_tree_204                     := bus_tree_204;
                    self.bus_tree_205                     := bus_tree_205;
                    self.bus_tree_206                     := bus_tree_206;
                    self.bus_tree_207                     := bus_tree_207;
                    self.bus_tree_208                     := bus_tree_208;
                    self.bus_tree_209                     := bus_tree_209;
                    self.bus_tree_210                     := bus_tree_210;
                    self.bus_tree_211                     := bus_tree_211;
                    self.bus_tree_212                     := bus_tree_212;
                    self.bus_tree_213                     := bus_tree_213;
                    self.bus_tree_214                     := bus_tree_214;
                    self.bus_tree_215                     := bus_tree_215;
                    self.bus_tree_216                     := bus_tree_216;
                    self.bus_tree_217                     := bus_tree_217;
                    self.bus_tree_218                     := bus_tree_218;
                    self.bus_tree_219                     := bus_tree_219;
                    self.bus_tree_220                     := bus_tree_220;
                    self.bus_tree_221                     := bus_tree_221;
                    self.bus_tree_222                     := bus_tree_222;
                    self.bus_tree_223                     := bus_tree_223;
                    self.bus_tree_224                     := bus_tree_224;
                    self.bus_tree_225                     := bus_tree_225;
                    self.bus_tree_226                     := bus_tree_226;
                    self.bus_tree_227                     := bus_tree_227;
                    self.bus_tree_228                     := bus_tree_228;
                    self.bus_tree_229                     := bus_tree_229;
                    self.bus_tree_230                     := bus_tree_230;
                    self.bus_tree_231                     := bus_tree_231;
                    self.bus_tree_232                     := bus_tree_232;
                    self.bus_tree_233                     := bus_tree_233;
                    self.bus_tree_234                     := bus_tree_234;
                    self.bus_tree_235                     := bus_tree_235;
                    self.bus_tree_236                     := bus_tree_236;
                    self.bus_tree_237                     := bus_tree_237;
                    self.bus_tree_238                     := bus_tree_238;
                    self.bus_tree_239                     := bus_tree_239;
                    self.bus_tree_240                     := bus_tree_240;
                    self.bus_tree_241                     := bus_tree_241;
                    self.bus_tree_242                     := bus_tree_242;
                    self.bus_tree_243                     := bus_tree_243;
                    self.bus_tree_244                     := bus_tree_244;
                    self.bus_tree_245                     := bus_tree_245;
                    self.bus_tree_246                     := bus_tree_246;
                    self.bus_tree_247                     := bus_tree_247;
                    self.bus_tree_248                     := bus_tree_248;
                    self.bus_tree_249                     := bus_tree_249;
                    self.bus_tree_250                     := bus_tree_250;
                    self.bus_tree_251                     := bus_tree_251;
                    self.bus_tree_252                     := bus_tree_252;
                    self.bus_tree_253                     := bus_tree_253;
                    self.bus_tree_254                     := bus_tree_254;
                    self.bus_tree_255                     := bus_tree_255;
                    self.bus_tree_256                     := bus_tree_256;
                    self.bus_tree_257                     := bus_tree_257;
                    self.bus_tree_258                     := bus_tree_258;
                    self.bus_tree_259                     := bus_tree_259;
                    self.bus_tree_260                     := bus_tree_260;
                    self.bus_tree_261                     := bus_tree_261;
                    self.bus_tree_262                     := bus_tree_262;
                    self.bus_tree_263                     := bus_tree_263;
                    self.bus_tree_264                     := bus_tree_264;
                    self.bus_tree_265                     := bus_tree_265;
                    self.bus_tree_266                     := bus_tree_266;
                    self.bus_tree_267                     := bus_tree_267;
                    self.bus_gbm_logit                    := bus_gbm_logit;
                    self.pbr                              := pbr;
                    self.offset                           := offset;
                    self.lgt                              := lgt;
                    self.bus_score                        := bus_score;
                    self.con_v01_w                        := con_v01_w;
                    self.con_v02_w                        := con_v02_w;
                    self.con_v03_w                        := con_v03_w;
                    self.con_v04_w                        := con_v04_w;
                    self.con_v05_w                        := con_v05_w;
                    self.con_v06_w                        := con_v06_w;
                    self.con_v07_w                        := con_v07_w;
                    self.con_v08_w                        := con_v08_w;
                    self.con_v09_w                        := con_v09_w;
                    self.con_v10_w                        := con_v10_w;
                    self.con_v11_w                        := con_v11_w;
                    self.con_v12_w                        := con_v12_w;
                    self.con_v13_w                        := con_v13_w;
                    self.con_v14_w                        := con_v14_w;
                    self.con_v15_w                        := con_v15_w;
                    self.con_lgt                          := con_lgt;
                    self.con_score                        := con_score;
                    self.bln_v01_w                        := bln_v01_w;
                    self.bln_v02_w                        := bln_v02_w;
                    self.bln_v03_w                        := bln_v03_w;
                    self.bln_v04_w                        := bln_v04_w;
                    self.bln_v05_w                        := bln_v05_w;
                    self.bln_v06_w                        := bln_v06_w;
                    self.bln_v07_w                        := bln_v07_w;
                    self.bln_v08_w                        := bln_v08_w;
                    self.bln_v09_w                        := bln_v09_w;
                    self.bln_v10_w                        := bln_v10_w;
                    self.bln_v11_w                        := bln_v11_w;
                    self.bln_v12_w                        := bln_v12_w;
                    self.bln_v13_w                        := bln_v13_w;
                    self.bln_v14_w                        := bln_v14_w;
                    self.bln_v15_w                        := bln_v15_w;
                    self.bln_v16_w                        := bln_v16_w;
                    self.bln_v17_w                        := bln_v17_w;
                    self.bln_v18_w                        := bln_v18_w;
                    self.bln_lgt                          := bln_lgt;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.bln_score                        := bln_score;
                    self.unscrbl_bus                      := unscrbl_bus;
                    self.unscrbl_con                      := unscrbl_con;
                    self.bbfm1906_1_0                     := bbfm1906_1_0;


                     SELF.clam                            := le.clam ;  
                     self.Busshell                        := le.Busshell ;
                     // SELF.clam                            := ri;  
                     // self.Busshell                        = le ;
                     
                    reasonCodes := Models.BB_WarningCodes(le.clam, le.Busshell , num_reasons, business_only_check)[1].hris;
                    self.bbfm_wc1                         := reasonCodes[1].hri;//bbfm_wc
                    self.bbfm_wc2                         := reasonCodes[2].hri;
                    self.bbfm_wc3                         := reasonCodes[3].hri;
                    self.bbfm_wc4                         := reasonCodes[4].hri;
  
  #else
     
      reasonCodes := Models.BB_WarningCodes(le.clam, le.Busshell , num_reasons, business_only_check)[1].hris;
      
      rCodes := DATASET([{'11B',Risk_Indicators.getHRIDesc('11B')}
                        ], Risk_Indicators.Layout_Desc);
                        
      cScore := (STRING3)BBFM1906_1_0;
      
      SELF.ri := IF(cScore = '222',
                    rCodes,
                    PROJECT(reasonCodes, 
                        TRANSFORM(Risk_Indicators.Layout_Desc,
                            SELF.hri := LEFT.hri,
                            SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
                                 )
                           )
                   );
                                          
                                          

      SELF.score := cScore;
      SELF.seq := le.busshell.input_echo.seq;
  
  #end   
  

      END;

   model :=   project(busshellplusclam, doModel(left) );
	
 

  
  
	return model;
END;

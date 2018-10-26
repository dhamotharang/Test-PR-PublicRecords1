import Std, risk_indicators, riskwise, riskwisefcra, ut, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1803_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons  
									  ):= FUNCTION
	

  
  
  
  
  
		// FP_DEBUG := True;
		 FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
  /* Model Input Variables */
                    STRING10 model_name;
                    unsigned4 seq;
		                INTEGER   sysdate                          ; //       := sysdate;
                    INTEGER   ver_src_am_pos                   ; //       := ver_src_am_pos;
                    BOOLEAN   ver_src_am                        ; //       := ver_src_am;
                    INTEGER   ver_src_ar_pos                    ; //       := ver_src_ar_pos;
                    BOOLEAN   ver_src_ar                        ; //       := ver_src_ar;
                    INTEGER   ver_src_ba_pos                    ; //       := ver_src_ba_pos;
                    BOOLEAN   ver_src_ba                        ; //       := ver_src_ba;
                    INTEGER   ver_src_cg_pos                   ; //       := ver_src_cg_pos;
                    BOOLEAN   ver_src_cg                       ; //       := ver_src_cg;
                    INTEGER   ver_src_da_pos                   ; //       := ver_src_da_pos;
                    BOOLEAN   ver_src_da                       ; //       := ver_src_da;
                    INTEGER   ver_src_d_pos                    ; //       := ver_src_d_pos;
                    BOOLEAN   ver_src_d                        ; //       := ver_src_d;
                    INTEGER   ver_src_dl_pos                   ; //       := ver_src_dl_pos;
                    BOOLEAN   ver_src_dl                       ; //       := ver_src_dl;
                    INTEGER   ver_src_eb_pos                   ; //       := ver_src_eb_pos;
                    BOOLEAN   ver_src_eb                       ; //       := ver_src_eb;
                    INTEGER   ver_src_e1_pos                   ; //       := ver_src_e1_pos;
                    BOOLEAN   ver_src_e1                       ; //       := ver_src_e1;
                    INTEGER   ver_src_e2_pos                   ; //       := ver_src_e2_pos;
                    BOOLEAN   ver_src_e2                       ; //       := ver_src_e2;
                    INTEGER   ver_src_e3_pos                   ; //       := ver_src_e3_pos;
                    BOOLEAN   ver_src_e3                       ; //       := ver_src_e3;
                    INTEGER   ver_src_en_pos                   ; //       := ver_src_en_pos;
                    BOOLEAN   ver_src_en                       ; //       := ver_src_en;
                    INTEGER   ver_src_eq_pos                   ; //       := ver_src_eq_pos;
                    BOOLEAN   ver_src_eq                       ; //       := ver_src_eq;
                    INTEGER   ver_src_fe_pos                   ; //       := ver_src_fe_pos;
                    BOOLEAN   ver_src_fe                       ; //       := ver_src_fe;
                    INTEGER   ver_src_ff_pos                   ; //       := ver_src_ff_pos;
                    BOOLEAN   ver_src_ff                       ; //       := ver_src_ff;
                    INTEGER   ver_src_p_pos                    ; //       := ver_src_p_pos;
                    BOOLEAN   ver_src_p                        ; //       := ver_src_p;
                    INTEGER   ver_src_pl_pos                   ; //       := ver_src_pl_pos;
                    BOOLEAN   ver_src_pl                       ; //       := ver_src_pl;
                    INTEGER   ver_src_tn_pos                   ; //       := ver_src_tn_pos;
                    BOOLEAN   ver_src_tn                       ; //       := ver_src_tn;
                    INTEGER   ver_src_sl_pos                   ; //       := ver_src_sl_pos;
                    BOOLEAN   ver_src_sl                       ; //       := ver_src_sl;
                    INTEGER   ver_src_v_pos                    ; //       := ver_src_v_pos;
                    BOOLEAN   ver_src_v                        ; //       := ver_src_v;
                    INTEGER   ver_src_vo_pos                   ; //       := ver_src_vo_pos;
                    BOOLEAN   ver_src_vo                       ; //       := ver_src_vo;
                    INTEGER   ver_src_w_pos                    ; //       := ver_src_w_pos;
                    BOOLEAN   ver_src_w                        ; //       := ver_src_w;
                    INTEGER   ver_fname_src_en_pos             ; //       := ver_fname_src_en_pos;
                    BOOLEAN   ver_fname_src_en                 ; //       := ver_fname_src_en;
                    INTEGER   ver_fname_src_eq_pos             ; //       := ver_fname_src_eq_pos;
                    BOOLEAN   ver_fname_src_eq                 ; //       := ver_fname_src_eq;
                    INTEGER   ver_fname_src_tn_pos             ; //       := ver_fname_src_tn_pos;
                    BOOLEAN   ver_fname_src_tn                 ; //       := ver_fname_src_tn;
                    INTEGER   ver_fname_src_ts_pos             ; //       := ver_fname_src_ts_pos;
                    BOOLEAN   ver_fname_src_ts                 ; //       := ver_fname_src_ts;
                    INTEGER   ver_fname_src_tu_pos             ; //       := ver_fname_src_tu_pos;
                    BOOLEAN   ver_fname_src_tu                 ; //       := ver_fname_src_tu;
                    INTEGER   ver_lname_src_en_pos             ; //       := ver_lname_src_en_pos;
                    BOOLEAN   ver_lname_src_en                 ; //       := ver_lname_src_en;
                    INTEGER   ver_lname_src_eq_pos             ; //       := ver_lname_src_eq_pos;
                    BOOLEAN   ver_lname_src_eq                 ; //       := ver_lname_src_eq;
                    INTEGER   ver_lname_src_tn_pos             ; //       := ver_lname_src_tn_pos;
                    BOOLEAN   ver_lname_src_tn                 ; //       := ver_lname_src_tn;
                    INTEGER   ver_lname_src_ts_pos             ; //       := ver_lname_src_ts_pos;
                    BOOLEAN   ver_lname_src_ts                 ; //       := ver_lname_src_ts;
                    INTEGER   ver_lname_src_tu_pos             ; //       := ver_lname_src_tu_pos;
                    BOOLEAN   ver_lname_src_tu                 ; //       := ver_lname_src_tu;
                    INTEGER   ver_addr_src_en_pos              ; //       := ver_addr_src_en_pos;
                    BOOLEAN   ver_addr_src_en                  ; //       := ver_addr_src_en;
                    INTEGER   ver_addr_src_eq_pos              ; //       := ver_addr_src_eq_pos;
                    BOOLEAN   ver_addr_src_eq                  ; //       := ver_addr_src_eq;
                    INTEGER   ver_addr_src_tn_pos              ; //       := ver_addr_src_tn_pos;
                    BOOLEAN   ver_addr_src_tn                  ; //       := ver_addr_src_tn;
                    INTEGER   ver_addr_src_ts_pos              ; //       := ver_addr_src_ts_pos;
                    BOOLEAN   ver_addr_src_ts                  ; //       := ver_addr_src_ts;
                    INTEGER   ver_addr_src_tu_pos              ; //       := ver_addr_src_tu_pos;
                    BOOLEAN   ver_addr_src_tu                  ; //       := ver_addr_src_tu;
                    INTEGER   ver_ssn_src_en_pos               ; //       := ver_ssn_src_en_pos;
                    BOOLEAN   ver_ssn_src_en                   ; //       := ver_ssn_src_en;
                    INTEGER   ver_ssn_src_eq_pos               ; //       := ver_ssn_src_eq_pos;
                    BOOLEAN   ver_ssn_src_eq                   ; //       := ver_ssn_src_eq;
                    INTEGER   ver_ssn_src_tn_pos               ; //       := ver_ssn_src_tn_pos;
                    BOOLEAN   ver_ssn_src_tn                   ; //       := ver_ssn_src_tn;
                    INTEGER   ver_ssn_src_ts_pos               ; //       := ver_ssn_src_ts_pos;
                    boolean   ver_ssn_src_ts                   ; //       := ver_ssn_src_ts;
                    INTEGER   ver_ssn_src_tu_pos               ; //       := ver_ssn_src_tu_pos;
                    boolean   ver_ssn_src_tu                   ; //       := ver_ssn_src_tu;
                    INTEGER   ver_dob_src_en_pos               ; //       := ver_dob_src_en_pos;
                    boolean   ver_dob_src_en                   ; //       := ver_dob_src_en;
                    INTEGER   ver_dob_src_eq_pos               ; //       := ver_dob_src_eq_pos;
                    boolean   ver_dob_src_eq                   ; //       := ver_dob_src_eq;
                    INTEGER   ver_dob_src_tn_pos               ; //       := ver_dob_src_tn_pos;
                    boolean   ver_dob_src_tn                   ; //       := ver_dob_src_tn;
                    INTEGER   ver_dob_src_ts_pos               ; //       := ver_dob_src_ts_pos;
                    boolean   ver_dob_src_ts                   ; //       := ver_dob_src_ts;
                    INTEGER   ver_dob_src_tu_pos               ; //       := ver_dob_src_tu_pos;
                    BOOLEAN   ver_dob_src_tu                   ; //       := ver_dob_src_tu;
                    INTEGER   rv_e58_br_dead_business_count    ; //       := rv_e58_br_dead_business_count;
                    INTEGER   nf_inq_per_phone                 ; //       := nf_inq_per_phone;
                    INTEGER   nf_phone_ver_experian            ; //       := nf_phone_ver_experian;
                    INTEGER   rv_d31_filing_ct120              ; //       := rv_d31_filing_ct120;
                    INTEGER   nf_inq_corrphonessn              ; //       := nf_inq_corrphonessn;
                    INTEGER   nf_email_name_addr_ver           ; //       := nf_email_name_addr_ver;
                    INTEGER   iv_inq_count01                   ; //       := iv_inq_count01;
                    INTEGER   nf_fp_varrisktype                ; //       := nf_fp_varrisktype;
                    INTEGER   nf_inq_lnamesperaddr_count12     ; //       := nf_inq_lnamesperaddr_count12;
                    INTEGER   nf_fp_idverrisktype              ; //       := nf_fp_idverrisktype;
                    INTEGER   nf_inq_per_ssn                   ; //       := nf_inq_per_ssn;
                    INTEGER   nf_fp_curraddrmedianincome       ; //       := nf_fp_curraddrmedianincome;
                    INTEGER   nf_sum_src_credentialed          ; //       := nf_sum_src_credentialed;
                    INTEGER   iv_unverified_addr_count         ; //       := iv_unverified_addr_count;
                    INTEGER   rv_i60_inq_comm_recency          ; //       := rv_i60_inq_comm_recency;
                    INTEGER   vo_pos                           ; //       := vo_pos;
                    INTEGER   iv_src_voter_adl_count           ; //       := iv_src_voter_adl_count;
                    string   fullemail                        ; //       := fullemail;
                    string   local_part                       ; //       := local_part;
                    string   e_fname                          ; //       := e_fname;
                    string   e_lname                          ; //       := e_lname;
                    INTEGER   em_fname_characters_present      ; //       := em_fname_characters_present;
                    INTEGER   em_fname_starts_w_firstchar      ; //       := em_fname_starts_w_firstchar;
                    INTEGER   em_lname_characters_present      ; //       := em_lname_characters_present;
                    INTEGER   em_lname_starts_w_firstchar      ; //       := em_lname_starts_w_firstchar;
                    INTEGER   em_name_contains_initials        ; //       := em_name_contains_initials;
                    INTEGER   _matching_fname_chars            ; //       := _matching_fname_chars;
                    INTEGER   _matching_lname_chars            ; //       := _matching_lname_chars;
                    real   em_name_pct_of_fn_ln_contained   ; //       := em_name_pct_of_fn_ln_contained;
                    real   o_v01_w                          ; //       := o_v01_w;
                    real   o_v02_w                          ; //       := o_v02_w;
                    real   o_v03_w                          ; //       := o_v03_w;
                    real   o_v04_w                          ; //       := o_v04_w;
                    real   o_v05_w                          ; //       := o_v05_w;
                    real   o_v06_w                          ; //       := o_v06_w;
                    real   o_v07_w                          ; //       := o_v07_w;
                    real   o_v08_w                          ; //       := o_v08_w;
                    real   o_v09_w                          ; //       := o_v09_w;
                    real   o_v10_w                          ; //       := o_v10_w;
                    real   o_v11_w                          ; //       := o_v11_w;
                    real   o_v12_w                          ; //       := o_v12_w;
                    real   o_v13_w                          ; //       := o_v13_w;
                    real   o_v14_w                          ; //       := o_v14_w;
                    real   o_v15_w                          ; //       := o_v15_w;
                    real   o_v16_w                          ; //       := o_v16_w;
                    real   o_v17_w                          ; //       := o_v17_w;
                    real   o_lgt                            ; //       := o_lgt;
                    integer   base                             ; //       := base;
                    decimal   odds                             ; //       := odds;
                    integer   point                            ; //       := point;
                    integer   fp1803_1_0                       ; //       := fp1803_1_0;
                    INTEGER   _sum_bureau                      ; //       := _sum_bureau;
                    INTEGER   _sum_credentialed                ; //       := _sum_credentialed;
                    INTEGER   _prop_owner_history              ; //       := _prop_owner_history;
                    INTEGER   beta_synthid_trigger             ; //       := beta_synthid_trigger;
                    INTEGER   num_bureau_fname                 ; //       := num_bureau_fname;
                    INTEGER   num_bureau_lname                 ; //       := num_bureau_lname;
                    INTEGER   num_bureau_addr                  ; //       := num_bureau_addr;
                    INTEGER   num_bureau_ssn                   ; //       := num_bureau_ssn;
                    INTEGER   num_bureau_dob                   ; //       := num_bureau_dob;
                    INTEGER   iv_bureau_verification_index     ; //       := iv_bureau_verification_index;
                    INTEGER   rv_c15_ssns_per_adl_c6_v2        ; //       := rv_c15_ssns_per_adl_c6_v2;
                    INTEGER   rv_s65_ssn_prior_dob             ; //       := rv_s65_ssn_prior_dob;
                    INTEGER   rv_c15_ssns_per_adl              ; //       := rv_c15_ssns_per_adl;
                    INTEGER   _rc_ssnhighissue                 ; //       := _rc_ssnhighissue;
                    INTEGER   ca_m_snc_ssn_high_issue          ; //       := ca_m_snc_ssn_high_issue;
                    boolean   co_tgr_fla_bureau_no_ssn         ; //       := co_tgr_fla_bureau_no_ssn;
                    boolean   sc_tgr_ssn_fs_6mo                ; //       := sc_tgr_ssn_fs_6mo;
                    boolean   sc_tgr_ssn_input_not_best        ; //       := sc_tgr_ssn_input_not_best;
                    boolean   sc_tgr_ssn_prior_dob             ; //       := sc_tgr_ssn_prior_dob;
                    boolean   co_tgr_ssns_per_adl              ; //       := co_tgr_ssns_per_adl;
                    boolean   co_did_count                     ; //       := co_did_count;
                    boolean   co_ssn_high_issue                ; //       := co_ssn_high_issue;
                    integer   beta_cpn_trigger                 ; //       := beta_cpn_trigger;
                    BOOLEAN   _ver_src_ds                      ; //       := _ver_src_ds;
                    BOOLEAN   _ver_src_de                      ; //       := _ver_src_de;
                    BOOLEAN   _derog                           ; //       := _derog;
                    BOOLEAN   _deceased                        ; //       := _deceased;
                    BOOLEAN   _ssnpriortodob                   ; //       := _ssnpriortodob;
                    BOOLEAN   _inputmiskeys                    ; //       := _inputmiskeys;
                    boolean   _multiplessns                    ; //       := _multiplessns;
                    integer   _hh_strikes                      ; //       := _hh_strikes;
                    integer   stolenid                         ; //       := stolenid;
                    integer   manipulatedid                    ; //       := manipulatedid;
                    integer   manipulatedidpt2                 ; //       := manipulatedidpt2;
                    integer   suspiciousactivity               ; //       := suspiciousactivity;
                    integer   vulnerablevictim                 ; //       := vulnerablevictim;
                    integer   friendlyfraud                    ; //       := friendlyfraud;
                    integer   stolenc_fp1803_1_0               ; //       := stolenc_fp1803_1_0;
                    integer   synthc_fp1803_1_0                ; //       := synthc_fp1803_1_0;
                    integer   manip2c_fp1803_1_0               ; //       := manip2c_fp1803_1_0;
                    integer   suspactc_fp1803_1_0              ; //       := suspactc_fp1803_1_0;
                    integer   vulnvicc_fp1803_1_0              ; //       := vulnvicc_fp1803_1_0;
                    integer   friendlyc_fp1803_1_0             ; //       := friendlyc_fp1803_1_0;
                    integer   custstolidindex                  ; //       := custstolidindex;
                    integer   custmanipidindex                 ; //       := custmanipidindex;
                    integer   custsynthidindex                 ; //       := custsynthidindex;
                    integer   custsuspactindex                 ; //       := custsuspactindex;
                    integer   custvulnvicindex                 ; //       := custvulnvicindex;
                    integer   custfriendfrdindex               ;//       := custfriendfrdindex;

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
   
  
  filing_count120                  := le.bjl.filing_count120;
	inq_corrphonessn                 := le.acc_logs.inq_corrphonessn;
	in_lname                         := le.shell_input.lname; 
  
  
	input_ssn_isbestmatch            := le.best_flags.input_ssn_isbestmatch;
	truedid                          := le.truedid;
	in_fname                         := le.shell_input.fname;
	in_email_address                 := le.shell_input.email_address;
	nas_summary                      := le.iid.nas_summary;
	did_count                        := if(isFCRA, 0, le.iid.didcount);
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnhighissue                  := (unsigned)le.iid.soclhighissue;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ver_fname_sources                := le.header_summary.ver_fname_sources;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	voter_avail                      := le.available_sources.voter;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	emailpop                         := le.input_validation.email;
	hphnpop                          := le.input_validation.homephone;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_prison_history             := le.other_address_info.isprison;
	unverified_addr_count            := le.address_verification.unverified_addr_count;
	phone_ver_experian               := le.Experian_Phone_Verification;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	//lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl)_created_6months;
	lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_perssn                       := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
	inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
	inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
	br_dead_business_count           := le.employment.dead_business_ct;
	stl_inq_count                    := le.impulse.count;
	email_name_addr_verification     := le.email_summary.reverse_email.verification_level;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_curraddrmedianincome          := le.fdattributesv2.curraddrmedianincome;
	felony_count                     := le.bjl.felony_count;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_criminals                     := le.hhid_summary.hh_criminals;
	rel_felony_count                 := le.relatives.relative_felony_count;
	inferred_age                     := le.inferred_age;





//***Begining of the SAS code that was converted to ECL ****//
NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


integer fn_findLongestSubstring( STRING nameToFind = '', STRING emailPrefix = '') :=
  FUNCTION
  // take inputs and remove all spaces, convert to upper case  

  nm1 := If( STD.Str.Find(nameToFind, ' ',1)=0, length(nameToFind), STD.Str.Find(nameToFind, ' ',1)-1);
  em1 := If( STD.Str.Find(emailPrefix, ' ',1)=0, length(emailPrefix), STD.Str.Find(emailPrefix, ' ',1)-1);
  
  nm := Std.Str.ToUpperCase((nameToFind)[1..nm1]);
  em := Std.Str.ToUpperCase((emailPrefix)[1..em1]);
 
    layout_substr := { STRING substr };
    layout_found  := { UNSIGNED1 len, STRING substr, BOOLEAN isFound };
    ds_stringToFind := DATASET([{nm}],layout_substr);
    
    ds_substr := 
      NORMALIZE( 
        ds_stringToFind, 
        LENGTH (nm), 
        TRANSFORM( layout_substr,
          SELF.substr := LEFT.substr[1..COUNTER];
        )
      );

    ds_substr_found :=
      PROJECT(
        ds_substr, 
        TRANSFORM( layout_found,
          SELF.len     := LENGTH(LEFT.substr),
          SELF.isFound := STD.Str.Find(em, LEFT.substr, 1 ) > 0,
          SELF.substr  := LEFT.substr
        )
      );
    
    substr_found := ds_substr_found( len = MAX(ds_substr_found(isFound),len) )[1].substr;
    
    isFault := '' IN [em,nm];
    
    RETURN  IF( isFault, -1, length (substr_found ));
  END;




sysdate := common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (STRING6)le.historydate+'01'));

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

ver_src_en := ver_src_en_pos > 0;

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');

ver_src_eq := ver_src_eq_pos > 0;

ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie');

ver_src_fe := ver_src_fe_pos > 0;

ver_src_ff_pos := Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie');

ver_src_ff := ver_src_ff_pos > 0;

ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');

ver_src_p := ver_src_p_pos > 0;

ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');

ver_src_pl := ver_src_pl_pos > 0;

ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie');

ver_src_tn := ver_src_tn_pos > 0;

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

rv_e58_br_dead_business_count := if(not(truedid), NULL, min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 999));

nf_inq_per_phone := if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999));

nf_phone_ver_experian := if(not(truedid), NULL, (integer)phone_ver_experian);

rv_d31_filing_ct120 := if(not(truedid), NULL, filing_count120);

nf_inq_corrphonessn := map(
    not(truedid)                       => NULL,
    (inq_corrphonessn in [-3, -2, -1]) => NULL,
                                          inq_corrphonessn);

nf_email_name_addr_ver := if(not(emailpop), NULL, (integer)email_name_addr_verification);

iv_inq_count01 := if(not(truedid), NULL, min(if(inq_count01 = NULL, -NULL, inq_count01), 999));

nf_fp_varrisktype := if(not(truedid), NULL,(integer)fp_varrisktype);

nf_inq_lnamesperaddr_count12 := if(not(truedid), NULL, min(if(Inq_LNamesPerAddr = NULL, -NULL, Inq_LNamesPerAddr), 999));

nf_fp_idverrisktype := if(not(truedid), NULL, (integer)fp_idverrisktype);

nf_inq_per_ssn := if(not(ssnlength > '0'), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

nf_fp_curraddrmedianincome := __common__(if(not(truedid), NULL, (integer)fp_curraddrmedianincome));

nf_sum_src_credentialed := if(not(truedid), NULL, if(max((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w) = NULL, NULL, sum((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w)));

iv_unverified_addr_count := if(not(truedid), NULL, min(if(unverified_addr_count = NULL, -NULL, unverified_addr_count), 999));

rv_i60_inq_comm_recency := map(
    not(truedid)               => NULL,
    inq_communications_count01>0 => 1,
    inq_communications_count03>0  => 3,
    inq_communications_count06>0  => 6,
    inq_communications_count12 >0 => 12,
    inq_communications_count24 >0 => 24,
    inq_communications_count >0   => 99,
                                  0);

vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

iv_src_voter_adl_count := map(
    not(truedid)     => NULL,
    not(voter_avail) => -1,
    vo_pos <= 0      => 0,
                        (integer)Models.Common.getw(ver_sources_count, vo_pos, ','));

fullemail := StringLib.StringToUpperCase(in_email_address);

local_part := StringLib.StringToUpperCase((fullemail)[1..StringLib.StringFind(fullemail, '@',1)-1]);

e_fname := in_fname;

e_lname := StringLib.StringToUpperCase(in_lname);




//em_fname_characters_present := if(fullemail = '', -1, fn_findLongestSubstring(e_fname, local_part));
em_fname_characters_present := if(fullemail = '', -1, If(e_fname = '' , 1, fn_findLongestSubstring(e_fname, local_part)));


em_fname_starts_w_firstchar := if(fullemail = '', -1,(integer)(local_part[1] = e_fname[1]));



//em_lname_characters_present := if(fullemail = '', -1, fn_findLongestSubstring(e_lname, local_part));
em_lname_characters_present := if(fullemail = '', -1, if( e_lname = '' , 1, fn_findLongestSubstring(e_lname, local_part)));



em_lname_starts_w_firstchar := if(fullemail = '', -1, (integer)(local_part[1] = e_lname[1]));


em_name_contains_initials := if(fullemail = '', -1, (integer)(contains_i(local_part, trim(e_fname[1]) + trim(e_lname[1])) > 0));

_matching_fname_chars := if(em_fname_characters_present = 1 and em_fname_starts_w_firstchar = 0, 0, em_fname_characters_present);

_matching_lname_chars := if(em_lname_characters_present = 1 and em_lname_starts_w_firstchar = 0, 0, em_lname_characters_present);





em_len:= if(StringLib.StringFilterOut(local_part, ' ._') = '' , 1, length(StringLib.StringFilterOut(local_part, ' ._')));

em_name_pct_of_fn_ln_contained := 
  if(_matching_fname_chars = 0 and _matching_lname_chars = 0 and em_name_contains_initials = 1, 
    100 * (2  / em_len), 
    min(100, 100 * (_matching_fname_chars + _matching_lname_chars) / em_len));



o_v01_w := map(
    rv_e58_br_dead_business_count = NULL => 0,
    rv_e58_br_dead_business_count = -1   => 0,
    rv_e58_br_dead_business_count <= 1.5 => 0.480827974663331,
    rv_e58_br_dead_business_count <= 2.5 => 0.00394142995900287,
                                            -0.62964791630755);

o_v02_w := map(
    nf_inq_per_phone = NULL  => 0,
    nf_inq_per_phone = -1    => 0,
    nf_inq_per_phone <= 0.5  => 0.293654523765733,
    nf_inq_per_phone <= 1.5  => 0.06471210841234,
    nf_inq_per_phone <= 2.5  => 0.000716184876487459,
    nf_inq_per_phone <= 9.5  => -0.506073323516504,
    nf_inq_per_phone <= 15.5 => -1.06327860104333,
                                -1.07853056400625);

o_v03_w := map(
    nf_phone_ver_experian = NULL => 0,
    nf_phone_ver_experian = -1   => 0,
    nf_phone_ver_experian <= 0.5 => -0.372906161950359,
                                    0.430851533608865);

o_v04_w := map(
    rv_d31_filing_ct120 = NULL => 0,
    rv_d31_filing_ct120 = -1   => 0,
    rv_d31_filing_ct120 <= 0.5 => -0.330398159890312,
                                  0.366913236518069);

o_v05_w := map(
    nf_inq_corrphonessn = NULL => 0,
    nf_inq_corrphonessn = -1   => 0,
    nf_inq_corrphonessn <= 0.5 => -0.251192214649841,
                                  0.475284312666759);

o_v06_w := map(
    nf_email_name_addr_ver = NULL                                   => 0,
    (nf_email_name_addr_ver in [0])                               => -0.296688658548839,
    (nf_email_name_addr_ver in [1])                               => -0.0428950700114206,
    (nf_email_name_addr_ver in [2, 3, 4, 5, 6, 7, 8]) => 0.306979744585982,
                                                                       0);

o_v07_w := map(
    iv_inq_count01 = NULL => 0,
    iv_inq_count01 = -1   => 0,
    iv_inq_count01 <= 0.5 => 0.266862621118003,
    iv_inq_count01 <= 1.5 => -0.178442871639899,
                             -0.224980179113793);

o_v08_w := map(
    nf_fp_varrisktype = NULL => 0,
    nf_fp_varrisktype = -1   => 0,
    nf_fp_varrisktype <= 1.5 => 0.175012571674542,
    nf_fp_varrisktype <= 2.5 => 0.0650920741504439,
    nf_fp_varrisktype <= 3.5 => -0.0366678989654444,
    nf_fp_varrisktype <= 4.5 => -0.233837451557946,
    nf_fp_varrisktype <= 5.5 => -0.264975089521451,
    nf_fp_varrisktype <= 6.5 => -0.348885036776004,
    nf_fp_varrisktype <= 8.5 => -0.416313302915526,
                                -0.864711838055344);

o_v09_w := map(
    nf_inq_lnamesperaddr_count12 = NULL => 0,
    nf_inq_lnamesperaddr_count12 = -1   => 0,
    nf_inq_lnamesperaddr_count12 <= 1.5 => 0.155217102139918,
    nf_inq_lnamesperaddr_count12 <= 2.5 => 0.0497596061842449,
    nf_inq_lnamesperaddr_count12 <= 3.5 => -0.0891103762992361,
                                           -0.768035725241534);

o_v10_w := map(
   em_name_pct_of_fn_ln_contained = NULL              => 0,
    em_name_pct_of_fn_ln_contained = -1                => 0,
   em_name_pct_of_fn_ln_contained <= 8.01282051282051 => -0.226276972459815,
                                                         0.225434418482878);

o_v11_w := map(
    nf_fp_idverrisktype = NULL => 0,
    nf_fp_idverrisktype = -1   => 0,
    nf_fp_idverrisktype <= 1.5 => 0.228483706696523,
    nf_fp_idverrisktype <= 2.5 => -0.0775553336795134,
    nf_fp_idverrisktype <= 5.5 => -0.111465281296662,
                                  -0.287307727698513);

o_v12_w := map(
    nf_inq_per_ssn = NULL  => 0,
    nf_inq_per_ssn = -1    => 0,
    nf_inq_per_ssn <= 1.5  => 0.0962525044721321,
    nf_inq_per_ssn <= 3.5  => 0.0728496250945393,
    nf_inq_per_ssn <= 6.5  => -0.0157654842131829,
    nf_inq_per_ssn <= 16.5 => -0.281775634179136,
                              -0.604660709378747);

o_v13_w := map(
    nf_fp_curraddrmedianincome = NULL      => 0,
    nf_fp_curraddrmedianincome = -1        => 0,
    nf_fp_curraddrmedianincome <= 25874    => 0.432635752034287,
    nf_fp_curraddrmedianincome <= 62290.5  => 0.0904089853733104,
    nf_fp_curraddrmedianincome <= 76143    => 0.0344242857462169,
    nf_fp_curraddrmedianincome <= 99715    => -0.148076711356445,
    nf_fp_curraddrmedianincome <= 108943.5 => -0.202732035469332,
                                              -0.388938119714867);

o_v14_w := map(
    nf_sum_src_credentialed = NULL => 0,
    nf_sum_src_credentialed = -1   => 0,
    nf_sum_src_credentialed <= 1.5 => -0.232311058949413,
    nf_sum_src_credentialed <= 2.5 => -0.0563006084698002,
    nf_sum_src_credentialed <= 6.5 => 0.104645742422303,
                                      0.598901970715906);

o_v15_w := map(
    iv_unverified_addr_count = NULL  => 0,
    iv_unverified_addr_count = -1    => 0,
    iv_unverified_addr_count <= 1.5  => 0.209670621902142,
    iv_unverified_addr_count <= 4.5  => -0.00769572937189634,
    iv_unverified_addr_count <= 12.5 => -0.117013944831159,
    iv_unverified_addr_count <= 14.5 => -0.460227194807083,
                                        -0.656789198212862);

o_v16_w := map(
    rv_i60_inq_comm_recency = NULL               => 0,
    (rv_i60_inq_comm_recency in [0])           => 0.0807046190438107,
    (rv_i60_inq_comm_recency in [1, 3, 6]) => -1.23148950451165,
    (rv_i60_inq_comm_recency in [12, 24])    => -0.0611540208804155,
    (rv_i60_inq_comm_recency in [99])          => 0.0176278195950024,
                                                    0);

o_v17_w := map(
    iv_src_voter_adl_count = NULL => 0,
    iv_src_voter_adl_count = -1   => 0,
    iv_src_voter_adl_count <= 0.5 => -0.114084740710219,
    iv_src_voter_adl_count <= 6.5 => 0.0427458417992877,
                                     0.702044809961563);

o_lgt := 2.20000339949871 +
    o_v01_w +
    o_v02_w +
    o_v03_w +
    o_v04_w +
    o_v05_w +
    o_v06_w +
    o_v07_w +
    o_v08_w +
    o_v09_w +
    o_v10_w +
    o_v11_w +
    o_v12_w +
    o_v13_w +
    o_v14_w +
    o_v15_w +
    o_v16_w +
    o_v17_w;

base := 700;

odds := (1 - 0.0416) / 0.0416;

point := 60;

fp1803_1_0 := min(if(max(round(point * (o_lgt - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(point * (o_lgt - ln(odds)) / ln(2) + base), 300)), 999);

_sum_bureau := if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn));

_sum_credentialed := if(max((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w) = NULL, NULL, sum((integer)ver_src_ar, (integer)ver_src_am, (integer)ver_src_ba, (integer)ver_src_cg, (integer)ver_src_da, (integer)ver_src_d, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w));

_prop_owner_history := if((add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0) OR (add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0), 1, 0);


beta_synthid_trigger :=   __common__( (integer)(_sum_credentialed = 0 and _sum_bureau > 0 and _prop_owner_history = 0 OR not(truedid)));


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


iv_bureau_verification_index := if(not(truedid), NULL, if(max((integer)(max(num_bureau_fname, num_bureau_lname) > 0), 
                                                          2* (integer)(num_bureau_addr > 0), 
                                                          4* (integer)(num_bureau_dob > 0), 
                                                          8* (integer)(num_bureau_ssn > 0)) = NULL, NULL, 
                                                              sum(if((integer)(max(num_bureau_fname, num_bureau_lname) > 0) = NULL, 0, 
                                                                     (integer)(max(num_bureau_fname, num_bureau_lname) > 0)), 
                                                                         if(2* (integer)(num_bureau_addr > 0) = NULL, 0, 
                                                                            2* (integer)(num_bureau_addr > 0)), 
                                                                               if(4* (integer)(num_bureau_dob > 0) = NULL, 0, 
                                                                                  4* (integer)(num_bureau_dob > 0)), 
                                                                                     if(8* (integer)(num_bureau_ssn > 0) = NULL, 0, 
                                                                                        8* (integer)(num_bureau_ssn > 0)))));


rv_c15_ssns_per_adl_c6_v2 := if(not(truedid), NULL, min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 999));

rv_s65_ssn_prior_dob := map(
    not(ssnlength > '0' and dobpop)            => NULL,
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


sc_tgr_ssn_input_not_best := __common__(input_ssn_isbestmatch = '0');

sc_tgr_ssn_prior_dob := __common__( rv_s65_ssn_prior_dob = 1);

co_tgr_ssns_per_adl := __common__( rv_c15_ssns_per_adl > 4);

co_did_count := __common__( did_count > 14);

co_ssn_high_issue := 0 <= ca_m_snc_ssn_high_issue AND ca_m_snc_ssn_high_issue <= 181;


 beta_cpn_trigger := __common__(map(
    co_tgr_fla_bureau_no_ssn   => 1,
    sc_tgr_ssn_fs_6mo          => 1,
    sc_tgr_ssn_input_not_best  => 1,
    sc_tgr_ssn_prior_dob       => 1,
    co_tgr_ssns_per_adl        => 1,
    co_did_count              => 1,
    co_ssn_high_issue          => 1,
                                     0));
                                    
                                     

_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;


_derog := felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;//

_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;

_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';


 _inputmiskeys :=             rc_ssnmiskeyflag or rc_addrmiskeyflag or (integer)add_input_house_number_match = 0;

_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;



_hh_strikes := if((integer)max((integer)hh_members_w_derog > 0, 
                      (integer)hh_criminals > 0, 
                      (integer)hh_payday_loan_users > 0) = NULL, NULL, 
                      (integer)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0));


stolenid := if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9 or _deceased or _ssnpriortodob, 1, 0);

manipulatedid := if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0);

manipulatedidpt2 := if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9, 1, 0);

suspiciousactivity := if(_derog, 1, 0);

vulnerablevictim := if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0);

friendlyfraud := if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0);

stolenc_fp1803_1_0 := if((boolean)stolenid, fp1803_1_0, 299);

synthc_fp1803_1_0 := if((boolean)beta_synthid_trigger, fp1803_1_0, 299);

manip2c_fp1803_1_0 := if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2 or (boolean)beta_cpn_trigger, fp1803_1_0, 299);

suspactc_fp1803_1_0 := if((boolean)suspiciousactivity, fp1803_1_0, 299);

vulnvicc_fp1803_1_0 := if((boolean)vulnerablevictim, fp1803_1_0, 299);

friendlyc_fp1803_1_0 := if((boolean)friendlyfraud, fp1803_1_0, 299);

custstolidindex := map(
    stolenc_fp1803_1_0 = 299                                => 1,
    300 <= stolenc_fp1803_1_0 AND stolenc_fp1803_1_0 < 470  => 9,
    470 <= stolenc_fp1803_1_0 AND stolenc_fp1803_1_0 < 510  => 8,
    510 <= stolenc_fp1803_1_0 AND stolenc_fp1803_1_0 < 550  => 7,
    550 <= stolenc_fp1803_1_0 AND stolenc_fp1803_1_0 < 590  => 6,
    590 <= stolenc_fp1803_1_0 AND stolenc_fp1803_1_0 < 630  => 5,
    630 <= stolenc_fp1803_1_0 AND stolenc_fp1803_1_0 < 675  => 4,
    675 <= stolenc_fp1803_1_0 AND stolenc_fp1803_1_0 < 745  => 3,
    745 <= stolenc_fp1803_1_0 AND stolenc_fp1803_1_0 <= 999 => 2,
                                                               99);

custmanipidindex := map(
    manip2c_fp1803_1_0 = 299                                => 1,
    300 <= manip2c_fp1803_1_0 AND manip2c_fp1803_1_0 < 460  => 9,
    460 <= manip2c_fp1803_1_0 AND manip2c_fp1803_1_0 < 510  => 8,
    510 <= manip2c_fp1803_1_0 AND manip2c_fp1803_1_0 < 550  => 7,
    550 <= manip2c_fp1803_1_0 AND manip2c_fp1803_1_0 < 610  => 6,
    610 <= manip2c_fp1803_1_0 AND manip2c_fp1803_1_0 < 650  => 5,
    650 <= manip2c_fp1803_1_0 AND manip2c_fp1803_1_0 < 715  => 4,
    715 <= manip2c_fp1803_1_0 AND manip2c_fp1803_1_0 < 755  => 3,
    755 <= manip2c_fp1803_1_0 AND manip2c_fp1803_1_0 <= 999 => 2,
                                                               99);

custsynthidindex := map(
    synthc_fp1803_1_0 = 299                               => 1,
    300 <= synthc_fp1803_1_0 AND synthc_fp1803_1_0 <= 470 => 9,
    470 < synthc_fp1803_1_0 AND synthc_fp1803_1_0 <= 545  => 8,
    545 < synthc_fp1803_1_0 AND synthc_fp1803_1_0 <= 615  => 7,
    615 < synthc_fp1803_1_0 AND synthc_fp1803_1_0 <= 645  => 6,
    645 < synthc_fp1803_1_0 AND synthc_fp1803_1_0 <= 670  => 5,
    670 < synthc_fp1803_1_0 AND synthc_fp1803_1_0 <= 705  => 4,
    705 < synthc_fp1803_1_0 AND synthc_fp1803_1_0 <= 745  => 3,
    745 < synthc_fp1803_1_0 AND synthc_fp1803_1_0 <= 999  => 2,
                                                             99);

custsuspactindex := map(
    suspactc_fp1803_1_0 = 299                                 => 1,
    300 <= suspactc_fp1803_1_0 AND suspactc_fp1803_1_0 < 450  => 9,
    450 <= suspactc_fp1803_1_0 AND suspactc_fp1803_1_0 < 500  => 8,
    500 <= suspactc_fp1803_1_0 AND suspactc_fp1803_1_0 < 575  => 7,
    575 <= suspactc_fp1803_1_0 AND suspactc_fp1803_1_0 < 600  => 6,
    600 <= suspactc_fp1803_1_0 AND suspactc_fp1803_1_0 < 630  => 5,
    630 <= suspactc_fp1803_1_0 AND suspactc_fp1803_1_0 < 690  => 4,
    690 <= suspactc_fp1803_1_0 AND suspactc_fp1803_1_0 < 760  => 3,
    760 <= suspactc_fp1803_1_0 AND suspactc_fp1803_1_0 <= 999 => 2,
                                                                 99);

custvulnvicindex := map(
    vulnvicc_fp1803_1_0 = 299                                 => 1,
    300 <= vulnvicc_fp1803_1_0 AND vulnvicc_fp1803_1_0 < 425  => 9,
    425 <= vulnvicc_fp1803_1_0 AND vulnvicc_fp1803_1_0 < 490  => 8,
    490 <= vulnvicc_fp1803_1_0 AND vulnvicc_fp1803_1_0 < 565  => 7,
    565 <= vulnvicc_fp1803_1_0 AND vulnvicc_fp1803_1_0 < 615  => 6,
    615 <= vulnvicc_fp1803_1_0 AND vulnvicc_fp1803_1_0 < 660  => 5,
    660 <= vulnvicc_fp1803_1_0 AND vulnvicc_fp1803_1_0 < 710  => 4,
    710 <= vulnvicc_fp1803_1_0 AND vulnvicc_fp1803_1_0 < 760  => 3,
    760 <= vulnvicc_fp1803_1_0 AND vulnvicc_fp1803_1_0 <= 999 => 2,
                                                                 99);

custfriendfrdindex := map(
    friendlyc_fp1803_1_0 = 299                                  => 1,
    300 <= friendlyc_fp1803_1_0 AND friendlyc_fp1803_1_0 < 475  => 9,
    475 <= friendlyc_fp1803_1_0 AND friendlyc_fp1803_1_0 < 535  => 8,
    535 <= friendlyc_fp1803_1_0 AND friendlyc_fp1803_1_0 < 585  => 7,
    585 <= friendlyc_fp1803_1_0 AND friendlyc_fp1803_1_0 < 610  => 6,
    610 <= friendlyc_fp1803_1_0 AND friendlyc_fp1803_1_0 < 655  => 5,
    655 <= friendlyc_fp1803_1_0 AND friendlyc_fp1803_1_0 < 715  => 4,
    715 <= friendlyc_fp1803_1_0 AND friendlyc_fp1803_1_0 < 790  => 3,
    790 <= friendlyc_fp1803_1_0 AND friendlyc_fp1803_1_0 <= 999 => 2,
                                                                   99);



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
                    self.ver_src_en                       := ver_src_en;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self.ver_src_eq                       := ver_src_eq;
                    self.ver_src_fe_pos                   := ver_src_fe_pos;
                    self.ver_src_fe                       := ver_src_fe;
                    self.ver_src_ff_pos                   := ver_src_ff_pos;
                    self.ver_src_ff                       := ver_src_ff;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self.ver_src_p                        := ver_src_p;
                    self.ver_src_pl_pos                   := ver_src_pl_pos;
                    self.ver_src_pl                       := ver_src_pl;
                    self.ver_src_tn_pos                   := ver_src_tn_pos;
                    self.ver_src_tn                       := ver_src_tn;
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
                    self.rv_e58_br_dead_business_count    := rv_e58_br_dead_business_count;
                    self.nf_inq_per_phone                 := nf_inq_per_phone;
                    self.nf_phone_ver_experian            := nf_phone_ver_experian;
                    self.rv_d31_filing_ct120              := rv_d31_filing_ct120;
                    self.nf_inq_corrphonessn              := nf_inq_corrphonessn;
                    self.nf_email_name_addr_ver           := nf_email_name_addr_ver;
                    self.iv_inq_count01                   := iv_inq_count01;
                    self.nf_fp_varrisktype                := nf_fp_varrisktype;
                    self.nf_inq_lnamesperaddr_count12     := nf_inq_lnamesperaddr_count12;
                    self.nf_fp_idverrisktype              := nf_fp_idverrisktype;
                    self.nf_inq_per_ssn                   := nf_inq_per_ssn;
                    self.nf_fp_curraddrmedianincome       := nf_fp_curraddrmedianincome;
                    self.nf_sum_src_credentialed          := nf_sum_src_credentialed;
                    self.iv_unverified_addr_count         := iv_unverified_addr_count;
                    self.rv_i60_inq_comm_recency          := rv_i60_inq_comm_recency;
                    self.vo_pos                           := vo_pos;
                    self.iv_src_voter_adl_count           := iv_src_voter_adl_count;
                    self.fullemail                        := fullemail;
                    self.local_part                       := local_part;
                    self.e_fname                          := e_fname;
                    self.e_lname                          := e_lname;
                    self.em_fname_characters_present      := em_fname_characters_present;
                    self.em_fname_starts_w_firstchar      := em_fname_starts_w_firstchar;
                    self.em_lname_characters_present      := em_lname_characters_present;
                    self.em_lname_starts_w_firstchar      := em_lname_starts_w_firstchar;
                    self.em_name_contains_initials        := em_name_contains_initials;
                    self._matching_fname_chars            := _matching_fname_chars;
                    self._matching_lname_chars            := _matching_lname_chars;
                    self.em_name_pct_of_fn_ln_contained   := em_name_pct_of_fn_ln_contained;
                    self.o_v01_w                          := o_v01_w;
                    self.o_v02_w                          := o_v02_w;
                    self.o_v03_w                          := o_v03_w;
                    self.o_v04_w                          := o_v04_w;
                    self.o_v05_w                          := o_v05_w;
                    self.o_v06_w                          := o_v06_w;
                    self.o_v07_w                          := o_v07_w;
                    self.o_v08_w                          := o_v08_w;
                    self.o_v09_w                          := o_v09_w;
                    self.o_v10_w                          := o_v10_w;
                    self.o_v11_w                          := o_v11_w;
                    self.o_v12_w                          := o_v12_w;
                    self.o_v13_w                          := o_v13_w;
                    self.o_v14_w                          := o_v14_w;
                    self.o_v15_w                          := o_v15_w;
                    self.o_v16_w                          := o_v16_w;
                    self.o_v17_w                          := o_v17_w;
                    self.o_lgt                            := o_lgt;
                    self.base                             := base;
                    self.odds                             := odds;
                    self.point                            := point;
                    self.fp1803_1_0                       := fp1803_1_0;
                    self._sum_bureau                      := _sum_bureau;
                    self._sum_credentialed                := _sum_credentialed;
                    self._prop_owner_history              := _prop_owner_history;
                    self.beta_synthid_trigger             := beta_synthid_trigger;
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
                    self.suspiciousactivity               := suspiciousactivity;
                    self.vulnerablevictim                 := vulnerablevictim;
                    self.friendlyfraud                    := friendlyfraud;
                    self.stolenc_fp1803_1_0               := stolenc_fp1803_1_0;
                    self.synthc_fp1803_1_0                := synthc_fp1803_1_0;
                    self.manip2c_fp1803_1_0               := manip2c_fp1803_1_0;
                    self.suspactc_fp1803_1_0              := suspactc_fp1803_1_0;
                    self.vulnvicc_fp1803_1_0              := vulnvicc_fp1803_1_0;
                    self.friendlyc_fp1803_1_0             := friendlyc_fp1803_1_0;
                    self.custstolidindex                  := custstolidindex;
                    self.custmanipidindex                 := custmanipidindex;
                    self.custsynthidindex                 := custsynthidindex;
                    self.custsuspactindex                 := custsuspactindex;
                    self.custvulnvicindex                 := custvulnvicindex;
                    self.custfriendfrdindex               := custfriendfrdindex;


	                  SELF.clam                             := le;                     //***Attach the entire Boca Shell when DEBUG MODE is TRUE
#end

	           self.seq                                     := le.seq;
	           self.StolenIdentityIndex                     := if(custstolidindex = 99, '', (STRING) custstolidindex);
	           self.SyntheticIdentityIndex                  := if(custsynthidindex = 99, '', (STRING) custsynthidindex);
	           self.ManipulatedIdentityIndex                := if(custmanipidindex = 99, '', (STRING) custmanipidindex);
	           self.VulnerableVictimIndex                   := if(custvulnvicindex = 99, '', (STRING) custvulnvicindex);
	           self.FriendlyFraudIndex                      := if(custfriendfrdindex = 99, '', (STRING) custfriendfrdindex);
	           self.SuspiciousActivityIndex                 := if(custsuspactindex = 99, '', (STRING) custsuspactindex);
             ritmp                                        :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons);
	           reasons                                      := Models.Common.checkFraudPointRC34(FP1803_1_0, ritmp, num_reasons);
	           self.ri                                      := reasons;
	           self.score                                   := (STRING)FP1803_1_0;
	           self                                         := [];
	
      END;

   model :=   project(clam, doModel(left) );
	
	return model;
END;




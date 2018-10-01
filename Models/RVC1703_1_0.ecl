// Rossman & Co 
import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVC1703_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVC_DEBUG := false;

  #if(RVC_DEBUG)
    layout_debug := record
		
				
    /* Model Intermediate Variables */		
			integer sysdate                       ; // := sysdate;
			string  iv_add_apt;
			integer iv_vp090_phn_dst_to_inp_add;
			string  iv_vp091_phnzip_mismatch;
			string  iv_vp100_phn_prob;
			integer iv_va060_dist_add_in_bst;
			integer _felony_last_date;
			integer iv_df001_mos_since_fel_ls;
			string iv_db001_bankruptcy; // := iv_db001_bankruptcy;
			integer iv_dg001_derog_count          ; // := iv_dg001_derog_count;
			integer iv_dl001_unrel_lien60_count   ; // := iv_dl001_unrel_lien60_count;
			integer lien_adl_li_lseen_pos         ; // := lien_adl_li_lseen_pos;
			string lien_adl_lseen_li  ; // := lien_adl_lseen_li;
			integer _lien_adl_lseen_li ; // := _lien_adl_lseen_li;
			integer lien_adl_l2_lseen_pos         ; // := lien_adl_l2_lseen_pos;
			string lien_adl_lseen_l2  ; // := lien_adl_lseen_l2;
			integer _lien_adl_lseen_l2 ; // := _lien_adl_lseen_l2;
			integer _src_lien_adl_lseen; // := _src_lien_adl_lseen;
			integer iv_dl001_lien_last_seen       ; // := iv_dl001_lien_last_seen;
			integer bureau_adl_tn_fseen_pos       ; // := bureau_adl_tn_fseen_pos;
			string bureau_adl_fseen_tn; // := bureau_adl_fseen_tn;
			integer _bureau_adl_fseen_tn          ; // := _bureau_adl_fseen_tn;
			integer bureau_adl_ts_fseen_pos       ; // := bureau_adl_ts_fseen_pos;
			string bureau_adl_fseen_ts; // := bureau_adl_fseen_ts;
			integer _bureau_adl_fseen_ts          ; // := _bureau_adl_fseen_ts;
			integer bureau_adl_tu_fseen_pos       ; // := bureau_adl_tu_fseen_pos;
			string bureau_adl_fseen_tu; // := bureau_adl_fseen_tu;
			integer _bureau_adl_fseen_tu          ; // := _bureau_adl_fseen_tu;
			integer bureau_adl_en_fseen_pos       ; // := bureau_adl_en_fseen_pos;
			string bureau_adl_fseen_en; // := bureau_adl_fseen_en;
			integer _bureau_adl_fseen_en          ; // := _bureau_adl_fseen_en;
			integer bureau_adl_eq_fseen_pos       ; // := bureau_adl_eq_fseen_pos;
			string bureau_adl_fseen_eq; // := bureau_adl_fseen_eq;
			integer _bureau_adl_fseen_eq          ; // := _bureau_adl_fseen_eq;
			integer iv_sr001_m_bureau_adl_fs      ; // := iv_sr001_m_bureau_adl_fs;
			integer wp_adl_wp_fseen_pos; // := wp_adl_wp_fseen_pos;
			string wp_adl_fseen_wp    ; // := wp_adl_fseen_wp;
			integer _wp_adl_fseen_wp   ; // := _wp_adl_fseen_wp;
			integer _src_wp_adl_fseen  ; // := _src_wp_adl_fseen;
			integer bureau_adl_vo_fseen_pos       ; // := bureau_adl_vo_fseen_pos;
			string bureau_adl_fseen_vo; // := bureau_adl_fseen_vo;
			integer _bureau_adl_fseen_vo          ; // := _bureau_adl_fseen_vo;
			integer _src_bureau_adl_fseen         ; // := _src_bureau_adl_fseen;
			integer mth_ver_src_fdate_vo          ; // := mth_ver_src_fdate_vo;
			integer bureau_adl_vo_lseen_pos       ; // := bureau_adl_vo_lseen_pos;
			string bureau_adl_lseen_vo; // := bureau_adl_lseen_vo;
			integer _bureau_adl_lseen_vo          ; // := _bureau_adl_lseen_vo;
			integer mth_ver_src_ldate_vo          ; // := mth_ver_src_ldate_vo;
			boolean mth_ver_src_fdate_vo60        ; // := mth_ver_src_fdate_vo60;
			boolean mth_ver_src_ldate_vo0         ; // := mth_ver_src_ldate_vo0;
			integer bureau_adl_w_lseen_pos        ; // := bureau_adl_w_lseen_pos;
			string bureau_adl_lseen_w ; // := bureau_adl_lseen_w;
			integer _bureau_adl_lseen_w; // := _bureau_adl_lseen_w;
			integer mth_ver_src_ldate_w; // := mth_ver_src_ldate_w;
			boolean mth_ver_src_ldate_w0          ; // := mth_ver_src_ldate_w0;
			integer bureau_adl_wp_lseen_pos       ; // := bureau_adl_wp_lseen_pos;
			string bureau_adl_lseen_wp; // := bureau_adl_lseen_wp;
			integer _bureau_adl_lseen_wp          ; // := _bureau_adl_lseen_wp;
			integer mth_ver_src_ldate_wp          ; // := mth_ver_src_ldate_wp;
			boolean mth_ver_src_ldate_wp0         ; // := mth_ver_src_ldate_wp0;
			integer mth_paw_first_seen ; // := mth_paw_first_seen;
			integer mth_paw_first_seen2; // := mth_paw_first_seen2;
			boolean ver_src_am			; // := ver_src_am;
			boolean ver_src_e1			; // := ver_src_e1;
			boolean ver_src_e2			; // := ver_src_e2;
			boolean ver_src_e3			; // := ver_src_e3;
			boolean ver_src_pl			; // := ver_src_pl;
			boolean ver_src_w			 ; // := ver_src_w;
			boolean paw_dead_business_count_gt3   ; // := paw_dead_business_count_gt3;
			boolean paw_active_phone_count_0      ; // := paw_active_phone_count_0;
			integer mth_infutor_first_seen        ; // := mth_infutor_first_seen;
			integer mth_infutor_last_seen         ; // := mth_infutor_last_seen;
			integer infutor_i			 ; // := infutor_i;
			real infutor_im			; // := infutor_im;
			integer white_pages_adl_wp_fseen_pos  ; // := white_pages_adl_wp_fseen_pos;
			string white_pages_adl_fseen_wp      ; // := white_pages_adl_fseen_wp;
			integer _white_pages_adl_fseen_wp     ; // := _white_pages_adl_fseen_wp;
			integer _src_white_pages_adl_fseen    ; // := _src_white_pages_adl_fseen;
			integer iv_sr001_m_wp_adl_fs          ; // := iv_sr001_m_wp_adl_fs;
			integer src_m_wp_adl_fs    ; // := src_m_wp_adl_fs;
			integer _header_first_seen ; // := _header_first_seen;
			integer iv_sr001_m_hdr_fs  ; // := iv_sr001_m_hdr_fs;
			integer src_m_hdr_fs			; // := src_m_hdr_fs;
			real source_mod6		; // := source_mod6;
			real iv_sr001_source_profile       ; // := iv_sr001_source_profile;
			integer iv_ms001_ssns_per_adl         ; // := iv_ms001_ssns_per_adl;
			integer iv_mi001_adlperssn_count      ; // := iv_mi001_adlperssn_count;
			integer _in_dob			   ; // := _in_dob;
			real yr_in_dob			 ; // := yr_in_dob;
			integer yr_in_dob_int	; // := yr_in_dob_int;
			integer age_estimate		; // := age_estimate;
			integer iv_ag001_age		; // := iv_ag001_age;
			integer iv_pv001_inp_avm_autoval      ; // := iv_pv001_inp_avm_autoval;
			integer iv_pv001_bst_avm_autoval      ; // := iv_pv001_bst_avm_autoval;
			real iv_pv001_avg_prop_prch_amt    ; // := iv_pv001_avg_prop_prch_amt;
			integer bst_addr_avm_auto_val_2       ; // := bst_addr_avm_auto_val_2;
			integer iv_pv001_bst_avm_chg_1yr      ; // := iv_pv001_bst_avm_chg_1yr;
			real iv_pv001_bst_avm_chg_1yr_pct  ; // := iv_pv001_bst_avm_chg_1yr_pct;
			integer inp_addr_date_first_seen      ; // := inp_addr_date_first_seen;
			integer iv_pl001_m_snc_in_addr_fs     ; // := iv_pl001_m_snc_in_addr_fs;
			integer prop_adl_p_fseen_pos          ; // := prop_adl_p_fseen_pos;
			string prop_adl_fseen_p   ; // := prop_adl_fseen_p;
			integer _prop_adl_fseen_p  ; // := _prop_adl_fseen_p;
			integer _src_prop_adl_fseen; // := _src_prop_adl_fseen;
			integer iv_pl001_m_snc_prop_adl_fs    ; // := iv_pl001_m_snc_prop_adl_fs;
			integer iv_pl001_bst_addr_lres        ; // := iv_pl001_bst_addr_lres;
			integer iv_pl002_avg_mo_per_addr      ; // := iv_pl002_avg_mo_per_addr;
			integer iv_pl002_addrs_per_ssn_c6     ; // := iv_pl002_addrs_per_ssn_c6;
			integer iv_po001_prop_own_tot         ; // := iv_po001_prop_own_tot;
			integer iv_po001_inp_addr_naprop      ; // := iv_po001_inp_addr_naprop;
			integer vehicles_adl_ar_fseen_pos     ; // := vehicles_adl_ar_fseen_pos;
			string vehicles_adl_fseen_ar         ; // := vehicles_adl_fseen_ar;
			integer _vehicles_adl_fseen_ar        ; // := _vehicles_adl_fseen_ar;
			integer vehicles_adl_eb_fseen_pos     ; // := vehicles_adl_eb_fseen_pos;
			string vehicles_adl_fseen_eb         ; // := vehicles_adl_fseen_eb;
			integer _vehicles_adl_fseen_eb        ; // := _vehicles_adl_fseen_eb;
			integer vehicles_adl_v_fseen_pos      ; // := vehicles_adl_v_fseen_pos;
			string vehicles_adl_fseen_v          ; // := vehicles_adl_fseen_v;
			integer _vehicles_adl_fseen_v         ; // := _vehicles_adl_fseen_v;
			integer vehicles_adl_w_fseen_pos      ; // := vehicles_adl_w_fseen_pos;
			string vehicles_adl_fseen_w          ; // := vehicles_adl_fseen_w;
			integer _vehicles_adl_fseen_w         ; // := _vehicles_adl_fseen_w;
			integer _src_vehicles_adl_fseen       ; // := _src_vehicles_adl_fseen;
			integer iv_po001_m_snc_veh_adl_fs     ; // := iv_po001_m_snc_veh_adl_fs;
			integer iv_in001_estimated_income     ; // := iv_in001_estimated_income;
			string iv_in001_wealth_index         ; // := iv_in001_wealth_index;
			string iv_ed001_college_ind_35       ; // := iv_ed001_college_ind_35;
			string iv_ed001_college_ind_36       ; // := iv_ed001_college_ind_36;
			string iv_ed001_college_ind_37       ; // := iv_ed001_college_ind_37;
			string iv_ed001_college_ind_50       ; // := iv_ed001_college_ind_50;
			string iv_ed001_college_ind_60       ; // := iv_ed001_college_ind_60;
			integer iv_iq001_inq_count12          ; // := iv_iq001_inq_count12;
			string iv_nap_type			; // := iv_nap_type;
			integer bureau_adl_tn_lseen_pos       ; // := bureau_adl_tn_lseen_pos;
			string bureau_adl_lseen_tn; // := bureau_adl_lseen_tn;
			integer _bureau_adl_lseen_tn          ; // := _bureau_adl_lseen_tn;
			integer bureau_adl_ts_lseen_pos       ; // := bureau_adl_ts_lseen_pos;
			string bureau_adl_lseen_ts; // := bureau_adl_lseen_ts;
			integer _bureau_adl_lseen_ts          ; // := _bureau_adl_lseen_ts;
			integer bureau_adl_tu_lseen_pos       ; // := bureau_adl_tu_lseen_pos;
			string bureau_adl_lseen_tu; // := bureau_adl_lseen_tu;
			integer _bureau_adl_lseen_tu          ; // := _bureau_adl_lseen_tu;
			integer bureau_adl_en_lseen_pos       ; // := bureau_adl_en_lseen_pos;
			string bureau_adl_lseen_en; // := bureau_adl_lseen_en;
			integer _bureau_adl_lseen_en          ; // := _bureau_adl_lseen_en;
			integer bureau_adl_eq_lseen_pos       ; // := bureau_adl_eq_lseen_pos;
			string bureau_adl_lseen_eq; // := bureau_adl_lseen_eq;
			integer _bureau_adl_lseen_eq          ; // := _bureau_adl_lseen_eq;
			integer _src_bureau_adl_lseen         ; // := _src_bureau_adl_lseen;
			integer iv_mos_src_bureau_adl_lseen   ; // := iv_mos_src_bureau_adl_lseen;
			integer bureau_ssn_tn_count_pos       ; // := bureau_ssn_tn_count_pos;
			integer bureau_ssn_count_tn; // := bureau_ssn_count_tn;
			integer bureau_ssn_ts_count_pos       ; // := bureau_ssn_ts_count_pos;
			integer bureau_ssn_count_ts; // := bureau_ssn_count_ts;
			integer bureau_ssn_tu_count_pos       ; // := bureau_ssn_tu_count_pos;
			integer bureau_ssn_count_tu; // := bureau_ssn_count_tu;
			integer bureau_ssn_en_count_pos       ; // := bureau_ssn_en_count_pos;
			integer bureau_ssn_count_en; // := bureau_ssn_count_en;
			integer bureau_ssn_eq_count_pos       ; // := bureau_ssn_eq_count_pos;
			integer bureau_ssn_count_eq; // := bureau_ssn_count_eq;
			real _src_bureau_ssn_count         ; // := _src_bureau_ssn_count;
			real iv_src_bureau_ssn_count       ; // := iv_src_bureau_ssn_count;
			integer bureau_ssn_tn_fseen_pos       ; // := bureau_ssn_tn_fseen_pos;
			string bureau_ssn_fseen_tn; // := bureau_ssn_fseen_tn;
			integer _bureau_ssn_fseen_tn          ; // := _bureau_ssn_fseen_tn;
			integer bureau_ssn_ts_fseen_pos       ; // := bureau_ssn_ts_fseen_pos;
			string bureau_ssn_fseen_ts; // := bureau_ssn_fseen_ts;
			integer _bureau_ssn_fseen_ts          ; // := _bureau_ssn_fseen_ts;
			integer bureau_ssn_tu_fseen_pos       ; // := bureau_ssn_tu_fseen_pos;
			string bureau_ssn_fseen_tu; // := bureau_ssn_fseen_tu;
			integer _bureau_ssn_fseen_tu          ; // := _bureau_ssn_fseen_tu;
			integer bureau_ssn_en_fseen_pos       ; // := bureau_ssn_en_fseen_pos;
			string bureau_ssn_fseen_en; // := bureau_ssn_fseen_en;
			integer _bureau_ssn_fseen_en          ; // := _bureau_ssn_fseen_en;
			integer bureau_ssn_eq_fseen_pos       ; // := bureau_ssn_eq_fseen_pos;
			string bureau_ssn_fseen_eq; // := bureau_ssn_fseen_eq;
			integer _bureau_ssn_fseen_eq          ; // := _bureau_ssn_fseen_eq;
			integer _src_bureau_ssn_fseen         ; // := _src_bureau_ssn_fseen;
			integer iv_mos_src_bureau_ssn_fseen   ; // := iv_mos_src_bureau_ssn_fseen;
			integer bureau_addr_tn_count_pos      ; // := bureau_addr_tn_count_pos;
			integer bureau_addr_count_tn          ; // := bureau_addr_count_tn;
			integer bureau_addr_ts_count_pos      ; // := bureau_addr_ts_count_pos;
			integer bureau_addr_count_ts          ; // := bureau_addr_count_ts;
			integer bureau_addr_tu_count_pos      ; // := bureau_addr_tu_count_pos;
			integer bureau_addr_count_tu          ; // := bureau_addr_count_tu;
			integer bureau_addr_en_count_pos      ; // := bureau_addr_en_count_pos;
			integer bureau_addr_count_en          ; // := bureau_addr_count_en;
			integer bureau_addr_eq_count_pos      ; // := bureau_addr_eq_count_pos;
			integer bureau_addr_count_eq          ; // := bureau_addr_count_eq;
			real _src_bureau_addr_count        ; // := _src_bureau_addr_count;
			real iv_src_bureau_addr_count      ; // := iv_src_bureau_addr_count;
			integer bureau_addr_tn_fseen_pos      ; // := bureau_addr_tn_fseen_pos;
			string bureau_addr_fseen_tn          ; // := bureau_addr_fseen_tn;
			integer _bureau_addr_fseen_tn         ; // := _bureau_addr_fseen_tn;
			integer bureau_addr_ts_fseen_pos      ; // := bureau_addr_ts_fseen_pos;
			string bureau_addr_fseen_ts          ; // := bureau_addr_fseen_ts;
			integer _bureau_addr_fseen_ts         ; // := _bureau_addr_fseen_ts;
			integer bureau_addr_tu_fseen_pos      ; // := bureau_addr_tu_fseen_pos;
			string bureau_addr_fseen_tu          ; // := bureau_addr_fseen_tu;
			integer _bureau_addr_fseen_tu         ; // := _bureau_addr_fseen_tu;
			integer bureau_addr_en_fseen_pos      ; // := bureau_addr_en_fseen_pos;
			string bureau_addr_fseen_en          ; // := bureau_addr_fseen_en;
			integer _bureau_addr_fseen_en         ; // := _bureau_addr_fseen_en;
			integer bureau_addr_eq_fseen_pos      ; // := bureau_addr_eq_fseen_pos;
			string bureau_addr_fseen_eq          ; // := bureau_addr_fseen_eq;
			integer _bureau_addr_fseen_eq         ; // := _bureau_addr_fseen_eq;
			integer _src_bureau_addr_fseen        ; // := _src_bureau_addr_fseen;
			integer iv_mos_src_bureau_addr_fseen  ; // := iv_mos_src_bureau_addr_fseen;
			integer bureau_lname_tn_count_pos     ; // := bureau_lname_tn_count_pos;
			integer bureau_lname_count_tn         ; // := bureau_lname_count_tn;
			integer bureau_lname_ts_count_pos     ; // := bureau_lname_ts_count_pos;
			integer bureau_lname_count_ts         ; // := bureau_lname_count_ts;
			integer bureau_lname_tu_count_pos     ; // := bureau_lname_tu_count_pos;
			integer bureau_lname_count_tu         ; // := bureau_lname_count_tu;
			integer bureau_lname_en_count_pos     ; // := bureau_lname_en_count_pos;
			integer bureau_lname_count_en         ; // := bureau_lname_count_en;
			integer bureau_lname_eq_count_pos     ; // := bureau_lname_eq_count_pos;
			integer bureau_lname_count_eq         ; // := bureau_lname_count_eq;
			real _src_bureau_lname_count       ; // := _src_bureau_lname_count;
			real iv_src_bureau_lname_count     ; // := iv_src_bureau_lname_count;
			integer bureau_lname_tn_fseen_pos     ; // := bureau_lname_tn_fseen_pos;
			string bureau_lname_fseen_tn         ; // := bureau_lname_fseen_tn;
			integer _bureau_lname_fseen_tn        ; // := _bureau_lname_fseen_tn;
			integer bureau_lname_ts_fseen_pos     ; // := bureau_lname_ts_fseen_pos;
			string bureau_lname_fseen_ts         ; // := bureau_lname_fseen_ts;
			integer _bureau_lname_fseen_ts        ; // := _bureau_lname_fseen_ts;
			integer bureau_lname_tu_fseen_pos     ; // := bureau_lname_tu_fseen_pos;
			string bureau_lname_fseen_tu         ; // := bureau_lname_fseen_tu;
			integer _bureau_lname_fseen_tu        ; // := _bureau_lname_fseen_tu;
			integer bureau_lname_en_fseen_pos     ; // := bureau_lname_en_fseen_pos;
			string bureau_lname_fseen_en         ; // := bureau_lname_fseen_en;
			integer _bureau_lname_fseen_en        ; // := _bureau_lname_fseen_en;
			integer bureau_lname_eq_fseen_pos     ; // := bureau_lname_eq_fseen_pos;
			string bureau_lname_fseen_eq         ; // := bureau_lname_fseen_eq;
			integer _bureau_lname_fseen_eq        ; // := _bureau_lname_fseen_eq;
			integer _src_bureau_lname_fseen       ; // := _src_bureau_lname_fseen;
			integer iv_mos_src_bureau_lname_fseen ; // := iv_mos_src_bureau_lname_fseen;
			integer bureau_dob_tn_count_pos       ; // := bureau_dob_tn_count_pos;
			integer bureau_dob_count_tn; // := bureau_dob_count_tn;
			integer bureau_dob_ts_count_pos       ; // := bureau_dob_ts_count_pos;
			integer bureau_dob_count_ts; // := bureau_dob_count_ts;
			integer bureau_dob_tu_count_pos       ; // := bureau_dob_tu_count_pos;
			integer bureau_dob_count_tu; // := bureau_dob_count_tu;
			integer bureau_dob_en_count_pos       ; // := bureau_dob_en_count_pos;
			integer bureau_dob_count_en; // := bureau_dob_count_en;
			integer bureau_dob_eq_count_pos       ; // := bureau_dob_eq_count_pos;
			integer bureau_dob_count_eq; // := bureau_dob_count_eq;
			integer _src_bureau_dob_count         ; // := _src_bureau_dob_count;
			integer iv_src_bureau_dob_count       ; // := iv_src_bureau_dob_count;
			integer bureau_dob_tn_fseen_pos       ; // := bureau_dob_tn_fseen_pos;
			string bureau_dob_fseen_tn; // := bureau_dob_fseen_tn;
			integer _bureau_dob_fseen_tn          ; // := _bureau_dob_fseen_tn;
			integer bureau_dob_ts_fseen_pos       ; // := bureau_dob_ts_fseen_pos;
			string bureau_dob_fseen_ts; // := bureau_dob_fseen_ts;
			integer _bureau_dob_fseen_ts          ; // := _bureau_dob_fseen_ts;
			integer bureau_dob_tu_fseen_pos       ; // := bureau_dob_tu_fseen_pos;
			string bureau_dob_fseen_tu; // := bureau_dob_fseen_tu;
			integer _bureau_dob_fseen_tu          ; // := _bureau_dob_fseen_tu;
			integer bureau_dob_en_fseen_pos       ; // := bureau_dob_en_fseen_pos;
			string bureau_dob_fseen_en; // := bureau_dob_fseen_en;
			integer _bureau_dob_fseen_en          ; // := _bureau_dob_fseen_en;
			integer bureau_dob_eq_fseen_pos       ; // := bureau_dob_eq_fseen_pos;
			string bureau_dob_fseen_eq; // := bureau_dob_fseen_eq;
			integer _bureau_dob_fseen_eq          ; // := _bureau_dob_fseen_eq;
			integer _src_bureau_dob_fseen         ; // := _src_bureau_dob_fseen;
			integer iv_mos_src_bureau_dob_fseen   ; // := iv_mos_src_bureau_dob_fseen;
			integer lien_adl_li_count_pos         ; // := lien_adl_li_count_pos;
			integer lien_adl_count_li  ; // := lien_adl_count_li;
			integer lien_adl_l2_count_pos         ; // := lien_adl_l2_count_pos;
			integer lien_adl_count_l2  ; // := lien_adl_count_l2;
			real _src_lien_adl_count; // := _src_lien_adl_count;
			integer bk_adl_bk_count_pos; // := bk_adl_bk_count_pos;
			integer bk_adl_count_bk    ; // := bk_adl_count_bk;
			real _src_bk_adl_count  ; // := _src_bk_adl_count;
			real iv_src_bankruptcy_adl_count   ; // := iv_src_bankruptcy_adl_count;
			integer bk_adl_ba_lseen_pos; // := bk_adl_ba_lseen_pos;
			string bk_adl_lseen_ba    ; // := bk_adl_lseen_ba;
			integer _bk_adl_lseen_ba   ; // := _bk_adl_lseen_ba;
			integer _src_bk_adl_lseen  ; // := _src_bk_adl_lseen;
			integer iv_mos_src_bankruptcy_adl_lseen ; // := iv_mos_src_bankruptcy_adl_lseen;
			integer prop_adl_p_count_pos          ; // := prop_adl_p_count_pos;
			integer prop_adl_count_p   ; // := prop_adl_count_p;
			real _src_prop_adl_count; // := _src_prop_adl_count;
			real iv_src_property_adl_count     ; // := iv_src_property_adl_count;
			integer prop_adl_p_lseen_pos          ; // := prop_adl_p_lseen_pos;
			string prop_adl_lseen_p   ; // := prop_adl_lseen_p;
			integer _prop_adl_lseen_p  ; // := _prop_adl_lseen_p;
			integer _src_prop_adl_lseen; // := _src_prop_adl_lseen;
			integer iv_mos_src_property_adl_lseen ; // := iv_mos_src_property_adl_lseen;
			integer voter_adl_v_count_pos         ; // := voter_adl_v_count_pos;
			integer iv_src_voter_adl_count        ; // := iv_src_voter_adl_count;
			integer vote_adl_vo_lseen_pos         ; // := vote_adl_vo_lseen_pos;
			string vote_adl_lseen_vo  ; // := vote_adl_lseen_vo;
			integer _vote_adl_lseen_vo ; // := _vote_adl_lseen_vo;
			integer _src_vote_adl_lseen; // := _src_vote_adl_lseen;
			integer iv_mos_src_voter_adl_lseen    ; // := iv_mos_src_voter_adl_lseen;
			integer emerge_adl_em_count_pos       ; // := emerge_adl_em_count_pos;
			integer emerge_adl_count_em; // := emerge_adl_count_em;
			integer emerge_adl_e1_count_pos       ; // := emerge_adl_e1_count_pos;
			integer emerge_adl_count_e1; // := emerge_adl_count_e1;
			integer emerge_adl_e2_count_pos       ; // := emerge_adl_e2_count_pos;
			integer emerge_adl_count_e2; // := emerge_adl_count_e2;
			integer emerge_adl_e3_count_pos       ; // := emerge_adl_e3_count_pos;
			integer emerge_adl_count_e3; // := emerge_adl_count_e3;
			integer emerge_adl_e4_count_pos       ; // := emerge_adl_e4_count_pos;
			integer emerge_adl_count_e4; // := emerge_adl_count_e4;
			integer iv_src_emerge_adl_count       ; // := iv_src_emerge_adl_count;
			integer _lname_change_date ; // := _lname_change_date;
			integer iv_mos_since_lname_change     ; // := iv_mos_since_lname_change;
			string iv_fname_eda_sourced_type     ; // := iv_fname_eda_sourced_type;
			string iv_lname_eda_sourced_type     ; // := iv_lname_eda_sourced_type;
			integer iv_fname_non_phn_src_ct       ; // := iv_fname_non_phn_src_ct;
			integer iv_full_name_non_phn_src_ct   ; // := iv_full_name_non_phn_src_ct;
			string iv_full_name_ver_sources      ; // := iv_full_name_ver_sources;
			integer iv_addr_non_phn_src_ct        ; // := iv_addr_non_phn_src_ct;
			integer iv_addr_phn_src_ct ; // := iv_addr_phn_src_ct;
			integer iv_dob_src_ct	; // := iv_dob_src_ct;
			integer _reported_dob	; // := _reported_dob;
			integer reported_age		; // := reported_age;
			integer iv_combined_age    ; // := iv_combined_age;
			integer _rc_ssnlowissue    ; // := _rc_ssnlowissue;
			integer iv_age_at_low_issue; // := iv_age_at_low_issue;
			integer _rc_ssnhighissue   ; // := _rc_ssnhighissue;
			integer iv_age_at_high_issue          ; // := iv_age_at_high_issue;
			integer iv_inp_addr_lres   ; // := iv_inp_addr_lres;
			integer iv_inp_addr_source_count      ; // := iv_inp_addr_source_count;
			string iv_inp_addr_ownership_lvl     ; // := iv_inp_addr_ownership_lvl;
			string iv_inp_own_prop_x_addr_naprop ; // := iv_inp_own_prop_x_addr_naprop;
			integer iv_inp_addr_mortgage_amount   ; // := iv_inp_addr_mortgage_amount;
			integer _add1_mortgage_date; // := _add1_mortgage_date;
			integer _add1_mortgage_due_date       ; // := _add1_mortgage_due_date;
			integer mortgage_date_diff ; // := mortgage_date_diff;
			string iv_inp_addr_mortgage_term     ; // := iv_inp_addr_mortgage_term;
			string iv_inp_addr_financing_type    ; // := iv_inp_addr_financing_type;
			integer iv_inp_addr_assessed_total_val; // := iv_inp_addr_assessed_total_val;
			integer inp_addr_fips_fall ; // := inp_addr_fips_fall;
			integer inp_addr_avm_auto_val         ; // := inp_addr_avm_auto_val;
			real iv_inp_addr_fips_ratio        ; // := iv_inp_addr_fips_ratio;
			integer iv_inp_addr_building_area     ; // := iv_inp_addr_building_area;
			integer iv_inp_addr_avm_change_1yr    ; // := iv_inp_addr_avm_change_1yr;
			real iv_inp_addr_avm_pct_change_1yr; // := iv_inp_addr_avm_pct_change_1yr;
			integer iv_inp_addr_avm_change_2yr    ; // := iv_inp_addr_avm_change_2yr;
			real iv_inp_addr_avm_pct_change_2yr; // := iv_inp_addr_avm_pct_change_2yr;
			integer iv_inp_addr_avm_change_3yr    ; // := iv_inp_addr_avm_change_3yr;
			real iv_inp_addr_avm_pct_change_3yr; // := iv_inp_addr_avm_pct_change_3yr;
			integer iv_bst_addr_source_count      ; // := iv_bst_addr_source_count;
			string iv_bst_addr_ownership_lvl     ; // := iv_bst_addr_ownership_lvl;
			string iv_bst_addr_naprop ; // := iv_bst_addr_naprop;
			string iv_bst_own_prop_x_addr_naprop ; // := iv_bst_own_prop_x_addr_naprop;
			integer iv_bst_addr_mortgage_amount   ; // := iv_bst_addr_mortgage_amount;
			integer iv_bst_addr_mtg_avm_abs_diff  ; // := iv_bst_addr_mtg_avm_abs_diff;
			integer bst_addr_mortgage_amount      ; // := bst_addr_mortgage_amount;
			real iv_bst_addr_mtg_avm_pct_diff  ; // := iv_bst_addr_mtg_avm_pct_diff;
			integer iv_bst_addr_assessed_total_val; // := iv_bst_addr_assessed_total_val;
			integer bst_addr_date_first_seen      ; // := bst_addr_date_first_seen;
			integer iv_mos_since_bst_addr_fseen   ; // := iv_mos_since_bst_addr_fseen;
			integer bst_addr_avm_auto_val         ; // := bst_addr_avm_auto_val;
			integer bst_addr_fips_fall ; // := bst_addr_fips_fall;
			real iv_bst_addr_fips_ratio        ; // := iv_bst_addr_fips_ratio;
			integer iv_bst_addr_building_area     ; // := iv_bst_addr_building_area;
			integer iv_bst_addr_avm_change_2yr    ; // := iv_bst_addr_avm_change_2yr;
			integer bst_addr_avm_auto_val_3       ; // := bst_addr_avm_auto_val_3;
			real iv_bst_addr_avm_pct_change_2yr; // := iv_bst_addr_avm_pct_change_2yr;
			integer iv_bst_addr_avm_change_3yr    ; // := iv_bst_addr_avm_change_3yr;
			integer bst_addr_avm_auto_val_1       ; // := bst_addr_avm_auto_val_1;
			integer bst_addr_avm_auto_val_4       ; // := bst_addr_avm_auto_val_4;
			real iv_bst_addr_avm_pct_change_3yr; // := iv_bst_addr_avm_pct_change_3yr;
			string iv_bst_addr_financing_type    ; // := iv_bst_addr_financing_type;
			integer iv_prv_addr_lres   ; // := iv_prv_addr_lres;
			integer iv_prv_addr_avm_auto_val      ; // := iv_prv_addr_avm_auto_val;
			integer iv_prv_addr_source_count      ; // := iv_prv_addr_source_count;
			string iv_prv_addr_eda_sourced       ; // := iv_prv_addr_eda_sourced;
			string iv_prv_addr_naprop ; // := iv_prv_addr_naprop;
			string iv_prv_own_prop_x_addr_naprop ; // := iv_prv_own_prop_x_addr_naprop;
			string iv_prv_addr_mortgage_present  ; // := iv_prv_addr_mortgage_present;
			integer iv_prv_addr_mortgage_amount   ; // := iv_prv_addr_mortgage_amount;
			integer iv_prv_addr_assessed_total_val; // := iv_prv_addr_assessed_total_val;
			integer prv_addr_date_first_seen      ; // := prv_addr_date_first_seen;
			integer iv_mos_since_prv_addr_fseen   ; // := iv_mos_since_prv_addr_fseen;
			integer prv_addr_date_last_seen       ; // := prv_addr_date_last_seen;
			integer iv_mos_since_prv_addr_lseen   ; // := iv_mos_since_prv_addr_lseen;
			integer iv_prop_owned_purchase_total  ; // := iv_prop_owned_purchase_total;
			integer iv_prop_owned_assessed_total  ; // := iv_prop_owned_assessed_total;
			integer iv_prop_owned_assessed_count  ; // := iv_prop_owned_assessed_count;
			real iv_avg_prop_assess_purch_amt  ; // := iv_avg_prop_assess_purch_amt;
			integer iv_prop_sold_purchase_total   ; // := iv_prop_sold_purchase_total;
			real iv_avg_prop_sold_purch_amt    ; // := iv_avg_prop_sold_purch_amt;
			integer iv_prop_sold_assessed_total   ; // := iv_prop_sold_assessed_total;
			real iv_avg_prop_sold_assess_amt   ; // := iv_avg_prop_sold_assess_amt;
			integer iv_purch_sold_ct_diff         ; // := iv_purch_sold_ct_diff;
			integer iv_purch_sold_val_diff        ; // := iv_purch_sold_val_diff;
			integer iv_purch_sold_assess_val_diff ; // := iv_purch_sold_assess_val_diff;
			integer iv_prop1_sale_price; // := iv_prop1_sale_price;
			integer _prop1_sale_date   ; // := _prop1_sale_date;
			integer iv_mos_since_prop1_sale       ; // := iv_mos_since_prop1_sale;
			integer iv_prop1_purch_sale_diff      ; // := iv_prop1_purch_sale_diff;
			integer iv_prop2_sale_price; // := iv_prop2_sale_price;
			integer _prop2_sale_date   ; // := _prop2_sale_date;
			integer iv_mos_since_prop2_sale       ; // := iv_mos_since_prop2_sale;
			integer iv_prop2_purch_sale_diff      ; // := iv_prop2_purch_sale_diff;
			integer iv_dist_bst_addr_to_prv_addr  ; // := iv_dist_bst_addr_to_prv_addr;
			integer iv_dist_inp_addr_to_prv_addr  ; // := iv_dist_inp_addr_to_prv_addr;
			integer iv_avg_lres			; // := iv_avg_lres;
			integer iv_max_lres			; // := iv_max_lres;
			integer iv_addrs_10yr		; // := iv_addrs_10yr;
			integer iv_unique_addr_count          ; // := iv_unique_addr_count;
			integer iv_addr_lres_6mo_count        ; // := iv_addr_lres_6mo_count;
			integer iv_addr_lres_12mo_count       ; // := iv_addr_lres_12mo_count;
			integer iv_hist_addr_match ; // := iv_hist_addr_match;
			integer iv_avg_num_sources_per_addr   ; // := iv_avg_num_sources_per_addr;
			integer _gong_did_first_seen          ; // := _gong_did_first_seen;
			integer iv_mos_since_gong_did_fst_seen; // := iv_mos_since_gong_did_fst_seen;
			integer _gong_did_last_seen; // := _gong_did_last_seen;
			integer iv_mos_since_gong_did_lst_seen; // := iv_mos_since_gong_did_lst_seen;
			integer iv_gong_did_phone_ct          ; // := iv_gong_did_phone_ct;
			integer iv_addrs_per_adl   ; // := iv_addrs_per_adl;
			integer iv_lnames_per_adl  ; // := iv_lnames_per_adl;
			integer iv_adls_per_addr   ; // := iv_adls_per_addr;
			integer iv_adls_per_sfd_addr          ; // := iv_adls_per_sfd_addr;
			integer iv_ssns_per_addr   ; // := iv_ssns_per_addr;
			integer iv_ssns_per_sfd_addr          ; // := iv_ssns_per_sfd_addr;
			integer iv_phones_per_apt_addr        ; // := iv_phones_per_apt_addr;
			integer iv_phones_per_sfd_addr        ; // := iv_phones_per_sfd_addr;
			integer iv_max_ids_per_addr; // := iv_max_ids_per_addr;
			integer iv_max_ids_per_sfd_addr       ; // := iv_max_ids_per_sfd_addr;
			integer iv_adls_per_phone  ; // := iv_adls_per_phone;
			integer iv_ssns_per_adl_c6 ; // := iv_ssns_per_adl_c6;
			integer iv_adls_per_addr_c6; // := iv_adls_per_addr_c6;
			integer iv_adls_per_sfd_addr_c6       ; // := iv_adls_per_sfd_addr_c6;
			integer iv_ssns_per_sfd_addr_c6       ; // := iv_ssns_per_sfd_addr_c6;
			integer iv_max_ids_per_sfd_addr_c6    ; // := iv_max_ids_per_sfd_addr_c6;
			integer iv_phones_per_addr_c6         ; // := iv_phones_per_addr_c6;
			integer iv_adls_per_phone_c6          ; // := iv_adls_per_phone_c6;
			integer iv_vo_addrs_per_adl; // := iv_vo_addrs_per_adl;
			integer iv_pl_addrs_per_adl; // := iv_pl_addrs_per_adl;
			integer iv_inq_auto_count12; // := iv_inq_auto_count12;
			integer iv_inq_auto_recency; // := iv_inq_auto_recency;
			integer iv_inq_ssns_per_adl; // := iv_inq_ssns_per_adl;
			integer iv_inq_addrs_per_adl          ; // := iv_inq_addrs_per_adl;
			integer iv_inq_num_diff_names_per_adl ; // := iv_inq_num_diff_names_per_adl;
			integer iv_inq_phones_per_adl         ; // := iv_inq_phones_per_adl;
			integer iv_inq_dobs_per_adl; // := iv_inq_dobs_per_adl;
			integer iv_inq_per_ssn     ; // := iv_inq_per_ssn;
			integer iv_inq_addrs_per_ssn          ; // := iv_inq_addrs_per_ssn;
			integer iv_inq_per_addr    ; // := iv_inq_per_addr;
			integer iv_inq_lnames_per_addr        ; // := iv_inq_lnames_per_addr;
			integer iv_inq_ssns_per_addr          ; // := iv_inq_ssns_per_addr;
			integer iv_inq_per_phone   ; // := iv_inq_per_phone;
			integer _paw_first_seen    ; // := _paw_first_seen;
			integer iv_mos_since_paw_first_seen   ; // := iv_mos_since_paw_first_seen;
			integer iv_paw_dead_business_count    ; // := iv_paw_dead_business_count;
			integer iv_paw_active_phone_count     ; // := iv_paw_active_phone_count;
			integer _infutor_first_seen; // := _infutor_first_seen;
			integer iv_mos_since_infutor_first_seen ; // := iv_mos_since_infutor_first_seen;
			integer _infutor_last_seen ; // := _infutor_last_seen;
			integer iv_mos_since_infutor_last_seen; // := iv_mos_since_infutor_last_seen;
			string iv_infutor_nap     ; // := iv_infutor_nap;
			integer iv_attr_addrs_recency         ; // := iv_attr_addrs_recency;
			integer iv_attr_purchase_recency      ; // := iv_attr_purchase_recency;
			integer iv_attr_rel_liens_recency     ; // := iv_attr_rel_liens_recency;
			integer iv_attr_bankruptcy_recency    ; // := iv_attr_bankruptcy_recency;
			integer iv_attr_proflic_exp_recency   ; // := iv_attr_proflic_exp_recency;
			integer iv_non_derog_count ; // := iv_non_derog_count;
			integer iv_unreleased_liens_ct        ; // := iv_unreleased_liens_ct;
			integer iv_liens_unrel_cj_ct          ; // := iv_liens_unrel_cj_ct;
			integer iv_liens_unrel_ft_ct          ; // := iv_liens_unrel_ft_ct;
			integer iv_liens_rel_ft_ct ; // := iv_liens_rel_ft_ct;
			integer iv_liens_unrel_lt_ct          ; // := iv_liens_unrel_lt_ct;
			integer iv_liens_rel_ot_ct ; // := iv_liens_rel_ot_ct;
			boolean ams_major_medical  ; // := ams_major_medical;
			boolean ams_major_science  ; // := ams_major_science;
			boolean ams_major_liberal  ; // := ams_major_liberal;
			boolean ams_major_business ; // := ams_major_business;
			boolean ams_major_unknown  ; // := ams_major_unknown;
			string iv_ams_college_major          ; // := iv_ams_college_major;
			string iv_ams_college_code; // := iv_ams_college_code;
			string iv_ams_college_type; // := iv_ams_college_type;
			string iv_ams_college_tier; // := iv_ams_college_tier;
			string iv_ams_file_type   ; // := iv_ams_file_type;
			string iv_prof_license_category      ; // := iv_prof_license_category;
			real final_score_0		; // := final_score_0;
			real final_score_1		; // := final_score_1;
			real final_score_2		; // := final_score_2;
			real final_score_3		; // := final_score_3;
			real final_score_4		; // := final_score_4;
			real final_score_5		; // := final_score_5;
			real final_score_6		; // := final_score_6;
			real final_score_7		; // := final_score_7;
			real final_score_8		; // := final_score_8;
			real final_score_9		; // := final_score_9;
			real final_score_10     ; // := final_score_10;
			real final_score_11     ; // := final_score_11;
			real final_score_12     ; // := final_score_12;
			real final_score_13     ; // := final_score_13;
			real final_score_14     ; // := final_score_14;
			real final_score_15     ; // := final_score_15;
			real final_score_16     ; // := final_score_16;
			real final_score_17     ; // := final_score_17;
			real final_score_18     ; // := final_score_18;
			real final_score_19     ; // := final_score_19;
			real final_score_20     ; // := final_score_20;
			real final_score_21     ; // := final_score_21;
			real final_score_22     ; // := final_score_22;
			real final_score_23     ; // := final_score_23;
			real final_score_24     ; // := final_score_24;
			real final_score_25     ; // := final_score_25;
			real final_score_26     ; // := final_score_26;
			real final_score_27     ; // := final_score_27;
			real final_score_28     ; // := final_score_28;
			real final_score_29     ; // := final_score_29;
			real final_score_30     ; // := final_score_30;
			real final_score_31     ; // := final_score_31;
			real final_score_32     ; // := final_score_32;
			real final_score_33     ; // := final_score_33;
			real final_score_34     ; // := final_score_34;
			real final_score_35     ; // := final_score_35;
			real final_score_36     ; // := final_score_36;
			real final_score_37     ; // := final_score_37;
			real final_score_38     ; // := final_score_38;
			real final_score_39     ; // := final_score_39;
			real final_score_40     ; // := final_score_40;
			real final_score_41     ; // := final_score_41;
			real final_score_42     ; // := final_score_42;
			real final_score_43     ; // := final_score_43;
			real final_score_44     ; // := final_score_44;
			real final_score_45     ; // := final_score_45;
			real final_score_46     ; // := final_score_46;
			real final_score_47     ; // := final_score_47;
			real final_score_48     ; // := final_score_48;
			real final_score_49     ; // := final_score_49;
			real final_score_50     ; // := final_score_50;
			real final_score_51     ; // := final_score_51;
			real final_score_52     ; // := final_score_52;
			real final_score_53     ; // := final_score_53;
			real final_score_54     ; // := final_score_54;
			real final_score_55     ; // := final_score_55;
			real final_score_56     ; // := final_score_56;
			real final_score_57     ; // := final_score_57;
			real final_score_58     ; // := final_score_58;
			real final_score_59     ; // := final_score_59;
			real final_score_60     ; // := final_score_60;
			real final_score_61     ; // := final_score_61;
			real final_score_62     ; // := final_score_62;
			real final_score_63     ; // := final_score_63;
			real final_score_64     ; // := final_score_64;
			real final_score_65     ; // := final_score_65;
			real final_score_66     ; // := final_score_66;
			real final_score_67     ; // := final_score_67;
			real final_score_68     ; // := final_score_68;
			real final_score_69     ; // := final_score_69;
			real final_score_70     ; // := final_score_70;
			real final_score_71     ; // := final_score_71;
			real final_score_72     ; // := final_score_72;
			real final_score_73     ; // := final_score_73;
			real final_score_74     ; // := final_score_74;
			real final_score_75     ; // := final_score_75;
			real final_score_76     ; // := final_score_76;
			real final_score_77     ; // := final_score_77;
			real final_score_78     ; // := final_score_78;
			real final_score_79     ; // := final_score_79;
			real final_score_80     ; // := final_score_80;
			real final_score_81     ; // := final_score_81;
			real final_score_82     ; // := final_score_82;
			real final_score_83     ; // := final_score_83;
			real final_score_84     ; // := final_score_84;
			real final_score_85     ; // := final_score_85;
			real final_score_86     ; // := final_score_86;
			real final_score_87     ; // := final_score_87;
			real final_score_88     ; // := final_score_88;
			real final_score_89     ; // := final_score_89;
			real final_score_90     ; // := final_score_90;
			real final_score_91     ; // := final_score_91;
			real final_score_92     ; // := final_score_92;
			real final_score_93     ; // := final_score_93;
			real final_score_94     ; // := final_score_94;
			real final_score_95     ; // := final_score_95;
			real final_score_96     ; // := final_score_96;
			real final_score_97     ; // := final_score_97;
			real final_score_98     ; // := final_score_98;
			real final_score_99     ; // := final_score_99;
			real final_score_100    ; // := final_score_100;
			real final_score_101    ; // := final_score_101;
			real final_score_102    ; // := final_score_102;
			real final_score_103    ; // := final_score_103;
			real final_score_104    ; // := final_score_104;
			real final_score_105    ; // := final_score_105;
			real final_score_106    ; // := final_score_106;
			real final_score_107    ; // := final_score_107;
			real final_score_108    ; // := final_score_108;
			real final_score_109    ; // := final_score_109;
			real final_score_110    ; // := final_score_110;
			real final_score_111    ; // := final_score_111;
			real final_score_112    ; // := final_score_112;
			real final_score_113    ; // := final_score_113;
			real final_score_114    ; // := final_score_114;
			real final_score_115    ; // := final_score_115;
			real final_score_116    ; // := final_score_116;
			real final_score_117    ; // := final_score_117;
			real final_score_118    ; // := final_score_118;
			real final_score_119    ; // := final_score_119;
			real final_score_120    ; // := final_score_120;
			real final_score_121    ; // := final_score_121;
			real final_score_122    ; // := final_score_122;
			real final_score_123    ; // := final_score_123;
			real final_score_124    ; // := final_score_124;
			real final_score_125    ; // := final_score_125;
			real final_score_126    ; // := final_score_126;
			real final_score_127    ; // := final_score_127;
			real final_score_128    ; // := final_score_128;
			real final_score_129    ; // := final_score_129;
			real final_score_130    ; // := final_score_130;
			real final_score_131    ; // := final_score_131;
			real final_score_132    ; // := final_score_132;
			real final_score_133    ; // := final_score_133;
			real final_score_134    ; // := final_score_134;
			real final_score_135    ; // := final_score_135;
			real final_score_136    ; // := final_score_136;
			real final_score_137    ; // := final_score_137;
			real final_score_138    ; // := final_score_138;
			real final_score_139    ; // := final_score_139;
			real final_score_140    ; // := final_score_140;
			real final_score_141    ; // := final_score_141;
			real final_score_142    ; // := final_score_142;
			real final_score_143    ; // := final_score_143;
			real final_score_144    ; // := final_score_144;
			real final_score_145    ; // := final_score_145;
			real final_score_146    ; // := final_score_146;
			real final_score_147    ; // := final_score_147;
			real final_score_148    ; // := final_score_148;
			real final_score_149    ; // := final_score_149;
			real final_score_150    ; // := final_score_150;
			real final_score_151    ; // := final_score_151;
			real final_score_152    ; // := final_score_152;
			real final_score_153    ; // := final_score_153;
			real final_score_154    ; // := final_score_154;
			real final_score_155    ; // := final_score_155;
			real final_score_156    ; // := final_score_156;
			real final_score_157    ; // := final_score_157;
			real final_score_158    ; // := final_score_158;
			real final_score_159    ; // := final_score_159;
			real final_score_160    ; // := final_score_160;
			real final_score_161    ; // := final_score_161;
			real final_score_162    ; // := final_score_162;
			real final_score_163    ; // := final_score_163;
			real final_score_164    ; // := final_score_164;
			real final_score_165    ; // := final_score_165;
			real final_score_166    ; // := final_score_166;
			real final_score_167    ; // := final_score_167;
			real final_score_168    ; // := final_score_168;
			real final_score_169    ; // := final_score_169;
			real final_score_170    ; // := final_score_170;
			real final_score_171    ; // := final_score_171;
			real final_score_172    ; // := final_score_172;
			real final_score_173    ; // := final_score_173;
			real final_score_174    ; // := final_score_174;
			real final_score_175    ; // := final_score_175;
			real final_score_176    ; // := final_score_176;
			real final_score_177    ; // := final_score_177;
			real final_score_178    ; // := final_score_178;
			real final_score_179    ; // := final_score_179;
			real final_score_180    ; // := final_score_180;
			real final_score_181    ; // := final_score_181;
			real final_score_182    ; // := final_score_182;
			real final_score_183    ; // := final_score_183;
			real final_score_184    ; // := final_score_184;
			real final_score_185    ; // := final_score_185;
			real final_score_186    ; // := final_score_186;
			real final_score_187    ; // := final_score_187;
			real final_score_188    ; // := final_score_188;
			real final_score_189    ; // := final_score_189;
			real final_score_190    ; // := final_score_190;
			real final_score_191    ; // := final_score_191;
			real final_score_192    ; // := final_score_192;
			real final_score_193    ; // := final_score_193;
			real final_score_194    ; // := final_score_194;
			real final_score_195    ; // := final_score_195;
			real final_score_196    ; // := final_score_196;
			real final_score_197    ; // := final_score_197;
			real final_score_198    ; // := final_score_198;
			real final_score_199    ; // := final_score_199;
			real final_score_200    ; // := final_score_200;
			real final_score_201    ; // := final_score_201;
			real final_score_202    ; // := final_score_202;
			real final_score_203    ; // := final_score_203;
			real final_score_204    ; // := final_score_204;
			real final_score_205    ; // := final_score_205;
			real final_score_206    ; // := final_score_206;
			real final_score_207    ; // := final_score_207;
			real final_score_208    ; // := final_score_208;
			real final_score_209    ; // := final_score_209;
			real final_score_210    ; // := final_score_210;
			real final_score_211    ; // := final_score_211;
			real final_score_212    ; // := final_score_212;
			real final_score_213    ; // := final_score_213;
			real final_score_214    ; // := final_score_214;
			real final_score_215    ; // := final_score_215;
			real final_score_216    ; // := final_score_216;
			real final_score_217    ; // := final_score_217;
			real final_score_218    ; // := final_score_218;
			real final_score_219    ; // := final_score_219;
			real final_score_220    ; // := final_score_220;
			real final_score_221    ; // := final_score_221;
			real final_score_222    ; // := final_score_222;
			real final_score_223    ; // := final_score_223;
			real final_score_224    ; // := final_score_224;
			real final_score_225    ; // := final_score_225;
			real final_score_226    ; // := final_score_226;
			real final_score_227    ; // := final_score_227;
			real final_score_228    ; // := final_score_228;
			real final_score_229    ; // := final_score_229;
			real final_score_230    ; // := final_score_230;
			real final_score_231    ; // := final_score_231;
			real final_score_232    ; // := final_score_232;
			real final_score_233    ; // := final_score_233;
			real final_score_234    ; // := final_score_234;
			real final_score_235    ; // := final_score_235;
			real final_score_236    ; // := final_score_236;
			real final_score_237    ; // := final_score_237;
			real final_score_238    ; // := final_score_238;
			real final_score_239    ; // := final_score_239;
			real final_score_240    ; // := final_score_240;
			real final_score_241    ; // := final_score_241;
			real final_score_242    ; // := final_score_242;
			real final_score_243    ; // := final_score_243;
			real final_score_244    ; // := final_score_244;
			real final_score_245    ; // := final_score_245;
			real final_score_246    ; // := final_score_246;
			real final_score_247    ; // := final_score_247;
			real final_score_248    ; // := final_score_248;
			real final_score_249    ; // := final_score_249;
			real final_score_250    ; // := final_score_250;
			real final_score_251    ; // := final_score_251;
			real final_score_252    ; // := final_score_252;
			real final_score_253    ; // := final_score_253;
			real final_score_254    ; // := final_score_254;
			real final_score_255    ; // := final_score_255;
			real final_score_256    ; // := final_score_256;
			real final_score_257    ; // := final_score_257;
			real final_score_258    ; // := final_score_258;
			real final_score_259    ; // := final_score_259;
			real final_score_260    ; // := final_score_260;
			real final_score_261    ; // := final_score_261;
			real final_score_262    ; // := final_score_262;
			real final_score_263    ; // := final_score_263;
			real final_score_264    ; // := final_score_264;
			real final_score_265    ; // := final_score_265;
			real final_score_266    ; // := final_score_266;
			real final_score_267    ; // := final_score_267;
			real final_score_268    ; // := final_score_268;
			real final_score_269    ; // := final_score_269;
			real final_score_270    ; // := final_score_270;
			real final_score_271    ; // := final_score_271;
			real final_score_272    ; // := final_score_272;
			real final_score_273    ; // := final_score_273;
			real final_score_274    ; // := final_score_274;
			real final_score_275    ; // := final_score_275;
			real final_score_276    ; // := final_score_276;
			real final_score_277    ; // := final_score_277;
			real final_score_278    ; // := final_score_278;
			real final_score_279    ; // := final_score_279;
			real final_score_280    ; // := final_score_280;
			real final_score_281    ; // := final_score_281;
			real final_score_282    ; // := final_score_282;
			real final_score_283    ; // := final_score_283;
			real final_score_284    ; // := final_score_284;
			real final_score_285    ; // := final_score_285;
			real final_score_286    ; // := final_score_286;
			real final_score_287    ; // := final_score_287;
			real final_score_288    ; // := final_score_288;
			real final_score_289    ; // := final_score_289;
			real final_score_290    ; // := final_score_290;
			real final_score_291    ; // := final_score_291;
			real final_score_292    ; // := final_score_292;
			real final_score_293    ; // := final_score_293;
			real final_score_294    ; // := final_score_294;
			real final_score_295    ; // := final_score_295;
			real final_score_296    ; // := final_score_296;
			real final_score_297    ; // := final_score_297;
			real final_score_298    ; // := final_score_298;
			real final_score_299    ; // := final_score_299;
			real final_score_300    	; // := final_score_300;
			real final_score_301    	; // := final_score_301;
			real final_score_302    	; // := final_score_302;
			real final_score_303    	; // := final_score_303;
			real final_score_304    	; // := final_score_304;
			real final_score_305    	; // := final_score_305;
			real final_score_306    	; // := final_score_306;
			real final_score_307    	; // := final_score_307;
			real final_score_308    	; // := final_score_308;
			real final_score_309    	; // := final_score_309;
			real final_score_310    	; // := final_score_310;
			real final_score_311    	; // := final_score_311;
			real final_score_312    	; // := final_score_312;
			real final_score_313    	; // := final_score_313;
			real final_score_314    	; // := final_score_314;
			real final_score_315    	; // := final_score_315;
			real final_score_316    	; // := final_score_316;
			real final_score_317    	; // := final_score_317;
			real final_score_318    	; // := final_score_318;
			real final_score_319    	; // := final_score_319;
			real final_score_320    	; // := final_score_320;
			real final_score_321    	; // := final_score_321;
			real final_score_322    	; // := final_score_322;
			real final_score_323    	; // := final_score_323;
			real final_score_324    	; // := final_score_324;
			real final_score_325    	; // := final_score_325;
			real final_score_326    	; // := final_score_326;
			real final_score_327    	; // := final_score_327;
			real final_score_328    	; // := final_score_328;
			real final_score_329    	; // := final_score_329;
			real final_score_330    	; // := final_score_330;
			real final_score_331    	; // := final_score_331;
			real final_score_332    	; // := final_score_332;
			real final_score_333    	; // := final_score_333;
			real final_score_334    	; // := final_score_334;
			real final_score_335    	; // := final_score_335;
			real final_score_336    	; // := final_score_336;
			real final_score_337    	; // := final_score_337;
			real final_score_338    	; // := final_score_338;
			real final_score_339    	; // := final_score_339;
			real final_score_340    	; // := final_score_340;
			real final_score_341    	; // := final_score_341;
			real final_score_342    	; // := final_score_342;
			real final_score_343    	; // := final_score_343;
			real final_score_344    	; // := final_score_344;
			real final_score_345    	; // := final_score_345;
			real final_score_346    	; // := final_score_346;
			real final_score_347    	; // := final_score_347;
			real final_score_348    	; // := final_score_348;
			real final_score_349    	; // := final_score_349;
			real final_score_350    	; // := final_score_350;
			real final_score_351    	; // := final_score_351;
			real final_score_352    	; // := final_score_352;
			real final_score_353    	; // := final_score_353;
			real final_score_354    	; // := final_score_354;
			real final_score_355    	; // := final_score_355;
			real final_score_356    	; // := final_score_356;
			real final_score_357    	; // := final_score_357;
			real final_score_358    	; // := final_score_358;
			real final_score_359    	; // := final_score_359;
			real final_score_360    	; // := final_score_360;
			real final_score_361    	; // := final_score_361;
			real final_score_362    	; // := final_score_362;
			real final_score_363    	; // := final_score_363;
			real final_score_364    	; // := final_score_364;
			real final_score_365    	; // := final_score_365;
			real final_score_366    	; // := final_score_366;
			real final_score_367    	; // := final_score_367;
			real final_score_368    	; // := final_score_368;
			real final_score_369    	; // := final_score_369;
			real final_score_370    	; // := final_score_370;
			real final_score_371    	; // := final_score_371;
			real final_score_372    	; // := final_score_372;
			real final_score_373    	; // := final_score_373;
			real final_score_374    	; // := final_score_374;
			real final_score_375    	; // := final_score_375;
			real final_score_376    	; // := final_score_376;
			real final_score					; // := final_score;
			boolean ssn_deceased					; // := ssn_deceased;
			boolean iv_riskview_222s   	; // := iv_riskview_222s;
			real pbr			       			; // := pbr;
			real sbr			       			; // := sbr;
			real offset			    			; // := offset;
			integer base			      			; // := base;
			integer pts			       			; // := pts;
			real lgt			       			; // := lgt;
			integer rvc1703_1_0					; // := rvc1703_1_0;
			real rc1v			      			; // := rc1v;
			real rc2v			      			; // := rc2v;
			real rc3v			      			; // := rc3v;
			real rc4v			      			; // := rc4v;
			integer model_lien_present 	; // := model_lien_present;
			string rc3			      			; // := rc3;
			string rc2			       			; // := rc2;
			string rc1			       			; // := rc1;
			string rc4			       			; // := rc4;
			string rc5			       			; // := rc5;

			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	
	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_z5                           := le.shell_input.z5;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_type                         := le.iid.nap_type;
	nap_status                       := le.iid.nap_status;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_phonezipflag                  := le.iid.phonezipflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssnlowissue                   := le.iid.socllowissue;
	rc_ssnhighissue                  := le.iid.soclhighissue;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_fnamecount                    := le.iid.firstcount;
	rc_addrcount                     := le.iid.addrcount;
	rc_phoneaddrcount                := le.iid.phoneaddrcount;
	rc_phoneaddr_addrcount           := le.iid.phoneaddr_addrcount;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	rc_phonetype                     := le.iid.phonetype;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_dobcount                   := le.iid.combo_dobcount;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_lname_sources_first_seen     := le.header_summary.ver_lname_sources_first_seen_date;
	ver_lname_sources_count          := le.header_summary.ver_lname_sources_recordcount;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_addr_sources_first_seen      := le.header_summary.ver_addr_sources_first_seen_date;
	ver_addr_sources_count           := le.header_summary.ver_addr_sources_recordcount;
	ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
	ver_ssn_sources_first_seen       := le.header_summary.ver_ssn_sources_first_seen_date;
	ver_ssn_sources_count            := le.header_summary.ver_ssn_sources_recordcount;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	ver_dob_sources_first_seen       := le.header_summary.ver_dob_sources_first_seen_date;
	ver_dob_sources_count            := le.header_summary.ver_dob_sources_recordcount;
	voter_avail                      := le.available_sources.voter;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	lname_change_date                := le.name_verification.lname_change_date;
	source_count                     := le.name_verification.source_count;
	fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
	lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.lres;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
	add1_avm_automated_valuation_3   := le.avm.input_address_information.avm_automated_valuation3;
	add1_avm_automated_valuation_4   := le.avm.input_address_information.avm_automated_valuation4;
	add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
	add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
	add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_financing_type              := le.address_verification.input_address_information.type_financing;
	add1_mortgage_due_date           := le.address_verification.input_address_information.first_td_due_date;
	add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
	add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
	add1_building_area               := le.address_verification.input_address_information.building_area;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_purchase_total    := le.address_verification.owned.property_owned_purchase_total;
	property_owned_purchase_count    := le.address_verification.owned.property_owned_purchase_count;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
	property_sold_total              := le.address_verification.sold.property_total;
	property_sold_purchase_total     := le.address_verification.sold.property_owned_purchase_total;
	property_sold_purchase_count     := le.address_verification.sold.property_owned_purchase_count;
	property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
	property_sold_assessed_count     := le.address_verification.sold.property_owned_assessed_count;
	prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
	prop1_sale_date                  := le.address_verification.recent_property_sales.sale_date1;
	prop1_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price1;
	prop2_sale_price                 := le.address_verification.recent_property_sales.sale_price2;
	prop2_sale_date                  := le.address_verification.recent_property_sales.sale_date2;
	prop2_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price2;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
	add2_lres                        := le.lres2;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_avm_automated_valuation_2   := le.avm.address_history_1.avm_automated_valuation2;
	add2_avm_automated_valuation_3   := le.avm.address_history_1.avm_automated_valuation3;
	add2_avm_automated_valuation_4   := le.avm.address_history_1.avm_automated_valuation4;
	add2_avm_med_fips                := le.avm.address_history_1.avm_median_fips_level;
	add2_avm_med_geo11               := le.avm.address_history_1.avm_median_geo11_level;
	add2_avm_med_geo12               := le.avm.address_history_1.avm_median_geo12_level;
	add2_source_count                := le.address_verification.address_history_1.source_count;
	add2_eda_sourced                 := le.address_verification.address_history_1.eda_sourced;
	add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
	add2_occupant_owned              := le.address_verification.address_history_1.occupant_owned;
	add2_family_owned                := le.address_verification.address_history_1.family_owned;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add2_building_area               := le.address_verification.address_history_1.building_area;
	add2_mortgage_amount             := le.address_verification.address_history_1.mortgage_amount;
	add2_mortgage_date               := le.address_verification.address_history_1.mortgage_date;
	add2_financing_type              := le.address_verification.address_history_1.type_financing;
	add2_assessed_total_value        := le.address_verification.address_history_1.assessed_total_value;
	add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
	add2_date_last_seen              := le.address_verification.address_history_1.date_last_seen;
	add3_lres                        := le.lres3;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	add3_source_count                := le.address_verification.address_history_2.source_count;
	add3_eda_sourced                 := le.address_verification.address_history_2.eda_sourced;
	add3_naprop                      := le.address_verification.address_history_2.naprop;
	add3_mortgage_amount             := le.address_verification.address_history_2.mortgage_amount;
	add3_mortgage_date               := le.address_verification.address_history_2.mortgage_date;
	add3_assessed_total_value        := le.address_verification.address_history_2.assessed_total_value;
	add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
	add3_date_last_seen              := le.address_verification.address_history_2.date_last_seen;
	avg_lres                         := le.other_address_info.avg_lres;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
	addr_count2                      := le.address_history_summary.addr_count2;
	addr_count_ge3                   := le.address_history_summary.addr_count3;
	addr_count_ge6                   := le.address_history_summary.addr_count6;
	addr_count_ge10                  := le.address_history_summary.addr_count10;
	addr_lres_6mo_count              := le.address_history_summary.lres_6mo_count;
	addr_lres_12mo_count             := le.address_history_summary.lres_12mo_count;
	hist_addr_match                  := le.address_history_summary.hist_addr_match;
	telcordia_type                   := le.phone_verification.telcordia_type;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	lnames_per_adl                   := le.velocity_counters.lnames_per_adl;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	phones_per_addr                  := le.velocity_counters.phones_per_addr;
	adls_per_phone                   := le.velocity_counters.adls_per_phone;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
	adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
	vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
	pl_addrs_per_adl                 := le.velocity_counters.pl_addrs_per_adl;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_lnamesperadl                 := le.acc_logs.inquirylnamesperadl;
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
	inq_perssn                       := le.acc_logs.inquiryperssn;
	inq_addrsperssn                  := le.acc_logs.inquiryaddrsperssn;
	inq_peraddr                      := le.acc_logs.inquiryperaddr;
	inq_lnamesperaddr                := le.acc_logs.inquirylnamesperaddr;
	inq_ssnsperaddr                  := le.acc_logs.inquiryssnsperaddr;
	inq_perphone                     := le.acc_logs.inquiryperphone;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_date_first_purchase         := le.other_address_info.date_first_purchase;
	attr_num_purchase30              := le.other_address_info.num_purchase30;
	attr_num_purchase90              := le.other_address_info.num_purchase90;
	attr_num_purchase180             := le.other_address_info.num_purchase180;
	attr_num_purchase12              := le.other_address_info.num_purchase12;
	attr_num_purchase24              := le.other_address_info.num_purchase24;
	attr_num_purchase36              := le.other_address_info.num_purchase36;
	attr_num_purchase60              := le.other_address_info.num_purchase60;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_num_rel_liens30             := le.bjl.liens_released_count30;
	attr_num_rel_liens90             := le.bjl.liens_released_count90;
	attr_num_rel_liens180            := le.bjl.liens_released_count180;
	attr_num_rel_liens12             := le.bjl.liens_released_count12;
	attr_num_rel_liens24             := le.bjl.liens_released_count24;
	attr_num_rel_liens36             := le.bjl.liens_released_count36;
	attr_num_rel_liens60             := le.bjl.liens_released_count60;
	attr_bankruptcy_count30          := le.bjl.bk_count30;
	attr_bankruptcy_count90          := le.bjl.bk_count90;
	attr_bankruptcy_count180         := le.bjl.bk_count180;
	attr_bankruptcy_count12          := le.bjl.bk_count12;
	attr_bankruptcy_count24          := le.bjl.bk_count24;
	attr_bankruptcy_count36          := le.bjl.bk_count36;
	attr_bankruptcy_count60          := le.bjl.bk_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	attr_num_proflic_exp30           := le.professional_license.expire_count30;
	attr_num_proflic_exp90           := le.professional_license.expire_count90;
	attr_num_proflic_exp180          := le.professional_license.expire_count180;
	attr_num_proflic_exp12           := le.professional_license.expire_count12;
	attr_num_proflic_exp24           := le.professional_license.expire_count24;
	attr_num_proflic_exp36           := le.professional_license.expire_count36;
	attr_num_proflic_exp60           := le.professional_license.expire_count60;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
	liens_rel_ft_ct                  := le.liens.liens_released_federal_tax.count;
	liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_last_date                 := le.bjl.last_felony_date;
	ams_date_first_seen              := le.student.date_first_seen;
	ams_age                          := le.student.age;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	prof_license_category            := le.professional_license.plcategory;
	wealth_index                     := le.wealth_indicator;
	input_dob_age                    := le.shell_input.age;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	estimated_income                 := le.estimated_income;


	/* ***********************************************************
	 *   Generated ECL                                           *
	 ************************************************************* */
	
NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' 
              or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' 
							or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

iv_vp090_phn_dst_to_inp_add := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);

iv_vp091_phnzip_mismatch := map(
    not(hphnpop and not(out_z5 = ''))          => ' ',
    rc_phonezipflag = '1' or rc_pwphonezipflag = '1' => '1',
    rc_phonezipflag = '0' or rc_pwphonezipflag = '0' => '0',
                                                    ' ');

iv_vp100_phn_prob := map(
    not(hphnpop)                                                                                           => '                   ',
    rc_hphonetypeflag = 'A'                                                                                => '8 Pay_Phone        ',
    rc_hriskphoneflag = '3' or rc_hphonetypeflag = '3' or (telcordia_type in ['64', '65', '66', '67', '68']) => '7 PCS              ',
    rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61'])             => '6 Pager            ',
    rc_hriskphoneflag = '1' or rc_hphonetypeflag = '1' or (telcordia_type in ['04', '55', '60'])             => '5 Cell             ',
    rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5'                                        => '4 Invalid          ',
    rc_pwphonezipflag = '4'                                                                                  => '3 Not_Issued       ',
    rc_hriskphoneflag = '5' or nap_status = 'D'                                                              => '2 Disconnected     ',
    rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1'        => '1 HiRisk           ',
                                                                                                              '0 No Phone Problems');

iv_va060_dist_add_in_bst := map(
    not(truedid)       => NULL,
    add1_isbestmatch   => 0,
    dist_a1toa2 = 9999 => NULL,
                          dist_a1toa2);

_felony_last_date := common.sas_date((string)(felony_last_date));

iv_df001_mos_since_fel_ls := map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => -1,
                                min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240));

iv_db001_bankruptcy := map(
    not(truedid or (integer)ssnlength > 0)                                                                                               => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
                                                                                                                                   '0 - No BK        ');

iv_dg001_derog_count := if(not(truedid), NULL, attr_total_number_derogs);

iv_dl001_unrel_lien60_count := if(not(truedid), NULL, attr_num_unrel_liens60);

lien_adl_li_lseen_pos := Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E');

lien_adl_lseen_li := if(lien_adl_li_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, lien_adl_li_lseen_pos, ','));

_lien_adl_lseen_li := common.sas_date((string)(lien_adl_lseen_li));

lien_adl_l2_lseen_pos := Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E');

lien_adl_lseen_l2 := if(lien_adl_l2_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, lien_adl_l2_lseen_pos, ','));

_lien_adl_lseen_l2 := common.sas_date((string)(lien_adl_lseen_l2));

_src_lien_adl_lseen := max(_lien_adl_lseen_li, _lien_adl_lseen_l2, -1);

iv_dl001_lien_last_seen := map(
    not(truedid)             => NULL,
    _src_lien_adl_lseen = -1 => -1,
                                if ((sysdate - _src_lien_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_lien_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_lien_adl_lseen) / (365.25 / 12))));

bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E');

bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));

_bureau_adl_fseen_tn := common.sas_date((string)(bureau_adl_fseen_tn));

bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E');

bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));

_bureau_adl_fseen_ts := common.sas_date((string)(bureau_adl_fseen_ts));

bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E');

bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));

_bureau_adl_fseen_tu := common.sas_date((string)(bureau_adl_fseen_tu));

bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E');

bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));

_bureau_adl_fseen_en := common.sas_date((string)(bureau_adl_fseen_en));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen_1 := min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

iv_sr001_m_bureau_adl_fs := map(
    not(truedid)                     => NULL,
    _src_bureau_adl_fseen_1 = 999999 => -1,
                                        if ((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12))));

wp_adl_wp_fseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

wp_adl_fseen_wp := if(wp_adl_wp_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, wp_adl_wp_fseen_pos, ','));

_wp_adl_fseen_wp := common.sas_date((string)(wp_adl_fseen_wp));

_src_wp_adl_fseen := _wp_adl_fseen_wp;

iv_sr001_m_wp_adl_fs_1 := map(
    not(truedid)             => NULL,
    _src_wp_adl_fseen = NULL => -1,
                                if ((sysdate - _src_wp_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_wp_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_wp_adl_fseen) / (365.25 / 12))));

_header_first_seen_1 := common.sas_date((string)(header_first_seen));

iv_sr001_m_hdr_fs_1 := map(
    not(truedid)                     => NULL,
    not(_header_first_seen_1 = NULL) => if ((sysdate - _header_first_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen_1) / (365.25 / 12)), roundup((sysdate - _header_first_seen_1) / (365.25 / 12))),
                                        -1);

bureau_adl_vo_fseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

bureau_adl_fseen_vo := if(bureau_adl_vo_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_vo_fseen_pos, ','));

_bureau_adl_fseen_vo := common.sas_date((string)(bureau_adl_fseen_vo));

_src_bureau_adl_fseen := _bureau_adl_fseen_vo;

mth_ver_src_fdate_vo := map(
    not(truedid)                 => NULL,
    _src_bureau_adl_fseen = NULL => -1,
                                    if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))));

bureau_adl_vo_lseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

bureau_adl_lseen_vo := if(bureau_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_vo_lseen_pos, ','));

_bureau_adl_lseen_vo := common.sas_date((string)(bureau_adl_lseen_vo));

_src_bureau_adl_lseen_3 := _bureau_adl_lseen_vo;

mth_ver_src_ldate_vo := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_lseen_3 = NULL => -1,
                                      if ((sysdate - _src_bureau_adl_lseen_3) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_3) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_3) / (365.25 / 12))));

mth_ver_src_fdate_vo60 := mth_ver_src_fdate_vo > 60;

mth_ver_src_ldate_vo0 := mth_ver_src_ldate_vo = 0;

bureau_adl_w_lseen_pos := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E');

bureau_adl_lseen_w := if(bureau_adl_w_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_w_lseen_pos, ','));

_bureau_adl_lseen_w := common.sas_date((string)(bureau_adl_lseen_w));

_src_bureau_adl_lseen_2 := _bureau_adl_lseen_w;

mth_ver_src_ldate_w := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_lseen_2 = NULL => -1,
                                      if ((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12))));

mth_ver_src_ldate_w0 := mth_ver_src_ldate_w = 0;

bureau_adl_wp_lseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

bureau_adl_lseen_wp := if(bureau_adl_wp_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_wp_lseen_pos, ','));

_bureau_adl_lseen_wp := common.sas_date((string)(bureau_adl_lseen_wp));

_src_bureau_adl_lseen_1 := _bureau_adl_lseen_wp;

mth_ver_src_ldate_wp := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_lseen_1 = NULL => -1,
                                      if ((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12))));

mth_ver_src_ldate_wp0 := mth_ver_src_ldate_wp = 0;

_paw_first_seen_1 := common.sas_date((string)(PAW_first_seen));

mth_paw_first_seen := map(
    not(truedid)             => NULL,
    _paw_first_seen_1 = NULL => -1,
                                if ((sysdate - _paw_first_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen_1) / (365.25 / 12)), roundup((sysdate - _paw_first_seen_1) / (365.25 / 12))));

mth_paw_first_seen2 := if(mth_paw_first_seen = NULL or mth_paw_first_seen < 6, 6, min(360, if(mth_paw_first_seen = NULL, -NULL, mth_paw_first_seen)));

ver_src_am := Models.Common.findw_cpp(ver_sources, 'AM' , ', ', 'E') > 0;

ver_src_e1 := Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E') > 0;

ver_src_e2 := Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E') > 0;

ver_src_e3 := Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E') > 0;

ver_src_pl := Models.Common.findw_cpp(ver_sources, 'PL' , ', ', 'E') > 0;

ver_src_w := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') > 0;

paw_dead_business_count_gt3 := paw_dead_business_count > 3;

paw_active_phone_count_0 := paw_active_phone_count <= 0;

_infutor_first_seen_1 := common.sas_date((string)(infutor_first_seen));

mth_infutor_first_seen := map(
    not(truedid)                 => NULL,
    _infutor_first_seen_1 = NULL => NULL,
                                    if ((sysdate - _infutor_first_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen_1) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen_1) / (365.25 / 12))));

_infutor_last_seen_1 := common.sas_date((string)(infutor_last_seen));

mth_infutor_last_seen := map(
    not(truedid)                => NULL,
    _infutor_last_seen_1 = NULL => NULL,
                                   if ((sysdate - _infutor_last_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen_1) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen_1) / (365.25 / 12))));

infutor_i := map(
    infutor_nap = 12 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 1,
    infutor_nap = 12                                                                 => 4,
    infutor_nap = 11 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 3,
    infutor_nap = 11                                                                 => 5,
    infutor_nap >= 7 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 6,
    infutor_nap >= 7                                                                 => 7,
    (infutor_nap in [1, 6])                                                          => 8,
    (infutor_nap in [0])                                                             => 2,
                                                                                        7);

infutor_im := map(
    infutor_i = 1 => 7.77,
    infutor_i = 2 => 8.06,
    infutor_i = 3 => 8.38,
    infutor_i = 4 => 8.96,
    infutor_i = 5 => 9.35,
    infutor_i = 6 => 10.19,
    infutor_i = 7 => 13.13,
    infutor_i = 8 => 14.77,
                     9.03);

white_pages_adl_wp_fseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

white_pages_adl_fseen_wp := if(white_pages_adl_wp_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, white_pages_adl_wp_fseen_pos, ','));

_white_pages_adl_fseen_wp := common.sas_date((string)(white_pages_adl_fseen_wp));

_src_white_pages_adl_fseen := _white_pages_adl_fseen_wp;

iv_sr001_m_wp_adl_fs := map(
    not(truedid)                      => NULL,
    _src_white_pages_adl_fseen = NULL => -1,
                                         if ((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12))));

src_m_wp_adl_fs := map(
    iv_sr001_m_wp_adl_fs = NULL => -1,
    iv_sr001_m_wp_adl_fs = -1   => 10,
    iv_sr001_m_wp_adl_fs >= 24  => 24,
                                   iv_sr001_m_wp_adl_fs);

_header_first_seen := common.sas_date((string)(header_first_seen));

iv_sr001_m_hdr_fs := map(
    not(truedid)                   => NULL,
    not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
                                      -1);

src_m_hdr_fs := map(
    iv_sr001_m_hdr_fs = NULL => 15,
    iv_sr001_m_hdr_fs = -1   => 40,
    iv_sr001_m_hdr_fs >= 260 => 260,
                                iv_sr001_m_hdr_fs);

source_mod6_1 := -2.350792319 +
    (integer)ver_src_am * -0.611853123 +
    (integer)ver_src_e1 * -0.208450798 +
    (integer)ver_src_e2 * -0.23159296 +
    (integer)ver_src_e3 * -0.415443106 +
    (integer)ver_src_pl * -0.275168358 +
    (integer)mth_ver_src_fdate_vo60 * -0.119660071 +
    (integer)mth_ver_src_ldate_vo0 * -0.322346162 +
    (integer)ver_src_w * -0.232332713 +
    (integer)mth_ver_src_ldate_w0 * -0.371580672 +
    (integer)mth_ver_src_ldate_wp0 * -0.149556634 +
    mth_paw_first_seen2 * -0.002615342 +
    (integer)paw_dead_business_count_gt3 * 1.3423068152 +
    (integer)paw_active_phone_count_0 * 0.3754685927 +
    infutor_im * 0.061827139 +
    src_m_wp_adl_fs * -0.006650973 +
    src_m_hdr_fs * -0.004903484;

source_mod6 := exp(source_mod6_1) / (1 + exp(source_mod6_1));

source_temp := round(500 * source_mod6/0.1) * 0.1;
//iv_sr001_source_profile := if(not(truedid), NULL, max((real)0, round(100 - 500 * source_mod6/0.1)*0.1));
iv_sr001_source_profile := if(not(truedid), NULL, max((real)0, round((100 - source_temp) * 10) / 10));

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

iv_mi001_adlperssn_count := map(
    not((integer)ssnlength > 0)  => NULL,
    adlperssn_count = 0 => 1,
                           adlperssn_count);

_in_dob := common.sas_date((string)(in_dob));

//yr_in_dob := if(in_dob = '', -1, (sysdate - _in_dob) / 365.25);
yr_in_dob := map(
			in_dob = '' 	=> -1, 
		 _in_dob = NULL			=> NULL,
			in_dob = '0' 	=> 0, 
											 (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

age_estimate := map(
    yr_in_dob_int > 0 => yr_in_dob_int,
    inferred_age > 0  => inferred_age,
                         -1);

iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

iv_pv001_bst_avm_autoval := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

iv_pv001_avg_prop_prch_amt := map(
    not(truedid or add1_pop)          => NULL,
    property_owned_purchase_count > 0 => property_owned_purchase_total / property_owned_purchase_count,
                                         -1);

iv_pv001_bst_avm_chg_1yr_pct_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL);

iv_pv001_bst_avm_chg_1yr_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL);

bst_addr_avm_auto_val_1_4 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

bst_addr_avm_auto_val_2 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation_2,
                        add2_avm_automated_valuation_2);

iv_pv001_bst_avm_chg_1yr := if(bst_addr_avm_auto_val_1_4 > 0 and bst_addr_avm_auto_val_2 > 0, bst_addr_avm_auto_val_1_4 - bst_addr_avm_auto_val_2, NULL);

iv_pv001_bst_avm_chg_1yr_pct := if(bst_addr_avm_auto_val_1_4 > 0 and bst_addr_avm_auto_val_2 > 0, round(100 * bst_addr_avm_auto_val_1_4 / bst_addr_avm_auto_val_2/0.1)*0.1, NULL);

inp_addr_date_first_seen := common.sas_date((string)(add1_date_first_seen));

iv_pl001_m_snc_in_addr_fs := map(
    not(add1_pop)                   => NULL,
    inp_addr_date_first_seen = NULL => -1,
                                       if ((sysdate - inp_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - inp_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - inp_addr_date_first_seen) / (365.25 / 12))));

prop_adl_p_fseen_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_fseen_p := if(prop_adl_p_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, prop_adl_p_fseen_pos, ','));

_prop_adl_fseen_p := common.sas_date((string)(prop_adl_fseen_p));

_src_prop_adl_fseen := _prop_adl_fseen_p;

iv_pl001_m_snc_prop_adl_fs := map(
    not(truedid)               => NULL,
    _src_prop_adl_fseen = NULL => -1,
                                  if ((sysdate - _src_prop_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_fseen) / (365.25 / 12))));

iv_pl001_bst_addr_lres := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_lres,
                        add2_lres);

iv_pl002_avg_mo_per_addr := map(
    not(truedid)            => NULL,
    avg_mo_per_addr = -9999 => -1,
    unique_addr_count = 0   => -1,
                               avg_mo_per_addr);

iv_pl002_addrs_per_ssn_c6 := if(not((integer)ssnlength > 0), NULL, addrs_per_ssn_c6);

iv_po001_prop_own_tot := if(not(truedid or add1_pop), NULL, property_owned_total);

iv_po001_inp_addr_naprop := if(not(add1_pop), NULL, add1_naprop);

vehicles_adl_ar_fseen_pos := Models.Common.findw_cpp(ver_sources, 'AR' , ', ', 'E');

vehicles_adl_fseen_ar := if(vehicles_adl_ar_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, vehicles_adl_ar_fseen_pos, ','));

_vehicles_adl_fseen_ar := common.sas_date((string)(vehicles_adl_fseen_ar));

vehicles_adl_eb_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EB' , ', ', 'E');

vehicles_adl_fseen_eb := if(vehicles_adl_eb_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, vehicles_adl_eb_fseen_pos, ','));

_vehicles_adl_fseen_eb := common.sas_date((string)(vehicles_adl_fseen_eb));

vehicles_adl_v_fseen_pos := Models.Common.findw_cpp(ver_sources, 'V' , ', ', 'E');

vehicles_adl_fseen_v := if(vehicles_adl_v_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, vehicles_adl_v_fseen_pos, ','));

_vehicles_adl_fseen_v := common.sas_date((string)(vehicles_adl_fseen_v));

vehicles_adl_w_fseen_pos := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E');

vehicles_adl_fseen_w := if(vehicles_adl_w_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, vehicles_adl_w_fseen_pos, ','));

_vehicles_adl_fseen_w := common.sas_date((string)(vehicles_adl_fseen_w));

_src_vehicles_adl_fseen := min(if(_vehicles_adl_fseen_ar = NULL, -NULL, _vehicles_adl_fseen_ar), if(_vehicles_adl_fseen_eb = NULL, -NULL, _vehicles_adl_fseen_eb), if(_vehicles_adl_fseen_v = NULL, -NULL, _vehicles_adl_fseen_v), if(_vehicles_adl_fseen_w = NULL, -NULL, _vehicles_adl_fseen_w), 999999);

iv_po001_m_snc_veh_adl_fs := map(
    not(truedid)                     => NULL,
    _src_vehicles_adl_fseen = 999999 => -1,
                                        if ((sysdate - _src_vehicles_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_vehicles_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_vehicles_adl_fseen) / (365.25 / 12))));

iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

iv_in001_wealth_index := if(not(truedid), ' ', wealth_index);

iv_ed001_college_ind_35 := map(
    not(truedid) or (iv_ag001_age in [-1, NULL, 0]) or iv_ag001_age > 35   => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') 
		  or ((integer)ams_college_tier >= 0 AND ams_college_tier <> '') 
			or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                    => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                 => '1',
                                                                              '0');

iv_ed001_college_ind_36 := map(
    not(truedid) or (iv_ag001_age in [-1, NULL, 0]) or iv_ag001_age > 36   => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') 
		  or ((integer)ams_college_tier >= 0 and ams_college_tier <> '')
			or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                    => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                 => '1',
                                                                              '0');

iv_ed001_college_ind_37 := map(
    not(truedid) or (iv_ag001_age in [-1, NULL, 0]) or iv_ag001_age > 37   => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') 
		  or ((integer)ams_college_tier >= 0 and ams_college_tier <> '')
			or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                    => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                 => '1',
                                                                              '0');

iv_ed001_college_ind_50 := map(
    not(truedid) or (iv_ag001_age in [-1, NULL, 0]) or iv_ag001_age > 50   => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') 
		  or ((integer)ams_college_tier >= 0 and ams_college_tier <> '')
//		  or (ams_college_tier <> '')
			or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                    => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                 => '1',
                                                                              '0');

iv_ed001_college_ind_60 := map(
    not(truedid) or (iv_ag001_age in [-1, NULL, 0]) or iv_ag001_age > 60   => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') 
		  or ((integer)ams_college_tier >= 0 and ams_college_tier <> '')
			or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                    => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                 => '1',
                                                                              '0');

iv_iq001_inq_count12 := if(not(truedid), NULL, inq_count12);

iv_nap_type := if(not(hphnpop or addrpop), ' ', nap_type);

bureau_adl_tn_lseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E');

bureau_adl_lseen_tn := if(bureau_adl_tn_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_tn_lseen_pos, ','));

_bureau_adl_lseen_tn := common.sas_date((string)(bureau_adl_lseen_tn));

bureau_adl_ts_lseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E');

bureau_adl_lseen_ts := if(bureau_adl_ts_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_ts_lseen_pos, ','));

_bureau_adl_lseen_ts := common.sas_date((string)(bureau_adl_lseen_ts));

bureau_adl_tu_lseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E');

bureau_adl_lseen_tu := if(bureau_adl_tu_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_tu_lseen_pos, ','));

_bureau_adl_lseen_tu := common.sas_date((string)(bureau_adl_lseen_tu));

bureau_adl_en_lseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E');

bureau_adl_lseen_en := if(bureau_adl_en_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_en_lseen_pos, ','));

_bureau_adl_lseen_en := common.sas_date((string)(bureau_adl_lseen_en));

bureau_adl_eq_lseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_lseen_eq := if(bureau_adl_eq_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_eq_lseen_pos, ','));

_bureau_adl_lseen_eq := common.sas_date((string)(bureau_adl_lseen_eq));

_src_bureau_adl_lseen := max(_bureau_adl_lseen_tn, _bureau_adl_lseen_ts, _bureau_adl_lseen_tu, _bureau_adl_lseen_en, _bureau_adl_lseen_eq);

iv_mos_src_bureau_adl_lseen := map(
    not(truedid)                 => NULL,
    _src_bureau_adl_lseen = NULL => -1,
                                    if ((sysdate - _src_bureau_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen) / (365.25 / 12))));

bureau_ssn_tn_count_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TN' , ', ', 'E');

bureau_ssn_count_tn := if(bureau_ssn_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_ssn_sources_count, bureau_ssn_tn_count_pos, ','));

bureau_ssn_ts_count_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TS' , ', ', 'E');

bureau_ssn_count_ts := if(bureau_ssn_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_ssn_sources_count, bureau_ssn_ts_count_pos, ','));

bureau_ssn_tu_count_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TU' , ', ', 'E');

bureau_ssn_count_tu := if(bureau_ssn_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_ssn_sources_count, bureau_ssn_tu_count_pos, ','));

bureau_ssn_en_count_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EN' , ', ', 'E');

bureau_ssn_count_en := if(bureau_ssn_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_ssn_sources_count, bureau_ssn_en_count_pos, ','));

bureau_ssn_eq_count_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , ', ', 'E');

bureau_ssn_count_eq := if(bureau_ssn_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_ssn_sources_count, bureau_ssn_eq_count_pos, ','));

_src_bureau_ssn_count := max(if(max(bureau_ssn_count_tn, bureau_ssn_count_ts, bureau_ssn_count_tu, bureau_ssn_count_en, bureau_ssn_count_eq) = NULL, NULL, sum(if(bureau_ssn_count_tn = NULL, 0, bureau_ssn_count_tn), if(bureau_ssn_count_ts = NULL, 0, bureau_ssn_count_ts), if(bureau_ssn_count_tu = NULL, 0, bureau_ssn_count_tu), if(bureau_ssn_count_en = NULL, 0, bureau_ssn_count_en), if(bureau_ssn_count_eq = NULL, 0, bureau_ssn_count_eq))), (real)0);

iv_src_bureau_ssn_count := map(
    not(truedid)                 => NULL,
    _src_bureau_ssn_count = NULL => -1,
                                    _src_bureau_ssn_count);

bureau_ssn_tn_fseen_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TN' , ', ', 'E');

bureau_ssn_fseen_tn := if(bureau_ssn_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_tn_fseen_pos, ','));

_bureau_ssn_fseen_tn := common.sas_date((string)(bureau_ssn_fseen_tn));

bureau_ssn_ts_fseen_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TS' , ', ', 'E');

bureau_ssn_fseen_ts := if(bureau_ssn_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_ts_fseen_pos, ','));

_bureau_ssn_fseen_ts := common.sas_date((string)(bureau_ssn_fseen_ts));

bureau_ssn_tu_fseen_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TU' , ', ', 'E');

bureau_ssn_fseen_tu := if(bureau_ssn_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_tu_fseen_pos, ','));

_bureau_ssn_fseen_tu := common.sas_date((string)(bureau_ssn_fseen_tu));

bureau_ssn_en_fseen_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EN' , ', ', 'E');

bureau_ssn_fseen_en := if(bureau_ssn_en_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_en_fseen_pos, ','));

_bureau_ssn_fseen_en := common.sas_date((string)(bureau_ssn_fseen_en));

bureau_ssn_eq_fseen_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , ', ', 'E');

bureau_ssn_fseen_eq := if(bureau_ssn_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_eq_fseen_pos, ','));

_bureau_ssn_fseen_eq := common.sas_date((string)(bureau_ssn_fseen_eq));

_src_bureau_ssn_fseen := if(max(_bureau_ssn_fseen_tn, _bureau_ssn_fseen_ts, _bureau_ssn_fseen_tu, _bureau_ssn_fseen_en, _bureau_ssn_fseen_eq) = NULL, NULL, min(if(_bureau_ssn_fseen_tn = NULL, -NULL, _bureau_ssn_fseen_tn), if(_bureau_ssn_fseen_ts = NULL, -NULL, _bureau_ssn_fseen_ts), if(_bureau_ssn_fseen_tu = NULL, -NULL, _bureau_ssn_fseen_tu), if(_bureau_ssn_fseen_en = NULL, -NULL, _bureau_ssn_fseen_en), if(_bureau_ssn_fseen_eq = NULL, -NULL, _bureau_ssn_fseen_eq)));

iv_mos_src_bureau_ssn_fseen := map(
    not(truedid)                 => NULL,
    _src_bureau_ssn_fseen = NULL => -1,
                                    if ((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12))));

bureau_addr_tn_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TN' , ', ', 'E');

bureau_addr_count_tn := if(bureau_addr_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tn_count_pos, ','));

bureau_addr_ts_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TS' , ', ', 'E');

bureau_addr_count_ts := if(bureau_addr_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_ts_count_pos, ','));

bureau_addr_tu_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TU' , ', ', 'E');

bureau_addr_count_tu := if(bureau_addr_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tu_count_pos, ','));

bureau_addr_en_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EN' , ', ', 'E');

bureau_addr_count_en := if(bureau_addr_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_en_count_pos, ','));

bureau_addr_eq_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EQ' , ', ', 'E');

bureau_addr_count_eq := if(bureau_addr_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_eq_count_pos, ','));

_src_bureau_addr_count := max(if(max(bureau_addr_count_tn, bureau_addr_count_ts, bureau_addr_count_tu, bureau_addr_count_en, bureau_addr_count_eq) = NULL, NULL, sum(if(bureau_addr_count_tn = NULL, 0, bureau_addr_count_tn), if(bureau_addr_count_ts = NULL, 0, bureau_addr_count_ts), if(bureau_addr_count_tu = NULL, 0, bureau_addr_count_tu), if(bureau_addr_count_en = NULL, 0, bureau_addr_count_en), if(bureau_addr_count_eq = NULL, 0, bureau_addr_count_eq))), (real)0);

iv_src_bureau_addr_count := map(
    not(truedid)                  => NULL,
    _src_bureau_addr_count = NULL => -1,
                                     _src_bureau_addr_count);

bureau_addr_tn_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TN' , ', ', 'E');

bureau_addr_fseen_tn := if(bureau_addr_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_tn_fseen_pos, ','));

_bureau_addr_fseen_tn := common.sas_date((string)(bureau_addr_fseen_tn));

bureau_addr_ts_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TS' , ', ', 'E');

bureau_addr_fseen_ts := if(bureau_addr_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_ts_fseen_pos, ','));

_bureau_addr_fseen_ts := common.sas_date((string)(bureau_addr_fseen_ts));

bureau_addr_tu_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TU' , ', ', 'E');

bureau_addr_fseen_tu := if(bureau_addr_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_tu_fseen_pos, ','));

_bureau_addr_fseen_tu := common.sas_date((string)(bureau_addr_fseen_tu));

bureau_addr_en_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EN' , ', ', 'E');

bureau_addr_fseen_en := if(bureau_addr_en_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_en_fseen_pos, ','));

_bureau_addr_fseen_en := common.sas_date((string)(bureau_addr_fseen_en));

bureau_addr_eq_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EQ' , ', ', 'E');

bureau_addr_fseen_eq := if(bureau_addr_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_eq_fseen_pos, ','));

_bureau_addr_fseen_eq := common.sas_date((string)(bureau_addr_fseen_eq));

_src_bureau_addr_fseen := if(max(_bureau_addr_fseen_tn, _bureau_addr_fseen_ts, _bureau_addr_fseen_tu, _bureau_addr_fseen_en, _bureau_addr_fseen_eq) = NULL, NULL, min(if(_bureau_addr_fseen_tn = NULL, -NULL, _bureau_addr_fseen_tn), if(_bureau_addr_fseen_ts = NULL, -NULL, _bureau_addr_fseen_ts), if(_bureau_addr_fseen_tu = NULL, -NULL, _bureau_addr_fseen_tu), if(_bureau_addr_fseen_en = NULL, -NULL, _bureau_addr_fseen_en), if(_bureau_addr_fseen_eq = NULL, -NULL, _bureau_addr_fseen_eq)));

iv_mos_src_bureau_addr_fseen := map(
    not(truedid)                  => NULL,
    _src_bureau_addr_fseen = NULL => -1,
                                     if ((sysdate - _src_bureau_addr_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_addr_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_addr_fseen) / (365.25 / 12))));

bureau_lname_tn_count_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TN' , ', ', 'E');

bureau_lname_count_tn := if(bureau_lname_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Lname_sources_count, bureau_lname_tn_count_pos, ','));

bureau_lname_ts_count_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TS' , ', ', 'E');

bureau_lname_count_ts := if(bureau_lname_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Lname_sources_count, bureau_lname_ts_count_pos, ','));

bureau_lname_tu_count_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TU' , ', ', 'E');

bureau_lname_count_tu := if(bureau_lname_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Lname_sources_count, bureau_lname_tu_count_pos, ','));

bureau_lname_en_count_pos := Models.Common.findw_cpp(ver_Lname_sources, 'EN' , ', ', 'E');

bureau_lname_count_en := if(bureau_lname_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Lname_sources_count, bureau_lname_en_count_pos, ','));

bureau_lname_eq_count_pos := Models.Common.findw_cpp(ver_Lname_sources, 'EQ' , ', ', 'E');

bureau_lname_count_eq := if(bureau_lname_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Lname_sources_count, bureau_lname_eq_count_pos, ','));

_src_bureau_lname_count := max(if(max(bureau_lname_count_tn, bureau_lname_count_ts, bureau_lname_count_tu, bureau_lname_count_en, bureau_lname_count_eq) = NULL, NULL, sum(if(bureau_lname_count_tn = NULL, 0, bureau_lname_count_tn), if(bureau_lname_count_ts = NULL, 0, bureau_lname_count_ts), if(bureau_lname_count_tu = NULL, 0, bureau_lname_count_tu), if(bureau_lname_count_en = NULL, 0, bureau_lname_count_en), if(bureau_lname_count_eq = NULL, 0, bureau_lname_count_eq))), (real)0);

iv_src_bureau_lname_count := map(
    not(truedid)                   => NULL,
    _src_bureau_lname_count = NULL => -1,
                                      _src_bureau_lname_count);

bureau_lname_tn_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TN' , ', ', 'E');

bureau_lname_fseen_tn := if(bureau_lname_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_tn_fseen_pos, ','));

_bureau_lname_fseen_tn := common.sas_date((string)(bureau_lname_fseen_tn));

bureau_lname_ts_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TS' , ', ', 'E');

bureau_lname_fseen_ts := if(bureau_lname_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_ts_fseen_pos, ','));

_bureau_lname_fseen_ts := common.sas_date((string)(bureau_lname_fseen_ts));

bureau_lname_tu_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TU' , ', ', 'E');

bureau_lname_fseen_tu := if(bureau_lname_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_tu_fseen_pos, ','));

_bureau_lname_fseen_tu := common.sas_date((string)(bureau_lname_fseen_tu));

bureau_lname_en_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'EN' , ', ', 'E');

bureau_lname_fseen_en := if(bureau_lname_en_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_en_fseen_pos, ','));

_bureau_lname_fseen_en := common.sas_date((string)(bureau_lname_fseen_en));

bureau_lname_eq_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'EQ' , ', ', 'E');

bureau_lname_fseen_eq := if(bureau_lname_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_eq_fseen_pos, ','));

_bureau_lname_fseen_eq := common.sas_date((string)(bureau_lname_fseen_eq));

_src_bureau_lname_fseen := if(max(_bureau_lname_fseen_tn, _bureau_lname_fseen_ts, _bureau_lname_fseen_tu, _bureau_lname_fseen_en, _bureau_lname_fseen_eq) = NULL, NULL, min(if(_bureau_lname_fseen_tn = NULL, -NULL, _bureau_lname_fseen_tn), if(_bureau_lname_fseen_ts = NULL, -NULL, _bureau_lname_fseen_ts), if(_bureau_lname_fseen_tu = NULL, -NULL, _bureau_lname_fseen_tu), if(_bureau_lname_fseen_en = NULL, -NULL, _bureau_lname_fseen_en), if(_bureau_lname_fseen_eq = NULL, -NULL, _bureau_lname_fseen_eq)));

iv_mos_src_bureau_lname_fseen := map(
    not(truedid)                   => NULL,
    _src_bureau_lname_fseen = NULL => -1,
                                      if ((sysdate - _src_bureau_lname_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_lname_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_lname_fseen) / (365.25 / 12))));

bureau_dob_tn_count_pos := Models.Common.findw_cpp(ver_DOB_sources, 'TN' , ', ', 'E');

bureau_dob_count_tn := if(bureau_dob_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_DOB_sources_count, bureau_dob_tn_count_pos, ','));

bureau_dob_ts_count_pos := Models.Common.findw_cpp(ver_DOB_sources, 'TS' , ', ', 'E');

bureau_dob_count_ts := if(bureau_dob_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_DOB_sources_count, bureau_dob_ts_count_pos, ','));

bureau_dob_tu_count_pos := Models.Common.findw_cpp(ver_DOB_sources, 'TU' , ', ', 'E');

bureau_dob_count_tu := if(bureau_dob_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_DOB_sources_count, bureau_dob_tu_count_pos, ','));

bureau_dob_en_count_pos := Models.Common.findw_cpp(ver_DOB_sources, 'EN' , ', ', 'E');

bureau_dob_count_en := if(bureau_dob_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_DOB_sources_count, bureau_dob_en_count_pos, ','));

bureau_dob_eq_count_pos := Models.Common.findw_cpp(ver_DOB_sources, 'EQ' , ', ', 'E');

bureau_dob_count_eq := if(bureau_dob_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_DOB_sources_count, bureau_dob_eq_count_pos, ','));

_src_bureau_dob_count := max(if(max(bureau_dob_count_tn, bureau_dob_count_ts, bureau_dob_count_tu, bureau_dob_count_en, bureau_dob_count_eq) = NULL, NULL, sum(if(bureau_dob_count_tn = NULL, 0, bureau_dob_count_tn), if(bureau_dob_count_ts = NULL, 0, bureau_dob_count_ts), if(bureau_dob_count_tu = NULL, 0, bureau_dob_count_tu), if(bureau_dob_count_en = NULL, 0, bureau_dob_count_en), if(bureau_dob_count_eq = NULL, 0, bureau_dob_count_eq))), (real)0);

iv_src_bureau_dob_count := map(
    not(truedid)                 => NULL,
    _src_bureau_dob_count = NULL => -1,
                                    _src_bureau_dob_count);

bureau_dob_tn_fseen_pos := Models.Common.findw_cpp(ver_DOB_sources, 'TN' , ', ', 'E');

bureau_dob_fseen_tn := if(bureau_dob_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_DOB_sources_first_seen, bureau_dob_tn_fseen_pos, ','));

_bureau_dob_fseen_tn := common.sas_date((string)(bureau_dob_fseen_tn));

bureau_dob_ts_fseen_pos := Models.Common.findw_cpp(ver_DOB_sources, 'TS' , ', ', 'E');

bureau_dob_fseen_ts := if(bureau_dob_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_DOB_sources_first_seen, bureau_dob_ts_fseen_pos, ','));

_bureau_dob_fseen_ts := common.sas_date((string)(bureau_dob_fseen_ts));

bureau_dob_tu_fseen_pos := Models.Common.findw_cpp(ver_DOB_sources, 'TU' , ', ', 'E');

bureau_dob_fseen_tu := if(bureau_dob_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_DOB_sources_first_seen, bureau_dob_tu_fseen_pos, ','));

_bureau_dob_fseen_tu := common.sas_date((string)(bureau_dob_fseen_tu));

bureau_dob_en_fseen_pos := Models.Common.findw_cpp(ver_DOB_sources, 'EN' , ', ', 'E');

bureau_dob_fseen_en := if(bureau_dob_en_fseen_pos = 0, '       0', Models.Common.getw(ver_DOB_sources_first_seen, bureau_dob_en_fseen_pos, ','));

_bureau_dob_fseen_en := common.sas_date((string)(bureau_dob_fseen_en));

bureau_dob_eq_fseen_pos := Models.Common.findw_cpp(ver_DOB_sources, 'EQ' , ', ', 'E');

bureau_dob_fseen_eq := if(bureau_dob_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_DOB_sources_first_seen, bureau_dob_eq_fseen_pos, ','));

_bureau_dob_fseen_eq := common.sas_date((string)(bureau_dob_fseen_eq));

_src_bureau_dob_fseen := if(max(_bureau_dob_fseen_tn, _bureau_dob_fseen_ts, _bureau_dob_fseen_tu, _bureau_dob_fseen_en, _bureau_dob_fseen_eq) = NULL, NULL, min(if(_bureau_dob_fseen_tn = NULL, -NULL, _bureau_dob_fseen_tn), if(_bureau_dob_fseen_ts = NULL, -NULL, _bureau_dob_fseen_ts), if(_bureau_dob_fseen_tu = NULL, -NULL, _bureau_dob_fseen_tu), if(_bureau_dob_fseen_en = NULL, -NULL, _bureau_dob_fseen_en), if(_bureau_dob_fseen_eq = NULL, -NULL, _bureau_dob_fseen_eq)));

iv_mos_src_bureau_dob_fseen := map(
    not(truedid)                 => NULL,
    _src_bureau_dob_fseen = NULL => -1,
                                    if ((sysdate - _src_bureau_dob_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_dob_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_dob_fseen) / (365.25 / 12))));

lien_adl_li_count_pos := Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E');

lien_adl_count_li := if(lien_adl_li_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lien_adl_li_count_pos, ','));

lien_adl_l2_count_pos := Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E');

lien_adl_count_l2 := if(lien_adl_l2_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lien_adl_l2_count_pos, ','));

_src_lien_adl_count := max(lien_adl_count_li, lien_adl_count_l2, (real)0);

bk_adl_bk_count_pos := Models.Common.findw_cpp(ver_sources, 'BA' , ', ', 'E');

bk_adl_count_bk := if(bk_adl_bk_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, bk_adl_bk_count_pos, ','));

_src_bk_adl_count := max(bk_adl_count_bk, (real)0);

iv_src_bankruptcy_adl_count := map(
    not(truedid)               => NULL,
    _src_lien_adl_count = NULL => -1,
                                  _src_bk_adl_count);

bk_adl_ba_lseen_pos := Models.Common.findw_cpp(ver_sources, 'BA' , ', ', 'E');

bk_adl_lseen_ba := if(bk_adl_ba_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bk_adl_ba_lseen_pos, ','));

_bk_adl_lseen_ba := common.sas_date((string)(bk_adl_lseen_ba));

_src_bk_adl_lseen := _bk_adl_lseen_ba;

iv_mos_src_bankruptcy_adl_lseen := map(
    not(truedid)             => NULL,
    _src_bk_adl_lseen = NULL => -1,
                                if ((sysdate - _src_bk_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bk_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_bk_adl_lseen) / (365.25 / 12))));

prop_adl_p_count_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_count_p := if(prop_adl_p_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, prop_adl_p_count_pos, ','));

_src_prop_adl_count := max(prop_adl_count_p, (real)0);

iv_src_property_adl_count := map(
    not(truedid)               => NULL,
    _src_prop_adl_count = NULL => -1,
                                  _src_prop_adl_count);

prop_adl_p_lseen_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_lseen_p := if(prop_adl_p_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, prop_adl_p_lseen_pos, ','));

_prop_adl_lseen_p := common.sas_date((string)(prop_adl_lseen_p));

_src_prop_adl_lseen := _prop_adl_lseen_p;

iv_mos_src_property_adl_lseen := map(
    not(truedid)               => NULL,
    _src_prop_adl_lseen = NULL => -1,
                                  if ((sysdate - _src_prop_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_lseen) / (365.25 / 12))));

voter_adl_v_count_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

iv_src_voter_adl_count := map(
    not(truedid)              => NULL,
    not(voter_avail)          => -1,
    voter_adl_v_count_pos = 0 => 0,
                                 (integer)Models.Common.getw(ver_sources_count, voter_adl_v_count_pos, ','));

vote_adl_vo_lseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

vote_adl_lseen_vo := if(vote_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, vote_adl_vo_lseen_pos, ','));

_vote_adl_lseen_vo := common.sas_date((string)(vote_adl_lseen_vo));

_src_vote_adl_lseen := _vote_adl_lseen_vo;

iv_mos_src_voter_adl_lseen := map(
    not(truedid)               => NULL,
    not(voter_avail)           => -1,
    _src_vote_adl_lseen = NULL => -1,
                                  if ((sysdate - _src_vote_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_vote_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_vote_adl_lseen) / (365.25 / 12))));

emerge_adl_em_count_pos := Models.Common.findw_cpp(ver_sources, 'EM' , ', ', 'E');

emerge_adl_count_em := if(emerge_adl_em_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_em_count_pos, ','));

emerge_adl_e1_count_pos := Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E');

emerge_adl_count_e1 := if(emerge_adl_e1_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e1_count_pos, ','));

emerge_adl_e2_count_pos := Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E');

emerge_adl_count_e2 := if(emerge_adl_e2_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e2_count_pos, ','));

emerge_adl_e3_count_pos := Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E');

emerge_adl_count_e3 := if(emerge_adl_e3_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e3_count_pos, ','));

emerge_adl_e4_count_pos := Models.Common.findw_cpp(ver_sources, 'E4' , ', ', 'E');

emerge_adl_count_e4 := if(emerge_adl_e4_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e4_count_pos, ','));

iv_src_emerge_adl_count := if(not(truedid), NULL, max(if(max(emerge_adl_count_em, emerge_adl_count_e1, emerge_adl_count_e2, emerge_adl_count_e3, emerge_adl_count_e4) = NULL, NULL, sum(if(emerge_adl_count_em = NULL, 0, emerge_adl_count_em), if(emerge_adl_count_e1 = NULL, 0, emerge_adl_count_e1), if(emerge_adl_count_e2 = NULL, 0, emerge_adl_count_e2), if(emerge_adl_count_e3 = NULL, 0, emerge_adl_count_e3), if(emerge_adl_count_e4 = NULL, 0, emerge_adl_count_e4))), (real)0));

_lname_change_date := common.sas_date((string)(lname_change_date));

iv_mos_since_lname_change := map(
    not((integer)ssnlength > 0)        => NULL,
    _lname_change_date = NULL => -1,
                                 if ((sysdate - _lname_change_date) / (365.25 / 12) >= 0, truncate((sysdate - _lname_change_date) / (365.25 / 12)), roundup((sysdate - _lname_change_date) / (365.25 / 12))));

iv_fname_eda_sourced_type := map(
    not((hphnpop or addrpop) and fnamepop) => '  ',
    fname_eda_sourced_type = ''          => '-1',
                                              fname_eda_sourced_type);

iv_lname_eda_sourced_type := map(
    not((hphnpop or addrpop) and lnamepop) => '  ',
    lname_eda_sourced_type = ''          => '-1',
                                              lname_eda_sourced_type);

iv_fname_non_phn_src_ct := if(not(truedid and fnamepop), NULL, rc_fnamecount);

iv_full_name_non_phn_src_ct := if(not(truedid and fnamepop and lnamepop), NULL, source_count);

iv_full_name_ver_sources := map(
    not((hphnpop or addrpop) and lnamepop and fnamepop)                                            => '             ',
    source_count > 0 and not(fname_eda_sourced_type = '') and not(lname_eda_sourced_type = '') => 'Phn & NonPhn ',
    source_count > 0                                                                               => 'NonPhn Only  ',
    not(fname_eda_sourced_type = '') and not(lname_eda_sourced_type = '')                      => 'Phn Only     ',
                                                                                                      'Name not Verd');

iv_addr_non_phn_src_ct := if(not(truedid) and add1_pop, NULL, rc_addrcount);

iv_addr_phn_src_ct := if(not(add1_pop and hphnpop), NULL, max(rc_phoneaddrcount, rc_phoneaddr_addrcount));

iv_dob_src_ct := if(not(truedid and dobpop), NULL, combo_dobcount);

_reported_dob := common.sas_date((string)(reported_dob));

reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

iv_combined_age := map(
    not(truedid or dobpop) => NULL,
    age > 0                => age,
    (integer)input_dob_age > 0      => (integer)input_dob_age,
    inferred_age > 0       => inferred_age,
    reported_age > 0       => reported_age,
    (integer)ams_age > 0            => (integer)ams_age,
                              -1);

_rc_ssnlowissue := common.sas_date((string)(rc_ssnlowissue));

//iv_age_at_low_issue := if(not(truedid and (integer)ssnlength > 0 and age > 0), 
//                          NULL, 
//													if ((age - ((sysdate - _rc_ssnlowissue) / (365.25))) >= 0, 
//													    truncate(age - ((sysdate - _rc_ssnlowissue) / 365.25)), 
//															roundup(age - ((sysdate - _rc_ssnlowissue) / 365.25))
//														 )
//												 );
												 
iv_age_at_low_issue := MAP(
		not(truedid and (integer)ssnlength > 0 and age >0)  										=> NULL,
		_rc_ssnlowissue	= NULL															=> NULL,
		age - ((sysdate - _rc_ssnlowissue) / 365.25) 	>= 0 		=> truncate(age - (sysdate - _rc_ssnlowissue) / 365.25),
																													 roundup(age - (sysdate - _rc_ssnlowissue) / 365.25)
													);

_rc_ssnhighissue := common.sas_date((string)(rc_ssnhighissue));

//iv_age_at_high_issue := if(not(truedid and (integer)ssnlength > 0 and age > 0), 
//                           NULL, 
//													 if ((age - ((sysdate - _rc_ssnhighissue) / (365.25))) >= 0, 
//													     truncate(age - ((sysdate - _rc_ssnhighissue) / 365.25)), 
//															 roundup(age - ((sysdate - _rc_ssnhighissue) / 365.25))
//															)
//													);

iv_age_at_high_issue := MAP(
		not(truedid and (integer)ssnlength > 0 and age >0) 											=> NULL, 
		_rc_ssnhighissue	= NULL														=> NULL,
		age - ((sysdate - _rc_ssnhighissue) / 365.25) >= 0		=> truncate(age - (sysdate - _rc_ssnhighissue) / 365.25),
																													 roundup(age - (sysdate - _rc_ssnhighissue) / 365.25)
													 );

iv_inp_addr_lres := if(not(add1_pop), NULL, add1_lres);

iv_inp_addr_source_count := if(not(add1_pop), NULL, add1_source_count);

iv_inp_addr_ownership_lvl := map(
    not(add1_pop)        => '            ',
    add1_applicant_owned => 'Applicant   ',
    add1_family_owned    => 'Family      ',
    add1_occupant_owned  => 'Occupant    ',
                            'No Ownership');

iv_inp_own_prop_x_addr_naprop := map(
    not(add1_pop)            => '  ',
    property_owned_total > 0 => (string)(add1_naprop + 10),
                                if(length((string)add1_naprop) < 2, '0' + (string)add1_naprop, (string)add1_naprop));

iv_inp_addr_mortgage_amount := if(not(add1_pop), NULL, add1_mortgage_amount);

_add1_mortgage_date := common.sas_date((string)(add1_mortgage_date));

_add1_mortgage_due_date := common.sas_date((string)(add1_mortgage_due_date));

mortgage_date_diff := if(not(_add1_mortgage_date = NULL) and not(_add1_mortgage_due_date = NULL), round((_add1_mortgage_due_date - _add1_mortgage_date) / 365.25), NULL);

iv_inp_addr_mortgage_term := map(
    not(add1_pop)            => '  ',
    mortgage_date_diff >= 40 => '40',
    mortgage_date_diff >= 30 => '30',
    mortgage_date_diff >= 25 => '25',
    mortgage_date_diff >= 20 => '20',
    mortgage_date_diff >= 15 => '15',
    mortgage_date_diff >= 10 => '10',
    mortgage_date_diff >= 5  => '5',
    mortgage_date_diff >= 0  => '0',
                                '-1');

iv_inp_addr_financing_type := map(
    not(add1_pop)              => '     ',
    add1_financing_type = '' => 'NONE ',
                                  add1_financing_type);

iv_inp_addr_assessed_total_val := if(not(add1_pop), NULL, add1_assessed_total_value);

inp_addr_fips_fall := map(
    add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
    add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
    add1_avm_med_fips > 0  => add1_avm_med_fips,
                              0);

inp_addr_avm_auto_val := add1_avm_automated_valuation;

iv_inp_addr_fips_ratio := map(
    not(add1_pop)          => NULL,
    inp_addr_fips_fall > 0 => inp_addr_avm_auto_val / inp_addr_fips_fall,
                              -1);

iv_inp_addr_building_area := if(not(add1_pop), NULL, add1_building_area);

iv_inp_addr_avm_change_1yr := map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_2 > 0 => add1_avm_automated_valuation - add1_avm_automated_valuation_2,
                                                                               NULL);

iv_inp_addr_avm_pct_change_1yr := map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_2 > 0 => add1_avm_automated_valuation / add1_avm_automated_valuation_2,
                                                                               NULL);

iv_inp_addr_avm_change_2yr := map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_3 > 0 => add1_avm_automated_valuation - add1_avm_automated_valuation_3,
                                                                               NULL);

iv_inp_addr_avm_pct_change_2yr := map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_3 > 0 => add1_avm_automated_valuation / add1_avm_automated_valuation_3,
                                                                               NULL);

iv_inp_addr_avm_change_3yr := map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_4 > 0 => add1_avm_automated_valuation - add1_avm_automated_valuation_4,
                                                                               NULL);

iv_inp_addr_avm_pct_change_3yr := map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_4 > 0 => add1_avm_automated_valuation / add1_avm_automated_valuation_4,
                                                                               NULL);

iv_bst_addr_source_count := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_source_count,
                        add2_source_count);

iv_bst_addr_ownership_lvl_c182 := map(
    add1_applicant_owned => 'Applicant   ',
    add1_family_owned    => 'Family      ',
    add1_occupant_owned  => 'Occupant    ',
                            'No Ownership');

iv_bst_addr_ownership_lvl_c183 := map(
    add2_applicant_owned => 'Applicant   ',
    add2_family_owned    => 'Family      ',
    add2_occupant_owned  => 'Occupant    ',
                            'No Ownership');

iv_bst_addr_ownership_lvl := map(
    not(truedid)     => ' ',
    add1_isbestmatch => iv_bst_addr_ownership_lvl_c182,
                        iv_bst_addr_ownership_lvl_c183);

iv_bst_addr_naprop := map(
    not(truedid)     => ' ',
    add1_isbestmatch => (string)add1_naprop,
                        (string)add2_naprop);

iv_bst_own_prop_x_addr_naprop_c186 := if(property_owned_total > 0, (string)(add1_naprop + 10), if(length((string)add1_naprop) < 2, '0' + (string)add1_naprop, (string)add1_naprop));

iv_bst_own_prop_x_addr_naprop_c187 := if(property_owned_total > 0, (string)(add2_naprop + 10), if(length((string)add2_naprop) < 2, '0' + (string)add2_naprop, (string)add2_naprop));

iv_bst_own_prop_x_addr_naprop := map(
    not(truedid)     => '  ',
    add1_isbestmatch => iv_bst_own_prop_x_addr_naprop_c186,
                        iv_bst_own_prop_x_addr_naprop_c187);

iv_bst_addr_mortgage_amount := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_mortgage_amount,
                        add2_mortgage_amount);

bst_addr_avm_auto_val_2_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

bst_addr_mortgage_amount_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_mortgage_amount,
                        add2_mortgage_amount);

iv_bst_addr_mtg_avm_abs_diff := if(bst_addr_mortgage_amount_1 <= 0 or bst_addr_avm_auto_val_2_1 <= 0, NULL, bst_addr_avm_auto_val_2_1 - bst_addr_mortgage_amount_1);

bst_addr_avm_auto_val_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

bst_addr_mortgage_amount := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_mortgage_amount,
                        add2_mortgage_amount);

iv_bst_addr_mtg_avm_pct_diff := if(bst_addr_mortgage_amount <= 0 or bst_addr_avm_auto_val_1 <= 0, NULL, bst_addr_avm_auto_val_1 / bst_addr_mortgage_amount);

iv_bst_addr_assessed_total_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_assessed_total_value,
                        add2_assessed_total_value);

bst_addr_date_first_seen := if(add1_isbestmatch, common.sas_date((string)(add1_date_first_seen)), common.sas_date((string)(add2_date_first_seen)));

iv_mos_since_bst_addr_fseen := map(
    not(truedid)                    => NULL,
    bst_addr_date_first_seen = NULL => -1,
                                       if ((sysdate - bst_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - bst_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - bst_addr_date_first_seen) / (365.25 / 12))));

bst_addr_fips_fall_c199 := map(
    add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
    add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
    add1_avm_med_fips > 0  => add1_avm_med_fips,
                              0);

bst_addr_fips_fall_c200 := map(
    add2_avm_med_geo12 > 0 => add2_avm_med_geo12,
    add2_avm_med_geo11 > 0 => add2_avm_med_geo11,
    add2_avm_med_fips > 0  => add2_avm_med_fips,
                              0);

bst_addr_fips_fall := if(add1_isbestmatch, bst_addr_fips_fall_c199, bst_addr_fips_fall_c200);

bst_addr_avm_auto_val := if(add1_isbestmatch, add1_avm_automated_valuation, add2_avm_automated_valuation);

iv_bst_addr_fips_ratio := map(
    not(truedid)           => NULL,
    bst_addr_fips_fall > 0 => bst_addr_avm_auto_val / bst_addr_fips_fall,
                              -1);

iv_bst_addr_building_area := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_building_area,
                        add2_building_area);

iv_bst_addr_avm_change_2yr_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL);

bst_addr_avm_auto_val_3_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation_3,
                        add2_avm_automated_valuation_3);

bst_addr_avm_auto_val_1_3 := map(
    not(truedid)     => bst_addr_avm_auto_val_1_4,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

iv_bst_addr_avm_change_2yr := if(bst_addr_avm_auto_val_1_3 > 0 and bst_addr_avm_auto_val_3_1 > 0, bst_addr_avm_auto_val_1_3 - bst_addr_avm_auto_val_3_1, NULL);

bst_addr_avm_auto_val_3 := map(
    not(truedid)     => bst_addr_avm_auto_val_3_1,
    add1_isbestmatch => add1_avm_automated_valuation_3,
                        add2_avm_automated_valuation_3);

iv_bst_addr_avm_pct_change_2yr_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL);

bst_addr_avm_auto_val_1_2 := map(
    not(truedid)     => bst_addr_avm_auto_val_1_3,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

iv_bst_addr_avm_pct_change_2yr := if(bst_addr_avm_auto_val_1_2 > 0 and bst_addr_avm_auto_val_3 > 0, bst_addr_avm_auto_val_1_2 / bst_addr_avm_auto_val_3, NULL);

bst_addr_avm_auto_val_1_1 := map(
    not(truedid)     => bst_addr_avm_auto_val_1_2,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

iv_bst_addr_avm_change_3yr_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL);

bst_addr_avm_auto_val_4_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation_4,
                        add2_avm_automated_valuation_4);

iv_bst_addr_avm_change_3yr := if(bst_addr_avm_auto_val_1_1 > 0 and bst_addr_avm_auto_val_4_1 > 0, bst_addr_avm_auto_val_1_1 - bst_addr_avm_auto_val_4_1, NULL);

bst_addr_avm_auto_val_1_5 := map(
    not(truedid)     => bst_addr_avm_auto_val_1_1,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

bst_addr_avm_auto_val_4 := map(
    not(truedid)     => bst_addr_avm_auto_val_4_1,
    add1_isbestmatch => add1_avm_automated_valuation_4,
                        add2_avm_automated_valuation_4);

iv_bst_addr_avm_pct_change_3yr_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL);

iv_bst_addr_avm_pct_change_3yr := if(bst_addr_avm_auto_val_1_5 > 0 and bst_addr_avm_auto_val_4 > 0, bst_addr_avm_auto_val_1_5 / bst_addr_avm_auto_val_4, NULL);

iv_bst_addr_financing_type_c212 := if(add1_financing_type = '', 'NONE ', add1_financing_type);

iv_bst_addr_financing_type_c213 := if(add2_financing_type = '', 'NONE ', add2_financing_type);

iv_bst_addr_financing_type := map(
    not(truedid)     => '     ',
    add1_isbestmatch => iv_bst_addr_financing_type_c212,
                        iv_bst_addr_financing_type_c213);

iv_prv_addr_lres := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_lres,
                        add3_lres);

iv_prv_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_avm_automated_valuation,
                        add3_avm_automated_valuation);

iv_prv_addr_source_count := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_source_count,
                        add3_source_count);

iv_prv_addr_eda_sourced := map(
    not(truedid)     => ' ',
    add1_isbestmatch => (string)(integer)add2_eda_sourced,
                        (string)(integer)add3_eda_sourced);

iv_prv_addr_naprop := map(
    not(truedid)     => ' ',
    add1_isbestmatch => (string)add2_naprop,
                        (string)add3_naprop);

iv_prv_own_prop_x_addr_naprop := map(
    not(truedid)                                  => '  ',
    add1_isbestmatch and property_owned_total > 0 => (string)(add2_naprop + 10),
    add1_isbestmatch                              => if(length((string)add2_naprop) < 2, '0' + (string)add2_naprop, (string)add2_naprop),
    property_owned_total > 0                      => (string)(add3_naprop + 10),
                                                     if(length((string)add3_naprop) < 2, '0' + (string)add3_naprop, (string)add3_naprop));

iv_prv_addr_mortgage_present := map(
    not(truedid)                                                 => '',
    add1_isbestmatch and not(((string)add2_mortgage_date in ['0', ' '])) => '1',
    not(((string)add3_mortgage_date in ['0', ' ']))                      => '0',
                                                                    '0');

iv_prv_addr_mortgage_amount := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_mortgage_amount,
                        add3_mortgage_amount);

iv_prv_addr_assessed_total_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_assessed_total_value,
                        add3_assessed_total_value);

prv_addr_date_first_seen := if(add1_isbestmatch, common.sas_date((string)(add2_date_first_seen)), common.sas_date((string)(add3_date_first_seen)));

iv_mos_since_prv_addr_fseen := map(
    not(truedid)                    => NULL,
    prv_addr_date_first_seen = NULL => -1,
                                       if ((sysdate - prv_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - prv_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - prv_addr_date_first_seen) / (365.25 / 12))));

prv_addr_date_last_seen := if(add1_isbestmatch, common.sas_date((string)(add2_date_last_seen)), common.sas_date((string)(add3_date_last_seen)));

iv_mos_since_prv_addr_lseen := map(
    not(truedid)                   => NULL,
    prv_addr_date_last_seen = NULL => -1,
                                      if ((sysdate - prv_addr_date_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - prv_addr_date_last_seen) / (365.25 / 12)), roundup((sysdate - prv_addr_date_last_seen) / (365.25 / 12))));

iv_prop_owned_purchase_total := if(not(truedid or add1_pop), NULL, property_owned_purchase_total);

iv_prop_owned_assessed_total := if(not(truedid or add1_pop), NULL, property_owned_assessed_total);

iv_prop_owned_assessed_count := if(not(truedid or add1_pop), NULL, property_owned_assessed_count);

iv_avg_prop_assess_purch_amt := map(
    not(truedid or add1_pop)          => NULL,
    property_owned_assessed_count > 0 => property_owned_assessed_total / property_owned_assessed_count,
                                         -1);

iv_prop_sold_purchase_total := if(not(truedid or add1_pop), NULL, property_sold_purchase_total);

iv_avg_prop_sold_purch_amt := map(
    not(truedid or add1_pop)         => NULL,
    property_sold_purchase_count > 0 => property_sold_purchase_total / property_sold_purchase_count,
                                        -1);

iv_prop_sold_assessed_total := if(not(truedid or add1_pop), NULL, property_sold_assessed_total);

iv_avg_prop_sold_assess_amt := map(
    not(truedid or add1_pop)         => NULL,
    property_sold_assessed_count > 0 => property_sold_assessed_total / property_sold_assessed_count,
                                        -1);

iv_purch_sold_ct_diff := if(not(truedid or add1_pop), NULL, property_owned_purchase_count - property_sold_purchase_count);

iv_purch_sold_val_diff := map(
    not(truedid or add1_pop)          => NULL,
    property_owned_purchase_total = 0 => NULL,
    property_sold_purchase_total = 0  => NULL,
                                         property_owned_purchase_total - property_sold_purchase_total);

iv_purch_sold_assess_val_diff := map(
    not(truedid or add1_pop)          => NULL,
    property_owned_assessed_total = 0 => NULL,
    property_sold_assessed_total = 0  => NULL,
                                         property_owned_assessed_total - property_sold_assessed_total);

iv_prop1_sale_price := if(not(truedid), NULL, prop1_sale_price);

_prop1_sale_date := common.sas_date((string)(prop1_sale_date));

iv_mos_since_prop1_sale := map(
    not(truedid)                 => NULL,
    not(_prop1_sale_date = NULL) => if ((sysdate - _prop1_sale_date) / (365.25 / 12) >= 0, truncate((sysdate - _prop1_sale_date) / (365.25 / 12)), roundup((sysdate - _prop1_sale_date) / (365.25 / 12))),
                                    -1);

iv_prop1_purch_sale_diff := map(
    not(truedid)                                           => NULL,
    prop1_prev_purchase_price > 0 and prop1_sale_price > 0 => prop1_sale_price - prop1_prev_purchase_price,
                                                              NULL);

iv_prop2_sale_price := if(not(truedid), NULL, prop2_sale_price);

_prop2_sale_date := common.sas_date((string)(prop2_sale_date));

iv_mos_since_prop2_sale := map(
    not(truedid)                 => NULL,
    not(_prop2_sale_date = NULL) => if ((sysdate - _prop2_sale_date) / (365.25 / 12) >= 0, truncate((sysdate - _prop2_sale_date) / (365.25 / 12)), roundup((sysdate - _prop2_sale_date) / (365.25 / 12))),
                                    -1);

iv_prop2_purch_sale_diff := map(
    not(truedid)                                           => NULL,
    prop2_prev_purchase_price > 0 and prop2_sale_price > 0 => prop2_sale_price - prop2_prev_purchase_price,
                                                              NULL);

iv_dist_bst_addr_to_prv_addr := map(
    not(truedid)     => NULL,
    add1_isbestmatch => dist_a1toa2,
                        dist_a2toa3);

iv_dist_inp_addr_to_prv_addr := map(
    not(truedid)     => NULL,
    add1_isbestmatch => dist_a1toa2,
                        dist_a1toa3);

iv_avg_lres := if(not(truedid), NULL, avg_lres);

iv_max_lres := if(not(truedid), NULL, max_lres);

iv_addrs_10yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_10yr);

iv_unique_addr_count := if(not(truedid), NULL, unique_addr_count);

iv_addr_lres_6mo_count := map(
    not(truedid)                => NULL,
    addr_lres_6mo_count = -9999 => -1,
                                   addr_lres_6mo_count);

iv_addr_lres_12mo_count := map(
    not(truedid)                 => NULL,
    addr_lres_12mo_count = -9999 => -1,
                                    addr_lres_12mo_count);

iv_hist_addr_match := map(
    not(truedid)            => NULL,
    hist_addr_match = -9999 => -1,
                               hist_addr_match);

iv_avg_num_sources_per_addr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             if (if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10))) >= 0, truncate(if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10)))), roundup(if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10))))));

_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

iv_mos_since_gong_did_fst_seen := map(
    not(truedid)                     => NULL,
    not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
                                        -1);

_gong_did_last_seen := common.sas_date((string)(gong_did_last_seen));

iv_mos_since_gong_did_lst_seen_1 := if(not(truedid), NULL, NULL);

iv_mos_since_gong_did_lst_seen := if(not(_gong_did_last_seen = NULL), if ((sysdate - _gong_did_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_last_seen) / (365.25 / 12))), -1);

iv_gong_did_phone_ct := if(not(truedid), NULL, gong_did_phone_ct);

iv_addrs_per_adl := if(not(truedid), NULL, addrs_per_adl);

iv_lnames_per_adl := if(not(truedid), NULL, lnames_per_adl);

iv_adls_per_addr := if(not(add1_pop), NULL, adls_per_addr);

iv_adls_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        adls_per_addr);

iv_ssns_per_addr := if(not(add1_pop), NULL, ssns_per_addr);

iv_ssns_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        ssns_per_addr);

iv_phones_per_apt_addr := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '0' => -1,
                        phones_per_addr);

iv_phones_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        phones_per_addr);

iv_max_ids_per_addr := if(not(add1_pop), NULL, max(adls_per_addr, ssns_per_addr));

iv_max_ids_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        max(adls_per_addr, ssns_per_addr));

iv_adls_per_phone := if(not(hphnpop), NULL, adls_per_phone);

iv_ssns_per_adl_c6 := if(not(truedid), NULL, ssns_per_adl_c6);

iv_adls_per_addr_c6 := if(not(add1_pop), NULL, adls_per_addr_c6);

iv_adls_per_sfd_addr_c6 := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        adls_per_addr_c6);

iv_ssns_per_sfd_addr_c6 := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        ssns_per_addr_c6);

iv_max_ids_per_sfd_addr_c6 := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        max(adls_per_addr_c6, ssns_per_addr_c6));

iv_phones_per_addr_c6 := if(not(add1_pop), NULL, phones_per_addr_c6);

iv_adls_per_phone_c6 := if(not(hphnpop), NULL, adls_per_phone_c6);

iv_vo_addrs_per_adl := map(
    not(truedid)     => NULL,
    not(voter_avail) => -1,
                        vo_addrs_per_adl);

iv_pl_addrs_per_adl := if(not(truedid), NULL, pl_addrs_per_adl);

iv_inq_auto_count12 := if(not(truedid), NULL, inq_auto_count12);

iv_inq_auto_recency := map(
    not(truedid)     => NULL,
    inq_auto_count01 >0 => 1,
    inq_auto_count03 >0 => 3,
    inq_auto_count06 >0 => 6,
    inq_auto_count12 >0 => 12,
    inq_auto_count24 >0 => 24,
    inq_auto_count  >0  => 99,
                        0);

iv_inq_ssns_per_adl := if(not(truedid), NULL, inq_ssnsperadl);

iv_inq_addrs_per_adl := if(not(truedid), NULL, inq_addrsperadl);

iv_inq_num_diff_names_per_adl := if(not(truedid), NULL, max(inq_fnamesperadl, inq_lnamesperadl));

iv_inq_phones_per_adl := if(not(truedid), NULL, inq_phonesperadl);

iv_inq_dobs_per_adl := if(not(truedid), NULL, inq_dobsperadl);

iv_inq_per_ssn := if(not((integer)ssnlength > 0), NULL, inq_perssn);

iv_inq_addrs_per_ssn := if(not((integer)ssnlength > 0), NULL, inq_addrsperssn);

iv_inq_per_addr := if(not(add1_pop), NULL, inq_peraddr);

iv_inq_lnames_per_addr := if(not(add1_pop), NULL, inq_lnamesperaddr);

iv_inq_ssns_per_addr := if(not(add1_pop), NULL, inq_ssnsperaddr);

iv_inq_per_phone := if(not(hphnpop), NULL, inq_perphone);

_paw_first_seen := common.sas_date((string)(paw_first_seen));

iv_mos_since_paw_first_seen := map(
    not(truedid)                => NULL,
    not(_paw_first_seen = NULL) => if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12))),
                                   -1);

iv_paw_dead_business_count := if(not(truedid), NULL, paw_dead_business_count);

iv_paw_active_phone_count := if(not(truedid), NULL, paw_active_phone_count);

_infutor_first_seen := common.sas_date((string)(infutor_first_seen));

iv_mos_since_infutor_first_seen := map(
    not(hphnpop)                    => NULL,
    not(_infutor_first_seen = NULL) => if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))),
                                       -1);

_infutor_last_seen := common.sas_date((string)(infutor_last_seen));

iv_mos_since_infutor_last_seen := map(
    not(hphnpop)                   => NULL,
    not(_infutor_last_seen = NULL) => if ((sysdate - _infutor_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen) / (365.25 / 12))),
                                      -1);

iv_infutor_nap := if(not(hphnpop), ' ', trim((string)infutor_nap, LEFT));

iv_attr_addrs_recency := map(
    not(truedid)      => NULL,
    attr_addrs_last30 >0 => 1,
    attr_addrs_last90 >0 => 3,
    attr_addrs_last12 >0 => 12,
    attr_addrs_last24 >0 => 24,
    attr_addrs_last36 >0 => 36,
    addrs_5yr >0         => 60,
    addrs_10yr >0        => 120,
    addrs_15yr  >0       => 180,
    addrs_per_adl > 0 => 999,
                         0);

iv_attr_purchase_recency := map(
    not(truedid)                 => NULL,
    attr_num_purchase30 >0          => 1,
    attr_num_purchase90 >0          => 3,
    attr_num_purchase180 >0         => 6,
    attr_num_purchase12 >0          => 12,
    attr_num_purchase24 >0          => 24,
    attr_num_purchase36 >0          => 36,
    attr_num_purchase60 >0          => 60,
    attr_date_first_purchase > 0 => 99,
                                    0);

iv_attr_rel_liens_recency := map(
    not(truedid)                        => NULL,
    attr_num_rel_liens30 >0                => 1,
    attr_num_rel_liens90 >0                => 3,
    attr_num_rel_liens180 >0               => 6,
    attr_num_rel_liens12 >0                => 12,
    attr_num_rel_liens24 >0                => 24,
    attr_num_rel_liens36 >0                => 36,
    attr_num_rel_liens60 >0                => 60,
    liens_historical_released_count > 0 => 99,
                                           0);

iv_attr_bankruptcy_recency := map(
    not(truedid)                      => NULL,
    attr_bankruptcy_count30 >0           => 1,
    attr_bankruptcy_count90 >0           => 3,
    attr_bankruptcy_count180 >0          => 6,
    attr_bankruptcy_count12 >0           => 12,
    attr_bankruptcy_count24 >0           => 24,
    attr_bankruptcy_count36 >0           => 36,
    attr_bankruptcy_count60 >0           => 60,
    (rc_bansflag in ['1', '2'])       => 99,
    bankrupt                          => 99,
    contains_i(ver_sources, 'BA') > 0 => 99,
    filing_count > 0                  => 99,
    bk_recent_count > 0               => 99,
                                         0);

iv_attr_proflic_exp_recency := map(
    not(truedid)            => NULL,
    attr_num_proflic_exp30 >0  => 1,
    attr_num_proflic_exp90 >0  => 3,
    attr_num_proflic_exp180 >0 => 6,
    attr_num_proflic_exp12 >0  => 12,
    attr_num_proflic_exp24 >0  => 24,
    attr_num_proflic_exp36 >0  => 36,
    attr_num_proflic_exp60 >0  => 60,
                               0);

iv_non_derog_count := if(not(truedid), NULL, attr_num_nonderogs);

iv_unreleased_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))));

iv_liens_unrel_cj_ct := if(not(truedid), NULL, liens_unrel_CJ_ct);

iv_liens_unrel_ft_ct := if(not(truedid), NULL, liens_unrel_FT_ct);

iv_liens_rel_ft_ct := if(not(truedid), NULL, liens_rel_FT_ct);

iv_liens_unrel_lt_ct := if(not(truedid), NULL, liens_unrel_LT_ct);

iv_liens_rel_ot_ct := if(not(truedid), NULL, liens_rel_OT_ct);

ams_major_medical := ( contains_i(StringLib.StringToUpperCase(ams_college_major), 'A') > 0 
                    or contains_i(StringLib.StringToUpperCase(ams_college_major), 'E') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'L') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'Q') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'T') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'V') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '040') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '041') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '044') > 0
										 );

ams_major_science := ( contains_i(StringLib.StringToUpperCase(ams_college_major), 'D') > 0 
                    or contains_i(StringLib.StringToUpperCase(ams_college_major), 'H') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'M') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'N') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '046') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '006') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '022') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '026') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '029') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '031') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '036') > 0
										 );

ams_major_liberal := ( contains_i(StringLib.StringToUpperCase(ams_college_major), 'C') > 0 
                    or contains_i(StringLib.StringToUpperCase(ams_college_major), 'F') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'I') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'J') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'K') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'O') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'W') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), 'Y') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '007') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '013') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '015') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '027') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '032') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '033') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '035') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '037') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '038') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '039') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '042') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '043') > 0 
										or contains_i(StringLib.StringToUpperCase(ams_college_major), '003') > 0
										 );

ams_major_business := ( contains_i(StringLib.StringToUpperCase(ams_college_major), 'B') > 0 
                     or contains_i(StringLib.StringToUpperCase(ams_college_major), 'G') > 0 
										 or contains_i(StringLib.StringToUpperCase(ams_college_major), 'P') > 0 
										 or contains_i(StringLib.StringToUpperCase(ams_college_major), 'R') > 0 
										 or contains_i(StringLib.StringToUpperCase(ams_college_major), 'S') > 0 
										 or contains_i(StringLib.StringToUpperCase(ams_college_major), 'Z') > 0 
										 or contains_i(StringLib.StringToUpperCase(ams_college_major), '009') > 0 
										 or contains_i(StringLib.StringToUpperCase(ams_college_major), '045') > 0
										  );

ams_major_unknown := ( contains_i(StringLib.StringToUpperCase(ams_college_major), 'U') > 0);

iv_ams_college_major := map(
    not(truedid)                             => '                ',
    ams_major_medical                        => 'Medical         ',
    ams_major_science                        => 'Science         ',
    ams_major_liberal                        => 'Liberal Arts    ',
    ams_major_business                       => 'Business        ',
    ams_major_unknown                        => 'Unclassified    ',
    not(ams_college_code = '')             => 'Unclassified    ',
    not((ams_date_first_seen in ['0', ' '])) => 'No College Found',
                                                'No AMS Found');

iv_ams_college_code := map(
    not(truedid)            => '  ',
    ams_college_code = '' => '-1',
                               trim(ams_college_code, LEFT));

iv_ams_college_type := map(
    not(truedid)            => '  ',
    ams_college_type = '' => '-1',
                               ams_college_type);

iv_ams_college_tier := map(
    not(truedid)            => '  ',
    ams_college_tier = '' => '-1',
                               ams_college_tier);

iv_ams_file_type := map(
    not(truedid)         => '  ',
    ams_file_type = 'M'  => '  ',
    ams_file_type = '' => '-1',
                            ams_file_type);

iv_prof_license_category := map(
    not(truedid)                 => '  ',
    prof_license_category = '' => '-1',
                                    prof_license_category);

final_score_0 := -1.9774121924;

final_score_1_c316 := map(
    iv_bst_addr_naprop <> ' '
		  AND NULL < (real)iv_bst_addr_naprop AND (real)iv_bst_addr_naprop <= 2.5 => -0.0396625293,
    (real)iv_bst_addr_naprop > 2.5                                => 0.0294499383,
    iv_bst_addr_naprop = ' '                               => -0.0318151800,
                                                               -0.0228830019);

final_score_1_c317 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl <= 0.5 => 0.2051153900,
    iv_inq_addrs_per_adl > 0.5                                  => 0.0514225646,
    iv_inq_addrs_per_adl = NULL                                 => 0.1096395439,
                                                                   0.1096395439);

final_score_1 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 90055 => final_score_1_c316,
    iv_prop_owned_assessed_total > 90055                                          => final_score_1_c317,
    iv_prop_owned_assessed_total = NULL                                           => -0.0566150017,
                                                                                     -0.0010867726);

final_score_2_c320 := map(
    NULL < iv_inq_ssns_per_adl AND iv_inq_ssns_per_adl <= 0.5 => 0.2159624485,
    iv_inq_ssns_per_adl > 0.5                                 => 0.0756127826,
    iv_inq_ssns_per_adl = NULL                                => 0.1380459080,
                                                                 0.1380459080);

final_score_2_c319 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 0.5 => final_score_2_c320,
    iv_dg001_derog_count > 0.5                                  => 0.0138403686,
    iv_dg001_derog_count = NULL                                 => 0.0889787035,
                                                                   0.0889787035);

final_score_2 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 93810 => -0.0192407138,
    iv_prop_owned_assessed_total > 93810                                          => final_score_2_c319,
    iv_prop_owned_assessed_total = NULL                                           => -0.0463765416,
                                                                                     -0.0022955498);

final_score_3_c323 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 0.5 => 0.1647315380,
    iv_dg001_derog_count > 0.5                                  => 0.0360611130,
    iv_dg001_derog_count = NULL                                 => 0.1216709013,
                                                                   0.1216709013);

final_score_3_c322 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl <= 0.5 => final_score_3_c323,
    iv_inq_addrs_per_adl > 0.5                                  => 0.0359392049,
    iv_inq_addrs_per_adl = NULL                                 => 0.0672465972,
                                                                   0.0672465972);

final_score_3 := map(
    iv_bst_addr_naprop <> ' '
		  AND NULL < (real)iv_bst_addr_naprop AND (real)iv_bst_addr_naprop <= 3.5 => -0.0237447888,
    (real)iv_bst_addr_naprop > 3.5                                => final_score_3_c322,
    iv_bst_addr_naprop = ' '                               => -0.0268099937,
                                                               -0.0025721241);

final_score_4_c326 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 0.5 => 0.1196045137,
    iv_dg001_derog_count > 0.5                                  => 0.0213633641,
    iv_dg001_derog_count = NULL                                 => 0.0835623585,
                                                                   0.0835623585);

final_score_4_c325 := map(
    NULL < iv_inq_num_diff_names_per_adl AND iv_inq_num_diff_names_per_adl <= 0.5 => final_score_4_c326,
    iv_inq_num_diff_names_per_adl > 0.5                                           => 0.0114806465,
    iv_inq_num_diff_names_per_adl = NULL                                          => 0.0605612682,
                                                                                     0.0367499320);

final_score_4 := map(
    iv_inp_own_prop_x_addr_naprop <> '  '
		  and NULL < (real)iv_inp_own_prop_x_addr_naprop AND (real)iv_inp_own_prop_x_addr_naprop <= 1.5 => -0.0372056621,
    (real)iv_inp_own_prop_x_addr_naprop > 1.5                                           => final_score_4_c325,
    iv_inp_own_prop_x_addr_naprop = '  '                                          => -0.0352853813,
                                                                                     -0.0033890540);

final_score_5_c328 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 1.5 => -0.0349215329,
    iv_src_property_adl_count > 1.5                                       => 0.0190034530,
    iv_src_property_adl_count = NULL                                      => -0.0143493788,
                                                                             -0.0173305199);

final_score_5_c329 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct <= 0.5 => 0.0943751144,
    iv_unreleased_liens_ct > 0.5                                    => -0.0050494872,
    iv_unreleased_liens_ct = NULL                                   => 0.0657469169,
                                                                       0.0657469169);

final_score_5 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 83314 => final_score_5_c328,
    iv_avg_prop_assess_purch_amt > 83314                                          => final_score_5_c329,
    iv_avg_prop_assess_purch_amt = NULL                                           => -0.0505672359,
                                                                                     -0.0041082238);

final_score_6_c332 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl <= 0.5 => 0.1054726324,
    iv_inq_addrs_per_adl > 0.5                                  => 0.0400056563,
    iv_inq_addrs_per_adl = NULL                                 => 0.0653577130,
                                                                   0.0653577130);

final_score_6_c331 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct <= 0.5 => final_score_6_c332,
    iv_unreleased_liens_ct > 0.5                                    => -0.0180221462,
    iv_unreleased_liens_ct = NULL                                   => 0.0584703088,
                                                                       0.0406664701);

final_score_6 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 47760 => -0.0198883548,
    iv_avg_prop_assess_purch_amt > 47760                                          => final_score_6_c331,
    iv_avg_prop_assess_purch_amt = NULL                                           => -0.0499577303,
                                                                                     -0.0049214733);

final_score_7_c334 := map(
    NULL < iv_inq_num_diff_names_per_adl AND iv_inq_num_diff_names_per_adl <= 0.5 => 0.0223830663,
    iv_inq_num_diff_names_per_adl > 0.5                                           => -0.0343863216,
    iv_inq_num_diff_names_per_adl = NULL                                          => -0.0186967449,
                                                                                     -0.0186967449);

final_score_7_c335 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 1.5 => 0.0695552352,
    iv_inq_per_addr > 1.5                             => -0.0099454939,
    iv_inq_per_addr = NULL                            => 0.0459294721,
                                                         0.0459294721);

final_score_7 := map(
    iv_bst_addr_naprop <> ' '
		  AND NULL < (real)iv_bst_addr_naprop AND (real)iv_bst_addr_naprop <= 3.5 => final_score_7_c334,
    (real)iv_bst_addr_naprop > 3.5                                => final_score_7_c335,
    iv_bst_addr_naprop = ' '                               => -0.0224215426,
                                                               -0.0037401863);

final_score_8_c337 := map(
    NULL < iv_inq_num_diff_names_per_adl AND iv_inq_num_diff_names_per_adl <= 0.5 => 0.0213445888,
    iv_inq_num_diff_names_per_adl > 0.5                                           => -0.0271157588,
    iv_inq_num_diff_names_per_adl = NULL                                          => -0.0172243879,
                                                                                     -0.0133315054);

final_score_8_c338 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 0.5 => 0.0843864382,
    iv_dg001_derog_count > 0.5                                  => 0.0190855405,
    iv_dg001_derog_count = NULL                                 => 0.0591200356,
                                                                   0.0591200356);

final_score_8 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 134235 => final_score_8_c337,
    iv_prop_owned_assessed_total > 134235                                          => final_score_8_c338,
    iv_prop_owned_assessed_total = NULL                                            => -0.0337517382,
                                                                                      -0.0063095878);

final_score_9_c340 := map(
    iv_ed001_college_ind_50 <> ' ' 
		  AND NULL < (real)iv_ed001_college_ind_50 AND (real)iv_ed001_college_ind_50 <= 0.5 => -0.0330800047,
    (real)iv_ed001_college_ind_50 > 0.5                                     => 0.0392102652,
    iv_ed001_college_ind_50 = ' '                                    => -0.0131635250,
                                                                         -0.0179954053);

final_score_9_c341 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 172350 => 0.0338674521,
    iv_prop_owned_assessed_total > 172350                                          => 0.1024467916,
    iv_prop_owned_assessed_total = NULL                                            => 0.0435183583,
                                                                                      0.0435183583);

final_score_9 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 81.75 => final_score_9_c340,
    iv_sr001_source_profile > 81.75                                     => final_score_9_c341,
    iv_sr001_source_profile = NULL                                      => -0.0122118046,
                                                                           -0.0039684744);

final_score_10_c344 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl <= 0.5 => 0.0727248180,
    iv_inq_addrs_per_adl > 0.5                                  => 0.0212158363,
    iv_inq_addrs_per_adl = NULL                                 => 0.0399566275,
                                                                   0.0399566275);

final_score_10_c343 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct <= 0.5 => final_score_10_c344,
    iv_unreleased_liens_ct > 0.5                                    => -0.0240077688,
    iv_unreleased_liens_ct = NULL                                   => 0.0182766427,
                                                                       0.0182766427);

final_score_10 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 3.5 => -0.0327155803,
    iv_pl001_m_snc_prop_adl_fs > 3.5                                        => final_score_10_c343,
    iv_pl001_m_snc_prop_adl_fs = NULL                                       => -0.0127415965,
                                                                               -0.0068651593);

final_score_11_c346 := map(
    (iv_ams_college_major in ['No AMS Found', 'No College Found', 'Science'])         => -0.0253305445,
    (iv_ams_college_major in ['Business', 'Liberal Arts', 'Medical', 'Unclassified']) => 0.0373245321,
    iv_ams_college_major = ''                                                       => -0.0173305282,
                                                                                         -0.0173305282);

final_score_11_c347 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct <= 0.5 => 0.0561893402,
    iv_unreleased_liens_ct > 0.5                                    => -0.0090068881,
    iv_unreleased_liens_ct = NULL                                   => 0.0333853261,
                                                                       0.0333853261);

final_score_11 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 80.95 => final_score_11_c346,
    iv_sr001_source_profile > 80.95                                     => final_score_11_c347,
    iv_sr001_source_profile = NULL                                      => -0.0167315267,
                                                                           -0.0041821497);

final_score_12_c350 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 1.391686501 => 0.0344106454,
    iv_bst_addr_avm_pct_change_3yr > 1.391686501                                            => -0.0345060751,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                   => 0.0013917596,
                                                                                               0.0136947893);

final_score_12_c349 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 3.5 => final_score_12_c350,
    iv_src_property_adl_count > 3.5                                       => 0.0679809560,
    iv_src_property_adl_count = NULL                                      => 0.0254061813,
                                                                             0.0254061813);

final_score_12 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val <= 25898.5 => -0.0192811043,
    iv_bst_addr_assessed_total_val > 25898.5                                            => final_score_12_c349,
    iv_bst_addr_assessed_total_val = NULL                                               => -0.0133570958,
                                                                                           -0.0033147978);

final_score_13_c353 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 0.5 => 0.0465973337,
    iv_dg001_derog_count > 0.5                                  => 0.0018841938,
    iv_dg001_derog_count = NULL                                 => 0.0294472346,
                                                                   0.0294472346);

final_score_13_c352 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 <= 1.5 => final_score_13_c353,
    iv_iq001_inq_count12 > 1.5                                  => -0.0279437895,
    iv_iq001_inq_count12 = NULL                                 => 0.0693265744,
                                                                   0.0175357873);

final_score_13 := map(
    iv_inp_own_prop_x_addr_naprop <> '  '
		  and NULL < (real)iv_inp_own_prop_x_addr_naprop AND (real)iv_inp_own_prop_x_addr_naprop <= 1.5 => -0.0250078930,
    (real)iv_inp_own_prop_x_addr_naprop > 1.5                                           => final_score_13_c352,
    iv_inp_own_prop_x_addr_naprop = '  '                                          => -0.0304597417,
                                                                                     -0.0055040478);

final_score_14_c356 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income <= 64500 => 0.0322584210,
    iv_in001_estimated_income > 64500                                       => 0.0903082015,
    iv_in001_estimated_income = NULL                                        => 0.0375331420,
                                                                               0.0375331420);

final_score_14_c355 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 1.5 => final_score_14_c356,
    iv_inq_per_addr > 1.5                             => -0.0141316015,
    iv_inq_per_addr = NULL                            => 0.0219333655,
                                                         0.0219333655);

final_score_14 := map(
    iv_bst_addr_naprop <> ' '
		  AND NULL < (real)iv_bst_addr_naprop AND (real)iv_bst_addr_naprop <= 2.5 => -0.0177075375,
    (real)iv_bst_addr_naprop > 2.5                                => final_score_14_c355,
    iv_bst_addr_naprop = ' '                               => -0.0085940556,
                                                               -0.0049472819);

final_score_15_c359 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 0.5 => 0.0496388736,
    iv_inq_per_addr > 0.5                             => 0.0055136730,
    iv_inq_per_addr = NULL                            => 0.0292929680,
                                                         0.0292929680);

final_score_15_c358 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct <= 0.5 => final_score_15_c359,
    iv_unreleased_liens_ct > 0.5                                    => -0.0173810512,
    iv_unreleased_liens_ct = NULL                                   => 0.0134811899,
                                                                       0.0134811899);

final_score_15 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 4.5 => -0.0259344827,
    iv_pl001_m_snc_prop_adl_fs > 4.5                                        => final_score_15_c358,
    iv_pl001_m_snc_prop_adl_fs = NULL                                       => -0.0020590374,
                                                                               -0.0058739352);

final_score_16_c362 := map(
    iv_ed001_college_ind_60 <> ' '
		  and NULL < (real)iv_ed001_college_ind_60 AND (real)iv_ed001_college_ind_60 <= 0.5 => -0.0092261150,
    (real)iv_ed001_college_ind_60 > 0.5                                     => 0.0546051269,
    iv_ed001_college_ind_60 = ' '                                    => 0.0065064513,
                                                                         0.0015200141);

final_score_16_c361 := map(
    NULL < iv_dl001_lien_last_seen AND iv_dl001_lien_last_seen <= 0.5 => final_score_16_c362,
    iv_dl001_lien_last_seen > 0.5                                     => -0.0397038932,
    iv_dl001_lien_last_seen = NULL                                    => -0.0105973882,
                                                                         -0.0105973882);

final_score_16 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 85.55 => final_score_16_c361,
    iv_sr001_source_profile > 85.55                                     => 0.0477672868,
    iv_sr001_source_profile = NULL                                      => -0.0064765271,
                                                                           -0.0050536126);

final_score_17_c364 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 <= 0.5 => 0.0101849626,
    iv_iq001_inq_count12 > 0.5                                  => -0.0270706131,
    iv_iq001_inq_count12 = NULL                                 => -0.0098966680,
                                                                   -0.0098966680);

final_score_17_c365 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 1.5 => 0.0498955308,
    iv_inq_per_addr > 1.5                             => -0.0093290714,
    iv_inq_per_addr = NULL                            => 0.0327443812,
                                                         0.0327443812);

final_score_17 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 82.95 => final_score_17_c364,
    iv_sr001_source_profile > 82.95                                     => final_score_17_c365,
    iv_sr001_source_profile = NULL                                      => -0.0022990957,
                                                                           -0.0024581601);

final_score_18_c368 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val <= 36265 => 0.0277011989,
    iv_bst_addr_assessed_total_val > 36265                                            => 0.0752553222,
    iv_bst_addr_assessed_total_val = NULL                                             => 0.0439679683,
                                                                                         0.0439679683);

final_score_18_c367 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 61.5 => final_score_18_c368,
    iv_mos_src_property_adl_lseen > 61.5                                           => -0.0001914849,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0219948904,
                                                                                      0.0219948904);

final_score_18 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 172.5 => -0.0131409884,
    iv_pl001_m_snc_prop_adl_fs > 172.5                                        => final_score_18_c367,
    iv_pl001_m_snc_prop_adl_fs = NULL                                         => -0.0054205875,
                                                                                 -0.0034020160);

final_score_19_c371 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 <= 0.5 => 0.0490934031,
    iv_iq001_inq_count12 > 0.5                                  => 0.0122908601,
    iv_iq001_inq_count12 = NULL                                 => 0.0310253285,
                                                                   0.0310253285);

final_score_19_c370 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr <= 15.5 => final_score_19_c371,
    iv_adls_per_addr > 15.5                              => -0.0117637823,
    iv_adls_per_addr = NULL                              => 0.0148399514,
                                                            0.0148399514);

final_score_19 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val <= 22658 => -0.0164249383,
    iv_bst_addr_assessed_total_val > 22658                                            => final_score_19_c370,
    iv_bst_addr_assessed_total_val = NULL                                             => -0.0066023425,
                                                                                         -0.0037114368);

final_score_20_c374 := map(
    iv_ed001_college_ind_37 <> ' '
		  AND NULL < (real)iv_ed001_college_ind_37 AND (real)iv_ed001_college_ind_37 <= 0.5 => -0.0071503008,
    (real)iv_ed001_college_ind_37 > 0.5                                     => 0.0689991434,
    iv_ed001_college_ind_37 = ' '                                    => 0.0039901895,
                                                                         0.0052794720);

final_score_20_c373 := map(
    NULL < iv_dl001_lien_last_seen AND iv_dl001_lien_last_seen <= 0.5 => final_score_20_c374,
    iv_dl001_lien_last_seen > 0.5                                     => -0.0316549033,
    iv_dl001_lien_last_seen = NULL                                    => -0.0024333610,
                                                                         -0.0056485786);

final_score_20 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 133105 => final_score_20_c373,
    iv_avg_prop_assess_purch_amt > 133105                                          => 0.0365908732,
    iv_avg_prop_assess_purch_amt = NULL                                            => -0.0276195033,
                                                                                      -0.0027373870);

final_score_21_c377 := map(
    iv_ed001_college_ind_50 <> ' ' 
		  AND NULL < (real)iv_ed001_college_ind_50 AND (real)iv_ed001_college_ind_50 <= 0.5 => -0.0125761077,
    (real)iv_ed001_college_ind_50 > 0.5                                     => 0.0361335842,
    iv_ed001_college_ind_50 = ' '                                    => 0.0070019991,
                                                                         -0.0000279866);

final_score_21_c376 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct <= 0.5 => final_score_21_c377,
    iv_unreleased_liens_ct > 0.5                                    => -0.0347789441,
    iv_unreleased_liens_ct = NULL                                   => -0.0114969027,
                                                                       -0.0114969027);

final_score_21 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 3.5 => final_score_21_c376,
    iv_src_property_adl_count > 3.5                                       => 0.0273805755,
    iv_src_property_adl_count = NULL                                      => 0.0002002235,
                                                                             -0.0055236051);

final_score_22_c380 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 0.5 => 0.0549541965,
    iv_inq_per_addr > 0.5                             => -0.0068006429,
    iv_inq_per_addr = NULL                            => 0.0414140198,
                                                         0.0414140198);

final_score_22_c379 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 2.5 => 0.0101627184,
    iv_src_property_adl_count > 2.5                                       => final_score_22_c380,
    iv_src_property_adl_count = NULL                                      => 0.0189060369,
                                                                             0.0189060369);

final_score_22 := map(
    NULL < iv_inq_num_diff_names_per_adl AND iv_inq_num_diff_names_per_adl <= 0.5 => final_score_22_c379,
    iv_inq_num_diff_names_per_adl > 0.5                                           => -0.0119071124,
    iv_inq_num_diff_names_per_adl = NULL                                          => -0.0046624260,
                                                                                     -0.0028130692);

final_score_23_c383 := map(
    NULL < iv_bst_addr_fips_ratio AND iv_bst_addr_fips_ratio <= 0.90749479885 => 0.0150279443,
    iv_bst_addr_fips_ratio > 0.90749479885                                    => 0.0565076114,
    iv_bst_addr_fips_ratio = NULL                                             => 0.0285800728,
                                                                                 0.0285800728);

final_score_23_c382 := map(
    NULL < iv_inq_num_diff_names_per_adl AND iv_inq_num_diff_names_per_adl <= 0.5 => final_score_23_c383,
    iv_inq_num_diff_names_per_adl > 0.5                                           => -0.0005630314,
    iv_inq_num_diff_names_per_adl = NULL                                          => 0.0295672728,
                                                                                     0.0092846295);

final_score_23 := map(
    NULL < iv_max_ids_per_addr AND iv_max_ids_per_addr <= 15.5 => final_score_23_c382,
    iv_max_ids_per_addr > 15.5                                 => -0.0198947485,
    iv_max_ids_per_addr = NULL                                 => -0.0182825182,
                                                                  -0.0025529978);

final_score_24_c386 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct <= 0.5 => 0.0107451899,
    iv_unreleased_liens_ct > 0.5                                    => -0.0204824561,
    iv_unreleased_liens_ct = NULL                                   => 0.0010941515,
                                                                       0.0010941515);

final_score_24_c385 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 2219.5 => final_score_24_c386,
    iv_inp_addr_building_area > 2219.5                                       => 0.0463633397,
    iv_inp_addr_building_area = NULL                                         => 0.0049941757,
                                                                                0.0049941757);

final_score_24 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl <= 1.5 => final_score_24_c385,
    iv_inq_addrs_per_adl > 1.5                                  => -0.0394448359,
    iv_inq_addrs_per_adl = NULL                                 => -0.0148631396,
                                                                   -0.0040365985);

final_score_25_c388 := map(
    iv_ed001_college_ind_37 <> ' '
		  AND NULL < (real)iv_ed001_college_ind_37 AND (real)iv_ed001_college_ind_37 <= 0.5 => -0.0134829870,
    (real)iv_ed001_college_ind_37 > 0.5                                     => 0.0361230663,
    iv_ed001_college_ind_37 = ' '                                    => -0.0143395953,
                                                                         -0.0098621604);

final_score_25_c389 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 <= 1.5 => 0.0309864768,
    iv_iq001_inq_count12 > 1.5                                  => -0.0219294797,
    iv_iq001_inq_count12 = NULL                                 => 0.0185744772,
                                                                   0.0185744772);

final_score_25 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 81.05 => final_score_25_c388,
    iv_sr001_source_profile > 81.05                                     => final_score_25_c389,
    iv_sr001_source_profile = NULL                                      => -0.0017081286,
                                                                           -0.0025152682);

final_score_26_c392 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 4.5 => 0.0107636273,
    iv_src_property_adl_count > 4.5                                       => 0.0421713587,
    iv_src_property_adl_count = NULL                                      => 0.0142166425,
                                                                             0.0142166425);

final_score_26_c391 := map(
    NULL < iv_hist_addr_match AND iv_hist_addr_match <= 0.5 => -0.0165879732,
    iv_hist_addr_match > 0.5                                => final_score_26_c392,
    iv_hist_addr_match = NULL                               => 0.0051441181,
                                                               0.0051441181);

final_score_26 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 <= 1.5 => final_score_26_c391,
    iv_iq001_inq_count12 > 1.5                                  => -0.0299336693,
    iv_iq001_inq_count12 = NULL                                 => -0.0082144766,
                                                                   -0.0039860742);

final_score_27_c395 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 1.5 => 0.0332033928,
    iv_dg001_derog_count > 1.5                                  => -0.0106660550,
    iv_dg001_derog_count = NULL                                 => 0.0243409157,
                                                                   0.0243409157);

final_score_27_c394 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val <= 22506 => -0.0053812724,
    iv_bst_addr_assessed_total_val > 22506                                            => final_score_27_c395,
    iv_bst_addr_assessed_total_val = NULL                                             => 0.0399588258,
                                                                                         0.0077381611);

final_score_27 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr <= 15.5 => final_score_27_c394,
    iv_adls_per_addr > 15.5                              => -0.0186389678,
    iv_adls_per_addr = NULL                              => -0.0194067936,
                                                            -0.0029899169);

final_score_28_c397 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 2543.5 => -0.0130753268,
    iv_bst_addr_building_area > 2543.5                                       => 0.0445673482,
    iv_bst_addr_building_area = NULL                                         => -0.0103173300,
                                                                                -0.0103173300);

final_score_28_c398 := map(
    NULL < iv_dl001_lien_last_seen AND iv_dl001_lien_last_seen <= -0.5 => 0.0449299869,
    iv_dl001_lien_last_seen > -0.5                                     => -0.0178022831,
    iv_dl001_lien_last_seen = NULL                                     => 0.0237088806,
                                                                          0.0237088806);

final_score_28 := map(
    iv_ed001_college_ind_60 <> ' ' 
		  AND NULL < (real)iv_ed001_college_ind_60 AND (real)iv_ed001_college_ind_60 <= 0.5 => final_score_28_c397,
    (real)iv_ed001_college_ind_60 > 0.5                                     => final_score_28_c398,
    iv_ed001_college_ind_60 = ' '                                    => 0.0088049254,
                                                                         -0.0023450833);

final_score_29_c401 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 97257 => 0.0054249188,
    iv_pv001_inp_avm_autoval > 97257                                      => 0.0401060383,
    iv_pv001_inp_avm_autoval = NULL                                       => 0.0225077378,
                                                                             0.0225077378);

final_score_29_c400 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 2.5 => final_score_29_c401,
    iv_inq_per_addr > 2.5                             => -0.0235462798,
    iv_inq_per_addr = NULL                            => 0.0118107885,
                                                         0.0118107885);

final_score_29 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.32808481095 => final_score_29_c400,
    iv_inp_addr_avm_pct_change_3yr > 1.32808481095                                            => -0.0164289706,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                     => -0.0074156834,
                                                                                                 -0.0025448997);

final_score_30_c404 := map(
    iv_ams_college_code <> '  ' 
		  and NULL < (integer)iv_ams_college_code AND (integer)iv_ams_college_code <= 3 => -0.0024387636,
    (integer)iv_ams_college_code > 3                                 => 0.0395513980,
    iv_ams_college_code = '  '                              => 0.0006157502,
                                                               0.0006157502);

final_score_30_c403 := map(
    NULL < iv_max_lres AND iv_max_lres <= 277.5 => final_score_30_c404,
    iv_max_lres > 277.5                         => 0.0339347053,
    iv_max_lres = NULL                          => 0.0047673306,
                                                   0.0047673306);

final_score_30 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl <= 1.5 => final_score_30_c403,
    iv_inq_addrs_per_adl > 1.5                                  => -0.0351948066,
    iv_inq_addrs_per_adl = NULL                                 => 0.0020723147,
                                                                   -0.0030052688);

final_score_31_c406 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen <= 0.5 => 0.0023034246,
    iv_mos_since_gong_did_lst_seen > 0.5                                            => -0.0273554621,
    iv_mos_since_gong_did_lst_seen = NULL                                           => -0.0091850185,
                                                                                       -0.0091850185);

final_score_31_c407 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 1.5 => 0.0277108374,
    iv_inq_per_addr > 1.5                             => -0.0087255251,
    iv_inq_per_addr = NULL                            => 0.0169820995,
                                                         0.0169820995);

final_score_31 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 81.05 => final_score_31_c406,
    iv_sr001_source_profile > 81.05                                     => final_score_31_c407,
    iv_sr001_source_profile = NULL                                      => -0.0027093143,
                                                                           -0.0023766835);

final_score_32_c409 := map(
    NULL < iv_avg_lres AND iv_avg_lres <= 138.5 => -0.0105039328,
    iv_avg_lres > 138.5                         => 0.0159289567,
    iv_avg_lres = NULL                          => -0.0023028864,
                                                   -0.0050746392);

final_score_32_c410 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct <= 1.5 => 0.0016678123,
    iv_addr_non_phn_src_ct > 1.5                                    => 0.0445988254,
    iv_addr_non_phn_src_ct = NULL                                   => 0.0258901633,
                                                                       0.0258901633);

final_score_32 := map(
    NULL < iv_inp_addr_mortgage_amount AND iv_inp_addr_mortgage_amount <= 107834.5 => final_score_32_c409,
    iv_inp_addr_mortgage_amount > 107834.5                                         => final_score_32_c410,
    iv_inp_addr_mortgage_amount = NULL                                             => -0.0129464560,
                                                                                      -0.0024277281);

final_score_33_c413 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 38845 => 0.0098065824,
    iv_inp_addr_assessed_total_val > 38845                                            => 0.0366162628,
    iv_inp_addr_assessed_total_val = NULL                                             => 0.0158456171,
                                                                                         0.0158456171);

final_score_33_c412 := map(
    NULL < iv_inq_phones_per_adl AND iv_inq_phones_per_adl <= 0.5 => final_score_33_c413,
    iv_inq_phones_per_adl > 0.5                                   => -0.0166152153,
    iv_inq_phones_per_adl = NULL                                  => 0.0239945352,
                                                                     0.0051053437);

final_score_33 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 0.5 => final_score_33_c412,
    iv_inq_per_addr > 0.5                             => -0.0133948487,
    iv_inq_per_addr = NULL                            => -0.0040033950,
                                                         -0.0040368858);

final_score_34_c415 := map(
    iv_ed001_college_ind_37 <> ' '
		  AND NULL < (real)iv_ed001_college_ind_37 AND (real)iv_ed001_college_ind_37 <= 0.5 => -0.0091892766,
    (real)iv_ed001_college_ind_37 > 0.5                                     => 0.0268112420,
    iv_ed001_college_ind_37 = ' '                                    => -0.0107183885,
                                                                         -0.0072493444);

final_score_34_c416 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= 4.5 => 0.0277840249,
    iv_mos_src_voter_adl_lseen > 4.5                                        => -0.0149141667,
    iv_mos_src_voter_adl_lseen = NULL                                       => 0.0172777529,
                                                                               0.0172777529);

final_score_34 := map(
    NULL < iv_avg_lres AND iv_avg_lres <= 142.5 => final_score_34_c415,
    iv_avg_lres > 142.5                         => final_score_34_c416,
    iv_avg_lres = NULL                          => -0.0036374321,
                                                   -0.0026133474);

final_score_35_c419 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct <= 0.5 => 0.0330667729,
    iv_unreleased_liens_ct > 0.5                                    => -0.0064956687,
    iv_unreleased_liens_ct = NULL                                   => 0.0220593452,
                                                                       0.0220593452);

final_score_35_c418 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval <= 71997.5 => -0.0003367577,
    iv_pv001_bst_avm_autoval > 71997.5                                      => final_score_35_c419,
    iv_pv001_bst_avm_autoval = NULL                                         => 0.0373061755,
                                                                               0.0076795465);

final_score_35 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr <= 13.5 => final_score_35_c418,
    iv_adls_per_addr > 13.5                              => -0.0145150388,
    iv_adls_per_addr = NULL                              => -0.0414641318,
                                                            -0.0031715294);

final_score_36_c422 := map(
    NULL < iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr <= 1.5 => 0.0383344549,
    iv_inq_ssns_per_addr > 1.5                                  => -0.0276505594,
    iv_inq_ssns_per_addr = NULL                                 => 0.0267158946,
                                                                   0.0267158946);

final_score_36_c421 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 85.35 => 0.0019088335,
    iv_sr001_source_profile > 85.35                                     => final_score_36_c422,
    iv_sr001_source_profile = NULL                                      => 0.0043987562,
                                                                           0.0043987562);

final_score_36 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl <= 1.5 => final_score_36_c421,
    iv_ms001_ssns_per_adl > 1.5                                   => -0.0206068417,
    iv_ms001_ssns_per_adl = NULL                                  => -0.0038246959,
                                                                     -0.0019483194);

final_score_37_c424 := map(
    iv_ed001_college_ind_36 <> ' '
		  and NULL < (real)iv_ed001_college_ind_36 AND (real)iv_ed001_college_ind_36 <= 0.5 => -0.0061994826,
    (real)iv_ed001_college_ind_36 > 0.5                                     => 0.0281282348,
    iv_ed001_college_ind_36 = ' '                                    => -0.0097540322,
                                                                         -0.0059448338);

final_score_37_c425 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 84.85 => 0.0057688814,
    iv_sr001_source_profile > 84.85                                     => 0.0448362365,
    iv_sr001_source_profile = NULL                                      => 0.0147390429,
                                                                           0.0147390429);

final_score_37 := map(
    NULL < iv_avg_lres AND iv_avg_lres <= 142.5 => final_score_37_c424,
    iv_avg_lres > 142.5                         => final_score_37_c425,
    iv_avg_lres = NULL                          => -0.0016939583,
                                                   -0.0020105890);

final_score_38_c428 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 7040 => 0.0664221545,
    iv_prop_owned_assessed_total > 7040                                          => 0.0133552609,
    iv_prop_owned_assessed_total = NULL                                          => 0.0299368153,
                                                                                    0.0299368153);

final_score_38_c427 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 62.5 => final_score_38_c428,
    iv_mos_src_property_adl_lseen > 62.5                                           => -0.0124751114,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0145773912,
                                                                                      0.0145773912);

final_score_38 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 2.5 => -0.0064665162,
    iv_src_property_adl_count > 2.5                                       => final_score_38_c427,
    iv_src_property_adl_count = NULL                                      => 0.0027676108,
                                                                             -0.0012319345);

final_score_39_c431 := map(
    iv_ed001_college_ind_37 <> ' ' 
		  AND NULL < (real)iv_ed001_college_ind_37 AND (real)iv_ed001_college_ind_37 <= 0.5 => 0.0141844626,
    (real)iv_ed001_college_ind_37 > 0.5                                     => 0.0589203325,
    iv_ed001_college_ind_37 = ' '                                    => 0.0154306252,
                                                                         0.0189291701);

final_score_39_c430 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 <= 0.5 => final_score_39_c431,
    iv_iq001_inq_count12 > 0.5                                  => -0.0039278070,
    iv_iq001_inq_count12 = NULL                                 => 0.0072031918,
                                                                   0.0072031918);

final_score_39 := map(
    NULL < iv_src_bureau_lname_count AND iv_src_bureau_lname_count <= 9.5 => final_score_39_c430,
    iv_src_bureau_lname_count > 9.5                                       => -0.0117928132,
    iv_src_bureau_lname_count = NULL                                      => -0.0082492849,
                                                                             -0.0019054893);

final_score_40_c433 := map(
    NULL < iv_dl001_unrel_lien60_count AND iv_dl001_unrel_lien60_count <= 0.5 => 0.0153516851,
    iv_dl001_unrel_lien60_count > 0.5                                         => -0.0178615796,
    iv_dl001_unrel_lien60_count = NULL                                        => 0.0355640041,
                                                                                 0.0071001356);

final_score_40_c434 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 246730 => -0.0069034645,
    iv_prop_owned_assessed_total > 246730                                          => 0.0519962795,
    iv_prop_owned_assessed_total = NULL                                            => -0.0012730111,
                                                                                      -0.0053923704);

final_score_40 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.4568299534 => final_score_40_c433,
    iv_inp_addr_avm_pct_change_3yr > 1.4568299534                                            => -0.0210110628,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                    => final_score_40_c434,
                                                                                                -0.0027071653);

final_score_41_c437 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr <= 60004.5 => 0.0159475966,
    iv_inp_addr_avm_change_3yr > 60004.5                                        => -0.0346536089,
    iv_inp_addr_avm_change_3yr = NULL                                           => 0.0167681165,
                                                                                   0.0135629150);

final_score_41_c436 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn <= 1.5 => final_score_41_c437,
    iv_inq_per_ssn > 1.5                            => -0.0177345912,
    iv_inq_per_ssn = NULL                           => 0.0065330180,
                                                       0.0065330180);

final_score_41 := map(
    NULL < iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr <= 2.5 => -0.0120191467,
    iv_avg_num_sources_per_addr > 2.5                                         => final_score_41_c436,
    iv_avg_num_sources_per_addr = NULL                                        => -0.0035825972,
                                                                                 -0.0031670538);

final_score_42_c440 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 1649.5 => 0.0069619380,
    iv_bst_addr_building_area > 1649.5                                       => 0.0295200782,
    iv_bst_addr_building_area = NULL                                         => 0.0115989265,
                                                                                0.0115989265);

final_score_42_c439 := map(
    NULL < iv_dl001_lien_last_seen AND iv_dl001_lien_last_seen <= 0.5 => final_score_42_c440,
    iv_dl001_lien_last_seen > 0.5                                     => -0.0160211333,
    iv_dl001_lien_last_seen = NULL                                    => 0.0062056495,
                                                                         0.0039714949);

final_score_42 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 1.5 => final_score_42_c439,
    iv_inq_per_addr > 1.5                             => -0.0190236145,
    iv_inq_per_addr = NULL                            => 0.0073056395,
                                                         -0.0027431953);

final_score_43_c442 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl <= 1.5 => 0.0016078219,
    iv_inq_addrs_per_adl > 1.5                                  => -0.0287452523,
    iv_inq_addrs_per_adl = NULL                                 => -0.0045078102,
                                                                   -0.0045078102);

final_score_43_c443 := map(
    NULL < iv_avg_prop_sold_assess_amt AND iv_avg_prop_sold_assess_amt <= 125375 => 0.0368250600,
    iv_avg_prop_sold_assess_amt > 125375                                         => 0.1546396168,
    iv_avg_prop_sold_assess_amt = NULL                                           => 0.0512592938,
                                                                                    0.0512592938);

final_score_43 := map(
    iv_prof_license_category <> ' ' 
		  AND NULL < (real)iv_prof_license_category AND (real)iv_prof_license_category <= 3.5 => final_score_43_c442,
    (real)iv_prof_license_category > 3.5                                      => final_score_43_c443,
    iv_prof_license_category = ' '                                     => -0.0030901681,
                                                                           -0.0034037232);

final_score_44_c446 := map(
    NULL < iv_bst_addr_mortgage_amount AND iv_bst_addr_mortgage_amount <= 190612.5 => 0.0199340724,
    iv_bst_addr_mortgage_amount > 190612.5                                         => 0.0758902526,
    iv_bst_addr_mortgage_amount = NULL                                             => 0.0220856651,
                                                                                      0.0220856651);

final_score_44_c445 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 50.5 => final_score_44_c446,
    iv_mos_src_property_adl_lseen > 50.5                                           => -0.0065816336,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0072470527,
                                                                                      0.0072470527);

final_score_44 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 0.5 => -0.0116966054,
    iv_pl001_m_snc_prop_adl_fs > 0.5                                        => final_score_44_c445,
    iv_pl001_m_snc_prop_adl_fs = NULL                                       => -0.0015155471,
                                                                               -0.0019970379);

final_score_45_c449 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 3.5 => 0.0088691801,
    iv_inq_per_addr > 3.5                             => -0.0281150578,
    iv_inq_per_addr = NULL                            => 0.0031188023,
                                                         0.0031188023);

final_score_45_c448 := map(
    NULL < iv_hist_addr_match AND iv_hist_addr_match <= 0.5 => -0.0186639139,
    iv_hist_addr_match > 0.5                                => final_score_45_c449,
    iv_hist_addr_match = NULL                               => -0.0033049899,
                                                               -0.0033049899);

final_score_45 := map(
    NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count <= 1.5 => final_score_45_c448,
    iv_paw_active_phone_count > 1.5                                       => 0.0826988169,
    iv_paw_active_phone_count = NULL                                      => 0.0011005935,
                                                                             -0.0025922199);

final_score_46_c452 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs <= 355.5 => 0.0008385555,
    iv_sr001_m_hdr_fs > 355.5                               => 0.0307793042,
    iv_sr001_m_hdr_fs = NULL                                => 0.0072329291,
                                                               0.0072329291);

final_score_46_c451 := map(
    NULL < iv_prv_addr_source_count AND iv_prv_addr_source_count <= 0.5 => 0.0756708824,
    iv_prv_addr_source_count > 0.5                                      => final_score_46_c452,
    iv_prv_addr_source_count = NULL                                     => 0.0114456528,
                                                                           0.0114456528);

final_score_46 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 12.43336 => final_score_46_c451,
    iv_bst_addr_mtg_avm_pct_diff > 12.43336                                          => -0.0536055434,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                              => -0.0041619904,
                                                                                        -0.0008530540);

final_score_47_c455 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 149056.5 => 0.0163845010,
    iv_inp_addr_assessed_total_val > 149056.5                                            => -0.0622181770,
    iv_inp_addr_assessed_total_val = NULL                                                => 0.0134163998,
                                                                                            0.0134163998);

final_score_47_c454 := map(
    NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs <= 340.5 => -0.0061184140,
    iv_sr001_m_bureau_adl_fs > 340.5                                      => final_score_47_c455,
    iv_sr001_m_bureau_adl_fs = NULL                                       => -0.0018653402,
                                                                             -0.0018653402);

final_score_47 := map(
    iv_prof_license_category <> ' ' 
		  and NULL < (real)iv_prof_license_category AND (real)iv_prof_license_category <= 3.5 => final_score_47_c454,
    (real)iv_prof_license_category > 3.5                                      => 0.0445881000,
    iv_prof_license_category = ' '                                     => 0.0038229438,
                                                                           -0.0008698113);

final_score_48_c458 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val <= 16640 => -0.0253051256,
    iv_bst_addr_assessed_total_val > 16640                                            => 0.0233996209,
    iv_bst_addr_assessed_total_val = NULL                                             => 0.0138565945,
                                                                                         0.0138565945);

final_score_48_c457 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 1.3091512238 => final_score_48_c458,
    iv_bst_addr_avm_pct_change_3yr > 1.3091512238                                            => -0.0106063209,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                    => 0.0026559969,
                                                                                                0.0042155093);

final_score_48 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 1.5 => final_score_48_c457,
    iv_dg001_derog_count > 1.5                                  => -0.0186802615,
    iv_dg001_derog_count = NULL                                 => -0.0013203349,
                                                                   -0.0013324373);

final_score_49_c461 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income <= 65500 => -0.0094330459,
    iv_in001_estimated_income > 65500                                       => 0.0249330759,
    iv_in001_estimated_income = NULL                                        => -0.0075858199,
                                                                               -0.0075858199);

final_score_49_c460 := map(
    NULL < iv_src_bureau_lname_count AND iv_src_bureau_lname_count <= 5.5 => 0.0140832137,
    iv_src_bureau_lname_count > 5.5                                       => final_score_49_c461,
    iv_src_bureau_lname_count = NULL                                      => -0.0020510385,
                                                                             -0.0020510385);

final_score_49 := map(
    NULL < iv_mos_src_bureau_dob_fseen AND iv_mos_src_bureau_dob_fseen <= 400.5 => final_score_49_c460,
    iv_mos_src_bureau_dob_fseen > 400.5                                         => 0.0573842734,
    iv_mos_src_bureau_dob_fseen = NULL                                          => -0.0106972835,
                                                                                   -0.0015056968);

final_score_50_c463 := map(
    iv_ams_college_tier <> '  '
		  and NULL < (real)iv_ams_college_tier AND (real)iv_ams_college_tier <= -0.5 => 0.0071557322,
    iv_ams_college_tier <> '  '
		  and (real)iv_ams_college_tier > -0.5                                 => 0.0449610046,
    iv_ams_college_tier = '  '                                 => 0.0129985134,
                                                                  0.0129985134);

final_score_50_c464 := map(
    NULL < iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen <= 3.5 => -0.0100788465,
    iv_mos_since_paw_first_seen > 3.5                                         => 0.0216822898,
    iv_mos_since_paw_first_seen = NULL                                        => -0.0080165307,
                                                                                 -0.0080165307);

final_score_50 := map(
    NULL < iv_src_bureau_lname_count AND iv_src_bureau_lname_count <= 5.5 => final_score_50_c463,
    iv_src_bureau_lname_count > 5.5                                       => final_score_50_c464,
    iv_src_bureau_lname_count = NULL                                      => -0.0033444996,
                                                                             -0.0027460158);

final_score_51_c467 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr <= 7.5 => 0.0924158184,
    iv_adls_per_addr > 7.5                              => -0.0116414530,
    iv_adls_per_addr = NULL                             => 0.0239419023,
                                                           0.0239419023);

final_score_51_c466 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 209.5 => final_score_51_c467,
    iv_prv_addr_lres > 209.5                              => 0.1339336241,
    iv_prv_addr_lres = NULL                               => 0.0456465002,
                                                             0.0456465002);

final_score_51 := map(
    NULL < iv_avg_prop_sold_assess_amt AND iv_avg_prop_sold_assess_amt <= 197480 => -0.0008557262,
    iv_avg_prop_sold_assess_amt > 197480                                         => final_score_51_c466,
    iv_avg_prop_sold_assess_amt = NULL                                           => -0.0239939005,
                                                                                    -0.0003794740);

final_score_52_c470 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 1994 => 0.0158464801,
    iv_bst_addr_building_area > 1994                                       => 0.1124798131,
    iv_bst_addr_building_area = NULL                                       => 0.0445753088,
                                                                              0.0445753088);

final_score_52_c469 := map(
    NULL < iv_avg_prop_sold_assess_amt AND iv_avg_prop_sold_assess_amt <= 160877 => -0.0028420622,
    iv_avg_prop_sold_assess_amt > 160877                                         => final_score_52_c470,
    iv_avg_prop_sold_assess_amt = NULL                                           => -0.0129948347,
                                                                                    -0.0020832916);

final_score_52 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 1.32083584205 => 0.0093562465,
    iv_bst_addr_avm_pct_change_3yr > 1.32083584205                                            => -0.0153701342,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                     => final_score_52_c469,
                                                                                                 -0.0003437693);

final_score_53_c473 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count <= 1.5 => 0.0169200221,
    iv_mi001_adlperssn_count > 1.5                                      => -0.0056877468,
    iv_mi001_adlperssn_count = NULL                                     => 0.0157768871,
                                                                           0.0084240368);

final_score_53_c472 := map(
    NULL < iv_dl001_lien_last_seen AND iv_dl001_lien_last_seen <= 0.5 => final_score_53_c473,
    iv_dl001_lien_last_seen > 0.5                                     => -0.0158655162,
    iv_dl001_lien_last_seen = NULL                                    => 0.0023268552,
                                                                         0.0023268552);

final_score_53 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 12.5 => final_score_53_c472,
    iv_addrs_per_adl > 12.5                              => -0.0207689499,
    iv_addrs_per_adl = NULL                              => -0.0016987545,
                                                            -0.0023394037);

final_score_54_c476 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval <= 230776 => 0.0087303969,
    iv_pv001_bst_avm_autoval > 230776                                      => 0.0509971402,
    iv_pv001_bst_avm_autoval = NULL                                        => 0.0600690889,
                                                                              0.0111283203);

final_score_54_c475 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr <= 39007.5 => final_score_54_c476,
    iv_inp_addr_avm_change_3yr > 39007.5                                        => -0.0152451881,
    iv_inp_addr_avm_change_3yr = NULL                                           => -0.0020186940,
                                                                                   0.0017259885);

final_score_54 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 3.5 => final_score_54_c475,
    iv_inq_per_addr > 3.5                             => -0.0281423556,
    iv_inq_per_addr = NULL                            => -0.0075685143,
                                                         -0.0024043546);

final_score_55_c478 := map(
    NULL < iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen <= 333.5 => -0.0026999353,
    iv_mos_src_bureau_ssn_fseen > 333.5                                         => 0.0180036143,
    iv_mos_src_bureau_ssn_fseen = NULL                                          => 0.0020730531,
                                                                                   0.0020730531);

final_score_55_c479 := map(
    iv_infutor_nap <> ' ' 
		  and NULL < (real)iv_infutor_nap AND (real)iv_infutor_nap <= 9.5 => -0.0085073769,
    (real)iv_infutor_nap > 9.5                            => 0.1386595222,
    iv_infutor_nap = ' '                           => -0.0459831454,
                                                       -0.0119529014);

final_score_55 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl <= 1.5 => final_score_55_c478,
    iv_ms001_ssns_per_adl > 1.5                                   => -0.0162193455,
    iv_ms001_ssns_per_adl = NULL                                  => final_score_55_c479,
                                                                     -0.0027476103);

final_score_56_c482 := map(
    NULL < iv_bst_addr_avm_change_3yr AND iv_bst_addr_avm_change_3yr <= 35803 => 0.0644579232,
    iv_bst_addr_avm_change_3yr > 35803                                        => -0.0208997149,
    iv_bst_addr_avm_change_3yr = NULL                                         => 0.0299767762,
                                                                                 0.0294388578);

final_score_56_c481 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 2647 => -0.0020474910,
    iv_bst_addr_building_area > 2647                                       => final_score_56_c482,
    iv_bst_addr_building_area = NULL                                       => -0.0006645191,
                                                                              -0.0006645191);

final_score_56 := map(
    NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count <= 1.5 => final_score_56_c481,
    iv_paw_active_phone_count > 1.5                                       => 0.0670906454,
    iv_paw_active_phone_count = NULL                                      => -0.0027057969,
                                                                             -0.0002375080);

final_score_57_c485 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 108290 => 0.0147356127,
    iv_inp_addr_assessed_total_val > 108290                                            => -0.0586168986,
    iv_inp_addr_assessed_total_val = NULL                                              => 0.0116010643,
                                                                                          0.0116010643);

final_score_57_c484 := map(
    NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs <= 337.5 => -0.0045783062,
    iv_sr001_m_bureau_adl_fs > 337.5                                      => final_score_57_c485,
    iv_sr001_m_bureau_adl_fs = NULL                                       => 0.0073645019,
                                                                             -0.0005544461);

final_score_57 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 3020.5 => final_score_57_c484,
    iv_inp_addr_building_area > 3020.5                                       => 0.0355967255,
    iv_inp_addr_building_area = NULL                                         => 0.0140510092,
                                                                                0.0006120475);

final_score_58_c487 := map(
    NULL < iv_max_ids_per_addr AND iv_max_ids_per_addr <= 13.5 => 0.0047231334,
    iv_max_ids_per_addr > 13.5                                 => -0.0120414013,
    iv_max_ids_per_addr = NULL                                 => -0.0032494645,
                                                                  -0.0032494645);

final_score_58_c488 := map(
    NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen <= 4.5 => 0.0925502410,
    iv_mos_since_prv_addr_lseen > 4.5                                         => 0.0020634136,
    iv_mos_since_prv_addr_lseen = NULL                                        => 0.0483803998,
                                                                                 0.0483803998);

final_score_58 := map(
    iv_prof_license_category <> ' '
		  and NULL < (real)iv_prof_license_category AND (real)iv_prof_license_category <= 3.5 => final_score_58_c487,
    (real)iv_prof_license_category > 3.5                                      => final_score_58_c488,
    iv_prof_license_category = ' '                                     => -0.0070714484,
                                                                           -0.0023717838);

final_score_59_c491 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 12.5 => 0.0355508828,
    iv_addrs_per_adl > 12.5                              => -0.0695509782,
    iv_addrs_per_adl = NULL                              => 0.0018357195,
                                                            0.0018357195);

final_score_59_c490 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 107.5 => final_score_59_c491,
    iv_mos_since_gong_did_fst_seen > 107.5                                            => 0.0692102793,
    iv_mos_since_gong_did_fst_seen = NULL                                             => 0.0323892990,
                                                                                         0.0323892990);

final_score_59 := map(
    NULL < iv_prop_sold_assessed_total AND iv_prop_sold_assessed_total <= 199790 => -0.0013187800,
    iv_prop_sold_assessed_total > 199790                                         => final_score_59_c490,
    iv_prop_sold_assessed_total = NULL                                           => -0.0106722533,
                                                                                    -0.0005948981);

final_score_60_c494 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 <= 3.5 => 0.0021789136,
    iv_iq001_inq_count12 > 3.5                                  => -0.0352321742,
    iv_iq001_inq_count12 = NULL                                 => -0.0016348422,
                                                                   -0.0016348422);

final_score_60_c493 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 130.5 => final_score_60_c494,
    iv_mos_since_prop1_sale > 130.5                                     => 0.0267499319,
    iv_mos_since_prop1_sale = NULL                                      => -0.0286706799,
                                                                           -0.0005539048);

final_score_60 := map(
    (iv_full_name_ver_sources in ['Name not Verd', 'NonPhn Only', 'Phn & NonPhn']) => final_score_60_c493,
    (iv_full_name_ver_sources in ['Phn Only'])                                     => 0.1212004956,
    iv_full_name_ver_sources = ''                                                => -0.0064606079,
                                                                                      -0.0001566650);

final_score_61_c496 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 1.32061547265 => 0.0064995459,
    iv_bst_addr_avm_pct_change_3yr > 1.32061547265                                            => -0.0192113985,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                     => -0.0037127664,
                                                                                                 -0.0026917626);

final_score_61_c497 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 0.5 => 0.0400139561,
    iv_dg001_derog_count > 0.5                                  => -0.0159482543,
    iv_dg001_derog_count = NULL                                 => 0.0180572188,
                                                                   0.0180572188);

final_score_61 := map(
    iv_ams_college_code <> '  '
		  and NULL < (integer)iv_ams_college_code AND (integer)iv_ams_college_code <= 3 => final_score_61_c496,
    (integer)iv_ams_college_code > 3                                 => final_score_61_c497,
    iv_ams_college_code = '  '                              => 0.0033962871,
                                                               -0.0012512050);

final_score_62_c499 := map(
    NULL < iv_paw_dead_business_count AND iv_paw_dead_business_count <= 0.5 => -0.0014957699,
    iv_paw_dead_business_count > 0.5                                        => -0.0638592437,
    iv_paw_dead_business_count = NULL                                       => -0.0347639357,
                                                                               -0.0027145133);

final_score_62_c500 := map(
    iv_infutor_nap <> ' '
		  and NULL < (real)iv_infutor_nap AND (real)iv_infutor_nap <= 9.5 => -0.0145151573,
    (real)iv_infutor_nap > 9.5                            => 0.1150176718,
    iv_infutor_nap = ' '                           => -0.0470531341,
                                                       -0.0014566564);

final_score_62 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct <= 2.5 => final_score_62_c499,
    iv_addr_non_phn_src_ct > 2.5                                    => 0.0167939916,
    iv_addr_non_phn_src_ct = NULL                                   => final_score_62_c500,
                                                                       -0.0002850323);

final_score_63_c503 := map(
    NULL < iv_avg_prop_sold_assess_amt AND iv_avg_prop_sold_assess_amt <= 58380 => 0.0053135220,
    iv_avg_prop_sold_assess_amt > 58380                                         => 0.0304927327,
    iv_avg_prop_sold_assess_amt = NULL                                          => 0.0081228864,
                                                                                   0.0081228864);

final_score_63_c502 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 73.5 => final_score_63_c503,
    iv_mos_src_property_adl_lseen > 73.5                                           => -0.0095410171,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0310463776,
                                                                                      0.0045803526);

final_score_63 := map(
    NULL < iv_max_ids_per_addr AND iv_max_ids_per_addr <= 19.5 => final_score_63_c502,
    iv_max_ids_per_addr > 19.5                                 => -0.0148436484,
    iv_max_ids_per_addr = NULL                                 => -0.0101951529,
                                                                  -0.0010434718);

final_score_64_c506 := map(
    (iv_ams_college_major in ['Business', 'Liberal Arts', 'No AMS Found', 'No College Found', 'Science']) => 0.0194947939,
    (iv_ams_college_major in ['Medical', 'Unclassified'])                                                 => 0.0845758696,
    iv_ams_college_major = ''                                                                           => 0.0282334050,
                                                                                                             0.0282334050);

final_score_64_c505 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn <= 2.5 => final_score_64_c506,
    iv_inq_per_ssn > 2.5                            => -0.0220353123,
    iv_inq_per_ssn = NULL                           => 0.0218656702,
                                                       0.0218656702);

final_score_64 := map(
    NULL < iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen <= 0.5 => -0.0023432408,
    iv_mos_since_paw_first_seen > 0.5                                         => final_score_64_c505,
    iv_mos_since_paw_first_seen = NULL                                        => -0.0054383271,
                                                                                 -0.0009981662);

final_score_65_c508 := map(
    NULL < iv_prop1_sale_price AND iv_prop1_sale_price <= 244250 => 0.0047091549,
    iv_prop1_sale_price > 244250                                 => 0.0704483792,
    iv_prop1_sale_price = NULL                                   => 0.0051425317,
                                                                    0.0052584668);

final_score_65_c509 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 102.5 => -0.0214148263,
    iv_sr001_m_wp_adl_fs > 102.5                                  => 0.0027849797,
    iv_sr001_m_wp_adl_fs = NULL                                   => -0.0116556306,
                                                                     -0.0116556306);

final_score_65 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen <= 2.5 => final_score_65_c508,
    iv_mos_since_gong_did_lst_seen > 2.5                                            => final_score_65_c509,
    iv_mos_since_gong_did_lst_seen = NULL                                           => -0.0012176564,
                                                                                       -0.0012176564);

final_score_66_c512 := map(
    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen <= 45.5 => 0.0079599250,
    iv_mos_since_infutor_last_seen > 45.5                                            => 0.0726136123,
    iv_mos_since_infutor_last_seen = NULL                                            => 0.0009744962,
                                                                                        0.0250557803);

final_score_66_c511 := map(
    (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed', '3 - BK Other']) => -0.0059242498,
    (iv_db001_bankruptcy in ['1 - BK Discharged'])                             => final_score_66_c512,
    iv_db001_bankruptcy = ''                                                 => -0.0286288592,
                                                                                  -0.0034236530);

final_score_66 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 12.43336 => 0.0065830097,
    iv_bst_addr_mtg_avm_pct_diff > 12.43336                                          => -0.0743110095,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                              => final_score_66_c511,
                                                                                        -0.0015873758);

final_score_67_c514 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 71247 => 0.0004456524,
    iv_pv001_inp_avm_autoval > 71247                                      => 0.0257432628,
    iv_pv001_inp_avm_autoval = NULL                                       => 0.0094708868,
                                                                             0.0094708868);

final_score_67_c515 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 3.5 => 0.0319027667,
    iv_addrs_per_adl > 3.5                              => -0.0070144090,
    iv_addrs_per_adl = NULL                             => -0.0056118051,
                                                           -0.0056118051);

final_score_67 := map(
    NULL < iv_src_bureau_lname_count AND iv_src_bureau_lname_count <= 5.5 => final_score_67_c514,
    iv_src_bureau_lname_count > 5.5                                       => final_score_67_c515,
    iv_src_bureau_lname_count = NULL                                      => 0.0007971222,
                                                                             -0.0017423985);

final_score_68_c517 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct <= 1.5 => 0.0026446872,
    iv_gong_did_phone_ct > 1.5                                  => -0.0175112225,
    iv_gong_did_phone_ct = NULL                                 => -0.0014515839,
                                                                   -0.0014515839);

final_score_68_c518 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 3171.5 => 0.0206012165,
    iv_inp_addr_building_area > 3171.5                                       => 0.1099968452,
    iv_inp_addr_building_area = NULL                                         => 0.0242190081,
                                                                                0.0242190081);

final_score_68 := map(
    iv_prof_license_category <> ' '
		  and NULL < (real)iv_prof_license_category AND (real)iv_prof_license_category <= -0.5 => final_score_68_c517,
    iv_prof_license_category <> ' ' 
		  and (real)iv_prof_license_category > -0.5                                      => final_score_68_c518,
    iv_prof_license_category = ' '                                      => -0.0007511163,
                                                                            -0.0000894279);

final_score_69_c521 := map(
    NULL < iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen <= 400.5 => 0.0052983315,
    iv_mos_src_bureau_ssn_fseen > 400.5                                         => 0.0497373486,
    iv_mos_src_bureau_ssn_fseen = NULL                                          => 0.0060674731,
                                                                                   0.0060674731);

final_score_69_c520 := map(
    (iv_db001_bankruptcy in ['2 - BK Dismissed', '3 - BK Other']) => -0.0480909330,
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged'])   => final_score_69_c521,
    iv_db001_bankruptcy = ''                                    => 0.0048338133,
                                                                     0.0048338133);

final_score_69 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 12.5 => final_score_69_c520,
    iv_addrs_per_adl > 12.5                              => -0.0151336672,
    iv_addrs_per_adl = NULL                              => -0.0056280376,
                                                            0.0006036362);

final_score_70_c524 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 0.91485451405 => -0.0278125974,
    iv_inp_addr_avm_pct_change_3yr > 0.91485451405                                            => 0.0109457543,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                     => 0.0039277901,
                                                                                                 0.0041636139);

final_score_70_c523 := map(
    NULL < iv_prop1_sale_price AND iv_prop1_sale_price <= 168850 => final_score_70_c524,
    iv_prop1_sale_price > 168850                                 => 0.0399458198,
    iv_prop1_sale_price = NULL                                   => 0.0319751149,
                                                                    0.0054449262);

final_score_70 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 0.5 => final_score_70_c523,
    iv_inq_per_addr > 0.5                             => -0.0078494592,
    iv_inq_per_addr = NULL                            => 0.0055603657,
                                                         -0.0010647648);

final_score_71_c527 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 4.5 => 0.0352588740,
    iv_src_property_adl_count > 4.5                                       => 0.1139941289,
    iv_src_property_adl_count = NULL                                      => 0.0509850956,
                                                                             0.0509850956);

final_score_71_c526 := map(
    NULL < iv_age_at_high_issue AND iv_age_at_high_issue <= 16.5 => final_score_71_c527,
    iv_age_at_high_issue > 16.5                                  => -0.0434728281,
    iv_age_at_high_issue = NULL                                  => 0.0343160502,
                                                                    0.0343160502);

final_score_71 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct <= 3.5 => -0.0006655630,
    iv_addr_non_phn_src_ct > 3.5                                    => final_score_71_c526,
    iv_addr_non_phn_src_ct = NULL                                   => 0.0158834192,
                                                                       0.0002840106);

final_score_72_c530 := map(
    NULL < iv_bst_addr_avm_change_3yr AND iv_bst_addr_avm_change_3yr <= 36945.5 => 0.0755308793,
    iv_bst_addr_avm_change_3yr > 36945.5                                        => -0.0204924676,
    iv_bst_addr_avm_change_3yr = NULL                                           => 0.0315325915,
                                                                                   0.0334153213);

final_score_72_c529 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 2910 => -0.0000277917,
    iv_inp_addr_building_area > 2910                                       => final_score_72_c530,
    iv_inp_addr_building_area = NULL                                       => 0.0010675358,
                                                                              0.0010675358);

final_score_72 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct <= 2.5 => final_score_72_c529,
    iv_gong_did_phone_ct > 2.5                                  => -0.0312189549,
    iv_gong_did_phone_ct = NULL                                 => -0.0068334980,
                                                                   -0.0014089845);

final_score_73_c533 := map(
    NULL < iv_dist_bst_addr_to_prv_addr AND iv_dist_bst_addr_to_prv_addr <= 380.5 => 0.0122190714,
    iv_dist_bst_addr_to_prv_addr > 380.5                                          => 0.0569734825,
    iv_dist_bst_addr_to_prv_addr = NULL                                           => 0.0155421468,
                                                                                     0.0155421468);

final_score_73_c532 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= 10.5 => final_score_73_c533,
    iv_mos_src_voter_adl_lseen > 10.5                                        => -0.0107309081,
    iv_mos_src_voter_adl_lseen = NULL                                        => 0.0033468121,
                                                                                0.0033468121);

final_score_73 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= -0.5 => -0.0121606295,
    iv_mos_src_voter_adl_lseen > -0.5                                        => final_score_73_c532,
    iv_mos_src_voter_adl_lseen = NULL                                        => -0.0007603934,
                                                                                -0.0019085063);

final_score_74_c535 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 6.5 => -0.0051958025,
    iv_pl001_m_snc_prop_adl_fs > 6.5                                        => 0.0169575958,
    iv_pl001_m_snc_prop_adl_fs = NULL                                       => 0.0032231843,
                                                                               0.0032231843);

final_score_74_c536 := map(
    iv_ed001_college_ind_37 <> ' ' 
		  AND NULL < (real)iv_ed001_college_ind_37 AND (real)iv_ed001_college_ind_37 <= 0.5 => -0.0039844898,
    (real)iv_ed001_college_ind_37 > 0.5                                     => 0.0406846129,
    iv_ed001_college_ind_37 = ' '                                    => -0.0113337890,
                                                                         -0.0080673359);

final_score_74 := map(
    iv_bst_own_prop_x_addr_naprop <> ' '
		  and NULL < (real)iv_bst_own_prop_x_addr_naprop AND (real)iv_bst_own_prop_x_addr_naprop <= 11.5 => final_score_74_c535,
    (real)iv_bst_own_prop_x_addr_naprop > 11.5                                           => final_score_74_c536,
    iv_bst_own_prop_x_addr_naprop = ' '                                           => -0.0058619342,
                                                                                      0.0005168292);

final_score_75_c538 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 12.5 => 0.0713867311,
    iv_mos_src_property_adl_lseen > 12.5                                           => 0.0060257327,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0362145695,
                                                                                      0.0362145695);

final_score_75_c539 := map(
    (iv_lname_eda_sourced_type in ['-1', 'A']) => -0.0351846442,
    (iv_lname_eda_sourced_type in ['AP', 'P']) => 0.0874574093,
    iv_lname_eda_sourced_type = ''           => -0.0096685123,
                                                  -0.0096685123);

final_score_75 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct <= 3.5 => -0.0022674311,
    iv_addr_non_phn_src_ct > 3.5                                    => final_score_75_c538,
    iv_addr_non_phn_src_ct = NULL                                   => final_score_75_c539,
                                                                       -0.0016464714);

final_score_76_c542 := map(
    (iv_ams_file_type in ['C', 'H'])  => 0.0306138061,
    (iv_ams_file_type in ['-1', 'A']) => 0.1214751145,
    iv_ams_file_type = ''           => 0.0374346276,
                                         0.0374346276);

final_score_76_c541 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 0.5 => final_score_76_c542,
    iv_dg001_derog_count > 0.5                                  => -0.0199427873,
    iv_dg001_derog_count = NULL                                 => 0.0163987804,
                                                                   0.0163987804);

final_score_76 := map(
    iv_ed001_college_ind_37 <> ' ' 
		  and NULL < (real)iv_ed001_college_ind_37 AND (real)iv_ed001_college_ind_37 <= 0.5 => -0.0050398843,
    (real)iv_ed001_college_ind_37 > 0.5                                     => final_score_76_c541,
    iv_ed001_college_ind_37 = ' '                                    => -0.0023286504,
                                                                         -0.0018106562);

final_score_77_c545 := map(
    NULL < iv_mos_src_bureau_dob_fseen AND iv_mos_src_bureau_dob_fseen <= 340.5 => 0.0068739206,
    iv_mos_src_bureau_dob_fseen > 340.5                                         => 0.0301326985,
    iv_mos_src_bureau_dob_fseen = NULL                                          => 0.0103071442,
                                                                                   0.0103071442);

final_score_77_c544 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count <= 1.5 => final_score_77_c545,
    iv_mi001_adlperssn_count > 1.5                                      => -0.0057852574,
    iv_mi001_adlperssn_count = NULL                                     => -0.0032675833,
                                                                           0.0036653892);

final_score_77 := map(
    NULL < iv_dl001_lien_last_seen AND iv_dl001_lien_last_seen <= 0.5 => final_score_77_c544,
    iv_dl001_lien_last_seen > 0.5                                     => -0.0148979320,
    iv_dl001_lien_last_seen = NULL                                    => 0.0025199332,
                                                                         -0.0016616977);

final_score_78_c548 := map(
    NULL < iv_combined_age AND iv_combined_age <= 67.5 => 0.0098680216,
    iv_combined_age > 67.5                             => -0.0177456143,
    iv_combined_age = NULL                             => 0.0075721063,
                                                          0.0075721063);

final_score_78_c547 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 3.5 => final_score_78_c548,
    iv_inq_per_addr > 3.5                             => -0.0235929873,
    iv_inq_per_addr = NULL                            => 0.0027435215,
                                                         0.0027435215);

final_score_78 := map(
    NULL < iv_hist_addr_match AND iv_hist_addr_match <= 0.5 => -0.0157702088,
    iv_hist_addr_match > 0.5                                => final_score_78_c547,
    iv_hist_addr_match = NULL                               => -0.0071056804,
                                                               -0.0028813995);

final_score_79_c551 := map(
    (iv_ams_college_major in ['No AMS Found', 'Science'])                                                 => -0.0002078620,
    (iv_ams_college_major in ['Business', 'Liberal Arts', 'Medical', 'No College Found', 'Unclassified']) => 0.0527466968,
    iv_ams_college_major = ''                                                                           => 0.0096833025,
                                                                                                             0.0096833025);

final_score_79_c550 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 119150 => final_score_79_c551,
    iv_purch_sold_assess_val_diff > 119150                                           => -0.0347417390,
    iv_purch_sold_assess_val_diff = NULL                                             => 0.0047554943,
                                                                                        0.0045714497);

final_score_79 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 1.5 => final_score_79_c550,
    iv_dg001_derog_count > 1.5                                  => -0.0155080008,
    iv_dg001_derog_count = NULL                                 => 0.0026675564,
                                                                   -0.0002094547);

final_score_80_c554 := map(
    NULL < iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen <= 265.5 => -0.0009418975,
    iv_mos_since_prv_addr_fseen > 265.5                                         => 0.0190345425,
    iv_mos_since_prv_addr_fseen = NULL                                          => 0.0008242229,
                                                                                   0.0008242229);

final_score_80_c553 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 3025.5 => final_score_80_c554,
    iv_inp_addr_building_area > 3025.5                                       => 0.0343304377,
    iv_inp_addr_building_area = NULL                                         => 0.0017518687,
                                                                                0.0017518687);

final_score_80 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl <= 1.5 => final_score_80_c553,
    iv_ms001_ssns_per_adl > 1.5                                   => -0.0153557342,
    iv_ms001_ssns_per_adl = NULL                                  => 0.0075897826,
                                                                     -0.0023206663);

final_score_81_c557 := map(
    NULL < iv_adls_per_phone AND iv_adls_per_phone <= 1.5 => -0.0073263862,
    iv_adls_per_phone > 1.5                               => 0.0483281985,
    iv_adls_per_phone = NULL                              => -0.0255032158,
                                                             0.0007752020);

final_score_81_c556 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 55595 => final_score_81_c557,
    iv_prop_owned_assessed_total > 55595                                          => -0.0274403080,
    iv_prop_owned_assessed_total = NULL                                           => -0.0101218641,
                                                                                     -0.0101218641);

final_score_81 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 76.5 => 0.0028383997,
    iv_mos_src_property_adl_lseen > 76.5                                           => final_score_81_c556,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0058450762,
                                                                                      0.0003376629);

final_score_82_c559 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 119110 => 0.0050426188,
    iv_inp_addr_assessed_total_val > 119110                                            => -0.0373072512,
    iv_inp_addr_assessed_total_val = NULL                                              => 0.0024686890,
                                                                                          0.0024686890);

final_score_82_c560 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 158.5 => -0.0009803406,
    iv_mos_since_gong_did_fst_seen > 158.5                                            => 0.0507508683,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0056299260,
                                                                                         0.0008208784);

final_score_82 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 83.05 => -0.0287757360,
    iv_pv001_bst_avm_chg_1yr_pct > 83.05                                          => final_score_82_c559,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                           => final_score_82_c560,
                                                                                     -0.0003927824);

final_score_83_c563 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 4.5 => -0.0057084807,
    iv_src_property_adl_count > 4.5                                       => 0.0125743741,
    iv_src_property_adl_count = NULL                                      => -0.0040537943,
                                                                             -0.0040537943);

final_score_83_c562 := map(
    NULL < iv_paw_dead_business_count AND iv_paw_dead_business_count <= 0.5 => final_score_83_c563,
    iv_paw_dead_business_count > 0.5                                        => -0.0615724592,
    iv_paw_dead_business_count = NULL                                       => -0.0048712144,
                                                                               -0.0048712144);

final_score_83 := map(
    NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr <= 491.5 => final_score_83_c562,
    iv_dist_inp_addr_to_prv_addr > 491.5                                          => 0.0165195660,
    iv_dist_inp_addr_to_prv_addr = NULL                                           => 0.0020786555,
                                                                                     -0.0026322223);

final_score_84_c566 := map(
    NULL < iv_max_ids_per_addr AND iv_max_ids_per_addr <= 11.5 => 0.0768017173,
    iv_max_ids_per_addr > 11.5                                 => 0.0142373109,
    iv_max_ids_per_addr = NULL                                 => 0.0439528215,
                                                                  0.0439528215);

final_score_84_c565 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 110.5 => final_score_84_c566,
    iv_mos_since_gong_did_fst_seen > 110.5                                            => 0.0024325439,
    iv_mos_since_gong_did_fst_seen = NULL                                             => 0.0075480940,
                                                                                         0.0075480940);

final_score_84 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 107.5 => -0.0057432999,
    iv_mos_since_gong_did_fst_seen > 107.5                                            => final_score_84_c565,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0053142296,
                                                                                         -0.0015736864);

final_score_85_c568 := map(
    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val <= 83825 => 0.0008843615,
    iv_prv_addr_assessed_total_val > 83825                                            => -0.0237657240,
    iv_prv_addr_assessed_total_val = NULL                                             => -0.0008174394,
                                                                                         -0.0008174394);

final_score_85_c569 := map(
    NULL < iv_prop_sold_assessed_total AND iv_prop_sold_assessed_total <= 93119.5 => 0.0191285555,
    iv_prop_sold_assessed_total > 93119.5                                         => 0.1266838399,
    iv_prop_sold_assessed_total = NULL                                            => 0.0227560525,
                                                                                     0.0227560525);

final_score_85 := map(
    NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr <= 1234.5 => final_score_85_c568,
    iv_dist_inp_addr_to_prv_addr > 1234.5                                          => final_score_85_c569,
    iv_dist_inp_addr_to_prv_addr = NULL                                            => -0.0147892315,
                                                                                      0.0003234522);

final_score_86_c572 := map(
    iv_prof_license_category <> ' '
		  and NULL < (real)iv_prof_license_category AND (real)iv_prof_license_category <= 3.5 => 0.0208168948,
    (real)iv_prof_license_category > 3.5                                      => 0.0856790868,
    iv_prof_license_category = ' '                                     => 0.0226099822,
                                                                           0.0226099822);

final_score_86_c571 := map(
    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val <= 84373 => final_score_86_c572,
    iv_prv_addr_assessed_total_val > 84373                                            => -0.0237380072,
    iv_prv_addr_assessed_total_val = NULL                                             => 0.0127617423,
                                                                                         0.0127617423);

final_score_86 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 100329 => -0.0027053753,
    iv_prv_addr_avm_auto_val > 100329                                      => final_score_86_c571,
    iv_prv_addr_avm_auto_val = NULL                                        => 0.0041703249,
                                                                              0.0004094167);

final_score_87_c575 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr <= 39146.5 => 0.0136155458,
    iv_inp_addr_avm_change_3yr > 39146.5                                        => -0.0307435490,
    iv_inp_addr_avm_change_3yr = NULL                                           => 0.0131565010,
                                                                                   0.0097540445);

final_score_87_c574 := map(
    NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs <= 337.5 => -0.0062865455,
    iv_sr001_m_bureau_adl_fs > 337.5                                      => final_score_87_c575,
    iv_sr001_m_bureau_adl_fs = NULL                                       => -0.0021451380,
                                                                             -0.0021451380);

final_score_87 := map(
    iv_ams_college_tier <> '  ' 
		  and NULL < (real)iv_ams_college_tier AND (real)iv_ams_college_tier <= 1.5 => final_score_87_c574,
    (real)iv_ams_college_tier > 1.5                                 => 0.0148108002,
    iv_ams_college_tier = '  '                                => 0.0104659678,
                                                                 0.0002325622);

final_score_88_c577 := map(
    NULL < iv_age_at_high_issue AND iv_age_at_high_issue <= 16.5 => 0.0014666048,
    iv_age_at_high_issue > 16.5                                  => -0.0104712423,
    iv_age_at_high_issue = NULL                                  => -0.0227310586,
                                                                    -0.0017035113);

final_score_88_c578 := map(
    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val <= 44100 => 0.0180934995,
    iv_prv_addr_assessed_total_val > 44100                                            => 0.1009730706,
    iv_prv_addr_assessed_total_val = NULL                                             => 0.0450775459,
                                                                                         0.0450775459);

final_score_88 := map(
    NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count <= 1.5 => final_score_88_c577,
    iv_paw_active_phone_count > 1.5                                       => final_score_88_c578,
    iv_paw_active_phone_count = NULL                                      => -0.0032917894,
                                                                             -0.0014000828);

final_score_89_c581 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 1.0184488781 => 0.0186381407,
    iv_bst_addr_mtg_avm_pct_diff > 1.0184488781                                          => -0.0115168090,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                  => -0.0156128568,
                                                                                            -0.0089089232);

final_score_89_c580 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 3129 => final_score_89_c581,
    iv_inp_addr_building_area > 3129                                       => 0.0432493437,
    iv_inp_addr_building_area = NULL                                       => -0.0073741165,
                                                                              -0.0073741165);

final_score_89 := map(
    iv_bst_own_prop_x_addr_naprop <> ' '
		  and NULL < (real)iv_bst_own_prop_x_addr_naprop AND (real)iv_bst_own_prop_x_addr_naprop <= 11.5 => 0.0058974624,
    (real)iv_bst_own_prop_x_addr_naprop > 11.5                                           => final_score_89_c580,
    iv_bst_own_prop_x_addr_naprop = ' '                                           => 0.0036517445,
                                                                                      0.0029277911);

final_score_90_c583 := map(
    iv_vp091_phnzip_mismatch <> ' ' 
		  and NULL < (real)iv_vp091_phnzip_mismatch AND (real)iv_vp091_phnzip_mismatch <= 0.5 => 0.0194411284,
    (real)iv_vp091_phnzip_mismatch > 0.5                                      => 0.1014538512,
    iv_vp091_phnzip_mismatch = ' '                                     => 0.0461643751,
                                                                           0.0461643751);

final_score_90_c584 := map(
    NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr <= 12.5 => -0.0038513767,
    iv_dist_inp_addr_to_prv_addr > 12.5                                          => 0.0089372514,
    iv_dist_inp_addr_to_prv_addr = NULL                                          => -0.0031156742,
                                                                                    0.0000199045);

final_score_90 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff <= 13850 => -0.0228182102,
    iv_prop2_purch_sale_diff > 13850                                      => final_score_90_c583,
    iv_prop2_purch_sale_diff = NULL                                       => final_score_90_c584,
                                                                             0.0002196058);

final_score_91_c587 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= 10.5 => 0.0112303446,
    iv_mos_src_voter_adl_lseen > 10.5                                        => -0.0054974958,
    iv_mos_src_voter_adl_lseen = NULL                                        => 0.0035057031,
                                                                                0.0035057031);

final_score_91_c586 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= -0.5 => -0.0093437113,
    iv_mos_src_voter_adl_lseen > -0.5                                        => final_score_91_c587,
    iv_mos_src_voter_adl_lseen = NULL                                        => -0.0142116111,
                                                                                -0.0010124030);

final_score_91 := map(
    (iv_full_name_ver_sources in ['Name not Verd', 'NonPhn Only', 'Phn & NonPhn']) => final_score_91_c586,
    (iv_full_name_ver_sources in ['Phn Only'])                                     => 0.0916739240,
    iv_full_name_ver_sources = ''                                                => -0.0077798091,
                                                                                      -0.0007439962);

final_score_92_c590 := map(
    NULL < iv_age_at_high_issue AND iv_age_at_high_issue <= 6.5 => 0.0134052066,
    iv_age_at_high_issue > 6.5                                  => -0.0020767559,
    iv_age_at_high_issue = NULL                                 => -0.0147334011,
                                                                   0.0028990132);

final_score_92_c589 := map(
    NULL < iv_prop1_sale_price AND iv_prop1_sale_price <= 241165 => final_score_92_c590,
    iv_prop1_sale_price > 241165                                 => 0.0467198850,
    iv_prop1_sale_price = NULL                                   => -0.0038643938,
                                                                    0.0032462802);

final_score_92 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn <= 1.5 => final_score_92_c589,
    iv_inq_per_ssn > 1.5                            => -0.0173176620,
    iv_inq_per_ssn = NULL                           => -0.0097020798,
                                                       -0.0019285257);

final_score_93_c593 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 12.3343605785 => 0.0111225058,
    iv_bst_addr_mtg_avm_pct_diff > 12.3343605785                                          => -0.0601553848,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                   => 0.0047031080,
                                                                                             0.0057749029);

final_score_93_c592 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 1.5 => final_score_93_c593,
    iv_inq_per_addr > 1.5                             => -0.0106258571,
    iv_inq_per_addr = NULL                            => 0.0009366110,
                                                         0.0009366110);

final_score_93 := map(
    NULL < iv_liens_unrel_lt_ct AND iv_liens_unrel_lt_ct <= 0.5 => final_score_93_c592,
    iv_liens_unrel_lt_ct > 0.5                                  => -0.0536103748,
    iv_liens_unrel_lt_ct = NULL                                 => -0.0000788570,
                                                                   -0.0019210025);

final_score_94_c596 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 269.5 => -0.0016103648,
    iv_pl001_m_snc_prop_adl_fs > 269.5                                        => -0.1037723117,
    iv_pl001_m_snc_prop_adl_fs = NULL                                         => -0.0199241058,
                                                                                 -0.0199241058);

final_score_94_c595 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 123490 => final_score_94_c596,
    iv_purch_sold_assess_val_diff > 123490                                           => -0.0772897796,
    iv_purch_sold_assess_val_diff = NULL                                             => -0.0089482629,
                                                                                        -0.0111052653);

final_score_94 := map(
    NULL < iv_age_at_high_issue AND iv_age_at_high_issue <= 16.5 => 0.0043676035,
    iv_age_at_high_issue > 16.5                                  => final_score_94_c595,
    iv_age_at_high_issue = NULL                                  => -0.0096689788,
                                                                    0.0010578125);

final_score_95_c599 := map(
    NULL < iv_inq_phones_per_adl AND iv_inq_phones_per_adl <= 0.5 => 0.0075874826,
    iv_inq_phones_per_adl > 0.5                                   => -0.0149472508,
    iv_inq_phones_per_adl = NULL                                  => -0.0002910667,
                                                                     -0.0002910667);

final_score_95_c598 := map(
    NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr <= 1692 => final_score_95_c599,
    iv_dist_inp_addr_to_prv_addr > 1692                                          => 0.0398426299,
    iv_dist_inp_addr_to_prv_addr = NULL                                          => 0.0281599920,
                                                                                    0.0023874645);

final_score_95 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 0.5 => final_score_95_c598,
    iv_inq_per_addr > 0.5                             => -0.0097181225,
    iv_inq_per_addr = NULL                            => -0.0183889800,
                                                         -0.0037602688);

final_score_96_c602 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 28925 => 0.0297668169,
    iv_purch_sold_val_diff > 28925                                    => -0.0607633338,
    iv_purch_sold_val_diff = NULL                                     => 0.0078899182,
                                                                         0.0070352991);

final_score_96_c601 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 108.5 => -0.0208211353,
    iv_sr001_m_wp_adl_fs > 108.5                                  => final_score_96_c602,
    iv_sr001_m_wp_adl_fs = NULL                                   => -0.0103686074,
                                                                     -0.0103686074);

final_score_96 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen <= 2.5 => 0.0050881913,
    iv_mos_since_gong_did_lst_seen > 2.5                                            => final_score_96_c601,
    iv_mos_since_gong_did_lst_seen = NULL                                           => -0.0008237354,
                                                                                       -0.0008237354);

final_score_97_c605 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 3413.5 => -0.0135477530,
    iv_inp_addr_building_area > 3413.5                                       => 0.0650885151,
    iv_inp_addr_building_area = NULL                                         => -0.0122285578,
                                                                                -0.0122285578);

final_score_97_c604 := map(
    (iv_ams_file_type in ['-1', 'C']) => final_score_97_c605,
    (iv_ams_file_type in ['A', 'H'])  => 0.0246454027,
    iv_ams_file_type = ''           => 0.0105329304,
                                         -0.0088343119);

final_score_97 := map(
    iv_bst_own_prop_x_addr_naprop <> ' '
		  and NULL < (real)iv_bst_own_prop_x_addr_naprop AND (real)iv_bst_own_prop_x_addr_naprop <= 12.5 => 0.0038997446,
    (real)iv_bst_own_prop_x_addr_naprop > 12.5                                           => final_score_97_c604,
    iv_bst_own_prop_x_addr_naprop = ' '                                           => 0.0039934741,
                                                                                      0.0011286038);

final_score_98_c608 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen <= 117.5 => 0.0213925677,
    iv_mos_since_infutor_first_seen > 117.5                                             => 0.1182405024,
    iv_mos_since_infutor_first_seen = NULL                                              => 0.0567385293,
                                                                                           0.0567385293);

final_score_98_c607 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 286839 => 0.0103867342,
    iv_prop_owned_assessed_total > 286839                                          => final_score_98_c608,
    iv_prop_owned_assessed_total = NULL                                            => 0.0117573787,
                                                                                      0.0117573787);

final_score_98 := map(
    iv_vp091_phnzip_mismatch <> ' '
		  and NULL < (real)iv_vp091_phnzip_mismatch AND (real)iv_vp091_phnzip_mismatch <= 0.5 => -0.0039519049,
    (real)iv_vp091_phnzip_mismatch > 0.5                                      => final_score_98_c607,
    iv_vp091_phnzip_mismatch = ' '                                     => 0.0016467037,
                                                                           0.0006287086);

final_score_99_c611 := map(
    NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen <= 81.5 => -0.0023235889,
    iv_mos_src_bureau_addr_fseen > 81.5                                          => -0.0258003470,
    iv_mos_src_bureau_addr_fseen = NULL                                          => -0.0125062345,
                                                                                    -0.0125062345);

final_score_99_c610 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 99120 => 0.0013609703,
    iv_prop_owned_assessed_total > 99120                                          => final_score_99_c611,
    iv_prop_owned_assessed_total = NULL                                           => -0.0006257011,
                                                                                     -0.0006257011);

final_score_99 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 140.5 => final_score_99_c610,
    iv_mos_since_prop1_sale > 140.5                                     => 0.0205439671,
    iv_mos_since_prop1_sale = NULL                                      => 0.0023690700,
                                                                           0.0002820074);

final_score_100_c614 := map(
    NULL < iv_bst_addr_avm_change_3yr AND iv_bst_addr_avm_change_3yr <= 3827.5 => -0.0077384025,
    iv_bst_addr_avm_change_3yr > 3827.5                                        => 0.0380798246,
    iv_bst_addr_avm_change_3yr = NULL                                          => 0.0155354292,
                                                                                  0.0194339709);

final_score_100_c613 := map(
    NULL < iv_inp_addr_lres AND iv_inp_addr_lres <= 271.5 => 0.0022821939,
    iv_inp_addr_lres > 271.5                              => final_score_100_c614,
    iv_inp_addr_lres = NULL                               => 0.0034367362,
                                                             0.0034367362);

final_score_100 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl <= 1.5 => final_score_100_c613,
    iv_ms001_ssns_per_adl > 1.5                                   => -0.0119599438,
    iv_ms001_ssns_per_adl = NULL                                  => 0.0027968446,
                                                                     -0.0003714339);

final_score_101_c616 := map(
    NULL < iv_max_ids_per_addr AND iv_max_ids_per_addr <= 12.5 => 0.0459677380,
    iv_max_ids_per_addr > 12.5                                 => -0.0169871979,
    iv_max_ids_per_addr = NULL                                 => 0.0185506772,
                                                                  0.0185506772);

final_score_101_c617 := map(
    NULL < iv_liens_rel_ot_ct AND iv_liens_rel_ot_ct <= 1.5 => -0.0006886528,
    iv_liens_rel_ot_ct > 1.5                                => 0.0524614832,
    iv_liens_rel_ot_ct = NULL                               => 0.0056655814,
                                                               0.0005511934);

final_score_101 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= 18587 => -0.0144175429,
    iv_prop1_purch_sale_diff > 18587                                      => final_score_101_c616,
    iv_prop1_purch_sale_diff = NULL                                       => final_score_101_c617,
                                                                             0.0000677714);

final_score_102_c620 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 58155 => 0.0874200434,
    iv_prop_owned_assessed_total > 58155                                          => -0.0024589236,
    iv_prop_owned_assessed_total = NULL                                           => 0.0077318646,
                                                                                     0.0077318646);

final_score_102_c619 := map(
    NULL < iv_pv001_avg_prop_prch_amt AND iv_pv001_avg_prop_prch_amt <= 61950 => -0.0150745394,
    iv_pv001_avg_prop_prch_amt > 61950                                        => final_score_102_c620,
    iv_pv001_avg_prop_prch_amt = NULL                                         => -0.0077506749,
                                                                                 -0.0077506749);

final_score_102 := map(
    iv_bst_own_prop_x_addr_naprop <> ' '
		  and NULL < (real)iv_bst_own_prop_x_addr_naprop AND (real)iv_bst_own_prop_x_addr_naprop <= 11.5 => 0.0038864951,
    (real)iv_bst_own_prop_x_addr_naprop > 11.5                                           => final_score_102_c619,
    iv_bst_own_prop_x_addr_naprop = ' '                                           => -0.0069573921,
                                                                                      0.0010794559);

final_score_103_c623 := map(
    NULL < iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen <= 334 => 0.0126285985,
    iv_mos_since_prv_addr_fseen > 334                                         => 0.0966095448,
    iv_mos_since_prv_addr_fseen = NULL                                        => 0.0149671652,
                                                                                 0.0149671652);

final_score_103_c622 := map(
    NULL < iv_mos_src_bureau_dob_fseen AND iv_mos_src_bureau_dob_fseen <= 387 => final_score_103_c623,
    iv_mos_src_bureau_dob_fseen > 387                                         => 0.1132753560,
    iv_mos_src_bureau_dob_fseen = NULL                                        => 0.0177348990,
                                                                                 0.0177348990);

final_score_103 := map(
    (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed', '3 - BK Other']) => -0.0013301222,
    (iv_db001_bankruptcy in ['1 - BK Discharged'])                             => final_score_103_c622,
    iv_db001_bankruptcy = ''                                                 => -0.0253744666,
                                                                                  0.0002947964);

final_score_104_c626 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 57.5 => 0.0074624559,
    iv_mos_src_property_adl_lseen > 57.5                                           => -0.0314791518,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0025972204,
                                                                                      0.0025972204);

final_score_104_c625 := map(
    (iv_vp100_phn_prob in ['2 Disconnected', '4 Invalid', '5 Cell', '6 Pager', '8 Pay_Phone']) => -0.0252508591,
    (iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '7 PCS'])                        => 0.0013909609,
    iv_vp100_phn_prob = ''                                                                   => final_score_104_c626,
                                                                                                  -0.0003621017);

final_score_104 := map(
    NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen <= 256.5 => final_score_104_c625,
    iv_mos_since_prv_addr_lseen > 256.5                                         => 0.0337709157,
    iv_mos_since_prv_addr_lseen = NULL                                          => 0.0055877219,
                                                                                   0.0002339430);

final_score_105_c628 := map(
    NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen <= -0.5 => -0.0099691839,
    iv_mos_src_bureau_addr_fseen > -0.5                                          => 0.0038498888,
    iv_mos_src_bureau_addr_fseen = NULL                                          => -0.0007412656,
                                                                                    -0.0007412656);

final_score_105_c629 := map(
    iv_infutor_nap <> ' ' 
		  and NULL < (real)iv_infutor_nap AND (real)iv_infutor_nap <= 9.5 => -0.0259050925,
    (real)iv_infutor_nap > 9.5                            => 0.0818944197,
    iv_infutor_nap = ' '                           => -0.0075075043,
                                                       -0.0043214015);

final_score_105 := map(
    NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen <= 285.5 => final_score_105_c628,
    iv_mos_since_prv_addr_lseen > 285.5                                         => 0.0459553154,
    iv_mos_since_prv_addr_lseen = NULL                                          => final_score_105_c629,
                                                                                   -0.0004819603);

final_score_106_c632 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 4781 => 0.0093169859,
    iv_inp_addr_building_area > 4781                                       => 0.1106247741,
    iv_inp_addr_building_area = NULL                                       => 0.0102321198,
                                                                              0.0102321198);

final_score_106_c631 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= 10.5 => final_score_106_c632,
    iv_mos_src_voter_adl_lseen > 10.5                                        => -0.0080486136,
    iv_mos_src_voter_adl_lseen = NULL                                        => 0.0017998520,
                                                                                0.0017998520);

final_score_106 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= -0.5 => -0.0104254259,
    iv_mos_src_voter_adl_lseen > -0.5                                        => final_score_106_c631,
    iv_mos_src_voter_adl_lseen = NULL                                        => -0.0051390346,
                                                                                -0.0024223620);

final_score_107_c634 := map(
    NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs <= 339.5 => -0.0031666429,
    iv_sr001_m_bureau_adl_fs > 339.5                                      => 0.0167551880,
    iv_sr001_m_bureau_adl_fs = NULL                                       => -0.0052664263,
                                                                             0.0017975395);

final_score_107_c635 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 107.5 => -0.0275967195,
    iv_mos_since_gong_did_fst_seen > 107.5                                            => 0.0005064535,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0138174589,
                                                                                         -0.0138174589);

final_score_107 := map(
    iv_infutor_nap <> ' ' 
		  and NULL < (real)iv_infutor_nap AND (real)iv_infutor_nap <= 11.5 => final_score_107_c634,
    (real)iv_infutor_nap > 11.5                            => final_score_107_c635,
    iv_infutor_nap = ' '                            => -0.0015447863,
                                                        -0.0012751406);

final_score_108_c637 := map(
    iv_inp_addr_mortgage_term <> '  ' 
		  and NULL < (real)iv_inp_addr_mortgage_term AND (real)iv_inp_addr_mortgage_term <= 7.5 => -0.0030115182,
    (real)iv_inp_addr_mortgage_term > 7.5                                       => 0.0096713792,
    iv_inp_addr_mortgage_term = '  '                                      => -0.0002816987,
                                                                             -0.0002816987);

final_score_108_c638 := map(
    (iv_fname_eda_sourced_type in ['-1', 'A']) => -0.0327388929,
    (iv_fname_eda_sourced_type in ['AP', 'P']) => 0.0776481789,
    iv_fname_eda_sourced_type = ''           => -0.0144554232,
                                                  -0.0142641791);

final_score_108 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 174.5 => final_score_108_c637,
    iv_sr001_m_wp_adl_fs > 174.5                                  => -0.0799899720,
    iv_sr001_m_wp_adl_fs = NULL                                   => final_score_108_c638,
                                                                     -0.0009895256);

final_score_109_c641 := map(
    iv_inp_own_prop_x_addr_naprop <> '  '
		  and NULL < (real)iv_inp_own_prop_x_addr_naprop AND (real)iv_inp_own_prop_x_addr_naprop <= 12.5 => 0.0258797362,
    (real)iv_inp_own_prop_x_addr_naprop > 12.5                                           => -0.0003077483,
    iv_inp_own_prop_x_addr_naprop = '  '                                           => 0.0134225527,
                                                                                      0.0134225527);

final_score_109_c640 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 57.5 => -0.0040445885,
    iv_pl001_m_snc_prop_adl_fs > 57.5                                        => final_score_109_c641,
    iv_pl001_m_snc_prop_adl_fs = NULL                                        => 0.0013613275,
                                                                                0.0013613275);

final_score_109 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 69.5 => final_score_109_c640,
    iv_mos_src_property_adl_lseen > 69.5                                           => -0.0102286227,
    iv_mos_src_property_adl_lseen = NULL                                           => -0.0048401168,
                                                                                      -0.0012982439);

final_score_110_c644 := map(
    (iv_lname_eda_sourced_type in ['-1', 'A', 'AP']) => -0.0032964755,
    (iv_lname_eda_sourced_type in ['P'])             => 0.0202770502,
    iv_lname_eda_sourced_type = ''                 => -0.0009087534,
                                                        -0.0009087534);

final_score_110_c643 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 12.5 => final_score_110_c644,
    iv_addrs_per_adl > 12.5                              => -0.0315945118,
    iv_addrs_per_adl = NULL                              => -0.0044518182,
                                                            -0.0044518182);

final_score_110 := map(
    NULL < iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count <= 1.5 => final_score_110_c643,
    iv_addr_lres_12mo_count > 1.5                                     => 0.0106846367,
    iv_addr_lres_12mo_count = NULL                                    => -0.0056840499,
                                                                         -0.0007458834);

final_score_111_c647 := map(
    NULL < iv_bst_addr_avm_change_3yr AND iv_bst_addr_avm_change_3yr <= 36859 => 0.0059257324,
    iv_bst_addr_avm_change_3yr > 36859                                        => -0.0186585975,
    iv_bst_addr_avm_change_3yr = NULL                                         => -0.0019347323,
                                                                                 -0.0003679730);

final_score_111_c646 := map(
    (iv_vp100_phn_prob in ['2 Disconnected', '6 Pager', '7 PCS', '8 Pay_Phone'])      => -0.0272048074,
    (iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '4 Invalid', '5 Cell']) => final_score_111_c647,
    iv_vp100_phn_prob = ''                                                          => -0.0012602559,
                                                                                         -0.0024580454);

final_score_111 := map(
    NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count <= 1.5 => final_score_111_c646,
    iv_paw_active_phone_count > 1.5                                       => 0.0417195271,
    iv_paw_active_phone_count = NULL                                      => -0.0033295168,
                                                                             -0.0021602749);

final_score_112_c649 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 148.5 => -0.0002027691,
    iv_sr001_m_wp_adl_fs > 148.5                                  => -0.0352896969,
    iv_sr001_m_wp_adl_fs = NULL                                   => -0.0010103162,
                                                                     -0.0010103162);

final_score_112_c650 := map(
    NULL < iv_inp_addr_fips_ratio AND iv_inp_addr_fips_ratio <= 0.7661607417 => 0.0027406731,
    iv_inp_addr_fips_ratio > 0.7661607417                                    => 0.1448177961,
    iv_inp_addr_fips_ratio = NULL                                            => 0.0658251099,
                                                                                0.0658251099);

final_score_112 := map(
    (iv_ams_college_major in ['Liberal Arts', 'Medical', 'No AMS Found', 'No College Found', 'Science', 'Unclassified']) => final_score_112_c649,
    (iv_ams_college_major in ['Business'])                                                                               => final_score_112_c650,
    iv_ams_college_major = ''                                                                                          => 0.0019696717,
                                                                                                                            -0.0005695960);

final_score_113_c653 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn <= 3.5 => 0.0036466409,
    iv_inq_per_ssn > 3.5                            => -0.0239548395,
    iv_inq_per_ssn = NULL                           => -0.0203001658,
                                                       0.0007863538);

final_score_113_c652 := map(
    (iv_db001_bankruptcy in ['2 - BK Dismissed', '3 - BK Other']) => -0.0357932755,
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged'])   => final_score_113_c653,
    iv_db001_bankruptcy = ''                                    => -0.0001951791,
                                                                     -0.0001951791);

final_score_113 := map(
    NULL < iv_pl001_bst_addr_lres AND iv_pl001_bst_addr_lres <= 409.5 => final_score_113_c652,
    iv_pl001_bst_addr_lres > 409.5                                    => -0.0578456031,
    iv_pl001_bst_addr_lres = NULL                                     => 0.0002967204,
                                                                         -0.0003775663);

final_score_114_c656 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr <= -109 => 0.1502871272,
    iv_inp_addr_avm_change_3yr > -109                                        => 0.0129858606,
    iv_inp_addr_avm_change_3yr = NULL                                        => 0.0164285178,
                                                                                0.0164285178);

final_score_114_c655 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr <= -1411.5 => -0.0192432713,
    iv_inp_addr_avm_change_3yr > -1411.5                                        => final_score_114_c656,
    iv_inp_addr_avm_change_3yr = NULL                                           => 0.0087056437,
                                                                                   0.0086321919);

final_score_114 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 107.5 => -0.0030606508,
    iv_mos_since_gong_did_fst_seen > 107.5                                            => final_score_114_c655,
    iv_mos_since_gong_did_fst_seen = NULL                                             => 0.0049709405,
                                                                                         0.0008316175);

final_score_115_c659 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 102.5 => 0.0251552732,
    iv_mos_src_bureau_lname_fseen > 102.5                                           => -0.0036778387,
    iv_mos_src_bureau_lname_fseen = NULL                                            => 0.0006329680,
                                                                                       0.0006329680);

final_score_115_c658 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 0.82163095235 => -0.0264275817,
    iv_inp_addr_avm_pct_change_1yr > 0.82163095235                                            => final_score_115_c659,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                     => 0.0001177853,
                                                                                                 -0.0012799773);

final_score_115 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 7.5 => 0.0549917471,
    iv_pl002_avg_mo_per_addr > 7.5                                      => final_score_115_c658,
    iv_pl002_avg_mo_per_addr = NULL                                     => 0.0108675693,
                                                                           -0.0000633002);

final_score_116_c662 := map(
    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen <= 3.5 => 0.0700778323,
    iv_mos_since_infutor_last_seen > 3.5                                            => -0.0158267326,
    iv_mos_since_infutor_last_seen = NULL                                           => 0.0228750636,
                                                                                       0.0228750636);

final_score_116_c661 := map(
    NULL < iv_inp_addr_fips_ratio AND iv_inp_addr_fips_ratio <= 0.98237254415 => final_score_116_c662,
    iv_inp_addr_fips_ratio > 0.98237254415                                    => 0.1340451063,
    iv_inp_addr_fips_ratio = NULL                                             => 0.0441496308,
                                                                                 0.0441496308);

final_score_116 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 342.5 => 0.0000323279,
    iv_prv_addr_lres > 342.5                              => final_score_116_c661,
    iv_prv_addr_lres = NULL                               => -0.0024087024,
                                                             0.0004736890);

final_score_117_c664 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 78.5 => 0.0019685221,
    iv_pl002_avg_mo_per_addr > 78.5                                      => -0.0129309592,
    iv_pl002_avg_mo_per_addr = NULL                                      => -0.0016466981,
                                                                            -0.0016466981);

final_score_117_c665 := map(
    (iv_fname_eda_sourced_type in ['A'])             => -0.0527287994,
    (iv_fname_eda_sourced_type in ['-1', 'AP', 'P']) => 0.0133243307,
    iv_fname_eda_sourced_type = ''                 => 0.0112453848,
                                                        0.0112453848);

final_score_117 := map(
    NULL < iv_attr_addrs_recency AND iv_attr_addrs_recency <= 589.5 => final_score_117_c664,
    iv_attr_addrs_recency > 589.5                                   => final_score_117_c665,
    iv_attr_addrs_recency = NULL                                    => -0.0023821074,
                                                                       -0.0004058884);

final_score_118_c668 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 77630 => -0.0095774906,
    iv_avg_prop_assess_purch_amt > 77630                                          => -0.0305660861,
    iv_avg_prop_assess_purch_amt = NULL                                           => -0.0131985406,
                                                                                     -0.0131985406);

final_score_118_c667 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income <= 88500 => final_score_118_c668,
    iv_in001_estimated_income > 88500                                       => 0.0529143678,
    iv_in001_estimated_income = NULL                                        => -0.0120430613,
                                                                               -0.0120430613);

final_score_118 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct <= 1.5 => 0.0037938905,
    iv_gong_did_phone_ct > 1.5                                  => final_score_118_c667,
    iv_gong_did_phone_ct = NULL                                 => 0.0069177872,
                                                                   0.0006801058);

final_score_119_c671 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count <= 1.5 => 0.1173513930,
    iv_inp_addr_source_count > 1.5                                      => 0.0143934992,
    iv_inp_addr_source_count = NULL                                     => 0.0349640876,
                                                                           0.0349640876);

final_score_119_c670 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 127.5 => 0.0018371913,
    iv_mos_since_prop1_sale > 127.5                                     => final_score_119_c671,
    iv_mos_since_prop1_sale = NULL                                      => 0.0027519177,
                                                                           0.0027519177);

final_score_119 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 65.5 => final_score_119_c670,
    iv_mos_src_property_adl_lseen > 65.5                                           => -0.0099173219,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0026133617,
                                                                                      -0.0000812903);

final_score_120_c674 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 470.5 => 0.0672547042,
    iv_mos_src_bureau_lname_fseen > 470.5                                           => -0.0656612808,
    iv_mos_src_bureau_lname_fseen = NULL                                            => -0.0014506600,
                                                                                       -0.0014506600);

final_score_120_c673 := map(
    NULL < iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen <= 173.5 => final_score_120_c674,
    iv_mos_since_prv_addr_fseen > 173.5                                         => 0.0843948045,
    iv_mos_since_prv_addr_fseen = NULL                                          => 0.0437311634,
                                                                                   0.0437311634);

final_score_120 := map(
    NULL < iv_mos_src_bureau_dob_fseen AND iv_mos_src_bureau_dob_fseen <= 424.5 => 0.0007642813,
    iv_mos_src_bureau_dob_fseen > 424.5                                         => final_score_120_c673,
    iv_mos_src_bureau_dob_fseen = NULL                                          => 0.0014872152,
                                                                                   0.0011790923);

final_score_121_c677 := map(
    iv_prof_license_category <> ' ' 
		  and NULL < (real)iv_prof_license_category AND (real)iv_prof_license_category <= -0.5 => 0.0025154767,
    iv_prof_license_category <> ' ' 
		  and (real)iv_prof_license_category > -0.5                                      => 0.0258508134,
    iv_prof_license_category = ' '                                      => -0.0030979641,
                                                                            0.0037160677);

final_score_121_c676 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= 3050 => -0.0163401014,
    iv_prop1_purch_sale_diff > 3050                                      => 0.0198905203,
    iv_prop1_purch_sale_diff = NULL                                      => final_score_121_c677,
                                                                            0.0032819582);

final_score_121 := map(
    NULL < iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr <= 22.5 => final_score_121_c676,
    iv_max_ids_per_sfd_addr > 22.5                                     => -0.0147669019,
    iv_max_ids_per_sfd_addr = NULL                                     => -0.0108086236,
                                                                          -0.0002592103);

final_score_122_c680 := map(
    iv_vp091_phnzip_mismatch <> ' '
		  and NULL < (real)iv_vp091_phnzip_mismatch AND (real)iv_vp091_phnzip_mismatch <= 0.5 => -0.0025570020,
    (real)iv_vp091_phnzip_mismatch > 0.5                                      => 0.0222389877,
    iv_vp091_phnzip_mismatch = ' '                                     => 0.0014090969,
                                                                           0.0024363958);

final_score_122_c679 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 12.5 => final_score_122_c680,
    iv_addrs_per_adl > 12.5                              => -0.0160757849,
    iv_addrs_per_adl = NULL                              => -0.0014035176,
                                                            -0.0014035176);

final_score_122 := map(
    NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr <= 492.5 => final_score_122_c679,
    iv_dist_inp_addr_to_prv_addr > 492.5                                          => 0.0164430970,
    iv_dist_inp_addr_to_prv_addr = NULL                                           => 0.0081944887,
                                                                                     0.0005496763);

final_score_123_c682 := map(
    NULL < iv_paw_dead_business_count AND iv_paw_dead_business_count <= 0.5 => 0.0038175952,
    iv_paw_dead_business_count > 0.5                                        => -0.0553711183,
    iv_paw_dead_business_count = NULL                                       => 0.0029716022,
                                                                               0.0029716022);

final_score_123_c683 := map(
    NULL < iv_liens_rel_ot_ct AND iv_liens_rel_ot_ct <= 1.5 => -0.0138280072,
    iv_liens_rel_ot_ct > 1.5                                => 0.0847002037,
    iv_liens_rel_ot_ct = NULL                               => -0.0112699045,
                                                               -0.0112699045);

final_score_123 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct <= 1.5 => final_score_123_c682,
    iv_gong_did_phone_ct > 1.5                                  => final_score_123_c683,
    iv_gong_did_phone_ct = NULL                                 => 0.0002518969,
                                                                   0.0000245928);

final_score_124_c686 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr <= 14943.5 => 0.1623687891,
    iv_inp_addr_avm_change_3yr > 14943.5                                        => 0.0297739199,
    iv_inp_addr_avm_change_3yr = NULL                                           => 0.0279850731,
                                                                                   0.0580855738);

final_score_124_c685 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 1.5 => final_score_124_c686,
    iv_inq_per_addr > 1.5                             => -0.0295999794,
    iv_inq_per_addr = NULL                            => 0.0298218809,
                                                         0.0298218809);

final_score_124 := map(
    NULL < iv_liens_rel_ot_ct AND iv_liens_rel_ot_ct <= 1.5 => -0.0015467825,
    iv_liens_rel_ot_ct > 1.5                                => final_score_124_c685,
    iv_liens_rel_ot_ct = NULL                               => 0.0041211330,
                                                               -0.0007247265);

final_score_125_c689 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 89.35 => -0.0069479656,
    iv_sr001_source_profile > 89.35                                     => 0.0937631712,
    iv_sr001_source_profile = NULL                                      => -0.0046975218,
                                                                           -0.0046975218);

final_score_125_c688 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 90605 => final_score_125_c689,
    iv_avg_prop_assess_purch_amt > 90605                                          => -0.0301053758,
    iv_avg_prop_assess_purch_amt = NULL                                           => -0.0102274490,
                                                                                     -0.0102274490);

final_score_125 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 85.5 => 0.0016202865,
    iv_mos_src_property_adl_lseen > 85.5                                           => final_score_125_c688,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0026875278,
                                                                                      -0.0004935801);

final_score_126_c691 := map(
    (iv_inp_addr_financing_type in ['ADJ', 'OTH'])  => -0.0301382163,
    (iv_inp_addr_financing_type in ['CNV', 'NONE']) => -0.0032377996,
    iv_inp_addr_financing_type = ''               => -0.0043559182,
                                                       -0.0043559182);

final_score_126_c692 := map(
    NULL < iv_bst_addr_source_count AND iv_bst_addr_source_count <= 6.5 => 0.0088136134,
    iv_bst_addr_source_count > 6.5                                      => -0.0383370744,
    iv_bst_addr_source_count = NULL                                     => 0.0074407234,
                                                                           0.0074407234);

final_score_126 := map(
    NULL < iv_prv_addr_source_count AND iv_prv_addr_source_count <= 2.5 => final_score_126_c691,
    iv_prv_addr_source_count > 2.5                                      => final_score_126_c692,
    iv_prv_addr_source_count = NULL                                     => -0.0045590879,
                                                                           -0.0006444749);

final_score_127_c694 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff <= 72850 => 0.0602985137,
    iv_prop2_purch_sale_diff > 72850                                      => -0.0330709018,
    iv_prop2_purch_sale_diff = NULL                                       => 0.0351510178,
                                                                             0.0351510178);

final_score_127_c695 := map(
    NULL < iv_po001_m_snc_veh_adl_fs AND iv_po001_m_snc_veh_adl_fs <= 145.5 => 0.0012386421,
    iv_po001_m_snc_veh_adl_fs > 145.5                                       => -0.0255398281,
    iv_po001_m_snc_veh_adl_fs = NULL                                        => 0.0084819140,
                                                                               0.0007300898);

final_score_127 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff <= 13787.5 => -0.0346745360,
    iv_prop2_purch_sale_diff > 13787.5                                      => final_score_127_c694,
    iv_prop2_purch_sale_diff = NULL                                         => final_score_127_c695,
                                                                               0.0007417757);

final_score_128_c698 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 119961.5 => 0.0084101260,
    iv_inp_addr_assessed_total_val > 119961.5                                            => -0.0425132106,
    iv_inp_addr_assessed_total_val = NULL                                                => 0.0045588898,
                                                                                            0.0045588898);

final_score_128_c697 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 64614.5 => -0.0116753967,
    iv_pv001_inp_avm_autoval > 64614.5                                      => final_score_128_c698,
    iv_pv001_inp_avm_autoval = NULL                                         => -0.0060700251,
                                                                               -0.0060700251);

final_score_128 := map(
    NULL < iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count <= 1.5 => final_score_128_c697,
    iv_addr_lres_12mo_count > 1.5                                     => 0.0099772779,
    iv_addr_lres_12mo_count = NULL                                    => 0.0035725204,
                                                                         -0.0018229077);

final_score_129_c701 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 1.1859967053 => -0.0263854257,
    iv_bst_addr_mtg_avm_pct_diff > 1.1859967053                                          => 0.0448830316,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                  => 0.0223030183,
                                                                                            0.0214207953);

final_score_129_c700 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn <= 4.5 => final_score_129_c701,
    iv_inq_per_ssn > 4.5                            => -0.0685687319,
    iv_inq_per_ssn = NULL                           => 0.0172949779,
                                                       0.0172949779);

final_score_129 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 2555.5 => -0.0014815068,
    iv_bst_addr_building_area > 2555.5                                       => final_score_129_c700,
    iv_bst_addr_building_area = NULL                                         => 0.0049476392,
                                                                                -0.0003927433);

final_score_130_c704 := map(
    NULL < iv_ssns_per_addr AND iv_ssns_per_addr <= 3.5 => -0.0089337801,
    iv_ssns_per_addr > 3.5                              => -0.0908568905,
    iv_ssns_per_addr = NULL                             => -0.0565020377,
                                                           -0.0565020377);

final_score_130_c703 := map(
    NULL < iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr <= 11.5 => final_score_130_c704,
    iv_adls_per_sfd_addr > 11.5                                  => 0.0107987294,
    iv_adls_per_sfd_addr = NULL                                  => -0.0321076723,
                                                                    -0.0321076723);

final_score_130 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 301800 => 0.0006455280,
    iv_avg_prop_assess_purch_amt > 301800                                          => final_score_130_c703,
    iv_avg_prop_assess_purch_amt = NULL                                            => 0.0072366218,
                                                                                      0.0004325881);

final_score_131_c707 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 144430 => 0.0110196132,
    iv_purch_sold_assess_val_diff > 144430                                           => -0.0663018939,
    iv_purch_sold_assess_val_diff = NULL                                             => 0.0197925149,
                                                                                        0.0071736160);

final_score_131_c706 := map(
    (iv_vp100_phn_prob in ['2 Disconnected', '4 Invalid', '5 Cell', '8 Pay_Phone']) => -0.0913122927,
    (iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '6 Pager', '7 PCS'])  => final_score_131_c707,
    iv_vp100_phn_prob = ''                                                        => -0.0309938674,
                                                                                       -0.0048025990);

final_score_131 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 197250 => final_score_131_c706,
    iv_purch_sold_val_diff > 197250                                    => 0.0613010803,
    iv_purch_sold_val_diff = NULL                                      => 0.0005923570,
                                                                          0.0005550229);

final_score_132_c710 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 86629.5 => -0.0381115723,
    iv_pv001_inp_avm_autoval > 86629.5                                      => 0.0833963681,
    iv_pv001_inp_avm_autoval = NULL                                         => -0.0087556623,
                                                                               -0.0087556623);

final_score_132_c709 := map(
    NULL < (real)iv_prv_own_prop_x_addr_naprop AND (real)iv_prv_own_prop_x_addr_naprop <= 2.5 => final_score_132_c710,
    (real)iv_prv_own_prop_x_addr_naprop > 2.5                                           => 0.0835044847,
    (real)iv_prv_own_prop_x_addr_naprop = NULL                                          => 0.0271298634,
                                                                                     0.0271298634);

final_score_132 := map(
    iv_ams_college_tier <> '  ' 
		  and NULL < (real)iv_ams_college_tier AND (real)iv_ams_college_tier <= 5.5 => -0.0017334698,
    (real)iv_ams_college_tier > 5.5                                 => final_score_132_c709,
    iv_ams_college_tier = '  '                                => 0.0004245060,
                                                                 -0.0012053579);

final_score_133_c713 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 85860 => 0.0031688366,
    iv_inp_addr_assessed_total_val > 85860                                            => -0.0278682473,
    iv_inp_addr_assessed_total_val = NULL                                             => 0.0002165628,
                                                                                         0.0002165628);

final_score_133_c712 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 2.3307169811 => final_score_133_c713,
    iv_inp_addr_avm_pct_change_1yr > 2.3307169811                                            => -0.0594810578,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                    => 0.0027756561,
                                                                                                0.0009169686);

final_score_133 := map(
    NULL < iv_inq_num_diff_names_per_adl AND iv_inq_num_diff_names_per_adl <= 1.5 => final_score_133_c712,
    iv_inq_num_diff_names_per_adl > 1.5                                           => -0.0280904197,
    iv_inq_num_diff_names_per_adl = NULL                                          => -0.0009129828,
                                                                                     -0.0013339266);

final_score_134_c716 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= 5250 => 0.0952705009,
    iv_prop1_purch_sale_diff > 5250                                      => -0.0390533768,
    iv_prop1_purch_sale_diff = NULL                                      => 0.0245564179,
                                                                            0.0252773618);

final_score_134_c715 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn <= 2.5 => final_score_134_c716,
    iv_inq_per_ssn > 2.5                            => -0.0270736867,
    iv_inq_per_ssn = NULL                           => 0.0185121180,
                                                       0.0185121180);

final_score_134 := map(
    NULL < iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen <= 2.5 => -0.0011750003,
    iv_mos_since_paw_first_seen > 2.5                                         => final_score_134_c715,
    iv_mos_since_paw_first_seen = NULL                                        => -0.0079728628,
                                                                                 -0.0002419846);

final_score_135_c719 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 1.05964635105 => 0.0786862667,
    iv_inp_addr_avm_pct_change_1yr > 1.05964635105                                            => -0.0061344926,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                     => 0.0158552810,
                                                                                                 0.0035917890);

final_score_135_c718 := map(
    NULL < iv_pv001_bst_avm_chg_1yr AND iv_pv001_bst_avm_chg_1yr <= 6395 => -0.0263021983,
    iv_pv001_bst_avm_chg_1yr > 6395                                      => final_score_135_c719,
    iv_pv001_bst_avm_chg_1yr = NULL                                      => -0.0002216604,
                                                                            -0.0072898759);

final_score_135 := map(
    NULL < iv_age_at_high_issue AND iv_age_at_high_issue <= 16.5 => 0.0041263127,
    iv_age_at_high_issue > 16.5                                  => final_score_135_c718,
    iv_age_at_high_issue = NULL                                  => -0.0140909375,
                                                                    0.0010548740);

final_score_136_c721 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 8055 => -0.0425144672,
    iv_purch_sold_assess_val_diff > 8055                                           => 0.0032304520,
    iv_purch_sold_assess_val_diff = NULL                                           => -0.0040632931,
                                                                                      -0.0050854845);

final_score_136_c722 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= 23700 => -0.0267562495,
    iv_prop1_purch_sale_diff > 23700                                      => 0.1020503476,
    iv_prop1_purch_sale_diff = NULL                                       => 0.0127283649,
                                                                             0.0114659367);

final_score_136 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 1.1105546875 => final_score_136_c721,
    iv_inp_addr_avm_pct_change_1yr > 1.1105546875                                            => final_score_136_c722,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                    => 0.0007395381,
                                                                                                0.0003745286);

final_score_137_c725 := map(
    NULL < iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen <= 212.5 => 0.0072726938,
    iv_mos_since_prv_addr_fseen > 212.5                                         => 0.0402518914,
    iv_mos_since_prv_addr_fseen = NULL                                          => 0.0110003795,
                                                                                   0.0110003795);

final_score_137_c724 := map(
    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val <= 95610 => final_score_137_c725,
    iv_prv_addr_assessed_total_val > 95610                                            => -0.0357959511,
    iv_prv_addr_assessed_total_val = NULL                                             => 0.0078537296,
                                                                                         0.0078537296);

final_score_137 := map(
    NULL < iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count <= 1.5 => -0.0037272461,
    iv_addr_lres_12mo_count > 1.5                                     => final_score_137_c724,
    iv_addr_lres_12mo_count = NULL                                    => 0.0010040254,
                                                                         -0.0007663136);

final_score_138_c728 := map(
    NULL < iv_dist_bst_addr_to_prv_addr AND iv_dist_bst_addr_to_prv_addr <= 5.5 => 0.0140392923,
    iv_dist_bst_addr_to_prv_addr > 5.5                                          => -0.0888555705,
    iv_dist_bst_addr_to_prv_addr = NULL                                         => -0.0350696195,
                                                                                   -0.0350696195);

final_score_138_c727 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.11961601895 => 0.0291386072,
    iv_inp_addr_avm_pct_change_3yr > 1.11961601895                                            => -0.0647968199,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                     => final_score_138_c728,
                                                                                                 -0.0251182937);

final_score_138 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 104495 => 0.0051578868,
    iv_purch_sold_assess_val_diff > 104495                                           => final_score_138_c727,
    iv_purch_sold_assess_val_diff = NULL                                             => -0.0001443177,
                                                                                        -0.0001931938);

final_score_139_c731 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 1613.5 => 0.0038752562,
    iv_bst_addr_building_area > 1613.5                                       => 0.0310960359,
    iv_bst_addr_building_area = NULL                                         => 0.0088115004,
                                                                                0.0088115004);

final_score_139_c730 := map(
    iv_bst_own_prop_x_addr_naprop <> ' '
		  and NULL < (real)iv_bst_own_prop_x_addr_naprop AND (real)iv_bst_own_prop_x_addr_naprop <= 11.5 => final_score_139_c731,
    (real)iv_bst_own_prop_x_addr_naprop > 11.5                                           => -0.0046796071,
    iv_bst_own_prop_x_addr_naprop = ' '                                           => 0.0048265781,
                                                                                      0.0048265781);

final_score_139 := map(
    NULL < iv_hist_addr_match AND iv_hist_addr_match <= 0.5 => -0.0116623545,
    iv_hist_addr_match > 0.5                                => final_score_139_c730,
    iv_hist_addr_match = NULL                               => -0.0012779246,
                                                               -0.0000827378);

final_score_140_c734 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 81470 => 0.0210121861,
    iv_prop_owned_assessed_total > 81470                                          => -0.0617679639,
    iv_prop_owned_assessed_total = NULL                                           => -0.0204938275,
                                                                                     -0.0204938275);

final_score_140_c733 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count <= 6.5 => 0.0052188505,
    iv_inp_addr_source_count > 6.5                                      => final_score_140_c734,
    iv_inp_addr_source_count = NULL                                     => 0.0045176492,
                                                                           0.0045176492);

final_score_140 := map(
    NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr <= 3.5 => -0.0081874284,
    iv_dist_inp_addr_to_prv_addr > 3.5                                          => final_score_140_c733,
    iv_dist_inp_addr_to_prv_addr = NULL                                         => -0.0023372605,
                                                                                   -0.0009934188);

final_score_141_c737 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= -21966.5 => -0.0398260435,
    iv_prop1_purch_sale_diff > -21966.5                                      => 0.0425569505,
    iv_prop1_purch_sale_diff = NULL                                          => 0.0123549076,
                                                                                0.0150535874);

final_score_141_c736 := map(
    NULL < iv_ag001_age AND iv_ag001_age <= 52.5 => final_score_141_c737,
    iv_ag001_age > 52.5                          => -0.0192696393,
    iv_ag001_age = NULL                          => -0.0021568797,
                                                    -0.0021568797);

final_score_141 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 105546.5 => final_score_141_c736,
    iv_purch_sold_assess_val_diff > 105546.5                                           => -0.0292603175,
    iv_purch_sold_assess_val_diff = NULL                                               => -0.0002168914,
                                                                                          -0.0006883367);

final_score_142_c740 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= 18750 => -0.0063793135,
    iv_prop1_purch_sale_diff > 18750                                      => 0.0975663158,
    iv_prop1_purch_sale_diff = NULL                                       => 0.0090961127,
                                                                             0.0096139651);

final_score_142_c739 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 111.55 => -0.0051453234,
    iv_pv001_bst_avm_chg_1yr_pct > 111.55                                          => final_score_142_c740,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                            => 0.0010714692,
                                                                                      0.0001622695);

final_score_142 := map(
    NULL < iv_avg_prop_sold_assess_amt AND iv_avg_prop_sold_assess_amt <= 346650 => final_score_142_c739,
    iv_avg_prop_sold_assess_amt > 346650                                         => 0.0678549744,
    iv_avg_prop_sold_assess_amt = NULL                                           => 0.0049892634,
                                                                                    0.0003811968);

final_score_143_c743 := map(
    (iv_lname_eda_sourced_type in ['-1', 'A', 'AP']) => 0.0096785974,
    (iv_lname_eda_sourced_type in ['P'])             => 0.0583675835,
    iv_lname_eda_sourced_type = ''                 => 0.0164808761,
                                                        0.0164808761);

final_score_143_c742 := map(
    NULL < iv_mos_src_bankruptcy_adl_lseen AND iv_mos_src_bankruptcy_adl_lseen <= 57.5 => final_score_143_c743,
    iv_mos_src_bankruptcy_adl_lseen > 57.5                                             => -0.0642616321,
    iv_mos_src_bankruptcy_adl_lseen = NULL                                             => 0.0125381642,
                                                                                          0.0125381642);

final_score_143 := map(
    NULL < iv_prv_addr_mortgage_amount AND iv_prv_addr_mortgage_amount <= 73661.5 => -0.0021295639,
    iv_prv_addr_mortgage_amount > 73661.5                                         => final_score_143_c742,
    iv_prv_addr_mortgage_amount = NULL                                            => -0.0009230741,
                                                                                     -0.0004401951);

final_score_144_c746 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 0.93215970225 => -0.0344927312,
    iv_bst_addr_avm_pct_change_3yr > 0.93215970225                                            => 0.0262874093,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                     => 0.0320540254,
                                                                                                 0.0189783614);

final_score_144_c745 := map(
    NULL < iv_inp_addr_lres AND iv_inp_addr_lres <= 295.5 => 0.0008354303,
    iv_inp_addr_lres > 295.5                              => final_score_144_c746,
    iv_inp_addr_lres = NULL                               => 0.0017658235,
                                                             0.0017658235);

final_score_144 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl <= 1.5 => final_score_144_c745,
    iv_ms001_ssns_per_adl > 1.5                                   => -0.0114503592,
    iv_ms001_ssns_per_adl = NULL                                  => 0.0034855355,
                                                                     -0.0014585083);

final_score_145_c749 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 22.5 => 0.0141787405,
    iv_mos_src_property_adl_lseen > 22.5                                           => -0.0231792410,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0058517663,
                                                                                      0.0058517663);

final_score_145_c748 := map(
    (iv_vp100_phn_prob in ['2 Disconnected', '4 Invalid', '6 Pager', '8 Pay_Phone']) => -0.0248547926,
    (iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '5 Cell', '7 PCS'])    => 0.0048379507,
    iv_vp100_phn_prob = ''                                                         => final_score_145_c749,
                                                                                        0.0032426612);

final_score_145 := map(
    NULL < iv_hist_addr_match AND iv_hist_addr_match <= 0.5 => -0.0111586346,
    iv_hist_addr_match > 0.5                                => final_score_145_c748,
    iv_hist_addr_match = NULL                               => 0.0002724741,
                                                               -0.0009907226);

final_score_146_c751 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income <= 62500 => -0.0042636206,
    iv_in001_estimated_income > 62500                                       => -0.0258251574,
    iv_in001_estimated_income = NULL                                        => -0.0052186092,
                                                                               -0.0052186092);

final_score_146_c752 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 10.5 => 0.0061034520,
    iv_src_property_adl_count > 10.5                                       => 0.0781602711,
    iv_src_property_adl_count = NULL                                       => 0.0068912175,
                                                                              0.0068912175);

final_score_146 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 106.5 => final_score_146_c751,
    iv_mos_since_gong_did_fst_seen > 106.5                                            => final_score_146_c752,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0006868652,
                                                                                         -0.0012165987);

final_score_147_c755 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 107.5 => -0.0327301637,
    iv_mos_since_gong_did_fst_seen > 107.5                                            => 0.0732776467,
    iv_mos_since_gong_did_fst_seen = NULL                                             => 0.0158972722,
                                                                                         0.0158972722);

final_score_147_c754 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 319 => final_score_147_c755,
    iv_mos_src_bureau_lname_fseen > 319                                           => -0.0658893295,
    iv_mos_src_bureau_lname_fseen = NULL                                          => -0.0204059643,
                                                                                     -0.0204059643);

final_score_147 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= -84950 => final_score_147_c754,
    iv_purch_sold_val_diff > -84950                                    => 0.0204510236,
    iv_purch_sold_val_diff = NULL                                      => -0.0007028127,
                                                                          -0.0002578752);

final_score_148_c758 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count <= 6.5 => -0.0115556202,
    iv_inp_addr_source_count > 6.5                                      => -0.0845680087,
    iv_inp_addr_source_count = NULL                                     => -0.0144033882,
                                                                           -0.0144033882);

final_score_148_c757 := map(
    NULL < iv_combined_age AND iv_combined_age <= 67.5 => 0.0043584560,
    iv_combined_age > 67.5                             => final_score_148_c758,
    iv_combined_age = NULL                             => 0.0029671928,
                                                          0.0029671928);

final_score_148 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 148.5 => final_score_148_c757,
    iv_sr001_m_wp_adl_fs > 148.5                                  => -0.0329123102,
    iv_sr001_m_wp_adl_fs = NULL                                   => -0.0000493040,
                                                                     0.0020741190);

final_score_149_c761 := map(
    NULL < iv_age_at_high_issue AND iv_age_at_high_issue <= 21.5 => 0.0061166027,
    iv_age_at_high_issue > 21.5                                  => -0.0490428246,
    iv_age_at_high_issue = NULL                                  => -0.0179746690,
                                                                    0.0038127113);

final_score_149_c760 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 211235.5 => final_score_149_c761,
    iv_pv001_inp_avm_autoval > 211235.5                                      => 0.0308338449,
    iv_pv001_inp_avm_autoval = NULL                                          => 0.0050379437,
                                                                                0.0050379437);

final_score_149 := map(
    NULL < iv_bst_addr_avm_change_3yr AND iv_bst_addr_avm_change_3yr <= 37017 => final_score_149_c760,
    iv_bst_addr_avm_change_3yr > 37017                                        => -0.0119268900,
    iv_bst_addr_avm_change_3yr = NULL                                         => -0.0009173956,
                                                                                 0.0003283166);

final_score_150_c764 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count <= 3.5 => 0.0295724286,
    iv_inp_addr_source_count > 3.5                                      => 0.0880525287,
    iv_inp_addr_source_count = NULL                                     => 0.0425451269,
                                                                           0.0425451269);

final_score_150_c763 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 86.5 => final_score_150_c764,
    iv_pl002_avg_mo_per_addr > 86.5                                      => -0.0303235874,
    iv_pl002_avg_mo_per_addr = NULL                                      => 0.0263742615,
                                                                            0.0263742615);

final_score_150 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 3232.5 => -0.0014684937,
    iv_bst_addr_building_area > 3232.5                                       => final_score_150_c763,
    iv_bst_addr_building_area = NULL                                         => 0.0096984697,
                                                                                -0.0005536614);

final_score_151_c766 := map(
    (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed', '3 - BK Other']) => -0.0013745924,
    (iv_db001_bankruptcy in ['1 - BK Discharged'])                             => 0.0166532832,
    iv_db001_bankruptcy = ''                                                 => 0.0003736409,
                                                                                  0.0003736409);

final_score_151_c767 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 1.05375773645 => -0.0661076492,
    iv_inp_addr_avm_pct_change_1yr > 1.05375773645                                            => -0.0084378958,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                     => -0.0040388423,
                                                                                                 -0.0267062332);

final_score_151 := map(
    NULL < iv_pv001_avg_prop_prch_amt AND iv_pv001_avg_prop_prch_amt <= 212600 => final_score_151_c766,
    iv_pv001_avg_prop_prch_amt > 212600                                        => final_score_151_c767,
    iv_pv001_avg_prop_prch_amt = NULL                                          => 0.0145932154,
                                                                                  0.0001646187);

final_score_152_c769 := map(
    NULL < iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen <= 179.5 => -0.0071934606,
    iv_mos_since_bst_addr_fseen > 179.5                                         => 0.0127510738,
    iv_mos_since_bst_addr_fseen = NULL                                          => 0.0088434586,
                                                                                   -0.0035058623);

final_score_152_c770 := map(
    NULL < iv_prop_owned_purchase_total AND iv_prop_owned_purchase_total <= 96433 => 0.0072797425,
    iv_prop_owned_purchase_total > 96433                                          => 0.0482269864,
    iv_prop_owned_purchase_total = NULL                                           => 0.0105975363,
                                                                                     0.0105975363);

final_score_152 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen <= 132.5 => final_score_152_c769,
    iv_mos_since_infutor_first_seen > 132.5                                             => final_score_152_c770,
    iv_mos_since_infutor_first_seen = NULL                                              => -0.0015029479,
                                                                                           -0.0007752576);

final_score_153_c773 := map(
    NULL < iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr <= 0.5 => 0.0470521274,
    iv_inq_ssns_per_addr > 0.5                                  => 0.0001173260,
    iv_inq_ssns_per_addr = NULL                                 => 0.0270945139,
                                                                   0.0270945139);

final_score_153_c772 := map(
    NULL < iv_liens_unrel_cj_ct AND iv_liens_unrel_cj_ct <= 0.5 => final_score_153_c773,
    iv_liens_unrel_cj_ct > 0.5                                  => -0.0539457279,
    iv_liens_unrel_cj_ct = NULL                                 => 0.0110865649,
                                                                   0.0110865649);

final_score_153 := map(
    (iv_ams_file_type in ['-1', 'C']) => -0.0001501879,
    (iv_ams_file_type in ['A', 'H'])  => final_score_153_c772,
    iv_ams_file_type = ''           => 0.0033489675,
                                         0.0007759063);

final_score_154_c775 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= 137.5 => 0.0055749048,
    iv_mos_src_voter_adl_lseen > 137.5                                        => -0.0588738224,
    iv_mos_src_voter_adl_lseen = NULL                                         => -0.0042733579,
                                                                                 0.0040648786);

final_score_154_c776 := map(
    (iv_lname_eda_sourced_type in ['A', 'AP']) => -0.0280279327,
    (iv_lname_eda_sourced_type in ['-1', 'P']) => -0.0037803556,
    iv_lname_eda_sourced_type = ''           => -0.0065440769,
                                                  -0.0065440769);

final_score_154 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen <= 9.5 => final_score_154_c775,
    iv_mos_since_gong_did_lst_seen > 9.5                                            => final_score_154_c776,
    iv_mos_since_gong_did_lst_seen = NULL                                           => 0.0003555086,
                                                                                       0.0003555086);

final_score_155_c779 := map(
    NULL < iv_addrs_10yr AND iv_addrs_10yr <= 4.5 => -0.0222968421,
    iv_addrs_10yr > 4.5                           => 0.0435650057,
    iv_addrs_10yr = NULL                          => -0.0176351517,
                                                     -0.0176351517);

final_score_155_c778 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 100525 => -0.0029873641,
    iv_avg_prop_assess_purch_amt > 100525                                          => final_score_155_c779,
    iv_avg_prop_assess_purch_amt = NULL                                            => -0.0059392945,
                                                                                      -0.0059392945);

final_score_155 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 111.55 => final_score_155_c778,
    iv_pv001_bst_avm_chg_1yr_pct > 111.55                                          => 0.0050425182,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                            => 0.0022278291,
                                                                                      -0.0001199855);

final_score_156_c782 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 5.5 => 0.1097359596,
    iv_addrs_per_adl > 5.5                              => 0.0292469860,
    iv_addrs_per_adl = NULL                             => 0.0467902018,
                                                           0.0467902018);

final_score_156_c781 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income <= 21500 => -0.0755134691,
    iv_in001_estimated_income > 21500                                       => final_score_156_c782,
    iv_in001_estimated_income = NULL                                        => 0.0325488275,
                                                                               0.0325488275);

final_score_156 := map(
    NULL < iv_pl002_addrs_per_ssn_c6 AND iv_pl002_addrs_per_ssn_c6 <= 0.5 => -0.0006999529,
    iv_pl002_addrs_per_ssn_c6 > 0.5                                       => final_score_156_c781,
    iv_pl002_addrs_per_ssn_c6 = NULL                                      => 0.0057788616,
                                                                             0.0005525617);

final_score_157_c785 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 125135 => 0.0508976874,
    iv_inp_addr_assessed_total_val > 125135                                            => -0.0589072280,
    iv_inp_addr_assessed_total_val = NULL                                              => 0.0348571287,
                                                                                          0.0348571287);

final_score_157_c784 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 200653 => 0.0030171563,
    iv_pv001_inp_avm_autoval > 200653                                      => final_score_157_c785,
    iv_pv001_inp_avm_autoval = NULL                                        => 0.0053697713,
                                                                              0.0053697713);

final_score_157 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 1.12083657025 => final_score_157_c784,
    iv_bst_addr_avm_pct_change_3yr > 1.12083657025                                            => -0.0061988576,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                     => -0.0008126481,
                                                                                                 -0.0008068385);

final_score_158_c788 := map(
    NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen <= 44.5 => -0.0108398367,
    iv_mos_since_prv_addr_lseen > 44.5                                         => -0.0430121025,
    iv_mos_since_prv_addr_lseen = NULL                                         => -0.0185708356,
                                                                                  -0.0185708356);

final_score_158_c787 := map(
    NULL < iv_inq_ssns_per_adl AND iv_inq_ssns_per_adl <= 0.5 => final_score_158_c788,
    iv_inq_ssns_per_adl > 0.5                                 => -0.0008261491,
    iv_inq_ssns_per_adl = NULL                                => -0.0393623399,
                                                                 -0.0049917776);

final_score_158 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 0.5 => 0.0042878277,
    iv_inq_per_addr > 0.5                             => final_score_158_c787,
    iv_inq_per_addr = NULL                            => 0.0243068701,
                                                         -0.0000711778);

final_score_159_c791 := map(
    NULL < iv_mos_since_prop2_sale AND iv_mos_since_prop2_sale <= 117.5 => 0.0984084321,
    iv_mos_since_prop2_sale > 117.5                                     => 0.0032028983,
    iv_mos_since_prop2_sale = NULL                                      => 0.0321660276,
                                                                           0.0321660276);

final_score_159_c790 := map(
    NULL < iv_po001_prop_own_tot AND iv_po001_prop_own_tot <= 1.5 => final_score_159_c791,
    iv_po001_prop_own_tot > 1.5                                   => -0.0414641067,
    iv_po001_prop_own_tot = NULL                                  => 0.0113333114,
                                                                     0.0113333114);

final_score_159 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff <= 4800 => -0.0582757397,
    iv_prop2_purch_sale_diff > 4800                                      => final_score_159_c790,
    iv_prop2_purch_sale_diff = NULL                                      => 0.0007222497,
                                                                            0.0005138697);

final_score_160_c794 := map(
    NULL < iv_bst_addr_mortgage_amount AND iv_bst_addr_mortgage_amount <= 176000 => 0.0215288630,
    iv_bst_addr_mortgage_amount > 176000                                         => 0.1051366069,
    iv_bst_addr_mortgage_amount = NULL                                           => 0.0245482831,
                                                                                    0.0245482831);

final_score_160_c793 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 193.5 => final_score_160_c794,
    iv_pl001_m_snc_prop_adl_fs > 193.5                                        => 0.0014046006,
    iv_pl001_m_snc_prop_adl_fs = NULL                                         => 0.0063639611,
                                                                                 0.0063639611);

final_score_160 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 172.5 => -0.0042091140,
    iv_pl001_m_snc_prop_adl_fs > 172.5                                        => final_score_160_c793,
    iv_pl001_m_snc_prop_adl_fs = NULL                                         => 0.0070999500,
                                                                                 -0.0010409849);

final_score_161_c796 := map(
    NULL < iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen <= 400.5 => 0.0009560008,
    iv_mos_since_prv_addr_fseen > 400.5                                         => 0.0656275103,
    iv_mos_since_prv_addr_fseen = NULL                                          => 0.0011548556,
                                                                                   0.0011548556);

final_score_161_c797 := map(
    iv_infutor_nap <> ' ' 
		  and NULL < (real)iv_infutor_nap AND (real)iv_infutor_nap <= 9.5 => -0.0144581400,
    (real)iv_infutor_nap > 9.5                            => 0.0703190494,
    iv_infutor_nap = ' '                           => -0.0075926007,
                                                       -0.0015404331);

final_score_161 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs <= 517.5 => final_score_161_c796,
    iv_sr001_m_hdr_fs > 517.5                               => -0.0612085582,
    iv_sr001_m_hdr_fs = NULL                                => final_score_161_c797,
                                                               0.0008111225);

final_score_162_c800 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 299969 => 0.1243716826,
    iv_pv001_inp_avm_autoval > 299969                                      => 0.0265012150,
    iv_pv001_inp_avm_autoval = NULL                                        => 0.0499901272,
                                                                              0.0499901272);

final_score_162_c799 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval <= 286600.5 => 0.0064019358,
    iv_pv001_bst_avm_autoval > 286600.5                                      => final_score_162_c800,
    iv_pv001_bst_avm_autoval = NULL                                          => 0.0163628396,
                                                                                0.0076974798);

final_score_162 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr <= 9.5 => final_score_162_c799,
    iv_adls_per_addr > 9.5                              => -0.0026646618,
    iv_adls_per_addr = NULL                             => 0.0014139432,
                                                           0.0010990200);

final_score_163_c803 := map(
    NULL < iv_inp_addr_fips_ratio AND iv_inp_addr_fips_ratio <= 1.1080054477 => 0.0761484467,
    iv_inp_addr_fips_ratio > 1.1080054477                                    => -0.0325837377,
    iv_inp_addr_fips_ratio = NULL                                            => 0.0410370121,
                                                                                0.0410370121);

final_score_163_c802 := map(
    iv_ed001_college_ind_35 <> ' '
		  and NULL < (real)iv_ed001_college_ind_35 AND (real)iv_ed001_college_ind_35 <= 0.5 => -0.0087844851,
    (real)iv_ed001_college_ind_35 > 0.5                                     => final_score_163_c803,
    iv_ed001_college_ind_35 = ' '                                    => -0.0089195029,
                                                                         -0.0070392615);

final_score_163 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 67025 => 0.0033335908,
    iv_prop_owned_assessed_total > 67025                                          => final_score_163_c802,
    iv_prop_owned_assessed_total = NULL                                           => 0.0132817753,
                                                                                     0.0011617006);

final_score_164_c806 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 3159.5 => -0.0176952107,
    iv_bst_addr_building_area > 3159.5                                       => 0.0750888851,
    iv_bst_addr_building_area = NULL                                         => -0.0127461891,
                                                                                -0.0127461891);

final_score_164_c805 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 57 => -0.0786857395,
    iv_pv001_bst_avm_chg_1yr_pct > 57                                          => -0.0038170477,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                        => final_score_164_c806,
                                                                                  -0.0078300934);

final_score_164 := map(
    iv_bst_own_prop_x_addr_naprop <> ' '
		  and NULL < (real)iv_bst_own_prop_x_addr_naprop AND (real)iv_bst_own_prop_x_addr_naprop <= 11.5 => 0.0029458183,
    (real)iv_bst_own_prop_x_addr_naprop > 11.5                                           => final_score_164_c805,
    iv_bst_own_prop_x_addr_naprop = ' '                                           => 0.0018933766,
                                                                                      0.0005480816);

final_score_165_c809 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 105.45 => -0.0360060118,
    iv_pv001_bst_avm_chg_1yr_pct > 105.45                                          => 0.0455742963,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                            => 0.0475853131,
                                                                                      0.0142350052);

final_score_165_c808 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 122858.5 => final_score_165_c809,
    iv_prv_addr_avm_auto_val > 122858.5                                      => 0.0826066943,
    iv_prv_addr_avm_auto_val = NULL                                          => 0.0265727536,
                                                                                0.0265727536);

final_score_165 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct <= 3.5 => -0.0014406395,
    iv_addr_non_phn_src_ct > 3.5                                    => final_score_165_c808,
    iv_addr_non_phn_src_ct = NULL                                   => 0.0029525756,
                                                                       -0.0008200209);

final_score_166_c812 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl <= 1.5 => 0.0207275544,
    iv_inq_addrs_per_adl > 1.5                                  => -0.0303628576,
    iv_inq_addrs_per_adl = NULL                                 => 0.0108129911,
                                                                   0.0108129911);

final_score_166_c811 := map(
    NULL < iv_prop_owned_assessed_count AND iv_prop_owned_assessed_count <= 1.5 => final_score_166_c812,
    iv_prop_owned_assessed_count > 1.5                                          => -0.0293785849,
    iv_prop_owned_assessed_count = NULL                                         => 0.0073956871,
                                                                                   0.0073956871);

final_score_166 := map(
    NULL < iv_prv_addr_mortgage_amount AND iv_prv_addr_mortgage_amount <= 19460 => -0.0038842173,
    iv_prv_addr_mortgage_amount > 19460                                         => final_score_166_c811,
    iv_prv_addr_mortgage_amount = NULL                                          => -0.0034864055,
                                                                                   -0.0016153315);

final_score_167_c815 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen <= 92.5 => -0.0456566124,
    iv_mos_since_infutor_first_seen > 92.5                                             => 0.2550004415,
    iv_mos_since_infutor_first_seen = NULL                                             => 0.0620191277,
                                                                                          0.0910309246);

final_score_167_c814 := map(
    NULL < iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst <= 7.5 => 0.0075667993,
    iv_va060_dist_add_in_bst > 7.5                                      => final_score_167_c815,
    iv_va060_dist_add_in_bst = NULL                                     => 0.0105027955,
                                                                           0.0105027955);

final_score_167 := map(
    NULL < iv_src_bureau_lname_count AND iv_src_bureau_lname_count <= 5.5 => final_score_167_c814,
    iv_src_bureau_lname_count > 5.5                                       => -0.0020222886,
    iv_src_bureau_lname_count = NULL                                      => -0.0023961495,
                                                                             0.0010692591);

final_score_168_c818 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr <= 15484 => 0.0430351943,
    iv_inp_addr_avm_change_3yr > 15484                                        => -0.0221085082,
    iv_inp_addr_avm_change_3yr = NULL                                         => 0.0459402219,
                                                                                 0.0301399123);

final_score_168_c817 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen <= 125.5 => 0.0023738373,
    iv_mos_since_infutor_first_seen > 125.5                                             => final_score_168_c818,
    iv_mos_since_infutor_first_seen = NULL                                              => -0.0062477025,
                                                                                           0.0086147372);

final_score_168 := map(
    NULL < iv_mos_src_bureau_dob_fseen AND iv_mos_src_bureau_dob_fseen <= 334.5 => -0.0036072601,
    iv_mos_src_bureau_dob_fseen > 334.5                                         => final_score_168_c817,
    iv_mos_src_bureau_dob_fseen = NULL                                          => 0.0019708080,
                                                                                   -0.0011910173);

final_score_169_c821 := map(
    NULL < iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst <= 13.5 => 0.0060466607,
    iv_va060_dist_add_in_bst > 13.5                                      => 0.1219022800,
    iv_va060_dist_add_in_bst = NULL                                      => 0.0101494101,
                                                                            0.0101494101);

final_score_169_c820 := map(
    NULL < iv_src_bureau_lname_count AND iv_src_bureau_lname_count <= 8.5 => final_score_169_c821,
    iv_src_bureau_lname_count > 8.5                                       => -0.0192357915,
    iv_src_bureau_lname_count = NULL                                      => -0.0113699913,
                                                                             -0.0113699913);

final_score_169 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl <= 1.5 => 0.0027936754,
    iv_ms001_ssns_per_adl > 1.5                                   => final_score_169_c820,
    iv_ms001_ssns_per_adl = NULL                                  => -0.0070767372,
                                                                     -0.0009039785);

final_score_170_c824 := map(
    NULL < iv_inq_auto_recency AND iv_inq_auto_recency <= 2 => -0.0597842130,
    iv_inq_auto_recency > 2                                 => 0.0732856599,
    iv_inq_auto_recency = NULL                              => -0.0370390431,
                                                               -0.0370390431);

final_score_170_c823 := map(
    NULL < iv_mos_src_bankruptcy_adl_lseen AND iv_mos_src_bankruptcy_adl_lseen <= 55.5 => 0.0038733933,
    iv_mos_src_bankruptcy_adl_lseen > 55.5                                             => final_score_170_c824,
    iv_mos_src_bankruptcy_adl_lseen = NULL                                             => 0.0015291200,
                                                                                          0.0015291200);

final_score_170 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 12.183205263 => final_score_170_c823,
    iv_bst_addr_mtg_avm_pct_diff > 12.183205263                                          => -0.0679741239,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                  => -0.0012130738,
                                                                                            -0.0009913973);

final_score_171_c827 := map(
    NULL < iv_bst_addr_avm_change_3yr AND iv_bst_addr_avm_change_3yr <= -3750 => 0.0494269351,
    iv_bst_addr_avm_change_3yr > -3750                                        => -0.0547776973,
    iv_bst_addr_avm_change_3yr = NULL                                         => -0.0392940267,
                                                                                 -0.0383391555);

final_score_171_c826 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen <= 95.5 => final_score_171_c827,
    iv_mos_since_gong_did_lst_seen > 95.5                                            => 0.0694019839,
    iv_mos_since_gong_did_lst_seen = NULL                                            => -0.0278058038,
                                                                                        -0.0278058038);

final_score_171 := map(
    NULL < iv_mos_since_lname_change AND iv_mos_since_lname_change <= 38.5 => 0.0007343565,
    iv_mos_since_lname_change > 38.5                                       => final_score_171_c826,
    iv_mos_since_lname_change = NULL                                       => -0.0112939952,
                                                                              -0.0005958092);

final_score_172_c830 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 91.95 => -0.0006592019,
    iv_sr001_source_profile > 91.95                                     => -0.0637065952,
    iv_sr001_source_profile = NULL                                      => -0.0008949229,
                                                                           -0.0008949229);

final_score_172_c829 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 334.5 => final_score_172_c830,
    iv_mos_src_bureau_lname_fseen > 334.5                                           => 0.0101148446,
    iv_mos_src_bureau_lname_fseen = NULL                                            => 0.0013356095,
                                                                                       0.0013356095);

final_score_172 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 20.5 => final_score_172_c829,
    iv_addrs_per_adl > 20.5                              => -0.0391699856,
    iv_addrs_per_adl = NULL                              => -0.0051455306,
                                                            -0.0000743223);

final_score_173_c833 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 80.5 => 0.0248513628,
    iv_pl002_avg_mo_per_addr > 80.5                                      => -0.0224950210,
    iv_pl002_avg_mo_per_addr = NULL                                      => 0.0132021086,
                                                                            0.0132021086);

final_score_173_c832 := map(
    NULL < iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst <= 10.5 => final_score_173_c833,
    iv_va060_dist_add_in_bst > 10.5                                      => 0.1241124202,
    iv_va060_dist_add_in_bst = NULL                                      => 0.0177915008,
                                                                            0.0177915008);

final_score_173 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval <= 206605 => -0.0014964152,
    iv_pv001_bst_avm_autoval > 206605                                      => final_score_173_c832,
    iv_pv001_bst_avm_autoval = NULL                                        => -0.0076533357,
                                                                              -0.0004563332);

final_score_174_c836 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen <= 134.5 => 0.0119679888,
    iv_mos_since_infutor_first_seen > 134.5                                             => 0.0682776659,
    iv_mos_since_infutor_first_seen = NULL                                              => 0.0599114160,
                                                                                           0.0300690389);

final_score_174_c835 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 125.75 => final_score_174_c836,
    iv_pv001_bst_avm_chg_1yr_pct > 125.75                                          => -0.0378628373,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                            => 0.0041840498,
                                                                                      0.0150357181);

final_score_174 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 130.5 => -0.0009329639,
    iv_mos_since_prop1_sale > 130.5                                     => final_score_174_c835,
    iv_mos_since_prop1_sale = NULL                                      => 0.0039928891,
                                                                           -0.0000176378);

final_score_175_c839 := map(
    NULL < iv_bst_addr_mortgage_amount AND iv_bst_addr_mortgage_amount <= 199506 => 0.0096661062,
    iv_bst_addr_mortgage_amount > 199506                                         => 0.0648723547,
    iv_bst_addr_mortgage_amount = NULL                                           => 0.0113008471,
                                                                                    0.0113008471);

final_score_175_c838 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct <= 5.5 => -0.0017472631,
    iv_fname_non_phn_src_ct > 5.5                                     => final_score_175_c839,
    iv_fname_non_phn_src_ct = NULL                                    => 0.0069022917,
                                                                         0.0004578316);

final_score_175 := map(
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                               => -0.0570124262,
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged', '3 - BK Other']) => final_score_175_c838,
    iv_db001_bankruptcy = ''                                                  => -0.0149732577,
                                                                                   -0.0002681855);

final_score_176_c842 := map(
    NULL < iv_bst_addr_fips_ratio AND iv_bst_addr_fips_ratio <= 1.05463228375 => -0.0170310892,
    iv_bst_addr_fips_ratio > 1.05463228375                                    => 0.0945849320,
    iv_bst_addr_fips_ratio = NULL                                             => 0.0097472768,
                                                                                 0.0097472768);

final_score_176_c841 := map(
    NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen <= 36.5 => final_score_176_c842,
    iv_mos_src_bureau_addr_fseen > 36.5                                          => 0.1450716241,
    iv_mos_src_bureau_addr_fseen = NULL                                          => 0.0334468123,
                                                                                    0.0334468123);

final_score_176 := map(
    NULL < iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst <= 123.5 => -0.0001165508,
    iv_va060_dist_add_in_bst > 123.5                                      => final_score_176_c841,
    iv_va060_dist_add_in_bst = NULL                                       => -0.0043265052,
                                                                             0.0001772435);

final_score_177_c845 := map(
    NULL < iv_src_bureau_dob_count AND iv_src_bureau_dob_count <= 7.5 => 0.0248132919,
    iv_src_bureau_dob_count > 7.5                                     => -0.0133695856,
    iv_src_bureau_dob_count = NULL                                    => 0.0158930576,
                                                                         0.0158930576);

final_score_177_c844 := map(
    NULL < iv_combined_age AND iv_combined_age <= 65.5 => final_score_177_c845,
    iv_combined_age > 65.5                             => -0.0247450230,
    iv_combined_age = NULL                             => 0.0097147985,
                                                          0.0097147985);

final_score_177 := map(
    NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen <= 79.5 => -0.0023249413,
    iv_mos_since_prv_addr_lseen > 79.5                                         => final_score_177_c844,
    iv_mos_since_prv_addr_lseen = NULL                                         => 0.0001258044,
                                                                                  -0.0004401667);

final_score_178_c848 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 9.5 => -0.0000059909,
    iv_src_property_adl_count > 9.5                                       => 0.0343951062,
    iv_src_property_adl_count = NULL                                      => 0.0003169708,
                                                                             0.0003169708);

final_score_178_c847 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 163.5 => final_score_178_c848,
    iv_sr001_m_wp_adl_fs > 163.5                                  => -0.0549664091,
    iv_sr001_m_wp_adl_fs = NULL                                   => 0.0015261526,
                                                                     -0.0001008300);

final_score_178 := map(
    (iv_inp_addr_financing_type in ['OTH'])                => -0.0617841770,
    (iv_inp_addr_financing_type in ['ADJ', 'CNV', 'NONE']) => final_score_178_c847,
    iv_inp_addr_financing_type = ''                      => 0.0278267560,
                                                              -0.0001189175);

final_score_179_c851 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 40410 => 0.0215779937,
    iv_inp_addr_assessed_total_val > 40410                                            => 0.1251841331,
    iv_inp_addr_assessed_total_val = NULL                                             => 0.0353710875,
                                                                                         0.0353710875);

final_score_179_c850 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 158.5 => -0.0033191250,
    iv_mos_since_gong_did_fst_seen > 158.5                                            => final_score_179_c851,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0096779370,
                                                                                         -0.0019800396);

final_score_179 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 2.3307169811 => -0.0007655861,
    iv_inp_addr_avm_pct_change_1yr > 2.3307169811                                            => -0.0613608295,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                    => final_score_179_c850,
                                                                                                -0.0020504119);

final_score_180_c853 := map(
    NULL < iv_po001_m_snc_veh_adl_fs AND iv_po001_m_snc_veh_adl_fs <= 81 => -0.0341073147,
    iv_po001_m_snc_veh_adl_fs > 81                                       => 0.0661449509,
    iv_po001_m_snc_veh_adl_fs = NULL                                     => -0.0287159087,
                                                                            -0.0287159087);

final_score_180_c854 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 7.5 => 0.0478229358,
    iv_pl002_avg_mo_per_addr > 7.5                                      => -0.0003588766,
    iv_pl002_avg_mo_per_addr = NULL                                     => 0.0004428740,
                                                                           0.0004428740);

final_score_180 := map(
    NULL < iv_bst_addr_fips_ratio AND iv_bst_addr_fips_ratio <= -0.5 => final_score_180_c853,
    iv_bst_addr_fips_ratio > -0.5                                    => final_score_180_c854,
    iv_bst_addr_fips_ratio = NULL                                    => -0.0049927965,
                                                                        -0.0010182545);

final_score_181_c857 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 9.5 => 0.0062607638,
    iv_pl001_m_snc_prop_adl_fs > 9.5                                        => 0.0864764845,
    iv_pl001_m_snc_prop_adl_fs = NULL                                       => 0.0494743952,
                                                                               0.0494743952);

final_score_181_c856 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 <= 1.5 => final_score_181_c857,
    iv_iq001_inq_count12 > 1.5                                  => 0.0048174646,
    iv_iq001_inq_count12 = NULL                                 => 0.0128523670,
                                                                   0.0128523670);

final_score_181 := map(
    NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 <= 0.5 => -0.0021313927,
    iv_inq_auto_count12 > 0.5                                 => final_score_181_c856,
    iv_inq_auto_count12 = NULL                                => 0.0024210859,
                                                                 0.0000989603);

final_score_182_c860 := map(
    NULL < iv_pv001_bst_avm_chg_1yr AND iv_pv001_bst_avm_chg_1yr <= -26693.5 => 0.0862039456,
    iv_pv001_bst_avm_chg_1yr > -26693.5                                      => -0.0079684764,
    iv_pv001_bst_avm_chg_1yr = NULL                                          => 0.0014255795,
                                                                                -0.0015521223);

final_score_182_c859 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 119075 => final_score_182_c860,
    iv_purch_sold_assess_val_diff > 119075                                           => -0.0280172156,
    iv_purch_sold_assess_val_diff = NULL                                             => -0.0000508865,
                                                                                        -0.0004589285);

final_score_182 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 386.5 => final_score_182_c859,
    iv_pl002_avg_mo_per_addr > 386.5                                      => 0.0750512004,
    iv_pl002_avg_mo_per_addr = NULL                                       => 0.0027441548,
                                                                             -0.0002199445);

final_score_183_c862 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs <= 528.5 => -0.0028856945,
    iv_sr001_m_hdr_fs > 528.5                               => -0.0673222343,
    iv_sr001_m_hdr_fs = NULL                                => -0.0031817649,
                                                               -0.0031817649);

final_score_183_c863 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr <= 6.5 => 0.0755044584,
    iv_adls_per_addr > 6.5                              => -0.0274253600,
    iv_adls_per_addr = NULL                             => 0.0116179165,
                                                           0.0030779985);

final_score_183 := map(
    NULL < iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count <= 1.5 => final_score_183_c862,
    iv_addr_lres_12mo_count > 1.5                                     => 0.0095400647,
    iv_addr_lres_12mo_count = NULL                                    => final_score_183_c863,
                                                                         0.0001199350);

final_score_184_c866 := map(
    NULL < iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen <= 237.5 => 0.0008916848,
    iv_mos_since_prv_addr_fseen > 237.5                                         => 0.0545398159,
    iv_mos_since_prv_addr_fseen = NULL                                          => 0.0141356104,
                                                                                   0.0141356104);

final_score_184_c865 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 1.01190874315 => final_score_184_c866,
    iv_bst_addr_mtg_avm_pct_diff > 1.01190874315                                          => -0.0103043666,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                   => -0.0079162721,
                                                                                             -0.0058770887);

final_score_184 := map(
    NULL < iv_attr_purchase_recency AND iv_attr_purchase_recency <= 48 => 0.0045374483,
    iv_attr_purchase_recency > 48                                      => final_score_184_c865,
    iv_attr_purchase_recency = NULL                                    => -0.0026947858,
                                                                          0.0009180466);

final_score_185_c869 := map(
    NULL < iv_inp_addr_avm_change_1yr AND iv_inp_addr_avm_change_1yr <= 33344.5 => 0.0089073735,
    iv_inp_addr_avm_change_1yr > 33344.5                                        => 0.0679389272,
    iv_inp_addr_avm_change_1yr = NULL                                           => 0.0279197548,
                                                                                   0.0191057411);

final_score_185_c868 := map(
    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val <= 94088.5 => final_score_185_c869,
    iv_prv_addr_assessed_total_val > 94088.5                                            => -0.0255772165,
    iv_prv_addr_assessed_total_val = NULL                                               => 0.0150284303,
                                                                                           0.0150284303);

final_score_185 := map(
    NULL < iv_prop_sold_assessed_total AND iv_prop_sold_assessed_total <= 49655 => -0.0017826835,
    iv_prop_sold_assessed_total > 49655                                         => final_score_185_c868,
    iv_prop_sold_assessed_total = NULL                                          => -0.0110459583,
                                                                                   0.0003346688);

final_score_186_c872 := map(
    NULL < iv_avg_lres AND iv_avg_lres <= 104.5 => 0.0084206330,
    iv_avg_lres > 104.5                         => 0.0993403647,
    iv_avg_lres = NULL                          => 0.0349665401,
                                                   0.0349665401);

final_score_186_c871 := map(
    NULL < iv_inp_addr_avm_change_2yr AND iv_inp_addr_avm_change_2yr <= -22577 => final_score_186_c872,
    iv_inp_addr_avm_change_2yr > -22577                                        => 0.0007848852,
    iv_inp_addr_avm_change_2yr = NULL                                          => -0.0615212768,
                                                                                  0.0007955396);

final_score_186 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 0.8291034123 => -0.0222734880,
    iv_inp_addr_avm_pct_change_1yr > 0.8291034123                                            => final_score_186_c871,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                    => 0.0002575884,
                                                                                                -0.0009035511);

final_score_187_c875 := map(
    NULL < iv_pl001_bst_addr_lres AND iv_pl001_bst_addr_lres <= 406.5 => 0.0008296334,
    iv_pl001_bst_addr_lres > 406.5                                    => -0.0633980014,
    iv_pl001_bst_addr_lres = NULL                                     => 0.0006744431,
                                                                         0.0006744431);

final_score_187_c874 := map(
    NULL < iv_inp_addr_fips_ratio AND iv_inp_addr_fips_ratio <= 3.0050101002 => final_score_187_c875,
    iv_inp_addr_fips_ratio > 3.0050101002                                    => -0.0557823317,
    iv_inp_addr_fips_ratio = NULL                                            => 0.0002315001,
                                                                                0.0002315001);

final_score_187 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 367.5 => final_score_187_c874,
    iv_pl002_avg_mo_per_addr > 367.5                                      => 0.0513253947,
    iv_pl002_avg_mo_per_addr = NULL                                       => -0.0028772011,
                                                                             0.0003256719);

final_score_188_c878 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 306225 => -0.0207246838,
    iv_prop_owned_assessed_total > 306225                                          => 0.0961360122,
    iv_prop_owned_assessed_total = NULL                                            => -0.0183816122,
                                                                                      -0.0183816122);

final_score_188_c877 := map(
    NULL < iv_inp_addr_avm_change_2yr AND iv_inp_addr_avm_change_2yr <= 92143 => final_score_188_c878,
    iv_inp_addr_avm_change_2yr > 92143                                        => 0.1365945292,
    iv_inp_addr_avm_change_2yr = NULL                                         => -0.0145328741,
                                                                                 -0.0146549533);

final_score_188 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 1.5 => 0.0026392640,
    iv_dg001_derog_count > 1.5                                  => final_score_188_c877,
    iv_dg001_derog_count = NULL                                 => -0.0051737272,
                                                                   -0.0016682598);

final_score_189_c881 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count <= 1.5 => -0.0075529876,
    iv_inp_addr_source_count > 1.5                                      => 0.0793813081,
    iv_inp_addr_source_count = NULL                                     => 0.0399892054,
                                                                           0.0399892054);

final_score_189_c880 := map(
    NULL < iv_pl002_addrs_per_ssn_c6 AND iv_pl002_addrs_per_ssn_c6 <= 0.5 => -0.0065579300,
    iv_pl002_addrs_per_ssn_c6 > 0.5                                       => final_score_189_c881,
    iv_pl002_addrs_per_ssn_c6 = NULL                                      => 0.0070975824,
                                                                             -0.0047766061);

final_score_189 := map(
    NULL < iv_src_bureau_ssn_count AND iv_src_bureau_ssn_count <= 13.5 => final_score_189_c880,
    iv_src_bureau_ssn_count > 13.5                                     => 0.0063069872,
    iv_src_bureau_ssn_count = NULL                                     => 0.0001558201,
                                                                          -0.0002888068);

final_score_190_c884 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 146015 => 0.0168300482,
    iv_prop_owned_assessed_total > 146015                                          => 0.0884263212,
    iv_prop_owned_assessed_total = NULL                                            => 0.0193355030,
                                                                                      0.0193355030);

final_score_190_c883 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 146630 => final_score_190_c884,
    iv_avg_prop_assess_purch_amt > 146630                                          => -0.0376528377,
    iv_avg_prop_assess_purch_amt = NULL                                            => 0.0156078705,
                                                                                      0.0156078705);

final_score_190 := map(
    (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed', '3 - BK Other']) => -0.0020290666,
    (iv_db001_bankruptcy in ['1 - BK Discharged'])                             => final_score_190_c883,
    iv_db001_bankruptcy = ''                                                 => -0.0123450727,
                                                                                  -0.0004015102);

final_score_191_c887 := map(
    NULL < iv_inq_phones_per_adl AND iv_inq_phones_per_adl <= 0.5 => 0.0094255715,
    iv_inq_phones_per_adl > 0.5                                   => -0.0098911506,
    iv_inq_phones_per_adl = NULL                                  => 0.0027875857,
                                                                     0.0027875857);

final_score_191_c886 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 0.5 => final_score_191_c887,
    iv_inq_per_addr > 0.5                             => -0.0042716805,
    iv_inq_per_addr = NULL                            => -0.0007025150,
                                                         -0.0007025150);

final_score_191 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 167.5 => final_score_191_c886,
    iv_sr001_m_wp_adl_fs > 167.5                                  => -0.0754896844,
    iv_sr001_m_wp_adl_fs = NULL                                   => 0.0011177329,
                                                                     -0.0011169956);

final_score_192_c890 := map(
    NULL < iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen <= 363.5 => -0.0186989614,
    iv_mos_src_bureau_ssn_fseen > 363.5                                         => -0.0937366063,
    iv_mos_src_bureau_ssn_fseen = NULL                                          => -0.0321296123,
                                                                                   -0.0321296123);

final_score_192_c889 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 107779.5 => 0.0023458804,
    iv_inp_addr_assessed_total_val > 107779.5                                            => final_score_192_c890,
    iv_inp_addr_assessed_total_val = NULL                                                => 0.0001822450,
                                                                                            0.0001822450);

final_score_192 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 230.6 => final_score_192_c889,
    iv_pv001_bst_avm_chg_1yr_pct > 230.6                                          => -0.0522632607,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                           => 0.0022336131,
                                                                                     0.0006968251);

final_score_193_c893 := map(
    NULL < iv_inp_addr_avm_pct_change_2yr AND iv_inp_addr_avm_pct_change_2yr <= 1.7440314424 => -0.0085742217,
    iv_inp_addr_avm_pct_change_2yr > 1.7440314424                                            => 0.0379712671,
    iv_inp_addr_avm_pct_change_2yr = NULL                                                    => -0.0152038260,
                                                                                                -0.0077021556);

final_score_193_c892 := map(
    NULL < iv_ssns_per_sfd_addr_c6 AND iv_ssns_per_sfd_addr_c6 <= 1.5 => final_score_193_c893,
    iv_ssns_per_sfd_addr_c6 > 1.5                                     => 0.0615870782,
    iv_ssns_per_sfd_addr_c6 = NULL                                    => -0.0062747610,
                                                                         -0.0062747610);

final_score_193 := map(
    (iv_bst_addr_ownership_lvl in ['Applicant'])                          => final_score_193_c892,
    (iv_bst_addr_ownership_lvl in ['Family', 'No Ownership', 'Occupant']) => 0.0024719566,
    iv_bst_addr_ownership_lvl = ''                                      => -0.0058282378,
                                                                             0.0003675502);

final_score_194_c896 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 123865 => 0.0322886218,
    iv_prop_owned_assessed_total > 123865                                          => 0.1603271932,
    iv_prop_owned_assessed_total = NULL                                            => 0.0533556710,
                                                                                      0.0533556710);

final_score_194_c895 := map(
    NULL < iv_inq_auto_recency AND iv_inq_auto_recency <= 9 => 0.0001252786,
    iv_inq_auto_recency > 9                                 => final_score_194_c896,
    iv_inq_auto_recency = NULL                              => 0.0031871389,
                                                               0.0031871389);

final_score_194 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 12.2055172015 => final_score_194_c895,
    iv_bst_addr_mtg_avm_pct_diff > 12.2055172015                                          => -0.0537149379,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                   => 0.0004546021,
                                                                                             0.0007391729);

final_score_195_c899 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 63.5 => 0.0424999453,
    iv_mos_src_property_adl_lseen > 63.5                                           => 0.0057667248,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0199667131,
                                                                                      0.0199667131);

final_score_195_c898 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 139.5 => final_score_195_c899,
    iv_sr001_m_wp_adl_fs > 139.5                                  => -0.0598853382,
    iv_sr001_m_wp_adl_fs = NULL                                   => 0.0148415590,
                                                                     0.0148415590);

final_score_195 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 132.5 => 0.0008477135,
    iv_mos_since_prop1_sale > 132.5                                     => final_score_195_c898,
    iv_mos_since_prop1_sale = NULL                                      => 0.0017550024,
                                                                           0.0015300923);

final_score_196_c902 := map(
    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen <= 1.5 => 0.0093774858,
    iv_mos_since_infutor_last_seen > 1.5                                            => -0.0033381595,
    iv_mos_since_infutor_last_seen = NULL                                           => 0.0038264610,
                                                                                       0.0019362651);

final_score_196_c901 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 11.5 => final_score_196_c902,
    iv_inq_per_addr > 11.5                             => -0.0481620716,
    iv_inq_per_addr = NULL                             => 0.0009218235,
                                                          0.0009218235);

final_score_196 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct <= 1.5 => final_score_196_c901,
    iv_gong_did_phone_ct > 1.5                                  => -0.0120750086,
    iv_gong_did_phone_ct = NULL                                 => 0.0037935030,
                                                                   -0.0016213179);

final_score_197_c905 := map(
    NULL < iv_bst_addr_mtg_avm_abs_diff AND iv_bst_addr_mtg_avm_abs_diff <= -38998.5 => -0.0452918774,
    iv_bst_addr_mtg_avm_abs_diff > -38998.5                                          => 0.0242338151,
    iv_bst_addr_mtg_avm_abs_diff = NULL                                              => 0.0103060008,
                                                                                        0.0124216136);

final_score_197_c904 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 134625 => final_score_197_c905,
    iv_inp_addr_assessed_total_val > 134625                                            => -0.0495500425,
    iv_inp_addr_assessed_total_val = NULL                                              => 0.0094221437,
                                                                                          0.0094221437);

final_score_197 := map(
    NULL < iv_mos_src_bureau_dob_fseen AND iv_mos_src_bureau_dob_fseen <= 340.5 => -0.0021447634,
    iv_mos_src_bureau_dob_fseen > 340.5                                         => final_score_197_c904,
    iv_mos_src_bureau_dob_fseen = NULL                                          => 0.0062304225,
                                                                                   -0.0001962350);

final_score_198_c908 := map(
    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen <= 26.5 => 0.0397899081,
    iv_mos_since_infutor_last_seen > 26.5                                            => 0.0087791842,
    iv_mos_since_infutor_last_seen = NULL                                            => -0.0299990044,
                                                                                        0.0227123488);

final_score_198_c907 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 82442 => final_score_198_c908,
    iv_inp_addr_assessed_total_val > 82442                                            => -0.0684596026,
    iv_inp_addr_assessed_total_val = NULL                                             => 0.0160801351,
                                                                                         0.0160801351);

final_score_198 := map(
    NULL < iv_max_lres AND iv_max_lres <= 329.5 => -0.0011061852,
    iv_max_lres > 329.5                         => final_score_198_c907,
    iv_max_lres = NULL                          => 0.0024529268,
                                                   -0.0002291032);

final_score_199_c911 := map(
    NULL < iv_inq_auto_recency AND iv_inq_auto_recency <= 4.5 => -0.0012119806,
    iv_inq_auto_recency > 4.5                                 => 0.0208065347,
    iv_inq_auto_recency = NULL                                => -0.0058155972,
                                                                 0.0009194533);

final_score_199_c910 := map(
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                               => -0.0582930851,
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged', '3 - BK Other']) => final_score_199_c911,
    iv_db001_bankruptcy = ''                                                  => 0.0003204090,
                                                                                   0.0003204090);

final_score_199 := map(
    (iv_full_name_ver_sources in ['Name not Verd', 'NonPhn Only', 'Phn & NonPhn']) => final_score_199_c910,
    (iv_full_name_ver_sources in ['Phn Only'])                                     => 0.0545247452,
    iv_full_name_ver_sources = ''                                                => 0.0440026264,
                                                                                      0.0009083859);

final_score_200_c914 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income <= 26500 => -0.0057180425,
    iv_in001_estimated_income > 26500                                       => 0.0067334108,
    iv_in001_estimated_income = NULL                                        => 0.0171879753,
                                                                               0.0032883803);

final_score_200_c913 := map(
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                               => -0.0553489721,
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged', '3 - BK Other']) => final_score_200_c914,
    iv_db001_bankruptcy = ''                                                  => 0.0027137971,
                                                                                   0.0027137971);

final_score_200 := map(
    NULL < iv_inq_lnames_per_addr AND iv_inq_lnames_per_addr <= 1.5 => final_score_200_c913,
    iv_inq_lnames_per_addr > 1.5                                    => -0.0168362313,
    iv_inq_lnames_per_addr = NULL                                   => 0.0001683781,
                                                                       0.0004105610);

final_score_201_c917 := map(
    NULL < iv_bst_addr_avm_pct_change_2yr AND iv_bst_addr_avm_pct_change_2yr <= 1.0424681625 => 0.0092637382,
    iv_bst_addr_avm_pct_change_2yr > 1.0424681625                                            => -0.0758791021,
    iv_bst_addr_avm_pct_change_2yr = NULL                                                    => -0.0120840293,
                                                                                                -0.0120840293);

final_score_201_c916 := map(
    NULL < iv_bst_addr_avm_pct_change_2yr AND iv_bst_addr_avm_pct_change_2yr <= 1.07940761235 => final_score_201_c917,
    iv_bst_addr_avm_pct_change_2yr > 1.07940761235                                            => 0.0380681542,
    iv_bst_addr_avm_pct_change_2yr = NULL                                                     => 0.0198127466,
                                                                                                 0.0182695466);

final_score_201 := map(
    NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr <= 1262.5 => -0.0017658044,
    iv_dist_inp_addr_to_prv_addr > 1262.5                                          => final_score_201_c916,
    iv_dist_inp_addr_to_prv_addr = NULL                                            => -0.0012121635,
                                                                                      -0.0005041536);

final_score_202_c920 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 0.5 => 0.0351660241,
    iv_dg001_derog_count > 0.5                                  => -0.0394075063,
    iv_dg001_derog_count = NULL                                 => 0.0174625673,
                                                                   0.0174625673);

final_score_202_c919 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 79.5 => final_score_202_c920,
    iv_mos_src_bureau_lname_fseen > 79.5                                           => -0.0084746549,
    iv_mos_src_bureau_lname_fseen = NULL                                           => 0.0097971299,
                                                                                      -0.0047546555);

final_score_202 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 1.1105546875 => final_score_202_c919,
    iv_inp_addr_avm_pct_change_1yr > 1.1105546875                                            => 0.0093484675,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                    => 0.0008969117,
                                                                                                0.0002925380);

final_score_203_c922 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 1.09668284475 => -0.0416819200,
    iv_inp_addr_avm_pct_change_1yr > 1.09668284475                                            => 0.0484954476,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                     => -0.0255255510,
                                                                                                 -0.0215450524);

final_score_203_c923 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 78400 => 0.0325974054,
    iv_purch_sold_val_diff > 78400                                    => -0.0462876404,
    iv_purch_sold_val_diff = NULL                                     => 0.0020076869,
                                                                         0.0021412915);

final_score_203 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 105535 => -0.0056718359,
    iv_purch_sold_assess_val_diff > 105535                                           => final_score_203_c922,
    iv_purch_sold_assess_val_diff = NULL                                             => final_score_203_c923,
                                                                                        0.0014184836);

final_score_204_c926 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 53993 => -0.0007372140,
    iv_prv_addr_avm_auto_val > 53993                                      => 0.0822540171,
    iv_prv_addr_avm_auto_val = NULL                                       => 0.0316688858,
                                                                             0.0316688858);

final_score_204_c925 := map(
    NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count <= 1.5 => -0.0019237535,
    iv_paw_active_phone_count > 1.5                                       => final_score_204_c926,
    iv_paw_active_phone_count = NULL                                      => -0.0016919736,
                                                                             -0.0016919736);

final_score_204 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct <= 7.5 => final_score_204_c925,
    iv_full_name_non_phn_src_ct > 7.5                                         => -0.0479553253,
    iv_full_name_non_phn_src_ct = NULL                                        => -0.0029480663,
                                                                                 -0.0021365508);

final_score_205_c929 := map(
    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen <= 45.5 => -0.0012876050,
    iv_mos_since_infutor_last_seen > 45.5                                            => 0.0403344291,
    iv_mos_since_infutor_last_seen = NULL                                            => 0.0065259235,
                                                                                        0.0117246542);

final_score_205_c928 := map(
    NULL < iv_mos_src_bureau_dob_fseen AND iv_mos_src_bureau_dob_fseen <= 383.5 => final_score_205_c929,
    iv_mos_src_bureau_dob_fseen > 383.5                                         => 0.0913608776,
    iv_mos_src_bureau_dob_fseen = NULL                                          => 0.0144914716,
                                                                                   0.0144914716);

final_score_205 := map(
    (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed', '3 - BK Other']) => -0.0018552825,
    (iv_db001_bankruptcy in ['1 - BK Discharged'])                             => final_score_205_c928,
    iv_db001_bankruptcy = ''                                                 => -0.0228676579,
                                                                                  -0.0004481992);

final_score_206_c932 := map(
    NULL < iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen <= 99.5 => 0.1073459839,
    iv_mos_since_bst_addr_fseen > 99.5                                         => 0.0048037300,
    iv_mos_since_bst_addr_fseen = NULL                                         => 0.0603109329,
                                                                                  0.0603109329);

final_score_206_c931 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 293262.5 => final_score_206_c932,
    iv_prv_addr_avm_auto_val > 293262.5                                      => -0.0343943686,
    iv_prv_addr_avm_auto_val = NULL                                          => 0.0357355066,
                                                                                0.0357355066);

final_score_206 := map(
    NULL < iv_prop_sold_assessed_total AND iv_prop_sold_assessed_total <= 295900 => -0.0004350228,
    iv_prop_sold_assessed_total > 295900                                         => final_score_206_c931,
    iv_prop_sold_assessed_total = NULL                                           => -0.0213779280,
                                                                                    -0.0002448908);

final_score_207_c934 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 213901 => 0.0020411323,
    iv_pv001_inp_avm_autoval > 213901                                      => 0.0320502508,
    iv_pv001_inp_avm_autoval = NULL                                        => 0.0033847482,
                                                                              0.0033847482);

final_score_207_c935 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 255085 => -0.0013222421,
    iv_prop_owned_assessed_total > 255085                                          => 0.0323720381,
    iv_prop_owned_assessed_total = NULL                                            => -0.0156702846,
                                                                                      -0.0007747390);

final_score_207 := map(
    NULL < iv_bst_addr_avm_change_3yr AND iv_bst_addr_avm_change_3yr <= 36988 => final_score_207_c934,
    iv_bst_addr_avm_change_3yr > 36988                                        => -0.0160013941,
    iv_bst_addr_avm_change_3yr = NULL                                         => final_score_207_c935,
                                                                                 -0.0005702779);

final_score_208_c938 := map(
    NULL < iv_bst_addr_mortgage_amount AND iv_bst_addr_mortgage_amount <= 21124 => 0.0492781916,
    iv_bst_addr_mortgage_amount > 21124                                         => -0.0309932594,
    iv_bst_addr_mortgage_amount = NULL                                          => 0.0267213849,
                                                                                   0.0267213849);

final_score_208_c937 := map(
    NULL < iv_pl_addrs_per_adl AND iv_pl_addrs_per_adl <= 0.5 => -0.0057149069,
    iv_pl_addrs_per_adl > 0.5                                 => final_score_208_c938,
    iv_pl_addrs_per_adl = NULL                                => -0.0039837128,
                                                                 -0.0039837128);

final_score_208 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 107.5 => final_score_208_c937,
    iv_mos_since_gong_did_fst_seen > 107.5                                            => 0.0075211403,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0045901432,
                                                                                         -0.0003855647);

final_score_209_c941 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 0.86826646525 => -0.0313122739,
    iv_inp_addr_avm_pct_change_1yr > 0.86826646525                                            => 0.0147388127,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                     => 0.0047842797,
                                                                                                 0.0061782994);

final_score_209_c940 := map(
    (iv_fname_eda_sourced_type in ['-1', 'A', 'AP']) => final_score_209_c941,
    (iv_fname_eda_sourced_type in ['P'])             => 0.0275572308,
    iv_fname_eda_sourced_type = ''                 => 0.0075985579,
                                                        0.0075985579);

final_score_209 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 4.5 => final_score_209_c940,
    iv_addrs_per_adl > 4.5                              => -0.0028532942,
    iv_addrs_per_adl = NULL                             => -0.0134643354,
                                                           -0.0006523444);

final_score_210_c944 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 2076 => 0.0306979719,
    iv_inp_addr_building_area > 2076                                       => 0.1214421272,
    iv_inp_addr_building_area = NULL                                       => 0.0417828867,
                                                                              0.0417828867);

final_score_210_c943 := map(
    NULL < iv_liens_rel_ot_ct AND iv_liens_rel_ot_ct <= 1.5 => 0.0008160594,
    iv_liens_rel_ot_ct > 1.5                                => final_score_210_c944,
    iv_liens_rel_ot_ct = NULL                               => 0.0023890075,
                                                               0.0016733186);

final_score_210 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count <= 2.5 => final_score_210_c943,
    iv_mi001_adlperssn_count > 2.5                                      => -0.0167027841,
    iv_mi001_adlperssn_count = NULL                                     => 0.0067523962,
                                                                           -0.0003520295);

final_score_211_c947 := map(
    NULL < iv_inp_addr_mortgage_amount AND iv_inp_addr_mortgage_amount <= 137176.5 => 0.0049406355,
    iv_inp_addr_mortgage_amount > 137176.5                                         => 0.0901078551,
    iv_inp_addr_mortgage_amount = NULL                                             => 0.0130085465,
                                                                                      0.0130085465);

final_score_211_c946 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 104.5 => -0.0177825167,
    iv_mos_since_gong_did_fst_seen > 104.5                                            => final_score_211_c947,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0028091660,
                                                                                         -0.0028091660);

final_score_211 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= 98280.5 => final_score_211_c946,
    iv_prop1_purch_sale_diff > 98280.5                                      => -0.0487002105,
    iv_prop1_purch_sale_diff = NULL                                         => 0.0001770655,
                                                                               -0.0002200398);

final_score_212_c950 := map(
    NULL < iv_prv_addr_mortgage_amount AND iv_prv_addr_mortgage_amount <= 73360 => 0.0055258591,
    iv_prv_addr_mortgage_amount > 73360                                         => 0.0658847482,
    iv_prv_addr_mortgage_amount = NULL                                          => 0.0184174722,
                                                                                   0.0184174722);

final_score_212_c949 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 78814 => final_score_212_c950,
    iv_inp_addr_assessed_total_val > 78814                                            => -0.0346923382,
    iv_inp_addr_assessed_total_val = NULL                                             => 0.0060934270,
                                                                                         0.0060934270);

final_score_212 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 38775 => -0.0189641040,
    iv_purch_sold_assess_val_diff > 38775                                           => final_score_212_c949,
    iv_purch_sold_assess_val_diff = NULL                                            => 0.0004958011,
                                                                                       -0.0000746868);

final_score_213_c953 := map(
    NULL < iv_bst_addr_avm_change_3yr AND iv_bst_addr_avm_change_3yr <= 1813 => 0.0909864039,
    iv_bst_addr_avm_change_3yr > 1813                                        => 0.0037741578,
    iv_bst_addr_avm_change_3yr = NULL                                        => 0.0209674128,
                                                                                0.0228411689);

final_score_213_c952 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 127.5 => 0.0009725341,
    iv_mos_since_prop1_sale > 127.5                                     => final_score_213_c953,
    iv_mos_since_prop1_sale = NULL                                      => 0.0016093770,
                                                                           0.0016093770);

final_score_213 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 85.5 => final_score_213_c952,
    iv_mos_src_property_adl_lseen > 85.5                                           => -0.0106700370,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0051715555,
                                                                                      -0.0005500246);

final_score_214_c956 := map(
    iv_ams_college_tier <> '  ' 
		  and NULL < (real)iv_ams_college_tier AND (real)iv_ams_college_tier <= 5.5 => -0.0064356119,
    (real)iv_ams_college_tier > 5.5                                 => 0.0680746602,
    iv_ams_college_tier = '  '                                => -0.0053841118,
                                                                 -0.0053841118);

final_score_214_c955 := map(
    iv_bst_addr_naprop <> ' '
		  AND NULL < (real)iv_bst_addr_naprop AND (real)iv_bst_addr_naprop <= 3.5 => 0.0049631831,
    (real)iv_bst_addr_naprop > 3.5                                => final_score_214_c956,
    iv_bst_addr_naprop = ' '                               => 0.0053831966,
                                                               0.0024777785);

final_score_214 := map(
    NULL < iv_mos_since_lname_change AND iv_mos_since_lname_change <= 38.5 => final_score_214_c955,
    iv_mos_since_lname_change > 38.5                                       => -0.0257478323,
    iv_mos_since_lname_change = NULL                                       => -0.0052855480,
                                                                              0.0012524294);

final_score_215_c959 := map(
    NULL < iv_phones_per_addr_c6 AND iv_phones_per_addr_c6 <= 0.5 => -0.0154708612,
    iv_phones_per_addr_c6 > 0.5                                   => -0.1083860785,
    iv_phones_per_addr_c6 = NULL                                  => -0.0254419406,
                                                                     -0.0254419406);

final_score_215_c958 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 6.4120562963 => final_score_215_c959,
    iv_bst_addr_mtg_avm_pct_diff > 6.4120562963                                          => 0.0413978406,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                  => -0.0465103799,
                                                                                            -0.0232558436);

final_score_215 := map(
    (iv_bst_addr_financing_type in ['ADJ', 'OTH'])  => final_score_215_c958,
    (iv_bst_addr_financing_type in ['CNV', 'NONE']) => -0.0010857572,
    iv_bst_addr_financing_type = ''               => 0.0145713761,
                                                       -0.0016056454);

final_score_216_c961 := map(
    NULL < iv_avg_lres AND iv_avg_lres <= 211.5 => -0.0163489080,
    iv_avg_lres > 211.5                         => -0.0692965049,
    iv_avg_lres = NULL                          => -0.0210930126,
                                                   -0.0210930126);

final_score_216_c962 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 93.45 => -0.0007417921,
    iv_sr001_source_profile > 93.45                                     => -0.0590188056,
    iv_sr001_source_profile = NULL                                      => -0.0008840693,
                                                                           -0.0008840693);

final_score_216 := map(
    (iv_bst_addr_financing_type in ['ADJ', 'OTH'])  => final_score_216_c961,
    (iv_bst_addr_financing_type in ['CNV', 'NONE']) => final_score_216_c962,
    iv_bst_addr_financing_type = ''               => -0.0097041909,
                                                       -0.0018910000);

final_score_217_c965 := map(
    NULL < iv_prop_sold_assessed_total AND iv_prop_sold_assessed_total <= 38035 => -0.0257641641,
    iv_prop_sold_assessed_total > 38035                                         => 0.1044830683,
    iv_prop_sold_assessed_total = NULL                                          => 0.0020733879,
                                                                                   0.0020733879);

final_score_217_c964 := map(
    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen <= 101.5 => 0.0092314103,
    iv_mos_since_infutor_last_seen > 101.5                                            => 0.1631112577,
    iv_mos_since_infutor_last_seen = NULL                                             => final_score_217_c965,
                                                                                         0.0116651203);

final_score_217 := map(
    (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed', '3 - BK Other']) => -0.0023058578,
    (iv_db001_bankruptcy in ['1 - BK Discharged'])                             => final_score_217_c964,
    iv_db001_bankruptcy = ''                                                 => -0.0255014910,
                                                                                  -0.0011732515);

final_score_218_c968 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 88.5 => 0.0129636648,
    iv_mos_src_bureau_lname_fseen > 88.5                                           => -0.0172471803,
    iv_mos_src_bureau_lname_fseen = NULL                                           => -0.0058945903,
                                                                                      -0.0058945903);

final_score_218_c967 := map(
    NULL < iv_src_bureau_ssn_count AND iv_src_bureau_ssn_count <= 6.5 => final_score_218_c968,
    iv_src_bureau_ssn_count > 6.5                                     => 0.0071664534,
    iv_src_bureau_ssn_count = NULL                                    => 0.0038090943,
                                                                         0.0038090943);

final_score_218 := map(
    NULL < iv_hist_addr_match AND iv_hist_addr_match <= 0.5 => -0.0093399223,
    iv_hist_addr_match > 0.5                                => final_score_218_c967,
    iv_hist_addr_match = NULL                               => 0.0014880827,
                                                               -0.0000379270);

final_score_219_c971 := map(
    NULL < iv_pl001_bst_addr_lres AND iv_pl001_bst_addr_lres <= 176.5 => -0.0111346054,
    iv_pl001_bst_addr_lres > 176.5                                    => 0.0187926727,
    iv_pl001_bst_addr_lres = NULL                                     => -0.0075539356,
                                                                         -0.0075539356);

final_score_219_c970 := map(
    NULL < iv_max_lres AND iv_max_lres <= 375.5 => final_score_219_c971,
    iv_max_lres > 375.5                         => -0.0782550155,
    iv_max_lres = NULL                          => -0.0084855480,
                                                   -0.0084855480);

final_score_219 := map(
    NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen <= -0.5 => final_score_219_c970,
    iv_mos_src_bureau_addr_fseen > -0.5                                          => 0.0045580017,
    iv_mos_src_bureau_addr_fseen = NULL                                          => 0.0044762434,
                                                                                    0.0003200788);

final_score_220_c973 := map(
    NULL < iv_attr_purchase_recency AND iv_attr_purchase_recency <= 79.5 => 0.0061850303,
    iv_attr_purchase_recency > 79.5                                      => -0.0896052770,
    iv_attr_purchase_recency = NULL                                      => -0.0426763080,
                                                                            -0.0426763080);

final_score_220_c974 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 1.03265786945 => 0.0583103393,
    iv_inp_addr_avm_pct_change_1yr > 1.03265786945                                            => -0.0585346990,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                     => -0.0111713473,
                                                                                                 -0.0109849983);

final_score_220 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 175.5 => 0.0000903110,
    iv_mos_since_gong_did_fst_seen > 175.5                                            => final_score_220_c973,
    iv_mos_since_gong_did_fst_seen = NULL                                             => final_score_220_c974,
                                                                                         -0.0004894198);

final_score_221_c976 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 1.0158356453 => 0.0176635392,
    iv_bst_addr_mtg_avm_pct_diff > 1.0158356453                                          => -0.0625341611,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                  => -0.0247845562,
                                                                                            -0.0266928909);

final_score_221_c977 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 2554.5 => -0.0003745228,
    iv_inp_addr_building_area > 2554.5                                       => 0.0163191091,
    iv_inp_addr_building_area = NULL                                         => 0.0004497905,
                                                                                0.0004497905);

final_score_221 := map(
    (iv_fname_eda_sourced_type in ['A'])             => final_score_221_c976,
    (iv_fname_eda_sourced_type in ['-1', 'AP', 'P']) => final_score_221_c977,
    iv_fname_eda_sourced_type = ''                 => 0.0329654738,
                                                        -0.0000667928);

final_score_222_c980 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.1046519959 => 0.0487951739,
    iv_inp_addr_avm_pct_change_3yr > 1.1046519959                                            => -0.0314597917,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                    => -0.0262788788,
                                                                                                -0.0060620582);

final_score_222_c979 := map(
    NULL < iv_ag001_age AND iv_ag001_age <= 42.5 => -0.0841413738,
    iv_ag001_age > 42.5                          => final_score_222_c980,
    iv_ag001_age = NULL                          => -0.0222913104,
                                                    -0.0222913104);

final_score_222 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 104840 => -0.0082021176,
    iv_purch_sold_assess_val_diff > 104840                                           => final_score_222_c979,
    iv_purch_sold_assess_val_diff = NULL                                             => 0.0004162861,
                                                                                        -0.0003393602);

final_score_223_c983 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 88.5 => -0.0044608561,
    iv_sr001_m_wp_adl_fs > 88.5                                  => 0.0333318340,
    iv_sr001_m_wp_adl_fs = NULL                                  => 0.0115599582,
                                                                    0.0115599582);

final_score_223_c982 := map(
    NULL < iv_pl002_addrs_per_ssn_c6 AND iv_pl002_addrs_per_ssn_c6 <= 0.5 => final_score_223_c983,
    iv_pl002_addrs_per_ssn_c6 > 0.5                                       => 0.0912916073,
    iv_pl002_addrs_per_ssn_c6 = NULL                                      => 0.0149956459,
                                                                             0.0149956459);

final_score_223 := map(
    NULL < iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen <= 2.5 => -0.0010244298,
    iv_mos_since_paw_first_seen > 2.5                                         => final_score_223_c982,
    iv_mos_since_paw_first_seen = NULL                                        => 0.0034607681,
                                                                                 -0.0000000511);

final_score_224_c985 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= 10.5 => 0.0043530267,
    iv_mos_src_voter_adl_lseen > 10.5                                        => -0.0081159625,
    iv_mos_src_voter_adl_lseen = NULL                                        => 0.0003894140,
                                                                                0.0003894140);

final_score_224_c986 := map(
    (iv_inp_addr_ownership_lvl in ['Family', 'No Ownership', 'Occupant']) => -0.0300289669,
    (iv_inp_addr_ownership_lvl in ['Applicant'])                          => 0.0529621080,
    iv_inp_addr_ownership_lvl = ''                                      => -0.0017310066,
                                                                             -0.0067885284);

final_score_224 := map(
    NULL < iv_bst_addr_fips_ratio AND iv_bst_addr_fips_ratio <= -0.5 => -0.0267485857,
    iv_bst_addr_fips_ratio > -0.5                                    => final_score_224_c985,
    iv_bst_addr_fips_ratio = NULL                                    => final_score_224_c986,
                                                                        -0.0010186447);

final_score_225_c989 := map(
    iv_prv_addr_naprop <> ' '
		  and NULL < (real)iv_prv_addr_naprop AND (real)iv_prv_addr_naprop <= 2.5 => -0.0338543296,
    (real)iv_prv_addr_naprop > 2.5                                => 0.0283649414,
    iv_prv_addr_naprop = ' '                               => -0.0229947624,
                                                               -0.0229947624);

final_score_225_c988 := map(
    NULL < iv_inp_addr_fips_ratio AND iv_inp_addr_fips_ratio <= -0.5 => final_score_225_c989,
    iv_inp_addr_fips_ratio > -0.5                                    => 0.0021878066,
    iv_inp_addr_fips_ratio = NULL                                    => 0.0009389695,
                                                                        0.0009389695);

final_score_225 := map(
    NULL < iv_liens_unrel_lt_ct AND iv_liens_unrel_lt_ct <= 0.5 => final_score_225_c988,
    iv_liens_unrel_lt_ct > 0.5                                  => -0.0386273064,
    iv_liens_unrel_lt_ct = NULL                                 => 0.0004134860,
                                                                   -0.0011491208);

final_score_226_c992 := map(
    iv_prv_addr_eda_sourced <> ' '
		  and NULL < (real)iv_prv_addr_eda_sourced AND (real)iv_prv_addr_eda_sourced <= 0.5 => -0.0001421538,
    (real)iv_prv_addr_eda_sourced > 0.5                                     => 0.0879529116,
    iv_prv_addr_eda_sourced = ' '                                    => 0.0532426439,
                                                                         0.0532426439);

final_score_226_c991 := map(
    NULL < iv_prv_addr_mortgage_amount AND iv_prv_addr_mortgage_amount <= 113450 => 0.0094835734,
    iv_prv_addr_mortgage_amount > 113450                                         => final_score_226_c992,
    iv_prv_addr_mortgage_amount = NULL                                           => 0.0134058031,
                                                                                    0.0134058031);

final_score_226 := map(
    (iv_lname_eda_sourced_type in ['-1', 'A', 'AP']) => -0.0009047771,
    (iv_lname_eda_sourced_type in ['P'])             => final_score_226_c991,
    iv_lname_eda_sourced_type = ''                 => 0.0081415641,
                                                        0.0006616639);

final_score_227_c994 := map(
    NULL < iv_pv001_bst_avm_chg_1yr AND iv_pv001_bst_avm_chg_1yr <= -44516 => -0.0540143394,
    iv_pv001_bst_avm_chg_1yr > -44516                                      => 0.0032246054,
    iv_pv001_bst_avm_chg_1yr = NULL                                        => -0.0004069197,
                                                                              0.0006861561);

final_score_227_c995 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 123.5 => -0.0384956384,
    iv_mos_since_prop1_sale > 123.5                                     => 0.0466809521,
    iv_mos_since_prop1_sale = NULL                                      => -0.0276001614,
                                                                           -0.0276001614);

final_score_227 := map(
    NULL < iv_po001_m_snc_veh_adl_fs AND iv_po001_m_snc_veh_adl_fs <= 142.5 => final_score_227_c994,
    iv_po001_m_snc_veh_adl_fs > 142.5                                       => final_score_227_c995,
    iv_po001_m_snc_veh_adl_fs = NULL                                        => -0.0055947995,
                                                                               -0.0002107622);

final_score_228_c998 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count <= 1.5 => 0.0078187235,
    iv_mi001_adlperssn_count > 1.5                                      => -0.0021118183,
    iv_mi001_adlperssn_count = NULL                                     => -0.0241569862,
                                                                           0.0033608610);

final_score_228_c997 := map(
    NULL < iv_liens_rel_ot_ct AND iv_liens_rel_ot_ct <= 3.5 => final_score_228_c998,
    iv_liens_rel_ot_ct > 3.5                                => 0.0879679344,
    iv_liens_rel_ot_ct = NULL                               => 0.0037608242,
                                                               0.0037608242);

final_score_228 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl <= 1.5 => final_score_228_c997,
    iv_inq_addrs_per_adl > 1.5                                  => -0.0139674066,
    iv_inq_addrs_per_adl = NULL                                 => 0.0037285614,
                                                                   0.0003537475);

final_score_229_c1001 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 80.75 => 0.0018626476,
    iv_sr001_source_profile > 80.75                                     => 0.0367198259,
    iv_sr001_source_profile = NULL                                      => 0.0075153785,
                                                                           0.0075153785);

final_score_229_c1000 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income <= 66500 => final_score_229_c1001,
    iv_in001_estimated_income > 66500                                       => 0.0701276099,
    iv_in001_estimated_income = NULL                                        => 0.0103327921,
                                                                               0.0103327921);

final_score_229 := map(
    NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr <= 491.5 => -0.0011307017,
    iv_dist_inp_addr_to_prv_addr > 491.5                                          => final_score_229_c1000,
    iv_dist_inp_addr_to_prv_addr = NULL                                           => 0.0049419722,
                                                                                     0.0001228087);

final_score_230_c1003 := map(
    NULL < iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen <= 123.5 => 0.0002554217,
    iv_mos_since_paw_first_seen > 123.5                                         => 0.0407055073,
    iv_mos_since_paw_first_seen = NULL                                          => 0.0005189780,
                                                                                   0.0005189780);

final_score_230_c1004 := map(
    iv_bst_own_prop_x_addr_naprop <> ' '
		  and NULL < (real)iv_bst_own_prop_x_addr_naprop AND (real)iv_bst_own_prop_x_addr_naprop <= 10.5 => -0.0094366522,
    (real)iv_bst_own_prop_x_addr_naprop > 10.5                                           => -0.0595231617,
    iv_bst_own_prop_x_addr_naprop = ' '                                           => -0.0268497876,
                                                                                      -0.0268497876);

final_score_230 := map(
    NULL < iv_prv_addr_mortgage_amount AND iv_prv_addr_mortgage_amount <= 219598 => final_score_230_c1003,
    iv_prv_addr_mortgage_amount > 219598                                         => final_score_230_c1004,
    iv_prv_addr_mortgage_amount = NULL                                           => -0.0133062952,
                                                                                    -0.0002729265);

final_score_231_c1006 := map(
    NULL < iv_bst_addr_avm_change_3yr AND iv_bst_addr_avm_change_3yr <= 36858 => 0.0035012787,
    iv_bst_addr_avm_change_3yr > 36858                                        => -0.0136487330,
    iv_bst_addr_avm_change_3yr = NULL                                         => 0.0037239005,
                                                                                 0.0021273441);

final_score_231_c1007 := map(
    NULL < iv_inp_addr_avm_change_1yr AND iv_inp_addr_avm_change_1yr <= 28049 => -0.0309195381,
    iv_inp_addr_avm_change_1yr > 28049                                        => 0.0516292740,
    iv_inp_addr_avm_change_1yr = NULL                                         => -0.0077428721,
                                                                                 -0.0155508563);

final_score_231 := map(
    NULL < iv_inq_per_addr AND iv_inq_per_addr <= 3.5 => final_score_231_c1006,
    iv_inq_per_addr > 3.5                             => final_score_231_c1007,
    iv_inq_per_addr = NULL                            => 0.0031583445,
                                                         -0.0003146658);

final_score_232_c1009 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= -76905 => -0.0706181548,
    iv_purch_sold_assess_val_diff > -76905                                           => 0.0074707106,
    iv_purch_sold_assess_val_diff = NULL                                             => -0.0084507899,
                                                                                        -0.0067606173);

final_score_232_c1010 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= 33650 => 0.0836361498,
    iv_prop1_purch_sale_diff > 33650                                      => 0.0076060870,
    iv_prop1_purch_sale_diff = NULL                                       => 0.0242408524,
                                                                             0.0242408524);

final_score_232 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= 24076.5 => final_score_232_c1009,
    iv_prop1_purch_sale_diff > 24076.5                                      => final_score_232_c1010,
    iv_prop1_purch_sale_diff = NULL                                         => 0.0013289382,
                                                                               0.0012283523);

final_score_233_c1013 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count <= 5.5 => -0.0277355803,
    iv_inp_addr_source_count > 5.5                                      => 0.0563935196,
    iv_inp_addr_source_count = NULL                                     => -0.0165866259,
                                                                           -0.0165866259);

final_score_233_c1012 := map(
    NULL < (real)iv_in001_wealth_index AND (real)iv_in001_wealth_index <= 3.5 => final_score_233_c1013,
    (real)iv_in001_wealth_index > 3.5                                   => -0.0482085613,
    (real)iv_in001_wealth_index = NULL                                  => -0.0241674492,
                                                                     -0.0241674492);

final_score_233 := map(
    (iv_bst_addr_financing_type in ['ADJ', 'OTH'])  => final_score_233_c1012,
    (iv_bst_addr_financing_type in ['CNV', 'NONE']) => 0.0007396472,
    iv_bst_addr_financing_type = ''               => 0.0011594808,
                                                       -0.0002783527);

final_score_234_c1016 := map(
    NULL < iv_bst_addr_mtg_avm_abs_diff AND iv_bst_addr_mtg_avm_abs_diff <= 131017.5 => -0.0223546074,
    iv_bst_addr_mtg_avm_abs_diff > 131017.5                                          => 0.0628329491,
    iv_bst_addr_mtg_avm_abs_diff = NULL                                              => -0.0126085670,
                                                                                        -0.0117929029);

final_score_234_c1015 := map(
    NULL < iv_inp_addr_avm_change_2yr AND iv_inp_addr_avm_change_2yr <= -14241.5 => 0.0624407442,
    iv_inp_addr_avm_change_2yr > -14241.5                                        => final_score_234_c1016,
    iv_inp_addr_avm_change_2yr = NULL                                            => 0.0098443278,
                                                                                    -0.0003372465);

final_score_234 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 105600 => final_score_234_c1015,
    iv_purch_sold_assess_val_diff > 105600                                           => -0.0260638940,
    iv_purch_sold_assess_val_diff = NULL                                             => -0.0001645143,
                                                                                        -0.0004903109);

final_score_235_c1019 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.2926024865 => 0.0368784064,
    iv_inp_addr_avm_pct_change_3yr > 1.2926024865                                            => -0.0607721698,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                    => 0.0484994764,
                                                                                                0.0141038417);

final_score_235_c1018 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr <= 14.5 => -0.0240329569,
    iv_adls_per_addr > 14.5                              => final_score_235_c1019,
    iv_adls_per_addr = NULL                              => -0.0137660323,
                                                            -0.0137660323);

final_score_235 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 163665 => 0.0017037375,
    iv_avg_prop_assess_purch_amt > 163665                                          => final_score_235_c1018,
    iv_avg_prop_assess_purch_amt = NULL                                            => 0.0098305131,
                                                                                      0.0010593220);

final_score_236_c1021 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 441255 => -0.0005477918,
    iv_prop_owned_assessed_total > 441255                                          => 0.0301775420,
    iv_prop_owned_assessed_total = NULL                                            => -0.0003199839,
                                                                                      -0.0003199839);

final_score_236_c1022 := map(
    iv_infutor_nap <> ' '
		  and NULL < (real)iv_infutor_nap AND (real)iv_infutor_nap <= 9.5 => -0.0017183774,
    (real)iv_infutor_nap > 9.5                            => 0.0726670932,
    iv_infutor_nap = ' '                           => -0.0121213371,
                                                       0.0009748797);

final_score_236 := map(
    NULL < iv_mos_since_prop2_sale AND iv_mos_since_prop2_sale <= 226.5 => final_score_236_c1021,
    iv_mos_since_prop2_sale > 226.5                                     => -0.0607825720,
    iv_mos_since_prop2_sale = NULL                                      => final_score_236_c1022,
                                                                           -0.0004541706);

final_score_237_c1024 := map(
    NULL < iv_sr001_m_bureau_adl_fs AND iv_sr001_m_bureau_adl_fs <= 332.5 => 0.0021403018,
    iv_sr001_m_bureau_adl_fs > 332.5                                      => 0.0148831064,
    iv_sr001_m_bureau_adl_fs = NULL                                       => 0.0021473043,
                                                                             0.0052251645);

final_score_237_c1025 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff <= 7875 => -0.0670989661,
    iv_prop2_purch_sale_diff > 7875                                      => 0.0448266105,
    iv_prop2_purch_sale_diff = NULL                                      => -0.0046967604,
                                                                            -0.0046517126);

final_score_237 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count <= 1.5 => final_score_237_c1024,
    iv_mi001_adlperssn_count > 1.5                                      => final_score_237_c1025,
    iv_mi001_adlperssn_count = NULL                                     => -0.0056700109,
                                                                           0.0009754324);

final_score_238_c1028 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= 7750 => 0.0283225076,
    iv_prop1_purch_sale_diff > 7750                                      => -0.0558501642,
    iv_prop1_purch_sale_diff = NULL                                      => -0.0163694763,
                                                                            -0.0162008893);

final_score_238_c1027 := map(
    iv_ams_college_code <> '  ' 
		  and NULL < (real)iv_ams_college_code AND (real)iv_ams_college_code <= 3 => final_score_238_c1028,
    (real)iv_ams_college_code > 3                                 => 0.0403770959,
    iv_ams_college_code = '  '                              => -0.0126762255,
                                                               -0.0126762255);

final_score_238 := map(
    NULL < iv_prop_owned_assessed_count AND iv_prop_owned_assessed_count <= 1.5 => 0.0006284073,
    iv_prop_owned_assessed_count > 1.5                                          => final_score_238_c1027,
    iv_prop_owned_assessed_count = NULL                                         => -0.0169192729,
                                                                                   -0.0003003757);

final_score_239_c1031 := map(
    NULL < iv_inq_dobs_per_adl AND iv_inq_dobs_per_adl <= 0.5 => 0.0364423429,
    iv_inq_dobs_per_adl > 0.5                                 => -0.0326106246,
    iv_inq_dobs_per_adl = NULL                                => 0.0078941803,
                                                                 0.0078941803);

final_score_239_c1030 := map(
    NULL < iv_bst_addr_fips_ratio AND iv_bst_addr_fips_ratio <= 1.7458995805 => final_score_239_c1031,
    iv_bst_addr_fips_ratio > 1.7458995805                                    => 0.0877828589,
    iv_bst_addr_fips_ratio = NULL                                            => 0.0174698780,
                                                                                0.0174698780);

final_score_239 := map(
    NULL < iv_inp_addr_mortgage_amount AND iv_inp_addr_mortgage_amount <= 199026 => -0.0015159782,
    iv_inp_addr_mortgage_amount > 199026                                         => final_score_239_c1030,
    iv_inp_addr_mortgage_amount = NULL                                           => 0.0181224146,
                                                                                    -0.0008548225);

final_score_240_c1034 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 113040 => 0.0115156149,
    iv_avg_prop_assess_purch_amt > 113040                                          => 0.1239950334,
    iv_avg_prop_assess_purch_amt = NULL                                            => 0.0635061017,
                                                                                      0.0635061017);

final_score_240_c1033 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen <= 126.5 => 0.0106056136,
    iv_mos_since_infutor_first_seen > 126.5                                             => final_score_240_c1034,
    iv_mos_since_infutor_first_seen = NULL                                              => -0.0287459188,
                                                                                           0.0160464785);

final_score_240 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= -41700 => -0.0072866752,
    iv_purch_sold_val_diff > -41700                                    => final_score_240_c1033,
    iv_purch_sold_val_diff = NULL                                      => -0.0010575352,
                                                                          -0.0006984803);

final_score_241_c1037 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 76095 => 0.0352791150,
    iv_avg_prop_assess_purch_amt > 76095                                          => -0.0353314570,
    iv_avg_prop_assess_purch_amt = NULL                                           => 0.0235159708,
                                                                                     0.0235159708);

final_score_241_c1036 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 233526 => final_score_241_c1037,
    iv_prv_addr_avm_auto_val > 233526                                      => 0.1138531012,
    iv_prv_addr_avm_auto_val = NULL                                        => 0.0277311879,
                                                                              0.0277311879);

final_score_241 := map(
    NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count <= 3.5 => -0.0009464499,
    iv_src_bureau_addr_count > 3.5                                      => final_score_241_c1036,
    iv_src_bureau_addr_count = NULL                                     => -0.0126532082,
                                                                           0.0001810539);

final_score_242_c1040 := map(
    NULL < iv_dob_src_ct AND iv_dob_src_ct <= 2.5 => -0.0079395954,
    iv_dob_src_ct > 2.5                           => 0.0069641730,
    iv_dob_src_ct = NULL                          => 0.0035120356,
                                                     0.0035120356);

final_score_242_c1039 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn <= 2.5 => final_score_242_c1040,
    iv_inq_per_ssn > 2.5                            => -0.0208696505,
    iv_inq_per_ssn = NULL                           => -0.0013946425,
                                                       0.0004906303);

final_score_242 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 1.5 => final_score_242_c1039,
    iv_dg001_derog_count > 1.5                                  => -0.0131162583,
    iv_dg001_derog_count = NULL                                 => -0.0078749625,
                                                                   -0.0029256686);

final_score_243_c1043 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val <= 71035 => -0.0454430535,
    iv_bst_addr_assessed_total_val > 71035                                            => 0.0317181935,
    iv_bst_addr_assessed_total_val = NULL                                             => -0.0027006718,
                                                                                         -0.0027006718);

final_score_243_c1042 := map(
    iv_prv_addr_naprop <> ' '
		  and NULL < (real)iv_prv_addr_naprop AND (real)iv_prv_addr_naprop <= 3.5 => final_score_243_c1043,
    (real)iv_prv_addr_naprop > 3.5                                => -0.0477048548,
    iv_prv_addr_naprop = ' '                               => -0.0223992240,
                                                               -0.0223992240);

final_score_243 := map(
    NULL < iv_pv001_avg_prop_prch_amt AND iv_pv001_avg_prop_prch_amt <= 209507.833335 => -0.0000217035,
    iv_pv001_avg_prop_prch_amt > 209507.833335                                        => final_score_243_c1042,
    iv_pv001_avg_prop_prch_amt = NULL                                                 => 0.0082101679,
                                                                                         -0.0002444921);

final_score_244_c1046 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 26285 => -0.0670503967,
    iv_inp_addr_assessed_total_val > 26285                                            => 0.0305799455,
    iv_inp_addr_assessed_total_val = NULL                                             => -0.0112616297,
                                                                                         -0.0112616297);

final_score_244_c1045 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 1.1043340985 => 0.0048871271,
    iv_bst_addr_avm_pct_change_3yr > 1.1043340985                                            => -0.0752362641,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                    => final_score_244_c1046,
                                                                                                -0.0287846508);

final_score_244 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 386125 => 0.0019240711,
    iv_prop_owned_assessed_total > 386125                                          => final_score_244_c1045,
    iv_prop_owned_assessed_total = NULL                                            => 0.0009731683,
                                                                                      0.0015757007);

final_score_245_c1049 := map(
    NULL < iv_combined_age AND iv_combined_age <= 55.5 => -0.0034687711,
    iv_combined_age > 55.5                             => 0.0250511239,
    iv_combined_age = NULL                             => 0.0045608087,
                                                          0.0045608087);

final_score_245_c1048 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 53470 => final_score_245_c1049,
    iv_prop_owned_assessed_total > 53470                                          => -0.0115192088,
    iv_prop_owned_assessed_total = NULL                                           => -0.0006157084,
                                                                                     -0.0006157084);

final_score_245 := map(
    NULL < iv_vp090_phn_dst_to_inp_add AND iv_vp090_phn_dst_to_inp_add <= 1659 => final_score_245_c1048,
    iv_vp090_phn_dst_to_inp_add > 1659                                         => 0.0989348323,
    iv_vp090_phn_dst_to_inp_add = NULL                                         => -0.0025870029,
                                                                                  -0.0016168275);

final_score_246_c1052 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 21.5 => 0.0077706448,
    iv_mos_src_property_adl_lseen > 21.5                                           => -0.0217979659,
    iv_mos_src_property_adl_lseen = NULL                                           => -0.0337760952,
                                                                                      0.0011476047);

final_score_246_c1051 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 248555 => final_score_246_c1052,
    iv_prop_owned_assessed_total > 248555                                          => 0.0687090487,
    iv_prop_owned_assessed_total = NULL                                            => 0.0240410496,
                                                                                      0.0025947175);

final_score_246 := map(
    NULL < iv_adls_per_phone AND iv_adls_per_phone <= 4.5 => 0.0011478780,
    iv_adls_per_phone > 4.5                               => -0.0709369102,
    iv_adls_per_phone = NULL                              => final_score_246_c1051,
                                                             0.0013258326);

final_score_247_c1055 := map(
    (iv_bst_addr_ownership_lvl in ['Applicant', 'Occupant'])  => -0.0247880917,
    (iv_bst_addr_ownership_lvl in ['Family', 'No Ownership']) => 0.0180415843,
    iv_bst_addr_ownership_lvl = ''                          => -0.0125950003,
                                                                 -0.0125950003);

final_score_247_c1054 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income <= 44500 => 0.0024375835,
    iv_in001_estimated_income > 44500                                       => final_score_247_c1055,
    iv_in001_estimated_income = NULL                                        => 0.0242480237,
                                                                               0.0008717496);

final_score_247 := map(
    NULL < iv_vp090_phn_dst_to_inp_add AND iv_vp090_phn_dst_to_inp_add <= 1664.5 => final_score_247_c1054,
    iv_vp090_phn_dst_to_inp_add > 1664.5                                         => 0.0995619575,
    iv_vp090_phn_dst_to_inp_add = NULL                                           => -0.0013721774,
                                                                                    -0.0002917351);

final_score_248_c1058 := map(
    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen <= 53.5 => 0.0216234948,
    iv_mos_since_infutor_last_seen > 53.5                                            => 0.1103019917,
    iv_mos_since_infutor_last_seen = NULL                                            => 0.0508903255,
                                                                                        0.0508903255);

final_score_248_c1057 := map(
    NULL < iv_ssns_per_addr AND iv_ssns_per_addr <= 12.5 => final_score_248_c1058,
    iv_ssns_per_addr > 12.5                              => -0.0432886386,
    iv_ssns_per_addr = NULL                              => 0.0174382304,
                                                            0.0116041448);

final_score_248 := map(
    NULL < iv_paw_dead_business_count AND iv_paw_dead_business_count <= 0.5 => -0.0007379169,
    iv_paw_dead_business_count > 0.5                                        => -0.0423513684,
    iv_paw_dead_business_count = NULL                                       => final_score_248_c1057,
                                                                               -0.0010266824);

final_score_249_c1061 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 160341.5 => 0.0923798784,
    iv_prv_addr_avm_auto_val > 160341.5                                      => 0.0020674634,
    iv_prv_addr_avm_auto_val = NULL                                          => 0.0487506924,
                                                                                0.0487506924);

final_score_249_c1060 := map(
    NULL < iv_prop_sold_assessed_total AND iv_prop_sold_assessed_total <= 333170 => 0.0016445258,
    iv_prop_sold_assessed_total > 333170                                         => final_score_249_c1061,
    iv_prop_sold_assessed_total = NULL                                           => 0.0019100463,
                                                                                    0.0019100463);

final_score_249 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 12.5 => final_score_249_c1060,
    iv_addrs_per_adl > 12.5                              => -0.0132538842,
    iv_addrs_per_adl = NULL                              => 0.0047366737,
                                                            -0.0010250210);

final_score_250_c1064 := map(
    NULL < iv_max_lres AND iv_max_lres <= 371.5 => 0.0002955938,
    iv_max_lres > 371.5                         => 0.0645731979,
    iv_max_lres = NULL                          => 0.0005120834,
                                                   0.0005120834);

final_score_250_c1063 := map(
    NULL < iv_max_lres AND iv_max_lres <= 375.5 => final_score_250_c1064,
    iv_max_lres > 375.5                         => -0.0396408328,
    iv_max_lres = NULL                          => 0.0001130308,
                                                   0.0001130308);

final_score_250 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 400.5 => final_score_250_c1063,
    iv_pl001_m_snc_prop_adl_fs > 400.5                                        => 0.0582867341,
    iv_pl001_m_snc_prop_adl_fs = NULL                                         => -0.0056220154,
                                                                                 0.0002204813);

final_score_251_c1067 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 115688.5 => 0.0707338534,
    iv_inp_addr_assessed_total_val > 115688.5                                            => -0.0370512247,
    iv_inp_addr_assessed_total_val = NULL                                                => 0.0424107672,
                                                                                            0.0424107672);

final_score_251_c1066 := map(
    NULL < iv_bst_addr_mtg_avm_abs_diff AND iv_bst_addr_mtg_avm_abs_diff <= 122110.5 => -0.0034444049,
    iv_bst_addr_mtg_avm_abs_diff > 122110.5                                          => final_score_251_c1067,
    iv_bst_addr_mtg_avm_abs_diff = NULL                                              => 0.0045737808,
                                                                                        0.0037351304);

final_score_251 := map(
    iv_infutor_nap <> ' '
		  and NULL < (real)iv_infutor_nap AND (real)iv_infutor_nap <= 10.5 => final_score_251_c1066,
    (real)iv_infutor_nap > 10.5                            => -0.0076446490,
    iv_infutor_nap = ' '                            => -0.0011974353,
                                                        0.0003909492);

final_score_252_c1070 := map(
    (iv_lname_eda_sourced_type in ['A'])             => -0.0540940090,
    (iv_lname_eda_sourced_type in ['-1', 'AP', 'P']) => 0.0045278918,
    iv_lname_eda_sourced_type = ''                 => -0.0006150156,
                                                        -0.0006150156);

final_score_252_c1069 := map(
    NULL < iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr <= 6.5 => -0.0317821143,
    iv_max_ids_per_sfd_addr > 6.5                                     => final_score_252_c1070,
    iv_max_ids_per_sfd_addr = NULL                                    => -0.0099632594,
                                                                         -0.0099632594);

final_score_252 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= 28.5 => 0.0028340723,
    iv_mos_src_voter_adl_lseen > 28.5                                        => final_score_252_c1069,
    iv_mos_src_voter_adl_lseen = NULL                                        => -0.0021145397,
                                                                                -0.0004217014);

final_score_253_c1073 := map(
    NULL < iv_inp_addr_avm_pct_change_2yr AND iv_inp_addr_avm_pct_change_2yr <= 1.08613017945 => -0.0411123873,
    iv_inp_addr_avm_pct_change_2yr > 1.08613017945                                            => 0.0356187555,
    iv_inp_addr_avm_pct_change_2yr = NULL                                                     => 0.0686547007,
                                                                                                 0.0135437897);

final_score_253_c1072 := map(
    NULL < iv_inq_per_phone AND iv_inq_per_phone <= 0.5 => 0.0009965563,
    iv_inq_per_phone > 0.5                              => -0.0414686664,
    iv_inq_per_phone = NULL                             => final_score_253_c1073,
                                                           -0.0014392844);

final_score_253 := map(
    NULL < iv_bst_addr_mtg_avm_abs_diff AND iv_bst_addr_mtg_avm_abs_diff <= 29370.5 => 0.0104203055,
    iv_bst_addr_mtg_avm_abs_diff > 29370.5                                          => final_score_253_c1072,
    iv_bst_addr_mtg_avm_abs_diff = NULL                                             => -0.0004341914,
                                                                                       0.0010069300);

final_score_254_c1076 := map(
    NULL < iv_full_name_non_phn_src_ct AND iv_full_name_non_phn_src_ct <= 6.5 => 0.0139204716,
    iv_full_name_non_phn_src_ct > 6.5                                         => 0.1347066900,
    iv_full_name_non_phn_src_ct = NULL                                        => 0.0199538286,
                                                                                 0.0199538286);

final_score_254_c1075 := map(
    NULL < iv_inq_auto_recency AND iv_inq_auto_recency <= 9 => -0.0021123715,
    iv_inq_auto_recency > 9                                 => final_score_254_c1076,
    iv_inq_auto_recency = NULL                              => -0.0156144917,
                                                               -0.0008403774);

final_score_254 := map(
    (iv_full_name_ver_sources in ['Name not Verd', 'NonPhn Only', 'Phn & NonPhn']) => final_score_254_c1075,
    (iv_full_name_ver_sources in ['Phn Only'])                                     => 0.0503153424,
    iv_full_name_ver_sources = ''                                                => -0.0099583264,
                                                                                      -0.0007331662);

final_score_255_c1079 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 90.5 => 0.0800448873,
    iv_mos_since_prop1_sale > 90.5                                     => 0.0004017507,
    iv_mos_since_prop1_sale = NULL                                     => 0.0429864482,
                                                                          0.0429864482);

final_score_255_c1078 := map(
    NULL < iv_prop_sold_purchase_total AND iv_prop_sold_purchase_total <= 329000 => -0.0001326624,
    iv_prop_sold_purchase_total > 329000                                         => final_score_255_c1079,
    iv_prop_sold_purchase_total = NULL                                           => 0.0000985469,
                                                                                    0.0000985469);

final_score_255 := map(
    NULL < iv_prop2_sale_price AND iv_prop2_sale_price <= 152950 => final_score_255_c1078,
    iv_prop2_sale_price > 152950                                 => -0.0320873189,
    iv_prop2_sale_price = NULL                                   => 0.0002819953,
                                                                    -0.0001616279);

final_score_256_c1082 := map(
    NULL < iv_ag001_age AND iv_ag001_age <= 61.5 => 0.0072830844,
    iv_ag001_age > 61.5                          => 0.1043185159,
    iv_ag001_age = NULL                          => 0.0380700735,
                                                    0.0380700735);

final_score_256_c1081 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 154.5 => -0.0119650295,
    iv_mos_since_gong_did_fst_seen > 154.5                                            => final_score_256_c1082,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0099945250,
                                                                                         -0.0099945250);

final_score_256 := map(
    NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen <= -0.5 => final_score_256_c1081,
    iv_mos_src_bureau_addr_fseen > -0.5                                          => 0.0021289781,
    iv_mos_src_bureau_addr_fseen = NULL                                          => -0.0013613781,
                                                                                    -0.0018790222);

final_score_257_c1085 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 1.1974887725 => 0.0317455255,
    iv_bst_addr_avm_pct_change_3yr > 1.1974887725                                            => -0.0605539816,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                    => 0.0367415993,
                                                                                                0.0130725426);

final_score_257_c1084 := map(
    NULL < iv_vp090_phn_dst_to_inp_add AND iv_vp090_phn_dst_to_inp_add <= 5.5 => 0.0387892281,
    iv_vp090_phn_dst_to_inp_add > 5.5                                         => -0.0471847609,
    iv_vp090_phn_dst_to_inp_add = NULL                                        => final_score_257_c1085,
                                                                                 0.0163146504);

final_score_257 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs <= 398.5 => -0.0016710001,
    iv_sr001_m_hdr_fs > 398.5                               => final_score_257_c1084,
    iv_sr001_m_hdr_fs = NULL                                => 0.0002553796,
                                                               -0.0011480225);

final_score_258_c1088 := map(
    NULL < iv_bst_addr_avm_pct_change_2yr AND iv_bst_addr_avm_pct_change_2yr <= 1.10683760685 => 0.1189907416,
    iv_bst_addr_avm_pct_change_2yr > 1.10683760685                                            => 0.0146826965,
    iv_bst_addr_avm_pct_change_2yr = NULL                                                     => 0.0306890461,
                                                                                                 0.0306890461);

final_score_258_c1087 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 1.4772917687 => -0.0109727291,
    iv_inp_addr_avm_pct_change_1yr > 1.4772917687                                            => final_score_258_c1088,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                    => -0.0012269020,
                                                                                                -0.0043461670);

final_score_258 := map(
    NULL < iv_avg_lres AND iv_avg_lres <= 97.5 => 0.0054517184,
    iv_avg_lres > 97.5                         => final_score_258_c1087,
    iv_avg_lres = NULL                         => -0.0034707939,
                                                  0.0015558985);

final_score_259_c1090 := map(
    NULL < iv_po001_m_snc_veh_adl_fs AND iv_po001_m_snc_veh_adl_fs <= 7 => -0.0163061434,
    iv_po001_m_snc_veh_adl_fs > 7                                       => -0.0712720236,
    iv_po001_m_snc_veh_adl_fs = NULL                                    => -0.0194342829,
                                                                           -0.0194342829);

final_score_259_c1091 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 90.5 => 0.0061758034,
    iv_pl002_avg_mo_per_addr > 90.5                                      => -0.0230740974,
    iv_pl002_avg_mo_per_addr = NULL                                      => -0.0097154514,
                                                                            -0.0003363721);

final_score_259 := map(
    (iv_vp100_phn_prob in ['2 Disconnected', '6 Pager', '7 PCS', '8 Pay_Phone'])      => final_score_259_c1090,
    (iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '4 Invalid', '5 Cell']) => 0.0032836658,
    iv_vp100_phn_prob = ''                                                          => final_score_259_c1091,
                                                                                         0.0007717309);

final_score_260_c1094 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.3067193676 => -0.0454959097,
    iv_inp_addr_avm_pct_change_3yr > 1.3067193676                                            => 0.0681085259,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                    => 0.0151347812,
                                                                                                0.0022258602);

final_score_260_c1093 := map(
    NULL < iv_attr_addrs_recency AND iv_attr_addrs_recency <= 90 => final_score_260_c1094,
    iv_attr_addrs_recency > 90                                   => -0.0583774200,
    iv_attr_addrs_recency = NULL                                 => -0.0214900984,
                                                                    -0.0214900984);

final_score_260 := map(
    NULL < iv_src_bankruptcy_adl_count AND iv_src_bankruptcy_adl_count <= 1.5 => 0.0014334110,
    iv_src_bankruptcy_adl_count > 1.5                                         => final_score_260_c1093,
    iv_src_bankruptcy_adl_count = NULL                                        => 0.0066777073,
                                                                                 0.0007742353);

final_score_261_c1097 := map(
    NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen <= 85.5 => 0.0488332419,
    iv_mos_since_prv_addr_lseen > 85.5                                         => 0.0046684511,
    iv_mos_since_prv_addr_lseen = NULL                                         => 0.0089513245,
                                                                                  0.0089513245);

final_score_261_c1096 := map(
    NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen <= 79.5 => -0.0022022437,
    iv_mos_since_prv_addr_lseen > 79.5                                         => final_score_261_c1097,
    iv_mos_since_prv_addr_lseen = NULL                                         => -0.0004857875,
                                                                                  -0.0004857875);

final_score_261 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 13.5 => final_score_261_c1096,
    iv_src_property_adl_count > 13.5                                       => 0.0541629338,
    iv_src_property_adl_count = NULL                                       => -0.0064765447,
                                                                              -0.0004836111);

final_score_262_c1099 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 219.5 => 0.0014056300,
    iv_mos_since_prop1_sale > 219.5                                     => -0.0611740218,
    iv_mos_since_prop1_sale = NULL                                      => 0.0011272780,
                                                                           0.0011272780);

final_score_262_c1100 := map(
    NULL < iv_pv001_bst_avm_chg_1yr AND iv_pv001_bst_avm_chg_1yr <= -5988 => 0.0180857985,
    iv_pv001_bst_avm_chg_1yr > -5988                                      => -0.0390029738,
    iv_pv001_bst_avm_chg_1yr = NULL                                       => -0.0022320853,
                                                                             -0.0176260629);

final_score_262 := map(
    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val <= 84383 => final_score_262_c1099,
    iv_prv_addr_assessed_total_val > 84383                                            => final_score_262_c1100,
    iv_prv_addr_assessed_total_val = NULL                                             => -0.0011516391,
                                                                                         -0.0001705883);

final_score_263_c1103 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 137765 => 0.0174819239,
    iv_pv001_inp_avm_autoval > 137765                                      => 0.0582932974,
    iv_pv001_inp_avm_autoval = NULL                                        => 0.0230514988,
                                                                              0.0230514988);

final_score_263_c1102 := map(
    NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 <= 0.5 => -0.0009222602,
    iv_inq_auto_count12 > 0.5                                 => final_score_263_c1103,
    iv_inq_auto_count12 = NULL                                => 0.0015121295,
                                                                 0.0015121295);

final_score_263 := map(
    NULL < iv_inq_phones_per_adl AND iv_inq_phones_per_adl <= 1.5 => final_score_263_c1102,
    iv_inq_phones_per_adl > 1.5                                   => -0.0238992016,
    iv_inq_phones_per_adl = NULL                                  => -0.0062031568,
                                                                     -0.0010536109);

final_score_264_c1106 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 172281 => 0.0907112440,
    iv_prv_addr_avm_auto_val > 172281                                      => -0.0193752524,
    iv_prv_addr_avm_auto_val = NULL                                        => 0.0351851603,
                                                                              0.0351851603);

final_score_264_c1105 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 126194 => -0.0345236288,
    iv_prv_addr_avm_auto_val > 126194                                      => final_score_264_c1106,
    iv_prv_addr_avm_auto_val = NULL                                        => -0.0217985656,
                                                                              -0.0217985656);

final_score_264 := map(
    NULL < iv_po001_m_snc_veh_adl_fs AND iv_po001_m_snc_veh_adl_fs <= 145.5 => 0.0005038540,
    iv_po001_m_snc_veh_adl_fs > 145.5                                       => final_score_264_c1105,
    iv_po001_m_snc_veh_adl_fs = NULL                                        => 0.0030689275,
                                                                               -0.0000265285);

final_score_265_c1109 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 275 => 0.0365963317,
    iv_pl001_m_snc_prop_adl_fs > 275                                        => -0.0584130503,
    iv_pl001_m_snc_prop_adl_fs = NULL                                       => 0.0259776361,
                                                                               0.0259776361);

final_score_265_c1108 := map(
    (iv_vp100_phn_prob in ['2 Disconnected', '4 Invalid', '8 Pay_Phone'])                    => -0.0912860277,
    (iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '5 Cell', '6 Pager', '7 PCS']) => final_score_265_c1109,
    iv_vp100_phn_prob = ''                                                                 => 0.0108379877,
                                                                                                0.0150220196);

final_score_265 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 58500 => final_score_265_c1108,
    iv_purch_sold_val_diff > 58500                                    => -0.0167429776,
    iv_purch_sold_val_diff = NULL                                     => -0.0004965719,
                                                                         -0.0002728627);

final_score_266_c1112 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 79580 => 0.0016485662,
    iv_pv001_inp_avm_autoval > 79580                                      => 0.0330684024,
    iv_pv001_inp_avm_autoval = NULL                                       => 0.0100611636,
                                                                             0.0100611636);

final_score_266_c1111 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 103.5 => final_score_266_c1112,
    iv_mos_src_bureau_lname_fseen > 103.5                                           => -0.0016529804,
    iv_mos_src_bureau_lname_fseen = NULL                                            => -0.0130463647,
                                                                                       0.0002181590);

final_score_266 := map(
    NULL < iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 <= 2.5 => final_score_266_c1111,
    iv_max_ids_per_sfd_addr_c6 > 2.5                                        => -0.0431118767,
    iv_max_ids_per_sfd_addr_c6 = NULL                                       => 0.0196337994,
                                                                               -0.0004680379);

final_score_267_c1115 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 56554 => 0.0049096456,
    iv_pv001_inp_avm_autoval > 56554                                      => 0.0297823991,
    iv_pv001_inp_avm_autoval = NULL                                       => 0.0150305579,
                                                                             0.0150305579);

final_score_267_c1114 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 333.5 => 0.0016726524,
    iv_mos_src_bureau_lname_fseen > 333.5                                           => final_score_267_c1115,
    iv_mos_src_bureau_lname_fseen = NULL                                            => 0.0356330257,
                                                                                       0.0054329210);

final_score_267 := map(
    NULL < iv_vp090_phn_dst_to_inp_add AND iv_vp090_phn_dst_to_inp_add <= 295.5 => final_score_267_c1114,
    iv_vp090_phn_dst_to_inp_add > 295.5                                         => -0.0229955784,
    iv_vp090_phn_dst_to_inp_add = NULL                                          => -0.0008357879,
                                                                                   0.0010398453);

final_score_268_c1118 := map(
    NULL < iv_inp_addr_mortgage_amount AND iv_inp_addr_mortgage_amount <= 62050 => 0.0117814848,
    iv_inp_addr_mortgage_amount > 62050                                         => 0.0802185970,
    iv_inp_addr_mortgage_amount = NULL                                          => 0.0215454183,
                                                                                   0.0215454183);

final_score_268_c1117 := map(
    (iv_ams_college_major in ['Business', 'No AMS Found', 'No College Found'])       => -0.0108809764,
    (iv_ams_college_major in ['Liberal Arts', 'Medical', 'Science', 'Unclassified']) => final_score_268_c1118,
    iv_ams_college_major = ''                                                      => -0.0074943673,
                                                                                        -0.0074943673);

final_score_268 := map(
    NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count <= 1.5 => final_score_268_c1117,
    iv_src_bureau_addr_count > 1.5                                      => 0.0048130458,
    iv_src_bureau_addr_count = NULL                                     => 0.0035976632,
                                                                           0.0009667404);

final_score_269_c1121 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 72.15 => 0.1015592291,
    iv_sr001_source_profile > 72.15                                     => 0.0148179217,
    iv_sr001_source_profile = NULL                                      => 0.0360306870,
                                                                           0.0360306870);

final_score_269_c1120 := map(
    NULL < iv_avg_prop_sold_assess_amt AND iv_avg_prop_sold_assess_amt <= 85920 => 0.0017612517,
    iv_avg_prop_sold_assess_amt > 85920                                         => final_score_269_c1121,
    iv_avg_prop_sold_assess_amt = NULL                                          => 0.0026870891,
                                                                                   0.0026870891);

final_score_269 := map(
    NULL < iv_attr_purchase_recency AND iv_attr_purchase_recency <= 48 => final_score_269_c1120,
    iv_attr_purchase_recency > 48                                      => -0.0058064135,
    iv_attr_purchase_recency = NULL                                    => -0.0020508598,
                                                                          -0.0002162681);

final_score_270_c1124 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 1.01211216155 => 0.0303281820,
    iv_bst_addr_mtg_avm_pct_diff > 1.01211216155                                          => -0.0248201533,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                   => 0.0176526649,
                                                                                             0.0118645610);

final_score_270_c1123 := map(
    NULL < iv_mos_src_bureau_dob_fseen AND iv_mos_src_bureau_dob_fseen <= 396.5 => final_score_270_c1124,
    iv_mos_src_bureau_dob_fseen > 396.5                                         => 0.0937838114,
    iv_mos_src_bureau_dob_fseen = NULL                                          => 0.0138919940,
                                                                                   0.0138919940);

final_score_270 := map(
    (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed', '3 - BK Other']) => -0.0018313688,
    (iv_db001_bankruptcy in ['1 - BK Discharged'])                             => final_score_270_c1123,
    iv_db001_bankruptcy = ''                                                 => 0.0039742751,
                                                                                  -0.0002805311);

final_score_271_c1127 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 111.75 => -0.0100226783,
    iv_pv001_bst_avm_chg_1yr_pct > 111.75                                          => 0.0588880403,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                            => 0.0334889356,
                                                                                      0.0210359769);

final_score_271_c1126 := map(
    NULL < iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen <= 339.5 => -0.0017753197,
    iv_mos_since_prv_addr_fseen > 339.5                                         => final_score_271_c1127,
    iv_mos_since_prv_addr_fseen = NULL                                          => -0.0012418878,
                                                                                   -0.0012418878);

final_score_271 := map(
    NULL < iv_pl001_bst_addr_lres AND iv_pl001_bst_addr_lres <= 413.5 => final_score_271_c1126,
    iv_pl001_bst_addr_lres > 413.5                                    => -0.0471866463,
    iv_pl001_bst_addr_lres = NULL                                     => 0.0030711599,
                                                                         -0.0012990815);

final_score_272_c1130 := map(
    NULL < iv_inq_ssns_per_adl AND iv_inq_ssns_per_adl <= 0.5 => -0.0091827446,
    iv_inq_ssns_per_adl > 0.5                                 => 0.1067015726,
    iv_inq_ssns_per_adl = NULL                                => 0.0643352631,
                                                                 0.0643352631);

final_score_272_c1129 := map(
    NULL < iv_non_derog_count AND iv_non_derog_count <= 5.5 => 0.0016551467,
    iv_non_derog_count > 5.5                                => final_score_272_c1130,
    iv_non_derog_count = NULL                               => -0.0179410364,
                                                               0.0021573250);

final_score_272 := map(
    NULL < iv_adls_per_phone AND iv_adls_per_phone <= 4.5 => -0.0000805675,
    iv_adls_per_phone > 4.5                               => -0.0739219863,
    iv_adls_per_phone = NULL                              => final_score_272_c1129,
                                                             0.0003072546);

final_score_273_c1133 := map(
    NULL < iv_vo_addrs_per_adl AND iv_vo_addrs_per_adl <= 3.5 => 0.0108844958,
    iv_vo_addrs_per_adl > 3.5                                 => -0.0783726053,
    iv_vo_addrs_per_adl = NULL                                => 0.0007394264,
                                                                 0.0007394264);

final_score_273_c1132 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr <= 15.5 => final_score_273_c1133,
    iv_adls_per_addr > 15.5                              => 0.0765812087,
    iv_adls_per_addr = NULL                              => 0.0177417403,
                                                            0.0177417403);

final_score_273 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 272950 => -0.0000399335,
    iv_prop_owned_assessed_total > 272950                                          => final_score_273_c1132,
    iv_prop_owned_assessed_total = NULL                                            => -0.0167860301,
                                                                                      0.0002696418);

final_score_274_c1136 := map(
    NULL < iv_attr_purchase_recency AND iv_attr_purchase_recency <= 48 => 0.0928572538,
    iv_attr_purchase_recency > 48                                      => -0.0003332858,
    iv_attr_purchase_recency = NULL                                    => 0.0416906753,
                                                                          0.0416906753);

final_score_274_c1135 := map(
    iv_prof_license_category <> ' ' 
		  and NULL < (real)iv_prof_license_category AND (real)iv_prof_license_category <= 2.5 => 0.0006081333,
    (real)iv_prof_license_category > 2.5                                      => final_score_274_c1136,
    iv_prof_license_category = ' '                                     => 0.0008770275,
                                                                           0.0015736465);

final_score_274 := map(
    NULL < iv_bst_addr_avm_change_2yr AND iv_bst_addr_avm_change_2yr <= 131560 => -0.0005518609,
    iv_bst_addr_avm_change_2yr > 131560                                        => 0.0584272772,
    iv_bst_addr_avm_change_2yr = NULL                                          => final_score_274_c1135,
                                                                                  0.0007964975);

final_score_275_c1139 := map(
    NULL < iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr <= 1.5 => -0.0316660952,
    iv_ssns_per_sfd_addr > 1.5                                  => 0.0371135221,
    iv_ssns_per_sfd_addr = NULL                                 => 0.0242533332,
                                                                   0.0242533332);

final_score_275_c1138 := map(
    NULL < iv_inp_addr_fips_ratio AND iv_inp_addr_fips_ratio <= 1.0268895182 => final_score_275_c1139,
    iv_inp_addr_fips_ratio > 1.0268895182                                    => -0.0236060789,
    iv_inp_addr_fips_ratio = NULL                                            => 0.0097373222,
                                                                                0.0097373222);

final_score_275 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 120650 => final_score_275_c1138,
    iv_purch_sold_val_diff > 120650                                    => -0.0340970649,
    iv_purch_sold_val_diff = NULL                                      => -0.0004765153,
                                                                          -0.0003071772);

final_score_276_c1141 := map(
    iv_inp_addr_mortgage_term <> '  ' 
		  and NULL < (real)iv_inp_addr_mortgage_term AND (real)iv_inp_addr_mortgage_term <= 2.5 => -0.0032745680,
    (real)iv_inp_addr_mortgage_term > 2.5                                       => 0.0068876291,
    iv_inp_addr_mortgage_term = '  '                                      => -0.0010470249,
                                                                             -0.0010470249);

final_score_276_c1142 := map(
    NULL < iv_max_lres AND iv_max_lres <= 169.5 => 0.0056143560,
    iv_max_lres > 169.5                         => -0.0757352877,
    iv_max_lres = NULL                          => -0.0360152739,
                                                   -0.0360152739);

final_score_276 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 361720 => final_score_276_c1141,
    iv_avg_prop_assess_purch_amt > 361720                                          => final_score_276_c1142,
    iv_avg_prop_assess_purch_amt = NULL                                            => 0.0138866108,
                                                                                      -0.0010827038);

final_score_277_c1145 := map(
    NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count <= 4.5 => -0.0007622875,
    iv_src_bureau_addr_count > 4.5                                      => 0.0505674379,
    iv_src_bureau_addr_count = NULL                                     => -0.0001742052,
                                                                           -0.0001742052);

final_score_277_c1144 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl <= 3.5 => final_score_277_c1145,
    iv_ms001_ssns_per_adl > 3.5                                   => -0.0612587682,
    iv_ms001_ssns_per_adl = NULL                                  => -0.0092526196,
                                                                     -0.0011139666);

final_score_277 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 607475 => final_score_277_c1144,
    iv_prop_owned_assessed_total > 607475                                          => 0.0406616706,
    iv_prop_owned_assessed_total = NULL                                            => 0.0144081409,
                                                                                      -0.0008398047);

final_score_278_c1148 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 265615 => -0.0002633053,
    iv_prop_owned_assessed_total > 265615                                          => 0.0704663715,
    iv_prop_owned_assessed_total = NULL                                            => 0.0004626857,
                                                                                      0.0004626857);

final_score_278_c1147 := map(
    NULL < iv_adls_per_phone_c6 AND iv_adls_per_phone_c6 <= 1.5 => 0.0020576178,
    iv_adls_per_phone_c6 > 1.5                                  => -0.0330460709,
    iv_adls_per_phone_c6 = NULL                                 => final_score_278_c1148,
                                                                   0.0010675773);

final_score_278 := map(
    NULL < iv_df001_mos_since_fel_ls AND iv_df001_mos_since_fel_ls <= -0.5 => final_score_278_c1147,
    iv_df001_mos_since_fel_ls > -0.5                                       => -0.0656265242,
    iv_df001_mos_since_fel_ls = NULL                                       => -0.0032548499,
                                                                              0.0001138782);

final_score_279_c1150 := map(
    NULL < iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen <= 406 => 0.0006175027,
    iv_mos_since_bst_addr_fseen > 406                                         => -0.0471856222,
    iv_mos_since_bst_addr_fseen = NULL                                        => 0.0040636833,
                                                                                 0.0004933874);

final_score_279_c1151 := map(
    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val <= 69985 => -0.0183607520,
    iv_prv_addr_assessed_total_val > 69985                                            => -0.1008822830,
    iv_prv_addr_assessed_total_val = NULL                                             => -0.0253581918,
                                                                                         -0.0253581918);

final_score_279 := map(
    NULL < iv_mos_since_lname_change AND iv_mos_since_lname_change <= 38.5 => final_score_279_c1150,
    iv_mos_since_lname_change > 38.5                                       => final_score_279_c1151,
    iv_mos_since_lname_change = NULL                                       => -0.0141780386,
                                                                              -0.0007847039);

final_score_280_c1154 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 109.5 => 0.0142682591,
    iv_mos_since_gong_did_fst_seen > 109.5                                            => -0.0587622671,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0091940366,
                                                                                         -0.0091940366);

final_score_280_c1153 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 115.4 => final_score_280_c1154,
    iv_pv001_bst_avm_chg_1yr_pct > 115.4                                          => 0.0772346611,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                           => 0.0363625829,
                                                                                     0.0215688283);

final_score_280 := map(
    NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen <= 286.5 => -0.0009557061,
    iv_mos_src_bureau_addr_fseen > 286.5                                          => final_score_280_c1153,
    iv_mos_src_bureau_addr_fseen = NULL                                           => 0.0030892050,
                                                                                     -0.0004526034);

final_score_281_c1157 := map(
    NULL < iv_attr_rel_liens_recency AND iv_attr_rel_liens_recency <= 30 => -0.0132332863,
    iv_attr_rel_liens_recency > 30                                       => 0.0321470831,
    iv_attr_rel_liens_recency = NULL                                     => -0.0084873313,
                                                                            -0.0084873313);

final_score_281_c1156 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= -46250 => -0.0292591927,
    iv_purch_sold_val_diff > -46250                                    => 0.0146951303,
    iv_purch_sold_val_diff = NULL                                      => final_score_281_c1157,
                                                                          -0.0070484042);

final_score_281 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 98360 => 0.0015128292,
    iv_prop_owned_assessed_total > 98360                                          => final_score_281_c1156,
    iv_prop_owned_assessed_total = NULL                                           => 0.0174828115,
                                                                                     0.0003523022);

final_score_282_c1160 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 62.5 => 0.0112303776,
    iv_prv_addr_lres > 62.5                              => -0.0071178148,
    iv_prv_addr_lres = NULL                              => 0.0022019840,
                                                            0.0022019840);

final_score_282_c1159 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff <= 19250 => -0.0816692938,
    iv_prop2_purch_sale_diff > 19250                                      => 0.0260341253,
    iv_prop2_purch_sale_diff = NULL                                       => final_score_282_c1160,
                                                                             0.0015244931);

final_score_282 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 12.197830798 => final_score_282_c1159,
    iv_bst_addr_mtg_avm_pct_diff > 12.197830798                                          => -0.0538753541,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                  => 0.0001568027,
                                                                                            0.0001177930);

final_score_283_c1163 := map(
    NULL < iv_bst_addr_avm_change_2yr AND iv_bst_addr_avm_change_2yr <= -2197 => 0.1322020712,
    iv_bst_addr_avm_change_2yr > -2197                                        => 0.0123649338,
    iv_bst_addr_avm_change_2yr = NULL                                         => 0.0412305509,
                                                                                 0.0415451618);

final_score_283_c1162 := map(
    NULL < iv_pl001_bst_addr_lres AND iv_pl001_bst_addr_lres <= 334 => final_score_283_c1163,
    iv_pl001_bst_addr_lres > 334                                    => -0.0498989676,
    iv_pl001_bst_addr_lres = NULL                                   => 0.0292897630,
                                                                       0.0292897630);

final_score_283 := map(
    NULL < iv_combined_age AND iv_combined_age <= 78.5 => -0.0012127717,
    iv_combined_age > 78.5                             => final_score_283_c1162,
    iv_combined_age = NULL                             => -0.0005717694,
                                                          -0.0005717694);

final_score_284_c1166 := map(
    NULL < iv_max_lres AND iv_max_lres <= 179.5 => 0.0593925963,
    iv_max_lres > 179.5                         => -0.0098102836,
    iv_max_lres = NULL                          => 0.0234500153,
                                                   0.0234500153);

final_score_284_c1165 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 35090 => -0.0219816775,
    iv_purch_sold_assess_val_diff > 35090                                           => 0.0688742609,
    iv_purch_sold_assess_val_diff = NULL                                            => final_score_284_c1166,
                                                                                       0.0246136596);

final_score_284 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 159.5 => 0.0004580754,
    iv_mos_since_prop1_sale > 159.5                                     => final_score_284_c1165,
    iv_mos_since_prop1_sale = NULL                                      => 0.0047815281,
                                                                           0.0011390401);

final_score_285_c1169 := map(
    iv_vp091_phnzip_mismatch <> ' '
		  and NULL < (real)iv_vp091_phnzip_mismatch AND (real)iv_vp091_phnzip_mismatch <= 0.5 => 0.1693446025,
    (real)iv_vp091_phnzip_mismatch > 0.5                                      => 0.0379582486,
    iv_vp091_phnzip_mismatch = ' '                                     => 0.1010919511,
                                                                           0.1010919511);

final_score_285_c1168 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 64.5 => final_score_285_c1169,
    iv_pl002_avg_mo_per_addr > 64.5                                      => -0.0341528871,
    iv_pl002_avg_mo_per_addr = NULL                                      => 0.0469314025,
                                                                            0.0469314025);

final_score_285 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen <= 127.5 => -0.0001042849,
    iv_mos_since_gong_did_lst_seen > 127.5                                            => final_score_285_c1168,
    iv_mos_since_gong_did_lst_seen = NULL                                             => 0.0003261656,
                                                                                         0.0003261656);

final_score_286_c1172 := map(
    NULL < iv_bst_addr_mortgage_amount AND iv_bst_addr_mortgage_amount <= 11995 => 0.0374257526,
    iv_bst_addr_mortgage_amount > 11995                                         => -0.0584462317,
    iv_bst_addr_mortgage_amount = NULL                                          => 0.0005519125,
                                                                                   0.0005519125);

final_score_286_c1171 := map(
    NULL < iv_inp_addr_avm_change_2yr AND iv_inp_addr_avm_change_2yr <= -4914.5 => 0.1008882951,
    iv_inp_addr_avm_change_2yr > -4914.5                                        => final_score_286_c1172,
    iv_inp_addr_avm_change_2yr = NULL                                           => 0.0244004626,
                                                                                   0.0225455737);

final_score_286 := map(
    NULL < iv_combined_age AND iv_combined_age <= 77.5 => 0.0000857016,
    iv_combined_age > 77.5                             => final_score_286_c1171,
    iv_combined_age = NULL                             => 0.0006181155,
                                                          0.0006181155);

final_score_287_c1175 := map(
    NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen <= 122.5 => -0.0169631358,
    iv_mos_since_prv_addr_lseen > 122.5                                         => 0.0039624909,
    iv_mos_since_prv_addr_lseen = NULL                                          => -0.0106055436,
                                                                                   -0.0106055436);

final_score_287_c1174 := map(
    NULL < iv_avg_lres AND iv_avg_lres <= 88.5 => 0.0083303354,
    iv_avg_lres > 88.5                         => final_score_287_c1175,
    iv_avg_lres = NULL                         => -0.0051515926,
                                                  -0.0051515926);

final_score_287 := map(
    (iv_bst_addr_ownership_lvl in ['Applicant'])                          => final_score_287_c1174,
    (iv_bst_addr_ownership_lvl in ['Family', 'No Ownership', 'Occupant']) => 0.0023734077,
    iv_bst_addr_ownership_lvl = ''                                      => -0.0125750333,
                                                                             0.0003991284);

final_score_288_c1178 := map(
    NULL < iv_src_bureau_dob_count AND iv_src_bureau_dob_count <= 7.5 => 0.0821618616,
    iv_src_bureau_dob_count > 7.5                                     => -0.0319919227,
    iv_src_bureau_dob_count = NULL                                    => 0.0055157493,
                                                                         0.0055157493);

final_score_288_c1177 := map(
    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val <= 34370 => final_score_288_c1178,
    iv_prv_addr_assessed_total_val > 34370                                            => 0.1219821294,
    iv_prv_addr_assessed_total_val = NULL                                             => 0.0357107367,
                                                                                         0.0357107367);

final_score_288 := map(
    NULL < iv_lnames_per_adl AND iv_lnames_per_adl <= 6.5 => -0.0009677151,
    iv_lnames_per_adl > 6.5                               => final_score_288_c1177,
    iv_lnames_per_adl = NULL                              => -0.0102414084,
                                                             -0.0007507207);

final_score_289_c1181 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 155315 => -0.0128370572,
    iv_avg_prop_assess_purch_amt > 155315                                          => -0.0369668908,
    iv_avg_prop_assess_purch_amt = NULL                                            => -0.0200760073,
                                                                                      -0.0200760073);

final_score_289_c1180 := map(
    NULL < iv_attr_rel_liens_recency AND iv_attr_rel_liens_recency <= 30 => final_score_289_c1181,
    iv_attr_rel_liens_recency > 30                                       => 0.0475554596,
    iv_attr_rel_liens_recency = NULL                                     => -0.0146019199,
                                                                            -0.0146019199);

final_score_289 := map(
    NULL < iv_inp_addr_mortgage_amount AND iv_inp_addr_mortgage_amount <= 158432 => 0.0002207039,
    iv_inp_addr_mortgage_amount > 158432                                         => final_score_289_c1180,
    iv_inp_addr_mortgage_amount = NULL                                           => 0.0029339824,
                                                                                    -0.0003676029);

final_score_290_c1184 := map(
    NULL < iv_inp_addr_avm_change_1yr AND iv_inp_addr_avm_change_1yr <= 14668.5 => 0.0192585805,
    iv_inp_addr_avm_change_1yr > 14668.5                                        => -0.0437170810,
    iv_inp_addr_avm_change_1yr = NULL                                           => 0.0116366167,
                                                                                   0.0094887578);

final_score_290_c1183 := map(
    (iv_lname_eda_sourced_type in ['-1', 'A', 'AP']) => -0.0031757399,
    (iv_lname_eda_sourced_type in ['P'])             => final_score_290_c1184,
    iv_lname_eda_sourced_type = ''                 => -0.0018343126,
                                                        -0.0018343126);

final_score_290 := map(
    NULL < iv_liens_rel_ft_ct AND iv_liens_rel_ft_ct <= 0.5 => final_score_290_c1183,
    iv_liens_rel_ft_ct > 0.5                                => 0.0866058051,
    iv_liens_rel_ft_ct = NULL                               => 0.0087881715,
                                                               -0.0012793647);

final_score_291_c1187 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 194825 => 0.0050993156,
    iv_prop_owned_assessed_total > 194825                                          => 0.0452749151,
    iv_prop_owned_assessed_total = NULL                                            => 0.0073439061,
                                                                                      0.0073439061);

final_score_291_c1186 := map(
    iv_vp091_phnzip_mismatch <> ' '
		  and NULL < (real)iv_vp091_phnzip_mismatch AND (real)iv_vp091_phnzip_mismatch <= 0.5 => -0.0031001915,
    (real)iv_vp091_phnzip_mismatch > 0.5                                      => final_score_291_c1187,
    iv_vp091_phnzip_mismatch = ' '                                     => -0.0028041741,
                                                                           -0.0009216408);

final_score_291 := map(
    NULL < iv_pv001_avg_prop_prch_amt AND iv_pv001_avg_prop_prch_amt <= 312902.5 => final_score_291_c1186,
    iv_pv001_avg_prop_prch_amt > 312902.5                                        => 0.0449041205,
    iv_pv001_avg_prop_prch_amt = NULL                                            => 0.0250385522,
                                                                                    -0.0005146268);

final_score_292_c1189 := map(
    NULL < iv_attr_bankruptcy_recency AND iv_attr_bankruptcy_recency <= 79.5 => -0.0025761699,
    iv_attr_bankruptcy_recency > 79.5                                        => -0.0560448541,
    iv_attr_bankruptcy_recency = NULL                                        => -0.0057530454,
                                                                                -0.0057530454);

final_score_292_c1190 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 0.7207973747 => 0.1136292468,
    iv_bst_addr_avm_pct_change_3yr > 0.7207973747                                            => 0.0059815078,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                    => 0.0465032161,
                                                                                                0.0110544498);

final_score_292 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 1.451608912 => final_score_292_c1189,
    iv_bst_addr_mtg_avm_pct_diff > 1.451608912                                          => final_score_292_c1190,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                 => -0.0020955632,
                                                                                           -0.0015112578);

final_score_293_c1193 := map(
    NULL < iv_age_at_high_issue AND iv_age_at_high_issue <= 15.5 => 0.0729835422,
    iv_age_at_high_issue > 15.5                                  => -0.0180931064,
    iv_age_at_high_issue = NULL                                  => 0.0499452410,
                                                                    0.0499452410);

final_score_293_c1192 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 12.5 => final_score_293_c1193,
    iv_mos_src_property_adl_lseen > 12.5                                           => -0.0095954105,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0185136247,
                                                                                      0.0185136247);

final_score_293 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct <= 3.5 => -0.0019012749,
    iv_addr_non_phn_src_ct > 3.5                                    => final_score_293_c1192,
    iv_addr_non_phn_src_ct = NULL                                   => -0.0028330904,
                                                                       -0.0015279915);

final_score_294_c1196 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 154.5 => -0.0036030157,
    iv_mos_since_gong_did_fst_seen > 154.5                                            => 0.0350053608,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0010918769,
                                                                                         -0.0017160679);

final_score_294_c1195 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 232.55 => 0.0054569786,
    iv_pv001_bst_avm_chg_1yr_pct > 232.55                                          => -0.0790525092,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                            => final_score_294_c1196,
                                                                                      -0.0001163288);

final_score_294 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 0.2937254902 => -0.0669594155,
    iv_bst_addr_mtg_avm_pct_diff > 0.2937254902                                          => 0.0003950309,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                  => final_score_294_c1195,
                                                                                            -0.0004516157);

final_score_295_c1199 := map(
    NULL < iv_src_bureau_lname_count AND iv_src_bureau_lname_count <= 6.5 => 0.0386382183,
    iv_src_bureau_lname_count > 6.5                                       => -0.0220761174,
    iv_src_bureau_lname_count = NULL                                      => -0.0101495021,
                                                                             -0.0101495021);

final_score_295_c1198 := map(
    NULL < iv_avg_prop_sold_assess_amt AND iv_avg_prop_sold_assess_amt <= 78116.6666665 => final_score_295_c1199,
    iv_avg_prop_sold_assess_amt > 78116.6666665                                         => -0.0581926694,
    iv_avg_prop_sold_assess_amt = NULL                                                  => -0.0175795357,
                                                                                           -0.0175795357);

final_score_295 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 136.5 => 0.0024672776,
    iv_sr001_m_wp_adl_fs > 136.5                                  => final_score_295_c1198,
    iv_sr001_m_wp_adl_fs = NULL                                   => 0.0046148629,
                                                                     0.0015873429);

final_score_296_c1202 := map(
    NULL < iv_adls_per_sfd_addr_c6 AND iv_adls_per_sfd_addr_c6 <= 0.5 => -0.0602886012,
    iv_adls_per_sfd_addr_c6 > 0.5                                     => 0.0049731245,
    iv_adls_per_sfd_addr_c6 = NULL                                    => -0.0409563542,
                                                                         -0.0409563542);

final_score_296_c1201 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 116535 => -0.0125060276,
    iv_prop_owned_assessed_total > 116535                                          => final_score_296_c1202,
    iv_prop_owned_assessed_total = NULL                                            => -0.0155344817,
                                                                                      -0.0155344817);

final_score_296 := map(
    NULL < iv_src_voter_adl_count AND iv_src_voter_adl_count <= 4.5 => 0.0008222958,
    iv_src_voter_adl_count > 4.5                                    => final_score_296_c1201,
    iv_src_voter_adl_count = NULL                                   => 0.0014244886,
                                                                       -0.0008883340);

final_score_297_c1205 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.14558550925 => 0.0867681793,
    iv_inp_addr_avm_pct_change_3yr > 1.14558550925                                            => -0.0289050466,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                     => 0.0652266756,
                                                                                                 0.0431094518);

final_score_297_c1204 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 88.55 => 0.0064169802,
    iv_sr001_source_profile > 88.55                                     => final_score_297_c1205,
    iv_sr001_source_profile = NULL                                      => 0.0076684967,
                                                                           0.0076684967);

final_score_297 := map(
    NULL < iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count <= 1.5 => -0.0027398245,
    iv_addr_lres_12mo_count > 1.5                                     => final_score_297_c1204,
    iv_addr_lres_12mo_count = NULL                                    => -0.0097726129,
                                                                         -0.0003091606);

final_score_298_c1208 := map(
    NULL < iv_mos_src_bureau_ssn_fseen AND iv_mos_src_bureau_ssn_fseen <= 254.5 => -0.0141179337,
    iv_mos_src_bureau_ssn_fseen > 254.5                                         => 0.0059759757,
    iv_mos_src_bureau_ssn_fseen = NULL                                          => 0.0020200142,
                                                                                   0.0020200142);

final_score_298_c1207 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs <= 195.5 => 0.0258749041,
    iv_sr001_m_hdr_fs > 195.5                               => final_score_298_c1208,
    iv_sr001_m_hdr_fs = NULL                                => 0.0045259681,
                                                               0.0045259681);

final_score_298 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 3.5 => -0.0049241663,
    iv_pl001_m_snc_prop_adl_fs > 3.5                                        => final_score_298_c1207,
    iv_pl001_m_snc_prop_adl_fs = NULL                                       => 0.0017976117,
                                                                               -0.0000725128);

final_score_299_c1211 := map(
    NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 <= 0.5 => -0.0126471075,
    iv_inq_auto_count12 > 0.5                                 => 0.0861686537,
    iv_inq_auto_count12 = NULL                                => 0.0003353816,
                                                                 0.0003353816);

final_score_299_c1210 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 4.3122068987 => final_score_299_c1211,
    iv_bst_addr_mtg_avm_pct_diff > 4.3122068987                                          => 0.0605263190,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                  => 0.0150292963,
                                                                                            0.0129165768);

final_score_299 := map(
    NULL < iv_avg_prop_sold_purch_amt AND iv_avg_prop_sold_purch_amt <= 45300 => -0.0005136974,
    iv_avg_prop_sold_purch_amt > 45300                                        => final_score_299_c1210,
    iv_avg_prop_sold_purch_amt = NULL                                         => -0.0115999172,
                                                                                 0.0006663953);

final_score_300_c1213 := map(
    (iv_bst_addr_ownership_lvl in ['Applicant'])                          => -0.0813367033,
    (iv_bst_addr_ownership_lvl in ['Family', 'No Ownership', 'Occupant']) => -0.0089609737,
    iv_bst_addr_ownership_lvl = ''                                      => -0.0278415988,
                                                                             -0.0278415988);

final_score_300_c1214 := map(
    NULL < iv_mos_src_bureau_adl_lseen AND iv_mos_src_bureau_adl_lseen <= 0.5 => 0.0014794688,
    iv_mos_src_bureau_adl_lseen > 0.5                                         => -0.0390981146,
    iv_mos_src_bureau_adl_lseen = NULL                                        => 0.0007775113,
                                                                                 0.0007775113);

final_score_300 := map(
    (iv_ams_college_type in ['N', 'P', 'R'])  => final_score_300_c1213,
    (iv_ams_college_type in ['-1', 'S', 'U']) => final_score_300_c1214,
    iv_ams_college_type = '  '                => -0.0016648526,
                                                 0.0004556049);

final_score_301_c1217 := map(
    NULL < iv_age_at_low_issue AND iv_age_at_low_issue <= 5.5 => 0.0110122056,
    iv_age_at_low_issue > 5.5                                 => -0.0005592974,
    iv_age_at_low_issue = NULL                                => -0.0124486487,
                                                                 0.0030389991);

final_score_301_c1216 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct <= 0.5 => final_score_301_c1217,
    iv_unreleased_liens_ct > 0.5                                    => -0.0086407365,
    iv_unreleased_liens_ct = NULL                                   => -0.0006984723,
                                                                       -0.0006984723);

final_score_301 := map(
    NULL < iv_inq_num_diff_names_per_adl AND iv_inq_num_diff_names_per_adl <= 1.5 => final_score_301_c1216,
    iv_inq_num_diff_names_per_adl > 1.5                                           => -0.0255408462,
    iv_inq_num_diff_names_per_adl = NULL                                          => -0.0006275193,
                                                                                     -0.0025734434);

final_score_302_c1219 := map(
    NULL < iv_avg_lres AND iv_avg_lres <= 348.5 => 0.0002567286,
    iv_avg_lres > 348.5                         => -0.0605869960,
    iv_avg_lres = NULL                          => 0.0001078429,
                                                   0.0001078429);

final_score_302_c1220 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen <= 123.5 => 0.0673719346,
    iv_mos_since_infutor_first_seen > 123.5                                             => 0.0185962838,
    iv_mos_since_infutor_first_seen = NULL                                              => 0.0471771037,
                                                                                           0.0471771037);

final_score_302 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 347.5 => final_score_302_c1219,
    iv_pl002_avg_mo_per_addr > 347.5                                      => final_score_302_c1220,
    iv_pl002_avg_mo_per_addr = NULL                                       => 0.0045970417,
                                                                             0.0005374694);

final_score_303_c1223 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 88.65 => -0.0117393699,
    iv_sr001_source_profile > 88.65                                     => 0.0480236095,
    iv_sr001_source_profile = NULL                                      => -0.0015611576,
                                                                           -0.0015611576);

final_score_303_c1222 := map(
    NULL < iv_inq_addrs_per_adl AND iv_inq_addrs_per_adl <= 0.5 => -0.0280042712,
    iv_inq_addrs_per_adl > 0.5                                  => final_score_303_c1223,
    iv_inq_addrs_per_adl = NULL                                 => -0.0110200426,
                                                                   -0.0110200426);

final_score_303 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count <= 5.5 => 0.0015584296,
    iv_inp_addr_source_count > 5.5                                      => final_score_303_c1222,
    iv_inp_addr_source_count = NULL                                     => 0.0230827869,
                                                                           0.0008434561);

final_score_304_c1226 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen <= 136 => 0.0077067009,
    iv_mos_since_infutor_first_seen > 136                                             => 0.1115930436,
    iv_mos_since_infutor_first_seen = NULL                                            => 0.0266408246,
                                                                                         0.0266408246);

final_score_304_c1225 := map(
    NULL < iv_fname_non_phn_src_ct AND iv_fname_non_phn_src_ct <= 6.5 => -0.0051100512,
    iv_fname_non_phn_src_ct > 6.5                                     => final_score_304_c1226,
    iv_fname_non_phn_src_ct = NULL                                    => -0.0040810028,
                                                                         -0.0040810028);

final_score_304 := map(
    NULL < iv_prv_addr_source_count AND iv_prv_addr_source_count <= 1.5 => final_score_304_c1225,
    iv_prv_addr_source_count > 1.5                                      => 0.0063423243,
    iv_prv_addr_source_count = NULL                                     => 0.0030718590,
                                                                           0.0016716330);

final_score_305_c1228 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= -35800 => -0.0273290153,
    iv_purch_sold_val_diff > -35800                                    => 0.0029203761,
    iv_purch_sold_val_diff = NULL                                      => 0.0002297563,
                                                                          -0.0000600204);

final_score_305_c1229 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val <= 46390 => -0.0722154545,
    iv_bst_addr_assessed_total_val > 46390                                            => 0.0057102711,
    iv_bst_addr_assessed_total_val = NULL                                             => -0.0513304618,
                                                                                         -0.0513304618);

final_score_305 := map(
    NULL < iv_inp_addr_fips_ratio AND iv_inp_addr_fips_ratio <= 2.44182775085 => final_score_305_c1228,
    iv_inp_addr_fips_ratio > 2.44182775085                                    => final_score_305_c1229,
    iv_inp_addr_fips_ratio = NULL                                             => 0.0087329901,
                                                                                 -0.0007445537);

final_score_306_c1232 := map(
    NULL < iv_non_derog_count AND iv_non_derog_count <= 5.5 => 0.0050699187,
    iv_non_derog_count > 5.5                                => 0.0394374740,
    iv_non_derog_count = NULL                               => 0.0176099318,
                                                               0.0083998882);

final_score_306_c1231 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 234110 => final_score_306_c1232,
    iv_inp_addr_assessed_total_val > 234110                                            => 0.0825480605,
    iv_inp_addr_assessed_total_val = NULL                                              => 0.0094990911,
                                                                                          0.0094990911);

final_score_306 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen <= 135.5 => -0.0028906292,
    iv_mos_since_infutor_first_seen > 135.5                                             => final_score_306_c1231,
    iv_mos_since_infutor_first_seen = NULL                                              => 0.0011552227,
                                                                                           0.0000054896);

final_score_307_c1235 := map(
    (iv_fname_eda_sourced_type in ['-1', 'AP']) => -0.0380768037,
    (iv_fname_eda_sourced_type in ['A', 'P'])   => 0.0238639640,
    iv_fname_eda_sourced_type = ''            => -0.0318530902,
                                                   -0.0318530902);

final_score_307_c1234 := map(
    NULL < iv_src_bureau_ssn_count AND iv_src_bureau_ssn_count <= 7.5 => final_score_307_c1235,
    iv_src_bureau_ssn_count > 7.5                                     => -0.0038119659,
    iv_src_bureau_ssn_count = NULL                                    => -0.0088476895,
                                                                         -0.0088476895);

final_score_307 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 77.5 => 0.0021918842,
    iv_mos_src_property_adl_lseen > 77.5                                           => final_score_307_c1234,
    iv_mos_src_property_adl_lseen = NULL                                           => -0.0011915129,
                                                                                      -0.0000689365);

final_score_308_c1238 := map(
    NULL < iv_inq_addrs_per_ssn AND iv_inq_addrs_per_ssn <= 0.5 => 0.0736861628,
    iv_inq_addrs_per_ssn > 0.5                                  => -0.0115205092,
    iv_inq_addrs_per_ssn = NULL                                 => 0.0382561557,
                                                                   0.0382561557);

final_score_308_c1237 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 240000.5 => -0.0029983166,
    iv_prv_addr_avm_auto_val > 240000.5                                      => final_score_308_c1238,
    iv_prv_addr_avm_auto_val = NULL                                          => 0.0025605678,
                                                                                -0.0017128941);

final_score_308 := map(
    NULL < iv_inp_addr_avm_pct_change_2yr AND iv_inp_addr_avm_pct_change_2yr <= 1.150501868 => -0.0041987725,
    iv_inp_addr_avm_pct_change_2yr > 1.150501868                                            => 0.0072147156,
    iv_inp_addr_avm_pct_change_2yr = NULL                                                   => final_score_308_c1237,
                                                                                               -0.0007431897);

final_score_309_c1241 := map(
    (iv_inp_addr_ownership_lvl in ['Applicant', 'No Ownership']) => 0.0173525704,
    (iv_inp_addr_ownership_lvl in ['Family', 'Occupant'])        => 0.1159929283,
    iv_inp_addr_ownership_lvl = ''                             => 0.0593388938,
                                                                    0.0593388938);

final_score_309_c1240 := map(
    NULL < iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr <= 19.5 => final_score_309_c1241,
    iv_adls_per_sfd_addr > 19.5                                  => -0.0428546043,
    iv_adls_per_sfd_addr = NULL                                  => 0.0267404615,
                                                                    0.0267404615);

final_score_309 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 7.5 => final_score_309_c1240,
    iv_pl002_avg_mo_per_addr > 7.5                                      => 0.0003579140,
    iv_pl002_avg_mo_per_addr = NULL                                     => -0.0137945185,
                                                                           0.0004612562);

final_score_310_c1243 := map(
    iv_infutor_nap <> ' ' 
		  and NULL < (real)iv_infutor_nap AND (real)iv_infutor_nap <= 11.5 => 0.0086955227,
    (real)iv_infutor_nap > 11.5                            => -0.0099025805,
    iv_infutor_nap = ' '                            => -0.0001536942,
                                                        0.0035924595);

final_score_310_c1244 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 103.5 => -0.0162134676,
    iv_sr001_m_wp_adl_fs > 103.5                                  => 0.0059024934,
    iv_sr001_m_wp_adl_fs = NULL                                   => -0.0073181427,
                                                                     -0.0073181427);

final_score_310 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen <= 9.5 => final_score_310_c1243,
    iv_mos_since_gong_did_lst_seen > 9.5                                            => final_score_310_c1244,
    iv_mos_since_gong_did_lst_seen = NULL                                           => -0.0002096675,
                                                                                       -0.0002096675);

final_score_311_c1246 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.1228185035 => -0.0269298115,
    iv_inp_addr_avm_pct_change_3yr > 1.1228185035                                            => 0.0591982696,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                    => 0.0332947263,
                                                                                                0.0235254897);

final_score_311_c1247 := map(
    NULL < iv_adls_per_sfd_addr_c6 AND iv_adls_per_sfd_addr_c6 <= 0.5 => 0.0036834630,
    iv_adls_per_sfd_addr_c6 > 0.5                                     => -0.0080303409,
    iv_adls_per_sfd_addr_c6 = NULL                                    => -0.0013945103,
                                                                         0.0007612965);

final_score_311 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff <= 13787.5 => -0.0336405918,
    iv_prop2_purch_sale_diff > 13787.5                                      => final_score_311_c1246,
    iv_prop2_purch_sale_diff = NULL                                         => final_score_311_c1247,
                                                                               0.0006798316);

final_score_312_c1250 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 5945 => 0.1439618379,
    iv_bst_addr_building_area > 5945                                       => 0.0074641501,
    iv_bst_addr_building_area = NULL                                       => 0.0438160147,
                                                                              0.0438160147);

final_score_312_c1249 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 4473.5 => 0.0029953019,
    iv_bst_addr_building_area > 4473.5                                       => final_score_312_c1250,
    iv_bst_addr_building_area = NULL                                         => 0.0035094708,
                                                                                0.0035094708);

final_score_312 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= -0.5 => -0.0075940386,
    iv_mos_src_voter_adl_lseen > -0.5                                        => final_score_312_c1249,
    iv_mos_src_voter_adl_lseen = NULL                                        => 0.0086070311,
                                                                                -0.0000518539);

final_score_313_c1252 := map(
    NULL < iv_prop_owned_purchase_total AND iv_prop_owned_purchase_total <= 453295 => 0.0020252825,
    iv_prop_owned_purchase_total > 453295                                          => -0.0640545002,
    iv_prop_owned_purchase_total = NULL                                            => 0.0018103913,
                                                                                      0.0018103913);

final_score_313_c1253 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 481811.5 => -0.0901556966,
    iv_pv001_inp_avm_autoval > 481811.5                                      => -0.0164511827,
    iv_pv001_inp_avm_autoval = NULL                                          => -0.0499532345,
                                                                                -0.0499532345);

final_score_313 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 399398 => final_score_313_c1252,
    iv_pv001_inp_avm_autoval > 399398                                      => final_score_313_c1253,
    iv_pv001_inp_avm_autoval = NULL                                        => 0.0039563069,
                                                                              0.0014309290);

final_score_314_c1256 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 1.13041371155 => -0.0376444035,
    iv_inp_addr_avm_pct_change_1yr > 1.13041371155                                            => 0.0260873924,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                     => -0.0284639933,
                                                                                                 -0.0241574286);

final_score_314_c1255 := map(
    NULL < iv_combined_age AND iv_combined_age <= 64.5 => -0.0028987063,
    iv_combined_age > 64.5                             => final_score_314_c1256,
    iv_combined_age = NULL                             => -0.0052337160,
                                                          -0.0052337160);

final_score_314 := map(
    NULL < iv_prv_addr_source_count AND iv_prv_addr_source_count <= 1.5 => final_score_314_c1255,
    iv_prv_addr_source_count > 1.5                                      => 0.0030439233,
    iv_prv_addr_source_count = NULL                                     => 0.0055012814,
                                                                           -0.0005398413);

final_score_315_c1259 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs <= 231.5 => 0.0306585933,
    iv_sr001_m_hdr_fs > 231.5                               => -0.0245509613,
    iv_sr001_m_hdr_fs = NULL                                => -0.0183938464,
                                                               -0.0183938464);

final_score_315_c1258 := map(
    NULL < iv_attr_rel_liens_recency AND iv_attr_rel_liens_recency <= 4.5 => final_score_315_c1259,
    iv_attr_rel_liens_recency > 4.5                                       => 0.0403537785,
    iv_attr_rel_liens_recency = NULL                                      => -0.0107037066,
                                                                             -0.0107037066);

final_score_315 := map(
    NULL < iv_prop_owned_assessed_count AND iv_prop_owned_assessed_count <= 1.5 => 0.0016314120,
    iv_prop_owned_assessed_count > 1.5                                          => final_score_315_c1258,
    iv_prop_owned_assessed_count = NULL                                         => 0.0138655206,
                                                                                   0.0010041992);

final_score_316_c1262 := map(
    NULL < iv_age_at_low_issue AND iv_age_at_low_issue <= -0.5 => 0.0189834025,
    iv_age_at_low_issue > -0.5                                 => -0.0086713781,
    iv_age_at_low_issue = NULL                                 => -0.0265029896,
                                                                  -0.0045467821);

final_score_316_c1261 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 111.05 => final_score_316_c1262,
    iv_pv001_bst_avm_chg_1yr_pct > 111.05                                          => 0.0053100163,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                            => 0.0029114485,
                                                                                      0.0007379122);

final_score_316 := map(
    NULL < iv_mos_src_bureau_adl_lseen AND iv_mos_src_bureau_adl_lseen <= 57.5 => final_score_316_c1261,
    iv_mos_src_bureau_adl_lseen > 57.5                                         => -0.0782358554,
    iv_mos_src_bureau_adl_lseen = NULL                                         => -0.0040210713,
                                                                                  0.0002556294);

final_score_317_c1265 := map(
    NULL < iv_unique_addr_count AND iv_unique_addr_count <= 9.5 => -0.0014694418,
    iv_unique_addr_count > 9.5                                  => 0.0860781728,
    iv_unique_addr_count = NULL                                 => 0.0060639905,
                                                                   0.0060639905);

final_score_317_c1264 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 5.0783375 => -0.0030385205,
    iv_bst_addr_mtg_avm_pct_diff > 5.0783375                                          => 0.0898977491,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                               => final_score_317_c1265,
                                                                                         0.0067061376);

final_score_317 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 105535 => final_score_317_c1264,
    iv_purch_sold_assess_val_diff > 105535                                           => -0.0272266864,
    iv_purch_sold_assess_val_diff = NULL                                             => 0.0008008613,
                                                                                        0.0007604548);

final_score_318_c1268 := map(
    NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen <= 285.5 => 0.0035618356,
    iv_mos_since_prv_addr_lseen > 285.5                                         => 0.0831468806,
    iv_mos_since_prv_addr_lseen = NULL                                          => 0.0038010199,
                                                                                   0.0038010199);

final_score_318_c1267 := map(
    NULL < iv_src_bureau_ssn_count AND iv_src_bureau_ssn_count <= 6.5 => -0.0070719012,
    iv_src_bureau_ssn_count > 6.5                                     => final_score_318_c1268,
    iv_src_bureau_ssn_count = NULL                                    => 0.0011458044,
                                                                         0.0011458044);

final_score_318 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct <= 3.5 => final_score_318_c1267,
    iv_gong_did_phone_ct > 3.5                                  => -0.0375970928,
    iv_gong_did_phone_ct = NULL                                 => -0.0013926673,
                                                                   0.0001102034);

final_score_319_c1271 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area <= 4797 => 0.0010084758,
    iv_inp_addr_building_area > 4797                                       => 0.0499613181,
    iv_inp_addr_building_area = NULL                                       => 0.0014488011,
                                                                              0.0014488011);

final_score_319_c1270 := map(
    NULL < iv_max_ids_per_addr AND iv_max_ids_per_addr <= 1.5 => -0.0130351210,
    iv_max_ids_per_addr > 1.5                                 => final_score_319_c1271,
    iv_max_ids_per_addr = NULL                                => -0.0000501619,
                                                                 -0.0000501619);

final_score_319 := map(
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                               => -0.0600746735,
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged', '3 - BK Other']) => final_score_319_c1270,
    iv_db001_bankruptcy = ''                                                  => 0.0008783207,
                                                                                   -0.0006492398);

final_score_320_c1273 := map(
    NULL < iv_pl001_bst_addr_lres AND iv_pl001_bst_addr_lres <= 351.5 => -0.0061448674,
    iv_pl001_bst_addr_lres > 351.5                                    => 0.0386674542,
    iv_pl001_bst_addr_lres = NULL                                     => -0.0053206440,
                                                                         -0.0053206440);

final_score_320_c1274 := map(
    (iv_bst_addr_financing_type in ['ADJ', 'CNV', 'OTH']) => -0.0238999670,
    (iv_bst_addr_financing_type in ['NONE'])              => 0.0060716759,
    iv_bst_addr_financing_type = ''                     => 0.0044506654,
                                                             0.0044506654);

final_score_320 := map(
    NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr <= 3.5 => final_score_320_c1273,
    iv_dist_inp_addr_to_prv_addr > 3.5                                          => final_score_320_c1274,
    iv_dist_inp_addr_to_prv_addr = NULL                                         => 0.0081844620,
                                                                                   0.0004526104);

final_score_321_c1277 := map(
    NULL < iv_mos_since_prop2_sale AND iv_mos_since_prop2_sale <= 147.5 => 0.0039812036,
    iv_mos_since_prop2_sale > 147.5                                     => 0.0463494084,
    iv_mos_since_prop2_sale = NULL                                      => 0.0050617619,
                                                                           0.0050617619);

final_score_321_c1276 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 107.5 => -0.0046203228,
    iv_mos_since_gong_did_fst_seen > 107.5                                            => final_score_321_c1277,
    iv_mos_since_gong_did_fst_seen = NULL                                             => -0.0015033819,
                                                                                         -0.0015033819);

final_score_321 := map(
    NULL < iv_attr_proflic_exp_recency AND iv_attr_proflic_exp_recency <= 0.5 => final_score_321_c1276,
    iv_attr_proflic_exp_recency > 0.5                                         => 0.0681645401,
    iv_attr_proflic_exp_recency = NULL                                        => -0.0042041200,
                                                                                 -0.0013501776);

final_score_322_c1280 := map(
    NULL < iv_prop_owned_purchase_total AND iv_prop_owned_purchase_total <= 230500 => 0.0055084551,
    iv_prop_owned_purchase_total > 230500                                          => -0.0493842678,
    iv_prop_owned_purchase_total = NULL                                            => 0.0046687643,
                                                                                      0.0046687643);

final_score_322_c1279 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 173.5 => final_score_322_c1280,
    iv_mos_since_gong_did_fst_seen > 173.5                                            => -0.0510141818,
    iv_mos_since_gong_did_fst_seen = NULL                                             => 0.0034970081,
                                                                                         0.0034970081);

final_score_322 := map(
    NULL < iv_bst_addr_mtg_avm_abs_diff AND iv_bst_addr_mtg_avm_abs_diff <= -40025 => -0.0241905152,
    iv_bst_addr_mtg_avm_abs_diff > -40025                                          => final_score_322_c1279,
    iv_bst_addr_mtg_avm_abs_diff = NULL                                            => -0.0008663267,
                                                                                      -0.0003967653);

final_score_323_c1283 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr <= 12534 => 0.0187286976,
    iv_inp_addr_avm_change_3yr > 12534                                        => 0.0877219530,
    iv_inp_addr_avm_change_3yr = NULL                                         => 0.0329187997,
                                                                                 0.0329187997);

final_score_323_c1282 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 146.5 => 0.0043206490,
    iv_mos_since_prop1_sale > 146.5                                     => final_score_323_c1283,
    iv_mos_since_prop1_sale = NULL                                      => 0.0282761530,
                                                                           0.0061399488);

final_score_323 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.15034246605 => final_score_323_c1282,
    iv_inp_addr_avm_pct_change_3yr > 1.15034246605                                            => -0.0065453331,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                     => -0.0020533068,
                                                                                                 -0.0010899383);

final_score_324_c1286 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 34908 => 0.0456274659,
    iv_prv_addr_avm_auto_val > 34908                                      => 0.0043089266,
    iv_prv_addr_avm_auto_val = NULL                                       => 0.0224090525,
                                                                             0.0224090525);

final_score_324_c1285 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 51.5 => final_score_324_c1286,
    iv_mos_src_property_adl_lseen > 51.5                                           => -0.0126348428,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0064760962,
                                                                                      0.0064760962);

final_score_324 := map(
    NULL < iv_pv001_avg_prop_prch_amt AND iv_pv001_avg_prop_prch_amt <= 62425 => -0.0019617095,
    iv_pv001_avg_prop_prch_amt > 62425                                        => final_score_324_c1285,
    iv_pv001_avg_prop_prch_amt = NULL                                         => -0.0201269577,
                                                                                 -0.0012369648);

final_score_325_c1289 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 331 => 0.0751352155,
    iv_mos_src_bureau_lname_fseen > 331                                           => -0.0277978432,
    iv_mos_src_bureau_lname_fseen = NULL                                          => 0.0307885618,
                                                                                     0.0307885618);

final_score_325_c1288 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= -105925 => final_score_325_c1289,
    iv_purch_sold_assess_val_diff > -105925                                           => -0.0092111769,
    iv_purch_sold_assess_val_diff = NULL                                              => 0.0003898189,
                                                                                         0.0000088293);

final_score_325 := map(
    NULL < iv_purch_sold_ct_diff AND iv_purch_sold_ct_diff <= -1.5 => -0.0286044493,
    iv_purch_sold_ct_diff > -1.5                                   => final_score_325_c1288,
    iv_purch_sold_ct_diff = NULL                                   => 0.0137044575,
                                                                      -0.0003059093);

final_score_326_c1292 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 49550 => -0.0074960184,
    iv_prop_owned_assessed_total > 49550                                          => -0.0641206873,
    iv_prop_owned_assessed_total = NULL                                           => -0.0304864855,
                                                                                     -0.0304864855);

final_score_326_c1291 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 172.5 => 0.0040808586,
    iv_mos_since_gong_did_fst_seen > 172.5                                            => final_score_326_c1292,
    iv_mos_since_gong_did_fst_seen = NULL                                             => 0.0034528079,
                                                                                         0.0034528079);

final_score_326 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct <= 1.5 => final_score_326_c1291,
    iv_gong_did_phone_ct > 1.5                                  => -0.0094274341,
    iv_gong_did_phone_ct = NULL                                 => -0.0050703524,
                                                                   0.0006633574);

final_score_327_c1295 := map(
    NULL < (real)iv_prv_addr_mortgage_present AND (real)iv_prv_addr_mortgage_present <= 0.5 => 0.0086386750,
    (real)iv_prv_addr_mortgage_present > 0.5                                          => -0.0073421257,
    (real)iv_prv_addr_mortgage_present = NULL                                         => 0.0004400144,
                                                                                   0.0004400144);

final_score_327_c1294 := map(
    NULL < iv_bst_addr_avm_change_3yr AND iv_bst_addr_avm_change_3yr <= -12099.5 => -0.0194912294,
    iv_bst_addr_avm_change_3yr > -12099.5                                        => final_score_327_c1295,
    iv_bst_addr_avm_change_3yr = NULL                                            => 0.0011009867,
                                                                                    -0.0001914248);

final_score_327 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 12.5 => final_score_327_c1294,
    iv_src_property_adl_count > 12.5                                       => 0.0467942172,
    iv_src_property_adl_count = NULL                                       => 0.0045170340,
                                                                              0.0000792530);

final_score_328_c1298 := map(
    (iv_ams_file_type in ['-1', 'C']) => 0.0103341677,
    (iv_ams_file_type in ['A', 'H'])  => 0.0658441901,
    iv_ams_file_type = ''           => -0.0417214511,
                                         0.0085477606);

final_score_328_c1297 := map(
    NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen <= 44.5 => final_score_328_c1298,
    iv_mos_src_bureau_addr_fseen > 44.5                                          => -0.0256829750,
    iv_mos_src_bureau_addr_fseen = NULL                                          => -0.0041217860,
                                                                                    -0.0041217860);

final_score_328 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= -87800 => -0.0799319455,
    iv_prop1_purch_sale_diff > -87800                                      => final_score_328_c1297,
    iv_prop1_purch_sale_diff = NULL                                        => -0.0007644346,
                                                                              -0.0012476053);

final_score_329_c1301 := map(
    NULL < iv_prop_owned_purchase_total AND iv_prop_owned_purchase_total <= 239083 => 0.0035013195,
    iv_prop_owned_purchase_total > 239083                                          => -0.0256756773,
    iv_prop_owned_purchase_total = NULL                                            => 0.0030489514,
                                                                                      0.0030489514);

final_score_329_c1300 := map(
    NULL < iv_prop2_purch_sale_diff AND iv_prop2_purch_sale_diff <= 37200 => 0.0111452363,
    iv_prop2_purch_sale_diff > 37200                                      => 0.0577032958,
    iv_prop2_purch_sale_diff = NULL                                       => final_score_329_c1301,
                                                                             0.0033400744);

final_score_329 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count <= 2.5 => final_score_329_c1300,
    iv_dg001_derog_count > 2.5                                  => -0.0144821427,
    iv_dg001_derog_count = NULL                                 => -0.0004482102,
                                                                   0.0008294590);

final_score_330_c1304 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 85.25 => -0.0009321920,
    iv_sr001_source_profile > 85.25                                     => -0.0237146420,
    iv_sr001_source_profile = NULL                                      => -0.0064098455,
                                                                           -0.0064098455);

final_score_330_c1303 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 87510 => 0.0006092699,
    iv_prop_owned_assessed_total > 87510                                          => final_score_330_c1304,
    iv_prop_owned_assessed_total = NULL                                           => -0.0006058859,
                                                                                     -0.0006058859);

final_score_330 := map(
    NULL < iv_liens_unrel_ft_ct AND iv_liens_unrel_ft_ct <= 1.5 => final_score_330_c1303,
    iv_liens_unrel_ft_ct > 1.5                                  => 0.0776589481,
    iv_liens_unrel_ft_ct = NULL                                 => -0.0075422406,
                                                                   -0.0004403754);

final_score_331_c1307 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 1.0620875257 => -0.0228723104,
    iv_bst_addr_avm_pct_change_3yr > 1.0620875257                                            => 0.0385356447,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                    => 0.0184212334,
                                                                                                0.0170418406);

final_score_331_c1306 := map(
    NULL < iv_mos_since_prop2_sale AND iv_mos_since_prop2_sale <= 72.5 => -0.0033903390,
    iv_mos_since_prop2_sale > 72.5                                     => final_score_331_c1307,
    iv_mos_since_prop2_sale = NULL                                     => -0.0026785466,
                                                                          -0.0026785466);

final_score_331 := map(
    NULL < iv_paw_dead_business_count AND iv_paw_dead_business_count <= 0.5 => final_score_331_c1306,
    iv_paw_dead_business_count > 0.5                                        => -0.0407557160,
    iv_paw_dead_business_count = NULL                                       => -0.0009115572,
                                                                               -0.0031767136);

final_score_332_c1310 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 375.5 => 0.0015126611,
    iv_pl002_avg_mo_per_addr > 375.5                                      => 0.0573063136,
    iv_pl002_avg_mo_per_addr = NULL                                       => 0.0016497876,
                                                                             0.0016497876);

final_score_332_c1309 := map(
    NULL < iv_phones_per_apt_addr AND iv_phones_per_apt_addr <= 3.5 => final_score_332_c1310,
    iv_phones_per_apt_addr > 3.5                                    => -0.0223411268,
    iv_phones_per_apt_addr = NULL                                   => 0.0002976249,
                                                                       0.0002976249);

final_score_332 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 163.5 => final_score_332_c1309,
    iv_sr001_m_wp_adl_fs > 163.5                                  => -0.0530008983,
    iv_sr001_m_wp_adl_fs = NULL                                   => -0.0061965042,
                                                                     -0.0002581649);

final_score_333_c1313 := map(
    NULL < iv_lnames_per_adl AND iv_lnames_per_adl <= 1.5 => -0.0151100313,
    iv_lnames_per_adl > 1.5                               => 0.0632548137,
    iv_lnames_per_adl = NULL                              => 0.0437250169,
                                                             0.0437250169);

final_score_333_c1312 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen <= 97.5 => -0.0238400641,
    iv_mos_since_gong_did_fst_seen > 97.5                                            => final_score_333_c1313,
    iv_mos_since_gong_did_fst_seen = NULL                                            => 0.0197459033,
                                                                                        0.0197459033);

final_score_333 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 7.5 => -0.0002616341,
    iv_src_property_adl_count > 7.5                                       => final_score_333_c1312,
    iv_src_property_adl_count = NULL                                      => -0.0008439166,
                                                                             0.0001439168);

final_score_334_c1316 := map(
    NULL < iv_inp_addr_avm_change_1yr AND iv_inp_addr_avm_change_1yr <= -26240 => 0.0962990593,
    iv_inp_addr_avm_change_1yr > -26240                                        => -0.0258159584,
    iv_inp_addr_avm_change_1yr = NULL                                          => -0.0262662869,
                                                                                  -0.0211927138);

final_score_334_c1315 := map(
    NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen <= 33.5 => 0.0000428346,
    iv_mos_src_bureau_addr_fseen > 33.5                                          => final_score_334_c1316,
    iv_mos_src_bureau_addr_fseen = NULL                                          => -0.0458163157,
                                                                                    -0.0064516441);

final_score_334 := map(
    NULL < iv_adls_per_addr_c6 AND iv_adls_per_addr_c6 <= 0.5 => 0.0025968794,
    iv_adls_per_addr_c6 > 0.5                                 => final_score_334_c1315,
    iv_adls_per_addr_c6 = NULL                                => 0.0139666484,
                                                                 0.0002242731);

final_score_335_c1319 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 105535 => 0.0026968903,
    iv_purch_sold_assess_val_diff > 105535                                           => -0.0234508669,
    iv_purch_sold_assess_val_diff = NULL                                             => 0.0017653204,
                                                                                        0.0015267404);

final_score_335_c1318 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 355790 => final_score_335_c1319,
    iv_avg_prop_assess_purch_amt > 355790                                          => -0.0722184156,
    iv_avg_prop_assess_purch_amt = NULL                                            => 0.0013577559,
                                                                                      0.0013577559);

final_score_335 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 428350 => final_score_335_c1318,
    iv_avg_prop_assess_purch_amt > 428350                                          => 0.0545822675,
    iv_avg_prop_assess_purch_amt = NULL                                            => 0.0025686935,
                                                                                      0.0014865347);

final_score_336_c1322 := map(
    NULL < iv_unique_addr_count AND iv_unique_addr_count <= 13.5 => 0.0042708876,
    iv_unique_addr_count > 13.5                                  => 0.1547246110,
    iv_unique_addr_count = NULL                                  => 0.0049184289,
                                                                    0.0049184289);

final_score_336_c1321 := map(
    NULL < iv_src_bureau_lname_count AND iv_src_bureau_lname_count <= 9.5 => final_score_336_c1322,
    iv_src_bureau_lname_count > 9.5                                       => -0.0049331371,
    iv_src_bureau_lname_count = NULL                                      => -0.0022434253,
                                                                             0.0002490896);

final_score_336 := map(
    NULL < iv_inp_addr_fips_ratio AND iv_inp_addr_fips_ratio <= 2.75008001685 => final_score_336_c1321,
    iv_inp_addr_fips_ratio > 2.75008001685                                    => -0.0478317707,
    iv_inp_addr_fips_ratio = NULL                                             => 0.0017793559,
                                                                                 -0.0002214002);

final_score_337_c1325 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen <= 12.5 => 0.0474374360,
    iv_mos_src_property_adl_lseen > 12.5                                           => -0.0074643648,
    iv_mos_src_property_adl_lseen = NULL                                           => 0.0176964822,
                                                                                      0.0176964822);

final_score_337_c1324 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct <= 3.5 => -0.0007930360,
    iv_addr_non_phn_src_ct > 3.5                                    => final_score_337_c1325,
    iv_addr_non_phn_src_ct = NULL                                   => -0.0004208098,
                                                                       -0.0004208098);

final_score_337 := map(
    NULL < iv_hist_addr_match AND iv_hist_addr_match <= -0.5 => 0.0919235772,
    iv_hist_addr_match > -0.5                                => final_score_337_c1324,
    iv_hist_addr_match = NULL                                => -0.0013314446,
                                                                -0.0000261993);

final_score_338_c1327 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 9230 => -0.0149629521,
    iv_purch_sold_assess_val_diff > 9230                                           => 0.0337686766,
    iv_purch_sold_assess_val_diff = NULL                                           => -0.0011533923,
                                                                                      0.0056407598);

final_score_338_c1328 := map(
    NULL < iv_mos_src_bureau_dob_fseen AND iv_mos_src_bureau_dob_fseen <= 285.5 => 0.0273670269,
    iv_mos_src_bureau_dob_fseen > 285.5                                         => -0.0749086069,
    iv_mos_src_bureau_dob_fseen = NULL                                          => -0.0309062993,
                                                                                   -0.0309062993);

final_score_338 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 118550 => final_score_338_c1327,
    iv_purch_sold_val_diff > 118550                                    => final_score_338_c1328,
    iv_purch_sold_val_diff = NULL                                      => 0.0009758677,
                                                                          0.0009539985);

final_score_339_c1330 := map(
    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val <= 32955 => -0.0001095796,
    iv_prv_addr_assessed_total_val > 32955                                            => 0.1282185053,
    iv_prv_addr_assessed_total_val = NULL                                             => 0.0273363114,
                                                                                         0.0273363114);

final_score_339_c1331 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 78600 => -0.0056617163,
    iv_inp_addr_assessed_total_val > 78600                                            => 0.0236749109,
    iv_inp_addr_assessed_total_val = NULL                                             => 0.0136428984,
                                                                                         -0.0037478510);

final_score_339 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr <= -34894.5 => final_score_339_c1330,
    iv_inp_addr_avm_change_3yr > -34894.5                                        => -0.0010390397,
    iv_inp_addr_avm_change_3yr = NULL                                            => final_score_339_c1331,
                                                                                    -0.0021952148);

final_score_340_c1334 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 11442.5 => 0.0683229541,
    iv_purch_sold_val_diff > 11442.5                                    => -0.0556494269,
    iv_purch_sold_val_diff = NULL                                       => -0.0157161838,
                                                                           -0.0133409096);

final_score_340_c1333 := map(
    NULL < iv_src_bureau_dob_count AND iv_src_bureau_dob_count <= 8.5 => 0.0093240896,
    iv_src_bureau_dob_count > 8.5                                     => final_score_340_c1334,
    iv_src_bureau_dob_count = NULL                                    => 0.0057670664,
                                                                         0.0057670664);

final_score_340 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval <= 52108.5 => -0.0024071686,
    iv_pv001_bst_avm_autoval > 52108.5                                      => final_score_340_c1333,
    iv_pv001_bst_avm_autoval = NULL                                         => 0.0129031164,
                                                                               0.0011619473);

final_score_341_c1337 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 120650 => 0.0024592499,
    iv_purch_sold_val_diff > 120650                                    => -0.0889543952,
    iv_purch_sold_val_diff = NULL                                      => -0.0041324824,
                                                                          -0.0041324824);

final_score_341_c1336 := map(
    NULL < iv_pl001_m_snc_prop_adl_fs AND iv_pl001_m_snc_prop_adl_fs <= 274.5 => final_score_341_c1337,
    iv_pl001_m_snc_prop_adl_fs > 274.5                                        => -0.0690579338,
    iv_pl001_m_snc_prop_adl_fs = NULL                                         => -0.0108270530,
                                                                                 -0.0108270530);

final_score_341 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 193800 => final_score_341_c1336,
    iv_purch_sold_val_diff > 193800                                    => 0.0530630660,
    iv_purch_sold_val_diff = NULL                                      => -0.0000620870,
                                                                          -0.0003019320);

final_score_342_c1340 := map(
    NULL < iv_age_at_high_issue AND iv_age_at_high_issue <= 15.5 => 0.0150799466,
    iv_age_at_high_issue > 15.5                                  => -0.0273445046,
    iv_age_at_high_issue = NULL                                  => 0.0013283935,
                                                                    0.0013283935);

final_score_342_c1339 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 3.5 => 0.0789793233,
    iv_addrs_per_adl > 3.5                              => final_score_342_c1340,
    iv_addrs_per_adl = NULL                             => 0.0059669327,
                                                           0.0059669327);

final_score_342 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 9245 => -0.0237311068,
    iv_purch_sold_assess_val_diff > 9245                                           => final_score_342_c1339,
    iv_purch_sold_assess_val_diff = NULL                                           => 0.0006908113,
                                                                                      0.0001740353);

final_score_343_c1342 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 59.5 => 0.0900712072,
    iv_pl002_avg_mo_per_addr > 59.5                                      => -0.0141339907,
    iv_pl002_avg_mo_per_addr = NULL                                      => 0.0404666781,
                                                                            0.0404666781);

final_score_343_c1343 := map(
    iv_infutor_nap <> ' ' 
		  and NULL < (real)iv_infutor_nap AND (real)iv_infutor_nap <= 9.5 => -0.0018334398,
    (real)iv_infutor_nap > 9.5                            => 0.0615791745,
    iv_infutor_nap = ' '                           => -0.0214333105,
                                                       -0.0048088991);

final_score_343 := map(
    NULL < iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen <= 125.5 => 0.0008071084,
    iv_mos_since_paw_first_seen > 125.5                                         => final_score_343_c1342,
    iv_mos_since_paw_first_seen = NULL                                          => final_score_343_c1343,
                                                                                   0.0009178782);

final_score_344_c1346 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 62.5 => 0.0003896181,
    iv_pl002_avg_mo_per_addr > 62.5                                      => 0.0758610515,
    iv_pl002_avg_mo_per_addr = NULL                                      => 0.0314321496,
                                                                            0.0314321496);

final_score_344_c1345 := map(
    NULL < iv_inp_addr_avm_pct_change_2yr AND iv_inp_addr_avm_pct_change_2yr <= 1.11055055985 => final_score_344_c1346,
    iv_inp_addr_avm_pct_change_2yr > 1.11055055985                                            => 0.0036238438,
    iv_inp_addr_avm_pct_change_2yr = NULL                                                     => -0.0148117128,
                                                                                                 0.0047533716);

final_score_344 := map(
    NULL < iv_bst_addr_avm_change_2yr AND iv_bst_addr_avm_change_2yr <= 14700.5 => -0.0074072358,
    iv_bst_addr_avm_change_2yr > 14700.5                                        => final_score_344_c1345,
    iv_bst_addr_avm_change_2yr = NULL                                           => 0.0008962587,
                                                                                   -0.0009476267);

final_score_345_c1349 := map(
    NULL < iv_src_emerge_adl_count AND iv_src_emerge_adl_count <= 5.5 => 0.0010138454,
    iv_src_emerge_adl_count > 5.5                                     => -0.0273093636,
    iv_src_emerge_adl_count = NULL                                    => 0.0004243992,
                                                                         0.0004243992);

final_score_345_c1348 := map(
    NULL < iv_addr_lres_6mo_count AND iv_addr_lres_6mo_count <= 5.5 => final_score_345_c1349,
    iv_addr_lres_6mo_count > 5.5                                    => 0.1058855497,
    iv_addr_lres_6mo_count = NULL                                   => 0.0007842465,
                                                                       0.0007842465);

final_score_345 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 21.5 => final_score_345_c1348,
    iv_addrs_per_adl > 21.5                              => -0.0422365370,
    iv_addrs_per_adl = NULL                              => -0.0163787763,
                                                            -0.0007450138);

final_score_346_c1352 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 339.5 => 0.0271288728,
    iv_mos_src_bureau_lname_fseen > 339.5                                           => 0.1542996665,
    iv_mos_src_bureau_lname_fseen = NULL                                            => 0.0440295665,
                                                                                       0.0440295665);

final_score_346_c1351 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 0.9147691652 => -0.0020400291,
    iv_bst_addr_mtg_avm_pct_diff > 0.9147691652                                          => final_score_346_c1352,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                  => 0.0090537747,
                                                                                            0.0136932549);

final_score_346 := map(
    NULL < iv_inq_auto_recency AND iv_inq_auto_recency <= 2 => -0.0016631348,
    iv_inq_auto_recency > 2                                 => final_score_346_c1351,
    iv_inq_auto_recency = NULL                              => -0.0029963860,
                                                               0.0002346067);

final_score_347_c1355 := map(
    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen <= 0.5 => 0.0952061566,
    iv_mos_since_infutor_last_seen > 0.5                                            => 0.0052822407,
    iv_mos_since_infutor_last_seen = NULL                                           => 0.0607093305,
                                                                                       0.0410653506);

final_score_347_c1354 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.1168994735 => 0.0027864260,
    iv_inp_addr_avm_pct_change_3yr > 1.1168994735                                            => final_score_347_c1355,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                    => 0.0195183267,
                                                                                                0.0065824117);

final_score_347 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 1.12979539135 => final_score_347_c1354,
    iv_bst_addr_avm_pct_change_3yr > 1.12979539135                                            => -0.0046755972,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                     => 0.0000752068,
                                                                                                 0.0003870266);

final_score_348_c1358 := map(
    NULL < iv_pl001_bst_addr_lres AND iv_pl001_bst_addr_lres <= 85.5 => -0.0042630565,
    iv_pl001_bst_addr_lres > 85.5                                    => -0.0419706682,
    iv_pl001_bst_addr_lres = NULL                                    => -0.0169064588,
                                                                        -0.0169064588);

final_score_348_c1357 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val <= 102645 => -0.0001483208,
    iv_bst_addr_assessed_total_val > 102645                                            => final_score_348_c1358,
    iv_bst_addr_assessed_total_val = NULL                                              => -0.0061344105,
                                                                                          -0.0011530810);

final_score_348 := map(
    NULL < iv_pv001_avg_prop_prch_amt AND iv_pv001_avg_prop_prch_amt <= 364100 => final_score_348_c1357,
    iv_pv001_avg_prop_prch_amt > 364100                                        => 0.0544708272,
    iv_pv001_avg_prop_prch_amt = NULL                                          => -0.0198503379,
                                                                                  -0.0011728170);

final_score_349_c1361 := map(
    NULL < iv_pl001_m_snc_in_addr_fs AND iv_pl001_m_snc_in_addr_fs <= 56.5 => -0.0255621745,
    iv_pl001_m_snc_in_addr_fs > 56.5                                       => 0.0494809298,
    iv_pl001_m_snc_in_addr_fs = NULL                                       => -0.0090526916,
                                                                              -0.0090526916);

final_score_349_c1360 := map(
    NULL < iv_pl001_bst_addr_lres AND iv_pl001_bst_addr_lres <= 111.5 => final_score_349_c1361,
    iv_pl001_bst_addr_lres > 111.5                                    => -0.0473736946,
    iv_pl001_bst_addr_lres = NULL                                     => -0.0211264322,
                                                                         -0.0211264322);

final_score_349 := map(
    NULL < iv_prop_sold_purchase_total AND iv_prop_sold_purchase_total <= 173650 => 0.0014869239,
    iv_prop_sold_purchase_total > 173650                                         => final_score_349_c1360,
    iv_prop_sold_purchase_total = NULL                                           => 0.0019310582,
                                                                                    0.0008962010);

final_score_350_c1364 := map(
    (iv_inp_addr_financing_type in ['NONE'])              => -0.0506644441,
    (iv_inp_addr_financing_type in ['ADJ', 'CNV', 'OTH']) => 0.0458418708,
    iv_inp_addr_financing_type = ''                     => -0.0334799470,
                                                             -0.0334799470);

final_score_350_c1363 := map(
    NULL < iv_mos_src_bankruptcy_adl_lseen AND iv_mos_src_bankruptcy_adl_lseen <= 40.5 => 0.0060595837,
    iv_mos_src_bankruptcy_adl_lseen > 40.5                                             => final_score_350_c1364,
    iv_mos_src_bankruptcy_adl_lseen = NULL                                             => 0.0029809830,
                                                                                          0.0029809830);

final_score_350 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff <= 12.2055172015 => final_score_350_c1363,
    iv_bst_addr_mtg_avm_pct_diff > 12.2055172015                                          => -0.0431672596,
    iv_bst_addr_mtg_avm_pct_diff = NULL                                                   => -0.0015852431,
                                                                                             -0.0007956246);

final_score_351_c1367 := map(
    NULL < iv_dist_bst_addr_to_prv_addr AND iv_dist_bst_addr_to_prv_addr <= 20.5 => 0.0020706664,
    iv_dist_bst_addr_to_prv_addr > 20.5                                          => 0.0474105011,
    iv_dist_bst_addr_to_prv_addr = NULL                                          => 0.0112528821,
                                                                                    0.0112528821);

final_score_351_c1366 := map(
    NULL < iv_mos_since_prv_addr_lseen AND iv_mos_since_prv_addr_lseen <= 159.5 => final_score_351_c1367,
    iv_mos_since_prv_addr_lseen > 159.5                                         => 0.0729478308,
    iv_mos_since_prv_addr_lseen = NULL                                          => 0.0151121900,
                                                                                   0.0151121900);

final_score_351 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 130.5 => 0.0006162272,
    iv_mos_since_prop1_sale > 130.5                                     => final_score_351_c1366,
    iv_mos_since_prop1_sale = NULL                                      => -0.0048266418,
                                                                           0.0011902382);

final_score_352_c1369 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 4029 => -0.0009966097,
    iv_bst_addr_building_area > 4029                                       => -0.0852565768,
    iv_bst_addr_building_area = NULL                                       => -0.0014451681,
                                                                              -0.0014451681);

final_score_352_c1370 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val <= 250688.5 => 0.0006552050,
    iv_prv_addr_avm_auto_val > 250688.5                                      => 0.0447964891,
    iv_prv_addr_avm_auto_val = NULL                                          => 0.0024201568,
                                                                                0.0017304873);

final_score_352 := map(
    NULL < iv_pv001_bst_avm_chg_1yr AND iv_pv001_bst_avm_chg_1yr <= -45031.5 => -0.0419286636,
    iv_pv001_bst_avm_chg_1yr > -45031.5                                      => final_score_352_c1369,
    iv_pv001_bst_avm_chg_1yr = NULL                                          => final_score_352_c1370,
                                                                                -0.0002715386);

final_score_353_c1373 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val <= 31955 => -0.0177197230,
    iv_bst_addr_assessed_total_val > 31955                                            => 0.0146412021,
    iv_bst_addr_assessed_total_val = NULL                                             => -0.0012232784,
                                                                                         -0.0012232784);

final_score_353_c1372 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 285250 => final_score_353_c1373,
    iv_purch_sold_assess_val_diff > 285250                                           => 0.0669924443,
    iv_purch_sold_assess_val_diff = NULL                                             => -0.0009392093,
                                                                                        -0.0008081726);

final_score_353 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 420105 => final_score_353_c1372,
    iv_pv001_inp_avm_autoval > 420105                                      => -0.0492914545,
    iv_pv001_inp_avm_autoval = NULL                                        => 0.0233958192,
                                                                              -0.0009071280);

final_score_354_c1376 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 82166.5 => 0.0216505005,
    iv_purch_sold_val_diff > 82166.5                                    => -0.0672049621,
    iv_purch_sold_val_diff = NULL                                       => -0.0003226586,
                                                                           -0.0003418682);

final_score_354_c1375 := map(
    NULL < iv_purch_sold_assess_val_diff AND iv_purch_sold_assess_val_diff <= 279880 => -0.0017091572,
    iv_purch_sold_assess_val_diff > 279880                                           => 0.0506637960,
    iv_purch_sold_assess_val_diff = NULL                                             => final_score_354_c1376,
                                                                                        -0.0003175210);

final_score_354 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count <= 13.5 => final_score_354_c1375,
    iv_src_property_adl_count > 13.5                                       => 0.0496080694,
    iv_src_property_adl_count = NULL                                       => 0.0064816883,
                                                                              -0.0000393797);

final_score_355_c1378 := map(
    NULL < iv_ssns_per_adl_c6 AND iv_ssns_per_adl_c6 <= 0.5 => 0.0030917046,
    iv_ssns_per_adl_c6 > 0.5                                => 0.0722672676,
    iv_ssns_per_adl_c6 = NULL                               => -0.0065142234,
                                                               0.0034235860);

final_score_355_c1379 := map(
    NULL < iv_avg_prop_sold_assess_amt AND iv_avg_prop_sold_assess_amt <= 221650 => -0.0060393802,
    iv_avg_prop_sold_assess_amt > 221650                                         => -0.0781833114,
    iv_avg_prop_sold_assess_amt = NULL                                           => -0.0066660542,
                                                                                    -0.0066660542);

final_score_355 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen <= 30.5 => final_score_355_c1378,
    iv_mos_since_gong_did_lst_seen > 30.5                                            => final_score_355_c1379,
    iv_mos_since_gong_did_lst_seen = NULL                                            => 0.0003965871,
                                                                                        0.0003965871);

final_score_356_c1381 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 93.45 => 0.0015905335,
    iv_sr001_source_profile > 93.45                                     => -0.0466948003,
    iv_sr001_source_profile = NULL                                      => 0.0014653729,
                                                                           0.0014653729);

final_score_356_c1382 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 88.05 => -0.0280237321,
    iv_sr001_source_profile > 88.05                                     => 0.0757776528,
    iv_sr001_source_profile = NULL                                      => -0.0255802410,
                                                                           -0.0255802410);

final_score_356 := map(
    NULL < iv_inq_phones_per_adl AND iv_inq_phones_per_adl <= 1.5 => final_score_356_c1381,
    iv_inq_phones_per_adl > 1.5                                   => final_score_356_c1382,
    iv_inq_phones_per_adl = NULL                                  => 0.0029478307,
                                                                     -0.0010306382);

final_score_357_c1385 := map(
    NULL < iv_src_bureau_lname_count AND iv_src_bureau_lname_count <= 7.5 => 0.1367692133,
    iv_src_bureau_lname_count > 7.5                                       => 0.0143501753,
    iv_src_bureau_lname_count = NULL                                      => 0.0305070027,
                                                                             0.0305070027);

final_score_357_c1384 := map(
    NULL < iv_sr001_source_profile AND iv_sr001_source_profile <= 88.25 => 0.0026273522,
    iv_sr001_source_profile > 88.25                                     => final_score_357_c1385,
    iv_sr001_source_profile = NULL                                      => 0.0038079823,
                                                                           0.0038079823);

final_score_357 := map(
    NULL < iv_src_bureau_ssn_count AND iv_src_bureau_ssn_count <= 13.5 => -0.0043341815,
    iv_src_bureau_ssn_count > 13.5                                     => final_score_357_c1384,
    iv_src_bureau_ssn_count = NULL                                     => -0.0073214953,
                                                                          -0.0011971635);

final_score_358_c1388 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 116760 => 0.0228491793,
    iv_prop_owned_assessed_total > 116760                                          => 0.1029999152,
    iv_prop_owned_assessed_total = NULL                                            => 0.0379227354,
                                                                                      0.0379227354);

final_score_358_c1387 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 112.5 => -0.0130566534,
    iv_mos_since_prop1_sale > 112.5                                     => final_score_358_c1388,
    iv_mos_since_prop1_sale = NULL                                      => -0.0361612434,
                                                                           -0.0108227062);

final_score_358 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr <= 22.5 => 0.0038752142,
    iv_adls_per_addr > 22.5                              => final_score_358_c1387,
    iv_adls_per_addr = NULL                              => 0.0082392286,
                                                            0.0006784003);

final_score_359_c1390 := map(
    NULL < iv_bst_addr_building_area AND iv_bst_addr_building_area <= 1695.5 => -0.0020541894,
    iv_bst_addr_building_area > 1695.5                                       => -0.0178829435,
    iv_bst_addr_building_area = NULL                                         => -0.0039477299,
                                                                                -0.0039477299);

final_score_359_c1391 := map(
    NULL < iv_phones_per_sfd_addr AND iv_phones_per_sfd_addr <= 2.5 => 0.0045185957,
    iv_phones_per_sfd_addr > 2.5                                    => 0.1169084693,
    iv_phones_per_sfd_addr = NULL                                   => 0.0056848978,
                                                                       0.0056848978);

final_score_359 := map(
    NULL < iv_bst_addr_fips_ratio AND iv_bst_addr_fips_ratio <= 0.94148865545 => final_score_359_c1390,
    iv_bst_addr_fips_ratio > 0.94148865545                                    => final_score_359_c1391,
    iv_bst_addr_fips_ratio = NULL                                             => -0.0041408673,
                                                                                 -0.0011979952);

final_score_360_c1393 := map(
    NULL < iv_pv001_avg_prop_prch_amt AND iv_pv001_avg_prop_prch_amt <= 199950 => 0.0022872709,
    iv_pv001_avg_prop_prch_amt > 199950                                        => 0.0640644199,
    iv_pv001_avg_prop_prch_amt = NULL                                          => 0.0024396189,
                                                                                  0.0024396189);

final_score_360_c1394 := map(
    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen <= 2.5 => 0.0277132733,
    iv_mos_since_infutor_last_seen > 2.5                                            => -0.0414820685,
    iv_mos_since_infutor_last_seen = NULL                                           => -0.0173641900,
                                                                                       -0.0173641900);

final_score_360 := map(
    NULL < iv_pv001_avg_prop_prch_amt AND iv_pv001_avg_prop_prch_amt <= 212600 => final_score_360_c1393,
    iv_pv001_avg_prop_prch_amt > 212600                                        => final_score_360_c1394,
    iv_pv001_avg_prop_prch_amt = NULL                                          => -0.0018819345,
                                                                                  0.0021628083);

final_score_361_c1397 := map(
    NULL < iv_pv001_bst_avm_chg_1yr AND iv_pv001_bst_avm_chg_1yr <= -14454.5 => 0.0395123260,
    iv_pv001_bst_avm_chg_1yr > -14454.5                                      => 0.0027816438,
    iv_pv001_bst_avm_chg_1yr = NULL                                          => 0.0077171774,
                                                                                0.0075192077);

final_score_361_c1396 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs <= 339.5 => -0.0027024522,
    iv_sr001_m_hdr_fs > 339.5                               => final_score_361_c1397,
    iv_sr001_m_hdr_fs = NULL                                => -0.0003043519,
                                                               -0.0003043519);

final_score_361 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 209.5 => final_score_361_c1396,
    iv_mos_since_prop1_sale > 209.5                                     => -0.0424442017,
    iv_mos_since_prop1_sale = NULL                                      => -0.0081066104,
                                                                           -0.0007563884);

final_score_362_c1400 := map(
    NULL < iv_max_lres AND iv_max_lres <= 317.5 => 0.0184894729,
    iv_max_lres > 317.5                         => 0.0866309690,
    iv_max_lres = NULL                          => 0.0226529044,
                                                   0.0226529044);

final_score_362_c1399 := map(
    NULL < iv_addr_phn_src_ct AND iv_addr_phn_src_ct <= 0.5 => final_score_362_c1400,
    iv_addr_phn_src_ct > 0.5                                => 0.0028194384,
    iv_addr_phn_src_ct = NULL                               => -0.0023595196,
                                                               0.0080894995);

final_score_362 := map(
    NULL < iv_inp_addr_avm_pct_change_1yr AND iv_inp_addr_avm_pct_change_1yr <= 1.01391541795 => final_score_362_c1399,
    iv_inp_addr_avm_pct_change_1yr > 1.01391541795                                            => -0.0056525361,
    iv_inp_addr_avm_pct_change_1yr = NULL                                                     => 0.0021365579,
                                                                                                 0.0011290366);

final_score_363_c1403 := map(
    NULL < iv_src_bureau_ssn_count AND iv_src_bureau_ssn_count <= 7.5 => 0.0819521114,
    iv_src_bureau_ssn_count > 7.5                                     => 0.0130519200,
    iv_src_bureau_ssn_count = NULL                                    => 0.0328011915,
                                                                         0.0328011915);

final_score_363_c1402 := map(
    (iv_nap_type in ['A']) => -0.0274901882,
    (iv_nap_type in ['P']) => final_score_363_c1403,
    iv_nap_type = ''     => 0.0081949266,
                              0.0130364264);

final_score_363 := map(
    NULL < iv_bst_addr_avm_change_2yr AND iv_bst_addr_avm_change_2yr <= -9059.5 => final_score_363_c1402,
    iv_bst_addr_avm_change_2yr > -9059.5                                        => -0.0023416010,
    iv_bst_addr_avm_change_2yr = NULL                                           => 0.0000274904,
                                                                                   -0.0001320129);

final_score_364_c1406 := map(
    NULL < iv_prop1_sale_price AND iv_prop1_sale_price <= 17383.5 => 0.0149655454,
    iv_prop1_sale_price > 17383.5                                 => -0.0210414675,
    iv_prop1_sale_price = NULL                                    => -0.0096918075,
                                                                     -0.0096918075);

final_score_364_c1405 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl <= 4.5 => -0.0620280017,
    iv_addrs_per_adl > 4.5                              => final_score_364_c1406,
    iv_addrs_per_adl = NULL                             => -0.0149072862,
                                                           -0.0149072862);

final_score_364 := map(
    NULL < iv_prop_sold_assessed_total AND iv_prop_sold_assessed_total <= 129820 => 0.0010675883,
    iv_prop_sold_assessed_total > 129820                                         => final_score_364_c1405,
    iv_prop_sold_assessed_total = NULL                                           => -0.0032653460,
                                                                                    0.0002472872);

final_score_365_c1408 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 313320 => -0.0002178492,
    iv_prop_owned_assessed_total > 313320                                          => 0.0364052759,
    iv_prop_owned_assessed_total = NULL                                            => 0.0000425067,
                                                                                      0.0000425067);

final_score_365_c1409 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr <= 1.11228839325 => 0.0278829312,
    iv_bst_addr_avm_pct_change_3yr > 1.11228839325                                            => -0.0744848833,
    iv_bst_addr_avm_pct_change_3yr = NULL                                                     => -0.0139781325,
                                                                                                 -0.0242690326);

final_score_365 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total <= 381935 => final_score_365_c1408,
    iv_prop_owned_assessed_total > 381935                                          => final_score_365_c1409,
    iv_prop_owned_assessed_total = NULL                                            => 0.0129516971,
                                                                                      -0.0001253137);

final_score_366_c1412 := map(
    NULL < iv_ssns_per_addr AND iv_ssns_per_addr <= 9.5 => 0.0050154681,
    iv_ssns_per_addr > 9.5                              => 0.1245514548,
    iv_ssns_per_addr = NULL                             => 0.0611538262,
                                                           0.0611538262);

final_score_366_c1411 := map(
    NULL < iv_po001_inp_addr_naprop AND iv_po001_inp_addr_naprop <= 1.5 => -0.0196182460,
    iv_po001_inp_addr_naprop > 1.5                                      => final_score_366_c1412,
    iv_po001_inp_addr_naprop = NULL                                     => -0.0055316558,
                                                                           0.0035659170);

final_score_366 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs <= 518.5 => 0.0000352631,
    iv_sr001_m_hdr_fs > 518.5                               => -0.0550856576,
    iv_sr001_m_hdr_fs = NULL                                => final_score_366_c1411,
                                                               -0.0000910316);

final_score_367_c1415 := map(
    NULL < iv_inp_addr_mortgage_amount AND iv_inp_addr_mortgage_amount <= 167009.5 => 0.0031043606,
    iv_inp_addr_mortgage_amount > 167009.5                                         => 0.0489574845,
    iv_inp_addr_mortgage_amount = NULL                                             => 0.0062554898,
                                                                                      0.0062554898);

final_score_367_c1414 := map(
    NULL < iv_adls_per_phone AND iv_adls_per_phone <= 0.5 => final_score_367_c1415,
    iv_adls_per_phone > 0.5                               => -0.0112720670,
    iv_adls_per_phone = NULL                              => -0.0118820220,
                                                             -0.0052473715);

final_score_367 := map(
    iv_bst_addr_naprop <> ' '
		  AND NULL < (real)iv_bst_addr_naprop AND (real)iv_bst_addr_naprop <= 3.5 => 0.0036333422,
    (real)iv_bst_addr_naprop > 3.5                                => final_score_367_c1414,
    iv_bst_addr_naprop = ' '                               => 0.0109825470,
                                                               0.0017410690);

final_score_368_c1418 := map(
    NULL < iv_inp_addr_avm_pct_change_2yr AND iv_inp_addr_avm_pct_change_2yr <= 1.014629181 => -0.0401896792,
    iv_inp_addr_avm_pct_change_2yr > 1.014629181                                            => 0.0132620493,
    iv_inp_addr_avm_pct_change_2yr = NULL                                                   => -0.0230232264,
                                                                                               -0.0148326769);

final_score_368_c1417 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val <= 55065 => final_score_368_c1418,
    iv_inp_addr_assessed_total_val > 55065                                            => -0.0707221210,
    iv_inp_addr_assessed_total_val = NULL                                             => -0.0207157763,
                                                                                         -0.0207157763);

final_score_368 := map(
    NULL < iv_pl002_avg_mo_per_addr AND iv_pl002_avg_mo_per_addr <= 226.5 => 0.0011964132,
    iv_pl002_avg_mo_per_addr > 226.5                                      => final_score_368_c1417,
    iv_pl002_avg_mo_per_addr = NULL                                       => -0.0059824311,
                                                                             0.0003056039);

final_score_369_c1421 := map(
    NULL < iv_max_lres AND iv_max_lres <= 97.5 => -0.0476916624,
    iv_max_lres > 97.5                         => 0.0580354177,
    iv_max_lres = NULL                         => 0.0264424145,
                                                  0.0264424145);

final_score_369_c1420 := map(
    NULL < iv_mos_since_prop1_sale AND iv_mos_since_prop1_sale <= 30.5 => final_score_369_c1421,
    iv_mos_since_prop1_sale > 30.5                                     => -0.0201103568,
    iv_mos_since_prop1_sale = NULL                                     => -0.0109462120,
                                                                          -0.0109462120);

final_score_369 := map(
    NULL < iv_purch_sold_val_diff AND iv_purch_sold_val_diff <= 198950 => final_score_369_c1420,
    iv_purch_sold_val_diff > 198950                                    => 0.0549480949,
    iv_purch_sold_val_diff = NULL                                      => -0.0008543976,
                                                                          -0.0010926175);

final_score_370_c1424 := map(
    NULL < iv_inp_addr_avm_pct_change_3yr AND iv_inp_addr_avm_pct_change_3yr <= 1.1914334168 => 0.0392290289,
    iv_inp_addr_avm_pct_change_3yr > 1.1914334168                                            => -0.0420184122,
    iv_inp_addr_avm_pct_change_3yr = NULL                                                    => 0.0130201769,
                                                                                                0.0130201769);

final_score_370_c1423 := map(
    NULL < iv_pv001_bst_avm_chg_1yr_pct AND iv_pv001_bst_avm_chg_1yr_pct <= 111.5 => final_score_370_c1424,
    iv_pv001_bst_avm_chg_1yr_pct > 111.5                                          => 0.0901252024,
    iv_pv001_bst_avm_chg_1yr_pct = NULL                                           => 0.0179900184,
                                                                                     0.0273431171);

final_score_370 := map(
    NULL < iv_prop1_purch_sale_diff AND iv_prop1_purch_sale_diff <= 24126.5 => -0.0055045649,
    iv_prop1_purch_sale_diff > 24126.5                                      => final_score_370_c1423,
    iv_prop1_purch_sale_diff = NULL                                         => 0.0010812892,
                                                                               0.0011027669);

final_score_371_c1427 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt <= 116205 => 0.0325243156,
    iv_avg_prop_assess_purch_amt > 116205                                          => 0.1168550325,
    iv_avg_prop_assess_purch_amt = NULL                                            => 0.0425280703,
                                                                                      0.0425280703);

final_score_371_c1426 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income <= 68500 => final_score_371_c1427,
    iv_in001_estimated_income > 68500                                       => -0.0570453627,
    iv_in001_estimated_income = NULL                                        => 0.0319687469,
                                                                               0.0319687469);

final_score_371 := map(
    NULL < iv_liens_rel_ot_ct AND iv_liens_rel_ot_ct <= 1.5 => -0.0009627850,
    iv_liens_rel_ot_ct > 1.5                                => final_score_371_c1426,
    iv_liens_rel_ot_ct = NULL                               => 0.0097848296,
                                                               0.0000034086);

final_score_372_c1430 := map(
    NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen <= 289.5 => -0.0095404386,
    iv_mos_src_bureau_addr_fseen > 289.5                                          => 0.0604912660,
    iv_mos_src_bureau_addr_fseen = NULL                                           => -0.0088005250,
                                                                                     -0.0088005250);

final_score_372_c1429 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen <= -0.5 => final_score_372_c1430,
    iv_mos_src_voter_adl_lseen > -0.5                                        => 0.0024538998,
    iv_mos_src_voter_adl_lseen = NULL                                        => -0.0013703860,
                                                                                -0.0013703860);

final_score_372 := map(
    iv_prof_license_category <> ' '
		  and NULL < (real)iv_prof_license_category AND (real)iv_prof_license_category <= 4.5 => final_score_372_c1429,
    (real)iv_prof_license_category > 4.5                                      => -0.0518935769,
    iv_prof_license_category = ' '                                     => -0.0096297580,
                                                                           -0.0016797195);

final_score_373_c1433 := map(
    NULL < iv_inp_addr_avm_change_1yr AND iv_inp_addr_avm_change_1yr <= 6005 => -0.0145508940,
    iv_inp_addr_avm_change_1yr > 6005                                        => -0.0860198926,
    iv_inp_addr_avm_change_1yr = NULL                                        => -0.0259666210,
                                                                                -0.0349869163);

final_score_373_c1432 := map(
    NULL < iv_sr001_m_wp_adl_fs AND iv_sr001_m_wp_adl_fs <= 120.5 => -0.0036899995,
    iv_sr001_m_wp_adl_fs > 120.5                                  => final_score_373_c1433,
    iv_sr001_m_wp_adl_fs = NULL                                   => -0.0134068365,
                                                                     -0.0134068365);

final_score_373 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 241.5 => 0.0011192108,
    iv_prv_addr_lres > 241.5                              => final_score_373_c1432,
    iv_prv_addr_lres = NULL                               => 0.0081249597,
                                                             0.0002874037);

final_score_374_c1436 := map(
    NULL < iv_unique_addr_count AND iv_unique_addr_count <= 3.5 => 0.0156783185,
    iv_unique_addr_count > 3.5                                  => -0.0165496024,
    iv_unique_addr_count = NULL                                 => -0.0038687372,
                                                                   -0.0038687372);

final_score_374_c1435 := map(
    NULL < iv_ag001_age AND iv_ag001_age <= 23.5 => -0.0536622573,
    iv_ag001_age > 23.5                          => final_score_374_c1436,
    iv_ag001_age = NULL                          => -0.0074810126,
                                                    -0.0074810126);

final_score_374 := map(
    iv_ed001_college_ind_50 <> ' '
		  AND NULL < (real)iv_ed001_college_ind_50 AND (real)iv_ed001_college_ind_50 <= 0.5 => -0.0027270935,
    (real)iv_ed001_college_ind_50 > 0.5                                     => final_score_374_c1435,
    iv_ed001_college_ind_50 = ' '                                    => 0.0035676176,
                                                                         -0.0007008072);

final_score_375_c1439 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 370.5 => 0.0940128840,
    iv_mos_src_bureau_lname_fseen > 370.5                                           => -0.0280064526,
    iv_mos_src_bureau_lname_fseen = NULL                                            => 0.0221570524,
                                                                                       0.0221570524);

final_score_375_c1438 := map(
    NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen <= 362.5 => -0.0274303299,
    iv_mos_src_bureau_lname_fseen > 362.5                                           => final_score_375_c1439,
    iv_mos_src_bureau_lname_fseen = NULL                                            => -0.0204388974,
                                                                                       -0.0204388974);

final_score_375 := map(
    (iv_bst_addr_financing_type in ['ADJ', 'OTH'])  => final_score_375_c1438,
    (iv_bst_addr_financing_type in ['CNV', 'NONE']) => 0.0018555194,
    iv_bst_addr_financing_type = ''               => -0.0087189958,
                                                       0.0006970551);

final_score_376_c1442 := map(
    NULL < iv_inp_addr_avm_change_3yr AND iv_inp_addr_avm_change_3yr <= 25735 => -0.0051001247,
    iv_inp_addr_avm_change_3yr > 25735                                        => 0.0909490947,
    iv_inp_addr_avm_change_3yr = NULL                                         => 0.0777815145,
                                                                                 0.0461010831);

final_score_376_c1441 := map(
    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen <= 55.5 => 0.0011257767,
    iv_mos_since_infutor_last_seen > 55.5                                            => final_score_376_c1442,
    iv_mos_since_infutor_last_seen = NULL                                            => 0.0120560657,
                                                                                        0.0132871617);

final_score_376 := map(
    (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed', '3 - BK Other']) => -0.0018281432,
    (iv_db001_bankruptcy in ['1 - BK Discharged'])                             => final_score_376_c1441,
    iv_db001_bankruptcy = ''                                                 => -0.0174342184,
                                                                                  -0.0005147515);

final_score := final_score_0 +
    final_score_1 +
    final_score_2 +
    final_score_3 +
    final_score_4 +
    final_score_5 +
    final_score_6 +
    final_score_7 +
    final_score_8 +
    final_score_9 +
    final_score_10 +
    final_score_11 +
    final_score_12 +
    final_score_13 +
    final_score_14 +
    final_score_15 +
    final_score_16 +
    final_score_17 +
    final_score_18 +
    final_score_19 +
    final_score_20 +
    final_score_21 +
    final_score_22 +
    final_score_23 +
    final_score_24 +
    final_score_25 +
    final_score_26 +
    final_score_27 +
    final_score_28 +
    final_score_29 +
    final_score_30 +
    final_score_31 +
    final_score_32 +
    final_score_33 +
    final_score_34 +
    final_score_35 +
    final_score_36 +
    final_score_37 +
    final_score_38 +
    final_score_39 +
    final_score_40 +
    final_score_41 +
    final_score_42 +
    final_score_43 +
    final_score_44 +
    final_score_45 +
    final_score_46 +
    final_score_47 +
    final_score_48 +
    final_score_49 +
    final_score_50 +
    final_score_51 +
    final_score_52 +
    final_score_53 +
    final_score_54 +
    final_score_55 +
    final_score_56 +
    final_score_57 +
    final_score_58 +
    final_score_59 +
    final_score_60 +
    final_score_61 +
    final_score_62 +
    final_score_63 +
    final_score_64 +
    final_score_65 +
    final_score_66 +
    final_score_67 +
    final_score_68 +
    final_score_69 +
    final_score_70 +
    final_score_71 +
    final_score_72 +
    final_score_73 +
    final_score_74 +
    final_score_75 +
    final_score_76 +
    final_score_77 +
    final_score_78 +
    final_score_79 +
    final_score_80 +
    final_score_81 +
    final_score_82 +
    final_score_83 +
    final_score_84 +
    final_score_85 +
    final_score_86 +
    final_score_87 +
    final_score_88 +
    final_score_89 +
    final_score_90 +
    final_score_91 +
    final_score_92 +
    final_score_93 +
    final_score_94 +
    final_score_95 +
    final_score_96 +
    final_score_97 +
    final_score_98 +
    final_score_99 +
    final_score_100 +
    final_score_101 +
    final_score_102 +
    final_score_103 +
    final_score_104 +
    final_score_105 +
    final_score_106 +
    final_score_107 +
    final_score_108 +
    final_score_109 +
    final_score_110 +
    final_score_111 +
    final_score_112 +
    final_score_113 +
    final_score_114 +
    final_score_115 +
    final_score_116 +
    final_score_117 +
    final_score_118 +
    final_score_119 +
    final_score_120 +
    final_score_121 +
    final_score_122 +
    final_score_123 +
    final_score_124 +
    final_score_125 +
    final_score_126 +
    final_score_127 +
    final_score_128 +
    final_score_129 +
    final_score_130 +
    final_score_131 +
    final_score_132 +
    final_score_133 +
    final_score_134 +
    final_score_135 +
    final_score_136 +
    final_score_137 +
    final_score_138 +
    final_score_139 +
    final_score_140 +
    final_score_141 +
    final_score_142 +
    final_score_143 +
    final_score_144 +
    final_score_145 +
    final_score_146 +
    final_score_147 +
    final_score_148 +
    final_score_149 +
    final_score_150 +
    final_score_151 +
    final_score_152 +
    final_score_153 +
    final_score_154 +
    final_score_155 +
    final_score_156 +
    final_score_157 +
    final_score_158 +
    final_score_159 +
    final_score_160 +
    final_score_161 +
    final_score_162 +
    final_score_163 +
    final_score_164 +
    final_score_165 +
    final_score_166 +
    final_score_167 +
    final_score_168 +
    final_score_169 +
    final_score_170 +
    final_score_171 +
    final_score_172 +
    final_score_173 +
    final_score_174 +
    final_score_175 +
    final_score_176 +
    final_score_177 +
    final_score_178 +
    final_score_179 +
    final_score_180 +
    final_score_181 +
    final_score_182 +
    final_score_183 +
    final_score_184 +
    final_score_185 +
    final_score_186 +
    final_score_187 +
    final_score_188 +
    final_score_189 +
    final_score_190 +
    final_score_191 +
    final_score_192 +
    final_score_193 +
    final_score_194 +
    final_score_195 +
    final_score_196 +
    final_score_197 +
    final_score_198 +
    final_score_199 +
    final_score_200 +
    final_score_201 +
    final_score_202 +
    final_score_203 +
    final_score_204 +
    final_score_205 +
    final_score_206 +
    final_score_207 +
    final_score_208 +
    final_score_209 +
    final_score_210 +
    final_score_211 +
    final_score_212 +
    final_score_213 +
    final_score_214 +
    final_score_215 +
    final_score_216 +
    final_score_217 +
    final_score_218 +
    final_score_219 +
    final_score_220 +
    final_score_221 +
    final_score_222 +
    final_score_223 +
    final_score_224 +
    final_score_225 +
    final_score_226 +
    final_score_227 +
    final_score_228 +
    final_score_229 +
    final_score_230 +
    final_score_231 +
    final_score_232 +
    final_score_233 +
    final_score_234 +
    final_score_235 +
    final_score_236 +
    final_score_237 +
    final_score_238 +
    final_score_239 +
    final_score_240 +
    final_score_241 +
    final_score_242 +
    final_score_243 +
    final_score_244 +
    final_score_245 +
    final_score_246 +
    final_score_247 +
    final_score_248 +
    final_score_249 +
    final_score_250 +
    final_score_251 +
    final_score_252 +
    final_score_253 +
    final_score_254 +
    final_score_255 +
    final_score_256 +
    final_score_257 +
    final_score_258 +
    final_score_259 +
    final_score_260 +
    final_score_261 +
    final_score_262 +
    final_score_263 +
    final_score_264 +
    final_score_265 +
    final_score_266 +
    final_score_267 +
    final_score_268 +
    final_score_269 +
    final_score_270 +
    final_score_271 +
    final_score_272 +
    final_score_273 +
    final_score_274 +
    final_score_275 +
    final_score_276 +
    final_score_277 +
    final_score_278 +
    final_score_279 +
    final_score_280 +
    final_score_281 +
    final_score_282 +
    final_score_283 +
    final_score_284 +
    final_score_285 +
    final_score_286 +
    final_score_287 +
    final_score_288 +
    final_score_289 +
    final_score_290 +
    final_score_291 +
    final_score_292 +
    final_score_293 +
    final_score_294 +
    final_score_295 +
    final_score_296 +
    final_score_297 +
    final_score_298 +
    final_score_299 +
    final_score_300 +
    final_score_301 +
    final_score_302 +
    final_score_303 +
    final_score_304 +
    final_score_305 +
    final_score_306 +
    final_score_307 +
    final_score_308 +
    final_score_309 +
    final_score_310 +
    final_score_311 +
    final_score_312 +
    final_score_313 +
    final_score_314 +
    final_score_315 +
    final_score_316 +
    final_score_317 +
    final_score_318 +
    final_score_319 +
    final_score_320 +
    final_score_321 +
    final_score_322 +
    final_score_323 +
    final_score_324 +
    final_score_325 +
    final_score_326 +
    final_score_327 +
    final_score_328 +
    final_score_329 +
    final_score_330 +
    final_score_331 +
    final_score_332 +
    final_score_333 +
    final_score_334 +
    final_score_335 +
    final_score_336 +
    final_score_337 +
    final_score_338 +
    final_score_339 +
    final_score_340 +
    final_score_341 +
    final_score_342 +
    final_score_343 +
    final_score_344 +
    final_score_345 +
    final_score_346 +
    final_score_347 +
    final_score_348 +
    final_score_349 +
    final_score_350 +
    final_score_351 +
    final_score_352 +
    final_score_353 +
    final_score_354 +
    final_score_355 +
    final_score_356 +
    final_score_357 +
    final_score_358 +
    final_score_359 +
    final_score_360 +
    final_score_361 +
    final_score_362 +
    final_score_363 +
    final_score_364 +
    final_score_365 +
    final_score_366 +
    final_score_367 +
    final_score_368 +
    final_score_369 +
    final_score_370 +
    final_score_371 +
    final_score_372 +
    final_score_373 +
    final_score_374 +
    final_score_375 +
    final_score_376;

ssn_deceased := rc_decsflag = '1' or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

pbr := 0.1266;

sbr := 0.1261;

offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));

base := 700;

pts := 45;

lgt := ln(0.1266 / 0.8734);

rvc1703_1_0 := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
                        round(
												  max((real)501, 
													    min((real)900, 
															    if(base + pts * ((final_score - offset - lgt) / ln(2)) = NULL, 
																	   -NULL, 
																		 base + pts * ((final_score - offset - lgt) / ln(2))
																		)
																 )
														 )
														 )
									);

rcvalue7 := if(iv_vp100_phn_prob = '2 Disconnected', 2, NULL);

rcvalue97 := if(iv_df001_mos_since_fel_ls >= 0, 14, NULL);

model_lien_present := if(iv_unreleased_liens_ct > 0 or iv_liens_rel_ot_ct > 0 or iv_dl001_unrel_lien60_count > 0 or iv_liens_unrel_lt_ct > 0 or iv_liens_unrel_cj_ct > 0 or iv_liens_rel_ft_ct > 0 or iv_liens_unrel_ft_ct > 0, 1, 0);

rcvalue98 := if(model_lien_present = 1, 13, NULL);

rcvalue99 := if(iv_hist_addr_match = 0, 10, NULL);

rcvalue9a := if(iv_bst_addr_naprop = '0', 8, NULL);

rcvalue9d := if(iv_addrs_10yr >= 7 or (iv_attr_addrs_recency in [1, 2, 12, 24, 36]), 6, NULL);

rcvalue9e := if(0 <= iv_non_derog_count AND iv_non_derog_count <= 3, 7, NULL);

rcvalue9i := if(iv_ed001_college_ind_35 = '0', 12, NULL);

rcvalue9m := if((iv_in001_wealth_index in ['0', '1']), 11, NULL);

rcvalue9q := if(iv_iq001_inq_count12 >= 1, 9, NULL);

rcvalue9r := if(0 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs <= 192, 4, NULL);

rcvalue9w := if((iv_db001_bankruptcy in ['1 - BK Discharged', '2 - BK Dismissed', '3 - BK Other']), 1, NULL);

rcvaluems := if(iv_ms001_ssns_per_adl >= 2, 5, NULL);

rcvaluepv := if(0 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval <= 75000, 3, NULL);

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

 
//*************************************************************************************//
rc_dataset_t := DATASET([
    {'7',  RCValue7 },
    {'97', RCValue97},
    {'98', RCValue98},
    {'99', RCValue99},
    {'9A', RCValue9A},
    {'9D', RCValue9D},
    {'9E', RCValue9E},
    {'9I', RCValue9I},
    {'9M', RCValue9M},
    {'9Q', RCValue9Q},
    {'9R', RCValue9R},
    {'9W', RCValue9W},
    {'MS', RCValueMS},
    {'PV', RCValuePV}
    ], ds_layout)(value > 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue > 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_t_sorted := sort(rc_dataset_t, -rc_dataset_t.value);

rc1_4 := rc_dataset_t_sorted[1].rc;
rc2_3 := rc_dataset_t_sorted[2].rc;
rc3_3 := rc_dataset_t_sorted[3].rc;
rc4_3 := rc_dataset_t_sorted[4].rc;
rc5_4 := '';

rc1v := rc_dataset_t_sorted[1].value;
rc2v := rc_dataset_t_sorted[2].value;
rc3v := rc_dataset_t_sorted[3].value;
rc4v := rc_dataset_t_sorted[4].value;
//*************************************************************************************//

rc5_3 := if(rc1_4 != '9Q' and rc2_3 != '9Q' and rc3_3 != '9Q' and rc4_3 != '9Q' 
            and iv_iq001_inq_count12 > 0, '9Q', rc5_4);

rc1_3 := if(rc1_4 = '', '36', rc1_4);

rc4_2 := if(rvc1703_1_0 = 900, '', rc4_3);

rc3_2 := if(rvc1703_1_0 = 900, '', rc3_3);

rc1_2 := if(rvc1703_1_0 = 900, '', rc1_3);

rc2_2 := if(rvc1703_1_0 = 900, '', rc2_3);

rc5_2 := if(rvc1703_1_0 = 900, '', rc5_3);

rc4_1 := if(rvc1703_1_0 = 222, '', rc4_2);

rc3_1 := if(rvc1703_1_0 = 222, '', rc3_2);

rc1_1 := if(rvc1703_1_0 = 222, '9X', rc1_2);

rc2_1 := if(rvc1703_1_0 = 222, '', rc2_2);

rc5_1 := if(rvc1703_1_0 = 222, '', rc5_2);

rc4 := if(rvc1703_1_0 = 200, '', rc4_1);

rc1 := if(rvc1703_1_0 = 200, '02', rc1_1);

rc3 := if(rvc1703_1_0 = 200, '', rc3_1);

rc5 := if(rvc1703_1_0 = 200, '', rc5_1);

rc2 := if(rvc1703_1_0 = 200, '', rc2_1);


// overrides handled a bit differently in this model (above)
// so built my_reasons dataset for use below.
my_reasons := dataset([rc1,rc2,rc3,rc4,rc5],{string rc});


riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
                
rcs_final := PROJECT(my_reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
                                             SELF.hri := LEFT.rc,
                                             SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)));

inCalif := isCalifornia AND (
           (integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
           +(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
           +(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
                                
ri := MAP( riTemp[1].hri <> '00' => riTemp,
           inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
           rcs_final
           );
                                                                
zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);

reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes



	#if(RVC_DEBUG)
	
	/* Model Input Variables */
		 self.clam															:= le;
		 
		
                    self.sysdate                          := sysdate;
                    self.iv_add_apt                       := iv_add_apt;
                    self.iv_vp090_phn_dst_to_inp_add      := iv_vp090_phn_dst_to_inp_add;
                    self.iv_vp091_phnzip_mismatch         := iv_vp091_phnzip_mismatch;
                    self.iv_vp100_phn_prob                := iv_vp100_phn_prob;
                    self.iv_va060_dist_add_in_bst         := iv_va060_dist_add_in_bst;
                    self._felony_last_date                := _felony_last_date;
                    self.iv_df001_mos_since_fel_ls        := iv_df001_mos_since_fel_ls;
                    self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
                    self.iv_dg001_derog_count             := iv_dg001_derog_count;
                    self.iv_dl001_unrel_lien60_count      := iv_dl001_unrel_lien60_count;
                    self.lien_adl_li_lseen_pos            := lien_adl_li_lseen_pos;
                    self.lien_adl_lseen_li                := lien_adl_lseen_li;
                    self._lien_adl_lseen_li               := _lien_adl_lseen_li;
                    self.lien_adl_l2_lseen_pos            := lien_adl_l2_lseen_pos;
                    self.lien_adl_lseen_l2                := lien_adl_lseen_l2;
                    self._lien_adl_lseen_l2               := _lien_adl_lseen_l2;
                    self._src_lien_adl_lseen              := _src_lien_adl_lseen;
                    self.iv_dl001_lien_last_seen          := iv_dl001_lien_last_seen;
                    self.bureau_adl_tn_fseen_pos          := bureau_adl_tn_fseen_pos;
                    self.bureau_adl_fseen_tn              := bureau_adl_fseen_tn;
                    self._bureau_adl_fseen_tn             := _bureau_adl_fseen_tn;
                    self.bureau_adl_ts_fseen_pos          := bureau_adl_ts_fseen_pos;
                    self.bureau_adl_fseen_ts              := bureau_adl_fseen_ts;
                    self._bureau_adl_fseen_ts             := _bureau_adl_fseen_ts;
                    self.bureau_adl_tu_fseen_pos          := bureau_adl_tu_fseen_pos;
                    self.bureau_adl_fseen_tu              := bureau_adl_fseen_tu;
                    self._bureau_adl_fseen_tu             := _bureau_adl_fseen_tu;
                    self.bureau_adl_en_fseen_pos          := bureau_adl_en_fseen_pos;
                    self.bureau_adl_fseen_en              := bureau_adl_fseen_en;
                    self._bureau_adl_fseen_en             := _bureau_adl_fseen_en;
                    self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
                    self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
                    self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
                    self.iv_sr001_m_bureau_adl_fs         := iv_sr001_m_bureau_adl_fs;
                    self.wp_adl_wp_fseen_pos              := wp_adl_wp_fseen_pos;
                    self.wp_adl_fseen_wp                  := wp_adl_fseen_wp;
                    self._wp_adl_fseen_wp                 := _wp_adl_fseen_wp;
                    self._src_wp_adl_fseen                := _src_wp_adl_fseen;
                    self.bureau_adl_vo_fseen_pos          := bureau_adl_vo_fseen_pos;
                    self.bureau_adl_fseen_vo              := bureau_adl_fseen_vo;
                    self._bureau_adl_fseen_vo             := _bureau_adl_fseen_vo;
                    self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
                    self.mth_ver_src_fdate_vo             := mth_ver_src_fdate_vo;
                    self.bureau_adl_vo_lseen_pos          := bureau_adl_vo_lseen_pos;
                    self.bureau_adl_lseen_vo              := bureau_adl_lseen_vo;
                    self._bureau_adl_lseen_vo             := _bureau_adl_lseen_vo;
                    self.mth_ver_src_ldate_vo             := mth_ver_src_ldate_vo;
                    self.mth_ver_src_fdate_vo60           := mth_ver_src_fdate_vo60;
                    self.mth_ver_src_ldate_vo0            := mth_ver_src_ldate_vo0;
                    self.bureau_adl_w_lseen_pos           := bureau_adl_w_lseen_pos;
                    self.bureau_adl_lseen_w               := bureau_adl_lseen_w;
                    self._bureau_adl_lseen_w              := _bureau_adl_lseen_w;
                    self.mth_ver_src_ldate_w              := mth_ver_src_ldate_w;
                    self.mth_ver_src_ldate_w0             := mth_ver_src_ldate_w0;
                    self.bureau_adl_wp_lseen_pos          := bureau_adl_wp_lseen_pos;
                    self.bureau_adl_lseen_wp              := bureau_adl_lseen_wp;
                    self._bureau_adl_lseen_wp             := _bureau_adl_lseen_wp;
                    self.mth_ver_src_ldate_wp             := mth_ver_src_ldate_wp;
                    self.mth_ver_src_ldate_wp0            := mth_ver_src_ldate_wp0;
                    self.mth_paw_first_seen               := mth_paw_first_seen;
                    self.mth_paw_first_seen2              := mth_paw_first_seen2;
                    self.ver_src_am                       := ver_src_am;
                    self.ver_src_e1                       := ver_src_e1;
                    self.ver_src_e2                       := ver_src_e2;
                    self.ver_src_e3                       := ver_src_e3;
                    self.ver_src_pl                       := ver_src_pl;
                    self.ver_src_w                        := ver_src_w;
                    self.paw_dead_business_count_gt3      := paw_dead_business_count_gt3;
                    self.paw_active_phone_count_0         := paw_active_phone_count_0;
                    self.mth_infutor_first_seen           := mth_infutor_first_seen;
                    self.mth_infutor_last_seen            := mth_infutor_last_seen;
                    self.infutor_i                        := infutor_i;
                    self.infutor_im                       := infutor_im;
                    self.white_pages_adl_wp_fseen_pos     := white_pages_adl_wp_fseen_pos;
                    self.white_pages_adl_fseen_wp         := white_pages_adl_fseen_wp;
                    self._white_pages_adl_fseen_wp        := _white_pages_adl_fseen_wp;
                    self._src_white_pages_adl_fseen       := _src_white_pages_adl_fseen;
                    self.iv_sr001_m_wp_adl_fs             := iv_sr001_m_wp_adl_fs;
                    self.src_m_wp_adl_fs                  := src_m_wp_adl_fs;
                    self._header_first_seen               := _header_first_seen;
                    self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;
                    self.src_m_hdr_fs                     := src_m_hdr_fs;
                    self.source_mod6                      := source_mod6;
                    self.iv_sr001_source_profile          := iv_sr001_source_profile;
                    self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
                    self.iv_mi001_adlperssn_count         := iv_mi001_adlperssn_count;
                    self._in_dob                          := _in_dob;
                    self.yr_in_dob                        := yr_in_dob;
                    self.yr_in_dob_int                    := yr_in_dob_int;
                    self.age_estimate                     := age_estimate;
                    self.iv_ag001_age                     := iv_ag001_age;
                    self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;
                    self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;
                    self.iv_pv001_avg_prop_prch_amt       := iv_pv001_avg_prop_prch_amt;
                    self.bst_addr_avm_auto_val_2          := bst_addr_avm_auto_val_2;
                    self.iv_pv001_bst_avm_chg_1yr         := iv_pv001_bst_avm_chg_1yr;
                    self.iv_pv001_bst_avm_chg_1yr_pct     := iv_pv001_bst_avm_chg_1yr_pct;
                    self.inp_addr_date_first_seen         := inp_addr_date_first_seen;
                    self.iv_pl001_m_snc_in_addr_fs        := iv_pl001_m_snc_in_addr_fs;
                    self.prop_adl_p_fseen_pos             := prop_adl_p_fseen_pos;
                    self.prop_adl_fseen_p                 := prop_adl_fseen_p;
                    self._prop_adl_fseen_p                := _prop_adl_fseen_p;
                    self._src_prop_adl_fseen              := _src_prop_adl_fseen;
                    self.iv_pl001_m_snc_prop_adl_fs       := iv_pl001_m_snc_prop_adl_fs;
                    self.iv_pl001_bst_addr_lres           := iv_pl001_bst_addr_lres;
                    self.iv_pl002_avg_mo_per_addr         := iv_pl002_avg_mo_per_addr;
                    self.iv_pl002_addrs_per_ssn_c6        := iv_pl002_addrs_per_ssn_c6;
                    self.iv_po001_prop_own_tot            := iv_po001_prop_own_tot;
                    self.iv_po001_inp_addr_naprop         := iv_po001_inp_addr_naprop;
                    self.vehicles_adl_ar_fseen_pos        := vehicles_adl_ar_fseen_pos;
                    self.vehicles_adl_fseen_ar            := vehicles_adl_fseen_ar;
                    self._vehicles_adl_fseen_ar           := _vehicles_adl_fseen_ar;
                    self.vehicles_adl_eb_fseen_pos        := vehicles_adl_eb_fseen_pos;
                    self.vehicles_adl_fseen_eb            := vehicles_adl_fseen_eb;
                    self._vehicles_adl_fseen_eb           := _vehicles_adl_fseen_eb;
                    self.vehicles_adl_v_fseen_pos         := vehicles_adl_v_fseen_pos;
                    self.vehicles_adl_fseen_v             := vehicles_adl_fseen_v;
                    self._vehicles_adl_fseen_v            := _vehicles_adl_fseen_v;
                    self.vehicles_adl_w_fseen_pos         := vehicles_adl_w_fseen_pos;
                    self.vehicles_adl_fseen_w             := vehicles_adl_fseen_w;
                    self._vehicles_adl_fseen_w            := _vehicles_adl_fseen_w;
                    self._src_vehicles_adl_fseen          := _src_vehicles_adl_fseen;
                    self.iv_po001_m_snc_veh_adl_fs        := iv_po001_m_snc_veh_adl_fs;
                    self.iv_in001_estimated_income        := iv_in001_estimated_income;
                    self.iv_in001_wealth_index            := iv_in001_wealth_index;
                    self.iv_ed001_college_ind_35          := iv_ed001_college_ind_35;
                    self.iv_ed001_college_ind_36          := iv_ed001_college_ind_36;
                    self.iv_ed001_college_ind_37          := iv_ed001_college_ind_37;
                    self.iv_ed001_college_ind_50          := iv_ed001_college_ind_50;
                    self.iv_ed001_college_ind_60          := iv_ed001_college_ind_60;
                    self.iv_iq001_inq_count12             := iv_iq001_inq_count12;
                    self.iv_nap_type                      := iv_nap_type;
                    self.bureau_adl_tn_lseen_pos          := bureau_adl_tn_lseen_pos;
                    self.bureau_adl_lseen_tn              := bureau_adl_lseen_tn;
                    self._bureau_adl_lseen_tn             := _bureau_adl_lseen_tn;
                    self.bureau_adl_ts_lseen_pos          := bureau_adl_ts_lseen_pos;
                    self.bureau_adl_lseen_ts              := bureau_adl_lseen_ts;
                    self._bureau_adl_lseen_ts             := _bureau_adl_lseen_ts;
                    self.bureau_adl_tu_lseen_pos          := bureau_adl_tu_lseen_pos;
                    self.bureau_adl_lseen_tu              := bureau_adl_lseen_tu;
                    self._bureau_adl_lseen_tu             := _bureau_adl_lseen_tu;
                    self.bureau_adl_en_lseen_pos          := bureau_adl_en_lseen_pos;
                    self.bureau_adl_lseen_en              := bureau_adl_lseen_en;
                    self._bureau_adl_lseen_en             := _bureau_adl_lseen_en;
                    self.bureau_adl_eq_lseen_pos          := bureau_adl_eq_lseen_pos;
                    self.bureau_adl_lseen_eq              := bureau_adl_lseen_eq;
                    self._bureau_adl_lseen_eq             := _bureau_adl_lseen_eq;
                    self._src_bureau_adl_lseen            := _src_bureau_adl_lseen;
                    self.iv_mos_src_bureau_adl_lseen      := iv_mos_src_bureau_adl_lseen;
                    self.bureau_ssn_tn_count_pos          := bureau_ssn_tn_count_pos;
                    self.bureau_ssn_count_tn              := bureau_ssn_count_tn;
                    self.bureau_ssn_ts_count_pos          := bureau_ssn_ts_count_pos;
                    self.bureau_ssn_count_ts              := bureau_ssn_count_ts;
                    self.bureau_ssn_tu_count_pos          := bureau_ssn_tu_count_pos;
                    self.bureau_ssn_count_tu              := bureau_ssn_count_tu;
                    self.bureau_ssn_en_count_pos          := bureau_ssn_en_count_pos;
                    self.bureau_ssn_count_en              := bureau_ssn_count_en;
                    self.bureau_ssn_eq_count_pos          := bureau_ssn_eq_count_pos;
                    self.bureau_ssn_count_eq              := bureau_ssn_count_eq;
                    self._src_bureau_ssn_count            := _src_bureau_ssn_count;
                    self.iv_src_bureau_ssn_count          := iv_src_bureau_ssn_count;
                    self.bureau_ssn_tn_fseen_pos          := bureau_ssn_tn_fseen_pos;
                    self.bureau_ssn_fseen_tn              := bureau_ssn_fseen_tn;
                    self._bureau_ssn_fseen_tn             := _bureau_ssn_fseen_tn;
                    self.bureau_ssn_ts_fseen_pos          := bureau_ssn_ts_fseen_pos;
                    self.bureau_ssn_fseen_ts              := bureau_ssn_fseen_ts;
                    self._bureau_ssn_fseen_ts             := _bureau_ssn_fseen_ts;
                    self.bureau_ssn_tu_fseen_pos          := bureau_ssn_tu_fseen_pos;
                    self.bureau_ssn_fseen_tu              := bureau_ssn_fseen_tu;
                    self._bureau_ssn_fseen_tu             := _bureau_ssn_fseen_tu;
                    self.bureau_ssn_en_fseen_pos          := bureau_ssn_en_fseen_pos;
                    self.bureau_ssn_fseen_en              := bureau_ssn_fseen_en;
                    self._bureau_ssn_fseen_en             := _bureau_ssn_fseen_en;
                    self.bureau_ssn_eq_fseen_pos          := bureau_ssn_eq_fseen_pos;
                    self.bureau_ssn_fseen_eq              := bureau_ssn_fseen_eq;
                    self._bureau_ssn_fseen_eq             := _bureau_ssn_fseen_eq;
                    self._src_bureau_ssn_fseen            := _src_bureau_ssn_fseen;
                    self.iv_mos_src_bureau_ssn_fseen      := iv_mos_src_bureau_ssn_fseen;
                    self.bureau_addr_tn_count_pos         := bureau_addr_tn_count_pos;
                    self.bureau_addr_count_tn             := bureau_addr_count_tn;
                    self.bureau_addr_ts_count_pos         := bureau_addr_ts_count_pos;
                    self.bureau_addr_count_ts             := bureau_addr_count_ts;
                    self.bureau_addr_tu_count_pos         := bureau_addr_tu_count_pos;
                    self.bureau_addr_count_tu             := bureau_addr_count_tu;
                    self.bureau_addr_en_count_pos         := bureau_addr_en_count_pos;
                    self.bureau_addr_count_en             := bureau_addr_count_en;
                    self.bureau_addr_eq_count_pos         := bureau_addr_eq_count_pos;
                    self.bureau_addr_count_eq             := bureau_addr_count_eq;
                    self._src_bureau_addr_count           := _src_bureau_addr_count;
                    self.iv_src_bureau_addr_count         := iv_src_bureau_addr_count;
                    self.bureau_addr_tn_fseen_pos         := bureau_addr_tn_fseen_pos;
                    self.bureau_addr_fseen_tn             := bureau_addr_fseen_tn;
                    self._bureau_addr_fseen_tn            := _bureau_addr_fseen_tn;
                    self.bureau_addr_ts_fseen_pos         := bureau_addr_ts_fseen_pos;
                    self.bureau_addr_fseen_ts             := bureau_addr_fseen_ts;
                    self._bureau_addr_fseen_ts            := _bureau_addr_fseen_ts;
                    self.bureau_addr_tu_fseen_pos         := bureau_addr_tu_fseen_pos;
                    self.bureau_addr_fseen_tu             := bureau_addr_fseen_tu;
                    self._bureau_addr_fseen_tu            := _bureau_addr_fseen_tu;
                    self.bureau_addr_en_fseen_pos         := bureau_addr_en_fseen_pos;
                    self.bureau_addr_fseen_en             := bureau_addr_fseen_en;
                    self._bureau_addr_fseen_en            := _bureau_addr_fseen_en;
                    self.bureau_addr_eq_fseen_pos         := bureau_addr_eq_fseen_pos;
                    self.bureau_addr_fseen_eq             := bureau_addr_fseen_eq;
                    self._bureau_addr_fseen_eq            := _bureau_addr_fseen_eq;
                    self._src_bureau_addr_fseen           := _src_bureau_addr_fseen;
                    self.iv_mos_src_bureau_addr_fseen     := iv_mos_src_bureau_addr_fseen;
                    self.bureau_lname_tn_count_pos        := bureau_lname_tn_count_pos;
                    self.bureau_lname_count_tn            := bureau_lname_count_tn;
                    self.bureau_lname_ts_count_pos        := bureau_lname_ts_count_pos;
                    self.bureau_lname_count_ts            := bureau_lname_count_ts;
                    self.bureau_lname_tu_count_pos        := bureau_lname_tu_count_pos;
                    self.bureau_lname_count_tu            := bureau_lname_count_tu;
                    self.bureau_lname_en_count_pos        := bureau_lname_en_count_pos;
                    self.bureau_lname_count_en            := bureau_lname_count_en;
                    self.bureau_lname_eq_count_pos        := bureau_lname_eq_count_pos;
                    self.bureau_lname_count_eq            := bureau_lname_count_eq;
                    self._src_bureau_lname_count          := _src_bureau_lname_count;
                    self.iv_src_bureau_lname_count        := iv_src_bureau_lname_count;
                    self.bureau_lname_tn_fseen_pos        := bureau_lname_tn_fseen_pos;
                    self.bureau_lname_fseen_tn            := bureau_lname_fseen_tn;
                    self._bureau_lname_fseen_tn           := _bureau_lname_fseen_tn;
                    self.bureau_lname_ts_fseen_pos        := bureau_lname_ts_fseen_pos;
                    self.bureau_lname_fseen_ts            := bureau_lname_fseen_ts;
                    self._bureau_lname_fseen_ts           := _bureau_lname_fseen_ts;
                    self.bureau_lname_tu_fseen_pos        := bureau_lname_tu_fseen_pos;
                    self.bureau_lname_fseen_tu            := bureau_lname_fseen_tu;
                    self._bureau_lname_fseen_tu           := _bureau_lname_fseen_tu;
                    self.bureau_lname_en_fseen_pos        := bureau_lname_en_fseen_pos;
                    self.bureau_lname_fseen_en            := bureau_lname_fseen_en;
                    self._bureau_lname_fseen_en           := _bureau_lname_fseen_en;
                    self.bureau_lname_eq_fseen_pos        := bureau_lname_eq_fseen_pos;
                    self.bureau_lname_fseen_eq            := bureau_lname_fseen_eq;
                    self._bureau_lname_fseen_eq           := _bureau_lname_fseen_eq;
                    self._src_bureau_lname_fseen          := _src_bureau_lname_fseen;
                    self.iv_mos_src_bureau_lname_fseen    := iv_mos_src_bureau_lname_fseen;
                    self.bureau_dob_tn_count_pos          := bureau_dob_tn_count_pos;
                    self.bureau_dob_count_tn              := bureau_dob_count_tn;
                    self.bureau_dob_ts_count_pos          := bureau_dob_ts_count_pos;
                    self.bureau_dob_count_ts              := bureau_dob_count_ts;
                    self.bureau_dob_tu_count_pos          := bureau_dob_tu_count_pos;
                    self.bureau_dob_count_tu              := bureau_dob_count_tu;
                    self.bureau_dob_en_count_pos          := bureau_dob_en_count_pos;
                    self.bureau_dob_count_en              := bureau_dob_count_en;
                    self.bureau_dob_eq_count_pos          := bureau_dob_eq_count_pos;
                    self.bureau_dob_count_eq              := bureau_dob_count_eq;
                    self._src_bureau_dob_count            := _src_bureau_dob_count;
                    self.iv_src_bureau_dob_count          := iv_src_bureau_dob_count;
                    self.bureau_dob_tn_fseen_pos          := bureau_dob_tn_fseen_pos;
                    self.bureau_dob_fseen_tn              := bureau_dob_fseen_tn;
                    self._bureau_dob_fseen_tn             := _bureau_dob_fseen_tn;
                    self.bureau_dob_ts_fseen_pos          := bureau_dob_ts_fseen_pos;
                    self.bureau_dob_fseen_ts              := bureau_dob_fseen_ts;
                    self._bureau_dob_fseen_ts             := _bureau_dob_fseen_ts;
                    self.bureau_dob_tu_fseen_pos          := bureau_dob_tu_fseen_pos;
                    self.bureau_dob_fseen_tu              := bureau_dob_fseen_tu;
                    self._bureau_dob_fseen_tu             := _bureau_dob_fseen_tu;
                    self.bureau_dob_en_fseen_pos          := bureau_dob_en_fseen_pos;
                    self.bureau_dob_fseen_en              := bureau_dob_fseen_en;
                    self._bureau_dob_fseen_en             := _bureau_dob_fseen_en;
                    self.bureau_dob_eq_fseen_pos          := bureau_dob_eq_fseen_pos;
                    self.bureau_dob_fseen_eq              := bureau_dob_fseen_eq;
                    self._bureau_dob_fseen_eq             := _bureau_dob_fseen_eq;
                    self._src_bureau_dob_fseen            := _src_bureau_dob_fseen;
                    self.iv_mos_src_bureau_dob_fseen      := iv_mos_src_bureau_dob_fseen;
                    self.lien_adl_li_count_pos            := lien_adl_li_count_pos;
                    self.lien_adl_count_li                := lien_adl_count_li;
                    self.lien_adl_l2_count_pos            := lien_adl_l2_count_pos;
                    self.lien_adl_count_l2                := lien_adl_count_l2;
                    self._src_lien_adl_count              := _src_lien_adl_count;
                    self.bk_adl_bk_count_pos              := bk_adl_bk_count_pos;
                    self.bk_adl_count_bk                  := bk_adl_count_bk;
                    self._src_bk_adl_count                := _src_bk_adl_count;
                    self.iv_src_bankruptcy_adl_count      := iv_src_bankruptcy_adl_count;
                    self.bk_adl_ba_lseen_pos              := bk_adl_ba_lseen_pos;
                    self.bk_adl_lseen_ba                  := bk_adl_lseen_ba;
                    self._bk_adl_lseen_ba                 := _bk_adl_lseen_ba;
                    self._src_bk_adl_lseen                := _src_bk_adl_lseen;
                    self.iv_mos_src_bankruptcy_adl_lseen  := iv_mos_src_bankruptcy_adl_lseen;
                    self.prop_adl_p_count_pos             := prop_adl_p_count_pos;
                    self.prop_adl_count_p                 := prop_adl_count_p;
                    self._src_prop_adl_count              := _src_prop_adl_count;
                    self.iv_src_property_adl_count        := iv_src_property_adl_count;
                    self.prop_adl_p_lseen_pos             := prop_adl_p_lseen_pos;
                    self.prop_adl_lseen_p                 := prop_adl_lseen_p;
                    self._prop_adl_lseen_p                := _prop_adl_lseen_p;
                    self._src_prop_adl_lseen              := _src_prop_adl_lseen;
                    self.iv_mos_src_property_adl_lseen    := iv_mos_src_property_adl_lseen;
                    self.voter_adl_v_count_pos            := voter_adl_v_count_pos;
                    self.iv_src_voter_adl_count           := iv_src_voter_adl_count;
                    self.vote_adl_vo_lseen_pos            := vote_adl_vo_lseen_pos;
                    self.vote_adl_lseen_vo                := vote_adl_lseen_vo;
                    self._vote_adl_lseen_vo               := _vote_adl_lseen_vo;
                    self._src_vote_adl_lseen              := _src_vote_adl_lseen;
                    self.iv_mos_src_voter_adl_lseen       := iv_mos_src_voter_adl_lseen;
                    self.emerge_adl_em_count_pos          := emerge_adl_em_count_pos;
                    self.emerge_adl_count_em              := emerge_adl_count_em;
                    self.emerge_adl_e1_count_pos          := emerge_adl_e1_count_pos;
                    self.emerge_adl_count_e1              := emerge_adl_count_e1;
                    self.emerge_adl_e2_count_pos          := emerge_adl_e2_count_pos;
                    self.emerge_adl_count_e2              := emerge_adl_count_e2;
                    self.emerge_adl_e3_count_pos          := emerge_adl_e3_count_pos;
                    self.emerge_adl_count_e3              := emerge_adl_count_e3;
                    self.emerge_adl_e4_count_pos          := emerge_adl_e4_count_pos;
                    self.emerge_adl_count_e4              := emerge_adl_count_e4;
                    self.iv_src_emerge_adl_count          := iv_src_emerge_adl_count;
                    self._lname_change_date               := _lname_change_date;
                    self.iv_mos_since_lname_change        := iv_mos_since_lname_change;
                    self.iv_fname_eda_sourced_type        := iv_fname_eda_sourced_type;
                    self.iv_lname_eda_sourced_type        := iv_lname_eda_sourced_type;
                    self.iv_fname_non_phn_src_ct          := iv_fname_non_phn_src_ct;
                    self.iv_full_name_non_phn_src_ct      := iv_full_name_non_phn_src_ct;
                    self.iv_full_name_ver_sources         := iv_full_name_ver_sources;
                    self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
                    self.iv_addr_phn_src_ct               := iv_addr_phn_src_ct;
                    self.iv_dob_src_ct                    := iv_dob_src_ct;
                    self._reported_dob                    := _reported_dob;
                    self.reported_age                     := reported_age;
                    self.iv_combined_age                  := iv_combined_age;
                    self._rc_ssnlowissue                  := _rc_ssnlowissue;
                    self.iv_age_at_low_issue              := iv_age_at_low_issue;
                    self._rc_ssnhighissue                 := _rc_ssnhighissue;
                    self.iv_age_at_high_issue             := iv_age_at_high_issue;
                    self.iv_inp_addr_lres                 := iv_inp_addr_lres;
                    self.iv_inp_addr_source_count         := iv_inp_addr_source_count;
                    self.iv_inp_addr_ownership_lvl        := iv_inp_addr_ownership_lvl;
                    self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;
                    self.iv_inp_addr_mortgage_amount      := iv_inp_addr_mortgage_amount;
                    self._add1_mortgage_date              := _add1_mortgage_date;
                    self._add1_mortgage_due_date          := _add1_mortgage_due_date;
                    self.mortgage_date_diff               := mortgage_date_diff;
                    self.iv_inp_addr_mortgage_term        := iv_inp_addr_mortgage_term;
                    self.iv_inp_addr_financing_type       := iv_inp_addr_financing_type;
                    self.iv_inp_addr_assessed_total_val   := iv_inp_addr_assessed_total_val;
                    self.inp_addr_fips_fall               := inp_addr_fips_fall;
                    self.inp_addr_avm_auto_val            := inp_addr_avm_auto_val;
                    self.iv_inp_addr_fips_ratio           := iv_inp_addr_fips_ratio;
                    self.iv_inp_addr_building_area        := iv_inp_addr_building_area;
                    self.iv_inp_addr_avm_change_1yr       := iv_inp_addr_avm_change_1yr;
                    self.iv_inp_addr_avm_pct_change_1yr   := iv_inp_addr_avm_pct_change_1yr;
                    self.iv_inp_addr_avm_change_2yr       := iv_inp_addr_avm_change_2yr;
                    self.iv_inp_addr_avm_pct_change_2yr   := iv_inp_addr_avm_pct_change_2yr;
                    self.iv_inp_addr_avm_change_3yr       := iv_inp_addr_avm_change_3yr;
                    self.iv_inp_addr_avm_pct_change_3yr   := iv_inp_addr_avm_pct_change_3yr;
                    self.iv_bst_addr_source_count         := iv_bst_addr_source_count;
                    self.iv_bst_addr_ownership_lvl        := iv_bst_addr_ownership_lvl;
                    self.iv_bst_addr_naprop               := iv_bst_addr_naprop;
                    self.iv_bst_own_prop_x_addr_naprop    := iv_bst_own_prop_x_addr_naprop;
                    self.iv_bst_addr_mortgage_amount      := iv_bst_addr_mortgage_amount;
                    self.iv_bst_addr_mtg_avm_abs_diff     := iv_bst_addr_mtg_avm_abs_diff;
                    self.bst_addr_mortgage_amount         := bst_addr_mortgage_amount;
                    self.iv_bst_addr_mtg_avm_pct_diff     := iv_bst_addr_mtg_avm_pct_diff;
                    self.iv_bst_addr_assessed_total_val   := iv_bst_addr_assessed_total_val;
                    self.bst_addr_date_first_seen         := bst_addr_date_first_seen;
                    self.iv_mos_since_bst_addr_fseen      := iv_mos_since_bst_addr_fseen;
                    self.bst_addr_avm_auto_val            := bst_addr_avm_auto_val;
                    self.bst_addr_fips_fall               := bst_addr_fips_fall;
                    self.iv_bst_addr_fips_ratio           := iv_bst_addr_fips_ratio;
                    self.iv_bst_addr_building_area        := iv_bst_addr_building_area;
                    self.iv_bst_addr_avm_change_2yr       := iv_bst_addr_avm_change_2yr;
                    self.bst_addr_avm_auto_val_3          := bst_addr_avm_auto_val_3;
                    self.iv_bst_addr_avm_pct_change_2yr   := iv_bst_addr_avm_pct_change_2yr;
                    self.iv_bst_addr_avm_change_3yr       := iv_bst_addr_avm_change_3yr;
                    self.bst_addr_avm_auto_val_1          := bst_addr_avm_auto_val_1;
                    self.bst_addr_avm_auto_val_4          := bst_addr_avm_auto_val_4;
                    self.iv_bst_addr_avm_pct_change_3yr   := iv_bst_addr_avm_pct_change_3yr;
                    self.iv_bst_addr_financing_type       := iv_bst_addr_financing_type;
                    self.iv_prv_addr_lres                 := iv_prv_addr_lres;
                    self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
                    self.iv_prv_addr_source_count         := iv_prv_addr_source_count;
                    self.iv_prv_addr_eda_sourced          := iv_prv_addr_eda_sourced;
                    self.iv_prv_addr_naprop               := iv_prv_addr_naprop;
                    self.iv_prv_own_prop_x_addr_naprop    := iv_prv_own_prop_x_addr_naprop;
                    self.iv_prv_addr_mortgage_present     := iv_prv_addr_mortgage_present;
                    self.iv_prv_addr_mortgage_amount      := iv_prv_addr_mortgage_amount;
                    self.iv_prv_addr_assessed_total_val   := iv_prv_addr_assessed_total_val;
                    self.prv_addr_date_first_seen         := prv_addr_date_first_seen;
                    self.iv_mos_since_prv_addr_fseen      := iv_mos_since_prv_addr_fseen;
                    self.prv_addr_date_last_seen          := prv_addr_date_last_seen;
                    self.iv_mos_since_prv_addr_lseen      := iv_mos_since_prv_addr_lseen;
                    self.iv_prop_owned_purchase_total     := iv_prop_owned_purchase_total;
                    self.iv_prop_owned_assessed_total     := iv_prop_owned_assessed_total;
                    self.iv_prop_owned_assessed_count     := iv_prop_owned_assessed_count;
                    self.iv_avg_prop_assess_purch_amt     := iv_avg_prop_assess_purch_amt;
                    self.iv_prop_sold_purchase_total      := iv_prop_sold_purchase_total;
                    self.iv_avg_prop_sold_purch_amt       := iv_avg_prop_sold_purch_amt;
                    self.iv_prop_sold_assessed_total      := iv_prop_sold_assessed_total;
                    self.iv_avg_prop_sold_assess_amt      := iv_avg_prop_sold_assess_amt;
                    self.iv_purch_sold_ct_diff            := iv_purch_sold_ct_diff;
                    self.iv_purch_sold_val_diff           := iv_purch_sold_val_diff;
                    self.iv_purch_sold_assess_val_diff    := iv_purch_sold_assess_val_diff;
                    self.iv_prop1_sale_price              := iv_prop1_sale_price;
                    self._prop1_sale_date                 := _prop1_sale_date;
                    self.iv_mos_since_prop1_sale          := iv_mos_since_prop1_sale;
                    self.iv_prop1_purch_sale_diff         := iv_prop1_purch_sale_diff;
                    self.iv_prop2_sale_price              := iv_prop2_sale_price;
                    self._prop2_sale_date                 := _prop2_sale_date;
                    self.iv_mos_since_prop2_sale          := iv_mos_since_prop2_sale;
                    self.iv_prop2_purch_sale_diff         := iv_prop2_purch_sale_diff;
                    self.iv_dist_bst_addr_to_prv_addr     := iv_dist_bst_addr_to_prv_addr;
                    self.iv_dist_inp_addr_to_prv_addr     := iv_dist_inp_addr_to_prv_addr;
                    self.iv_avg_lres                      := iv_avg_lres;
                    self.iv_max_lres                      := iv_max_lres;
                    self.iv_addrs_10yr                    := iv_addrs_10yr;
                    self.iv_unique_addr_count             := iv_unique_addr_count;
                    self.iv_addr_lres_6mo_count           := iv_addr_lres_6mo_count;
                    self.iv_addr_lres_12mo_count          := iv_addr_lres_12mo_count;
                    self.iv_hist_addr_match               := iv_hist_addr_match;
                    self.iv_avg_num_sources_per_addr      := iv_avg_num_sources_per_addr;
                    self._gong_did_first_seen             := _gong_did_first_seen;
                    self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
                    self._gong_did_last_seen              := _gong_did_last_seen;
                    self.iv_mos_since_gong_did_lst_seen   := iv_mos_since_gong_did_lst_seen;
                    self.iv_gong_did_phone_ct             := iv_gong_did_phone_ct;
                    self.iv_addrs_per_adl                 := iv_addrs_per_adl;
                    self.iv_lnames_per_adl                := iv_lnames_per_adl;
                    self.iv_adls_per_addr                 := iv_adls_per_addr;
                    self.iv_adls_per_sfd_addr             := iv_adls_per_sfd_addr;
                    self.iv_ssns_per_addr                 := iv_ssns_per_addr;
                    self.iv_ssns_per_sfd_addr             := iv_ssns_per_sfd_addr;
                    self.iv_phones_per_apt_addr           := iv_phones_per_apt_addr;
                    self.iv_phones_per_sfd_addr           := iv_phones_per_sfd_addr;
                    self.iv_max_ids_per_addr              := iv_max_ids_per_addr;
                    self.iv_max_ids_per_sfd_addr          := iv_max_ids_per_sfd_addr;
                    self.iv_adls_per_phone                := iv_adls_per_phone;
                    self.iv_ssns_per_adl_c6               := iv_ssns_per_adl_c6;
                    self.iv_adls_per_addr_c6              := iv_adls_per_addr_c6;
                    self.iv_adls_per_sfd_addr_c6          := iv_adls_per_sfd_addr_c6;
                    self.iv_ssns_per_sfd_addr_c6          := iv_ssns_per_sfd_addr_c6;
                    self.iv_max_ids_per_sfd_addr_c6       := iv_max_ids_per_sfd_addr_c6;
                    self.iv_phones_per_addr_c6            := iv_phones_per_addr_c6;
                    self.iv_adls_per_phone_c6             := iv_adls_per_phone_c6;
                    self.iv_vo_addrs_per_adl              := iv_vo_addrs_per_adl;
                    self.iv_pl_addrs_per_adl              := iv_pl_addrs_per_adl;
                    self.iv_inq_auto_count12              := iv_inq_auto_count12;
                    self.iv_inq_auto_recency              := iv_inq_auto_recency;
                    self.iv_inq_ssns_per_adl              := iv_inq_ssns_per_adl;
                    self.iv_inq_addrs_per_adl             := iv_inq_addrs_per_adl;
                    self.iv_inq_num_diff_names_per_adl    := iv_inq_num_diff_names_per_adl;
                    self.iv_inq_phones_per_adl            := iv_inq_phones_per_adl;
                    self.iv_inq_dobs_per_adl              := iv_inq_dobs_per_adl;
                    self.iv_inq_per_ssn                   := iv_inq_per_ssn;
                    self.iv_inq_addrs_per_ssn             := iv_inq_addrs_per_ssn;
                    self.iv_inq_per_addr                  := iv_inq_per_addr;
                    self.iv_inq_lnames_per_addr           := iv_inq_lnames_per_addr;
                    self.iv_inq_ssns_per_addr             := iv_inq_ssns_per_addr;
                    self.iv_inq_per_phone                 := iv_inq_per_phone;
                    self._paw_first_seen                  := _paw_first_seen;
                    self.iv_mos_since_paw_first_seen      := iv_mos_since_paw_first_seen;
                    self.iv_paw_dead_business_count       := iv_paw_dead_business_count;
                    self.iv_paw_active_phone_count        := iv_paw_active_phone_count;
                    self._infutor_first_seen              := _infutor_first_seen;
                    self.iv_mos_since_infutor_first_seen  := iv_mos_since_infutor_first_seen;
                    self._infutor_last_seen               := _infutor_last_seen;
                    self.iv_mos_since_infutor_last_seen   := iv_mos_since_infutor_last_seen;
                    self.iv_infutor_nap                   := iv_infutor_nap;
                    self.iv_attr_addrs_recency            := iv_attr_addrs_recency;
                    self.iv_attr_purchase_recency         := iv_attr_purchase_recency;
                    self.iv_attr_rel_liens_recency        := iv_attr_rel_liens_recency;
                    self.iv_attr_bankruptcy_recency       := iv_attr_bankruptcy_recency;
                    self.iv_attr_proflic_exp_recency      := iv_attr_proflic_exp_recency;
                    self.iv_non_derog_count               := iv_non_derog_count;
                    self.iv_unreleased_liens_ct           := iv_unreleased_liens_ct;
                    self.iv_liens_unrel_cj_ct             := iv_liens_unrel_cj_ct;
                    self.iv_liens_unrel_ft_ct             := iv_liens_unrel_ft_ct;
                    self.iv_liens_rel_ft_ct               := iv_liens_rel_ft_ct;
                    self.iv_liens_unrel_lt_ct             := iv_liens_unrel_lt_ct;
                    self.iv_liens_rel_ot_ct               := iv_liens_rel_ot_ct;
                    self.ams_major_medical                := ams_major_medical;
                    self.ams_major_science                := ams_major_science;
                    self.ams_major_liberal                := ams_major_liberal;
                    self.ams_major_business               := ams_major_business;
                    self.ams_major_unknown                := ams_major_unknown;
                    self.iv_ams_college_major             := iv_ams_college_major;
                    self.iv_ams_college_code              := iv_ams_college_code;
                    self.iv_ams_college_type              := iv_ams_college_type;
                    self.iv_ams_college_tier              := iv_ams_college_tier;
                    self.iv_ams_file_type                 := iv_ams_file_type;
                    self.iv_prof_license_category         := iv_prof_license_category;
                    self.final_score_0                    := final_score_0;
                    self.final_score_1                    := final_score_1;
                    self.final_score_2                    := final_score_2;
                    self.final_score_3                    := final_score_3;
                    self.final_score_4                    := final_score_4;
                    self.final_score_5                    := final_score_5;
                    self.final_score_6                    := final_score_6;
                    self.final_score_7                    := final_score_7;
                    self.final_score_8                    := final_score_8;
                    self.final_score_9                    := final_score_9;
                    self.final_score_10                   := final_score_10;
                    self.final_score_11                   := final_score_11;
                    self.final_score_12                   := final_score_12;
                    self.final_score_13                   := final_score_13;
                    self.final_score_14                   := final_score_14;
                    self.final_score_15                   := final_score_15;
                    self.final_score_16                   := final_score_16;
                    self.final_score_17                   := final_score_17;
                    self.final_score_18                   := final_score_18;
                    self.final_score_19                   := final_score_19;
                    self.final_score_20                   := final_score_20;
                    self.final_score_21                   := final_score_21;
                    self.final_score_22                   := final_score_22;
                    self.final_score_23                   := final_score_23;
                    self.final_score_24                   := final_score_24;
                    self.final_score_25                   := final_score_25;
                    self.final_score_26                   := final_score_26;
                    self.final_score_27                   := final_score_27;
                    self.final_score_28                   := final_score_28;
                    self.final_score_29                   := final_score_29;
                    self.final_score_30                   := final_score_30;
                    self.final_score_31                   := final_score_31;
                    self.final_score_32                   := final_score_32;
                    self.final_score_33                   := final_score_33;
                    self.final_score_34                   := final_score_34;
                    self.final_score_35                   := final_score_35;
                    self.final_score_36                   := final_score_36;
                    self.final_score_37                   := final_score_37;
                    self.final_score_38                   := final_score_38;
                    self.final_score_39                   := final_score_39;
                    self.final_score_40                   := final_score_40;
                    self.final_score_41                   := final_score_41;
                    self.final_score_42                   := final_score_42;
                    self.final_score_43                   := final_score_43;
                    self.final_score_44                   := final_score_44;
                    self.final_score_45                   := final_score_45;
                    self.final_score_46                   := final_score_46;
                    self.final_score_47                   := final_score_47;
                    self.final_score_48                   := final_score_48;
                    self.final_score_49                   := final_score_49;
                    self.final_score_50                   := final_score_50;
                    self.final_score_51                   := final_score_51;
                    self.final_score_52                   := final_score_52;
                    self.final_score_53                   := final_score_53;
                    self.final_score_54                   := final_score_54;
                    self.final_score_55                   := final_score_55;
                    self.final_score_56                   := final_score_56;
                    self.final_score_57                   := final_score_57;
                    self.final_score_58                   := final_score_58;
                    self.final_score_59                   := final_score_59;
                    self.final_score_60                   := final_score_60;
                    self.final_score_61                   := final_score_61;
                    self.final_score_62                   := final_score_62;
                    self.final_score_63                   := final_score_63;
                    self.final_score_64                   := final_score_64;
                    self.final_score_65                   := final_score_65;
                    self.final_score_66                   := final_score_66;
                    self.final_score_67                   := final_score_67;
                    self.final_score_68                   := final_score_68;
                    self.final_score_69                   := final_score_69;
                    self.final_score_70                   := final_score_70;
                    self.final_score_71                   := final_score_71;
                    self.final_score_72                   := final_score_72;
                    self.final_score_73                   := final_score_73;
                    self.final_score_74                   := final_score_74;
                    self.final_score_75                   := final_score_75;
                    self.final_score_76                   := final_score_76;
                    self.final_score_77                   := final_score_77;
                    self.final_score_78                   := final_score_78;
                    self.final_score_79                   := final_score_79;
                    self.final_score_80                   := final_score_80;
                    self.final_score_81                   := final_score_81;
                    self.final_score_82                   := final_score_82;
                    self.final_score_83                   := final_score_83;
                    self.final_score_84                   := final_score_84;
                    self.final_score_85                   := final_score_85;
                    self.final_score_86                   := final_score_86;
                    self.final_score_87                   := final_score_87;
                    self.final_score_88                   := final_score_88;
                    self.final_score_89                   := final_score_89;
                    self.final_score_90                   := final_score_90;
                    self.final_score_91                   := final_score_91;
                    self.final_score_92                   := final_score_92;
                    self.final_score_93                   := final_score_93;
                    self.final_score_94                   := final_score_94;
                    self.final_score_95                   := final_score_95;
                    self.final_score_96                   := final_score_96;
                    self.final_score_97                   := final_score_97;
                    self.final_score_98                   := final_score_98;
                    self.final_score_99                   := final_score_99;
                    self.final_score_100                  := final_score_100;
                    self.final_score_101                  := final_score_101;
                    self.final_score_102                  := final_score_102;
                    self.final_score_103                  := final_score_103;
                    self.final_score_104                  := final_score_104;
                    self.final_score_105                  := final_score_105;
                    self.final_score_106                  := final_score_106;
                    self.final_score_107                  := final_score_107;
                    self.final_score_108                  := final_score_108;
                    self.final_score_109                  := final_score_109;
                    self.final_score_110                  := final_score_110;
                    self.final_score_111                  := final_score_111;
                    self.final_score_112                  := final_score_112;
                    self.final_score_113                  := final_score_113;
                    self.final_score_114                  := final_score_114;
                    self.final_score_115                  := final_score_115;
                    self.final_score_116                  := final_score_116;
                    self.final_score_117                  := final_score_117;
                    self.final_score_118                  := final_score_118;
                    self.final_score_119                  := final_score_119;
                    self.final_score_120                  := final_score_120;
                    self.final_score_121                  := final_score_121;
                    self.final_score_122                  := final_score_122;
                    self.final_score_123                  := final_score_123;
                    self.final_score_124                  := final_score_124;
                    self.final_score_125                  := final_score_125;
                    self.final_score_126                  := final_score_126;
                    self.final_score_127                  := final_score_127;
                    self.final_score_128                  := final_score_128;
                    self.final_score_129                  := final_score_129;
                    self.final_score_130                  := final_score_130;
                    self.final_score_131                  := final_score_131;
                    self.final_score_132                  := final_score_132;
                    self.final_score_133                  := final_score_133;
                    self.final_score_134                  := final_score_134;
                    self.final_score_135                  := final_score_135;
                    self.final_score_136                  := final_score_136;
                    self.final_score_137                  := final_score_137;
                    self.final_score_138                  := final_score_138;
                    self.final_score_139                  := final_score_139;
                    self.final_score_140                  := final_score_140;
                    self.final_score_141                  := final_score_141;
                    self.final_score_142                  := final_score_142;
                    self.final_score_143                  := final_score_143;
                    self.final_score_144                  := final_score_144;
                    self.final_score_145                  := final_score_145;
                    self.final_score_146                  := final_score_146;
                    self.final_score_147                  := final_score_147;
                    self.final_score_148                  := final_score_148;
                    self.final_score_149                  := final_score_149;
                    self.final_score_150                  := final_score_150;
                    self.final_score_151                  := final_score_151;
                    self.final_score_152                  := final_score_152;
                    self.final_score_153                  := final_score_153;
                    self.final_score_154                  := final_score_154;
                    self.final_score_155                  := final_score_155;
                    self.final_score_156                  := final_score_156;
                    self.final_score_157                  := final_score_157;
                    self.final_score_158                  := final_score_158;
                    self.final_score_159                  := final_score_159;
                    self.final_score_160                  := final_score_160;
                    self.final_score_161                  := final_score_161;
                    self.final_score_162                  := final_score_162;
                    self.final_score_163                  := final_score_163;
                    self.final_score_164                  := final_score_164;
                    self.final_score_165                  := final_score_165;
                    self.final_score_166                  := final_score_166;
                    self.final_score_167                  := final_score_167;
                    self.final_score_168                  := final_score_168;
                    self.final_score_169                  := final_score_169;
                    self.final_score_170                  := final_score_170;
                    self.final_score_171                  := final_score_171;
                    self.final_score_172                  := final_score_172;
                    self.final_score_173                  := final_score_173;
                    self.final_score_174                  := final_score_174;
                    self.final_score_175                  := final_score_175;
                    self.final_score_176                  := final_score_176;
                    self.final_score_177                  := final_score_177;
                    self.final_score_178                  := final_score_178;
                    self.final_score_179                  := final_score_179;
                    self.final_score_180                  := final_score_180;
                    self.final_score_181                  := final_score_181;
                    self.final_score_182                  := final_score_182;
                    self.final_score_183                  := final_score_183;
                    self.final_score_184                  := final_score_184;
                    self.final_score_185                  := final_score_185;
                    self.final_score_186                  := final_score_186;
                    self.final_score_187                  := final_score_187;
                    self.final_score_188                  := final_score_188;
                    self.final_score_189                  := final_score_189;
                    self.final_score_190                  := final_score_190;
                    self.final_score_191                  := final_score_191;
                    self.final_score_192                  := final_score_192;
                    self.final_score_193                  := final_score_193;
                    self.final_score_194                  := final_score_194;
                    self.final_score_195                  := final_score_195;
                    self.final_score_196                  := final_score_196;
                    self.final_score_197                  := final_score_197;
                    self.final_score_198                  := final_score_198;
                    self.final_score_199                  := final_score_199;
                    self.final_score_200                  := final_score_200;
                    self.final_score_201                  := final_score_201;
                    self.final_score_202                  := final_score_202;
                    self.final_score_203                  := final_score_203;
                    self.final_score_204                  := final_score_204;
                    self.final_score_205                  := final_score_205;
                    self.final_score_206                  := final_score_206;
                    self.final_score_207                  := final_score_207;
                    self.final_score_208                  := final_score_208;
                    self.final_score_209                  := final_score_209;
                    self.final_score_210                  := final_score_210;
                    self.final_score_211                  := final_score_211;
                    self.final_score_212                  := final_score_212;
                    self.final_score_213                  := final_score_213;
                    self.final_score_214                  := final_score_214;
                    self.final_score_215                  := final_score_215;
                    self.final_score_216                  := final_score_216;
                    self.final_score_217                  := final_score_217;
                    self.final_score_218                  := final_score_218;
                    self.final_score_219                  := final_score_219;
                    self.final_score_220                  := final_score_220;
                    self.final_score_221                  := final_score_221;
                    self.final_score_222                  := final_score_222;
                    self.final_score_223                  := final_score_223;
                    self.final_score_224                  := final_score_224;
                    self.final_score_225                  := final_score_225;
                    self.final_score_226                  := final_score_226;
                    self.final_score_227                  := final_score_227;
                    self.final_score_228                  := final_score_228;
                    self.final_score_229                  := final_score_229;
                    self.final_score_230                  := final_score_230;
                    self.final_score_231                  := final_score_231;
                    self.final_score_232                  := final_score_232;
                    self.final_score_233                  := final_score_233;
                    self.final_score_234                  := final_score_234;
                    self.final_score_235                  := final_score_235;
                    self.final_score_236                  := final_score_236;
                    self.final_score_237                  := final_score_237;
                    self.final_score_238                  := final_score_238;
                    self.final_score_239                  := final_score_239;
                    self.final_score_240                  := final_score_240;
                    self.final_score_241                  := final_score_241;
                    self.final_score_242                  := final_score_242;
                    self.final_score_243                  := final_score_243;
                    self.final_score_244                  := final_score_244;
                    self.final_score_245                  := final_score_245;
                    self.final_score_246                  := final_score_246;
                    self.final_score_247                  := final_score_247;
                    self.final_score_248                  := final_score_248;
                    self.final_score_249                  := final_score_249;
                    self.final_score_250                  := final_score_250;
                    self.final_score_251                  := final_score_251;
                    self.final_score_252                  := final_score_252;
                    self.final_score_253                  := final_score_253;
                    self.final_score_254                  := final_score_254;
                    self.final_score_255                  := final_score_255;
                    self.final_score_256                  := final_score_256;
                    self.final_score_257                  := final_score_257;
                    self.final_score_258                  := final_score_258;
                    self.final_score_259                  := final_score_259;
                    self.final_score_260                  := final_score_260;
                    self.final_score_261                  := final_score_261;
                    self.final_score_262                  := final_score_262;
                    self.final_score_263                  := final_score_263;
                    self.final_score_264                  := final_score_264;
                    self.final_score_265                  := final_score_265;
                    self.final_score_266                  := final_score_266;
                    self.final_score_267                  := final_score_267;
                    self.final_score_268                  := final_score_268;
                    self.final_score_269                  := final_score_269;
                    self.final_score_270                  := final_score_270;
                    self.final_score_271                  := final_score_271;
                    self.final_score_272                  := final_score_272;
                    self.final_score_273                  := final_score_273;
                    self.final_score_274                  := final_score_274;
                    self.final_score_275                  := final_score_275;
                    self.final_score_276                  := final_score_276;
                    self.final_score_277                  := final_score_277;
                    self.final_score_278                  := final_score_278;
                    self.final_score_279                  := final_score_279;
                    self.final_score_280                  := final_score_280;
                    self.final_score_281                  := final_score_281;
                    self.final_score_282                  := final_score_282;
                    self.final_score_283                  := final_score_283;
                    self.final_score_284                  := final_score_284;
                    self.final_score_285                  := final_score_285;
                    self.final_score_286                  := final_score_286;
                    self.final_score_287                  := final_score_287;
                    self.final_score_288                  := final_score_288;
                    self.final_score_289                  := final_score_289;
                    self.final_score_290                  := final_score_290;
                    self.final_score_291                  := final_score_291;
                    self.final_score_292                  := final_score_292;
                    self.final_score_293                  := final_score_293;
                    self.final_score_294                  := final_score_294;
                    self.final_score_295                  := final_score_295;
                    self.final_score_296                  := final_score_296;
                    self.final_score_297                  := final_score_297;
                    self.final_score_298                  := final_score_298;
                    self.final_score_299                  := final_score_299;
                    self.final_score_300                  := final_score_300;
                    self.final_score_301                  := final_score_301;
                    self.final_score_302                  := final_score_302;
                    self.final_score_303                  := final_score_303;
                    self.final_score_304                  := final_score_304;
                    self.final_score_305                  := final_score_305;
                    self.final_score_306                  := final_score_306;
                    self.final_score_307                  := final_score_307;
                    self.final_score_308                  := final_score_308;
                    self.final_score_309                  := final_score_309;
                    self.final_score_310                  := final_score_310;
                    self.final_score_311                  := final_score_311;
                    self.final_score_312                  := final_score_312;
                    self.final_score_313                  := final_score_313;
                    self.final_score_314                  := final_score_314;
                    self.final_score_315                  := final_score_315;
                    self.final_score_316                  := final_score_316;
                    self.final_score_317                  := final_score_317;
                    self.final_score_318                  := final_score_318;
                    self.final_score_319                  := final_score_319;
                    self.final_score_320                  := final_score_320;
                    self.final_score_321                  := final_score_321;
                    self.final_score_322                  := final_score_322;
                    self.final_score_323                  := final_score_323;
                    self.final_score_324                  := final_score_324;
                    self.final_score_325                  := final_score_325;
                    self.final_score_326                  := final_score_326;
                    self.final_score_327                  := final_score_327;
                    self.final_score_328                  := final_score_328;
                    self.final_score_329                  := final_score_329;
                    self.final_score_330                  := final_score_330;
                    self.final_score_331                  := final_score_331;
                    self.final_score_332                  := final_score_332;
                    self.final_score_333                  := final_score_333;
                    self.final_score_334                  := final_score_334;
                    self.final_score_335                  := final_score_335;
                    self.final_score_336                  := final_score_336;
                    self.final_score_337                  := final_score_337;
                    self.final_score_338                  := final_score_338;
                    self.final_score_339                  := final_score_339;
                    self.final_score_340                  := final_score_340;
                    self.final_score_341                  := final_score_341;
                    self.final_score_342                  := final_score_342;
                    self.final_score_343                  := final_score_343;
                    self.final_score_344                  := final_score_344;
                    self.final_score_345                  := final_score_345;
                    self.final_score_346                  := final_score_346;
                    self.final_score_347                  := final_score_347;
                    self.final_score_348                  := final_score_348;
                    self.final_score_349                  := final_score_349;
                    self.final_score_350                  := final_score_350;
                    self.final_score_351                  := final_score_351;
                    self.final_score_352                  := final_score_352;
                    self.final_score_353                  := final_score_353;
                    self.final_score_354                  := final_score_354;
                    self.final_score_355                  := final_score_355;
                    self.final_score_356                  := final_score_356;
                    self.final_score_357                  := final_score_357;
                    self.final_score_358                  := final_score_358;
                    self.final_score_359                  := final_score_359;
                    self.final_score_360                  := final_score_360;
                    self.final_score_361                  := final_score_361;
                    self.final_score_362                  := final_score_362;
                    self.final_score_363                  := final_score_363;
                    self.final_score_364                  := final_score_364;
                    self.final_score_365                  := final_score_365;
                    self.final_score_366                  := final_score_366;
                    self.final_score_367                  := final_score_367;
                    self.final_score_368                  := final_score_368;
                    self.final_score_369                  := final_score_369;
                    self.final_score_370                  := final_score_370;
                    self.final_score_371                  := final_score_371;
                    self.final_score_372                  := final_score_372;
                    self.final_score_373                  := final_score_373;
                    self.final_score_374                  := final_score_374;
                    self.final_score_375                  := final_score_375;
                    self.final_score_376                  := final_score_376;
                    self.final_score                      := final_score;
                    self.ssn_deceased                     := ssn_deceased;
                    self.iv_riskview_222s                 := iv_riskview_222s;
                    self.pbr                              := pbr;
                    self.sbr                              := sbr;
                    self.offset                           := offset;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.rvc1703_1_0                      := rvc1703_1_0;
                    self.rc1v                             := rc1v;
                    self.rc2v                             := rc2v;
                    self.rc3v                             := rc3v;
                    self.rc4v                             := rc4v;
                    self.model_lien_present               := model_lien_present;
                    self.rc3                              := rc3;
                    self.rc2                              := rc2;
                    self.rc1                              := rc1;
                    self.rc4                              := rc4;
                    self.rc5                              := rc5;
										
		#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		self.score := if(reasons[1].hri IN ['91','92','93','94'],
		                 (STRING3)((INTEGER)reasons[1].hri + 10),
										 (string3)rvc1703_1_0);
END;

		model := project( clam, doModel(left) );

		return model;

END;
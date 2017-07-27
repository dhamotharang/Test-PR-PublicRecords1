EXPORT Common := MODULE
	EXPORT Model_Debug := FALSE; // Set to TRUE to have Attributes returned, FALSE to run normally

	WFFlattenedLayout := RECORD
		progressive_phone.layout_progressive_phone_common;
		UNSIGNED1 wf_level_ind_AP := 0;
		UNSIGNED1 wf_level_ind_CL := 0;
		UNSIGNED1 wf_level_ind_CR := 0;
		UNSIGNED1 wf_level_ind_ES := 0;
		UNSIGNED1 wf_level_ind_MD := 0;
		UNSIGNED1 wf_level_ind_SE := 0;
		UNSIGNED1 wf_level_ind_SP := 0;
		UNSIGNED1 wf_level_ind_SX := 0;
		UNSIGNED1 wf_level_ind_PP := 0;
		UNSIGNED1 wf_level_ind_TH := 0;
		STRING8 matchcodes_AP := '';
		STRING8 matchcodes_CL := '';
		STRING8 matchcodes_CR := '';
		STRING8 matchcodes_ES := '';
		STRING8 matchcodes_MD := '';
		STRING8 matchcodes_SE := '';
		STRING8 matchcodes_SP := '';
		STRING8 matchcodes_SX := '';
		STRING8 matchcodes_PP := '';
		STRING8 matchcodes_TH := '';
	END;	
	
	WFFlattenedAttributesLayout := RECORD
		// Aggregated Waterfall Phones Output
		WFFlattenedLayout;
		
		// Phones Plus Attributes
		UNSIGNED3 datelastseen := 0;
		UNSIGNED2 append_nonpublished_match := 0;
		UNSIGNED8 rules := 0;
		UNSIGNED4 eda_hist_match := 0;
		UNSIGNED8 src_rule := 0;
		BOOLEAN append_best_addr_match_flag := FALSE;
		STRING16 CellPhoneIDKey_text := '';
		
		// EDA Attributes
		STRING5 address_match_best := ''; // BOOLEAN
		STRING5 days_in_service := ''; // UNSIGNED2
		STRING1 dwelling := '';
		STRING1 eda_attr_subj := '';
		STRING5 num_phone_owners_cur := ''; // UNSIGNED2
		STRING5 num_phones_connected_addr := ''; //UNSIGNED2
	END;	
	
	EXPORT Layout_Debug_v1 := RECORD			
			/* Model Inputs */
			WFFlattenedAttributesLayout;

			/* Model Variables */
			INTEGER archive_date;
			BOOLEAN cell_ind;
			REAL _month;
			INTEGER age_last_seen;
			INTEGER age_last_seen_c120;
			INTEGER age_last_seen_c120_rec;
			BOOLEAN app_nonpub_match_1_ind;
			BOOLEAN app_nonpub_match_2_ind;
			BOOLEAN app_nonpub_match_gong;
			BOOLEAN rules_7_ind;
			BOOLEAN eda_hist_match_1_ind;
			BOOLEAN src_rule_11_ind;
			INTEGER matchcode_n;
			INTEGER matchcode_a;
			INTEGER matchcode_c;
			INTEGER matchcode_z;
			INTEGER matchcode_lvl_n_a;
			INTEGER matchcode_lvl_n_a_c;
			INTEGER matchcode_lvl_n_a_c_z;
			REAL matchcode_lvl_n_a_c_z_l;
			INTEGER age_last_seen_c120_rec_cell;
			REAL pp_score;
			REAL pp_score_prob;
			BOOLEAN matchcodes_a;
			BOOLEAN matchcodes_n;
			BOOLEAN matchcodes_c;
			BOOLEAN matchcodes_z;
			INTEGER orth_lvl_sx_1;
			INTEGER orth_lvl_sp_1;
			INTEGER orth_lvl_md_1;
			INTEGER orth_lvl_cl_1;
			INTEGER orth_lvl_ap_1;
			INTEGER orth_lvl_ap_es_se_sp_sx_1;
			INTEGER orth_lvl_ap_cl_es_se_sx_1;
			INTEGER orth_lvl_other_1;
			INTEGER orth_lvl_md;
			INTEGER orth_lvl_ap_cl_es_se_sx;
			INTEGER orth_lvl_sx;
			INTEGER orth_lvl_cl;
			INTEGER orth_lvl_other;
			INTEGER orth_lvl_ap;
			INTEGER orth_lvl_ap_es_se_sp_sx;
			INTEGER orth_other_se;
			INTEGER orth_other_sx;
			INTEGER orth_other_ap;
			INTEGER orth_oth_es;
			INTEGER orth_oth_es_se;
			INTEGER orth_oth_es_se_sx;
			INTEGER orth_oth_es_se_sx_ap;
			REAL orth_oth_es_se_sx_ap_l;
			INTEGER match_orth_ap_cl_es_se_sx_c;
			INTEGER days_in_service_rec;
			INTEGER num_phones_connected_addr_rec;
			INTEGER num_phone_owners_cur_c2;
			INTEGER num_phone_owners_cur_c2_rec;
			INTEGER dwell_eda_subj_lvl;
			REAL dwell_eda_subj_lvl_l;
			INTEGER address_match_best_rec;
			INTEGER match_orth_ap_cl_es_se_sx_n;
			INTEGER match_orth_md_c;
			INTEGER match_orth_ap_es_se_sp_sx_n;
			INTEGER match_orth_other_n;
			INTEGER match_orth_sx_n;
			REAL eda_score;
			REAL eda_score_prob;
			REAL phones_score_prob;
			REAL phones_score_logit;
			INTEGER point;
			INTEGER base;
			REAL odds;
			INTEGER phones_score;
		END;
END;
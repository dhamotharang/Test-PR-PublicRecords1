
EXPORT Regulatory := module

		// copied from hygenics_crim.layout_offender
		export Crim_offender_Layout := record
				string8 		process_date;
				string8 		file_date;
				string60 		offender_key;
				string5 		vendor;
				string20 		source_file;
				string2 		record_type;
				string25 		orig_state;
				string15 		id_num;
				string56 		pty_nm;
				string1 		pty_nm_fmt;
				string20 		orig_lname;
				string20 		orig_fname;
				string20 		orig_mname;
				string10 		orig_name_suffix;
				// string5 	title;
				string20 		lname;
				string20 		fname;
				string20 		mname;
				string6 		name_suffix;
				//string3 	cleaning_score;
				string1 		pty_typ;
				unsigned8		nid;
				string1			ntype;
				unsigned2		nindicator;
				string1 		nitro_flag;
				string9 		ssn;
				string35 		case_num;
				string40 		case_court;
				string8 		case_date;
				string5 		case_type;
				string25 		case_type_desc;
				string30 		county_of_origin;
				string10 		dle_num;
				string9 		fbi_num;
				string10		doc_num;
				string10 		ins_num;
				string25 		dl_num;
				string2 		dl_state;
				string2 		citizenship;
				string8 		dob;
				string8 		dob_alias;
				string13 		county_of_birth;
				string25 		place_of_birth;
				string25 		street_address_1;
				string25 		street_address_2;
				string25 		street_address_3;
				string10 		street_address_4;
				string10 		street_address_5;
				string13 		current_residence_county;
				string13 		legal_residence_county;
				string3 		race;
				string30 		race_desc;
				string7 		sex;
				string3 		hair_color;
				string15 		hair_color_desc;
				string3 		eye_color;
				string15 		eye_color_desc;
				string3 		skin_color;
				string15 		skin_color_desc;
				string10 		scars_marks_tattoos_1;
				string10 		scars_marks_tattoos_2;
				string10 		scars_marks_tattoos_3;
				string10 		scars_marks_tattoos_4;
				string10 		scars_marks_tattoos_5;
				string3 		height;
				string3 		weight;
				string5 		party_status;
				string60 		party_status_desc;
				string10 		_3g_offender;
				string10 		violent_offender;
				string10 		sex_offender;
				string10 		vop_offender;
				string1 		data_type;
				string26 		record_setup_date;
				string45 		datasource;
				qstring10 	prim_range;
				string2 		predir;
				qstring28 	prim_name;
				qstring4 		addr_suffix;
				string2 		postdir;
				qstring10 	unit_desig;
				qstring8 		sec_range;
				qstring25 	p_city_name;
				qstring25 	v_city_name;
				string2 		st;
				qstring5 		zip5;
				qstring4 		zip4;
				string4			cart;
				string1			cr_sort_sz;
				string4			lot;
				string1			lot_order;
				string2			dpbc;
				string1			chk_digit;
				string2			rec_type;
				string2			ace_fips_st;
				string3			ace_fips_county;
				string10		geo_lat;
				string11		geo_long;
				string4			msa;
				string7			geo_blk;
				string1			geo_match;
				string4			err_stat;
				unsigned1 	clean_errors;
				string18 		county_name;
				string12 		did;
				string3 		score;
				string9 		ssn_appended;
				string1 		curr_incar_flag;
				string1 		curr_parole_flag;
				string1 		curr_probation_flag;
				string8 		src_upload_date;
				string3 		age;
				string150 	image_link;
				string1 		fcra_conviction_flag;
				string1 		fcra_traffic_flag;
				string8 		fcra_date;
				string1 		fcra_date_type;
				string8 		conviction_override_date;
				string1 		conviction_override_date_type;
				string2 		offense_score;
				unsigned8		offender_persistent_id;
		end;
		

		// copied from hygenics_crim.Layout_Base_Offenses_with_OffenseCategory
		export Crim_Offenses_Layout := record
				string8			process_date;
				string60		offender_key;
				string5			vendor;
				string30		county_of_origin;
				string20		source_file;
				//string50	off_name;
				string1			data_type;
				string2			record_type;
				string2			orig_state;
				string50		offense_key;
				string8			off_date;
				string8			arr_date;
				string35		case_num;
				string3			total_num_of_offenses:='';
				string3			num_of_counts:='';
				string20		off_code:='';
				string31		chg:='';
				string1			chg_typ_flg:='';
				string4 		off_of_record;
				string75		off_desc_1:='';
				string50		off_desc_2:='';
				string2			add_off_cd:='';
				string30		add_off_desc:='';
				string1			off_typ:='';
				string5			off_lev:='';
				string8			arr_disp_date:='';
				string3			arr_disp_cd:='';
				string50		arr_disp_desc_1:='';
				string50		arr_disp_desc_2:='';
				string50		arr_disp_desc_3:='';
				string5			court_cd:='';
				string40		court_desc:='';
				string40		ct_dist:='';
				string1			ct_fnl_plea_cd:='';
				string30		ct_fnl_plea:='';
				string8			ct_off_code:='';
				string17		ct_chg:='';
				string1			ct_chg_typ_flg:='';
				string50		ct_off_desc_1:='';
				string50		ct_off_desc_2:='';
				string1			ct_addl_desc_cd:='';
				string2			ct_off_lev:='';
				string8			ct_disp_dt:='';
				string4			ct_disp_cd:='';
				string50		ct_disp_desc_1:='';
				string50		ct_disp_desc_2:='';
				string2			cty_conv_cd:='';
				string30		cty_conv:='';
				string1			adj_wthd:='';
				string8			stc_dt:='';
				string3			stc_cd:='';
				string3			stc_comp:='';
				string50		stc_desc_1:='';
				string50		stc_desc_2:='';
				string50		stc_desc_3:='';
				string50		stc_desc_4:='';
				string15		stc_lgth:='';
				string50		stc_lgth_desc:='';
				string8			inc_adm_dt:='';
				string10		min_term:='';
				string35		min_term_desc:='';
				string10		max_term:='';
				string35		max_term_desc:='';
				string50  	Parole:='';
				String50  	Probation:='';
				String40  	OffenseTown:='';
				String8   	Convict_dt:=''; 
				string40  	Court_County:='';
				string60 		fcra_offense_key:='';
				string1 		fcra_conviction_flag:='';
				string1 		fcra_traffic_flag:='';
				string8 		fcra_date:='';
				string1 		fcra_date_type:='';
				string8 		conviction_override_date:='';
				string1 		conviction_override_date_type:='';
				string2 		offense_score:='';
				unsigned8		offense_persistent_id:=0;
				unsigned8  	offense_category; 
				string8    	Hyg_classification_code;
				string8    	Old_ln_Offense_score;
		end;

		// copied from hygenics_crim.Layout_CrimPunishment
		export Crim_Punishment_Layout := record
				string8			process_date;
				string60		offender_key;
				string8 		event_dt;
				string5			vendor;
				string20		source_file;
				string2			record_type := '';
				string2			orig_state;
				string50		offense_key;
				string1			punishment_type;
				string8			sent_date:='';
				string15		sent_length:='';
				string60		sent_length_desc:='';
				string8			cur_stat_inm:='';
				string50		cur_stat_inm_desc:='';
				string8			cur_loc_inm_cd:='';
				string60		cur_loc_inm:='';
				string8			inm_com_cty_cd:='';
				string25		inm_com_cty:='';
				string8			cur_sec_class_dt:='';
				string25		cur_loc_sec:='';
				string3			gain_time:='';
				string8			gain_time_eff_dt:='';
				string8			latest_adm_dt:='';
				string8			sch_rel_dt:='';
				string8			act_rel_dt:='';
				string8			ctl_rel_dt:='';
				string8			presump_par_rel_dt:='';
				string8			mutl_part_pgm_dt:='';
				string4 		release_type;
				string2 		office_region;
				string8			par_cur_stat:='';
				string50		par_cur_stat_desc:='';
				string8			par_status_dt:='';
				string8			par_st_dt:='';
				string8			par_sch_end_dt:='';
				string8			par_act_end_dt:='';
				string8			par_cty_cd:='';
				string50		par_cty:='';
				string30 		supv_office;
				string30 		supv_officer;
				string14 		office_phone;
				string2 		tdcjid_unit_type;
				string15 		tdcjid_unit_assigned;
				string1 		tdcjid_admit_date;
				string1 		prison_status;
				string2 		recv_dept_code;
				string10 		recv_dept_date;
				string1 		parole_active_flag;
				string10 		casepull_date;
				string8   	pro_st_dt;
				string8   	pro_end_dt;
				string50  	pro_status;
				string8 		conviction_override_date;
				string1 		conviction_override_date_type;
				unsigned8 	punishment_persistent_id;
				string8   	fcra_date;  //VC 
				string1   	fcra_date_type;
		end;

		// copied from hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory
		EXPORT Crim_CourtOffenses_Layout := record    
				string8 		process_date;
				string60 		offender_key;
				string5 		vendor;
				string2 		state_origin;
				string20 		source_file;
				string1 		data_type;
				string4 		off_comp;
				string1 		off_delete_flag;
				string8 		off_date;
				string8 		arr_date;
				string3 		num_of_counts;
				string10 		le_agency_cd;
				string50 		le_agency_desc;
				string35 		le_agency_case_number;
				string35 		traffic_ticket_number;
				string25 		traffic_dl_no;
				string2 		traffic_dl_st;
				string20 		arr_off_code;
				string75 		arr_off_desc_1;
				string50 		arr_off_desc_2;
				string5 		arr_off_type_cd;
				string30 		arr_off_type_desc;
				string5 		arr_off_lev;
				string20 		arr_statute;
				string70 		arr_statute_desc;
				string8 		arr_disp_date;
				string5 		arr_disp_code;
				string30 		arr_disp_desc_1;
				string30 		arr_disp_desc_2;
				string10 		pros_refer_cd;
				string50 		pros_refer;
				string10 		pros_assgn_cd;
				string50 		pros_assgn;
				string1 		pros_chg_rej;
				string20 		pros_off_code;
				string75 		pros_off_desc_1;
				string50 		pros_off_desc_2;
				string5 		pros_off_type_cd;
				string30 		pros_off_type_desc;
				string5 		pros_off_lev;
				string30 		pros_act_filed;
				string35 		court_case_number;
				string10 		court_cd;
				string40 		court_desc;
				string1 		court_appeal_flag;
				string30 		court_final_plea;
				string20 		court_off_code;
				string75 		court_off_desc_1;
				string50 		court_off_desc_2;
				string5 		court_off_type_cd;
				string30 		court_off_type_desc;
				string5 		court_off_lev;
				string20 		court_statute;
				string50 		court_additional_statutes;
				string70 		court_statute_desc;
				string8 		court_disp_date;
				string5 		court_disp_code;
				string40 		court_disp_desc_1;
				string40 		court_disp_desc_2;
				string8 		sent_date;
				string50 		sent_jail;
				string50 		sent_susp_time;
				string8 		sent_court_cost;
				string9 		sent_court_fine;
				string9 		sent_susp_court_fine;
				string50 		sent_probation;
				string5 		sent_addl_prov_code;
				string40 		sent_addl_prov_desc_1;
				string40 		sent_addl_prov_desc_2;
				string2 		sent_consec;
				string10 		sent_agency_rec_cust_ori;
				string50 		sent_agency_rec_cust;
				string8 		appeal_date;
				string40 		appeal_off_disp;
				string40 		appeal_final_decision;
				string8 		convict_dt;
				string30 		offense_town;
				string30 		cty_conv;
				string12 		restitution;
				string30 		community_service;
				string20 		parole;
				string30 		addl_sent_dates;
				string60 		probation_desc2;
				string8 		court_dt;
				string40 		court_county;
				string35 		arr_off_lev_mapped;
				string35 		court_off_lev_mapped;
				string60 		fcra_offense_key;
				string1 		fcra_conviction_flag;
				string1 		fcra_traffic_flag;
				string8 		fcra_date;
				string1 		fcra_date_type;
				string8 		conviction_override_date;
				string1 		conviction_override_date_type;
				string2 		offense_score;
				unsigned8 	offense_persistent_id;
				unsigned8 	offense_category;
				string8   	Hyg_classification_code;
				string8    	Old_ln_Offense_score;
		end;


		//
		// process Criminal Records Offender information
		//
		export apply_CR_Offenders(ds) := 
				functionmacro
						import suppress;
						
						CR_Offn_Offender_Key_Hash(recordof(ds) L) := hashmd5(trim(l.offender_key, left, right));

						ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_cr_offndr_sup.txt', CR_Offn_Offender_Key_Hash);

						return Suppress.applyRegulatory.CR_simple_append(ds1, 'file_cr_offndr_inj.thor', hygenics_crim.Regulatory.Crim_Offender_Layout);
				endmacro; // apply_CR_Offenders

		//
		// process Criminal Records Offenses information
		//
		// *** if suppression value is ssn or did, then we need to get the offender key based on those values.  
		export apply_CR_Offenses(ds) := 
				functionmacro
						import suppress;

						CR_Offs_Offender_Key_Hash(recordof(ds) L) 	:= hashmd5(trim(l.offender_key, left, right));

						ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_cr_offense_sup.txt', CR_Offs_Offender_Key_Hash);

						return Suppress.applyRegulatory.CR_simple_append(ds1, 'file_cr_offense_inj.thor', hygenics_crim.Regulatory.Crim_Offenses_Layout);
				endmacro; // apply_CR_Offenses

									
			//
			// process Criminal Records Punishment information
			//
			// *** if suppression value is ssn or did, then we need to get the offender key based on those values.  
			export apply_CR_Punishment(ds) := 
					functionmacro
							import suppress;

							CR_Pun_Offender_Key_Hash(recordof(ds) L) := hashmd5(trim(l.offender_key, left, right));
			
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_cr_punishment_sup.txt', CR_Pun_Offender_Key_Hash);									
							
							return Suppress.applyRegulatory.CR_simple_append_Punish(ds1, 'file_cr_punishment_inj.thor', hygenics_crim.Regulatory.Crim_Punishment_Layout);		
					endmacro; // apply_CR_Punishment 			


			//
			// process Criminal Records Activity information
			// this is a placeholder until Activity is processed														
			//
			export apply_CR_Activity(ds) := 
					functionmacro
							return (ds);
					endmacro; // apply_CR_Activity

			
			//
			// process Criminal Records Court Offenses information
			//
			export apply_CR_CourtOffenses(ds) := 
					functionmacro
							import suppress;

							CR_CourtOffs_Offender_Key_Hash(recordof(ds) L) 	:= hashmd5(trim(l.offender_key, left, right));
			
							ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_cr_traffic_offense_sup.txt', CR_CourtOffs_Offender_Key_Hash);
							
							return Suppress.applyRegulatory.CR_simple_append(ds1, 'file_cr_traffic_offense_inj.thor', hygenics_crim.Regulatory.Crim_CourtOffenses_Layout);
					endmacro; // apply_CR_CourtOffenses
					
	end;
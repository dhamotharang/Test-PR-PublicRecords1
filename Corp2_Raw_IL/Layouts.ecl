export Layouts := module

  shared max_size := _Dataset().max_record_size;
	
	export StringLayoutIn								:= record, 		maxlength(max_size)
		string 			payload;
	end;
	
	export StringLayoutBase							:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		StringLayoutIn;
	end;

	//Layouts for Daily/Master
	export MasterFixedStringLayoutIn		:= record
	  string80		masterheader;
	  string1			recordtype;		
		string1000	payload;
	end;

	export MasterLayoutIn 							:= record
		string8 		cd41100_file_number;
		string8 		cd41100_incorp_date;
		string2 		cd41100_state_code;
		string9 		cd41100_filler;
		string3 		cd41100_corp_intent;
		string2 		cd41100_status;
		string1 		cd41100_type_corp;
		string8 		cd41100_trans_date;
		string3 		filler_01;
		string8 		cd41100_date_last_change;
		string7 		cd41100_cr_factor;
		string9 		cd41100_cr_paid_amount;
		string11 		cd41100_ar_cap;
		string8 		cd41100_cr_del_run_date;
		string8 		cd41100_cr_run_date;
		string4 		cd41100_paid_batch_no;
		string4 		cd41100_paid_batch_yr;
		string1 		cd41100_hold_prorate;
		string1 		cd41100_regulated_ind; 
		string1 		filler_02;
		string1 		cd41100_name_length_ind;
		string1 		cd41100_records_destroyed;
		string8			cd41100_cr_paid_date;
		string8 		cd41100_cap_date;
		string7 		cd41100_pv_factor; 
		string9 		cd41100_pv_paid_amount;
		string11 		cd41100_pv_ar_cap;
		string8 		cd41100_pv_del_run_date;
		string8 		cd41100_pv_run_date;
		string4 		cd41100_pv_paid_batch_no;
		string4 		cd41100_pv_paid_batch_yr;
		string1 		cd41100_inc_letter_ind;
		string1 		cd41100_abinitio_ind;
		string1 		cd41100_assume_old_ind;
		string2 		filler_03;
		string8 		cd41100_pv_paid_date;
		string8 		cd41100_duration_date;
		string12 		cd41100_total_cap;
		string10 		filler_04;
		string12 		cd41100_tax_cap;
		string10 		filler_05;
		string11 		cd41100_ill_cap;
		string11 		cd41100_new_ill_cap;
		string11 		cd41100_pv_ill_cap;
		string4			filler_05a;
		string8 		cd41100_agent_change_date;
		string1 		cd41100_agent_code;
		string9 		cd41100_agent_zip;
		string3 		cd41100_agent_county_code;
		string8 		cd41100_fiscal_year;
		string8 		cd41100_extended_date;
		string6 		filler_06;
		string6 		filler_07;
		string4 		cd41100_section_code;
		string8 		cd41100_stock_date;
		string1 		cd41100_revenue_ind;
		string6 		filler_08;
		string30 		cd41100_agent_name;
		string30 		cd41100_agent_street;
		string18 		cd41100_agent_city;
		string8 		cd41100_survivor_nbr;
		string60 		cd41100_pres_name_addr;
		string60 		cd41100_sec_name_addr;
		string189 	cd41100_corp_name;
	end;

	export MasterLayoutBase							:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		MasterLayoutIn;
	end;

	export AssumedOldNamesLayoutIn 			:= record, 		maxlength(230)
		string8 		cd40008_file_number;
		string8 		cd40008_date_cancel;
		string8 		cd40008_assumed_curr_date;
		string1 		cd40008_assumed_old_ind;
		string8 		cd40008_assumed_old_date;
		string189		cd40008_assumed_old_name;
		string11	 	filler;
	end;

	export AssumedOldNamesLayoutBase		:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		AssumedOldNamesLayoutIn;
	end;

	export StockLayoutIn								:= record, 		maxlength(max_size)	
		string8 		cd40019_file_number;
		string25 		cd40019_stock_class;
		string25 		cd40019_stock_series;
		string1 		cd40019_voting_rights;
		string13 		cd40019_authorized_shares;
		string16 		cd40019_issued_shares;
		string12 		cd40019_par_value;
	end;
	
	export StockLayoutBase							:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		StockLayoutIn;
	end;

	//Layouts for LLC 
	export LLCMasterLayoutIn						:= record
	  string1			ll_record_ind_42001; 						//a literal "M" for Master	
		string8  		ll_file_nbr_42001;
		string1  		ll_agent_code_42001;
		string30 		ll_agent_name_42001;
		string30 		ll_agent_street_42001;
		string18 		ll_agent_city_42001;
		string9  		ll_agent_zip_42001;
		string3  		ll_agent_cnty_code_42001;
		string8  		ll_agent_chg_date_42001;
		string120 	ll_llc_name_42001;
		string6  		ll_purpose_code_42001;
		string2  		ll_status_code_42001;
		string8  		ll_status_date_42001;
		string8  		ll_organized_date_42001;
		string8  		ll_dissolution_date_42001;
		string1  		ll_management_type_42001;
		string9  		ll_fein_42001;
		string2  		ll_juris_organized_42001;
		string30 		ll_records_off_street_42001;
		string18 		ll_records_off_city_42001;
		string9  		ll_records_off_zip_42001;
		string2  		ll_records_off_juris_42001;
		string1  		ll_assumed_ind_42001;
		string1  		ll_old_ind_42001;
		string1  		ll_provisions_ind_42001;
		string8  		ll_cr_ar_mail_date_42001;
		string8  		ll_cr_ar_file_date_42001;
		string8  		ll_cr_ar_deliq_date_42001;
		string4  		ll_cr_ar_paid_amt_42001;
		string4  		ll_cr_ar_year_due_42001;
		string8  		ll_pv_ar_mail_date_42001;
		string8  		ll_pv_ar_file_date_42001;
		string8  		ll_pv_ar_deliq_date_42001;
		string4  		ll_pv_ar_paid_amt_42001;
		string4  		ll_pv_ar_year_due_42001;
		string1  		ll_opt_ind_42001;
	end;

	export LLCAssumedNamesLayoutIn			:= record
	  string1			ll_record_ind_42006; 						//a literal "A" for Assumed Names
		string8 		ll_file_nbr_42006;
		string8 		ll_assumed_adopt_date_42006;
		string8 		ll_assumed_can_date_42006;
		string1 		ll_assumed_can_code_42006;
		string4 		ll_assumed_renew_year_42006;
		string8 		ll_assumed_renew_date_42006;
		string1 		ll_assumed_ind_42006;
		string120 	ll_llc_name_42006;
	end;

	export LLCDeletedFromSOSLayoutIn		:= record
		string8 		filenbr;
	end;

	export LLCInitialRecordLayoutIn			:= record
		string8 		filecreationdate;
	end;

	export LLCOldNamesLayoutIn					:= record
	  string1			ll_record_ind_42007; 						//a literal "O" for Old Names	
		string8 		ll_file_nbr_42007;
		string8 		ll_old_date_filed_42007;
		string120 	ll_llc_name_42007;
	end;
	
	export LLCManagerMemberLayoutIn 		:= record
	  string1			ll_record_ind_42008; 						//a literal "P" for Manager/Member
		string8 		ll_file_nbr_42008;
		string60 		ll_mm_name_42008;
		string30 		ll_mm_street_42008;
		string18 		ll_mm_city_42008;
		string2  		ll_mm_juris_42008;
		string9  		ll_mm_zip_42008;
		string8  		ll_mm_file_date_42008;
		string1  		ll_mm_type_code_42008;
	end;

	//Layouts for LP
	export LPLayoutIn 									:= record
	  string1			lp_record_ind_52001; 						//a literal "M" for master
		string7   	lp_file_number_52001; 					//now 7 was string8
		string8   	lp_date_duration_52001;
		string8   	lp_date_sos_filed_52001;
		string8   	lp_date_effective_52001;
		string8   	lp_date_br_mailed_52001;
		string8   	lp_date_br_deliq_52001;
		string8   	lp_date_br_filed_52001;
		string6   	lp_renewal_year_month_52001;
		string2   	lp_status_52001;
		string8   	lp_status_date_52001;
		string6   	lp_intent_code_52001;
		string11  	lp_contributions_52001;
		string8   	lp_date_org_filed_52001;
		string3   	lp_filing_org_cnty_filed_52001;
		string11  	lp_filing_org_doc_nbr_52001;
		string1   	lp_assumed_ind_52001;
		string1   	lp_old_ind_52001;
		string1   	lp_admitting_ind_52001;
		string189 	lp_partnership_name_52001;
		string2   	lp_business_state_52001;
		string30  	lp_records_office_street_52001;
		string18  	lp_records_office_city_52001;
		string2   	lp_records_office_state_52001;
		string9   	lp_records_office_zip_52001;
		string3   	lp_records_office_cnty_52001;
		string1   	lp_agent_code_52001;
		string60  	lp_agent_name_52001;
		string60  	lp_agent_firm_name_52001;
		string30  	lp_agent_street_52001;
		string18  	lp_agent_city_52001;
		string9   	lp_agent_zip_52001;
		string3   	lp_agent_cnty_code_52001;
		string8   	lp_date_agent_chge_52001;
	end;

	export LPAdmittingNamesLayoutIn			:= record
	 string1			lp_record_ind_52017; 						//a literal "N" for admitting names	
	 string7 			lp_file_number_52017;
	 string189 		lp_admitting_name_52017;
	 string8 			lp_date_filed_52017;
	 string351		filler;
	end;

	export LPAssumedNamesLayoutIn				:= record
	  string1			lp_record_ind_52005; 						//a literal "A" for assumed names	
		string7 		lp_file_number_52005;
		string189 	lp_assumed_name_52005;
		string8 		lp_assumed_date_adopted_52005;
		string8 		lp_assumed_date_cancel_52005;
		string8 		lp_assumed_date_renew_52005;
		string1 		lp_assumed_cancel_code_52005;
		string334		filler;
	end;

	export LPGeneralPartnerLayoutIn			:= record
	 string1			lp_record_ind_52004; 						//a literal "P" for general partner manager/members	
	 string7  		lp_file_number_52004;
	 string60 		lp_gp_name_52004;
	 string30 		lp_gp_street_52004;
	 string18 		lp_gp_city_52004;
	 string2  		lp_gp_state_52004;
	 string9  		lp_mm_zip_52004;
	 string8  		lp_gp_file_date_52004;
	 string421		filler;
	end;

	export LPInitialRecordLayoutIn			:= record
		string8 		filecreationdate;
	end;

	export LPOldNamesLayoutIn						:= record 
	  string1			lp_record_ind_52006; 							//a literal "N" for old names
		string7 		lp_file_number_52006;
		string189 	lp_old_name_52006;
		string8  		lp_date_filed_52006;
	end;

	export LPDeletedFromSOSLayoutIn			:= record
		string8 		filenumber;
	end;

	//Temporary layouts
	export TempMasterRawLayout 					:= record
		unsigned 		seqno;
		unsigned 		groupno;
		unsigned 		recno;
		integer  		ctr;
		string80 		payload;
		string80 		payload1;
		string80 		payload2;
		string80 		payload3;
		string80 		payload4;
		string80 		payload5;
		string80 		payload6;
		string80 		payload7;
		string80 		payload8;
		string80 		payload9;
		string80 		payload10;
		string80 		payload11;
		string1000 	payload12;
	end;
	
	export AssumedNames_TempLay          := record
	  AssumedOldNamesLayoutIn;
		MasterLayoutIn.cd41100_state_code;
		MasterLayoutIn.cd41100_type_corp;
		MasterLayoutIn.cd41100_incorp_date;
	end;
		
	export LLCAssumedNames_TempLay        := record
		LLCAssumedNamesLayoutIn;
		LLCMasterLayoutIn.ll_juris_organized_42001;
		LLCMasterLayoutIn.ll_organized_date_42001;
	end;
	
	export LLCOldNames_TempLay						:= record
		LLCOldNamesLayoutIn;
		LLCMasterLayoutIn.ll_juris_organized_42001;
		LLCMasterLayoutIn.ll_organized_date_42001;
	end;	
	
	export LPAssumedNames_TempLay          := record
		LPAssumedNamesLayoutIn;
		LPLayoutIn.lp_business_state_52001;
		LPLayoutIn.lp_date_sos_filed_52001;
	end;
	
	export LPAdmittingNames_TempLay         := record
		LPAdmittingNamesLayoutIn;
		LPLayoutIn.lp_business_state_52001;
		LPLayoutIn.lp_date_sos_filed_52001;
	end;
	
	export LPOldNames_TempLay       				 := record
		LPOldNamesLayoutIn;
	  LPLayoutIn.lp_business_state_52001;
		LPLayoutIn.lp_date_sos_filed_52001;
	end;
		
end;
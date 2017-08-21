EXPORT Layouts := module

	export FilingLayoutIn  								:= Record
		string20 		filing_id;
		string50 		filing_type;
		string50 		filing_subtype;
		string50 		word_design_type;
		string50 		duration_term_type;
		string50 		status;
		string50 		sub_status;
		string50 		standing_tax;
		string50		standing_ra;
		string50		standing_other;
		string50 		purpose;
		string50 		applicant_type;
		string20 		filing_num;
		string256 	filing_name;
		string256 	old_name;
		string256 	fictitious_name;
		string1			domestic_yn;
		string20 		filing_date;
		string20 		delayed_effective_date;
		string20 		expiration_date;
		string20 		inactive_date;
		string20 		ra_resign_cert_letter_date;
		string1 		converted_yn;
		string128 	converted_from;
		string256 	converted_from_name;
		string20		converted_date;
		string1 		issue_on_record_yn;
		string128 	transfered_to;
		string20 		transfered_date;
		string128 	formation_locale;
		string128 	continued_from_locale;
		string50 		domesticated_from_locale;
		string20 		form_home_juris_date;
		string20 		common_shares;
		string20 		common_par_value;
		string20 		preferred_shares;
		string20 		preferred_par_value;
		string1 		additional_stock_yn;
		string128 	principle_addr1;
		string128 	principle_addr2;
		string128 	principle_addr3;
		string80 		principle_city;
		string50 		principle_state;
		string50 		principle_postal_code;
		string128 	principle_country;
		string128 	mail_addr1;
		string128 	mail_addr2;
		string128 	mail_addr3;
		string80 		mail_city;
		string50 		mail_state;
		string50 		mail_postal_code;
		string128 	mail_country;
		string50 		state_of_org;
		string20 		org_date;
		string1 		reg_us_office_yn;
		string20 		reg_us_date;
		string30 		reg_us_serial_num;
		string30 		reg_us_status;
		string1 		reg_us_app_refused_yn;
		string20 		first_used_anywhere_date;
		string20 		first_used_wyo_date;
		string1 		ar_exempt_yn;
		string1000 	trademark_keywords;
	end;
		
	export FilingLayoutBase  							:= Record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		FilingLayoutIn;
	end;

	export FilingARLayoutIn  							:= Record
		string20 		filing_annual_report_id;
		string20 		filing_id;
		string50 		status;
		string20 		annual_report_num;
		string4 		filing_year;
		string20 		filing_date;
		string20 		license_tax_amt;
	end;

	export FilingARLayoutBase   					:= Record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		FilingARLayoutIn;
	end;	
	
	export PartyLayoutIn   								:= Record
		string20 		party_id;
		string50 		party_type;
		string20 		source_id;
		string50 		source_type;
		string256 	org_name;
		string50 		first_name;
		string30 		middle_name;
		string100 	last_name;
		string100 	individual_title;
		string256 	addr1;
		string100 	addr2;
		string100 	addr3;
		string60 		city;
		string60 		county;
		string50 		state;
		string30 		postal_code;
		string100 	country;
	end;
 
	export PartyLayoutBase   							:= Record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		PartyLayoutIn;
	end;
	
	export TempFilingWithParty						:= Record
		FilingLayoutIn;
		PartyLayoutIn;
		string norm_name;
		string norm_fname;
		string norm_mname;
		string norm_lname;
	end;
	
	export TempARWithFiling  						  := Record
		FilingARLayoutIn;
		FilingLayoutIn.filing_num;		
		FilingLayoutIn.ar_exempt_yn;
	end;	

end;
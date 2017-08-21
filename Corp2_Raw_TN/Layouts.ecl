export Layouts := module  

	export FilingLayoutIn 									:= record	
			string		control_no;
			string		filing_type;
			string		business_type;
			string		duration_term_type;
			string		status;
			string		standing_ar;
			string		standing_ra;
			string		standing_other;
			string		filing_name;
			string		domestic_yn;
			string		filing_date;
			string		delayed_effective_date;
			string		expiration_date;
			string		inactive_date;
			string		formation_locale;
			string		form_home_juris_date;
			string		common_shares;
			string		principle_addr1;
			string		principle_addr2;
			string		principle_addr3;
			string		principle_city;
			string		principle_state;
			string		principle_postal_code;
			string		principle_country;
			string		mail_addr1;
			string		mail_addr2;
			string		mail_addr3;
			string		mail_city;
			string		mail_state;
			string		mail_postal_code;
			string		mail_country;
			string		ar_exempt_yn;
			string		managed_by_type;
			string		member_count;
			string		public_benefit_yn;
			string		religious_benefit_yn;
			string		ar_due_date;
			string		fyc_month_no;
	end;

	export FilingLayoutBase 								:= record
			string		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			FilingLayoutIn;
	end;

	export FilingNameLayoutIn 							:= record
			string		filing_name_id;
			string		control_no;
			string		name_type;
			string		name;
	end;

	export FilingNameLayoutBase 						:= record
			string		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			FilingNameLayoutIn;
	end;
	
	export PartyLayoutIn										:= record
			string		control_no;
	    string		party_id;		
			string		party_type;
			string		source_id;
			string		source_type;
			string		org_name;
			string		first_name;
			string		middle_name;
			string		last_name;
			string		individual_title;
			string		addr1;
			string		addr2;
			string		addr3;
			string		city;
			string		county;
			string		state;
			string		postal_code;
			string		country;
	end;

	export PartyLayoutBase 									:= record
			string		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			PartyLayoutIn;
	end;
		
	export AnnualReportLayoutIn							:= record
			string	filing_annual_report_id;
			string	control_no;
			string	ar_status;
			string	annual_report_nbr;
			string	filing_year;
			string	ar_filing_date;
			string	license_tax_amt;
	end;

	export AnnualReportLayoutBase						:= record
			string		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			AnnualReportLayoutIn;
	end;

	export Temp_Filing_Party								:= record
			FilingLayoutIn;
			PartyLayoutIn 		 - [control_no];
	end;
	  
	export Temp_FilingNames								:= record
			FilingNameLayoutIn;
			FilingLayoutIn.Filing_Name;
			FilingLayoutIn.domestic_yn;
			FilingLayoutIn.filing_date;
	end;
	
	export Temp_Filing_AnnualReport 				:= record
	    integer position := 0;
			FilingLayoutIn;
			AnnualReportLayoutIn -[control_no];
	end;

end;	
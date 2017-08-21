EXPORT Layouts := module

	export crpAddLayoutIn := RECORD
    	string 	corp_file_no 	:= '';
			string 	address_type	:= '';
			string 	name					:= '';
			string 	address_1			:= '';
			string 	address_2			:= '';
			string 	city					:= '';
			string	state					:= '';
			string 	zip						:= '';
			string 	country				:= '';
			string 	lf						:= '';
  end;
	
	export crpAddLayoutBase := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		crpAddLayoutIn;
  end;

	export crpAgtLayoutIn := RECORD
			string 	corp_file_no		:= '';
			string 	AgtName					:= '';
			string 	AgtAddress_1		:= '';
			string 	AgtAddress_2		:= '';
			string 	AgtCity					:= '';
			string	AgtState				:= '';
			string 	AgtZip					:= '';
			string 	AgtNo						:= '';
			string 	AgtSeq					:= '';
			string 	AgtId						:= '';
			string 	lf							:= '';
  end;
	
	export crpAgtLayoutBase := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		crpAgtLayoutIn;
  end;
	
	export crpDesLayoutIn := RECORD
			string	corp_file_no		:= '';
			string 	ap_type					:= '';
			string 	desc						:= '';
			string 	lf							:= '';
  end;
	
	export crpDesLayoutBase := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		crpDesLayoutIn;
  end;
		
	export crpFilLayoutIn := RECORD
			string 	corp_file_no			:= '';
			string 	chapter_no				:= '';
			string 	delin_flag				:= '';
			string 	farm_flag					:= '';
			string 	farm_delin_flag		:= '';
			string 	dead_code					:= '';
			string 	dead_date					:= '';
			string 	state_of_incorp		:= '';
			string	status_code				:= '';
			string 	date_incorp				:= '';
			string 	date_expired			:= '';
			string 	no_acres					:= '';
			string 	lf								:= '';
  end;
	
	export crpFilLayoutBase := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		crpFilLayoutIn;
  end;
		
	export crpHisLayoutIn := RECORD
			string 	corp_file_no			:= '';
			string 	type_filing				:= '';
			string 	date_filed				:= '';
			string 	time_filed				:= '';
			string 	date_filing_eff		:= '';
			string 	time_fiing_eff		:= '';
			string 	his_date_expired	:= '';
			string 	total_pages				:= '';
			string 	book_no						:= '';
			string 	page_no						:= '';
			string 	cert_no						:= '';
			string 	remarks_flag			:= '';
			string 	merger_file_no		:= '';
			string 	merger_status			:= '';
			string 	merger_name				:= '';
			string 	merger_state			:= '';
			string 	lf								:= '';
  end;
	
	export crpHisLayoutBase := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		crpHisLayoutIn;
  end;
		
	export crpNamLayoutIn := RECORD
			string 	corp_file_no			:= '';
			string 	name_type					:= '';
			string 	curr_name					:= '';
			string 	name_mod_flag			:= '';
			string 	name_frm					:= '';
			string	name_status_code	:= '';
			string 	name_cert_no			:= '';
			string 	sequence_no				:= '';
			string 	old_sequence_no		:= '';
			string 	lf								:= '';
  end;
	
	export crpNamLayoutBase := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		crpNamLayoutIn;
  end;
	
	export crpOffLayoutIn := RECORD
			string 	corp_file_no		:= '';
			string 	name						:= '';
			string 	address_1				:= '';
			string 	address_2				:= '';
			string 	city						:= '';
			string 	state						:= '';
			string 	zip							:= '';
			string 	country					:= '';
			string 	officer_type		:= '';
			string 	dir_flag				:= '';
			string 	shholder_flag		:= '';
			string 	lf							:= '';
  end;
	
	export crpOffLayoutBase := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		crpOffLayoutIn;
  end;
	
	export crpPrtLayoutIn := RECORD
			string 	corp_file_no		:= '';
			string 	partners				:= '';
			string 	lf;
  end;
	
	export crpPrtLayoutBase := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		crpPrtLayoutIn;
  end;
		
	export crpRemLayoutIn := RECORD
			string 	corp_file_no		:= '';
			string 	remarks					:= '';
			string	RemCertNo				:= '';
  end;
	
	export crpRemLayoutBase := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		crpRemLayoutIn;
  end;
		
	export crpStkLayoutIn := RECORD
			string 	corp_file_no		:= '';
			string 	stock_type			:= '';
			string 	stock_class			:= '';
			string 	stock_series		:= '';
			string 	number_shares		:= '';
			string 	lf;
  end;
	
	export crpStkLayoutBase := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		crpStkLayoutIn;
  end;
			
			
	//Temporary Layouts
	  
	EXPORT joinMaster := record
      crpFilLayoutIn;
			crpAgtLayoutIn 	 -corp_file_no  -lf;
			crpAddLayoutIn 	 -corp_file_no  -lf;
			crpDesLayoutIn	 -corp_file_no  -lf;
			crpNamLayoutIn   -corp_file_no  -lf;
			crpPrtLayoutIn	 -corp_file_no  -lf;
			crpHisLayoutIn	 -corp_file_no  -lf;
		end;
		
	  EXPORT crpOffLookupsNam := record
			crpOffLayoutIn;
			crpNamLayoutIn	 -corp_file_no  -lf;
		end;		
	
		EXPORT AllEventFiles := record
			string 	corp_file_no	:= '';
			string 	chapter_no		:= '';
			crpHisLayoutIn	 -corp_file_no  -lf;
			string 	remarks			  := '';
			string	RemCertNo		  := '';
		end;	
	
end;
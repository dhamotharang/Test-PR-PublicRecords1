EXPORT Layouts := module

	export CPABREPLayoutIn 			:= record //record length 317
		string2  		filetype;
		string1 	 	filler0;
		string7  		corp_number;
		string1  		filler1;
		string70 		corp_name;
		string30 		attn_line;
		string30	 	address_1;
		string30 		address_2;
		string20 		city;
		string9 	 	zip;
		string1  		close_corp;
		string2  		tax_closing;
		string8  		date_of_incorp;
		string6  		last_correct_a_r;
		string8  		a_r_due;
		string8  		extension_date;
		string8 	 	forfeiture_date;
		string8  		expiration_date;
		string9  		stock_issued;
		string1  		filler2;
		string9  		fein;
		string1  		cleanup_stat;
		string10 		cleanup_id;
		string8  		prior_busn_date;
		string1  		more_5_o_d;
		string7  		last_update;
		string2  		state;  					//is a business address
		string3  		state_country;		//is the state and country of formation
		string3  		country;					//is the current location of the company
		string1  		a_r_status;
		string1  		filler3;
		string2  		corporation_type;
		string2  		corp_stat;
		string7  		ranum;
		string1  		lf;
	end;

	export CPABREPLayoutBase 		:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CPABREPLayoutIn;
	end;
		
	export CPADREPLayoutIn 			:= record //record length 186
		string2 		update_code;
		string1  		filler0;
		string7  		ranum;
		string1  		filler;
		string70 		raname;
		string30 		raaddr1;
		string30 		raaddr2;
		string4  		razip4;
		string1  		rastatus;
		string10 		rauid;
		string2  		rastate;
		string2  		racounty;
		string20 		racity;
		string5  		razip5;
		string1  		lf;
	end;

	export CPADREPLayoutBase 		:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;
		CPADREPLayoutIn;		
	end;
	
	export CPAEREPLayoutIn 			:= record	//record length 75
		string2  update_code;
		string1  filler0;
		string7  cnnumber;
		string5  cn_seq_number;
		string1  filler;
		string40 cn_name;
		string7  cn_ccn;
		string1  cn_cur_pre;
		string1  cn_master_type;
		string8  cn_file_date;
		string1  cn_verify;
		string1  lf;
	end;

	export CPAEREPLayoutBase 		:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;
		CPAEREPLayoutIn;		
	end;
		
	export CPAHSTLayoutIn 			:= record //record length 83
		string2  		update_code;
		string1  		filler0;
		string7 	 	corp_number;
		string2  		seq_number;
		string1  		filler;
		string3  		fund;
		string8  		validation_date;
		string4  		validation_number;
		string3  		validation_sub;
		string7  		amount_paid;
		string8  		transaction_date;
		string8  		filing_ar_date;
		string10 		user_id;
		string4 		microfilm_roll;
		string5  		microfilm_frame;
		string1  		agriculture_code;
		string1  		bad_check_code;
		string3  		number_of_pages;
		string1  		delete_or_error;
		string3  		history_code;
		string1  		lf;
	end;
		
	export CPAHSTLayoutBase 		:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;
		CPAHSTLayoutIn;		
	end;		
		
	export CPAQREPLayoutIn 			:= record	//record length 41
		string7  		corp_num;
		string2  		corp_seqnum;
		string1  		filler;
		string30 		corp_name_cont;
		string1  		lf;
	end;
	
	export CPAQREPLayoutBase 		:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CPAQREPLayoutIn;
	end;
	
	export CPBCREPLayoutIn 			:= record	//record length 148
		string2  		update_code;
		string1  		filler0;
		string7  		pnnumber;
		string5  		pnseqnum;
		string1  		filler;
		string70 		pncorpname;
		string30 		pname1;
		string30 		pname2;
		string1  		pncurprev;
		string1  		lf;
	end;
	
	export CPBCREPLayoutBase 		:= record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;
		CPBCREPLayoutIn;
	end;

	export CPAKREPLayoutIn 			:= record //Status code translation table layout record length 78
		string2  		corp_stat_code;
		string60 		long_desc;
		string15 		short_desc;
		string1  		lf;
	end;
	
	export CPANREPLayoutIn 			:= record //State & country code translation table layout record length 34
		string3  		code;
		string30 		name;
		string1  		lf;
	end;
	
	export CPASREPLayoutIn 			:= record //County code translation table layout record length 58
		string2  		county_code;
		string20 		city_name;
		string5  		zip;
		string30 		county_name;
		string1  		lf;
	end;

	export CRPTYPLayoutIn 			:= record //Corp type code translation table layout record length 33
		string2  		corporation_type;
		string30 		corp_typ_desc;
		string1  		lf;
	end;

	export CPALREPLayoutIn 			:= record //Annual report status code translation table layout record length 68
		string2  		a_r_status;
		string50 		long_arsc_desc;
		string15 		short_arsc_desc;
		string1  		lf;
	end;

	export Temp_CPABREP_CPADREP := record
	  CPABREPlayoutin and not [lf];
	  CPADREPlayoutin and not [lf];
		CPASREPLayoutIn and not [lf];
	  CPBCREPlayoutin.pncorpname;
		CPBCREPlayoutin.pname1;
		CPBCREPlayoutin.pname2;
	  CPAQREPlayoutin.corp_name_cont;
	  CPAHSTLayoutin.agriculture_code;
		CPAEREPLayoutIn.cn_cur_pre;
		CPAEREPLayoutIn.cn_file_date;	
	  string30 corp_name_cont_2;
	  string30 corp_name_cont_3;
	  string60 corp_status_desc;
	  string60 corp_orig_org_structure_desc;
	  string3  corp_country_code;
	  string60 corp_country_desc;
	  string50 ar_status;
	end;

	export Temp_CPAQREP 				:= record
	  CPAQREPLayoutIn and not [lf];
		string30 corp_name_cont_2;
		string30 corp_name_cont_3; 
	end;

	export Temp_CPABREP_CPAHST := record
		CPABREPLayoutIn;
		CPAHSTLayoutIn;
	  string50 ar_status;		
	end;
	
	export Temp_CPADREP_CPASREP := record
		CPADREPLayoutIn;
		CPASREPLayoutIn;
	end;

end;
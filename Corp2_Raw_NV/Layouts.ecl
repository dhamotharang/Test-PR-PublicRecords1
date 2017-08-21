export Layouts := module

	export CorporationsLayoutIn 			:= record
			string  	corp_id;  //raw data is integer
      string  	ra_id;  	//raw data is integer
      string  	corp_type;
      string  	corp_category;
      string  	corp_status;
      string  	managed_by;
      string 		corp_name;
      string   	qualifying_state;
      string  	corp_no;
      string  	capital_amt;
      string  	no_par_share_count;
      string 		corp_foreign_name;
      string   	is_on_admin_hold;
      string   	classification;
      string 		reservation_owner_name;
      string  	reservation_owner_addr1;
      string  	reservation_owner_addr2;
      string  	reservation_owner_city;
      string   	reservation_owner_st;
      string  	reservation_owner_zip;
      string   	reservation_owner_country;
      string  	creation_dt;
      string  	status_changed_dt;
      string  	annual_lo_due_dt;
      string  	ra_resigned_dt;
      string  	expired_dt;
	end;

	export CorporationsLayoutBase 		:= record
			string		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			CorporationsLayoutIn;
	end;

	export RALayoutIn 								:= record
			string  	ra_id;  //raw data is integer
      string 		name;
      string  	addr1;
      string  	addr2;
      string  	city;
      string   	st;
      string  	zip;
      string  	mailing_addr1;
      string  	mailing_addr2;
      string  	mailing_city;
      string  	mailing_st;
      string  	mailing_zip;
      string   	mailing_county;
      string   	mailing_country;
      string  	phone_no;
      string  	fax_no;
      string 		email_address;
	end;

	export RALayoutBase 							:= record
			string		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			RALayoutIn;
	end;

  export OfficersLayoutIn 					:= record
			string  	officer_id; //raw data is integer
      string  	corp_id; 		//raw data is integer
      string  	officer_type;
      string  	last_name;
      string  	first_name; 
      string   	middle_initial;
      string  	addr1;
      string  	addr2;
      string  	city;
      string   	st;
      string  	zip;
      string   	county;
      string   	country;
      string   	inactive;
      string 		email_address;
      string   	terminated;
      string   	resigned;
		end;
		
	export OfficersLayoutBase 				:= record
			string		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			OfficersLayoutIn;
		end;
		
	export ActionsLayoutIn 						:= record
			string   	action_id;  //raw data is integer
      string   	corp_id;		 //raw data is integer
      string   	action_dt;
      string   	action_type;
      string 		action_notes;
      string   	document_no;
      string   	effective_dt;
      string    has_stock; 
    end;	   

	export ActionsLayoutBase 					:= record
			string		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;			
			ActionsLayoutIn;
    end;
		
	export StockLayoutIn 							:= record
			string  	stock_id;		//raw data is integer
      string  	corp_id;		//raw data is integer
      string  	par_share_count; //raw data is big integer
      string  	par_share_value; //raw data is numeric
    end;

	export StockLayoutBase 						:= record
			string		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			StockLayoutIn;
    end;

	//********************************************************************
	//CorpRALayout: Temporary layout used to hold the joined 
	//							records from Corporations, and RA.
	//******************************************************************** 
	export TempCorpRALayout						:= record 
			string corp_key;
			CorporationsLayoutIn;
			RALayoutIn -[ra_id];
			string rawRA_country;
		end;
		
	//********************************************************************
	//CorpOfficersLayout: Temporary layout used to hold the joined 
	//										records from Corporations, and Officers.
	//******************************************************************** 
	export TempCorpOfficersLayout			:= record 
			string corp_key;
			CorporationsLayoutIn;
			OfficersLayoutIn -[corp_id];
		end;
		
	//********************************************************************
	//ActionsLayout: Temporary layout used to represent the joined files
	//							 from Corporations and Actions.
	//******************************************************************** 
	export TempCorpActionsLayout			:= record 
			string corp_key;
			CorporationsLayoutIn;
			ActionsLayoutIn -[corp_id];
		end;

	//********************************************************************
	//CorpStockLayout: Temporary layout used to represent the joined files
	//							   from Corporations and Stock.
	//******************************************************************** 	
	export TempCorpStockLayout				:= record 
			string corp_key;
			CorporationsLayoutIn;
			StockLayoutIn -[corp_id];
		end;

end;
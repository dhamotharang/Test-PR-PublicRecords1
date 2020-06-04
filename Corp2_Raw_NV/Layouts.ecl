import corp2_raw_nv;

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
			string    NV_business_ID; // New field
			string    exemption_code; // New field
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
			string		CRA_Authority_name;		// New field
			string		CRA_Authority_addr1; 	// New field			
			string		CRA_Authority_addr2;	// New field
			string		CRA_Authority_city; 	// New field
			string		CRA_Authority_st; 	  // New field
			string		CRA_Authority_zip; 		// New field
			string		CRA_Authority_phone; 	// New field
			string		agent_type; 					// New field
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
		
	export ActionsLayoutIn 						:= record
			string   	action_id;  //raw data is integer
      string   	corp_id;		 //raw data is integer
      string   	action_dt;
      string   	action_type;
      string 		action_notes;
      string   	document_no;
      string   	effective_dt;
      string    has_stock; 
			string		number_of_pages; // New field
    end;	   

	export StockLayoutIn 							:= record
			string  	stock_id;		//raw data is integer
      string  	corp_id;		//raw data is integer
      string  	par_share_count; //raw data is big integer
      string  	par_share_value; //raw data is numeric
    end;

	export TMLayoutIn 							:= record  // New File
			string  	TM_ID;
			string  	Trademark_Type;
			string  	Trademark_Category ;
			string  	Trademark_Status; 
			string  	Trademark_Name;
			string  	Qualifying_State;
			string  	Trademark_Number;
			string  	IsOnAdminHold;
			string  	Classification_Code;
			string  	Reservation_Owner_Name;
			string  	Reservation_Owner_Address_1;
			string  	Reservation_Owner_Address_2;
			string  	Reservation_Owner_City;
			string  	Reservation_Owner_State;
			string  	Reservation_Owner_Zip;
			string  	Reservation_Owner_Country;
			string  	Creation_Date;
			string  	Status_Changed_Date;
			string  	Expired_Date;
		end;

	export TMActionsLayoutIn 			:= record  // New File
			string  	ActionID;
			string  	EntityID;
			string  	Action_Date;
			string  	Action_Type;
			string  	Action_Notes;
			string  	Document_Number;
			string  	Effective_Date;
			string  	Has_Stock;
			string  	Number_of_Pages;
		end;

	//********************************************************************
	//TempNormRALayout: Temporary layout used for normalizing RA file 
	//******************************************************************** 
	export TempNormRALayout						:= record 
			RALayoutIn;
			string 		norm_name;
      string  	norm_addr1;
      string  	norm_addr2;
      string  	norm_city;
      string   	norm_st;
      string  	norm_zip;
			string    norm_country;
			string    norm_phone;
			string    norm_type;  // RA or CRA
		end;
		
	//********************************************************************
	//TempCorpRALayout: Temporary layout used for joining of 
	//							    Corporations and RA
	//******************************************************************** 
	export TempCorpRALayout						:= record 
			CorporationsLayoutIn;
			TempNormRALayout -[ra_id];
	end;
		
	//********************************************************************
	//TempOfficersCorpLayout: Temporary layout used for joining of 
	//										    Officers and Corporations
	//******************************************************************** 
	export TempOfficersCorpLayout			:= record 
			OfficersLayoutIn;
			CorporationsLayoutIn.corp_name;
			CorporationsLayoutIn.corp_no;
		end;
		
	//********************************************************************
	//TempStockCorpLayout: Temporary layout used for joining of 
	//							         Stock and Corporations  
	//******************************************************************** 
	export TempStockCorpLayout			:= record 
			CorporationsLayoutIn.corp_id;
			CorporationsLayoutIn.corp_no;
      CorporationsLayoutIn.capital_amt;
      CorporationsLayoutIn.no_par_share_count;
			StockLayoutIn.par_share_count;  
      StockLayoutIn.par_share_value;  
		end;

	//********************************************************************
	//TempActionsLayout: Temporary layout used for joining of 
	//							         Actions and Corporations  
	//******************************************************************** 
	export TempActionsLayout			:= record 
			CorporationsLayoutIn.corp_id;
			CorporationsLayoutIn.corp_no;
      CorporationsLayoutIn.annual_lo_due_dt; 
			ActionsLayoutIn -[corp_id];
		end;
	
	//********************************************************************
	//TempTMActionsLayout: Temporary layout used for joining of 
	//							         Trademark Actions and Trademark  
	//******************************************************************** 
	export TempTMActionsLayout			:= record 
			TMLayoutIn.TM_id;
			TMLayoutIn.trademark_number;
      TMActionsLayoutIn;
	end;
		
end;


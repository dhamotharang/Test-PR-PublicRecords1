EXPORT Layouts := module
	
	//There are only 3-main vendor common layout types!! Business, Principal &  TradeOwners !! 
		
	/* 		Business Layout will be used for following Business files
				DomLLCBus-Domestic Limited Liability Company, DomMBEBus-Domestic Mutual Benefit Enterprise, 
				DomNPCBus-Domestic Non-Profit Corporation,DomProfBus-Domestic Profit Corporation, PshipsBus-Partnerships Business(Domestic and Foreign),
				ForLLCBus-Foreign Limited Liability Company, ForNPCBus-Foreign Non-Profit Corporation, 
				ForProfBus-Foreign Profit Corporation & TrdNamesBus-TradeNames 
	*/
	export BusLayoutIn 								:= Record 
	
		string business_id;
		string file_no;
		string business_type;
		string business_name;
		string naics_code;
		string naics_subcode;
		string principal_office_address_1;
		string principal_office_address_2;
		string principal_office_city;
		string principal_office_state;
		string principal_office_zip;
		string mailing_address_1;
		string mailing_address_2;
		string mailing_city;
		string mailing_state;
		string mailing_zip;
		string foreign_address_1;
		string foreign_address_2;
		string foreign_city;
		string foreign_state;
		string foreign_zip;
		string foreign_business_name;
		string place_of_formation;
		string registered_agent;
		string agent_address_1;
		string agent_address_2;
		string agent_city;
		string agent_state;
		string agent_zip;
		string business_origin_date;
		string business_status;
		string last_annual_report_date;
		string termination_date;
		string fiscal_year_month;
		string manager_managed;
		string corporation_type;
		string business_description;
		string term_date;
		string members_liable;
		string member_organization;
		string corporation_subtype;
		string cessation_date;
		string dissolved_date;
		string withdrawal_date;
		string merged_date;
		string cancellation_date;

	end;

	export BusLayoutBase  					:= Record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		BusLayoutIn;

	end;
	
	/* 	Principal Layout will be be used for following Principal files
   		DomLLCPrn-Domestic Limited Liability Company, DomMBEPrn-Domestic Mutual Benefit Enterprise, 
			DomNPCPrn-Domestic Non-Profit Corporation,DomProfPrn-Domestic Profit Corporation, PshipsPrn-Partnerships Prniness(Domestic and Foreign),
			ForLLCPrn-Foreign Limited Liability Company, ForNPCPrn-Foreign Non-Profit Corporation, 
			ForProfPrn-Foreign Profit Corporation & TrdNamesPrn-TradeNames  
  */
	export PrnLayoutIn		 							:= Record 

		string business_id;
		string principal_name;
		string principal_title;
		string business_address_1;
		string business_address_2;
		string business_city;
		string business_state;
		string business_zip;

	end;
	
	export PrnLayoutBase  					:= Record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		PrnLayoutIn;

	end;
	
	//TradeOwners
	export TrdNamesOwnLayoutIn 						:= Record 

		string tradename_id;
		string tradename;
		string tradename_business_owner_id;
		string tradename_business_owner;

	end;
	
	export TrdNamesOwnLayoutBase					:= Record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		TrdNamesOwnLayoutIn;

	end;
	
	//Temporary Layout
	export Temp_Prn_ContType					:= Record
	
		string1 cont_type;
		PrnLayoutIn;

	end;
	
end;

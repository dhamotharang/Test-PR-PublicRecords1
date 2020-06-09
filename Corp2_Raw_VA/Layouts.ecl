EXPORT Layouts := MODULE

	
  EXPORT CorpsLayoutIn 									 := RECORD				
		STRING   corps_entity_id;
		STRING   corps_name;
		STRING   corps_status;
		STRING   corps_status_date;
		STRING   corps_duration; 
		STRING   corps_incorp_date;
		STRING   corps_incorp_state;
		STRING   corps_industry_code;
		STRING   corps_street1;
		STRING   corps_street2;
		STRING   corps_city;
		STRING   corps_state;
		STRING   corps_zip;
		STRING   corps_po_eff_date;
		STRING   corps_ra_name;
		STRING   corps_ra_street1; 
		STRING   corps_ra_street2;
		STRING   corps_ra_city;
		STRING   corps_ra_state;
		STRING   corps_ra_zip;
		STRING   corps_ra_eff_date;
		STRING   corps_ra_status;
		STRING   corps_ra_loc;
		STRING   corps_stock_ind;
		STRING   corps_total_shares;
		STRING   corps_merger_ind;
		STRING   corps_assess_ind;
		STRING   corps_stock1;
	END;

	EXPORT CorpsLayoutBase								 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		CorpsLayoutIn;
	END;
	
	EXPORT LPLayoutIn 										 := RECORD 			
		STRING   lp_entity_id;
		STRING   lp_name;
		STRING   lp_status;
		STRING   lp_status_date;
		STRING   lp_duration; 
		STRING   lp_incorp_date;
		STRING   lp_incorp_state;
		STRING   lp_industry_code;
		STRING   lp_street1;
		STRING   lp_street2;
		STRING   lp_city;
		STRING   lp_state;
		STRING   lp_zip;
		STRING   lp_po_eff_date;
		STRING   lp_ra_name;
		STRING   lp_ra_street1; 
		STRING   lp_ra_street2;
		STRING   lp_ra_city;
		STRING   lp_ra_state;
		STRING   lp_ra_zip;
		STRING   lp_ra_eff_date;
		STRING   lp_ra_status;
		STRING   lp_ra_loc;
		STRING   lp_stock_ind;
		STRING   lp_total_shares;
		STRING   lp_merger_ind;
		STRING   lp_assess_ind;
		STRING   lp_stock1;
	END;
	
	EXPORT LPLayoutBase										 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		LPLayoutIn;
	END;
	
	EXPORT AmendmentLayoutIn 							 := RECORD				
		STRING   amend_entity_id;
		STRING   amend_date;
		STRING   amend_type1;
		STRING   amend_type2;
		STRING   amend_type3;
		STRING   amend_type4;
		STRING   amend_type5;
		STRING   amend_type6;
		STRING   amend_type7;
		STRING   amend_type8;
		STRING   amend_stock1;
	END;
	
	EXPORT AmendmentLayoutBase					   := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		AmendmentLayoutIn;
	END;
	
	EXPORT OfficersLayoutIn 							 := RECORD 			
		STRING   offc_entity_id;
		STRING   offc_last_name;
		STRING   offc_first_name;
		STRING   offc_middle_name;
		STRING   offc_title; 		
	END;
	
	EXPORT OfficersLayoutBase							 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		OfficersLayoutIn;
	END;
	
	EXPORT NamesHistLayoutIn 							 := RECORD				
		STRING   nmhist_entity_id;
		STRING   nmhist_name_status;
		STRING   nmhist_name_eff_date; 	
		STRING   nmhist_entity_name;
	END;

	EXPORT NamesHistLayoutBase						 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		NamesHistLayoutIn;
	END;

	EXPORT MergersLayoutIn 								 := RECORD				 
		STRING   merg_entity_id;
		STRING   merg_type;
		STRING   merg_eff_date;
		STRING   merg_surv_id;
		STRING   merg_foreign_name; 			
	END;

	EXPORT MergersLayoutBase							 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		MergersLayoutIn;
	END;
	
	EXPORT ReservedLayoutIn 						   := RECORD				
		STRING   res_number;
		STRING   res_type;
		STRING   res_status;
		STRING   res_name;
		STRING   res_exp_date; 
		STRING   res_requestor;
		STRING   res_street1;
		STRING   res_street2;
		STRING   res_city;
		STRING   res_state;
		STRING   res_zip;			
	END;

	EXPORT ReservedLayoutBase							 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		ReservedLayoutIn;
	END;
	
	EXPORT LLCLayoutIn 										 := RECORD				
		STRING   llc_entity_id;
		STRING   llc_name;
		STRING   llc_status;
		STRING   llc_status_date;
		STRING   llc_duration; 
		STRING   llc_incorp_date;
		STRING   llc_incorp_state;
		STRING   llc_industry_code;
		STRING   llc_street1;
		STRING   llc_street2;
		STRING   llc_city;
		STRING   llc_state;
		STRING   llc_zip;
		STRING   llc_po_eff_date;
		STRING   llc_ra_name;
		STRING   llc_ra_street1; 
		STRING   llc_ra_street2;
		STRING   llc_ra_city;
		STRING   llc_ra_state;
		STRING   llc_ra_zip;
		STRING   llc_ra_eff_date;
		STRING   llc_ra_status;
		STRING   llc_ra_loc;
		STRING   llc_stock_ind;
		STRING   llc_total_shares;
		STRING   llc_merger_ind;
		STRING   llc_assess_ind;
		STRING   llc_stock1;
	END;

	EXPORT LLCLayoutBase									 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		LLCLayoutIn;
	END;
	
  //**********************************	
	//Below are TEMPORARY Record layouts
  //**********************************	

	//Corps Lookup Layouts
	EXPORT TempNameMergerLayoutIn	 				 := RECORD
		NamesHistLayoutIn;
		MergersLayoutIn;
	END;

  EXPORT TempCorpsLayoutIn	 		         := RECORD
		CorpsLayoutIn;
		//Merger fields
		STRING1   merg_type;
		STRING10  merg_eff_date;
		STRING8   merg_surv_id;
		STRING100 merg_foreign_name;		
		
	END;

  EXPORT TempLPLayoutIn	 		             := RECORD
		LPLayoutIn;
		//Merger fields
		STRING1   merg_type;
		STRING10  merg_eff_date;
		STRING8   merg_surv_id;
		STRING100 merg_foreign_name;	
		
	END;
	
	EXPORT TempLLCLayoutIn	 		           := RECORD
		LLCLayoutIn;
		//Merger fields
		STRING1   merg_type;
		STRING10  merg_eff_date;
		STRING8   merg_surv_id;
		STRING100 merg_foreign_name;		
		
	END;

	EXPORT TempOfficersCorpsLayoutIn 			 := RECORD
		OfficersLayoutIn;  
		STRING350 corp_legal_name;
	END;

	//Normalized Layout		
  EXPORT TempNormAmendLayoutIn 				   := RECORD
		STRING8   amend_entity_id;
		STRING10  amend_date;
		STRING60  amend_type;		
		STRING50  amend_stock_class; 
		STRING50  amend_stock_abbrv; 
    STRING15 	amend_stock_shares;
		STRING30  corp_key; 
	END;
	
	EXPORT NamesHist_TempLay					     := RECORD
		NamesHistLayoutIn;
		TempCorpsLayoutIn.corps_entity_id;
		TempCorpsLayoutIn.corps_incorp_date;
		TempCorpsLayoutIn.corps_incorp_state;
	END;
	
	EXPORT Reserved_TempLay									:= RECORD
		ReservedLayoutIn;
		TempCorpsLayoutIn.corps_entity_id;
		TempCorpsLayoutIn.corps_incorp_date;
	END;
			
END;
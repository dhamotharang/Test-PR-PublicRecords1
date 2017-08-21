EXPORT Layouts := MODULE

	EXPORT TablesLayoutIn 								 := RECORD 			
		STRING2   table_id;
		STRING50  table_contents; 
		STRING29  table_column_id;
		STRING8   table_column_value;
		STRING50  table_description;                			        
	END;
	
	EXPORT TablesLayoutBase								 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		TablesLayoutIn;
	END;
	
  EXPORT CorpsLayoutIn 									 := RECORD				
		STRING7   corps_entity_id;
		STRING100 corps_name;
		STRING2   corps_status;
		STRING10  corps_status_date;
		STRING10  corps_duration; 
		STRING10  corps_incorp_date;
		STRING2   corps_incorp_state;
		STRING2   corps_industry_code;
		STRING45  corps_street1;
		STRING45  corps_street2;
		STRING23  corps_city;
		STRING2   corps_state;
		STRING10  corps_zip;
		STRING10  corps_po_eff_date;
		STRING100 corps_ra_name;
		STRING45  corps_ra_street1; 
		STRING45  corps_ra_street2;
		STRING23  corps_ra_city;
		STRING2   corps_ra_state;
		STRING10  corps_ra_zip;
		STRING10  corps_ra_eff_date;
		STRING1   corps_ra_status;
		STRING3   corps_ra_loc;
		STRING1   corps_stock_ind;
		STRING11  corps_total_shares;
		STRING1   corps_merger_ind;
		STRING1   corps_assess_ind;
		STRING25  corps_stock1;
		STRING25  corps_stock2;
		STRING25  corps_stock3;
		STRING25  corps_stock4;
		STRING25  corps_stock5;
		STRING25  corps_stock6;
		STRING25  corps_stock7;
		STRING25  corps_stock8;
	END;

	EXPORT CorpsLayoutBase								 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		CorpsLayoutIn;
	END;
	
	EXPORT LPLayoutIn 										 := RECORD 			
		STRING7   lp_entity_id;
		STRING100 lp_name;
		STRING2   lp_status;
		STRING10  lp_status_date;
		STRING10  lp_duration; 
		STRING10  lp_incorp_date;
		STRING2   lp_incorp_state;
		STRING2   lp_industry_code;
		STRING45  lp_street1;
		STRING45  lp_street2;
		STRING23  lp_city;
		STRING2   lp_state;
		STRING10  lp_zip;
		STRING10  lp_po_eff_date;
		STRING100 lp_ra_name;
		STRING45  lp_ra_street1; 
		STRING45  lp_ra_street2;
		STRING23  lp_ra_city;
		STRING2   lp_ra_state;
		STRING10  lp_ra_zip;
		STRING10  lp_ra_eff_date;
		STRING1   lp_ra_status;
		STRING3   lp_ra_loc;
		STRING1   lp_stock_ind;
		STRING11  lp_total_shares;
		STRING1   lp_merger_ind;
		STRING1   lp_assess_ind;
		STRING25  lp_stock1;
		STRING25  lp_stock2;
		STRING25  lp_stock3;
		STRING25  lp_stock4;
		STRING25  lp_stock5;
		STRING25  lp_stock6;
		STRING25  lp_stock7;
		STRING25  lp_stock8;
	END;
	
	EXPORT LPLayoutBase										 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		LPLayoutIn;
	END;
	
	EXPORT AmendmentLayoutIn 							 := RECORD				
		STRING7   amend_entity_id;
		STRING10  amend_date;
		STRING1   amend_type1;
		STRING1   amend_type2;
		STRING1   amend_type3;
		STRING1   amend_type4;
		STRING1   amend_type5;
		STRING1   amend_type6;
		STRING1   amend_type7;
		STRING1   amend_type8;
		STRING25  amend_stock1;
		STRING25  amend_stock2;
		STRING25  amend_stock3;
		STRING25  amend_stock4;
		STRING25  amend_stock5;
		STRING25  amend_stock6;
		STRING25  amend_stock7;
		STRING25  amend_stock8;
	END;
	
	EXPORT AmendmentLayoutBase					   := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		AmendmentLayoutIn;
	END;
	
	EXPORT OfficersLayoutIn 							 := RECORD 			
		STRING7   offc_entity_id;
		STRING30  offc_last_name;
		STRING20  offc_first_name;
		STRING20  offc_middle_name;
		STRING15  offc_title; 			
	END;
	
	EXPORT OfficersLayoutBase							 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		OfficersLayoutIn;
	END;
	
	EXPORT NamesHistLayoutIn 							 := RECORD				
		STRING7   nmhist_entity_id;
		STRING2   nmhist_name_status;
		STRING10  nmhist_name_eff_date; 	
		STRING100 nmhist_entity_name;
	END;

	EXPORT NamesHistLayoutBase						 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		NamesHistLayoutIn;
	END;

	EXPORT MergersLayoutIn 								 := RECORD				 
		STRING7   merg_entity_id;
		STRING1   merg_type;
		STRING10  merg_eff_date;
		STRING7   merg_surv_id;
		STRING100 merg_foreign_name; 			
	END;

	EXPORT MergersLayoutBase							 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		MergersLayoutIn;
	END;
	
	EXPORT ReservedLayoutIn 						   := RECORD				
		STRING7   res_number;
		STRING1   res_type;
		STRING2   res_status;
		STRING100 res_name;
		STRING10  res_exp_date; 
		STRING100 res_requestor;
		STRING45  res_street1;
		STRING45  res_street2;
		STRING23  res_city;
		STRING2   res_state;
		STRING10  res_zip;			
	END;

	EXPORT ReservedLayoutBase							 := RECORD
		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;	
		ReservedLayoutIn;
	END;
	
	EXPORT LLCLayoutIn 										 := RECORD				
		STRING7   llc_entity_id;
		STRING100 llc_name;
		STRING2   llc_status;
		STRING10  llc_status_date;
		STRING10  llc_duration; 
		STRING10  llc_incorp_date;
		STRING2   llc_incorp_state;
		STRING2   llc_industry_code;
		STRING45  llc_street1;
		STRING45  llc_street2;
		STRING23  llc_city;
		STRING2   llc_state;
		STRING10  llc_zip;
		STRING10  llc_po_eff_date;
		STRING100 llc_ra_name;
		STRING45  llc_ra_street1; 
		STRING45  llc_ra_street2;
		STRING23  llc_ra_city;
		STRING2   llc_ra_state;
		STRING10  llc_ra_zip;
		STRING10  llc_ra_eff_date;
		STRING1   llc_ra_status;
		STRING3   llc_ra_loc;
		STRING1   llc_stock_ind;
		STRING11  llc_total_shares;
		STRING1   llc_merger_ind;
		STRING1   llc_assess_ind;
		STRING25  llc_stock1;
		STRING25  llc_stock2;
		STRING25  llc_stock3;
		STRING25  llc_stock4;
		STRING25  llc_stock5;
		STRING25  llc_stock6;
		STRING25  llc_stock7;
		STRING25  llc_stock8;
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
		//Table 01 - Corp_Status
		STRING50  t1_statusdesc;
		//Table 02 - Corp_Forgn_State
		STRING50  t2_for_stdesc;
		//Table 03 - Corp_Org_Bus_Type
		STRING50  t3_busdesc;
		//Table 04 - Register Agent Status
		STRING50  t4_ra_statusdesc;
		//Table 05 - Register Agent Location
		STRING50  t5_ra_location;
		//Table 07 - Assessment
		STRING50  t7_assessmt_desc;
		//Table 12 - Stock Class Description
		STRING50  t12_stockclass1;
		STRING50  t12_stockclass2;
		STRING50  t12_stockclass3;
		STRING50  t12_stockclass4;
		STRING50  t12_stockclass5;
		STRING50  t12_stockclass6;
		STRING50  t12_stockclass7;
		STRING50  t12_stockclass8;
		STRING15  stockamt1;
		STRING15  stockamt2;
		STRING15  stockamt3;
		STRING15  stockamt4;
		STRING15  stockamt5;
		STRING15  stockamt6;
		STRING15  stockamt7;
		STRING15  stockamt8;
		//Merger fields
		STRING1   merg_type;
		STRING10  merg_eff_date;
		STRING7   merg_surv_id;
		STRING100 merg_foreign_name;		
		
	END;

  EXPORT TempLPLayoutIn	 		             := RECORD
		LPLayoutIn;
		//Table 01 - Corp_Status
		STRING50  t1_statusdesc;
		//Table 02 - Corp_Forgn_State
		STRING50  t2_for_stdesc;
		//Table 03 - Corp_Org_Bus_Type
		STRING50  t3_busdesc;
		//Table 05 - Register Agent Location
		STRING50  t5_ra_location;
		//Table 07 - Assessment
		STRING50  t7_assessmt_desc;
		//Table 12 - Stock Class Description
		STRING50  t12_stockclass1;
		STRING50  t12_stockclass2;
		STRING50  t12_stockclass3;
		STRING50  t12_stockclass4;
		STRING50  t12_stockclass5;
		STRING50  t12_stockclass6;
		STRING50  t12_stockclass7;
		STRING50  t12_stockclass8;
		STRING15  stockamt1;
		STRING15  stockamt2;
		STRING15  stockamt3;
		STRING15  stockamt4;
		STRING15  stockamt5;
		STRING15  stockamt6;
		STRING15  stockamt7;
		STRING15  stockamt8;
    //Table 28 - RA Status
		STRING50  t28_ra_statusdesc;		
		//Merger fields
		STRING1   merg_type;
		STRING10  merg_eff_date;
		STRING7   merg_surv_id;
		STRING100 merg_foreign_name;	
		
	END;
	
	EXPORT TempLLCLayoutIn	 		           := RECORD
		LLCLayoutIn;
		//Table 01 - Corp_Status
		STRING50  t1_statusdesc;
		//Table 02 - Corp_Forgn_State
		STRING50  t2_for_stdesc;
		//Table 03 - Corp_Org_Bus_Type
		STRING50  t3_busdesc;
		//Table 05 - Register Agent Location
		STRING50  t5_ra_location;
		//Table 07 - Assessment
		STRING50  t7_assessmt_desc;
		//Table 12 - Stock Class Description
		STRING50  t12_stockclass1;
		STRING50  t12_stockclass2;
		STRING50  t12_stockclass3;
		STRING50  t12_stockclass4;
		STRING50  t12_stockclass5;
		STRING50  t12_stockclass6;
		STRING50  t12_stockclass7;
		STRING50  t12_stockclass8;
		STRING15  stockamt1;
		STRING15  stockamt2;
		STRING15  stockamt3;
		STRING15  stockamt4;
		STRING15  stockamt5;
		STRING15  stockamt6;
		STRING15  stockamt7;
		STRING15  stockamt8;
	  //Table 40 - RA Status
		STRING50  t40_ra_statusdesc;
		//Merger fields
		STRING1   merg_type;
		STRING10  merg_eff_date;
		STRING7   merg_surv_id;
		STRING100 merg_foreign_name;		
		
	END;

	EXPORT TempOfficersCorpsLayoutIn 			 := RECORD
		OfficersLayoutIn;  
		STRING350 corp_legal_name;
	END;

	//Normalized Layouts		
	EXPORT TempNormCorpsLayoutIn 					 := RECORD
		STRING7   corps_entity_id;
		STRING100 corps_name;
		STRING1   corps_stock_ind;
		STRING15  corps_total_shares;
		STRING50  corps_stock_class;	
		STRING50  corps_stock_abbrv;
		STRING15 	corps_stock_shares;
		STRING50 	t12_stock_desc;
		STRING250 stock_addl_info;
		//string15 	stock_shares;
	END;
	
	EXPORT TempNormLPLayoutIn 						 := RECORD
		STRING7   lp_entity_id;
		STRING100 lp_name;
		STRING1   lp_stock_ind;
		STRING15  lp_total_shares;
		STRING50  lp_stock_class;	
		STRING50  lp_stock_abbrv;
		STRING15 	lp_stock_shares;
		STRING50 	t12_stock_desc;
		STRING250 stock_addl_info;
		//string15 	stock_shares;
	END;
	
	EXPORT TempNormLLCLayoutIn 						 := RECORD
		STRING7   llc_entity_id;
		STRING100 llc_name;
		STRING1   llc_stock_ind;
		STRING15  llc_total_shares;
		STRING50  llc_stock_class;	
		STRING50  llc_stock_abbrv;
		STRING15 	llc_stock_shares;
		STRING50 	t12_stock_desc;
		STRING250 stock_addl_info;
		//string15 	stock_shares;
	END;
		
  EXPORT TempNormAmendLayoutIn 				   := RECORD
		STRING7   amend_entity_id;
		STRING10  amend_date;
		STRING1   amend_type;		
		STRING50 	amend_type_desc;
		STRING50  amend_stock_class; 
		STRING50  amend_stock_abbrv; 
    STRING15 	amend_stock_shares;
		STRING50 	t12_stock_desc;
		STRING250 stock_addl_info;
	END;
	
	EXPORT NamesHist_TempLay					     := RECORD
		NamesHistLayoutIn;
		TempCorpsLayoutIn.corps_entity_id;
		TempCorpsLayoutIn.corps_incorp_date;
	END;
	
	EXPORT Reserved_TempLay									:= RECORD
		ReservedLayoutIn;
		TempCorpsLayoutIn.corps_entity_id;
		TempCorpsLayoutIn.corps_incorp_date;
	END;
			
END;
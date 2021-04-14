EXPORT Layouts := MODULE

	
  EXPORT CorpsLayoutIn 									 := RECORD				
		STRING   corps_entity_id;
		STRING   corps_name;
		STRING   corps_status;
		STRING   corps_StatusReason;
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

	EXPORT LPLayoutIn 										 := RECORD 			
		STRING   lp_entity_id;
		STRING   lp_name;
		STRING   lp_status;
		STRING   lp_StatusReason;
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
	
	EXPORT OfficersLayoutIn 							 := RECORD 			
		STRING   offc_entity_id;
		STRING   offc_last_name;
		STRING   offc_first_name;
		STRING   offc_middle_name;
		STRING   offc_title; 		
	END;
	
	EXPORT NamesHistLayoutIn 							 := RECORD				
		STRING   nmhist_entity_id;
		STRING   nmhist_name_status;
		STRING   nmhist_name_eff_date; 	
		STRING   nmhist_entity_name;
	END;

	EXPORT MergersLayoutIn 								 := RECORD				 
		STRING   merg_entity_id;
		STRING   merg_type;
		STRING   merg_eff_date;
		STRING   merg_surv_id;
		STRING   merg_foreign_name; 			
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

	EXPORT LLCLayoutIn 										 := RECORD				
		STRING   llc_entity_id;
		STRING   llc_name;
		STRING   llc_status;
		STRING   llc_StatusReason;
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
	
	EXPORT PSALayoutIn 			:= RECORD 			//Public Service Authority                        
		STRING   psa_Entity_ID;
		STRING   psa_Name;
		STRING   psa_Status;
		STRING   psa_StatusReason;
		STRING   psa_Status_Date;
		STRING   psa_Duration; 
		STRING   psa_Incorp_Date;
		STRING   psa_Incorp_State;
		STRING   psa_Industry_Code;
		STRING   psa_Street1;
		STRING   psa_Street2;
		STRING   psa_City;
		STRING   psa_State;
		STRING   psa_Zip;
		STRING   psa_PrinOffEff_Date;
		STRING   psa_RA_Name;
		STRING   psa_RA_Street1; 
		STRING   psa_RA_Street2;
		STRING   psa_RA_City;
		STRING   psa_RA_State;
		STRING   psa_RA_Zip;
		STRING   psa_RA_Eff_Date;
		STRING   psa_RA_Status;
		STRING   psa_RA_Loc;
		STRING   psa_Stock_Ind;
		STRING   psa_Total_Shares;
		STRING   psa_Merger_Ind;
		STRING   psa_Assess_Ind;
	END;

	EXPORT BTLayoutIn 			:= RECORD 		//Business Trust
		STRING   bt_Entity_ID;
		STRING   bt_Name;
		STRING   bt_Status;
		STRING   bt_StatusReason;
		STRING   bt_Status_Date;
		STRING   bt_Duration; 
		STRING   bt_Incorp_Date;
		STRING   bt_Incorp_State;
		STRING   bt_Industry_Code;
		STRING   bt_Street1;
		STRING   bt_Street2;
		STRING   bt_City;
		STRING   bt_State;
		STRING   bt_Zip;
		STRING   bt_PrinOffEff_Date;
		STRING   bt_RA_Name;
		STRING   bt_RA_Street1; 
		STRING   bt_RA_Street2;
		STRING   bt_RA_City;
		STRING   bt_RA_State;
		STRING   bt_RA_Zip;
		STRING   bt_RA_Eff_Date;
		STRING   bt_RA_Status;
		STRING   bt_RA_Loc;
		STRING   bt_Stock_Ind;
		STRING   bt_Total_Shares;
		STRING   bt_Merger_Ind;
		STRING   bt_Assess_Ind;
	END;
	
	EXPORT GPLayoutIn 	:= RECORD 					//General Partner
		STRING   gp_Entity_ID;
		STRING   gp_Name;
		STRING   gp_Status;
		STRING   gp_StatusReason;
		STRING   gp_Status_Date;
		STRING   gp_Duration; 
		STRING   gp_Incorp_Date;
		STRING   gp_Incorp_State;
		STRING   gp_Industry_Code;
		STRING   gp_Street1;
		STRING   gp_Street2;
		STRING   gp_City;
		STRING   gp_State;
		STRING   gp_Zip;
		STRING   gp_PrinOffEff_Date;
		STRING   gp_RA_Name;
		STRING   gp_RA_Street1; 
		STRING   gp_RA_Street2;
		STRING   gp_RA_City;
		STRING   gp_RA_State;
		STRING   gp_RA_Zip;
		STRING   gp_RA_Eff_Date;
		STRING   gp_RA_Status;
		STRING   gp_RA_Loc;
		STRING   gp_StockInd;
		STRING   gp_Total_Shares;
		STRING   gp_Merger_Ind;
		STRING   gp_Assess_Ind;
	END;
	
  //**********************************	
	//Below are TEMPORARY Record layouts
  //**********************************	

	//Corps Lookup Layouts
  EXPORT TempCorpsLayoutIn	 		         := RECORD
		CorpsLayoutIn;
		//Merger fields
		STRING  merg_type;
		STRING  merg_eff_date;
		STRING  merg_surv_id;
	END;

  EXPORT TempLPLayoutIn	 		             := RECORD
		LPLayoutIn;
		//Merger fields
		STRING  merg_type;
		STRING  merg_eff_date;
		STRING  merg_surv_id;
	END;
	
	EXPORT TempLLCLayoutIn	 		           := RECORD
		LLCLayoutIn;
		//Merger fields
		STRING  merg_type;
		STRING  merg_eff_date;
		STRING  merg_surv_id;
	END;

	EXPORT TempOfficersCorpsLayoutIn 			 := RECORD
		OfficersLayoutIn;  
		STRING350 corp_legal_name;
	END;

	//Normalized Layout		
  EXPORT TempNormAmendLayoutIn 				   := RECORD
		STRING  amend_entity_id;
		STRING  amend_date;
		STRING  amend_type;		
		STRING  amend_stock_class; 
		STRING  amend_stock_abbrv; 
    STRING 	amend_stock_shares;
		STRING  corp_key; 
	END;
	
	EXPORT NamesHist_TempLay					     := RECORD
		NamesHistLayoutIn;
		CorpsLayoutIn.corps_entity_id;
		CorpsLayoutIn.corps_incorp_date;
		CorpsLayoutIn.corps_incorp_state;
	END;
	
	EXPORT Reserved_TempLay									:= RECORD
		ReservedLayoutIn;
		CorpsLayoutIn.corps_entity_id;
		CorpsLayoutIn.corps_incorp_date;
	END;
			
END;
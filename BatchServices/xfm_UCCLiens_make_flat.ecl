IMPORT BatchServices, UCCv2_Services;

EXPORT BatchServices.layout_UCCLiens_Batch_out.final_out xfm_UCCLiens_make_flat(BatchServices.layouts.ucc.rec_ucc_rollup_src_acctno l) := 
	TRANSFORM

		SELF.TMSID                    := l.tmsid;
		self.acctno                   := l.acctno;
		
	// Core section:

		SELF.filing_jurisdiction      := l.filing_jurisdiction;     
		SELF.filing_jurisdiction_name := l.filing_jurisdiction_name;
		SELF.orig_filing_number       := l.orig_filing_number;      
		SELF.orig_filing_type         := l.orig_filing_type;        
		SELF.orig_filing_date         := l.orig_filing_date;        
		SELF.filing_status            := l.filing_status[1].filing_status;                    
		SELF.filing_status_desc       := l.filing_status[1].filing_status_desc;          
		SELF.total_debtors_count      := (STRING4)COUNT(l.debtors);        
		SELF.total_secureds_count     := (STRING4)COUNT(l.secureds) + (STRING4)COUNT(l.creditors);      
		SELF.total_assignees_count    := (STRING4)COUNT(l.assignees);    

	// ***** FILINGS (6 most recent Filings, sorted by filing_date descending) *****

		SELF.filing_1_filing_number   := l.filings[1].filing_number;  
		SELF.filing_1_filing_type     := l.filings[1].filing_type;    
		SELF.filing_1_filing_date     := l.filings[1].filing_date;   
		SELF.filing_1_expiration_date := l.filings[1].expiration_date;
		SELF.filing_1_contract_type   := l.filings[1].contract_type;  
		SELF.filing_1_amount          := l.filings[1].amount;
		
		SELF.filing_2_filing_number   := l.filings[2].filing_number;  
		SELF.filing_2_filing_type     := l.filings[2].filing_type;    
		SELF.filing_2_filing_date     := l.filings[2].filing_date;   
		SELF.filing_2_expiration_date := l.filings[2].expiration_date;
		SELF.filing_2_contract_type   := l.filings[2].contract_type; 
		SELF.filing_2_amount          := l.filings[2].amount;
		
		SELF.filing_3_filing_number   := l.filings[3].filing_number;  
		SELF.filing_3_filing_type     := l.filings[3].filing_type;    
		SELF.filing_3_filing_date     := l.filings[3].filing_date;   
		SELF.filing_3_expiration_date := l.filings[3].expiration_date;
		SELF.filing_3_contract_type   := l.filings[3].contract_type; 
		SELF.filing_3_amount          := l.filings[3].amount;
		
		SELF.filing_4_filing_number   := l.filings[4].filing_number;  
		SELF.filing_4_filing_type     := l.filings[4].filing_type;    
		SELF.filing_4_filing_date     := l.filings[4].filing_date;   
		SELF.filing_4_expiration_date := l.filings[4].expiration_date;
		SELF.filing_4_contract_type   := l.filings[4].contract_type; 
		SELF.filing_4_amount          := l.filings[4].amount;
		
		SELF.filing_5_filing_number   := l.filings[5].filing_number;  
		SELF.filing_5_filing_type     := l.filings[5].filing_type;    
		SELF.filing_5_filing_date     := l.filings[5].filing_date;   
		SELF.filing_5_expiration_date := l.filings[5].expiration_date;
		SELF.filing_5_contract_type   := l.filings[5].contract_type; 
		SELF.filing_5_amount          := l.filings[5].amount;
		
		SELF.filing_6_filing_number   := l.filings[6].filing_number;  
		SELF.filing_6_filing_type     := l.filings[6].filing_type;    
		SELF.filing_6_filing_date     := l.filings[6].filing_date;   
		SELF.filing_6_expiration_date := l.filings[6].expiration_date;
		SELF.filing_6_contract_type   := l.filings[6].contract_type; 	
		SELF.filing_6_amount          := l.filings[6].amount;
		
	// ***** DEBTORS (10) *****

		SELF.debtor_1_party_1_orig_name   := l.debtors[1].orig_name;
		SELF.debtor_1_party_1_addr_1      := l.debtors[1].addresses[1].address1;
		SELF.debtor_1_party_1_addr_2      := l.debtors[1].addresses[1].address2;
		SELF.debtor_1_party_1_v_city_name := l.debtors[1].addresses[1].v_city_name;
		SELF.debtor_1_party_1_st          := l.debtors[1].addresses[1].st;
		SELF.debtor_1_party_1_zip         := l.debtors[1].addresses[1].zip5;
		SELF.debtor_1_party_2_addr_1      := l.debtors[1].addresses[2].address1;
		SELF.debtor_1_party_2_addr_2      := l.debtors[1].addresses[2].address2;
		SELF.debtor_1_party_2_v_city_name := l.debtors[1].addresses[2].v_city_name;
		SELF.debtor_1_party_2_st          := l.debtors[1].addresses[2].st;
		SELF.debtor_1_party_2_zip         := l.debtors[1].addresses[2].zip5;
		SELF.debtor_1_party_UltID 				:= l.debtors[1].parsed_parties[1].UltID;
		SELF.debtor_1_party_OrgID 				:= l.debtors[1].parsed_parties[1].OrgID;
		SELF.debtor_1_party_SeleID 				:= l.debtors[1].parsed_parties[1].SeleID;
		SELF.debtor_1_party_ProxID 				:= l.debtors[1].parsed_parties[1].ProxID;
		SELF.debtor_1_party_PowID 				:= l.debtors[1].parsed_parties[1].PowID;
		SELF.debtor_1_party_EmpID 				:= l.debtors[1].parsed_parties[1].EmpID;
		SELF.debtor_1_party_DotID 				:= l.debtors[1].parsed_parties[1].DotID;
		
		SELF.debtor_2_party_1_orig_name   := l.debtors[2].orig_name;
		SELF.debtor_2_party_1_addr_1      := l.debtors[2].addresses[1].address1;
		SELF.debtor_2_party_1_addr_2      := l.debtors[2].addresses[1].address2;
		SELF.debtor_2_party_1_v_city_name := l.debtors[2].addresses[1].v_city_name;
		SELF.debtor_2_party_1_st          := l.debtors[2].addresses[1].st;
		SELF.debtor_2_party_1_zip         := l.debtors[2].addresses[1].zip5;
		SELF.debtor_2_party_2_addr_1      := l.debtors[2].addresses[2].address1;
		SELF.debtor_2_party_2_addr_2      := l.debtors[2].addresses[2].address2;
		SELF.debtor_2_party_2_v_city_name := l.debtors[2].addresses[2].v_city_name;
		SELF.debtor_2_party_2_st          := l.debtors[2].addresses[2].st;
		SELF.debtor_2_party_2_zip         := l.debtors[2].addresses[2].zip5;
		SELF.debtor_2_party_UltID 				:= l.debtors[2].parsed_parties[1].UltID;
		SELF.debtor_2_party_OrgID 				:= l.debtors[2].parsed_parties[1].OrgID;
		SELF.debtor_2_party_SeleID 				:= l.debtors[2].parsed_parties[1].SeleID;
		SELF.debtor_2_party_ProxID 				:= l.debtors[2].parsed_parties[1].ProxID;
		SELF.debtor_2_party_PowID 				:= l.debtors[2].parsed_parties[1].PowID;
		SELF.debtor_2_party_EmpID 				:= l.debtors[2].parsed_parties[1].EmpID;
		SELF.debtor_2_party_DotID 				:= l.debtors[2].parsed_parties[1].DotID;

		SELF.debtor_3_party_1_orig_name   := l.debtors[3].orig_name;
		SELF.debtor_3_party_1_addr_1      := l.debtors[3].addresses[1].address1;
		SELF.debtor_3_party_1_addr_2      := l.debtors[3].addresses[1].address2;
		SELF.debtor_3_party_1_v_city_name := l.debtors[3].addresses[1].v_city_name;
		SELF.debtor_3_party_1_st          := l.debtors[3].addresses[1].st;
		SELF.debtor_3_party_1_zip         := l.debtors[3].addresses[1].zip5;
		SELF.debtor_3_party_2_addr_1      := l.debtors[3].addresses[2].address1;
		SELF.debtor_3_party_2_addr_2      := l.debtors[3].addresses[2].address2;
		SELF.debtor_3_party_2_v_city_name := l.debtors[3].addresses[2].v_city_name;
		SELF.debtor_3_party_2_st          := l.debtors[3].addresses[2].st;
		SELF.debtor_3_party_2_zip         := l.debtors[3].addresses[2].zip5;
		SELF.debtor_3_party_UltID 				:= l.debtors[3].parsed_parties[1].UltID;
		SELF.debtor_3_party_OrgID 				:= l.debtors[3].parsed_parties[1].OrgID;
		SELF.debtor_3_party_SeleID 				:= l.debtors[3].parsed_parties[1].SeleID;
		SELF.debtor_3_party_ProxID 				:= l.debtors[3].parsed_parties[1].ProxID;
		SELF.debtor_3_party_PowID 				:= l.debtors[3].parsed_parties[1].PowID;
		SELF.debtor_3_party_EmpID 				:= l.debtors[3].parsed_parties[1].EmpID;
		SELF.debtor_3_party_DotID 				:= l.debtors[3].parsed_parties[1].DotID;

		SELF.debtor_4_party_1_orig_name   := l.debtors[4].orig_name;
		SELF.debtor_4_party_1_addr_1      := l.debtors[4].addresses[1].address1;
		SELF.debtor_4_party_1_addr_2      := l.debtors[4].addresses[1].address2;
		SELF.debtor_4_party_1_v_city_name := l.debtors[4].addresses[1].v_city_name;
		SELF.debtor_4_party_1_st          := l.debtors[4].addresses[1].st;
		SELF.debtor_4_party_1_zip         := l.debtors[4].addresses[1].zip5;
		SELF.debtor_4_party_2_addr_1      := l.debtors[4].addresses[2].address1;
		SELF.debtor_4_party_2_addr_2      := l.debtors[4].addresses[2].address2;
		SELF.debtor_4_party_2_v_city_name := l.debtors[4].addresses[2].v_city_name;
		SELF.debtor_4_party_2_st          := l.debtors[4].addresses[2].st;
		SELF.debtor_4_party_2_zip         := l.debtors[4].addresses[2].zip5;
		SELF.debtor_4_party_UltID 				:= l.debtors[4].parsed_parties[1].UltID;
		SELF.debtor_4_party_OrgID 				:= l.debtors[4].parsed_parties[1].OrgID;
		SELF.debtor_4_party_SeleID 				:= l.debtors[4].parsed_parties[1].SeleID;
		SELF.debtor_4_party_ProxID 				:= l.debtors[4].parsed_parties[1].ProxID;
		SELF.debtor_4_party_PowID 				:= l.debtors[4].parsed_parties[1].PowID;
		SELF.debtor_4_party_EmpID 				:= l.debtors[4].parsed_parties[1].EmpID;
		SELF.debtor_4_party_DotID 				:= l.debtors[4].parsed_parties[1].DotID;

		SELF.debtor_5_party_1_orig_name   := l.debtors[5].orig_name;
		SELF.debtor_5_party_1_addr_1      := l.debtors[5].addresses[1].address1;
		SELF.debtor_5_party_1_addr_2      := l.debtors[5].addresses[1].address2;
		SELF.debtor_5_party_1_v_city_name := l.debtors[5].addresses[1].v_city_name;
		SELF.debtor_5_party_1_st          := l.debtors[5].addresses[1].st;
		SELF.debtor_5_party_1_zip         := l.debtors[5].addresses[1].zip5;
		SELF.debtor_5_party_2_addr_1      := l.debtors[5].addresses[2].address1;
		SELF.debtor_5_party_2_addr_2      := l.debtors[5].addresses[2].address2;
		SELF.debtor_5_party_2_v_city_name := l.debtors[5].addresses[2].v_city_name;
		SELF.debtor_5_party_2_st          := l.debtors[5].addresses[2].st;
		SELF.debtor_5_party_2_zip         := l.debtors[5].addresses[2].zip5;
		SELF.debtor_5_party_UltID 				:= l.debtors[5].parsed_parties[1].UltID;
		SELF.debtor_5_party_OrgID 				:= l.debtors[5].parsed_parties[1].OrgID;
		SELF.debtor_5_party_SeleID 				:= l.debtors[5].parsed_parties[1].SeleID;
		SELF.debtor_5_party_ProxID 				:= l.debtors[5].parsed_parties[1].ProxID;
		SELF.debtor_5_party_PowID 				:= l.debtors[5].parsed_parties[1].PowID;
		SELF.debtor_5_party_EmpID 				:= l.debtors[5].parsed_parties[1].EmpID;
		SELF.debtor_5_party_DotID 				:= l.debtors[5].parsed_parties[1].DotID;

		SELF.debtor_6_party_1_orig_name   := l.debtors[6].orig_name;
		SELF.debtor_6_party_1_addr_1      := l.debtors[6].addresses[1].address1;
		SELF.debtor_6_party_1_addr_2      := l.debtors[6].addresses[1].address2;
		SELF.debtor_6_party_1_v_city_name := l.debtors[6].addresses[1].v_city_name;
		SELF.debtor_6_party_1_st          := l.debtors[6].addresses[1].st;
		SELF.debtor_6_party_1_zip         := l.debtors[6].addresses[1].zip5;
		SELF.debtor_6_party_2_addr_1      := l.debtors[6].addresses[2].address1;
		SELF.debtor_6_party_2_addr_2      := l.debtors[6].addresses[2].address2;
		SELF.debtor_6_party_2_v_city_name := l.debtors[6].addresses[2].v_city_name;
		SELF.debtor_6_party_2_st          := l.debtors[6].addresses[2].st;
		SELF.debtor_6_party_2_zip         := l.debtors[6].addresses[2].zip5;
		SELF.debtor_6_party_UltID 				:= l.debtors[6].parsed_parties[1].UltID;
		SELF.debtor_6_party_OrgID 				:= l.debtors[6].parsed_parties[1].OrgID;
		SELF.debtor_6_party_SeleID 				:= l.debtors[6].parsed_parties[1].SeleID;
		SELF.debtor_6_party_ProxID 				:= l.debtors[6].parsed_parties[1].ProxID;
		SELF.debtor_6_party_PowID 				:= l.debtors[6].parsed_parties[1].PowID;
		SELF.debtor_6_party_EmpID 				:= l.debtors[6].parsed_parties[1].EmpID;
		SELF.debtor_6_party_DotID 				:= l.debtors[6].parsed_parties[1].DotID;

		SELF.debtor_7_party_1_orig_name   := l.debtors[7].orig_name;
		SELF.debtor_7_party_1_addr_1      := l.debtors[7].addresses[1].address1;
		SELF.debtor_7_party_1_addr_2      := l.debtors[7].addresses[1].address2;
		SELF.debtor_7_party_1_v_city_name := l.debtors[7].addresses[1].v_city_name;
		SELF.debtor_7_party_1_st          := l.debtors[7].addresses[1].st;
		SELF.debtor_7_party_1_zip         := l.debtors[7].addresses[1].zip5;
		SELF.debtor_7_party_2_addr_1      := l.debtors[7].addresses[2].address1;
		SELF.debtor_7_party_2_addr_2      := l.debtors[7].addresses[2].address2;
		SELF.debtor_7_party_2_v_city_name := l.debtors[7].addresses[2].v_city_name;
		SELF.debtor_7_party_2_st          := l.debtors[7].addresses[2].st;
		SELF.debtor_7_party_2_zip         := l.debtors[7].addresses[2].zip5;
		SELF.debtor_7_party_UltID 				:= l.debtors[7].parsed_parties[1].UltID;
		SELF.debtor_7_party_OrgID 				:= l.debtors[7].parsed_parties[1].OrgID;
		SELF.debtor_7_party_SeleID 				:= l.debtors[7].parsed_parties[1].SeleID;
		SELF.debtor_7_party_ProxID 				:= l.debtors[7].parsed_parties[1].ProxID;
		SELF.debtor_7_party_PowID 				:= l.debtors[7].parsed_parties[1].PowID;
		SELF.debtor_7_party_EmpID 				:= l.debtors[7].parsed_parties[1].EmpID;
		SELF.debtor_7_party_DotID 				:= l.debtors[7].parsed_parties[1].DotID;

		SELF.debtor_8_party_1_orig_name   := l.debtors[8].orig_name;
		SELF.debtor_8_party_1_addr_1      := l.debtors[8].addresses[1].address1;
		SELF.debtor_8_party_1_addr_2      := l.debtors[8].addresses[1].address2;
		SELF.debtor_8_party_1_v_city_name := l.debtors[8].addresses[1].v_city_name;
		SELF.debtor_8_party_1_st          := l.debtors[8].addresses[1].st;
		SELF.debtor_8_party_1_zip         := l.debtors[8].addresses[1].zip5;
		SELF.debtor_8_party_2_addr_1      := l.debtors[8].addresses[2].address1;
		SELF.debtor_8_party_2_addr_2      := l.debtors[8].addresses[2].address2;
		SELF.debtor_8_party_2_v_city_name := l.debtors[8].addresses[2].v_city_name;
		SELF.debtor_8_party_2_st          := l.debtors[8].addresses[2].st;
		SELF.debtor_8_party_2_zip         := l.debtors[8].addresses[2].zip5;
		SELF.debtor_8_party_UltID 				:= l.debtors[8].parsed_parties[1].UltID;
		SELF.debtor_8_party_OrgID 				:= l.debtors[8].parsed_parties[1].OrgID;
		SELF.debtor_8_party_SeleID 				:= l.debtors[8].parsed_parties[1].SeleID;
		SELF.debtor_8_party_ProxID 				:= l.debtors[8].parsed_parties[1].ProxID;
		SELF.debtor_8_party_PowID 				:= l.debtors[8].parsed_parties[1].PowID;
		SELF.debtor_8_party_EmpID 				:= l.debtors[8].parsed_parties[1].EmpID;
		SELF.debtor_8_party_DotID 				:= l.debtors[8].parsed_parties[1].DotID;

		SELF.debtor_9_party_1_orig_name   := l.debtors[9].orig_name;
		SELF.debtor_9_party_1_addr_1      := l.debtors[9].addresses[1].address1;
		SELF.debtor_9_party_1_addr_2      := l.debtors[9].addresses[1].address2;
		SELF.debtor_9_party_1_v_city_name := l.debtors[9].addresses[1].v_city_name;
		SELF.debtor_9_party_1_st          := l.debtors[9].addresses[1].st;
		SELF.debtor_9_party_1_zip         := l.debtors[9].addresses[1].zip5;
		SELF.debtor_9_party_2_addr_1      := l.debtors[9].addresses[2].address1;
		SELF.debtor_9_party_2_addr_2      := l.debtors[9].addresses[2].address2;
		SELF.debtor_9_party_2_v_city_name := l.debtors[9].addresses[2].v_city_name;
		SELF.debtor_9_party_2_st          := l.debtors[9].addresses[2].st;
		SELF.debtor_9_party_2_zip         := l.debtors[9].addresses[2].zip5;
		SELF.debtor_9_party_UltID 				:= l.debtors[9].parsed_parties[1].UltID;
		SELF.debtor_9_party_OrgID 				:= l.debtors[9].parsed_parties[1].OrgID;
		SELF.debtor_9_party_SeleID 				:= l.debtors[9].parsed_parties[1].SeleID;
		SELF.debtor_9_party_ProxID 				:= l.debtors[9].parsed_parties[1].ProxID;
		SELF.debtor_9_party_PowID 				:= l.debtors[9].parsed_parties[1].PowID;
		SELF.debtor_9_party_EmpID 				:= l.debtors[9].parsed_parties[1].EmpID;
		SELF.debtor_9_party_DotID 				:= l.debtors[9].parsed_parties[1].DotID;

		SELF.debtor_10_party_1_orig_name   := l.debtors[10].orig_name;
		SELF.debtor_10_party_1_addr_1      := l.debtors[10].addresses[1].address1;
		SELF.debtor_10_party_1_addr_2      := l.debtors[10].addresses[1].address2;
		SELF.debtor_10_party_1_v_city_name := l.debtors[10].addresses[1].v_city_name;
		SELF.debtor_10_party_1_st          := l.debtors[10].addresses[1].st;
		SELF.debtor_10_party_1_zip         := l.debtors[10].addresses[1].zip5;
		SELF.debtor_10_party_2_addr_1      := l.debtors[10].addresses[2].address1;
		SELF.debtor_10_party_2_addr_2      := l.debtors[10].addresses[2].address2;
		SELF.debtor_10_party_2_v_city_name := l.debtors[10].addresses[2].v_city_name;
		SELF.debtor_10_party_2_st          := l.debtors[10].addresses[2].st;
		SELF.debtor_10_party_2_zip         := l.debtors[10].addresses[2].zip5;
		SELF.debtor_10_party_UltID 				 := l.debtors[10].parsed_parties[1].UltID;
		SELF.debtor_10_party_OrgID 				 := l.debtors[10].parsed_parties[1].OrgID;
		SELF.debtor_10_party_SeleID 			 := l.debtors[10].parsed_parties[1].SeleID;
		SELF.debtor_10_party_ProxID 			 := l.debtors[10].parsed_parties[1].ProxID;
		SELF.debtor_10_party_PowID 				 := l.debtors[10].parsed_parties[1].PowID;
		SELF.debtor_10_party_EmpID 				 := l.debtors[10].parsed_parties[1].EmpID;
		SELF.debtor_10_party_DotID 				 := l.debtors[10].parsed_parties[1].DotID;
			
	// ***** SECUREDS (5) *****
		
		// Business rule. In the world of UCC Liens, only MA calls a secured party a 'creditor'. Everyone calls them a 'secured party'.
		
		// Secured 1
		
		SELF.secured_1_orig_name   := IF( l.filing_jurisdiction != 'MA', l.secureds[1].orig_name                , l.creditors[1].orig_name );
		SELF.secured_1_addr_1      := IF( l.filing_jurisdiction != 'MA', l.secureds[1].addresses[1].address1    , l.creditors[1].addresses[1].address1 );   
		SELF.secured_1_addr_2      := IF( l.filing_jurisdiction != 'MA', l.secureds[1].addresses[1].address2    , l.creditors[1].addresses[1].address2 );   
		SELF.secured_1_v_city_name := IF( l.filing_jurisdiction != 'MA', l.secureds[1].addresses[1].v_city_name , l.creditors[1].addresses[1].v_city_name );
		SELF.secured_1_st          := IF( l.filing_jurisdiction != 'MA', l.secureds[1].addresses[1].st          , l.creditors[1].addresses[1].st );         
		SELF.secured_1_zip         := IF( l.filing_jurisdiction != 'MA', l.secureds[1].addresses[1].zip5        , l.creditors[1].addresses[1].zip5 );
		SELF.Secured_1_UltID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[1].parsed_parties[1].UltID  , l.creditors[1].parsed_parties[1].UltID );	
		SELF.Secured_1_OrgID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[1].parsed_parties[1].OrgID  , l.creditors[1].parsed_parties[1].OrgID );	
		SELF.Secured_1_SeleID 		 := IF( l.filing_jurisdiction != 'MA', l.secureds[1].parsed_parties[1].SeleID , l.creditors[1].parsed_parties[1].SeleID );	
		SELF.Secured_1_ProxID 		 := IF( l.filing_jurisdiction != 'MA', l.secureds[1].parsed_parties[1].ProxID , l.creditors[1].parsed_parties[1].ProxID );	
		SELF.Secured_1_PowID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[1].parsed_parties[1].PowID  , l.creditors[1].parsed_parties[1].PowID );	
		SELF.Secured_1_EmpID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[1].parsed_parties[1].EmpID  , l.creditors[1].parsed_parties[1].EmpID );	
		SELF.Secured_1_DotID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[1].parsed_parties[1].DotID  , l.creditors[1].parsed_parties[1].DotID );	
		                                                                                             
		// Secured 2
		
		SELF.secured_2_orig_name   := IF( l.filing_jurisdiction != 'MA', l.secureds[2].orig_name                , l.creditors[2].orig_name );
		SELF.secured_2_addr_1      := IF( l.filing_jurisdiction != 'MA', l.secureds[2].addresses[1].address1    , l.creditors[2].addresses[1].address1 );   
		SELF.secured_2_addr_2      := IF( l.filing_jurisdiction != 'MA', l.secureds[2].addresses[1].address2    , l.creditors[2].addresses[1].address2 );   
		SELF.secured_2_v_city_name := IF( l.filing_jurisdiction != 'MA', l.secureds[2].addresses[1].v_city_name , l.creditors[2].addresses[1].v_city_name );
		SELF.secured_2_st          := IF( l.filing_jurisdiction != 'MA', l.secureds[2].addresses[1].st          , l.creditors[2].addresses[1].st );         
		SELF.secured_2_zip         := IF( l.filing_jurisdiction != 'MA', l.secureds[2].addresses[1].zip5        , l.creditors[2].addresses[1].zip5 );       
		SELF.Secured_2_UltID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[2].parsed_parties[1].UltID  , l.creditors[2].parsed_parties[1].UltID );	
		SELF.Secured_2_OrgID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[2].parsed_parties[1].OrgID  , l.creditors[2].parsed_parties[1].OrgID );	
		SELF.Secured_2_SeleID 		 := IF( l.filing_jurisdiction != 'MA', l.secureds[2].parsed_parties[1].SeleID , l.creditors[2].parsed_parties[1].SeleID );	
		SELF.Secured_2_ProxID 		 := IF( l.filing_jurisdiction != 'MA', l.secureds[2].parsed_parties[1].ProxID , l.creditors[2].parsed_parties[1].ProxID );	
		SELF.Secured_2_PowID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[2].parsed_parties[1].PowID  , l.creditors[2].parsed_parties[1].PowID );	
		SELF.Secured_2_EmpID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[2].parsed_parties[1].EmpID  , l.creditors[2].parsed_parties[1].EmpID );	
		SELF.Secured_2_DotID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[2].parsed_parties[1].DotID  , l.creditors[2].parsed_parties[1].DotID );	
		
		// Secured 3
		
		SELF.secured_3_orig_name   := IF( l.filing_jurisdiction != 'MA', l.secureds[3].orig_name                , l.creditors[3].orig_name );
		SELF.secured_3_addr_1      := IF( l.filing_jurisdiction != 'MA', l.secureds[3].addresses[1].address1    , l.creditors[3].addresses[1].address1 );   
		SELF.secured_3_addr_2      := IF( l.filing_jurisdiction != 'MA', l.secureds[3].addresses[1].address2    , l.creditors[3].addresses[1].address2 );   
		SELF.secured_3_v_city_name := IF( l.filing_jurisdiction != 'MA', l.secureds[3].addresses[1].v_city_name , l.creditors[3].addresses[1].v_city_name );
		SELF.secured_3_st          := IF( l.filing_jurisdiction != 'MA', l.secureds[3].addresses[1].st          , l.creditors[3].addresses[1].st );         
		SELF.secured_3_zip         := IF( l.filing_jurisdiction != 'MA', l.secureds[3].addresses[1].zip5        , l.creditors[3].addresses[1].zip5 );
		SELF.Secured_3_UltID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[3].parsed_parties[1].UltID  , l.creditors[3].parsed_parties[1].UltID );	
		SELF.Secured_3_OrgID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[3].parsed_parties[1].OrgID  , l.creditors[3].parsed_parties[1].OrgID );	
		SELF.Secured_3_SeleID 		 := IF( l.filing_jurisdiction != 'MA', l.secureds[3].parsed_parties[1].SeleID , l.creditors[3].parsed_parties[1].SeleID );	
		SELF.Secured_3_ProxID 		 := IF( l.filing_jurisdiction != 'MA', l.secureds[3].parsed_parties[1].ProxID , l.creditors[3].parsed_parties[1].ProxID );	
		SELF.Secured_3_PowID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[3].parsed_parties[1].PowID  , l.creditors[3].parsed_parties[1].PowID );	
		SELF.Secured_3_EmpID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[3].parsed_parties[1].EmpID  , l.creditors[3].parsed_parties[1].EmpID );	
		SELF.Secured_3_DotID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[3].parsed_parties[1].DotID  , l.creditors[3].parsed_parties[1].DotID );	
		                           
		// Secured 4
		
		SELF.secured_4_orig_name   := IF( l.filing_jurisdiction != 'MA', l.secureds[4].orig_name                , l.creditors[4].orig_name );
		SELF.secured_4_addr_1      := IF( l.filing_jurisdiction != 'MA', l.secureds[4].addresses[1].address1    , l.creditors[4].addresses[1].address1 );   
		SELF.secured_4_addr_2      := IF( l.filing_jurisdiction != 'MA', l.secureds[4].addresses[1].address2    , l.creditors[4].addresses[1].address2 );   
		SELF.secured_4_v_city_name := IF( l.filing_jurisdiction != 'MA', l.secureds[4].addresses[1].v_city_name , l.creditors[4].addresses[1].v_city_name );
		SELF.secured_4_st          := IF( l.filing_jurisdiction != 'MA', l.secureds[4].addresses[1].st          , l.creditors[4].addresses[1].st );         
		SELF.secured_4_zip         := IF( l.filing_jurisdiction != 'MA', l.secureds[4].addresses[1].zip5        , l.creditors[4].addresses[1].zip5 );
		SELF.Secured_4_UltID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[4].parsed_parties[1].UltID  , l.creditors[4].parsed_parties[1].UltID );	
		SELF.Secured_4_OrgID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[4].parsed_parties[1].OrgID  , l.creditors[4].parsed_parties[1].OrgID );	
		SELF.Secured_4_SeleID 		 := IF( l.filing_jurisdiction != 'MA', l.secureds[4].parsed_parties[1].SeleID , l.creditors[4].parsed_parties[1].SeleID );	
		SELF.Secured_4_ProxID 		 := IF( l.filing_jurisdiction != 'MA', l.secureds[4].parsed_parties[1].ProxID , l.creditors[4].parsed_parties[1].ProxID );	
		SELF.Secured_4_PowID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[4].parsed_parties[1].PowID  , l.creditors[4].parsed_parties[1].PowID );	
		SELF.Secured_4_EmpID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[4].parsed_parties[1].EmpID  , l.creditors[4].parsed_parties[1].EmpID );	
		SELF.Secured_4_DotID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[4].parsed_parties[1].DotID  , l.creditors[4].parsed_parties[1].DotID );	
		                           
		// Secured 5
		
		SELF.secured_5_orig_name   := IF( l.filing_jurisdiction != 'MA', l.secureds[5].orig_name                , l.creditors[5].orig_name );
		SELF.secured_5_addr_1      := IF( l.filing_jurisdiction != 'MA', l.secureds[5].addresses[1].address1    , l.creditors[5].addresses[1].address1 );   
		SELF.secured_5_addr_2      := IF( l.filing_jurisdiction != 'MA', l.secureds[5].addresses[1].address2    , l.creditors[5].addresses[1].address2 );   
		SELF.secured_5_v_city_name := IF( l.filing_jurisdiction != 'MA', l.secureds[5].addresses[1].v_city_name , l.creditors[5].addresses[1].v_city_name );
		SELF.secured_5_st          := IF( l.filing_jurisdiction != 'MA', l.secureds[5].addresses[1].st          , l.creditors[5].addresses[1].st );         
		SELF.secured_5_zip         := IF( l.filing_jurisdiction != 'MA', l.secureds[5].addresses[1].zip5        , l.creditors[5].addresses[1].zip5 );    
   	SELF.Secured_5_UltID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[5].parsed_parties[1].UltID  , l.creditors[5].parsed_parties[1].UltID );	
		SELF.Secured_5_OrgID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[5].parsed_parties[1].OrgID  , l.creditors[5].parsed_parties[1].OrgID );	
		SELF.Secured_5_SeleID 		 := IF( l.filing_jurisdiction != 'MA', l.secureds[5].parsed_parties[1].SeleID , l.creditors[5].parsed_parties[1].SeleID );	
		SELF.Secured_5_ProxID 		 := IF( l.filing_jurisdiction != 'MA', l.secureds[5].parsed_parties[1].ProxID , l.creditors[5].parsed_parties[1].ProxID );	
		SELF.Secured_5_PowID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[5].parsed_parties[1].PowID  , l.creditors[5].parsed_parties[1].PowID );	
		SELF.Secured_5_EmpID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[5].parsed_parties[1].EmpID  , l.creditors[5].parsed_parties[1].EmpID );	
		SELF.Secured_5_DotID 			 := IF( l.filing_jurisdiction != 'MA', l.secureds[5].parsed_parties[1].DotID  , l.creditors[5].parsed_parties[1].DotID );	
		                           
	// ***** ASSIGNEES (5) *****

		// Assignee 1
		
		SELF.assignee_1_orig_name   := l.assignees[1].orig_name;
		SELF.assignee_1_addr_1      := l.assignees[1].addresses[1].address1;
		SELF.assignee_1_addr_2      := l.assignees[1].addresses[1].address2;
		SELF.assignee_1_v_city_name := l.assignees[1].addresses[1].v_city_name;
		SELF.assignee_1_st          := l.assignees[1].addresses[1].st;
		SELF.assignee_1_zip         := l.assignees[1].addresses[1].zip5;
		SELF.assignee_1_UltID 			:= l.assignees[1].parsed_parties[1].UltID;
		SELF.assignee_1_OrgID 			:= l.assignees[1].parsed_parties[1].OrgID;
		SELF.assignee_1_SeleID 			:= l.assignees[1].parsed_parties[1].SeleID;
		SELF.assignee_1_ProxID 			:= l.assignees[1].parsed_parties[1].ProxID;
		SELF.assignee_1_PowID 			:= l.assignees[1].parsed_parties[1].PowID;
		SELF.assignee_1_EmpID 			:= l.assignees[1].parsed_parties[1].EmpID;
		SELF.assignee_1_DotID 			:= l.assignees[1].parsed_parties[1].DotID;
		
		// Assignee 2
		
		SELF.assignee_2_orig_name   := l.assignees[2].orig_name;
		SELF.assignee_2_addr_1      := l.assignees[2].addresses[1].address1;
		SELF.assignee_2_addr_2      := l.assignees[2].addresses[1].address2;
		SELF.assignee_2_v_city_name := l.assignees[2].addresses[1].v_city_name;
		SELF.assignee_2_st          := l.assignees[2].addresses[1].st;
		SELF.assignee_2_zip         := l.assignees[2].addresses[1].zip5;
		SELF.assignee_2_UltID 			:= l.assignees[2].parsed_parties[1].UltID;
		SELF.assignee_2_OrgID 			:= l.assignees[2].parsed_parties[1].OrgID;
		SELF.assignee_2_SeleID 			:= l.assignees[2].parsed_parties[1].SeleID;
		SELF.assignee_2_ProxID 			:= l.assignees[2].parsed_parties[1].ProxID;
		SELF.assignee_2_PowID 			:= l.assignees[2].parsed_parties[1].PowID;
		SELF.assignee_2_EmpID 			:= l.assignees[2].parsed_parties[1].EmpID;
		SELF.assignee_2_DotID 			:= l.assignees[2].parsed_parties[1].DotID;
		
		// Assignee 3
		
		SELF.assignee_3_orig_name   := l.assignees[3].orig_name;
		SELF.assignee_3_addr_1      := l.assignees[3].addresses[1].address1;
		SELF.assignee_3_addr_2      := l.assignees[3].addresses[1].address2;
		SELF.assignee_3_v_city_name := l.assignees[3].addresses[1].v_city_name;
		SELF.assignee_3_st          := l.assignees[3].addresses[1].st;
		SELF.assignee_3_zip         := l.assignees[3].addresses[1].zip5;
		SELF.assignee_3_UltID 			:= l.assignees[3].parsed_parties[1].UltID;
		SELF.assignee_3_OrgID 			:= l.assignees[3].parsed_parties[1].OrgID;
		SELF.assignee_3_SeleID 			:= l.assignees[3].parsed_parties[1].SeleID;
		SELF.assignee_3_ProxID 			:= l.assignees[3].parsed_parties[1].ProxID;
		SELF.assignee_3_PowID 			:= l.assignees[3].parsed_parties[1].PowID;
		SELF.assignee_3_EmpID 			:= l.assignees[3].parsed_parties[1].EmpID;
		SELF.assignee_3_DotID 			:= l.assignees[3].parsed_parties[1].DotID;
		
		// Assignee 4
		
		SELF.assignee_4_orig_name   := l.assignees[4].orig_name;
		SELF.assignee_4_addr_1      := l.assignees[4].addresses[1].address1;
		SELF.assignee_4_addr_2      := l.assignees[4].addresses[1].address2;
		SELF.assignee_4_v_city_name := l.assignees[4].addresses[1].v_city_name;
		SELF.assignee_4_st          := l.assignees[4].addresses[1].st;
		SELF.assignee_4_zip         := l.assignees[4].addresses[1].zip5;
		SELF.assignee_4_UltID 			:= l.assignees[4].parsed_parties[1].UltID;
		SELF.assignee_4_OrgID 			:= l.assignees[4].parsed_parties[1].OrgID;
		SELF.assignee_4_SeleID 			:= l.assignees[4].parsed_parties[1].SeleID;
		SELF.assignee_4_ProxID 			:= l.assignees[4].parsed_parties[1].ProxID;
		SELF.assignee_4_PowID 			:= l.assignees[4].parsed_parties[1].PowID;
		SELF.assignee_4_EmpID 			:= l.assignees[4].parsed_parties[1].EmpID;
		SELF.assignee_4_DotID 			:= l.assignees[4].parsed_parties[1].DotID;
		
		// Assignee 5
		
		SELF.assignee_5_orig_name   := l.assignees[5].orig_name;
		SELF.assignee_5_addr_1      := l.assignees[5].addresses[1].address1;
		SELF.assignee_5_addr_2      := l.assignees[5].addresses[1].address2;
		SELF.assignee_5_v_city_name := l.assignees[5].addresses[1].v_city_name;
		SELF.assignee_5_st          := l.assignees[5].addresses[1].st;
		SELF.assignee_5_zip         := l.assignees[5].addresses[1].zip5;
		SELF.assignee_5_UltID 			:= l.assignees[5].parsed_parties[1].UltID;
		SELF.assignee_5_OrgID 			:= l.assignees[5].parsed_parties[1].OrgID;
		SELF.assignee_5_SeleID 			:= l.assignees[5].parsed_parties[1].SeleID;
		SELF.assignee_5_ProxID 			:= l.assignees[5].parsed_parties[1].ProxID;
		SELF.assignee_5_PowID 			:= l.assignees[5].parsed_parties[1].PowID;
		SELF.assignee_5_EmpID 			:= l.assignees[5].parsed_parties[1].EmpID;
		SELF.assignee_5_DotID 			:= l.assignees[5].parsed_parties[1].DotID;
			
		// ***** FILING OFFICE (1) *****	
			
		SELF.filing_agency          := l.filing_offices[1].filing_agency;
		SELF.address                := l.filing_offices[1].address;
		SELF.city                   := l.filing_offices[1].city;
		SELF.state                  := l.filing_offices[1].state;
		SELF.county                 := l.filing_offices[1].county;
		SELF.zip                    := l.filing_offices[1].zip;
	
	// A description of the collateralÂ—up to 512 characters

		SELF.collateral_desc        := l.collateral[1].collateral_desc;
		SELF.borough                := l.collateral[1].borough;
			
	END;
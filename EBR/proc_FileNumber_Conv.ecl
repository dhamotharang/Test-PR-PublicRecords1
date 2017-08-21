export proc_FileNumber_Conv(string filedate) := function

ebr.MAC_FileNumber_Conv(ebr.File_0010_Header_In,                           ebr.Layout_0010_Header_In,                          '0010_Header',                              filedate,       _0010_Header );			    
ebr.MAC_FileNumber_Conv(EBR.File_1000_Executive_Summary_In, 		 ebr.Layout_1000_Executive_Summary_In, 	       '1000_Executive_Summary', 		   filedate,       _1000_Executive_Summary); 		              	        
ebr.MAC_FileNumber_Conv(EBR.File_2000_Trade_In,				 ebr.Layout_2000_Trade_In,			       '2000_Trade',				   filedate,	     _2000_Trade);				
ebr.MAC_FileNumber_Conv(EBR.File_2015_Trade_Payment_Totals_In,		 ebr.Layout_2015_Trade_Payment_Totals_In,	       '2015_Trade_Payment_Totals',		   filedate,	     _2015_Trade_Payment_Totals);		
ebr.MAC_FileNumber_Conv(EBR.File_2020_Trade_Payment_Trends_In,		 ebr.Layout_2020_Trade_Payment_Trends_In,	       '2020_Trade_Payment_Trends',		   filedate,	     _2020_Trade_Payment_Trends);		
ebr.MAC_FileNumber_Conv(EBR.File_2025_Trade_Quarterly_Averages_In,	 ebr.Layout_2025_Trade_Quarterly_Averages_In,	       '2025_Trade_Quarterly_Averages',		   filedate,	     _2025_Trade_Quarterly_Averages);		
ebr.MAC_FileNumber_Conv(EBR.File_4010_Bankruptcy_In,			 ebr.Layout_4010_Bankruptcy_In,		       '4010_Bankruptcy',			   filedate,	     _4010_Bankruptcy);			
ebr.MAC_FileNumber_Conv(EBR.File_4020_Tax_Liens_In,			 ebr.Layout_4020_Tax_Liens_In,		       '4020_Tax_Liens',			   filedate,	     _4020_Tax_Liens);			
ebr.MAC_FileNumber_Conv(EBR.File_4030_Judgement_In, 			 ebr.Layout_4030_Judgement_In, 		       '4030_Judgement', 			   filedate,	     _4030_Judgement); 			
ebr.MAC_FileNumber_Conv(EBR.File_4035_Attachment_Lien_In,			 ebr.Layout_4035_Attachment_Lien_In,		       '4035_Attachment_Lien',			   filedate,	     _4035_Attachment_Lien);			
ebr.MAC_FileNumber_Conv(EBR.File_4040_Bulk_Transfers_In,			 ebr.Layout_4040_Bulk_Transfers_In,		       '4040_Bulk_Transfers',			   filedate,	     _4040_Bulk_Transfers);			
ebr.MAC_FileNumber_Conv(EBR.File_4500_Collateral_Accounts_In,		 ebr.Layout_4500_Collateral_Accounts_In,	       '4500_Collateral_Accounts',		   filedate,	     _4500_Collateral_Accounts);		
ebr.MAC_FileNumber_Conv(EBR.File_4510_UCC_Filings_In,			 ebr.Layout_4510_UCC_Filings_In,		       '4510_UCC_Filings',			   filedate,	     _4510_UCC_Filings);			
ebr.MAC_FileNumber_Conv(EBR.File_5000_Bank_Details_In,			 ebr.Layout_5000_Bank_Details_In,		       '5000_Bank_Details',			   filedate,	     _5000_Bank_Details);			
ebr.MAC_FileNumber_Conv(EBR.File_5600_Demographic_Data_In,		 ebr.Layout_5600_Demographic_Data_In,		       '5600_Demographic_Data',			   filedate,	     _5600_Demographic_Data);			
ebr.MAC_FileNumber_Conv(EBR.File_5610_Demographic_Data_In,		 ebr.Layout_5610_Demographic_Data_In,		       '5610_Demographic_Data',			   filedate,	     _5610_Demographic_Data);			
ebr.MAC_FileNumber_Conv(EBR.File_6000_Inquiries_In,			 ebr.Layout_6000_Inquiries_In,		       '6000_Inquiries',			   filedate,	     _6000_Inquiries);			
ebr.MAC_FileNumber_Conv(EBR.File_6500_Government_Trade_In,		 ebr.Layout_6500_Government_Trade_In,		       '6500_Government_Trade',			   filedate,	     _6500_Government_Trade);			
ebr.MAC_FileNumber_Conv(EBR.File_6510_Government_Debarred_Contractor_In,	 ebr.Layout_6510_Government_Debarred_Contractor_In,  '6510_Government_Debarred_Contractor',	   filedate,	     _6510_Government_Debarred_Contractor);	
ebr.MAC_FileNumber_Conv(EBR.File_7000_SNP_Parent_Name_Address_In,		 ebr.Layout_7000_SNP_Parent_Name_Address_In,	       '7000_SNP_Parent_Name_Address',		   filedate,	     _7000_SNP_Parent_Name_Address);
ebr.MAC_FileNumber_Conv(EBR.File_7010_SNP_Data_In,		 ebr.Layout_7010_SNP_Data_In,	       '7010_SNP_Data_In',		   filedate,	     _7010_SNP_Data_In);		
		
outconv := SEQUENTIAL(										 						       							   
_0010_Header,                          										 						       							   
_1000_Executive_Summary,
_2000_Trade,				
_2015_Trade_Payment_Totals,		
_2020_Trade_Payment_Trends,		
_2025_Trade_Quarterly_Averages,	
_4010_Bankruptcy,			
_4020_Tax_Liens,			
_4030_Judgement, 			
_4035_Attachment_Lien,			
_4040_Bulk_Transfers,			
_4500_Collateral_Accounts,		
_4510_UCC_Filings,			
_5000_Bank_Details,			
_5600_Demographic_Data,		
_5610_Demographic_Data,		
_6000_Inquiries,			
_6500_Government_Trade,		
_6510_Government_Debarred_Contractor,	
_7000_SNP_Parent_Name_Address,
_7010_SNP_Data_In
);
return outconv;
end;
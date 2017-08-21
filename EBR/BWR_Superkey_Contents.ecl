export whichversion(string pkeyname, string pversion) :=
	fileservices.superfilecontents(pkeyname + '_' + pversion);

myversion := 'qa';

superkeycontents := 
	  whichversion(KeyName_0010_Header_BDID, myversion)								
	+ whichversion(KeyName_0010_Header_FILE_NUMBER, myversion)						
	+ whichversion(KeyName_1000_Executive_Summary_BDID, myversion)					
	+ whichversion(KeyName_1000_Executive_Summary_FILE_NUMBER, myversion)				
	+ whichversion(KeyName_2000_Trade_BDID, myversion)								
	+ whichversion(KeyName_2000_Trade_FILE_NUMBER, myversion)							
	+ whichversion(KeyName_2015_Trade_Payment_Totals_BDID, myversion)					
	+ whichversion(KeyName_2015_Trade_Payment_Totals_FILE_NUMBER, myversion)			
	+ whichversion(KeyName_2020_Trade_Payment_Trends_BDID, myversion)					
	+ whichversion(KeyName_2020_Trade_Payment_Trends_FILE_NUMBER, myversion)			
	+ whichversion(KeyName_2025_Trade_Quarterly_Averages_BDID, myversion)				
	+ whichversion(KeyName_2025_Trade_Quarterly_Averages_FILE_NUMBER, myversion)		
	+ whichversion(KeyName_4010_Bankruptcy_BDID, myversion)							
	+ whichversion(KeyName_4010_Bankruptcy_FILE_NUMBER, myversion)					
	+ whichversion(KeyName_4020_Tax_Liens_BDID, myversion)							
	+ whichversion(KeyName_4020_Tax_Liens_FILE_NUMBER, myversion)						
	+ whichversion(KeyName_4030_Judgement_BDID, myversion)							
	+ whichversion(KeyName_4030_Judgement_FILE_NUMBER, myversion)						
//	+ whichversion(KeyName_4035_Attachment_Lien_BDID, myversion)						
//	+ whichversion(KeyName_4035_Attachment_Lien_FILE_NUMBER, myversion)				
//	+ whichversion(KeyName_4040_Bulk_Transfers_BDID, myversion)						
//	+ whichversion(KeyName_4040_Bulk_Transfers_FILE_NUMBER, myversion)				
	+ whichversion(KeyName_4500_Collateral_Accounts_BDID, myversion)					
	+ whichversion(KeyName_4500_Collateral_Accounts_FILE_NUMBER, myversion)			
	+ whichversion(KeyName_4510_UCC_Filings_BDID, myversion)							
	+ whichversion(KeyName_4510_UCC_Filings_FILE_NUMBER, myversion)					
	+ whichversion(KeyName_5000_Bank_Details_BDID, myversion)							
	+ whichversion(KeyName_5000_Bank_Details_FILE_NUMBER, myversion)					
	+ whichversion(KeyName_5600_Demographic_Data_BDID, myversion)						
	+ whichversion(KeyName_5600_Demographic_Data_FILE_NUMBER, myversion)				
	+ whichversion(KeyName_5610_Demographic_Data_BDID, myversion)						
	+ whichversion(KeyName_5610_Demographic_Data_DID, myversion)						
	+ whichversion(KeyName_5610_Demographic_Data_FILE_NUMBER, myversion)				
	+ whichversion(KeyName_5610_Demographic_Data_SSN, myversion)						
	+ whichversion(KeyName_6000_Inquiries_BDID, myversion)							
	+ whichversion(KeyName_6000_Inquiries_FILE_NUMBER, myversion)						
	+ whichversion(KeyName_6500_Government_Trade_BDID, myversion)						
	+ whichversion(KeyName_6500_Government_Trade_FILE_NUMBER, myversion)				
	+ whichversion(KeyName_6510_Government_Debarred_Contractor_BDID, myversion)		
	+ whichversion(KeyName_6510_Government_Debarred_Contractor_FILE_NUMBER, myversion)
//	+ whichversion(KeyName_7000_SNP_Parent_Name_Address_BDID, myversion)				
//	+ whichversion(KeyName_7000_SNP_Parent_Name_Address_FILE_NUMBER, myversion)		
	+ whichversion(KeyName_7010_SNP_Data_BDID, myversion)								
	+ whichversion(KeyName_7010_SNP_Data_FILE_NUMBER, myversion);

export BWR_Superkey_Contents := output(superkeycontents, named('EbrSuperkeyContents'), all);
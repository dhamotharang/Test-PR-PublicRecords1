import ebr;
#workunit('name', ebr.Dataset_Name + ' create all superfiles and superkeys');

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Create Input Superfiles
//////////////////////////////////////////////////////////////////////////////////////////////
ebr.create_superfiles(ebr.FileName_0010_Header_In);
ebr.create_superfiles(ebr.FileName_1000_Executive_Summary_In);
ebr.create_superfiles(ebr.FileName_2000_Trade_In);
ebr.create_superfiles(ebr.FileName_2015_Trade_Payment_Totals_In);
ebr.create_superfiles(ebr.FileName_2020_Trade_Payment_Trends_In);
ebr.create_superfiles(ebr.FileName_2025_Trade_Quarterly_Averages_In);
ebr.create_superfiles(ebr.FileName_4010_Bankruptcy_In);
ebr.create_superfiles(ebr.FileName_4020_Tax_Liens_In);
ebr.create_superfiles(ebr.FileName_4030_Judgement_In);
ebr.create_superfiles(ebr.FileName_4035_Attachment_Lien_In);
ebr.create_superfiles(ebr.FileName_4040_Bulk_Transfers_In);
ebr.create_superfiles(ebr.FileName_4500_Collateral_Accounts_In);
ebr.create_superfiles(ebr.FileName_4510_UCC_Filings_In);
ebr.create_superfiles(ebr.FileName_5000_Bank_Details_In);
ebr.create_superfiles(ebr.FileName_5600_Demographic_Data_In);
ebr.create_superfiles(ebr.FileName_5610_Demographic_Data_In);
ebr.create_superfiles(ebr.FileName_6000_Inquiries_In);
ebr.create_superfiles(ebr.FileName_6500_Government_Trade_In);
ebr.create_superfiles(ebr.FileName_6510_Government_Debarred_Contractor_In);
ebr.create_superfiles(ebr.FileName_7000_SNP_Parent_Name_Address_In);
ebr.create_superfiles(ebr.FileName_7010_SNP_Data_In);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Create Base Superfiles
//////////////////////////////////////////////////////////////////////////////////////////////
ebr.create_superfiles(ebr.FileName_0010_Header_Base,true);
ebr.create_superfiles(ebr.FileName_1000_Executive_Summary_Base,true);
ebr.create_superfiles(ebr.FileName_2000_Trade_Base,true);
ebr.create_superfiles(ebr.FileName_2015_Trade_Payment_Totals_Base,true);
ebr.create_superfiles(ebr.FileName_2020_Trade_Payment_Trends_Base,true);
ebr.create_superfiles(ebr.FileName_2025_Trade_Quarterly_Averages_Base,true);
ebr.create_superfiles(ebr.FileName_4010_Bankruptcy_Base,true);
ebr.create_superfiles(ebr.FileName_4020_Tax_Liens_Base,true);
ebr.create_superfiles(ebr.FileName_4030_Judgement_Base,true);
ebr.create_superfiles(ebr.FileName_4035_Attachment_Lien_Base,true);
ebr.create_superfiles(ebr.FileName_4040_Bulk_Transfers_Base,true);
ebr.create_superfiles(ebr.FileName_4500_Collateral_Accounts_Base,true);
ebr.create_superfiles(ebr.FileName_4510_UCC_Filings_Base,true);
ebr.create_superfiles(ebr.FileName_5000_Bank_Details_Base,true);
ebr.create_superfiles(ebr.FileName_5600_Demographic_Data_Base,true);
ebr.create_superfiles(ebr.FileName_5610_Demographic_Data_Base,true);
ebr.create_superfiles(ebr.FileName_6000_Inquiries_Base,true);
ebr.create_superfiles(ebr.FileName_6500_Government_Trade_Base,true);
ebr.create_superfiles(ebr.FileName_6510_Government_Debarred_Contractor_Base,true);
ebr.create_superfiles(ebr.FileName_7000_SNP_Parent_Name_Address_Base,true);
ebr.create_superfiles(ebr.FileName_7010_SNP_Data_Base,true);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Create Superkey files
//////////////////////////////////////////////////////////////////////////////////////////////
ebr.create_superkeys(ebr.KeyName_0010_Header_BDID);
ebr.create_superkeys(ebr.KeyName_0010_Header_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_1000_Executive_Summary_BDID);
ebr.create_superkeys(ebr.KeyName_1000_Executive_Summary_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_2000_Trade_BDID);
ebr.create_superkeys(ebr.KeyName_2000_Trade_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_2015_Trade_Payment_Totals_BDID);
ebr.create_superkeys(ebr.KeyName_2015_Trade_Payment_Totals_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_2020_Trade_Payment_Trends_BDID);
ebr.create_superkeys(ebr.KeyName_2020_Trade_Payment_Trends_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_2025_Trade_Quarterly_Averages_BDID);
ebr.create_superkeys(ebr.KeyName_2025_Trade_Quarterly_Averages_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_4010_Bankruptcy_BDID);
ebr.create_superkeys(ebr.KeyName_4010_Bankruptcy_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_4020_Tax_Liens_BDID);
ebr.create_superkeys(ebr.KeyName_4020_Tax_Liens_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_4030_Judgement_BDID);
ebr.create_superkeys(ebr.KeyName_4030_Judgement_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_4035_Attachment_Lien_BDID);
ebr.create_superkeys(ebr.KeyName_4035_Attachment_Lien_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_4040_Bulk_Transfers_BDID);
ebr.create_superkeys(ebr.KeyName_4040_Bulk_Transfers_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_4500_Collateral_Accounts_BDID);
ebr.create_superkeys(ebr.KeyName_4500_Collateral_Accounts_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_4510_UCC_Filings_BDID);
ebr.create_superkeys(ebr.KeyName_4510_UCC_Filings_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_5000_Bank_Details_BDID);
ebr.create_superkeys(ebr.KeyName_5000_Bank_Details_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_5600_Demographic_Data_BDID);
ebr.create_superkeys(ebr.KeyName_5600_Demographic_Data_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_5610_Demographic_Data_BDID);
ebr.create_superkeys(ebr.KeyName_5610_Demographic_Data_DID);
ebr.create_superkeys(ebr.KeyName_5610_Demographic_Data_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_5610_Demographic_Data_SSN);
ebr.create_superkeys(ebr.KeyName_6000_Inquiries_BDID);
ebr.create_superkeys(ebr.KeyName_6000_Inquiries_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_6500_Government_Trade_BDID);
ebr.create_superkeys(ebr.KeyName_6500_Government_Trade_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_6510_Government_Debarred_Contractor_BDID);
ebr.create_superkeys(ebr.KeyName_6510_Government_Debarred_Contractor_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_7000_SNP_Parent_Name_Address_BDID);
ebr.create_superkeys(ebr.KeyName_7000_SNP_Parent_Name_Address_FILE_NUMBER);
ebr.create_superkeys(ebr.KeyName_7010_SNP_Data_BDID);
ebr.create_superkeys(ebr.KeyName_7010_SNP_Data_FILE_NUMBER);

//*** For LinkIDS superfiles ********
ebr.create_superkeys(ebr.KeyName_0010_Header_Linkids);
ebr.create_superkeys(ebr.KeyName_1000_Executive_Summary_Linkids);
ebr.create_superkeys(ebr.KeyName_4510_UCC_Filings_Linkids);
ebr.create_superkeys(ebr.KeyName_5600_Demographic_Data_Linkids);
ebr.create_superkeys(ebr.KeyName_5610_Demographic_Data_Linkids);


//******************** AUTOKEYS ********************************
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::Payload');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::address');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::addressb');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::citystname');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::citystnameb');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::fein');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::name');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::nameb');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::namewords');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::phone');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::phoneb');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::phoneb');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::ssn');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::stname');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::stnameb');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::zip');
ebr.create_superkeys(trim(ebr.KeyName_root) + 'autokey::zipb');

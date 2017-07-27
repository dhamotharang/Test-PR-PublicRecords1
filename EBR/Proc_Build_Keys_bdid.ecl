import ut, roxiekeybuild;

export Proc_Build_Keys_bdid(string filedate) := function

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Build all keys + superkey manipulation
//////////////////////////////////////////////////////////////////////////////////////////////
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_0010_Header_BDID,								keynames(filedate).Versions.k0010_header_bdid.New,								'',build_0010_Header_bdid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_0010_Header_FILE_NUMBER,						keynames(filedate).Versions.k0010_header_file_number.New,							'',build_0010_Header_FILE_NUMBER_key);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_1000_Executive_Summary_BDID,					keynames(filedate).Versions.k1000_executive_summary_bdid.New,						'',build_1000_Executive_Summary_BDID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_1000_Executive_Summary_FILE_NUMBER,				keynames(filedate).Versions.k1000_executive_summary_file_number.New,				'',build_1000_Executive_Summary_FILE_NUMBER_key);
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_2000_Trade_BDID,								keynames(filedate).Versions.k2000_trade_bdid.New,									'',build_2000_Trade_BDID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_2000_Trade_FILE_NUMBER,							keynames(filedate).Versions.k2000_trade_file_number.New,							'',build_2000_Trade_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_2015_Trade_Payment_Totals_BDID,					keynames(filedate).Versions.k2015_trade_payment_totals_bdid.New,					'',build_2015_Trade_Payment_Totals_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_2015_Trade_Payment_Totals_FILE_NUMBER,			keynames(filedate).Versions.k2015_trade_payment_totals_file_number.New,			'',build_2015_Trade_Payment_Totals_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_2020_Trade_Payment_Trends_BDID,					keynames(filedate).Versions.k2020_trade_payment_trends_bdid.New,					'',build_2020_Trade_Payment_Trends_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_2020_Trade_Payment_Trends_FILE_NUMBER,			keynames(filedate).Versions.k2020_trade_payment_trends_file_number.New,			'',build_2020_Trade_Payment_Trends_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_2025_Trade_Quarterly_Averages_BDID,				keynames(filedate).Versions.k2025_trade_quarterly_averages_bdid.New,				'',build_2025_Trade_Quarterly_Averages_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_2025_Trade_Quarterly_Averages_FILE_NUMBER,		keynames(filedate).Versions.k2025_trade_quarterly_averages_file_number.New,		'',build_2025_Trade_Quarterly_Averages_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4010_Bankruptcy_BDID,							keynames(filedate).Versions.k4010_bankruptcy_bdid.New,							'',build_4010_Bankruptcy_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4010_Bankruptcy_FILE_NUMBER,					keynames(filedate).Versions.k4010_bankruptcy_file_number.New,						'',build_4010_Bankruptcy_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4020_Tax_Liens_BDID,							keynames(filedate).Versions.k4020_tax_liens_bdid.New,								'',build_4020_Tax_Liens_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4020_Tax_Liens_FILE_NUMBER,						keynames(filedate).Versions.k4020_tax_liens_file_number.New,						'',build_4020_Tax_Liens_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4030_Judgement_BDID,							keynames(filedate).Versions.k4030_judgement_bdid.New,								'',build_4030_Judgement_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4030_Judgement_FILE_NUMBER,						keynames(filedate).Versions.k4030_judgement_file_number.New,						'',build_4030_Judgement_FILE_NUMBER_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4035_Attachment_Lien_BDID,						keynames(filedate).Versions.k4035_attachment_lien_bdid.New,						'',build_4035_Attachment_Lien_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4035_Attachment_Lien_FILE_NUMBER,				keynames(filedate).Versions.k4035_attachment_lien_file_number.New,				'',build_4035_Attachment_Lien_FILE_NUMBER_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4040_Bulk_Transfers_BDID,						keynames(filedate).Versions.k4040_bulk_transfers_bdid.New,						'',build_4040_Bulk_Transfers_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4040_Bulk_Transfers_FILE_NUMBER,				keynames(filedate).Versions.k4040_bulk_transfers_file_number.New,					'',build_4040_Bulk_Transfers_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4500_Collateral_Accounts_BDID,					keynames(filedate).Versions.k4500_collateral_accounts_bdid.New,					'',build_4500_Collateral_Accounts_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4500_Collateral_Accounts_FILE_NUMBER,			keynames(filedate).Versions.k4500_collateral_accounts_file_number.New,			'',build_4500_Collateral_Accounts_FILE_NUMBER_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4510_UCC_Filings_BDID,							keynames(filedate).Versions.k4510_ucc_filings_bdid.New,							'',build_4510_UCC_Filings_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4510_UCC_Filings_FILE_NUMBER,					keynames(filedate).Versions.k4510_ucc_filings_file_number.New,					'',build_4510_UCC_Filings_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_5000_Bank_Details_BDID,							keynames(filedate).Versions.k5000_bank_details_bdid.New,							'',build_5000_Bank_Details_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_5000_Bank_Details_FILE_NUMBER,					keynames(filedate).Versions.k5000_bank_details_file_number.New,					'',build_5000_Bank_Details_FILE_NUMBER_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_5600_Demographic_Data_BDID,						keynames(filedate).Versions.k5600_demographic_data_bdid.New,						'',build_5600_Demographic_Data_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_5600_Demographic_Data_FILE_NUMBER,				keynames(filedate).Versions.k5600_demographic_data_file_number.New,				'',build_5600_Demographic_Data_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_5610_Demographic_Data_BDID,						keynames(filedate).Versions.k5610_demographic_data_bdid.New,						'',build_5610_Demographic_Data_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_5610_Demographic_Data_DID,						keynames(filedate).Versions.k5610_demographic_data_did.New,						'',build_5610_Demographic_Data_DID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_5610_Demographic_Data_FILE_NUMBER,				keynames(filedate).Versions.k5610_demographic_data_file_number.New, 				'',build_5610_Demographic_Data_FILE_NUMBER_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_5610_Demographic_Data_SSN,						keynames(filedate).Versions.k5610_demographic_data_ssn.New, 						'',build_5610_Demographic_Data_SSN_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_6000_Inquiries_BDID,							keynames(filedate).Versions.k6000_inquiries_bdid.New,								'',build_6000_Inquiries_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_6000_Inquiries_FILE_NUMBER,						keynames(filedate).Versions.k6000_inquiries_file_number.New,						'',build_6000_Inquiries_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_6500_Government_Trade_BDID,						keynames(filedate).Versions.k6500_government_trade_bdid.New,						'',build_6500_Government_Trade_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_6500_Government_Trade_FILE_NUMBER,				keynames(filedate).Versions.k6500_government_trade_file_number.New,				'',build_6500_Government_Trade_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_6510_Government_Debarred_Contractor_BDID,		keynames(filedate).Versions.k6510_government_debarred_contractor_bdid.New,		'',build_6510_Government_Debarred_Contractor_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_6510_Government_Debarred_Contractor_FILE_NUMBER,keynames(filedate).Versions.k6510_government_debarred_contractor_file_number.New, '',build_6510_Government_Debarred_Contractor_FILE_NUMBER_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_7000_SNP_Parent_Name_Address_BDID,				keynames(filedate).Versions.k7000_snp_parent_name_address_bdid.New,				'',build_7000_SNP_Parent_Name_Address_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_7000_SNP_Parent_Name_Address_FILE_NUMBER,		keynames(filedate).Versions.k7000_snp_parent_name_address_file_number.New,		'',build_7000_SNP_Parent_Name_Address_FILE_NUMBER_key)
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_7010_SNP_Data_BDID,								keynames(filedate).Versions.k7010_snp_data_bdid.New,								'',build_7010_SNP_Data_BDID_key)
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_7010_SNP_Data_FILE_NUMBER,						keynames(filedate).Versions.k7010_snp_data_file_number.New,						'',build_7010_SNP_Data_FILE_NUMBER_key)							
                                                                                 
Build_Keys1 := parallel(
    build_0010_Header_BDID_key
   ,build_0010_Header_FILE_NUMBER_key
   ,build_1000_Executive_Summary_BDID_key
   ,build_1000_Executive_Summary_FILE_NUMBER_key
   //,build_2000_Trade_BDID_key
   ,build_2000_Trade_FILE_NUMBER_key
   //,build_2015_Trade_Payment_Totals_BDID_key
   ,build_2015_Trade_Payment_Totals_FILE_NUMBER_key
   //,build_2020_Trade_Payment_Trends_BDID_key
   ,build_2020_Trade_Payment_Trends_FILE_NUMBER_key
   //,build_2025_Trade_Quarterly_Averages_BDID_key
   ,build_2025_Trade_Quarterly_Averages_FILE_NUMBER_key
   //,build_4010_Bankruptcy_BDID_key
   ,build_4010_Bankruptcy_FILE_NUMBER_key
   //,build_4020_Tax_Liens_BDID_key
   ,build_4020_Tax_Liens_FILE_NUMBER_key
   //,build_4030_Judgement_BDID_key
   ,build_4030_Judgement_FILE_NUMBER_key
);
Build_Keys2 := parallel(
// ,build_4035_Attachment_Lien_BDID_key
// ,build_4035_Attachment_Lien_FILE_NUMBER_key
// ,build_4040_Bulk_Transfers_BDID_key
// ,build_4040_Bulk_Transfers_FILE_NUMBER_key
//  build_4500_Collateral_Accounts_BDID_key
    build_4500_Collateral_Accounts_FILE_NUMBER_key
   ,build_4510_UCC_Filings_BDID_key
   ,build_4510_UCC_Filings_FILE_NUMBER_key
// ,build_5000_Bank_Details_BDID_key
   ,build_5000_Bank_Details_FILE_NUMBER_key
   ,build_5600_Demographic_Data_BDID_key
   ,build_5600_Demographic_Data_FILE_NUMBER_key
// ,build_5610_Demographic_Data_BDID_key
   ,build_5610_Demographic_Data_DID_key
   ,build_5610_Demographic_Data_FILE_NUMBER_key
   ,build_5610_Demographic_Data_SSN_key
// ,build_6000_Inquiries_BDID_key
   ,build_6000_Inquiries_FILE_NUMBER_key
// ,build_6500_Government_Trade_BDID_key
   ,build_6500_Government_Trade_FILE_NUMBER_key
// ,build_6510_Government_Debarred_Contractor_BDID_key
   ,build_6510_Government_Debarred_Contractor_FILE_NUMBER_key
// ,build_7000_SNP_Parent_Name_Address_BDID_key
// ,build_7000_SNP_Parent_Name_Address_FILE_NUMBER_key
// ,build_7010_SNP_Data_BDID_key
   ,build_7010_SNP_Data_FILE_NUMBER_key
);
Build_Keys := sequential(
	 Build_Keys1
	,Build_Keys2
);

RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k0010_header_bdid.New,									KeyName_0010_Header_BDID,												Move_0010_Header_bdid_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k0010_header_file_number.New,							KeyName_0010_Header_FILE_NUMBER,										Move_0010_Header_FILE_NUMBER_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k1000_executive_summary_bdid.New,						KeyName_1000_Executive_Summary_BDID,									Move_1000_Executive_Summary_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k1000_executive_summary_file_number.New,				KeyName_1000_Executive_Summary_FILE_NUMBER,								Move_1000_Executive_Summary_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k2000_trade_bdid.New,									KeyName_2000_Trade_BDID,												Move_2000_Trade_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k2000_trade_file_number.New,							KeyName_2000_Trade_FILE_NUMBER,											Move_2000_Trade_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k2015_trade_payment_totals_bdid.New,					KeyName_2015_Trade_Payment_Totals_BDID,									Move_2015_Trade_Payment_Totals_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k2015_trade_payment_totals_file_number.New,			KeyName_2015_Trade_Payment_Totals_FILE_NUMBER,							Move_2015_Trade_Payment_Totals_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k2020_trade_payment_trends_bdid.New,					KeyName_2020_Trade_Payment_Trends_BDID,									Move_2020_Trade_Payment_Trends_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k2020_trade_payment_trends_file_number.New,			KeyName_2020_Trade_Payment_Trends_FILE_NUMBER,							Move_2020_Trade_Payment_Trends_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k2025_trade_quarterly_averages_bdid.New,				KeyName_2025_Trade_Quarterly_Averages_BDID,								Move_2025_Trade_Quarterly_Averages_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k2025_trade_quarterly_averages_file_number.New,		KeyName_2025_Trade_Quarterly_Averages_FILE_NUMBER,						Move_2025_Trade_Quarterly_Averages_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4010_bankruptcy_bdid.New,								KeyName_4010_Bankruptcy_BDID,											Move_4010_Bankruptcy_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4010_bankruptcy_file_number.New,						KeyName_4010_Bankruptcy_FILE_NUMBER,									Move_4010_Bankruptcy_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4020_tax_liens_bdid.New,								KeyName_4020_Tax_Liens_BDID,											Move_4020_Tax_Liens_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4020_tax_liens_file_number.New,						KeyName_4020_Tax_Liens_FILE_NUMBER,										Move_4020_Tax_Liens_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4030_judgement_bdid.New,								KeyName_4030_Judgement_BDID,											Move_4030_Judgement_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4030_judgement_file_number.New,						KeyName_4030_Judgement_FILE_NUMBER,										Move_4030_Judgement_FILE_NUMBER_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4035_attachment_lien_bdid.New,						KeyName_4035_Attachment_Lien_BDID,										Move_4035_Attachment_Lien_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4035_attachment_lien_file_number.New,					KeyName_4035_Attachment_Lien_FILE_NUMBER,								Move_4035_Attachment_Lien_FILE_NUMBER_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4040_bulk_transfers_bdid.New,							KeyName_4040_Bulk_Transfers_BDID,										Move_4040_Bulk_Transfers_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4040_bulk_transfers_file_number.New,					KeyName_4040_Bulk_Transfers_FILE_NUMBER,								Move_4040_Bulk_Transfers_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4500_collateral_accounts_bdid.New,					KeyName_4500_Collateral_Accounts_BDID,									Move_4500_Collateral_Accounts_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4500_collateral_accounts_file_number.New,				KeyName_4500_Collateral_Accounts_FILE_NUMBER,							Move_4500_Collateral_Accounts_FILE_NUMBER_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4510_ucc_filings_bdid.New,							KeyName_4510_UCC_Filings_BDID,											Move_4510_UCC_Filings_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k4510_ucc_filings_file_number.New,						KeyName_4510_UCC_Filings_FILE_NUMBER,									Move_4510_UCC_Filings_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k5000_bank_details_bdid.New,							KeyName_5000_Bank_Details_BDID,											Move_5000_Bank_Details_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k5000_bank_details_file_number.New,					KeyName_5000_Bank_Details_FILE_NUMBER,									Move_5000_Bank_Details_FILE_NUMBER_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k5600_demographic_data_bdid.New,						KeyName_5600_Demographic_Data_BDID,										Move_5600_Demographic_Data_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k5600_demographic_data_file_number.New,				KeyName_5600_Demographic_Data_FILE_NUMBER,								Move_5600_Demographic_Data_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k5610_demographic_data_bdid.New,						KeyName_5610_Demographic_Data_BDID,										Move_5610_Demographic_Data_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k5610_demographic_data_did.New,						KeyName_5610_Demographic_Data_DID,										Move_5610_Demographic_Data_DID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k5610_demographic_data_file_number.New, 				KeyName_5610_Demographic_Data_FILE_NUMBER,								Move_5610_Demographic_Data_FILE_NUMBER_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k5610_demographic_data_ssn.New, 						KeyName_5610_Demographic_Data_SSN,										Move_5610_Demographic_Data_SSN_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k6000_inquiries_bdid.New,								KeyName_6000_Inquiries_BDID,											Move_6000_Inquiries_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k6000_inquiries_file_number.New,						KeyName_6000_Inquiries_FILE_NUMBER,										Move_6000_Inquiries_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k6500_government_trade_bdid.New,						KeyName_6500_Government_Trade_BDID,										Move_6500_Government_Trade_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k6500_government_trade_file_number.New,				KeyName_6500_Government_Trade_FILE_NUMBER,								Move_6500_Government_Trade_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k6510_government_debarred_contractor_bdid.New,			KeyName_6510_Government_Debarred_Contractor_BDID,						Move_6510_Government_Debarred_Contractor_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k6510_government_debarred_contractor_file_number.New, 	KeyName_6510_Government_Debarred_Contractor_FILE_NUMBER,				Move_6510_Government_Debarred_Contractor_FILE_NUMBER_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k7000_snp_parent_name_address_bdid.New,				KeyName_7000_SNP_Parent_Name_Address_BDID,								Move_7000_SNP_Parent_Name_Address_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k7000_snp_parent_name_address_file_number.New,			KeyName_7000_SNP_Parent_Name_Address_FILE_NUMBER,						Move_7000_SNP_Parent_Name_Address_FILE_NUMBER_key, 2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k7010_snp_data_bdid.New,								KeyName_7010_SNP_Data_BDID,												Move_7010_SNP_Data_BDID_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames(filedate).Versions.k7010_snp_data_file_number.New,						KeyName_7010_SNP_Data_FILE_NUMBER,						                Move_7010_SNP_Data_FILE_NUMBER_key, 2);					

Move_Keys := sequential(
	 Move_0010_Header_bdid_key
	,Move_0010_Header_FILE_NUMBER_key
	,Move_1000_Executive_Summary_BDID_key
	,Move_1000_Executive_Summary_FILE_NUMBER_key
//,Move_2000_Trade_BDID_key
	,Move_2000_Trade_FILE_NUMBER_key
//,Move_2015_Trade_Payment_Totals_BDID_key
	,Move_2015_Trade_Payment_Totals_FILE_NUMBER_key
//,Move_2020_Trade_Payment_Trends_BDID_key
	,Move_2020_Trade_Payment_Trends_FILE_NUMBER_key
//,Move_2025_Trade_Quarterly_Averages_BDID_key
	,Move_2025_Trade_Quarterly_Averages_FILE_NUMBER_key
//,Move_4010_Bankruptcy_BDID_key
	,Move_4010_Bankruptcy_FILE_NUMBER_key
//,Move_4020_Tax_Liens_BDID_key
	,Move_4020_Tax_Liens_FILE_NUMBER_key
//,Move_4030_Judgement_BDID_key
	,Move_4030_Judgement_FILE_NUMBER_key
//	,Move_4035_Attachment_Lien_BDID_key
//	,Move_4035_Attachment_Lien_FILE_NUMBER_key
//	,Move_4040_Bulk_Transfers_BDID_key
//	,Move_4040_Bulk_Transfers_FILE_NUMBER_key
//,Move_4500_Collateral_Accounts_BDID_key
	,Move_4500_Collateral_Accounts_FILE_NUMBER_key
	,Move_4510_UCC_Filings_BDID_key
	,Move_4510_UCC_Filings_FILE_NUMBER_key
//,Move_5000_Bank_Details_BDID_key
	,Move_5000_Bank_Details_FILE_NUMBER_key
	,Move_5600_Demographic_Data_BDID_key
	,Move_5600_Demographic_Data_FILE_NUMBER_key
//,Move_5610_Demographic_Data_BDID_key
	,Move_5610_Demographic_Data_DID_key
	,Move_5610_Demographic_Data_FILE_NUMBER_key
	,Move_5610_Demographic_Data_SSN_key
//,Move_6000_Inquiries_BDID_key
	,Move_6000_Inquiries_FILE_NUMBER_key
//,Move_6500_Government_Trade_BDID_key
	,Move_6500_Government_Trade_FILE_NUMBER_key
//,Move_6510_Government_Debarred_Contractor_BDID_key
	,Move_6510_Government_Debarred_Contractor_FILE_NUMBER_key
//	,Move_7000_SNP_Parent_Name_Address_BDID_key
//	,Move_7000_SNP_Parent_Name_Address_FILE_NUMBER_key
//,Move_7010_SNP_Data_BDID_key
	,Move_7010_SNP_Data_FILE_NUMBER_key					
);


//////////////////////////////////////////////////////////////////////////////////////////////
// -- Execute all
//////////////////////////////////////////////////////////////////////////////////////////////
retval := sequential(
	 Build_Keys
	,Move_Keys
);

return retval;

end;

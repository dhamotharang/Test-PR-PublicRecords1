import ut;

ut.mac_SF_Move(FileName_0010_Header_In,						'R',rollback_0010_Header_superfile						,2,false)
ut.mac_SF_Move(FileName_1000_Executive_Summary_In,			'R',rollback_1000_Executive_Summary_superfile			,2,false)
ut.mac_SF_Move(FileName_2000_Trade_In,						'R',rollback_2000_Trade_superfile						,2,false)
ut.mac_SF_Move(FileName_2015_Trade_Payment_Totals_In,			'R',rollback_2015_Trade_Payment_Totals_superfile			,2,false)
ut.mac_SF_Move(FileName_2020_Trade_Payment_Trends_In,			'R',rollback_2020_Trade_Payment_Trends_superfile			,2,false)
ut.mac_SF_Move(FileName_2025_Trade_Quarterly_Averages_In,		'R',rollback_2025_Trade_Quarterly_Averages_superfile		,2,false)
ut.mac_SF_Move(FileName_4010_Bankruptcy_In,					'R',rollback_4010_Bankruptcy_superfile					,2,false)
ut.mac_SF_Move(FileName_4020_Tax_Liens_In,					'R',rollback_4020_Tax_Liens_superfile					,2,false)
ut.mac_SF_Move(FileName_4030_Judgement_In,					'R',rollback_4030_Judgement_superfile					,2,false)
ut.mac_SF_Move(FileName_4035_Attachment_Lien_In,				'R',rollback_4035_Attachment_Lien_superfile				,2,false)
ut.mac_SF_Move(FileName_4040_Bulk_Transfers_In,				'R',rollback_4040_Bulk_Transfers_superfile				,2,false)
ut.mac_SF_Move(FileName_4500_Collateral_Accounts_In,			'R',rollback_4500_Collateral_Accounts_superfile			,2,false)
ut.mac_SF_Move(FileName_4510_UCC_Filings_In,					'R',rollback_4510_UCC_Filings_superfile					,2,false)
ut.mac_SF_Move(FileName_5000_Bank_Details_In,				'R',rollback_5000_Bank_Details_superfile				,2,false)
ut.mac_SF_Move(FileName_5600_Demographic_Data_In,				'R',rollback_5600_Demographic_Data_superfile				,2,false)
ut.mac_SF_Move(FileName_5610_Demographic_Data_In,				'R',rollback_5610_Demographic_Data_superfile				,2,false)
ut.mac_SF_Move(FileName_6000_Inquiries_In,				 	'R',rollback_6000_Inquiries_superfile					,2,false)
ut.mac_SF_Move(FileName_6500_Government_Trade_In,				'R',rollback_6500_Government_Trade_superfile				,2,false)
ut.mac_SF_Move(FileName_6510_Government_Debarred_Contractor_In,	'R',rollback_6510_Government_Debarred_Contractor_superfile	,2,false)
ut.mac_SF_Move(FileName_7000_SNP_Parent_Name_Address_In,		'R',rollback_7000_SNP_Parent_Name_Address_superfile		,2,false)
ut.mac_SF_Move(FileName_7010_SNP_Data_In,					'R',rollback_7010_SNP_Data_superfile					,2,false)
                                                              
export BWR_Rollback_Input_Files := sequential(
	 rollback_0010_Header_superfile
	,rollback_1000_Executive_Summary_superfile
	,rollback_2000_Trade_superfile
	,rollback_2015_Trade_Payment_Totals_superfile
	,rollback_2020_Trade_Payment_Trends_superfile
	,rollback_2025_Trade_Quarterly_Averages_superfile
	,rollback_4010_Bankruptcy_superfile
	,rollback_4020_Tax_Liens_superfile
	,rollback_4030_Judgement_superfile
	,rollback_4035_Attachment_Lien_superfile
	,rollback_4040_Bulk_Transfers_superfile
	,rollback_4500_Collateral_Accounts_superfile
	,rollback_4510_UCC_Filings_superfile
	,rollback_5000_Bank_Details_superfile
	,rollback_5600_Demographic_Data_superfile
	,rollback_5610_Demographic_Data_superfile
	,rollback_6000_Inquiries_superfile
	,rollback_6500_Government_Trade_superfile
	,rollback_6510_Government_Debarred_Contractor_superfile
	,rollback_7000_SNP_Parent_Name_Address_superfile
	,rollback_7010_SNP_Data_superfile
);
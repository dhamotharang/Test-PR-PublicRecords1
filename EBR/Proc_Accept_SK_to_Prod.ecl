import ut;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Move Superkeys to QA
//////////////////////////////////////////////////////////////////////////////////////////////
ut.mac_sk_move_v2(KeyName_0010_Header_BDID,							'P', do1)
ut.mac_sk_move_v2(KeyName_0010_Header_FILE_NUMBER,					'P', do2)
ut.mac_sk_move_v2(KeyName_1000_Executive_Summary_BDID,					'P', do3)
ut.mac_sk_move_v2(KeyName_1000_Executive_Summary_FILE_NUMBER,			'P', do4)
ut.mac_sk_move_v2(KeyName_2000_Trade_BDID,							'P', do5)
ut.mac_sk_move_v2(KeyName_2000_Trade_FILE_NUMBER,						'P', do6)
ut.mac_sk_move_v2(KeyName_2015_Trade_Payment_Totals_BDID,				'P', do7)
ut.mac_sk_move_v2(KeyName_2015_Trade_Payment_Totals_FILE_NUMBER,			'P', do8)
ut.mac_sk_move_v2(KeyName_2020_Trade_Payment_Trends_BDID,				'P', do9)
ut.mac_sk_move_v2(KeyName_2020_Trade_Payment_Trends_FILE_NUMBER,			'P', do10)
ut.mac_sk_move_v2(KeyName_2025_Trade_Quarterly_Averages_BDID,			'P', do11)
ut.mac_sk_move_v2(KeyName_2025_Trade_Quarterly_Averages_FILE_NUMBER,		'P', do12)
ut.mac_sk_move_v2(KeyName_4010_Bankruptcy_BDID,						'P', do13)
ut.mac_sk_move_v2(KeyName_4010_Bankruptcy_FILE_NUMBER,					'P', do14)
ut.mac_sk_move_v2(KeyName_4020_Tax_Liens_BDID,						'P', do15)
ut.mac_sk_move_v2(KeyName_4020_Tax_Liens_FILE_NUMBER,					'P', do16)
ut.mac_sk_move_v2(KeyName_4030_Judgement_BDID,						'P', do17)
ut.mac_sk_move_v2(KeyName_4030_Judgement_FILE_NUMBER,					'P', do18)
ut.mac_sk_move_v2(KeyName_4035_Attachment_Lien_BDID,					'P', do19)
ut.mac_sk_move_v2(KeyName_4035_Attachment_Lien_FILE_NUMBER,				'P', do20)
ut.mac_sk_move_v2(KeyName_4040_Bulk_Transfers_BDID,					'P', do21)
ut.mac_sk_move_v2(KeyName_4040_Bulk_Transfers_FILE_NUMBER,				'P', do22)
ut.mac_sk_move_v2(KeyName_4500_Collateral_Accounts_BDID,				'P', do23)
ut.mac_sk_move_v2(KeyName_4500_Collateral_Accounts_FILE_NUMBER,			'P', do24)
ut.mac_sk_move_v2(KeyName_4510_UCC_Filings_BDID,						'P', do25)
ut.mac_sk_move_v2(KeyName_4510_UCC_Filings_FILE_NUMBER,				'P', do26)
ut.mac_sk_move_v2(KeyName_5000_Bank_Details_BDID,						'P', do27)
ut.mac_sk_move_v2(KeyName_5000_Bank_Details_FILE_NUMBER,				'P', do28)
ut.mac_sk_move_v2(KeyName_5600_Demographic_Data_BDID,					'P', do29)
ut.mac_sk_move_v2(KeyName_5600_Demographic_Data_FILE_NUMBER,			'P', do30)
ut.mac_sk_move_v2(KeyName_5610_Demographic_Data_BDID,					'P', do31)
ut.mac_sk_move_v2(KeyName_5610_Demographic_Data_DID,					'P', do32)
ut.mac_sk_move_v2(KeyName_5610_Demographic_Data_FILE_NUMBER,			'P', do33)
ut.mac_sk_move_v2(KeyName_5610_Demographic_Data_SSN,					'P', do34)
ut.mac_sk_move_v2(KeyName_6000_Inquiries_BDID,						'P', do35)
ut.mac_sk_move_v2(KeyName_6000_Inquiries_FILE_NUMBER,					'P', do36)
ut.mac_sk_move_v2(KeyName_6500_Government_Trade_BDID,					'P', do37)
ut.mac_sk_move_v2(KeyName_6500_Government_Trade_FILE_NUMBER,			'P', do38)
ut.mac_sk_move_v2(KeyName_6510_Government_Debarred_Contractor_BDID,		'P', do39)
ut.mac_sk_move_v2(KeyName_6510_Government_Debarred_Contractor_FILE_NUMBER,	'P', do40)
ut.mac_sk_move_v2(KeyName_7000_SNP_Parent_Name_Address_BDID,			'P', do41)
ut.mac_sk_move_v2(KeyName_7000_SNP_Parent_Name_Address_FILE_NUMBER,		'P', do42)
ut.mac_sk_move_v2(KeyName_7010_SNP_Data_BDID,						'P', do43)
ut.mac_sk_move_v2(KeyName_7010_SNP_Data_FILE_NUMBER,					'P', do44)





export Proc_Accept_SK_to_Prod := sequential(
	 do1
	,do2
	,do3
	,do4
	,do5
	,do6
	,do7
	,do8
	,do9
	,do10
	,do11
	,do12
	,do13
	,do14
	,do15
	,do16
	,do17
	,do18
	,do19
	,do20
	,do21
	,do22
	,do23
	,do24
	,do25
	,do26
	,do27
	,do28
	,do29
	,do30
	,do31
	,do32
	,do33
	,do34
	,do35
	,do36
	,do37
	,do38
	,do39
	,do40
	,do41
	,do42
	,do43
	,do44
);

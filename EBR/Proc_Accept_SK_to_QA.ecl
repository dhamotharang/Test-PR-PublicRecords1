import promotesupers, roxiekeybuild;

export Proc_Accept_SK_to_QA := function

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Move Superkeys to QA
//////////////////////////////////////////////////////////////////////////////////////////////
promotesupers.Mac_SK_Move_v2(KeyName_0010_Header_BDID,																'Q', do1)
promotesupers.Mac_SK_Move_v2(KeyName_0010_Header_FILE_NUMBER,													'Q', do2)
promotesupers.Mac_SK_Move_v2(KeyName_1000_Executive_Summary_BDID,											'Q', do3)
promotesupers.Mac_SK_Move_v2(KeyName_1000_Executive_Summary_FILE_NUMBER,							'Q', do4)
promotesupers.Mac_SK_Move_v2(KeyName_2000_Trade_BDID,																	'Q', do5)
promotesupers.Mac_SK_Move_v2(KeyName_2000_Trade_FILE_NUMBER,													'Q', do6)
promotesupers.Mac_SK_Move_v2(KeyName_2015_Trade_Payment_Totals_BDID,									'Q', do7)
promotesupers.Mac_SK_Move_v2(KeyName_2015_Trade_Payment_Totals_FILE_NUMBER,						'Q', do8)
promotesupers.Mac_SK_Move_v2(KeyName_2020_Trade_Payment_Trends_BDID,									'Q', do9)
promotesupers.Mac_SK_Move_v2(KeyName_2020_Trade_Payment_Trends_FILE_NUMBER,						'Q', do10)
promotesupers.Mac_SK_Move_v2(KeyName_2025_Trade_Quarterly_Averages_BDID,							'Q', do11)
promotesupers.Mac_SK_Move_v2(KeyName_2025_Trade_Quarterly_Averages_FILE_NUMBER,				'Q', do12)
promotesupers.Mac_SK_Move_v2(KeyName_4010_Bankruptcy_BDID,														'Q', do13)
promotesupers.Mac_SK_Move_v2(KeyName_4010_Bankruptcy_FILE_NUMBER,											'Q', do14)
promotesupers.Mac_SK_Move_v2(KeyName_4020_Tax_Liens_BDID,															'Q', do15)
promotesupers.Mac_SK_Move_v2(KeyName_4020_Tax_Liens_FILE_NUMBER,											'Q', do16)
promotesupers.Mac_SK_Move_v2(KeyName_4030_Judgement_BDID,															'Q', do17)
promotesupers.Mac_SK_Move_v2(KeyName_4030_Judgement_FILE_NUMBER,											'Q', do18)
promotesupers.Mac_SK_Move_v2(KeyName_4035_Attachment_Lien_BDID,												'Q', do19)
promotesupers.Mac_SK_Move_v2(KeyName_4035_Attachment_Lien_FILE_NUMBER,								'Q', do20)
promotesupers.Mac_SK_Move_v2(KeyName_4040_Bulk_Transfers_BDID,												'Q', do21)
promotesupers.Mac_SK_Move_v2(KeyName_4040_Bulk_Transfers_FILE_NUMBER,									'Q', do22)
promotesupers.Mac_SK_Move_v2(KeyName_4500_Collateral_Accounts_BDID,										'Q', do23)
promotesupers.Mac_SK_Move_v2(KeyName_4500_Collateral_Accounts_FILE_NUMBER,						'Q', do24)
promotesupers.Mac_SK_Move_v2(KeyName_4510_UCC_Filings_BDID,														'Q', do25)
promotesupers.Mac_SK_Move_v2(KeyName_4510_UCC_Filings_FILE_NUMBER,										'Q', do26)
promotesupers.Mac_SK_Move_v2(KeyName_5000_Bank_Details_BDID,													'Q', do27)
promotesupers.Mac_SK_Move_v2(KeyName_5000_Bank_Details_FILE_NUMBER,										'Q', do28)
promotesupers.Mac_SK_Move_v2(KeyName_5600_Demographic_Data_BDID,											'Q', do29)
promotesupers.Mac_SK_Move_v2(KeyName_5600_Demographic_Data_FILE_NUMBER,								'Q', do30)
promotesupers.Mac_SK_Move_v2(KeyName_5610_Demographic_Data_BDID,											'Q', do31)
promotesupers.Mac_SK_Move_v2(KeyName_5610_Demographic_Data_DID,												'Q', do32)
promotesupers.Mac_SK_Move_v2(KeyName_5610_Demographic_Data_FILE_NUMBER,								'Q', do33)
promotesupers.Mac_SK_Move_v2(KeyName_5610_Demographic_Data_SSN,												'Q', do34)
promotesupers.Mac_SK_Move_v2(KeyName_6000_Inquiries_BDID,															'Q', do35)
promotesupers.Mac_SK_Move_v2(KeyName_6000_Inquiries_FILE_NUMBER,											'Q', do36)
promotesupers.Mac_SK_Move_v2(KeyName_6500_Government_Trade_BDID,											'Q', do37)
promotesupers.Mac_SK_Move_v2(KeyName_6500_Government_Trade_FILE_NUMBER,								'Q', do38)
promotesupers.Mac_SK_Move_v2(KeyName_6510_Government_Debarred_Contractor_BDID,				'Q', do39)
promotesupers.Mac_SK_Move_v2(KeyName_6510_Government_Debarred_Contractor_FILE_NUMBER,	'Q', do40)
promotesupers.Mac_SK_Move_v2(KeyName_7000_SNP_Parent_Name_Address_BDID,								'Q', do41)
promotesupers.Mac_SK_Move_v2(KeyName_7000_SNP_Parent_Name_Address_FILE_NUMBER,				'Q', do42)
promotesupers.Mac_SK_Move_v2(KeyName_7010_SNP_Data_BDID,															'Q', do43)
promotesupers.Mac_SK_Move_v2(KeyName_7010_SNP_Data_FILE_NUMBER,												'Q', do44)


retval := sequential(
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
//	,do19
//	,do20
//	,do21
//	,do22
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
//	,do41
//	,do42
	,do43
	,do44
);

return retval;

end;

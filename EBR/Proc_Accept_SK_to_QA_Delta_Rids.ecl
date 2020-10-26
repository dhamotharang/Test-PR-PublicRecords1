import promotesupers, roxiekeybuild;

export Proc_Accept_SK_to_QA_Delta_Rids := function

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Move Superkeys to QA
//////////////////////////////////////////////////////////////////////////////////////////////
promotesupers.Mac_SK_Move_v2(EBR.KeyName_0010_Header_Delta_Rid,										'Q', do1)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_1000_Executive_Summary_Delta_rid,				'Q', do2)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_2000_Trade_Delta_rid,										'Q', do3)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_2015_Trade_Payment_Totals_Delta_rid,			'Q', do4)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_2020_Trade_Payment_Trends_Delta_rid,			'Q', do5)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_2025_Trade_Quarterly_Averages_Delta_rid,	'Q', do6)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_4010_Bankruptcy_Delta_rid,								'Q', do7)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_4020_Tax_Liens_Delta_rid,								'Q', do8)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_4030_Judgement_Delta_rid,								'Q', do9)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_4500_Collateral_Accounts_Delta_rid,			'Q', do10)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_4510_UCC_Filings_Delta_rid,							'Q', do11)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_5000_Bank_Details_Delta_rid,							'Q', do12)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_5600_Demographic_Data_Delta_rid,					'Q', do13)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_5610_Demographic_Data_Delta_rid,					'Q', do14)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_6000_Inquiries_Delta_rid,								'Q', do15)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_6500_Government_Trade_Delta_rid,					'Q', do16)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_6510_Government_Debarred_Delta_rid,			'Q', do17)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_7010_SNP_Data_Delta_rid,									'Q', do18)
promotesupers.Mac_SK_Move_v2(EBR.KeyName_Autokey_Delta_rid,												'Q', do19)

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
											,do19
										);

return retval;

end;
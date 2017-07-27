clear_0010_Header_superfile						:= Clear_Input_Superfile(FileName_0010_Header_In);
clear_1000_Executive_Summary_superfile				:= Clear_Input_Superfile(FileName_1000_Executive_Summary_In);
clear_2000_Trade_superfile						:= Clear_Input_Superfile(FileName_2000_Trade_In);
clear_2015_Trade_Payment_Totals_superfile			:= Clear_Input_Superfile(FileName_2015_Trade_Payment_Totals_In);
clear_2020_Trade_Payment_Trends_superfile			:= Clear_Input_Superfile(FileName_2020_Trade_Payment_Trends_In);
clear_2025_Trade_Quarterly_Averages_superfile		:= Clear_Input_Superfile(FileName_2025_Trade_Quarterly_Averages_In);
clear_4010_Bankruptcy_superfile					:= Clear_Input_Superfile(FileName_4010_Bankruptcy_In);
clear_4020_Tax_Liens_superfile					:= Clear_Input_Superfile(FileName_4020_Tax_Liens_In);
clear_4030_Judgement_superfile					:= Clear_Input_Superfile(FileName_4030_Judgement_In);
clear_4035_Attachment_Lien_superfile				:= Clear_Input_Superfile(FileName_4035_Attachment_Lien_In);
clear_4040_Bulk_Transfers_superfile				:= Clear_Input_Superfile(FileName_4040_Bulk_Transfers_In);
clear_4500_Collateral_Accounts_superfile			:= Clear_Input_Superfile(FileName_4500_Collateral_Accounts_In);
clear_4510_UCC_Filings_superfile					:= Clear_Input_Superfile(FileName_4510_UCC_Filings_In);
clear_5000_Bank_Details_superfile					:= Clear_Input_Superfile(FileName_5000_Bank_Details_In);
clear_5600_Demographic_Data_superfile				:= Clear_Input_Superfile(FileName_5600_Demographic_Data_In);
clear_5610_Demographic_Data_superfile				:= Clear_Input_Superfile(FileName_5610_Demographic_Data_In);
clear_6000_Inquiries_superfile					:= Clear_Input_Superfile(FileName_6000_Inquiries_In);
clear_6500_Government_Trade_superfile				:= Clear_Input_Superfile(FileName_6500_Government_Trade_In);
clear_6510_Government_Debarred_Contractor_superfile	:= Clear_Input_Superfile(FileName_6510_Government_Debarred_Contractor_In);
clear_7000_SNP_Parent_Name_Address_superfile			:= Clear_Input_Superfile(FileName_7000_SNP_Parent_Name_Address_In);
clear_7010_SNP_Data_superfile						:= Clear_Input_Superfile(FileName_7010_SNP_Data_In);

export Clear_All_Input_Superfiles := sequential(
	 clear_0010_Header_superfile
	,clear_1000_Executive_Summary_superfile
	,clear_2000_Trade_superfile
	,clear_2015_Trade_Payment_Totals_superfile
	,clear_2020_Trade_Payment_Trends_superfile
	,clear_2025_Trade_Quarterly_Averages_superfile
	,clear_4010_Bankruptcy_superfile
	,clear_4020_Tax_Liens_superfile
	,clear_4030_Judgement_superfile
	,clear_4035_Attachment_Lien_superfile
	,clear_4040_Bulk_Transfers_superfile
	,clear_4500_Collateral_Accounts_superfile
	,clear_4510_UCC_Filings_superfile
	,clear_5000_Bank_Details_superfile
	,clear_5600_Demographic_Data_superfile
	,clear_5610_Demographic_Data_superfile
	,clear_6000_Inquiries_superfile
	,clear_6500_Government_Trade_superfile
	,clear_6510_Government_Debarred_Contractor_superfile
	,clear_7000_SNP_Parent_Name_Address_superfile
	,clear_7010_SNP_Data_superfile
);
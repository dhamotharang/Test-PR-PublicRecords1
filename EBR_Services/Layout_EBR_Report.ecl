import ebr,EBR_Services;

export Layout_EBR_Report := 
RECORD

  EBR_Services.Layout_File_Number;
	EBR_Services.Layout_0010_Header_Base_Expanded and not[global_sid,record_sid] 	header_recs;
	dataset(EBR_Services.Layout_1000_Executive_Summary_Expanded)        executive_summary_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Executive_Summary)};
	dataset(ebr.Layout_2000_Trade_In)																		trade_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Trade)};
	dataset(ebr.Layout_2015_Trade_Payment_Totals_In)										trade_payment_total_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Trade_Payment_Totals)};
	dataset(ebr.Layout_2020_Trade_Payment_Trends_Base and not[global_sid,record_sid])									trade_payment_trend_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Trade_Payment_Trends)};
	dataset(ebr.Layout_2025_Trade_Quarterly_Averages_Base and not[global_sid,record_sid])							trade_quarterly_average_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Trade_Quarterly_Averages)};
	dataset(ebr.Layout_4010_Bankruptcy_In)															bankruptcy_recs {MAXCOUNT(EBR_Services.constants.maxcounts.public_records)};
	dataset(ebr.Layout_4020_Tax_Liens_In)																tax_lien_recs {MAXCOUNT(EBR_Services.constants.maxcounts.public_records)};
	dataset(ebr.Layout_4030_Judgement_In)																judgment_recs {MAXCOUNT(EBR_Services.constants.maxcounts.public_records)};
	dataset(ebr.Layout_4500_Collateral_Accounts_In)											collateral_account_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Collateral_Accounts)};
	dataset(ebr.Layout_4510_UCC_Filings_In)															ucc_filing_recs {MAXCOUNT(EBR_Services.constants.maxcounts.public_records)};
	dataset(EBR_Services.Layout_5000_Bank_Details_Expanded)							bank_detail_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Bank_Details)};
	dataset(EBR_Services.Layouts.demographic_5600_output_Rec)		   			demographic_data_5600_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Demographic_Data)};
	dataset(ebr.Layout_5610_demographic_data_Out and not[global_sid,record_sid])												demographic_data_5610_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Demographic_Data)};
	dataset(EBR_Services.Layout_6000_Inquiries_Base_Rolled.top_level)		inquiry_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Inquiry_counts)};
	dataset(ebr.Layout_6500_Government_Trade_In)												government_trade_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Government_Trade)};
	dataset(EBR_Services.Layout_6510_Government_Debarred_Contractor_Expanded)	government_debarred_contractor_recs {MAXCOUNT(EBR_Services.constants.maxcounts.Government_Debarred_Contractor)};
	dataset(ebr.Layout_7010_SNP_Data_In)																snp_data_recs {MAXCOUNT(EBR_Services.constants.maxcounts.SNP_Data)};

END;
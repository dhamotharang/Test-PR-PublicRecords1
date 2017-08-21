//////////////////////////////////////////////////////////////////////////////////////////////
// -- Table of current Experian Business 0010_Header segment codes
//////////////////////////////////////////////////////////////////////////////////////////////
Segment_Codes_temp := DATASET([
{'0010', '', sizeof(Layout_0010_Header_In),						sizeof(Layout_0010_Header_Base)},
{'1000', '', sizeof(Layout_1000_Executive_Summary_In), 			sizeof(Layout_1000_Executive_Summary_Base)},
{'2000', '', sizeof(Layout_2000_Trade_In),						sizeof(Layout_2000_Trade_Base)},
{'2010', ''},
{'2015', '', sizeof(Layout_2015_Trade_Payment_Totals_In),			sizeof(Layout_2015_Trade_Payment_Totals_Base)},
{'2020', '', sizeof(Layout_2020_Trade_Payment_Trends_In),			sizeof(Layout_2020_Trade_Payment_Trends_Base)},
{'2025', '', sizeof(Layout_2025_Trade_Quarterly_Averages_In),		sizeof(Layout_2025_Trade_Quarterly_Averages_Base)},
{'4010', '', sizeof(Layout_4010_Bankruptcy_In),					sizeof(Layout_4010_Bankruptcy_Base)},
{'4020', '', sizeof(Layout_4020_Tax_Liens_In),					sizeof(Layout_4020_Tax_Liens_Base)},
{'4030', '', sizeof(Layout_4030_Judgement_In),					sizeof(Layout_4030_Judgement_Base)},
{'4035', '', sizeof(Layout_4035_Attachment_Lien_In),				sizeof(Layout_4035_Attachment_Lien_Base)},
{'4040', '', sizeof(Layout_4040_Bulk_Transfers_In),				sizeof(Layout_4040_Bulk_Transfers_Base)},
{'4500', '', sizeof(Layout_4500_Collateral_Accounts_In),			sizeof(Layout_4500_Collateral_Accounts_Base)},
{'4510', '', sizeof(Layout_4510_UCC_Filings_In),					sizeof(Layout_4510_UCC_Filings_Base)},
{'5000', '', sizeof(Layout_5000_Bank_Details_In),					sizeof(Layout_5000_Bank_Details_Base)},
{'5600', '', sizeof(Layout_5600_Demographic_Data_In),				sizeof(Layout_5600_Demographic_Data_Base)},
{'5610', '', sizeof(Layout_5610_Demographic_Data_In),				sizeof(Layout_5610_Demographic_Data_Base)},
{'6000', '', sizeof(Layout_6000_Inquiries_In),					sizeof(Layout_6000_Inquiries_Base)},
{'6500', '', sizeof(Layout_6500_Government_Trade_In),				sizeof(Layout_6500_Government_Trade_Base)},
{'6510', '', sizeof(Layout_6510_Government_Debarred_Contractor_In),	sizeof(Layout_6510_Government_Debarred_Contractor_Base)},
{'7000', '', sizeof(Layout_7000_SNP_Parent_Name_Address_In),		sizeof(Layout_7000_SNP_Parent_Name_Address_Base)},
{'7010', '', sizeof(Layout_7010_SNP_Data_In),					sizeof(Layout_7010_SNP_Data_Base)}
], Layout_Segment_Codes);

Layout_Segment_Codes getfilenames(Segment_Codes_temp l) := 
transform
	self.code 			:= l.code;
	self.description		:= decode_segments(l.code);
	self.filename_in 		:= GetSegmentFileName_In(l.code);
	self.filename_base 		:= getSegmentFileName_Base(l.code);
	self.keyname_bdid 		:= GetSegmentKeyName_BDID(l.code);
	self.keyname_file_number	:= GetSegmentKeyName_FILE_NUMBER(l.code);
	self := l;
end;

export Segment_Codes := project(Segment_Codes_temp, getfilenames(left));// : persist(EBR_Thor + 'TEMP::' + dataset_name + '_Segment_Codes');
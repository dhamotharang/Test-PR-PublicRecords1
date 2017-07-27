export GetSegmentFile_Base(segcode, outfile) := macro
#if('0010' = segcode)
	outfile := ebr.File_0010_Header_Base;
#end
#if('1000' = segcode)
	outfile := ebr.File_1000_Executive_Summary_Base;
#end
#if('2000' = segcode)
	outfile := ebr.File_2000_Trade_Base;
#end
//#if('2010' = segcode)
//	outfile := ebr.File_2010_Trade_Base;
//#end
#if('2015' = segcode)
	outfile := ebr.File_2015_Trade_Payment_Totals_Base;
#end
#if('2020' = segcode)
	outfile := ebr.File_2020_Trade_Payment_Trends_Base;
#end
#if('2025' = segcode)
	outfile := ebr.File_2025_Trade_Quarterly_Averages_Base;
#end
#if('4010' = segcode)
	outfile := ebr.File_4010_Bankruptcy_Base;
#end
#if('4020' = segcode)
	outfile := ebr.File_4020_Tax_Liens_Base;
#end
#if('4030' = segcode)
	outfile := ebr.File_4030_Judgement_Base;
#end
#if('4035' = segcode)
	outfile := ebr.File_4035_Attachment_Lien_Base;
#end
#if('4040' = segcode)
	outfile := ebr.File_4040_Bulk_Transfers_Base;
#end
#if('4500' = segcode)
	outfile := ebr.File_4500_Collateral_Accounts_Base;
#end
#if('4510' = segcode)
	outfile := ebr.File_4510_UCC_Filings_Base;
#end
#if('5000' = segcode)
	outfile := ebr.File_5000_Bank_Details_Base;
#end
#if('5600' = segcode)
	outfile := ebr.File_5600_Demographic_Data_Base;
#end
#if('5610' = segcode)
	outfile := ebr.File_5610_Demographic_Data_Base;
#end
#if('6000' = segcode)
	outfile := ebr.File_6000_Inquiries_Base;
#end
#if('6500' = segcode)
	outfile := ebr.File_6500_Government_Trade_Base;
#end
#if('6510' = segcode)
	outfile := ebr.File_6510_Government_Debarred_Contractor_Base;
#end
#if('7000' = segcode)
	outfile := ebr.File_7000_SNP_Parent_Name_Address_Base;
#end
#if('7010' = segcode)
	outfile := ebr.File_7010_SNP_Data_Base;
#end
endmacro;
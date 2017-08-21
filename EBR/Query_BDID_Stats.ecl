
//////////////////////////////////////////////////////////////////////////////////////////////
// -- Do all stats
//////////////////////////////////////////////////////////////////////////////////////////////
Output_Segment_Stats('0010',header_segment_stats);
Output_Segment_Stats('1000',executive_summary_segment_stats);
Output_Segment_Stats('2000',trade1_segment_stats);
Output_Segment_Stats('2015',Trade_Payment_Totals_segment_stats);
Output_Segment_Stats('2020',Trade_Payment_Trends_segment_stats);
Output_Segment_Stats('2025',Trade_Quarterly_Averages_segment_stats);
Output_Segment_Stats('4010',Bankruptcy_segment_stats);
Output_Segment_Stats('4020',Tax_Liens_segment_stats);
Output_Segment_Stats('4030',Judgement_segment_stats);
Output_Segment_Stats('4035',Attachment_Lien_segment_stats);
Output_Segment_Stats('4040',Bulk_Transfers_segment_stats);
Output_Segment_Stats('4500',Collateral_Accounts_segment_stats);
Output_Segment_Stats('4510',UCC_Filings_segment_stats);
Output_Segment_Stats('5000',Bank_Details_segment_stats);
Output_Segment_Stats('5600',Demographic_Data1_segment_stats);
Output_Segment_Stats('5610',Demographic_Data2_segment_stats);
Output_Segment_Stats('6000',Inquiries_segment_stats);
Output_Segment_Stats('6500',Government_Trade_segment_stats);
Output_Segment_Stats('6510',Government_Debarred_Contractor_segment_stats);
Output_Segment_Stats('7000',SNP_Parent_Name_Address_segment_stats);
Output_Segment_Stats('7010',SNP_Data_segment_stats);

export Query_BDID_Stats := output(
	  header_segment_stats
	+ executive_summary_segment_stats
	+ trade1_segment_stats
	+ Trade_Payment_Totals_segment_stats
	+ Trade_Payment_Trends_segment_stats
	+ Trade_Quarterly_Averages_segment_stats
	+ Bankruptcy_segment_stats
	+ Tax_Liens_segment_stats
	+ Judgement_segment_stats
//	+ Attachment_Lien_segment_stats
//	+ Bulk_Transfers_segment_stats
	+ Collateral_Accounts_segment_stats
	+ UCC_Filings_segment_stats
	+ Bank_Details_segment_stats
	+ Demographic_Data1_segment_stats
	+ Demographic_Data2_segment_stats
	+ Inquiries_segment_stats
	+ Government_Trade_segment_stats
	+ Government_Debarred_Contractor_segment_stats
//	+ SNP_Parent_Name_Address_segment_stats
	+ SNP_Data_segment_stats
, named('EBR_Counts'),all);
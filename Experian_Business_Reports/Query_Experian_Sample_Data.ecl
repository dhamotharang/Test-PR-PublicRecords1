#option('outputLimit', 100);
#workunit('name', 'Experian Business Sample Data');

// Create a sample of Experian Business Reports with Trade Data
fheader := Experian_Business_Reports.File_Header_Records_In;

layout_header_slim := record
fheader.FILE_NUMBER;
fheader.COMPANY_NAME;
fheader.STREET_ADDRESS;
fheader.CITY;
fheader.STATE_CODE;
fheader.ZIP;
end;

fheader_slim := table(fheader, layout_header_slim);
fheader_slim_dedup := dedup(fheader_slim, FILE_NUMBER, all);

fheader_sample := enth(fheader_slim_dedup, 100);

// output header records
header_records := join(fheader,
                       fheader_sample,
				   left.FILE_NUMBER = right.FILE_NUMBER,
				   transform(Experian_Business_Reports.Layout_Header_Records_In, self := left),
				   lookup);
				   
output(sort(header_records, FILE_NUMBER), named('Header'), all);

// output executive summary data
layout_executive_summary_data := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Executive_Summary_1000_In;
end;

executive_summary_records := join(Experian_Business_Reports.File_Executive_Summary_1000_In,
                                  fheader_sample,
				              left.FILE_NUMBER = right.FILE_NUMBER,
				              transform(layout_executive_summary_data, self := right, self := left),
				              lookup);
					   
output(sort(executive_summary_records, FILE_NUMBER), named('Executive_Summary'), all);

// output trade data
layout_trade_data := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Trade_Data_2000_In;
end;

trade_records := join(Experian_Business_Reports.File_Trade_Data_2000_In + Experian_Business_Reports.File_Trade_Data_2010_In,
                      fheader_sample,
				  left.FILE_NUMBER = right.FILE_NUMBER,
				  transform(layout_trade_data, self := right, self := left),
				  lookup);
					   
output(sort(trade_records, FILE_NUMBER, SEGMENT_CODE), named('Trade_Data'), all);

// output government trade data
layout_government_trade_data := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Government_Trade_Data_6500_In;
end;

government_trade_records := join(Experian_Business_Reports.File_Government_Trade_Data_6500_In,
                                 fheader_sample,
				             left.FILE_NUMBER = right.FILE_NUMBER,
				             transform(layout_government_trade_data, self := right, self := left),
				             lookup);
					   
output(sort(government_trade_records, FILE_NUMBER, SEGMENT_CODE), named('Govt_Trade_Data'), all);

// output trade payment totals
layout_trade_payment_totals := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Trade_Payment_Totals_2015_In;
end;

trade_payment_totals_records := join(Experian_Business_Reports.File_Trade_Payment_Totals_2015_In,
                                     fheader_sample,
				                 left.FILE_NUMBER = right.FILE_NUMBER,
				                 transform(layout_trade_payment_totals, self := right, self := left),
				                 lookup);
					   
output(sort(trade_payment_totals_records, FILE_NUMBER), named('Trade_Payment_Totals'), all);

// output trade payment trends
layout_trade_payment_trends := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Trade_Payment_Trends_2020_In;
end;

trade_payment_trends_records := join(Experian_Business_Reports.File_Trade_Payment_Trends_2020_In,
                                     fheader_sample,
				                 left.FILE_NUMBER = right.FILE_NUMBER,
				                 transform(layout_trade_payment_trends, self := right, self := left),
				                 lookup);
					   
output(sort(trade_payment_trends_records, FILE_NUMBER), named('Trade_Payment_Trends'), all);

// output trade quarterly averages
layout_trade_quarterly_averages := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Trade_Quarterly_Avg_2025_In;
end;

trade_quarterly_averages_records := join(Experian_Business_Reports.File_Trade_Quarterly_Avg_2025_In,
                                         fheader_sample,
				                     left.FILE_NUMBER = right.FILE_NUMBER,
				                     transform(layout_trade_quarterly_averages, self := right, self := left),
				                     lookup);
					   
output(sort(trade_quarterly_averages_records, FILE_NUMBER), named('Trade_Quarterly_Averages'), all);

// output bankruptcy data
layout_bankruptcy_4010 := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Bankrupcty_4010_In;
end;

bankruptcy_records := join(Experian_Business_Reports.File_Bankruptcy_4010_In,
                           fheader_sample,
				       left.FILE_NUMBER = right.FILE_NUMBER,
				        transform(layout_bankruptcy_4010, self := right, self := left),
				        lookup);

output(sort(bankruptcy_records, FILE_NUMBER), named('Bankruptcy'), all);

// output tax liens data
layout_tax_liens := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Tax_Liens_4020_In;
end;

tax_liens_records := join(Experian_Business_Reports.File_Tax_Liens_4020_In,
                          fheader_sample,
				      left.FILE_NUMBER = right.FILE_NUMBER,
				      transform(layout_tax_liens, self := right, self := left),
				      lookup);

output(sort(tax_liens_records, FILE_NUMBER), named('Tax_Liens'), all);

// output judgment data
layout_judgment_4030 := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Judgment_4030_In;
end;

judgment_records := join(Experian_Business_Reports.File_Judgment_4030_In,
                         fheader_sample,
				     left.FILE_NUMBER = right.FILE_NUMBER,
				     transform(layout_judgment_4030, self := right, self := left),
				     lookup);

output(sort(judgment_records, FILE_NUMBER), named('Judgment'), all);

// output UCC Counts data
layout_ucc_counts_4500 := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_UCC_Counts_4500_In;
end;

ucc_counts_records := join(Experian_Business_Reports.File_UCC_Counts_4500_In,
                           fheader_sample,
				       left.FILE_NUMBER = right.FILE_NUMBER,
				       transform(layout_ucc_counts_4500, self := right, self := left),
				       lookup);

output(sort(ucc_counts_records, FILE_NUMBER), named('UCC_Counts'), all);

// output UCC Filings data
layout_ucc_filings_4510 := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_UCC_Filings_4510_In;
end;

ucc_filings_records := join(Experian_Business_Reports.File_UCC_Filings_4510_In,
                            fheader_sample,
				        left.FILE_NUMBER = right.FILE_NUMBER,
				        transform(layout_ucc_filings_4510, self := right, self := left),
				        lookup);

output(sort(ucc_filings_records, FILE_NUMBER), named('UCC_Filings'), all);

// output Bank Details Data
layout_bank_details_data := record
string40 HEADER_COMPANY_NAME;
string30 HEADER_STREET_ADDRESS;
string28 HEADER_CITY;
string2  HEADER_STATE_CODE;
string5  HEADER_ZIP;
Experian_Business_Reports.Layout_Bank_Details_5000_In;
end;

bank_details_records := join(Experian_Business_Reports.File_Bank_Details_5000_In,
                             fheader_sample,
				         left.FILE_NUMBER = right.FILE_NUMBER,
				         transform(layout_bank_details_data,
					      self.HEADER_COMPANY_NAME := right.COMPANY_NAME,
						 self.HEADER_STREET_ADDRESS := right.STREET_ADDRESS,
						 self.HEADER_CITY := right.CITY,
						 self.HEADER_STATE_CODE := right.STATE_CODE,
						 self.HEADER_ZIP := right.ZIP,
						 self := left),
				         lookup);
					   
output(sort(bank_details_records, FILE_NUMBER), named('Bank_Details'), all);

// output demographic data
layout_demographic_data_5600 := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Demographic_Data_5600_In;
end;

demographic_records_5600 := join(Experian_Business_Reports.File_Demographic_Data_5600_In,
                            fheader_sample,
				        left.FILE_NUMBER = right.FILE_NUMBER,
				        transform(layout_demographic_data_5600, self := right, self := left),
				        lookup);
					   
output(sort(demographic_records_5600, FILE_NUMBER), named('Demographic_5600'), all);
				   
// output demographic data
layout_demographic_data_5610 := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Demographic_Data_5610_In;
end;

demographic_records_5610 := join(Experian_Business_Reports.File_Demographic_Data_5610_In,
                            fheader_sample,
				        left.FILE_NUMBER = right.FILE_NUMBER,
				        transform(layout_demographic_data_5610, self := right, self := left),
				        lookup);
					   
output(sort(demographic_records_5610, FILE_NUMBER), named('Demographic_5610'), all);

// output inquiries data
layout_inquiries_6000 := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Inquiries_6000_In;
end;

inquiries_records := join(Experian_Business_Reports.File_Inquiries_6000_In,
                          fheader_sample,
				      left.FILE_NUMBER = right.FILE_NUMBER,
				      transform(layout_inquiries_6000, self := right, self := left),
				      lookup);
					   
output(sort(inquiries_records, FILE_NUMBER), named('Inquiries'), all);

// output S&P Parent Data
layout_s_and_p_parent_data_7000 := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_S_and_P_Parent_Name_and_Address_In;
end;

parent_records := join(Experian_Business_Reports.File_S_and_P_Parent_Name_and_Address_In,
                       fheader_sample,
				   left.FILE_NUMBER = right.FILE_NUMBER,
				   transform(layout_s_and_p_parent_data_7000, self := right, self := left),
				   lookup);
					   
output(sort(parent_records, FILE_NUMBER), named('S_and_P_Parent_Name_and_Address'), all);

// output S&P  Data
layout_s_and_p_data_7010 := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_S_and_P_Data_7010_In;
end;

s_and_p_data__records := join(Experian_Business_Reports.File_S_and_P_Data_7010_In,
                              fheader_sample,
				          left.FILE_NUMBER = right.FILE_NUMBER,
				          transform(layout_s_and_p_data_7010, self := right, self := left),
				          lookup);
					   
output(sort(s_and_p_data__records, FILE_NUMBER), named('S_and_P_Data'), all);

// output attachment lien data
layout_attachment_lien_4035 := record
string40 COMPANY_NAME;
string30 STREET_ADDRESS;
string28 CITY;
string2 STATE_CODE;
string5 ZIP;
Experian_Business_Reports.Layout_Attachment_Lien_4035_In;
end;

attachment_lien_records := join(Experian_Business_Reports.File_Attachment_Lien_4035_In,
                                fheader_sample,
				            left.FILE_NUMBER = right.FILE_NUMBER,
				            transform(layout_attachment_lien_4035, self := right, self := left),
				            lookup);
					   
output(sort(attachment_lien_records, FILE_NUMBER), named('Attachment_Liens'), all);

﻿import EBR, BIPV2;

EXPORT Layouts := module
//Incoming Layouts	
  export In_0010_Header := record
		EBR.Layout_0010_Header_Base_slim - [global_sid, record_sid];
		string50     cust_name;
		string10			bug_name;
		string9       link_FEIN;
		string8       link_inc_date;
		
	 end;
	
	
	export In_5600_Demographic := record
		EBR.Layout_5600_demographic_data_Base_slim - [global_sid, record_sid];
		string50     cust_name;
		string10		 bug_name;
		string9      link_FEIN;
		string       link_inc_date;
	end; 
	 

	export IN_5610_Demographic := record
    string10	FILE_NUMBER;	
		EBR.Layout_5610_demographic_data_Base_slim - [file_number, global_sid, record_sid];
		string50  cust_name;
		string10	bug_name;
		string8   link_dob;
		string9   link_ssn;
		string9   link_FEIN;
		string8   link_inc_date;
	end;	

	
//Base Layouts	 
	export File_0010_Header := record
		EBR.Layout_0010_Header_Base_AID;
		string50     cust_name;
		string10			bug_name;
		string9       link_FEIN;
		string8       link_inc_date;
	end;
	
	export File_5600_Demographic := record
		EBR.Layout_5600_Demographic_Data_Base;
		string50     cust_name;
		string10		 bug_name;
		string9      link_FEIN;
		string       link_inc_date;
	end;
	
	export File_5610_Demographic := record
		EBR.Layout_5610_demographic_data_Base;
		string50  cust_name;
		string10	bug_name;
		string8   link_dob;
		string9   link_ssn;
		string9   link_FEIN;
		string8   link_inc_date;
	end;
	
	
	export File_1000_Executive_Summary := record
		EBR.Layout_1000_Executive_Summary_Base;
		string10 cust_name;
    string bug_num;
    string9 link_ssn;
    string8 link_dob;
    string9 link_fein;
    string8 link_inc_date;
	end;
	
	export File_2000_Trade := record
		EBR.Layout_2000_Trade_Base;
	end;
	
	export File_2015_Trade_Payment_Totals := record
		EBR.Layout_2015_Trade_Payment_Totals_Base;
		string cust_name;
    string bug_num;
    string9 link_ssn;
    string8 link_dob;
		string9 link_fein;
	end;
	
	export File_2020_Trade_Payment_Trends := record
		EBR.Layout_2020_Trade_Payment_Trends_Base;
	end;
	
	export File_2025_Trade_Quarterly_Averages := record
		EBR.Layout_2025_Trade_Quarterly_Averages_Base;
	end;
	
	export File_4010_Bankruptcy := record
		EBR.Layout_4010_Bankruptcy_Base;
	end;
	
	export File_4020_Tax_Liens := record
		EBR.Layout_4020_Tax_Liens_Base;
	end;
	
	export File_4030_Judgment := record
		EBR.Layout_4030_Judgement_Base;
	end;
	
	export File_4035_Attachment_Lien := record
		EBR.Layout_4035_Attachment_Lien_Base;
	end;
	
	export File_4040_Bulk_Transfers	:= record
		EBR.Layout_4040_Bulk_Transfers_Base;
	end;
	
	export File_4500_Collateral_Accounts := record
		EBR.Layout_4500_Collateral_Accounts_Base;
	end;
	
	export File_4510_UCC_Filings := record
		EBR.Layout_4510_UCC_Filings_Base;
	end;
	
	export File_5000_Bank_Details	:= record
		EBR.Layout_5000_Bank_Details_Base;
	end;
	
	export File_6000_Inquires	:= record
		EBR.Layout_6000_Inquiries_Base;
	end;
	
	export File_6500_Government_Trade := record
		EBR.Layout_6500_Government_Trade_Base;
	end;
	
	export File_6510_Government_Debarred_Contractor := record
		EBR.Layout_6510_Government_Debarred_Contractor_Base;
	end;
	
	export File_7000_SNP :=record
		EBR.Layout_7000_SNP_Parent_Name_Address_Base;
	end;
	
	export File_7010_SNP_DATA	:= record
		EBR.Layout_7010_SNP_Data_Base;
	end;
	

//Key Layouts 
	export Slim_0010_Header_Base := record
		EBR.Layout_0010_Header_Base;
	end;
	
	export Slim_5600_demographic_data_Base := record
		EBR.Layout_5600_demographic_data_Base_slim;
	end;
	
	export Slim_5610_Demographic_Data_Base := record
		EBR.Layout_5610_Demographic_Data_Base_slim;
	end;
	
	export Slim_1000_executive_summary_base := record
		EBR.layout_1000_executive_summary_base_slim;
	end; 
	
	export Slim_2000_Trade_Base := record
		EBR.Layout_2000_Trade_Base_slim;
		end;
	
 export Slim_2015_Trade_Payment_Totals_Base := record
		EBR.Layout_2015_Trade_Payment_Totals_Base_slim;
		end;
	
	export Slim_2020_Trade_Payment_Trends_Base := record
		EBR.Layout_2020_Trade_Payment_Trends_Base_slim;
		end;
		
	export Slim_2025_Trade_Quarterly_Averages_Base := record
		EBR.Layout_2025_Trade_Quarterly_Averages_Base_slim;
	end;
	
	export Slim_4010_Bankruptcy_Base := record
		EBR.Layout_4010_Bankruptcy_Base_slim;
	end;
	
	export Slim_4020_Tax_Liens_Base := record
		EBR.Layout_4020_Tax_Liens_Base_slim;
	end;
	
	export Slim_4030_Judgement_Base := record
		EBR.Layout_4030_Judgement_Base_slim;
	end;
	
	export Slim_4500_Collateral_Accounts_Base := record
		EBR.Layout_4500_Collateral_Accounts_Base_slim;
	end;
	
	export Slim_4510_UCC_Filings_Base := record
		EBR.Layout_4510_UCC_Filings_Base_slim;
	end;
	
	export Slim_5000_Bank_Details_Base := record
		EBR.Layout_5000_Bank_Details_Base_slim;
	end;
	
	
	export Slim_6000_Inquiries_Base := record
		EBR.Layout_6000_Inquiries_Base_slim;
	end;
	
	export Slim_6500_Government_Trade_Base := record
		EBR.Layout_6500_Government_Trade_Base_slim;
		end;
		
	export Slim_6510_Government_Debarred_Contractor_Base := record
		EBR.Layout_6510_Government_Debarred_Contractor_Base_slim;
	end;
	
	export Slim_7010_SNP_Data_Base := record
		EBR.Layout_7010_SNP_Data_Base_slim;
	end; 
	
	export autokey :=record
		EBR.layout_0010_header_base_slim;
		string28 business_city;
		string5 business_zip;
		unsigned1 zero;
		string1 zero1;
		string1 zero2;
		string1 zero3;
		string1 zero4;
		string1 zero5;
		string1 zero6;
		unsigned5 business_phone_number;
		BIPV2.IDlayouts.l_xlink_ids;
end;

Export Executive_In:=Record
unsigned6 BDID;
string8 date_first_seen;
string8 date_last_seen;
unsigned4 process_date_first_seen;
unsigned4 process_date_last_seen;
string record_type;
   string8     process_date;
   string10    FILE_NUMBER;
   string4     SEGMENT_CODE;
   string5     SEQUENCE_NUMBER;
   string3     CURRENT_DBT;
   string3     PREDICTED_DBT;
   string3     CONF_PERCENT;
   string1     CONF_SLOPE;
   string6     orig_PREDICTED_DBT_DATE_MMDDYY;
   string3     AVERAGE_INDUSTRY_DBT;
   string3     AVERAGE_ALL_INDUSTRIES_DBT;
   string8     LOW_BALANCE;
   string8     HIGH_BALANCE;
   string8     CURRENT_ACCOUNT_BALANCE;
   string8     HIGH_CREDIT_EXTENDED;
   string8     MEDIAN_CREDIT_EXTENDED;
   string1     PAYMENT_PERFORMANCE;
   string1     PAYMENT_TREND;
   string20    INDUSTRY_DESCRIPTION;
   string8     predicted_dbt_date;
   string1     lf;
string10 cust_name;
string bug_num;
string9 link_ssn;
string8 link_dob;
string9 link_fein;
string8 link_inc_date;
End;

Export Trade_Pay_Tot_In:=Record
unsigned6 bdid;
string date_first_seen;
string date_last_seen;
unsigned4 process_date_first_seen;
unsigned4 process_date_last_seen;
string record_type;
string8 process_date;
   string10 FILE_NUMBER;
   string4 SEGMENT_CODE;
   string5 SEQUENCE_NUMBER;
   string3 TRADE_COUNT1;
   string3 DEBT1;
   string1 HIGH_CREDIT_MASK1;
   string8 RECENT_HIGH_CREDIT1;
   string1 ACCOUNT_BALANCE_MASK1;
   string8 MASKED_ACCOUNT_BALANCE1;
   string3 CURRENT_BALANCE_PERCENT1;
   string3 DEBT_01_30_PERCENT1;
   string3 DEBT_31_60_PERCENT1;
   string3 DEBT_61_90_PERCENT1;
   string3 DEBT_91_PLUS_PERCENT1;
   string3 TRADE_COUNT2;
   string3 DEBT2;
   string1 HIGH_CREDIT_MASK2;
   string8 RECENT_HIGH_CREDIT2;
   string1 ACCOUNT_BALANCE_MASK2;
   string8 MASKED_ACCOUNT_BALANCE2;
   string3 CURRENT_BALANCE_PERCENT2;
   string3 DEBT_01_30_PERCENT2;
   string3 DEBT_31_60_PERCENT2;
   string3 DEBT_61_90_PERCENT2;
   string3 DEBT_91_PLUS_PERCENT2;
   string3 TRADE_COUNT3;
   string3 DEBT3;
   string1 HIGH_CREDIT_MASK3;
   string8 RECENT_HIGH_CREDIT3;
   string1 ACCOUNT_BALANCE_MASK3;
   string8 MASKED_ACCOUNT_BALANCE3;
   string3 CURRENT_BALANCE_PERCENT3;
   string3 DEBT_01_30_PERCENT3;
   string3 DEBT_31_60_PERCENT3;
   string3 DEBT_61_90_PERCENT3;
   string3 DEBT_91_PLUS_PERCENT3;
   string8 HIGHEST_CREDIT_MEDIAN;
   string8 orig_ACCOUNT_BALANCE_REGULAR_TRADELINES;
   string8 orig_ACCOUNT_BALANCE_NEW;
   string8 orig_ACCOUNT_BALANCE_COMBINED;
   string3 AGED_TRADES_COUNT;
   string8 account_balance_regular_tradelines;
   string8 account_balance_new;
   string8 account_balance_combined;
   string1 lf;
string cust_name;
string bug_num;
string9 link_ssn;
string8 link_dob;
string9 link_fein;
End;
	
end;
	
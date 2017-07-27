import Autokey_batch;
export Firmographics_BatchService_Layouts := module

	export layout_batch_in := record
		Autokey_batch.Layouts.rec_inBatchMaster  -date -sic_code -filing_number -apn
		                                          -fips_code -score_bdid
		                                          -name_first -name_middle -name_last -name_suffix
																							-ssn -dob   -dl  -dlstate
																							 -vin -plate -plateState
																							 -searchType  -max_results  -Did  -score  -matchCode;																																									
	end;
	
	export rec_results_raw := record
	   string30   acctno;
		 STRING120  companyName;
	   unsigned6  phone;
		 string39   Fax;
		 unsigned4  yearStarted;
		 unsigned2  yearsInBusiness;
		 string105  parentCompanyName;
		 string85   URL;
		 unsigned4  fein;
		 string11   TickerSymbol;
		 unsigned6  Sales;
		 string12   NetWorth;		 
		 string9    numEmployees;
	end;

  export layout_batch_out := record
	   string30   acctno;
		  
		 STRING120  companyName_1;
		 unsigned6  phone_1;
		 string39   fax_1;
		 unsigned4  yearStarted_1;
		 unsigned2  yearsInBusiness_1;
		 string105  parentCompanyName_1;
		 string85   URL_1;
		 unsigned4  fein_1;
		 string11   TickerSymbol_1;
		 unsigned6  Sales_1;
		 string12   NetWorth_1;
		 string9    NumEmployees_1;
		 
		 STRING120  companyName_2;
		 unsigned6  phone_2;
		 string39   fax_2;
		 unsigned4  yearStarted_2;
		 unsigned2  yearsInBusiness_2;
		 string105  parentCompanyName_2;
		 string85   URL_2;
		 unsigned4  fein_2;
		 string11   TickerSymbol_2;
		 unsigned6  Sales_2;
		 string12   NetWorth_2;		
		 string9    NumEmployees_2;
		 
		 STRING120  companyName_3;
		 unsigned6  phone_3;
		 string39   fax_3;
		 unsigned4  yearStarted_3;
		 unsigned2  yearsInBusiness_3;
		 string105  parentCompanyName_3;
		 string85   URL_3;
		 unsigned4  fein_3;
		 string11   TickerSymbol_3;
		 unsigned6  Sales_3;
		 string12   NetWorth_3;		
		 string9    NumEmployees_3;
		 
		 STRING120  companyName_4;
		 unsigned6  phone_4;
		 string39   fax_4;
		 unsigned4  yearStarted_4;
		 unsigned2  yearsInBusiness_4;
		 string105  parentCompanyName_4;
		 string85   URL_4;
		 unsigned4  fein_4;
		 string11   TickerSymbol_4;
		 unsigned6  Sales_4;
		 string12   NetWorth_4;		
		 string9    NumEmployees_4;
		 
     STRING120  companyName_5;		 
		 unsigned6  phone_5;
		 string39   fax_5;
		 unsigned4  yearStarted_5;
		 unsigned2  yearsInBusiness_5;
		 string105  parentCompanyName_5;
		 string85   URL_5;
		 unsigned4  fein_5;
		 string11   TickerSymbol_5;
		 unsigned6  Sales_5;
		 string12   NetWorth_5;		 				 
		 string9    NumEmployees_5;
		 
		 STRING120  companyName_6;
		 unsigned6  phone_6;
		 string39   fax_6;
		 unsigned4  yearStarted_6;
		 unsigned2  yearsInBusiness_6;
		 string105  parentCompanyName_6;
		 string85   URL_6;
		 unsigned4  fein_6;
		 string11   TickerSymbol_6;
		 unsigned6  Sales_6;
		 string12   NetWorth_6;		 				 
		 string9    NumEmployees_6;
	   		 
	end;
end;
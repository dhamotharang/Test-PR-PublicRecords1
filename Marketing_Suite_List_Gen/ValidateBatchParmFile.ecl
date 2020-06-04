import Marketing_Suite_List_Gen, STD, ut;

export ValidateBatchParmFile(
															dataset(Marketing_Suite_List_Gen.Layouts.Layout_ParmFile)	inParmFile,
															string	JobID
														 )	:= function

  /*----------------------------------------------------------------------------------------------------------------------
  | This function will take the parameter file we are receiving from batch and validate it to make sure that 
	|	the structure of the file is as expected as well as some values being passed to us. 	
  |----------------------------------------------------------------------------------------------------------------------*/ 
	
	//	input parameter file layout
  Layout_ParmFile          											:= Marketing_Suite_List_Gen.Layouts.Layout_ParmFile;
	
	//	validated parameter file layout
  Layout_Valid_ParmFile    											:= Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile;
 
  /*---------------------------------------------------------------------------------------------------------------------------: attributes
  |	These are the current parameter keywords in the parameter file. We expect 1 parameter per line. If multiple values 
	|	are being passed in, they will be separated by a comma.
  |--------------------------------------------------------------------------------------------------------------------------------------*/
	string ParmFilterType_Location								:= 'SEARCHTYPE';
  string ParmFilterName_PhonePresent   					:= 'PHONEPRESENT';
	string ParmFilterName_PhoneTollFree			  		:= 'TOLLFREE';	
	string ParmFilterName_PhoneAreaCode						:= 'AREACODE';	
	string ParmFilterName_GeoState   							:= 'STATE';	
	string ParmFilterName_GeoStateCounty  				:= 'STATECOUNTY';	
	string ParmFilterName_GeoStateCity  					:= 'STATECITY';	
	string ParmFilterName_GeoStateCityCounty 			:= 'STATECITYCOUNTY';	
	string ParmFilterName_GeoStateCityCountyZip		:= 'STATECITYCOUNTYZIP';	
	string ParmFilterName_GeoStateZip							:= 'STATEZIP';	
	string ParmFilterName_GeoStateCityZip  				:= 'STATECITYZIP';	
	string ParmFilterName_GeoStateCountyZip  			:= 'STATECOUNTYZIP';	
	string ParmFilterName_GeoZipCode							:= 'ZIPCODE';	
	string ParmFilterName_RevenueRange						:= 'SALESRANGE';
	string ParmFilterName_RevenueGT								:= 'SALESGT';
	string ParmFilterName_RevenueLT								:= 'SALESLT';
	string ParmFilterName_IndustryPrimarySIC			:= 'PRIMARYSICCODE';
	string ParmFilterName_IndustryALLSIC					:= 'ALLSICCODE';
	string ParmFilterName_IndustryPrimaryNAICS		:= 'PRIMARYNAICSCODE';
	string ParmFilterName_IndustryALLNAICS				:= 'ALLNAICSCODE';
	string ParmFilterName_EmployeeRange						:= 'EMPLOYEERANGE';
	string ParmFilterName_EmployeeGT							:= 'EMPLOYEEGT';
	string ParmFilterName_EmployeeLT							:= 'EMPLOYEELT';	
	string ParmFilterName_BusYearsRange						:= 'BUSYEARSRANGE';	
	string ParmFilterName_BusYearsGT							:= 'BUSYEARSGT';	
	string ParmFilterName_BusYearsLT							:= 'BUSYEARSLT';	
	string ParmFilterName_BusEmailPresent					:= 'BUSEMAILPRESENT';
	string ParmFilterName_ContactAddressPresent		:= 'CONTACTADDRPRESENT';
	string ParmFilterName_ContactEmailPresent			:= 'CONTACTEMAILPRESENT';
	string ParmFilterName_ContactLexidPresent			:= 'CONTACTLEXIDPRESENT';
	string ParmFilterName_ContactExecTitlePresent	:= 'CONTACTEXECTITLEPRESENT';

  /*=======================================================================================================================================
  | Filter the parameter file by individual filter values (1 rec per value), then execute necessary functions 
	|	to validate the values and format them into set.
  |======================================================================================================================================*/
 
	/*---------------------------------------------------------------------------------------------------------------------------------------
  | Location Search Type - This is a mandatory criteria. It determines whether the customer wants results at a seleid
	|	level or a proxid level. The marketing V1 file being used to hit against has both levels. So if the customer wants
	|	a proxid level search, then location address will be returned instead of business address. Not only is this parameter
  | mandatory, it also has to be accompanied by at least 2 other parameter categories. You will see this check further 
  | down in the code.
  |--------------------------------------------------------------------------------------------------------------------------------------*/

  rs_record_SearchType											:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterType_Location);
	string input_filt_SearchType							:= 	if(count(rs_record_SearchType) > 0, rs_record_SearchType[1].filter_values, '');
	set of string filt_SearchType							:= 	Marketing_Suite_List_Gen.SetFromString.SearchType(input_filt_SearchType);	
																					 
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Phone - There are three subcategories with in the phone parameter. 
	|	1) Customer wants records where the phone number is present.
	|	2) Customer wants records where the phone number is a toll free phone number.
	|	3) Customer wants records where the phone number has certain area codes. 
	|
	|	If the customer requests records where the phone number is toll free, it will need an area code in the toll free 
	|	set defined below. If the customer requests specific area codes, we validate that the value requested is a 3 
	|	digit number.
  |--------------------------------------------------------------------------------------------------------------------------------------*/
  
	rs_record_phone_present										:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_PhonePresent);
	set of string filt_PhonePresent						:=	if(count(rs_record_phone_present) > 0,['Y'],['']);
	
  rs_record_phone_tollfree									:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_PhoneTollFree);
  set of string filt_tollfree								:= 	if(count(rs_record_phone_tollfree) > 0,
																											['800','888','877','866','855','844','833','822','880','887','889','400'],
																											['']
																									 );
	
  rs_record_phone_areacode									:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_PhoneAreaCode);
  string input_filt_areacode								:= 	if(count(rs_record_phone_areacode) > 0, rs_record_phone_areacode[1].filter_values, '');
	set of string filt_areacode								:= 	Marketing_Suite_List_Gen.SetFromString.AreaCode(input_filt_areacode);

  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Geography - Due to the nature of different states having the same city and county names as well as zipcodes that 
	|	cross cities and counties, the parameters for geography are very specific. There are 9 parameters possible in the 
	|	geography category.
	|	1) Customer wants records from a particular state.
	|	2) Customer wants records from a particular city & state.
	|	3) Customer wants records from a particular county & state.
	| 4) Customer wants records from a particular city, state and county.
	| 5) Customer wants records from a particular city, state, county and zip.
	|	6) Customer wants records from a particular state and zip.	
	|	7) Customer wants records from a particular state, city and zip.
	|	8) Customer wants records from a particular state, county and zip.
	|	9) Customer wants records from a particular zip.	
	|
	|	Appropriate validation is done on each parameter. The county parameter comes in as a county name, so conversion 
	|	to a digit for filtering is done. 
  |--------------------------------------------------------------------------------------------------------------------------------------*/

  rs_record_GeoState												:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoState);
  input_filt_GeoState												:= 	if(count(rs_record_GeoState) > 0, rs_record_GeoState[1].filter_values, '');
	set of string filt_GeoState								:= 	Marketing_Suite_List_Gen.SetFromString.GeoState(input_filt_GeoState);
	
  rs_record_GeoStateCity										:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCity);
  input_filt_GeoStateCity										:= 	if(count(rs_record_GeoStateCity) > 0, rs_record_GeoStateCity[1].filter_values, '');
	set of string filt_GeoStateCity						:= 	Marketing_Suite_List_Gen.SetFromString.GeoStateCity(input_filt_GeoStateCity);
	
  rs_record_GeoStateCounty									:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCounty);
  input_filt_GeoStateCounty									:= 	if(count(rs_record_GeoStateCounty) > 0, rs_record_GeoStateCounty[1].filter_values, '');
	set of string filt_GeoStateCounty					:= 	Marketing_Suite_List_Gen.SetFromString.GeoStateCounty(input_filt_GeoStateCounty);
	
  rs_record_GeoStateCityCounty							:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCityCounty);
  input_filt_GeoStateCityCounty							:= 	if(count(rs_record_GeoStateCityCounty) > 0, rs_record_GeoStateCityCounty[1].filter_values, '');
	set of string filt_GeoStateCityCounty			:= 	Marketing_Suite_List_Gen.SetFromString.GeoStateCityCounty(input_filt_GeoStateCityCounty);
	
  rs_record_GeoStateCityCountyZip						:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCityCountyZip);
  input_filt_GeoStateCityCountyZip					:= 	if(count(rs_record_GeoStateCityCountyZip) > 0, rs_record_GeoStateCityCountyZip[1].filter_values, '');
	set of string filt_GeoStateCityCountyZip	:= 	Marketing_Suite_List_Gen.SetFromString.GeoStateCityCountyZip(input_filt_GeoStateCityCountyZip);	
	
  rs_record_GeoStateZip											:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateZip);
  input_filt_GeoStateZip										:= 	if(count(rs_record_GeoStateZip) > 0, rs_record_GeoStateZip[1].filter_values, '');
	set of string filt_GeoStateZip						:= 	Marketing_Suite_List_Gen.SetFromString.GeoStateZip(input_filt_GeoStateZip);
	
  rs_record_GeoStateCityZip									:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCityZip);
  input_filt_GeoStateCityZip								:= 	if(count(rs_record_GeoStateCityZip) > 0, rs_record_GeoStateCityZip[1].filter_values, '');
	set of string filt_GeoStateCityZip				:= 	Marketing_Suite_List_Gen.SetFromString.GeoStateCityZip(input_filt_GeoStateCityZip);
	
  rs_record_GeoStateCountyZip								:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCountyZip);
  input_filt_GeoStateCountyZip							:= 	if(count(rs_record_GeoStateCountyZip) > 0, rs_record_GeoStateCountyZip[1].filter_values, '');
	set of string filt_GeoStateCountyZip			:= 	Marketing_Suite_List_Gen.SetFromString.GeoStateCountyZip(input_filt_GeoStateCountyZip);	
		
  rs_record_GeoZipCode											:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoZipCode);
  input_filt_GeoZipCode											:= 	if(count(rs_record_GeoZipCode) > 0, rs_record_GeoZipCode[1].filter_values, '');
	set of string filt_GeoZipCode							:= 	Marketing_Suite_List_Gen.SetFromString.GeoZipCode(input_filt_GeoZipCode);	
		
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Revenue - There are three Revenue parameters possible.
	|	1) Customer wants records with an annual revenue within a range.
	|	2) Customer wants records with an annual revenue greater than a value.
	|	3) Customer wants records with an annual revenue less than a value.
	|
	|	Appropriate validation is done on each parameter.
  |--------------------------------------------------------------------------------------------------------------------------------------*/
  
	rs_record_RevenueRange										:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_RevenueRange);
  string input_filt_RevenueRange						:= 	if(count(rs_record_RevenueRange) > 0, rs_record_RevenueRange[1].filter_values, '');
	set of string filt_RevenueRange						:= 	Marketing_Suite_List_Gen.SetFromString.RevenueRange(input_filt_RevenueRange);
	
  rs_record_RevenueGT												:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_RevenueGT);
  string input_filt_RevenueGT								:= 	if(count(rs_record_RevenueGT) > 0, rs_record_RevenueGT[1].filter_values, '');
	set of string filt_RevenueGT							:= 	Marketing_Suite_List_Gen.SetFromString.RevenueGT(input_filt_RevenueGT);
	
  rs_record_RevenueLT												:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_RevenueLT);
  string input_filt_RevenueLT								:= 	if(count(rs_record_RevenueLT) > 0, rs_record_RevenueLT[1].filter_values, '');
	set of string filt_RevenueLT							:= 	Marketing_Suite_List_Gen.SetFromString.RevenueLT(input_filt_RevenueLT);

  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Employee - There are three Employee parameters possible.
	|	1) Customer wants records with the number of employees within a range.
	|	2) Customer wants records with the number of employees greater than a value.
	|	3) Customer wants records with the number of employees less than a value.
	|
	|	Appropriate validation is done on each parameter.
  |--------------------------------------------------------------------------------------------------------------------------------------*/
	
	rs_record_EmployeeRange										:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_EmployeeRange);
  string input_filt_EmployeeRange						:= 	if(count(rs_record_EmployeeRange) > 0, rs_record_EmployeeRange[1].filter_values, '');
	set of string filt_EmployeeRange					:= 	Marketing_Suite_List_Gen.SetFromString.EmployeeRange(input_filt_EmployeeRange);
	
  rs_record_EmployeeGT											:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_EmployeeGT);
  string input_filt_EmployeeGT							:= 	if(count(rs_record_EmployeeGT) > 0, rs_record_EmployeeGT[1].filter_values, '');
	set of string filt_EmployeeGT							:= 	Marketing_Suite_List_Gen.SetFromString.EmployeeGT(input_filt_EmployeeGT);
	
  rs_record_EmployeeLT											:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_EmployeeLT);
  string input_filt_EmployeeLT							:= 	if(count(rs_record_EmployeeLT) > 0, rs_record_EmployeeLT[1].filter_values, '');
	set of string filt_EmployeeLT							:= 	Marketing_Suite_List_Gen.SetFromString.EmployeeLT(input_filt_EmployeeLT);	
	
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Industry - There are four Industry parameters possible. The Marketing V1 file that we are hitting against has a primary SIC 
	|	as well as 4 secondary SICs. The same is true for the NAICS codes (primary plus 4 secondary).
	|	1) Customer wants records with the primary sic code to be a specific value or list of values.
	|	2) Customer wants records with any (primary or secondary) sic codes to be a specific value or list of values.
	|	3) Customer wants records with the primary NAICS code to be a specific value or list of values.
	|	4) Customer wants records with any (primary or secondary) NAICS codes to be a specific value or list of values.
	|
	|	Appropriate validation is done on each parameter. Customers are permitted to request 2,3 & 4 digit filters for the SIC 
	|	Code(s). Customers are permitted to request 2,3,4,5 & 6 digit filters for the NAICS code(s). 
  |--------------------------------------------------------------------------------------------------------------------------------------*/
  
	rs_record_IndustryPrimarySIC							:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_IndustryPrimarySIC);
  string input_filt_IndustryPrimarySIC			:= 	if(count(rs_record_IndustryPrimarySIC) > 0, rs_record_IndustryPrimarySIC[1].filter_values, '');
	set of string filt_IndustryPrimarySIC			:= 	Marketing_Suite_List_Gen.SetFromString.IndustryPrimarySIC(input_filt_IndustryPrimarySIC);

  rs_record_IndustryAllSIC									:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_IndustryAllSIC);
  string input_filt_IndustryALLSIC					:= 	if(count(rs_record_IndustryAllSIC) > 0, rs_record_IndustryAllSIC[1].filter_values, '');
	set of string filt_IndustryAllSIC					:= 	Marketing_Suite_List_Gen.SetFromString.IndustryAllSIC(input_filt_IndustryAllSIC);
	
  rs_record_IndustryPrimaryNAICS						:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_IndustryPrimaryNAICS);
  string input_filt_IndustryPrimaryNAICS		:= 	if(count(rs_record_IndustryPrimaryNAICS) > 0, rs_record_IndustryPrimaryNAICS[1].filter_values, '');
	set of string filt_IndustryPrimaryNAICS		:= 	Marketing_Suite_List_Gen.SetFromString.IndustryPrimaryNAICS(input_filt_IndustryPrimaryNAICS);
	
  rs_record_IndustryAllNAICS								:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_IndustryAllNAICS);
  string input_filt_IndustryAllNAICS				:= 	if(count(rs_record_IndustryAllNAICS) > 0, rs_record_IndustryAllNAICS[1].filter_values, '');
	set of string filt_IndustryAllNAICS				:= 	Marketing_Suite_List_Gen.SetFromString.IndustryAllNAICS(input_filt_IndustryAllNAICS);

  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Years in Business - There are three Years in Business parameters possible.
	|	1) Customer wants records with the age of the company within a range.
	|	2) Customer wants records with the age of the company greater than a value.
	|	3) Customer wants records with the age of the company less than a value.
	|
	|	Appropriate validation is done on each parameter.
  |--------------------------------------------------------------------------------------------------------------------------------------*/
  
	rs_record_BusYearsRange										:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_BusYearsRange);
  string input_filt_BusYearsRange						:= 	if(count(rs_record_BusYearsRange) > 0, rs_record_BusYearsRange[1].filter_values, '');
	set of string filt_BusYearsRange					:= 	Marketing_Suite_List_Gen.SetFromString.BusYearsRange(input_filt_BusYearsRange);
	
  rs_record_BusYearsGT											:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_BusYearsGT);
  string input_filt_BusYearsGT							:= 	if(count(rs_record_BusYearsGT) > 0, rs_record_BusYearsGT[1].filter_values, '');
	set of string filt_BusYearsGT							:= 	Marketing_Suite_List_Gen.SetFromString.BusYearsGT(input_filt_BusYearsGT);
	
  rs_record_BusYearsLT											:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_BusYearsLT);
  string input_filt_BusYearsLT							:= 	if(count(rs_record_BusYearsLT) > 0, rs_record_BusYearsLT[1].filter_values, '');
	set of string filt_BusYearsLT							:= 	Marketing_Suite_List_Gen.SetFromString.BusYearsLT(input_filt_BusYearsLT);

  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Business Email Present
	|	1) Customer wants records where a business email is present.
  |--------------------------------------------------------------------------------------------------------------------------------------*/
 
	rs_record_bus_email_present								:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_BusEmailPresent);
	set of string filt_BusEmailPresent				:=	if(count(rs_record_bus_email_present) > 0,['Y'],['']);
	
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | We split the Contact parameters out into two categories: A generic contact parameter group and an executive
	|	title parameter group. 
  |--------------------------------------------------------------------------------------------------------------------------------------*/             

  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Contact - There are three Contact parameters possible.
	|	1) Customer wants records with a full (street address, city, state & zip) contact address present.
	|	2) Customer wants records with a contact email present.
	|	3) Customer wants records with a contact lexid present.
	|
	|	Appropriate validation is done on each parameter.
  |--------------------------------------------------------------------------------------------------------------------------------------*/
	
	rs_record_contact_addr_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactAddressPresent);
	set of string filt_ContactAddrPresent			:=	if(count(rs_record_contact_addr_present) > 0,['Y'],['']);	
	
	rs_record_contact_email_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactEmailPresent);
	set of string filt_ContactEmailPresent		:=	if(count(rs_record_contact_email_present) > 0,['Y'],['']);
	
	rs_record_contact_lexid_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactLexidPresent);
	set of string filt_ContactLexidPresent		:=	if(count(rs_record_contact_lexid_present) > 0,['Y'],['']);	

  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Executive Title
	|	1) Customer wants records with a contact who has an executive title.
	|
	|	A list of executives were provided by product for this filter.
  |--------------------------------------------------------------------------------------------------------------------------------------*/
	
	ExecTitleSet	:=	fnGetExecTitles;
	
	rs_record_contact_exec_title_present			:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactExecTitlePresent);
	set of string filt_ContactExecTitlePresent:=	if(count(rs_record_contact_exec_title_present) > 0,ExecTitleSet,['']);
	
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | All filters have been processed. Re-assemble the parameter file with all of the cleansed filters
  |--------------------------------------------------------------------------------------------------------------------------------------*/ 
  DS_STDfilterFile  := dataset([{ParmFilterType_Location								,	filt_SearchType}
																,{ParmFilterName_PhonePresent						, filt_PhonePresent}
                                ,{ParmFilterName_PhoneTollFree					, filt_tollfree}
                                ,{ParmFilterName_PhoneAreaCode					, filt_areacode}
                                ,{ParmFilterName_GeoState								, filt_GeoState}
                                ,{ParmFilterName_GeoStateCounty  				, filt_GeoStateCounty}	
                                ,{ParmFilterName_GeoStateCity  					, filt_GeoStateCity}	
                                ,{ParmFilterName_GeoStateCityCounty 		, filt_GeoStateCityCounty}	
                                ,{ParmFilterName_GeoStateCityCountyZip	, filt_GeoStateCityCountyZip}	
                                ,{ParmFilterName_GeoStateZip						, filt_GeoStateZip}	
                                ,{ParmFilterName_GeoStateCityZip  			, filt_GeoStateCityZip}	
                                ,{ParmFilterName_GeoStateCountyZip  		, filt_GeoStateCountyZip}	
																,{ParmFilterName_GeoZipCode							, filt_GeoZipCode}
																,{ParmFilterName_RevenueRange						, filt_RevenueRange}
																,{ParmFilterName_RevenueGT							, filt_RevenueGT}
																,{ParmFilterName_RevenueLT							, filt_RevenueLT}
																,{ParmFilterName_IndustryPrimarySIC			, filt_IndustryPrimarySIC}
																,{ParmFilterName_IndustryAllSIC					, filt_IndustryAllSIC}
																,{ParmFilterName_IndustryPrimaryNAICS		, filt_IndustryPrimaryNAICS}
																,{ParmFilterName_IndustryAllNAICS				, filt_IndustryAllNAICS}																
																,{ParmFilterName_EmployeeRange					, filt_EmployeeRange}																
																,{ParmFilterName_EmployeeGT							, filt_EmployeeGT}																
																,{ParmFilterName_EmployeeLT							, filt_EmployeeLT}																
																,{ParmFilterName_BusYearsRange					, filt_BusYearsRange}																
																,{ParmFilterName_BusYearsGT							, filt_BusYearsGT}																
																,{ParmFilterName_BusYearsLT							, filt_BusYearsLT}																
																,{ParmFilterName_BusEmailPresent				, filt_BusEmailPresent}	
																,{ParmFilterName_ContactAddressPresent	, filt_ContactAddrPresent}	
																,{ParmFilterName_ContactEmailPresent		, filt_ContactEmailPresent}	
																,{ParmFilterName_ContactLexidPresent		, filt_ContactLexidPresent}	
																,{ParmFilterName_ContactExecTitlePresent,	filt_ContactExecTitlePresent}
																]
																, Layout_Valid_Parmfile
															 )(set_filter_values[1] != '');
															 
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Below is a list of each filter cateory and each parameter within that category. This is needed because there is a 
	|	requirement where at least two categories are needed in addition to the Location Search (seleid/proxid) parameter.
  |--------------------------------------------------------------------------------------------------------------------------------------*/ 															 
															 
	PhoneFilterSet		:=	['PHONEPRESENT','TOLLFREE','AREACODE'];
	GeoFilterSet			:=	['STATE','STATECOUNTY','STATECITY','STATECITYCOUNTY','STATECITYCOUNTYZIP','STATEZIP','STATECITYZIP','STATECOUNTYZIP','ZIPCODE'];
	RevenueFilterSet	:=	['SALESRANGE','SALESGT','SALESLT'];
	IndustryFilterSet	:=	['PRIMARYSICCODE','ALLSICCODE','PRIMARYNAICSCODE','ALLNAICSCODE'];
	EmployeeFilterSet	:=	['EMPLOYEERANGE','EMPLOYEEGT','EMPLOYEELT'];
	BusYearsFilterSet	:=	['BUSYEARSRANGE','BUSYEARSGT','BUSYEARSLT'];
	BusEmailFilterSet	:=	['BUSEMAILPRESENT'];
	ContactFilterSet	:=	['CONTACTADDRPRESENT','CONTACTEMAILPRESENT','CONTACTLEXIDPRESENT'];
	ExecTitleFilterSet:=	['CONTACTEXECTITLEPRESENT'];

  /*---------------------------------------------------------------------------------------------------------------------------------------
  | For each parameter we have, assign a value of 1 to each parameter, otherwise assign a value of 0. Then add up all the 
	|	counts to see if we have 2 or more categories. If not, send an error. 
  |--------------------------------------------------------------------------------------------------------------------------------------*/ 
	
	PhoneCount				:=	if(count(DS_STDfilterFile(filter_name in PhoneFilterSet))>0,1,0);
	GeoCount					:=	if(count(DS_STDfilterFile(filter_name in GeoFilterSet))>0,1,0);
	RevenueCount			:=	if(count(DS_STDfilterFile(filter_name in RevenueFilterSet))>0,1,0);
	IndustryCodeCount	:=	if(count(DS_STDfilterFile(filter_name in IndustryFilterSet))>0,1,0);
	EmployeeCount			:=	if(count(DS_STDfilterFile(filter_name in EmployeeFilterSet))>0,1,0);
	BusYearsCount			:=	if(count(DS_STDfilterFile(filter_name in BusYearsFilterSet))>0,1,0);
	BusEmailCount			:=	if(count(DS_STDfilterFile(filter_name in BusEmailFilterSet))>0,1,0);
	ContactCount			:=	if(count(DS_STDfilterFile(filter_name in ContactFilterSet))>0,1,0);
	ExecTitleCount		:=	if(count(DS_STDfilterFile(filter_name in ExecTitleFilterSet))>0,1,0);
														 
	SectionCount			:=	PhoneCount + GeoCount + RevenueCount + IndustryCodeCount + EmployeeCount + 
												BusYearsCount + BusEmailCount + ContactCount + ExecTitleCount;
	
	string failString		:= 'Criteria for at least 2 input sections in addition to the SearchType criteria is needed. Please check parameter file values';
	string successString:= 'Marketing List Gen job completed sucessfully';

    										 
	Result 						:=  if(SectionCount > 1 
														, DS_STDfilterFile
														, FAIL(DS_STDfilterFile,99,failString)
													 ) : 	FAILURE(mod_email.SendFailureEmail(failString, jobId)); 
											
  return Result;

end;
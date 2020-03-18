import Marketing_Suite_List_Gen, STD, ut;

export ValidateBatchParmFile(
															dataset(Marketing_Suite_List_Gen.Layouts.Layout_ParmFile)	inParmFile
														 )	:= function

  /*------------------------------------------------------------------------------------------------------------------------------: layouts
  | 
  |--------------------------------------------------------------------------------------------------------------------------------------*/ 
  Layout_ParmFile          											:= Marketing_Suite_List_Gen.Layouts.Layout_ParmFile;
  Layout_Valid_ParmFile    											:= Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile;
 
  /*---------------------------------------------------------------------------------------------------------------------------: attributes
  | 
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
  | Filter the parameter file by individual filter values (1 rec per value), then execute function to validate values and format into set.
  |======================================================================================================================================*/
 
	/*---------------------------------------------------------------------------------------------------------------------------------------
  | Location Search Type - Mandatory criteria             
  |--------------------------------------------------------------------------------------------------------------------------------------*/

  rs_record_SearchType											:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterType_Location);
	string input_filt_SearchType							:= 	if(count(rs_record_SearchType) > 0, rs_record_SearchType[1].filter_values, '');
	set of string filt_SearchType							:= 	Marketing_Suite_List_Gen.SetFromString.SearchType(input_filt_SearchType);	
																					 
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Phone            
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
  | Geography              
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
  | Revenue              
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
  | Employee              
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
  | Industry              
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
  | Years in Business              
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
  | Business Email Address              
  |--------------------------------------------------------------------------------------------------------------------------------------*/
 
	rs_record_bus_email_present								:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_BusEmailPresent);
	set of string filt_BusEmailPresent				:=	if(count(rs_record_bus_email_present) > 0,['Y'],['']);
	
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Contact              
  |--------------------------------------------------------------------------------------------------------------------------------------*/

	rs_record_contact_addr_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactAddressPresent);
	set of string filt_ContactAddrPresent			:=	if(count(rs_record_contact_addr_present) > 0,['Y'],['']);	
	
	rs_record_contact_email_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactEmailPresent);
	set of string filt_ContactEmailPresent		:=	if(count(rs_record_contact_email_present) > 0,['Y'],['']);
	
	rs_record_contact_lexid_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactLexidPresent);
	set of string filt_ContactLexidPresent		:=	if(count(rs_record_contact_lexid_present) > 0,['Y'],['']);	

  /*---------------------------------------------------------------------------------------------------------------------------------------
  | Executive Title              
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
															 
	PhoneFilterSet		:=	['PHONEPRESENT','TOLLFREE','AREACODE'];
	GeoFilterSet			:=	['STATE','STATECOUNTY','STATECITY','STATECITYCOUNTY','STATECITYCOUNTYZIP','STATEZIP','STATECITYZIP','STATECOUNTYZIP','ZIPCODE'];
	RevenueFilterSet	:=	['SALESRANGE','SALESGT','SALESLT'];
	IndustryFilterSet	:=	['PRIMARYSICCODE','ALLSICCODE','PRIMARYNAICSCODE','ALLNAICSCODE'];
	EmployeeFilterSet	:=	['EMPLOYEERANGE','EMPLOYEEGT','EMPLOYEELT'];
	BusYearsFilterSet	:=	['BUSYEARSRANGE','BUSYEARSGT','BUSYEARSLT'];
	BusEmailFilterSet	:=	['BUSEMAILPRESENT'];
	ContactFilterSet	:=	['CONTACTADDRPRESENT','CONTACTEMAILPRESENT','CONTACTLEXIDPRESENT'];
	ExecTitleFilterSet:=	['CONTACTEXECTITLEPRESENT'];

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
	
	string failString := 'Criteria for at least 2 input sections in addition to the SearchType criteria is needed. Please check parameter file values';
    										 
	Result 						:=  if(SectionCount > 1 
														, DS_STDfilterFile
														, FAIL(DS_STDfilterFile,99,failString)
													 ) : FAILURE(mod_email.SendFailureEmail(failString, '')); 
											
  return Result;

end;
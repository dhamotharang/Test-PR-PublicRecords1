/*--SOAP--
<message name="CriminalRecords::SearchService">

	<!-- Keyed Fields -->
  <part name="OffenderKey" 			type="xsd:string" />
  <part name="DOCNumber" 				type="xsd:string" />
  <part name="DID" 							type="xsd:string" />
	
	<!-- Autokey Search Fields -->
  <part name='SSN'							type='xsd:string'/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName"   			type="xsd:string"/>
  <part name="MiddleName"  			type="xsd:string"/>
  <part name="LastName"    			type="xsd:string"/>
  <part name="Addr"	       			type="xsd:string"/>
  <part name="City"        			type="xsd:string"/>
  <part name="State"       			type="xsd:string"/>
  <part name="Zip"         			type="xsd:string"/>
  <part name="County"           type="xsd:string"/>
  <part name="FilingJurisdictionState"           type="xsd:string"/>
	<part name="CaseNumber"				type="xsd:string"/>
  <part name="DOB" 							type="xsd:unsignedInt"/>

	<!-- Tuning -->
	<part name="AllowNickNames" 	type="xsd:boolean"/>
	<part name="PhoneticMatch"  	type="xsd:boolean"/>
	<part name="ExactOnly"   			type="xsd:boolean"/>
	<part name="NoDeepDive" 			type="xsd:boolean"/>
	<part name="ZipRadius"  			type="xsd:unsignedInt"/>
	<part name="PenaltThreshold"	type="xsd:unsignedInt"/>
	
	<!-- Compliance Settings -->
  <part name="DPPAPurpose"			type="xsd:byte"/>
  <part name="GLBPurpose"				type="xsd:byte"/>
  <part name="SSNMask"					type="xsd:string"/>
  <part name="DLMask"						type="xsd:string"/>
	<part name="ApplicationType"  type="xsd:string"/>
	
	<!-- Record Management -->
	<part name="MaxResults"					type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
	<part name="SkipRecords"				type="xsd:unsignedInt"/>
  <part name="StrictMatch" type="xsd:boolean"/>

	<!-- XML Input -->
	<part name="CrimSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
</message>
*/
/*--INFO-- This service pulls from the Criminal Offenders file.*/

import iesp, AutoStandardI, std;

export SearchService := MACRO
 
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 #ONWARNING (4207, ignore);
	rec_in		:= iesp.criminal.t_CrimSearchRequest;
	ds_in			:= dataset([], rec_in) : STORED('CrimSearchRequest', few);
	first_row	:= ds_in[1] : INDEPENDENT;

	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);

	//set main search criteria:
	search_by := global(first_row.SearchBy);
	iesp.ECL2ESP.SetInputSearchOptions(first_row.options);
	iesp.ECL2ESP.SetInputReportBy(row(first_row.searchby,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[])));
			
	#stored('County', search_by.FilingJurisdiction); // currently web is passing same value to this
	                                                  // as Search_by.County which is set in
																									// SetInputAddress(search_by.Address) above
																								  
	#stored('DOCNumber', search_by.DOCNumber);
	#stored('FilingJurisdictionState', search_by.FilingJurisdictionState);
	#stored('CaseNumber', search_by.CaseNumber);
		
	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,CriminalRecords_Services.IParam.search,opt))
		export string25		doc_number		:= '' : STORED('DOCNumber');
		export string35   case_number := '' : STORED('CaseNumber');
		export string60		offender_key		:= '' : STORED('OffenderKey');
		export string30		county_in			:= '' : STORED('County');
		export string30 	County 			:='';
		export string2 		FilingJurisdictionState 			:='' :STORED('FilingJurisdictionState');
		export unsigned2 	penalty_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project (input_params, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
    export string8 	  CaseFilingStartDate  := iesp.ECL2ESP.t_DateToString8(search_by.CaseFilingDateRange.StartDate);
    export string8 	  CaseFilingEndDate    := iesp.ECL2ESP.t_DateToString8(search_by.CaseFilingDateRange.EndDate);
	end;

	is_valid_dateinput := (tempmod.CaseFilingStartDate = '' or STD.DATE.IsValidDate((UNSIGNED4)tempmod.CaseFilingStartDate)) 
		                      and (tempmod.CaseFilingEndDate = '' or STD.DATE.IsValidDate((UNSIGNED4)tempmod.CaseFilingEndDate));
		
  IF(~is_valid_dateinput, FAIL('An error occurred while running CriminalRecords_Services.SearchService: invalid input dates.') );

	tmp := CriminalRecords_Services.SearchService_Records.val(tempmod);
	
	tmp_max := choosen(tmp,iesp.constants.CRIM.MaxSearchRecords);

	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp_max, results, iesp.criminal.t_CrimSearchResponse);
	output(results, named('Results'),all);																	 															
																 															

endmacro;
//SearchService();
/*
<CrimSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>1</DLPurpose>
  <EndUser/>
</User>
<Options>
  <ReturnCount>100</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <UseNicknames>0</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>1</StrictMatch>
</Options>
<SearchBy>
  <SSN></SSN>
	<DOCNumber></DOCNumber>
  <CaseNumber></CaseNumber>
  <UniqueID></UniqueID>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetSuffix></StreetSuffix>
    <UnitNumber></UnitNumber>
    <State></State>
    <City></City>
    <Zip5></Zip5>
		<County></County>
  </Address>
	<DOB>
		<Year></Year>
		<Month></Month>
		<Day></Day>
	</DOB>
  <FilingJurisdiction></FilingJurisdiction>
  <FilingJurisdictionState></FilingJurisdictionState>
</SearchBy>
</row>
</CrimSearchRequest>
*/
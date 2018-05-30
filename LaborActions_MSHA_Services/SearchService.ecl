/*--SOAP--
<message name="SearchService">

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"         type="xsd:byte"/>
	<part name="DPPAPurpose"        type="xsd:byte"/>
	<part name="CompanyName"      	type="xsd:string"/>
	<part name="FirstName"        	type="xsd:string"/>
	<part name="LastName"         	type="xsd:string"/>
	<part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
  <part name="StrictMatch" 				type="xsd:boolean"/>

  <part name="laborAction_MSHASearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns Labor Action Mine Saftery and Health violation records.*/


import laborActions_MSHA, iesp, AutoStandardI;

EXPORT SearchService := MACRO

  #ONWARNING (4207, IGNORE);

    rec_in := iesp.laborAction_MSHA.t_laborAction_MSHASearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('laborAction_MSHASearchRequest', FEW);
	  first_row := ds_in[1] : independent;
    //set options

		iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		
    //set main search criteria:
		search_by := global (first_row.SearchBy);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.Options);
		iesp.ECL2ESP.SetInputNameCompanyName (first_row.SearchBy.Name);
	  iesp.ECL2ESP.SetInputReportBy(row(first_row.searchby,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[])));
		
	  input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,laborActions_MSHA_Services.IParam.searchrecords,opt))
		  EXPORT STRING8 	 InspectionStartDate  := iesp.ECL2ESP.t_DateToString8(search_by.InspectionDateRange.StartDate);
		  EXPORT STRING8 	 InspectionEndDate    := iesp.ECL2ESP.t_DateToString8(search_by.InspectionDateRange.EndDate);
		end;
			
		is_valid_dateinput := (tempmod.InspectionStartDate = '' or ut.ValidDate(tempmod.InspectionStartDate)) 
		                      and (tempmod.InspectionEndDate = '' or ut.ValidDate(tempmod.InspectionEndDate));
		
    IF(~is_valid_dateinput, FAIL('An error occurred while running LaborActions_MSHA_Services.SearchService: invalid input dates.') );
		
		tmpresults := laborActions_MSHA_Services.Search_Records.val(tempmod);		
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmpresults, 
																								results, 
																								iesp.laborAction_MSHA.t_laborAction_MSHASearchResponse,,,,,,
																								iesp.Constants.LABOR_ACTION_MSHA.MaxSearchRecords);

		output(results, named('Results'));
	
endmacro;
//SearchService ();
/*
<laborAction_MSHASearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
	<SSNMask></SSNMask>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>

<SearchBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
		<CompanyName></CompanyName>
  </Name>
</SearchBy>
<Options>
  <ReturnCount></ReturnCount>
  <StartingRecord></StartingRecord>
  <UseNicknames>0</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>0</StrictMatch>
</Options>
</row>
</laborAction_MSHASearchRequest>
*/
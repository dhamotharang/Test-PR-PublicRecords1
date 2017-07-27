/*--SOAP--
<message name="SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
		
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName"        type="xsd:string"/>
	<part name="MiddleName"       type="xsd:string"/>
	<part name="LastName"         type="xsd:string"/>
	<part name="NameSuffix"				type="xsd:string"/>
	<part name="CompanyName"			type="xsd:string"/>
	
	<part name="addr" type="xsd:string"/>
	<part name="prim_range" type="xsd:string"/>
	<part name="prim_name" type="xsd:string"/>
  <part name="predir" type="xsd:string"/>
  <part name="postdir" type="xsd:string"/>
	<part name="suffix"  type="xsd:string"/>
  <part name="sec_range" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
		
	<part name="ReturnCount"         type="xsd:string"/>
	<part name="StartingRecord"      type="xsd:string"/>

	<part name="MaxResults" type="xsd:string"/>
	<part name="StrictMatch" type="xsd:boolean"/>
	<part name="PenaltThreshold"		type="xsd:unsignedInt" default="0"/>
	
	<part name="GSAVerificationRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns GSA Excluded Parties / Verifications Search records.*/

import iesp, AutoStandardI, doxie;

export SearchService := macro

		ds_in := DATASET ([], iesp.gsaverification.t_GSAVerificationRequest) : STORED ('GSAVerificationRequest', FEW);
		
		first_row := ds_in[1] : independent;
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		search_by := global (first_row.SearchBy);
		iesp.ECL2ESP.SetInputNameCompanyName(search_by.Name);
   iesp.ECL2ESP.SetInputAddress (search_by.Address);
		iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
		#stored ('PenaltThreshold', first_row.options.PenaltyThreshold);	
		
			tmp								:=AutoStandardI.GlobalModule();
			in_mod  					:= module (project (tmp,GSA_Services.Functions.params,  opt))
        export string5 name_suffix := '' : stored ('NameSuffix');
			end;	
			
	  StartDate  := iesp.ECL2ESP.t_DateToString8(search_by.ActionDateRange.StartDate);
		EndDate    := iesp.ECL2ESP.t_DateToString8(search_by.ActionDateRange.EndDate);
		
		is_valid_dateinput := (StartDate = '' or ut.ValidDate(StartDate)) 
		                      and (EndDate = '' or ut.ValidDate(EndDate));
		
    IF(~is_valid_dateinput, FAIL('An error occurred while running GSA_Services.SearchService: invalid input dates.') );

		inputData := GSA_Services.Functions.fn_getInputData(in_mod);	
		// search and return results record structure
		ds_all_recs := project(choosen(GSA_Services.BatchService_Records(inputData,0,StartDate,EndDate).ds_outRecs,iesp.constants.MAX_GSA_VERIFICATION_RESPONSE_RECORDS),iesp.gsaverification.t_GSAVerificationRecord);
	
		// apply final iesp response layout.
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(ds_all_recs, results, iesp.gsaverification.t_GSAVerificationResponse);

		// display the final response.
		output(results, named('Results'));	
endmacro;

//SearchService ();

/*
<GSAVerificationRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
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
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </Address>
</SearchBy>
<Options>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
	<MaxResults></MaxResults>
</Options>
</row>
</GSAVerificationRequest>
*/




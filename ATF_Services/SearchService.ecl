/*--SOAP--
<message name="SearchService">
  <part name="SSN" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="LastName" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType" type="xsd:string"/>
  <part name="ATFLicenseNumber" type="xsd:string"/>
  <part name="TradeName" type = "xsd:string"/>
  
  <part name="NoDeepDive" type="xsd:boolean"/>
  <part name="PenaltThreshold" type="xsd:unsignedInt"/>
  <part name="StrictMatch" type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
  
  <part name="FirearmSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- This service Returns ATF Firearms and Explosives Search records.*/

import ATF_services, iesp, AutoStandardI, WSInput;
export SearchService := MACRO

 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

    //The following macro defines the field sequence on WsECL page of query.
		WSInput.MAC_ATF_Services_SearchService();  

    rec_in := iesp.firearm.t_FirearmSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('FirearmSearchRequest', FEW);
    first_row := ds_in[1] : independent;
		 
    //set options   
    iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		#stored('includeCriminalIndicators',first_row.options.includeCriminalIndicators);

    //set main search criteria:
    search_by := global (first_row.SearchBy);
    #stored ('TradeName', search_by.TradeName);
    #stored ('ATFLicenseNumber', search_by.LicenseNumber);
    #stored ('SSN', search_by.SSN);
    iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

    input_params := AutoStandardI.GlobalModule();
		tempmod := module(project(input_params,ATF_Services.IParam.search_params,opt))
			EXPORT string15 license_number := '' : stored('ATFLicenseNumber');
			EXPORT string120 companyname := '' : stored('TradeName');
			Export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
			EXPORT boolean IncludeCriminalIndicators := false : stored('IncludeCriminalIndicators');
		end;	
		atf_recs := ATF_Services.SearchService_Records.search(tempmod, false);
		 
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(atf_recs.records, results, iesp.firearm.t_FirearmSearchResponse);		
		output(results, named('Results'));	

ENDMACRO;

//SearchService ();
/*
<FirearmSearchRequest>
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
  <TradeName></TradeName>
  <LicenseNumber></LicenseNumber>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
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
  <UseNicknames>1</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>0</StrictMatch>
  <IncludeCriminalIndicators>0</IncludeCriminalIndicators>
</Options>
</row>
</FirearmSearchRequest>
*/

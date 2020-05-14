/*--SOAP--
<message name="SearchService" wuTimeout="300000">
	<part name="DunsNumber" 		type="xsd:string"/>
	<part name="Phone" 			type='xsd:string'/>
	<part name="CompanyName" 	type='xsd:string'/>
	<part name="Addr" 			type='xsd:string'/>
	<part name="City" 			type="xsd:string" />
	<part name="State" 			type='xsd:string'/>
	<part name="ZipCode" 		type = 'xsd:string'/>
	<part name = 'BDID'			type = 'xsd:string'/>
	<part name = 'GLBPurpose'	type = 'xsd:byte'/>
	<part name = 'DPPAPurpose'	type = 'xsd:byte'/>
	<part name="NoDeepDive" 	type="xsd:boolean"/>  
	<part name="ReturnCount"      type="xsd:string"/>
	<part name="StartingRecord"   type="xsd:string"/>
	
	<part name="DunAndBradstreetRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- This service searches the DnB datafiles.*/


import DNB_services, iesp, AutoStandardI;
export SearchService := MACRO


    rec_in := iesp.dunandbradstreet.t_DunAndBradstreetRequest;
    ds_in := DATASET ([], rec_in) : STORED ('DunAndBradstreetRequest', FEW);
    frow := ds_in[1] : independent; 

 		 
    //set options
    
    iesp.ECL2ESP.SetInputBaseRequest (frow);
    iesp.ECL2ESP.Marshall.Mac_Set (frow.options);

    //set main search criteria:
    
    
    search_by := global (frow.SearchBy);
    #stored ('CompanyName', search_by.CompanyName);
    #stored ('DunsNumber', search_by.DunsNumber);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
    #stored('phone', search_by.Phone10);
		#stored('BDID', search_by.BusinessId);

    // TODO: check for "wealsofound": according to input XML it should be a constant, if any.	
		// wealsofound is opposite of no deep dive
		boolean Reversed_weAlsoFound := false : stored('weAlsoFound');
		#stored('NoDeepDive',~Reversed_weAlsoFound);

																																						
		tempmod := module(project(AutoStandardI.GlobalModule(),dnb_Services.SearchService_Records.params,opt))
			EXPORT string15 Duns_Number := '' : stored('DunsNumber');
			export PenaltThreshold := 10 : stored('PenaltThreshold');
   EXPORT DataPermissionMask := '' : STORED('DataPermissionMask');
			end;
		tmp := DNB_Services.SearchService_Records.val(tempmod);
		
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp, results, iesp.dunandbradstreet.t_DunAndBradstreetResponse);		
		output(results, named('Results'));	
		
		dnb_royalties := Royalty.RoyaltyDNB.GetOnlineRoyalties(results.records);
		output(dnb_royalties, named('RoyaltySet'));

ENDMACRO;

// SearchService ();
/*
<DunAndBradstreetRequest>
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
  <CompanyName></CompanyName>
  <dunsnumber></dunsnumber>
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
</Options>
</row>
</DunAndBradstreetRequest>
*/
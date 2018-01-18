/*--SOAP--
<message name="SearchService">
  
	<!-- XML INPUT -->
	<part name="InstantIDInternationalRequest" 		type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="TestDataEnabled" 									type="xsd:boolean"/>
	<part name="TestDataTableName" 								type="xsd:string"/>
	<part name="gateways" 												type="tns:XmlDataSet" cols="110" rows="4"/>
	</message>
*/
/*--INFO-- Search GDC or GB Group gateway and return International Instant ID results.*/


import iesp, Seed_Files, IntlIID_V2;

export SearchService := macro
		
	// Get XML input 
	rec_in := iesp.iid_international.t_InstantIDInternationalRequest;
	ds_in := DATASET ([], rec_in) : STORED ('InstantIDInternationalRequest', FEW);

	boolean 	Test_Data_Enabled := FALSE   				: stored('TestDataEnabled');
	string20 	Test_Data_Table_Name := ''  				: stored('TestDataTableName');

	gateways := dataset([], Risk_Indicators.Layout_Gateways_In) : stored ('gateways', few);
				
	iesp.iid_international.t_InstantIDInternationalRequest addDefaults(ds_in le) := transform
		self.user.DLPurpose := '';
		self := le;
	end;
	indata := project(ds_in, addDefaults(LEFT));

	GetCountrySettings := indata[1].options.GetCountrySettings;

	country := IntlIID_V2.IntlIIDFunctions().correctCountry(trim(indata[1].searchby.Address.Country));
	useGB := count(gateways(servicename = 'gbgroup')) > 0 AND country in IntlIID_V2.Constants.GBCountries;
	
	//ret_test_seed := Seed_Files.GetIntlIID(indata, Test_Data_Table_Name); needs new fields for IVI
	callGBGateway := IntlIID_V2.getGBID3(indata, gateways);
	//GBResults := if(test_data_enabled, ret_test_seed, callGBGateway);
	callGDCGateway := IntlIID_V2.getGDCVerify(indata, gateways);
	stage1 :=  if(useGB, callGBGateway, callGDCGateway);
	
	// add on IP data
	wIP := IntlIID_V2.intliidFunctions().addIPs(indata, stage1, gateways);
	
	// add on watch list data
	wWL := IntlIID_V2.watchlistFunctions().addWLMatches(indata, wIP);

	include_wl := Count(indata[1].Options.WatchList) > 0; 
	stage2 := if(include_wl, wWL, wIP);	
	
	/*/ add on world check data
	wWC := IntlIID_V2.watchlistFunctions().addWCMatches(indata, stage2); 
	
	include_wc := true; // temp waiting for ESP
	stage3 := if(include_wc, wWC, stage2)
	/*/
	
	// add passport validation
	PassportValidationOnly:= indata[1].options.PassportValidationOnly;
	final := if(PassportValidationOnly, IntlIID_V2.intliidFunctions().passportCheck(indata), stage2);

	response := if(GetCountrySettings,IntlIID_V2.intliidFunctions().getCountrySetup(indata), final); 
	
	output(response, named ('Results'));
endmacro;
// intliid_v2.SearchService();
// For testing/debugging in a web form xml text area
//SearchService ();
/*

<InstantIDInternationalRequest>
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
<Options>
	<IncludeOFAC></IncludeOFAC>
	<IncludeOtherWatchLists></IncludeOtherWatchLists>
	<UseDOBFilter></UseDOBFilter>
	<DOBRadius></DOBRadius>
	<GlobalWatchlistThreshold></GlobalWatchlistThreshold>
	<PassportValidationOnly>1</PassportValidationOnly>
	<WatchList>
		<Name>BES</Name>
		<Name>CFTC</Name>
		<Name>DTC</Name>
		<Name>EUDT</Name>
		<Name>FBI</Name>
		<Name>FCEN</Name>
		<Name>FAR</Name>
		<Name>IMW</Name>
		<Name>OFAC</Name>
		<Name>OCC</Name>
		<Name>OSFI</Name>
		<Name>PEP</Name>
		<Name>SDT</Name>
		<Name>BIS</Name>
		<Name>UNNT</Name>
		<Name>WBIF</Name>
	</WatchList>
</Options>
<SearchBy>
  <Name>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Prefix></Prefix>
  </Name>
	<Gender>M</Gender>
	<DOB>
		<Year>71</Year>
		<Month>07</Month>
		<Day>23</Day>
	</DOB>
  <Address>
    <StreetNumber></StreetNumber>
    <UnitDesignation></UnitDesignation>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <PostalCode></PostalCode>
		<Country></Country>
		<Province></Province>
  </Address>
	<NationalIDNumber></NationalIDNumber>
	<Passport>
		<MachineReadableLine1>P&lt;USASHAW&lt;JESSE&lt;CHARLES&lt;PATRICK&lt;BENJAMIN&lt;&lt;&lt;&lt;</MachineReadableLine1>
		<MachineReadableLine2>11011&lt;11&lt;0USA7107230M1507230&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;2</MachineReadableLine2>
	</Passport>
	<HomePhone></HomePhone>
	<IsHomePhonePublished></IsHomePhonePublished>
	<MobilePhone></MobilePhone>
	<IsMobilePhonePublished></IsMobilePhonePublished>
	<IPAddress></IPAddress>
</SearchBy>
</row>
</InstantIDInternationalRequest>

//Risk_Indicators.Layout_Gateways_In
<DATASET>
	<ROW>
		<servicename>GDCVerifyCheck</servicename>
		<url>http://172.23.193.55:8090/WsGateway</url>
	</ROW>
	<ROW>
		<servicename>GbID3Check</servicename>
		<url>http://172.23.193.55:8090/WsGateway</url>
	</ROW>
	<ROW>
		<servicename>netacuity</servicename>
		<url>http://rw_score_dev:[PASSWORD_REDACTED]@rwgatewaycert.br.seisint.com:8090/wsGateway</url>
	</ROW>
</DATASET>
*/
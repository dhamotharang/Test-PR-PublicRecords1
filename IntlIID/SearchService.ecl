/*--SOAP--
<message name="SearchService">
	<part name="InstantIDInternationalRequest" 		type="tns:XmlDataSet" cols="110" rows="40" />
	<part name="TestDataEnabled" 									type="xsd:boolean"/>
	<part name="TestDataTableName" 								type="xsd:string"/>
	<part name="gateways" 												type="tns:XmlDataSet" cols="110" rows="10"/>
	</message>
*/
/*--INFO-- SearchService calls the Global Data Company (GDC) gateway ESP and returns International Instant ID results. (ESDL-compliant)*/
/*--HELP-- 
<pre>
&lt;InstantIDInternationalRequest&gt;
&lt;row&gt;
&lt;User&gt;
 &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt;
 &lt;BillingCode&gt;&lt;/BillingCode&gt;
 &lt;QueryId&gt;&lt;/QueryId&gt;
 &lt;CompanyId&gt;&lt;/CompanyId&gt;
 &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
 &lt;DLPurpose&gt;&lt;/DLPurpose&gt;
 &lt;EndUser&gt;
  &lt;CompanyName&gt;&lt;/CompanyName&gt;
  &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
  &lt;City&gt;&lt;/City&gt;
  &lt;State&gt;&lt;/State&gt;
  &lt;Zip5&gt;&lt;/Zip5&gt;
 &lt;/EndUser&gt;
 &lt;MaxWaitSeconds&gt;&lt;/MaxWaitSeconds&gt;
 &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
&lt;/User&gt;
&lt;Options&gt;
 &lt;IncludeOFAC&gt;&lt;/IncludeOFAC&gt;
 &lt;IncludeOtherWatchLists&gt;&lt;/IncludeOtherWatchLists&gt;
 &lt;UseDOBFilter&gt;&lt;/UseDOBFilter&gt;
 &lt;DOBRadius&gt;&lt;/DOBRadius&gt;
 &lt;GlobalWatchlistThreshold&gt;0.84&lt;/GlobalWatchlistThreshold&gt;
 &lt;WatchList&gt;
  &lt;Name&gt;FCEN&lt;/Name&gt;
  &lt;Name&gt;IMW&lt;/Name&gt;
  &lt;Name&gt;OFAC&lt;/Name&gt;
  &lt;Name&gt;OSFI&lt;/Name&gt;
  &lt;Name&gt;SDT&lt;/Name&gt;
  &lt;Name&gt;BIS&lt;/Name&gt;
  &lt;Name&gt;UNNT&lt;/Name&gt;
 &lt;/WatchList&gt;
 &lt;PassportValidationOnly&gt;0&lt;/PassportValidationOnly&gt;
 &lt;VisaValidationOnly&gt;0&lt;/VisaValidationOnly&gt;
 &lt;PermissibleUse&gt;&lt;/PermissibleUse&gt;
 &lt;GetCountrySettings&gt;0&lt;/GetCountrySettings&gt;
 &lt;Countries&gt;
  &lt;Country&gt;
   &lt;Name&gt;UK&lt;/Name&gt;
   &lt;CreditFlag&gt;1&lt;/CreditFlag&gt;
  &lt;/Country&gt;
  &lt;Country&gt;
   &lt;Name&gt;Canada&lt;/Name&gt;
   &lt;CreditFlag&gt;0&lt;/CreditFlag&gt;
  &lt;/Country&gt;
  &lt;Country&gt;
   &lt;Name&gt;TestNoMatch&lt;/Name&gt;
   &lt;CreditFlag&gt;0&lt;/CreditFlag&gt;
  &lt;/Country&gt;
 &lt;/Countries&gt; 
 &lt;EndUserCompanyId&gt;&lt;/EndUserCompanyId&gt;
 &lt;CreditFlag&gt;0&lt;/CreditFlag&gt;
&lt;/Options&gt;
&lt;SearchBy&gt;
 &lt;Name&gt;
  &lt;First&gt;&lt;/First&gt;
  &lt;Middle&gt;&lt;/Middle&gt;
  &lt;Last&gt;&lt;/Last&gt;
 &lt;/Name&gt;
 &lt;Gender&gt;&lt;/Gender&gt;
 &lt;Address&gt;
  &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
  &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
  &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
  &lt;StreetName&gt;&lt;/StreetName&gt;
  &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
  &lt;City&gt;&lt;/City&gt;
  &lt;Province&gt;&lt;/Province&gt;
  &lt;PostalCode&gt;&lt;/PostalCode&gt;
  &lt;Country&gt;&lt;/Country&gt;
  &lt;County&gt;&lt;/County&gt;
 &lt;/Address&gt;
 &lt;DOB&gt;
  &lt;Year&gt;0&lt;/Year&gt;
  &lt;Month&gt;0&lt;/Month&gt;
  &lt;Day&gt;0&lt;/Day&gt;
 &lt;/DOB&gt;
 &lt;NationalIDNumber&gt;&lt;/NationalIDNumber&gt;
 &lt;HomePhone&gt;&lt;/HomePhone&gt;
 &lt;MobilePhone&gt;&lt;/MobilePhone&gt;
 &lt;Passport&gt;
  &lt;MachineReadableLine1&gt;&lt;/MachineReadableLine1&gt;
  &lt;MachineReadableLine2&gt;&lt;/MachineReadableLine2&gt;
 &lt;/Passport&gt;
 &lt;Visa&gt;
  &lt;MachineReadableLine1&gt;&lt;/MachineReadableLine1&gt;
  &lt;MachineReadableLine2&gt;&lt;/MachineReadableLine2&gt;
 &lt;/Visa&gt;
 &lt;IPAddress&gt;&lt;/IPAddress&gt;
&lt;/SearchBy&gt;
&lt;/row&gt;
&lt;/InstantIDInternationalRequest&gt;
</pre>
*/

import iesp, Seed_Files, Risk_Indicators;

export SearchService := macro
		
	// Get XML input 
	rec_in := iesp.iid_international.t_InstantIDInternationalRequest_Unicode;
	ds_in := DATASET ([], rec_in) : STORED ('InstantIDInternationalRequest', FEW);

	boolean 	Test_Data_Enabled := FALSE   				: stored('TestDataEnabled');
	string20 	Test_Data_Table_Name := ''  				: stored('TestDataTableName');

	gateways := Gateway.Configuration.Get();
				
	iesp.iid_international.t_InstantIDInternationalRequest_Unicode addDefaults(ds_in le) := transform
		self.user.DLPurpose := '';
		self.user.QueryId := if(trim(le.user.QueryId) <> '', trim(le.user.QueryId), '1'); // batch seq #
		self := le;
	end;
	indata := project(ds_in, addDefaults(LEFT));

	makeGWCalls := ~(indata[1].options.PassportValidationOnly OR indata[1].options.VisaValidationOnly OR indata[1].options.GetCountrySettings);
	makeNetAcuityCall := makeGWCalls and ~test_data_enabled;
	callGDCGateway := IntlIID.getGDCVerify(indata, gateways);
	// ret_test_seed := Seed_Files.GetIntlIID(indata, Test_Data_Table_Name);
	// stage1 := if(test_data_enabled, ret_test_seed, callGDCGateway);

	// Bugzilla 144247 opened to fix Seed_Files.Key_IntlIID
	// System error: 0: Index layout does not match published layout for index 
	stage1 := callGDCGateway;
	
	// add on IP data
	ds_ip_in 	:= PROJECT(indata,TRANSFORM(riskwise.Layout_IPAI,SELF.ipaddr:=LEFT.searchby.ipaddress,SELF.seq:=0));
	wIPa 			:= IntlIID.IntlIIDFunctions().addIPs(ds_ip_in, stage1, gateways(makeNetAcuityCall));
	wIP 			:= wIPa[1].Results;
	
	// add on watch list data
	wWL := IntlIID.WatchListFunctions().addWLMatches(indata, wIP);

	include_wl := Count(indata[1].Options.WatchList) > 0; 
	stage2 := if(include_wl, wWL, wIP);	
	
	/*/ add on world check data
	wWC := IntlIID.WatchListFunctions().addWCMatches(indata, stage2); 
	
	include_wc := true; // temp waiting for ESP
	stage3 := if(include_wc, wWC, stage2)
	/*/
	
	final := map( indata[1].options.PassportValidationOnly => IntlIID.ValidationFunctions().PassportCheck(indata),
								indata[1].options.VisaValidationOnly => IntlIID.ValidationFunctions().VisaCheck(indata),
								indata[1].options.GetCountrySettings => IntlIID.IntlIIDFunctions().getCountrySetup(indata),
								test_data_enabled => stage1, 
								stage2);
	
	royalties := 
		IF(makeGWCalls, Royalty.RoyaltyGDC.GetOnlineRoyalties(final))+
		if(makeNetAcuityCall, Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(gateways, ds_ip_in, wIPa[1].GWResults));

	output(final, named ('Results'));
	output(royalties,NAMED('RoyaltySet'));
endmacro;
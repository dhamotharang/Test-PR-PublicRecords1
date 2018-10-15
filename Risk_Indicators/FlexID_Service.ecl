/*--SOAP--
<message name="FlexID (aka IID Model)">
	<part name="FlexIDRequest" type="tns:XmlDataSet" cols="80" rows="50"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="IIDVersionOverride" type="xsd:boolean"/>
	<part name="_CompanyID" type="xsd:string"/>
	<part name="scores" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="allowemergingid" type="xsd:boolean"/>
 </message>
*/
/*--HELP-- 
<pre>
&lt;FlexIDRequest&gt;
 &lt;Row&gt;
 &lt;User&gt;
  &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt; 
  &lt;BillingCode&gt;&lt;/BillingCode&gt; 
  &lt;QueryId&gt;&lt;/QueryId&gt; 
  &lt;CompanyId&gt;&lt;/CompanyId&gt; 
  &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt; 
  &lt;DLPurpose&gt;&lt;/DLPurpose&gt; 
  &lt;LoginHistoryId&gt;&lt;/LoginHistoryId&gt; 
  &lt;DebitUnits&gt;0&lt;/DebitUnits&gt; 
  &lt;IP&gt;&lt;/IP&gt; 
  &lt;IndustryClass&gt;&lt;/IndustryClass&gt; 
  &lt;ResultFormat&gt;&lt;/ResultFormat&gt; 
  &lt;LogAsFunction&gt;&lt;/LogAsFunction&gt; 
  &lt;SSNMask&gt;&lt;/SSNMask&gt; 
  &lt;DOBMask&gt;&lt;/DOBMask&gt; 
  &lt;DLMask&gt;false&lt;/DLMask&gt; 
  &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt; 
  &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt; 
  &lt;ApplicationType&gt;&lt;/ApplicationType&gt; 
  &lt;SSNMaskingOn&gt;false&lt;/SSNMaskingOn&gt; 
  &lt;DLMaskingOn&gt;false&lt;/DLMaskingOn&gt; 
 &lt;EndUser&gt;
  &lt;CompanyName&gt;&lt;/CompanyName&gt; 
  &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt; 
  &lt;City&gt;&lt;/City&gt; 
  &lt;State&gt;&lt;/State&gt; 
  &lt;Zip5&gt;&lt;/Zip5&gt; 
  &lt;/EndUser&gt;
  &lt;MaxWaitSeconds&gt;0&lt;/MaxWaitSeconds&gt; 
  &lt;RelatedTransactionId&gt;&lt;/RelatedTransactionId&gt; 
  &lt;AccountNumber&gt;&lt;/AccountNumber&gt; 
  &lt;TestDataEnabled&gt;false&lt;/TestDataEnabled&gt; 
  &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt; 
  &lt;/User&gt;
  &lt;RemoteLocations&gt;&lt;/RemoteLocations&gt; 
  &lt;ServiceLocations&gt;&lt;/ServiceLocations&gt; 
 &lt;Options&gt;
  &lt;Blind&gt;false&lt;/Blind&gt; 
  &lt;Encrypt&gt;false&lt;/Encrypt&gt; 
  &lt;ReturnTokens&gt;false&lt;/ReturnTokens&gt; 
  &lt;WatchLists&gt;&lt;/WatchLists&gt; 
  &lt;UseDOBFilter&gt;false&lt;/UseDOBFilter&gt; 
  &lt;DOBRadius&gt;0&lt;/DOBRadius&gt; 
  &lt;IncludeMSOverride&gt;false&lt;/IncludeMSOverride&gt; 
  &lt;DisallowTargusEID3220&gt;false&lt;/DisallowTargusEID3220&gt; 
  &lt;PoBoxCompliance&gt;false&lt;/PoBoxCompliance&gt; 
 &lt;RequireExactMatch&gt;
  &lt;LastName&gt;false&lt;/LastName&gt; 
  &lt;FirstName&gt;false&lt;/FirstName&gt; 
  &lt;FirstNameAllowNickname&gt;false&lt;/FirstNameAllowNickname&gt; 
  &lt;Address&gt;false&lt;/Address&gt; 
  &lt;HomePhone&gt;false&lt;/HomePhone&gt; 
  &lt;SSN&gt;false&lt;/SSN&gt; 
  &lt;DOB&gt;false&lt;/DOB&gt; 
  &lt;DriverLicense&gt;false&lt;/DriverLicense&gt;
  &lt;/RequireExactMatch&gt;
  &lt;IncludeAllRiskIndicators&gt;false&lt;/IncludeAllRiskIndicators&gt; 
  &lt;IncludeVerifiedElementSummary&gt;false&lt;/IncludeVerifiedElementSummary&gt; 
  &lt;IncludeDLVerification&gt;false&lt/IncludeDLVerification&gt;
 &lt;DOBMatch&gt;
  &lt;MatchType&gt;&lt;/MatchType&gt; 
  &lt;MatchYearRadius&gt;0&lt;/MatchYearRadius&gt; 
  &lt;/DOBMatch&gt;
  &lt;CustomCVIModelName&gt;&lt;/CustomCVIModelName&gt;
	&lt;LastSeenThreshold&gt;&lt;/LastSeenThreshold&gt;
	&lt;IncludeMIoverride&gt;&lt;/IncludeMIoverride&gt;
	&lt;IncludeSSNVerification&gt;&lt;/IncludeSSNVerification&gt;
&lt;CVICalculationOptions&gt;
	&lt;IncludeDOB&gt;&lt;/IncludeDOB&gt;
	&lt;IncludeDriverLicense&gt;&lt;/IncludeDriverLicense&gt;
	&lt;DisableCustomerNetworkOption&gt;false&lt;/DisableCustomerNetworkOption&gt;
&lt;/CVICalculationOptions&gt;
	&lt;DisAllowInsurancePhoneHeaderGateway&gt;&lt;/DisAllowInsurancePhoneHeaderGateway&gt;
	&lt;InstantIDVersion&gt;&lt;/InstantIDVersion&gt;
	&lt;EnableEmergingID&gt;&lt;/EnableEmergingID&gt;
	&lt;NameInputOrder&gt;&lt;/NameInputOrder&gt;
	&lt;GlobalWatchlistThreshold&gt;0.84&lt;/GlobalWatchlistThreshold&gt;
	&lt;OFACVersion&gt;2&lt;/OFACVersion&gt;
  &lt;/Options&gt;
 &lt;SearchBy&gt;
 &lt;Seq&gt;&lt/Seq&gt;
 &lt;Name&gt;
  &lt;Full&gt;&lt;/Full&gt; 
  &lt;First&gt;&lt;/First&gt; 
  &lt;Middle&gt;&lt;/Middle&gt; 
  &lt;Last&gt;&lt;/Last&gt; 
  &lt;Suffix&gt;&lt;/Suffix&gt; 
  &lt;Prefix&gt;&lt;/Prefix&gt; 
  &lt;/Name&gt;
 &lt;Address&gt;
  &lt;StreetNumber&gt;&lt;/StreetNumber&gt; 
  &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt; 
  &lt;StreetName&gt;&lt;/StreetName&gt; 
  &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt; 
  &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt; 
  &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt; 
  &lt;UnitNumber&gt;&lt;/UnitNumber&gt; 
  &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt; 
  &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt; 
  &lt;City&gt;&lt;/City&gt; 
  &lt;State&gt;&lt;/State&gt; 
  &lt;Zip5&gt;&lt;/Zip5&gt; 
  &lt;Zip4&gt;&lt;/Zip4&gt; 
  &lt;County&gt;&lt;/County&gt; 
  &lt;PostalCode&gt;&lt;/PostalCode&gt; 
  &lt;StateCityZip&gt;&lt;/StateCityZip&gt; 
  &lt;/Address&gt;
 &lt;DOB&gt;
  &lt;Year&gt;0&lt;/Year&gt; 
  &lt;Month&gt;0&lt;/Month&gt; 
  &lt;Day&gt;0&lt;/Day&gt; 
  &lt;/DOB&gt;
  &lt;Age&gt;0&lt;/Age&gt; 
  &lt;SSN&gt;&lt;/SSN&gt; 
  &lt;SSNLast4&gt;&lt;/SSNLast4&gt; 
  &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt; 
  &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt; 
  &lt;IPAddress&gt;&lt;/IPAddress&gt; 
  &lt;Email&gt;&lt;/Email&gt; 
  &lt;HomePhone&gt;&lt;/HomePhone&gt; 
  &lt;WorkPhone&gt;&lt;/WorkPhone&gt; 
&lt;Passport&gt;
  &lt;MachineReadableLine1&gt;&lt/MachineReadableLine1&gt;
  &lt;MachineReadableLine2&gt;&lt/MachineReadableLine2&gt;
&lt;/Passport&gt;
  &lt;Gender&gt;&lt/Gender&gt;
  &lt;/SearchBy&gt;
 &lt;/Row&gt;
&lt;/FlexIDRequest&gt;
</pre>
*/
import address, iesp, identifier2, ut, risk_indicators, Risk_Reporting;

export FlexID_Service := MACRO

#stored('_espclientinterfaceversion', '');

	ds_in    := dataset([], iesp.flexid.t_FlexIdRequest)  	: stored('FlexIDRequest', few);
	first_row := ds_in[1] : independent;
	
	//set options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

	//set main search criteria:
	search_by := global(first_row.SearchBy);
	options := global(first_row.Options);
	user := global(first_row.User);
	
	// Code neccessary to support import custom model name. //string128 CustomCVIModelName {xpath('CustomCVIModelName')};  Andi mentioned these may need to be initialized to the same default value??
	string128 modelName := trim(stringlib.StringToUpperCase(options.CustomCVIModelName));
	#stored ('CustomCVIModelName', modelName);

/* **********************************************
   *  Fields needed for improved Scout Logging  *
   **********************************************/
	string32 _LoginID           := ''	: STORED('_LoginID');
	string20 CompanyID          := '' : STORED('_CompanyID');
	string20 FunctionName       := '' : STORED('_LogFunctionName');
	string50 ESPMethod          := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion   := '' : STORED('_ESPClientInterfaceVersion');
	string6 ssnmask             := 'NONE' : STORED('SSNMask');
	string6 dobmask	            := 'NONE'	: STORED('DOBMask');
	unsigned1 dlmask            := 0	: STORED('DLMask');
	string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
	string1 ExcludeDMVPII       := '' : STORED('ExcludeDMVPII');
	BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');
	BOOLEAN allowemergingid := FALSE : STORED('allowemergingid');
	
	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Risk_Indicators__InstantID);
/* ************* End Scout Fields **************/

	#stored ('AccountNumber',search_by.Seq);
	boolean Test_Data_Enabled := FALSE   	: stored('TestDataEnabled');
	
	string28 streetName := search_by.address.StreetName;
	#stored ('PrimName', streetName);
	string10 streetNumber := search_by.address.StreetNumber;
	#stored ('PrimRange', streetNumber);
	string2 streetPreDirection := search_by.address.StreetPreDirection;
	#stored ('PreDir', streetPreDirection);
	string2 streetPostDirection := search_by.address.StreetPostDirection;
	#stored ('PostDir', streetPostDirection);
	string4 streetSuffix := search_by.address.StreetSuffix;
	#stored ('Suffix', streetSuffix);
	string8 UnitNumber := search_by.address.UnitNumber;
	#stored ('SecRange', UnitNumber);
	string10 UnitDesig := search_by.address.unitdesignation;
	#stored ('UnitDesignation', search_by.address.UnitDesignation);
	in_streetaddr := address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
	string60 in_streetAddress1 := IF(search_by.address.StreetAddress1='', in_streetAddr, search_by.address.StreetAddress1);
	string60 in_streetAddress2 := search_by.address.StreetAddress2;
	string addr := trim (in_streetAddress1) + ' ' + trim (in_streetAddress2);
	#stored ('StreetAddress',addr); 
	string2 State := search_by.address.State;
	#stored ('State', State);
	string25 City := search_by.address.City;
	#stored ('City', City);
	string5 zip5 := search_by.address.Zip5; 
	#stored('Zip',zip5);
	string18 County := search_by.address.County;
	#stored('County',County);
	
											
	iesp.ECL2ESP.SetInputName (search_by.Name,False);

	iesp.ECL2ESP.SetInputDate (search_by.DOB , 'DOB');
	unsigned8 dob_value := 0 : stored('DOB');
	#stored ('DateOfBirth',(string)dob_value);
	
	dobTemp := record
		risk_indicators.layouts.Layout_DOB_Match_Options;
	end;
	dob_temp := project( ut.ds_oneRecord, transform( dobTemp, self.DOBMatch := options.DOBMatch.MatchType, self.DOBMatchYearRadius := options.DOBMatch.MatchYearRadius ));
	#stored ('DOBMatchOptions', dob_temp);
	
	string11 SSN := trim(search_by.SSN);
	string4  SSNLast4 := trim(search_by.SSNLast4);
	string11 ssn_calc := if(SSN != '', SSN, SSNLast4);
	#stored('SSN', ssn_calc);
	
	#stored ('PassportUpperLine',search_by.Passport.MachineReadableLine1);
	#stored ('PassportLowerLine',search_by.Passport.MachineReadableLine2);
	#stored ('Gender',search_by.Gender);
	  
	#stored ('Age',search_by.Age);
	#stored ('DLNumber',search_by.DriverLicenseNumber);
	#stored ('DLState',search_by.DriverLicenseState);
	#stored ('IPAddress',search_by.IPAddress);
	#stored ('Email',search_by.Email);
	#stored ('HomePhone',search_by.HomePhone);
	#stored ('WorkPhone',search_by.WorkPhone);
	#stored ('PoBoxCompliance',options.PoBoxCompliance);

	#stored ('ExactFirstNameMatch',options.RequireExactMatch.FirstName);
	#stored ('ExactLastNameMatch',options.RequireExactMatch.LastName);
	#stored ('ExactAddrMatch',options.RequireExactMatch.Address);	
	#stored ('ExactPhoneMatch',options.RequireExactMatch.HomePhone);
	#stored ('ExactSSNMatch',options.RequireExactMatch.SSN);
	#stored ('ExactDOBMatch',options.RequireExactMatch.DOB);	// not meant for use but put in for future use
	#stored ('ExactFirstNameMatchAllowNicknames',options.RequireExactMatch.FirstNameAllowNickname);
	#stored ('ExactDriverLicenseMatch',options.RequireExactMatch.DriverLicense);

	boolean IncludeSummaryFlags := options.IncludeVerifiedElementSummary;
	#stored ('IncludeAllRiskIndicators',options.IncludeAllRiskIndicators);
	#stored ('IncludeMSOverride',options.IncludeMSOverride);
	boolean IncludeDLverification := options.IncludeDLVerification;
	#stored ('IncludeDLverification', IncludeDLverification);
	
	temp := record
		dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
	end;
	watchlist_temp := project( ut.ds_oneRecord, transform( temp, self.Watchlist := options.Watchlists ));
	#stored( 'Watchlist', watchlist_temp );
	
	//Adding OFACVersion as an input option until the hard cutover to XG5.  After the cutover, old version/s are no longer allowed
	//so force version to 4 (XG5).  
	unsigned1 tempOFACVersion := max(options.OFACVersion, 2); //default to version 2, unless a higher version is passed in
	#stored ('OFACVersion',tempOFACVersion); 
	real gwt := options.GlobalWatchlistThreshold;
	real globalWatchlistThreshold :=  if (gwt=0.00, 0.84, gwt);
	#stored ('GlobalWatchlistThreshold',globalWatchlistThreshold);
	#stored ('UseDOBFilter',options.UseDOBFilter);
	#stored ('DOBRadius',options.DOBRadius);
	
	boolean IncludeTargusE3220 := ~options.DisallowTargusEID3220;
	#stored ('IncludeTargusE3220',IncludeTargusE3220);
	
	#stored ('SearchADVO', TRUE); // turn on advo searching to get the Drop_Indicator for 118476
	
	#stored ('IncludeMIOverride',options.IncludeMIOverride);
	#stored ('IncludeDOBInCVI',options.CVICalculationOptions.IncludeDOB);
	#stored ('IncludeDriverLicenseInCVI',options.CVICalculationOptions.IncludeDriverLicense);
	#stored ('DisableCustomerNetworkOptionInCVI',options.CVICalculationOptions.DisableCustomerNetworkOption);
	unsigned3 LastSeenThreshold := if((UNSIGNED)options.LastSeenThreshold=0, risk_indicators.iid_constants.oneyear, (UNSIGNED)options.LastSeenThreshold);
	#stored ('LastSeenThreshold',LastSeenThreshold);
	#stored ('DisallowInsurancePhoneHeaderGateway',options.DisAllowInsurancePhoneHeaderGateway);
	#stored ('InstantIDVersion',options.InstantIDVersion);
	
	emergingID_checks := allowemergingid or options.EnableEmergingID;
	#stored ('EnableEmergingID', emergingID_checks);
	#stored ('NameInputOrder',options.NameInputOrder);
	// #stored ('IIDVersionOverride',options.IIDVersionOverride);	// now out of band, so should just work in ciid
	boolean FromFlexID := TRUE;
	#stored ('FromFlexID',FromFlexID);	// needed for the cmra and pobox fields.  they originally were in flexid but not ciid, so only available for ciid version 1 but all versions of flexid
	#stored ('InbandTrackingOptOut',user.OutcomeTrackingOptOut);
	
	string DataRestriction := AutoStandardI.GlobalModule().DataRestrictionMask;
	string DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

	model_url := dataset([],Models.Layout_Score_Chooser) : STORED('scores',few);
	fa_params := model_url(StringLib.StringToLowerCase(name)='models.fraudadvisor_service')[1].parameters;
	model_version := trim(StringLib.StringToUppercase(fa_params(StringLib.StringToLowerCase(name)='version')[1].value));
	custom_modelname := trim(StringLib.StringToUppercase(fa_params(StringLib.StringToLowerCase(name)='custom')[1].value));
	Custommodelname := if(model_version='', custom_modelname, model_version);


	// make call to instantID
	iid := Risk_Indicators.InstantID_records;
	
	targus := Project(iid, transform(Royalty.Layouts.Royalty,
									self.royalty_type_code := left.royalty_type_code_targus,
                  self.royalty_type := left.royalty_type_targus,	
									self.royalty_count := left.royalty_count_targus,
									self.non_royalty_count := left.non_royalty_count_targus,
									self.count_entity := left.count_entity_targus,
									self := left));
									
	insurance := Project(iid, transform(Royalty.Layouts.Royalty,
                  self.royalty_type_code := left.royalty_type_code_insurance,
                  self.royalty_type := left.royalty_type_insurance,
                  self.royalty_count := left.royalty_count_insurance,
                  self.non_royalty_count := left.non_royalty_count_insurance,
                  self.count_entity := left.count_entity_insurance,
									self := left));

royalties4ustemp := if(test_data_enabled, DATASET([], Royalty.Layouts.Royalty), 
	targus + insurance);
	
royalties4us := royalties4ustemp(royalty_type_code != 0);
	
	iesp.flexid.t_FlexIDResponse intoOut(iid le, iesp.flexid.t_FlexIdRequest ri) := TRANSFORM
		
		self.result.inputecho := ri.searchby;
		
		self.result.UniqueId := (string)le.did;
		
		self.result.verifiedSSN := if(options.IncludeSSNVerification and (unsigned)le.InstantIDVersion=1, le.verssn, '');
		
		self.result.nameaddressphone.summary := (string)le.nap_summary;
		self.result.nameaddressphone._type := le.nap_type;
		self.result.nameaddressphone.status := le.nap_status;
		
		// Summary Verification flags
		self.Result.VerifiedElementSummary.FirstName := if(IncludeSummaryFlags, if(le.verfirst<>'', '1', '0'), '');
		self.Result.VerifiedElementSummary.LastName := if(IncludeSummaryFlags, if(le.verlast<>'', '1', '0'), '');
		
		addrScore := IF(modelName='CCVI1609_1', //should we be coding using the actual input source (the right dataset and esp related layouts?).
										IF(Risk_Indicators.AddrScore.zip_score(le.combo_zip, le.z5)=100
											 and Risk_Indicators.AddrScore.primRange_score(le.combo_prim_range, le.prim_range)=100,
											 100, 11),
									  Risk_Indicators.AddrScore.AddressScore(	le.combo_prim_range, le.combo_prim_name, le.combo_sec_range,
																													  le.prim_range, le.prim_name, le.sec_range));
																														
		addrMatch := Risk_indicators.iid_constants.ga(addrScore) and if(options.RequireExactMatch.Address, le.combo_prim_range=le.prim_range and le.combo_prim_name=le.prim_name and
																														ut.nneq(le.combo_sec_range,le.sec_range), true);																		
		self.Result.VerifiedElementSummary.StreetAddress := if(IncludeSummaryFlags, 	if(addrMatch, '1', '0'), 
																												'');
		CityA := stringlib.stringtouppercase(trim(le.combo_city));
		CityB := stringlib.stringtouppercase(trim(ri.searchby.address.city));
		CityScore := 100 - MAX(ut.StringSimilar100(CityA, CityB), ut.StringSimilar100(CityB, CityA));
		CityMatch := (options.RequireExactMatch.Address and CityA=CityB and CityB<>'') or (~options.RequireExactMatch.Address and CityScore between 80 and 100 and CityB<>'');
		
		self.Result.VerifiedElementSummary.City := if(IncludeSummaryFlags, if(CityMatch, '1', '0'), '');
		self.Result.VerifiedElementSummary.State := if(IncludeSummaryFlags, if(trim(le.combo_state)=trim(stringlib.stringtouppercase(ri.searchby.address.State)) and trim(ri.searchby.address.state)<>'', '1', '0'), '');
		self.Result.VerifiedElementSummary.Zip := if(IncludeSummaryFlags, if(trim(le.combo_zip)=trim(ri.searchby.address.zip5) and trim(ri.searchby.address.zip5)<>'', '1', '0'), '');
		self.Result.VerifiedElementSummary.HomePhone := if(IncludeSummaryFlags, if(le.verhphone<>'', '1', '0'), '');
		self.Result.VerifiedElementSummary.SSN := if(IncludeSummaryFlags, if(le.verssn<>'', '1', '0'), '');
		self.Result.VerifiedElementSummary.DOB := le.verdob<>'';	// base price
		self.Result.VerifiedElementSummary.DOBMatchLevel := le.dobmatchlevel;	// base price
		self.Result.VerifiedElementSummary.DL := if(IncludeDLVerification, if(le.verdl<>'', '1', '0'), '');
		
		self.Result.ValidElementSummary.SSNDeceased := le.SSNDeceased;
		self.Result.ValidElementSummary.SSNValid := le.ssa_date_first <> '';
		self.Result.ValidElementSummary.PassportValid := le.passportValidated = 'Y';
		self.Result.ValidElementSummary.DLValid := if(IncludeDLVerification, le.DLValid, '');

		self.Result.ValidElementSummary.addressPOBox := le.addressPOBox;
		self.Result.ValidElementSummary.addressCMRA := (le.ADVODropIndicator='C' or le.addressCMRA);
		self.Result.ValidElementSummary.SSNFoundForLexID := le.SSNFoundForLexID;	

		self.result.nameaddressssnsummary := le.nas_summary;
		
		// existing way of populating cvi
		self.result.comprehensiveverificationindex := (integer)le.cvi;
		self.result.CVIHighRiskIndicators := project(le.ri, transform(iesp.share.t_SequencedRiskIndicator, self.riskcode:=left.hri, self.description:=left.desc,self.sequence:=left.seq));
		
		// new way of populating cvi
		self.result.ComprehensiveVerification.ComprehensiveVerificationIndex := (integer)le.cvi;
		self.result.ComprehensiveVerification.RiskIndicators := project(le.ri, transform(iesp.share.t_SequencedRiskIndicator, self.riskcode:=left.hri, self.description:=left.desc,self.sequence:=left.seq));
		
		self.result.models :=  project(le.models, transform(iesp.instantid.t_ModelSequencedHRI,
																							self.name := left.description,
																							self.scores := project(le.models.scores, transform(iesp.instantid.t_ScoreSequencedHRI,
																																											 self._type := left.description,
																																											 self.RiskIndices := project(left.risk_indices, iesp.share.t_nameValuePair),
																																																									 self.value := (integer)left.i, 
																																																									 self.highriskindicators := project(left.reason_codes, transform(iesp.share.t_SequencedRiskIndicator,
																																																																											self.sequence := left.seq,
																																																																											self.riskcode := left.reason_code,
																																																																											self.description := left.reason_description))))));
		
		
		self.result.InstantIDVersion := le.InstantIDVersion;
		self.result.EmergingID := le.EmergingID;
		self.result.AddressSecondaryRangeMismatch := le.AddressSecondaryRangeMismatch;
		
		self := le;
		self._Header := [];
		self := [];
	END;
	result := join(iid, ds_in, trim(left.acctno)=trim(right.searchby.seq), intoOut(LEFT,RIGHT), keep(1));


	// get flexid specific test seeds (the additional 12 fields)
	testSeeds := Risk_Indicators.FlexID_TestSeed_Function(ds_in);


	iesp.flexid.t_FlexIDResponse getFlexIDseeds (result le, testSeeds ri) := TRANSFORM
		self.Result.VerifiedElementSummary.FirstName := if(IncludeSummaryFlags, ri.VerifiedElementSummary.FirstName, '');
		self.Result.VerifiedElementSummary.LastName := if(IncludeSummaryFlags, ri.VerifiedElementSummary.LastName, '');
		self.Result.VerifiedElementSummary.StreetAddress := if(IncludeSummaryFlags, ri.VerifiedElementSummary.StreetAddress, '');
		self.Result.VerifiedElementSummary.City := if(IncludeSummaryFlags, ri.VerifiedElementSummary.City, '');
		self.Result.VerifiedElementSummary.State := if(IncludeSummaryFlags, ri.VerifiedElementSummary.State, '');
		self.Result.VerifiedElementSummary.Zip := if(IncludeSummaryFlags, ri.VerifiedElementSummary.Zip, '');
		self.Result.VerifiedElementSummary.HomePhone := if(IncludeSummaryFlags, ri.VerifiedElementSummary.HomePhone, '');
		self.Result.VerifiedElementSummary.SSN := if(IncludeSummaryFlags, ri.VerifiedElementSummary.SSN, '');
		self.Result.VerifiedElementSummary.DOB := ri.VerifiedElementSummary.DOB;
		self.Result.VerifiedElementSummary.DOBMatchLevel := le.Result.VerifiedElementSummary.DOBMatchLevel;	// take this field from the CIID test seed results
		
		self.Result.ValidElementSummary.DLValid := if(IncludeDLVerification, ri.ValidElementSummary.DLValid, '');
		self.Result.ValidElementSummary := ri.ValidElementSummary;
		self.Result.VerifiedSSN := ri.VerifiedSSN;
		
		self.Result.InstantIDVersion := le.Result.InstantIDVersion;
		self.Result.EmergingID := le.Result.EmergingID;
		self.Result.AddressSecondaryRangeMismatch := le.Result.AddressSecondaryRangeMismatch;
		
		self := le;
	END;
	allSeeds := join(result, testSeeds, left.result.inputecho.seq=right.inputecho.seq, getFlexIDseeds(left,right));


	final := if(first_row.user.testdataenabled, allSeeds, result);

	output( final, named( 'Results' ) );
	
	// Deltabase_Log
	Deltabase_Logging_prep := project(iid, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
   																												 self.company_id := (Integer)CompanyID,
   																												 self.login_id := _LoginID,
   																												 self.product_id := Risk_Reporting.ProductID.Risk_Indicators__InstantID,
   																												 self.function_name := FunctionName,
   																												 self.esp_method := ESPMethod,
   																												 self.interface_version := InterfaceVersion,
   																												 self.delivery_method := DeliveryMethod,
   																												 self.date_added := (STRING8)Std.Date.Today(),
   																												 self.death_master_purpose := DeathMasterPurpose,
   																												 self.ssn_mask := ssnmask,
																													 self.dob_mask := dobmask,
																													 self.dl_mask := (String)dlmask,
																													 self.exclude_dmv_pii := ExcludeDMVPII,
																													 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																													 self.archive_opt_in := ArchiveOptIn,
                                                           self.glb := (integer)user.GLBPurpose,
                                                           self.dppa := (integer)user.DLPurpose,
   																												 self.data_restriction_mask := DataRestriction,
   																												 self.data_permission_mask := DataPermission,
   																												 self.industry := Industry_Search[1].Industry,
   																												 self.i_ssn := SSN,
                                                           self.i_dob := (string)dob_value,
                                                           self.i_name_full := search_by.Name.Full,
   																												 self.i_name_first := search_by.Name.First,
   																												 self.i_name_last := search_by.Name.Last,
   																												 // self.i_lexid := 0, 
   																												 self.i_address := addr,
   																												 self.i_city := City,
   																												 self.i_state := State,
   																												 self.i_zip := zip5,
   																												 self.i_dl := search_by.DriverLicenseNumber,
   																												 self.i_dl_state := search_by.DriverLicenseState,
                                                           self.i_home_phone :=  search_by.HomePhone,
                                                           self.i_work_phone :=  search_by.WorkPhone,
																													 self.i_model_name_1 := IF(left.cviCustomScore != '', modelName, 'CVI'),
																													 self.i_model_name_2 := Custommodelname,
   																												 self.o_score_1 := IF(left.cviCustomScore != '', left.cviCustomScore, left.cvi),
   																												 self.o_reason_1_1 := IF(left.cviCustomScore != '', left.cviCustomScore_ri[1].hri, left.ri[1].hri),
   																												 self.o_reason_1_2 := IF(left.cviCustomScore != '', left.cviCustomScore_ri[2].hri, left.ri[2].hri),
   																												 self.o_reason_1_3 := IF(left.cviCustomScore != '', left.cviCustomScore_ri[3].hri, left.ri[3].hri),
   																												 self.o_reason_1_4 := IF(left.cviCustomScore != '', left.cviCustomScore_ri[4].hri, left.ri[4].hri),
   																												 self.o_reason_1_5 := IF(left.cviCustomScore != '', left.cviCustomScore_ri[5].hri, left.ri[5].hri),
   																												 self.o_reason_1_6 := IF(left.cviCustomScore != '', left.cviCustomScore_ri[6].hri, left.ri[6].hri),
   																												 //Check to see if there was a model requested
   																												 extra_score := left.models[1].scores[1].i <> '';
   																												 self.o_score_2 := left.models[1].scores[1].i,
   																												 self.o_reason_2_1 := IF(extra_score, left.models[1].scores[1].reason_codes[1].reason_code, ''),
   																												 self.o_reason_2_2 := IF(extra_score, left.models[1].scores[1].reason_codes[2].reason_code, ''),
   																												 self.o_reason_2_3 := IF(extra_score, left.models[1].scores[1].reason_codes[3].reason_code, ''),
   																												 self.o_reason_2_4 := IF(extra_score, left.models[1].scores[1].reason_codes[4].reason_code, ''),
   																												 self.o_reason_2_5 := IF(extra_score, left.models[1].scores[1].reason_codes[5].reason_code, ''),
   																												 self.o_reason_2_6 := IF(extra_score, left.models[1].scores[1].reason_codes[6].reason_code, ''),
   																												 self.o_lexid := left.did,
   																												 self := left,
   																												 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	
	IF(~(DisableOutcomeTracking or user.OutcomeTrackingOptOut) and not Test_Data_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
	
	dRoyalties := royalties4us;
	output(dRoyalties, named('RoyaltySet'));

ENDMACRO;
// risk_indicators.FlexID_Service();
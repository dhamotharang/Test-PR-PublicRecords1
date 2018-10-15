/*--SOAP--
<message name="SmallBusiness_Service">
	<!-- XML INPUT -->
	<part name="SmallBusinessRiskRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
	</message>
*/
/*--INFO-- LexisNexis Small Business Risk Score real-time service */
/*--HELP--
<pre>
SmallBusinessRiskRequest XML:
&lt;Dataset&gt;
   &lt;Row&gt;
      &lt;remotelocations&gt;&lt;/remotelocations&gt;
      &lt;servicelocations&gt;&lt;/servicelocations&gt;
      &lt;user&gt;
	 &lt;referencecode&gt;&lt;/referencecode&gt;
	 &lt;billingcode&gt;&lt;/billingcode&gt;
	 &lt;queryid&gt;&lt;/queryid&gt;
	 &lt;companyid&gt;&lt;/companyid&gt;
	 &lt;glbpurpose&gt;&lt;/glbpurpose&gt;
	 &lt;dlpurpose&gt;&lt;/dlpurpose&gt;
	 &lt;loginhistoryid&gt;&lt;/loginhistoryid&gt;
	 &lt;debitunits&gt;0&lt;/debitunits&gt;
	 &lt;ip&gt;&lt;/ip&gt;
	 &lt;industryclass&gt;&lt;/industryclass&gt;
	 &lt;resultformat&gt;&lt;/resultformat&gt;
	 &lt;logasfunction&gt;&lt;/logasfunction&gt;
	 &lt;ssnmask&gt;&lt;/ssnmask&gt;
	 &lt;dobmask&gt;&lt;/dobmask&gt;
	 &lt;dlmask&gt;false&lt;/dlmask&gt;
	 &lt;datarestrictionmask&gt;&lt;/datarestrictionmask&gt;
	 &lt;datapermissionmask&gt;&lt;/datapermissionmask&gt;
	 &lt;ssnmaskingon&gt;false&lt;/ssnmaskingon&gt;
	 &lt;dlmaskingon&gt;false&lt;/dlmaskingon&gt;
	 &lt;enduser&gt;
	    &lt;companyname&gt;&lt;/companyname&gt;
	    &lt;streetaddress1&gt;&lt;/streetaddress1&gt;
	    &lt;city&gt;&lt;/city&gt;
	    &lt;state&gt;&lt;/state&gt;
	    &lt;zip5&gt;&lt;/zip5&gt;
	 &lt;/enduser&gt;
	 &lt;maxwaitseconds&gt;0&lt;/maxwaitseconds&gt;
	 &lt;relatedtransactionid&gt;&lt;/relatedtransactionid&gt;
	 &lt;accountnumber&gt;&lt;/accountnumber&gt;
      &lt;/user&gt;
      &lt;options&gt;
	 &lt;blind&gt;false&lt;/blind&gt;
	 &lt;encrypt&gt;false&lt;/encrypt&gt;
	 &lt;strictmatch&gt;false&lt;/strictmatch&gt;
	 &lt;maxresults&gt;0&lt;/maxresults&gt;
	 &lt;usenicknames&gt;false&lt;/usenicknames&gt;
	 &lt;includealsofound&gt;false&lt;/includealsofound&gt;
	 &lt;usephonetics&gt;false&lt;/usephonetics&gt;
	 &lt;penaltythreshold&gt;0&lt;/penaltythreshold&gt;
      &lt;/options&gt;
      &lt;searchby&gt;
	 &lt;business&gt;
	    &lt;name&gt;&lt;/name&gt;
	    &lt;alternatename&gt;&lt;/alternatename&gt;
	    &lt;address&gt;
	       &lt;streetname&gt;&lt;/streetname&gt;
	       &lt;streetnumber&gt;&lt;/streetnumber&gt;
	       &lt;streetpredirection&gt;&lt;/streetpredirection&gt;
	       &lt;streetpostdirection&gt;&lt;/streetpostdirection&gt;
	       &lt;streetsuffix&gt;&lt;/streetsuffix&gt;
	       &lt;unitdesignation&gt;&lt;/unitdesignation&gt;
	       &lt;unitnumber&gt;&lt;/unitnumber&gt;
	       &lt;streetaddress1&gt;&lt;/streetaddress1&gt;
	       &lt;streetaddress2&gt;&lt;/streetaddress2&gt;
	       &lt;state&gt;&lt;/state&gt;
	       &lt;city&gt;&lt;/city&gt;
	       &lt;zip5&gt;&lt;/zip5&gt;
	       &lt;zip4&gt;&lt;/zip4&gt;
	       &lt;county&gt;&lt;/county&gt;
	       &lt;postalcode&gt;&lt;/postalcode&gt;
	       &lt;statecityzip&gt;&lt;/statecityzip&gt;
	    &lt;/address&gt;
	    &lt;fein&gt;&lt;/fein&gt;
	    &lt;phone10&gt;&lt;/phone10&gt;
	 &lt;/business&gt;
	 &lt;owneragent&gt;
	    &lt;name&gt;
	       &lt;full&gt;&lt;/full&gt;
	       &lt;first&gt;&lt;/first&gt;
	       &lt;middle&gt;&lt;/middle&gt;
	       &lt;last&gt;&lt;/last&gt;
	       &lt;suffix&gt;&lt;/suffix&gt;
	       &lt;prefix&gt;&lt;/prefix&gt;
	    &lt;/name&gt;
	    &lt;address&gt;
	       &lt;streetname&gt;&lt;/streetname&gt;
	       &lt;streetnumber&gt;&lt;/streetnumber&gt;
	       &lt;streetpredirection&gt;&lt;/streetpredirection&gt;
	       &lt;streetpostdirection&gt;&lt;/streetpostdirection&gt;
	       &lt;streetsuffix&gt;&lt;/streetsuffix&gt;
	       &lt;unitdesignation&gt;&lt;/unitdesignation&gt;
	       &lt;unitnumber&gt;&lt;/unitnumber&gt;
	       &lt;streetaddress1&gt;&lt;/streetaddress1&gt;
	       &lt;streetaddress2&gt;&lt;/streetaddress2&gt;
	       &lt;state&gt;&lt;/state&gt;
	       &lt;city&gt;&lt;/city&gt;
	       &lt;zip5&gt;&lt;/zip5&gt;
	       &lt;zip4&gt;&lt;/zip4&gt;
	       &lt;county&gt;&lt;/county&gt;
	       &lt;postalcode&gt;&lt;/postalcode&gt;
	       &lt;statecityzip&gt;&lt;/statecityzip&gt;
	    &lt;/address&gt;
	    &lt;ssn&gt;&lt;/ssn&gt;
	    &lt;dob&gt;
	       &lt;year&gt;0&lt;/year&gt;
	       &lt;month&gt;0&lt;/month&gt;
	       &lt;day&gt;0&lt;/day&gt;
	    &lt;/dob&gt;
	    &lt;phone10&gt;&lt;/phone10&gt;
	    &lt;driverlicensenumber&gt;&lt;/driverlicensenumber&gt;
	    &lt;driverlicensestate&gt;&lt;/driverlicensestate&gt;
	 &lt;/owneragent&gt;
      &lt;/searchby&gt;
   &lt;/Row&gt;
&lt;/Dataset&gt;
</pre>
*/

import iesp, Risk_Indicators, Risk_Reporting, Address, Inquiry_AccLogs;
export SmallBusiness_Service := macro
 #onwarning(4207, ignore);
	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
	
	// Get XML input 
	ds_in    := dataset([], iesp.ws_analytics.t_SmallBusinessRiskRequest) : STORED ('SmallBusinessRiskRequest', few);
	gateways := Gateway.Configuration.Get();
	
	userIn := ds_in[1].User;
	search := ds_in[1].SearchBy;
	
/* **********************************************
	 *  Fields needed for improved Scout Logging  *
	 **********************************************/
	string32 _LoginID               := ''	: STORED('_LoginID');
	outofbandCompanyID							:= '' : STORED('_CompanyID');
	string20 CompanyID              := if(userIn.CompanyId != '', userIn.CompanyId, outofbandCompanyID);
	string20 FunctionName           := '' : STORED('_LogFunctionName');
	string50 ESPMethod              := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
	string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
	outofbandssnmask                := '' : STORED('SSNMask');
	string10 SSN_Mask               := if(userIn.SSNMask != '', userIn.SSNMask, outofbandssnmask);
	outofbanddobmask                := '' : STORED('DOBMask');
	string10 DOB_Mask               := if(userIn.DOBMask != '', userIn.DOBMask, outofbanddobmask);
	BOOLEAN DL_Mask                 := userIn.DLMask;
	BOOLEAN ExcludeDMVPII           := userIn.ExcludeDMVPII;
	BOOLEAN OutofBandOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	BOOLEAN DisableOutcomeTracking  := OutofBandOutcomeTracking OR userIn.OutcomeTrackingOptOut;
	BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_Service);
/* ************* End Scout Fields **************/
	
	unsigned history_date         := 999999 : stored('HistoryDateYYYYMM');
	boolean  Test_Data_Enabled    := FALSE  : stored('TestDataEnabled');
	string20 Test_Data_Table_Name := ''     : stored('TestDataTableName');
	string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
	#stored('DisableBocaShellLogging', DisableOutcomeTracking);
				
	// add a sequence value
	LNSmallBusiness.Layouts.RequestEx addSeq( ds_in le, integer c ) := TRANSFORM
		self.seq := c;
		self.AcctNo := le.user.accountnumber;
		self.historydate := history_date;
		self := le;
	end;
	
	prep := project( ds_in, addSeq(left,counter) );

	lnsbResults := LNSmallBusiness.SmallBusiness_Function( prep, gateways, Test_Data_Enabled, Test_Data_Table_Name, DataRestriction, DataPermission );
	
	// realtime gets only one record, so sequence is irrelevant. per 2008-01-13 discussions with Terrence, we believe
	// accountnumber for realtime transactions are handled automagically via the ESP, so we can omit them as well
	iesp.ws_analytics.t_SmallBusinessRiskResponse formOutput( lnsbResults le ) := TRANSFORM
		self := le;
	END;
	final := project( lnsbResults, formOutput(LEFT) );

	//Log to Deltabase
	Deltabase_Logging_prep := project(final, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																							 self.company_id := (Integer)CompanyID,
																							 self.login_id := _LoginID,
																							 self.product_id := Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_Service,
																							 self.function_name := FunctionName,
																							 self.esp_method := ESPMethod,
																							 self.interface_version := InterfaceVersion,
																							 self.delivery_method := DeliveryMethod,
																							 self.date_added := (STRING8)Std.Date.Today(),
																							 self.death_master_purpose := DeathMasterPurpose,
																							 self.ssn_mask := SSN_Mask,
																							 self.dob_mask := DOB_Mask,
																							 self.dl_mask := (String)(Integer)DL_Mask,
																							 self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
																							 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																							 self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                               self.glb := (Integer)userIn.GLBPurpose,
                                               self.dppa := (Integer)userIn.DLPurpose,
																							 self.data_restriction_mask := DataRestriction,
																							 self.data_permission_mask := DataPermission,
																							 self.industry := Industry_Search[1].Industry,
																							 self.i_attributes_name := '',
																							 self.i_ssn := search.OwnerAgent.SSN,
                                               self.i_dob := iesp.ECL2ESP.t_DateToString8(search.OwnerAgent.DOB),
                                               self.i_name_full := search.OwnerAgent.Name.Full,
																							 self.i_name_first := search.OwnerAgent.Name.First,
																							 self.i_name_last := search.OwnerAgent.Name.Last,
																							 // self.i_lexid := '', 
																							 self.i_address := If(trim(search.OwnerAgent.address.streetaddress1)!='', search.OwnerAgent.address.streetaddress1,
																																				 Address.Addr1FromComponents(search.OwnerAgent.address.streetnumber,
																																				 search.OwnerAgent.address.streetpredirection, search.OwnerAgent.address.streetname,
																																				 search.OwnerAgent.address.streetsuffix, search.OwnerAgent.address.streetpostdirection,
																																				 search.OwnerAgent.address.unitdesignation, search.OwnerAgent.address.unitnumber)),
																							 self.i_city := search.OwnerAgent.address.City,
																							 self.i_state := search.OwnerAgent.address.State,
																							 self.i_zip := search.OwnerAgent.address.Zip5,
																							 self.i_dl := search.OwnerAgent.DriverLicenseNumber,
																							 self.i_dl_state := search.OwnerAgent.DriverLicenseState,
                                               self.i_home_phone := search.OwnerAgent.Phone10,
																							 self.i_tin := search.Business.FEIN,
																							 self.i_bus_name := search.Business.Name,
                                               self.i_alt_bus_name := search.Business.AlternateName,
																							 self.i_bus_address := If(trim(search.Business.address.streetaddress1)!='', search.Business.address.streetaddress1,
																																						 Address.Addr1FromComponents(search.Business.address.streetnumber,
																																						 search.Business.address.streetpredirection, search.Business.address.streetname,
																																						 search.Business.address.streetsuffix, search.Business.address.streetpostdirection,
																																						 search.Business.address.unitdesignation, search.Business.address.unitnumber)),
																							 self.i_bus_city := search.Business.address.City,
																							 self.i_bus_state := search.Business.address.State,
																							 self.i_bus_zip := search.Business.address.Zip5,
                                               self.i_bus_phone := search.Business.Phone10,
																							 self.i_model_name_1 := IF(ds_in[1].servicelocations[1].parameters[1].value = '', 'RVS811_0', ds_in[1].servicelocations[1].parameters[1].value),
																							 self.o_score_1    := (String)left.Result.Models[1].Scores[1].value,
																							 self.o_reason_1_1 := left.Result.Models[1].Scores[1].BusinessHighRiskIndicators[1].Riskcode,
																							 self.o_reason_1_2 := left.Result.Models[1].Scores[1].BusinessHighRiskIndicators[2].Riskcode,
																							 self.o_reason_1_3 := left.Result.Models[1].Scores[1].BusinessHighRiskIndicators[3].Riskcode,
																							 self.o_reason_1_4 := left.Result.Models[1].Scores[1].BusinessHighRiskIndicators[4].Riskcode,
																							 self.o_reason_2_1 := left.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[1].Riskcode,
																							 self.o_reason_2_2 := left.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[2].Riskcode,
																							 self.o_reason_2_3 := left.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[3].Riskcode,
																							 self.o_reason_2_4 := left.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[4].Riskcode,
                                               self.o_lexid := lnsbResults[1].rep_did,
                                               self.o_bdid := (String)lnsbResults[1].bdid,
																							 self := left,
																							 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	// #stored('Deltabase_Log', Deltabase_Logging);

	// Note: All intermediate logs must have the following name schema:
	// Starts with 'LOG_' (Upper case is important!!)
	// Middle part is the database name, in this case: 'log__mbs'
	// Must end with '_intermediate__log'
	intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell) : STORED('Intermediate_Log');
	IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(intermediateLog, NAMED('LOG_log__mbs_intermediate__log')) );
	
	//Improved Scout Logging
	IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')) );
	
	output(final,named('Results'));
endmacro;
// LNSmallBusiness.SmallBusiness_Service();
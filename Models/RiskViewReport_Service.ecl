/*--SOAP--
<message name="RiskviewReport_Service">
	<part name="RiskViewReportRequest" type="tns:XmlDataSet" cols="110" rows="75"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="scores" type="tns:XmlDataSet" cols="70" rows="10"/>
</message>
*/


/*--INFO-- Contains RiskView Scores and report data returns */

IMPORT risk_indicators, Address, Models, iesp;

export RiskViewReport_Service := MACRO
  #onwarning(4207, ignore);

		/* Force layout of WsECL page */
		#WEBSERVICE(FIELDS(
			'RiskViewReportRequest',
			'HistoryDateYYYYMM',
			'gateways',
			'scores',
			'OutcomeTrackingOptOut'));
			
		/* **********************************************
		 *  Fields needed for improved Scout Logging  *
		 **********************************************/
			string32 _LoginID           := ''	: STORED('_LoginID');
			string20 CompanyID          := '' : STORED('_CompanyID');
			string20 FunctionName       := '' : STORED('_LogFunctionName');
			string50 ESPMethod          := '' : STORED('_ESPMethodName');
			string10 InterfaceVersion   := '' : STORED('_ESPClientInterfaceVersion');
			string10 SSN_Mask           := '' : STORED('SSNMask');
			string10 DOB_Mask	          := ''	: STORED('DOBMask');
			string1 DL_Mask             := ''	: STORED('DLMask');
			string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
			string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
			string1 ExcludeDMVPII       := '' : STORED('ExcludeDMVPII');
			BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
			string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');

			//Look up the industry by the company ID.
			Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(TRUE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Models__RiskView_Service);
		/* ************* End Scout Fields **************/

		requestIn := DATASET([], iesp.riskviewreport.t_RiskViewReportRequest)  	: STORED('RiskViewReportRequest', FEW);
		
		firstRow := requestIn[1] : independent;
		iesp.ECL2ESP.SetInputBaseRequest(firstRow);
		
		search := firstRow.SearchBy;
		option := firstRow.Options;
		users := firstRow.User;
		
		#stored ('AccountNumber',search.Seq);

		STRING28 streetName := search.Address.StreetName;
		STRING10 streetNumber := search.Address.StreetNumber;
		STRING2 streetPreDirection := search.Address.StreetPreDirection;
		STRING2 streetPostDirection := search.Address.StreetPostDirection;
		STRING4 streetSuffix := search.Address.StreetSuffix;
		STRING8 UnitNumber := search.Address.UnitNumber;
		STRING10 UnitDesig := search.Address.UnitDesignation;
		STRING60 tempStreetAddr := Address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
		STRING60 in_streetAddress1 := IF(search.Address.StreetAddress1='', tempStreetAddr, search.Address.StreetAddress1);
		STRING60 in_streetAddress2 := search.Address.StreetAddress2;
		STRING120 streetAddr := StringLib.StringToUpperCase(TRIM(in_streetAddress1) + ' ' + TRIM(in_streetAddress2));

		STRING50 outOfBandDataRestriction := '' : STORED('DataRestrictionMask');
		STRING50 DataRestriction := MAP(TRIM(users.DataRestrictionMask) <> '' => users.DataRestrictionMask,
																		TRIM(outOfBandDataRestriction) <> ''  => outOfBandDataRestriction,
																																						 Risk_Indicators.iid_constants.default_DataRestriction);
		STRING50 outOfBandDataPermission := '' : STORED('DataPermissionMask');
		STRING50 DataPermission := MAP(TRIM(users.DataPermissionMask) <> '' => users.DataPermissionMask,
																		TRIM(outOfBandDataPermission) <> ''  => outOfBandDataPermission,
																																						 Risk_Indicators.iid_constants.default_DataPermission);

		// validate minimum inputs.
		addressPopulated := (in_streetAddress1 <> '') and (search.Address.zip5 <> '' or (search.Address.City <> '' and search.Address.State <> ''));
		namePopulated := search.Name.Full <> '' or (search.Name.first<>'' and search.Name.last<>'');
		if( not (addressPopulated and namePopulated),
				FAIL('Error - Minimum input required fields: First Name, Last Name, Address, and Zip or City and State.'));
				
	// ESDL into old format for the call...
		inSSN := if( TRIM(search.SSN) <> '', search.SSN, search.SSNLast4);
		
		iesp.ECL2ESP.SetInputName (search.Name,true);
		boolean useFML := true;
		#stored ('cleanNameFML', useFML);
		
		string8 dob_value := iesp.ECL2ESP.t_DateToString8(search.DOB);
		#stored ('DateOfBirth',dob_value);

		#stored ('AccountNumber', users.AccountNumber);
		#stored ('StreetAddress', streetAddr);
		#stored ('City', StringLib.StringToUpperCase(search.Address.City));
		#stored ('State', StringLib.StringToUpperCase(search.Address.State));
		#stored ('Zip', search.Address.Zip5);
		#stored ('Country', '');
		#stored ('ssn', inSSN);
		#stored ('Age', search.Age);
		#stored ('DLNumber', search.DriverLicenseNumber);
		#stored ('DLState', StringLib.StringToUpperCase(Search.DriverLicenseState));
		#stored ('Email', '');
		#stored ('IPAddress', search.IPAddress);
		#stored ('HomePhone', search.HomePhone);
		#stored ('WorkPhone', search.WorkPhone);
		#stored ('EmployerName', '');
		#stored ('FormerName', '');
		#stored ('Attributes', false);
		#stored ('IntendedPurpose', option.IntendedPurpose);
		#stored ('TestDataEnabled', users.TestDataEnabled);
		#stored ('TestDataTableName', users.TestDataTableName);
		#stored ('IndustryClass', users.IndustryClass);
		// history date is out of band...?
		STRING50 DataRestrictionMask 			:= MAP(	TRIM(users.DataRestrictionMask) <> ''  => users.DataRestrictionMask,
																						AutoStandardI.GlobalModule().DataRestrictionMask); 
		#stored ('DataRestrictionMask', DataRestriction);

		STRING50 DataPermissionMask 			:= MAP(	TRIM(users.DataPermissionMask) <> ''  => users.DataPermissionMask,
																						AutoStandardI.GlobalModule().DataPermissionMask); 
		#stored ('DataPermissionMask', DataPermission);
		// scores is out of band
		//#stored ('RequestedAttributeGroups', ); // no attributes in riskview...
		// gateways are out of band...
		
		#stored('ReturnBS', true); // tell rv_records to return the bs used in the returnedbs stored value
		#stored('ReturnBSVersion', 41); // if returnbs is requested, this sets the min version for the return. -- we want the newest for this
		
		#stored('FFDOptionsMask', option.FFDOptionsMask);
		
		// Pull model information for scout logging
		ds_scores := dataset([],Models.Layout_Score_Chooser) 		: stored('scores',few);
		scores_count := count(ds_scores);
		
		scores_param := ds_scores.parameters(StringLib.StringToLowerCase(name)='custom');
		model_name1 := IF(scores_count >= 1, StringLib.StringToLowerCase(scores_param[1].value), '');
		
		scores_param2 := ds_scores[2].parameters(StringLib.StringToLowerCase(name)='custom');
		model_name2 := IF(scores_count > 1, StringLib.StringToLowerCase(scores_param2[1].value), '');
		
		
		// Riskview_Records requires either a model request or an attribute request
		// Riskviewreport sends the model request out of band on the scores block	
		riskview_xml := Models.RiskView_Records;
		exceptions := exists(riskview_xml[1].models[1].scores((integer)i in [0, 100, 101, 200, 222]));
		riskview_did := riskview_xml.did;

		BocaShell_returned := DATASET([], risk_indicators.Layout_Boca_Shell) : STORED('ReturnedBS');
		BocaShellVersion := 0 : STORED('ReturnedBSVersion'); // this will now be the actual version run.
		
		reportOut := if(users.TestDataEnabled,
										Risk_Indicators.RVR_TestSeed_Function(requestIn),
										Models.RiskViewReport_RptFunction(BocaShell_returned, BocaShellVersion, DataRestriction, option.IntendedPurpose));

		// ----------------------------------------
		// Model transforms
		// ----------------------------------------

		iesp.share.t_SequencedRiskIndicator toRRri(Risk_Indicators.layouts.layout_reason_codes_plus_seq l) := TRANSFORM
			self.Sequence := l.seq;
			self.riskcode := l.reason_code;
			self.description := l.reason_description;
		END;

		iesp.riskviewreport.t_RvReportScoreHRI toRRscores(Models.Layout_Score l) := TRANSFORM
			self._Type := l.Description;
			self.Value := (integer)l.i;
			self.HighRiskIndicators := project(l.reason_codes, toRRri(left));
		END;

		iesp.riskviewreport.t_RvReportModelHRI toRRmodel(Models.Layout_Model l) := TRANSFORM
			self.name := l.description;
			self.scores := project(l.scores, toRRscores(left));
			self := [];
		END;

		iesp.riskviewreport.t_RiskViewReportResponse formatResponse( riskview_xml l, reportOut r) := TRANSFORM
			self.Result.InputEcho := search;
			self.Result.Models := project(l.models, toRRmodel(left));
			self.Result.Report := if(not exceptions, r);
			self.Result.ConsumerStatements := l.ConsumerStatements;
            
      // for inquiry logging, populate the consumer section with the DID and input fields
      self.Result.Consumer := l.Consumer;        
      
			self.Result := [];
			self._header := [];
		END;

		// break out the score from the riskview_records call
		// and request the riskviewreport section to be populated
		// (attributes could be extracted from riskview_xml as well...)
		//		res := project( riskview_xml, formatResponse(left, reportOut));
		res := join(riskview_xml, reportOut, (unsigned4)left.AccountNumber = right.seq, formatResponse(left, right));
		intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell) : STORED('Intermediate_Log');
		// Note: All intermediate logs must have the following name schema:
		// Starts with 'LOG_' (Upper case is important!!)
		// Middle part is the database name, in this case: 'log__mbs__fcra'
		// Must end with '_intermediate__log'
IF(~DisableOutcomeTracking and ~users.TestDataEnabled, OUTPUT(intermediateLog, NAMED('LOG_log__mbs__fcra_intermediate__log')) );

		
		//Log to Deltabase
		Deltabase_Logging_prep := project(riskview_xml, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																						 self.company_id := (Integer)CompanyID,
																						 self.login_id := _LoginID,
																						 self.product_id := Risk_Reporting.ProductID.Models__RiskView_Service,
																						 self.function_name := FunctionName,
																						 self.esp_method := ESPMethod,
																						 self.interface_version := InterfaceVersion,
																						 self.delivery_method := DeliveryMethod,
																						 self.date_added := (STRING8)Std.Date.Today(),
																						 self.death_master_purpose := DeathMasterPurpose,
																						 self.ssn_mask := SSN_Mask,
																						 self.dob_mask := DOB_Mask,
																						 self.dl_mask := DL_Mask,
																						 self.exclude_dmv_pii := ExcludeDMVPII,
																						 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																						 self.archive_opt_in := ArchiveOptIn,
                                             self.glb := (Integer)users.GLBPurpose,
                                             self.dppa := (Integer)users.DLPurpose,
																						 self.data_restriction_mask := DataRestriction,
																						 self.data_permission_mask := DataPermission,
																						 self.industry := Industry_Search[1].Industry,
																						 // self.i_attributes_name := attributesIn[1].name,
																						 self.i_ssn := inSSN,
                                             self.i_dob := Search.dob.year +
                                                           intformat((integer1)Search.dob.month, 2, 1) +
                                                           intformat((integer1)Search.dob.day, 2, 1),
                                             self.i_name_full := search.Name.Full,
																						 self.i_name_first := search.Name.First,
																						 self.i_name_last := search.Name.Last,
																						 // self.i_lexid := did_value, 
																						 self.i_address := streetAddr,
																						 self.i_city := search.Address.City,
																						 self.i_state := search.Address.State,
																						 self.i_zip := search.Address.Zip5,
																						 self.i_dl := search.DriverLicenseNumber,
																						 self.i_dl_state := Search.DriverLicenseState,
                                             self.i_home_phone := search.HomePhone,
                                             self.i_work_phone := search.WorkPhone,
																						 // Check to see if there were models requested
																						 // model_count := count(option.IncludeModels.ModelRequests);
																						 self.i_model_name_1 := model_name1,
																						 extra_score := scores_count > 1;
																						 self.i_model_name_2 := model_name2,
																						 self.o_score_1    := IF(model_name1 != '', left.Models[1].Scores[1].i, ''),
																						 self.o_reason_1_1 := left.Models[1].Scores[1].reason_codes[1].reason_code,
																						 self.o_reason_1_2 := left.Models[1].Scores[1].reason_codes[2].reason_code,
																						 self.o_reason_1_3 := left.Models[1].Scores[1].reason_codes[3].reason_code,
																						 self.o_reason_1_4 := left.Models[1].Scores[1].reason_codes[4].reason_code,
																						 self.o_reason_1_5 := left.Models[1].Scores[1].reason_codes[5].reason_code,
																						 self.o_reason_1_6 := left.Models[1].Scores[1].reason_codes[6].reason_code,
																						 self.o_score_2    := IF(extra_score, left.Models[2].Scores[1].i, ''),
																						 self.o_reason_2_1 := IF(extra_score, left.Models[2].Scores[1].reason_codes[1].reason_code, ''),
																						 self.o_reason_2_2 := IF(extra_score, left.Models[2].Scores[1].reason_codes[2].reason_code, ''),
																						 self.o_reason_2_3 := IF(extra_score, left.Models[2].Scores[1].reason_codes[3].reason_code, ''),
																						 self.o_reason_2_4 := IF(extra_score, left.Models[2].Scores[1].reason_codes[4].reason_code, ''),
																						 self.o_reason_2_5 := IF(extra_score, left.Models[2].Scores[1].reason_codes[5].reason_code, ''),
																						 self.o_reason_2_6 := IF(extra_score, left.Models[2].Scores[1].reason_codes[6].reason_code, ''),
																						 self.o_lexid      := left.did,
																						 self := left,
																						 self := [] ));
		Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
		
		//Improved Scout Logging
		IF(~DisableOutcomeTracking and ~users.TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs__fcra_transaction__log__scout')));

		output( res, named( 'Results' ) );
//		output( BocaShell_returned, named('bocashell'));
ENDMACRO;

/*--HELP-- 
<pre>
  &lt;RiskViewReportRequest&gt;
   &lt;Row&gt;
   &lt;User&gt;
    &lt;ReferenceCode/&gt;
    &lt;BillingCode/&gt;
    &lt;QueryId/&gt;
    &lt;GLBPurpose/&gt;
    &lt;DLPurpose/&gt;
    &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt; 
    &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt; 
    &lt;EndUser&gt;
     &lt;CompanyName/&gt;
     &lt;StreetAddress1/&gt;
     &lt;City/&gt;
     &lt;State/&gt;
     &lt;Zip5/&gt;
    &lt;/EndUser&gt;
    &lt;MaxWaitSeconds&gt;0&lt;/MaxWaitSeconds&gt;
    &lt;AccountNumber/&gt;
    &lt;TestDataEnabled&gt;0&lt;/TestDataEnabled&gt;
    &lt;TestDataTableName&gt;0&lt;/TestDataTableName&gt;
   &lt;/User&gt;
   &lt;Options&gt;
    &lt;IncludeModels&gt;
     &lt;BankCard/&gt;
     &lt;Auto/&gt;
     &lt;Telecom/&gt;
     &lt;Retail/&gt;
     &lt;MoneyService/&gt;
     &lt;Prescreen/&gt;
     &lt;RefundAnticipation/&gt;
     &lt;InPersonApplication&gt;0&lt;/InPersonApplication&gt;
     &lt;ModelRequests&gt;
      &lt;ModelRequest&gt;
       &lt;ModelName&gt;riskview&lt;/ModelName&gt;
       &lt;ModelOptions&gt;
        &lt;ModelOption&gt;
         &lt;OptionName&gt;custom&lt;/OptionName&gt;
         &lt;OptionValue&gt;rvg1302_1&lt;/OptionValue&gt;
        &lt;/ModelOption&gt;
       &lt;/ModelOptions&gt;
      &lt;/ModelRequest&gt;
     &lt;/ModelRequests&gt;
    &lt;/IncludeModels&gt;
    &lt;IntendedPurpose&gt;Application&lt;/IntendedPurpose&gt;
   &lt;/Options&gt;
   &lt;SearchBy&gt;
    &lt;Name&gt;
     &lt;Full/&gt;
     &lt;First&gt;John&lt;/First&gt;
     &lt;Middle/&gt;
     &lt;Last&gt;Doe&lt;/Last&gt;
     &lt;Suffix/&gt;
     &lt;Prefix/&gt;
    &lt;/Name&gt;
    &lt;Address&gt;
     &lt;StreetNumber/&gt;
     &lt;StreetPreDirection/&gt;
     &lt;StreetName/&gt;
     &lt;StreetSuffix/&gt;
     &lt;StreetPostDirection/&gt;
     &lt;UnitDesignation/&gt;
     &lt;UnitNumber/&gt;
     &lt;StreetAddress1&gt;1010 W st germain St&lt;/StreetAddress1&gt;
     &lt;StreetAddress2/&gt;
     &lt;City&gt;St. Cloud&lt;/City&gt;
     &lt;State&gt;MN&lt;/State&gt;
     &lt;Zip5&gt;56303&lt;/Zip5&gt;
     &lt;Zip4/&gt;
     &lt;County/&gt;
     &lt;PostalCode/&gt;
     &lt;StateCityZip/&gt;
    &lt;/Address&gt;
    &lt;DOB&gt;
     &lt;Year&gt;0&lt;/Year&gt;
     &lt;Month&gt;0&lt;/Month&gt;
     &lt;Day&gt;0&lt;/Day&gt;
    &lt;/DOB&gt;
    &lt;Age&gt;0&lt;/Age&gt;
    &lt;SSN&gt;123456987&lt;/SSN&gt;
    &lt;SSNLast4/&gt;
    &lt;DriverLicenseNumber/&gt;
    &lt;DriverLicenseState/&gt;
    &lt;IPAddress/&gt;
    &lt;HomePhone/&gt;
    &lt;WorkPhone/&gt;
   &lt;/SearchBy&gt;
   &lt;/Row&gt;
  &lt;/RiskViewReportRequest&gt;
</pre>
*/
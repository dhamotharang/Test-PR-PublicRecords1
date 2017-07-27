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

		/* Force layout of WsECL page */
		#WEBSERVICE(FIELDS(
			'RiskViewReportRequest',
			'HistoryDateYYYYMM',
			'gateways',
			'scores'));

		BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');

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
		OUTPUT(intermediateLog, NAMED('LOG_log__mbs__fcra_intermediate__log'));
		
		//Improved Scout Logging
		Deltabase_Logging := DATASET([], Risk_Reporting.Layouts.LOG_Deltabase_Layout) : STORED('Deltabase_Log');
		IF(~DisableOutcomeTracking, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs__fcra_transaction__log__scout')));

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
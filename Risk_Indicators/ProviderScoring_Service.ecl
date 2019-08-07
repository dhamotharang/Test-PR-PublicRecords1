/*--SOAP--
<message name="ProviderScoring_Service" wuTimeout="300000">
	<part name="ProviderIntegrityScoreRequest" type="tns:XmlDataSet" cols="200" rows="25"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
/*--INFO-- Provider Integrity Service -- Provider Scoring via ESDL*/
/*--HELP-- 
<pre>
&lt;ProviderIntegrityScoreRequest&gt;
  &lt;Row&gt;
    &lt;SearchBy&gt;
      &lt;Name&gt;
        &lt;Full&gt;&lt;/Full&gt;
        &lt;Prefix&gt;&lt;/Prefix&gt;
        &lt;First&gt;&lt;/First&gt;
        &lt;Middle&gt;&lt;/Middle&gt;
        &lt;Last&gt;&lt;/Last&gt;
        &lt;Suffix&gt;&lt;/Suffix&gt;
      &lt;/Name&gt;
      &lt;CompanyName&gt;&lt;/CompanyName&gt;
      &lt;Address&gt;
        &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
        &lt;City&gt;&lt;/City&gt;
        &lt;State&gt;&lt;/State&gt;
        &lt;Zip5&gt;&lt;/Zip5&gt;
        &lt;County&gt;&lt;/County&gt;
        &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
        &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
        &lt;StreetName&gt;&lt;/StreetName&gt;
        &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
        &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
        &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
        &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
      &lt;/Address&gt;
      &lt;DOB&gt;
        &lt;Year&gt;&lt;/Year&gt;
        &lt;Month&gt;&lt;/Month&gt;
        &lt;Day&gt;&lt;/Day&gt;
      &lt;/DOB&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;Phone10&gt;&lt;/Phone10&gt;
      &lt;BusinessId&gt;&lt;/BusinessId&gt;
      &lt;UPINNumber&gt;&lt;/UPINNumber&gt;
      &lt;NPINumber&gt;&lt;/NPINumber&gt;
      &lt;FEIN&gt;&lt;/FEIN&gt;
      &lt;LicenseNumber&gt;&lt;/LicenseNumber&gt;
      &lt;LicenseState&gt;&lt;/LicenseState&gt;
      &lt;CLIANumber&gt;&lt;/CLIANumber&gt;
    &lt;/SearchBy&gt;
    &lt;Options&gt;
      &lt;IncludeModels&gt;
        &lt;ProviderIntegrityScore&gt;HCP1206_0&lt;/ProviderIntegrityScore&gt;
        &lt;IncludeAllRiskIndicators&gt;0&lt;/IncludeAllRiskIndicators&gt;
      &lt;/IncludeModels&gt;
    &lt;/Options&gt;
    &lt;User&gt;
      &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt;
      &lt;BillingCode&gt;&lt;/BillingCode&gt;
      &lt;QueryId&gt;&lt;/QueryId&gt;
      &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
      &lt;GLBPurpose&gt;8&lt;/GLBPurpose&gt;
      &lt;DLPurpose&gt;0&lt;/DLPurpose&gt;
      &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt; 
      &lt;TestDataEnabled&gt;0&lt;/TestDataEnabled&gt; 
      &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt; 
    &lt;/User&gt;
  &lt;/Row&gt;
&lt;/ProviderIntegrityScoreRequest&gt;
</pre>
*/


IMPORT Address, iesp, Models, Risk_Indicators, ut, gateway, AutoStandardI;

EXPORT ProviderScoring_Service := MACRO

	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

	/* ********************************************
	 *            Grab Service Inputs             *
	 ********************************************** */
  requestIn := DATASET([], iesp.providerintegrityscore.t_ProviderIntegrityScoreRequest)  	: STORED('ProviderIntegrityScoreRequest', FEW);
  firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	search := GLOBAL(firstRow.SearchBy);
	option := GLOBAL(firstRow.Options);
	users := GLOBAL(firstRow.User);
	
	STRING25 Model_Request_Raw		  := TRIM(option.IncludeModels.ProviderIntegrityScore);
	UNSIGNED1 GLBPurpose					  := IF(TRIM(users.GLBPurpose) = '', AutoStandardI.Constants.GLBPurpose_default, (UNSIGNED)users.GLBPurpose);
	UNSIGNED1 DPPAPurpose					  := IF(TRIM(users.DLPurpose) = '', 0, (UNSIGNED)users.DLPurpose);
	STRING DataRestrictionMaskOOB   := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	STRING50 DataRestrictionMask    := IF(TRIM(users.DataRestrictionMask) = '', DataRestrictionMaskOOB, users.DataRestrictionMask);
	string10 DataPermissionMaskOOB 	:= AutoStandardI.GlobalModule().DataPermissionMask;
	STRING10 DataPermissionMask    	:= IF(TRIM(users.DataPermissionMask) = '', DataPermissionMaskOOB, users.DataPermissionMask);
	UNSIGNED3 HistoryDate					  := Risk_Indicators.iid_constants.default_history_date : STORED('HistoryDateYYYYMM');
	UNSIGNED1 NumWarningCodes			  := IF(option.IncludeModels.IncludeAllRiskIndicators = TRUE, 8, 4);
	
    // CCPA Fields
    unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
    string TransactionID := '' : stored ('_TransactionId');
    string BatchUID := '' : stored('_BatchUID');
    unsigned6 GlobalCompanyId := 0 : stored('_GCID');
    
	// This product has no gateways
	gateways := Gateway.Constants.void_gateway;
	
	/* ********************************************
	 *              Clean Up Inputs               *
	 ********************************************** */
  
	ProviderScoringRequest_Sequenced := DATASET(1, TRANSFORM(Risk_Indicators.Layout_Provider_Scoring.Input,
        SELF.seq := IF(TRIM(search.Seq) IN ['', '0'], COUNTER, (INTEGER)search.Seq);
        SELF.AcctNo := TRIM(users.AccountNumber); // Provider ID
		
		// Name
		SELF.Provider_Full_Name := TRIM(search.Name.Full);
		SELF.Provider_First_Name := TRIM(search.Name.First);
		SELF.Provider_Middle_Name := TRIM(search.Name.Middle);
		SELF.Provider_Last_Name := TRIM(search.Name.Last);
		SELF.Provider_Business_Name := TRIM(search.CompanyName);
		// Address
		streetName := TRIM(search.Address.StreetName);
		streetNumber := TRIM(search.Address.StreetNumber);
		streetPreDirection := TRIM(search.Address.StreetPreDirection);
		streetPostDirection := TRIM(search.Address.StreetPostDirection);
		streetSuffix := TRIM(search.Address.StreetSuffix);
		UnitNumber := TRIM(search.Address.UnitNumber);
		UnitDesig := TRIM(search.Address.UnitDesignation);
		tempStreetAddr := Address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
		SELF.StreetAddress1 := IF(TRIM(search.Address.StreetAddress1) = '', tempStreetAddr, search.Address.StreetAddress1);
		SELF.StreetAddress2 := TRIM(search.Address.StreetAddress2);
		SELF.City := TRIM(search.Address.City);
		SELF.St := TRIM(search.Address.State);
		SELF.Zip := TRIM(search.Address.Zip5);
		// Other PII
		SELF.SSN := TRIM(search.SSN);
		SELF.DateOfBirth := TRIM(iesp.ECL2ESP.t_DateToString8(search.DOB));
		SELF.BusinessPhone := TRIM(search.Phone10);
		SELF.FEIN := IF(TRIM(search.TaxID) = '', TRIM(search.FEIN), TRIM(search.TaxID));
		SELF.Medical_License := TRIM(search.LicenseNumber);
		SELF.NPI := TRIM(search.NPINumber);
		SELF.UPIN := TRIM(search.UPINNumber);
		SELF.HistoryDateYYYYMM := HistoryDate;
        SELF := []) );
	
	Model_Request := StringLib.StringToUpperCase(Model_Request_Raw);

	BocaShellVersion := MAP(
													Model_Request = 'HCP1206_0' => 4,
																												 0
													);
													
	NumberOfWarningCodes := MIN(MAX(NumWarningCodes, 4), 8); // Allow default minimum of 4 Reason Codes, on up to max of 8 Reason Codes

	/* ********************************************
	 *    Get Boca Shell and Healthcare Data      *
	 ********************************************** */
	// Don't do the work if we don't have a valid model request!
	BocaShell_HealthcareShell := IF(BocaShellVersion > 0, Risk_Indicators.ProviderScoring_Search_Function(ProviderScoringRequest_Sequenced, BocaShellVersion, DPPAPurpose, GLBPurpose, DataRestrictionMask, HistoryDate, gateways, DataPermissionMask,
    LexIdSourceOptout := LexIdSourceOptout, TransactionID := TransactionID, BatchUID := BatchUID, GlobalCompanyID := GlobalCompanyID),
																												DATASET([], Risk_Indicators.Layout_Provider_Scoring.Clam_Plus_Healthcare));

	/* ********************************************
	 *             Get Model Results              *
	 ********************************************** */
	modelResult := MAP(
											Model_Request = 'HCP1206_0' => Models.HCP1206_0_0(BocaShell_HealthcareShell, NumberOfWarningCodes),
											Model_Request = ''					=> DATASET([], Models.Layout_ModelOut),
																										 FAIL(Models.Layout_ModelOut, 'Invalid/unknown model request: ' + Model_Request)
										);
	
	/* ***************************************
	 *    Convert Model Results to ESDL:   *
   *************************************** */
	iesp.providerintegrityscore.t_PSSequencedRiskIndicator getRIs(Risk_Indicators.Layout_Desc modelRIs, UNSIGNED RIOrder) := TRANSFORM
		SELF.Sequence := RIOrder;
		SELF.RiskCode := modelRIs.hri;
		SELF.Description := Risk_Indicators.getHRIDesc(modelRIs.hri);
	END;
	iesp.providerintegrityscore.t_PSScore getScores(Models.Layout_ModelOut modelScore) := TRANSFORM
		SELF.Value := (INTEGER)modelScore.Score;
		SELF.RiskIndicators := PROJECT(modelScore.ri, getRIs(LEFT, COUNTER));
		SELF._Type := MAP(Model_Request = 'HCP1206_0' => 'HealthcareProvider',
																											'');
	END;
	iesp.providerintegrityscore.t_PSModel intoModel(modelResult le) := TRANSFORM
		SELF.Name := Model_Request;
		SELF.Scores := PROJECT(le, getScores(LEFT));
	END;
	
	scoreResults := PROJECT(modelResult, intoModel(LEFT));
	
	/* ********************************************
	 *  Map Model Results into appropriate layout *
	 ********************************************** */
  iesp.providerintegrityscore.t_ProviderIntegrityScoreResponse intoFinal(Risk_Indicators.Layout_Provider_Scoring.Input input) := TRANSFORM
		SELF._Header 	:= [];
		SELF.SearchBy 	:= search;
		SELF.Models 		:= scoreResults;
	END;
	final := PROJECT(ProviderScoringRequest_Sequenced, intoFinal(LEFT));
	
	OUTPUT(final, NAMED('Results'));
ENDMACRO;
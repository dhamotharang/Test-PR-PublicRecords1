/*--SOAP--
<message name="ProviderScoring_Batch_Service" wuTimeout="300000">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="Model" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="NumberOfWarningCodes" type="xsd:byte"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
/*--HELP--
<pre>
&lt;dataset&gt;
  &lt;row&gt;
    &lt;AcctNo&gt;&lt;/AcctNo&gt;
    &lt;Provider_Full_Name&gt;&lt;/Provider_Full_Name&gt;
    &lt;Provider_First_Name&gt;&lt;/Provider_First_Name&gt;
    &lt;Provider_Middle_Name&gt;&lt;/Provider_Middle_Name&gt;
    &lt;Provider_Last_Name&gt;&lt;/Provider_Last_Name&gt;
    &lt;Provider_Business_Name&gt;&lt;/Provider_Business_Name&gt;
    &lt;SSN&gt;&lt;/SSN&gt;
    &lt;DateOfBirth&gt;&lt;/DateOfBirth&gt;
    &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
    &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
    &lt;City&gt;&lt;/City&gt;
    &lt;St&gt;&lt;/St&gt;
    &lt;Zip&gt;&lt;/Zip&gt;
    &lt;Postal_Code&gt;&lt;/Postal_Code&gt;
    &lt;BusinessPhone&gt;&lt;/BusinessPhone&gt;
    &lt;FEIN&gt;&lt;/FEIN&gt;
    &lt;Medical_License&gt;&lt;/Medical_License&gt;
    &lt;NPI&gt;&lt;/NPI&gt;
    &lt;DEA_Number&gt;&lt;/DEA_Number&gt;
    &lt;UPIN&gt;&lt;/UPIN&gt;
    &lt;Claim_Amount&gt;&lt;/Claim_Amount&gt;
    &lt;Filler_Field_1&gt;&lt;/Filler_Field_1&gt;
    &lt;Filler_Field_2&gt;&lt;/Filler_Field_2&gt;
    &lt;HistoryDateYYYYMM&gt;999999&lt;/HistoryDateYYYYMM&gt;
  &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/


IMPORT STD, Models, Risk_Indicators, RiskWise, gateway, AutoStandardI;

EXPORT ProviderScoring_Batch_Service := MACRO

	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

	/* ********************************************
	 *            Grab Service Inputs             *
	 ********************************************** */
	Batch_Input										:= DATASET([], Risk_Indicators.Layout_Provider_Scoring.Input) : STORED('batch_in');
	
	STRING25 Model_Request_Raw		:= '' : STORED('Model');
	UNSIGNED1 GLBPurpose					:= AutoStandardI.Constants.GLBPurpose_default : STORED('GLBPurpose');
	UNSIGNED1 DPPAPurpose					:= 0 : STORED('DPPAPurpose');
	STRING DataRestrictionMask  	:= risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	STRING50 DataPermission 			:= Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
	UNSIGNED3 HistoryDate					:= Risk_Indicators.iid_constants.default_history_date : STORED('HistoryDateYYYYMM');
	UNSIGNED1 NumWarningCodes			:= 4 : STORED('NumberOfWarningCodes');
  
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
	Risk_Indicators.Layout_Provider_Scoring.Input sequenceInput(Risk_Indicators.Layout_Provider_Scoring.Input le, UNSIGNED6 seqCounter) := TRANSFORM
		SELF.seq := seqCounter;
		SELF := le;
	END;
	Batch_Input_Sequenced := PROJECT(Batch_Input, sequenceInput(LEFT, COUNTER));
	
	Model_Request := STD.STR.ToUpperCase(Model_Request_Raw);

	BocaShellVersion := MAP(
													Model_Request = 'HCP1206_0' => 4,
																												 0
													);
													
	NumberOfWarningCodes := MIN(MAX(NumWarningCodes, 4), 8); // Allow default minimum of 4 Reason Codes, on up to max of 8 Reason Codes

	/* ********************************************
	 *    Get Boca Shell and Healthcare Data      *
	 ********************************************** */
	// Don't do the work if we don't have a valid model request!
	BocaShell_HealthcareShell := IF(BocaShellVersion > 0, Risk_Indicators.ProviderScoring_Search_Function(Batch_Input_Sequenced, BocaShellVersion, DPPAPurpose, GLBPurpose, DataRestrictionMask, HistoryDate, gateways, DataPermission, 
    LexIdSourceOptout := LexIdSourceOptout, TransactionID := TransactionID, BatchUID := BatchUID, GlobalCompanyID := GlobalCompanyID),
																												DATASET([], Risk_Indicators.Layout_Provider_Scoring.Clam_Plus_Healthcare));

	/* ********************************************
	 *             Get Model Results              *
	 ********************************************** */
	modelResult := MAP(
											Model_Request = 'HCP1206_0' => Models.HCP1206_0_0(BocaShell_HealthcareShell, NumberOfWarningCodes),
																										 DATASET([], Models.Layout_ModelOut)
										);
	
	/* ********************************************
	 *  Map Model Results into appropriate layout *
	 ********************************************** */
	Risk_Indicators.Layout_Provider_Scoring.BatchOut formOutput(Risk_Indicators.Layout_Provider_Scoring.Input input, Models.Layout_ModelOut model) := TRANSFORM
		SELF.AcctNo := input.AcctNo;
		SELF.Score := model.Score;
		SELF.RC1 := model.ri[1].hri;
		SELF.RC2 := model.ri[2].hri;
		SELF.RC3 := model.ri[3].hri;
		SELF.RC4 := model.ri[4].hri;
		SELF.RC5 := model.ri[5].hri;
		SELF.RC6 := model.ri[6].hri;
		SELF.RC7 := model.ri[7].hri;
		SELF.RC8 := model.ri[8].hri;
	END;
	final := JOIN(Batch_Input_Sequenced, modelResult, LEFT.seq = RIGHT.seq, formOutput(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.Max_atmost));

	OUTPUT(final, NAMED('Results'));
ENDMACRO;
/*--SOAP--
<message name="RiskView Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="IntendedPurpose" type="xsd:string"/>
	<part name="AttributesVersionRequest" type="xsd:string"/>
	<part name="Auto_model_name" type="xsd:string"/>
	<part name="Bankcard_model_name" type="xsd:string"/>
	<part name="Short_term_lending_model_name" type="xsd:string"/>
	<part name="Telecommunications_model_name" type="xsd:string"/>
	<part name="Crossindustry_model_name" type="xsd:string"/>
	<part name="Custom_model_name" type="xsd:string"/>
	<part name="Custom2_model_name" type="xsd:string"/>
	<part name="Custom3_model_name" type="xsd:string"/>
	<part name="Custom4_model_name" type="xsd:string"/>
	<part name="Custom5_model_name" type="xsd:string"/>
	<part name="prescreen_score_threshold" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="EndUserCompanyName" type="xsd:string"/>
	<part name="CustomerNumber" type="xsd:string"/>
	<part name="SecurityCode" type="xsd:string"/>
	<part name="FFDOptionsMask"      type="xsd:string"/>
	<part name="IncludeLNJReport" type="xsd:boolean"/>
	<part name="IncludeLNJRecordsWithSSN" type="xsd:boolean"/>
	<part name="IncludeLNJBureauRecs" type="xsd:boolean"/>
 <part name="ReportingPeriod" type="xsd:integer"/>
	<part name="ExcludeCityTaxLiens" type="xsd:boolean"/>
	<part name="ExcludeCountyTaxLiens" type="xsd:boolean"/>
	<part name="ExcludeStateTaxWarrants" type="xsd:boolean"/>
	<part name="ExcludeStateTaxLiens" type="xsd:boolean"/>
	<part name="ExcludeFederalTaxLiens" type="xsd:boolean"/>
	<part name="ExcludeOtherLiens" type="xsd:boolean"/>
	<part name="ExcludeJudgments" type="xsd:boolean"/>
	<part name="ExcludeEvictions" type="xsd:boolean"/>
    <part name="MinimumAmount" type="xsd:integer"/>
    <part name="ExcludeEvictions" type="xsd:boolean"/>
    <part name="ExcludeStates" type="xsd:string"/>
    <part name="ExcludeReportingSources" type="xsd:string"/>
    <part name="IncludeStatusRefreshChecks" type="xsd:boolean"/>
    <part name="AttributesOnly" type="xsd:boolean"/>
    <part name="ExcludeStatusRefresh" type="xsd:boolean"/>
    <part name="StatusRefreshWaitPeriod" type="xsd:string"/>
	<part name="RetainInputDID" type="xsd:boolean"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>

	<part name="_BatchJobId" type="xsd:string"/>
	<part name="_CompanyId" type="xsd:string"/>

</message>
*/
/*--INFO-- Contains RiskView Scores and attributes version 5.0 and higher */

import iesp, gateway, risk_indicators, FFD, STD, Riskview, Royalty;

export Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
#stored('DataPermissionMask',risk_indicators.iid_constants.default_DataPermission);

batchin := dataset([],riskview.layouts.Layout_Riskview_Batch_In) 	: stored('batch_in',few);
string    AttributesVersionRequest := '' 				: stored('AttributesVersionRequest');
string    Auto_model_name := '' 								: stored('Auto_model_name');
string    Bankcard_model_name := '' 						: stored('Bankcard_model_name');
string    Short_term_lending_model_name := '' 	: stored('Short_term_lending_model_name');
string    Telecommunications_model_name := '' 	: stored('Telecommunications_model_name');
string    Crossindustry_model_name := '' 	: stored('Crossindustry_model_name');
string    Custom_model_name := '' 							: stored('Custom_model_name');
string    Custom2_model_name := '' 							: stored('Custom2_model_name');
string    Custom3_model_name := '' 							: stored('Custom3_model_name');
string    Custom4_model_name := '' 							: stored('Custom4_model_name');
string    Custom5_model_name := '' 	 						: stored('Custom5_model_name');
string    prescreen_score_threshold := '' 			: stored('prescreen_score_threshold');

gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	SELF.servicename := le.servicename;
	SELF.url := IF(le.servicename IN ['targus', 'first_data'], '', le.url); // Don't allow Targus Gateway or First Data/Fiserv Gateway
	SELF := le;
END;
gateways := PROJECT(gateways_in, gw_switch(LEFT));

string IntendedPurpose := ''					: stored('IntendedPurpose');
string EndUserCompanyName := ''				: stored('EndUserCompanyName');
string CustomerNumber := ''						: stored('CustomerNumber');
string SecurityCode := ''							: stored('SecurityCode');

string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
STRING DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
boolean OutputConsumerStatements := strFFDOptionsMask_in[1] = '1';

boolean IncludeLnJ := false : stored('IncludeLNJReport');
boolean IncludeRecordsWithSSN := false : stored('IncludeLNJRecordsWithSSN');
boolean IncludeBureauRecs := false : stored('IncludeLNJBureauRecs');	
integer2 ReportingPeriod := 84 : stored('ReportingPeriod'); 

boolean ExcludeCityTaxLiens := false : stored('ExcludeCityTaxLiens');
boolean ExcludeCountyTaxLiens := false : stored('ExcludeCountyTaxLiens');
boolean ExcludeStateTaxWarrants := false : stored('ExcludeStateTaxWarrants');
boolean ExcludeStateTaxLiens := false : stored('ExcludeStateTaxLiens');
boolean ExcludeFederalTaxLiens := false : stored('ExcludeFederalTaxLiens');
boolean ExcludeOtherLiens := false : stored('ExcludeOtherLiens');
boolean ExcludeJudgments := false : stored('ExcludeJudgments');
boolean ExcludeEvictions := false : stored('ExcludeEvictions');
boolean ExcludeReleasedCases := false : stored('ExcludeReleasedCases');
unsigned6 MinAmount := 0 : stored('MinimumAmount');
MinimumAmount := MIN(MinAmount, 999999999);
string ExcludeStates := '' : stored('ExcludeStates');
ExcludeStatesArray := STD.STr.SplitWords(TRIM(ExcludeStates,ALL),',');
ExcludedStates := DATASET(ExcludeStatesArray,iesp.share.t_StringArrayItem);
string ExcludeReportingSources := '' : stored('ExcludeReportingSources');
ExcludeReportingSourcesArray := STD.STr.SplitWords(TRIM(ExcludeReportingSources,ALL),',');
ExcludedReportingSources := DATASET(ExcludeReportingSourcesArray,iesp.share.t_StringArrayItem);
boolean IncludeStatusRefreshChecks := false : stored('IncludeStatusRefreshChecks');
boolean AttributesOnly := false : stored('AttributesOnly');
boolean ExcludeStatusRefresh := false : stored('ExcludeStatusRefresh');
string5 StatusRefreshWaitPeriod := '' : stored('StatusRefreshWaitPeriod');
DeferredTransactionIDs := PROJECT(batchin(DeferredTransactionID <> ''), TRANSFORM({STRING32 DeferredTransactionID}, 
                                                                  SELF.DeferredTransactionID := LEFT.DeferredTransactionID));


_BatchJobId := '' : stored('_BatchJobId');
string20 _CompanyID := '' : stored('_CompanyId');



//Default to being ON, which is 1. If Excluded, we change to 0.
string tmpFilterLienTypes := Risk_Indicators.iid_constants.LnJDefault;

tmpCityFltr := if(ExcludeCityTaxLiens, '0', tmpFilterLienTypes[1..1]);
tmpCountyFltr := if(ExcludeCountyTaxLiens, '0', tmpFilterLienTypes[2..2]);
tmpStateWarrantFltr := if(ExcludeStateTaxWarrants, '0', tmpFilterLienTypes[3..3]);
tmpStateFltr :=  if(ExcludeStateTaxLiens, '0', tmpFilterLienTypes[4..4]);
tmpFedFltr := if(ExcludeFederalTaxLiens, '0', tmpFilterLienTypes[5..5]);
tmpLiensFltr := if(ExcludeOtherLiens,'0', tmpFilterLienTypes[6..6]);
tmpJdgmtsFltr := if(ExcludeJudgments, '0', tmpFilterLienTypes[7..7]);
tmpEvictionsFltr := if(ExcludeEvictions, '0', tmpFilterLienTypes[8..8]);
tmpReleasedCasesFltr := if(ExcludeReleasedCases, '0', tmpFilterLienTypes[9..9]);
tmpAttributesOnlyFltr := if(AttributesOnly, '0', tmpFilterLienTypes[10..10]);
tmpExcludeStatusRefresh := if(ExcludeStatusRefresh, '0', tmpFilterLienTypes[11..11]);
	//We now have boolean options for each of these filters. We built the code to use a bit (string)
	//saying which ones they want and which ones they want to filter. I take the boolean flags and 
	//turn them into the string the code is expecting. FlagLiensOptions in constants will convert to 
	//the BS options in the search_function.
FilterLienTypes := tmpCityFltr + 
		tmpCountyFltr +
		tmpStateWarrantFltr +
		tmpStateFltr + 
		tmpFedFltr +
		tmpLiensFltr +
		tmpJdgmtsFltr +
		tmpEvictionsFltr +
		tmpReleasedCasesFltr +
		tmpAttributesOnlyFltr +
        tmpExcludeStatusRefresh;

boolean RetainInputDID := false				: stored('RetainInputDID');  // to be used by modelers in R&D mode

BOOLEAN ReturnDetailedRoyalties := FALSE : STORED('ReturnDetailedRoyalties'); // Allows batch to specify if they want royalty details in RoyaltySet

boolean isCalifornia_in_person := false;  // always false in batch
STRING6 SSNMask := 'NONE';
STRING6 DOBMask := 'NONE';
BOOLEAN DLMask := FALSE;
// add sequence number to matchup later to add acctno to output and generate name/value pairs for custom model inputs.  
// For models that use these the model code should be adjusted to handle both the batch and XML names if the model is available in both services.
iesp.RiskView_Share.t_ModelOptionRV getCustomInputs(RiskView.Layouts.Layout_Riskview_Batch_In custom, INTEGER custom_input) := TRANSFORM
	SELF.OptionName := CASE(custom_input,
				1  => 'custom_input1',
				2  => 'custom_input2',
				3  => 'custom_input3',
				4  => 'custom_input4',
				5  => 'custom_input5',
				6  => 'custom_input6',
				7  => 'custom_input7',
				8  => 'custom_input8',
				9  => 'custom_input9',
				10 => 'custom_input10',
				11 => 'custom_input11',
				12 => 'custom_input12',
				13 => 'custom_input13',
				14 => 'custom_input14',
				15 => 'custom_input15',
				16 => 'custom_input16',
				17 => 'custom_input17',
				18 => 'custom_input18',
				19 => 'custom_input19',
				20 => 'custom_input20',
				21 => 'custom_input21',
				22 => 'custom_input22',
				23 => 'custom_input23',
				24 => 'custom_input24',
				25 => 'custom_input25',
							'');
	SELF.OptionValue := CASE(custom_input,
				1  => custom.custom_input1,
				2  => custom.custom_input2,
				3  => custom.custom_input3,
				4  => custom.custom_input4,
				5  => custom.custom_input5,
				6  => custom.custom_input6,
				7  => custom.custom_input7,
				8  => custom.custom_input8,
				9  => custom.custom_input9,
				10 => custom.custom_input10,
				11 => custom.custom_input11,
				12 => custom.custom_input12,
				13 => custom.custom_input13,
				14 => custom.custom_input14,
				15 => custom.custom_input15,
				16 => custom.custom_input16,
				17 => custom.custom_input17,
				18 => custom.custom_input18,
				19 => custom.custom_input19,
				20 => custom.custom_input20,
				21 => custom.custom_input21,
				22 => custom.custom_input22,
				23 => custom.custom_input23,
				24 => custom.custom_input24,
				25 => custom.custom_input25,
							'');
END;

RiskView.Layouts.layout_riskview_input getInput(riskview.layouts.Layout_Riskview_Batch_In le, UNSIGNED4 c) := TRANSFORM
	SELF.seq := c; /*Production*/
	// SELF.seq := (Unsigned)le.AcctNo; /*Validation*/

	SELF.Custom_Inputs := NORMALIZE(DATASET([TRANSFORM(iesp.RiskView_Share.t_ModelOptionRV, SELF := [])]), 25, getCustomInputs(le, COUNTER));

	SELF := le;
END;
batchin_with_seq := project(batchin, getInput(LEFT, COUNTER));

MLA_alone				:= STD.Str.ToLowerCase(custom_model_name) = 'mla1608_0' AND 
									 STD.Str.ToLowerCase(custom2_model_name) = '' AND
									 STD.Str.ToLowerCase(custom3_model_name) = '' AND
									 STD.Str.ToLowerCase(custom4_model_name) = '' AND
									 STD.Str.ToLowerCase(custom5_model_name) = '' AND
									 auto_model_name = '' AND bankcard_model_name = '' AND 
									 Short_term_lending_model_name = '' AND Telecommunications_model_name = '' AND Crossindustry_model_name =''  AND AttributesVersionRequest = '';
								 
//error_message := 'Error - Minimum input fields required: First Name, Last Name, Address, and Zip or City and State; LexID only; or First Name, Last Name, and SSN';
// Brad wants to keep error message stating just first/last name, but also allow user to use unparsedfullname field in place of first/last fields if they want
valid_inputs := batchin_with_seq((
							((trim(name_first)<>'' and trim(name_last)<>'') or trim(unparsedfullname)<>'') and  	// name check
							(trim(ssn)<>'' or   																																																		// ssn check
								( trim(street_addr)<>'' and 																																													// address check
								(trim(z5)<>'' OR (trim(p_city_name)<>'' AND trim(St)<>'')))												// zip or city/state check
							)
								 or
							 (MLA_alone //if MLA requested by itself, bypass Riskview minimum input checks here.
							  ) or
							(unsigned)LexID <> 0
						) and ReportingPeriod > 0 and ReportingPeriod <= 84);

						
search_Results := riskview.Search_Function(valid_inputs, 
	gateways,
	DataRestriction,
	AttributesVersionRequest, 
	auto_model_name, 
	bankcard_model_name, 
	Short_term_lending_model_name, 
	Telecommunications_model_name, 
	Crossindustry_model_name, 
	Custom_model_name,
	Custom2_model_name,
	Custom3_model_name,
	Custom4_model_name,
	Custom5_model_name,
	IntendedPurpose,
	prescreen_score_threshold, 
	isCalifornia_in_person,
	riskview.constants.batch,
	riskview.constants.no_riskview_report,
	DataPermission,
	SSNMask,
	DOBMask,
	DLMask, 
	FilterLienTypes,
	EndUserCompanyName,
	CustomerNumber,
	SecurityCode,
	IncludeRecordsWithSSN,
	IncludeBureauRecs, 
	ReportingPeriod, 
	IncludeLnJ,
	RetainInputDID,
	MinimumAmount := MinimumAmount,
	ExcludeStates := ExcludedStates,
	ExcludeReportingSources := ExcludedReportingSources,
	IncludeStatusRefreshChecks := IncludeStatusRefreshChecks,
    DeferredTransactionIDs := DeferredTransactionIDs,
	StatusRefreshWaitPeriod := StatusRefreshWaitPeriod,
  IsBatch := TRUE,
	CompanyID := _CompanyID,
	TransactionID := _BatchJobId
	);


#if(Riskview.Constants.TurnOnValidation = FALSE)


Results := join(batchin_with_seq, search_results, left.seq=right.seq,
			RiskView.Transforms.FormatBatch(left, right, IncludeStatusRefreshChecks, ExcludeStatusRefresh),
			left outer);

AttributesOnlyResults := PROJECT(Results, RiskView.Transforms.AttributesOnlyBatch(LEFT));

FinalResults := IF(AttributesOnly = TRUE AND IncludeLNJ = TRUE, AttributesOnlyResults, Results);
// OUTPUT(batchin_with_seq, NAMED('batchin_with_seq'));
// OUTPUT(search_results, NAMED('search_results'));

MLA_royalties := if((STD.Str.ToLowerCase(custom_model_name)  = 'mla1608_0' OR
										 STD.Str.ToLowerCase(custom2_model_name) = 'mla1608_0' OR
										 STD.Str.ToLowerCase(custom3_model_name) = 'mla1608_0' OR
										 STD.Str.ToLowerCase(custom4_model_name) = 'mla1608_0' OR 
										 STD.Str.ToLowerCase(custom5_model_name) = 'mla1608_0'), 
										 Royalty.RoyaltyMLA.GetBatchRoyaltiesBySeq(batchin_with_seq, search_Results),
										 Royalty.RoyaltyMLA.GetNoBatchRoyalties());
                     
dRoyalties := Royalty.GetBatchRoyalties(MLA_royalties, ReturnDetailedRoyalties);

output(dRoyalties, NAMED('RoyaltySet'));

output(FinalResults, named('Results')); /*Production*/
// output(search_Results, named('Results')); /*Validation*/

// output(FilterLienTypes, named('FilterLienTypes'));
// output(tmpCityFltr, named('tmpCityFltr'));
// output(tmpCountyFltr, named('tmpCountyFltr'));
// output(tmpStateWarrantFltr, named('tmpStateWarrantFltr'));
// output(tmpStateFltr, named('tmpStateFltr'));
// output(tmpFedFltr, named('tmpFedFltr'));
// output(tmpLiensFltr, named('tmpLiensFltr'));
// output(tmpJdgmtsFltr, named('tmpJdgmtsFltr'));
// output(tmpEvictionsFltr, named('tmpEvictionsFltr'));
// output(tmpFilterLienTypes, named('tmpFilterLienTypes'));

ConsumerStatementResults1 := project(search_Results.ConsumerStatements, 
	transform(FFD.layouts.ConsumerStatementBatchFull,
		self.UniqueId := (unsigned)left.uniqueId;
		
		self.dateAdded := // renamed timestamp to be dateAdded to match what krishna's team is doing
			intformat(left.timestamp.year, 4, 1) + 
			intformat(left.timestamp.month, 2, 1) + 
			intformat(left.timestamp.day, 2, 1) +
			' ' +
			intformat(left.timestamp.hour24, 2, 1) + 
			intformat(left.timestamp.minute, 2, 1) + 
			intformat(left.timestamp.second, 2, 1);
		self.recordtype := left.statementtype;	// renamed the statement type to be recordtype like krishna's team is doing instead to be more generic since it also includes disputes now as well
		self := left,
		self := []));

empty_ds := dataset([], FFD.layouts.ConsumerStatementBatchFull);

ConsumerStatementResults_temp := if(OutputConsumerStatements, ConsumerStatementResults1, empty_ds);
		
ConsumerStatementResults := join(Results, ConsumerStatementResults_temp, (unsigned)left.lexid=right.uniqueid, 
			transform(FFD.layouts.ConsumerStatementBatchFull, 
			self.acctno := left.acctno, self := right));

			
output(ConsumerStatementResults, named('CSDResults'));  

#else // Else, output the model results directly

/* Use this join for Validation*/
Results := join(batchin_with_seq, search_results, left.seq=right.seq,
		transform( {string30 acctno, recordof(search_results)},
			self.acctno := left.acctno;
			self := right, self := []), left outer);  // make this a left outer join to put the original inputs back in 

output(Results, named('Results'));
#end

/*--HELP-- 
<pre>
&lt;Batch_In&gt;
  &lt;Row&gt;
    	&lt;AcctNo&gt;123&lt;/AcctNo&gt;
    	&lt;LexID&gt;&lt;/LexID&gt;
    	&lt;SSN&gt;&lt;/SSN&gt;
    	&lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
    	&lt;Name_First&gt;&lt;/Name_First&gt;
    	&lt;Name_Middle&gt;&lt;/Name_Middle&gt;
    	&lt;Name_Last&gt;&lt;/Name_Last&gt;
    	&lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
    	&lt;DOB&gt;&lt;/DOB&gt;
    	&lt;Street_Addr&gt;&lt;/Street_Addr&gt;
    	&lt;P_City_Name&gt;&lt;/P_City_Name&gt;
    	&lt;St&gt;&lt;/St&gt;
    	&lt;Z5&gt;&lt;/Z5&gt;
    	&lt;Age&gt;&lt;/Age&gt;
    	&lt;DL_Number&gt;&lt;/DL_Number&gt;
    	&lt;DL_State&gt;&lt;/DL_State&gt;
    	&lt;Home_Phone&gt;&lt;/Home_Phone&gt;
    	&lt;Work_Phone&gt;&lt;/Work_Phone&gt;
    	&lt;IP_Addr&gt;&lt;/IP_Addr&gt;
      &lt;HistoryDateTimeStamp&gt;&lt;/HistoryDateTimeStamp&gt;
      &lt;custom_input1&gt;&lt;/custom_input1&gt;
  &lt;/Row&gt;
&lt;/Batch_In&gt;
</pre>
*/	

// custom input fields go up to 25, but it's not worth putting all of those in this help section if they are never used

ENDMACRO;

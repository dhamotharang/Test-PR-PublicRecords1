import  gateway, risk_indicators, FFD, STD, Riskview;

export FCRAInsurview2_Batch_Service := MACRO

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
integer2 ReportingPeriod := 84 : stored('ReportingPeriod'); 
string EndUserCompanyName := ''	; // these are used for MLA in riskview, not needed here
string CustomerNumber := '';// these are used for MLA in riskview, not needed here
string SecurityCode := '';// these are used for MLA in riskview, not needed here
boolean IncludeLnJ := false ;
boolean IncludeRecordsWithSSN := false;
boolean IncludeBureauRecs := false;	

string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
STRING DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
boolean OutputConsumerStatements := strFFDOptionsMask_in[1] = '1';
string FilterLienTypes := Risk_Indicators.iid_constants.LnJDefault;
boolean	exception_score_reason := false; // no models requested in Insurview2
boolean RetainInputDID := true;  
boolean isCalifornia_in_person := false;  // always false in batch
STRING6 SSNMask := 'NONE';
STRING6 DOBMask := 'NONE';
BOOLEAN DLMask := FALSE;

RiskView.Layouts.layout_riskview_input getInput(riskview.layouts.Layout_Riskview_Batch_In le, UNSIGNED4 c) := TRANSFORM
	SELF.seq := c;
	SELF := le;
	self := [];
END;
batchin_with_seq := project(batchin, getInput(LEFT, COUNTER));
						 
//error_message := 'Error - Minimum input fields required: First Name, Last Name, Address, and Zip or City and State; LexID only; or First Name, Last Name, and SSN';
// Brad wants to keep error message stating just first/last name, but also allow user to use unparsedfullname field in place of first/last fields if they want
valid_inputs := batchin_with_seq((
							((trim(name_first)<>'' and trim(name_last)<>'') or trim(unparsedfullname)<>'') and  	// name check
							(trim(ssn)<>'' or   																																																		// ssn check
								( trim(street_addr)<>'' and 																																													// address check
								(trim(z5)<>'' OR (trim(p_city_name)<>'' AND trim(St)<>'')))												// zip or city/state check
							)
								 or
							(unsigned)LexID <> 0
						) and ReportingPeriod > 0 and ReportingPeriod <= 84);



boolean	InsuranceMode := TRUE; // This value is set to true for insurance only.
boolean	InsuranceBankruptcyAllow10Yr := TRUE; //Value is true for insurance only.  AllowS bankruptcy records up to 10 years if TRUE.  Default is 7 years for insurance.

						
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
	exception_score_reason,
	InsuranceMode,
	InsuranceBankruptcyAllow10Yr
	);

rvResults := join(batchin_with_seq, search_results, left.seq=right.seq,
			RiskView.Transforms.FormatBatch(left, right),
			left outer);

rva := RiskView.Layouts.layout_riskview5_batch_response;

insurview2_batch_response_layout := record
rva.acctno;
rva.LexID;

rva.InputProvidedFirstName;
rva.InputProvidedLastName;
rva.InputProvidedStreetAddress;
rva.InputProvidedCity;
rva.InputProvidedState;
rva.InputProvidedZipCode;
rva.InputProvidedSSN;
rva.InputProvidedDateofBirth;
rva.InputProvidedPhone;
rva.InputProvidedLexID;

rva.SubjectRecordTimeOldest;
rva.SubjectRecordTimeNewest;
rva.SubjectNewestRecord12Month;
rva.SubjectActivityIndex03Month;
rva.SubjectActivityIndex06Month;
rva.SubjectActivityIndex12Month;
rva.SubjectAge;
rva.SubjectDeceased;
rva.SubjectSSNCount;
rva.SubjectStabilityIndex;
rva.SubjectStabilityPrimaryFactor;
rva.SubjectAbilityIndex;
rva.SubjectAbilityPrimaryFactor;
rva.SubjectWillingnessIndex;
rva.SubjectWillingnessPrimaryFactor;

rva.ConfirmationSubjectFound;
rva.ConfirmationInputName;
rva.ConfirmationInputDOB;
rva.ConfirmationInputSSN;
rva.ConfirmationInputAddress;

rva.SourceNonDerogProfileIndex;
rva.SourceNonDerogCount;
rva.SourceNonDerogCount03Month;
rva.SourceNonDerogCount06Month;
rva.SourceNonDerogCount12Month;
rva.SourceCredHeaderTimeOldest;
rva.SourceCredHeaderTimeNewest;
rva.SourceVoterRegistration;

rva.SSNSubjectCount;
rva.SSNDeceased;
rva.SSNDateLowIssued;
rva.SSNProblems;

rva.AddrOnFileCount;
rva.AddrOnFileCorrectional;
rva.AddrOnFileCollege;
rva.AddrOnFileHighRisk;
rva.AddrInputTimeOldest;
rva.AddrInputTimeNewest;
rva.AddrInputLengthOfRes;
rva.AddrInputSubjectCount;
rva.AddrInputMatchIndex;
rva.AddrInputSubjectOwned;
rva.AddrInputDeedMailing;
rva.AddrInputOwnershipIndex;
rva.AddrInputPhoneService;
rva.AddrInputPhoneCount;
rva.AddrInputDwellType;
rva.AddrInputDwellTypeIndex;
rva.AddrInputDelivery;
rva.AddrInputTimeLastSale;
rva.AddrInputLastSalePrice;
rva.AddrInputTaxValue;
rva.AddrInputTaxYr;
rva.AddrInputTaxMarketValue;
rva.AddrInputAVMValue;
rva.AddrInputAVMValue12Month;
rva.AddrInputAVMValue60Month;
rva.AddrInputAVMRatio12MonthPrior;
rva.AddrInputAVMRatio60MonthPrior;
rva.AddrInputCountyRatio;
rva.AddrInputTractRatio;
rva.AddrInputBlockRatio;
rva.AddrInputProblems;
rva.AddrCurrentTimeOldest;
rva.AddrCurrentTimeNewest;
rva.AddrCurrentLengthOfRes;
rva.AddrCurrentSubjectOwned;
rva.AddrCurrentDeedMailing;
rva.AddrCurrentOwnershipIndex;
rva.AddrCurrentPhoneService;
rva.AddrCurrentDwellType;
rva.AddrCurrentDwellTypeIndex;
rva.AddrCurrentTimeLastSale;
rva.AddrCurrentLastSalesPrice;
rva.AddrCurrentTaxValue;
rva.AddrCurrentTaxYr;
rva.AddrCurrentTaxMarketValue;
rva.AddrCurrentAVMValue;
rva.AddrCurrentAVMValue12Month;
rva.AddrCurrentAVMRatio12MonthPrior;
rva.AddrCurrentAVMValue60Month;
rva.AddrCurrentAVMRatio60MonthPrior;
rva.AddrCurrentCountyRatio;
rva.AddrCurrentTractRatio;
rva.AddrCurrentBlockRatio;
rva.AddrCurrentCorrectional;
rva.AddrPreviousTimeOldest;
rva.AddrPreviousTimeNewest;
rva.AddrPreviousLengthOfRes;
rva.AddrPreviousSubjectOwned;
rva.AddrPreviousOwnershipIndex;
rva.AddrPreviousDwellType;
rva.AddrPreviousDwellTypeIndex;
rva.AddrPreviousCorrectional;


rva.AddrStabilityIndex;
rva.AddrChangeCount03Month;
rva.AddrChangeCount06Month;
rva.AddrChangeCount12Month;
rva.AddrChangeCount24Month;
rva.AddrChangeCount60Month;
rva.AddrLastMoveTaxRatioDiff;
rva.AddrLastMoveEconTrajectory;
rva.AddrLastMoveEconTrajectoryIndex;

rva.PhoneInputProblems;
rva.PhoneInputSubjectCount;
rva.PhoneInputMobile;

rva.EducationAttendance;
rva.EducationEvidence;
rva.EducationProgramAttended;
rva.EducationInstitutionPrivate;
rva.EducationInstitutionRating;

rva.BusinessAssociation;
rva.BusinessAssociationIndex;
rva.BusinessAssociationTimeOldest;
rva.BusinessTitleLeadership;


rva.ProfLicCount;
rva.ProfLicTypeCategory;

rva.AssetIndex;
rva.AssetIndexPrimaryFactor;
rva.AssetOwnership;
rva.AssetProp;
rva.AssetPropIndex;
rva.AssetPropEverCount;
rva.AssetPropCurrentCount;
rva.AssetPropCurrentTaxTotal;
rva.AssetPropPurchaseCount12Month;
rva.AssetPropPurchaseTimeOldest;
rva.AssetPropPurchaseTimeNewest;
rva.AssetPropNewestMortgageType;
rva.AssetPropEverSoldCount;
rva.AssetPropSoldCount12Month;
rva.AssetPropSaleTimeOldest;
rva.AssetPropSaleTimeNewest;
rva.AssetPropNewestSalePrice;
rva.AssetPropSalePurchaseRatio;
rva.AssetPersonal;
rva.AssetPersonalCount;

rva.PurchaseActivityIndex;
rva.PurchaseActivityCount;
rva.PurchaseActivityDollarTotal;

rva.DerogSeverityIndex;
rva.DerogCount;
rva.DerogCount12Month;
rva.DerogTimeNewest;

rva.CriminalFelonyCount;
rva.CriminalFelonyCount12Month;
rva.CriminalFelonyTimeNewest;
rva.CriminalNonFelonyCount;
rva.CriminalNonFelonyCount12Month;
rva.CriminalNonFelonyTimeNewest;

rva.EvictionCount;
rva.EvictionCount12Month;
rva.EvictionTimeNewest;

rva.LienJudgmentSeverityIndex;
rva.LienJudgmentCount;
rva.LienJudgmentCount12Month;
rva.LienJudgmentSmallClaimsCount;
rva.LienJudgmentCourtCount;
rva.LienJudgmentTaxCount;
rva.LienJudgmentForeclosureCount;
rva.LienJudgmentOtherCount;
rva.LienJudgmentTimeNewest;
rva.LienJudgmentDollarTotal;

rva.BankruptcyCount;
rva.BankruptcyCount24Month;
rva.BankruptcyTimeNewest;
rva.BankruptcyChapter;
rva.BankruptcyStatus;
rva.BankruptcyDismissed24Month;

rva.ShortTermLoanRequest;
rva.ShortTermLoanRequest12Month;
rva.ShortTermLoanRequest24Month;

rva.InquiryAuto12Month;
rva.InquiryBanking12Month;
rva.InquiryTelcom12Month;
rva.InquiryNonShortTerm12Month;
rva.InquiryShortTerm12Month;
rva.InquiryCollections12Month;

rva.AlertRegulatoryCondition;
END;

// OUTPUT(batchin_with_seq, NAMED('batchin_with_seq'));
// OUTPUT(search_results, NAMED('search_results'));
results := project(rvResults, transform(insurview2_batch_response_layout, self := left));
output(Results, named('Results')); /*Production*/

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
  
/*--SOAP--
<message name="Insurview2 Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="IntendedPurpose" type="xsd:string"/>
	<part name="AttributesVersionRequest" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="FFDOptionsMask"      type="xsd:string"/>
 <part name="ReportingPeriod" type="xsd:integer"/>
</message>
*/
/*--INFO-- Contains Insurview attributes version 5.0 and higher */


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


ENDMACRO;

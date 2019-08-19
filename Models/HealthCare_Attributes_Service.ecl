/*--SOAP--
<message name="Health Care Attributes Service">
	<part name="HealthCareAttributesRequest" type="tns:XmlDataSet" cols="110" rows="75"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
</message>
*/
/*--INFO-- Health Care Attributes Service -- */
/*--HELP-- 
<pre>
&lt;HealthCareAttributesRequest&gt;
  &lt;Row&gt;
	&lt;User&gt;	
		&lt;ReferenceCode&gt;&lt;/ReferenceCode&gt;
		&lt;BillingCode&gt;&lt;/BillingCode&gt;
		&lt;QueryId&gt;&lt;/QueryId&gt;
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
		&lt;TestDataEnabled&gt;0&lt;/TestDataEnabled&gt;
		&lt;TestDataTableName&gt;&lt;/TestDataTableName&gt; 
	&lt;/User&gt;
	&lt;SearchBy&gt;
		&lt;UniqueId&gt;&lt;/UniqueId&gt;
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
		&lt;HomePhone&gt;&lt;/HomePhone&gt;
		&lt;WorkPhone&gt;&lt;/WorkPhone&gt;
		&lt;DOB&gt;
			&lt;Year&gt;&lt;/Year&gt;
			&lt;Month&gt;&lt;/Month&gt;
			&lt;Day&gt;&lt;/Day&gt;
		&lt;/DOB&gt;
		&lt;SSN&gt;&lt;/SSN&gt;
	&lt;/SearchBy&gt;
	&lt;Options&gt;
		&lt;AttributesVersionRequest&gt;HealthcareAttrV1&lt;/AttributesVersionRequest&gt;
	&lt;/Options&gt;
  &lt;/Row&gt;
&lt;/HealthCareAttributesRequest&gt;
</pre>
*/

IMPORT Address, Risk_Indicators, Models, ut, iesp, gateway, STD;
	
EXPORT HealthCare_Attributes_Service := MACRO
/* ***************************************
	 *             Grab Input:             *
   *************************************** */
  requestIn := DATASET([], iesp.healthcareattributes.t_HealthcareAttributesRequest)  	: STORED('HealthCareAttributesRequest', FEW);
  firstRow 	:= requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	users 		:= GLOBAL(firstRow.User);
	search 		:= GLOBAL(firstRow.SearchBy);
	option		:= GLOBAL(firstRow.Options);
	

/* ***************************************
	 *           Set Search By:            *
   *************************************** */
	// Name
	#stored('UnParsedFullName', search.Name.Full);
	#stored('FirstName', search.Name.First);
	#stored('MiddleName', search.Name.Middle);
	#stored('LastName', search.Name.Last);
	#stored('SuffixName', search.Name.Suffix);
	Risk_Indicators.MAC_unparsedfullname(NamePrefix, NameFirst, NameMiddle, NameLast, NameSuffix, 'FirstName', 'MiddleName', 'LastName', 'SuffixName');
	// Address
	STRING28 	streetName 					:= search.Address.StreetName;
	STRING10 	streetNumber 				:= search.Address.StreetNumber;
	STRING2 	streetPreDirection 	:= search.Address.StreetPreDirection;
	STRING2 	streetPostDirection := search.Address.StreetPostDirection;
	STRING4 	streetSuffix 				:= search.Address.StreetSuffix;
	STRING8 	UnitNumber 					:= search.Address.UnitNumber;
	STRING10 	UnitDesig 					:= search.Address.UnitDesignation;
	STRING60 	tempStreetAddr 			:= Address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
	STRING60 	in_streetAddress1 	:= IF(search.Address.StreetAddress1='', tempStreetAddr, search.Address.StreetAddress1);
	STRING60 	in_streetAddress2 	:= search.Address.StreetAddress2;
	STRING120 streetAddr 					:= TRIM(in_streetAddress1) + ' ' + TRIM(in_streetAddress2);
	STRING10 	UnitDesignation 		:= search.Address.UnitDesignation;
	STRING25 	City 								:= search.Address.City;
	STRING2 	State 							:= search.Address.State;
	STRING5 	Zip 								:= search.Address.Zip5;
	STRING18 	County 							:= search.Address.County;
	// Other PII
	string10 	HomePhone 					:= search.HomePhone;
	string10 	WorkPhone 					:= search.WorkPhone;
	STRING8 	DateOfBirth 				:= iesp.ECL2ESP.t_DateToString8(search.DOB);
	STRING9 	SSN 								:= search.SSN;
	
/* ***************************************
	 *             Set Options:            *
   *************************************** */
	 
	unsigned1 attributesVersion := map(
		STD.Str.ToLowerCase(option.AttributesVersionRequest[1..15]) = 'healthcareattrv' => (unsigned1)option.AttributesVersionRequest[16..],
		(unsigned1)option.AttributesVersionRequest
	);
	 
	UNSIGNED3 historyDate 		:= 999999 : STORED('HistoryDateYYYYMM');
	gateways 									:= Gateway.Constants.void_gateway;
	
/* ***************************************
	 *           Set User Values:          *
   *************************************** */
	 
	// STRING50 	DataRestriction 	:= risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	// STRING10 	DataPermission 		:= Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
	string50	DataRestriction 			:= AutoStandardI.GlobalModule().DataRestrictionMask;
	string10	DataPermission 		:= AutoStandardI.GlobalModule().DataPermissionMask;
	UNSIGNED1 DPPAPurpose 			:= IF(TRIM(users.DLPurpose) = '', 0, (UNSIGNED1)users.DLPurpose);
	UNSIGNED1 GLBPurpose 				:= IF(TRIM(users.GLBPurpose) = '', 0, (UNSIGNED1)users.GLBPurpose);
  STRING20 	AccountNumber 		:= users.AccountNumber;
	BOOLEAN 	TestDataEnabled 	:= users.TestDataEnabled;  //*** kwh - how does these 'Testdata' fields get populated...they are not on input?
	STRING32 	TestDataTableName := users.TestDataTableName;
  
//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');
	
	// Sequence - This is hidden from the ESP to be used by the ECL Developers for testing purposes
	STRING30 Seq := IF((integer)AccountNumber = 0, '1', (string)(integer)AccountNumber);

/* ***************************************
	 *            Validate Input:          *
   *************************************** */

	IF(TRIM(users.GLBPurpose) IN ['', '-'], FAIL('GLB permissible purpose is required to utilize this product.'));

	/* ***************************************
	 *           Package Input:            *
   *************************************** */
   
    packagedInput := DATASET([TRANSFORM(Models.layouts.Layout_HealthCare_Attributes_In,
        SELF.Seq 						:= Seq;
		SELF.FirstName 			:= STD.Str.ToUpperCase(NameFirst);
		SELF.MiddleName 		:= STD.Str.ToUpperCase(NameMiddle);
		SELF.LastName 			:= STD.Str.ToUpperCase(NameLast);
		SELF.SuffixName 		:= STD.Str.ToUpperCase(NameSuffix);
		SELF.streetAddr   	:= STD.Str.ToUpperCase(streetAddr);
		SELF.City         	:= STD.Str.ToUpperCase(City);
		SELF.State        	:= STD.Str.ToUpperCase(State);
		SELF.Zip          	:= Zip;
		SELF.County        	:= STD.Str.ToUpperCase(County);
		SELF.HomePhone 			:= HomePhone;
		SELF.WorkPhone 			:= WorkPhone;
		SELF.DateOfBirth 		:= DateOfBirth;
		SELF.SSN 						:= SSN;
		SELF.AccountNumber 	:= AccountNumber;
		self.DID 						:= (unsigned)search.UniqueId;
		SELF.HistoryDate 		:= historydate;
		SELF 								:= [])] );
  
    packagedTestseedInput := DATASET([TRANSFORM(Risk_Indicators.Layout_Input,
        SELF.seq := (INTEGER)Seq;
		SELF.fname := STD.Str.ToUpperCase(NameFirst);
		SELF.lname := STD.Str.ToUpperCase(NameLast);
		SELF.ssn := SSN;
		SELF.in_zipCode := Zip;
		SELF.phone10 := homephone;
		SELF := [])] );
	
/* ***************************************
	 *      Gather Attributes/Scores:      *
   *************************************** */
	 
	FunctionResults := IF(TestDataEnabled, 
		Models.HealthCare_Attributes_TestSeed_Function(packagedTestseedInput, TestDataTableName),	// TestSeed Values  
		Models.HealthCare_Attributes_Search_Function(packagedInput, GLBPurpose, DPPAPurpose, DataRestriction, DataPermission, 
    LexIdSourceOptout := LexIdSourceOptout, 
    TransactionID := TransactionID, 
    BatchUID := BatchUID, 
    GlobalCompanyID := GlobalCompanyID) // Realtime Values
	);	 
	 
/* ***************************************
	 *  Convert Attribute Results to ESDL: *
   *************************************** */
	iesp.share.t_NameValuePair intoVersion1(FunctionResults le, INTEGER c) := TRANSFORM
		SELF.name := MAP(
			c=1 => 'EstimatedHHIncome',
			c=2 => 'EstimatedHHSize',
			c=3 => 'CensusAveHHSize',
			c=4 => 'HHOccupantDescription',
			''
		);

		SELF.value := MAP(
			c=1 => (string)le.EstimatedHHIncome,
			c=2 => (string)le.EstimatedHHSize,
			c=3 => (string)le.CensusAveHHSize,
			c=4 => le.HHOccupantDescription,
			''
		);
	END;

	nameValuePairsVersion1 :=  NORMALIZE(FunctionResults, 4, intoVersion1(LEFT, COUNTER));

/* ***************************************
	 *      Combine the Final Results:     *
   *************************************** */

HCA_record := record
  iesp.healthcareattributes.t_HealthcareAttributesResponse;
end;

HCA_record intoFinal(FunctionResults le) := TRANSFORM
	SELF._Header := [];
	SELF.Result.UniqueId := le.did;
	SELF.Result.InputEcho := search;
	SELF.Result.Attributes := case( attributesVersion,
		1 => nameValuePairsVersion1,
				 DATASET([], iesp.share.t_NameValuePair));
	SELF := [];
END;

Results := PROJECT(FunctionResults, intoFinal(LEFT));
OUTPUT(Results, NAMED('Results'));

ENDMACRO;

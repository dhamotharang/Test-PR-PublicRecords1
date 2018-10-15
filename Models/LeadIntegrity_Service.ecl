/*--SOAP--
<message name="Lead Integrity Service">
	<part name="LeadIntegrityRequest" type="tns:XmlDataSet" cols="110" rows="75"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="DisableDoNotMailMask" type="xsd:boolean"/>
  <part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/> 
</message>
*/
/*--INFO-- Lead Integrity Service -- ITA Attributes via ESDL*/
/*--HELP-- 
<pre>
&lt;LeadIntegrityRequest&gt;
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
      &lt;HomePhone&gt;&lt;/HomePhone&gt;
      &lt;WorkPhone&gt;&lt;/WorkPhone&gt;
      &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt;
      &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt;
    &lt;/SearchBy&gt;
    &lt;Options&gt;
      &lt;AttributesVersionRequest&gt;4&lt;/AttributesVersionRequest&gt;
      &lt;IncludeModels&gt;
        &lt;Integrity&gt;&lt;/Integrity&gt;
      &lt;/IncludeModels&gt;
      &lt;DisableDoNotMailMask&gt;&lt;/DisableDoNotMailMask&gt;
    &lt;/Options&gt;
    &lt;User&gt;
      &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt;
      &lt;BillingCode&gt;&lt;/BillingCode&gt;
      &lt;QueryId&gt;&lt;/QueryId&gt;
      &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
      &lt;GLBPurpose&gt;5&lt;/GLBPurpose&gt;
      &lt;DLPurpose&gt;0&lt;/DLPurpose&gt;
      &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt; 
      &lt;TestDataEnabled&gt;0&lt;/TestDataEnabled&gt; 
      &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt; 
    &lt;/User&gt;
  &lt;/Row&gt;
&lt;/LeadIntegrityRequest&gt;
</pre>
*/

IMPORT Address, Risk_Indicators, Models, RiskWise, Risk_Reporting, ut, dma, doxie, iesp, gateway, Inquiry_AccLogs, STD;
	
EXPORT LeadIntegrity_Service := MACRO

  // Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
	
/* ***************************************
	 *             Grab Input:             *
   *************************************** */
  requestIn := DATASET([], iesp.leadintegrity.t_LeadIntegrityRequest)  	: STORED('LeadIntegrityRequest', FEW);
  firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	search := GLOBAL(firstRow.SearchBy);
	option := GLOBAL(firstRow.Options);
	users := GLOBAL(firstRow.User);
	
/* **********************************************
	 *  Fields needed for improved Scout Logging  *
	 **********************************************/
	string32 _LoginID               := ''	: STORED('_LoginID');
	outofbandCompanyID							:= '' : STORED('_CompanyID');
	string20 CompanyID              := if(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
	string20 FunctionName           := '' : STORED('_LogFunctionName');
	string50 ESPMethod              := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
	string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
	outofbandssnmask                := '' : STORED('SSNMask');
	string10 SSN_Mask               := if(users.SSNMask != '', users.SSNMask, outofbandssnmask);
	outofbanddobmask                := '' : STORED('DOBMask');
	string10 DOB_Mask               := if(users.DOBMask != '', users.DOBMask, outofbanddobmask);
	BOOLEAN DL_Mask                 := users.DLMask;
	BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
	BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');
	
	BOOLEAN OutofBandOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	DisableOutcomeTracking := OutofBandOutcomeTracking OR users.OutcomeTrackingOptOut;
	#stored('DisableBocaShellLogging', DisableOutcomeTracking);

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Models__LeadIntegrity_Service);
/* ************* End Scout Fields **************/

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
	STRING120 streetAddr := TRIM(in_streetAddress1) + ' ' + TRIM(in_streetAddress2);
	STRING10 UnitDesignation := search.Address.UnitDesignation;
	STRING25 City := search.Address.City;
	STRING2 State := search.Address.State;
	STRING5 Zip := search.Address.Zip5;
	STRING18 County := search.Address.County;
	// Other PII
	STRING8 DateOfBirth := iesp.ECL2ESP.t_DateToString8(search.DOB);
	STRING9 SSN := search.SSN;
	STRING10 HomePhone := search.HomePhone;
	STRING10 WorkPhone := search.WorkPhone;
	STRING15 DLNumber := search.DriverLicenseNumber;
	STRING2 DLState := search.DriverLicenseState;
	
/* ***************************************
	 *             Set Options:            *
   *************************************** */
	STRING16 modelName := StringLib.StringToLowerCase(TRIM(option.IncludeModels.Integrity));

	unsigned1 attributesVersion := map(
		modelname = 'msn1210_1' 	=> 4,  //this model creates score from V4 attributes but does not return them - so set version internally 
		// LeadIntegrityAttrV4 (etc) is now also a valid input
		StringLib.StringToLowerCase(option.AttributesVersionRequest[1..18]) = 'leadintegrityattrv' => (unsigned1)option.AttributesVersionRequest[19..],
		(unsigned1)option.AttributesVersionRequest
	);

	STRING8 date_in := iesp.ECL2ESP.t_DateToString8(option.HistoryDate)[1..6];
	UNSIGNED3 historyDate := if(TRIM(date_in) <> '', (INTEGER)date_in, 999999); 
	
	UNSIGNED6 did_value := (UNSIGNED6)search.UniqueId;
	
	BOOLEAN DisableDNMMask_stored := FALSE : STORED('DisableDoNotMailMask');
	BOOLEAN DisableDNMMask := DisableDNMMask_stored OR option.DisableDoNotMailFilter;
  unsigned1 ofac_version      := 1        : stored('OFACVersion');
  
  gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := if(ofac_version = 4 and le.servicename = 'bridgerwlc',le.servicename, '');
	self.url := if(ofac_version = 4 and le.servicename = 'bridgerwlc', le.url, ''); 		
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

/* ***************************************
	 *           Set User Values:          *
   *************************************** */
  STRING outOfBandDataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
  STRING50 DataRestriction := IF(TRIM(users.DataRestrictionMask) <> '', users.DataRestrictionMask, outOfBandDataRestriction);
	
  STRING50 outOfBandDataPermission := '' : STORED('DataPermissionMask');
  STRING50 DataPermission := MAP(TRIM(users.DataPermissionMask) <> '' => users.DataPermissionMask,
                                  TRIM(outOfBandDataPermission) <> ''  => outOfBandDataPermission,
                                                                           Risk_Indicators.iid_constants.default_DataPermission);

	UNSIGNED1 prep_dppa := IF(TRIM(users.DLPurpose) = '', 0, (UNSIGNED1)users.DLPurpose);
	UNSIGNED1 DPPAPurpose := IF(~DisableDNMMask, 0, prep_dppa);
	UNSIGNED1 GLBPurpose := IF(TRIM(users.GLBPurpose) = '', 5, (UNSIGNED1)users.GLBPurpose);
  STRING20 AccountNumber := users.AccountNumber;
	BOOLEAN TestDataEnabled := users.TestDataEnabled;
	STRING32 TestDataTableName := users.TestDataTableName;
	
	// Sequence - This is hidden from the ESP to be used by the ECL Developers for testing purposes
	STRING30 Seq := IF((integer)AccountNumber = 0, '1', (string)(integer)AccountNumber);


/* ***************************************
	 *            Validate Input:          *
   *************************************** */
	IF(TRIM(users.DLPurpose) NOT IN ['','0'], FAIL('There is no DPPA permissible purpose for this product.'));
	IF(TRIM(users.GLBPurpose) IN ['', '-'], FAIL('GLB permissible purpose is required to utilize this product.'));
	
/* ***************************************
	 *           Package Input:            *
   *************************************** */
	Models.Layout_LeadIntegrity_In intoInput() := TRANSFORM
		SELF.Seq := Seq;
		SELF.FirstName := StringLib.StringToUpperCase(NameFirst);
		SELF.MiddleName := StringLib.StringToUpperCase(NameMiddle);
		SELF.LastName := StringLib.StringToUpperCase(NameLast);
		SELF.SuffixName := StringLib.StringToUpperCase(NameSuffix);
		SELF.streetAddr   := StringLib.StringToUpperCase(streetAddr);
		SELF.City         := StringLib.StringToUpperCase(City);
		SELF.State        := StringLib.StringToUpperCase(State);
		SELF.Zip          := Zip;
		SELF.DateOfBirth := DateOfBirth;
		SELF.SSN := SSN;
		SELF.HomePhone := HomePhone;
		SELF.WorkPhone := WorkPhone;
		SELF.DLNumber := DLNumber;
		SELF.DLState := StringLib.StringToUpperCase(DLState);
		SELF.AccountNumber := AccountNumber;
		self.DID := did_value; 		
		SELF := [];
	END;

	packagedInput := DATASET([intoInput()]);
	
	Risk_Indicators.Layout_Input intoLayoutInput() := TRANSFORM
		SELF.seq := (INTEGER)Seq;
		SELF.fname := StringLib.StringToUpperCase(NameFirst);
		SELF.lname := StringLib.StringToUpperCase(NameLast);
		SELF.ssn := SSN;
		SELF.in_zipCode := Zip;
		SELF.phone10 := HomePhone;
		SELF := [];
	END;

	packagedTestseedInput := DATASET([intoLayoutInput()]);

/* ***************************************
	 *      Gather Attributes/Scores:      *
   *************************************** */
	results := IF(TestDataEnabled, 
		Models.LeadIntegrity_TestSeed_Function(packagedTestseedInput, TestDataTableName, modelname, attributesVersion),	// TestSeed Values
		Models.LeadIntegrity_Search_Function(packagedInput, GLBPurpose, DPPAPurpose, historyDate, DataRestriction, attributesVersion, modelName, DisableDNMMask, DataPermission) // Realtime Values
	);

/* ***************************************
	 *  Convert Attribute Results to ESDL: *
   *************************************** */
	iesp.share.t_NameValuePair intoVersion1(results le, INTEGER c) := TRANSFORM
		SELF.name := MAP(
											c=1 => 'SubjectFirstSeen',
											c=2 => 'DateLastUpdate',
											c=3 => 'RecentUpdate',
											c=4 => 'NumSrcsConfirmIDAddr',
											c=5 => 'PhoneFullNameMatch',
											c=6 => 'PhoneLastNameMatch',
											c=7 => 'AgeRiskIndicator',
											c=8 => 'InvalidSSN',
											c=9 => 'InvalidPhone',
											c=10 => 'InvalidAddr',
											c=11 => 'NoVerifyNameAddrPhoneSSN',
											c=12 => 'SSNDeceased',
											c=13 => 'DateSSNDeceased',
											c=14 => 'SSNIssued',
											c=15 => 'RecentSSN',
											c=16 => 'LowIssueDate',
											c=17 => 'HighIssueDate',
											c=18 => 'SSNIssueState',
											c=19 => 'NonUSssn',
											c=20 => 'SSN3Years',
											c=21 => 'SSNAfter5',
											c=22 => 'SSNProbs',
											c=23 => 'SSNNotFound',
											c=24 => 'SSNFoundOther',
											c=25 => 'SSNIssuedPrior',
											c=26 => 'PhoneOther',
											c=27 => 'SSNPerID',
											c=28 => 'AddrPerID',
											c=29 => 'PhonePerID',
											c=30 => 'IDPerSSN',
											c=31 => 'AddrPerSSN',
											c=32 => 'IDPerAddr',
											c=33 => 'SSNPerAddr',
											c=34 => 'PhonePerAddr',
											c=35 => 'IDPerPhone',
											c=36 => 'SSNPerID6',
											c=37 => 'AddrPerID6',
											c=38 => 'PhonePerID6',
											c=39 => 'IDPerSSN6',
											c=40 => 'AddrPerSSN6',
											c=41 => 'IDPerAddr6',
											c=42 => 'SSNPerAddr6',
											c=43 => 'PhonePerAddr6',
											c=44 => 'IDPerPhone6',
											c=45 => 'LastNamePerSSN',
											c=46 => 'LastNamePerID',
											c=47 => 'TimeSinceLastName',	
											c=48 => 'LastNames30',
											c=49 => 'LastNames90',
											c=50 => 'LastNames180',
											c=51 => 'LastNames12',
											c=52 => 'LastNames24',
											c=53 => 'LastNames36',
											c=54 => 'LastNames60',
											c=55 => 'IDPerSFDUAddr',
											c=56 => 'SSNPerSFDUAddr',
											c=57 => 'TimeSinceInputAddrFirstSeen',
											c=58 => 'TimeSinceInputAddrLastSeen',
											c=59 => 'InputAddrLenOfRes',
											c=60 => 'InputAddrDwellType',
											c=61 => 'InputAddrLandUseCode',
											c=62 => 'InputAddrAssessedValue',
											c=63 => 'InputAddrTaxAssessedYr',
											c=64 => 'InputAddrApplicantOwned',
											c=65 => 'InputAddrFamilyOwned',
											c=66 => 'InputAddrOccupantOwned',
											c=67 => 'InputAddrLastSalesDate',
											c=68 => 'InputAddrLastSalesAmount',	
											c=69 => 'InputAddrNotPrimaryRes',
											c=70 => 'InputAddrActivePhoneList',
											c=71 => 'InputAddrActivePhoneNumber',
											c=72 => 'InputAddrMedianIncome',
											c=73 => 'InputAddrMedianHomeVal',
											c=74 => 'InputAddrMurderIndex',
											c=75 => 'InputAddrCarTheftIndex',
											c=76 => 'InputAddrBurglaryIndex',
											c=77 => 'InputAddrCrimeIndex',
											c=78 => 'InputAddrAssessMarket',
											c=79 => 'InputAddrTaxAssessVal',
											c=80 => 'InputAddrPriceIndVal',
											c=81 => 'InputAddrHedVal',
											c=82 => 'InputAddrAutoVal',
											c=83 => 'InputAddrConfScore',
											c=84 => 'InputAddrCountyIndex',
											c=85 => 'InputAddrTractIndex',
											c=86 => 'InputAddrBlockIndex',
											c=87 => 'TimeSinceCurrAddrFirstSeen',
											c=88 => 'TimeSinceCurrAddrLastSeen',
											c=89 => 'CurrAddrLenOfRes',
											c=90 => 'CurrAddrDwellType',
											c=91 => 'CurrAddrLandUseCode',
											c=92 => 'CurrAddrAssessedValue',
											c=93 => 'CurrAddrTaxAssessedYr',
											c=94 => 'CurrAddrApplicantOwned',
											c=95 => 'CurrAddrFamilyOwned',
											c=96 => 'CurrAddrOccupantOwned',
											c=97 => 'CurrAddrLastSalesDate',
											c=98 => 'CurrAddrLastSalesAmount',	
											c=99 => 'CurrAddrNotPrimaryRes',
											c=100 => 'CurrAddrActivePhoneList',
											c=101 => 'CurrAddrActivePhoneNumber',
											c=102 => 'CurrAddrMedianIncome',
											c=103 => 'CurrAddrMedianHomeVal',
											c=104 => 'CurrAddrMurderIndex',
											c=105 => 'CurrAddrCarTheftIndex',
											c=106 => 'CurrAddrBurglaryIndex',
											c=107 => 'CurrAddrCrimeIndex',
											c=108 => 'CurrAddrAssessMarket',
											c=109 => 'CurrAddrTaxAssessVal',
											c=110 => 'CurrAddrPriceIndVal',
											c=111 => 'CurrAddrHedVal',
											c=112 => 'CurrAddrAutoVal',
											c=113 => 'CurrAddrConfScore',
											c=114 => 'CurrAddrCountyIndex',
											c=115 => 'CurrAddrTractIndex',
											c=116 => 'CurrAddrBlockIndex',
											c=117 => 'TimeSincePrevAddrFirstSeen',
											c=118 => 'TimeSincePrevAddrLastSeen',
											c=119 => 'PrevAddrLenOfRes',
											c=120 => 'PrevAddrDwellType',
											c=121 => 'PrevAddrLandUseCode',
											c=122 => 'PrevAddrAssessedValue',
											c=123 => 'PrevAddrTaxAssessedYr',	
											c=124 => 'PrevAddrApplicantOwned',
											c=125 => 'PrevAddrFamilyOwned',
											c=126 => 'PrevAddrOccupantOwned',
											c=127 => 'PrevAddrLastSalesDate',
											c=128 => 'PrevAddrLastSalesAmount',	
											c=129 => 'PrevAddrNotPrimaryRes',
											c=130 => 'PrevAddrActivePhoneList',
											c=131 => 'PrevAddrActivePhoneNumber',
											c=132 => 'PrevAddrMedianIncome',
											c=133 => 'PrevAddrMedianHomeVal',
											c=134 => 'PrevAddrMurderIndex',
											c=135 => 'PrevAddrCarTheftIndex',
											c=136 => 'PrevAddrBurglaryIndex',
											c=137 => 'PrevAddrCrimeIndex',
											c=138 => 'PrevAddrAssessMarket',
											c=139 => 'PrevAddrTaxAssessVal',
											c=140 => 'PrevAddrPriceIndVal',
											c=141 => 'PrevAddrHedVal',
											c=142 => 'PrevAddrAutoVal',
											c=143 => 'PrevAddrConfScore',
											c=144 => 'PrevAddrCountyIndex',
											c=145 => 'PrevAddrTractIndex',
											c=146 => 'PrevAddrBlockIndex',
											c=147 => 'InputAddrCurrAddrMatch',
											c=148 => 'InputAddrCurrAddrDistance',
											c=149 => 'InputAddrCurrAddrStateDiff',
											c=150 => 'InputAddrCurrAddrAssessedDiff',
											c=151 => 'InputAddrCurrAddrIncomeDiff',
											c=152 => 'InputAddrCurrAddrHomeValDiff',
											c=153 => 'InputAddrCurrAddrCrimeDiff',
											c=154 => 'EconomicTrajectory',
											c=155 => 'InputAddrPrevAddrMatch',
											c=156 => 'CurrAddrPrevAddrDistance',
											c=157 => 'CurrAddrPrevAddrStateDiff',
											c=158 => 'CurrAddrPrevAddrAssessedDiff',
											c=159 => 'CurrAddrPrevAddrIncomeDiff',
											c=160 => 'CurrAddrPrevAddrHomeValDiff',
											c=161 => 'CurrAddrPrevAddrCrimeDiff',
											c=162 => 'EconomicTrajectory2',
											c=163 => 'AddrStability',
											c=164 => 'StatusMostRecent',
											c=165 => 'StatusPrevious',
											c=166 => 'StatusNextPrevious',
											c=167 => 'TimeSincePrevAddrDateFirstSeen',
											c=168 => 'TimeSinceNextPrevDateFirstSeen',
											c=169 => 'AddrChanges30',
											c=170 => 'AddrChanges90',
											c=171 => 'AddrChanges180',
											c=172 => 'AddrChanges12',
											c=173 => 'AddrChanges24',
											c=174 => 'AddrChanges36',
											c=175 => 'AddrChanges60',
											c=176 => 'PropertyOwnedTotal',
											c=177 => 'PropertyOwnedAssessedTotal',
											c=178 => 'PropertyHistoricallyOwned',
											c=179 => 'DateFirstPurchase',
											c=180 => 'DateMostRecentPurchase',
											c=181 => 'DateMostRecentSale',
											c=182 => 'PropPurchased30',
											c=183 => 'PropPurchased90',
											c=184 => 'PropPurchased180',
											c=185 => 'PropPurchased12',
											c=186 => 'PropPurchased24',
											c=187 => 'PropPurchased36',
											c=188 => 'PropPurchased60',
											c=189 => 'PropSold30',
											c=190 => 'PropSold90',
											c=191 => 'PropSold180',
											c=192 => 'PropSold12',
											c=193 => 'PropSold24',
											c=194 => 'PropSold36',
											c=195 => 'PropSold60',
											c=196 => 'NumWatercraft',
											c=197 => 'NumWatercraft30',
											c=198 => 'NumWatercraft90',
											c=199 => 'NumWatercraft180',
											c=200 => 'NumWatercraft12',
											c=201 => 'NumWatercraft24',
											c=202 => 'NumWatercraft36',
											c=203 => 'NumWatercraft60',
											c=204 => 'NumAircraft',
											c=205 => 'NumAircraft30',
											c=206 => 'NumAircraft90',
											c=207 => 'NumAircraft180',
											c=208 => 'NumAircraft12',
											c=209 => 'NumAircraft24',
											c=210 => 'NumAircraft36',
											c=211 => 'NumAircraft60',
											c=212 => 'WealthIndex',
											c=213 => 'TotalNumberDerogs',
											c=214 => 'DateLastDerog',
											c=215 => 'NumFelonies',
											c=216 => 'DateLastConviction',
											c=217 => 'NumFelonies30',
											c=218 => 'NumFelonies90',
											c=219 => 'NumFelonies180',
											c=220 => 'NumFelonies12',
											c=221 => 'NumFelonies24',
											c=222 => 'NumFelonies36',
											c=223 => 'NumFelonies60',
											c=224 => 'NumArrests',
											c=225 => 'DateLastArrest',
											c=226 => 'NumArrests30',
											c=227 => 'NumArrests90',
											c=228 => 'NumArrests180',
											c=229 => 'NumArrests12',
											c=230 => 'NumArrests24',
											c=231 => 'NumArrests36',
											c=232 => 'NumArrests60',
											c=233 => 'LiensCount',
											c=234 => 'LiensUnreleasedCount',
											c=235 => 'MostRecentUnrelDate',
											c=236 => 'LiensUnreleasedCount30',
											c=237 => 'LiensUnreleasedCount90',
											c=238 => 'LiensUnreleasedCount180',
											c=239 => 'LiensUnreleasedCount12',
											c=240 => 'LiensUnreleasedCount24',
											c=241 => 'LiensUnreleasedCount36',
											c=242 => 'LiensUnreleasedCount60',
											c=243 => 'LiensReleasedCount',
											c=244 => 'MostRecentReleasedDate',
											c=245 => 'LiensReleasedCount30',
											c=246 => 'LiensReleasedCount90',
											c=247 => 'LiensReleasedCount180',
											c=248 => 'LiensReleasedCount12',
											c=249 => 'LiensReleasedCount24',
											c=250 => 'LiensReleasedCount36',
											c=251 => 'LiensReleasedCount60',
											c=252 => 'BankruptCount',
											c=253 => 'MostRecentBankruptDate',
											c=254 => 'MostRecentBankruptType',
											c=255 => 'MostRecentBankruptStatus',
											c=256 => 'BankruptCount30',
											c=257 => 'BankruptCount90',
											c=258 => 'BankruptCount180',
											c=259 => 'BankruptCount12',
											c=260 => 'BankruptCount24',
											c=261 => 'BankruptCount36',
											c=262 => 'BankruptCount60',
											c=263 => 'EvictionCount',
											c=264 => 'MostRecentEvictionDate',
											c=265 => 'EvictionCount30',
											c=266 => 'EvictionCount90',
											c=267 => 'EvictionCount180',
											c=268 => 'EvictionCount12',
											c=269 => 'EvictionCount24',
											c=270 => 'EvictionCount36',
											c=271 => 'EvictionCount60',
											c=272 => 'NonDerogSrcCount',
											c=273 => 'NonDerogSrcCount30',
											c=274 => 'NonDerogSrcCount90',
											c=275 => 'NonDerogSrcCount180',
											c=276 => 'NonDerogSrcCount12',
											c=277 => 'NonDerogSrcCount24',
											c=278 => 'NonDerogSrcCount36',
											c=279 => 'NonDerogSrcCount60',
											c=280 => 'ProfLicCount',
											c=281 => 'MostRecentProfLicDate',
											c=282 => 'MostRecentProfLicExpireDate',
											c=283 => 'ProfLicCount30',
											c=284 => 'ProfLicCount90',
											c=285 => 'ProfLicCount180',
											c=286 => 'ProfLicCount12',
											c=287 => 'ProfLicCount24',
											c=288 => 'ProfLicCount36',
											c=289 => 'ProfLicCount60',
											c=290 => 'ProfLicExpireCount30',
											c=291 => 'ProfLicExpireCount90',
											c=292 => 'ProfLicExpireCount180',
											c=293 => 'ProfLicExpireCount12',
											c=294 => 'ProfLicExpireCount24',
											c=295 => 'ProfLicExpireCount36',
											c=296 => 'ProfLicExpireCount60',
											c=297 => 'InputAddrHighRisk',
											c=298 => 'InputPhoneHighRisk',
											c=299 => 'SIC',
											c=300 => 'InputAddrPrison',
											c=301 => 'InputZipPOBox',
											c=302 => 'InputZipCorpMil',
											c=303 => 'InputPhoneStatus',
											c=304 => 'InputPhonePager',
											c=305 => 'InputPhoneMobile',
											c=306 => 'TimeSinceSubjectPhoneFirstSeen',
											c=307 => 'TimeSinceSubjectPhoneLastSeen',
											c=308 => 'InvalidPhoneZip',
											c=309 => 'InputPhoneAddrDist',
											c=310 => 'PhoneType',
											c=311 => 'ServiceType',
											c=312 => 'AreaCodeChange',
											c=313 => 'AddrVal',
											c=314 => 'AddrValErrorCode',
															 'DoNotMail'
										);
																																							// Output Attribute Name:
		SELF.value := MAP(																												// ======================
											c=1 => le.SubjectFirstSeen,															// SubjectFirstSeen
											c=2 => le.DateLastUpdate,																// DateLastUpdate
											c=3 => le.RecentUpdate,																	// RecentUpdate
											c=4 => le.NumSrcsConfirmIDAddr,													// NumSrcsConfirmIDAddr
											c=5 => le.PhoneFullNameMatch,														// PhoneFullNameMatch
											c=6 => le.PhoneLastNameMatch,														// PhoneLastNameMatch
											c=7 => le.AgeRiskIndicator,															// AgeRiskIndicator
											c=8 => le.InvalidSSN,																		// InvalidSSN
											c=9 => le.InvalidPhone,																	// InvalidPhone
											c=10 => le.InvalidAddr,																	// InvalidAddr
											c=11 => le.NoVerifyNameAddrPhoneSSN,										// NoVerifyNameAddrPhoneSSN
											c=12 => le.SSNDeceased,																	// SSNDeceased
											c=13 => le.DateSSNDeceased,															// DateSSNDeceased
											c=14 => le.SSNIssued,																		// SSNIssued
											c=15 => le.RecentSSN,																		// RecentSSN
											c=16 => le.LowIssueDate,																// LowIssueDate
											c=17 => le.HighIssueDate,																// HighIssueDate
											c=18 => le.SSNIssueState,																// SSNIssueState
											c=19 => le.NonUSssn,																		// NonUSssn
											c=20 => le.SSN3Years,																		// SSN3Years
											c=21 => le.SSNAfter5,																		// SSNAfter5
											c=22 => le.SSNProbs,																		// SSNProbs
											c=23 => le.SSNNotFound,																	// SSNNotFound
											c=24 => le.SSNFoundOther,																// SSNFoundOther
											c=25 => le.SSNIssuedPrior,															// SSNIssuedPrior
											c=26 => le.PhoneOther,																	// PhoneOther
											c=27 => le.SSNPerID,																		// SSNPerID
											c=28 => le.AddrPerID,																		// AddrPerID
											c=29 => le.PhonePerID,																	// PhonePerID
											c=30 => le.IDPerSSN,																		// IDPerSSN
											c=31 => le.AddrPerSSN,																	// AddrPerSSN
											c=32 => le.IDPerAddr,																		// IDPerAddr
											c=33 => le.SSNPerAddr,																	// SSNPerAddr
											c=34 => le.PhonePerAddr,																// PhonePerAddr
											c=35 => le.IDPerPhone,																	// IDPerPhone
											c=36 => le.SSNPerID6,																		// SSNPerID6
											c=37 => le.AddrPerID6,																	// AddrPerID6
											c=38 => le.PhonePerID6,																	// PhonePerID6
											c=39 => le.IDPerSSN6,																		// IDPerSSN6
											c=40 => le.AddrPerSSN6,																	// AddrPerSSN6
											c=41 => le.IDPerAddr6,																	// IDPerAddr6
											c=42 => le.SSNPerAddr6,																	// SSNPerAddr6
											c=43 => le.PhonePerAddr6,																// PhonePerAddr6
											c=44 => le.IDPerPhone6,																	// IDPerPhone6
											c=45 => le.LastNamePerSSN,															// LastNamePerSSN
											c=46 => le.LastNamePerID,																// LastNamePerID
											c=47 => le.TimeSinceLastName,														// TimeSinceLastName
											c=48 => le.LastNames30,																	// LastNames30
											c=49 => le.LastNames90,																	// LastNames90
											c=50 => le.LastNames180,																// LastNames180
											c=51 => le.LastNames12,																	// LastNames12
											c=52 => le.LastNames24,																	// LastNames24
											c=53 => le.LastNames36,																	// LastNames36
											c=54 => le.LastNames60,																	// LastNames60
											c=55 => le.IDPerSFDUAddr,																// IDPerSFDUAddr
											c=56 => le.SSNPerSFDUAddr,															// SSNPerSFDUAddr
											c=57 => le.TimeSinceInputAddrFirstSeen,									// TimeSinceInputAddrFirstSeen
											c=58 => le.TimeSinceInputAddrLastSeen,									// TimeSinceInputAddrLastSeen
											c=59 => le.InputAddrLenOfRes,														// InputAddrLenOfRes
											c=60 => le.InputAddrDwellType,													// InputAddrDwellType
											c=61 => le.InputAddrLandUseCode,												// InputAddrLandUseCode
											c=62 => le.InputAddrAssessedValue,											// InputAddrAssessedValue
											c=63 => le.InputAddrTaxAssessedYr,											// InputAddrTaxAssessedYr
											c=64 => le.InputAddrApplicantOwned,											// InputAddrApplicantOwned
											c=65 => le.InputAddrFamilyOwned,												// InputAddrFamilyOwned
											c=66 => le.InputAddrOccupantOwned,											// InputAddrOccupantOwned
											c=67 => le.InputAddrLastSalesDate,											// InputAddrLastSalesDate
											c=68 => le.InputAddrLastSalesAmount,										// InputAddrLastSalesAmount
											c=69 => le.InputAddrNotPrimaryRes,											// InputAddrNotPrimaryRes
											c=70 => le.InputAddrActivePhoneList,										// InputAddrActivePhoneList
											c=71 => le.InputAddrActivePhoneNumber,									// InputAddrActivePhoneNumber
											c=72 => le.InputAddrMedianIncome,												// InputAddrMedianIncome
											c=73 => le.InputAddrMedianHomeVal,											// InputAddrMedianHomeVal
											c=74 => le.InputAddrMurderIndex,												// InputAddrMurderIndex
											c=75 => le.InputAddrCarTheftIndex,											// InputAddrCarTheftIndex
											c=76 => le.InputAddrBurglaryIndex,											// InputAddrBurglaryIndex
											c=77 => le.InputAddrCrimeIndex,													// InputAddrCrimeIndex
											c=78 => le.InputAddrAssessMarket,												// InputAddrAssessMarket
											c=79 => le.InputAddrTaxAssessVal,												// InputAddrTaxAssessVal
											c=80 => le.InputAddrPriceIndVal,												// InputAddrPriceIndVal
											c=81 => le.InputAddrHedVal,															// InputAddrHedVal
											c=82 => le.InputAddrAutoVal,														// InputAddrAutoVal
											c=83 => le.InputAddrConfScore,													// InputAddrConfScore
											c=84 => le.InputAddrCountyIndex,												// InputAddrCountyIndex
											c=85 => le.InputAddrTractIndex,													// InputAddrTractIndex
											c=86 => le.InputAddrBlockIndex,													// InputAddrBlockIndex
											c=87 => le.TimeSinceCurrAddrFirstSeen,									// TimeSinceCurrAddrFirstSeen
											c=88 => le.TimeSinceCurrAddrLastSeen,										// TimeSinceCurrAddrLastSeen
											c=89 => le.CurrAddrLenOfRes,														// CurrAddrLenOfRes
											c=90 => le.CurrAddrDwellType,														// CurrAddrDwellType
											c=91 => le.CurrAddrLandUseCode,													// CurrAddrLandUseCode
											c=92 => le.CurrAddrAssessedValue,												// CurrAddrAssessedValue
											c=93 => le.CurrAddrTaxAssessedYr,												// CurrAddrTaxAssessedYr
											c=94 => le.CurrAddrApplicantOwned,											// CurrAddrApplicantOwned
											c=95 => le.CurrAddrFamilyOwned,													// CurrAddrFamilyOwned
											c=96 => le.CurrAddrOccupantOwned,												// CurrAddrOccupantOwned
											c=97 => le.CurrAddrLastSalesDate,												// CurrAddrLastSalesDate
											c=98 => le.CurrAddrLastSalesAmount,											// CurrAddrLastSalesAmount
											c=99 => le.CurrAddrNotPrimaryRes,												// CurrAddrNotPrimaryRes
											c=100 => le.CurrAddrActivePhoneList,										// CurrAddrActivePhoneList
											c=101 => le.CurrAddrActivePhoneNumber,									// CurrAddrActivePhoneNumber
											c=102 => le.CurrAddrMedianIncome,												// CurrAddrMedianIncome
											c=103 => le.CurrAddrMedianHomeVal,											// CurrAddrMedianHomeVal
											c=104 => le.CurrAddrMurderIndex,												// CurrAddrMurderIndex
											c=105 => le.CurrAddrCarTheftIndex,											// CurrAddrCarTheftIndex
											c=106 => le.CurrAddrBurglaryIndex,											// CurrAddrBurglaryIndex
											c=107 => le.CurrAddrCrimeIndex,													// CurrAddrCrimeIndex
											c=108 => le.CurrAddrAssessMarket,												// CurrAddrAssessMarket
											c=109 => le.CurrAddrTaxAssessVal,												// CurrAddrTaxAssessVal
											c=110 => le.CurrAddrPriceIndVal,												// CurrAddrPriceIndVal
											c=111 => le.CurrAddrHedVal,															// CurrAddrHedVal
											c=112 => le.CurrAddrAutoVal,														// CurrAddrAutoVal
											c=113 => le.CurrAddrConfScore,													// CurrAddrConfScore
											c=114 => le.CurrAddrCountyIndex,												// CurrAddrCountyIndex
											c=115 => le.CurrAddrTractIndex,													// CurrAddrTractIndex
											c=116 => le.CurrAddrBlockIndex,													// CurrAddrBlockIndex
											c=117 => le.TimeSincePrevAddrFirstSeen,									// TimeSincePrevAddrFirstSeen
											c=118 => le.TimeSincePrevAddrLastSeen,									// TimeSincePrevAddrLastSeen
											c=119 => le.PrevAddrLenOfRes,														// PrevAddrLenOfRes
											c=120 => le.PrevAddrDwellType,													// PrevAddrDwellType
											c=121 => le.PrevAddrLandUseCode,												// PrevAddrLandUseCode
											c=122 => le.PrevAddrAssessedValue,											// PrevAddrAssessedValue
											c=123 => le.PrevAddrTaxAssessedYr,											// PrevAddrTaxAssessedYr
											c=124 => le.PrevAddrApplicantOwned,											// PrevAddrApplicantOwned
											c=125 => le.PrevAddrFamilyOwned,												// PrevAddrFamilyOwned
											c=126 => le.PrevAddrOccupantOwned,											// PrevAddrOccupantOwned
											c=127 => le.PrevAddrLastSalesDate,											// PrevAddrLastSalesDate
											c=128 => le.PrevAddrLastSalesAmount,										// PrevAddrLastSalesAmount
											c=129 => le.PrevAddrNotPrimaryRes,											// PrevAddrNotPrimaryRes
											c=130 => le.PrevAddrActivePhoneList,										// PrevAddrActivePhoneList
											c=131 => le.PrevAddrActivePhoneNumber,									// PrevAddrActivePhoneNumber
											c=132 => le.PrevAddrMedianIncome,												// PrevAddrMedianIncome
											c=133 => le.PrevAddrMedianHomeVal,											// PrevAddrMedianHomeVal
											c=134 => le.PrevAddrMurderIndex,												// PrevAddrMurderIndex
											c=135 => le.PrevAddrCarTheftIndex,											// PrevAddrCarTheftIndex
											c=136 => le.PrevAddrBurglaryIndex,											// PrevAddrBurglaryIndex
											c=137 => le.PrevAddrCrimeIndex,													// PrevAddrCrimeIndex
											c=138 => le.PrevAddrAssessMarket,												// PrevAddrAssessMarket
											c=139 => le.PrevAddrTaxAssessVal,												// PrevAddrTaxAssessVal
											c=140 => le.PrevAddrPriceIndVal,												// PrevAddrPriceIndVal
											c=141 => le.PrevAddrHedVal,															// PrevAddrHedVal
											c=142 => le.PrevAddrAutoVal,														// PrevAddrAutoVal
											c=143 => le.PrevAddrConfScore,													// PrevAddrConfScore
											c=144 => le.PrevAddrCountyIndex,												// PrevAddrCountyIndex
											c=145 => le.PrevAddrTractIndex,													// PrevAddrTractIndex
											c=146 => le.PrevAddrBlockIndex,													// PrevAddrBlockIndex
											c=147 => le.InputAddrCurrAddrMatch,											// InputAddrCurrAddrMatch
											c=148 => le.InputAddrCurrAddrDistance,									// InputAddrCurrAddrDistance
											c=149 => le.InputAddrCurrAddrStateDiff,									// InputAddrCurrAddrStateDiff
											c=150 => le.InputAddrCurrAddrAssessedDiff,							// InputAddrCurrAddrAssessedDiff
											c=151 => le.InputAddrCurrAddrIncomeDiff,								// InputAddrCurrAddrIncomeDiff
											c=152 => le.InputAddrCurrAddrHomeValDiff,								// InputAddrCurrAddrHomeValDiff
											c=153 => le.InputAddrCurrAddrCrimeDiff,									// InputAddrCurrAddrCrimeDiff
											c=154 => le.EconomicTrajectory,													// EconomicTrajectory
											c=155 => le.InputAddrPrevAddrMatch,											// InputAddrPrevAddrMatch
											c=156 => le.CurrAddrPrevAddrDistance,										// CurrAddrPrevAddrDistance
											c=157 => le.CurrAddrPrevAddrStateDiff,									// CurrAddrPrevAddrStateDiff
											c=158 => le.CurrAddrPrevAddrAssessedDiff,								// CurrAddrPrevAddrAssessedDiff
											c=159 => le.CurrAddrPrevAddrIncomeDiff,									// CurrAddrPrevAddrIncomeDiff
											c=160 => le.CurrAddrPrevAddrHomeValDiff,								// CurrAddrPrevAddrHomeValDiff
											c=161 => le.CurrAddrPrevAddrCrimeDiff,									// CurrAddrPrevAddrCrimeDiff
											c=162 => le.EconomicTrajectory2,												// EconomicTrajectory2
											c=163 => le.AddrStability,															// AddrStability
											c=164 => le.StatusMostRecent,														// StatusMostRecent
											c=165 => le.StatusPrevious,															// StatusPrevious
											c=166 => le.StatusNextPrevious,													// StatusNextPrevious
											c=167 => le.TimeSincePrevAddrDateFirstSeen,							// TimeSincePrevAddrDateFirstSeen
											c=168 => le.TimeSinceNextPrevDateFirstSeen,							// TimeSinceNextPrevDateFirstSeen
											c=169 => le.AddrChanges30,															// AddrChanges30
											c=170 => le.AddrChanges90,															// AddrChanges90
											c=171 => le.AddrChanges180,															// AddrChanges180
											c=172 => le.AddrChanges12,															// AddrChanges12
											c=173 => le.AddrChanges24,															// AddrChanges24
											c=174 => le.AddrChanges36,															// AddrChanges36
											c=175 => le.AddrChanges60,															// AddrChanges60
											c=176 => le.PropertyOwnedTotal,													// PropertyOwnedTotal
											c=177 => le.PropertyOwnedAssessedTotal,									// PropertyOwnedAssessedTotal
											c=178 => le.PropertyHistoricallyOwned,									// PropertyHistoricallyOwned
											c=179 => le.DateFirstPurchase,													// DateFirstPurchase
											c=180 => le.DateMostRecentPurchase,											// DateMostRecentPurchase
											c=181 => le.DateMostRecentSale,													// DateMostRecentSale
											c=182 => le.PropPurchased30,														// PropPurchased30
											c=183 => le.PropPurchased90,														// PropPurchased90
											c=184 => le.PropPurchased180,														// PropPurchased180
											c=185 => le.PropPurchased12,														// PropPurchased12
											c=186 => le.PropPurchased24,														// PropPurchased24
											c=187 => le.PropPurchased36,														// PropPurchased36
											c=188 => le.PropPurchased60,														// PropPurchased60
											c=189 => le.PropSold30,																	// PropSold30
											c=190 => le.PropSold90,																	// PropSold90
											c=191 => le.PropSold180,																// PropSold180
											c=192 => le.PropSold12,																	// PropSold12
											c=193 => le.PropSold24,																	// PropSold24
											c=194 => le.PropSold36,																	// PropSold36
											c=195 => le.PropSold60,																	// PropSold60
											c=196 => le.NumWatercraft,															// NumWatercraft
											c=197 => le.NumWatercraft30,														// NumWatercraft30
											c=198 => le.NumWatercraft90,														// NumWatercraft90
											c=199 => le.NumWatercraft180,														// NumWatercraft180
											c=200 => le.NumWatercraft12,														// NumWatercraft12
											c=201 => le.NumWatercraft24,														// NumWatercraft24
											c=202 => le.NumWatercraft36,														// NumWatercraft36
											c=203 => le.NumWatercraft60,														// NumWatercraft60
											c=204 => le.NumAircraft,																// NumAircraft
											c=205 => le.NumAircraft30,															// NumAircraft30
											c=206 => le.NumAircraft90,															// NumAircraft90
											c=207 => le.NumAircraft180,															// NumAircraft180
											c=208 => le.NumAircraft12,															// NumAircraft12
											c=209 => le.NumAircraft24,															// NumAircraft24
											c=210 => le.NumAircraft36,															// NumAircraft36
											c=211 => le.NumAircraft60,															// NumAircraft60
											c=212 => le.WealthIndex,																// WealthIndex
											c=213 => le.TotalNumberDerogs,													// TotalNumberDerogs
											c=214 => le.DateLastDerog,															// DateLastDerog
											c=215 => le.NumFelonies,																// NumFelonies
											c=216 => le.DateLastConviction,													// DateLastConviction
											c=217 => le.NumFelonies30,															// NumFelonies30
											c=218 => le.NumFelonies90,															// NumFelonies90
											c=219 => le.NumFelonies180,															// NumFelonies180
											c=220 => le.NumFelonies12,															// NumFelonies12
											c=221 => le.NumFelonies24,															// NumFelonies24
											c=222 => le.NumFelonies36,															// NumFelonies36
											c=223 => le.NumFelonies60,															// NumFelonies60
											c=224 => le.NumArrests,																	// NumArrests
											c=225 => le.DateLastArrest,															// DateLastArrest
											c=226 => le.NumArrests30,																// NumArrests30
											c=227 => le.NumArrests90,																// NumArrests90
											c=228 => le.NumArrests180,															// NumArrests180
											c=229 => le.NumArrests12,																// NumArrests12
											c=230 => le.NumArrests24,																// NumArrests24
											c=231 => le.NumArrests36,																// NumArrests36
											c=232 => le.NumArrests60,																// NumArrests60
											c=233 => le.LiensCount,																	// LiensCount
											c=234 => le.LiensUnreleasedCount,												// LiensUnreleasedCount
											c=235 => le.MostRecentUnrelDate,												// MostRecentUnrelDate
											c=236 => le.LiensUnreleasedCount30,											// LiensUnreleasedCount30
											c=237 => le.LiensUnreleasedCount90,											// LiensUnreleasedCount90
											c=238 => le.LiensUnreleasedCount180,										// LiensUnreleasedCount180
											c=239 => le.LiensUnreleasedCount12,											// LiensUnreleasedCount12
											c=240 => le.LiensUnreleasedCount24,											// LiensUnreleasedCount24
											c=241 => le.LiensUnreleasedCount36,											// LiensUnreleasedCount36
											c=242 => le.LiensUnreleasedCount60,											// LiensUnreleasedCount60
											c=243 => le.LiensReleasedCount,													// LiensReleasedCount
											c=244 => le.MostRecentReleasedDate,											// MostRecentReleasedDate
											c=245 => le.LiensReleasedCount30,												// LiensReleasedCount30
											c=246 => le.LiensReleasedCount90,												// LiensReleasedCount90
											c=247 => le.LiensReleasedCount180,											// LiensReleasedCount180
											c=248 => le.LiensReleasedCount12,												// LiensReleasedCount12
											c=249 => le.LiensReleasedCount24,												// LiensReleasedCount24
											c=250 => le.LiensReleasedCount36,												// LiensReleasedCount36
											c=251 => le.LiensReleasedCount60,												// LiensReleasedCount60
											c=252 => le.BankruptCount,															// BankruptCount
											c=253 => le.MostRecentBankruptDate,											// MostRecentBankruptDate
											c=254 => le.MostRecentBankruptType,											// MostRecentBankruptType
											c=255 => le.MostRecentBankruptStatus,										// MostRecentBankruptStatus
											c=256 => le.BankruptCount30,														// BankruptCount30
											c=257 => le.BankruptCount90,														// BankruptCount90
											c=258 => le.BankruptCount180,														// BankruptCount180
											c=259 => le.BankruptCount12,														// BankruptCount12
											c=260 => le.BankruptCount24,														// BankruptCount24
											c=261 => le.BankruptCount36,														// BankruptCount36
											c=262 => le.BankruptCount60,														// BankruptCount60
											c=263 => le.EvictionCount,															// EvictionCount
											c=264 => le.MostRecentEvictionDate,											// MostRecentEvictionDate
											c=265 => le.EvictionCount30,														// EvictionCount30
											c=266 => le.EvictionCount90,														// EvictionCount90
											c=267 => le.EvictionCount180,														// EvictionCount180
											c=268 => le.EvictionCount12,														// EvictionCount12
											c=269 => le.EvictionCount24,														// EvictionCount24
											c=270 => le.EvictionCount36,														// EvictionCount36
											c=271 => le.EvictionCount60,														// EvictionCount60
											c=272 => le.NonDerogSrcCount,														// NonDerogSrcCount
											c=273 => le.NonDerogSrcCount30,													// NonDerogSrcCount30
											c=274 => le.NonDerogSrcCount90,													// NonDerogSrcCount90
											c=275 => le.NonDerogSrcCount180,												// NonDerogSrcCount180
											c=276 => le.NonDerogSrcCount12,													// NonDerogSrcCount12
											c=277 => le.NonDerogSrcCount24,													// NonDerogSrcCount24
											c=278 => le.NonDerogSrcCount36,													// NonDerogSrcCount36
											c=279 => le.NonDerogSrcCount60,													// NonDerogSrcCount60
											c=280 => le.ProfLicCount,																// ProfLicCount
											c=281 => le.MostRecentProfLicDate,											// MostRecentProfLicDate
											c=282 => le.MostRecentProfLicExpireDate,								// MostRecentProfLicExpireDate
											c=283 => le.ProfLicCount30,															// ProfLicCount30
											c=284 => le.ProfLicCount90,															// ProfLicCount90
											c=285 => le.ProfLicCount180,														// ProfLicCount180
											c=286 => le.ProfLicCount12,															// ProfLicCount12
											c=287 => le.ProfLicCount24,															// ProfLicCount24
											c=288 => le.ProfLicCount36,															// ProfLicCount36
											c=289 => le.ProfLicCount60,															// ProfLicCount60
											c=290 => le.ProfLicExpireCount30,												// ProfLicExpireCount30
											c=291 => le.ProfLicExpireCount90,												// ProfLicExpireCount90
											c=292 => le.ProfLicExpireCount180,											// ProfLicExpireCount180
											c=293 => le.ProfLicExpireCount12,												// ProfLicExpireCount12
											c=294 => le.ProfLicExpireCount24,												// ProfLicExpireCount24
											c=295 => le.ProfLicExpireCount36,												// ProfLicExpireCount36
											c=296 => le.ProfLicExpireCount60,												// ProfLicExpireCount60
											c=297 => le.InputAddrHighRisk,													// InputAddrHighRisk
											c=298 => le.InputPhoneHighRisk,													// InputPhoneHighRisk
											c=299 => le.SIC,																				// SIC
											c=300 => le.InputAddrPrison,														// InputAddrPrison
											c=301 => le.InputZipPOBox,															// InputZipPOBox
											c=302 => le.InputZipCorpMil,														// InputZipCorpMil
											c=303 => le.InputPhoneStatus,														// InputPhoneStatus
											c=304 => le.InputPhonePager,														// InputPhonePager
											c=305 => le.InputPhoneMobile,														// InputPhoneMobile
											c=306 => le.TimeSinceSubjectPhoneFirstSeen,							// TimeSinceSubjectPhoneFirstSeen
											c=307 => le.TimeSinceSubjectPhoneLastSeen,							// TimeSinceSubjectPhoneLastSeen
											c=308 => le.InvalidPhoneZip,														// InvalidPhoneZip
											c=309 => le.InputPhoneAddrDist,													// InputPhoneAddrDist
											c=310 => le.PhoneType,																	// PhoneType
											c=311 => le.ServiceType,																// ServiceType
											c=312 => le.AreaCodeChange,															// AreaCodeChange
											c=313 => le.AddrVal,																		// AddrVal
											c=314 => le.AddrValErrorCode,														// AddrValErrorCode
															 le.DoNotMail																		// DoNotMail
										 );
	END;
	
	iesp.share.t_NameValuePair intoVersion3(results le, INTEGER c) := TRANSFORM
		SELF.name := MAP(
											c=1 =>		'AgeOldestRecord',
											c=2 =>		'AgeNewestRecord',
											c=3 =>		'RecentUpdate',
											c=4 =>		'SrcsConfirmIDAddrCount',
											c=5 =>		'CreditBureauRecord',
											c=6 =>		'InvalidSSN',
											c=7 =>		'InvalidAddr',
											c=8 =>		'InvalidPhone',
											c=9 =>		'VerificationFailure',
											c=10 =>		'SSNNotFound',
											c=11 =>		'SSNFoundOther',
											c=12 =>		'VerifiedName',
											c=13 =>		'VerifiedSSN',
											c=14 =>		'VerifiedPhone',
											c=15 =>		'VerifiedPhoneFullName',
											c=16 =>		'VerifiedPhoneLastName',
											c=17 =>		'VerifiedAddress',
											c=18 =>		'VerifiedDOB',
											c=19 =>		'AgeRiskIndicator',
											c=20 =>		'SubjectSSNCount',
											c=21 =>		'SubjectAddrCount',
											c=22 =>		'SubjectPhoneCount',
											c=23 =>		'SubjectSSNRecentCount',
											c=24 =>		'SubjectAddrRecentCount',
											c=25 =>		'SubjectPhoneRecentCount',
											c=26 =>		'SSNIdentitiesCount',
											c=27 =>		'SSNAddrCount',
											c=28 =>		'SSNIdentitiesRecentCount',
											c=29 =>		'SSNAddrRecentCount',
											c=30 =>		'InputAddrIdentitiesCount',
											c=31 =>		'InputAddrSSNCount',
											c=32 =>		'InputAddrPhoneCount',
											c=33 =>		'InputAddrIdentitiesRecentCount',
											c=34 =>		'InputAddrSSNRecentCount',
											c=35 =>		'InputAddrPhoneRecentCount',
											c=36 =>		'PhoneIdentitiesCount',
											c=37 =>		'PhoneIdentitiesRecentCount',
											c=38 =>		'PhoneOther',
											c=39 =>		'SSNLastNameCount',
											c=40 =>		'SubjectLastNameCount',
											c=41 =>		'LastNameChangeAge',
											c=42 =>		'LastNameChangeCount01',
											c=43 =>		'LastNameChangeCount03',
											c=44 =>		'LastNameChangeCount06',
											c=45 =>		'LastNameChangeCount12',
											c=46 =>		'LastNameChangeCount24',
											c=47 =>		'LastNameChangeCount36',
											c=48 =>		'LastNameChangeCount60',
											c=49 =>		'SFDUAddrIdentitiesCount',
											c=50 =>		'SFDUAddrSSNCount',
											c=51 =>		'SSNDeceased',
											c=52 =>		'SSNDateDeceased',
											c=53 =>		'SSNIssued',
											c=54 =>		'SSNRecent',
											c=55 =>		'SSNLowIssueDate',
											c=56 =>		'SSNHighIssueDate',
											c=57 =>		'SSNIssueState',
											c=58 =>		'SSNNonUS',
											c=59 =>		'SSNIssuedPriorDOB',
											c=60 =>		'SSN3Years',
											c=61 =>		'SSNAfter5',
											c=62 =>		'SSNProblems',
											c=63 =>		'RelativesCount',
											c=64 =>		'RelativesBankruptcyCount',
											c=65 =>		'RelativesFelonyCount',
											c=66 =>		'RelativesPropOwnedCount',
											c=67 =>		'RelativesPropOwnedTaxTotal',
											c=68 =>		'RelativesDistanceClosest',
											c=69 =>		'InputAddrAgeOldestRecord',
											c=70 =>		'InputAddrAgeNewestRecord',
											c=71 =>		'InputAddrLenOfRes',
											c=72 =>		'InputAddrDwellType',
											c=73 =>		'InputAddrLandUseCode',
											c=74 =>		'InputAddrApplicantOwned',
											c=75 =>		'InputAddrFamilyOwned',
											c=76 =>		'InputAddrOccupantOwned',
											c=77 =>		'InputAddrAgeLastSale',
											c=78 =>		'InputAddrLastSalesPrice',
											c=79 =>		'InputAddrNotPrimaryRes',
											c=80 =>		'InputAddrActivePhoneList',
											c=81 =>		'InputAddrActivePhoneNumber',
											c=82 =>		'InputAddrTaxValue',
											c=83 =>		'InputAddrTaxYr',
											c=84 =>		'InputAddrTaxMarketValue',
											c=85 =>		'InputAddrAVMTax',
											c=86 =>		'InputAddrAVMSalesPrice',
											c=87 =>		'InputAddrAVMHedonic',
											c=88 =>		'InputAddrAVMValue',
											c=89 =>		'InputAddrAVMConfidence',
											c=90 =>		'InputAddrCountyIndex',
											c=91 =>		'InputAddrTractIndex',
											c=92 =>		'InputAddrBlockIndex',
											c=93 =>		'InputAddrMedianIncome',
											c=94 =>		'InputAddrMedianValue',
											c=95 =>		'InputAddrMurderIndex',
											c=96 =>		'InputAddrCarTheftIndex',
											c=97 =>		'InputAddrBurglaryIndex',
											c=98 =>		'InputAddrCrimeIndex',
											c=99 =>		'CurrAddrAgeOldestRecord',
											c=100 =>		'CurrAddrAgeNewestRecord',
											c=101 =>		'CurrAddrLenOfRes',
											c=102 =>		'CurrAddrDwellType',
											c=103 =>		'CurrAddrLandUseCode',
											c=104 =>		'CurrAddrApplicantOwned',
											c=105 =>		'CurrAddrFamilyOwned',
											c=106 =>		'CurrAddrOccupantOwned',
											c=107 =>		'CurrAddrAgeLastSale',
											c=108 =>		'CurrAddrLastSalesPrice',
											c=109 =>		'CurrAddrActivePhoneList',
											c=110 =>		'CurrAddrActivePhoneNumber',
											c=111 =>		'CurrAddrTaxValue',
											c=112 =>		'CurrAddrTaxYr',
											c=113 =>		'CurrAddrTaxMarketValue',
											c=114 =>		'CurrAddrAVMTax',
											c=115 =>		'CurrAddrAVMSalesPrice',
											c=116 =>		'CurrAddrAVMHedonic',
											c=117 =>		'CurrAddrAVMValue',
											c=118 =>		'CurrAddrAVMConfidence',
											c=119 =>		'CurrAddrCountyIndex',
											c=120 =>		'CurrAddrTractIndex',
											c=121 =>		'CurrAddrBlockIndex',
											c=122 =>		'CurrAddrMedianIncome',
											c=123 =>		'CurrAddrMedianValue',
											c=124 =>		'CurrAddrMurderIndex',
											c=125 =>		'CurrAddrCarTheftIndex',
											c=126 =>		'CurrAddrBurglaryIndex',
											c=127 =>		'CurrAddrCrimeIndex',
											c=128 =>		'PrevAddrAgeOldestRecord',
											c=129 =>		'PrevAddrAgeNewestRecord',
											c=130 =>		'PrevAddrLenOfRes',
											c=131 =>		'PrevAddrDwellType',
											c=132 =>		'PrevAddrLandUseCode',
											c=133 =>		'PrevAddrApplicantOwned',
											c=134 =>		'PrevAddrFamilyOwned',
											c=135 =>		'PrevAddrOccupantOwned',
											c=136 =>		'PrevAddrAgeLastSale',
											c=137 =>		'PrevAddrLastSalesPrice',
											c=138 =>		'PrevAddrActivePhoneList',
											c=139 =>		'PrevAddrActivePhoneNumber',
											c=140 =>		'PrevAddrTaxValue',
											c=141 =>		'PrevAddrTaxYr',
											c=142 =>		'PrevAddrTaxMarketValue',
											c=143 =>		'PrevAddrAVMTax',
											c=144 =>		'PrevAddrAVMSalesPrice',
											c=145 =>		'PrevAddrAVMHedonic',
											c=146 =>		'PrevAddrAVMValue',
											c=147 =>		'PrevAddrAVMConfidence',
											c=148 =>		'PrevAddrCountyIndex',
											c=149 =>		'PrevAddrTractIndex',
											c=150 =>		'PrevAddrBlockIndex',
											c=151 =>		'PrevAddrMedianIncome',
											c=152 =>		'PrevAddrMedianValue',
											c=153 =>		'PrevAddrMurderIndex',
											c=154 =>		'PrevAddrCarTheftIndex',
											c=155 =>		'PrevAddrBurglaryIndex',
											c=156 =>		'PrevAddrCrimeIndex',
											c=157 =>		'InputCurrAddrMatch',
											c=158 =>		'InputCurrAddrDistance',
											c=159 =>		'InputCurrAddrStateDiff',
											c=160 =>		'InputCurrAddrTaxDiff',
											c=161 =>		'InputCurrAddrIncomeDiff',
											c=162 =>		'InputCurrAddrValueDiff',
											c=163 =>		'InputCurrAddrCrimeDiff',
											c=164 =>		'InputCurrEconTrajectory',
											c=165 =>		'InputPrevAddrMatch',
											c=166 =>		'CurrPrevAddrDistance',
											c=167 =>		'CurrPrevAddrStateDiff',
											c=168 =>		'CurrPrevAddrTaxDiff',
											c=169 =>		'CurrPrevAddrIncomeDiff',
											c=170 =>		'CurrPrevAddrValueDiff',
											c=171 =>		'CurrPrevAddrCrimeDiff',
											c=172 =>		'PrevCurrEconTrajectory',
											c=173 =>		'EducationAttendedCollege',
											c=174 =>		'EducationProgram2Yr',
											c=175 =>		'EducationProgram4Yr',
											c=176 =>		'EducationProgramGraduate',
											c=177 =>		'EducationInstitutionPrivate',
											c=178 =>		'EducationInstitutionRating',
											c=179 =>		'EducationFieldofStudyType',
											c=180 =>		'AddrStability',
											c=181 =>		'StatusMostRecent',
											c=182 =>		'StatusPrevious',
											c=183 =>		'StatusNextPrevious',
											c=184 =>		'AddrChangeCount01',
											c=185 =>		'AddrChangeCount03',
											c=186 =>		'AddrChangeCount06',
											c=187 =>		'AddrChangeCount12',
											c=188 =>		'AddrChangeCount24',
											c=189 =>		'AddrChangeCount36',
											c=190 =>		'AddrChangeCount60',
											c=191 =>		'PredictedAnnualIncome',
											c=192 =>		'PropOwnedCount',
											c=193 =>		'PropOwnedTaxTotal',
											c=194 =>		'PropOwnedHistoricalCount',
											c=195 =>		'PropAgeOldestPurchase',
											c=196 =>		'PropAgeNewestPurchase',
											c=197 =>		'PropAgeNewestSale',
											c=198 =>		'PropNewestSalePurchaseIndex',
											c=199 =>		'PropPurchasedCount01',
											c=200 =>		'PropPurchasedCount03',
											c=201 =>		'PropPurchasedCount06',
											c=202 =>		'PropPurchasedCount12',
											c=203 =>		'PropPurchasedCount24',
											c=204 =>		'PropPurchasedCount36',
											c=205 =>		'PropPurchasedCount60',
											c=206 =>		'PropSoldCount01',
											c=207 =>		'PropSoldCount03',
											c=208 =>		'PropSoldCount06',
											c=209 =>		'PropSoldCount12',
											c=210 =>		'PropSoldCount24',
											c=211 =>		'PropSoldCount36',
											c=212 =>		'PropSoldCount60',
											c=213 =>		'WatercraftCount',
											c=214 =>		'WatercraftCount01',
											c=215 =>		'WatercraftCount03',
											c=216 =>		'WatercraftCount06',
											c=217 =>		'WatercraftCount12',
											c=218 =>		'WatercraftCount24',
											c=219 =>		'WatercraftCount36',
											c=220 =>		'WatercraftCount60',
											c=221 =>		'AircraftCount',
											c=222 =>		'AircraftCount01',
											c=223 =>		'AircraftCount03',
											c=224 =>		'AircraftCount06',
											c=225 =>		'AircraftCount12',
											c=226 =>		'AircraftCount24',
											c=227 =>		'AircraftCount36',
											c=228 =>		'AircraftCount60',
											c=229 =>		'WealthIndex',
											c=230 =>		'SubPrimeSolicitedCount',
											c=231 =>		'SubPrimeSolicitedCount01',
											c=232 =>		'SubPrimeSolicitedCount03',
											c=233 =>		'SubPrimeSolicitedCount06',
											c=234 =>		'SubPrimeSolicitedCount12',
											c=235 =>		'SubPrimeSolicitedCount24',
											c=236 =>		'SubPrimeSolicitedCount36',
											c=237 =>		'SubPrimeSolicitedCount60',
											c=238 =>		'DerogSeverityIndex',
											c=239 =>		'DerogCount',
											c=240 =>		'DerogAge',
											c=241 =>		'FelonyCount',
											c=242 =>		'FelonyAge',
											c=243 =>		'FelonyCount01',
											c=244 =>		'FelonyCount03',
											c=245 =>		'FelonyCount06',
											c=246 =>		'FelonyCount12',
											c=247 =>		'FelonyCount24',
											c=248 =>		'FelonyCount36',
											c=249 =>		'FelonyCount60',
											c=250 =>		'ArrestCount',
											c=251 =>		'ArrestAge',
											c=252 =>		'ArrestCount01',
											c=253 =>		'ArrestCount03',
											c=254 =>		'ArrestCount06',
											c=255 =>		'ArrestCount12',
											c=256 =>		'ArrestCount24',
											c=257 =>		'ArrestCount36',
											c=258 =>		'ArrestCount60',
											c=259 =>		'LienCount',
											c=260 =>		'LienFiledCount',
											c=261 =>		'LienFiledAge',
											c=262 =>		'LienFiledCount01',
											c=263 =>		'LienFiledCount03',
											c=264 =>		'LienFiledCount06',
											c=265 =>		'LienFiledCount12',
											c=266 =>		'LienFiledCount24',
											c=267 =>		'LienFiledCount36',
											c=268 =>		'LienFiledCount60',
											c=269 =>		'LienReleasedCount',
											c=270 =>		'LienReleasedAge',
											c=271 =>		'LienReleasedCount01',
											c=272 =>		'LienReleasedCount03',
											c=273 =>		'LienReleasedCount06',
											c=274 =>		'LienReleasedCount12',
											c=275 =>		'LienReleasedCount24',
											c=276 =>		'LienReleasedCount36',
											c=277 =>		'LienReleasedCount60',
											c=278 =>		'BankruptcyCount',
											c=279 =>		'BankruptcyAge',
											c=280 =>		'BankruptcyType',
											c=281 =>		'BankruptcyStatus',
											c=282 =>		'BankruptcyCount01',
											c=283 =>		'BankruptcyCount03',
											c=284 =>		'BankruptcyCount06',
											c=285 =>		'BankruptcyCount12',
											c=286 =>		'BankruptcyCount24',
											c=287 =>		'BankruptcyCount36',
											c=288 =>		'BankruptcyCount60',
											c=289 =>		'EvictionCount',
											c=290 =>		'EvictionAge',
											c=291 =>		'EvictionCount01',
											c=292 =>		'EvictionCount03',
											c=293 =>		'EvictionCount06',
											c=294 =>		'EvictionCount12',
											c=295 =>		'EvictionCount24',
											c=296 =>		'EvictionCount36',
											c=297 =>		'EvictionCount60',
											c=298 =>		'NonDerogCount',
											c=299 =>		'NonDerogCount01',
											c=300 =>		'NonDerogCount03',
											c=301 =>		'NonDerogCount06',
											c=302 =>		'NonDerogCount12',
											c=303 =>		'NonDerogCount24',
											c=304 =>		'NonDerogCount36',
											c=305 =>		'NonDerogCount60',
											c=306 =>		'ProfLicCount',
											c=307 =>		'ProfLicAge',
											c=308 =>		'ProfLicTypeCategory',
											c=309 =>		'ProfLicExpireDate',
											c=310 =>		'ProfLicCount01',
											c=311 =>		'ProfLicCount03',
											c=312 =>		'ProfLicCount06',
											c=313 =>		'ProfLicCount12',
											c=314 =>		'ProfLicCount24',
											c=315 =>		'ProfLicCount36',
											c=316 =>		'ProfLicCount60',
											c=317 =>		'ProfLicExpireCount01',
											c=318 =>		'ProfLicExpireCount03',
											c=319 =>		'ProfLicExpireCount06',
											c=320 =>		'ProfLicExpireCount12',
											c=321 =>		'ProfLicExpireCount24',
											c=322 =>		'ProfLicExpireCount36',
											c=323 =>		'ProfLicExpireCount60',
											c=324 =>		'PRSearchCollectionCount',
											c=325 =>		'PRSearchCollectionCount01',
											c=326 =>		'PRSearchCollectionCount03',
											c=327 =>		'PRSearchCollectionCount06',
											c=328 =>		'PRSearchCollectionCount12',
											c=329 =>		'PRSearchCollectionCount24',
											c=330 =>		'PRSearchCollectionCount36',
											c=331 =>		'PRSearchCollectionCount60',
											c=332 =>		'PRSearchIDVFraudCount',
											c=333 =>		'PRSearchIDVFraudCount01',
											c=334 =>		'PRSearchIDVFraudCount03',
											c=335 =>		'PRSearchIDVFraudCount06',
											c=336 =>		'PRSearchIDVFraudCount12',
											c=337 =>		'PRSearchIDVFraudCount24',
											c=338 =>		'PRSearchIDVFraudCount36',
											c=339 =>		'PRSearchIDVFraudCount60',
											c=340 =>		'PRSearchOtherCount',
											c=341 =>		'PRSearchOtherCount01',
											c=342 =>		'PRSearchOtherCount03',
											c=343 =>		'PRSearchOtherCount06',
											c=344 =>		'PRSearchOtherCount12',
											c=345 =>		'PRSearchOtherCount24',
											c=346 =>		'PRSearchOtherCount36',
											c=347 =>		'PRSearchOtherCount60',
											c=348 =>		'InputPhoneStatus',
											c=349 =>		'InputPhonePager',
											c=350 =>		'InputPhoneMobile',
											c=351 =>		'InputPhoneType',
											c=352 =>		'InputPhoneServiceType',
											c=353 =>		'InputAreaCodeChange',
											c=354 =>		'PhoneEDAAgeOldestRecord',
											c=355 =>		'PhoneEDAAgeNewestRecord',
											c=356 =>		'PhoneOtherAgeOldestRecord',
											c=357 =>		'PhoneOtherAgeNewestRecord',
											c=358 =>		'InvalidPhoneZip',
											c=359 =>		'InputPhoneAddrDist',
											c=360 =>		'InputAddrSICCode',
											c=361 =>		'InputAddrValidation',
											c=362 =>		'InputAddrErrorCode',
											c=363 =>		'InputAddrHighRisk',
											c=364 =>		'InputPhoneHighRisk',
											c=365 =>		'InputAddrPrison',
											c=366 =>		'CurrAddrPrison',
											c=367 =>		'PrevAddrPrison',
											c=368 =>		'HistoricalAddrPrison',
											c=369 =>		'InputZipPOBox',
											c=370 =>		'InputZipCorpMil',
																	'DoNotMail'
										);
																																							// Output Attribute Name:
		SELF.value := MAP(																												// ======================
											c=1 =>		le.Version3.AgeOldestRecord,									// AgeOldestRecord								
											c=2 =>		le.Version3.AgeNewestRecord,									// AgeNewestRecord								
											c=3 =>		le.RecentUpdate,															// RecentUpdate		
											c=4 =>		le.Version3.SrcsConfirmIDAddrCount,						// SrcsConfirmIDAddrCount											
											c=5 =>		le.Version3.CreditBureauRecord,								// CreditBureauRecord									
											c=6 =>		le.Version3.InvalidSSN,												// InvalidSSN					
											c=7 =>		le.Version3.InvalidAddr,											// InvalidAddr						
											c=8 =>		le.Version3.InvalidPhone,											// InvalidPhone						
											c=9 =>		le.Version3.VerificationFailure,							// VerificationFailure										
											c=10 =>		le.Version3.SSNNotFound,											// SSNNotFound						
											c=11 =>		le.Version3.SSNFoundOther,										// SSNFoundOther							
											c=12 =>		le.Version3.VerifiedName,											// VerifiedName						
											c=13 =>		le.Version3.VerifiedSSN,											// VerifiedSSN						
											c=14 =>		le.Version3.VerifiedPhone,										// VerifiedPhone							
											c=15 =>		le.Version3.VerifiedPhoneFullName,						// VerifiedPhoneFullName											
											c=16 =>		le.Version3.VerifiedPhoneLastName,						// VerifiedPhoneLastName											
											c=17 =>		le.Version3.VerifiedAddress,									// VerifiedAddress								
											c=18 =>		le.Version3.VerifiedDOB,											// VerifiedDOB						
											c=19 =>		le.AgeRiskIndicator,													// AgeRiskIndicator				
											c=20 =>		le.Version3.SubjectSSNCount,									// SubjectSSNCount								
											c=21 =>		le.Version3.SubjectAddrCount,									// SubjectAddrCount								
											c=22 =>		le.Version3.SubjectPhoneCount,								// SubjectPhoneCount									
											c=23 =>		le.Version3.SubjectSSNRecentCount,						// SubjectSSNRecentCount											
											c=24 =>		le.Version3.SubjectAddrRecentCount,						// SubjectAddrRecentCount											
											c=25 =>		le.Version3.SubjectPhoneRecentCount,					// SubjectPhoneRecentCount												
											c=26 =>		le.Version3.SSNIdentitiesCount,								// SSNIdentitiesCount									
											c=27 =>		le.Version3.SSNAddrCount,											// SSNAddrCount						
											c=28 =>		le.Version3.SSNIdentitiesRecentCount,					// SSNIdentitiesRecentCount												
											c=29 =>		le.Version3.SSNAddrRecentCount,								// SSNAddrRecentCount									
											c=30 =>		le.Version3.InputAddrIdentitiesCount,					// InputAddrIdentitiesCount												
											c=31 =>		le.Version3.InputAddrSSNCount,								// InputAddrSSNCount									
											c=32 =>		le.Version3.InputAddrPhoneCount,							// InputAddrPhoneCount										
											c=33 =>		le.Version3.InputAddrIdentitiesRecentCount,		// InputAddrIdentitiesRecentCount															
											c=34 =>		le.Version3.InputAddrSSNRecentCount,					// InputAddrSSNRecentCount												
											c=35 =>		le.Version3.InputAddrPhoneRecentCount,				// InputAddrPhoneRecentCount													
											c=36 =>		le.Version3.PhoneIdentitiesCount,							// PhoneIdentitiesCount										
											c=37 =>		le.Version3.PhoneIdentitiesRecentCount,				// PhoneIdentitiesRecentCount													
											c=38 =>		le.Version3.PhoneOther,												// PhoneOther					
											c=39 =>		le.Version3.SSNLastNameCount,									// SSNLastNameCount								
											c=40 =>		le.Version3.SubjectLastNameCount,							// SubjectLastNameCount										
											c=41 =>		le.TimeSinceLastName,													// LastNameChangeAge				
											c=42 =>		le.Version3.LastNameChangeCount01,						// LastNameChangeCount01											
											c=43 =>		le.Version3.LastNameChangeCount03,						// LastNameChangeCount03											
											c=44 =>		le.Version3.LastNameChangeCount06,						// LastNameChangeCount06											
											c=45 =>		le.Version3.LastNameChangeCount12,						// LastNameChangeCount12											
											c=46 =>		le.Version3.LastNameChangeCount24,						// LastNameChangeCount24											
											c=47 =>		le.Version3.LastNameChangeCount36,						// LastNameChangeCount36											
											c=48 =>		le.Version3.LastNameChangeCount60,						// LastNameChangeCount60											
											c=49 =>		le.Version3.SFDUAddrIdentitiesCount,					// SFDUAddrIdentitiesCount												
											c=50 =>		le.Version3.SFDUAddrSSNCount,									// SFDUAddrSSNCount								
											c=51 =>		le.Version3.SSNDeceased,											// SSNDeceased						
											c=52 =>		le.DateSSNDeceased,														// SSNDateDeceased			
											c=53 =>		le.Version3.SSNIssued,												// SSNIssued					
											c=54 =>		le.Version3.SSNRecent,												// SSNRecent					
											c=55 =>		le.LowIssueDate,															// SSNLowIssueDate		
											c=56 =>		le.HighIssueDate,															// SSNHighIssueDate		
											c=57 =>		le.SSNIssueState,															// SSNIssueState		
											c=58 =>		le.Version3.SSNNonUS,													// SSNNonUS				
											c=59 =>		le.Version3.SSNIssuedPriorDOB,								// SSNIssuedPriorDOB									
											c=60 =>		le.Version3.SSN3Years,												// SSN3Years					
											c=61 =>		le.Version3.SSNAfter5,												// SSNAfter5					
											c=62 =>		le.SSNProbs,																	// SSNProblems
											c=63 =>		le.Version3.RelativesCount,										// RelativesCount							
											c=64 =>		le.Version3.RelativesBankruptcyCount,					// RelativesBankruptcyCount												
											c=65 =>		le.Version3.RelativesFelonyCount,							// RelativesFelonyCount										
											c=66 =>		le.Version3.RelativesPropOwnedCount,					// RelativesPropOwnedCount												
											c=67 =>		le.Version3.RelativesPropOwnedTaxTotal,				// RelativesPropOwnedTaxTotal													
											c=68 =>		le.Version3.RelativesDistanceClosest,					// RelativesDistanceClosest												
											c=69 =>		le.TimeSinceInputAddrFirstSeen,								// InputAddrAgeOldestRecord									
											c=70 =>		le.TimeSinceInputAddrLastSeen,								// InputAddrAgeNewestRecord									
											c=71 =>		le.InputAddrLenOfRes,													// InputAddrLenOfRes				
											c=72 =>		le.Version3.InputAddrDwellType,								// InputAddrDwellType									
											c=73 =>		le.Version3.InputAddrLandUseCode,							// InputAddrLandUseCode										
											c=74 =>		le.Version3.InputAddrApplicantOwned,					// InputAddrApplicantOwned												
											c=75 =>		le.Version3.InputAddrFamilyOwned,							// InputAddrFamilyOwned										
											c=76 =>		le.Version3.InputAddrOccupantOwned,						// InputAddrOccupantOwned											
											c=77 =>		le.Version3.InputAddrAgeLastSale,							// InputAddrAgeLastSale										
											c=78 =>		le.InputAddrLastSalesAmount,									// InputAddrLastSalesPrice								
											c=79 =>		le.Version3.InputAddrNotPrimaryRes,						// InputAddrNotPrimaryRes											
											c=80 =>		le.Version3.InputAddrActivePhoneList,					// InputAddrActivePhoneList												
											c=81 =>		le.InputAddrActivePhoneNumber,								// InputAddrActivePhoneNumber									
											c=82 =>		le.InputAddrAssessedValue,										// InputAddrTaxValue							
											c=83 =>		le.InputAddrTaxAssessedYr,										// InputAddrTaxYr							
											c=84 =>		le.InputAddrAssessMarket,											// InputAddrTaxMarketValue						
											c=85 =>		le.InputAddrTaxAssessVal,											// InputAddrAVMTax						
											c=86 =>		le.InputAddrPriceIndVal,											// InputAddrAVMSalesPrice						
											c=87 =>		le.InputAddrHedVal,														// InputAddrAVMHedonic			
											c=88 =>		le.InputAddrAutoVal,													// InputAddrAVMValue				
											c=89 =>		le.InputAddrConfScore,												// InputAddrAVMConfidence					
											c=90 =>		le.InputAddrCountyIndex,											// InputAddrCountyIndex						
											c=91 =>		le.InputAddrTractIndex,												// InputAddrTractIndex					
											c=92 =>		le.InputAddrBlockIndex,												// InputAddrBlockIndex					
											c=93 =>		le.InputAddrMedianIncome,											// InputAddrMedianIncome						
											c=94 =>		le.InputAddrMedianHomeVal,										// InputAddrMedianValue							
											c=95 =>		le.InputAddrMurderIndex,											// InputAddrMurderIndex						
											c=96 =>		le.InputAddrCarTheftIndex,										// InputAddrCarTheftIndex							
											c=97 =>		le.InputAddrBurglaryIndex,										// InputAddrBurglaryIndex							
											c=98 =>		le.InputAddrCrimeIndex,												// InputAddrCrimeIndex					
											c=99 =>		le.TimeSinceCurrAddrFirstSeen,								// CurrAddrAgeOldestRecord									
											c=100 =>		le.TimeSinceCurrAddrLastSeen,									// CurrAddrAgeNewestRecord								
											c=101 =>		le.CurrAddrLenOfRes,													// CurrAddrLenOfRes				
											c=102 =>		le.Version3.CurrAddrDwellType,								// CurrAddrDwellType									
											c=103 =>		le.Version3.CurrAddrLandUseCode,							// CurrAddrLandUseCode										
											c=104 =>		le.Version3.CurrAddrApplicantOwned,						// CurrAddrApplicantOwned											
											c=105 =>		le.Version3.CurrAddrFamilyOwned,							// CurrAddrFamilyOwned										
											c=106 =>		le.Version3.CurrAddrOccupantOwned,						// CurrAddrOccupantOwned											
											c=107 =>		le.Version3.CurrAddrAgeLastSale,							// CurrAddrAgeLastSale										
											c=108 =>		le.CurrAddrLastSalesAmount,										// CurrAddrLastSalesPrice							
											c=109 =>		le.Version3.CurrAddrActivePhoneList,					// CurrAddrActivePhoneList												
											c=110 =>		le.CurrAddrActivePhoneNumber,									// CurrAddrActivePhoneNumber								
											c=111 =>		le.CurrAddrAssessedValue,											// CurrAddrTaxValue						
											c=112 =>		le.CurrAddrTaxAssessedYr,											// CurrAddrTaxYr						
											c=113 =>		le.CurrAddrAssessMarket,											// CurrAddrTaxMarketValue						
											c=114 =>		le.CurrAddrTaxAssessVal,											// CurrAddrAVMTax						
											c=115 =>		le.CurrAddrPriceIndVal,												// CurrAddrAVMSalesPrice					
											c=116 =>		le.CurrAddrHedVal,														// CurrAddrAVMHedonic			
											c=117 =>		le.CurrAddrAutoVal,														// CurrAddrAVMValue			
											c=118 =>		le.CurrAddrConfScore,													// CurrAddrAVMConfidence				
											c=119 =>		le.CurrAddrCountyIndex,												// CurrAddrCountyIndex					
											c=120 =>		le.CurrAddrTractIndex,												// CurrAddrTractIndex					
											c=121 =>		le.CurrAddrBlockIndex,												// CurrAddrBlockIndex					
											c=122 =>		le.CurrAddrMedianIncome,											// CurrAddrMedianIncome						
											c=123 =>		le.CurrAddrMedianHomeVal,											// CurrAddrMedianValue						
											c=124 =>		le.CurrAddrMurderIndex,												// CurrAddrMurderIndex					
											c=125 =>		le.CurrAddrCarTheftIndex,											// CurrAddrCarTheftIndex						
											c=126 =>		le.CurrAddrBurglaryIndex,											// CurrAddrBurglaryIndex						
											c=127 =>		le.CurrAddrCrimeIndex,												// CurrAddrCrimeIndex					
											c=128 =>		le.TimeSincePrevAddrFirstSeen,								// PrevAddrAgeOldestRecord									
											c=129 =>		le.TimeSincePrevAddrLastSeen,									// PrevAddrAgeNewestRecord								
											c=130 =>		le.PrevAddrLenOfRes,													// PrevAddrLenOfRes				
											c=131 =>		le.Version3.PrevAddrDwellType,								// PrevAddrDwellType									
											c=132 =>		le.Version3.PrevAddrLandUseCode,							// PrevAddrLandUseCode										
											c=133 =>		le.Version3.PrevAddrApplicantOwned,						// PrevAddrApplicantOwned											
											c=134 =>		le.Version3.PrevAddrFamilyOwned,							// PrevAddrFamilyOwned										
											c=135 =>		le.Version3.PrevAddrOccupantOwned,						// PrevAddrOccupantOwned											
											c=136 =>		le.Version3.PrevAddrAgeLastSale,							// PrevAddrAgeLastSale										
											c=137 =>		le.PrevAddrLastSalesAmount,										// PrevAddrLastSalesPrice							
											c=138 =>		le.Version3.PrevAddrActivePhoneList,					// PrevAddrActivePhoneList												
											c=139 =>		le.PrevAddrActivePhoneNumber,									// PrevAddrActivePhoneNumber								
											c=140 =>		le.PrevAddrAssessedValue,											// PrevAddrTaxValue						
											c=141 =>		le.PrevAddrTaxAssessedYr,											// PrevAddrTaxYr						
											c=142 =>		le.PrevAddrAssessMarket,											// PrevAddrTaxMarketValue						
											c=143 =>		le.PrevAddrTaxAssessVal,											// PrevAddrAVMTax						
											c=144 =>		le.PrevAddrPriceIndVal,												// PrevAddrAVMSalesPrice					
											c=145 =>		le.PrevAddrHedVal,														// PrevAddrAVMHedonic			
											c=146 =>		le.PrevAddrAutoVal,														// PrevAddrAVMValue			
											c=147 =>		le.PrevAddrConfScore,													// PrevAddrAVMConfidence				
											c=148 =>		le.PrevAddrCountyIndex,												// PrevAddrCountyIndex					
											c=149 =>		le.PrevAddrTractIndex,												// PrevAddrTractIndex					
											c=150 =>		le.PrevAddrBlockIndex,												// PrevAddrBlockIndex					
											c=151 =>		le.PrevAddrMedianIncome,											// PrevAddrMedianIncome						
											c=152 =>		le.PrevAddrMedianHomeVal,											// PrevAddrMedianValue						
											c=153 =>		le.PrevAddrMurderIndex,												// PrevAddrMurderIndex					
											c=154 =>		le.PrevAddrCarTheftIndex,											// PrevAddrCarTheftIndex						
											c=155 =>		le.PrevAddrBurglaryIndex,											// PrevAddrBurglaryIndex						
											c=156 =>		le.PrevAddrCrimeIndex,												// PrevAddrCrimeIndex					
											c=157 =>		le.Version3.InputCurrAddrMatch,								// InputCurrAddrMatch									
											c=158 =>		le.InputAddrCurrAddrDistance,									// InputCurrAddrDistance								
											c=159 =>		le.Version3.InputCurrAddrStateDiff,						// InputCurrAddrStateDiff											
											c=160 =>		le.InputAddrCurrAddrAssessedDiff,							// InputCurrAddrTaxDiff										
											c=161 =>		le.InputAddrCurrAddrIncomeDiff,								// InputCurrAddrIncomeDiff									
											c=162 =>		le.InputAddrCurrAddrHomeValDiff,							// InputCurrAddrValueDiff										
											c=163 =>		le.InputAddrCurrAddrCrimeDiff,								// InputCurrAddrCrimeDiff									
											c=164 =>		le.EconomicTrajectory,												// InputCurrEconTrajectory					
											c=165 =>		le.Version3.InputPrevAddrMatch,								// InputPrevAddrMatch									
											c=166 =>		le.CurrAddrPrevAddrDistance,									// CurrPrevAddrDistance								
											c=167 =>		le.Version3.CurrPrevAddrStateDiff,						// CurrPrevAddrStateDiff											
											c=168 =>		le.CurrAddrPrevAddrAssessedDiff,							// CurrPrevAddrTaxDiff										
											c=169 =>		le.CurrAddrPrevAddrIncomeDiff,								// CurrPrevAddrIncomeDiff									
											c=170 =>		le.CurrAddrPrevAddrHomeValDiff,								// CurrPrevAddrValueDiff									
											c=171 =>		le.CurrAddrPrevAddrCrimeDiff,									// CurrPrevAddrCrimeDiff								
											c=172 =>		le.EconomicTrajectory2,												// PrevCurrEconTrajectory					
											c=173 =>		le.Version3.EducationAttendedCollege,					// EducationAttendedCollege												
											c=174 =>		le.Version3.EducationProgram2Yr,							// EducationProgram2Yr										
											c=175 =>		le.Version3.EducationProgram4Yr,							// EducationProgram4Yr										
											c=176 =>		le.Version3.EducationProgramGraduate,					// EducationProgramGraduate												
											c=177 =>		le.Version3.EducationInstitutionPrivate,			// EducationInstitutionPrivate														
											c=178 =>		le.Version3.EducationInstitutionRating,				// EducationInstitutionRating													
											c=179 =>		le.Version3.EducationFieldofStudyType,				// EducationFieldofStudyType													
											c=180 =>		le.AddrStability,															// AddrStability		
											c=181 =>		le.Version3.StatusMostRecent,									// StatusMostRecent								
											c=182 =>		le.Version3.StatusPrevious,										// StatusPrevious							
											c=183 =>		le.Version3.StatusNextPrevious,								// StatusNextPrevious									
											c=184 =>		le.Version3.AddrChangeCount01,								// AddrChangeCount01									
											c=185 =>		le.Version3.AddrChangeCount03,								// AddrChangeCount03									
											c=186 =>		le.Version3.AddrChangeCount06,								// AddrChangeCount06									
											c=187 =>		le.Version3.AddrChangeCount12,								// AddrChangeCount12									
											c=188 =>		le.Version3.AddrChangeCount24,								// AddrChangeCount24									
											c=189 =>		le.Version3.AddrChangeCount36,								// AddrChangeCount36									
											c=190 =>		le.Version3.AddrChangeCount60,								// AddrChangeCount60									
											c=191 =>		le.Version3.PredictedAnnualIncome,						// PredictedAnnualIncome											
											c=192 =>		le.Version3.PropOwnedCount,										// PropOwnedCount							
											c=193 =>		le.PropertyOwnedAssessedTotal,								// PropOwnedTaxTotal									
											c=194 =>		le.Version3.PropOwnedHistoricalCount,					// PropOwnedHistoricalCount												
											c=195 =>		le.Version3.PropAgeOldestPurchase,						// PropAgeOldestPurchase											
											c=196 =>		le.Version3.PropAgeNewestPurchase,						// PropAgeNewestPurchase											
											c=197 =>		le.Version3.PropAgeNewestSale,								// PropAgeNewestSale									
											c=198 =>		le.Version3.PropNewestSalePurchaseIndex,			// PropNewestSalePurchaseIndex														
											c=199 =>		le.Version3.PropPurchasedCount01,							// PropPurchasedCount01										
											c=200 =>		le.Version3.PropPurchasedCount03,							// PropPurchasedCount03										
											c=201 =>		le.Version3.PropPurchasedCount06,							// PropPurchasedCount06										
											c=202 =>		le.Version3.PropPurchasedCount12,							// PropPurchasedCount12										
											c=203 =>		le.Version3.PropPurchasedCount24,							// PropPurchasedCount24										
											c=204 =>		le.Version3.PropPurchasedCount36,							// PropPurchasedCount36										
											c=205 =>		le.Version3.PropPurchasedCount60,							// PropPurchasedCount60										
											c=206 =>		le.Version3.PropSoldCount01,									// PropSoldCount01								
											c=207 =>		le.Version3.PropSoldCount03,									// PropSoldCount03								
											c=208 =>		le.Version3.PropSoldCount06,									// PropSoldCount06								
											c=209 =>		le.Version3.PropSoldCount12,									// PropSoldCount12								
											c=210 =>		le.Version3.PropSoldCount24,									// PropSoldCount24								
											c=211 =>		le.Version3.PropSoldCount36,									// PropSoldCount36								
											c=212 =>		le.Version3.PropSoldCount60,									// PropSoldCount60								
											c=213 =>		le.Version3.WatercraftCount,									// WatercraftCount								
											c=214 =>		le.Version3.WatercraftCount01,								// WatercraftCount01									
											c=215 =>		le.Version3.WatercraftCount03,								// WatercraftCount03									
											c=216 =>		le.Version3.WatercraftCount06,								// WatercraftCount06									
											c=217 =>		le.Version3.WatercraftCount12,								// WatercraftCount12									
											c=218 =>		le.Version3.WatercraftCount24,								// WatercraftCount24									
											c=219 =>		le.Version3.WatercraftCount36,								// WatercraftCount36									
											c=220 =>		le.Version3.WatercraftCount60,								// WatercraftCount60									
											c=221 =>		le.Version3.AircraftCount,										// AircraftCount							
											c=222 =>		le.Version3.AircraftCount01,									// AircraftCount01								
											c=223 =>		le.Version3.AircraftCount03,									// AircraftCount03								
											c=224 =>		le.Version3.AircraftCount06,									// AircraftCount06								
											c=225 =>		le.Version3.AircraftCount12,									// AircraftCount12								
											c=226 =>		le.Version3.AircraftCount24,									// AircraftCount24								
											c=227 =>		le.Version3.AircraftCount36,									// AircraftCount36								
											c=228 =>		le.Version3.AircraftCount60,									// AircraftCount60								
											c=229 =>		le.WealthIndex,																// WealthIndex	
											c=230 =>		le.Version3.SubPrimeSolicitedCount,						// SubPrimeSolicitedCount											
											c=231 =>		le.Version3.SubPrimeSolicitedCount01,					// SubPrimeSolicitedCount01												
											c=232 =>		le.Version3.SubPrimeSolicitedCount03,					// SubPrimeSolicitedCount03												
											c=233 =>		le.Version3.SubPrimeSolicitedCount06,					// SubPrimeSolicitedCount06												
											c=234 =>		le.Version3.SubPrimeSolicitedCount12,					// SubPrimeSolicitedCount12												
											c=235 =>		le.Version3.SubPrimeSolicitedCount24,					// SubPrimeSolicitedCount24												
											c=236 =>		le.Version3.SubPrimeSolicitedCount36,					// SubPrimeSolicitedCount36												
											c=237 =>		le.Version3.SubPrimeSolicitedCount60,					// SubPrimeSolicitedCount60												
											c=238 =>		le.Version3.DerogSeverityIndex,								// DerogSeverityIndex									
											c=239 =>		le.Version3.DerogCount,												// DerogCount					
											c=240 =>		le.Version3.DerogAge,													// DerogAge				
											c=241 =>		le.Version3.FelonyCount,											// FelonyCount						
											c=242 =>		le.Version3.FelonyAge,												// FelonyAge					
											c=243 =>		le.Version3.FelonyCount01,										// FelonyCount01							
											c=244 =>		le.Version3.FelonyCount03,										// FelonyCount03							
											c=245 =>		le.Version3.FelonyCount06,										// FelonyCount06							
											c=246 =>		le.Version3.FelonyCount12,										// FelonyCount12							
											c=247 =>		le.Version3.FelonyCount24,										// FelonyCount24							
											c=248 =>		le.Version3.FelonyCount36,										// FelonyCount36							
											c=249 =>		le.Version3.FelonyCount60,										// FelonyCount60							
											c=250 =>		le.Version3.ArrestCount,											// ArrestCount						
											c=251 =>		le.Version3.ArrestAge,												// ArrestAge					
											c=252 =>		le.Version3.ArrestCount01,										// ArrestCount01							
											c=253 =>		le.Version3.ArrestCount03,										// ArrestCount03							
											c=254 =>		le.Version3.ArrestCount06,										// ArrestCount06							
											c=255 =>		le.Version3.ArrestCount12,										// ArrestCount12							
											c=256 =>		le.Version3.ArrestCount24,										// ArrestCount24							
											c=257 =>		le.Version3.ArrestCount36,										// ArrestCount36							
											c=258 =>		le.Version3.ArrestCount60,										// ArrestCount60							
											c=259 =>		le.Version3.LienCount,												// LienCount					
											c=260 =>		le.Version3.LienFiledCount,										// LienFiledCount							
											c=261 =>		le.Version3.LienFiledAge,											// LienFiledAge						
											c=262 =>		le.Version3.LienFiledCount01,									// LienFiledCount01								
											c=263 =>		le.Version3.LienFiledCount03,									// LienFiledCount03								
											c=264 =>		le.Version3.LienFiledCount06,									// LienFiledCount06								
											c=265 =>		le.Version3.LienFiledCount12,									// LienFiledCount12								
											c=266 =>		le.Version3.LienFiledCount24,									// LienFiledCount24								
											c=267 =>		le.Version3.LienFiledCount36,									// LienFiledCount36								
											c=268 =>		le.Version3.LienFiledCount60,									// LienFiledCount60								
											c=269 =>		le.Version3.LienReleasedCount,								// LienReleasedCount									
											c=270 =>		le.Version3.LienReleasedAge,									// LienReleasedAge								
											c=271 =>		le.Version3.LienReleasedCount01,							// LienReleasedCount01										
											c=272 =>		le.Version3.LienReleasedCount03,							// LienReleasedCount03										
											c=273 =>		le.Version3.LienReleasedCount06,							// LienReleasedCount06										
											c=274 =>		le.Version3.LienReleasedCount12,							// LienReleasedCount12										
											c=275 =>		le.Version3.LienReleasedCount24,							// LienReleasedCount24										
											c=276 =>		le.Version3.LienReleasedCount36,							// LienReleasedCount36										
											c=277 =>		le.Version3.LienReleasedCount60,							// LienReleasedCount60										
											c=278 =>		le.Version3.BankruptcyCount,									// BankruptcyCount								
											c=279 =>		le.Version3.BankruptcyAge,										// BankruptcyAge							
											c=280 =>		le.Version3.BankruptcyType,										// BankruptcyType							
											c=281 =>		le.MostRecentBankruptStatus,									// BankruptcyStatus								
											c=282 =>		le.Version3.BankruptcyCount01,								// BankruptcyCount01									
											c=283 =>		le.Version3.BankruptcyCount03,								// BankruptcyCount03									
											c=284 =>		le.Version3.BankruptcyCount06,								// BankruptcyCount06									
											c=285 =>		le.Version3.BankruptcyCount12,								// BankruptcyCount12									
											c=286 =>		le.Version3.BankruptcyCount24,								// BankruptcyCount24									
											c=287 =>		le.Version3.BankruptcyCount36,								// BankruptcyCount36									
											c=288 =>		le.Version3.BankruptcyCount60,								// BankruptcyCount60									
											c=289 =>		le.Version3.EvictionCount,										// EvictionCount							
											c=290 =>		le.Version3.EvictionAge,											// EvictionAge						
											c=291 =>		le.Version3.EvictionCount01,									// EvictionCount01								
											c=292 =>		le.Version3.EvictionCount03,									// EvictionCount03								
											c=293 =>		le.Version3.EvictionCount06,									// EvictionCount06								
											c=294 =>		le.Version3.EvictionCount12,									// EvictionCount12								
											c=295 =>		le.Version3.EvictionCount24,									// EvictionCount24								
											c=296 =>		le.Version3.EvictionCount36,									// EvictionCount36								
											c=297 =>		le.Version3.EvictionCount60,									// EvictionCount60								
											c=298 =>		le.Version3.NonDerogCount,										// NonDerogCount							
											c=299 =>		le.Version3.NonDerogCount01,									// NonDerogCount01								
											c=300 =>		le.Version3.NonDerogCount03,									// NonDerogCount03								
											c=301 =>		le.Version3.NonDerogCount06,									// NonDerogCount06								
											c=302 =>		le.Version3.NonDerogCount12,									// NonDerogCount12								
											c=303 =>		le.Version3.NonDerogCount24,									// NonDerogCount24								
											c=304 =>		le.Version3.NonDerogCount36,									// NonDerogCount36								
											c=305 =>		le.Version3.NonDerogCount60,									// NonDerogCount60								
											c=306 =>		le.Version3.ProfLicCount,											// ProfLicCount						
											c=307 =>		le.Version3.ProfLicAge,												// ProfLicAge					
											c=308 =>		le.Version3.ProfLicTypeCategory,							// ProfLicTypeCategory										
											c=309 =>		le.MostRecentProfLicExpireDate,								// ProfLicExpireDate									
											c=310 =>		le.Version3.ProfLicCount01,										// ProfLicCount01							
											c=311 =>		le.Version3.ProfLicCount03,										// ProfLicCount03							
											c=312 =>		le.Version3.ProfLicCount06,										// ProfLicCount06							
											c=313 =>		le.Version3.ProfLicCount12,										// ProfLicCount12							
											c=314 =>		le.Version3.ProfLicCount24,										// ProfLicCount24							
											c=315 =>		le.Version3.ProfLicCount36,										// ProfLicCount36							
											c=316 =>		le.Version3.ProfLicCount60,										// ProfLicCount60							
											c=317 =>		le.Version3.ProfLicExpireCount01,							// ProfLicExpireCount01										
											c=318 =>		le.Version3.ProfLicExpireCount03,							// ProfLicExpireCount03										
											c=319 =>		le.Version3.ProfLicExpireCount06,							// ProfLicExpireCount06										
											c=320 =>		le.Version3.ProfLicExpireCount12,							// ProfLicExpireCount12										
											c=321 =>		le.Version3.ProfLicExpireCount24,							// ProfLicExpireCount24										
											c=322 =>		le.Version3.ProfLicExpireCount36,							// ProfLicExpireCount36										
											c=323 =>		le.Version3.ProfLicExpireCount60,							// ProfLicExpireCount60										
											c=324 =>		le.Version3.PRSearchCollectionCount,					// PRSearchCollectionCount												
											c=325 =>		le.Version3.PRSearchCollectionCount01,				// PRSearchCollectionCount01													
											c=326 =>		le.Version3.PRSearchCollectionCount03,				// PRSearchCollectionCount03													
											c=327 =>		le.Version3.PRSearchCollectionCount06,				// PRSearchCollectionCount06													
											c=328 =>		le.Version3.PRSearchCollectionCount12,				// PRSearchCollectionCount12													
											c=329 =>		le.Version3.PRSearchCollectionCount24,				// PRSearchCollectionCount24													
											c=330 =>		le.Version3.PRSearchCollectionCount36,				// PRSearchCollectionCount36													
											c=331 =>		le.Version3.PRSearchCollectionCount60,				// PRSearchCollectionCount60													
											c=332 =>		le.Version3.PRSearchIDVFraudCount,						// PRSearchIDVFraudCount											
											c=333 =>		le.Version3.PRSearchIDVFraudCount01,					// PRSearchIDVFraudCount01												
											c=334 =>		le.Version3.PRSearchIDVFraudCount03,					// PRSearchIDVFraudCount03												
											c=335 =>		le.Version3.PRSearchIDVFraudCount06,					// PRSearchIDVFraudCount06												
											c=336 =>		le.Version3.PRSearchIDVFraudCount12,					// PRSearchIDVFraudCount12												
											c=337 =>		le.Version3.PRSearchIDVFraudCount24,					// PRSearchIDVFraudCount24												
											c=338 =>		le.Version3.PRSearchIDVFraudCount36,					// PRSearchIDVFraudCount36												
											c=339 =>		le.Version3.PRSearchIDVFraudCount60,					// PRSearchIDVFraudCount60												
											c=340 =>		le.Version3.PRSearchOtherCount,								// PRSearchOtherCount									
											c=341 =>		le.Version3.PRSearchOtherCount01,							// PRSearchOtherCount01										
											c=342 =>		le.Version3.PRSearchOtherCount03,							// PRSearchOtherCount03										
											c=343 =>		le.Version3.PRSearchOtherCount06,							// PRSearchOtherCount06										
											c=344 =>		le.Version3.PRSearchOtherCount12,							// PRSearchOtherCount12										
											c=345 =>		le.Version3.PRSearchOtherCount24,							// PRSearchOtherCount24										
											c=346 =>		le.Version3.PRSearchOtherCount36,							// PRSearchOtherCount36										
											c=347 =>		le.Version3.PRSearchOtherCount60,							// PRSearchOtherCount60										
											c=348 =>		le.Version3.InputPhoneStatus,									// InputPhoneStatus								
											c=349 =>		le.Version3.InputPhonePager,									// InputPhonePager								
											c=350 =>		le.Version3.InputPhoneMobile,									// InputPhoneMobile								
											c=351 =>		le.Version3.InputPhoneType,										// InputPhoneType							
											c=352 =>		le.ServiceType,																// InputPhoneServiceType	
											c=353 =>		le.Version3.InputAreaCodeChange,							// InputAreaCodeChange										
											c=354 =>		le.TimeSinceSubjectPhoneFirstSeen,						// PhoneEDAAgeOldestRecord											
											c=355 =>		le.TimeSinceSubjectPhoneLastSeen,							// PhoneEDAAgeNewestRecord										
											c=356 =>		le.Version3.PhoneOtherAgeOldestRecord,				// PhoneOtherAgeOldestRecord													
											c=357 =>		le.Version3.PhoneOtherAgeNewestRecord,				// PhoneOtherAgeNewestRecord													
											c=358 =>		le.Version3.InvalidPhoneZip,									// InvalidPhoneZip								
											c=359 =>		le.InputPhoneAddrDist,												// InputPhoneAddrDist					
											c=360 =>		le.SIC,																				// InputAddrSICCode
											c=361 =>		le.Version3.InputAddrValidation,							// InputAddrValidation										
											c=362 =>		le.AddrValErrorCode,													// InputAddrErrorCode				
											c=363 =>		le.Version3.InputAddrHighRisk,								// InputAddrHighRisk									
											c=364 =>		le.Version3.InputPhoneHighRisk,								// InputPhoneHighRisk									
											c=365 =>		le.Version3.InputAddrPrison,									// InputAddrPrison								
											c=366 =>		le.Version3.CurrAddrPrison,										// CurrAddrPrison							
											c=367 =>		le.Version3.PrevAddrPrison,										// PrevAddrPrison							
											c=368 =>		le.Version3.HistoricalAddrPrison,							// HistoricalAddrPrison										
											c=369 =>		le.Version3.InputZipPOBox,										// InputZipPOBox							
											c=370 =>		le.Version3.InputZipCorpMil,									// InputZipCorpMil								
																	le.DoNotMail																	// DoNotMail
										 );
	END;
	
	iesp.share.t_NameValuePair intoVersion4(results le, INTEGER c) := TRANSFORM
		SELF.name := MAP(
			c=1 => 'AgeOldestRecord',
			c=2 => 'AgeNewestRecord',
			c=3 => 'RecentUpdate',
			c=4 => 'SrcsConfirmIDAddrCount',
			c=5 => 'CreditBureauRecord',
			c=6 => 'VerificationFailure',
			c=7 => 'SSNNotFound',
			c=8 => 'SSNFoundOther',
			c=9 => 'VerifiedName',
			c=10 => 'VerifiedSSN',
			c=11 => 'VerifiedPhone',
			c=12 => 'VerifiedAddress',
			c=13 => 'VerifiedDOB',
			c=14 => 'AgeRiskIndicator',
			c=15 => 'SubjectSSNCount',
			c=16 => 'SubjectAddrCount',
			c=17 => 'SubjectPhoneCount',
			c=18 => 'SubjectSSNRecentCount',
			c=19 => 'SubjectAddrRecentCount',
			c=20 => 'SubjectPhoneRecentCount',
			c=21 => 'SSNIdentitiesCount',
			c=22 => 'SSNAddrCount',
			c=23 => 'SSNIdentitiesRecentCount',
			c=24 => 'SSNAddrRecentCount',
			c=25 => 'InputAddrPhoneCount',
			c=26 => 'InputAddrPhoneRecentCount',
			c=27 => 'PhoneIdentitiesCount',
			c=28 => 'PhoneIdentitiesRecentCount',
			c=29 => 'PhoneOther',
			c=30 => 'SSNLastNameCount',
			c=31 => 'SubjectLastNameCount',
			c=32 => 'LastNameChangeAge',
			c=33 => 'LastNameChangeCount01',
			c=34 => 'LastNameChangeCount03',
			c=35 => 'LastNameChangeCount06',
			c=36 => 'LastNameChangeCount12',
			c=37 => 'LastNameChangeCount24',
			c=38 => 'LastNameChangeCount60',
			c=39 => 'SFDUAddrIdentitiesCount',
			c=40 => 'SFDUAddrSSNCount',
			c=41 => 'SSNAgeDeceased',
			c=42 => 'SSNRecent',
			c=43 => 'SSNLowIssueAge',
			c=44 => 'SSNHighIssueAge',
			c=45 => 'SSNIssueState',
			c=46 => 'SSNNonUS',
			c=47 => 'SSN3Years',
			c=48 => 'SSNAfter5 ',
			c=49 => 'SSNProblems',
			c=50 => 'RelativesCount',
			c=51 => 'RelativesBankruptcyCount',
			c=52 => 'RelativesFelonyCount',
			c=53 => 'RelativesPropOwnedCount',
			c=54 => 'RelativesPropOwnedTaxTotal',
			c=55 => 'RelativesDistanceClosest',
			c=56 => 'InputAddrAgeOldestRecord',
			c=57 => 'InputAddrAgeNewestRecord',
			c=58 => 'InputAddrHistoricalMatch',
			c=59 => 'InputAddrLenOfRes ',
			c=60 => 'InputAddrDwellType ',
			c=61 => 'InputAddrDelivery',
			c=62 => 'InputAddrApplicantOwned',
			c=63 => 'InputAddrFamilyOwned',
			c=64 => 'InputAddrOccupantOwned ',
			c=65 => 'InputAddrAgeLastSale',
			c=66 => 'InputAddrLastSalesPrice',
			c=67 => 'InputAddrMortgageType',
			c=68 => 'InputAddrNotPrimaryRes',
			c=69 => 'InputAddrActivePhoneList',
			c=70 => 'InputAddrTaxValue ',
			c=71 => 'InputAddrTaxYr',
			c=72 => 'InputAddrTaxMarketValue',
			c=73 => 'InputAddrAVMValue',
			c=74 => 'InputAddrAVMValue12',
			c=75 => 'InputAddrAVMValue60',
			c=76 => 'InputAddrCountyIndex',
			c=77 => 'InputAddrTractIndex',
			c=78 => 'InputAddrBlockIndex',
			c=79 => 'InputAddrMedianIncome',
			c=80 => 'InputAddrMedianValue',
			c=81 => 'InputAddrMurderIndex',
			c=82 => 'InputAddrCarTheftIndex',
			c=83 => 'InputAddrBurglaryIndex',
			c=84 => 'InputAddrCrimeIndex',
			c=85 => 'InputAddrMobilityIndex',
			c=86 => 'InputAddrVacantPropCount',
			c=87 => 'InputAddrBusinessCount',
			c=88 => 'InputAddrSingleFamilyCount',
			c=89 => 'InputAddrMultiFamilyCount',
			c=90 => 'CurrAddrAgeOldestRecord',
			c=91 => 'CurrAddrAgeNewestRecord',
			c=92 => 'CurrAddrLenOfRes ',
			c=93 => 'CurrAddrDwellType ',
			c=94 => 'CurrAddrApplicantOwned ',
			c=95 => 'CurrAddrFamilyOwned ',
			c=96 => 'CurrAddrOccupantOwned ',
			c=97 => 'CurrAddrAgeLastSale',
			c=98 => 'CurrAddrLastSalesPrice',
			c=99 => 'CurrAddrMortgageType',
			c=100 => 'CurrAddrActivePhoneList ',
			c=101 => 'CurrAddrTaxValue ',
			c=102 => 'CurrAddrTaxYr',
			c=103 => 'CurrAddrTaxMarketValue',
			c=104 => 'CurrAddrAVMValue',
			c=105 => 'CurrAddrAVMValue12',
			c=106 => 'CurrAddrAVMValue60',
			c=107 => 'CurrAddrCountyIndex',
			c=108 => 'CurrAddrTractIndex',
			c=109 => 'CurrAddrBlockIndex',
			c=110 => 'CurrAddrMedianIncome',
			c=111 => 'CurrAddrMedianValue',
			c=112 => 'CurrAddrMurderIndex',
			c=113 => 'CurrAddrCarTheftIndex',
			c=114 => 'CurrAddrBurglaryIndex',
			c=115 => 'CurrAddrCrimeIndex',
			c=116 => 'PrevAddrAgeOldestRecord',
			c=117 => 'PrevAddrAgeNewestRecord',
			c=118 => 'PrevAddrLenOfRes ',
			c=119 => 'PrevAddrDwellType ',
			c=120 => 'PrevAddrApplicantOwned ',
			c=121 => 'PrevAddrFamilyOwned ',
			c=122 => 'PrevAddrOccupantOwned',
			c=123 => 'PrevAddrAgeLastSale',
			c=124 => 'PrevAddrLastSalesPrice',
			c=125 => 'PrevAddrTaxValue',
			c=126 => 'PrevAddrTaxYr',
			c=127 => 'PrevAddrTaxMarketValue',
			c=128 => 'PrevAddrAVMValue',
			c=129 => 'PrevAddrCountyIndex',
			c=130 => 'PrevAddrTractIndex',
			c=131 => 'PrevAddrBlockIndex',
			c=132 => 'PrevAddrMedianIncome',
			c=133 => 'PrevAddrMedianValue',
			c=134 => 'PrevAddrMurderIndex',
			c=135 => 'PrevAddrCarTheftIndex',
			c=136 => 'PrevAddrBurglaryIndex',
			c=137 => 'PrevAddrCrimeIndex',
			c=138 => 'AddrMostRecentDistance',
			c=139 => 'AddrMostRecentStateDiff',
			c=140 => 'AddrMostRecentTaxDiff',
			c=141 => 'AddrMostRecentMoveAge',
			c=142 => 'AddrMostRecentIncomeDiff',
			c=143 => 'AddrMostRecentValueDIff',
			c=144 => 'AddrMostRecentCrimeDiff',
			c=145 => 'AddrRecentEconTrajectory',
			c=146 => 'AddrRecentEconTrajectoryIndex',
			c=147 => 'EducationAttendedCollege',
			c=148 => 'EducationProgram2Yr',
			c=149 => 'EducationProgram4Yr',
			c=150 => 'EducationProgramGraduate',
			c=151 => 'EducationInstitutionPrivate',
			c=152 => 'EducationInstitutionRating',
			c=153 => 'EducationFieldofStudyType',
			c=154 => 'AddrStability',
			c=155 => 'StatusMostRecent ',
			c=156 => 'StatusPrevious ',
			c=157 => 'StatusNextPrevious',
			c=158 => 'AddrChangeCount01',
			c=159 => 'AddrChangeCount03',
			c=160 => 'AddrChangeCount06',
			c=161 => 'AddrChangeCount12',
			c=162 => 'AddrChangeCount24 ',
			c=163 => 'AddrChangeCount60 ',
			c=164 => 'EstimatedAnnualIncome',
			c=165 => 'AssetOwner',
			c=166 => 'PropertyOwner',
			c=167 => 'PropOwnedCount',
			c=168 => 'PropOwnedTaxTotal',
			c=169 => 'PropOwnedHistoricalCount',
			c=170 => 'PropAgeOldestPurchase',
			c=171 => 'PropAgeNewestPurchase',
			c=172 => 'PropAgeNewestSale',
			c=173 => 'PropNewestSalePrice',
			c=174 => 'PropNewestSalePurchaseIndex',
			c=175 => 'PropPurchasedCount01',
			c=176 => 'PropPurchasedCount03',
			c=177 => 'PropPurchasedCount06',
			c=178 => 'PropPurchasedCount12',
			c=179 => 'PropPurchasedCount24',
			c=180 => 'PropPurchasedCount60',
			c=181 => 'PropSoldCount01',
			c=182 => 'PropSoldCount03',
			c=183 => 'PropSoldCount06',
			c=184 => 'PropSoldCount12',
			c=185 => 'PropSoldCount24 ',
			c=186 => 'PropSoldCount60 ',
			c=187 => 'WatercraftOwner',
			c=188 => 'WatercraftCount',
			c=189 => 'WatercraftCount01',
			c=190 => 'WatercraftCount03',
			c=191 => 'WatercraftCount06',
			c=192 => 'WatercraftCount12 ',
			c=193 => 'WatercraftCount24',
			c=194 => 'WatercraftCount60 ',
			c=195 => 'AircraftOwner',
			c=196 => 'AircraftCount',
			c=197 => 'AircraftCount01',
			c=198 => 'AircraftCount03',
			c=199 => 'AircraftCount06',
			c=200 => 'AircraftCount12 ',
			c=201 => 'AircraftCount24',
			c=202 => 'AircraftCount60 ',
			c=203 => 'WealthIndex',
			c=204 => 'BusinessActiveAssociation',
			c=205 => 'BusinessInactiveAssociation',
			c=206 => 'BusinessAssociationAge',
			c=207 => 'BusinessTitle',
			c=208 => 'BusinessInputAddrCount',
			c=209 => 'DerogSeverityIndex',
			c=210 => 'DerogCount',
			c=211 => 'DerogRecentCount',
			c=212 => 'DerogAge',
			c=213 => 'FelonyCount',
			c=214 => 'FelonyAge',
			c=215 => 'FelonyCount01',
			c=216 => 'FelonyCount03',
			c=217 => 'FelonyCount06',
			c=218 => 'FelonyCount12',
			c=219 => 'FelonyCount24',
			c=220 => 'FelonyCount60',
			c=221 => 'ArrestCount',
			c=222 => 'ArrestAge',
			c=223 => 'ArrestCount01',
			c=224 => 'ArrestCount03',
			c=225 => 'ArrestCount06',
			c=226 => 'ArrestCount12',
			c=227 => 'ArrestCount24',
			c=228 => 'ArrestCount60',
			c=229 => 'LienCount',
			c=230 => 'LienFiledCount',
			c=231 => 'LienFiledTotal',
			c=232 => 'LienFiledAge',
			c=233 => 'LienFiledCount01',
			c=234 => 'LienFiledCount03',
			c=235 => 'LienFiledCount06',
			c=236 => 'LienFiledCount12',
			c=237 => 'LienFiledCount24',
			c=238 => 'LienFiledCount60',
			c=239 => 'LienReleasedCount',
			c=240 => 'LienReleasedTotal',
			c=241 => 'LienReleasedAge',
			c=242 => 'LienReleasedCount01',
			c=243 => 'LienReleasedCount03',
			c=244 => 'LienReleasedCount06',
			c=245 => 'LienReleasedCount12',
			c=246 => 'LienReleasedCount24',
			c=247 => 'LienReleasedCount60',
			c=248 => 'BankruptcyCount',
			c=249 => 'BankruptcyAge',
			c=250 => 'BankruptcyType',
			c=251 => 'BankruptcyStatus',
			c=252 => 'BankruptcyCount01',
			c=253 => 'BankruptcyCount03',
			c=254 => 'BankruptcyCount06',
			c=255 => 'BankruptcyCount12',
			c=256 => 'BankruptcyCount24',
			c=257 => 'BankruptcyCount60',
			c=258 => 'EvictionCount',
			c=259 => 'EvictionAge',
			c=260 => 'EvictionCount01',
			c=261 => 'EvictionCount03',
			c=262 => 'EvictionCount06',
			c=263 => 'EvictionCount12 ',
			c=264 => 'EvictionCount24 ',
			c=265 => 'EvictionCount60 ',
			c=266 => 'AccidentCount',
			c=267 => 'AccidentAge',
			c=268 => 'RecentActivityIndex',
			c=269 => 'NonDerogCount',
			c=270 => 'NonDerogCount01',
			c=271 => 'NonDerogCount03',
			c=272 => 'NonDerogCount06',
			c=273 => 'NonDerogCount12',
			c=274 => 'NonDerogCount24',
			c=275 => 'NonDerogCount60',
			c=276 => 'VoterRegistrationRecord',
			c=277 => 'ProfLicCount',
			c=278 => 'ProfLicAge',
			c=279 => 'ProfLicTypeCategory',
			c=280 => 'ProfLicExpired',
			c=281 => 'ProfLicCount01',
			c=282 => 'ProfLicCount03',
			c=283 => 'ProfLicCount06',
			c=284 => 'ProfLicCount12',
			c=285 => 'ProfLicCount24',
			c=286 => 'ProfLicCount60',
			c=287 => 'PRSearchLocateCount',
			c=288 => 'PRSearchLocateCount01',
			c=289 => 'PRSearchLocateCount03',
			c=290 => 'PRSearchLocateCount06',
			c=291 => 'PRSearchLocateCount12',
			c=292 => 'PRSearchLocateCount24',
			c=293 => 'PRSearchPersonalFinanceCount',
			c=294 => 'PRSearchPersonalFinanceCount01',
			c=295 => 'PRSearchPersonalFinanceCount03',
			c=296 => 'PRSearchPersonalFinanceCount06',
			c=297 => 'PRSearchPersonalFinanceCount12',
			c=298 => 'PRSearchPersonalFinanceCount24',
			c=299 => 'PRSearchOtherCount',
			c=300 => 'PRSearchOtherCount01',
			c=301 => 'PRSearchOtherCount03',
			c=302 => 'PRSearchOtherCount06',
			c=303 => 'PRSearchOtherCount12',
			c=304 => 'PRSearchOtherCount24',
			c=305 => 'PRSearchIdentitySSNs',
			c=306 => 'PRSearchIdentityAddrs',
			c=307 => 'PRSearchIdentityPhones',
			c=308 => 'PRSearchSSNIdentities',
			c=309 => 'PRSearchAddrIdentities',
			c=310 => 'PRSearchPhoneIdentities',
			c=311 => 'SubPrimeOfferRequestCount',
			c=312 => 'SubPrimeOfferRequestCount01',
			c=313 => 'SubPrimeOfferRequestCount03',
			c=314 => 'SubPrimeOfferRequestCount06',
			c=315 => 'SubPrimeOfferRequestCount12',
			c=316 => 'SubPrimeOfferRequestCount24',
			c=317 => 'SubPrimeOfferRequestCount60',
			c=318 => 'InputPhoneMobile ',
			c=319 => 'InputPhoneType',
			c=320 => 'InputPhoneServiceType',
			c=321 => 'InputAreaCodeChange',
			c=322 => 'PhoneEDAAgeOldestRecord',
			c=323 => 'PhoneEDAAgeNewestRecord',
			c=324 => 'PhoneOtherAgeOldestRecord',
			c=325 => 'PhoneOtherAgeNewestRecord',
			c=326 => 'InputPhoneHighRisk',
			c=327 => 'InputPhoneProblems',
			c=328 => 'OnlineDirectory',
			c=329 => 'InputAddrSICCode',
			c=330 => 'InputAddrValidation',
			c=331 => 'InputAddrErrorCode',
			c=332 => 'InputAddrHighRisk',
			c=333 => 'CurrAddrCorrectional',
			c=334 => 'PrevAddrCorrectional',
			c=335 => 'HistoricalAddrCorrectional',
			c=336 => 'InputAddrProblems',
			c=337 => 'DoNotMail',
			c=338 => 'IdentityRiskLevel',
			c=339 => 'IDVerRiskLevel',
			c=340 => 'IDVerAddressAssocCount',
			c=341 => 'IDVerSSNCreditBureauCount',
			c=342 => 'IDVerSSNCreditBureauDelete',
			c=343 => 'SourceRiskLevel',
			c=344 => 'SourceWatchList',
			c=345 => 'SourceOrderActivity',
			c=346 => 'SourceOrderSourceCount',
			c=347 => 'SourceOrderAgeLastOrder',
			c=348 => 'VariationRiskLevel',
			c=349 => 'VariationIdentityCount',
			c=350 => 'VariationMSourcesSSNCount',
			c=351 => 'VariationMSourcesSSNUnrelCount',
			c=352 => 'VariationDOBCount',
			c=353 => 'VariationDOBCountNew',
			c=354 => 'SearchVelocityRiskLevel',
			c=355 => 'SearchUnverifiedSSNCountYear',
			c=356 => 'SearchUnverifiedAddrCountYear',
			c=357 => 'SearchUnverifiedDOBCountYear',
			c=358 => 'SearchUnverifiedPhoneCountYear',
			c=359 => 'AssocRiskLevel',
			c=360 => 'AssocSuspicousIdentitiesCount',
			c=361 => 'AssocCreditBureauOnlyCount',
			c=362 => 'AssocCreditBureauOnlyCountNew',
			c=363 => 'AssocCreditBureauOnlyCountMonth',
			c=364 => 'AssocHighRiskTopologyCount',
			c=365 => 'ValidationRiskLevel',
			c=366 => 'CorrelationRiskLevel',
			c=367 => 'DivRiskLevel',
			c=368 => 'DivSSNIdentityMSourceCount',
			c=369 => 'DivSSNIdentityMSourceUrelCount',
			c=370 => 'DivSSNLNameCountNew',
			c=371 => 'DivSSNAddrMSourceCount',
			c=372 => 'DivAddrIdentityCount',
			c=373 => 'DivAddrIdentityCountNew',
			c=374 => 'DivAddrIdentityMSourceCount',
			c=375 => 'DivAddrSuspIdentityCountNew',
			c=376 => 'DivAddrSSNCount',
			c=377 => 'DivAddrSSNCountNew',
			c=378 => 'DivAddrSSNMSourceCount',
			c=379 => 'DivSearchAddrSuspIdentityCount',
			c=380 => 'SearchComponentRiskLevel',
			c=381 => 'SearchSSNSearchCount',
			c=382 => 'SearchAddrSearchCount',
			c=383 => 'SearchPhoneSearchCount',
			c=384 => 'ComponentCharRiskLevel',
			''
		);

		SELF.value := MAP(
			c=1 => le.version4.AgeOldestRecord,
			c=2 => le.version4.AgeNewestRecord,
			c=3 => le.version4.RecentUpdate,
			c=4 => le.version4.SrcsConfirmIDAddrCount,
			c=5 => le.version4.CreditBureauRecord,
			c=6 => le.version4.VerificationFailure,
			c=7 => le.version4.SSNNotFound,
			c=8 => le.version4.SSNFoundOther,
			c=9 => le.version4.VerifiedName,
			c=10 => le.version4.VerifiedSSN,
			c=11 => le.version4.VerifiedPhone,
			c=12 => le.version4.VerifiedAddress,
			c=13 => le.version4.VerifiedDOB,
			c=14 => le.version4.AgeRiskIndicator,
			c=15 => le.version4.SubjectSSNCount,
			c=16 => le.version4.SubjectAddrCount,
			c=17 => le.version4.SubjectPhoneCount,
			c=18 => le.version4.SubjectSSNRecentCount,
			c=19 => le.version4.SubjectAddrRecentCount,
			c=20 => le.version4.SubjectPhoneRecentCount,
			c=21 => le.version4.SSNIdentitiesCount,
			c=22 => le.version4.SSNAddrCount,
			c=23 => le.version4.SSNIdentitiesRecentCount,
			c=24 => le.version4.SSNAddrRecentCount,
			c=25 => le.version4.InputAddrPhoneCount,
			c=26 => le.version4.InputAddrPhoneRecentCount,
			c=27 => le.version4.PhoneIdentitiesCount,
			c=28 => le.version4.PhoneIdentitiesRecentCount,
			c=29 => le.version4.PhoneOther,
			c=30 => le.version4.SSNLastNameCount,
			c=31 => le.version4.SubjectLastNameCount,
			c=32 => le.version4.LastNameChangeAge,
			c=33 => le.version4.LastNameChangeCount01,
			c=34 => le.version4.LastNameChangeCount03,
			c=35 => le.version4.LastNameChangeCount06,
			c=36 => le.version4.LastNameChangeCount12,
			c=37 => le.version4.LastNameChangeCount24,
			c=38 => le.version4.LastNameChangeCount60,
			c=39 => le.version4.SFDUAddrIdentitiesCount,
			c=40 => le.version4.SFDUAddrSSNCount,
			c=41 => le.version4.SSNAgeDeceased,
			c=42 => le.version4.SSNRecent,
			c=43 => le.version4.SSNLowIssueAge,
			c=44 => le.version4.SSNHighIssueAge,
			c=45 => le.version4.SSNIssueState,
			c=46 => le.version4.SSNNonUS,
			c=47 => le.version4.SSN3Years,
			c=48 => le.version4.SSNAfter5 ,
			c=49 => le.version4.SSNProblems,
			c=50 => le.version4.RelativesCount,
			c=51 => le.version4.RelativesBankruptcyCount,
			c=52 => le.version4.RelativesFelonyCount,
			c=53 => le.version4.RelativesPropOwnedCount,
			c=54 => le.version4.RelativesPropOwnedTaxTotal,
			c=55 => le.version4.RelativesDistanceClosest,
			c=56 => le.version4.InputAddrAgeOldestRecord,
			c=57 => le.version4.InputAddrAgeNewestRecord,
			c=58 => le.version4.InputAddrHistoricalMatch,
			c=59 => le.version4.InputAddrLenOfRes ,
			c=60 => le.version4.InputAddrDwellType ,
			c=61 => le.version4.InputAddrDelivery,
			c=62 => le.version4.InputAddrApplicantOwned,
			c=63 => le.version4.InputAddrFamilyOwned,
			c=64 => le.version4.InputAddrOccupantOwned ,
			c=65 => le.version4.InputAddrAgeLastSale,
			c=66 => le.version4.InputAddrLastSalesPrice,
			c=67 => le.version4.InputAddrMortgageType,
			c=68 => le.version4.InputAddrNotPrimaryRes,
			c=69 => le.version4.InputAddrActivePhoneList,
			c=70 => le.version4.InputAddrTaxValue ,
			c=71 => le.version4.InputAddrTaxYr,
			c=72 => le.version4.InputAddrTaxMarketValue,
			c=73 => le.version4.InputAddrAVMValue,
			c=74 => le.version4.InputAddrAVMValue12,
			c=75 => le.version4.InputAddrAVMValue60,
			c=76 => le.version4.InputAddrCountyIndex,
			c=77 => le.version4.InputAddrTractIndex,
			c=78 => le.version4.InputAddrBlockIndex,
			c=79 => le.version4.InputAddrMedianIncome,
			c=80 => le.version4.InputAddrMedianValue,
			c=81 => le.version4.InputAddrMurderIndex,
			c=82 => le.version4.InputAddrCarTheftIndex,
			c=83 => le.version4.InputAddrBurglaryIndex,
			c=84 => le.version4.InputAddrCrimeIndex,
			c=85 => le.version4.InputAddrMobilityIndex,
			c=86 => le.version4.InputAddrVacantPropCount,
			c=87 => le.version4.InputAddrBusinessCount,
			c=88 => le.version4.InputAddrSingleFamilyCount,
			c=89 => le.version4.InputAddrMultiFamilyCount,
			c=90 => le.version4.CurrAddrAgeOldestRecord,
			c=91 => le.version4.CurrAddrAgeNewestRecord,
			c=92 => le.version4.CurrAddrLenOfRes ,
			c=93 => le.version4.CurrAddrDwellType ,
			c=94 => le.version4.CurrAddrApplicantOwned ,
			c=95 => le.version4.CurrAddrFamilyOwned ,
			c=96 => le.version4.CurrAddrOccupantOwned ,
			c=97 => le.version4.CurrAddrAgeLastSale,
			c=98 => le.version4.CurrAddrLastSalesPrice,
			c=99 => le.version4.CurrAddrMortgageType,
			c=100 => le.version4.CurrAddrActivePhoneList ,
			c=101 => le.version4.CurrAddrTaxValue ,
			c=102 => le.version4.CurrAddrTaxYr,
			c=103 => le.version4.CurrAddrTaxMarketValue,
			c=104 => le.version4.CurrAddrAVMValue,
			c=105 => le.version4.CurrAddrAVMValue12,
			c=106 => le.version4.CurrAddrAVMValue60,
			c=107 => le.version4.CurrAddrCountyIndex,
			c=108 => le.version4.CurrAddrTractIndex,
			c=109 => le.version4.CurrAddrBlockIndex,
			c=110 => le.version4.CurrAddrMedianIncome,
			c=111 => le.version4.CurrAddrMedianValue,
			c=112 => le.version4.CurrAddrMurderIndex,
			c=113 => le.version4.CurrAddrCarTheftIndex,
			c=114 => le.version4.CurrAddrBurglaryIndex,
			c=115 => le.version4.CurrAddrCrimeIndex,
			c=116 => le.version4.PrevAddrAgeOldestRecord,
			c=117 => le.version4.PrevAddrAgeNewestRecord,
			c=118 => le.version4.PrevAddrLenOfRes ,
			c=119 => le.version4.PrevAddrDwellType ,
			c=120 => le.version4.PrevAddrApplicantOwned ,
			c=121 => le.version4.PrevAddrFamilyOwned ,
			c=122 => le.version4.PrevAddrOccupantOwned,
			c=123 => le.version4.PrevAddrAgeLastSale,
			c=124 => le.version4.PrevAddrLastSalesPrice,
			c=125 => le.version4.PrevAddrTaxValue,
			c=126 => le.version4.PrevAddrTaxYr,
			c=127 => le.version4.PrevAddrTaxMarketValue,
			c=128 => le.version4.PrevAddrAVMValue,
			c=129 => le.version4.PrevAddrCountyIndex,
			c=130 => le.version4.PrevAddrTractIndex,
			c=131 => le.version4.PrevAddrBlockIndex,
			c=132 => le.version4.PrevAddrMedianIncome,
			c=133 => le.version4.PrevAddrMedianValue,
			c=134 => le.version4.PrevAddrMurderIndex,
			c=135 => le.version4.PrevAddrCarTheftIndex,
			c=136 => le.version4.PrevAddrBurglaryIndex,
			c=137 => le.version4.PrevAddrCrimeIndex,
			c=138 => le.version4.AddrMostRecentDistance,
			c=139 => le.version4.AddrMostRecentStateDiff,
			c=140 => le.version4.AddrMostRecentTaxDiff,
			c=141 => le.version4.AddrMostRecentMoveAge,
			c=142 => le.version4.AddrMostRecentIncomeDiff,
			c=143 => le.version4.AddrMostRecentValueDIff,
			c=144 => le.version4.AddrMostRecentCrimeDiff,
			c=145 => le.version4.AddrRecentEconTrajectory,
			c=146 => le.version4.AddrRecentEconTrajectoryIndex,
			c=147 => le.version4.EducationAttendedCollege,
			c=148 => le.version4.EducationProgram2Yr,
			c=149 => le.version4.EducationProgram4Yr,
			c=150 => le.version4.EducationProgramGraduate,
			c=151 => le.version4.EducationInstitutionPrivate,
			c=152 => le.version4.EducationInstitutionRating,
			c=153 => le.version4.EducationFieldofStudyType,
			c=154 => le.version4.AddrStability,
			c=155 => le.version4.StatusMostRecent,
			c=156 => le.version4.StatusPrevious,
			c=157 => le.version4.StatusNextPrevious,
			c=158 => le.version4.AddrChangeCount01,
			c=159 => le.version4.AddrChangeCount03,
			c=160 => le.version4.AddrChangeCount06,
			c=161 => le.version4.AddrChangeCount12,
			c=162 => le.version4.AddrChangeCount24 ,
			c=163 => le.version4.AddrChangeCount60 ,
			c=164 => le.version4.EstimatedAnnualIncome,
			c=165 => le.version4.AssetOwner,
			c=166 => le.version4.PropertyOwner,
			c=167 => le.version4.PropOwnedCount,
			c=168 => le.version4.PropOwnedTaxTotal,
			c=169 => le.version4.PropOwnedHistoricalCount,
			c=170 => le.version4.PropAgeOldestPurchase,
			c=171 => le.version4.PropAgeNewestPurchase,
			c=172 => le.version4.PropAgeNewestSale,
			c=173 => le.version4.PropNewestSalePrice,
			c=174 => le.version4.PropNewestSalePurchaseIndex,
			c=175 => le.version4.PropPurchasedCount01,
			c=176 => le.version4.PropPurchasedCount03,
			c=177 => le.version4.PropPurchasedCount06,
			c=178 => le.version4.PropPurchasedCount12,
			c=179 => le.version4.PropPurchasedCount24,
			c=180 => le.version4.PropPurchasedCount60,
			c=181 => le.version4.PropSoldCount01,
			c=182 => le.version4.PropSoldCount03,
			c=183 => le.version4.PropSoldCount06,
			c=184 => le.version4.PropSoldCount12,
			c=185 => le.version4.PropSoldCount24 ,
			c=186 => le.version4.PropSoldCount60 ,
			c=187 => le.version4.WatercraftOwner,
			c=188 => le.version4.WatercraftCount,
			c=189 => le.version4.WatercraftCount01,
			c=190 => le.version4.WatercraftCount03,
			c=191 => le.version4.WatercraftCount06,
			c=192 => le.version4.WatercraftCount12 ,
			c=193 => le.version4.WatercraftCount24,
			c=194 => le.version4.WatercraftCount60 ,
			c=195 => le.version4.AircraftOwner,
			c=196 => le.version4.AircraftCount,
			c=197 => le.version4.AircraftCount01,
			c=198 => le.version4.AircraftCount03,
			c=199 => le.version4.AircraftCount06,
			c=200 => le.version4.AircraftCount12 ,
			c=201 => le.version4.AircraftCount24,
			c=202 => le.version4.AircraftCount60 ,
			c=203 => le.version4.WealthIndex,
			c=204 => le.version4.BusinessActiveAssociation,
			c=205 => le.version4.BusinessInactiveAssociation,
			c=206 => le.version4.BusinessAssociationAge,
			c=207 => le.version4.BusinessTitle,
			c=208 => le.version4.BusinessInputAddrCount,
			c=209 => le.version4.DerogSeverityIndex,
			c=210 => le.version4.DerogCount,
			c=211 => le.version4.DerogRecentCount,
			c=212 => le.version4.DerogAge,
			c=213 => le.version4.FelonyCount,
			c=214 => le.version4.FelonyAge,
			c=215 => le.version4.FelonyCount01,
			c=216 => le.version4.FelonyCount03,
			c=217 => le.version4.FelonyCount06,
			c=218 => le.version4.FelonyCount12,
			c=219 => le.version4.FelonyCount24,
			c=220 => le.version4.FelonyCount60,
			c=221 => le.version4.ArrestCount,
			c=222 => le.version4.ArrestAge,
			c=223 => le.version4.ArrestCount01,
			c=224 => le.version4.ArrestCount03,
			c=225 => le.version4.ArrestCount06,
			c=226 => le.version4.ArrestCount12,
			c=227 => le.version4.ArrestCount24,
			c=228 => le.version4.ArrestCount60,
			c=229 => le.version4.LienCount,
			c=230 => le.version4.LienFiledCount,
			c=231 => le.version4.LienFiledTotal,
			c=232 => le.version4.LienFiledAge,
			c=233 => le.version4.LienFiledCount01,
			c=234 => le.version4.LienFiledCount03,
			c=235 => le.version4.LienFiledCount06,
			c=236 => le.version4.LienFiledCount12,
			c=237 => le.version4.LienFiledCount24,
			c=238 => le.version4.LienFiledCount60,
			c=239 => le.version4.LienReleasedCount,
			c=240 => le.version4.LienReleasedTotal,
			c=241 => le.version4.LienReleasedAge,
			c=242 => le.version4.LienReleasedCount01,
			c=243 => le.version4.LienReleasedCount03,
			c=244 => le.version4.LienReleasedCount06,
			c=245 => le.version4.LienReleasedCount12,
			c=246 => le.version4.LienReleasedCount24,
			c=247 => le.version4.LienReleasedCount60,
			c=248 => le.version4.BankruptcyCount,
			c=249 => le.version4.BankruptcyAge,
			c=250 => le.version4.BankruptcyType,
			c=251 => le.version4.BankruptcyStatus,
			c=252 => le.version4.BankruptcyCount01,
			c=253 => le.version4.BankruptcyCount03,
			c=254 => le.version4.BankruptcyCount06,
			c=255 => le.version4.BankruptcyCount12,
			c=256 => le.version4.BankruptcyCount24,
			c=257 => le.version4.BankruptcyCount60,
			c=258 => le.version4.EvictionCount,
			c=259 => le.version4.EvictionAge,
			c=260 => le.version4.EvictionCount01,
			c=261 => le.version4.EvictionCount03,
			c=262 => le.version4.EvictionCount06,
			c=263 => le.version4.EvictionCount12 ,
			c=264 => le.version4.EvictionCount24 ,
			c=265 => le.version4.EvictionCount60 ,
			c=266 => le.version4.AccidentCount,
			c=267 => le.version4.AccidentAge,
			c=268 => le.version4.RecentActivityIndex,
			c=269 => le.version4.NonDerogCount,
			c=270 => le.version4.NonDerogCount01,
			c=271 => le.version4.NonDerogCount03,
			c=272 => le.version4.NonDerogCount06,
			c=273 => le.version4.NonDerogCount12,
			c=274 => le.version4.NonDerogCount24,
			c=275 => le.version4.NonDerogCount60,
			c=276 => le.version4.VoterRegistrationRecord,
			c=277 => le.version4.ProfLicCount,
			c=278 => le.version4.ProfLicAge,
			c=279 => le.version4.ProfLicTypeCategory,
			c=280 => le.version4.ProfLicExpired,
			c=281 => le.version4.ProfLicCount01,
			c=282 => le.version4.ProfLicCount03,
			c=283 => le.version4.ProfLicCount06,
			c=284 => le.version4.ProfLicCount12,
			c=285 => le.version4.ProfLicCount24,
			c=286 => le.version4.ProfLicCount60,
			c=287 => le.version4.PRSearchLocateCount,
			c=288 => le.version4.PRSearchLocateCount01,
			c=289 => le.version4.PRSearchLocateCount03,
			c=290 => le.version4.PRSearchLocateCount06,
			c=291 => le.version4.PRSearchLocateCount12,
			c=292 => le.version4.PRSearchLocateCount24,
			c=293 => le.version4.PRSearchPersonalFinanceCount,
			c=294 => le.version4.PRSearchPersonalFinanceCount01,
			c=295 => le.version4.PRSearchPersonalFinanceCount03,
			c=296 => le.version4.PRSearchPersonalFinanceCount06,
			c=297 => le.version4.PRSearchPersonalFinanceCount12,
			c=298 => le.version4.PRSearchPersonalFinanceCount24,
			c=299 => le.version4.PRSearchOtherCount,
			c=300 => le.version4.PRSearchOtherCount01,
			c=301 => le.version4.PRSearchOtherCount03,
			c=302 => le.version4.PRSearchOtherCount06,
			c=303 => le.version4.PRSearchOtherCount12,
			c=304 => le.version4.PRSearchOtherCount24,
			c=305 => le.version4.PRSearchIdentitySSNs,
			c=306 => le.version4.PRSearchIdentityAddrs,
			c=307 => le.version4.PRSearchIdentityPhones,
			c=308 => le.version4.PRSearchSSNIdentities,
			c=309 => le.version4.PRSearchAddrIdentities,
			c=310 => le.version4.PRSearchPhoneIdentities,
			c=311 => le.version4.SubPrimeOfferRequestCount,
			c=312 => le.version4.SubPrimeOfferRequestCount01,
			c=313 => le.version4.SubPrimeOfferRequestCount03,
			c=314 => le.version4.SubPrimeOfferRequestCount06,
			c=315 => le.version4.SubPrimeOfferRequestCount12,
			c=316 => le.version4.SubPrimeOfferRequestCount24,
			c=317 => le.version4.SubPrimeOfferRequestCount60,
			c=318 => le.version4.InputPhoneMobile ,
			c=319 => le.version4.InputPhoneType,
			c=320 => le.version4.InputPhoneServiceType,
			c=321 => le.version4.InputAreaCodeChange,
			c=322 => le.version4.PhoneEDAAgeOldestRecord,
			c=323 => le.version4.PhoneEDAAgeNewestRecord,
			c=324 => le.version4.PhoneOtherAgeOldestRecord,
			c=325 => le.version4.PhoneOtherAgeNewestRecord,
			c=326 => le.version4.InputPhoneHighRisk,
			c=327 => le.version4.InputPhoneProblems,
			c=328 => le.version4.OnlineDirectory,
			c=329 => le.version4.InputAddrSICCode,
			c=330 => le.version4.InputAddrValidation,
			c=331 => le.version4.InputAddrErrorCode,
			c=332 => le.version4.InputAddrHighRisk,
			c=333 => le.version4.CurrAddrCorrectional,
			c=334 => le.version4.PrevAddrCorrectional,
			c=335 => le.version4.HistoricalAddrCorrectional,
			c=336 => le.version4.InputAddrProblems,
			c=337 => le.version4.DoNotMail,
			c=338 => le.version4.IdentityRiskLevel,
			c=339 => le.version4.IDVerRiskLevel,
			c=340 => le.version4.IDVerAddressAssocCount,
			c=341 => le.version4.IDVerSSNCreditBureauCount,
			c=342 => le.version4.IDVerSSNCreditBureauDelete,
			c=343 => le.version4.SourceRiskLevel,
			c=344 => le.version4.SourceWatchList,
			c=345 => le.version4.SourceOrderActivity,
			c=346 => le.version4.SourceOrderSourceCount,
			c=347 => le.version4.SourceOrderAgeLastOrder,
			c=348 => le.version4.VariationRiskLevel,
			c=349 => le.version4.VariationIdentityCount,
			c=350 => le.version4.VariationMSourcesSSNCount,
			c=351 => le.version4.VariationMSourcesSSNUnrelCount,
			c=352 => le.version4.VariationDOBCount,
			c=353 => le.version4.VariationDOBCountNew,
			c=354 => le.version4.SearchVelocityRiskLevel,
			c=355 => le.version4.SearchUnverifiedSSNCountYear,
			c=356 => le.version4.SearchUnverifiedAddrCountYear,
			c=357 => le.version4.SearchUnverifiedDOBCountYear,
			c=358 => le.version4.SearchUnverifiedPhoneCountYear,
			c=359 => le.version4.AssocRiskLevel,
			c=360 => le.version4.AssocSuspicousIdentitiesCount,
			c=361 => le.version4.AssocCreditBureauOnlyCount,
			c=362 => le.version4.AssocCreditBureauOnlyCountNew,
			c=363 => le.version4.AssocCreditBureauOnlyCountMonth,
			c=364 => le.version4.AssocHighRiskTopologyCount,
			c=365 => le.version4.ValidationRiskLevel,
			c=366 => le.version4.CorrelationRiskLevel,
			c=367 => le.version4.DivRiskLevel,
			c=368 => le.version4.DivSSNIdentityMSourceCount,
			c=369 => le.version4.DivSSNIdentityMSourceUrelCount,
			c=370 => le.version4.DivSSNLNameCountNew,
			c=371 => le.version4.DivSSNAddrMSourceCount,
			c=372 => le.version4.DivAddrIdentityCount,
			c=373 => le.version4.DivAddrIdentityCountNew,
			c=374 => le.version4.DivAddrIdentityMSourceCount,
			c=375 => le.version4.DivAddrSuspIdentityCountNew,
			c=376 => le.version4.DivAddrSSNCount,
			c=377 => le.version4.DivAddrSSNCountNew,
			c=378 => le.version4.DivAddrSSNMSourceCount,
			c=379 => le.version4.DivSearchAddrSuspIdentityCount,
			c=380 => le.version4.SearchComponentRiskLevel,
			c=381 => le.version4.SearchSSNSearchCount,
			c=382 => le.version4.SearchAddrSearchCount,
			c=383 => le.version4.SearchPhoneSearchCount,
			c=384 => le.version4.ComponentCharRiskLevel,
			''
		);
	END;
	nameValuePairsVersion1 :=  NORMALIZE(results, 315, intoVersion1(LEFT, COUNTER));
	nameValuePairsVersion3 :=  NORMALIZE(results, 371, intoVersion3(LEFT, COUNTER));
	nameValuePairsVersion4 :=  NORMALIZE(results, 384, intoVersion4(LEFT, COUNTER));

/* ***************************************
	 *    Convert Model Results to ESDL:   *
   *************************************** */
	iesp.leadintegrity.t_ModelSequencedWarningCode intoModel(results le) := TRANSFORM
		SELF.Name := StringLib.StringToUpperCase(modelName);
		SELF.Scores := IF(TRIM(modelName) != '',	// Only return results if a model was requested
									DATASET([
														{'', le.score1, IF(TRIM(le.reason1) != '', // Make sure there is a Warning Code to return before indexing
																										DATASET([		// Grab the Model Score Result
																										{le.reason1, IF(TRIM(le.reason1) not in ['','00'], Risk_Indicators.getHRIDesc(le.reason1), ''), 1},
																										{le.reason2, IF(TRIM(le.reason2) not in ['','00'], Risk_Indicators.getHRIDesc(le.reason2), ''), 2},
																										{le.reason3, IF(TRIM(le.reason3) not in ['','00'], Risk_Indicators.getHRIDesc(le.reason3), ''), 3},
																										{le.reason4, IF(TRIM(le.reason4) not in ['','00'], Risk_Indicators.getHRIDesc(le.reason4), ''), 4},
																										{le.reason5, IF(TRIM(le.reason5) not in ['','00'], Risk_Indicators.getHRIDesc(le.reason5), ''), 5},
																										{le.reason6, IF(TRIM(le.reason6) not in ['','00'], Risk_Indicators.getHRIDesc(le.reason6), ''), 6}
																										], iesp.leadintegrity.t_SequencedWarningCode)( warningcode not in ['','00'] ),
																										DATASET([], iesp.leadintegrity.t_SequencedWarningCode))}
														], iesp.leadintegrity.t_ScoreSequencedWarningCode),	// Finish packaging the Scores
									DATASET([], iesp.leadintegrity.t_ScoreSequencedWarningCode));	// No model requested, blank out the scores section
	END;
	
	modelResults := PROJECT(results, intoModel(LEFT));

	
/* ***************************************
	 *      Combine the Final Results:     *
   *************************************** */
lead_integrity_internal := record
  unsigned6 did;
  iesp.leadintegrity.t_LeadIntegrityResponse;
end;

	lead_integrity_internal intoFinal(results le) := TRANSFORM
    self.did := le.did;
		SELF.Result.InputEcho := search;
		//DID was added to the iesp layout so that requests coming from an ESP would contain the DID. Having the query return it 
		//outside of the iesp layout (as is above) ends up being dropped in the ESP.  Keeping both for now rather than removing the above
		//so that no down stream process gets broken.  
		SELF.Result.UniqueId := (string)le.did;
		SELF.Result.Models := modelResults;
		SELF.Result.Attributes := map( 
			modelname = 'msn1210_1' 	=> DATASET([], iesp.share.t_NameValuePair),  //this model does not return attributes - just score 
			attributesVersion = 1 		=> nameValuePairsVersion1,
			attributesVersion = 3 		=> nameValuePairsVersion3,
			attributesVersion = 4 		=> nameValuePairsVersion4,
																	 DATASET([], iesp.share.t_NameValuePair)
		);
		
		SELF._Header := [];
		SELF := [];
	END;
	final := PROJECT(results, intoFinal(LEFT));
	
	//Log to Deltabase
	//Caution should be used in adding logging to LeadIntegrity. Paypal is VERY sensitive to anything that increases transaction time.
	Deltabase_Logging_prep := project(final, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																										 self.company_id := (Integer)CompanyID,
																										 self.login_id := _LoginID,
																										 self.product_id := Risk_Reporting.ProductID.Models__LeadIntegrity_Service,
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
                                                     self.glb := GLBPurpose,
                                                     self.dppa := DPPAPurpose,
																										 self.data_restriction_mask := DataRestriction,
																										 self.data_permission_mask := DataPermission,
																										 self.industry := Industry_Search[1].Industry,
																										 self.i_ssn := search.SSN,
                                                     self.i_dob := DateOfBirth,
                                                     self.i_name_full := search.Name.Full,
																										 self.i_name_first := search.Name.First,
																										 self.i_name_last := search.Name.Last,
                                                     self.i_lexid := (Integer)search.UniqueID,
																										 self.i_address := in_streetAddress1 + if(in_streetAddress2 != '', ' ' + in_streetAddress2, ''),
																										 self.i_city := search.Address.City,
																										 self.i_state := search.Address.State,
																										 self.i_zip := search.Address.Zip5,
																										 self.i_dl := search.DriverLicenseNumber,
																										 self.i_dl_state := search.DriverLicenseState,
                                                     self.i_home_phone := HomePhone,
                                                     self.i_work_phone := WorkPhone,
																										 self.i_attributes_name := option.AttributesVersionRequest,
																										 self.i_model_name_1 := left.Result.Models[1].Name,
																										 self.o_score_1 := left.Result.Models[1].Scores[1].Value,
																										 self.o_reason_1_1 := left.Result.Models[1].Scores[1].WarningCodeIndicators[1].WarningCode,
																										 self.o_reason_1_2 := left.Result.Models[1].Scores[1].WarningCodeIndicators[2].WarningCode,
																										 self.o_reason_1_3 := left.Result.Models[1].Scores[1].WarningCodeIndicators[3].WarningCode,
																										 self.o_reason_1_4 := left.Result.Models[1].Scores[1].WarningCodeIndicators[4].WarningCode,
																										 self.o_reason_1_5 := left.Result.Models[1].Scores[1].WarningCodeIndicators[5].WarningCode,
																										 self.o_reason_1_6 := left.Result.Models[1].Scores[1].WarningCodeIndicators[6].WarningCode,
																										 self.o_lexid := (Integer)left.did,
																										 self := left,
																										 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	
	// intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell) : STORED('Intermediate_Log');

	// Note: All intermediate logs must have the following name schema:
	// Starts with 'LOG_' (Upper case is important!!)
	// Middle part is the database name, in this case: 'log__mbs'
	// Must end with '_intermediate__log'
	// OUTPUT(intermediateLog, NAMED('LOG_log__mbs_intermediate__log'));

	OUTPUT(final, NAMED('Results'));
	
	//Improved Scout Logging
	IF(~DisableOutcomeTracking and ~TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

ENDMACRO;
// Models.LeadIntegrity_Service();
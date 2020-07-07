/*--SOAP--
<message name="Fraud_Defense_Manager_Service" wuTimeout="300000">
	<part name="FraudDefenseManagerRequest" type="tns:XmlDataSet" cols="100" rows="100"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
/*--INFO-- Fraud Defense Manager Service - This service searches for fraudulant identifiers and returns them as suspicious risk indicators.  There is no limit to the number of fraudulant indicators.  This is an ESDL compliant XML service.*/
/*--HELP-- 
<pre>
&lt;FraudDefenseManagerRequest&gt;
  &lt;Row&gt;
    &lt;SearchBy&gt;
      &lt;Name&gt;
        &lt;First&gt;&lt;/First&gt;
        &lt;Middle&gt;&lt;/Middle&gt;
        &lt;Last&gt;&lt;/Last&gt;
      &lt;/Name&gt;
      &lt;Address&gt;
        &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
        &lt;City&gt;&lt;/City&gt;
        &lt;State&gt;&lt;/State&gt;
        &lt;Zip5&gt;&lt;/Zip5&gt;
      &lt;/Address&gt;
      &lt;DOB&gt;
        &lt;Year&gt;&lt;/Year&gt;
        &lt;Month&gt;&lt;/Month&gt;
        &lt;Day&gt;&lt;/Day&gt;
      &lt;/DOB&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;Phone&gt;&lt;/Phone&gt;
      &lt;IPAddress&gt;&lt;/IPAddress&gt;
      &lt;Email&gt;&lt;/Email&gt;
      &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt;
      &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt;
      &lt;DeviceID&gt;&lt;/DeviceID&gt;
      &lt;UniqueID&gt;&lt;/UniqueID&gt;
    &lt;/SearchBy&gt;
    &lt;User&gt;
      &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
      &lt;GLBPurpose&gt;0&lt;/GLBPurpose&gt;
      &lt;DLPurpose&gt;0&lt;/DLPurpose&gt;
      &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt;
      &lt;TestDataEnabled&gt;0&lt;/TestDataEnabled&gt;
      &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt;
      &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt;
      &lt;BillingCode&gt;&lt;/BillingCode&gt;
      &lt;QueryId&gt;&lt;/QueryId&gt;
    &lt;/User&gt;
  &lt;/Row&gt;
&lt;/FraudDefenseManagerRequest&gt;



&lt;Gateways&gt;
  &lt;row&gt;
    &lt;servicename&gt;delta_inquiry&lt;/servicename&gt;
    &lt;url&gt;http://username:password@10.176.68.151:7909/WsDeltaBase/preparedsql&lt;/url&gt;
  &lt;/row&gt;
  &lt;row&gt;
    &lt;servicename&gt;netacuity&lt;/servicename&gt;
    &lt;url&gt;http://username:password@rwgatewaycert.sc.seisint.com:7726/WsGateway&lt;/url&gt;
  &lt;/row&gt;
&lt;/Gateways&gt;
</pre>
</pre>
*/


IMPORT Address, Gateway, iesp, Risk_Indicators, Suspicious_Fraud_LN, Doxie, STD;

EXPORT Fraud_Defense_Manager_Service := MACRO
	/* ************************************************************************
	 *  Grab service inputs - This service supports ESDL XML                  *
	 ************************************************************************ */
	UNSIGNED3 HistoryDateTemp 	:= 999999 : STORED('HistoryDateYYYYMM');
	// Make sure the History Date is at least in the 1900's...  In other words, not 0 - 999999 indicates this is a realtime run
	HistoryDateYYYYMM := IF(HistoryDateTemp < 190000, 999999, HistoryDateTemp);
	
	// Gateways Coded in this Product: NetAcuity and Delta_Inquiry
	Gateways 										:= Gateway.Configuration.Get();
	
	requestIn := DATASET([], iesp.FraudDefenseManager.t_FraudDefenseManagerRequest)  	: STORED('FraudDefenseManagerRequest', FEW);
	
	//CCPA fields
	unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
	string TransactionID := '' : STORED('_TransactionId');
	string BatchUID := '' : STORED('_BatchUID');
	unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

  firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	request := GLOBAL(firstRow.SearchBy);
	option := GLOBAL(firstRow.Options);
	users := GLOBAL(firstRow.User);

	// Get GLB and DPPA and make sure they are at least set to 0
	UNSIGNED1 GLBPurpose					:= MAX((INTEGER)users.GLBPurpose, 0);
	UNSIGNED1 DPPAPurpose					:= MAX((INTEGER)users.DLPurpose, 0);
	
	mod_access := MODULE(Doxie.IDataAccess)
		EXPORT glb := GLBPurpose;
		EXPORT dppa := DPPAPurpose;
		EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
		EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
		EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
	END;
	
	// Make sure DataRestrictionMask is populated - if not set it to the default Data Restriction Mask
	STRING50 DataRestrictionMask	:= IF(TRIM(users.DataRestrictionMask) <> '', TRIM(users.DataRestrictionMask), Risk_Indicators.iid_constants.default_DataRestriction);
	BOOLEAN TestDataEnabled				:= (INTEGER)users.TestDataEnabled = 1;
	STRING32 TestDataTableName		:= STD.Str.ToUpperCase(TRIM(users.TestDataTableName));

	/* ************************************************************************
	 *  Convert the ESDL input into the batch layout so that we can use the   *
   *  same underlying functions.  Need to be able to handle parsed street   *
   *  and unparsed name, unlike the batch service - which is why some of    *
   *  the parsing logic is here and not in the Search_Function.             *
	 ************************************************************************ */
	Batch_In := DATASET([TRANSFORM(Suspicious_Fraud_LN.layouts.Layout_Batch_In, 
		SELF.ReferenceCode				:= users.ReferenceCode;
		SELF.QueryID							:= users.QueryID;
		SELF.LexID								:= (INTEGER)request.UniqueID;
		SELF.AcctNo								:= users.AccountNumber;
		
		// Use the Name Cleaner to get the Parsed version of the UnParsedFullName if populated.
		inUnparsedName						:= STD.Str.ToUpperCase(TRIM(request.Name.Full, LEFT, RIGHT));
		inNameFirst 							:= STD.Str.ToUpperCase(TRIM(request.Name.First, LEFT, RIGHT));
		inNameMiddle							:= STD.Str.ToUpperCase(TRIM(request.Name.Middle, LEFT, RIGHT));
		inNameLast								:= STD.Str.ToUpperCase(TRIM(request.Name.Last, LEFT, RIGHT));
		cleanedName								:= Address.CleanPerson73(inUnparsedName);
		cleanedFirst							:= IF(inUnparsedName <> '', STD.Str.ToUpperCase(cleanedName[6..25]), '');
		cleanedMiddle							:= IF(inUnparsedName <> '', STD.Str.ToUpperCase(cleanedName[26..45]), '');
		cleanedLast								:= IF(inUnparsedName <> '', STD.Str.ToUpperCase(cleanedName[46..65]), '');

		SELF.FirstName						:= IF(inNameFirst = '', cleanedFirst, inNameFirst);
		SELF.MiddleName						:= IF(inNameMiddle = '', cleanedMiddle, inNameMiddle);
		SELF.LastName							:= IF(inNameLast = '', cleanedLast, inNameLast);
		
		tempStreetAddr						:= Address.Addr1FromComponents(TRIM(request.Address.StreetNumber, LEFT, RIGHT), TRIM(request.Address.StreetPreDirection, LEFT, RIGHT), 
																															TRIM(request.Address.StreetName, LEFT, RIGHT), TRIM(request.Address.StreetSuffix, LEFT, RIGHT), 
																															TRIM(request.Address.StreetPostDirection, LEFT, RIGHT), TRIM(request.Address.UnitDesignation, LEFT, RIGHT), 
																															TRIM(request.Address.UnitNumber, LEFT, RIGHT));
		inStreetAddress1					:= STD.Str.ToUpperCase(TRIM(request.Address.StreetAddress1, LEFT, RIGHT));
		SELF.StreetAddress1				:= IF(inStreetAddress1 = '', tempStreetAddr, inStreetAddress1);
		SELF.StreetAddress2				:= STD.Str.ToUpperCase(TRIM(request.Address.StreetAddress2, LEFT, RIGHT));
		SELF.City									:= STD.Str.ToUpperCase(TRIM(request.Address.City, LEFT, RIGHT));
		SELF.State								:= STD.Str.ToUpperCase(TRIM(request.Address.State, LEFT, RIGHT));
		SELF.Zip5									:= request.Address.Zip5;
		DOBMonth									:= INTFORMAT(request.DOB.Month, 2, 1);
		DOBDay										:= INTFORMAT(request.DOB.Day, 2, 1);
		DOBYear										:= INTFORMAT(request.DOB.Year, 4, 1);
		DOBCombined								:= IF((INTEGER)DOBYear = 0 OR (INTEGER)DOBMonth = 0 OR (INTEGER)DOBDay = 0, '', DOBYear + DOBMonth + DOBDay); // Make sure YYYYMMDD are populated, if not, blank it out
		SELF.DateOfBirth					:= DOBCombined;
		SELF.SSN									:= request.SSN;
		SELF.Phone10							:= request.Phone;
		SELF.IPAddress						:= request.IPAddress;
		SELF.Email								:= STD.Str.ToUpperCase(TRIM(request.Email, LEFT, RIGHT));
		SELF.DriverLicenseNumber	:= request.DriverLicenseNumber;
		SELF.DriverLicenseState		:= request.DriverLicenseState;
		SELF.DeviceID							:= request.DeviceID;
		SELF.ArchiveDate					:= HistoryDateYYYYMM;)]);
	
	/* ************************************************************************
	 * Get the Suspicious Fraud Results - Search TestSeeds is TestDataEnabled *
	 ************************************************************************ */
	results := IF(TestDataEnabled = FALSE, Suspicious_Fraud_LN.Fraud_Defense_Manager_Search_Function(Batch_In, GLBPurpose, DPPAPurpose, DataRestrictionMask, Gateways, mod_access),
																				 Suspicious_Fraud_LN.Fraud_Defense_Manager_TestSeed_Function(Batch_In, TestDataTableName));
	
	/* ************************************************************************
	 *  Convert the Results into ESDL                                         *
	 ************************************************************************ */
	iesp.FraudDefenseManager.t_USPISHotList getUSPISHotList(Suspicious_Fraud_LN.layouts.USPISHotListRecs le) := TRANSFORM
		SELF.Reason := le.ReasonAdded;
		SELF.DateAdded.Year := (INTEGER)le.DateAdded[1..4];
		SELF.DateAdded.Month := (INTEGER)le.DateAdded[5..6];
		SELF.DateAdded.Day := (INTEGER)le.DateAdded[7..8];
	END;
	iesp.share.t_RiskIndicator getRiskIndicators(Suspicious_Fraud_LN.layouts.Risk_Indicators le) := TRANSFORM
		SELF.RiskCode := le.SuspiciousRiskCode;
		SELF.Description := le.SuspiciousRiskIndicator;
	END;
	iesp.FraudDefenseManager.t_FraudDefenseManagerResponse intoESDL(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		SELF.InputEcho																							:= request; // Simply copy our input into the InputEcho section
		
		SELF.SSNReturn.Hit 																					:= le.Suspicious_SSN.SSN_Hit;
		SELF.SSNReturn.HitResponse																	:= le.Suspicious_SSN.SSN_Message;
		SELF.SSNReturn.DataSource																		:= le.Suspicious_SSN.Data_Source;
		SELF.SSNReturn.RiskIndicators																:= PROJECT(le.RiskCode_SSN, getRiskIndicators(LEFT));
		SELF.SSNReturn.DateFirstSeenInFile.Year											:= (INTEGER)le.Suspicious_SSN.DateFirstSeenInFile[1..4];
		SELF.SSNReturn.DateFirstSeenInFile.Month										:= (INTEGER)le.Suspicious_SSN.DateFirstSeenInFile[5..6];
		SELF.SSNReturn.DateFirstSeenInFile.Day											:= (INTEGER)le.Suspicious_SSN.DateFirstSeenInFile[7..8];
		SELF.SSNReturn.InquiryCount																	:= le.Suspicious_SSN.InquiryCount;
		SELF.SSNReturn.InquiryCountHour															:= le.Suspicious_SSN.InquiryCountHour;
		SELF.SSNReturn.InquiryCountToday														:= le.Suspicious_SSN.InquiryCountDay;
		SELF.SSNReturn.InquiryCountWeek															:= le.Suspicious_SSN.InquiryCountWeek;
		SELF.SSNReturn.InquiryCountMonth														:= le.Suspicious_SSN.InquiryCountMonth;
		SELF.SSNReturn.InquiryCountYear															:= le.Suspicious_SSN.InquiryCountYear;

		SELF.AddressReturn.Hit 																			:= le.Suspicious_Address.Address_Hit;
		SELF.AddressReturn.HitResponse															:= le.Suspicious_Address.Address_Message;
		SELF.AddressReturn.DataSource																:= le.Suspicious_Address.Data_Source;
		SELF.AddressReturn.RiskIndicators														:= PROJECT(le.RiskCode_Address, getRiskIndicators(LEFT));
		USPISDateYear																								:= (INTEGER)le.Suspicious_Address.USPISHotListDateAdded[1..4];
		USPISDateMonth																							:= (INTEGER)le.Suspicious_Address.USPISHotListDateAdded[5..6];
		USPISDateDay																								:= (INTEGER)le.Suspicious_Address.USPISHotListDateAdded[7..8];
		SELF.AddressReturn.USPISHotListRecords											:= PROJECT(le.USPISHotListRecords, getUSPISHotList(LEFT));
		SELF.AddressReturn.DateFirstSeenInFile.Year									:= (INTEGER)le.Suspicious_Address.DateFirstSeenInFile[1..4];
		SELF.AddressReturn.DateFirstSeenInFile.Month								:= (INTEGER)le.Suspicious_Address.DateFirstSeenInFile[5..6];
		SELF.AddressReturn.DateFirstSeenInFile.Day									:= (INTEGER)le.Suspicious_Address.DateFirstSeenInFile[7..8];
		SELF.AddressReturn.InquiryCount															:= le.Suspicious_Address.InquiryCount;
		SELF.AddressReturn.InquiryCountHour													:= le.Suspicious_Address.InquiryCountHour;
		SELF.AddressReturn.InquiryCountToday												:= le.Suspicious_Address.InquiryCountDay;
		SELF.AddressReturn.InquiryCountWeek													:= le.Suspicious_Address.InquiryCountWeek;
		SELF.AddressReturn.InquiryCountMonth												:= le.Suspicious_Address.InquiryCountMonth;
		SELF.AddressReturn.InquiryCountYear													:= le.Suspicious_Address.InquiryCountYear;
		
		SELF.EmailReturn.Hit 																				:= le.Suspicious_Email.Email_Hit;
		SELF.EmailReturn.HitResponse																:= le.Suspicious_Email.Email_Message;
		SELF.EmailReturn.DataSource																	:= le.Suspicious_Email.Data_Source;
		SELF.EmailReturn.RiskIndicators															:= PROJECT(le.RiskCode_Email, getRiskIndicators(LEFT));
		SELF.EmailReturn.DateFirstSeenInFile.Year										:= (INTEGER)le.Suspicious_Email.DateFirstSeenInFile[1..4];
		SELF.EmailReturn.DateFirstSeenInFile.Month									:= (INTEGER)le.Suspicious_Email.DateFirstSeenInFile[5..6];
		SELF.EmailReturn.DateFirstSeenInFile.Day										:= (INTEGER)le.Suspicious_Email.DateFirstSeenInFile[7..8];
		SELF.EmailReturn.InquiryCount																:= le.Suspicious_Email.InquiryCount;
		SELF.EmailReturn.InquiryCountHour														:= le.Suspicious_Email.InquiryCountHour;
		SELF.EmailReturn.InquiryCountToday													:= le.Suspicious_Email.InquiryCountDay;
		SELF.EmailReturn.InquiryCountWeek														:= le.Suspicious_Email.InquiryCountWeek;
		SELF.EmailReturn.InquiryCountMonth													:= le.Suspicious_Email.InquiryCountMonth;
		SELF.EmailReturn.InquiryCountYear														:= le.Suspicious_Email.InquiryCountYear;
		
		SELF.IPAddressReturn.Hit 																		:= le.Suspicious_IPAddress.IPAddress_Hit;
		SELF.IPAddressReturn.HitResponse														:= le.Suspicious_IPAddress.IPAddress_Message;
		SELF.IPAddressReturn.DataSource															:= le.Suspicious_IPAddress.Data_Source;
		SELF.IPAddressReturn.RiskIndicators													:= PROJECT(le.RiskCode_IPAddress, getRiskIndicators(LEFT));
		SELF.IPAddressReturn.DateFirstSeenInFile.Year								:= (INTEGER)le.Suspicious_IPAddress.DateFirstSeenInFile[1..4];
		SELF.IPAddressReturn.DateFirstSeenInFile.Month							:= (INTEGER)le.Suspicious_IPAddress.DateFirstSeenInFile[5..6];
		SELF.IPAddressReturn.DateFirstSeenInFile.Day								:= (INTEGER)le.Suspicious_IPAddress.DateFirstSeenInFile[7..8];
		SELF.IPAddressReturn.InquiryCount														:= le.Suspicious_IPAddress.InquiryCount;
		SELF.IPAddressReturn.InquiryCountHour												:= le.Suspicious_IPAddress.InquiryCountHour;
		SELF.IPAddressReturn.InquiryCountToday											:= le.Suspicious_IPAddress.InquiryCountDay;
		SELF.IPAddressReturn.InquiryCountWeek												:= le.Suspicious_IPAddress.InquiryCountWeek;
		SELF.IPAddressReturn.InquiryCountMonth											:= le.Suspicious_IPAddress.InquiryCountMonth;
		SELF.IPAddressReturn.InquiryCountYear												:= le.Suspicious_IPAddress.InquiryCountYear;
		
		SELF.NameReturn.Hit 																				:= le.Suspicious_Name.Name_Hit;
		SELF.NameReturn.HitResponse																	:= le.Suspicious_Name.Name_Message;
		SELF.NameReturn.DataSource																	:= le.Suspicious_Name.Data_Source;
		SELF.NameReturn.RiskIndicators															:= PROJECT(le.RiskCode_Name, getRiskIndicators(LEFT));
		SELF.NameReturn.DateFirstSeenInFile.Year										:= (INTEGER)le.Suspicious_Name.DateFirstSeenInFile[1..4];
		SELF.NameReturn.DateFirstSeenInFile.Month										:= (INTEGER)le.Suspicious_Name.DateFirstSeenInFile[5..6];
		SELF.NameReturn.DateFirstSeenInFile.Day											:= (INTEGER)le.Suspicious_Name.DateFirstSeenInFile[7..8];
		SELF.NameReturn.InquiryCount																:= le.Suspicious_Name.InquiryCount;
		SELF.NameReturn.InquiryCountHour														:= le.Suspicious_Name.InquiryCountHour;
		SELF.NameReturn.InquiryCountToday														:= le.Suspicious_Name.InquiryCountDay;
		SELF.NameReturn.InquiryCountWeek														:= le.Suspicious_Name.InquiryCountWeek;
		SELF.NameReturn.InquiryCountMonth														:= le.Suspicious_Name.InquiryCountMonth;
		SELF.NameReturn.InquiryCountYear														:= le.Suspicious_Name.InquiryCountYear;
		
		SELF.PhoneReturn.Hit 																				:= le.Suspicious_Phone.Phone_Hit;
		SELF.PhoneReturn.HitResponse																:= le.Suspicious_Phone.Phone_Message;
		SELF.PhoneReturn.DataSource																	:= le.Suspicious_Phone.Data_Source;
		SELF.PhoneReturn.RiskIndicators															:= PROJECT(le.RiskCode_Phone, getRiskIndicators(LEFT));
		SELF.PhoneReturn.DateFirstSeenInFile.Year										:= (INTEGER)le.Suspicious_Phone.DateFirstSeenInFile[1..4];
		SELF.PhoneReturn.DateFirstSeenInFile.Month									:= (INTEGER)le.Suspicious_Phone.DateFirstSeenInFile[5..6];
		SELF.PhoneReturn.DateFirstSeenInFile.Day										:= (INTEGER)le.Suspicious_Phone.DateFirstSeenInFile[7..8];
		SELF.PhoneReturn.InquiryCount																:= le.Suspicious_Phone.InquiryCount;
		SELF.PhoneReturn.InquiryCountHour														:= le.Suspicious_Phone.InquiryCountHour;
		SELF.PhoneReturn.InquiryCountToday													:= le.Suspicious_Phone.InquiryCountDay;
		SELF.PhoneReturn.InquiryCountWeek														:= le.Suspicious_Phone.InquiryCountWeek;
		SELF.PhoneReturn.InquiryCountMonth													:= le.Suspicious_Phone.InquiryCountMonth;
		SELF.PhoneReturn.InquiryCountYear														:= le.Suspicious_Phone.InquiryCountYear;
		
		SELF.CombinationReturn.Hit 																	:= le.Suspicious_Combination.Combination_Search_Hit;
		SELF.CombinationReturn.HitResponse													:= le.Suspicious_Combination.Combination_Search_Message;
		SELF.CombinationReturn.DataSource														:= le.Suspicious_Combination.Data_Source;
		SELF.CombinationReturn.RiskIndicators												:= PROJECT(le.RiskCode_Combination, getRiskIndicators(LEFT));
		SELF.CombinationReturn.DateFirstSeenInFile.Year							:= (INTEGER)le.Suspicious_Combination.DateFirstSeenInFile[1..4];
		SELF.CombinationReturn.DateFirstSeenInFile.Month						:= (INTEGER)le.Suspicious_Combination.DateFirstSeenInFile[5..6];
		SELF.CombinationReturn.DateFirstSeenInFile.Day							:= (INTEGER)le.Suspicious_Combination.DateFirstSeenInFile[7..8];
		SELF.CombinationReturn.InquiryCount													:= le.Suspicious_Combination.InquiryCount;
		SELF.CombinationReturn.InquiryCountHour											:= le.Suspicious_Combination.InquiryCountHour;
		SELF.CombinationReturn.InquiryCountToday										:= le.Suspicious_Combination.InquiryCountDay;
		SELF.CombinationReturn.InquiryCountWeek											:= le.Suspicious_Combination.InquiryCountWeek;
		SELF.CombinationReturn.InquiryCountMonth										:= le.Suspicious_Combination.InquiryCountMonth;
		SELF.CombinationReturn.InquiryCountYear											:= le.Suspicious_Combination.InquiryCountYear;

		SELF._Header 																								:= []; // Blank out the _Header section, nothing to fill in there
	END;
	finalResults := PROJECT(results, intoESDL(LEFT));

	OUTPUT(finalResults, NAMED('Results'));

	dIPIn := PROJECT(Batch_In,TRANSFORM(Royalty.RoyaltyNetAcuity.IPData,SELF.IPAddr:=LEFT.IPAddress;));
	dIPOut := PROJECT(results, TRANSFORM(Royalty.RoyaltyNetAcuity.IPData, SELF.Royalty_NAG := LEFT.Suspicious_IPAddress.Royalty_NAG;));
	royalties := IF(TestDataEnabled = FALSE, Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(Gateways, dIPIn, dIPOut, TRUE));
	output(royalties,NAMED('RoyaltySet'));

ENDMACRO;
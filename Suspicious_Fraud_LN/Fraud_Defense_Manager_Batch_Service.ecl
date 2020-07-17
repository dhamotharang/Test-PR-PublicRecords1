/*--SOAP--
<message name="Fraud_Defense_Manager_Batch_Service" wuTimeout="300000">
  <part name="Batch_In" type="tns:XmlDataSet" cols="100" rows="100"/>
  <part name="GLBPurpose" type="xsd:integer"/>
  <part name="DPPAPurpose" type="xsd:integer"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
</message>
*/
/*--INFO-- Fraud Defense Manager Batch Service - This service searches for fraudulant identifiers and returns them as suspicious risk indicators.  There is no limit to the number of fraudulant indicators.  This is a batch service.*/
/*--HELP-- 
<pre>
&lt;Batch_In&gt;
  &lt;Row&gt;
    &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt;
    &lt;QueryID&gt;&lt;/QueryID&gt;
    &lt;LexID&gt;&lt;/LexID&gt;
    &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
    &lt;FirstName&gt;&lt;/FirstName&gt;
    &lt;MiddleName&gt;&lt;/MiddleName&gt;
    &lt;LastName&gt;&lt;/LastName&gt;
    &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
    &lt;City&gt;&lt;/City&gt;
    &lt;State&gt;&lt;/State&gt;
    &lt;Zip5&gt;&lt;/Zip5&gt;
    &lt;DateOfBirth&gt;&lt;/DateOfBirth&gt;
    &lt;SSN&gt;&lt;/SSN&gt;
    &lt;Phone10&gt;&lt;/Phone10&gt;
    &lt;IPAddress&gt;&lt;/IPAddress&gt;
    &lt;Email&gt;&lt;/Email&gt;
    &lt;DriverLicenseNumber&gt;&lt;/DriverLicenseNumber&gt;
    &lt;DriverLicenseState&gt;&lt;/DriverLicenseState&gt;
    &lt;DeviceID&gt;&lt;/DeviceID&gt;
    &lt;ArchiveDate&gt;&lt;/ArchiveDate&gt;
  &lt;/Row&gt;
&lt;/Batch_In&gt;
</pre>
*/


IMPORT Gateway, Suspicious_Fraud_LN, Royalty, AutoStandardI;

EXPORT Fraud_Defense_Manager_Batch_Service := MACRO
	/* ************************************************************************
	 *  Grab service inputs - This service supports both Batch and Realtime   *
	 ************************************************************************ */
	Batch_In											:= DATASET([], Suspicious_Fraud_LN.layouts.Layout_Batch_In) : STORED('Batch_In');
	
	UNSIGNED1 GLBPurpose					:= 8 : STORED('GLBPurpose');
	UNSIGNED1 DPPAPurpose					:= 0 : STORED('DPPAPurpose');
	STRING DataRestriction		:= '1    0' : STORED('DataRestrictionMask');
	STRING DataPermission		:= AutoStandardI.Constants.DataPermissionMask_default : STORED('DataPermissionMask') ;
	
	//CCPA fields
	unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
	string TransactionID := '' : STORED('_TransactionId');
	string BatchUID := '' : STORED('_BatchUID');
	unsigned6 GlobalCompanyId := 0 : STORED('_GCID');
	
	mod_access := MODULE(Doxie.IDataAccess)
	EXPORT glb := GLBPurpose;
	EXPORT dppa := DPPAPurpose;
	EXPORT DataPermissionMask := DataPermission;
    EXPORT DataRestrictionMask := DataRestriction;
	EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
	EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
	EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
END;

	// Gateways Coded in this Product: NetAcuity
	GatewaysTemp									:= Gateway.Configuration.Get();
	Gateways 											:= GatewaysTemp (StringLib.StringToLowerCase(ServiceName) <> 'delta_inquiry'); // Filter out the Deltabase Gateway - Batch won't hit Deltabase
	
	/* ************************************************************************
	 *  Get the Identity Fraud Network Results                                      *
	 ************************************************************************ */
	results := Suspicious_Fraud_LN.Fraud_Defense_Manager_Search_Function(Batch_In, GLBPurpose, DPPAPurpose, DataRestriction, Gateways, mod_access);
	
	/* ************************************************************************
	 *  Project the Results into the Proper Output Layout                     *
	 ************************************************************************ */
	Suspicious_Fraud_LN.layouts.Layout_Batch_Flat_Out flattenOutput(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		SELF.SSN_Hit												:= le.Suspicious_SSN.SSN_Hit;
		SELF.SSN_Message										:= le.Suspicious_SSN.SSN_Message;
		SELF.SSN_Data_Source								:= le.Suspicious_SSN.Data_Source;
		SELF.SSN_SuspiciousRiskCodes				:= le.Suspicious_SSN.SuspiciousRiskCodes;
		SELF.SSN_DateFirstSeenInFile				:= le.Suspicious_SSN.DateFirstSeenInFile;
		SELF.SSN_InquiryCount								:= le.Suspicious_SSN.InquiryCount;
		SELF.SSN_InquiryCountHour						:= le.Suspicious_SSN.InquiryCountHour;
		SELF.SSN_InquiryCountDay						:= le.Suspicious_SSN.InquiryCountDay;
		SELF.SSN_InquiryCountWeek						:= le.Suspicious_SSN.InquiryCountWeek;
		SELF.SSN_InquiryCountMonth					:= le.Suspicious_SSN.InquiryCountMonth;
		SELF.SSN_InquiryCountYear						:= le.Suspicious_SSN.InquiryCountYear;
		SELF.Address_Hit										:= le.Suspicious_Address.Address_Hit;
		SELF.Address_Message								:= le.Suspicious_Address.Address_Message;
		SELF.Address_Data_Source						:= le.Suspicious_Address.Data_Source;
		SELF.Address_SuspiciousRiskCodes		:= le.Suspicious_Address.SuspiciousRiskCodes;
		SELF.Address_USPISHotListDateAdded	:= le.Suspicious_Address.USPISHotListDateAdded;
		SELF.Address_USPISHotListReason			:= le.Suspicious_Address.USPISHotListReason;
		SELF.Address_DateFirstSeenInFile		:= le.Suspicious_Address.DateFirstSeenInFile;
		SELF.Address_InquiryCount						:= le.Suspicious_Address.InquiryCount;
		SELF.Address_InquiryCountHour				:= le.Suspicious_Address.InquiryCountHour;
		SELF.Address_InquiryCountDay				:= le.Suspicious_Address.InquiryCountDay;
		SELF.Address_InquiryCountWeek				:= le.Suspicious_Address.InquiryCountWeek;
		SELF.Address_InquiryCountMonth			:= le.Suspicious_Address.InquiryCountMonth;
		SELF.Address_InquiryCountYear				:= le.Suspicious_Address.InquiryCountYear;
		SELF.Email_Hit											:= le.Suspicious_Email.Email_Hit;
		SELF.Email_Message									:= le.Suspicious_Email.Email_Message;
		SELF.Email_Data_Source							:= le.Suspicious_Email.Data_Source;
		SELF.Email_SuspiciousRiskCodes			:= le.Suspicious_Email.SuspiciousRiskCodes;
		SELF.Email_DateFirstSeenInFile			:= le.Suspicious_Email.DateFirstSeenInFile;
		SELF.Email_InquiryCount							:= le.Suspicious_Email.InquiryCount;
		SELF.Email_InquiryCountHour					:= le.Suspicious_Email.InquiryCountHour;
		SELF.Email_InquiryCountDay					:= le.Suspicious_Email.InquiryCountDay;
		SELF.Email_InquiryCountWeek					:= le.Suspicious_Email.InquiryCountWeek;
		SELF.Email_InquiryCountMonth				:= le.Suspicious_Email.InquiryCountMonth;
		SELF.Email_InquiryCountYear					:= le.Suspicious_Email.InquiryCountYear;
		SELF.IPAddress_Hit									:= le.Suspicious_IPAddress.IPAddress_Hit;
		SELF.IPAddress_Message							:= le.Suspicious_IPAddress.IPAddress_Message;
		SELF.IPAddress_Data_Source					:= le.Suspicious_IPAddress.Data_Source;
		SELF.IPAddress_SuspiciousRiskCodes	:= le.Suspicious_IPAddress.SuspiciousRiskCodes;
		SELF.IPAddress_DateFirstSeenInFile	:= le.Suspicious_IPAddress.DateFirstSeenInFile;
		SELF.IPAddress_InquiryCount					:= le.Suspicious_IPAddress.InquiryCount;
		SELF.IPAddress_InquiryCountHour			:= le.Suspicious_IPAddress.InquiryCountHour;
		SELF.IPAddress_InquiryCountDay			:= le.Suspicious_IPAddress.InquiryCountDay;
		SELF.IPAddress_InquiryCountWeek			:= le.Suspicious_IPAddress.InquiryCountWeek;
		SELF.IPAddress_InquiryCountMonth		:= le.Suspicious_IPAddress.InquiryCountMonth;
		SELF.IPAddress_InquiryCountYear			:= le.Suspicious_IPAddress.InquiryCountYear;
		SELF.Name_Hit												:= le.Suspicious_Name.Name_Hit;
		SELF.Name_Message										:= le.Suspicious_Name.Name_Message;
		SELF.Name_Data_Source								:= le.Suspicious_Name.Data_Source;
		SELF.Name_SuspiciousRiskCodes				:= le.Suspicious_Name.SuspiciousRiskCodes;
		SELF.Name_DateFirstSeenInFile				:= le.Suspicious_Name.DateFirstSeenInFile;
		SELF.Name_InquiryCount							:= le.Suspicious_Name.InquiryCount;
		SELF.Name_InquiryCountHour					:= le.Suspicious_Name.InquiryCountHour;
		SELF.Name_InquiryCountDay						:= le.Suspicious_Name.InquiryCountDay;
		SELF.Name_InquiryCountWeek					:= le.Suspicious_Name.InquiryCountWeek;
		SELF.Name_InquiryCountMonth					:= le.Suspicious_Name.InquiryCountMonth;
		SELF.Name_InquiryCountYear					:= le.Suspicious_Name.InquiryCountYear;
		SELF.Phone_Hit											:= le.Suspicious_Phone.Phone_Hit;
		SELF.Phone_Message									:= le.Suspicious_Phone.Phone_Message;
		SELF.Phone_Data_Source							:= le.Suspicious_Phone.Data_Source;
		SELF.Phone_SuspiciousRiskCodes			:= le.Suspicious_Phone.SuspiciousRiskCodes;
		SELF.Phone_DateFirstSeenInFile			:= le.Suspicious_Phone.DateFirstSeenInFile;
		SELF.Phone_InquiryCount							:= le.Suspicious_Phone.InquiryCount;
		SELF.Phone_InquiryCountHour					:= le.Suspicious_Phone.InquiryCountHour;
		SELF.Phone_InquiryCountDay					:= le.Suspicious_Phone.InquiryCountDay;
		SELF.Phone_InquiryCountWeek					:= le.Suspicious_Phone.InquiryCountWeek;
		SELF.Phone_InquiryCountMonth				:= le.Suspicious_Phone.InquiryCountMonth;
		SELF.Phone_InquiryCountYear					:= le.Suspicious_Phone.InquiryCountYear;
		SELF.Combination_Search_Hit									:= le.Suspicious_Combination.Combination_Search_Hit;
		SELF.Combination_Search_Message							:= le.Suspicious_Combination.Combination_Search_Message;
		SELF.Combination_Search_Data_Source					:= le.Suspicious_Combination.Data_Source;
		SELF.Combination_Search_SuspiciousRiskCodes	:= le.Suspicious_Combination.SuspiciousRiskCodes;
		SELF.Combination_Search_DateFirstSeenInFile	:= le.Suspicious_Combination.DateFirstSeenInFile;
		SELF.Combination_Search_InquiryCount				:= le.Suspicious_Combination.InquiryCount;
		SELF.Combination_Search_InquiryCountHour		:= le.Suspicious_Combination.InquiryCountHour;
		SELF.Combination_Search_InquiryCountDay			:= le.Suspicious_Combination.InquiryCountDay;
		SELF.Combination_Search_InquiryCountWeek		:= le.Suspicious_Combination.InquiryCountWeek;
		SELF.Combination_Search_InquiryCountMonth		:= le.Suspicious_Combination.InquiryCountMonth;
		SELF.Combination_Search_InquiryCountYear		:= le.Suspicious_Combination.InquiryCountYear;
		
		SELF := le.Input_Echo; // The last fields to be copied are our inputs
	END;
	finalResults := SORT(PROJECT(results, flattenOutput(LEFT)), AcctNo);
		
	OUTPUT(finalResults, NAMED('Results'));
	
	BOOLEAN  ReturnDetailedRoyalties := false : STORED('ReturnDetailedRoyalties');
	dIPIn := PROJECT(Batch_In,TRANSFORM(Royalty.RoyaltyNetAcuity.IPData,SELF.AcctNo := LEFT.AcctNo; SELF.IPAddr := LEFT.IPAddress;));	
	dIPOut := project(results, TRANSFORM(Royalty.RoyaltyNetAcuity.IPData, SELF.AcctNo := LEFT.Input_Echo.AcctNo; SELF.Royalty_NAG := LEFT.Suspicious_IPAddress.Royalty_NAG;));
	dRoyaltiesByAcctno 	:= Royalty.RoyaltyNetAcuity.GetBatchRoyaltiesByAcctno(Gateways, dIPIn, dIPOut, TRUE);
	dRoyalties 					:= Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, ReturnDetailedRoyalties);
	output(dRoyalties,NAMED('RoyaltySet'));
	
ENDMACRO;

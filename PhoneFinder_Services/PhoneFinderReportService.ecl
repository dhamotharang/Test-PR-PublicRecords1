/*--SOAP--
<message name="PhoneFinderSearchService">
	<part name="DID" type="xsd:string"/>
	<separator />
	<part name="SSN" type="xsd:string"/>
	<separator />
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="PhoneticMatch" type="xsd:boolean"/>
	<part name="AllowNickNames" type="xsd:boolean"/>
	<separator />
	<part name="Addr" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<separator />
	<part name="Phone" type="xsd:string"/>
	<separator />
	<part name="TransactionType" type="xsd:string" default="Basic" description="Basic, Premium, Ultimate"/>
	<separator />
	<part name="DPPAPurpose" type="xsd:byte" default="1" size="2"/>
	<part name="GLBPurpose" type="xsd:byte" default="1" size="2"/>
	<part name="DataRestrictionMask" type="xsd:string" default="00000000000000"/>
	<part name="DataPermissionMask" type="xsd:string" default="1111010000"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<separator />
	<part name="SSNMask" type="xsd:string" default="FIRST5"/>
	<part name="DOBMask" type="xsd:string" default="DAY"/>
	<separator />
	<part name="StrictMatch" type="xsd:boolean" default="false"/>
	<part name="PenaltThreshold" type="xsd:string"/>
	<separator />
  <part name="VerifyPhoneName" type="xsd:boolean" default="false"/>
	<part name="VerifyPhoneNameAddress" type="xsd:boolean" default="false"/>
	<part name="VerifyPhoneIsActive" type="xsd:boolean" default="false"/>
  <part name="DateFirstSeenThreshold" type="xsd:integer" default="180"/>
  <part name="DateLastSeenThreshold" type="xsd:integer" default="30"/>
  <part name="LengthOfTimeThreshold" type="xsd:integer" default="90"/>
 	<part name="UseDateFirstSeenVerify" type="xsd:boolean" default="false"/>
	<part name="UseDateLastSeenVerify" type="xsd:boolean" default="false"/>
  <part name="UseLengthOfTimeVerify" type="xsd:boolean" default="false"/>
  <part name="UseDeltabase" type="xsd:boolean" default="false"/>
  <part name="IncludePhoneMetadata" type="xsd:boolean" default="true"/>
  <part name="SubjectMetadataOnly" type="xsd:boolean" default="false"/>
  <separator />
	<part name="Gateways" type="tns:XmlDataSet" cols="80" rows="15" />
	<part name="PhoneFinderSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="RiskIndicators" type="tns:XmlDataSet" cols="80" rows="20" />
  <part name="IncludeOtherPhoneRiskIndicators" type="xsd:boolean" default="false"/>
  <part name="usewaterfallv6" type="xsd:boolean" default="false"/>
</message>
*/
IMPORT Address,AutoStandardI,Gateway,iesp,PhoneFinder_Services,ut;

EXPORT PhoneFinderReportService() :=
MACRO	

	// parse ESDL input
  dIn       := DATASET([], iesp.phonefinder.t_PhoneFinderSearchRequest) : STORED('PhoneFinderSearchRequest',FEW);
  pfRequest := dIn[1] : INDEPENDENT;
	
	// Searchby request
	pfSearchBy:= GLOBAL(pfRequest.SearchBy);
	
	// User setttings
	pfUser := GLOBAL(pfRequest.User);
	
  // Report options
  pfOptions := GLOBAL(pfRequest.Options);
	
	// Gateway information
	dGateways := Gateway.Configuration.Get();
	
  // #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest(pfRequest);
  iesp.ECL2ESP.SetInputReportBy(PROJECT(pfSearchBy,
																				TRANSFORM(iesp.bpsreport.t_BpsReportBy,
																									SELF.Phone10 := LEFT.PhoneNumber,
																									SELF         := LEFT,
																									SELF         := [])));
	iesp.ECL2ESP.SetInputSearchOptions(PROJECT(pfOptions,TRANSFORM(iesp.share.t_BaseSearchOptionEx,SELF := LEFT;SELF := [])));
	
	// Global module
	globalMod := AutoStandardI.GlobalModule();
	
	// Search module
	searchMod := PROJECT(globalMod,PhoneFinder_Services.iParam.DIDParams,OPT);
	
	// Create dataset from search request
	Autokey_batch.Layouts.rec_inBatchMaster tFormat2Batch() :=
	TRANSFORM
		// Clean name and address
		cleanName := Address.GetCleanNameAddress.fnCleanName(pfSearchBy.Name);
		cleanAddr := Address.CleanAddressFieldsFips(AutoStandardI.InterfaceTranslator.clean_address.val(searchMod)).addressrecord;
		
		SELF.acctno      := '1';	// since there would only be one record
		SELF.name_first  := IF( AutoStandardI.InterfaceTranslator.fname_val.val(searchMod) != '',
														AutoStandardI.InterfaceTranslator.fname_val.val(searchMod),
														cleanName.fname);
		SELF.name_middle := IF( AutoStandardI.InterfaceTranslator.mname_val.val(searchMod) != '',
														AutoStandardI.InterfaceTranslator.mname_val.val(searchMod),
														cleanName.mname);
		SELF.name_last   := IF( AutoStandardI.InterfaceTranslator.lname_val.val(searchMod) != '',
														AutoStandardI.InterfaceTranslator.lname_val.val(searchMod),
														cleanName.lname);
		SELF.name_suffix := cleanName.name_suffix;
		SELF.z5          := cleanAddr.zip;
		SELF.ssn         := IF( AutoStandardI.InterfaceTranslator.ssn_value.val(searchMod) != '',
														AutoStandardI.InterfaceTranslator.ssn_value.val(searchMod),
														searchMod.SSN);
		SELF.homephone   := IF( AutoStandardI.InterfaceTranslator.phone_value.val(searchMod) != '',
														AutoStandardI.InterfaceTranslator.phone_value.val(searchMod),
														searchMod.Phone);
		SELF.DID         := IF( AutoStandardI.InterfaceTranslator.did_value.val(searchMod) != '',
														(UNSIGNED6)AutoStandardI.InterfaceTranslator.did_value.val(searchMod),
														(UNSIGNED6)searchMod.DID);
		SELF             := cleanAddr;
		SELF             := [];
	END;
	
	dReqBatch := DATASET([tFormat2Batch()]);
	
	iesp.phonefinder.t_PhoneFinderSearchBy CleanupSearch(recordof(dReqBatch) l) := TRANSFORM
		self.Name.first := l.name_first;
		self.Name.middle := l.name_middle;
		self.Name.last := l.name_last;
		self.Name.suffix := l.name_suffix;
		self.Address.streetNumber := l.prim_range;
		self.Address.streetPreDirection := l.predir;
		self.Address.streetName := l.prim_name;
		self.Address.streetSuffix := l.addr_suffix;
		self.Address.streetPostDirection := l.postdir;
		self.Address.unitDesignation := l.unit_desig;
		self.Address.unitNumber := l.sec_range;
		self.Address.streetAddress1 := Address.Addr1FromComponents(l.prim_range,l.predir,l.prim_name,l.addr_suffix,
																										l.postdir,l.unit_desig,l.sec_range);
		self.Address.city := l.p_city_name;
		self.Address.state := l.st;
		self.Address.zip5 := l.z5;
		self.Address.zip4 := l.zip4;
		self.PhoneNumber := l.homephone;
		self := l;
		self := [];
	
	END;

	cleanpSearchBy := PROJECT(dReqBatch, CleanupSearch(LEFT));
	
	formattedSearchBy := cleanpSearchBy[1];
	
	// Transaction type
	STRING vTransactionType := pfOptions._Type : STORED('TransactionType');

	// Report module
	reportMod := MODULE(PhoneFinder_Services.iParam.ReportParams)
		EXPORT UNSIGNED1 TransactionType     := CASE(ut.fnTrim2Upper(vTransactionType),
																									'BASIC'    => 0,
																									'PREMIUM'  => 1,
																									'ULTIMATE' => 2,
																									'PHONERISKASSESSMENT' => 3,
																									0);
		EXPORT BOOLEAN   StrictMatch        		:= AutoStandardI.InterfaceTranslator.StrictMatch_value.val(searchMod);
		EXPORT BOOLEAN   PhoneticMatch      		:= AutoStandardI.InterfaceTranslator.phonetics.val(searchMod);
		EXPORT STRING32  ApplicationType   		  := AutoStandardI.InterfaceTranslator.application_type_val.val(searchMod);
		EXPORT STRING5   IndustryClass      		:= AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.industry_class_val.params));
		EXPORT UNSIGNED1 GLBPurpose         		:= AutoStandardI.InterfaceTranslator.glb_purpose.val(searchMod);
		EXPORT UNSIGNED1 DPPAPurpose        		:= AutoStandardI.InterfaceTranslator.dppa_purpose.val(searchMod);
		EXPORT UNSIGNED  ScoreThreshold     		:= AutoStandardI.InterfaceTranslator.score_threshold_value.val(searchMod);
		EXPORT UNSIGNED  PenaltyThreshold    		:= AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
		EXPORT STRING    DataRestrictionMask		:= globalMod.DataRestrictionMask;
		EXPORT STRING    DataPermissionMask 		:= globalMod.DataPermissionMask;
		EXPORT STRING6   DOBMask             		:= AutoStandardI.InterfaceTranslator.dob_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.dob_mask_val.params));
		EXPORT STRING6   SSNMask            		:= AutoStandardI.InterfaceTranslator.ssn_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
		EXPORT BOOLEAN   UseLastResort      		:= doxie.DataPermission.use_LastResort and TransactionType <> PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT;
		EXPORT BOOLEAN   UseInHouseQSent    		:= doxie.DataPermission.use_QSent and TransactionType <> PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT;
		EXPORT BOOLEAN   UseQSent           		:= ~doxie.DataRestriction.QSent and TransactionType in [PhoneFinder_Services.Constants.TransType.Premium,PhoneFinder_Services.Constants.TransType.Ultimate];
		EXPORT BOOLEAN   UseAccuData_OCN        := pfOptions.IncludePhoneMetadata and TransactionType in [PhoneFinder_Services.Constants.TransType.Premium,
		                                                                                                  PhoneFinder_Services.Constants.TransType.Ultimate,
		                                                                                                  PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT];
		EXPORT BOOLEAN   UseTargus          		:= ~doxie.DataRestriction.PhoneFinderTargus and TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
		EXPORT BOOLEAN   UseMetronet         		:= ~doxie.DataRestriction.ExperianPhones and TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
		EXPORT BOOLEAN   UseEquifax         		:= ~doxie.DataRestriction.EquifaxPhoneMart and TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
		EXPORT BOOLEAN   useWaterfallv6					:= FALSE : STORED('useWaterfallv6');	// internal
		EXPORT BOOLEAN   IncludePhoneMetadata		:= pfOptions.IncludePhoneMetadata : STORED('IncludePhoneMetadata');				 				 
		BOOLEAN          RealTimedata 			 		:= pfOptions.UseDeltabase : STORED('UseDeltabase');						 
		EXPORT BOOLEAN   UseDeltabase 					:= IF(IncludePhoneMetadata,RealTimedata,FALSE);																						 
		BOOLEAN          SubjectMetadata 		 		:= pfOptions.SubjectMetadataOnly : STORED('SubjectMetadataOnly');
		EXPORT BOOLEAN   SubjectMetadataOnly  	:= IF(IncludePhoneMetadata,SubjectMetadata,FALSE);
		
		// Options for phone verification	  
		EXPORT BOOLEAN   VerifyPhoneName				:= pfOptions.VerificationOptions.VerifyPhoneName 				: STORED('VerifyPhoneName');
		EXPORT BOOLEAN   VerifyPhoneNameAddress := pfOptions.VerificationOptions.VerifyPhoneNameAddress : STORED('VerifyPhoneNameAddress');
		EXPORT BOOLEAN   VerifyPhoneIsActive    := pfOptions.VerificationOptions.VerifyPhoneIsActive    : STORED('VerifyPhoneIsActive');
  EXPORT INTEGER   DateFirstSeenThreshold := pfOptions.VerificationOptions.DateFirstSeenThreshold	: STORED('DateFirstSeenThreshold');
  EXPORT INTEGER   DateLastSeenThreshold  := pfOptions.VerificationOptions.DateLastSeenThreshold 	: STORED('DateLastSeenThreshold');
  EXPORT INTEGER   LengthOfTimeThreshold  := pfOptions.VerificationOptions.LengthOfTimeThreshold 	: STORED('LengthOfTimeThreshold');
		EXPORT BOOLEAN   UseDateFirstSeenVerify := pfOptions.VerificationOptions.UseDateFirstSeenVerify	: STORED('UseDateFirstSeenVerify');
		EXPORT BOOLEAN   UseDateLastSeenVerify  := pfOptions.VerificationOptions.UseDateLastSeenVerify  : STORED('UseDateLastSeenVerify');
		EXPORT BOOLEAN   UseLengthOfTimeVerify  := pfOptions.VerificationOptions.UseLengthOfTimeVerify  : STORED('UseLengthOfTimeVerify');
									   UserRules							:= pfOptions.RiskIndicators : STORED('RiskIndicators');	
										 allRules := IF(EXISTS(UserRules)and IncludePhoneMetadata, PhoneFinder_Services.Constants.defaultRules + UserRules,
										                                                           DATASET([],iesp.phonefinder.t_PhoneFinderRiskIndicator));
		EXPORT DATASET(iesp.phonefinder.t_PhoneFinderRiskIndicator) RiskIndicators	:= IF(TransactionType = PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT, 
		                                                                                  UserRules,
																																		                  allRules);
		EXPORT BOOLEAN   IncludeOtherPhoneRiskIndicators		:= pfOptions.IncludeOtherPhoneRiskIndicators : STORED('IncludeOtherPhoneRiskIndicators');	
		EXPORT UNSIGNED1 LineIdentityConsentLevel           := pfOptions.LineIdentityConsentLevel : STORED('LineIdentityConsentLevel');                                                     
		EXPORT STRING20  Usecase                            := pfOptions.LineIdentityUseCase: STORED('LineIdentityUseCase');
		EXPORT STRING3 	 ProductCode                        := pfUser.ProductCode: STORED('ProductCode');
		EXPORT STRING8	 BillingId                          := pfUser.BillingId: STORED('BillingId');
		EXPORT BOOLEAN   UseZumigoIdentity	 := doxie.DataPermission.use_ZumigoIdentity and TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate and BillingId <>'';
	END;

	modRecords := PhoneFinder_Services.PhoneFinder_Records(dReqBatch,reportMod,
																												IF(reportMod.TransactionType = PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT,
																																											 dGateways(servicename IN PhoneFinder_Services.Constants.PhoneRiskAssessmentGateways),dGateways),
 																												formattedSearchBy);
 iesp.phonefinder.t_PhoneFinderSearchResponse tFormat2IespResponse() :=
      		TRANSFORM
      			SELF._Header   := iesp.ECL2ESP.GetHeaderRow();
      			SELF.Records   := modRecords.dFormat2IESP;
      			SELF.InputEcho := pfSearchBy;
 END;
      		
 results := DATASET([tFormat2IespResponse()]);
   
 royalties	:= modRecords.dRoyalties;
   	
 Zumigo_Log := modRecords.Zumigo_History_Recs;
    
 OUTPUT(results,named('Results'));
 OUTPUT(royalties,named('RoyaltySet'));
 OUTPUT(Zumigo_Log,named('LOG_DELTA__PHONEFINDER_DELTA__PHONES__GATEWAY'));

ENDMACRO;

/*--HELP--
<pre>
&lt;PhoneFinderSearchRequest&gt;
&lt;row&gt;
&lt;User&gt;
  &lt;ReferenceCode&gt;ref_code_str&lt;/ReferenceCode&gt;
  &lt;BillingCode&gt;billing_code&lt;/BillingCode&gt;
  &lt;QueryId&gt;query_id&lt;/QueryId&gt;
  &lt;GLBPurpose&gt;1&lt;/GLBPurpose&gt;
  &lt;DLPurpose&gt;1&lt;/DLPurpose&gt;
  &lt;DataRestrictionMask&gt;000000000000000&lt;/DataRestrictionMask&gt;
  &lt;DataPermissionMask&gt;0000000000&lt;/DataPermissionMask&gt;
  &lt;SSNMask&gt;first5&lt;/SSNMask&gt;
  &lt;DOBMask&gt;&lt;/DOBMask&gt;
  &lt;EndUser/&gt;
&lt;/User&gt;
&lt;Options&gt;
  &lt;Type&gt;0&lt;/Type&gt;
  &lt;UsePhonetics&gt;false&lt;/UsePhonetics&gt;
  &lt;UseNicknames/&gt;
  &lt;VerificationOptions&gt;
		&lt;VerifyPhoneName&gt;&lt;/VerifyPhoneName&gt;
		&lt;VerifyPhoneNameAddress&gt;&lt;/VerifyPhoneNameAddress&gt;
		&lt;VerifyPhoneIsActive&gt;&lt;/VerifyPhoneIsActive&gt;
		&lt;DateFirstSeenThreshold&gt;&lt;/DateFirstSeenThreshold&gt;
		&lt;DateLastSeenThreshold&gt;&lt;/DateLastSeenThreshold&gt;
		&lt;LengthOfTimeThreshold&gt;&lt;/LengthOfTimeThreshold&gt;
		&lt;UseDateFirstSeenVerify&gt;&lt;/UseDateFirstSeenVerify&gt;
		&lt;UseDateLastSeenVerify&gt;&lt;/UseDateLastSeenVerify&gt;
		&lt;UseLengthOfTimeVerify&gt;&lt;/UseLengthOfTimeVerify&gt;
	&lt;/VerificationOptions&gt;
&lt;/Options&gt;
&lt;SearchBy&gt;
  &lt;UniqueID&gt;&lt;/UniqueID&gt;
  &lt;SSN&gt;&lt;/SSN&gt;
  &lt;PhoneNumber&gt;&lt;/PhoneNumber&gt;
  &lt;Name&gt;
    &lt;Full&gt;&lt;/Full&gt;
    &lt;First&gt;&lt;/First&gt;
    &lt;Middle&gt;&lt;/Middle&gt;
    &lt;Last&gt;&lt;/Last&gt;
  &lt;/Name&gt;
  &lt;Address&gt;
    &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
    &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
    &lt;StreetName&gt;&lt;/StreetName&gt;
    &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
		&lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
    &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
    &lt;City&gt;&lt;/City&gt;
    &lt;State&gt;&lt;/State&gt;
    &lt;Zip5&gt;&lt;/Zip5&gt;
  &lt;/Address&gt;
&lt;/SearchBy&gt;
&lt;/row&gt;
&lt;/PhoneFinderSearchRequest&gt;
</pre>
*/
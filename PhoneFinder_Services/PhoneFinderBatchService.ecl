/*--SOAP--
<message name="PhoneFinderBatchService">
  <part name="TransactionType" type="xsd:byte" default="0" size="1" description="0 - Basic, 1 - Premium 2 - Ultimate"/>
	<separator/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000000"/>
  <part name="DataPermissionMask" type="xsd:string" default="0000000000"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
  <separator/>
	<part name="SSNMask" type="xsd:string" default="FIRST5"/>
	<part name="DOBMask" type="xsd:string" default="DAY"/>
	<separator/>
	<part name="StrictMatch" type="xsd:boolean" default="false"/>
	<part name="AllowNickNames" type="xsd:boolean" default="false"/>
	<part name="PhoneticMatch" type="xsd:boolean" default="false"/>
	<part name="PenaltThreshold" type="xsd:string"/>
  <part name="UseDeltabase" type="xsd:boolean" default="false"/>
  <part name="IncludePhoneMetadata" type="xsd:boolean" default="false"/>
  <part name="SubjectMetadataOnly" type="xsd:boolean" default="false"/>
	<part name="RiskIndicators" type="tns:XmlDataSet" cols="70" rows="20" />
  <part name="IncludeOtherPhoneRiskIndicators" type="xsd:boolean" default="false"/>
  <part name="usewaterfallv6" type="xsd:boolean" default="false"/>
	<separator/>
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
	<separator/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
  <separator/>
  <part name="BatchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

EXPORT PhoneFinderBatchService :=
MACRO

	IMPORT AutoStandardI,Gateway,PhoneFinder_Services;
	
	// Batch input request
	dBatchReq := DATASET([],PhoneFinder_Services.Layouts.BatchIn) : STORED('BatchRequest');

	// Gateway configurations
	dGateways := Gateway.Configuration.Get();
	
	// Global module
	globalMod := AutoStandardI.GlobalModule();
	
	// Search module
	searchMod := PROJECT(globalMod,PhoneFinder_Services.iParam.DIDParams,OPT);
	
	// Report module
	reportMod := MODULE(PhoneFinder_Services.iParam.ReportParams)
		EXPORT UNSIGNED1 TransactionType     := 0 : STORED('TransactionType');
		EXPORT BOOLEAN   StrictMatch         := AutoStandardI.InterfaceTranslator.StrictMatch_value.val(searchMod);
		EXPORT BOOLEAN   PhoneticMatch       := AutoStandardI.InterfaceTranslator.phonetics.val(searchMod);
		EXPORT STRING32  ApplicationType     := AutoStandardI.InterfaceTranslator.application_type_val.val(searchMod);
		EXPORT STRING5   IndustryClass       := AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.industry_class_val.params));
		EXPORT UNSIGNED1 GLBPurpose          := AutoStandardI.InterfaceTranslator.glb_purpose.val(searchMod);
		EXPORT UNSIGNED1 DPPAPurpose         := AutoStandardI.InterfaceTranslator.dppa_purpose.val(searchMod);
		EXPORT UNSIGNED  ScoreThreshold      := AutoStandardI.InterfaceTranslator.score_threshold_value.val(searchMod);
		EXPORT UNSIGNED  PenaltyThreshold    := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
		EXPORT STRING    DataRestrictionMask := globalMod.DataRestrictionMask;
		EXPORT STRING    DataPermissionMask  := globalMod.DataPermissionMask;
		EXPORT STRING6   DOBMask             := AutoStandardI.InterfaceTranslator.dob_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.dob_mask_val.params));
		EXPORT STRING6   SSNMask             := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
		EXPORT BOOLEAN   UseLastResort       := doxie.DataPermission.use_LastResort and TransactionType <> PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT;
		EXPORT BOOLEAN   UseInHouseQSent     := doxie.DataPermission.use_QSent and TransactionType <> PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT;
		EXPORT BOOLEAN   UseQSent            := ~doxie.DataRestriction.QSent and TransactionType in [PhoneFinder_Services.Constants.TransType.Premium,PhoneFinder_Services.Constants.TransType.Ultimate];
		EXPORT BOOLEAN   UseTargus           := ~doxie.DataRestriction.PhoneFinderTargus and TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
		EXPORT BOOLEAN   UseMetronet         := ~doxie.DataRestriction.ExperianPhones and TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
		EXPORT BOOLEAN   UseEquifax          := ~doxie.DataRestriction.EquifaxPhoneMart and TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
		EXPORT BOOLEAN   useWaterfallv6			 := FALSE : STORED('useWaterfallv6');//internal
		EXPORT BOOLEAN   IncludePhoneMetadata := FALSE : STORED('IncludePhoneMetadata');  
    
		EXPORT BOOLEAN   UseAccudata_ocn     := IncludePhoneMetadata and TransactionType in [PhoneFinder_Services.Constants.TransType.Premium,
		                                                                                     PhoneFinder_Services.Constants.TransType.Ultimate,
																																												 PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT]; // accudata_ocn gateway call
					 BOOLEAN   RealtimeData 			 := FALSE : STORED('UseDeltabase');
		EXPORT BOOLEAN   UseDeltabase 			 := IF(IncludePhoneMetadata,RealtimeData,FALSE);
					 BOOLEAN   SubjectMetadata 		 := FALSE : STORED('SubjectMetadataOnly');
		EXPORT BOOLEAN   SubjectMetadataOnly := IF(IncludePhoneMetadata,SubjectMetadata,FALSE);
										 UserRules  				 := DATASET([],iesp.phonefinder.t_PhoneFinderRiskIndicator) : STORED('RiskIndicators');
										 allRules := IF(EXISTS(UserRules) and IncludePhoneMetadata, PhoneFinder_Services.Constants.defaultRules + UserRules,
										                                                            DATASET([],iesp.phonefinder.t_PhoneFinderRiskIndicator));
		EXPORT DATASET(iesp.phonefinder.t_PhoneFinderRiskIndicator) RiskIndicators	
																						:= IF(TransactionType = PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT, 
																						      UserRules,
																							    allRules);	
		EXPORT BOOLEAN   IncludeOtherPhoneRiskIndicators:= FALSE : STORED('IncludeOtherPhoneRiskIndicators');
		EXPORT BOOLEAN 	 DetailedRoyalties 	            := FALSE : STORED('ReturnDetailedRoyalties');
		EXPORT UNSIGNED1 LineIdentityConsentLevel       := 0 : STORED('LineIdentityConsentLevel');	
		EXPORT STRING20  Usecase                        := '': STORED('LineIdentityUseCase');
		EXPORT STRING3 	 ProductCode                    := '': STORED('ProductCode');
		EXPORT STRING8	 BillingId                      := '': STORED('BillingId');
		EXPORT BOOLEAN   UseZumigoIdentity	 := doxie.DataPermission.use_ZumigoIdentity and TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate and BillingId <>'';
				
					 BOOLEAN   DirectMarketing := FALSE : STORED('DirectMarketingSourcesOnly');
		EXPORT BOOLEAN   DirectMarketingSourcesOnly := DirectMarketing AND TransactionType = PhoneFinder_Services.Constants.TransType.BASIC;

	END;
	
	modBatchRecords := PhoneFinder_Services.PhoneFinder_BatchRecords(dBatchReq,reportMod,
   																																		IF(reportMod.TransactionType = PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT,
   																																											dGateways(servicename IN PhoneFinder_Services.Constants.PhoneRiskAssessmentGateways),dGateways));
   	
    royalties	:= modBatchRecords.dRoyalties;
   	results	:= modBatchRecords.dBatchOut;
   	Zumigo_Log	:= modBatchRecords.Zumigo_History_Recs;
 
   OUTPUT(results,named('Results'));
   OUTPUT(royalties,named('RoyaltySet'));
   OUTPUT(Zumigo_Log,named('LOG_DELTA_PHONEFINDER_DELTA_PHONES_GATEWAY'));

ENDMACRO;

/*--HELP--
<pre>
&lt;BatchRequest&gt;
  &lt;Row&gt;
    &lt;acctno&gt;&lt;/acctno&gt;
    &lt;name_first&gt;&lt;/name_first&gt;
    &lt;name_middle&gt;&lt;/name_middle&gt;
    &lt;name_last&gt;&lt;/name_last&gt;
    &lt;name_suffix&gt;&lt;/name_suffix&gt;
    &lt;prim_range&gt;&lt;/prim_range&gt;
    &lt;predir&gt;&lt;/predir&gt;
    &lt;prim_name&gt;&lt;/prim_name&gt;
    &lt;addr_suffix&gt;&lt;/addr_suffix&gt;
    &lt;postdir&gt;&lt;/postdir&gt;
    &lt;unit_desig&gt;&lt;/unit_desig&gt;
    &lt;sec_range&gt;&lt;/sec_range&gt;
    &lt;p_city_name&gt;&lt;/p_city_name&gt;
    &lt;st&gt;&lt;/st&gt;
    &lt;z5&gt;&lt;/z5&gt;
    &lt;z4&gt;&lt;/z4&gt;
    &lt;ssn&gt;&lt;/ssn&gt;
    &lt;phone&gt;&lt;/phone&gt;
    &lt;did&gt;&lt;/did&gt;
  &lt;/Row&gt;
&lt;/BatchRequest&gt;
</pre>
*/
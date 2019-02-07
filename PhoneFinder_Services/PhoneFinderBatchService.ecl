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
  <part name="UseInHousePhoneMetadata" type="xsd:boolean" default="false"/>
  <part name="VerifyPhoneName" type="xsd:boolean" default="false"/>
  <part name="VerifyPhoneNameAddress" type="xsd:boolean" default="false"/>
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
	 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
   #stored('useOnlyBestDID',true); // used to determine the 1 "best" did for the input criteria
	// Batch input request
	dBatchReq := DATASET([],PhoneFinder_Services.Layouts.BatchIn) : STORED('BatchRequest');

	// Gateway configurations
	dGateways := Gateway.Configuration.Get();
	
 reportMod := PhoneFinder_Services.iParam.GetBatchParams();
		
	modBatchRecords := PhoneFinder_Services.PhoneFinder_BatchRecords(dBatchReq,reportMod,
   																																		IF(reportMod.TransactionType = PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT,
   																																											dGateways(servicename IN PhoneFinder_Services.Constants.PhoneRiskAssessmentGateways),dGateways));
   	
    royalties	 := modBatchRecords.dRoyalties;
   	results   	:= modBatchRecords.dBatchOut;
   	Zumigo_Log	:= modBatchRecords.Zumigo_History_Recs;
 
   OUTPUT(results,named('Results'));
   OUTPUT(royalties,named('RoyaltySet'));
   OUTPUT(Zumigo_Log,named('LOG_DELTA__PHONEFINDER_DELTA__PHONES__GATEWAY'));
   

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
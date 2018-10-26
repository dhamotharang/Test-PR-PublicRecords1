/*--SOAP--
<message name="PhonePickListService">
	<part name="Phone" type="xsd:string"/>
	<separator />
	<part name="DPPAPurpose" type="xsd:byte" default="1" size="2"/>
	<part name="GLBPurpose" type="xsd:byte" default="1" size="2"/> 
	<part name="DataRestrictionMask" type="xsd:string" default="00000000000000"/>
	<part name="DataPermissionMask" type="xsd:string" default="0000000000"/>
	<separator />
	<part name="PhonePickListRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

EXPORT PhonePickListService :=
MACRO
	// parse ESDL input
  dIn             := DATASET([], iesp.phonepicklist.t_PhonePickListRequest) : STORED('PhonePickListRequest',FEW);
  pickListRequest := dIn[1] : INDEPENDENT;
	
	// Searchby request
	pickListSearchBy:= GLOBAL(pickListRequest.SearchBy);
	
	// User setttings
	pickListUser := GLOBAL(pickListRequest.User);
	
  // Report options
  pickListOptions := GLOBAL(pickListRequest.Options);
	
	// #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest(pickListRequest);
  iesp.ECL2ESP.SetInputReportBy(PROJECT(pickListSearchBy,
																				TRANSFORM(iesp.bpsreport.t_BpsReportBy,
																									SELF.Phone10 := LEFT.PhoneNumber,
																									SELF         := LEFT,
																									SELF         := [])));
	iesp.ECL2ESP.SetInputSearchOptions(PROJECT(pickListOptions,transform(iesp.share.t_BaseSearchOptionEx,SELF := LEFT;SELF := [])));
	iesp.ECL2ESP.Marshall.Mac_Set(pickListOptions);
	
	// Global module
	globalMod := AutoStandardI.GlobalModule();
	
	STRING15 vPhone := pickListSearchBy.PhoneNumber : STORED('Phone');
	
	// Search module
	searchMod := PROJECT(globalMod,PhoneFinder_Services.iParam.DIDParams,OPT);
	
	PhoneFinder_Services.Layouts.BatchInAppendDID tFormat2Batch() :=
	TRANSFORM
		SELF.acctno    := '1';	// since there would only be one record
		SELF.homephone := IF( AutoStandardI.InterfaceTranslator.phone_value.val(searchMod) != '',
													AutoStandardI.InterfaceTranslator.phone_value.val(searchMod),
													vPhone);
		SELF           := [];
	END;
	
	dReqBatch := DATASET([tFormat2Batch()]);
	
	// Report module
	reportMod := MODULE(PhoneFinder_Services.iParam.ReportParams)
		EXPORT STRING32  ApplicationType     := AutoStandardI.InterfaceTranslator.application_type_val.val(searchMod);
		EXPORT STRING5   IndustryClass       := AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.industry_class_val.params));
		EXPORT UNSIGNED1 GLBPurpose          := AutoStandardI.InterfaceTranslator.glb_purpose.val(searchMod);
		EXPORT UNSIGNED1 DPPAPurpose         := AutoStandardI.InterfaceTranslator.dppa_purpose.val(searchMod);
		EXPORT UNSIGNED  PenaltyThreshold    := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
		EXPORT STRING    DataRestrictionMask := globalMod.DataRestrictionMask : STORED('DataRestrictionMask');
		EXPORT STRING    DataPermissionMask  := globalMod.DataPermissionMask : STORED('DataPermissionMask');
		EXPORT BOOLEAN   UseLastResort       := FALSE;
		EXPORT BOOLEAN   UseInHouseQSent     := doxie.DataPermission.use_QSent;
		EXPORT BOOLEAN   UseQSent            := FALSE;
		EXPORT BOOLEAN   UseTargus           := FALSE;
		EXPORT BOOLEAN   IsPhone7Search      := TRUE;
		EXPORT BOOLEAN   UseInhousePhones    := TRUE;
    
	END;
	
	dPhonePickList := PhoneFinder_Services.PhonePickList_Records(dReqBatch,reportMod);
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(dPhonePickList,dMarshallResults,iesp.phonepicklist.t_PhonePickListResponse,,,,InputEcho,pickListSearchBy);
	
	MAP(vPhone = '' or LENGTH(TRIM(vPhone)) != 7                         => FAIL(301,doxie.ErrorCodes(301)),
			COUNT(dPhonePickList) > PhoneFinder_Services.Constants.MaxPhones => FAIL(203,doxie.ErrorCodes(203)),
			OUTPUT(dMarshallResults,named('Results')));
	
ENDMACRO;

/*--HELP--
<pre>
&lt;PhonePickListRequest&gt;
&lt;row&gt;
&lt;User&gt;
  &lt;ReferenceCode&gt;ref_code_str&lt;/ReferenceCode&gt;
  &lt;BillingCode&gt;billing_code&lt;/BillingCode&gt;
  &lt;QueryId&gt;query_id&lt;/QueryId&gt;
  &lt;GLBPurpose&gt;1&lt;/GLBPurpose&gt;
  &lt;DLPurpose&gt;1&lt;/DLPurpose&gt;
  &lt;DataRestrictionMask&gt;000000000000000&lt;/DataRestrictionMask&gt;
  &lt;DataPermissionMask&gt;0000000000&lt;/DataPermissionMask&gt;
&lt;/User&gt;
&lt;Options/&gt;
&lt;SearchBy&gt;
  &lt;PhoneNumber&gt;&lt;/PhoneNumber&gt;
&lt;/SearchBy&gt;
&lt;/row&gt;
&lt;/PhonePickListRequest&gt;
</pre>
*/
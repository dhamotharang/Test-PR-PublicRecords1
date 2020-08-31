/*--SOAP--
<message name="PropertyHistoryPlus_Service">
	<part name="APN"                 type="xsd:string"/>
	<part name="Addr"                type="xsd:string"/>
	<part name="City"                type="xsd:string"/>
	<part name="State"               type="xsd:string"/>
	<part name="Zip"                 type="xsd:string"/>
	<part name="LnBranded"           type="xsd:boolean"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType"     type="xsd:string"/>
	<separator/>
	<part name="PropertyHistoryPlusReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

EXPORT PropertyHistoryPlus_Service :=
MACRO
	dIn := DATASET([],iesp.propertyhistoryplus.t_PropertyHistoryPlusReportRequest) : STORED('PropertyHistoryPlusReportRequest',FEW);
	mcRequest := dIn[1] : GLOBAL;
	
	// Searchby request
	xmlSearchBy:= GLOBAL(mcRequest.ReportBy);
	
  // Report options
  mcOptions := GLOBAL(mcRequest.Options);
	
  // #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest(mcRequest);
  iesp.ECL2ESP.SetInputReportBy(PROJECT(xmlSearchBy,TRANSFORM(iesp.bpsreport.t_BpsReportBy,SELF := LEFT,SELF := [])));
	iesp.ECL2ESP.SetInputSearchOptions(PROJECT(mcOptions,TRANSFORM(iesp.share.t_BaseSearchOptionEx,SELF := LEFT,SELF := [])));
	
	// Global module
	globalMod := AutoStandardI.GlobalModule();
	searchMod := PROJECT(globalMod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,OPT);
	boolean includeAssignmentsAndReleases := mcRequest.Options.IncludeAssignmentsAndReleases;
	
	reportParams := MODULE(Location_Services.iParam.PropHistHRI)
		EXPORT UNSIGNED1 GLBPurpose          := AutoStandardI.InterfaceTranslator.glb_purpose.val(searchMod);
		EXPORT UNSIGNED1 DPPAPurpose         := AutoStandardI.InterfaceTranslator.dppa_purpose.val(searchMod);
		EXPORT STRING6   DOBMask             := AutoStandardI.InterfaceTranslator.dob_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.dob_mask_val.params));
		EXPORT STRING6   SSNMask             := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(PROJECT(globalMod,AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
		EXPORT STRING    DataRestrictionMask := globalMod.DataRestrictionMask;
		EXPORT STRING    DataPermissionMask  := globalMod.DataPermissionMask;
		EXPORT BOOLEAN   IgnoreFares         := globalMod.ignoreFares;
		EXPORT BOOLEAN   IgnoreFidelity      := globalMod.ignoreFidelity;
		
		EXPORT BOOLEAN   LNBranded           := AutoStandardI.InterfaceTranslator.ln_branded_value.val(PROJECT(searchMod,AutoStandardI.InterfaceTranslator.ln_branded_value.params));
		EXPORT STRING32  ApplicationType     := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(searchMod,AutoStandardI.InterfaceTranslator.application_type_val.params));
		EXPORT STRING5   IndustryClass       := AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(searchMod,AutoStandardI.InterfaceTranslator.industry_class_val.params));
	END;
	
	// Populating the XML request from the soap fields
	STRING vAPN := '' : STORED('APN');
	
	iesp.propertyhistoryplus.t_PropertyHistoryPlusReportBy tFormatSoapFields2Xml() :=
	TRANSFORM
		SELF.ParcelId := vAPN;
		SELF.Address  := ROW({'','','','','','','',searchMod.addr[1..60],searchMod.addr[61..],searchMod.city,searchMod.state,searchMod.zip,'','','',''},iesp.share.t_Address);
	END;
	
	soapSearchBy := ROW(tFormatSoapFields2Xml());
	
	propHistPlusSearchBy := IF(EXISTS(dIn),xmlSearchBy,soapSearchBy);
	
	// Clean the address
	Autokey_batch.Layouts.rec_inBatchMaster tConvert2Batch(iesp.propertyhistoryplus.t_PropertyHistoryPlusReportBy pInput) :=
	TRANSFORM
		cleanAddr := Address.CleanAddressFieldsFips(AutoStandardI.InterfaceTranslator.clean_address.val(searchMod)).addressrecord;
		
		SELF.acctno      := '1';	// since there would only be one record
		SELF.z5          := cleanAddr.zip;
		SELF.apn         := pInput.ParcelId;
		SELF             := cleanAddr;
	END;
	
	dReqCleanAddr := PROJECT(DATASET(propHistPlusSearchBy),tConvert2Batch(LEFT));
	
	// Filter records with no unit number populated
	dUnitNumbersDedup := Location_Services.Functions.GetSecRanges (dReqCleanAddr(sec_range = ''));
	
	// If we do get back more than one distinguished secondary range (not counting blanks), then we fail the service with insufficient address
  // NB: in case APN is in the input search will go on by APN.
	IF(trim(vAPN) = '' and (count(dUnitNumbersDedup) > 1), FAIL(310,doxie.ErrorCodes(310)));
	
    dResults := Location_Services.PropertyHistoryPlus_Records(dReqCleanAddr,reportParams,propHistPlusSearchBy, includeAssignmentsAndReleases);
	
	OUTPUT(dResults,NAMED('Results'));
ENDMACRO;

/*--HELP--
<pre>
&lt;PropertyHistoryPlusReportRequest&gt;
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
&lt;/User&gt;
&lt;Options/&gt;
&lt;ReportBy&gt;
  &lt;ParcelId&gt;&lt;/ParcelId&gt;
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
&lt;/ReportBy&gt;
&lt;/row&gt;
&lt;/PropertyHistoryPlusReportRequest&gt;
</pre>
*/
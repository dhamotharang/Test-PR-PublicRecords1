/*--SOAP--
<message name="ReportServiceFCRA">
	<part name="DataRestrictionMask"   type="xsd:string"/>
	<part name="DOBMask"               type="xsd:string"/>
	<part name="SSNMask"               type="xsd:string"/>
	<part name="GLBPurpose"            type="xsd:byte"/>
	<part name="PermissiblePurpose"    type="xsd:string"/>
	<part name="FFDOptionsMask"        type="xsd:integer"/>
	<part name="IncludeLiensJudgments" type="xsd:boolean"/>
	<part name="Gateways"              type="tns:XmlDataSet" cols="70" rows="4"/>
	<part name="FCRAConsumerCreditReportRequest" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT iesp, MDR, Royalty, WSInput;

EXPORT ReportServiceFCRA := MACRO

	WSInput.MAC_ConsumerCreditReport_ReportServiceFCRA();

	reqRec := iesp.consumercreditreport_fcra.t_FcraConsumerCreditReportRequest;
	ds_xml := DATASET([],reqRec) : STORED('FCRAConsumerCreditReportRequest',FEW);
	firstRow := ds_xml[1] : INDEPENDENT;

	ConsumerCreditReport_Services.IParams.SetInputUserOptions(GLOBAL(firstRow));
	in_mod := ConsumerCreditReport_Services.IParams.getParams();
	IF(NOT in_mod.hasGlbPermissiblePurpose, FAIL(ConsumerCreditReport_Services.Constants.GLB_REQUIRED_MSG));
	ds_input_recs := ConsumerCreditReport_Services.Functions.format_InputRec(ds_xml);

	ds_records := ConsumerCreditReport_Services.Records(ds_input_recs,in_mod);
	ds_results := PROJECT(ds_records,TRANSFORM(iesp.consumercreditreport_fcra.t_FcraConsumerCreditReportResponse,SELF:=LEFT));
	ds_royalties := Royalty.RoyaltyCCR.GetOnlineRoyalties(ds_records);

	OUTPUT(ds_results,NAMED('Results'));
	OUTPUT(ds_royalties,NAMED('RoyaltySet'));

ENDMACRO;

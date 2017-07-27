/*--SOAP--
<message name="CriminalRecords::ReportService">

	<!-- Keyed Fields -->
  <part name="DID" 							type="xsd:string"/>
  <part name="OffenderKey" 			type="xsd:string"/>
  <part name="DOCNumber" 				type="xsd:string"/>
  <part name="FirstName"   			type="xsd:string"/>
  <part name="MiddleName"  			type="xsd:string"/>
  <part name="LastName"    			type="xsd:string"/>
  <part name="State"       			type="xsd:string"/>
	
	<!-- Tuning -->
	<part name="PenaltThreshold"	type="xsd:unsignedInt"/>
	<part name="IncludeAllCriminalRecords"	type="xsd:boolean"/>
	<part name="IncludeSexualOffenses"	type="xsd:boolean"/>
	  
	
	<!-- Compliance Settings -->
  <part name="DPPAPurpose"			type="xsd:byte"/>
  <part name="GLBPurpose"				type="xsd:byte"/>
  <part name="SSNMask"					type="xsd:string"/>
  <part name="DLMask"						type="xsd:string"/>
	<part name="ApplicationType"  type="xsd:string"/>
	
	<!-- Record Management -->
	<part name="MaxResults"					type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
	<part name="SkipRecords"				type="xsd:unsignedInt"/>

	<!-- XML Input -->
	<part name="CrimReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
</message>
*/
/*--INFO-- This service pulls from the Criminal Offenders file.*/
import iesp, AutoStandardI;
export ReportService := MACRO
rec_in		:= iesp.criminal.t_CrimReportRequest;
ds_in			:= dataset([], rec_in) : STORED('CrimReportRequest', few);
first_row	:= ds_in[1] : INDEPENDENT;

iesp.ECL2ESP.SetInputBaseRequest(first_row);
report_opt	 := global (first_row.Options);
// read specific for this query input (Note: DOCNumber isn't used by ESP for report).
report_by := global (first_row.ReportBy);

iesp.ECL2ESP.SetInputName(report_by.Name);

#stored('OffenderKey', report_by.OffenderId);
#stored('IncludeAllCriminalRecords', report_opt.IncludeAllCriminalRecords);
#stored('IncludeSexualOffenses', report_opt.IncludeSexualOffenses);
#stored ('DID',report_by.UniqueId)
// used only for SOAP testing
input_params := AutoStandardI.GlobalModule();
tempmod := module(project(input_params,CriminalRecords_Services.IParam.report,opt))
	export string25	doc_number			:= '' : STORED('DOCNumber');
 	export string60	offender_key		:= '' : STORED('OffenderKey');
	export boolean 	IncludeAllCriminalRecords := false :STORED('IncludeAllCriminalRecords');
	export boolean 	IncludeSexualOffenses := false :STORED('IncludeSexualOffenses');	
	export string6 	ssnmask := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project (input_params, AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
end;

results := project(CriminalRecords_Services.ReportService_Records.val(tempmod), iesp.criminal.t_CrimReportResponse);

output(results, named('Results'));

endmacro;
//Interface is wrong
//Name fields should not be in the interface as they don't seem to be used by the search
//Julie

// ReportService();
/*
<CrimReportRequest>
<row>
 <User>
  <DLPurpose>1</DLPurpose>
  <DebitUnits>0</DebitUnits>
  <SSNMaskingOn>0</SSNMaskingOn>
  <GLBPurpose>1</GLBPurpose>
  <DLMaskingOn>0</DLMaskingOn>
  <DLMask>0</DLMask>
  <MaxWaitSeconds>0</MaxWaitSeconds>
  <BillingCode>camaral</BillingCode>
 </User>
 <Options>
  <IncludeAllCriminalRecords>1</IncludeAllCriminalRecords>
  <IncludeSexualOffenses>1</IncludeSexualOffenses>
 </Options>
 <ReportBy>
  <OffenderId>FL313471</OffenderId>
 </ReportBy>
</row>
</CrimReportRequest>
*/
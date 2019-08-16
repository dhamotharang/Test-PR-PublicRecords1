/*--SOAP--
<message name="ReportService">
	<part name="ExcludeForeclosures"     type="xsd:boolean"/>
	<part name="IncludeNoticeOfDefaults" type="xsd:boolean"/>
	<separator/>

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte" default="1"/>
	<part name="DPPAPurpose"         type="xsd:byte" default="1"/>
	<part name="ApplicationType"     type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string" default="0"/> 
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
	<separator/>
	
	<!-- SEARCH FIELDS -->  
	<part name="ForeclosureId"       type="xsd:string"/>
	<part name="SSN"      		   type="xsd:string"/>
	<part name="DID"      		   type="xsd:string"/>
	<separator/>

	<!-- User -->
	<part name="ReferenceCode"       type="xsd:string"/>
	<part name="BillingCode"         type="xsd:string"/>
	<part name="QueryId"             type="xsd:string"/>

	
  <part name="ForeclosureReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
</message>
*/
/*--INFO-- Returns Foreclosure reports records.<br/>
 Optionally returns Notice of Defaults reports records:
<table border="1">
<tr><th>ExcludeForeclosures</th><th>IncludeNoticeOfDefaults</th><th>Record Types</th></tr>
<tr><td>false</td><td>false</td><td>Foreclosures Only</td></tr>
<tr><td>false</td><td>true</td><td>Foreclosures and Notice of Defaults</td></tr>
<tr><td>true</td><td>true</td><td>Notice of Defaults Only</td></tr>
<tr><td>true</td><td>false</td><td>nil, nada, null, naught, nothing, ...</td></tr>
</table>
*/

import Foreclosure_services, iesp, AutoStandardI;
export ReportService := macro
		
		rec_in := iesp.foreclosure.t_ForeclosureReportRequest;
    ds_in := DATASET ([], rec_in) : STORED ('ForeclosureReportRequest', FEW);
		first_row := ds_in[1] : independent;

    //set options
    iesp.ECL2ESP.SetInputBaseRequest (first_row);

    //set main search criteria:
    report_by := global (first_row.ReportBy);		
		#stored ('DID', report_by.UniqueId);
		#stored ('SSN', report_by.SSN);
		#stored ('ForeclosureId', report_by.ForeclosureId);
		#stored ('ExcludeForeclosures',first_row.options.ExcludeForeclosures);
		#stored ('IncludeNoticeOfDefaults',first_row.options.IncludeNoticeOfDefaults);
	
  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
	tempmod := module(project(input_params,Foreclosure_services.ReportService_Records.params,opt))
			EXPORT string70 ForeclosureId := '' :stored ('ForeclosureId');
	end;

	boolean ExcludeForeclosures := false : stored('ExcludeForeclosures');
	boolean IncludeNoticeOfDefaults := false : stored('IncludeNoticeOfDefaults');
	boolean includeVendorSourceB := first_row.options.IncludeVendorSourceB;
	 
	for := if(~ExcludeForeclosures,Foreclosure_Services.ReportService_Records.val(tempmod,mod_access,false, includeVendorSourceB));
	nod := if(IncludeNoticeOfDefaults,Foreclosure_Services.ReportService_Records.val(tempmod,mod_access,true, includeVendorSourceB));
	raw_records := sort(for+nod,-recordingdate,record);

  // attach standard ESP header
  iesp.foreclosure.t_ForeclosureReportResponse Format () := transform
    Self._Header := iesp.ECL2ESP.GetHeaderRow();
    Self.Foreclosures := choosen (raw_records, iesp.constants.MAX_COUNT_Foreclosure_REPORT);
  end;

  results := dataset ([Format ()]);
	output(results, named('Results'));		
endmacro;

//ReportService ();

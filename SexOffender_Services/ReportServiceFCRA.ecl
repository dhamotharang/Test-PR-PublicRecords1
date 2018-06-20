/*--SOAP--
<message name="ReportServiceFCRA">

	<!-- User Section -->
	<part name="ReferenceCode"       type="xsd:string"/>
	<part name="BillingCode"         type="xsd:string"/>
	<part name="QueryId"             type="xsd:string"/>
	<part name="ApplicationType"     type="xsd:string"/>
		
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="FCRAPurpose"         type="xsd:string"/>
	<part name="SSNMask" 							type="xsd:string"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
	
	<!-- FCRA REPORT FIELD -->
	<part name="DID" 							   type="xsd:string"/>
	
  <!-- Options -->
	<part name="AllowGraphicDescription"		 type="xsd:boolean"/>
		
  <part name="FcraSexOffenderReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Return Sex Offender information in a report format.*/

import iesp, AutoStandardI, FFD;

export ReportServiceFCRA := macro
	boolean isFCRA := true;
	#constant('NoDeepDive', true);

  // Get XML input 
  rec_in := iesp.sexualoffender_fcra.t_FcraSexOffenderReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('FcraSexOffenderReportRequest', FEW);
	first_row := ds_in[1] : independent;

  //set options
	// add coding to additional options for name searching options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
	report_by := global (first_row.ReportBy);
	options		:= global (first_row.Options);
	//Do not need to store name fields since they are not used in prod/moxie even though
	//they are on the moxie (wsonline) search form.

	//Store "report-by" fields into soap names to be used below
  #stored('AllowGraphicDescription', options.AllowGraphicDescription);
  #stored('IncludeBestAddress', options.IncludeBestAddress); //do we want this for FCRA...and if so we need an FCRA key for watchdog.key_watchdog_nonglb (used in Raw.GetBestAddressRec)

	glbMod := AutoStandardI.GlobalModule(isFCRA);
	tempmod := module(project(glbMod, SexOffender_Services.IParam.report,opt));
		string14 soap_did := '' : stored('DID');
		string14 rdid := if(report_by.UniqueId <> '', report_by.UniqueId, soap_did);
		export string14 DID := rdid;
		export boolean	AllowGraphicDescription	:= false	: stored('AllowGraphicDescription');
		export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(glbMod,AutoStandardI.InterfaceTranslator.application_type_val.params));
		export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
		export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
	end;

	temp := SexOffender_Services.ReportRecords.fcra_val(tempmod);
 
  input_consumer := FFD.MAC.PrepareConsumerRecord(tempmod.did, true, , report_by.UniqueId); 
	
 	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(temp.Records, results, 
                  iesp.sexualoffender_fcra.t_FcraSexOffenderReportResponse, SexualOffenses, true);
 // transform to FCRA FFD layout
  FFD.MAC.AppendConsumerAlertsAndStatements(results, out_results, temp.Statements, temp.ConsumerAlerts, input_consumer, iesp.sexualoffender_fcra.t_FcraSexOffenderReportResponse);

  output(out_results,named('Results'));

endmacro;

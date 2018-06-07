/*--SOAP--
<message name="CriminalRecords::SearchService">

	<!-- Keyed Fields -->
  <part name="DID" 							type="xsd:string" />
	
	<!-- Autokey Search Fields -->
  <part name='SSN'							type='xsd:string'/>
  <part name="FirstName"   			type="xsd:string"/>
  <part name="MiddleName"  			type="xsd:string"/>
  <part name="LastName"    			type="xsd:string"/>
  <part name="Addr"	       			type="xsd:string"/>
  <part name="City"        			type="xsd:string"/>
  <part name="State"       			type="xsd:string"/>
  <part name="Zip"         			type="xsd:string"/>
  <part name="County"           type="xsd:string"/>
	<part name="DOB" 							type="xsd:unsignedInt"/>

	<!-- Tuning -->
	<part name="NoDeepDive" 			type="xsd:boolean"/>
	
	<!-- Compliance Settings -->
  <part name="FCRAPurpose" type="xsd:string"/>
  <part name="DPPAPurpose"			type="xsd:byte"/>
  <part name="GLBPurpose"				type="xsd:byte"/>
  <part name="SSNMask"					type="xsd:string"/>
  <part name="DLMask"						type="xsd:string"/>
	<part name="ApplicationType"  type="xsd:string"/>
	
	<!-- Record Management -->
	<part name="MaxResults"					type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
	<part name="SkipRecords"				type="xsd:unsignedInt"/>
  <part name="StrictMatch" type="xsd:boolean"/>

	<!-- XML Input -->
	<part name="FcraCriminalSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
/*--INFO-- This service pulls from the Criminal Offenders file.*/

import iesp, AutoStandardI, STD;

export SearchServiceFCRA := MACRO
#onwarning(4207, ignore);

	boolean isFCRA := true;
	#constant('NoDeepDive', true);
	#constant('DidOnly', true); // for picklist

	// Get XML input
	rec_in		:= iesp.criminal_fcra.t_FcraCriminalSearchRequest;
	ds_in			:= dataset([], rec_in) : STORED('FcraCriminalSearchRequest', few);
	first_row	:= ds_in[1] : INDEPENDENT;
	search_by := global(first_row.SearchBy);
		
	// set options
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);

	// set main search criteria:
	iesp.ECL2ESP.SetInputSearchOptions(first_row.options);
	iesp.ECL2ESP.SetInputReportBy(row(first_row.searchby,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[])));
	
	//soap call for remote DIDs
	//------------------------------------------------------------------------------------
  // the only purpose of this macro is to produce a single DID, so in case DID is provided in the input
  // -- either in #stored or in ESDL -- this MACRO will necessarily bounced this DID back.
	FCRA.MAC_GetPickListRecords (ds_in, res_esdl);
	//------------------------------------------------------------------------------------
	
	rdid := res_esdl[1].Records[1].UniqueId;
	
	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,CriminalRecords_Services.IParam.search,opt))
		export string14 did 								:= rdid;
		export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);	
		export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);	
	end;

	input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, true, search_by);
	
	crim_all := CriminalRecords_Services.SearchService_Records.fcra_val(tempmod);
	crim_records_all := crim_all.Records;
	
	crim_records := choosen(crim_records_all,iesp.constants.CRIM.MaxSearchRecords);

	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(crim_records, results_pre, iesp.criminal_fcra.t_FcraCriminalSearchResponse);

	FFD.MAC.AppendConsumerAlertsAndStatements(results_pre, results, crim_all.Statements, crim_all.ConsumerAlerts, input_consumer, iesp.criminal_fcra.t_FcraCriminalSearchResponse);	
	
	output(results, named('Results'), all);																	 															
																 															
endmacro;
/*--SOAP--
<message name="SearchServiceFCRA">
	<part name="DID"                 type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
  <part name="FcraWeaponSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Returns FCRA concealed weapon Search records.*/

import CCW_services, iesp, AutoStandardI, FCRA , FFD;

EXPORT SearchServiceFCRA := MACRO
 #onwarning(4207, ignore);
	#constant('NoDeepDive', true);
	
	rec_in := iesp.concealedweapon_fcra.t_FcraWeaponSearchRequest;
	ds_in := DATASET ([], rec_in) : STORED ('FcraWeaponSearchRequest', FEW);
	first_row := ds_in[1] : independent;
	
	//set options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
	
	//set main search criteria:
	search_by := global (first_row.SearchBy);
	iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
	iesp.ECL2ESP.SetInputReportBy(row(first_row.searchby,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[])));
	
	//soap call for remote DIDs
	//------------------------------------------------------------------------------------
  // the only purpose of this macro is to produce a single DID, so in case DID is provided in the input
  // -- either in #stored or in ESDL -- this MACRO will necessarily bounced this DID back.
	FCRA.MAC_GetPickListRecords (ds_in, res_esdl);

	//------------------------------------------------------------------------------------

	rdid := res_esdl[1].Records[1].UniqueId;
	
	input_params := AutoStandardI.GlobalModule(true);
	tempmod := module(project(input_params,CCW_services.SearchService_Records.params,opt))
		EXPORT string14 did := rdid;
		EXPORT STRING32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
		EXPORT STRING5 IndustryClass := AutoStandardI.InterfaceTranslator.industry_class_value.val (project(input_params,AutoStandardI.InterfaceTranslator.industry_class_value.params));
		export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
		export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
	end;
	
	ccwresults := CCW_services.SearchService_Records.search(tempmod, true);		

	input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, true, search_by);
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(ccwresults.Records, results, iesp.concealedweapon_fcra.t_FcraWeaponSearchResponse);	
	
  FFD.MAC.AppendConsumerAlertsAndStatements(results, results_final, ccwresults.Statements, ccwresults.ConsumerAlerts, input_consumer, iesp.concealedweapon_fcra.t_FcraWeaponSearchResponse);	 																						
	
	output(results_final, named('Results'));
	 
ENDMACRO;

// SearchServiceFCRA()
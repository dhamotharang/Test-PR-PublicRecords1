/*--SOAP--
<message name="SearchServiceFCRA">

	<part name="DID"              type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
  <part name="FcraHuntFishSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Search and return Hunting & Fishing License FCRA information.*/

import iesp, AutoStandardI, FCRA, STD;

export SearchServiceFCRA := macro
  #onwarning(4207, ignore);
		#constant('NoDeepDive', true);
		// Get XML input 
		rec_in := iesp.huntingfishing_fcra.t_FcraHuntFishSearchRequest;
		ds_in := DATASET ([], rec_in) : STORED ('FcraHuntFishSearchRequest', FEW);
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
		tempmod := module(project(input_params,hunting_fishing_services.Search_Records.params,opt));
			export string14 did := rdid;
			export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
			export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
			export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
		end;
		tempresults := hunting_fishing_services.Search_Records.val(tempmod, true);

	  input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, true, search_by);

		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults.Records, results, iesp.huntingfishing_fcra.t_FcraHuntFishSearchResponse, Records, false);
																																	
		FFD.MAC.AppendConsumerAlertsAndStatements(results, results_new, tempresults.Statements, tempresults.ConsumerAlerts, input_consumer, iesp.huntingfishing_fcra.t_FcraHuntFishSearchResponse);

		output(results_new, named('Results'));

endmacro;
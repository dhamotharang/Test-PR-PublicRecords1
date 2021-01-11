// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Returns FCRA concealed weapon Search records.*/

IMPORT CCW_services, iesp, AutoStandardI, FCRA , FFD;

EXPORT SearchServiceFCRA := MACRO
  #ONWARNING(4207, ignore);
  #CONSTANT('NoDeepDive', TRUE);
  
  rec_in := iesp.concealedweapon_fcra.t_FcraWeaponSearchRequest;
  ds_in := DATASET ([], rec_in) : STORED ('FcraWeaponSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  
  //set options
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
  
  //set main search criteria:
  search_by := GLOBAL (first_row.SearchBy);
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
  iesp.ECL2ESP.SetInputReportBy(ROW(first_row.searchby,TRANSFORM(iesp.bpsreport.t_BpsReportBy,SELF:=LEFT,SELF:=[])));
  
  //soap call for remote DIDs
  //------------------------------------------------------------------------------------
  // the only purpose of this macro is to produce a single DID, so in case DID is provided in the input
  // -- either in #stored or in ESDL -- this MACRO will necessarily bounced this DID back.
  FCRA.MAC_GetPickListRecords (ds_in, res_esdl);

  //------------------------------------------------------------------------------------

  rdid := res_esdl[1].Records[1].UniqueId;
  
  input_params := AutoStandardI.GlobalModule(TRUE);
  tempmod := MODULE(PROJECT(input_params,CCW_services.SearchService_Records.params,OPT))
    EXPORT STRING14 did := rdid;
    EXPORT STRING32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
    EXPORT STRING5 IndustryClass := AutoStandardI.InterfaceTranslator.industry_class_value.val (PROJECT(input_params,AutoStandardI.InterfaceTranslator.industry_class_value.params));
    EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
  END;
  
  ccwresults := CCW_services.SearchService_Records.search(tempmod, TRUE);

  input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, TRUE, search_by);
  
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(ccwresults.Records, results, iesp.concealedweapon_fcra.t_FcraWeaponSearchResponse);
  
  FFD.MAC.AppendConsumerAlertsAndStatements(results, results_final, ccwresults.Statements, ccwresults.ConsumerAlerts, input_consumer, iesp.concealedweapon_fcra.t_FcraWeaponSearchResponse);
  
  OUTPUT(results_final, NAMED('Results'));
   
ENDMACRO;

// SearchServiceFCRA()

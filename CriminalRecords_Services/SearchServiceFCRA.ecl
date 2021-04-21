// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT iesp, AutoStandardI, STD;

EXPORT SearchServiceFCRA := MACRO
#ONWARNING(4207, ignore);

  BOOLEAN isFCRA := TRUE;
  #CONSTANT('NoDeepDive', TRUE);
  #CONSTANT('DidOnly', TRUE); // for picklist

  // Get XML input
  rec_in := iesp.criminal_fcra.t_FcraCriminalSearchRequest;
  ds_in := DATASET([], rec_in) : STORED('FcraCriminalSearchRequest', few);
  first_row := ds_in[1] : INDEPENDENT;
  search_by := GLOBAL(first_row.SearchBy);

  // set options
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);

  // set main search criteria:
  iesp.ECL2ESP.SetInputSearchOptions(first_row.options);
  iesp.ECL2ESP.SetInputReportBy(ROW(first_row.searchby,TRANSFORM(iesp.bpsreport.t_BpsReportBy,SELF:=LEFT,SELF:=[])));

  //soap call for remote DIDs
  //------------------------------------------------------------------------------------
  // the only purpose of this macro is to produce a single DID, so in case DID is provided in the input
  // -- either in #stored or in ESDL -- this MACRO will necessarily bounced this DID back.
  FCRA.MAC_GetPickListRecords (ds_in, res_esdl);
  //------------------------------------------------------------------------------------

  rdid := res_esdl[1].Records[1].UniqueId;

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
  tempmod := MODULE(PROJECT(input_params,CriminalRecords_Services.IParam.search,OPT))
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    EXPORT STRING14 did := rdid;
    EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
  END;

  input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, TRUE, search_by);

  crim_all := CriminalRecords_Services.SearchService_Records.fcra_val(tempmod);
  crim_records_all := crim_all.Records;

  crim_records := CHOOSEN(crim_records_all,iesp.constants.CRIM.MaxSearchRecords);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(crim_records, results_pre, iesp.criminal_fcra.t_FcraCriminalSearchResponse);

  FFD.MAC.AppendConsumerAlertsAndStatements(results_pre, results, crim_all.Statements, crim_all.ConsumerAlerts, input_consumer, iesp.criminal_fcra.t_FcraCriminalSearchResponse);

  OUTPUT(results, NAMED('Results'), ALL);

ENDMACRO;

// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO--
  IDM Search(Identity Management) searches for perfect, precise or nice identities/DID to be used later by Quiz/IDM Report.
*/
IMPORT iesp;

EXPORT SearchService() := MACRO

  #CONSTANT('IncludeNonDMVSources', TRUE);
  #STORED('FuzzySecRange',AutoStandardI.Constants.SECRANGE.EXACT_OR_BLANK);

  // this is to disable "isAdvanced" branch in doxie\header_records_byDID, which creates a dependency on a standard search
  #constant ('RelativeFirstName1', '');
  #constant ('RelativeFirstName2', '');
  #constant ('OtherLastName1', '');
  #constant ('OtherState1', '');
  #constant ('OtherState2', '');
  #constant ('OtherCity1', '');

  // read input
  ds_in := DATASET([], iesp.identitymanagementsearch.t_IdentityManagementSearchRequest) : STORED('IdentityManagementSearchRequest',FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //==== CASE1: IF BEST MATCHING CONDITION(DID) PROVIDED IN INPUT. IGNORE ALL OTHER INPUTS ====//
  searchBy := IF(first_row.SearchBy.UniqueId <> '',
                PROJECT(first_row.SearchBy,TRANSFORM(iesp.identitymanagementsearch.t_IDMSearchBy,
                                                     SELF.UniqueId := LEFT.UniqueId, SELF := [])),
                first_row.SearchBy);

  SetLegacyInput (iesp.identitymanagementsearch.t_IDMSearchOption xml_in) := FUNCTION
    score := IF(xml_in.ScoreThreshold = 0, 15, xml_in.ScoreThreshold);
    #STORED('ScoreThreshold', score);
    RETURN iesp.ECL2ESP.EnforceRead();
  END;

  iesp.ECL2ESP.SetInputReportBy(PROJECT(searchBy, TRANSFORM(iesp.bpsreport.t_BpsReportBy, SELF := LEFT, SELF:=[]))); //Stored only for Penalty Calculation
  iesp.ECL2ESP.SetInputBaseRequest(first_row); //Stores input options
  SetLegacyInput (GLOBAL(first_row.options)); //Stores only score threshold as not supported by base request above.
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);

  uncleaned_input := IdentityManagement_Services.Functions.SetSearchBy(ds_in);

  m_search := module (IdentityManagement_Services.IParam._search)
    export boolean include_hri   := TRUE; //Always return HRI Indicators
    export boolean use_saltFetch := first_row.options.UseSALTLexIDFetch;
  end;
  header_recs := IdentityManagement_Services.search_records(uncleaned_input, m_search);

  idm_recs := PROJECT(header_recs,iesp.identitymanagementsearch.t_IDMSearchRecord)(UniqueId <> '');

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(idm_recs, results, iesp.identitymanagementsearch.t_IdentityManagementSearchResponse,
                                             Records, FALSE, RecordCount);

  OUTPUT(results,NAMED('Results'));
  OUTPUT(header_recs(UniqueId = '' AND errorcode <> 0),NAMED('Error_Codes'));

ENDMACRO;

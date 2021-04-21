// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Possible Incarceration Indicator.*/

IMPORT AutoStandardI, BatchShare, CriminalRecords_BatchService,ut;

EXPORT Possible_Incarceration_Indicator_Batch_Service() := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  gm := AutoStandardI.GlobalModule();
  BOOLEAN match_name := FALSE : STORED('Match_Name');
  BOOLEAN match_addr := FALSE : STORED('Match_Street_Address');
  BOOLEAN match_city := FALSE : STORED('Match_City');
  BOOLEAN match_state := FALSE : STORED('Match_State');
  BOOLEAN match_zip := FALSE : STORED('Match_Zip');
  BOOLEAN match_ssn := FALSE : STORED('Match_SSN');
  BOOLEAN Match_DOB := FALSE : STORED('Match_DOB');
  BOOLEAN Return_Doc_Name := FALSE : STORED('Return_DOC_Name');
  BOOLEAN Return_SSN := FALSE : STORED('Return_SSN');

  batch_params := BatchShare.IParam.getBatchParams();
  pii_batch_params := MODULE(PROJECT(batch_params, CriminalRecords_BatchService.IParam.batch_params, OPT))
    EXPORT MatchName := match_name;
    EXPORT MatchStrAddr := match_addr;
    EXPORT MatchCity := match_city;
    EXPORT MatchState := match_state;
    EXPORT MatchZip := match_zip;
    EXPORT MatchSSN := match_ssn;
    EXPORT MatchDOB := match_DOB;
    EXPORT ReturnDocName := Return_Doc_Name;
    EXPORT ReturnSSN := Return_SSN;
  END;

  ds_xml_in := DATASET([], CriminalRecords_BatchService.Layouts.batch_pii_in) : STORED('batch_in', FEW);

  // run input through some standard procedures
  BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
  BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);

  ds_batch_out := CriminalRecords_BatchService.Possible_Incarceration_Indicator_Batch_Service_Records(pii_batch_params, ds_batch_in).Records;

  // Restore original acctno.
  BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_batch_out, ds_batch_ready, FALSE);

  ut.mac_TrimFields(ds_batch_ready, 'ds_batch_ready', results);
  OUTPUT(results, NAMED('Results'));

ENDMACRO;

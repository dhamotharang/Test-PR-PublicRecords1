// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
EXPORT BatchService() := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT('useonlybestdid', TRUE);
 
  #WEBSERVICE(DESCRIPTION('This service pulls from the Criminal Offenders & 2 Offenses files.'));

  ds_xml_in := DATASET([], CriminalRecords_BatchService.Layouts.batch_in) : STORED('batch_in');
  
  crim_batch_params := CriminalRecords_BatchService.IParam.getBatchParams();
  
  // run input through some standard procedures
  BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
  BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);
  
  ds_batch_out := CriminalRecords_BatchService.BatchRecords(crim_batch_params, ds_batch_in);
  
  // Restore original acctno.
  BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_batch_out.Records, results, FALSE);
  
  ut.mac_TrimFields(results, 'results', result);
  
  OUTPUT(result, NAMED('RESULTS'), ALL);

ENDMACRO;

// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service pulls from the FCRA Criminal Offenders file.*/

EXPORT BatchServiceFCRA() := MACRO
  BOOLEAN isFCRA := TRUE;
  
  ds_xml_in := DATASET([], CriminalRecords_BatchService.Layouts.batch_in) : STORED('batch_in');

  batch_params := BatchShare.IParam.getBatchParams();
  crim_batch_params := MODULE(PROJECT(batch_params, CriminalRecords_BatchService.IParam.batch_params, OPT))
    EXPORT DATASET (Gateway.layouts.config) gateways := Gateway.Configuration.Get();
    UNSIGNED2 MaxResults_val := 50 : STORED('MaxResults');
    EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get();
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get();
  END;
  
  // run input through some standard procedures
  BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
  BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);
  
  // append DID (a soap call to Picklist service)
  BatchShare.MAC_AppendPicklistDID (ds_batch_in, ds_batch_did, crim_batch_params, IsFCRA);
  
  ds_batch_out_all := CriminalRecords_BatchService.BatchRecords(crim_batch_params, ds_batch_did, isFCRA);
  ds_batch_out := ds_batch_out_all.Records;
  statements := ds_batch_out_all.Statements;
  
  // Restore original acctno.
  BatchShare.MAC_RestoreAcctno(ds_batch_did, ds_batch_out, results);
  BatchShare.MAC_RestoreAcctno(ds_batch_did, statements, csdresults , FALSE, FALSE);
  
  ut.mac_TrimFields(results, 'results', result);
  
  OUTPUT(result, NAMED('RESULTS'), ALL);
  OUTPUT(csdresults, NAMED('CSDResults'), ALL);

ENDMACRO;

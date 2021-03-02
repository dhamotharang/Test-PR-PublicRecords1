// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- FCRA Incarceration Indicator.*/

IMPORT AutoStandardI, BatchShare, CriminalRecords_BatchService,ut;

EXPORT Possible_Incarceration_Indicator_Batch_ServiceFCRA() := MACRO
  BOOLEAN isFCRA := TRUE;

  ds_xml_in := DATASET([], CriminalRecords_BatchService.Layouts.batch_pii_in) : STORED('batch_in', FEW);
  BOOLEAN Return_Doc_Name := FALSE : STORED('Return_DOC_Name');
  BOOLEAN Return_SSN := FALSE : STORED('Return_SSN');

  gm := AutoStandardI.GlobalModule(isFCRA);
  batch_params := BatchShare.IParam.getBatchParams();
  pii_batch_params := MODULE(PROJECT(batch_params, CriminalRecords_BatchService.IParam.batch_params, OPT))
    EXPORT DATASET (Gateway.layouts.config) gateways := Gateway.Configuration.Get();
    EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get();
    EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get();
    EXPORT ReturnDocName := Return_Doc_Name;
    EXPORT ReturnSSN := Return_SSN;
  END;

  // run input through some standard procedures
  BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
  BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);


  // append DID (a soap call to Picklist service)
  BatchShare.MAC_AppendPicklistDID (ds_batch_in, ds_batch_did, pii_batch_params, IsFCRA);

  crim_out:= CriminalRecords_BatchService.Possible_Incarceration_Indicator_Batch_Service_Records(pii_batch_params, ds_batch_did, isFCRA);
  ds_batch_out := crim_out.Records;
  statements := crim_out.Statements;

  // Restore original acctno.
  BatchShare.MAC_RestoreAcctno(ds_batch_did, ds_batch_out, ds_batch_ready);
  BatchShare.MAC_RestoreAcctno(ds_batch_did, statements, statements_ready, FALSE, FALSE);

  ut.mac_TrimFields(ds_batch_ready, 'ds_batch_ready', results);

  OUTPUT(results, NAMED('Results'));
  OUTPUT(statements_ready, NAMED('CSDResults'));

ENDMACRO;

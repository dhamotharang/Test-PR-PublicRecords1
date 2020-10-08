/*--SOAP--
<message name="BatchService">
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="30"/>
</message>
*/

IMPORT BatchServices, BatchShare, GeoTriangulation_Services, Royalty, WSInput;

EXPORT BatchService := MACRO

	WSInput.MAC_GeoTriangulation_BatchService();

  CNST := BatchServices.AccuityBankData_Constants;

  in_mod := BatchShare.IParam.getBatchParams();

  BOOLEAN use_AccuityBankData := doxie.compliance.use_AccuityBankData(in_mod.DataPermissionMask);

  ds_batch_in := DATASET([],GeoTriangulation_Services.Layouts.rec_batch_in) : STORED('batch_in',FEW);

  BatchShare.MAC_SequenceInput(ds_batch_in ,ds_batch_seq);

  // Project the macro sequenced output ds onto the layout expected by GT_S.Records, due to syntax error
  ds_batch_in_seqlo := PROJECT(ds_batch_seq, GeoTriangulation_Services.Layouts.rec_batch_seq);

  // Call GT_S.Records to validate inputs, get IP_metadata and get Bank Routing data
  ds_batch_records := GeoTriangulation_Services.Records(ds_batch_in_seqlo);

  // Restore acctno from orig_acctno
  BatchShare.MAC_RestoreAcctno(ds_batch_seq, ds_batch_records, ds_batch_restored,,false);

  // Final project onto the GeoTriangulation batch output layout
  ds_batch_out := PROJECT(ds_batch_restored,
                          TRANSFORM(GeoTriangulation_Services.Layouts.rec_batch_out,
                            // 1 field needs directly assigned due to name difference on left ds layout vs output layout
                            SELF.edge_region := LEFT.ipm_edge_region; 
                            SELF := LEFT;  //rest of output fields have the same name as the input layout fields
                           ));

  // First determine the Accuity bank routing number royalties
  ds_royalties_br   := Royalty.RoyaltyAccuityBankData.GetBatchRoyaltiesByAcctno(ds_batch_records);
  ds_royalty_br_set := Royalty.GetBatchRoyalties(ds_royalties_br,FALSE); //FALSE=do not ReturnDetailedRoyalties
  
  // Next determine the Digital Envoy NetAcuity ip_metadata royalties for each acctno/ip_address
  ds_royalties_ip   := Royalty.RoyaltyNetAcuityIpMetadata.GetBatchRoyaltiesByAcctno(ds_batch_records);
  ds_royalty_ip_set := Royalty.GetBatchRoyalties(ds_royalties_ip,FALSE); //FALSE=do not ReturnDetailedRoyalties

  // Combine the 2 individual royalty sets for just 1 standard output 'RoyaltySet' ds
  ds_royalty_set := ds_royalty_br_set + ds_royalty_ip_set;

  IF(NOT use_AccuityBankData,FAIL(CNST.ErrCode.CONFIG_ERR, CNST.ErrMsg.CONFIG_ERR));

  // Debug Outputs, un-comment as needed for testing
  //OUTPUT(ds_batch_in,            NAMED('ds_batch_in'));
  //OUTPUT(ds_batch_seq,           NAMED('ds_batch_seq'));
  //OUTPUT(ds_batch_in_seqlo,      NAMED('ds_batch_in_seqlo'));
  //OUTPUT(ds_batch_records,       NAMED('ds_batch_records'));
  //OUTPUT(ds_batch_restored,      NAMED('ds_batch_restored'));
  //OUTPUT(ds_batch_out,           NAMED('ds_batch_out'));
  //OUTPUT(ds_royalties_br,        NAMED('ds_royalties_br'));
  //OUTPUT(ds_royalty_br_set,      NAMED('ds_royalty_br_set'));
  //OUTPUT(ds_royalties_ip,        NAMED('ds_royalties_ip'));
  //OUTPUT(ds_royalty_ip_set,      NAMED('ds_royalty_ip_set'));
  //OUTPUT(ds_royalty_set,         NAMED('ds_royalty_set'));

  OUTPUT(ds_batch_out,   NAMED('Results'));
  OUTPUT(ds_royalty_set, NAMED('RoyaltySet'));

ENDMACRO;

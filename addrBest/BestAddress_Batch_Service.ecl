// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO--
    This service returns best address.
*/

export BestAddress_Batch_Service := macro
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT('TwoPartySearch', FALSE);
  #constant('OnlyReturnSuccessfullyCleanedAddresses',true);

  ds_raw := dataset([],AddrBest.Layout_BestAddr.Batch_in) : stored('batch_in',few);

  BatchShare.MAC_SequenceInput(ds_raw, ds_xml_in_seq);
  BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_input);

  input_mod := AddrBest.Iparams.DefaultParams;
  pre_out_recs := AddrBest.Records(ds_input, input_mod).best_records;

  BatchShare.MAC_RestoreAcctno(ds_input, pre_out_recs, out_recs,,false);

  output(out_recs, named('Results'));
endmacro;

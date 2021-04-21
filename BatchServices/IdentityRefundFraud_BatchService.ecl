// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT AutoheaderV2, BatchServices, BatchShare, doxie, Royalty, ut, WSInput;

EXPORT IdentityRefundFraud_BatchService := MACRO
  #CONSTANT('penaltthreshold','10');
  #CONSTANT('SearchLibraryVersion',AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT('TwoPartySearch', FALSE);

  WSInput.MAC_TaxRefundISv3_BatchService();

  rec_layout_in := BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in;
  ds_batch := DATASET([],rec_layout_in) : STORED('TaxRefund_batch_in');
  BatchShare.MAC_SequenceInput(ds_batch, ds_sequenced);
  BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);

  STRING filter_rule := '' : STORED('FilterRule');
  BOOLEAN isv3fdn := STD.Str.ToUpperCase(filter_rule) = BatchServices.Constants.TRISv31_FDN.V3FDN_FILTER;
  rc := BatchServices.TaxRefundISv3_BatchService_Functions.ProcessHRICodes(isv3fdn);

  doxie.MAC_Header_Field_Declare();
  mod_access := doxie.compliance.GetGlobalDataAccessModule();
  mod_args := MODULE(PROJECT(mod_access, BatchServices.TaxRefundISv3_BatchService_Interfaces.Input, OPT))
    // common input options
    EXPORT BOOLEAN   IncludeBlankDOD    := FALSE : STORED('IncludeBlankDOD');
    EXPORT BOOLEAN   PhoneticMatch      := phonetics;
    EXPORT BOOLEAN   AllowNickNames     := nicknames;
    // Specific, v2 & v3 shared input options
    EXPORT STRING120 append_l           := 'BEST_ALL, BEST_EDA'; //Append allows all Best Info to return
    EXPORT STRING120 verify_l           := 'BEST_ALL';
    EXPORT STRING2   input_state        := '' : STORED('InputState');
    EXPORT STRING20  ModelName          := '' : STORED('ModelName');
    EXPORT STRING30  FilterRule         := filter_rule;
    EXPORT BOOLEAN   GetSSNBest         := TRUE : STORED('GetSSNBest');
    // Specific, new v3 only input options
    EXPORT STRING3   ScoreCut           := '' : STORED('ScoreCut'); // 0 - 999 are valid values
    EXPORT UNSIGNED2 DIDScoreThreshold  := 0  : STORED('DIDScoreThreshold'); // 0 - 100 are valid values. default=80 in KTR Layouts xls "Input Options" tab???
    EXPORT STRING30  Creditor           := '' : STORED('Creditor'); // text, i.e. State of Georgia
    EXPORT UNSIGNED3 RefundThreshold    := 0  : STORED('RefundThreshold'); // 0 - 9999999 are valid values
    //  FDN
    EXPORT BOOLEAN   IncludeDependantID := FALSE : STORED('IncludeDependantID');
    EXPORT INTEGER   IPAddrExceedsRange := 100 : STORED('IPAddrExceedsRange');
    EXPORT UNSIGNED6 GlobalCompanyId    := 0 : STORED('GlobalCompanyId');
    EXPORT UNSIGNED2 IndustryType       := 0 : STORED('IndustryType');
    EXPORT UNSIGNED6 ProductCode        := 0 : STORED('ProductCode');
    // HRI codes externalized
    EXPORT STRING   AddressRiskHRICodes  := rc.AddressRiskHRICodes;
    EXPORT STRING   IdentityRiskHRICodes := rc.IdentityRiskHRICodes;
    EXPORT STRING   ReportOnlyHRICodes   := rc.ReportOnlyHRICodes;
    EXPORT STRING   AllHRICodes          := rc.AllHRICodes;
  END;

  // Check GlobalCompanyId, IndustryType and ProductCode have values for FDN
  IF(isv3fdn AND mod_args.GlobalCompanyId = 0,
    FAIL(ut.constants_MessageCodes.FDN_GC_ID,
    ut.MapMessageCodes(ut.constants_MessageCodes.FDN_GC_ID)));

  IF(isv3fdn AND mod_args.IndustryType = 0,
    FAIL(ut.constants_MessageCodes.FDN_INDUSTRY_TYPE,
    ut.MapMessageCodes(ut.constants_MessageCodes.FDN_INDUSTRY_TYPE)));

  IF(isv3fdn AND mod_args.ProductCode = 0,
    FAIL(ut.constants_MessageCodes.FDN_PRODUCT_CODE,
    ut.MapMessageCodes(ut.constants_MessageCodes.FDN_PRODUCT_CODE)));

  // BATCH OUTPUT
  Results_temp := BatchServices.TaxRefundISv3_BatchService_Records(ds_batch_in, mod_args);
  BatchShare.MAC_RestoreAcctno(ds_batch_in, Results_temp, ds_output,,FALSE);
  ds_results := PROJECT(ds_output, BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_out AND NOT [royalty_nag,fdn_count]);
  ut.mac_TrimFields(ds_results, 'ds_results', Results);

  // ROYALTIES
  BOOLEAN ReturnDetailedRoyalties := FALSE : STORED('ReturnDetailedRoyalties');
  dRoyaltiesByAcctno_FDN := Royalty.RoyaltyFDNCoRR.GetBatchRoyaltiesByAcctno(Results_temp,fdn_count);
  dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno_FDN, ReturnDetailedRoyalties) ;
  Royalty.MAC_RestoreAcctno(ds_batch_in, dRoyalties, royalties);

  OUTPUT(royalties,NAMED('RoyaltySet'));
  OUTPUT(Results,NAMED('Results'));

ENDMACRO;

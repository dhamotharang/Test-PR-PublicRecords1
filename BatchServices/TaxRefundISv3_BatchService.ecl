// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO--
           This service processes the input through Deceased, Criminal, ADL Best, Best
           Address and SSN Issuance batch services to fill in the appropriate output fields.
           Additonally when needed applicable (input person info is deceased),
           it uses Bankruptcy, Driver's License, Liens, MVRs, Property(deeds only) and
           Voters batch services to fill in certain output fields.
           The search requires a minimum input of last name,
           first name or middle name or initial, SSN, and Street Address 1, City and
           State, or Zip.  req 4.1.2
*/

IMPORT AutoheaderV2, BatchServices, BatchShare, doxie, Gateway, Royalty, ut, WSInput;


EXPORT TaxRefundISv3_BatchService := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT('TwoPartySearch', FALSE);

  //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_TaxRefundISv3_BatchService();

  #constant('penaltthreshold','10');

  rec_layout_in := BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in;

  ds_batch := dataset([], rec_layout_in) : stored('TaxRefund_batch_in');

  gateways_in := Gateway.Configuration.Get();

  doxie.MAC_Header_Field_Declare();

  BatchShare.MAC_SequenceInput(ds_batch, ds_sequenced);
  BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);

  mod_access := doxie.compliance.GetGlobalDataAccessModule();

  string filter_rule := '' : stored('FilterRule');
  boolean isv3fdn := STD.Str.ToUpperCase(filter_rule) = 'V3FDN_FILTER';
  rc := BatchServices.TaxRefundISv3_BatchService_Functions.ProcessHRICodes(isv3fdn);

  mod_args := MODULE (PROJECT (mod_access, BatchServices.TaxRefundISv3_BatchService_Interfaces.Input, OPT))
    // common input options
    EXPORT boolean   IncludeBlankDOD    := 0 : stored('IncludeBlankDOD');
    EXPORT boolean   PhoneticMatch       := phonetics;
    EXPORT boolean   AllowNickNames      := nicknames;
    // TRIS specific, v2 & v3 shared input options
    EXPORT string120 append_l           := 'BEST_ALL, BEST_EDA'; //Append allows all Best Info to return
    EXPORT string120 verify_l           := 'BEST_ALL';
    EXPORT string2   input_state        := '' : stored('InputState');
    EXPORT string20  ModelName          := '' : stored('ModelName');
    EXPORT string30  FilterRule         := filter_rule;
    EXPORT boolean   GetSSNBest         := TRUE : stored('GetSSNBest');
    // TRIS specific, new v3 only input options ---v
    EXPORT string3   ScoreCut           := '' : stored('ScoreCut'); // 0 - 999 are valid values
    EXPORT unsigned2 DIDScoreThreshold  := 0 : stored('DIDScoreThreshold'); // 0 - 100 are valid values. default=80 in TRIS KTR Layouts xls "Input Options" tab???
    EXPORT string30  Creditor           := '' : stored('Creditor'); // text, i.e. State of Georgia
    EXPORT unsigned3 RefundThreshold    := 0 : stored('RefundThreshold'); // 0 - 9999999 are valid values
    // TRIS v3.2 Enhancement: IncludeIPAddrGW & IncludeDebtEvasion are no longer to be used.
    // EXPORT boolean   IncludeIPAddrGW        := true : stored('IncludeIPAddrGW'); // default to true
    // EXPORT boolean   IncludeDebtEvasion   := true : stored('IncludeDebtEvasion'); // default to false

    // TRIS V3.1 with fdn
    EXPORT boolean   IncludeDependantID    := false : stored('IncludeDependantID');
    EXPORT integer   IPAddrExceedsRange   := 100 : stored('IPAddrExceedsRange');
    EXPORT unsigned6 GlobalCompanyId      := 0 : stored('GlobalCompanyId');
    EXPORT unsigned2 IndustryType          := 0 : stored('IndustryType');
    EXPORT unsigned6 ProductCode          := 0 : stored('ProductCode');

    // HRI codes externalized
    EXPORT string   AddressRiskHRICodes  := rc.AddressRiskHRICodes;
    EXPORT string   IdentityRiskHRICodes := rc.IdentityRiskHRICodes;
    EXPORT string   ReportOnlyHRICodes   := rc.ReportOnlyHRICodes;
    EXPORT string   AllHRICodes          := rc.AllHRICodes;
  END;

  gc_id        := mod_args.GlobalCompanyId;
  ind_type     := mod_args.IndustryType;
  product_code := mod_args.ProductCode;

  //Checking that gc_id, industry type, and product code have some values for fdn data.
  IF(isv3fdn and gc_id = 0,
            FAIL(ut.constants_MessageCodes.FDN_GC_ID,
            ut.MapMessageCodes(ut.constants_MessageCodes.FDN_GC_ID)));

  IF(isv3fdn and ind_type = 0,
            FAIL(ut.constants_MessageCodes.FDN_INDUSTRY_TYPE,
            ut.MapMessageCodes(ut.constants_MessageCodes.FDN_INDUSTRY_TYPE)));

  IF(isv3fdn and product_code = 0,
            FAIL(ut.constants_MessageCodes.FDN_PRODUCT_CODE,
            ut.MapMessageCodes(ut.constants_MessageCodes.FDN_PRODUCT_CODE)));

  Results_temp := BatchServices.TaxRefundISv3_BatchService_Records(ds_batch_in, mod_args);

  // ****TRIS v3.2 Enhancement: Req 3.1.3.14 Since NetAcutiy gateway call is removed from query, royalty calculation is not needed....
  // ****....However completely removing it may causes issues at ESP end, so projecting dRoyalties below to blank dataset

  // dIPIn := PROJECT(ds_batch_in, TRANSFORM(Royalty.RoyaltyNetAcuity.IPData,
                                  // SELF.AcctNo := LEFT.AcctNo;
                                  // SELF.IPAddr := LEFT.IP_Address));

  BOOLEAN  ReturnDetailedRoyalties := false : STORED('ReturnDetailedRoyalties');

  dRoyaltiesByAcctno_FDN   := Royalty.RoyaltyFDNCoRR.GetBatchRoyaltiesByAcctno(Results_temp,fdn_count);
  // dRoyaltiesByAcctno  := Royalty.RoyaltyNetAcuity.GetBatchRoyaltiesByAcctno(gateways_in, dIPIn, Results_temp, TRUE);
  dRoyalties  := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno_FDN, ReturnDetailedRoyalties) ;

  BatchShare.MAC_RestoreAcctno(ds_batch_in,Results_temp,ds_output,,false);
  Royalty.MAC_RestoreAcctno(ds_batch_in,dRoyalties, royalties);

  ds_results := PROJECT(ds_output, BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_out AND NOT [royalty_nag,fdn_count]);

  ut.mac_TrimFields(ds_results, 'ds_results', Results);

  OUTPUT(royalties,NAMED('RoyaltySet'));
  OUTPUT(Results,NAMED('Results'));

ENDMACRO;

IMPORT ffd;
EXPORT layout_ucc_rollup := RECORD
  UNSIGNED2 penalt;
  uccv2_services.layout_ucc_filing;
  UCCv2_Services.assorted_layouts.matched_party_rec matched_party;
  DATASET(uccv2_services.layout_ucc_hist) filings{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_FILINGS)};
  DATASET(uccv2_services.layout_ucc_party) debtors{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_DEBTORS)};
  DATASET(uccv2_services.layout_ucc_party) secureds{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_SECUREDS)};
  DATASET(uccv2_services.layout_ucc_party) assignees{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_ASSIGNEES)};
  DATASET(uccv2_services.layout_ucc_party) creditors{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_CREDITORS)};
  DATASET(uccv2_services.layout_ucc_signer) signers{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_SIGNERS)};
  DATASET(uccv2_services.layout_ucc_filofc) filing_offices{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES)};
  DATASET(uccv2_services.layout_ucc_coll) collateral{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_COLLATERAL)};
  BOOLEAN isDeepDive := FALSE;
  FFD.Layouts.CommonRawRecordElements;
END;

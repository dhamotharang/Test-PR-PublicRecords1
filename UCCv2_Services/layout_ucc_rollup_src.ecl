
IMPORT UCCV2;

EXPORT layout_ucc_rollup_src := RECORD
  UNSIGNED2 penalt;
  uccv2_services.layout_ucc_filing_src;
  DATASET(uccv2_services.layout_ucc_hist_src) filings{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_FILINGS)};
  DATASET(uccv2_services.layout_ucc_party_src) debtors{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_DEBTORS)};
  DATASET(uccv2_services.layout_ucc_party_src) secureds{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_SECUREDS)};
  DATASET(uccv2_services.layout_ucc_party_src) assignees{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_ASSIGNEES)};
  DATASET(uccv2_services.layout_ucc_party_src) creditors{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_CREDITORS)};
  DATASET(uccv2_services.layout_ucc_signer) signers{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_SIGNERS)};
  DATASET(uccv2_services.layout_ucc_filofc) filing_offices{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_FILING_OFFICES)};
  DATASET(uccv2_services.layout_ucc_coll_src) collateral{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_COLLATERAL)};
END;

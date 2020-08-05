IMPORT uccv2;

k_main := uccv2.layout_UCC_common.layout_ucc_new;

EXPORT layout_ucc_hist := RECORD
  k_main.rmsid;
  k_main.filing_number;
  k_main.filing_type;
  k_main.filing_date;
  k_main.filing_status;
  k_main.status_type;
  k_main.page;
  k_main.expiration_date;
  k_main.contract_type;
  k_main.amount;
  k_main.irs_serial_number;
  k_main.effective_date;
  DATASET(uccv2_services.layout_ucc_hist_parties) filing_parties{MAXCOUNT(UCCv2_Services.Constants.MAXCOUNT_FILING_PARTIES)};
END;

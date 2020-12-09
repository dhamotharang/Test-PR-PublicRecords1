IMPORT BatchShare;
EXPORT layout_liens_history_extended := RECORD
  TYPEOF(BatchShare.Layouts.ShareAcct.acctno) acctno := '';
  STRING50 tmsid;
  STRING case_link_id := '';
  UNSIGNED case_link_priority := 0;
  DATASET(LiensV2_Services.layout_lien_history_w_bcb) filings{MAXCOUNT(15)};
END;


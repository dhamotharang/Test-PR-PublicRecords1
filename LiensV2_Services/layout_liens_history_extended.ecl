import BatchShare;
export layout_liens_history_extended := RECORD
	typeof(BatchShare.Layouts.ShareAcct.acctno) acctno := '';
  string50 tmsid;
	dataset(LiensV2_Services.layout_lien_history_w_bcb) filings{maxcount(15)};
end;


IMPORT liensv2, BIPV2, FFD, BatchShare;

EXPORT layout_lien_party_raw := RECORD
  liensv2.Layout_liens_party;
  BIPV2.IDlayouts.l_header_ids;
  TYPEOF(BatchShare.Layouts.ShareAcct.acctno) acctno := '';
  BOOLEAN hasCriminalConviction;
  BOOLEAN isSexualOffender;
  DATASET(FFD.Layouts.StatementIdRec) StatementIds := DATASET([],FFD.Layouts.StatementIdRec);
  BOOLEAN isDisputed := FALSE;
END;

import liensv2, BIPV2, FFD, BatchShare;

export layout_lien_party_raw := record
  liensv2.Layout_liens_party;
	BIPV2.IDlayouts.l_header_ids;
  typeof(BatchShare.Layouts.ShareAcct.acctno) acctno := '';
  boolean hasCriminalConviction;
  boolean isSexualOffender;
	dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
	boolean isDisputed := false;
end;
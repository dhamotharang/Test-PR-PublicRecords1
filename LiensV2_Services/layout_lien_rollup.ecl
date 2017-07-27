
IMPORT BIPV2, LiensV2;

export layout_lien_rollup := record
	unsigned2 penalt := 0;
	LiensV2_Services.assorted_layouts.matched_party_rec matched_party;
	liensv2_services.layout_lien_case;
	dataset(liensv2_services.layout_lien_party) debtors{maxcount(LiensV2.Constants.MAXCOUNT_PARTIES)};
	dataset(liensv2_services.layout_lien_party) creditors{maxcount(LiensV2.Constants.MAXCOUNT_PARTIES)};
	dataset(liensv2_services.layout_lien_party) attorneys{maxcount(LiensV2.Constants.MAXCOUNT_PARTIES)};
	dataset(liensv2_services.layout_lien_party) thds{maxcount(LiensV2.Constants.MAXCOUNT_PARTIES)};
	dataset(liensv2_services.layout_lien_history) filings{maxcount(LiensV2.Constants.MAXCOUNT_FILINGS)};
	string30 acctno := '';
	boolean isDeepDive := false;
  BIPV2.IDlayouts.l_key_ids_bare;
end;


IMPORT BIPV2, LiensV2;

EXPORT layout_lien_rollup := RECORD
  UNSIGNED2 penalt := 0;
  LiensV2_Services.assorted_layouts.matched_party_rec matched_party;
  liensv2_services.layout_lien_case;
  DATASET(liensv2_services.layout_lien_party) debtors{MAXCOUNT(LiensV2.Constants.MAXCOUNT_PARTIES)};
  DATASET(liensv2_services.layout_lien_party) creditors{MAXCOUNT(LiensV2.Constants.MAXCOUNT_PARTIES)};
  DATASET(liensv2_services.layout_lien_party) attorneys{MAXCOUNT(LiensV2.Constants.MAXCOUNT_PARTIES)};
  DATASET(liensv2_services.layout_lien_party) thds{MAXCOUNT(LiensV2.Constants.MAXCOUNT_PARTIES)};
  DATASET(liensv2_services.layout_lien_history) filings{MAXCOUNT(LiensV2.Constants.MAXCOUNT_FILINGS)};
  STRING30 acctno := '';
  BOOLEAN isDeepDive := FALSE;
  BIPV2.IDlayouts.l_key_ids_bare;
END;

IMPORT STD;

doxie_cbrs.mac_Selection_Declare();

EXPORT registered_agents_records_raw_v2(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

ra_recs := doxie_cbrs.Corporation_Filings_records_v2(bdids).source_view(Max_CorporationFilings_val)(EXISTS(corp_hist(corp_ra_name <> '' AND corp_ra_address_line1 <> '')));

filtered_ra_recs := ra_recs(
  EXISTS(corp_hist(
    STD.STR.Find(corp_ra_name, 'RESIGNED', 1) < 1 AND
    STD.STR.Find(corp_ra_name, 'REVOKED', 1) < 1 AND
    STD.STR.Find(corp_ra_name, 'WITHDREW', 1) < 1 AND
    STD.STR.Find(corp_ra_name, 'OF STATE', 1) < 1 AND
    STD.STR.Find(corp_ra_name, 'ADDRESS FOR', 1) < 1
    )
  ));

              
RETURN SORT(DEDUP(filtered_ra_recs,ALL),corp_state_origin);
END;

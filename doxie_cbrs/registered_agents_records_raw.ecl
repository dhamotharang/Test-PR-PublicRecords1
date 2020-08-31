IMPORT STD;
EXPORT registered_agents_records_raw(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

ra_recs := doxie_cbrs.Corporation_Filings_records(bdids)(corp_ra_name <> '' AND corp_ra_address_line1 <> '');

filtered_ra_recs := ra_recs(
  STD.STR.Find(corp_ra_name, 'RESIGNED', 1) < 1 AND
  STD.STR.Find(corp_ra_name, 'REVOKED', 1) < 1 AND
  STD.STR.Find(corp_ra_name, 'WITHDREW', 1) < 1 AND
  STD.STR.Find(corp_ra_name, 'OF STATE', 1) < 1 AND
  STD.STR.Find(corp_ra_name, 'ADDRESS FOR', 1) < 1);

              
RETURN SORT(DEDUP(filtered_ra_recs,ALL),corp_state_origin);
END;

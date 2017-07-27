export registered_agents_records_raw(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

ra_recs := doxie_cbrs.Corporation_Filings_records(bdids)(corp_ra_name <> '' and corp_ra_address_line1 <> '');

filtered_ra_recs := ra_recs(Stringlib.Stringfind(corp_ra_name, 'RESIGNED', 1) < 1 and
							Stringlib.Stringfind(corp_ra_name, 'REVOKED', 1) < 1 and
							Stringlib.Stringfind(corp_ra_name, 'WITHDREW', 1) < 1 and
							stringlib.stringfind(corp_ra_name, 'OF STATE', 1) < 1 and
							stringlib.stringfind(corp_ra_name, 'ADDRESS FOR', 1) < 1);

							
return sort(dedup(filtered_ra_recs,ALL),corp_state_origin);
END;
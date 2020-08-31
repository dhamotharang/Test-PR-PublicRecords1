IMPORT business_header,doxie,ut;
doxie_cbrs.mac_Selection_Declare()

EXPORT others_at_address_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

bestrecs := doxie_cbrs.best_rest(bdids)(isOAA);

//slim it down and drop some dups
outrec := RECORD
  bestrecs.bdid;
  bestrecs.company_name;
  bestrecs.phone;
  bestrecs.dt_last_seen;
  BOOLEAN hasBBB := FALSE;
  BOOLEAN hasBBB_NM := FALSE;
  STRING120 BBB_http_link := '';
END;

slm := table(bestrecs, outrec);
doxie_cbrs.mac_hasBBB(slm, slmb, bdids)
srt := SORT(slmb, company_name, -phone, bdid);
ddp := DEDUP(srt, company_name, phone, bdid);

RETURN ddp;
END;

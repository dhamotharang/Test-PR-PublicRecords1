IMPORT doxie, business_header;
doxie_cbrs.mac_Selection_Declare()

EXPORT best_address_full(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  thebest := doxie_cbrs.best_records_bdids(bdids);

  best_rec := RECORD
    doxie.layout_addressSearch;
    thebest.company_name;
  END;

  best_rec prep(thebest l) := TRANSFORM
    SELF.seq := 0;
    SELF.zip := (STRING5)l.zip;
    SELF := l;
  END;

  RETURN DEDUP(PROJECT(thebest, prep(LEFT)),ALL);
END;

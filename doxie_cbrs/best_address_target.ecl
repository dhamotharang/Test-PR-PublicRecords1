IMPORT doxie, doxie_cbrs;

EXPORT best_address_target(DATASET(doxie_cbrs.layout_references) bdids,
                           doxie.IDataAccess mod_access
                          ) := FUNCTION

  thebest := doxie_cbrs.best_records_prs_target(bdids,mod_access);

  doxie.layout_addressSearch prep(thebest l) := TRANSFORM
    SELF.seq := 0;
    SELF.zip := (STRING5)l.zip;
    SELF := l;
  END;

  RETURN PROJECT(thebest, prep(LEFT));
END;

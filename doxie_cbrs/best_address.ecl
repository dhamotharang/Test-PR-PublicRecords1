IMPORT doxie;
thebest := doxie_cbrs.best_records;

doxie.layout_addressSearch prep(thebest l) := TRANSFORM
  SELF.seq := 0;
  SELF.zip := (STRING5)l.zip;
  SELF := l;
END;

EXPORT best_address := DEDUP(PROJECT(thebest, prep(LEFT)),ALL);

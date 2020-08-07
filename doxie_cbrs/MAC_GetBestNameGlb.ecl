EXPORT MAC_GetBestNameGlb(outfile, infile, key) := MACRO
  #uniquename(tra)
  TYPEOF(infile) %tra%(infile l, RECORDOF(key) r) := TRANSFORM
    isbest := r.fname <> '';
    SELF.title := IF(isbest, r.title, l.title);
    SELF.fname := IF(isbest, r.fname, l.fname);
    SELF.mname := IF(isbest, r.mname, l.mname);
    SELF.lname := IF(isbest, r.lname, l.lname);
    SELF.name_suffix := IF(isbest, r.name_suffix, l.name_suffix);
    SELF := l;
  END;

  outfile := JOIN(infile,key,
    LEFT.did > 0 AND
    KEYED(LEFT.did = RIGHT.did) AND
    RIGHT.fname <> '' AND RIGHT.lname <> '',
    %tra%(LEFT, RIGHT), LEFT OUTER, KEEP(1));
ENDMACRO;

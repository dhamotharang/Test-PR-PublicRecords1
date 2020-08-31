IMPORT doxie, doxie_cbrs, ut;

EXPORT reverse_lookup_records_prs(DATASET(doxie_cbrs.layout_references) bdids,
                                  doxie.IDataAccess mod_access,
                                  BOOLEAN Include_ReversePhone,
                                  UNSIGNED3 Max_ReverseLookup
                                  ) := FUNCTION
                                  
rlr := doxie_cbrs.reverse_lookup_records(bdids,mod_access,Include_ReversePhone);

baserec := RECORD
  STRING10 phone10;
  STRING10 prim_range;
  STRING2 predir;
  STRING28 prim_name;
  STRING4 suffix;
  STRING2 postdir;
  STRING10 unit_desig;
  STRING8 sec_range;
  STRING25 p_city_name;
  STRING2 v_predir;
  STRING28 v_prim_name;
  STRING4 v_suffix;
  STRING2 v_postdir;
  STRING25 v_city_name;
  STRING2 st;
  STRING5 z5;
  STRING4 z4;
END;
INTEGER ml := 40000;
lnrec := RECORD, MAXLENGTH(ml)
  rlr.level;
  STRING120 listed_name;
END;


rec := RECORD, MAXLENGTH(ml)
  baserec;
  DATASET(lnrec) listed_name_children;
  UNSIGNED3 cumulative_count := 0;
  BOOLEAN past_max := FALSE;
END;

cdrec := RECORD, MAXLENGTH(ml)
  rec;
  lnrec;
END;

//**** initial slimming
cdrec slim(rlr l) := TRANSFORM
  SELF.listed_name_children := DATASET([{l.level,l.listed_name}], lnrec);
  SELF := l;
END;

slm := PROJECT(rlr, slim(LEFT));

//**** limit our numbers
lmt := CHOOSEN(SORT(slm, level, phone10, listed_name), Max_ReverseLookup * 2);

//***** rollup the names
srt := SORT(lmt, phone10, prim_range, prim_name, sec_range, z5, listed_name);

cdrec rollem(cdrec l, cdrec r) := TRANSFORM
  SELF.listed_name_children := l.listed_name_children + r.listed_name_children;
  SELF.level := IF(r.phone10 <> '' AND r.level < l.level, r.level, l.level);
  SELF:= l;
END;

rld := ROLLUP(srt, rollem(LEFT, RIGHT), phone10, prim_range, prim_name, sec_range, z5);

//***** sort for display
srt2 := SORT(rld, level, -COUNT(listed_name_children), phone10, prim_range, prim_name, sec_range, phone10);

//***** get rid of dups by clean name and slim a tiny bit
rec dedupit(cdrec l) := TRANSFORM
  SELF.listed_name_children := DEDUP(l.listed_name_children, (ut.CleanCompany(listed_name))[1..40]);
  SELF := l;
END;

ddp := PROJECT(srt2, dedupit(LEFT));

//***** try out a cum. count
rec iter(rec l, rec r) := TRANSFORM
  SELF.cumulative_count := l.cumulative_count + COUNT(r.listed_name_children);
  SELF.past_max := l.cumulative_count >= Max_ReverseLookup;
  SELF := r;
END;

itr := ITERATE(ddp, iter(LEFT, RIGHT));
RETURN itr;
END;

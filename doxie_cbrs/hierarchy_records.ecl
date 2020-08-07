IMPORT business_header,doxie;
doxie.mac_header_field_Declare()
d := doxie_cbrs.dca_hierarchy_prs;
i := doxie_cbrs.infousa_hierarchy_prs;

inf := IF(COUNT(d) > COUNT(i), d, i);

outrec := RECORD
  inf.level;
  doxie_cbrs.Layout_BH_Best_String;
END;

besrec := RECORD
  inf.name;
  outrec;
END;

//get best info
doxie_cbrs.mac_best_records(inf, bes, besrec, TRUE)
s := SORT(bes, level);

//patch name
outrec form(s l) := TRANSFORM
  SELF.company_name := IF(l.company_name = '', l.name, l.company_name);
  SELF.level := 0; //blank out and reseed below
  SELF := l;
END;

namepatch := PROJECT(s, form(LEFT));

//use a level indicator
outrec iter(outrec l, outrec r) := TRANSFORM
  SELF.level := l.level + 1;
  SELF := r;
END;

EXPORT hierarchy_records := ITERATE(namepatch, iter(LEFT, RIGHT));

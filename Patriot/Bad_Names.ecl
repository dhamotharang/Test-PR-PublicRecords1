p := File_Patriot;

r := record
  unsigned1 one := 1;
  p.fname;
  p.mname;
  p.lname;
  end;

t := dedup(table(p(fname<>'',lname<>''),r),fname,lname,mname,all);

export Bad_Names := t : persist('Patriot_BadNames');
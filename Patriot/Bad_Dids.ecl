import header,ut;

h := header.file_headers;

hr := record
  unsigned1 one := 1;
  h.did;
  h.fname;
  h.lname;
  h.mname;
  end;

ht := dedup(table(h,hr),did,fname,lname,mname,all);

di := record
  unsigned6 did;
  unsigned8 zero := 0;
  end;

di take_did(hr le) := transform
  self := le;
  end;

br := join(ht,File_ScoredNames(score<3),left.fname=right.fname and left.mname=right.mname and
                  left.lname=right.lname,take_did(left),hash);

export Bad_Dids := dedup(br,did,all) : persist('Patriot_Bad_Dids');
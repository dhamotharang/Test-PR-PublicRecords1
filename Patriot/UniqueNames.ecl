import header,ut;

h := header.file_headers;

hr := record
  string20 fname := h.fname;
  string20 lname := h.lname;
  string20 mname := h.mname;
  end;

ht := dedup(table(h,hr),fname,lname,mname,all);

export UniqueNames := ht : persist('DBTEMP::UniqueNames');
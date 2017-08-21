hea_stub := record
string10      phone;
string9      ssn;
string20      fname;
string1      minit;
string20      lname;
string10      prim_range;
string28      prim_name;
string10      unit_desig;
string8      sec_range;
string25      city_name;
string2      st;
string5      zip;
string4      zip4;
  end;

hea_stub tra(FL_Headers l) := transform
  self := l;
  end;

pb := project(File_flheaders,tra(left));

ps := sort(pb,lname,prim_range,zip,prim_name,fname,ssn);

p := dedup(ps,lname,prim_range,zip,prim_name,fname,ssn);

Layout_Extra tra1(layout_joined l, hea_stub r) := transform
  self.old_ssn := r.ssn;
  self.new_ssn := '';
  self := l;
  end;

Layout_Extra tra2(layout_extra l, hea_stub r) := transform
  self.new_ssn := r.ssn;
  self := l;
  end;

j1 := join(file_annotated,p,left.name1_last=right.lname and
                         left.prim_range=right.prim_range and
                         left.z5 = right.zip and
                         left.prim_name = right.prim_name and
                         left.name1_first = right.fname,tra1(left,right),left outer);


j2 := join(j1,p,left.new_name1_last=right.lname and
                         left.new_prim_range=right.prim_range and
                         left.new_z5 = right.zip and
                         left.new_prim_name = right.prim_name and
                         left.new_name1_first = right.fname,tra2(left,right),left outer);

hea_stub := record
string10      phone;
string9      ssn;
string20      fname;
string1      minit;
string20      lname;
string10      prim_range;
string28      prim_name;
string10      unit_desig;
string8      sec_range;
string25      city_name;
string2      st;
string5      zip;
string4      zip4;
  end;

hea_stub tra(FL_Headers l) := transform
  self := l;
  end;

pb := project(File_flheaders,tra(left));

ps := sort(pb,lname,prim_range,zip,prim_name,fname,ssn);

p := dedup(ps,lname,prim_range,zip,prim_name,fname,ssn);

Layout_Extra tra1(layout_joined l, hea_stub r) := transform
  self.old_ssn := r.ssn;
  self.new_ssn := '';
  self := l;
  end;

Layout_Extra tra2(layout_extra l, hea_stub r) := transform
  self.new_ssn := r.ssn;
  self := l;
  end;

j1 := join(file_annotated,p,left.name1_last=right.lname and
                         left.prim_range=right.prim_range and
                         left.z5 = right.zip and
                         left.prim_name = right.prim_name and
                         left.name1_first = right.fname,tra1(left,right),left outer);


j2 := join(j1,p,left.new_name1_last=right.lname and
                         left.new_prim_range=right.prim_range and
                         left.new_z5 = right.zip and
                         left.new_prim_name = right.prim_name and
                         left.new_name1_first = right.fname,tra2(left,right),left outer);

hea_stub := record
string10      phone;
string9      ssn;
string20      fname;
string1      minit;
string20      lname;
string10      prim_range;
string28      prim_name;
string10      unit_desig;
string8      sec_range;
string25      city_name;
string2      st;
string5      zip;
string4      zip4;
  end;

hea_stub tra(FL_Headers l) := transform
  self := l;
  end;

pb := project(File_flheaders,tra(left));

ps := sort(pb,lname,prim_range,zip,prim_name,fname,ssn);

p := dedup(ps,lname,prim_range,zip,prim_name,fname,ssn);

Layout_Extra tra1(layout_joined l, hea_stub r) := transform
  self.old_ssn := r.ssn;
  self.new_ssn := '';
  self := l;
  end;

Layout_Extra tra2(layout_extra l, hea_stub r) := transform
  self.new_ssn := r.ssn;
  self := l;
  end;

j1 := join(file_annotated,p,left.name1_last=right.lname and
                         left.prim_range=right.prim_range and
                         left.z5 = right.zip and
                         left.prim_name = right.prim_name and
                         left.name1_first = right.fname,tra1(left,right),left outer);


j2 := join(j1,p,left.new_name1_last=right.lname and
                         left.new_prim_range=right.prim_range and
                         left.new_z5 = right.zip and
                         left.new_prim_name = right.prim_name and
                         left.new_name1_first = right.fname,tra2(left,right),left outer);

hea_stub := record
string10      phone;
string9      ssn;
string20      fname;
string1      minit;
string20      lname;
string10      prim_range;
string28      prim_name;
string10      unit_desig;
string8      sec_range;
string25      city_name;
string2      st;
string5      zip;
string4      zip4;
  end;

hea_stub tra(FL_Headers l) := transform
  self := l;
  end;

pb := project(File_flheaders,tra(left));

ps := sort(pb,lname,prim_range,zip,prim_name,fname,ssn);

p := dedup(ps,lname,prim_range,zip,prim_name,fname,ssn);

Layout_Extra tra1(layout_joined l, hea_stub r) := transform
  self.old_ssn := r.ssn;
  self.new_ssn := '';
  self := l;
  end;

Layout_Extra tra2(layout_extra l, hea_stub r) := transform
  self.new_ssn := r.ssn;
  self := l;
  end;

j1 := join(file_annotated,p,left.name1_last=right.lname and
                         left.prim_range=right.prim_range and
                         left.z5 = right.zip and
                         left.prim_name = right.prim_name and
                         left.name1_first = right.fname,tra1(left,right),left outer);


j2 := join(j1,p,left.new_name1_last=right.lname and
                         left.new_prim_range=right.prim_range and
                         left.new_z5 = right.zip and
                         left.new_prim_name = right.prim_name and
                         left.new_name1_first = right.fname,tra2(left,right),left outer);

hea_stub := record
string10      phone;
string9      ssn;
string20      fname;
string1      minit;
string20      lname;
string10      prim_range;
string28      prim_name;
string10      unit_desig;
string8      sec_range;
string25      city_name;
string2      st;
string5      zip;
string4      zip4;
  end;

hea_stub tra(FL_Headers l) := transform
  self := l;
  end;

pb := project(File_flheaders,tra(left));

ps := sort(pb,lname,prim_range,zip,prim_name,fname,ssn);

p := dedup(ps,lname,prim_range,zip,prim_name,fname,ssn);

Layout_Extra tra1(layout_joined l, hea_stub r) := transform
  self.old_ssn := r.ssn;
  self.new_ssn := '';
  self := l;
  end;

Layout_Extra tra2(layout_extra l, hea_stub r) := transform
  self.new_ssn := r.ssn;
  self := l;
  end;

j1 := join(file_annotated,p,left.name1_last=right.lname and
                         left.prim_range=right.prim_range and
                         left.z5 = right.zip and
                         left.prim_name = right.prim_name and
                         left.name1_first = right.fname,tra1(left,right),left outer);


j2 := join(j1,p,left.new_name1_last=right.lname and
                         left.new_prim_range=right.prim_range and
                         left.new_z5 = right.zip and
                         left.new_prim_name = right.prim_name and
                         left.new_name1_first = right.fname,tra2(left,right),left outer);

hea_stub := record
string10      phone;
string9      ssn;
string20      fname;
string1      minit;
string20      lname;
string10      prim_range;
string28      prim_name;
string10      unit_desig;
string8      sec_range;
string25      city_name;
string2      st;
string5      zip;
string4      zip4;
  end;

hea_stub tra(FL_Headers l) := transform
  self := l;
  end;

pb := project(File_flheaders,tra(left));

ps := sort(pb,lname,prim_range,zip,prim_name,fname,ssn);

p := dedup(ps,lname,prim_range,zip,prim_name,fname,ssn);

Layout_Extra tra1(layout_joined l, hea_stub r) := transform
  self.old_ssn := r.ssn;
  self.new_ssn := '';
  self := l;
  end;

Layout_Extra tra2(layout_extra l, hea_stub r) := transform
  self.new_ssn := r.ssn;
  self := l;
  end;

j1 := join(file_annotated,p,left.name1_last=right.lname and
                         left.prim_range=right.prim_range and
                         left.z5 = right.zip and
                         left.prim_name = right.prim_name and
                         left.name1_first = right.fname,tra1(left,right),left outer);


j2 := join(j1,p,left.new_name1_last=right.lname and
                         left.new_prim_range=right.prim_range and
                         left.new_z5 = right.zip and
                         left.new_prim_name = right.prim_name and
                         left.new_name1_first = right.fname,tra2(left,right),left outer);


export PrintTest := 'todo';
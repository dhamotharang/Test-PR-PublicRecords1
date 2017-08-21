import address;

shared Layout_Indic := record //Indic
   unsigned4 per_id;
   unsigned6 did := 0;
   integer4 soc;
   decimal5 zip;
   data9 cid;
   integer1 marital;
   integer4 dob;
   string1 sex;
   qstring25 lst;
   qstring15 frst;
   qstring15 middle;
   string2 suffix;
   qstring15 st_num;
   qstring25 st_name;
   qstring15 st_type;
   qstring25 city;
   string2 state;
   decimal5 adr_zip;
   decimal11 phone;
   data3 phone_dt;
end;
/*
shared Layout_Indic := record //Indic
   unsigned4 per_id;
   unsigned6 did := 0;
   integer4 soc;
   decimal5 zip;
   data9 cid;
   integer1 marital;
   integer4 dob;
   string1 sex;
   qstring25 lst;
   qstring15 frst;
   qstring15 middle;
   string2 suffix;
   address.Layout_Address_Clean_Return;
   decimal11 phone;
end;*/
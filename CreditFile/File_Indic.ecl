import did_add,ut,header_slimsort,address;

Layout_Indic_in := record //Indic
   unsigned4 per_id;
   integer4 soc;
   decimal5 zip;
   data9 cid;
   integer1 marital;
   integer1 dob_m;
   integer1 dob_d;
   integer1 dob_y;
   ebcdic string1 sex;
   ebcdic string25 lst;
   ebcdic string15 frst;
   ebcdic string15 middle;
   ebcdic string2 suffix;
   ebcdic string15 st_num;
   ebcdic string25 st_name;
   ebcdic string15 st_type;
   ebcdic string20 city;
   ebcdic string2 state;
   decimal5 adr_zip;
   decimal11 phone;
   data3 phone_dt;
   ebcdic string1 fill;
end;

Layout_Indic_In into(Layout_Indic_In le,unsigned1 slice) := transform
  self.per_id := Change_Id(slice,le.per_id);
  self := le;
  end;

d := project(dataset('~thor_data400::dev_in::cred_per',layout_indic_in,flat),into(left,1));

inter := record //Indic
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
   qstring120 addr1;
   qstring120 addr2;
   address.Layout_Address_Clean_Return;
end;

inter add_city(layout_indic_in le,file_citymap ri) := transform
  self.addr1 := Stringlib.StringCleanSpaces(trim((string30)le.st_num)+' '+trim((string30)le.st_name)+' '+trim((string30)le.st_type));
  self.addr2 := Stringlib.StringCleanSpaces(trim((string30)IF(ri.city_full='',le.city,ri.city_full))+ ', ' + trim((string30)le.state) + ' ' + (STRING5)IF(le.adr_zip<> 0, intformat((integer)le.adr_zip,5,1), ' '));
  self.dob := MAP(le.dob_y=0 => 0,
                  (le.dob_y+1900) * 10000 + 100 * le.dob_m + le.dob_d);
  self := le;
  end;

j := join(d(NOT (city='OZ' AND state='GA')),file_citymap,left.city=right.city_abbr,add_city(left,right),left outer,lookup);

address.MAC_Address_Clean_Standard(j,addr1,addr2,true,ofile)

layout_indic_addr := record
layout_indic;
  qstring9 ssn;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring8  sec_range;
  string2 st;
  string5  zip5;
end;


layout_indic_addr slim(ofile le) := transform
  self.ssn := (qstring9)le.soc;
  self := le;
  end;

matchfile := project(ofile, slim(left));

matchset := ['D','S','A'];

did_add.MAC_Match_Flex
	(matchfile, matchset,						//see above
	 ssn, dob, frst, middle, lst, suffix, 
	 prim_range, prim_name, sec_range, zip5, st, phone,
	 DID,
	 layout_indic_addr, 
	 false, junk2,
	 75,
	 res)

Layout_Indic strip(layout_indic_addr le) := transform
self := le;
end;

export File_Indic := project(res, strip(left));
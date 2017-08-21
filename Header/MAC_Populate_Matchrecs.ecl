import ut,header;

export MAC_Populate_Matchrecs (inf,outf,psist,new_version = 'false'):= macro

#uniquename(sm_rec)
%sm_rec% := record
unsigned6 did;
//unsigned6 preglb_did;
qstring18 vendor_id;
qstring9 ssn;
STRING1 valid_ssn;
STRING9 best_ssn := '';
integer4 dob;
STRING1 jflag1;
integer4 best_dob := 0;
qstring10	phone;
qstring20 fname;
qstring20 lname;
qstring20 mname;
qstring5 name_suffix;
qstring10 prim_range;
qstring28 prim_name;
qstring5 zip;
string2 st;
qstring25 city_name;
qstring8 sec_range;
unsigned3	dt_last_seen;
boolean good_ssn := false;
integer1 good_nmaddr := 0;
unsigned1 rare_name := 255;
unsigned1 head_cnt;
  end;

#uniquename(intof)
%sm_rec% %intof%(inf le) := transform
  self.fname := datalib.PreferredFirstNew(le.fname, new_version);
  self.mname := datalib.PreferredFirstNew(le.mname, new_version);
  self.name_suffix := ut.Translate_Suffix(le.name_suffix);
	SELF.head_cnt := 1;
  self := le;
  end;

#uniquename(me_use1)
%me_use1% := project(inf,%intof%(left));

#uniquename(dist_precount)
#uniquename(dist)
%dist_precount% := distribute(%me_use1%,hash(did));
// %dist% := group(sort(distribute(%me_use1%,hash(did)),did,local),did,local);

// get counts
#uniquename(cnt_rec)
#uniquename(cnt_tab)
#uniquename(cnt)
%cnt_rec% :=
RECORD
	%dist_precount%.did;
	%cnt% := COUNT(GROUP);
END;
%cnt_tab% := TABLE(%dist_precount%, %cnt_rec%, did, LOCAL);

#uniquename(tra)
%sm_rec% %tra%(%sm_rec% le, %cnt_tab% ri) :=
TRANSFORM
	SELF.head_cnt := IF(ri.%cnt%>255,255,ri.%cnt%);
	SELF := le;
END;

%dist% := JOIN(%dist_precount%, %cnt_tab%, LEFT.did=RIGHT.did, %tra%(LEFT,RIGHT), LOCAL);

#uniquename(prop_ssn)
#uniquename(prop_dob)
#uniquename(prop_phone)
#uniquename(prop_mname)
#uniquename(prop_lname)
#uniquename(prop_fname)
%sm_rec% %prop_ssn%(%sm_rec% le,%sm_rec% ri) := transform
  self.ssn := if ( ri.ssn='', le.ssn, ri.ssn );
  self := ri;
end;

%sm_rec% %prop_dob%(%sm_rec% le,%sm_rec% ri) := transform
	self.dob := map( (ri.dob % 10000 = 0 or ri.dob % 10000 = 101 or ri.dob % 10000 = 100)
						and ri.dob div 10000 = le.dob div 10000 => le.dob,
					 (ri.dob % 100 = 0 or ri.dob % 100 = 1 )
						and ri.dob div 100 = le.dob div 100 => le.dob,
					 ri.dob = 0 => le.dob,
					 ri.dob);
//( ri.dob=0, le.dob, ri.dob );
	self := ri;
end;

%sm_rec% %prop_mname%(%sm_rec% le,%sm_rec% ri) := transform
	self.mname := if ( ri.mname='' or (length(trim(ri.mname)) = 1 and ri.mname[1] = le.mname[1]),le.mname,ri.mname );
	self := ri;
end;


%sm_rec% %prop_phone%(%sm_rec% le,%sm_rec% ri) := transform
	self.phone := if (ri.phone = '',le.phone,ri.phone);
	self := ri;
end;

%sm_rec% %prop_fname%(%sm_rec% le,%sm_rec% ri) := transform
	self.fname := if ( ri.fname='' or (length(trim(ri.fname)) = 1 and ri.fname[1] = le.fname[1]),le.fname,ri.fname );
	self := ri;
end;

%sm_rec% %prop_lname%(%sm_rec% le,%sm_rec% ri) := transform
	self.lname := if ( ri.lname='' or (length(trim(ri.lname)) = 1 and ri.lname[1] = le.lname[1]),le.lname,ri.lname );
    self := ri;
end;

#uniquename(sd1)
#uniquename(sd2)
#uniquename(sd3)
#uniquename(sd4)
#uniquename(sd5)
#uniquename(sd6)
#uniquename(topopulate)
#uniquename(not_topopulate)
%topopulate% := %dist%(head_cnt>1);
%not_topopulate% := %dist%(head_cnt=1);

header.MAC_Populate_SSN(%topopulate%,%sd1%)
header.mac_populate_dob(%sd1%,%sd2%)
// %sd1% := iterate(sort(%dist%,-ssn), %prop_ssn%(left,right));
// %sd2% := iterate(sort(%sd1%,-dob),  %prop_dob%(left,right));
#uniquename(sd_grouped)
%sd_grouped% := group(sort(%sd2%,did,local),did,local);

%sd3% := iterate(sort(%sd_grouped%,-mname),%prop_mname%(left,right));
%sd4% := iterate(sort(%sd3%,-phone),%prop_phone%(left,right));
%sd5% := iterate(sort(%sd4%,-lname),%prop_lname%(left,right));
%sd6% := iterate(sort(%sd5%,-fname),%prop_fname%(left,right));

outf1 := group(dedup(%sd6%,all));// : persist(psist);

slimrec := record
	outf1.did;
	outf1.lname;
end;

slim1 := table(outf1,slimrec);
slim2 := dedup(sort(slim1,did,lname,local),did,lname,local);

outf1 crosspop(outf1 L, slim2 R) := transform
	self.lname := R.lname;
	self := L;
end;

outf2 := join(outf1,slim2,left.did = right.did, crosspop(left,right),local)+%not_topopulate%;

outf := dedup(sort(outf2,record,local),local) : persist(psist);

endmacro;
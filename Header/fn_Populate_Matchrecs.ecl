import ut,header,watchdog; 

export fn_Populate_Matchrecs (
	dataset(layout_header) inf,
	dataset(watchdog.Layout_Best) bestfile0, 
	string persist_suffix = '',
	boolean new_version = false,
	boolean skipPreferredFirst = false):= function


#uniquename(intof)
layout_matchcandidates %intof%(inf le) := transform
  self.fname := if(skipPreferredFirst, le.fname, datalib.PreferredFirstNew(le.fname, new_version));
  self.mname := if(skipPreferredFirst, le.mname, datalib.PreferredFirstNew(le.mname, new_version));
  self.name_suffix := ut.fGetSuffix(le.name_suffix);
	SELF.head_cnt := 1;
	self.prim_range_fraction := regexfind(' [0-9]/[0-9]$',trim(le.prim_range));
  self := le;
  end;

#uniquename(me_use1)
new := header.fn_StripNonSSNs(inf).head;
%me_use1% := project(new,%intof%(left));


bestfile := header.fn_StripNonSSNs(inf).best(bestfile0);

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
layout_matchcandidates %tra%(layout_matchcandidates le, %cnt_tab% ri) :=
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
#uniquename(prop_prim_range)

layout_matchcandidates %prop_ssn%(layout_matchcandidates le,layout_matchcandidates ri) := transform
  self.ssn := if ( ri.ssn='', le.ssn, ri.ssn );
  self := ri;
end;

layout_matchcandidates %prop_dob%(layout_matchcandidates le,layout_matchcandidates ri) := transform
	self.dob := map( (ri.dob % 10000 = 0 or ri.dob % 10000 = 101 or ri.dob % 10000 = 100)
						and ri.dob div 10000 = le.dob div 10000 => le.dob,
					 (ri.dob % 100 = 0 or ri.dob % 100 = 1 )
						and ri.dob div 100 = le.dob div 100 => le.dob,
					 ri.dob = 0 => le.dob,
					 ri.dob);
//( ri.dob=0, le.dob, ri.dob );
	self := ri;
end;

layout_matchcandidates %prop_mname%(layout_matchcandidates le,layout_matchcandidates ri) := transform
	self.mname := if ( ri.mname='' or (length(trim(ri.mname)) = 1 and ri.mname[1] = le.mname[1]),le.mname,ri.mname );
	self := ri;
end;


layout_matchcandidates %prop_phone%(layout_matchcandidates le,layout_matchcandidates ri) := transform
	self.phone := if (ri.phone = '',le.phone,ri.phone);
	self := ri;
end;

layout_matchcandidates %prop_fname%(layout_matchcandidates le,layout_matchcandidates ri) := transform
	self.fname := if ( ri.fname='' or (length(trim(ri.fname)) = 1 and ri.fname[1] = le.fname[1]),le.fname,ri.fname );
	self := ri;
end;

layout_matchcandidates %prop_lname%(layout_matchcandidates le,layout_matchcandidates ri) := transform
	self.lname := if ( ri.lname='' or (length(trim(ri.lname)) = 1 and ri.lname[1] = le.lname[1]),le.lname,ri.lname );
    self := ri;
end;

layout_matchcandidates %prop_prim_range%(layout_matchcandidates le) := transform
	self.prim_range := if(le.prim_range_fraction,
                        le.prim_range[1..stringlib.stringfind(le.prim_range,regexfind(' [0-9]/[0-9]$',trim(le.prim_range),0),1)-1],
			           le.prim_range);	
    self := le;
end;

#uniquename(lname2nd)
%lname2nd%		:=	'^[a-z]{3,}[ -/]{1,}([a-z]{3,}$)';
#uniquename(hyphenated)
%hyphenated%	:=	'(^[a-z]{3,})[ -/]{1,}([a-z]{3,}$)';
#uniquename(lname_is_hyphenated)
boolean %lname_is_hyphenated%(string lname) := regexfind(%hyphenated%,trim(lname),nocase);

#uniquename(prop_lname1st)
layout_matchcandidates %prop_lname1st%(layout_matchcandidates le) := transform
	self.lname := if(%lname_is_hyphenated%(le.lname)
					,le.lname[1..stringlib.stringfind(le.lname,regexfind(%lname2nd%,trim(le.lname),1,nocase),1)-2]
					,le.lname);
    self := le;
end;

#uniquename(prop_lname2nd)
layout_matchcandidates %prop_lname2nd%(layout_matchcandidates le) := transform
	self.lname :=  if(%lname_is_hyphenated%(le.lname)
					,le.lname[stringlib.stringfind(le.lname,regexfind(%lname2nd%,trim(le.lname),1,nocase),1)..]
					,le.lname);
    self := le;
end;

#uniquename(sd1)
#uniquename(sd2)
#uniquename(sd3)
#uniquename(sd4)
#uniquename(sd5)
#uniquename(sd6)
#uniquename(sd7)
#uniquename(sd8)
#uniquename(sd9)
#uniquename(topopulate)
#uniquename(not_topopulate)
%topopulate%     := %dist%(head_cnt>1);
%not_topopulate% := %dist%(head_cnt=1);

%sd1% := header.fn_Populate_SSN(%topopulate%,bestfile);
%sd2% := header.fn_populate_dob(%sd1%,bestfile) +  %not_topopulate%;
// %sd1% := iterate(sort(%dist%,-ssn), %prop_ssn%(left,right));
// %sd2% := iterate(sort(%sd1%,-dob),  %prop_dob%(left,right));
#uniquename(sd_grouped)
%sd_grouped% := group(sort(%sd2%,did,local),did,local);

#uniquename(prim_range_fraction)
%prim_range_fraction%	:= %dist%(prim_range_fraction);
#uniquename(hyphenated_lname)
%hyphenated_lname%	:= %dist%(%lname_is_hyphenated%(lname));

%sd3% := iterate(sort(%sd_grouped%,-mname),%prop_mname%(left,right));
%sd4% := iterate(sort(%sd3%,-phone),%prop_phone%(left,right));
%sd5% := iterate(sort(%sd4%,-lname),%prop_lname%(left,right));
%sd6% := iterate(sort(%sd5%,-fname),%prop_fname%(left,right));
%sd7% := group(sort(project(sort(%sd6%,-prim_range),%prop_prim_range%(left))	+ %prim_range_fraction%,did,local),did,local);
%sd8% := group(sort(project(sort(%sd7%,-lname),%prop_lname1st%(left))			+ %hyphenated_lname%,did,local),did,local);
%sd9% := group(sort(project(sort(%sd8%,-lname),%prop_lname2nd%(left))			+ %hyphenated_lname%,did,local),did,local);

outf1 := distribute(group(dedup(%sd9%,all)),hash(did));// : persist(psist);

slimrec := record
	outf1.did;
	outf1.lname;
end;

slim1 := table(outf1,slimrec,local);
slim2 := dedup(sort(slim1,did,lname,local),did,lname,local);

outf1 crosspop(outf1 L, slim2 R) := transform
	self.lname := R.lname;
	self := L;
end;

outf2 := join(outf1,slim2,left.did = right.did, crosspop(left,right),local);

d := dedup(sort(outf2,record,local),local);
d_pst := d;// : persist('Populated_Matchrecs' + persist_suffix);
return if ( header.DoSkipPersist(persist_suffix),d,d_pst);

end;
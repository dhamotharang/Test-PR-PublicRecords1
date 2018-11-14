import header,ut,did_add;

export fn_Apt_Patch(boolean isEN=false,string filedate) := function

apts := header.fn_ApartmentBuildings(isEN, filedate)(apt_cnt > 1);
dh := header.file_fcra_header_prep(filedate)(if(isEN,true,src<>'EN'),prim_name != '', prim_range != '');
dh_excl := header.file_fcra_header_prep(filedate)(if(isEN,true,src<>'EN') and (prim_name = '' or prim_range = ''));

slimrec := record
	dh.prim_name;
	dh.prim_range;
	dh.predir;
	dh.suffix;
	dh.sec_Range;
	dh.zip;
	dh.lname;
	dh.fname;
	dh.ssn;
	dh.dob;
	dh.did;
end;

dhslim := table(dh,slimrec);

dhslim get_apt_dwellers(dhslim L, apts R ) := transform
	self := L;
end;

dhs_d := distribute(dhslim,hash(prim_name,prim_range,zip));
apts_d := distribute(apts,hash(prim_name,prim_range,zip));

dwellers := join(dhs_d,apts_d,left.prim_range = right.prim_range and
							left.prim_name = right.prim_name and
							left.zip = right.zip and
							left.predir = right.predir and
							left.suffix = right.suffix,get_apt_dwellers(LEFT,RIGHT),local);

dwellers_sorted := sort(dwellers,prim_name,prim_range,zip,sec_range,lname,ssn,dob,fname,local);
dwllr_ddp := dedup(dwellers_sorted,prim_name,prim_range,zip,sec_range,lname,ssn,dob,local);

name_counter := record
	dwllr_ddp.prim_name;
	dwllr_ddp.prim_range;
	dwllr_ddp.zip;
	dwllr_ddp.lname;
	sr_cnt := count(GROUP);
end;

dwtab := table(dwllr_ddp(sec_Range!=''),name_counter,prim_name,prim_range,zip,lname,local);

dw_singles := dwtab(sr_cnt = 1);

slimrec rejoin(dwllr_ddp L, dw_singles R) := transform
	self := L;
end;

dw_singfull := join(dwllr_ddp(sec_Range != ''),dw_singles,left.prim_name =right.prim_name and
							left.prim_range = right.prim_range and
							left.zip = right.zip and
							left.lname = right.lname,rejoin(LEFT,RIGHT),local);


slimrec propogate(dwllr_ddp L, dw_singfull R) := transform
	self.sec_range := R.sec_range;
	self := L;
end;

blank_dwellers := dwllr_ddp(sec_range = '');

dw_final_1 := join(blank_dwellers,dw_singfull,
				left.prim_name = right.prim_name and
				left.prim_range = right.prim_range and
				left.zip = right.zip and
				left.lname = right.lname and
				ut.nneq(left.ssn,right.ssn) and
				did_add.DOB_Match_Score(left.dob,right.dob) > 75,
				propogate(LEFT,RIGHT),local);


/*------------------------- [ check relatives ]-----------*/

dr := header.File_Relatives_v3(recent_cohabit > 0);

dr twisted(dr l) := transform
	self.person1 := l.person2;
	self.person2 := l.person1;
	self := L;
end;

dr_twisted := project(dr, twisted(left));

drfull := distribute(dr + dr_twisted,hash((unsigned6)person1));

rel_w_addr := record
	dw_singfull.prim_name;
	dw_singfull.sec_range;
	dw_singfull.prim_range;
	dw_singfull.zip;
	unsigned6 person1;
	unsigned6 person2;
end;

rel_w_addr get_rel_addr(drfull L, dw_singfull R) := transform
	self := R;
	self := L;
end;

dws := distribute(dw_singfull,hash(did));

rels := join(drfull,dws,(unsigned6)left.person1 = right.did and
				left.prim_range = (integer)right.prim_range and
				left.zip = (integer)right.zip,get_rel_addr(LEFT,RIGHT),local);


slimrec get_addr_from_rel(rels L, dwllr_ddp R) := transform
	self.sec_Range := L.sec_range;
	self := R;
end;

relsd := distribute(rels,hash(person2));
bdd := distribute(blank_dwellers, hash(did));

dw_final_2 := join (relsd,bdd,left.person2 = right.did and
						left.prim_name = right.prim_name and
						left.prim_range = right.prim_range and
						left.zip = right.zip,
						get_addr_from_rel(LEFT,RIGHT),local);

dwf := dw_final_1 + dw_final_2;
dwfs := sort(dwf,prim_range,prim_name,sec_range,zip,lname,did,fname);
dwfd := distribute(dedup(dwfs,prim_range,prim_name,sec_range,zip,Lname,did),hash(did));

/*-----------------------[ rejoin with headers ]----------------------*/

dh merge1(dh L,dwfd R) := transform
	self.sec_range := if (l.sec_Range = '',R.sec_range,l.sec_range);
	self.pflag2 := if(l.sec_range = '' and R.sec_range!='','A',L.pflag2);
	self := L;
end;

out1 := join(distribute(dh,hash(did)),dwfd,left.did = right.did and left.lname = right.lname and
					left.ssn = right.ssn and left.dob = right.dob and 
					left.prim_range = right.prim_range and
					left.prim_name = right.prim_name and 
					left.zip = right.zip and left.sec_Range = '',
				merge1(LEFT,RIGHT),left outer,local);

out1s := sort(distribute(out1,hash(rid)),rid,sec_range,local);
out1d := dedup(out1s,rid,local);


return project(out1d + dh_excl,header.Layout_Header);

end;
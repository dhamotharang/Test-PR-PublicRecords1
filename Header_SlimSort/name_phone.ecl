import header,ut;

stupid_Nums := ['1111111111','2222222222','3333333333','4444444444','5555555555','6666666666','7777777777','8888888888','9999999999',
			 '4114114111'];

h := header_slimsort.propagated_matchrecs(length(trim(stringlib.stringfilter(phone,'0123456789'),all)) = 10,
								  (integer)(phone[1..3]) != 0,
								  (integer)(phone[4..10]) != 0,
								  phone[4..10] != '9999999',
								  phone not in Stupid_Nums,
								  fname<>'');

phonep := record
  layout_name_phone;
  end;

phonep into(h le) := transform 
  self.fname := datalib.preferredfirstNew(le.fname, Header_Slimsort.Constants.UsePFNew);
  self.mname := datalib.preferredfirstNew(le.mname, Header_Slimsort.Constants.UsePFNew);
  self.name_suffix := if(ut.is_unk(le.name_suffix), '', ut.fGetSuffix(le.name_suffix));
  self := le;
  end;

t := project(h,into(left));

dis_t := distribute(t,hash((string)phone));

st := sort(dis_t,phone,did,fname,name_suffix,mname,lname,local);

gt := group(st,phone,local);

dt := dedup(gt,did,fname,name_suffix,mname,lname);

phone_rec := record
  dt.phone;
  unsigned4 cnt := count(group);
  end;

dt1 := dedup(dt,did);

phone_count := table(dt1,phone_rec,dt.phone, local);

phone_f_rec := record
  dt.fname;
  dt.phone;
  unsigned4 cnt := count(group);
  end;

dt2 := dedup(dt,did,fname);
phone_f_count := table(dt2,phone_f_rec,dt.phone,dt.fname, local);

phone_fs_rec := record
  dt.name_suffix;
  dt.fname;
  dt.phone;
  unsigned4 cnt := count(group);
  end;

dt3 := dedup(dt(name_suffix<>''),did,fname,name_suffix);
phone_fs_count := table(dt3,phone_fs_rec,dt.phone,dt.fname,dt.name_suffix, local);

phone_full_rec := record
  dt.name_suffix;
  dt.fname;
  dt.mname;
  dt.lname;
  dt.phone;
  unsigned4 cnt := count(group);
  end;

phone_full_count := table(dt,phone_full_rec,phone,mname,fname,lname,name_suffix, local);

layout_name_phone join_phone(phonep le, phone_rec ri) := transform
  self.phone_dids := ri.cnt;
  self := le;
  end;

phone_joined := join(dt,
                    phone_count,
                     left.phone=right.phone,join_phone(left,right),local);

layout_name_phone join_phone_f(layout_name_phone le, phone_f_rec ri) := transform
  self.phone_fname_dids := ri.cnt;
  self := le;
  end;

phone_f_joined := join(phone_joined,phone_f_count,
                                  left.phone=right.phone and
                                  left.fname=right.fname,
                                     join_phone_f(left,right),local);

layout_name_phone join_phone_fs(layout_name_phone le, phone_fs_rec ri) := transform
  self.phone_fname_suffix_dids := ri.cnt;
  self := le;
  end;

phone_fs_joined := join(phone_f_joined,phone_fs_count,
                                  left.phone=right.phone and
                                  left.fname=right.fname and
                                  left.name_suffix=right.name_suffix,
                                  join_phone_fs(left,right),left outer,local);

layout_name_phone join_full(layout_name_phone le, phone_full_rec ri) := transform
  self.phone_fullname_dids := ri.cnt;
  self := le;
  end;

ready1  := join(phone_fs_joined,phone_full_count,
                                  left.phone=right.phone and
                                  left.fname=right.fname and
                                  left.mname=right.mname and
                                  left.lname=right.lname and
                                  left.name_suffix=right.name_suffix,
                       join_full(left,right),local) : persist('~thor_data400::slimsort_name_phone_ready1');

g0 := distribute(ready1,hash(lname,fname));
					   
g1 := g0(length(trim(mname)) > 1);
g2 := g0(length(trim(mname)) = 1) : persist('cjmtemp::HSS_workaround3'); // temp fix
g3 := g0(length(trim(mname)) = 0);

g0 j1(g1 L, g2 R) := transform
	self.phone_fullname_dids := L.phone_fullname_dids + R.phone_fullname_dids;
	self := l;
end;

m1 := join(g1,g2,left.mname[1] = right.mname[1] and 
			  left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.phone = right.phone ,
			  j1(LEFT,RIGHT),left outer,local);

m1d := dedup(sort(m1,lname,fname,mname,name_suffix,phone,did,-phone_fullname_dids,local),
			lname,fname,mname,name_suffix,phone,did,local);

m2 := join(m1d,g3,left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.phone = right.phone,
			  j1(LEFT,RIGHT),left outer,local);

m2d := dedup(sort(m2,lname,fname,mname,name_suffix,phone,did,-phone_fullname_dids,local),
		lname,fname,mname,name_suffix,phone,did,local); // full mid names are done here



//----------[ Single Initial ]----------------------

g1_ddp := dedup(sort(g1,lname,fname,mname[1],name_suffix,phone,did,local),
					lname,fname,mname[1],name_suffix,phone,did,local);

g1rec := record
	g1_ddp.lname;
	g1_ddp.fname;
	string1 mi := g1_ddp.mname[1];
	g1_ddp.name_suffix;
	g1_ddp.phone;
	unsigned2 cnt := count(GROUP);
end;

g1tab := table(g1_ddp,g1rec,fname,lname,mname[1],name_suffix,phone,local);

g2 j2(g2 L, g1tab R) := transform
	self.phone_fullname_dids := L.phone_fullname_dids + R.cnt;
	self := L;
end;

m3 := join(g2,g1tab,left.mname[1] = right.mi and 
			  left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.phone = right.phone,
			  j2(LEFT,RIGHT),left outer,local);
			  
m4 := join(m3,g3,left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.phone = right.phone,
			  j1(LEFT,RIGHT),left outer,local);

m4d := dedup(sort(m4,lname,fname,mname,name_suffix,phone,did,-phone_fullname_dids,local),
        lname,fname,mname,name_suffix,phone,did,local) : persist('persist::slimsort_break_phone'); // mid initials are done here

//-----------------[ Blank Middles ]-------------------

g1_ddp_2 := dedup(sort(g1,lname,fname,name_suffix,phone,did,local),
					lname,fname,name_suffix,phone,did,local);

g1rec_2 := record
	g1_ddp_2.lname;
	g1_ddp_2.fname;
	g1_ddp_2.name_suffix;
	g1_ddp_2.phone;
	unsigned2 cnt := count(GROUP);
end;

g1tab_2 := table(g1_ddp_2,g1rec_2,fname,lname,name_suffix,phone,local);

g2 j4(g3 L, g1tab_2 R) := transform
	self.phone_fullname_dids := L.phone_fullname_dids + R.cnt;
	self := L;
end;

m5 := join(g3,g1tab_2,left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.phone = right.phone,
			  j4(LEFT,RIGHT),left outer,local);
			  
g2_ddp := dedup(sort(g2,lname,fname,name_suffix,phone,did,local),
					lname,fname,name_suffix,phone,did,local);

g2rec := record
	g2_ddp.lname;
	g2_ddp.fname;
	g2_ddp.name_suffix;
	g2_ddp.phone;
	unsigned2 cnt := count(GROUP);
end;

g2tab := table(g2_ddp,g2rec,fname,lname,name_suffix,phone,local);

g2 j6(g3 L, g2tab R) := transform
	self.phone_fullname_dids := L.phone_fullname_dids + R.cnt;
	self := L;
end;

m6 := join(m5,g2tab,left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.phone = right.phone,
			  j6(LEFT,RIGHT),left outer,local);
			  
final0 := m2d + m4d + m6;

final0 strip_probationary(final0 L, header_slimsort.Table_DID_OnProbation R) := transform
	self := L;
end;

final1 := join(final0,header_slimsort.Table_DID_OnProbation,left.did = right.did, strip_Probationary(LEFT,RIGHT),
			left only,hash);
			
final2 := distribute(final1(did != 0), hash((string)phone));

export name_phone:= final2 : persist('headerbuild_hss_name_phone');
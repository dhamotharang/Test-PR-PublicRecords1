import header, header_slimsort,lib_ziplib,ut;

h := header_slimsort.propagated_matchrecs((integer)dob <> 0, fname <> '', lname <> '');

h_st := project(h, transform(header.layout_matchcandidates,
self.st := if(left.st <> '', left.st, ziplib.ZipToState2(left.zip)), self := left));

dobp := Header_SlimSort.layout_name_dob_dayob;

dobp into(h_st le) := transform 
  self.mob := ut.mob(le.dob);
  self.dayob :=le.dob % 100;
  self.fname := datalib.preferredfirstNew(le.fname, Header_Slimsort.Constants.UsePFNew);
  self.mname := datalib.preferredfirstNew(le.mname, Header_Slimsort.Constants.UsePFNew);
  self := le;
  end;

pre_t := project(h_st,into(left));

t := pre_t;

dis_t := distribute(t,hash(trim(lname),trim(fname)));

sdt := sort(dis_t,lname,fname,mob,did,dayob,mname,zip,st,local);

gt := group(sdt,lname,fname,mob,local);

dt := dedup(gt,did,dayob,mname,zip,st): persist ('dt_temp');

dt0 := dedup(dt,did,dayob);

dob_wd_rec := record
	dt.mob;
	dt.fname;
	dt.lname;
    unsigned4 cnt := count(group) * 100;
	dt.dayob;
end;

dob_wd_count := table(dt0,dob_wd_rec,mob,fname,lname,dayob,local);

dt1 := dedup(dt,did);

dob_rec := record
  dt.mob;
  dt.fname;
  dt.lname;
  unsigned4 cnt := count(group) * 100;
  end;

dob_count := table(dt1,dob_rec,mob,fname,lname, local);

dob_m_rec := record
  dt.mob;
  dt.fname;
  dt.lname;
  unsigned4 cnt := count(group) * 100;
  dt.mname;
  end;

dt2 := dedup(sort(dt,did,mname),did,mname);

dob_m_count := table(dt2,dob_m_rec,mob,fname,lname,mname, local);

dob_zip_rec := record
  dt.mob;
  dt.fname;
  dt.lname;
  unsigned4 cnt := count(group) * 100;
  dt.zip;
  end;

sdt3 := sort(group(dt(zip<>''),lname,fname,mob,local),did,zip);
dt3 := dedup(sdt3,did,zip);
dob_z_counts := table(dt3,dob_zip_rec,mob,fname,lname,zip, local);

dob_ziptot_rec := record
  dob_z_counts.mob;
  dob_z_counts.fname;
  dob_z_counts.lname;
  unsigned4 cnt := max(group,dob_z_counts.cnt);
  end;

dob_z_count := table(dob_z_counts,dob_ziptot_rec,mob,fname,lname,local);

//add st in name DOB count
dob_st_rec := record
  dt.mob;
  dt.fname;
  dt.lname;
  unsigned4 cnt := count(group) * 100;
  dt.st;
  end;

sdt4 := sort(group(dt(st<>''),lname,fname,mob,local),did,st);
dt4 := dedup(sdt4,did,st);
dob_st_count := table(dt4,dob_st_rec,mob,fname,lname,st,local);

dobp join_dob(dobp le, dob_rec ri) := transform
  self.dob_fnname_dids := ri.cnt;
   self := le;
  end;

dobs_joined := join(dt,dob_count,left.mob=right.mob and
                                  left.fname=right.fname and
                                  left.lname=right.lname,join_dob(left,right),local);

dobp join_dob_wd(dobp le,dob_wd_count ri) := transform
	self.dob_fnname_dob_dids := ri.cnt;
	self := le;
end;

dobs_wd_joined := join(dobs_joined,dob_wd_count,left.mob = right.mob and
												left.dayob = right.dayob and
												left.lname = right.lname and
												left.fname = right.fname,
												join_dob_wd(left,right),local);

dobp join_dob_m(dobp le, dob_m_count ri) := transform
  self.dob_fnmname_dids := ri.cnt;
  self := le;
  end;

dobs_m_joined := join(dobs_wd_joined,dob_m_count,left.mob=right.mob and
                                  left.fname=right.fname and
                                  left.mname=right.mname and
                                  left.lname=right.lname,join_dob_m(left,right),local);

dobp join_dob_z(dobp le, dob_z_count ri) := transform
  self.dob_fnname_zip_dids := ri.cnt;
  self := le;
  end;

dobs_z_joined := join(dobs_m_joined,dob_z_count,left.mob=right.mob and
                                  left.fname=right.fname and
                                  left.lname=right.lname,join_dob_z(left,right),left outer,local);

dobp join_dob_st(dobp le, dob_st_count ri) := transform
  self.dob_fnname_st_dids := ri.cnt;
  self := le;
  end;

pre_name_dob_dayob := join(dobs_z_joined,dob_st_count,left.mob=right.mob and
                                  left.fname=right.fname and
                                  left.lname=right.lname and 
								  left.st = right.st,join_dob_st(left,right),left outer,local): persist ('pre_ndobdayob');
/*----------------------------------------*/

dobp good_left(dobp le) := transform
  self := le;
  end;

dt_dgrp := group(dt);
dt_dist := distribute(dt_dgrp(dayob != 0),hash(mob,dayob,trim(lname)));
ut.MAC_Remove_Withdups_Local(dt_dist,hash(mob,dayob,trim(lname)),50,dt_ddout)

hw_name := join (dt_ddout,dt_ddout,left.mob = right.mob and 
					   left.dayob = right.dayob and
					   left.did != right.did
					   and ut.NameMatch(left.fname,left.mname,left.lname,
							right.fname,right.mname,right.lname) < 3 and
						left.lname = right.lname,
					   good_left(LEFT),left only,local);

name_ddayob := distribute(pre_name_dob_dayob,hash(mob,dayob,trim(lname)));
dobp add_goodfuzz(name_ddayob l, dobp ri) := transform
  self.near_name := ri.fname='';
  self := l;
  end;

nm_db_dyb2 := join (name_ddayob,hw_name,left.mob = right.mob and
								left.dayob = right.dayob and 
								left.fname = right.fname and 
								left.mname = right.mname and
								left.lname = right.lname,
								add_goodfuzz(LEFT,RIGHT),left outer,local);

ff := distribute(nm_db_dyb2,hash(lname,fname,mob));//,mob,dayob,zip,near_name,dob_fnname_dob_dids ,dob_fnname_zip_dids,dob_fnmname_dids,dob_fnname_dids));
f2 := sort(ff,lname,fname,mob,mname,did,dayob,zip,st,near_name,dob_fnname_dob_dids ,dob_fnname_zip_dids,dob_fnmname_dids,dob_fnname_dids,dob_fnname_st_dids,local);
f3 := dedup(f2,lname,fname,mob,mname,did,dayob,zip,st,near_name,dob_fnname_dob_dids ,dob_fnname_zip_dids,dob_fnmname_dids,dob_fnname_dids,dob_fnname_st_dids,local);

//----------------[ correct for zero days]--------

zeroday := f3(dayob = 00);
nzd := f3(dayob != 00);

f3 correct_for_zeroday(nzd L, zeroday R) := transform
	self.dob_fnname_dob_dids := L.dob_fnname_dob_dids + (3 * (R.dob_fnname_dob_dids div 100));
	self := L;
end;

f4 := join(nzd,zeroday,left.fname = right.fname and left.lname = right.lname and
				   left.did = right.did and left.mob = right.mob,
		correct_for_zeroday(LEFT,RIGHT),left outer, local);
		
f5 := f4 + zeroday: persist('~thor_data400::SlimSort_name_dob_dayob_f5');


//---------------[ correct for blank middles/single mid initial ]----

g1 := f5(length(trim(mname)) > 1);
g2 := f5(length(trim(mname)) = 1): persist('cjmtemp::HSS_workaround2'); // temp fix
g3 := f5(length(trim(mname)) = 0);

f3 j1(g1 L, g2 R) := transform
	self.dob_fnmname_dids := L.dob_fnmname_dids + R.dob_fnmname_dids;
	self := l;
end;

m1 := join(g1,g2,left.mname[1] = right.mname[1] and 
			  left.fname = right.fname and
			  left.lname = right.lname and
			  left.mob = right.mob ,
			  j1(LEFT,RIGHT),left outer,local);

m1d := dedup(sort(m1,lname,fname,mob,mname,dayob,zip,st,did,-dob_fnmname_dids,local),
			lname,fname,mob,mname,dayob,zip,st,did,local);

m2 := join(m1d,g3,left.fname = right.fname and
			  left.lname = right.lname and
			  left.mob = right.mob,
			  j1(LEFT,RIGHT),left outer,local);

m2d := dedup(sort(m2,lname,fname,mob,mname,dayob,zip,st,did,-dob_fnmname_dids,local),
		lname,fname,mob,mname,dayob,zip,st,did,local); // full mid names are done here

//----------[ Single Initial ]----------------------

g1_ddp := dedup(sort(g1,lname,fname,mob,mname[1],did,local),
					lname,fname,mob,mname[1],did,local);

g1rec := record
	g1_ddp.lname;
	g1_ddp.fname;
	string1 mi := g1_ddp.mname[1];
	g1_ddp.mob;
	unsigned2 cnt := count(GROUP) * 100;
end;

g1tab := table(g1_ddp,g1rec,fname,lname,mname[1],mob,local);

g2 j2(g2 L, g1tab R) := transform
	self.dob_fnmname_dids := L.dob_fnmname_dids + R.cnt;
	self := L;
end;

m3 := join(g2,g1tab,left.mname[1] = right.mi and 
			  left.fname = right.fname and
			  left.lname = right.lname and
			  left.mob = right.mob,
			  j2(LEFT,RIGHT),left outer,local);
			  
m4 := join(m3,g3,left.fname = right.fname and
			  left.lname = right.lname and
			  left.mob = right.mob,
			  j1(LEFT,RIGHT),left outer,local);

m4d := dedup(sort(m4,lname,fname,mob,mname,dayob,zip,st,did,-dob_fnmname_dids,local),
             lname,fname,mob,mname,dayob,zip,st,did,local): persist('persist::slimsort_break_dob'); // mid initials are done here

//-----------------[ Blank Middles ]-------------------

g1_ddp_2 := dedup(sort(g1,lname,fname,mob,did,local),
					lname,fname,mob,did,local);

g1rec_2 := record
	g1_ddp_2.lname;
	g1_ddp_2.fname;
	g1_ddp_2.mob;
	unsigned2 cnt := count(GROUP) * 100;
end;

g1tab_2 := table(g1_ddp_2,g1rec_2,fname,lname,mob,local);

g2 j4(g3 L, g1tab_2 R) := transform
	self.dob_fnmname_dids := L.dob_fnmname_dids + R.cnt;
	self := L;
end;

m5 := join(g3,g1tab_2,left.fname = right.fname and
			  left.lname = right.lname and
			  left.mob = right.mob,
			  j4(LEFT,RIGHT),left outer,local);
			  
g2_ddp := dedup(sort(g2,lname,fname,mob,did,local),
					lname,fname,mob,did,local);

g2rec := record
	g2_ddp.lname;
	g2_ddp.fname;
	g2_ddp.mob;
	unsigned2 cnt := count(GROUP) * 100;
end;

g2tab := table(g2_ddp,g2rec,fname,lname,mob,local);

g2 j6(g3 L, g2tab R) := transform
	self.dob_fnmname_dids := L.dob_fnmname_dids + R.cnt;
	self := L;
end;

m6 := join(m5,g2tab,left.fname = right.fname and
			  left.lname = right.lname and
			  left.mob = right.mob,
			  j6(LEFT,RIGHT),left outer,local);
			  
final0 := m2d + m4d + m6;

alphinit2(qstring1 f, qstring1 l) := if(f < l, f + l, l + f);

final0 strip_probationary_and_add_alphinit(final0 L, header_slimsort.Table_DID_OnProbation R) := transform
	self.alphinit := alphinit2(L.fname[1],l.lname[1]);
	self := L;
end;

final1 := join(final0,header_slimsort.Table_DID_OnProbation,
			left.did = right.did, 
			strip_Probationary_and_add_Alphinit(LEFT,RIGHT),
			left only,hash);

final2 := distribute(final1(did != 0), hash(mob,alphinit));

export name_dob_dayob := dedup(final2,all,local) : persist('headerbuild_hss_name_dob_dayob');

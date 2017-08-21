import header,ut;

h := propagated_matchrecs((integer)ssn <> 0,
					 length(trim(ssn,all)) = 9,
					 ssn not in ut.set_badssn,
					 fname <> '');

ssnp := record
  layout_name_ssn;
  end;

ssnp into(h le) := transform 
  self.fname := datalib.preferredfirstNew(le.fname, Header_Slimsort.Constants.UsePFNew);
  self.mname := datalib.preferredfirstNew(le.mname, Header_Slimsort.Constants.UsePFNew);
  self.name_suffix := if(ut.is_unk(le.name_suffix), '', ut.fGetSuffix(le.name_suffix));
  self := le;
  end;

t := project(h,into(left));

dis_t := distribute(t,hash(ssn));

sd := sort(dis_t,ssn,did,fname,name_suffix,lname,mname,local);

gsd := group(sd,ssn,local);

dt := dedup(gsd,did,fname,name_suffix,lname,mname);

ssns_rec := record
  dt.ssn;
  unsigned4 cnt := count(group);
  end;

dt1 := dedup(dt,did);

ssns_count := table(dt1,ssns_rec,dt.ssn, local);

ssns_f_rec := record
  dt.fname;
  dt.ssn;
  unsigned4 cnt := count(group);
  end;

dt2 := dedup(dt,did,fname);
ssns_f_count := table(dt2,ssns_f_rec,dt.ssn,dt.fname, local);

ssns_fs_rec := record
  dt.name_suffix;
  dt.fname;
  dt.ssn;
  unsigned4 cnt := count(group);
  end;

dt3 := dedup(dt(name_suffix<>''),did,fname,name_suffix);
ssns_fs_count := table(dt3,ssns_fs_rec,dt.ssn,dt.fname,dt.name_suffix, local);

ssns_full_rec := record
  dt.name_suffix;
  dt.fname;
  dt.mname;
  dt.lname;
  dt.ssn;
  unsigned4 cnt := count(group);
  end;

ssns_full_count := table(dt,ssns_full_rec,ssn,mname,fname,lname,name_suffix, local);

layout_name_ssn join_ssn(ssnp le, ssns_rec ri) := transform
  self.ssn_dids := ri.cnt;
  self := le;
  end;

ssns_joined := join(dt,ssns_count,left.ssn=right.ssn,join_ssn(left,right),local);

layout_name_ssn join_ssn_f(layout_name_ssn le, ssns_f_rec ri) := transform
  self.ssn_fname_dids := ri.cnt;
  self := le;
  end;

ssns_f_joined := join(ssns_joined,ssns_f_count,
                                  left.ssn=right.ssn and
                                  left.fname=right.fname,join_ssn_f(left,right),local);

layout_name_ssn join_ssn_fs(layout_name_ssn le, ssns_fs_rec ri) := transform
  self.ssn_fname_suffix_dids := ri.cnt;
  self := le;
  end;

ssns_fs_joined := join(ssns_f_joined,ssns_fs_count,left.ssn=right.ssn and
                                  left.fname=right.fname and
                                  left.name_suffix=right.name_suffix,join_ssn_fs(left,right),left outer,local);

layout_name_ssn join_full(layout_name_ssn le, ssns_full_rec ri) := transform
  self.ssn_fullname_dids := ri.cnt;
  self := le;
  end;

pre_ssns_full_joined := join(ssns_fs_joined,ssns_full_count,left.ssn=right.ssn and
                                  left.fname=right.fname and
                                  left.mname=right.mname and
                                  left.lname=right.lname and
                                  left.name_suffix=right.name_suffix,
                       join_full(left,right),local);

name_ssn_full := pre_ssns_full_joined(ssn_fullname_dids < 500);

remdupl := record
	unsigned6	did := dt.did;
	qstring9	ssn := dt.ssn;
end;

dt_ssn1 := distribute(table(dt,remdupl),hash(ssn));

dt_ssn1_sort := sort(dt_ssn1,ssn,local);
dt_ssn1_g := group (dt_ssn1_sort,ssn,local);
dt_ssn1_dd := dedup(dt_ssn1_g,did);

remdupl2 := record
	qstring9 ssn := dt_ssn1_dd.ssn;
	unsigned2 myCount := count(GROUP);
end;

dt_ssn1_b := table(dt_ssn1_dd,remdupl2,ssn,local);

typeof(dt) remdups(dt L,dt_ssn1_b R) := transform
	self := L;
end;

dt_ssn2_pred := join(dt,dt_ssn1_b,left.ssn = right.ssn and right.myCount > 10,
				remdups(LEFT,RIGHT),left only,local);


dt_ssn2 := distribute(dt_ssn2_pred,hash(ssn));

ssnp good_left(ssnp le) := transform
  self := le;
  end;

hw_name := join (dt_ssn2,dt_ssn2,left.ssn = right.ssn and left.did != right.did
								and ut.NameMatch(left.fname,left.mname,left.lname,
									right.fname,right.mname,right.lname) < 3,
								good_left(LEFT),left only,local);

hwn_dist := distribute(hw_name,hash(fname,lname));
name_ssn_full_dist := distribute(name_ssn_full,hash(fname,lname));

layout_name_ssn add_goodfuzz(name_ssn_full_dist l, ssnp ri) := transform
  self.near_name := ri.fname='';
  self := l;
  end;

fuzz_added := join(name_ssn_full_dist,hwn_dist,left.ssn = right.ssn and 
							left.fname = right.fname and left.mname = right.mname
							and left.lname = right.lname,
							add_goodfuzz(LEFT,RIGHT),left outer,local);

g0 := distribute(fuzz_added,hash(lname,fname));
					
g1 := g0(length(trim(mname)) > 1);
g2 := g0(length(trim(mname)) = 1);
g3 := g0(length(trim(mname)) = 0);

g0 j1(g1 L, g2 R) := transform
	self.ssn_fullname_dids := L.ssn_fullname_dids + R.ssn_fullname_dids;
	self := l;
end;

m1 := join(g1,g2, left.did <> right.did and
              left.mname[1] = right.mname[1] and 
			  left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and 
			  left.ssn = right.ssn ,
			  j1(LEFT,RIGHT),left outer,local);

m1d := dedup(sort(m1,lname,fname,mname,name_suffix,ssn,did,-ssn_fullname_dids,local),
			lname,fname,mname,name_suffix,ssn,did,local);

m2 := join(m1d,g3,
              left.did <> right.did and
              left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.ssn = right.ssn,
			  j1(LEFT,RIGHT),left outer,local);

m2d := dedup(sort(m2,lname,fname,mname,name_suffix,ssn,did,-ssn_fullname_dids,local),
		lname,fname,mname,name_suffix,ssn,did,local); // full mid names are done here



//----------[ Single Initial ]----------------------

g1_ddp := dedup(sort(g1,lname,fname,mname[1],name_suffix,ssn,did,local),
					lname,fname,mname[1],name_suffix,ssn,did,local);

g1rec := record
	g1_ddp.lname;
	g1_ddp.fname;
	string1 mi := g1_ddp.mname[1];
	g1_ddp.name_suffix;
	g1_ddp.ssn;
	g1_ddp.did;
	unsigned2 cnt := count(GROUP);
end;

g1tab := table(g1_ddp,g1rec,fname,lname,mname[1],name_suffix,ssn,did,local);

g2 j2(g2 L, g1tab R) := transform
	self.ssn_fullname_dids := L.ssn_fullname_dids + R.cnt;
	self := L;
end;

m3 := join(g2,g1tab,
              left.did <> right.did and
              left.mname[1] = right.mi and 
			  left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.ssn = right.ssn,
			  j2(LEFT,RIGHT),left outer,local);
			  
m4 := join(m3,g3,
              left.did <> right.did and
              left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.ssn = right.ssn,
			  j1(LEFT,RIGHT),left outer,local);

m4d := dedup(sort(m4,lname,fname,mname,name_suffix,ssn,did,-ssn_fullname_dids,local),
			lname,fname,mname,name_suffix,ssn,did,local) : persist('persist::slimsort_break_ssn'); // mid initials are done here

//-----------------[ Blank Middles ]-------------------

g1_ddp_2 := dedup(sort(g1,lname,fname,name_suffix,ssn,did,local),
					lname,fname,name_suffix,ssn,did,local);

g1rec_2 := record
	g1_ddp_2.lname;
	g1_ddp_2.fname;
	g1_ddp_2.name_suffix;
	g1_ddp_2.ssn;
	g1_ddp_2.did;
	unsigned2 cnt := count(GROUP);
end;

g1tab_2 := table(g1_ddp_2,g1rec_2,fname,lname,name_suffix,ssn,did,local);

g2 j4(g3 L, g1tab_2 R) := transform
	self.ssn_fullname_dids := L.ssn_fullname_dids + R.cnt;
	self := L;
end;

m5 := join(g3,g1tab_2,
               left.did <> right.did and
              left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.ssn = right.ssn,
			  j4(LEFT,RIGHT),left outer,local);
			  
g2_ddp := dedup(sort(g2,lname,fname,name_suffix,ssn,did,local),
					lname,fname,name_suffix,ssn,did,local);

g2rec := record
	g2_ddp.lname;
	g2_ddp.fname;
	g2_ddp.name_suffix;
	g2_ddp.ssn;
	g2_ddp.did;
	unsigned2 cnt := count(GROUP);
end;

g2tab := table(g2_ddp,g2rec,fname,lname,name_suffix,ssn,did,local);

g2 j6(g3 L, g2tab R) := transform
	self.ssn_fullname_dids := L.ssn_fullname_dids + R.cnt;
	self := L;
end;

m6 := join(m5,g2tab,
              left.did <> right.did and
              left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.ssn = right.ssn,
			  j6(LEFT,RIGHT),left outer,local);

m6d := dedup(sort(m6,lname,fname,name_suffix,ssn,did,-ssn_fullname_dids,local),
		lname,fname,name_suffix,ssn,did,local); // blank middles are done here

final0 := m2d + m4d + m6d;

final0 strip_probationary(final0 L, header_slimsort.Table_DID_OnProbation R) := transform
	self := L;
end;

final1 := join(final0,header_slimsort.Table_DID_OnProbation,left.did = right.did, strip_Probationary(LEFT,RIGHT),
			left only,hash);
			
final2 := distribute(final1(did != 0, ssn_dids < 50),hash((string)ssn));

final := sort(final2,ssn,local);

export name_ssn := final : persist('headerbuild_hss_name_ssn');
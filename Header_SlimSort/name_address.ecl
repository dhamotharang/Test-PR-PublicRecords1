import header,ut;


h := header_slimsort.propagated_matchrecs(fname<>'',lname<>'',prim_name <> '',zip<>'');

//h := group(sort(distribute(h0,hash(did)),did,local),did,local);

addressp := record
	header_slimsort.layout_name_address;
end;
	
addressp into(h le) := transform 
  self.fname := datalib.preferredfirstNew(le.fname, Header_Slimsort.Constants.UsePFNew);
  self.mname := datalib.preferredfirstNew(le.mname, Header_Slimsort.Constants.UsePFNew);
  self.name_suffix := if(ut.is_unk(le.name_suffix), '', ut.fGetSuffix(le.name_suffix));
  self := le;
  end;

pre_t := project(h,into(left));

t := pre_t;

dt_alpha := distribute(t,hash(fname,lname));
dt_a0 := dedup(sort(dt_alpha,
				fname,lname,prim_range,prim_name,zip,st,
				mname,name_suffix,sec_range,did,-dt_last_seen,local ),
			fname,lname,prim_range,prim_name,zip,st,mname,
			name_suffix,sec_range,did,local );



dis_t :=  group( 
            sort(dt_alpha,
              fname, 
			  lname, 
			  prim_range, 
              prim_name, 
              zip,
			  -dt_last_seen,
			  local),
            fname, 
			lname,
			prim_range,
            prim_name, 
            zip,
            local );

dis_t_st := group(
				sort(dt_alpha,
				  fname,
				  lname,
				  prim_range,
				  prim_name,
				  st,
				  -dt_last_seen,
				  local),
				fname,
				lname,
				prim_range,
				prim_name,
				st,
				local);


dt := dedup( sort(dis_t,mname,name_suffix,sec_range,did,-dt_last_seen ),mname,name_suffix,sec_range,did ) : persist('persist::na_slimsort_1');

dtg := sort (dt, did, sec_range);
dc4 := dedup(dtg, did, sec_range );
dc1 := dedup(dc4, did );

dtg2 := sort(dt, did, mname, name_suffix, sec_range);

dc3 := dedup(dtg2, did, mname, name_suffix, sec_range);
dc2 := dedup(dc3, did, mname, name_suffix);

dt_st := dedup(sort(dis_t_st,mname,name_suffix,sec_range,did,-dt_last_seen),mname,name_suffix,sec_range,did);
dtg_st := sort(dt_st,did,sec_range);
dc1_st := dedup(dtg_st,did,sec_range);

add_rec := record
  dt.fname;
  dt.lname;
  dt.prim_range;
  dt.prim_name;
  dt.zip;
  dt.did;
end;

add_calc := table(dc1,add_rec,fname,lname,prim_range,prim_name,zip,did, local) :independent; // https://track.hpccsystems.com/browse/HPCC-14067

jrec := record
	add_rec;
	unsigned6	rdid;
end;

jrec cross_calc(add_calc L, add_calc R) := transform
	self.rdid := R.did;
	self := l;
end;

acd := distribute(add_calc,hash(zip, prim_name, prim_range, lname));

add_count_cross := join(acd,acd,left.lname = right.lname and
			left.prim_range = right.prim_range and 
			left.prim_name = right.prim_name and
			left.zip = right.zip and
			ut.stringsimilar(left.fname,right.fname) < 3,
			cross_calc(LEFT,RIGHT),local,atmost(left.lname=right.lname and left.prim_range=right.prim_range and 
										left.prim_name=right.prim_name and left.zip=right.zip,3000));


add_count_cross_ddp :=group(dedup(sort(distribute(add_count_cross,hash(did)),did,fname,lname,prim_range,prim_name,zip,rdid,local),did,fname,lname,prim_range,prim_name,zip,rdid,local),did,fname,lname,prim_range,prim_name,zip,local);

jrec2 := record
	add_count_cross_ddp;
	unsigned4	cnt := 1;
end;

accd := table(add_count_cross_ddp,jrec2);

accd roll_accd(accd L, accd R) := transform
	self.cnt := L.cnt + R.cnt;
	self := l;
end;

add_count := distribute(group(rollup(accd,true,roll_accd(LEFT,RIGHT))),hash(fname,lname));

addressp add_adds(dt_a0 l, add_count ri) := transform
  self.fl_nosec_count := ri.cnt;
  self := l;
  end;

join_add := join(dt_a0,add_count,left.fname = right.fname and
                              left.lname=right.lname and
                              left.prim_name=right.prim_name and
						left.prim_range=right.prim_range and
                              left.zip=right.zip and left.did = right.did,
                              add_adds(left,right),local,atmost(3000));

st_Rec := record
	dt_St.fname;
	dt_st.lname;
	dt_st.prim_range;
	dt_st.prim_name;
	dt_st.sec_range;
	dt_st.st;
	dt_st.did;
end;

state_tab := table(dc1_st,st_rec,fname,lname,prim_range,prim_name,sec_range,st,did,local);

jst_rec := record
	st_rec;
	unsigned6	rdid;
end;

jst_rec cross_calc_st(state_tab L, state_tab R) := transform
	self.rdid := R.did;
	self := l;
end;

std := distribute(state_tab, hash(prim_name, prim_range, lname, sec_range, st));

st_count := join(std,std,left.lname = right.lname and
			left.prim_range = right.prim_range and 
			left.prim_name = right.prim_name and
			left.sec_range = right.sec_range and
			left.st = right.st and
			ut.stringsimilar(left.fname,right.fname) < 3,
			cross_calc_st(LEFT,RIGHT),local,atmost(left.lname = right.lname and
			left.prim_range = right.prim_range and 
			left.prim_name = right.prim_name and
			left.sec_range = right.sec_range and
			left.st = right.st,3000));


st_count_ddp := group(dedup(sort(distribute(st_count,hash(did)),did,fname,lname,prim_range,prim_name,sec_range,st,rdid,local),did,fname,lname,prim_range,prim_name,sec_range,st,rdid,local),did,fname,lname,prim_range,prim_name,sec_range,st,local);

jst_rec2 := record
	st_count_ddp;
	unsigned4	cnt := 1;
end;

scd := table(st_count_ddp,jst_rec2);

scd roll_scd(scd L, scd R) := transform
	self.cnt := L.cnt + R.cnt;
	self := l;
end;

state_count := distribute(group(rollup(scd,true,roll_scd(LEFT,RIGHT))),hash(fname,lname));

addressp add_sts(join_add L, state_count Ri) := transform
	self.fl_st_count := Ri.cnt;
	self := L;
end;

join_Sts := join(join_add,state_count,left.fname = right.fname and
									left.lname = right.lname and
									left.prim_range = right.prim_range and
									left.prim_name = right.prim_name and
									left.sec_range = right.sec_range and
									left.st = right.st and left.did = right.did,
								add_sts(LEFT,RIGHT),local,atmost(3000));//  : persist('persist::slimsort_break1_addr');


dc1pz := dedup(sort(dc1,lname,fname,prim_name,zip,did),lname,fname,prim_name,zip,did) :independent;

add_pz_rec := record
	dc1pz.fname;
	dc1pz.lname;
	dc1pz.prim_name;
	dc1pz.zip;
	dc1pz.did;
end;

apz_count := table(dc1pz,add_pz_rec,fname,lname,prim_name,zip,did,local);

apz_jrec := record
	add_pz_rec;
	unsigned6	rdid;
end;

apz_jrec crossCalcPZ(apz_count L, apz_Count R) := transform	
	self.rdid := R.did;
	self := l;
end;

apzd := distribute(apz_count,hash(zip,prim_name, lname));

apz2 := join(apzd, apzd, left.lname = right.lname and
			left.prim_name = right.prim_name and
			left.zip = right.zip and
			ut.StringSimilar(left.fname,right.fname) < 3,
			crossCalcPZ(LEFT,RIGHT),local,atmost(left.lname = right.lname and
			left.prim_name = right.prim_name and
			left.zip = right.zip,3000));

apz2_ddp := group(dedup(sort(distribute(apz2,hash(did)),did,fname,lname,prim_name,zip,rdid,local),did,fname,lname,prim_name,zip,rdid,local),did,fname,lname,prim_name,zip,local);

apz_jrec2 := record
	apz2_ddp;
	unsigned4	cnt := 1;
end;

apz_roll_in := table(apz2_ddp,apz_jrec2);

apz_jrec2 roll_apz(apz_roll_in L, apz_roll_in R) := transform
	self.cnt := L.cnt + R.cnt;
	self := L;
end;

add_pz_count := distribute(group(rollup(apz_roll_in,true,roll_apz(LEFT,RIGHT))),hash(fname,lname));

addressp add_pz_cnts(join_sts L, add_pz_count R) := transform
	self.fl_pz_count := R.cnt;
	self := l;
end;

join_pz := join(join_sts, add_pz_count, left.fname = right.fname and
						left.lname = right.lname and
						left.prim_name = right.prim_name and
						left.zip = right.zip and left.did = right.did,
				add_pz_cnts(LEFT,RIGHT),local,atmost(3000));

add_m_rec := record
  dt.fname;
  dt.lname;
  dt.prim_range;
  dt.prim_name;
  dt.zip;
  dt.mname;
  dt.name_suffix;
  dt.did;
  end;

amcount := table(dc2,add_m_rec,fname,
                                   lname,
                                   prim_range,
                                   mname,
                                   name_suffix,
                                   prim_name,
                                   zip,did,local);

amjrec := record
	amcount;
	unsigned6	rdid;
end;

amjrec cross_mid(amcount L, amcount R) := transform
	self.rdid := R.did;
	self := L;
end;

amcd := distribute(amcount, hash(lname, mname, name_suffix, prim_Range, prim_name, zip));

am_cross := join(amcd, amcd, left.lname = right.lname and
				left.mname = right.mname and
				left.name_suffix = right.name_suffix and
				left.prim_range = right.prim_range and
				left.prim_name = right.prim_name and
				left.zip = right.zip and
				ut.StringSimilar(left.fname,right.fname) < 3,
				cross_mid(LEFT,RIGHT),local,atmost(left.lname = right.lname and
				left.mname = right.mname and
				left.name_suffix = right.name_suffix and
				left.prim_range = right.prim_range and
				left.prim_name = right.prim_name and
				left.zip = right.zip,3000));

amcross_ddp := group(dedup(sort(distribute(am_Cross,hash(did)),
				did,fname,mname,lname,name_suffix,prim_range,prim_name,zip,rdid,local),
				did,fname,mname,lname,name_suffix,prim_range,prim_name,zip,rdid,local),
				did,fname,mname,lname,name_suffix,prim_Range,prim_name,zip,local);

amjrec2 := record
	amcross_ddp;
	unsigned4	cnt := 1;
end;

amc_roll_in := table(amcross_ddp,amjrec2);

amjrec2 roll_mids(amc_roll_in L, amc_roll_in R) := transform
	self.cnt := L.cnt + R.cnt;
	self := l;
end;

add_m_count := distribute(group(rollup(amc_roll_in,true,roll_mids(LEFT,RIGHT))),hash(fname,lname));

addressp add_adds_m(join_pz l, add_m_count ri) := transform
  self.fmls_nosec_count := ri.cnt;
  self := l;
  end;

join_add_m := join(join_pz,add_m_count,left.fname=right.fname and
                              left.lname=right.lname and
                              left.mname=right.mname and
                              left.name_suffix=right.name_suffix and
                              left.prim_name=right.prim_name and
                			  left.prim_range=right.prim_range and
                              left.zip=right.zip and left.did = right.did,
                              add_adds_m(left,right),local,atmost(3000));

add_sec_rec := record
  dt.fname;
  dt.lname;
  dt.prim_range;
  dt.prim_name;
  dt.sec_range;
  dt.zip;
  dt.did;
  end;

addsec := table(dc4,add_sec_rec,sec_range,fname,lname,prim_range,prim_name,zip,did, local);

jsecrec := record
	addsec;
	unsigned6	rdid;
end;

jsecrec cross_secs(addsec L, addsec R) := transform
	self.rdid := R.did;
	self := l;
end;

addsecd := distribute(addsec, hash(lname, prim_range, prim_name, sec_range, zip));


addsec_cross := join(addsecd,addsecd,left.lname = right.lname and
					left.prim_range = right.prim_range and
					left.prim_name = right.prim_name and
					left.sec_range = right.sec_range and
					left.zip = right.zip and
					ut.stringsimilar(left.fname,right.fname) < 3,
					cross_secs(LEFT,RIGHT),local,atmost(left.lname = right.lname and
					left.prim_range = right.prim_range and
					left.prim_name = right.prim_name and
					left.sec_range = right.sec_range and
					left.zip = right.zip,3000));


asc_ddp := group(dedup(sort(distribute(addsec_cross,hash(did)),
	did,fname,lname,prim_range,prim_name,sec_range,zip,rdid,local),
	did,fname,lname,prim_range,prim_name,sec_range,zip,rdid,local),
	did,fname,lname,prim_range,prim_name,sec_range,zip,local);

jsecrec2 := record
	asc_ddp;
	unsigned4	cnt := 1;
end;

asc_roll_in := table(asc_ddp,jsecrec2);

asc_roll_in roll_asc(asc_roll_in L, asc_Roll_in R) := transform
	self.cnt := L.cnt + R.cnt;
	self := l;
end;

add_sec_count := distribute(group(rollup(asc_roll_in,true,roll_asc(LEFT,RIGHT))),hash(fname,lname));

add_msec_rec := record
  dt.fname;
  dt.lname;
  dt.prim_range;
  dt.prim_name;
  dt.zip;
  dt.mname;
  dt.name_suffix;
  dt.sec_range;
  dt.did;
  end;


amsec_count := table(dc3,add_msec_rec,sec_range,fname,lname,prim_range,mname,name_suffix,prim_name,zip,did, local);

jmsecrec := record
	amsec_count;
	unsigned6	rdid;
end;

jmsecrec cross_msec(amsec_count L, amsec_count R) := transform
	self.rdid := R.did;
	self := l;
end;


amseccd := distribute(amsec_count, hash (lname, mname, name_suffix, prim_range, prim_name, sec_range, zip));

amsec_cross := join(amseccd, amseccd, left.lname = right.lname and
			left.mname = right.mname and left.name_suffix = right.name_suffix and
			left.prim_range = right.prim_range and 
			left.prim_name = right.prim_name and
			left.sec_range = right.sec_range and
			left.zip = right.zip and
			ut.StringSimilar(left.fname,right.fname) < 3,
			cross_msec(LEFT,RIGHT),local,atmost(left.lname = right.lname and
			left.mname = right.mname and left.name_suffix = right.name_suffix and
			left.prim_range = right.prim_range and 
			left.prim_name = right.prim_name and
			left.sec_range = right.sec_range and
			left.zip = right.zip,3000));

amsec_ddp := group(dedup(sort(distribute(amsec_cross,hash(did)),
			did,fname,lname,mname,name_suffix,prim_range,prim_name,sec_range,zip, rdid,local),
			did,fname,lname,mname,name_suffix,prim_range,prim_name,sec_range,zip, rdid,local),
			did,fname,lname,mname,name_suffix,prim_range,prim_name,sec_range,zip,local);

jmsecrec2 := record
	amsec_ddp;
	unsigned4	cnt := 1;
end;

amsec_roll_in := table(amsec_ddp,jmsecrec2);

amsec_roll_in roll_amsec(amsec_roll_in L, amsec_roll_in R) := transform
	self.cnt := L.cnt + R.cnt;
	self := L;
end;

add_msec_count := distribute(group(rollup(amsec_roll_in,true,roll_amsec(LEFT,RIGHT))),hash(fname,lname));

addressp add_adds_msec(join_add l, add_msec_count ri) := transform
  self.fmls_sec_count := ri.cnt;
  self := l;
  end;

join_add_msec := join(join_add_m,add_msec_count,left.fname=right.fname and
                              left.lname=right.lname and
                              left.mname=right.mname and
                              left.name_suffix=right.name_suffix and
                              left.prim_name=right.prim_name and
                			left.prim_range=right.prim_range and
                              left.sec_range=right.sec_range and
                              left.zip=right.zip and left.did = right.did,
                              add_adds_msec(left,right),local,atmost(3000));

addressp add_adds_sec(join_add l, add_sec_count ri) := transform
  self.fl_sec_count := ri.cnt;
  self := l;
  end;

pre_join_add_sec := join(join_add_msec,add_sec_count,left.fname=right.fname and
                              left.lname=right.lname and
                              left.prim_name=right.prim_name and
                			  left.prim_range=right.prim_range and
                              left.sec_range=right.sec_range and
                              left.zip=right.zip and left.did = right.did,
                              add_adds_sec(left,right),local,atmost(3000));

join_add_sec  := distribute(pre_join_add_sec(fmls_sec_count < 50),hash((string)prim_range,(string)prim_name,(string)zip)) : persist('persist::na_slimsort_2');

apt_bldg := sort(distribute(header.ApartmentBuildings,hash((string)prim_range,(string)prim_name,(string)zip)),
				prim_range,prim_name,zip,predir,local);

apt_bldg roll_predirs(apt_bldg L, apt_bldg R) := transform
	self.apt_cnt := L.apt_cnt + R.apt_cnt;
	self.did_cnt := L.did_cnt + R.did_cnt;
	self := L;
end;

apt_bldg_r := rollup(apt_bldg,left.prim_range = right.prim_range and
						left.prim_name = right.prim_name and
						left.zip = right.zip,
						roll_predirs(LEFT,RIGHT),local);
		

addressp_plus := record
	addressp;
	unsigned4	did_cnt;
	boolean		frequent := false;
end;

addressp_plus into_cnted(join_add_sec L,apt_bldg_r R) := transform
	self.apt_cnt := if (R.apt_cnt = 0,1,R.apt_cnt);
	self.did_cnt := if (r.did_cnt = 0,1,r.did_cnt);
    self.near_name := 2;
	self := L;
end;

dt_addr_w_cnt := join(join_add_sec,apt_bldg_r,left.prim_name = right.prim_name and
					left.prim_range = right.prim_range and 
					left.zip = right.zip,
					into_cnted(LEFT,RIGHT),left outer,local);


// 0 = safe, 1 = bldg match, 2 = apt match
addressp_plus good_left(addressp_plus le,addressp_plus ri) := transform
	self.near_name := map(ri.did = 0 => 1, // atmost
						  ri.did = le.did => 0, // self
						  ri.sec_range != le.sec_range => 1,
						  2);
	self := le;
end;

dt_awc_dist := distribute(dt_addr_w_cnt,hash((string)prim_range,(string)prim_name,(string)zip));

boolean initial_matches(string1 f1, string1 f2, string1 l1, string1 l2) :=
	map(f1 = f2 and l1 = l2 => true,
		f1 = l2 and f2 = l1 => true,
		false);

hw_name1 := join(dt_awc_dist,dt_awc_dist,left.prim_range=right.prim_range and
                                left.prim_name=right.prim_name and
                                (left.sec_range=right.sec_range or
									left.apt_cnt < 50 and right.apt_cnt < 50) and
                                left.zip=right.zip and
                                ut.DoNamesMatch(left.fname,left.mname,left.lname,
                                             right.fname,right.mname,right.lname,3) < 3,
                                good_left(left,right),left outer,local,atmost(left.prim_name = right.prim_name and
													left.prim_range = right.prim_range and left.zip = right.zip,1000));
													
hwn1_ddp := dedup(sort(hw_name1,prim_range,prim_name,sec_range,zip,st,lname,fname,mname,name_suffix,did,-apt_cnt,-near_name,local),prim_range,prim_name,sec_range,zip,st,lname,fname,mname,name_suffix,did,apt_cnt,local);

hwfocnter := dedup(sort(hwn1_ddp,prim_range,prim_name,sec_range,zip,fname,did,local),prim_Range,prim_name,sec_range,zip,fname,did,local);

fname_rec := record
	hw_name1.prim_range;
	hw_name1.prim_name;
	hw_name1.sec_range;
	hw_name1.zip;
	hw_name1.fname;
	unsigned4	cnt := count(group);
end;

ftab := table(hwfocnter(did_cnt <= 10),fname_rec,prim_range,prim_name,sec_range,zip,fname,local);

addressp_plus add_fname_cnt(hwn1_ddp L, ftab R) := transform
	self.fo_small_count := R.cnt;
	self := L;
end;

hw_name2 := join(hwn1_ddp,ftab,left.prim_range = right.prim_range and
					left.prim_name = right.prim_name and
					left.sec_range = right.sec_range and
					left.zip = right.zip and
					left.fname = right.fname,
					add_fname_cnt(LEFT,RIGHT),local,left outer);


hwn_dist := distribute(hw_name2,hash(fname,lname)) : persist('persist::na_slimsort_3');

nfreqs := header.FullName_Frequencies;

addressp_plus adjust_scores(hwn_dist L, nfreqs R) := transform
	self.frequent := if (r.percentage * L.did_cnt >= 1, true,false);
	self.fl_nosec_count := L.fl_nosec_count + if (self.frequent,1,0);
	self.fl_sec_count := L.fl_sec_count + if(self.frequent,1,0);
	self.fl_st_count := L.fl_st_count + if(self.frequent,1,0);
	self.fl_pz_count := L.fl_pz_count + if(self.frequent,1,0);
	self.fmls_nosec_count := L.fmls_nosec_count + if (self.frequent,1,0);
	self.fmls_sec_count := L.fmls_sec_count + if(self.frequent,1,0);
	self := L;
end;

dt_adj := join(hwn_dist, nfreqs,left.fname = right.fname and 
					left.lname = right.lname,adjust_scores(LEFT,RIGHT),left outer,local);

addressp strip_plus(addressp_plus L) := transform
	self := L;
end;

prev_name_address := project(dt_adj,strip_plus(LEFT));

snz := header_slimsort.Safe_Name_Zips;

// 0 = unsafe, 1 = only 1 in country, 2 = only one in 100 mile radius
header_slimsort.layout_name_address addsafe(prev_name_address l, snz r) := transform
	self.safe_name_zip := if(r.zip = '', 0, if (r.namecount = 1, 1, 2));
	self := l;
end;

df := join(distribute(prev_name_address, hash(trim((string)fname), trim((string)lname))),
			  snz,
			  left.fname = right.fname and 
			  left.lname = right.lname and 
			  left.did = right.did and
			  left.zip = right.zip,
			  addsafe(left, right), left outer, local);

// fix for middle intial and blank middles.

g1 := df(length(trim(mname)) > 1);
g2 := df(length(trim(mname)) = 1) : persist('cjmtemp::HSS_workaround1'); // temp fix
g3 := df(length(trim(mname)) = 0);

df j1(g1 L, g2 R) := transform
	self.fmls_nosec_count := L.fmls_nosec_count + R.fmls_nosec_count;
	self.fmls_sec_count := if (L.sec_range = r.sec_range,L.fmls_sec_count + R.fmls_sec_count,L.fmls_sec_count);
	self := l;
end;

m1 := join(g1,g2,left.mname[1] = right.mname[1] and 
			  left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.prim_range = right.prim_range and
			  left.prim_name = right.prim_name and
			  left.zip = right.zip,
			  j1(LEFT,RIGHT),left outer,local);

m1d := dedup(sort(m1,lname,fname,mname,name_suffix,prim_range,prim_name,sec_range,zip,did,-fmls_nosec_count,-fmls_sec_count,local),
			lname,fname,mname,name_suffix,prim_range,prim_name,sec_range,zip,did,local);

m2 := join(m1d,g3,left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.prim_range = right.prim_range and
			  left.prim_name = right.prim_name and
			  left.zip = right.zip,
			  j1(LEFT,RIGHT),left outer,local);

m2d := dedup(sort(m2,lname,fname,mname,name_suffix,prim_range,prim_name,sec_range,zip,did,-fmls_nosec_count,-fmls_sec_count,local),
		lname,fname,mname,name_suffix,prim_range,prim_name,sec_range,zip,did,local); // full mid names are done here



//----------[ Single Initial ]----------------------

g1_ddp_sec := dedup(sort(g1,lname,fname,mname[1],name_suffix,prim_range,prim_Name,sec_range,zip,did,local),
					lname,fname,mname[1],name_suffix,prim_range,prim_Name,sec_range,zip,did,local);

g1_ddp_nosec := dedup(sort(g1,lname,fname,mname[1],name_suffix,prim_range,prim_Name,zip,did,local),
					lname,fname,mname[1],name_suffix,prim_range,prim_Name,zip,did,local);

g1rec_sec := record
	g1_ddp_sec.lname;
	g1_ddp_Sec.fname;
	string1 mi := g1_ddp_Sec.mname[1];
	g1_ddp_sec.name_suffix;
	g1_ddp_Sec.prim_range;
	g1_ddp_Sec.prim_name;
	g1_ddp_Sec.sec_range;
	g1_ddp_sec.zip;
	unsigned2 cnt := count(GROUP);
end;

g1rec_nosec := record
	g1_ddp_nosec.lname;
	g1_ddp_nosec.fname;
	string1 mi := g1_ddp_nosec.mname[1];
	g1_ddp_nosec.name_suffix;
	g1_ddp_nosec.prim_range;
	g1_ddp_nosec.prim_name;
	g1_ddp_nosec.zip;
	unsigned2 cnt := count(GROUP);
end;

g1tab_nosec := table(g1_ddp_nosec,g1rec_nosec,fname,lname,mname[1],name_suffix,prim_Range,prim_name,zip,local);
g1tab_sec := table(g1_ddp_sec,g1rec_sec,fname,lname,mname[1],name_suffix,prim_Range,prim_name,sec_range,zip,local);

g2 j2(g2 L, g1tab_nosec R) := transform
	self.fmls_nosec_count := L.fmls_nosec_count + R.cnt;
	self := L;
end;

g2 j3(g2 L, g1tab_sec R) := transform
	self.fmls_sec_count := L.fmls_sec_count + R.cnt;
	self := L;
end;

m3 := join(g2,g1tab_nosec,left.mname[1] = right.mi and 
			  left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.prim_range = right.prim_range and
			  left.prim_name = right.prim_name and
			  left.zip = right.zip,
			  j2(LEFT,RIGHT),left outer,local);
			  
m3b := join(m3,g1tab_sec,left.mname[1] = right.mi and 
			  left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.prim_range = right.prim_range and
			  left.prim_name = right.prim_name and
			  left.sec_range = right.sec_range and
			  left.zip = right.zip,
			  j3(LEFT,RIGHT),left outer,local);			  

m4 := join(m3b,g3,left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.prim_range = right.prim_range and
			  left.prim_name = right.prim_name and
			  left.zip = right.zip,
			  j1(LEFT,RIGHT),left outer,local);

m4d := dedup(sort(m4,lname,fname,mname,name_suffix,prim_range,prim_name,sec_range,zip,did,-fmls_sec_count,-fmls_nosec_count,local),
			lname,fname,mname,name_suffix,prim_range,prim_name,sec_range,zip,did,local); // mid initials are done here

//-----------------[ Blank Middles ]-------------------

g1_ddp_sec_2 := dedup(sort(g1,lname,fname,name_suffix,prim_range,prim_Name,sec_range,zip,did,local),
					lname,fname,name_suffix,prim_range,prim_Name,sec_range,zip,did,local);

g1_ddp_nosec_2 := dedup(sort(g1,lname,fname,name_suffix,prim_range,prim_Name,zip,did,local),
					lname,fname,name_suffix,prim_range,prim_Name,zip,did,local);


g1rec_sec_2 := record
	g1_ddp_sec_2.lname;
	g1_ddp_sec_2.fname;
	g1_ddp_sec_2.name_suffix;
	g1_ddp_sec_2.prim_range;
	g1_ddp_sec_2.prim_name;
	g1_ddp_sec_2.sec_range;
	g1_ddp_sec_2.zip;
	unsigned2 cnt := count(GROUP);
end;

g1rec_nosec_2 := record
	g1_ddp_nosec_2.lname;
	g1_ddp_nosec_2.fname;
	g1_ddp_nosec_2.name_suffix;
	g1_ddp_nosec_2.prim_range;
	g1_ddp_nosec_2.prim_name;
	g1_ddp_nosec_2.zip;
	unsigned2 cnt := count(GROUP);
end;

g1tab_nosec_2 := table(g1_ddp_nosec_2,g1rec_nosec_2,fname,lname,name_suffix,prim_Range,prim_name,zip,local);
g1tab_sec_2 := table(g1_ddp_sec_2,g1rec_sec_2,fname,lname,name_suffix,prim_Range,prim_name,sec_range,zip,local);

g2 j4(g3 L, g1tab_nosec_2 R) := transform
	self.fmls_nosec_count := L.fmls_nosec_count + R.cnt;
	self := L;
end;

g2 j5(g3 L, g1tab_sec_2 R) := transform
	self.fmls_sec_count := L.fmls_sec_count + R.cnt;
	self := L;
end;

m5 := join(g3,g1tab_nosec_2,left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.prim_range = right.prim_range and
			  left.prim_name = right.prim_name and
			  left.zip = right.zip,
			  j4(LEFT,RIGHT),left outer,local);
			  
m5b := join(m5,g1tab_sec_2,left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.prim_range = right.prim_range and
			  left.prim_name = right.prim_name and
			  left.sec_range = right.sec_range and
			  left.zip = right.zip,
			  j5(LEFT,RIGHT),left outer,local);			  

g2_ddp_sec := dedup(sort(g2,lname,fname,name_suffix,prim_range,prim_Name,sec_range,zip,did,local),
					lname,fname,name_suffix,prim_range,prim_Name,sec_range,zip,did,local);

g2_ddp_nosec := dedup(sort(g2,lname,fname,name_suffix,prim_range,prim_Name,zip,did,local),
					lname,fname,name_suffix,prim_range,prim_Name,zip,did,local);

g2rec_sec := record
	g2_ddp_sec.lname;
	g2_ddp_sec.fname;
	g2_ddp_sec.name_suffix;
	g2_ddp_sec.prim_range;
	g2_ddp_sec.prim_name;
	g2_ddp_sec.sec_range;
	g2_ddp_sec.zip;
	unsigned2 cnt := count(GROUP);
end;

g2rec_nosec := record
	g2_ddp_nosec.lname;
	g2_ddp_nosec.fname;
	g2_ddp_nosec.name_suffix;
	g2_ddp_nosec.prim_range;
	g2_ddp_nosec.prim_name;
	g2_ddp_nosec.zip;
	unsigned2 cnt := count(GROUP);
end;

g2tab_nosec := table(g2_ddp_nosec,g2rec_nosec,fname,lname,name_suffix,prim_Range,prim_name,zip,local);
g2tab_sec := table(g2_ddp_sec,g2rec_sec,fname,lname,name_suffix,prim_Range,prim_name,sec_range,zip,local);

g2 j6(g3 L, g2tab_nosec R) := transform
	self.fmls_nosec_count := L.fmls_nosec_count + R.cnt;
	self := L;
end;

g2 j7(g3 L, g2tab_sec R) := transform
	self.fmls_sec_count := L.fmls_sec_count + R.cnt;
	self := L;
end;

m6 := join(m5b,g2tab_nosec,left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.prim_range = right.prim_range and
			  left.prim_name = right.prim_name and
			  left.zip = right.zip,
			  j6(LEFT,RIGHT),left outer,local);
			  
m6b := join(m6,g2tab_sec,left.fname = right.fname and
			  left.lname = right.lname and
			  left.name_suffix = right.name_suffix and
			  left.prim_range = right.prim_range and
			  left.prim_name = right.prim_name and
			  left.sec_range = right.sec_range and
			  left.zip = right.zip,
			  j7(LEFT,RIGHT),left outer,local);			  

final0 := m2d + m4d + m6b;


final0 strip_probationary(final0 L, header_slimsort.Table_DID_OnProbation R) := transform
	self := L;
end;

final1 := join(final0,header_slimsort.Table_DID_OnProbation,left.did = right.did, strip_Probationary(LEFT,RIGHT),
			left only,hash);


final2 := distribute(final1(did != 0),
			   hash((string)prim_name,(string)prim_range,(string)lname));//(string)header_slimsort.ZipState((string5)zip,(string2)st)));

final := sort(final2,prim_name,prim_range,lname,local);


export name_address := final : Persist('headerbuild_hss_name_addr');
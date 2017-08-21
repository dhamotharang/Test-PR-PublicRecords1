import doxie,ut, watchdog;
do_counts :=true;
do_outputs:=false;

// DEFINE GENDER/AGE HERE!
gender_set := ['M','U','',' '];
unsigned1 age_l := 0;	
unsigned1 age_h := 100;

get_one_zip(string5 p_zip, 
			unsigned1 p_radius, 
			unsigned8 p_date_l,
			unsigned8 p_date_h, 
			set of string p_gender_set, 
			unsigned1 p_age_l=0,
			unsigned1 p_age_h=100) 
	:= function
	import ut;
	TheKey := doxie.key_troy;
	result1 := 
		TheKey(zip IN ziplib.zipswithinradius(p_zip,p_radius),
				ut.date_overlap(first_seen,last_seen,p_date_l,p_date_h)>0,
				gender in p_gender_set,
				(age=0 or age>=p_age_l),
                age<=p_age_h,
				ut.zip_dist(p_zip,(string5) zip)<=p_radius);	// this does nothing now! use latlong difference from centroid???
	return result1;
end;

sp(string s) := if ( trim(s)<>'',trim(s)+' ','' );

unsigned3 get_header_first_seen(doxie.key_header L) := MAP ( l.dt_first_seen > 0 and ( l.dt_first_seen < l.dt_vendor_first_reported or l.dt_vendor_first_reported=0 )=> l.dt_first_seen,
           l.dt_vendor_first_reported > 0 => l.dt_vendor_first_reported,
           l.dt_vendor_last_reported > 0 and l.dt_vendor_last_reported < l.dt_last_seen => l.dt_vendor_last_reported,
           l.dt_last_seen );

unsigned3 get_header_last_seen(doxie.key_header L) :=  MAP ( l.dt_last_seen > 0 and l.dt_last_seen > l.dt_vendor_last_reported => l.dt_last_seen,
           l.dt_vendor_last_reported > 0 => l.dt_vendor_last_reported,
           l.dt_vendor_first_reported > l.dt_first_seen => l.dt_vendor_first_reported,
           l.dt_first_seen);

HdrKey := doxie.Key_Header;
best := distribute(watchdog.File_Best,hash(did));


// DEFINE ZIPS/DATES HERE!
md_va_1 := get_one_zip('20745',20,199701,200112,gender_set,age_l,age_h);
md_va_2 := get_one_zip('20746',20,199701,200112,gender_set,age_l,age_h);
md_va_3 := get_one_zip('20747',20,199701,200112,gender_set,age_l,age_h);
md_va_4 := get_one_zip('20748',20,199701,200112,gender_set,age_l,age_h);
md_va_5 := get_one_zip('20783',20,199701,200112,gender_set,age_l,age_h);
md_va_6 := get_one_zip('22303',20,199701,200112,gender_set,age_l,age_h);
md_va_7 := get_one_zip('22308',20,199701,200112,gender_set,age_l,age_h);
md_va_8 := get_one_zip('22312',20,199701,200112,gender_set,age_l,age_h);
md_va_9 := get_one_zip('20176',20,200102,200108,gender_set,age_l,age_h);
md_va   := dedup(sort(distribute(md_va_1+md_va_2+md_va_3+md_va_4+md_va_5+md_va_6+md_va_7+md_va_8+md_va_9,hash(did)),did,local),did,local);
c_md_va := output(count(md_va),named('md_va'));

prince_william_va_1   := get_one_zip('22193',20,200901,201001,gender_set,age_l,age_h);
prince_william_va 	  := dedup(sort(distribute(prince_william_va_1,hash(did)),did,local),did,local);
c_prince_william_va := output(count(prince_william_va),named('prince_william_va'));

ct_1 := get_one_zip('06521',20,200606,200703,gender_set,age_l,age_h);
ct_2 := get_one_zip('06523',20,200606,200703,gender_set,age_l,age_h);
ct   := dedup(sort(distribute(ct_1+ct_2,hash(did)),did,local),did,local);
c_ct := output(count(ct),named('ct'));

ri_1   := get_one_zip('02921',20,200606,200703,gender_set,age_l,age_h);
ri 	   := dedup(sort(distribute(ri_1,hash(did)),did,local),did,local);
c_ri := output(count(ri),named('ri'));

recordof(doxie.Key_Troy)  to_join(recordof(doxie.Key_Troy) l, recordof(doxie.Key_Troy) r) := transform
	self.did := l.did;
	self := [];
	end;
md_va_J_ct_ri := join(md_va,ct+ri,left.did=right.did,to_join(left,right),local, keep(1));
c_md_va_J_ct_ri := output(count(md_va_J_ct_ri),named('md_va_J_ct_ri'));

md_va_J_ct_ri_J_prince_william_va := join(md_va_J_ct_ri,prince_william_va,left.did=right.did,to_join(left,right),local, keep(1));
c_md_va_J_ct_ri_J_prince_william_va := output(count(md_va_J_ct_ri_J_prince_william_va),named('md_va_J_ct_ri_J_prince_william_va'));

// DEFINE SELECTED RESULT HERE!
candidates := md_va_J_ct_ri_J_prince_william_va;

layout_with_crim := record
	recordof(candidates);
	unsigned2 crim_records;
	end;
layout_with_crim take_lu(candidates le, doxie.Key_Did_Lookups ri) := transform
	self.crim_records := ri.crim_cnt+ri.sex_cnt;	
	self := le;
end;  
candidates_with_crim := join(candidates,doxie.key_did_lookups,left.did=right.did,take_lu(left,right),left outer);		   

hres := record
  unsigned1 crim_records;
  unsigned6 did;
  unsigned4 first_seen;
  unsigned4 last_seen;
  string10  phone;
  string9   ssn;
  integer4  dob;
  integer4 dod;
  string120 name;
  string120 addr1;
  string120 addr2;
  end;

hres add_header(candidates_with_crim l, doxie.Key_Header r) := transform
  self.crim_records := l.crim_records;
  self.did := l.did;
  self.dod := r.dod;
  self.first_seen := get_header_first_seen(r);
  self.last_seen := get_header_last_seen(r);
  self.name := sp(r.title)+sp(r.fname)+sp(r.mname)+sp(r.lname)+sp(r.name_suffix);
  self.addr1 := sp(r.prim_range)+sp(r.predir)+sp(r.prim_name)+sp(r.suffix)+sp(r.postdir)+sp(r.unit_desig)+sp(r.sec_range);
  self.addr2 := sp(r.city_name)+sp(r.st)+sp(r.zip);
  self := r;
  end;
with_hdr := JOIN(candidates_with_crim,doxie.Key_Header,left.did=right.s_did,add_header(left,right));

recordof(with_hdr) to_overwrite_with_best(with_hdr l, best r) := transform
    self.name := sp(r.title)+sp(r.fname)+sp(r.mname)+sp(r.lname)+sp(r.name_suffix);
	self.dob := r.dob;
	self.dod := (integer) r.dod;
	self.ssn := r.ssn;
	self := l;
	end;
with_best := join(with_hdr,best,left.did=right.did,to_overwrite_with_best(left,right),local);

dst_with_hdr := distribute(with_best, hash(did));
srt_with_hdr := sort(dst_with_hdr, except first_seen, last_seen	, local);
grp_with_hdr := group(srt_with_hdr, except first_seen, last_seen , local);

hres roll_them(grp_with_hdr l, grp_with_hdr r) := transform
	self.first_seen := if((l.first_seen < r.first_seen) and l.first_seen<>0, l.first_seen, r.first_seen);
	self.last_seen  := if(l.last_seen  > r.last_seen,  l.last_seen,  r.last_seen);
	self := l;
end;
rolled_with_hdr:= rollup(grp_with_hdr, roll_them(left, right), except first_seen, last_seen);


last_hdr := dedup(sort(distribute(rolled_with_hdr,hash(did)),did,-last_seen,local),did,local);

o_with_header := output(sort(rolled_with_hdr,did,-last_seen),,'~thor::out::dc_ne_serial_killer_history',csv(heading(0),separator('|'),terminator('\r\n')));
o_last_header := output(last_hdr,,'~thor::out::dc_ne_serial_killer_individuals',csv(heading(0),separator('|'),terminator('\r\n')));

export troy_graves_dc_ne := sequential(
#if(do_counts)
	c_md_va
	,c_ct
	,c_ri
	,c_prince_william_va
	,c_md_va_J_ct_ri
	,c_md_va_J_ct_ri_J_prince_william_va);
#elseif(do_outputs)
	o_with_header
	,o_last_header);
#end

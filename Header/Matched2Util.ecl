import utilfile, ut, mdr, lib_datalib;

//***** Set the flag where the name_Address is safe
head   := header.file_headers(header.Blocked_data());
nmaddr := utilfile.well_behaved_name_address;

head_fat_rec := record
	head;
	boolean well_behaved := false;
end;

na_dist   := distribute(nmaddr,             hash(trim(prim_range),trim(prim_name),trim(zip)));
head_dist := distribute(head(prim_name<>''),hash(trim(prim_range),trim(prim_name),trim(zip)));

//people who match well_behaved records get a w_b flag set.....note left outer join
head_fat_rec flagit(head_dist l, na_dist r) := transform
 self.well_behaved := r.prim_name <> '';
 self              := l;
end;

flagged := join(head_dist,na_dist, 
				left.fname      = right.fname      and 
				left.lname      = right.lname      and
				left.prim_range = right.prim_range and 
				left.prim_name  = right.prim_name  and
				left.zip        = right.zip,
				flagit(left, right),
				left outer,
				local
			   );

head_to_try0 := flagged(well_behaved or ssn<>'');
head_skip    := flagged(~well_behaved,ssn='');

head_rec_wide := record
	head_fat_rec;
	unsigned6 util_seq  := 0;
	boolean   up_date   := false;
	boolean   downdate  := false;
	boolean   addssn    := false;
	boolean   addphone  := false;
	boolean   is_preglb := false;
end;

head_rec_wide fatten(head_skip l) := transform
	self := l;
end;

head_rec_wide fatten0(head l) := transform
	self := l;
end;

head_skip_fat := project(head_skip,         fatten (left))
               + project(head(prim_name=''),fatten0(left));

util_seq  := utilfile.Sequenced;
header.MAC_555_phones(util_seq, phone, util_seq0);
util_dist := distribute(util_seq0(prim_name <> ''),hash(trim(prim_range),trim(prim_name),trim(zip)));

head_rec_wide t_glb_boolean(head_to_try0 le) := transform
 self.is_preglb  := ut.PermissionTools.glb.HeaderIsPreGLB(le.dt_nonglb_last_seen,le.dt_first_seen,le.src);
 self			 := le;
end;

head_to_try := project(head_to_try0,t_glb_boolean(left));

bphone(string10 p1, string10 p2) := 
	if((integer)p1 < (integer)p2, p2, p1);

head_rec_wide tra_na(head_to_try l, util_dist r) := transform

    boolean rec_is_eq := l.src='EQ';
	
    string9 v_ssn := if(l.ssn = '', r.ssn, l.ssn);
	
	self.ssn := v_ssn;
	self.phone := bphone(l.phone, r.phone);
	
	//original pflag3 values can get overlaid with something different on subsequent builds (e.g. X to W)
	//we want to keep the 'fuller' assignment
	
	string1 how_pflag3_is_today      := l.pflag3;
	string1 what_new_pflag3_would_be := map(r.src = 'UW' and l.ssn = '' and v_ssn <> '' => 'X',
			                                r.src = 'UW'                                => 'W',
			                                r.src = 'UT' and l.ssn = '' and v_ssn <> '' => 'U',
			                                '');
	
	self.pflag3 := 
		map(how_pflag3_is_today      ='X' and what_new_pflag3_would_be     ='W' => how_pflag3_is_today,
		    how_pflag3_is_today      ='W' and what_new_pflag3_would_be     ='X' => what_new_pflag3_would_be,
		    trim(how_pflag3_is_today)= '' and what_new_pflag3_would_be     <>'' => what_new_pflag3_would_be,
			how_pflag3_is_today      ='U' and trim(what_new_pflag3_would_be)='' => how_pflag3_is_today,
			how_pflag3_is_today
		   );

	self.dt_first_seen            := if(rec_is_eq,ut.EarliestDate(l.dt_first_seen,           r.dt_first_seen),           l.dt_first_seen);
	self.dt_last_seen             := if(rec_is_eq,ut.LatestDate  (l.dt_last_seen,            r.dt_last_seen),            l.dt_last_seen);
	self.dt_vendor_first_reported := if(rec_is_eq,ut.EarliestDate(l.dt_vendor_first_reported,r.dt_vendor_first_reported),l.dt_vendor_first_reported);
	self.dt_vendor_last_reported  := if(rec_is_eq,ut.LatestDate  (l.dt_vendor_last_reported, r.dt_vendor_last_reported), l.dt_vendor_last_reported);
	self.dt_nonglb_last_seen      := if(~l.is_preglb, l.dt_nonglb_last_seen,     if(rec_is_eq,ut.LatestDate  (l.dt_nonglb_last_seen,     r.dt_nonglb_last_seen),     l.dt_nonglb_last_seen));
	self.util_seq := r.uid;
	self.up_date  := self.dt_last_seen  > l.dt_last_seen;
	self.downdate := self.dt_first_seen < l.dt_first_seen;
	self.addssn   := self.ssn           > l.ssn;
	self.addphone := self.phone         > l.phone;
	self          := l;
end;

phones_match(string p1, string p2) := 
	p1 = '' or p2 = '' or
	(integer)p1 = 0 or (integer)p2 = 0 or
	p1 = p2 or 
	stringlib.stringfind(p1, p2, 1) > 0 or
	stringlib.stringfind(p2, p1, 1) > 0;

na_match1 := join(head_to_try(ssn<>''), util_dist(ssn<>''), 
				  left.prim_range = right.prim_range                  and
				  left.prim_name  = right.prim_name                   and
				  left.zip        = right.zip                         and
				  ut.NNEQ(left.sec_range, right.sec_range)            and
				  ut.NNEQ_Suffix(left.name_suffix, right.name_suffix) and
			      phones_match(left.phone, right.phone)               and
                  (left.ssn=right.ssn and datalib.DoNamesMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname,3)<3),
                  tra_na(left,right),
				  left outer,
				  local
				 );

na_match2 := join(head_to_try(well_behaved), util_dist, 
				  left.prim_range = right.prim_range                  and
				  left.prim_name  = right.prim_name                   and
				  left.zip        = right.zip                         and
				  ut.NNEQ(left.sec_range, right.sec_range)            and
				  ut.NNEQ_Suffix(left.name_suffix, right.name_suffix) and
			      phones_match(left.phone, right.phone)               and
                  (ut.NNEQ(left.ssn,right.ssn) and datalib.DoNamesMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname,2)<2),
				  tra_na(left,right),
				  left outer,
				  local
				 );

na_match := na_match1 + na_match2;

r_srt := record
 na_match;
 integer sort_order;
end;

r_srt t1(na_match le) := transform
 self.sort_order := if(le.ssn<>'',1,2);
 self            := le;
end;

p1 := project(na_match,t1(left));

na_srtd := sort(p1, rid, -dt_last_seen, sort_order, local);	
na_ddpd := dedup(na_srtd, rid, local);

drop_sort_order := project(na_ddpd,recordof(na_match));

export Matched2Util := head_skip_fat + drop_sort_order : persist('headerbuild_util_na_match');
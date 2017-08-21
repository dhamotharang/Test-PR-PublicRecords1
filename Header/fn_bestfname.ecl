import watchdog, NID,ut;
export fn_bestfname(dataset(recordof(header.layout_header)) in_hdr) := function

f := in_hdr;

rfields := record
unsigned6    did;
qstring20    fname;
integer4     fname_count := 0;
end;

rfields slim(f le) := transform
self.fname := trim(le.fname);
self := le;
  end;

slim_h := project(f(fname<>''),slim(left));

//Sort by DID and fname
srt_h := sort(slim_h(fname <> ''),did,fname,local);

//Group by DID and fname
grp := group(srt_h,did,fname,local);

//Count the occurrances of each DID and fname combination
rfields cnt_fname(rfields le, rfields rt) := transform
self.fname_count := le.fname_count + 1;
self := rt;
  end;

fname_did_cnt := iterate(grp,cnt_fname(left,right));

//Sort and dedup by fname to give one record per DID/fname with the highest count
cnt_dedup := dedup(sort(fname_did_cnt,-fname_count),fname);

//Ungroup and resort
group_sort := sort(group(cnt_dedup),did,-fname_count,local);

//Dedup by DID keeping the top two most frequent
two_DID := dedup(group_sort,did,keep 2,local);

//If fname count is 1.5x greater than the next, it is 'best'
rfields fname_join(rfields le, rfields rt) := transform
self.fname := MAP(length(trim(le.fname)) = 1 and le.fname[1] = rt.fname[1] => rt.fname,
				  length(trim(rt.fname)) = 1 and le.fname[1] = rt.fname[1] => le.fname,
				  NID.PreferredFirstVersionedStr(le.fname, NID.version) = rt.fname => rt.fname,
				  NID.PreferredFirstVersionedStr(rt.fname, NID.version) = le.fname => le.fname,
				  le.fname_count < 1.2*rt.fname_count => '',le.fname);
self := le;
end;

join_cnt := join(two_DID,two_DID,left.did=right.did and
					left.fname <> right.fname,fname_join(left,right),left outer,local);		

//sort and dedup by did
sorted_duped := dedup(sort(join_cnt,did,-fname_count,-fname,local),did,local);		

//output only the 'best' fname records (at most one per DID)
BestFirstName_sub1 := sorted_duped(fname <> '') : Persist('~thor_data400::persist::Watchdog_BestFirstName_sub1');

bfn := bestfirstname_sub1(fname = '');

f extract_subset(f L, bfn R) := transform
	self := L;
end;

f0 := join(f,bfn,left.did = right.did,extract_subset(LEFT,RIGHT),hash);

rfields1 := record
unsigned6    	did;
qstring20    	fname;
qstring20		lname;
integer4     	fname_count := 0;
unsigned1		mult := 1;
end;

rfields1 slim1(f0 le) := transform
self.fname := trim(le.fname);
self.lname := trim(le.lname);
self := le;
  end;

slim_h1 := project(f0(fname<>''),slim1(left));

bls1 := header.fn_bestlname(f);

slim_h1 calc_mult(slim_h1 L,bls1 R) := transform
	self.mult := if(l.lname = r.lname, 2,1);
	self := L;
end;

slim_h2 := join(slim_h1, bls1, left.did = right.did,calc_mult(LEFT,RIGHT),hash);

//Sort by DID and fname
srt_h1 := sort(slim_h2(fname <> ''),did,fname,local);

//Group by DID and fname
grp1 := group(srt_h1,did,fname,local);

//Count the occurrances of each DID and fname combination
rfields1 cnt_fname1(rfields1 le, rfields1 rt) := transform
self.fname_count := le.fname_count + 1;
self := rt;
  end;

pre_fname_did_cnt := iterate(grp1,cnt_fname1(left,right));

rfields1 mult_cnt (pre_fname_did_cnt L) := transform
	self.fname_count := L.fname_count * l.mult;
	self := L;
end;

fname_did_cnt1 := project(pre_fname_did_cnt,mult_cnt(LEFT));

//Sort and dedup by fname to give one record per DID/fname with the highest count
cnt_dedup1 := dedup(sort(fname_did_cnt1,-fname_count),fname);

//Ungroup and resort
group_sort1 := sort(group(cnt_dedup1),did,-fname_count,local);

//Dedup by DID keeping the top two most frequent
two_DID1 := dedup(group_sort1,did,keep 2,local);

//If fname count is 1.5x greater than the next, it is 'best'
rfields1 fname_join1(rfields1 le, rfields1 rt) := transform
self.fname := MAP(length(trim(le.fname)) = 1 and le.fname[1] = rt.fname[1] => rt.fname,
				  length(trim(rt.fname)) = 1 and le.fname[1] = rt.fname[1] => le.fname,
				  NID.PreferredFirstVersionedStr(le.fname, NID.version) = rt.fname => rt.fname,
				  NID.PreferredFirstVersionedStr(rt.fname, NID.version) = le.fname => le.fname,
				  le.fname_count < 1.2*rt.fname_count => '',le.fname);
self := le;
end;

join_cnt1 := join(two_DID1,two_DID1,left.did=right.did and
					left.fname <> right.fname,fname_join1(left,right),left outer,local);		

//sort and dedup by did
sorted_duped1:= dedup(sort(join_cnt1,did,-fname_count,-fname,local),did,local);		

rfields_out := record
unsigned6    did;
qstring20    fname;
integer4     fname_count;
end;

rfields_out into_out(sorted_duped1 L) := transform
	self := l;
end;

//output only the 'best' fname records (at most one per DID)
BestFirstName_sub2 := project(sorted_duped1(fname <> ''),into_out(LEFT));

best_fname := BestFirstName_sub1 + BestFirstName_sub2 : persist('~thor_data400::persist::watchdog_bestfname');
return best_fname;
end;

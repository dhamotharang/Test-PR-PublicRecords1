import header,mdr;

f0 := file_header_filtered;
bfn := bestfirstname_sub1(fname = '');

f0 extract_subset(f0 L, bfn R) := transform
	self := L;
end;

f := join(f0,bfn,left.did = right.did,extract_subset(LEFT,RIGHT),hash);

rfields := record
unsigned6    	did;
qstring20    	fname;
qstring20		lname;
integer4     	fname_count := 0;
unsigned1		mult := 1;
end;

rfields slim(f le) := transform
self.fname := trim(le.fname);
self.lname := trim(le.lname);
self := le;
  end;

slim_h := project(f(fname<>''),slim(left));

bls1 := bestlastname_sub1;

slim_h calc_mult(slim_h L,bls1 R) := transform
	self.mult := if(l.lname = r.lname, 2,1);
	self := L;
end;

slim_h2 := join(slim_h, bls1, left.did = right.did,calc_mult(LEFT,RIGHT),hash);

//Sort by DID and fname
srt_h := sort(slim_h2(fname <> ''),did,fname,local);

//Group by DID and fname
grp := group(srt_h,did,fname,local);

//Count the occurrances of each DID and fname combination
rfields cnt_fname(rfields le, rfields rt) := transform
self.fname_count := le.fname_count + 1;
self := rt;
  end;

pre_fname_did_cnt := iterate(grp,cnt_fname(left,right));

rfields mult_cnt (pre_fname_did_cnt L) := transform
	self.fname_count := L.fname_count * l.mult;
	self := L;
end;

fname_did_cnt := project(pre_fname_did_cnt,mult_cnt(LEFT));

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
				  datalib.preferredfirst(le.fname) = rt.fname => rt.fname,
				  datalib.preferredfirst(rt.fname) = le.fname => le.fname,
				  le.fname_count < 1.5*rt.fname_count => '',le.fname);
self := le;
end;

join_cnt := join(two_DID,two_DID,left.did=right.did and
					left.fname <> right.fname,fname_join(left,right),left outer,local);		

//sort and dedup by did
sorted_duped := dedup(sort(join_cnt,did,-fname_count,-fname,local),did,local);		


rfields_out := record
unsigned6    did;
qstring20    fname;
integer4     fname_count;
end;

rfields_out into_out(sorted_duped L) := transform
	self := l;
end;

//output only the 'best' fname records (at most one per DID)
export BestFirstName_sub2 := project(sorted_duped(fname <> ''),into_out(LEFT));

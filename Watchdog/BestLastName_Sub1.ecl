/* Get Best Last name
Take the most recent date last seen lname (divided into quarters).  If there are multiple, take 
the recent average date first seen. Unless the namematch score difference between the two is < 2, 
then take the most frequent.  (score lname based on fname to avoid flip flopped first and last names)
*/
import header, ut, mdr;

integer8 monthsever(string6 strdate) :=
	((integer)(strdate[1..4])) * 12 + 
	((integer)(strdate[5..6]));

f := file_header_filtered(~(lname='INVEST' and src in mdr.sourceTools.set_Utility_sources));

Mac_Bucket_Dates (f, dt_last_seen, ,dt_vendor_last_reported, ,3, date_bucket, date_bucket_f)

rfields := record
unsigned6     did;
integer4      dt_first_seen;
integer4      dt_last_seen;
qstring20     lname;
end;

rfields slim(date_bucket_f le) := transform
self.dt_last_seen := le.date_bucket;
self.dt_first_seen := if(le.dt_first_seen=0,le.dt_vendor_first_reported,le.dt_first_seen);
self := le;
end;

//set the date last seen by finding how many quarters the max date is from today
slim_h := project(date_bucket_f,slim(left));

srt_h := sort(slim_h,did,lname,local);

grp := group(srt_h,did,lname,local);

cnt_zero := record
 grp.did;
 grp.lname;
 integer4 zero_cnt := count(group);
end;

zero_group := table(grp(dt_first_seen>0),cnt_zero);

//find avg dt_first_seen and count of records per DID/lname
new_rec := record
 grp.did;
 grp.lname;
 integer4 dt_last_seen := min(group,grp.dt_last_seen);
 integer4  dt_first_seen := sum(group,monthsever((string6)grp.dt_first_seen));
 integer4  lname_count := count(group);
 integer4  name_match := 0;
end;

set_count := table(grp,new_rec);

new_rec setDt(new_rec L, cnt_zero R) := transform
 self.dt_first_seen := l.dt_first_seen/r.zero_cnt;
 self := l;
end;

set_first_seen := join(set_count,zero_group,left.did=right.did and left.lname=right.lname,
						setDt(left,right),left outer, local);

//Find DIDs where fname=lname and take those out of fname compare.
same_name := dedup(sort(f(fname=lname),did,local),did,local);

new_rec same_out(new_rec L) := transform
 self := l;
end;

no_same_name := join(set_first_seen,same_name,left.did=right.did,same_out(left),left only,local);
only_same_name := join(set_first_seen,same_name,left.did=right.did,same_out(left),local);

//Find fname counts
fname_cnt := record
 f.did;
 f.fname;
 integer cnt := count(group);
end;

all_fnames := table(f,fname_cnt,did,fname,local);

new_rec fnameScore(new_rec L, fname_cnt R) := transform
 self.lname_count := if(r.did!=0,l.lname_count-r.cnt,l.lname_count);
 self := l;
end;

with_fname_score := join(no_same_name,all_fnames,left.did=right.did and left.lname=right.fname,
						fnamescore(left,right),left outer,local);

two_did := dedup(sort((with_fname_score + only_same_name)(lname_count>0),did,dt_last_seen,-dt_first_seen,-lname_count,local),did,keep 2,local);

//resort so count has higher priority then date first seen
two_did_sort := sort(two_did,did,dt_last_seen,-lname_count,-dt_first_seen,local);
grp_did := group(two_did_sort,did,local);


//determine namematch score
LowPrefix := ['AL','EL','DE','BAR','VAN','O','MC','MAC'];
ElAlMatch(string s1, string s2) := 
  ut.Tails(s1,s2) and ut.StripTail(s1,s2) IN LowPrefix or
  ut.Tails(s2,s1) and ut.StripTail(s2,s1) IN LowPrefix;

SMatch(string s1, string s2) :=
  MAP( s1=s2 => 0, 
       ut.StringSimilar(s1,s2)< 2 or ElAlMatch(s1,s2) => 1, 
       ut.Lead_Contains(s1,s2) => 1, 
       ut.stringsimilar(s1,s2) < 3 => 2, 
       ut.tails(s1,s2) or ut.tails(s2,s1) or ut.stringsimilar(s1,s2)<4 => 3, 
       99 );

new_rec name_score(new_rec le, new_rec rt) := transform
self.name_match := MAP(ut.StringSimilar(le.lname,rt.lname)< 2 or ElAlMatch(le.lname,rt.lname) => 1, 
					   ut.Lead_Contains(le.lname,rt.lname) => 1, 
					   ut.stringsimilar(le.lname,rt.lname) < 3 => 2, 
					   ut.tails(le.lname,rt.lname) or ut.tails(le.lname,rt.lname) 
						or ut.stringsimilar(le.lname,rt.lname)<4 => 3, 
					   99 );
self := rt;
end;

set_score := iterate(grp_did,name_score(left,right));

//Determine best lname based on rules above
new_rec bflag(new_rec le, new_rec rt) := transform					
self.lname := IF(le.did=0,rt.lname,
					 IF(le.dt_last_seen<>rt.dt_last_seen,
						IF(rt.name_match > 1,le.lname,
						  IF(le.lname_count > rt.lname_count,le.lname,
							IF(le.lname_count < rt.lname_count,rt.lname,
								IF(le.dt_first_seen < rt.dt_first_seen,rt.lname,
									IF(le.dt_first_seen > rt.dt_first_seen,le.lname,''))))),
						IF(rt.name_match > 1,IF(le.dt_first_seen<rt.dt_first_seen,rt.lname,
							IF(le.dt_first_seen>rt.dt_first_seen,le.lname,
								IF(le.lname_count=rt.lname_count,'',le.lname))),
							IF(le.lname_count=rt.lname_count,'',le.lname))));
self := rt;
end;

set_bflag := iterate(set_score,bflag(left,right));

//get rid of lname dups, float blanks for sub2, both non-blank keep the best
dup_lname_usl := dedup(sort(set_bflag,dt_last_seen,-lname_count,-dt_first_seen),did);
dup_lname_blk := dedup(sort(set_bflag,-dt_last_seen,lname_count,dt_first_seen),did)(lname='');

new_rec get_usl_final(dup_lname_usl l) := transform
	self := l;
end;

dup_lname := join(dup_lname_usl, dup_lname_blk, 
                  left.did=right.did, get_usl_final(left), left only, local) 
		   + dup_lname_blk; 	

export BestLastName_sub1 := dup_lname : persist('persist::Watchdog_BestLastName_sub1');


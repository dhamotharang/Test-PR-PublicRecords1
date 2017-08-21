/*Find the Best First Name
Group by DID and fname, then count the occurrences.
If the second most frequent is the 'preferredfirst' of the most frequent, pick it.
If not, pick the most frequent only if it is 1.5x as frequent as the next.
If not, don't pick any -- we don't have a 'best' fname*/

import header,mdr,NID;

f_ := file_header_filtered;
watchdog.Mac_Exclude_as_Best(f_, f, 'fname');
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
				          le.fname_count < 1.5*rt.fname_count => '',le.fname);
self := le;
end;

join_cnt := join(two_DID,two_DID,left.did=right.did and
					left.fname <> right.fname,fname_join(left,right),left outer,local);		

//sort and dedup by did
sorted_duped := dedup(sort(join_cnt,did,-fname_count,-fname,local),did,local);		

//output only the 'best' fname records (at most one per DID)
export BestFirstName_sub1 := sorted_duped : Persist('persist::Watchdog_BestFirstName_sub1');

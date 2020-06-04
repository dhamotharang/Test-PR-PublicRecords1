/*Find the Best Middle Name
Group by DID and mname, then count the occurrences.
If the second most frequent is the 'preferredfirst' of the most frequent, pick it.
If not, pick the most frequent only if it is 1.5x as frequent as the next.
If not, don't pick any -- we don't have a 'best' mname*/

import header,mdr,NID, address, ut;
suffix_set := ['II', 'III','IV', 'VII', 'VIII', 'IX', 'IV', 'JR', 'SR'];
f_ := file_header_filtered (mname<>'' and mname not in suffix_set);
watchdog.Mac_Exclude_as_Best(f_, f, 'mname') ;

rfields := record
unsigned6    did;
qstring20    mname;
integer4     mname_count := 0;
end;

rfields slim(f le) := transform
self.mname := trim(le.mname);
self := le;
  end;
alphabet := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
slim_h := project(f((stringlib.stringfilterout(trim(mname,all), alphabet) = '' and  length(trim(mname,all)) < 3 or address.persons.IsPossibleName(trim(mname,all)))),slim(left));

//Sort by DID and mname
srt_h := sort(slim_h,did,mname,local);

//Group by DID and mname
grp := group(srt_h,did,mname,local);

//Count the occurrances of each DID and mname combination
rfields cnt_mname(rfields le, rfields rt) := transform
self.mname_count := le.mname_count + 1;
self := rt;
  end;

mname_did_cnt := iterate(grp,cnt_mname(left,right));

//Sort and dedup by mname to give one record per DID/mname with the highest count
cnt_dedup := ungroup(dedup(sort(mname_did_cnt,-mname_count),mname));


//Find DIDs where mname=lname and take those out of mname compare.
same_name := dedup(sort(f(mname=lname),did,local),did,local);

rfields same_out(same_name L, cnt_dedup R) := transform
	self := R;
end;

no_same_name := join(same_name,cnt_dedup, left.did = right.did, same_out(LEFT,RIGHT),right only, local);
same_name_only := join(same_name,cnt_dedup, left.did = right.did, same_out(LEFT,RIGHT),local);

//Find fname counts
lname_cnt := record
 f.did;
 f.lname;
 integer cnt := count(group);
end;

all_lnames := table(f,lname_cnt,did,lname,local);

rfields mnameScore(rfields L, lname_cnt R) := transform
 self.mname_count := if(r.did!=0,l.mname_count div 2,l.mname_count);
 self := l;
end;

with_lname_score := join(same_name_only,all_lnames,left.did=right.did and left.mname=right.lname,
						mnamescore(left,right),left outer,local);

mname_ready := sort(with_lname_score + no_same_name,did,-mname_count,local);

//Dedup by DID keeping the top two most frequent
two_DID := dedup(mname_ready,did,keep 2,local);

//If mname count is 1.5x greater than the next, it is 'best'
rfields mname_join(rfields le, rfields rt) := transform
self.mname := MAP(length(trim(le.mname)) = 1 and le.mname[1] = rt.mname[1] => rt.mname,
				          length(trim(rt.mname)) = 1 and le.mname[1] = rt.mname[1] => le.mname,
				          NID.PreferredFirstVersionedStr(le.mname, NID.version) = rt.mname => rt.mname,
				          NID.PreferredFirstVersionedStr(rt.mname, NID.version) = le.mname => le.mname,
				          le.mname_count < 1.5*rt.mname_count => '',le.mname);
self := le;
end;

join_cnt := join(two_DID,two_DID,left.did=right.did and
					left.mname <> right.mname,mname_join(left,right),left outer,local);				

//sort and dedup by did
sorted_duped := dedup(sort(join_cnt,did,-mname_count,-mname,local),did,local);		


//output only the 'best' mname records (at most one per DID)

export BestMiddleName := sorted_duped(mname <> '') : Persist('persist::Watchdog_BestMiddleName');

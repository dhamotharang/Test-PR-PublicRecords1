/*Find the Best Name Suffix
Group by DID and suffix, then count the occurrences.
If 20% or more of the records are populated, then take the most frequent.
If there is a tie, take numbers over Jr. or Sr.
Take Sr. over Jr.*/

import header, mdr, ut;

export fn_bestsuffix(dataset(recordof(header.layout_header)) f0, string pst_sfx) := function

f := f0(~ut.is_unk(name_suffix));

rfields := record
 f.did;
 integer4 suffix_count := AVE(group,IF(f.name_suffix<>'',100,0));
end;

with_suffix := table(f,rfields,did,local);

new_rec := record
 f.did;
 qstring5 name_suffix := ut.fGetSuffix(f.name_suffix);
 integer4 cnt := count(group);
end;

group_count := table(f,new_rec,did,ut.fGetSuffix(name_suffix),local);

new_rec getCount(new_rec L, rfields r) := transform
 self := l;
end;

slim_h := join(group_count(name_suffix<>''),with_suffix(suffix_count>19),left.did=right.did,getCount(left,right),local);

//Sort by DID and suffix
srt_h := sort(slim_h,did,-cnt,name_suffix,local);

//Dedup by DID keeping the top two most frequent
two_DID := dedup(srt_h,did,keep 2,local);

//Pick the best
new_rec suffix_join(new_rec le, new_rec rt) := transform
self.name_suffix := MAP(le.cnt > rt.cnt => le.name_suffix,
						le.name_suffix[1..2]='Jr' => rt.name_suffix,le.name_suffix);
self := le;
end;

join_cnt := join(two_DID,two_DID,left.did=right.did and
					left.name_suffix <> right.name_suffix,suffix_join(left,right),left outer,local);		

boolean NoPersist := header.DoSkipPersist(pst_sfx);

//sort and dedup by did
sorted_dupd     := dedup(sort(join_cnt,did,-cnt,name_suffix,local),did,local);
sorted_dupd_pst := sorted_dupd : persist('persist::watchdog_BestSuffix'+pst_sfx);

outf := if(NoPersist, sorted_dupd, sorted_dupd_pst);

return outf;

end;
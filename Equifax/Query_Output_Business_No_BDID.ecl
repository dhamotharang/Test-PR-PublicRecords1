f := Equifax.business_prep;

layout_slim := record
f.cid;
f.pid;
f.bdid;
end;

fslim := table(f(bdid <> 0), layout_slim);
fslim_dedup := dedup(fslim, cid, pid, bdid, all);

layout_stat := record
fslim_dedup.cid;
fslim_dedup.pid;
bdid_cnt := count(group);
end;

fstat := table(fslim_dedup, layout_stat, cid, pid, few);

// output records which did not bdid
Equifax.Layout_Business_Clean SelectNoBDID(Equifax.Layout_Business_Clean l, layout_stat r) := transform
self := l;
end;

fnobdid := join(f,
                fstat,
				left.cid = right.cid and
				  left.pid = right.pid,
				SelectNoBDID(left, right),
				left only,
				lookup);
				
fnobdid_sort := sort(fnobdid, cid, pid);

output(choosen(fnobdid_sort,5000));

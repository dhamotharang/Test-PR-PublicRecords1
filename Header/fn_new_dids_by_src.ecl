import mdr, header, Strata;

export fn_new_dids_by_src(
dataset(recordof(header.Layout_Header)) ds_new,
dataset(recordof(header.Layout_Header)) ds_previous
)
 := 
function

prev_max_rid := mdr.fn_max_rid(ds_previous(not header.isDemoData()));
new_dids     := ds_new(did>prev_max_rid);

r1 := record
 new_dids.src;
 count_ := count(group);
end;

rsNewDidsBySource := sort(table(new_dids, r1, src, few), -count_);
Strata.modOrbitAdaptersForPersonHdrBld.fnGetNewDidsAction(rsNewDidsBySource, header.version_build);
t1 := output(rsNewDidsBySource, all, named('new_dids_by_source'));

return t1;

end;
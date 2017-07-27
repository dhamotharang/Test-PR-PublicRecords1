#workunit ('name', 'Business Header GroupID Distribution Stats ' + Business_Header.version);

bh := Business_Header.File_Super_Group;

// Count Unique BDIDs in the Business Header file
layout_bh_slim := record
bh.group_id;
end;

bh_slim := table(bh, layout_bh_slim);

layout_bh_stat := record
bh_slim.group_id;
cnt := count(group);
end;

bh_stats := table(bh_slim, layout_bh_stat, group_id);

count(bh_stats);  // number of unique bdids


output(topn(bh_stats, 1000,-cnt),all);
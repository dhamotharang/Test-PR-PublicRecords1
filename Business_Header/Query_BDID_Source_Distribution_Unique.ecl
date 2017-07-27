bh := Business_Header.File_Business_Header;

// Count records by source type in the Business Header file
layout_bh_slim := record
bh.source;
bh.bdid;
end;

bh_slim := table(bh, layout_bh_slim);
bh_slim_dedup := dedup(bh_slim, source, bdid, all);

layout_bh_stat := record
bh_slim_dedup.source;
cnt := count(group);
end;

bh_stats := table(bh_slim_dedup, layout_bh_stat, source, few);

bh_stats_sort := sort(bh_stats, source);

output(bh_stats_sort);
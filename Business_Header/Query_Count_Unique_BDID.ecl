#workunit ('name', 'Business Header Bdid Unique Count ' + Business_Header.version);

bh := Business_Header.File_Business_Header;

// Count Unique BDIDs in the Business Header file
layout_bh_slim := record
bh.bdid;
end;

bh_slim := table(bh, layout_bh_slim);

layout_bh_stat := record
bh_slim.bdid;
cnt := count(group);
end;

bh_stats := table(bh_slim, layout_bh_stat, bdid);

bh_stats_sort := sort(bh_stats(cnt > 10), -cnt);

output(count(bh_stats)								,named('UniqueBdids'));
output(choosen(bh_stats_sort, 1000)	,named('BdidsWithMostRecords'));
bc := Business_Header.File_Business_Contacts;

// Count records by source type in the Business Contacts file
layout_bc_slim := record
bc.source;
bc.bdid;
end;

bc_slim := table(bc(from_hdr='N'), layout_bc_slim);

layout_bc_stat := record
bc_slim.source;
cnt := count(group);
end;

bc_source_stats := table(bc_slim, layout_bc_stat, source, few);

bc_source_stats_sort := sort(bc_source_stats, source);

output(bc_source_stats_sort);
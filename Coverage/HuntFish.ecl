 /* W20080314-152424
 Hunt Fish
 */
 
 //Hunters and fishers Phase-1 Status
ds := eMerges.file_hunters_out;

layout_stats := record
   ds.source_state;
   total_cnt := count(group);
   file_acquired_date_min  := min(group, ds.file_acquired_date);
   file_acquired_date_max  := max(group, ds.file_acquired_date);
   datelicense_min   := min(group, ds.datelicense);
   datelicense_max   := max(group, ds.datelicense);
   regdate_min       := min(group, ds.regdate);
   regdate_max       := max(group, ds.regdate);
   dt_first_seen_min := min(group, ds.date_first_seen);
   dt_last_seen_max  := max(group, ds.date_last_seen);
end;

out_stats := table(ds((integer)trim(datelicense) > 19840101), layout_stats, source_state, few);
output(sort(out_stats,source_state));

out_stats2 := table(ds((integer)trim(file_acquired_date) > 19000101), layout_stats, source_state, few);
output(sort(out_stats2,source_state));

out_stats3 := table(ds((integer)trim(regdate) > 19000101), layout_stats, source_state, few);
output(sort(out_stats3,source_state));
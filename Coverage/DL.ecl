/* W20080314-135139
DL
*/

// Phase-1 status for Drivers License.
ds := DriversV2.File_DL;

layout_stats := record
   ds.orig_state;
   total_cnt := count(group);
   lic_issue_date_min    := min(group, ds.lic_issue_date);
   lic_issue_date_max    := max(group, ds.lic_issue_date);
   orig_issue_date_min   := min(group, ds.orig_issue_date);
   orig_issue_date_max   := max(group, ds.orig_issue_date);
   dt_first_seen_min     := min(group, ds.dt_first_seen);
   dt_last_seen_max      := max(group, ds.dt_last_seen);
   dt_vendor_first_reported_min := min(group, ds.dt_vendor_first_reported);
   dt_vendor_last_reported_max  := max(group, ds.dt_vendor_last_reported);
end;

out_stats := table(ds(lic_issue_date > 19470817), layout_stats, orig_state, few);
output(out_stats);
/* W20080314-141307
Voters
*/

// Phase-1 Status for Voters
import ut;
integer curdate := (integer)ut.GetDate;

ds := Votersv2.File_Voters_Base((integer)regdate > 0);

Layout_stats := record
    ds.source_state;
	total_cnt     := count(group);
	regdate_min   := min(group, ds.regdate);
	regdate_max   := max(group, ds.regdate);
	file_acquired_date_min := min(group, ds.file_acquired_date);
 	file_acquired_date_max := max(group, ds.file_acquired_date);
	dt_first_seen_min      := min(group, ds.date_first_seen);
	dt_last_seen_man       := max(group, ds.date_last_seen);
end;

//out_stats := table(ds, layout_stats, source_state, few);
//output(sort(out_stats,source_state));

out_stats2 := table(ds((integer)trim(regdate) between 19270101 and curdate), layout_stats, source_state, few);
output(sort(out_stats2, source_state));
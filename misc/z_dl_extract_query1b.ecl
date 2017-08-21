
import drivers;

in_file := drivers.File_Dl;

d := in_file;

stat_rec := record
d.source_code;
d.orig_state;
d.dt_first_seen;
d.dt_last_seen;
d.dt_vendor_first_reported;
d.dt_vendor_last_reported;
total_records 	:= count(group);
end;

stats := table(
	d,
	stat_rec,
	d.source_code,
	d.orig_state,
	d.dt_first_seen,
	d.dt_last_seen,
	d.dt_vendor_first_reported,
	d.dt_vendor_last_reported,few);

export dl_extract_query1b := stats : persist('~thor_data400::misc::dl_stats_200600925');

import drivers, address, ut;

d := drivers.File_Dl;

stat_rec := record
d.source_code;
d.orig_state;
total_records 	:= count(group);
end;
stats := table(d,stat_rec,d.source_code,d.orig_state,few);

export dl_extract_query1 := stats : persist('~thor_data400::misc::dl_stats_20090908');




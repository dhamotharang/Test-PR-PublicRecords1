import header,ut,did_add, dx_Header;
// count dates, sort dates desc, and pick the greater count (or most recent if equals) of the two most recent dates.
// opted to not just get the highest count b/c an old build may have an unusualy high count
t:=sort(table(header.file_headers((integer)((string)dt_last_seen)[5..]>0,dt_last_seen>0),{dt_last_seen,cnt:=count(group)},dt_last_seen,few),-dt_last_seen)(cnt>10000);
max_date:=if(t[1].cnt >= t[2].cnt, t[1].dt_last_seen, t[2].dt_last_seen);

dMax:=dataset([{max_date}],{unsigned3 max_date_last_seen});

export data_key_max_dt_last_seen := PROJECT (dMax, dx_Header.layouts.i_max_date);
//:= index( dMax, {dMax},{dMax},
//	ut.Data_Location.Person_header + 'thor_data400::key::max_dt_last_seen_' + doxie.Version_SuperKey);
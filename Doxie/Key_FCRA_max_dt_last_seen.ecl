import header,did_add,mdr, data_services;

// count dates, sort dates desc, and pick the greater count (or most recent if equals) of the two most recent dates.
// opted to not just get the highest count b/c an old build may have an unusualy high count
t:=sort(
         table(
                 header.file_headers( 
                                       (integer)((STRING)dt_last_seen)[5..] > 0,
                                       dt_last_seen > 0,
                                       src in mdr.sourceTools.set_scoring_FCRA
                                    ),
                 {dt_last_seen,cnt:=count(group)},
                 dt_last_seen,
                 few
              ),
              -dt_last_seen
       );

max_date:=if(t[1].cnt >= t[2].cnt, t[1].dt_last_seen, t[2].dt_last_seen);

dMax:=dataset([{max_date}],{unsigned3 max_date_last_seen});

export key_FCRA_max_dt_last_seen
			:= index( dMax, {dMax},{dMax},
				Data_Services.Data_location.person_header + 'thor_data400::key::fcra::max_dt_last_seen_' + doxie.Version_SuperKey);
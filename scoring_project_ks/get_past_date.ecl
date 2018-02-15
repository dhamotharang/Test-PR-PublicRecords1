EXPORT get_past_date( req_date, no_of_days  )  := function

		all_days := scoring_project_ks.day_logic.day_search_map;

		number_today := all_days(DateKey = (string) req_date);

		day1 := number_today[1].id;

		req_day_id := (string) ((integer) day1 - no_of_days ) ;

		req_day := all_days(id =  req_day_id);

		// req_day;

		final_date := req_day[1].datekey;

return final_date;


end;

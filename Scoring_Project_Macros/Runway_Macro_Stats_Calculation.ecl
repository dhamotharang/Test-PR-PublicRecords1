EXPORT Runway_Macro_Stats_Calculation(ds_curr,ds_prev, at_name) := FUNCTIONMACRO

final_lay := record
Integer diff_flag;
end;

final_lay xfrm (ds_curr l, ds_prev r) := transform
self.diff_flag := If(l.#expand(at_name) <> r.#expand(at_name), 1, 0);
end;


final_jn := JOIN(ds_curr, ds_prev, left.seq = right.seq, xfrm(left, right));
diff_count := count(final_jn(diff_flag = 1));
match_count := count(ds_curr);

	
	stats_layout := RECORD
		STRING Score_name;
		decimal9_2 Previous_Average;
		decimal9_2 Current_Average;
		decimal9_2 Average_Change;
		decimal9_2 Percent_Change;

	END;

	stats_layout add_stats(ut.ds_oneRecord le) :=  TRANSFORM
		SELF.Score_name := at_name;
		SELF.Previous_Average := table(ds_prev, {temp_mean := AVE(group, (real)ds_prev.#expand(at_name))} )[1].temp_mean;
		SELF.Current_Average := table(ds_curr, {temp_mean := AVE(group, (real)ds_curr.#expand(at_name))} )[1].temp_mean;
		self.Average_Change := SELF.Current_Average - SELF.Previous_Average ;
		self.Percent_Change := (diff_count/match_count)*100;
		// SELF.median := (REAL)medn.#expand(at_name);
		// SELF.std_dev := SQRT( VARIANCE(ds_slim, (REAL) #expand(at_name)));
		// SELF.miss_rate := COUNT( ds( (STRING) #expand(at_name) = '')) / full_count;
		// SELF.zero_rate := COUNT( ds( (STRING) #expand(at_name) = '0')) / full_count;
		// SELF.neg_one_rate := COUNT( ds( (STRING) #expand(at_name) = '-1')) / full_count;
		// SELF.hit_rate := 	(full_count -
											// COUNT( ds( (STRING) #expand(at_name) = '')) -
											// COUNT( ds( (STRING) #expand(at_name) = '0')) -
											// COUNT( ds( (STRING) #expand(at_name) = '-1')) )
											// / full_count;		
	END;
	
	dset := project(ut.ds_oneRecord, add_stats(left));
	


	return dset;
endmacro;
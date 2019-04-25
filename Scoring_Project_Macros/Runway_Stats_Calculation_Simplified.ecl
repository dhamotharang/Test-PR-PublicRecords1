EXPORT Runway_Stats_Calculation_Simplified(ds_curr, ds_prev) := FUNCTIONMACRO

import ut,STD, Scoring_Project_Macros, Scoring_Project_DailyTracking;

curr_stats := Scoring_Project_Macros.Runway_Macro_Simplified(ds_curr, 'seq');
prev_stats := Scoring_Project_Macros.Runway_Macro_Simplified(ds_prev, 'seq');

// curr_filter_222 := count(curr_stats(std.str.startswith(field_name, 'rv') and (integer)field_value = 222));
// prev_filter_222 := count(prev_stats(std.str.startswith(field_name, 'rv') and (integer)field_value = 222));

final_lay := record
STRING field_name ;
Integer diff_flag;
Integer increase_flag;
Integer decrease_flag;
Integer curr_222;
Integer prev_222;
end;

final_lay xfrm (curr_stats l, prev_stats r) := transform
self.diff_flag := If(l.field_value <> r.field_value, 1, 0);
self.increase_flag := If((real)l.field_value > (real)r.field_value, 1, 0);
self.decrease_flag := If((real)l.field_value < (real)r.field_value, 1, 0);
self.curr_222 := IF(std.str.startswith(l.field_name, 'rv') and (integer)l.field_value = 222, 1, 0);
self.prev_222 := IF(std.str.startswith(r.field_name, 'rv') and (integer)r.field_value = 222, 1, 0);
self := l;
end;


final_jn := JOIN(curr_stats, prev_stats, left.seq = right.seq and left.field_name = right.field_name, xfrm(left, right));


stats_lay := record
STRING Score_name := final_jn.field_name;
difference_count := sum(group,final_jn.diff_flag);
increase_count := sum(group,final_jn.increase_flag);
decrease_count := sum(group,final_jn.decrease_flag);
curr_222_count := sum(group,final_jn.curr_222);
prev_222_count := sum(group,final_jn.prev_222);
end;

stats_tab := TABLE(final_jn, stats_lay, final_jn.field_name);
sorted_stats_tab := sort(stats_tab, score_name);

match_count := count(ds_curr);



curr_avg := Scoring_Project_Macros.Average_Calculation_MACRO(curr_stats);
prev_avg := Scoring_Project_Macros.Average_Calculation_MACRO(prev_stats);

stats_layout := RECORD
		STRING Score_name;
		decimal9_2 Previous_Average;
		decimal9_2 Current_Average;
		decimal9_2 Average_Change;
		decimal9_2 Percent_Change;
		decimal9_2 Percent_Increase;
		decimal9_2 Percent_Decrease;
		String Total_222_Change;
END;

stats_layout xfrm1 (curr_avg l, prev_avg r) := transform
self.Score_name := l.score_name;
self.Previous_Average := r.average;
self.Current_Average := l.average;
self.Average_Change := SELF.Current_Average - SELF.Previous_Average ;
self.Percent_Change := 0.0;
self.Percent_Increase := 0.0;
self.Percent_Decrease := 0.0;
self.Total_222_Change := '';
end;

res_join := JOIN(curr_avg, prev_avg, left.score_name = right.score_name, xfrm1(left, right));
sorted_res_join := Sort(res_join, score_name);

stats_layout xfrm2 (sorted_res_join l, sorted_stats_tab r) := transform
self.Percent_Change := (r.difference_count / match_count)*100;
self.Percent_Increase := (r.increase_count / match_count)*100;
self.Percent_Decrease := (r.decrease_count / match_count)*100;
self.Total_222_Change := IF(std.str.startswith(l.score_name, 'rv'),(string)(r.curr_222_count - r.prev_222_count), '');
self := l;
end;

final_result := JOIN(sorted_res_join, sorted_stats_tab, left.score_name = right.score_name, xfrm2(left, right));

return final_result;
// return stats_tab;

endmacro;

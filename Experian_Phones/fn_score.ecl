import ut, models;
EXPORT fn_score (string phone_type, string phone_source, string last_update_dt, string max_update_date ) := function
lvl_self_land  := (unsigned)(phone_source = 'S' and phone_type <> 'C');
lvl_self_cell  := (unsigned)(phone_source = 'S' and phone_type = 'C'); 

days_since_last_updt := models.common.sas_date(max_update_date) - models.common.sas_date(last_update_dt);
days_since_rep_date_cap := min(days_since_last_updt, 2800);

days_since_self_land := (unsigned) (lvl_self_land * days_since_rep_date_cap);
days_since_self_cell := (unsigned) (lvl_self_cell * days_since_rep_date_cap);
				
exp_score := -3.307581008
                  + (real) (lvl_self_land  * 1.0077174249)
                  + (real) (lvl_self_cell  * 2.2836276034)
                  + (real) (days_since_rep_date_cap  * -0.001581704)
                  + (real) (days_since_self_land  * 0.0004655893)    ;			
		 
exp_score_prob := exp(exp_score)/(1+exp(exp_score));

 point := 40;
 base  := 600;
 odds  := .11111;

 c_p0 := (real) (1469/15734);
 c_p1 := (real) (663/8518);

 constant := ln( (c_p0/(1 - c_p0)) * ((1 - c_p1)/c_p1));

 exp_score_final 	:= min(max(round(point*(constant + exp_score - ln(odds))/ln(2) + base), 0), 999);

return exp_score_final;
end;








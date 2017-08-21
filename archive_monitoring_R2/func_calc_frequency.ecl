//to calculate the date for frequency
export func_calc_frequency(string8   in_date,
                           string1   frequency_type,
	                      unsigned2 frequency_time) := function

in_year := (unsigned)(in_date[1..4]);
in_month := (unsigned)(in_date[5..6]);
in_day := (unsigned)(in_date[7..8]);

//use 30 as an approximation for month days
total_days := map(frequency_time=0 => 0,
                  frequency_type='D' => frequency_time - 1,
                  frequency_type='W' => frequency_time * 7 - 1,
                  frequency_type='M' => frequency_time * 30 - 1, 
			   frequency_time - 1);
			
valid_days := total_days + in_day - 1;
valid_months := valid_days DIV 30 + in_month - 1;			
			
new_day := valid_days % 30 + 1;			   
new_month := valid_months % 12 + 1;
new_year := valid_months DIV 12 + in_year;

new_date := if(total_days=0, in_date,
               (string4)new_year + intformat(new_month,2,1) + intformat(new_day,2,1));

return new_date;

end;
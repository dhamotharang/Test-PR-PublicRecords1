IMPORT STD;

export date6_to_date8(unsigned3 in_date) := function

in_year_val := in_date DIV 100;
in_month_val := in_date % 100;
	
out_year := if(in_year_val> STD.Date.Year (STD.Date.Today()) or
               in_year_val<1800, '', (string4)in_year_val);
			
out_month := if(in_month_val>12 or in_month_val<1, '01', intformat(in_month_val,2,1));

out_date := if(in_date=0 or out_year='', '', out_year + out_month + '01');

return out_date;			

end;
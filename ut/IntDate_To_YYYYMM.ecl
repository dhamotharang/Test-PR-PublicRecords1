export unsigned IntDate_To_YYYYMM(unsigned in_date, boolean last_seen_flag) := 
                map(in_date=0 => 0,
			     in_date between 1800 and 9999 => in_date*100 + if(last_seen_flag, 12 ,1),
		          in_date between 18000000 and 99999999 => in_date DIV 100,
		          in_date);
export Constants := MODULE
	
  export SID_limit_byEP := 100;
	export SID_limit_byUID := 100;

	export min_date := DSIndex.date_key(seq=1)[1].min_date;
	export max_date := DSIndex.date_key(seq=1)[1].max_date;
		
	integer date_s := 0: STORED('StartDate');
	export start_date:= IF(LENGTH((string)date_s)=8 ,date_s
	                       ,0);
	integer date_e := 0: STORED('EndDate');
	
	export end_date:= IF(LENGTH((string)date_e)=8 ,date_e
	                     ,0);	

	integer date_s2 := 0: STORED('StartDate2');
	export start_date2:= IF(LENGTH((string)date_s2)=8 ,date_s2
	                       ,0);
	integer date_e2 := 0: STORED('EndDate2');
	
	export end_date2:= IF(LENGTH((string)date_e2)=8 ,date_e2
	                     ,0);		
END;
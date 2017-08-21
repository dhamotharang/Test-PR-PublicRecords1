import corp2;

export fFormatOfDate(string indate) := function
			//********************************************************************
			//fFormatOfDate:  The function tries to determine the date format of 
			//								the input date.
			//								 1) MM/DD/CCYY (the default format)
			//								 2) MM-DD-CCYY  e.g. 10-01-2016
			//								 2) CCYYMMDD		e.g. 20150430
			//								 3) MMM_DD_CCYY e.g. JAN 4 2015 or JANUARY 4 2015
			//								 4) DD_MMM_CCYY e.g. 07-NOV-2015 or '07-NOVEMBER-2015'
			//								 5) MM/DD/YY 		e.g. 8/2/15
			//								 6) MM-DD-YY 		e.g. 8-2-15
			//								 7) CCYY-MM-DD 	e.g. 2016-10-01
			//********************************************************************     
			month_names					:= ['JAN','JANUARY','FEB','FEBRUARY','MAR','MARCH','APR','APRIL','MAY','JUN','JUNE','JUL','JULY','AUG','AUGUST','SEP','SEPTEMBER','OCT','OCTOBER','NOV','NOVEMBER','DEC','DECEMBER'];
			
			//split the date by space into parts
			split_by_space(string s) := function
					return stringlib.splitwords(s,' ',true);
			end;
			
			//split the date by dash into parts
			split_by_dash(string s) := function
					return stringlib.splitwords(s,'-',true);
			end;

			uc_indate			 	 		:= corp2.t2u(indate);
			
			has_dash						:= if(stringlib.stringfind(uc_indate,'-',1)<>0,true,false);

			//some fields have different formats within the date and this begins 
			//the process of standardizing all the dates.
			standardize_date1		:= stringlib.stringfindreplace(uc_indate,'/','-');
			standardize_date2		:= stringlib.stringfindreplace(standardize_date1,'T',' ');
			standardize_date		:= standardize_date2;

			//some dates includes the time and the time is removed here.
			capture_only_date		:= stringlib.stringgetnthword(standardize_date,1);

			//split the date by dash or by space into parts
			partition_date			  := map(stringlib.stringfind(standardize_date,'-',1)<>0 => split_by_dash(capture_only_date),
																	 stringlib.stringfind(standardize_date,' ',1)<>0 => split_by_space(standardize_date),
																	 split_by_dash(standardize_date)
																	);
			
			//derive the format on the standardized date; allowing for 18th, 19th, and 20th century dates.  
			derived_format				:= map(uc_indate in [] 																																																		=> '',
																	 length(partition_date[1]) in 	[8]	and partition_date[1][1..2] 	in ['18','19','20']														 	 	=> 'CCYYMMDD',			
																	 length(partition_date[1]) in [1,2] and length(partition_date[2]) in [1,2] and length(partition_date[3]) in [2] 	 	=> 'MM/DD/YY',
																	 length(partition_date[1]) in [1,2] and length(partition_date[2]) in [1,2] and length(partition_date[3]) in [4] 	 	=> 'MM/DD/CCYY',
																	 length(partition_date[1]) in   [4] and length(partition_date[2]) in [1,2] and length(partition_date[3]) in [1,2] 	=> 'CCYY/MM/DD',
																	 partition_date[2]				 in month_names and partition_date[3][1..2] in ['18','19','20']														=> 'DD_MMM_CCYY',
																	 partition_date[1]				 in month_names	and partition_date[3][1..2] in ['18','19','20']														=> 'MMM_DD_CCYY',
																	 'UNKNOWN'
																);
			
			//replace the slash with dash if the input date came in with dashes.
			date_format						:= map(has_dash  and derived_format = 'MM/DD/YY' 		=> 'MM-DD-YY',
																	 has_dash  and derived_format = 'MM/DD/CCYY' 	=> 'MM-DD-CCYY',
																	 has_dash  and derived_format = 'CCYY/MM/DD' 	=> 'CCYY-MM-DD',
																	 derived_format
																	);

			return date_format;

end;
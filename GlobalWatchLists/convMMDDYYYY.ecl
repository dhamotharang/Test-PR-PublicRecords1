export convMMDDYYYY(string date) := function

	ds_mnth 	:= 	//Format: 07/15/2010 or 07-15-2010
					if(regexfind('[A-Z]+', date, 0) = '' and trim(date, left, right)[3] in ['/','-'],
					trim(date, left, right)[1..2],
					
					//Format: 7/15/2010 or 7-15-2010
					if(regexfind('[A-Z]+', date, 0) = '' and trim(date, left, right)[2] in ['/','-'],
					'0'+trim(date, left, right)[1],
					
					//Format: 2010/07/15
					if(regexfind('[A-Z]+', date, 0) = '' and DataLib.StringFind(date, '/', 1) = 5 and length(date[DataLib.StringFind(date, '/', 1)+1..DataLib.StringFind(date, '/', 2)-1])= 2,
					date[DataLib.StringFind(date, '/', 1)+1..DataLib.StringFind(date, '/', 2)-1],
						
					//Format: 2010/7/15
					if(regexfind('[A-Z]+', date, 0) = '' and DataLib.StringFind(date, '/', 1) = 5 and length(date[DataLib.StringFind(date, '/', 1)+1..DataLib.StringFind(date, '/', 2)-1])= 1,
					'0'+date[DataLib.StringFind(date, '/', 1)+1..DataLib.StringFind(date, '/', 2)-1],
							
					//Format: 2010-07-15
					if(regexfind('[A-Z]+', StringLib.StringToUpperCase(date), 0)='' and length(trim(date[DataLib.StringFind(date, '-', 1)+1..DataLib.StringFind(date, '-', 2)-1], left, right))=2,
					trim(date[DataLib.StringFind(date, '-', 1)+1..DataLib.StringFind(date, '-', 2)-1], left, right),
					
					//Format: 2010-7-15
					if(regexfind('[A-Z]+', StringLib.StringToUpperCase(date), 0)='' and length(trim(date[DataLib.StringFind(date, '-', 1)+1..DataLib.StringFind(date, '-', 2)-1], left, right))=1,
					'0'+trim(date[DataLib.StringFind(date, '-', 1)+1..DataLib.StringFind(date, '-', 2)-1], left, right),
					''))))));

	ds_day 		:= 	//Format: 07/15/2010
					if(regexfind('[A-Z]+', date, 0) = '' and DataLib.StringFind(date, '/', 1) <> 5 and length(date[DataLib.StringFind(date, '/', 1)+1..DataLib.StringFind(date, '/', 2)-1])=2,
					date[DataLib.StringFind(date, '/', 1)+1..DataLib.StringFind(date, '/', 2)-1],
	
					//Format: 7/15/2010
					if(regexfind('[A-Z]+', date, 0) = '' and DataLib.StringFind(date, '/', 1) <> 5 and length(date[DataLib.StringFind(date, '/', 1)+1..DataLib.StringFind(date, '/', 2)-1])=1,
					'0'+date[DataLib.StringFind(date, '/', 1)+1..DataLib.StringFind(date, '/', 2)-1],
					
					//Format: 07-15-2010
					if(regexfind('[A-Z]+', date, 0) = '' and DataLib.StringFind(date, '-', 1) <> 5 and length(date[DataLib.StringFind(date, '-', 1)+1..DataLib.StringFind(date, '-', 2)-1])=2,
					date[DataLib.StringFind(date, '-', 1)+1..DataLib.StringFind(date, '-', 2)-1],
	
					//Format: 7-15-2010
					if(regexfind('[A-Z]+', date, 0) = '' and DataLib.StringFind(date, '-', 1) <> 5 and length(date[DataLib.StringFind(date, '-', 1)+1..DataLib.StringFind(date, '-', 2)-1])=1,
					'0'+date[DataLib.StringFind(date, '-', 1)+1..DataLib.StringFind(date, '-', 2)-1],
					
					//Format: 2010/07/15
					if(regexfind('[A-Z]+', date, 0) = '' and DataLib.StringFind(date, '/', 1) = 5 and length(date[DataLib.StringFind(date, '/', 2)+1..length(date)])= 2,
					date[DataLib.StringFind(date, '/', 2)+1..length(date)],
					
					//Format: 2010/7/15
					if(regexfind('[A-Z]+', date, 0) = '' and DataLib.StringFind(date, '/', 1) = 5 and length(date[DataLib.StringFind(date, '/', 2)+1..length(trim(date, left, right))])=1,
					'0'+date[DataLib.StringFind(date, '/', 2)+1..length(trim(date, left, right))],
										
					//Format: 2010-07-15
					if(regexfind('[A-Z]+', StringLib.StringToUpperCase(date), 0)='' and length(trim(date[DataLib.StringFind(date, '-', 2)+1..length(date)], left, right))=2,
					trim(date[DataLib.StringFind(date, '-', 2)+1..length(date)], left, right),
					
					//Format: 2010-07-5
					if(regexfind('[A-Z]+', StringLib.StringToUpperCase(date), 0)='' and length(trim(date[DataLib.StringFind(date, '-', 2)+1..length(date)], left, right))=1,
					'0'+trim(date[DataLib.StringFind(date, '-', 2)+1..length(date)], left, right),
					''))))))));

	ds_yr  		:=  //Format: 07/15/2010
					if(regexfind('[A-Z]+', date, 0) = '' and length(date[DataLib.StringFind(date, '/', 2)+1..length(trim(date, left, right))])=4,
					date[DataLib.StringFind(date, '/', 2)+1..length(trim(date, left, right))],
					
					//Format: 07-15-2010
					if(regexfind('[A-Z]+', date, 0) = '' and length(date[DataLib.StringFind(date, '-', 2)+1..length(trim(date, left, right))])=4,
					date[DataLib.StringFind(date, '-', 2)+1..length(trim(date, left, right))],
					
					//Format: 2010/07/15
					if(regexfind('[A-Z]+', date, 0) = '' and DataLib.StringFind(date, '/', 1)= 5,
					trim(date, left, right)[1..4],
					
					//Format: 2010-07-15
					if(regexfind('[A-Z]+', date, 0) = '' and regexfind('[0-9]+', trim(date, left, right)[1..4], 0)<>'',
					trim(date, left, right)[1..4],
					''))));

	v_mnth		:= if(ds_mnth between '01' and '12',
					ds_mnth,
					'');
	
	v_day		:= if(ds_day between '01' and '31',
					ds_day,
					'');
	
	v_yr		:= if(ds_yr[1..2] > '18',
					ds_yr,
					'');
	
	full_yr 	:= v_yr+v_mnth+v_day;
	
return full_yr;
end;
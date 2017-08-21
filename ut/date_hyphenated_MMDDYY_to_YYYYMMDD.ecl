//Reforrmats a date in format[MM-DD-YY or MM-DD-YYYY] to YYYYMMDD
export date_hyphenated_MMDDYY_to_YYYYMMDD(string s) := function

  m     := s[1..StringLib.StringFind(s,'-',1) - 1];
  d     := s[StringLib.StringFind(s,'-',1) + 1 .. StringLib.StringFind(s,'-',2) - 1 ];
  yy    := s[StringLib.StringFind(s,'-',2) + 1	.. ];	
	mm    := if(length(m)=1 ,'0'+m,m);
	dd    := if(length(d)=1 ,'0'+d,d);
	yyyy	:= if(length(yy)=2 ,(string)ut.Date_YY_to_YYYY((unsigned) yy), yy);
	
	return yyyy + mm + dd;
	
end;
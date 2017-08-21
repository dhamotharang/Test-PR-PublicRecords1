// This attribute converts a date and time from GMT to EST, subtracting 5 or 6 hours IF DST or not
import std,lib_stringlib,ut;
EXPORT fn_dategmt(string pdate) := function
	datepattern := '^(.*)\\/(.*)\\/(.*) \\d.*$';
	timepattern := '^\\d\\/\\d\\/\\d (.*):(.*):(.*) [AP][M]$';
	ampattern 	:= '^.*(AM)$';
	
  isdst				:= ut.GetDaylightSavings('FL');
	string2 mm	:= REGEXFIND(datepattern, pdate,1);
	string2 dd	:= REGEXFIND(datepattern, pdate,2);
	string4 yyyy:= REGEXFIND(datepattern, pdate,3);
	string2 hh	:= REGEXFIND(timepattern, pdate,1);
	boolean am	:= if(REGEXFIND(ampattern, pdate,1)='AM' and hh<if(isdst,'5','6'),true,false);
	unsigned sub:= if(am,1,0);
	datetemp1		:= STD.Date.FromGregorianYMD((integer)yyyy,(integer)mm,(integer)dd);
	datecalc		:= datetemp1-sub;
  datatemp2		:= STD.Date.ToGregorianYMD(datecalc);
	outyear			:= (string)datatemp2.year;
	outmonth		:= (string)datatemp2.month;
	outday			:= (string)datatemp2.day;
	dateout			:= outyear+if(LENGTH(trim(outmonth))=1,'0'+trim(outmonth),outmonth)+if(LENGTH(trim(outday))=1,'0'+trim(outday),outday);
	return(dateout);
end;
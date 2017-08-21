// This attribute converts a date and time from GMT to EST, subtracting 5 or 6 hours IF DST or not
import std,lib_stringlib;
EXPORT fn_dategmt(string pdate) := function
	datepattern := '^(.*)\\/(.*)\\/(.*) \\d.*$';
	timepattern := '^\\d\\/\\d\\/\\d (.*):(.*):(.*) [AP][M]$';
	ampattern 	:= '^.*(AM)$';
	todaysdate  := lib_stringlib.StringLib.getdateYYYYMMDD();
	dststart		:= ['20160313','20170312','20180311','20190310','20200308','20210314','20220313','20230312',
									'20240310','20250309','20260308','20270314','20280312','20290311','20300310'];
	dstends			:= ['20161106','20171105','20181104','20191103','20201101','20211107','20221106','20231105',
									'20241103','20251102','20261101','20271107','20281105','20291104','20301103'];
  isdst				:= if(todaysdate>=dststart[map(todaysdate[1..4]='2016'=>1, todaysdate[1..4]='2017'=>2,
																						 todaysdate[1..4]='2018'=>3, todaysdate[1..4]='2019'=>4,
																						 todaysdate[1..4]='2020'=>5, todaysdate[1..4]='2021'=>6,
																						 todaysdate[1..4]='2022'=>7, todaysdate[1..4]='2023'=>8,
																						 todaysdate[1..4]='2024'=>9, todaysdate[1..4]='2025'=>10,
																						 todaysdate[1..4]='2026'=>11,todaysdate[1..4]='2027'=>12,
																						 todaysdate[1..4]='2028'=>13,todaysdate[1..4]='2029'=>14,
																						 todaysdate[1..4]='2030'=>15,15)] and
										todaysdate<=dstends [map(todaysdate[1..4]='2016'=>1, todaysdate[1..4]='2017'=>2,
																						 todaysdate[1..4]='2018'=>3, todaysdate[1..4]='2019'=>4,
																						 todaysdate[1..4]='2020'=>5, todaysdate[1..4]='2021'=>6,
																						 todaysdate[1..4]='2022'=>7, todaysdate[1..4]='2023'=>8,
																						 todaysdate[1..4]='2024'=>9, todaysdate[1..4]='2025'=>10,
																						 todaysdate[1..4]='2026'=>11,todaysdate[1..4]='2027'=>12,
																						 todaysdate[1..4]='2028'=>13,todaysdate[1..4]='2029'=>14,
																						 todaysdate[1..4]='2030'=>15,15)],
										true,false);
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
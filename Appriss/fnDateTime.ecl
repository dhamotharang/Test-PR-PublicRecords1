// The different date and timestamp  patterns we expect

//   timestamp1  11/29/1993 20:08 MDT 
pat_ts1:= '^([0-9]{2})[\\/\\-]([0-9]{2})[\\/\\-]([0-9]{4}) ([0-9]{2}):([0-9]{2})[\\s]([A-Z]{3})$';

//   timestamp2  1993-11-29 20:08:00.0
pat_ts2:= '^([0-9]{4})[\\/\\-]([0-9]{2})[\\/\\-]([0-9]{2}) ([0-9]{2}):([0-9]{2}):([0-9]{2}).([0-9])$';

//   timestamp3  19931129-000000.0
pat_ts3:= '^([0-9]{4})([0-9]{2})([0-9]{2})[-]([0-9]{6}).([0-9])$';

//   date only   11/29/1993
pat_date:='^([0-9]{2})[\\/\\-]([0-9]{2})[\\/\\-]([0-9]{4})$';

//   date only 2  2004-09-21 or yyyy/mm/dd or yyyy/mm/dd
pat_date2:='^([0-9]{4})[\\/\\-]*([0-9]{2})[\\/\\-]*([0-9]{2})$';

toStd_from_ts1(string s):= FUNCTION
mm:=regexfind(pat_ts1,s,1);
dd:=regexfind(pat_ts1,s,2);
yyyy:=regexfind(pat_ts1,s,3);
hh:=regexfind(pat_ts1,s,4);
mins:=regexfind(pat_ts1,s,5);
zone:=regexfind(pat_ts1,s,6);
RETURN yyyy+mm+dd+'-'+hh+mins+'00.0-'+zone;
END;

toStd_from_ts2(string s):= FUNCTION
yyyy:=regexfind(pat_ts2,s,1);
mm:=regexfind(pat_ts2,s,2);
dd:=regexfind(pat_ts2,s,3);
hh:=regexfind(pat_ts2,s,4);
mins:=regexfind(pat_ts2,s,5);
seconds:=regexfind(pat_ts2,s,6);
fractsecs:=regexfind(pat_ts2,s,7);
RETURN yyyy+mm+dd+'-'+hh+mins+seconds+'.'+fractsecs;
END;


toStd_from_Date(string s):= FUNCTION
mm:=regexfind(pat_date,s,1);
dd:=regexfind(pat_date,s,2);
yyyy:=regexfind(pat_date,s,3);
RETURN yyyy+mm+dd;
END;

toStd_from_ts3(string s):= FUNCTION
yyyy:=regexfind(pat_ts3,s,1);
mm:=regexfind(pat_ts3,s,2);
dd:=regexfind(pat_ts3,s,3);
RETURN yyyy+mm+dd;
END;


toStd_from_Date2(string s):= FUNCTION
yyyy:=regexfind(pat_date2,s,1);
mm:=regexfind(pat_date2,s,2);
dd:=regexfind(pat_date2,s,3);
RETURN yyyy+mm+dd;
END;

export fnDateTime(string s):= FUNCTION
RETURN if (regexfind(pat_ts1,s,0) != '' , toStd_from_ts1(s), // timestamp fmt 1(zone)
           if (regexfind(pat_ts2,s,0) != '' , toStd_from_ts2(s), // time stamp fmt 2
					     if (regexfind(pat_ts3,s,0) != '', toStd_from_ts3(s), // date only
				           if (regexfind(pat_date,s,0) != '', toStd_from_date(s), // date only
							   	     if (regexfind(pat_date2,s,0) != '', toStd_from_Date2(s), // date only
				                   if (s != '','*'+s,'') // check if nonblank
                          )
						          )
					        )
					    )
					);
END;


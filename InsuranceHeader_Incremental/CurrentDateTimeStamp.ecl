IMPORT STD;

// TRUE gets local time zone, as opposed to UTC
nowDate 		 := STD.Date.CurrentDate(TRUE);
nowTime 		 := STD.Date.CurrentTime(TRUE);

EXPORT CurrentDateTimeStamp := nowDate * 1000000 + nowTime;
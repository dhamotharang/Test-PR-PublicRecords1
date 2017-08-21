import ut,STD,lib_timelib;
EXPORT GetWUModified(string esp,string wuid) := function


checkoutAttributeInRecord := record
		
		string WUID{xpath('WUID')} := wuid;
		string CreatorType{xpath('CreatorType')} := 'hthor'; // after 6.2.14
		string Kind{xpath('Kind')} := 'WhenQueryFinished'; // after 6.2.14
	end;
	
	
	WUStatisticItem := record
		string Value{xpath('Value')};
	end;
	
	checkoutAttributeOutRecord := record
		string WUID{xpath('WUID')};
		dataset(WUStatisticItem) stats{xpath('Statistics/WUStatisticItem')};
	end;
	
	wuresults := SOAPCALL('http://'+esp+':8010/WsWorkunits', 'WUGetStats', 
											checkoutAttributeInRecord, checkoutAttributeOutRecord,
											
											xpath('WUGetStatsResponse')
										 );
	
	recentTimeStamp := regexreplace('[^0-9]',Std.Str.SplitWords(sort(wuresults.stats,-value)[1].value,'.')[1],''); // remove fractions

	
	d_ds := dataset([{(integer2)recentTimeStamp[1..4],(unsigned1)recentTimeStamp[5..6],(unsigned1)recentTimeStamp[7..8],(unsigned1)recentTimeStamp[9..10],(unsigned1)recentTimeStamp[11..12],(unsigned1)recentTimeStamp[13..14]}],date.DateTime_rec);
	
	thorbackup.date.Seconds_t timediff := thorbackup.Date.SecondsFromDateTimeRec(d_ds[1]) + timelib.LocalTimeZoneOffset();
	
	string modified := intformat(thorbackup.date.SecondsToParts(timediff).year,4,1)
											+ intformat(thorbackup.date.SecondsToParts(timediff).month,2,1)
											+ intformat(thorbackup.date.SecondsToParts(timediff).day,2,1)
											+ intformat(thorbackup.date.SecondsToParts(timediff).hour,2,1)
											+ intformat(thorbackup.date.SecondsToParts(timediff).minute,2,1)
											+ intformat(thorbackup.date.SecondsToParts(timediff).second,2,1);
			
	
	return modified;
end;
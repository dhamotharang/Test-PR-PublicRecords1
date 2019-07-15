import header,ut,_control,std;
#workunit('name','Monitor PersonHeader');

elist := 'gabriel.marcan@lexisnexisrisk.com';

un1 := '#workunit(\'name\',\'Automated: Monitor Prod PersonHeader Wuids\');';
un2 := '#workunit(\'name\',\'Automated: Monitor Alph PersonHeader Wuids\');';
getTime:=Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
sequential(
					if(getTime[1..2] in ['07','13','19']
						,sequential(_control.fSubmitNewWorkunit(un2+'import header; header.Build_monitor_Alpharetta(\''+elist+'\');// submitted by:'+workunit+'\n', 'hthor_eclcc')
											 ,fileservices.sendEmail(elist,'Header Monitor is running ( '+Workunit+' )','')
						))
					,_control.fSubmitNewWorkunit(un1+'import header; header.build_monitor(\''+elist+'\'); // submitted by:'+workunit+'\n', 'hthor_eclcc')
) :when(cron('15 * * * *'));


// ( W:\projects\Header\15-05a HeaderBuildAnalysis\BWR_Monitor_Header.ecl )
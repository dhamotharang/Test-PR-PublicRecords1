
#option('multiplePersistInstances',FALSE);
 
Layout_scrubs_stats := RECORD
  string processdate;
  string recordstotal;
  string sourcecode;
  string fieldname;
  string rulename;
  string ruledesc;
  string rulecnt;
  string rulepcnt;
  string rulethreshold;
  string rejectwarning;
  string invalidvalue;
  string invalidvaluecnt;
  string code;
  string severity;
 END;


// get data sets  
ds_scrubs_stats_main := dataset('~profilestat::ScrubsAlerts::scrubs_sexoffender_main::' + StringLib.GetDateYYYYMMDD() + '::' + workunit + '.csv',
                           Layout_scrubs_stats, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r'])));		

ds_scrubs_stats_offense := dataset('~profilestat::ScrubsAlerts::scrubs_sexoffender_offense::' + StringLib.GetDateYYYYMMDD() + '::' + workunit + '.csv',
                           Layout_scrubs_stats, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r'])));		

headerRec := DATASET([{'processdate','recordstotal','sourcecode','fieldname','rulename','ruledesc','rulecnt','rulepcnt','rulethreshold','rejectwarning','invalidvalue','invalidvaluecnt','code','severity'}], Layout_scrubs_stats);

 output(headerRec + project(ds_scrubs_stats_main(rejectwarning = 'Y'),
																		 transform(Layout_scrubs_stats,
																			 self.processdate := left.processdate,
																			 self.recordstotal := left.recordstotal,
																			 self.sourcecode := left.sourcecode,
																			 self.fieldname := left.fieldname,
																			 self.rulename := left.rulename,
																			 self.ruledesc := left.ruledesc,
																			 self.rulecnt := left.rulecnt,
																			 self.rulepcnt := left.rulepcnt,
																			 self.rulethreshold := left.rulethreshold,
																			 self.rejectwarning := left.rejectwarning,
																			 self.invalidvalue := left.invalidvalue,
																			 self.invalidvaluecnt := left.invalidvaluecnt,
																			 self.code := left.code,
																			 self.severity := left.severity))
																			   ,, '~profilestat::scrubs::scrubs_sexoffender_main::reject_warning.csv', 
																				     csv(separator(','),terminator('\r\n'),quote('"')), compressed, overwrite); 	

ds_scrubs_stats_main_reject_warning := dataset('~profilestat::scrubs::scrubs_sexoffender_main::reject_warning.csv',
                           Layout_scrubs_stats, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r'])));		


output(headerRec + project(ds_scrubs_stats_offense(rejectwarning = 'Y'),
																		 transform(Layout_scrubs_stats,
																			 self.processdate := left.processdate,
																			 self.recordstotal := left.recordstotal,
																			 self.sourcecode := left.sourcecode,
																			 self.fieldname := left.fieldname,
																			 self.rulename := left.rulename,
																			 self.ruledesc := left.ruledesc,
																			 self.rulecnt := left.rulecnt,
																			 self.rulepcnt := left.rulepcnt,
																			 self.rulethreshold := left.rulethreshold,
																			 self.rejectwarning := left.rejectwarning,
																			 self.invalidvalue := left.invalidvalue,
																			 self.invalidvaluecnt := left.invalidvaluecnt,
																			 self.code := left.code,
																			 self.severity := left.severity))
																			   ,, '~profilestat::scrubs::scrubs_sexoffender_offense::reject_warning.csv', 
																				     csv(separator(','),terminator('\r\n'),quote('"')), compressed, overwrite); 	

ds_scrubs_stats_offense_reject_warning := dataset('~profilestat::scrubs::scrubs_sexoffender_offense::reject_warning.csv',
                           Layout_scrubs_stats, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r'])));		



// convert data sets to single recs.
linestring := RECORD
			STRING300000 line; 
		END;

linestring converttoline (ds_scrubs_stats_main L) := TRANSFORM
SELF.line := L.processdate + ',' +
						 L.recordstotal + ',' +
						 L.sourcecode + ',' +
						 L.fieldname + ',' +
						 L.rulename + ',' +
						 L.ruledesc + ',' +
						 L.rulecnt + ',' +
						 L.rulepcnt + ',' +
						 L.rulethreshold + ',' +
						 L.rejectwarning + ',' +
						 L.invalidvalue+ ',' +
						 L.invalidvaluecnt + ',' +
						 L.code + ',' +
						 L.severity ;
END;
		
singlelinerecord_stats_main := PROJECT (ds_scrubs_stats_main, converttoline(LEFT));

singlelinerecord_stats_offense := PROJECT (ds_scrubs_stats_offense, converttoline(LEFT));

singlelinerecord_stats_main_reject_warning 
                 := PROJECT (ds_scrubs_stats_main_reject_warning, converttoline(LEFT));

singlelinerecord_stats_offense_reject_warning
                 := PROJECT (ds_scrubs_stats_offense_reject_warning, converttoline(LEFT));

// use in report format.
subheaderRecOffenderMain := DATASET([{'Scrubs Stats Offender Main,,,,,,,,,,,,,,'}], linestring);
subheaderRecOffenderMainRejectWarning := DATASET([{'Scrubs Stats Offender Main RejectWarning,,,,,,,,,,,,,,'}], linestring);
subheaderRecOffenderOffense := DATASET([{'Scrubs Stats Offender Offense,,,,,,,,,,,,,,'}], linestring);
subheaderRecOffenderOffenseRejectWarning := DATASET([{'Scrubs Stats Offender Offense RejectWarning ,,,,,,,,,,,,,,'}], linestring);
blankheaderRec := DATASET([{',,,,,,,,,,,,,,'}], linestring);


// set up single records for email						 
myrec := RECORD
	UNSIGNED  code0; 
	STRING300000 line; 
END;

myrec ref(singlelinerecord_stats_main l) := TRANSFORM 
	SELF.code0 := 0; 
	SELF       := l; 
END;


input1 := PROJECT(subheaderRecOffenderMain
                    + singlelinerecord_stats_main, ref(LEFT));

input2 := PROJECT(subheaderRecOffenderMainRejectWarning
                    + singlelinerecord_stats_main_reject_warning, ref(LEFT));
								
input3 := PROJECT(subheaderRecOffenderOffense
                    + singlelinerecord_stats_offense, ref(LEFT));
								
input4 := PROJECT(subheaderRecOffenderOffenseRejectWarning
                    + singlelinerecord_stats_offense_reject_warning, ref(LEFT));								

MyRec rollupForm (myrec L, myrec R) := TRANSFORM
	SELF.line := TRIM(L.line, left, right) + '\n' + TRIM(R.line, LEFT, RIGHT); 
	SELF      := L;
END;

XtabOut1 := ROLLUP(input1, rollupForm(LEFT,RIGHT), CODE0);
XtabOut2 := ROLLUP(input2, rollupForm(LEFT,RIGHT), CODE0);
XtabOut3 := ROLLUP(input3, rollupForm(LEFT,RIGHT), CODE0);
XtabOut4 := ROLLUP(input4, rollupForm(LEFT,RIGHT), CODE0);

// Launch emails
mailScrubsStatsMain := FileServices.SendEmailAttachText( 'tarun.patel@lexisnexis.com,tarun.patel@lexisnexis.com'
																						,'Scrubs Stats Sex Offender Main File '+Thorlib.WUID()
																						,'See attached scrubs stats for offender main file.'
																						, TRIM(XtabOut1[1].line, LEFT, RIGHT)
																						,'text/xml'
																						,'ScrubsStatsOffenderMain.csv'
																						,
																						,
																						,'tarun.patel@lexisnexis.com');	
mailScrubsStatsMain;


mailScrubsStatsMainRW := FileServices.SendEmailAttachText( 'tarun.patel@lexisnexis.com,tarun.patel@lexisnexis.com'
																						,'Scrubs Stats Sex Offender Main Reject Warning File '+Thorlib.WUID()
																						,'See attached scrubs stats for offender main reject warning file.'
																						, TRIM(XtabOut2[1].line, LEFT, RIGHT)
																						,'text/xml'
																						,'ScrubsStatsOffenderMainRejectWarning.csv'
																						,
																						,
																						,'tarun.patel@lexisnexis.com');	
mailScrubsStatsMainRW;


mailScrubsStatsOffense := FileServices.SendEmailAttachText( 'tarun.patel@lexisnexis.com,tarun.patel@lexisnexis.com'
																						,'Scrubs Stats Sex Offender Offense File '+Thorlib.WUID()
																						,'See attached scrubs stats for offender Offense file.'
																						, TRIM(XtabOut3[1].line, LEFT, RIGHT)
																						,'text/xml'
																						,'ScrubsStatsOffenderOffense.csv'
																						,
																						,
																						,'tarun.patel@lexisnexis.com');	
mailScrubsStatsOffense;


mailScrubsStatsOffenseRW := FileServices.SendEmailAttachText( 'tarun.patel@lexisnexis.com,tarun.patel@lexisnexis.com'
																						,'Scrubs Stats Sex Offender Offense Reject Warning File '+Thorlib.WUID()
																						,'See attached scrubs stats for offender offense reject warning file.'
																						, TRIM(XtabOut4[1].line, LEFT, RIGHT)
																						,'text/xml'
																						,'ScrubsStatsOffenderOffenseRejectWarning.csv'
																						,
																						,
																						,'tarun.patel@lexisnexis.com');	
mailScrubsStatsOffenseRW;







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
ds_scrubs_stats_DefendantRaw := dataset('~profilestat::ScrubsAlerts::scrubs_sexoffender_def_raw::' + StringLib.GetDateYYYYMMDD() + '::' + workunit + '.csv',
                           Layout_scrubs_stats, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r'])));		

headerRec := DATASET([{'processdate','recordstotal','sourcecode','fieldname','rulename','ruledesc','rulecnt','rulepcnt','rulethreshold','rejectwarning','invalidvalue','invalidvaluecnt','code','severity'}], Layout_scrubs_stats);

 output(headerRec + project(ds_scrubs_stats_DefendantRaw(rejectwarning = 'Y'),
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
																			   ,, '~profilestat::scrubs::scrubs_sexoffender_def_raw::reject_warning.csv', 
																				     csv(separator(','),terminator('\r\n'),quote('"')), compressed, overwrite); 	

ds_scrubs_stats_DefendantRaw_reject_warning := dataset('~profilestat::scrubs::scrubs_sexoffender_def_raw::reject_warning.csv',
                           Layout_scrubs_stats, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r'])));		



// convert data sets to single recs.
linestring := RECORD
			STRING300000 line; 
		END;

linestring converttoline (ds_scrubs_stats_DefendantRaw L) := TRANSFORM
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
		
singlelinerecord_stats_DefendantRaw := PROJECT (ds_scrubs_stats_DefendantRaw, converttoline(LEFT));


singlelinerecord_stats_DefendantRaw_reject_warning 
                 := PROJECT (ds_scrubs_stats_DefendantRaw_reject_warning, converttoline(LEFT));


// use in report format.
subheaderRecOffenderDefendantRaw := DATASET([{'Scrubs Stats Sex Offender Defendant Raw,,,,,,,,,,,,,,'}], linestring);
subheaderRecOffenderDefendantRawRejectWarning := DATASET([{'Scrubs Stats Sex Offender Defendant Raw RejectWarning,,,,,,,,,,,,,,'}], linestring);
blankheaderRec := DATASET([{',,,,,,,,,,,,,,'}], linestring);


// set up single records for email						 
myrec := RECORD
	UNSIGNED  code0; 
	STRING300000 line; 
END;

myrec ref(singlelinerecord_stats_DefendantRaw l) := TRANSFORM 
	SELF.code0 := 0; 
	SELF       := l; 
END;


input1 := PROJECT(subheaderRecOffenderDefendantRaw
                    + singlelinerecord_stats_DefendantRaw, ref(LEFT));

input2 := PROJECT(subheaderRecOffenderDefendantRawRejectWarning
                    + singlelinerecord_stats_DefendantRaw_reject_warning, ref(LEFT));				

MyRec rollupForm (myrec L, myrec R) := TRANSFORM
	SELF.line := TRIM(L.line, left, right) + '\n' + TRIM(R.line, LEFT, RIGHT); 
	SELF      := L;
END;

XtabOut1 := ROLLUP(input1, rollupForm(LEFT,RIGHT), CODE0);
XtabOut2 := ROLLUP(input2, rollupForm(LEFT,RIGHT), CODE0);

Email_to := 'tarun.patel@lexisnexis.com';
Email_from := 'eclsystem@seisint.com';

// Launch emails
mailScrubsStatsDefendantRaw := FileServices.SendEmailAttachText( Email_to
																						,'Scrubs Stats Sex Offender Defendant Raw '+Thorlib.WUID()
																						,'See attached scrubs stats for defendant raw file.'
																						, TRIM(XtabOut1[1].line, LEFT, RIGHT)
																						,'text/xml'
																						,'ScrubsStatsDefendantRaw.csv'
																						,
																						,
																						,Email_from);	
mailScrubsStatsDefendantRaw;


mailScrubsStatsDefendantRawRW := FileServices.SendEmailAttachText( Email_to
																						,'Scrubs Stats Sex Offender Defendant Raw Reject Warning File '+Thorlib.WUID()
																						,'See attached scrubs stats for defendant raw reject warning file.'
																						, TRIM(XtabOut2[1].line, LEFT, RIGHT)
																						,'text/xml'
																						,'ScrubsStatsDefendantRawRejectWarning.csv'
																						,
																						,
																						,Email_from);	
mailScrubsStatsDefendantRawRW;








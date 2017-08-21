

//
import hygenics_soff, lib_date, ut, lib_fileservices;

pVersion := StringLib.GetDateYYYYMMDD(); 

pCoverage := hygenics_soff.File_In_SO_Defendant
              (sourcename not in ['OREGON_SEX_OFFENDER_REGISTRY', // Omit: since OREGON_WEB_SEX_OFFENDER_REGISTRY gets processes.
							                    'CALIFORNIA_SEX_OFFENDER_REGISTRY', //Omit: legal issues where the data is not to be used for FCRA purposes.                                                                   
                                  'NEVADA_SEX_OFFENDER_REGISTRY',  //Omit: legal issues where the data is not to be used for FCRA purposes.                                                                      
                                  'MISSISSIPPI_SEX_OFFENDER_REGISTRY',  //Omit: no longer get updates from Hygenics due to restrictions on commercial use.                                                                 
                                  'PUERTO_RICO_SEX_OFFENDER_REGISTRY'  //Omit: no longer get updates from Hygenics due to restrictions on commercial use.                                                                 
												        	 ]);

//Flag records where coverage date > 90 days
	src_filter 								:= StringLib.StringFilter(pCoverage.RecordUploadDate, '0123456789');
	file_date_filter 					:= StringLib.StringFilter(pVersion, '0123456789');
	
rPopulationStats_file_Coverage
 :=
  record	
		state									             := pCoverage.statecode;
		source_file						             := pCoverage.sourcename;
		coverage_end_date			             := pCoverage.RecordUploadDate;
		fcra_remove_flag_90_days_away	     :=	 if(trim(src_filter, left, right)<>'' and length(src_filter) = length(file_date_filter) and LIB_Date.DaysApart(src_filter, file_date_filter) = 90,
														              	 'Y',
																						    '');
   end; 

dPopulationStats_pOffender := table(pCoverage
																			,rPopulationStats_file_Coverage
																			,statecode, sourcename
																			,few);

srt_dPopulationStats_pOffender := sort(dPopulationStats_pOffender, state, source_file);

Layout_fcra_warning_list := RECORD
   string state;
   string source_file;
   string coverage_end_date;
   string fcra_remove_flag_90_days_away;		
 END;

headerRec := DATASET([{'State','Source Name','Coverage End Date','FCRA Removal 90 Days Away Flag'}], Layout_fcra_warning_list);
		
output(headerRec + project(srt_dPopulationStats_pOffender(fcra_remove_flag_90_days_away = 'Y'),
																		 transform(Layout_fcra_warning_list,
																			 self.state := left.state,
																			 self.source_file := left.source_file,
																			 self.coverage_end_date := left.coverage_end_date,
																			 self.fcra_remove_flag_90_days_away := left.fcra_remove_flag_90_days_away
																			  ))
																			   ,, '~sex_offender_fcra_warning_list.csv', 
																				     csv(separator(','),terminator('\r\n'),quote('"')), compressed, overwrite); 	

ds_fcra_warning_list := dataset('~sex_offender_fcra_warning_list.csv',
                           Layout_fcra_warning_list, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r'])));		

count_rec :=  count(ds_fcra_warning_list);

//set up email

// convert data sets to single recs.
linestring := RECORD
			STRING300000 line; 
		END;
		
linestring converttoline (ds_fcra_warning_list L) := TRANSFORM
SELF.line := L.state + ',' +
						 L.source_file + ',' +
						 L.coverage_end_date + ',' +
						 L.fcra_remove_flag_90_days_away ;
END;		

singlelinerecord_fcra_warning_list
                 := PROJECT (ds_fcra_warning_list, converttoline(LEFT));

// use in report format.
subheaderRecFCRA_warning_list 
                 := DATASET([{'Following States Are 90 Days Away From Removal From FCRA:,,,'}], linestring);

// set up single records for email						 
myrec := RECORD
	UNSIGNED  code0; 
	STRING300000 line; 
END;

myrec ref(singlelinerecord_fcra_warning_list l) := TRANSFORM 
	SELF.code0 := 0; 
	SELF       := l; 
END;

input := PROJECT(//subheaderRecFCRA_warning_list
                   // + 
										singlelinerecord_fcra_warning_list, ref(LEFT));

MyRec rollupForm (myrec L, myrec R) := TRANSFORM
	SELF.line := TRIM(L.line, left, right) + '\n' + TRIM(R.line, LEFT, RIGHT); 
	SELF      := L;
END;

XtabOut1 := ROLLUP(input, rollupForm(LEFT,RIGHT), CODE0);

Email_to := 
 'Angela.Herzberg@lexisnexis.com,tarun.patel@lexisnexis.com,Charles.Pettola@lexisnexis.com,valerie.minnis@lexisnexis.com,neha.merchant@lexisnexis.com,jennifer.stewart@lexisnexis.com,Jennifer.Butts@lexisnexis.com,Rob.Becker@lexisnexis.com';
	
//Email_to := 'tarun.patel@lexisnexis.com';

Email_from := 'eclsystem@seisint.com';

// Launch emails
mail_SO_warning_list := FileServices.SendEmailAttachText( 
                                             Email_to
																						,'Sex Offender Sources 90 Days Away From Removal From FCRA ('+Thorlib.WUID() + ').'
																						,'Please check attachment to see if there are any states on the warning list.'
																						, TRIM(XtabOut1[1].line, LEFT, RIGHT)
																						,'text/xml'
																						,'FCRA SOFF Sources 90 Days Away From Removal List.csv'
																						,
																						,
																						,Email_from);	
																	 
//mail_SO_warning_list;
launch_email := if(count_rec > 1, mail_SO_warning_list);
launch_email;


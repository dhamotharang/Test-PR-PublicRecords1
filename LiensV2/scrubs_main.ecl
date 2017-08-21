import Scrubs, Scrubs_LiensV2_Main, Orbit3SOA, SALT30;

EXPORT scrubs_main(string pVersion) := FUNCTION
#workunit('name', 'Scrubs LiensV2 Main');
#option('multiplePersistInstances',FALSE);

wuid := WORKUNIT; //get WUID
F := Scrubs_LiensV2_Main.File_Liens_Main;
S := Scrubs_LiensV2_Main.Scrubs; // My scrubs module
N := S.FromNone(F); // Generate the error flags
T := S.FromBits(N.BitmapInfile);     // Use the FromBits module; makes my bitmap datafile easier to get to
U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module


//Outputs reports
output(U.SummaryStats, named('ErrorSummaryMain')); // Show errors by field and type
output(choosen(U.AllErrors, 1000), named('EyeballSomeErrorsMain')); // Just eyeball some errors
output(choosen(U.BadValues, 1000), named('SomeErrorValuesMain')); // See my error field values

// Orbit Stats
Orbit_st := U.OrbitStats() : persist('~persist::liensV2_main_orbit_stats');

output(Scrubs.OrbitProfileStats(,,Orbit_st).SummaryStats, all,named('OrbitReportSummaryMain'));

//Submits Profile's stats to Orbit
Submit_Stats := Scrubs.OrbitProfileStats('Scrubs_Liens_Main',, Orbit_st, pversion,'Main').SubmitStats;

Orbit_report := output(Orbit_st,all,named('OrbitReportMain'));

//Output Scrubs report with examples in WU
Scrubs_report := Scrubs.OrbitProfileStats('Scrubs_Liens_Main',, Orbit_st, pversion,'Main').CompareToProfile_with_examples;

//Send Alerts and Scrubs reports via email 
Scrubs_alert := Scrubs_report;
attachment := Scrubs.fn_email_attachment(Scrubs_alert);

mailfile := FileServices.SendEmailAttachData('terri.hardy-george@lexisnexis.com'
																						,'Scrubs Report Liens Main' //subject
																						,'Scrubs Report Liens Main ' + wuid //body
																						,(data)attachment
																						,'text/csv'
																						,'ScrubsReportLiensMain.csv'
																						,
																						,
																						,'terri.hardy-george@lexisnexis.com');	


	RETURN sequential(Submit_Stats
									  ,Orbit_report 
										,if(count(Scrubs_alert) > 1, mailfile, output('No Scrubs Report Liens Main'))
							     );

END;	

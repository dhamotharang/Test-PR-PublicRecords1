import Scrubs, Scrubs_LiensV2_Party, Orbit3SOA, SALT30;

EXPORT scrubs_party(string pVersion) := FUNCTION
#workunit('name', 'Scrubs LiensV2 Party');
#option('multiplePersistInstances',FALSE);

wuid := WORKUNIT; //get WUID
F := Scrubs_LiensV2_Party.File_Liens_Party;
S := Scrubs_LiensV2_Party.Scrubs; // My scrubs module
N := S.FromNone(F); // Generate the error flags
T := S.FromBits(N.BitmapInfile);     // Use the FromBits module; makes my bitmap datafile easier to get to
U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module


//Outputs reports
output(U.SummaryStats, named('ErrorSummaryParty')); // Show errors by field and type
output(choosen(U.AllErrors, 1000), named('EyeballSomeErrorsParty')); // Just eyeball some errors
output(choosen(U.BadValues, 1000), named('SomeErrorValuesParty')); // See my error field values

// Orbit Stats
Orbit_st := U.OrbitStats() : persist('~persist::liensV2_party_orbit_stats');

output(Scrubs.OrbitProfileStats(,,Orbit_st).SummaryStats, all,named('OrbitReportSummaryParty'));

//Submits Profile's stats to Orbit
Submit_Stats := Scrubs.OrbitProfileStats('Scrubs_Liens_Party',, Orbit_st, pversion,'Party').SubmitStats;

Orbit_report := output(Orbit_st,all,named('OrbitReportParty'));

//Output Scrubs report with examples in WU
Scrubs_report := Scrubs.OrbitProfileStats('Scrubs_Liens_Party',, Orbit_st, pversion,'Party').CompareToProfile_with_examples;

//Send Alerts and Scrubs reports via email 
Scrubs_alert := Scrubs_report(RejectWarning = 'Y');

attachment := Scrubs.fn_email_attachment(Scrubs_alert);

mailfile := FileServices.SendEmailAttachData('terri.hardy-george@lexisnexis.com'
																						,'Scrubs Report Liens Party' //subject
																						,'Scrubs Report Liens Party ' + wuid //body
																						,(data)attachment
																						,'text/csv'
																						,'ScrubsReportLiensParty.csv'
																						,
																						,
																						,'terri.hardy-george@lexisnexis.com');	


	RETURN sequential(Submit_Stats
									  ,Orbit_report 
										,if(count(Scrubs_alert) > 1, mailfile, output('No Scrubs Report Liens Party'))
							     );

END;	


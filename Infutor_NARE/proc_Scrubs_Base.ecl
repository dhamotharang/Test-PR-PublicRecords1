import Scrubs, Scrubs_Infutor_NARE_base, Orbit3SOA, SALT30, ut, Infutor_NARE;

EXPORT proc_Scrubs_Base (string Version) := FUNCTION
#workunit('name', 'Scrubs Infutor NARE Base');
#option('multiplePersistInstances',FALSE);

F := Infutor_NARE.file_base;
P := project(F, Infutor_NARE.layouts.base_new);
S :=Scrubs_Infutor_NARE_base.Scrubs; // My scrubs module
N := S.FromNone(P); // Generate the error flags

U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
output(U.SummaryStats, named('ErrorSummary')); // Show errors by field and type
output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors')); // Just eyeball some errors
output(choosen(U.BadValues, 1000), named('SomeErrorValues')); // See my error field values

//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
	Orbit_st := U.OrbitStats() : persist('~persist::NARE_orbit_stats');

//Submits Profile's stats to Orbit
	submit_stats :=	Scrubs.OrbitProfileStats('Scrubs_Infutor_NARE_Base',, Orbit_st, version).SubmitStats;

//Output Scrubs report with examples in WU
	Scrubs_report := Scrubs.OrbitProfileStats('Scrubs_Infutor_NARE_Base',, Orbit_st, version).CompareToProfile_with_examples;
	
//Send Alerts and Scrubs reports via email 
	Scrubs_alert := Scrubs_report(RejectWarning = 'Y');
	attachment := Scrubs.fn_email_attachment(Scrubs_alert);
  mailfile := FileServices.SendEmailAttachData('shannon.skumanich@lexisnexis.com'
																						,'Scrubs Infutor NARE Base Report' //subject
																						,'Scrubs Infutor NARE Base Report '+ WORKUNIT //body
																						,(data)attachment
																						,'text/csv'
																						,'ScrubsReportInf.csv'
																						,
																						,
																						,'shannon.skumanich@lexisnexis.com;harry.gist@lexisnexis.com');	
  //append bitmap to base
	dbuildbase := project(N.BitmapInfile, transform(Infutor_NARE.layouts.Scrubs, self := left));
	//ut.MAC_SF_BuildProcess(dbuildbase,'~thor_data400::base::email::infutor_email_base',NAREBaseFile,3,,true);
	NAREBaseFile := output(dbuildbase,,'~thor_data400::base::email::infutor_email_base_'+thorlib.wuid(),overwrite,__compressed__);

RETURN sequential(submit_stats
									,output(Scrubs_report, all, named('ScrubsReportExamples'))
									//Send Alerts if Scrubs exceeds threholds
									,if(count(Scrubs_alert) > 1, mailfile, output('No_Scrubs_Alerts'))
									,NAREBaseFile);

END;
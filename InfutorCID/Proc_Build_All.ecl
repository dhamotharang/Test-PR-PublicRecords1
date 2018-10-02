import _control, instantid_logs, PromoteSupers,Scrubs_InfutorCID, Scrubs;

/////************************************************************************/
/////************************************************************************/
////Spraying and add to IN superfile done on Unix
////  edata14 /load01/infutor_cid
////  run.ksh
/////************************************************************************/
/////************************************************************************/

Export Proc_Build_All(string version) := function

#workunit('name', 'Yogurt: InfutorCID/InstantID_Logs Build ' + version);

//////////////////////////////SCRUBS INFUTOR///////////////////////////////////
F := Scrubs_InfutorCID.In_InfutorCidBase;
S :=Scrubs_InfutorCID.Scrubs; // My scrubs module
N :=S.FromNone(F); //	scrub_file_step1
// T := S.FromBits(N.BitmapInfile);   // Use the FromBits module; makes my bitmap datafile easier to get to
U := S.FromExpanded(N.ExpandedInFile); // 	scrub_file_step2
// Orbit Stats
Orbit_st := U.OrbitStats() : persist('~persist::InfutorCid_orbit_stats'); 
scrubs_rpt := Scrubs.OrbitProfileStats('Scrubs_InfutorCid', , Orbit_st, version).CompareToProfile_with_examples;
//Submits stats to Orbit
	submit_stats := Scrubs.OrbitProfileStats('Scrubs_InfutorCid',, Orbit_st, version).SubmitStats;
	Scrubs_alert := scrubs_rpt(RejectWarning = 'Y');
	attachment := Scrubs.fn_email_attachment(Scrubs_alert);

mailfile := FileServices.SendEmailAttachData('uma.pamarthy@lexisnexis.com'
																						,'InfutorCid Scrubs Report Subject' //subject
																						,'InfutorCid Scrubs Report Body' //body
																						,(data)attachment
																						,'text/csv'
																						,'InfutorCidScrubsReport.csv'
																						,
																						,
																						,_Control.MyInfo.EmailAddressNotify);	
/////////////////////////////////////////////////////////////////////////////////////////
New_Inputs		:= nothor(fileservices.superfilecontents('~thor_data400::in::infutorcid', 1))[1].name <>'';

PromoteSupers.MAC_SF_BuildProcess(infutorCID.Map_InfutorCIDv2(version), '~thor_data400::base::infutorcid', Swapfiles, 3,,true);
 
Create_Build := 
			sequential(
				/*Build Instant ID File */	InstantID_Logs.Proc_Build_All(version),
				if(~New_Inputs, output('No New Infutor CID Inputs on Thor'),
										sequential(
											output('Begin Data Mapping...',named('Infutor_CID_Process___')),
				/*Create area code change file*/InfutorCID.Proc_Npa_Change (version)
		//////////////////SCRUBS REPORTS////////////////////////		
		,submit_stats
		//output Scrubs Report
		,output(scrubs_rpt, all, named('ScrubsReportWithExamples'))
		//Send Alerts if Scrubs exceeds threholds
		,if(count(Scrubs_alert) > 1, mailfile, output('No_Scrubs_Alerts'))	,					
		///////////////////////////////////////////////////////////				
				/*Build Base with History & Swap Super*/	SwapFiles,
				/*Build Keys*/				InfutorCID.Proc_Build_Keys(version),
				/*InfutorCID Stats*/		InfutorCID.Proc_Build_Stats(version),
				/*Generate Strata*/			InfutorCID.strata_populationcounts(version),
				/*Clear Superfile*/			fileservices.clearsuperfile('~thor_data400::in::infutorcid'))))
: Failure(FileServices.SendEmail('cecelie.guyton@lexisnexis.com, deborah.torhanova@lexisnexis.com ,cnguyton@tmo.blackberry.net', 'Infutor CID/Instant ID Failure',thorlib.wuid() + '\n\n' +FAILMESSAGE));

return sequential(Create_Build);//, Create_History);
end;
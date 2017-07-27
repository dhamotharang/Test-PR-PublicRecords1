IMPORT Org_Mast, Scrubs, Scrubs_Org_Mast, _Control;

EXPORT Scrub_Code (string filedate, boolean pUseProd = false) := MODULE
		EXPORT Scrub_Code_Orgzn(string projName, string fileName, string scopeName) := FUNCTION

			scrubs_rep_dir_str := 'Scrubs_' + projName;
			scrubs_in_file_str := scopeName + '_In_' + scopeName;
			scrubs_mod_str := scopeName + '_Scrubs';
			scrubs_orbit_profile_name_str := 'Scrubs_' + projName + '_' + scopeName;
			

		// Code for Scrub
		//********************************Apply Scrubs before building the base file***************************
			//recordsToScrub						:=	PROJECT(pBaseFile, TRANSFORM(Org_Mast.Layouts.organization_base,SELF:=LEFT));
			recordsToScrub						:=	StandardizeInputFile(filedate, pUseProd).organization;

			scrubs_Org_Mast					:=	Scrubs_Org_Mast.Orgzn_Scrubs;									//	Scrubs Module for Org_Mast PM Layout

			dOrg_Mast_ScrubbedRecords		:=	scrubs_Org_Mast.FromNone(recordsToScrub);		//	Generate the Org_Mast PM error flags
			dOrg_Mast_ExpandedRecords		:=	scrubs_Org_Mast.FromExpanded(dOrg_Mast_ScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module

			ErrorSummary							:=	OUTPUT(dOrg_Mast_ExpandedRecords.SummaryStats, NAMED('ErrorSummary_' + scopeName),OVERWRITE);										//	Show errors by field and type
			EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dOrg_Mast_ExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors_' + scopeName),OVERWRITE);		//	Just eyeball some errors
			SomeErrorValues						:=	OUTPUT(CHOOSEN(dOrg_Mast_ExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues_' + scopeName),OVERWRITE);			//	See my error field values

		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
		persistFileName := '~persist::' + scrubs_rep_dir_str + '_' + scopeName + '_scrubs_rpt';
			Orbitstats					:=	dOrg_Mast_ExpandedRecords.OrbitStats():persist(persistFileName);	//	Get our stats

		//Submits stats to Orbit
			submitStats								:=	Scrubs.OrbitProfileStats(scrubs_orbit_profile_name_str,,Orbitstats,filedate,scrubs_in_file_str).SubmitStats;
		//Output Scrubs report with examples in WU
			dScrubsWithExamples				:=	Scrubs.OrbitProfileStats(scrubs_orbit_profile_name_str,,Orbitstats,filedate,scrubs_in_file_str).CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
			scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
			scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
			msg := 'Scrubs Org_Mast Provider Master Report Test for Scopename: ' + scopeName;
			mailfile									:=	FileServices.SendEmailAttachData(Org_Mast.email_notification_lists.BuildSuccess //	_Control.MyInfo.EmailAddressNotify
																																,msg //subject
																																,msg + ' WU: ' + WORKUNIT //body
																																,(data)scrubsAttachment
																																,'text/csv'
																																,'Org_Mast_PM_ScrubsReport.csv'
																																,
																																,
																																,_Control.MyInfo.EmailAddressNotify);	
		//****************************************************************************************************
			SEQUENTIAL(
				// ErrorSummary,
				// EyeballSomeErrors,
				// SomeErrorValues,
				SubmitStats
				// mailfile
			);

			Return true;
		END; //END FUNCTION	
		
		EXPORT Scrub_Code_Aff(string projName, string fileName, string scopeName) := FUNCTION

			scrubs_rep_dir_str := 'Scrubs_' + projName;
			scrubs_in_file_str := scopeName + '_In_' + scopeName;
			scrubs_mod_str := scopeName + '_Scrubs';
			scrubs_orbit_profile_name_str := 'Scrubs_' + projName + '_' + scopeName;
			

		// Code for Scrub
		//********************************Apply Scrubs before building the base file***************************
//			recordsToScrub						:=	PROJECT(pBaseFile, TRANSFORM(Org_Mast.Layouts.organization_base,SELF:=LEFT));
			recordsToScrub						:=	StandardizeInputFile(filedate, pUseProd).affiliations;

			scrubs_Org_Mast					:=	Scrubs_Org_Mast.Aff_Scrubs;									//	Scrubs Module for Org_Mast PM Layout

			dOrg_Mast_ScrubbedRecords		:=	scrubs_Org_Mast.FromNone(recordsToScrub);		//	Generate the Org_Mast PM error flags
			dOrg_Mast_ExpandedRecords		:=	scrubs_Org_Mast.FromExpanded(dOrg_Mast_ScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module

			ErrorSummary							:=	OUTPUT(dOrg_Mast_ExpandedRecords.SummaryStats, NAMED('ErrorSummary_' + scopeName),OVERWRITE);										//	Show errors by field and type
			EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dOrg_Mast_ExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors_' + scopeName),OVERWRITE);		//	Just eyeball some errors
			SomeErrorValues						:=	OUTPUT(CHOOSEN(dOrg_Mast_ExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues_' + scopeName),OVERWRITE);			//	See my error field values

		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
		persistFileName := '~persist::' + scrubs_rep_dir_str + '_' + scopeName + '_scrubs_rpt';
			Orbitstats					:=	dOrg_Mast_ExpandedRecords.OrbitStats():persist(persistFileName);	//	Get our stats

		//Submits stats to Orbit
			submitStats								:=	Scrubs.OrbitProfileStats(scrubs_orbit_profile_name_str,,Orbitstats,filedate,scrubs_in_file_str).SubmitStats;
		//Output Scrubs report with examples in WU
			dScrubsWithExamples				:=	Scrubs.OrbitProfileStats(scrubs_orbit_profile_name_str,,Orbitstats,filedate,scrubs_in_file_str).CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
			scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
			scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
			msg := 'Scrubs Org_Mast Provider Master Report Test for Scopename: ' + scopeName;
			mailfile									:=	FileServices.SendEmailAttachData(Org_Mast.email_notification_lists.BuildSuccess //	_Control.MyInfo.EmailAddressNotify
																																,msg //subject
																																,msg + ' WU: ' + WORKUNIT //body
																																,(data)scrubsAttachment
																																,'text/csv'
																																,'Org_Mast_PM_ScrubsReport.csv'
																																,
																																,
																																,_Control.MyInfo.EmailAddressNotify);	
		//****************************************************************************************************
			SEQUENTIAL(
				// ErrorSummary,
				// EyeballSomeErrors,
				// SomeErrorValues,
				SubmitStats
				// mailfile
			);

			Return true;
		END; //END FUNCTION	
		
				
		Scrubbed_Output_Org := Scrub_Code_Orgzn('Org_Mast', 'organization', 'orgzn');
		Scrubbed_Output_Aff := Scrub_Code_Aff('Org_Mast', 'affiliations', 'aff');

    full_build :=
		PARALLEL(
			Scrubbed_Output_Org;
			Scrubbed_Output_Aff;
		);
		
		EXPORT All := full_build;
		
END; // Module		

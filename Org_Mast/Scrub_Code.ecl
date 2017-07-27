IMPORT Org_Mast, Scrubs, Scrubs_Org_Mast, _Control;

EXPORT Scrub_Code (string filedate, boolean pUseProd = false) := MODULE
		EXPORT Scrub_Code(Dataset(Org_Mast.Layouts.Organization_base) pBaseFile, string version) := FUNCTION
		// Code for Scrub
		//********************************Apply Scrubs before building the base file***************************
			recordsToScrub						:=	PROJECT(pBaseFile, TRANSFORM(Org_Mast.Layouts.Organization_base,SELF:=LEFT));

			scrubs_Org_Mast					:=	Scrubs_Org_Mast.Orgzn_Scrubs;									//	Scrubs Module for Org_Mast Layout

			dOrgScrubbedRecords		:=	scrubs_Org_Mast.FromNone(recordsToScrub);		//	Generate the Org_Mast error flags
			dOrgExpandedRecords		:=	scrubs_Org_Mast.FromExpanded(dOrgScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module

			ErrorSummary							:=	OUTPUT(dOrgExpandedRecords.SummaryStats, NAMED('ErrorSummary'),OVERWRITE);										//	Show errors by field and type
			EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dOrgExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'),OVERWRITE);		//	Just eyeball some errors
			SomeErrorValues						:=	OUTPUT(CHOOSEN(dOrgExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'),OVERWRITE);			//	See my error field values

		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
			Orbitstats					:=		dOrgExpandedRecords.OrbitStats():persist('~persist::Org_Mast_scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
			submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Org_Master','Scrubs',Orbitstats,version,'Org_Master').SubmitStats;
		//Output Scrubs report with examples in WU
			dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Org_Master','Scrubs',Orbitstats,version,'Org_Master').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
			scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
			Alerts										:= OUTPUT(scrubsAlert, NAMED('AlertsSummary'),OVERWRITE);
			scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
			mailfile									:=	FileServices.SendEmailAttachData(Org_Mast.email_notification_lists.BuildSuccess //	_Control.MyInfo.EmailAddressNotify
																																,'Scrubs Scrubs_Org_Organization Report Test' //subject
																																,'Scrubs Scrubs_Org_Organization Report Test WU: '+WORKUNIT //body
																																,(data)scrubsAttachment
																																,'text/csv'
																																,'Scrubs_Org_Organization ScrubsReport.csv'
																																,
																																,
																																,_Control.MyInfo.EmailAddressNotify);	
		//****************************************************************************************************
			SEQUENTIAL(
				ErrorSummary,
				EyeballSomeErrors,
				SomeErrorValues,
				SubmitStats,
				Alerts,
				mailfile
			);

			Return true;
		END; //FUNCTION	
		ToScrub_File := Org_Mast.StandardizeInputFile(filedate,pUseProd).Organization;
		EXPORT Scrubbed_Output := Scrub_Code(ToScrub_File, filedate);
END; // Module		

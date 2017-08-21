IMPORT HMS, Scrubs, Scrubs_HMS, _Control;

EXPORT Scrub_Code (string filedate, boolean pUseProd = false) := MODULE
		EXPORT Scrub_Code(Dataset(hms.Layouts.Individual_base) pBaseFile, string version) := FUNCTION
		// Code for Scrub
		//********************************Apply Scrubs before building the base file***************************
			recordsToScrub						:=	PROJECT(pBaseFile, TRANSFORM(hms.Layouts.Individual_base,SELF:=LEFT));

			scrubsHMS					:=	Scrubs_HMS.Individuals_Scrubs;									//	Scrubs Module for HMS PM Layout

			dHmsScrubbedRecords		:=	scrubsHMS.FromNone(recordsToScrub);		//	Generate the HMS PM error flags
			dHmsExpandedRecords		:=	scrubsHMS.FromExpanded(dHmsScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module

			ErrorSummary							:=	OUTPUT(dHmsExpandedRecords.SummaryStats, NAMED('ErrorSummary'),OVERWRITE);										//	Show errors by field and type
			EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dHmsExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'),OVERWRITE);		//	Just eyeball some errors
			SomeErrorValues						:=	OUTPUT(CHOOSEN(dHmsExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'),OVERWRITE);			//	See my error field values

		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
			Orbitstats					:=	dHmsExpandedRecords.OrbitStats():persist('~persist::hms_pm_scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
			submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_HMS_Individuals','Scrubs',Orbitstats,version,'HMS_PM').SubmitStats;
		//Output Scrubs report with examples in WU
			dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_HMS_Individuals','Scrubs',Orbitstats,version,'HMS_PM').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
			scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
			scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
			mailfile									:=	FileServices.SendEmailAttachData(hms.email_notification_lists.BuildSuccess //	_Control.MyInfo.EmailAddressNotify
																																,'Scrubs HMS Provider Master Report Test' //subject
																																,'Scrubs HMS Provider Master Report Test WU: '+WORKUNIT //body
																																,(data)scrubsAttachment
																																,'text/csv'
																																,'HMS_PM_ScrubsReport.csv'
																																,
																																,
																																,_Control.MyInfo.EmailAddressNotify);	
		//****************************************************************************************************
			SEQUENTIAL(
				ErrorSummary,
				EyeballSomeErrors,
				SomeErrorValues,
				SubmitStats
			//	mailfile Removed to receive orbit notification only. AP.
			);

			Return true;
		END; //FUNCTION	
		ToScrub_File := hms.StandardizeInputFile(filedate,pUseProd).Individual;
		EXPORT Scrubbed_Output := Scrub_Code(ToScrub_File, filedate);
END; // Module		

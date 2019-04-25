//Code to handle despray and email for key validation
//Arguments: Datasetname as string, summaryDS as dataset, buildVersion as string
//Author: Vikram Pareddy


EXPORT DesprayAndEmailSummary(__dsName, __summaryDS, __buildVersion, __isDev=true) := macro
		IMPORT FDN_QA, std, Vikram, advfiles, ut;
		
		ADVBase := advfiles.ADV_Base(__isDev);
		
	//***********************************Despraying summary report onto local server**************************************//
    desprayLayout := record
			string datasetName;
			string WUID;
			string buildVersion;
			recordof(__summaryDS);
		end;
		
		fileToBeDesprayed := project(__summaryDS, transform(desprayLayout,
			self.datasetName := __dsName;
			self.WUID := workunit;
			self.buildVersion := __buildVersion;
			self := left;));
			
			desprayFileThorName := if(__isDev=true, '~qa::testing::'+__dsName+'::keyValidation::desprayFile::' +__buildVersion, 
																													'~qa::'+__dsName+'::keyValidation::desprayFile::' +__buildVersion);
			desprayFolderLocation := if(__isDev=true, 'C:\\KeyValidation\\summaryReports\\test\\', 'C:\\KeyValidation\\summaryReports\\');
			
			eighteenServer := '10.48.72.34';
		despraySummary := Vikram.desprayFile(fileToBeDesprayed, desprayFileThorName,  
																						eighteenServer, desprayFolderLocation, __dsName+ '_' + __buildVersion + '.csv', __isDev);
		
		//FDN SPECIFIC TESTS
		//payload validation and source mapping are specific to FDN dataset. It gets called only if the dsName is FDN
		// payloadValidationResult := FDN_QA.FDN_payload_validation;
    // sourceMappingResult := FDN_QA.SourceMappingSummary;

		//preparing an csv attachment out of the summary dataset
			XtabOut := Vikram.getAttachmentForEmail('~qa::'+__dsName+'::keyValidation::desprayFile::' +__buildVersion, workunit);
			no_of_records := count(XtabOut);
			
		//send email task
		emailSummary := fileservices.SendEmailAttachText(AdvBase.Report_Recipients,	
					__dsName + '_keyval_summary_' +__buildVersion+'' ,
					__dsName+' Key validation Summary' + '\n' ,//+ if(__dsName='FDN', payloadValidationResult + '\n' + sourceMappingResult, ''),
					XtabOut[no_of_records].line ,
					'text/plain; charset=ISO-8859-3', 
					__dsName + '_keyval_summary_' +__buildVersion+'.csv',
					,
					,
					AdvBase.Email_Notification_From_Address
				);
				
			sequential(output(__summaryDS), despraySummary); 
											// if(__isDev=true, output('No email required'), emailSummary));

endmacro;
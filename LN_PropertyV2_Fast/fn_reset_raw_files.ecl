EXPORT fn_reset_raw_files := FUNCTION

rawSuperFileNames := dataset([LN_PropertyV2_Fast.FileNames.raw.bk.assessment,
											  LN_PropertyV2_Fast.FileNames.raw.bk.assessment_repl,
												LN_PropertyV2_Fast.FileNames.raw.bk.deed,
												LN_PropertyV2_Fast.FileNames.raw.bk.deed_repl,
												LN_PropertyV2_Fast.FileNames.raw.bk.mortgage,
												LN_PropertyV2_Fast.FileNames.raw.bk.mortgage_repl,
												LN_PropertyV2_Fast.FileNames.raw.frs.deed,
												LN_PropertyV2_Fast.FileNames.raw.frs.assessment,
												LN_PropertyV2_Fast.FileNames.raw.frs.assessment_ptu
												],{string rawSuperFileName});

report(string msg) := output(dataset([{msg}],{string message}),named('LOG'),extend); // <---- ACTION

// for each logical file in the superfile
//   remove logical file description

clearLogicalFileDescription(string s,string superFile) := sequential(
				
				fileservices.SetFileDescription( '~'+s, ''), // <-- ACTION
				
				report('Raws file description being cleared: '+s+' ( in '+superFile+')')
);

resetSuperFileSubFilesDescriptions(string superFile) := 
		apply(fileservices.SuperFileContents(superFile),clearLogicalFileDescription(name,superfile));

removeStartedProcessingDescription := apply(rawSuperFileNames,resetSuperFileSubFilesDescriptions(rawSuperFileName));

// for each logical file in the archive super file
//   move to the un-archived superfile

moveBack(string super,string name) := sequential(
				
				fileservices.startsuperfiletransaction(),
				fileservices.addsuperfile('~'+super,'~'+name),								// <-- ACTION
				fileservices.removesuperfile('~'+super+'_archive','~'+name), // <-- ACTION
				fileservices.finishsuperfiletransaction(),
				
				report('Un-archiving '+name+' to '+super),
);

moveUnprocessedLogicalFilesFromArchiveToPreProcessedSuperFile(string super) := function
		listOfArchivedFilesInCurrentSuper := fileservices.SuperFileContents(super+'_archive');
		{listOfArchivedFilesInCurrentSuper, boolean blankDescription} checkDescription(listOfArchivedFilesInCurrentSuper L) := transform
			self.blankDescription := length(trim(fileservices.GetFileDescription('~'+L.name)))=0;
			self := L;
		END;
		incorrectlyArchived := 
						project(listOfArchivedFilesInCurrentSuper,checkDescription(LEFT))(blankDescription);
		return apply(incorrectlyArchived,moveBack(super,name));
END;

restoreIncorrectlyArchivedRawFiles := apply(rawSuperFileNames,moveUnprocessedLogicalFilesFromArchiveToPreProcessedSuperFile(rawSuperFileName));

resetPrepFiles := nothor(sequential(
						removeStartedProcessingDescription,
						restoreIncorrectlyArchivedRawFiles
					));
					
					
RETURN sequential(
						LN_PropertyV2_Fast.buildAssist_report_superFiles_contents('reset_raw','before_reset'),
						resetPrepFiles,
						LN_PropertyV2_Fast.buildAssist_report_superFiles_contents('reset_raw','after_reset')
					);

END;
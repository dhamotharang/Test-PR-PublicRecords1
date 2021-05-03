// Lists content of archive, raw and prep super files
// ensure result limit is high enough (take 1000 or more)
import std;
FsLogicalFileNameRecord := RECORD 
  STRING name; 
END;
reportLayout := record
	string superType;
	string logicalFileName;
	string fileDescription;
	string fileRecordCount;
end;

addToReport (string superFileName, string sType) := function

	logicalFileNames := std.file.SuperFileContents('~'+superFileName);
	reportLayout tFillReport(FsLogicalFileNameRecord L) := TRANSFORM
		SELF.superType := superFileName;
		SELF.logicalFileName := L.name;
		SELF.fileDescription := std.file.GetFileDescription( '~'+L.name );
		SELF.fileRecordCount := std.file.GetLogicalFileAttribute('~'+L.name ,'recordCount');

	END;
	return project(logicalFileNames,tFillReport(LEFT));

end;

				report := 
						nothor(
						//PREP
						addToReport(LN_PropertyV2_Fast.FileNames.prep.assessment,'prep')
						+addToReport(LN_PropertyV2_Fast.FileNames.prep.deed_mortg,'prep')
						+addToReport(LN_PropertyV2_Fast.FileNames.prep.addl_names,'prep')
						+addToReport(LN_PropertyV2_Fast.FileNames.prep.addl_legal,'prep')
						+addToReport(LN_PropertyV2_Fast.FileNames.prep.addl_frs_a,'prep')
						+addToReport(LN_PropertyV2_Fast.FileNames.prep.addl_frs_d,'prep')
						+addToReport(LN_PropertyV2_Fast.FileNames.prep.search_prp,'prep')
						//+addToReport(LN_PropertyV2_Fast.FileNames.prep.addl_name_info,'prep') //Additional BK A&R file
						// RAW
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.assessment,'raw')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.deed,'raw')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.assessment_repl,'raw')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.deed_repl,'raw')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.mortgage,'raw')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.mortgage_repl,'raw')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.frs.assessment,'raw')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.frs.assessment_ptu,'raw')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.frs.deed,'raw')
						// +addToReport(LN_PropertyV2_Fast.FileNames.raw.BK_AR.assignment,'raw') //New BK Mortgage Assignment file
						// +addToReport(LN_PropertyV2_Fast.FileNames.raw.BK_AR.release,'raw')	//New BK Mortgage Release file
						 // ARCHIVE
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.assessment+'_archive','archive')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.deed+'_archive','archive')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.assessment_repl+'_archive','archive')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.deed_repl+'_archive','archive')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.mortgage+'_archive','archive')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.mortgage_repl+'_archive','archive')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.frs.assessment+'_archive','archive')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.frs.assessment_ptu+'_archive','archive')
						+addToReport(LN_PropertyV2_Fast.FileNames.raw.frs.deed+'_archive','archive')
						
						);
				
EXPORT buildAssist_report_superFiles_contents(string process_date,string _when) := parallel(
				output(choosen(report(trim(fileDescription)='',regexfind('^(?!.*(prep|archive)).*$',supertype))	,1000,1),named('Files_in_raw'									   +' ('+_when+')')),			
				output(choosen(report(regexfind(process_date,fileDescription))																	,1000,1),named('Files_to_process'								 +' ('+_when+')')),
				output(choosen(report(regexfind(process_date,fileDescription),regexfind('archive',supertype))		,1000,1),named('Files_processed'								 +' ('+_when+')')),
				output(choosen(report(trim(fileDescription)='',regexfind('archive',supertype))									,1000,1),named('Files_missed_(restore_to_raw)'	 +' ('+_when+')'))
				);
				
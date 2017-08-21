import dops, std;

EXPORT Proc_New_Rpt_Farm_to_Market (string pversion ='') := function

//***************** basic parameters to pass to functions ********************
	build_metrics      := LN_PropertyV2_Fast.File_Build_Metrics.file(version = pversion);
	start_process_date := set(build_metrics, prep_start_date)[1];
	end_process_date   := set(build_metrics, key_build_end_date)[1]; 
	prod_date          := LN_PropertyV2_Fast.fn_dategmt(set(dops.GetReleaseHistory('B', 'N', 'LNPropertyV2Keys')(prodversion = pversion), prodwhenupdated)[1]); 
	qa_date            := LN_PropertyV2_Fast.fn_dategmt(set(dops.GetReleaseHistory('B', 'N', 'LNPropertyV2Keys')(certversion = pversion), certwhenupdated)[1]); 
	prev_prod_date     := LN_PropertyV2_Fast.fn_dategmt(set(dops.GetReleaseHistory('B', 'N', 'LNPropertyV2Keys')(max(prodversion < pversion)), prodwhenupdated)[1]); 
	build_type         := set(build_metrics, update_type)[1];

	FsLogicalFileNameRecord := RECORD 
	STRING name; 
	END;

	reportLayout := RECORD
		STRING superType;
		STRING logicalFileName;
		STRING fileDescription;
		STRING fileRecordCount;
	END;

		addToReport (STRING superFileName) := FUNCTION
			logicalFileNames := std.file.SuperFileContents('~'+superFileName);

			reportLayout tFillReport(FsLogicalFileNameRecord L) := TRANSFORM
				SELF.superType := superFileName;
				SELF.logicalFileName := L.name;
				SELF.fileDescription := std.file.GetFileDescription( '~'+L.name );
				SELF.fileRecordCount := std.file.GetLogicalFileAttribute('~'+L.name ,'recordCount');
			END;

			RETURN project(logicalFileNames,tFillReport(LEFT));
		END;

//***************** Pulls files from raw archive superfiles ******************
		report := 
				nothor(
				addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.assessment+'_archive')
				+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.deed+'_archive')
				+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.assessment_repl+'_archive')
				+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.deed_repl+'_archive')
				+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.mortgage+'_archive')
				+addToReport(LN_PropertyV2_Fast.FileNames.raw.bk.mortgage_repl+'_archive')
				+addToReport(LN_PropertyV2_Fast.FileNames.raw.frs.assessment+'_archive')
				+addToReport(LN_PropertyV2_Fast.FileNames.raw.frs.assessment_ptu+'_archive')
				+addToReport(LN_PropertyV2_Fast.FileNames.raw.frs.deed+'_archive')
				);

		subInSuperFile(STRING super,STRING sub) := FUNCTION
			RETURN	Sequential(
								fileservices.StartSuperFileTransaction(),
								fileservices.AddSuperFile('~'+super,'~'+sub),
								fileservices.FinishSuperFileTransaction() 
								);
			END;

//***************** Selects which raw logical files will be used for report **
		Select_Files_For_Reporting(string process_date) := sequential(
				nothor(apply(global(report(regexfind(process_date,fileDescription)),few),
							subInSuperFile(regexfind('^.*(thor.*)_archive$',trim(superType),1)+'_reporting2',trim(logicalFileName)))));

//***************** Clears superfile to receive selected raw files ***********
		clear_superfiles := sequential(
			fileservices.StartSuperFileTransaction(),
			fileservices.ClearSuperFile('~thor_data400::in::property::raw::frs::assessment_ptu_reporting2'),
			fileservices.ClearSuperFile('~thor_data400::in::property::raw::frs::assessment_reporting2'),
			fileservices.ClearSuperFile('~thor_data400::in::property::raw::frs::deed_reporting2'),
			fileservices.ClearSuperFile('~thor_data::in::ln_propertyv2::raw::bk::assessment_repl_reporting2'),
			fileservices.ClearSuperFile('~thor_data::in::ln_propertyv2::raw::bk::assessment_reporting2'),
			fileservices.ClearSuperFile('~thor_data::in::ln_propertyv2::raw::bk::deed_repl_reporting2'),
			fileservices.ClearSuperFile('~thor_data::in::ln_propertyv2::raw::bk::deed_reporting2'),
			fileservices.ClearSuperFile('~thor_data::in::ln_propertyv2::raw::bk::mortgage_repl_reporting2'),
			fileservices.ClearSuperFile('~thor_data::in::ln_propertyv2::raw::bk::mortgage_reporting2'),
			fileservices.FinishSuperFileTransaction());
	
	rpts := sequential(
				clear_superfiles,
				Select_Files_For_Reporting (pversion),
				parallel(
					output(
					LN_PropertyV2_Fast.fn_New_Rpt_Farm_to_Market(start_process_date,end_process_date, prod_date, qa_date, pversion, build_type, prev_prod_date).deed_days_apart_stats_delivery_date_updated, all,
					named('DeedByFiledate')),
					output(
					LN_PropertyV2_Fast.fn_New_Rpt_Farm_to_Market(start_process_date,end_process_date, prod_date, qa_date, pversion, build_type, prev_prod_date).assess_days_apart_stats_delivery_date_updated, all,
					named('AssessorByFiledate')),
					output(
					LN_PropertyV2_Fast.fn_New_Rpt_Farm_to_Market_hist(pversion).deed_days_apart_stats_all_updated, all,
					named('DeedBycountyFiledate')),
					output(
					LN_PropertyV2_Fast.fn_New_Rpt_Farm_to_Market_hist(pversion).assess_days_apart_stats_all_updated, all,
					named('AssessorBycountyFiledate')),
					output(
					LN_PropertyV2_Fast.fn_New_Rpt_Farm_to_Market_hist(pversion).deed_days_apart_stats_all_condensed, all,
					named('DeedBycountyCondensed')),
					)
			);

	return rpts;
end;

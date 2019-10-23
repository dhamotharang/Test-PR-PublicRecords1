IMPORT LN_PropertyV2_Fast,LN_PropertyV2,ut,Std;

// Jira DF-11862 - added isfast parameter to name persist file accordingly in order to run continuous delta
EXPORT proc2Prep(string	prepDate, boolean isFast) :=  FUNCTION

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
																 
	//DF-23895 -- Removed Superfile transaction for setting up file description as it hammered dali 

	 replaceSubFilesTag(string rawSuperFile,string oldTag = '', string newTag = '',boolean isArchive=false) := FUNCTION 
				superFileName := rawSuperFile + if(isArchive,'_archive','');
				subFileNames := fileservices.SuperFileContents(superFileName);
				return apply(subFileNames, if(trim(STD.File.GetFileDescription('~'+Name))=oldTag
																			,STD.File.SetFileDescription('~'+Name,newTag)
																		  )
																 );
		END;


		tagBeforeProcessing := apply(rawSuperFileNames,replaceSubFilesTag(rawSuperFileName,'','processing '+prepDate));
		
		// Load BK data
		iRokAn		:=	dedup(LN_PropertyV2_Fast.Files.raw.bk_assessment,record,except raw_file_name,all);
		iRokAr 		:=	dedup(LN_PropertyV2_Fast.Files.raw.bk_assessment_repl,record,except raw_file_name,all);
		
		iRokDn		:=	dedup(LN_PropertyV2_Fast.Files.raw.bk_deed,record,except raw_file_name,all);
		iRokDr		:= 	dedup(LN_PropertyV2_Fast.Files.raw.bk_deed_repl,record,except raw_file_name,all);
		
		iRokMn		:=	dedup(LN_PropertyV2_Fast.Files.raw.bk_mortgage,record,except raw_file_name,all);
		iRokMr		:= 	dedup(LN_PropertyV2_Fast.Files.raw.bk_mortgage_repl,record,except raw_file_name,all);

		// Load Fares data
		iRfrD		:=	dedup(LN_PropertyV2_Fast.Files.raw.frs_deed,record,except raw_file_name,all);
		iRfrAr	:=	dedup(LN_PropertyV2_Fast.Files.raw.frs_assessment,record,except raw_file_name,all);
		iRfrAp	:= 	dedup(LN_PropertyV2_Fast.Files.raw.frs_assessment_ptu,record,except raw_file_name,all);
				
		iRfrA		:= iRfrAr + iRfrAp;
		
		// Splt, map and save OKC prep files
		prepOkcAssessment	:= LN_PropertyV2_Fast.Map_OKC_Raw_Assessment_Base(prepDate,iRokAn,iRokAr).assessment.dNew;
		prepOkcDeed 			:= LN_PropertyV2_Fast.Map_OKC_Raw_Deed_Base(prepDate,iRokDn,iRokDr).deed.dNew;
		prepOkcMortgage 	:= LN_PropertyV2_Fast.Map_OKC_Raw_Mortgage_Base(prepDate,iRokMn,iRokMr).mortgage.dNew;
		
		prepAddlNames			:= LN_PropertyV2_Fast.Map_OKC_Raw_Assessment_Base(prepDate,iRokAn,iRokAr).addlNames.dNew
												+LN_PropertyV2_Fast.Map_OKC_Raw_Deed_Base(prepDate,iRokDn,iRokDr).addlNames.dNew
												+LN_PropertyV2_Fast.Map_OKC_Raw_Mortgage_Base(prepDate,iRokMn,iRokMr).addlNames.dNew;
		
		prepAddlLegal			:= LN_PropertyV2_Fast.Map_OKC_Raw_Assessment_Base(prepDate,iRokAn,iRokAr).addlLegal.dNew
												+LN_PropertyV2_Fast.Map_OKC_Raw_Deed_Base(prepDate,iRokDn,iRokDr).addlLegal.dNew;
		
		prepOkcSearch			:= LN_PropertyV2_Fast.Map_OKC_Raw_Assessment_Base(prepDate,iRokAn,iRokAr).search.dNew
												+LN_PropertyV2_Fast.Map_OKC_Raw_Deed_Base(prepDate,iRokDn,iRokDr).search.dNew
												+LN_PropertyV2_Fast.Map_OKC_Raw_Mortgage_Base(prepDate,iRokMn,iRokMr).search.dNew;
		
		// Split, map and and save Fares prep files;
		prepFrsAssessment	:= LN_PropertyV2_Fast.prep_frs(prepDate,iRfrD,iRfrA,isfast).assessment;
		prepFrsDeed				:= LN_PropertyV2_Fast.prep_frs(prepDate,iRfrD,iRfrA,isfast).deedMortga;
		prepFrsAddlLegal	:= LN_PropertyV2_Fast.prep_frs(prepDate,iRfrD,iRfrA,isfast).addlFLegal;
		prepAddlFaresTax 	:= LN_PropertyV2_Fast.prep_frs(prepDate,iRfrD,iRfrA,isfast).addlFrsTax;
		prepAddlFaresDeed	:= LN_PropertyV2_Fast.prep_frs(prepDate,iRfrD,iRfrA,isfast).addlFrDeed;
		prepFrsSearch			:= LN_PropertyV2_Fast.prep_frs(prepDate,iRfrD,iRfrA,isfast).searchProp;
		
		
		LN_PropertyV2_Fast.Layout_prep_assessment tReformatToCommon(LN_PropertyV2.irs_dummy_recs_assessor L)  := TRANSFORM
				SELF.update_type	:= '';
				SELF.raw_file_name:= 'irs_dummy_rec';
				SELF							:= L;
		END;
		
		LN_PropertyV2_Fast.Layout_prep_deed_mortg tReformatDeedToCommon(LN_PropertyV2.irs_dummy_recs_deed L)  := TRANSFORM
				SELF.raw_file_name:= 'irs_dummy_rec';
				SELF							:= L;
		END;

		// This file(s) are written, but are not used
		writeUnmatchedFipsFile := LN_PropertyV2_Fast.prep_frs(prepDate,iRfrD,iRfrA,isfast).writeUnmatchedFipsFile;
		// combine sources files
		combinedPrepAssessment		:=	prepOkcAssessment	
			+ dedup(sort(LN_PropertyV2_Fast.fn_get_frs_assessment_cert_date(prepFrsAssessment),record),record)
			+ project(LN_PropertyV2.irs_dummy_recs_assessor,tReformatToCommon(LEFT));
		combinedPrepDeedMortgage	:= 	prepOkcDeed   + prepOkcMortgage + prepFrsDeed
			+ project(LN_PropertyV2.irs_dummy_recs_deed,tReformatDeedToCommon(LEFT));
		combinedPrepSearch_no_sri	:= 	prepOkcSearch + prepFrsSearch;
		combinedPrepAddlLegal			:=	prepAddlLegal + prepFrsAddlLegal;

		combinedPrepSearch_no_sri map_assign_source_rec_id(combinedPrepSearch_no_sri L) := TRANSFORM
		
					self.source_rec_id := HASH64( ut.CleanSpacesAndUpper(l.vendor_source_flag) +','
																			+ ut.CleanSpacesAndUpper(l.ln_fares_id) + ','
																			+ ut.CleanSpacesAndUpper(l.source_code) +','
																			+ ut.CleanSpacesAndUpper(l.which_orig) +','
																			+ ut.CleanSpacesAndUpper(l.conjunctive_name_seq) +','
																			+ ut.CleanSpacesAndUpper(l.nameasis));
					self 								:= L;
		end;
		
		combinedPrepSearch := project(combinedPrepSearch_no_sri,map_assign_source_rec_id(LEFT));
		
		// combinedPrepAssessment, withCountryCodeCombinedPrepAssessment);
		// combinedPrepDeedMortgage, withCountryCodeCombinedPrepDeedMortgage);

		// Write combined prep files
		addToSuperFile(string superFileName, string subFileName) := FUNCTION
				RETURN SEQUENTIAL(
										if (not fileservices.SuperFileExists(superFileName), fileservices.CreateSuperFile(superFileName)),
										fileservices.StartSuperFileTransaction(),
										fileservices.AddSuperFile(superFileName,subFileName),
										fileservices.FinishSuperFileTransaction()
								);
		END;				
		prefix_dated := LN_PropertyV2_Fast.FileNames.prepCluster +
										LN_PropertyV2_Fast.FileNames.prep.prefix + prepDate+'::';

		createPrepFiles := parallel(writeUnmatchedFipsFile,
							sequential(output(combinedPrepAssessment,									 ,prefix_dated+'assessment',overwrite,compressed), 
							addToSuperFile(LN_PropertyV2_Fast.FileNames.prep.assessment,prefix_dated+'assessment'))
						,	sequential(output(combinedPrepDeedMortgage,								 ,prefix_dated+'deed_mortage',overwrite,compressed), 
							addToSuperFile(LN_PropertyV2_Fast.FileNames.prep.deed_mortg,prefix_dated+'deed_mortage'))
						, sequential(output(prepAddlNames,												 	 ,prefix_dated+'addl_names',overwrite,compressed), 
							addToSuperFile(LN_PropertyV2_Fast.FileNames.prep.addl_names,prefix_dated+'addl_names'))
						, sequential(output(combinedPrepAddlLegal,									 ,prefix_dated+'addl_legal',overwrite,compressed), 
							addToSuperFile(LN_PropertyV2_Fast.FileNames.prep.addl_legal,prefix_dated+'addl_legal'))
						, sequential(output(prepAddlFaresTax,											 	 ,prefix_dated+'addl_frs_assessment',overwrite,compressed), 
							addToSuperFile(LN_PropertyV2_Fast.FileNames.prep.addl_frs_a,prefix_dated+'addl_frs_assessment'))
						, sequential(output(prepAddlFaresDeed,										 	 ,prefix_dated+'addl_frs_deed_mortgage',overwrite,compressed), 
							addToSuperFile(LN_PropertyV2_Fast.FileNames.prep.addl_frs_d,prefix_dated+'addl_frs_deed_mortgage'))
						, sequential(output(combinedPrepSearch,										 	 ,prefix_dated+'search',overwrite,compressed), 
							addToSuperFile(LN_PropertyV2_Fast.FileNames.prep.search_prp,prefix_dated+'search'))
					 );
		archiveRawFile(string rawSuperFile) := FUNCTION 
			  archiveSuperFile := rawSuperFile+'_archive';
				subFileNames := nothor(fileservices.SuperFileContents(rawSuperFile));
				{subFileNames, string description :=''} tUpdateDescription(subFileNames L) := TRANSFORM
					//SELF.description := when('',nothor(fileservices.SetFileDescription( '~'+L.name , 'prep_date '+prepDate )));
					SELF := L;
				END;
				return sequential(
													//output(project(subFileNames,tUpdateDescription(LEFT)),NAMED('List_of_files_prepped'),EXTEND), // Tag raw files with prep date
													fileservices.CreateSuperFile(archiveSuperFile,,true),// Creates super file if it does not exist
													fileservices.StartSuperFileTransaction(),
													fileservices.AddSuperFile(archiveSuperFile,rawSuperFile,,true),// add content (NOT by reference)
													fileservices.ClearSuperFile(rawSuperFile), // now finish the job and clear the origin raw super file
													fileservices.FinishSuperFileTransaction()
													);
		END;
		archiveRawFiles := nothor(apply(rawSuperFileNames,archiveRawFile(rawSuperFileName)));

		tagAfterProcessing := apply(rawSuperFileNames,replaceSubFilesTag(rawSuperFileName,'processing '+prepDate,'process_date '+prepDate,true));														
		return sequential(
											LN_PropertyV2_Fast.BuildLogger.update(prepDate,'prep_start_date',(STRING8)Std.Date.Today()),
											nothor(tagBeforeProcessing),
											createPrepFiles,
											archiveRawFiles,
											LN_PropertyV2_Fast.fn_Audit_Input_archive,
											nothor(tagAfterProcessing),
											LN_PropertyV2_Fast.BuildLogger.update(prepDate,'prep_end_date',(STRING8)Std.Date.Today()),
										);
END;
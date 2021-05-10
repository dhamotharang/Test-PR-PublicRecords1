import _control, versioncontrol, MCI;

export Build_Base_V2 := module
   
		EXPORT build_base_members(
					 string				pVersion
					,boolean			pUseProd
					,string				gcid
					,unsigned1		pLexidThreshold
					,string1			pHistMode
					,string100		gcid_name
					,string10			pBatch_jobID
					,string1			pAppendOption) := module
//AppendOption:
// 1 - Append LexID to records with LexID match AND Customer Record Key for all records
// 2 - Append LexID to records with LexID match AND Customer Record Key ONLY for records with NO LEXID
// 3 - Append LexID ONLY to records with LexID match and DO NOT append Customer Record Key for any records
// 4 - Append ONLY Customer Record Key for all records - NO LEXID appends for any records
	
					shared build_base_member := MCI.Update_Base_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).all_data_base;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames_V2(pVersion, pUseProd, gcid, pHistMode).member_base.new
																				 	,build_base_member
																					,Build_member_Base
																					);
					shared full_build_member	:=  
						sequential(				
						 		 Build_member_Base
								 ,if(pHistMode = 'A', MCI.Promote_V2.promote_base(pVersion,pUseProd,gcid,pHistMode).buildfiles.New2Built,
								 sequential(
										fileservices.startsuperfiletransaction()
										,fileservices.addsuperfile('~usgv::mci::base::' + gcid + '::built_nosave',MCI.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).member_base.new)
										// ,fileservices.addsuperfile('~usgv::mci::base::' + gcid + '::qa_nosave',MCI.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).member_base.new)
										,fileservices.finishsuperfiletransaction()))); 
									// only promote save all base files through normal promote - nosave base files should only go to QA, and will 
									// eventually be deleted with the nosave cleanup process
	
					export member_all	:=
						if(VersionControl.IsValidVersion(pVersion[1..8])
								,full_build_member
								,output('No Valid version parameter passed, skipping member base build')
						);
		END;
	
		EXPORT process_input_file(
					 string				pVersion
					,boolean			pUseProd
					,string				gcid
					,unsigned1		pLexidThreshold
					,string1			pHistMode
					,string100		gcid_name
					,string10			pBatch_jobID
					,string1			pAppendOption) := module
//AppendOption:
// 1 - Append LexID to records with LexID match AND Customer Record Key for all records
// 2 - Append LexID to records with LexID match AND Customer Record Key ONLY for records with NO LEXID
// 3 - Append LexID ONLY to records with LexID match and DO NOT append Customer Record Key for any records
// 4 - Append ONLY Customer Record Key for all records - NO LEXID appends for any records
	
					shared build_processed_input := MCI.Update_Base_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).processed_input;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames_V2(pVersion, pUseProd, gcid, pHistMode).processed_input.new
																				 	,build_processed_input
																					,Build_input_process_file
																					);
																					
					shared full_process_input	:=  
						sequential(				
						 		 Build_input_process_file
								,Promote_V2.promote_processed_input(pVersion, pUseProd, gcid, pHistMode).buildfiles.New2Built);
	
					export process_input_all	:=
						if(VersionControl.IsValidVersion(pVersion[1..8])
								,full_process_input
								,output('No Valid version parameter passed, skipping processed input file build')
						);
		END;
	
		EXPORT build_batch_output(
					 string				pVersion
					,boolean			pUseProd
					,string				gcid
					,unsigned1 		pLexidThreshold
					,string1			pHistMode
					,string100		gcid_name
					,string10			pBatch_jobID
					,string1			pAppendOption) := module
//AppendOption:
// 1 - Append LexID to records with LexID match AND Customer Record Key for all records
// 2 - Append LexID to records with LexID match AND Customer Record Key ONLY for records with NO LEXID
// 3 - Append LexID ONLY to records with LexID match and DO NOT append Customer Record Key for any records
// 4 - Append ONLY Customer Record Key for all records - NO LEXID appends for any records
	
					shared build_batch_output := MCI.Update_Base_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).return_tobatch;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames_V2(pVersion, pUseProd, gcid, pHistMode).tobatch_file.new
																				 	,build_batch_output
																					,Build_output_tobatch
																					);
					shared full_batch_output	:=  
						sequential(				
						 		 Build_output_tobatch
								,MCI.Functions.PipeFile(pVersion, pUseProd, gcid, pHistMode, pBatch_jobID)
								,Promote_V2.promote_return_tobatch(pVersion, pUseProd, gcid, pHistMode).buildfiles.New2Built);
	
					export full_batch_all	:=
						if(VersionControl.IsValidVersion(pVersion[1..8])
								,full_batch_output
								,output('No Valid version parameter passed, skipping batch output build')
						);
		END;
		
		EXPORT build_base_metrics(
					 string				pVersion
					,boolean			pUseProd
					,string				gcid
					,unsigned1		pLexidThreshold
					,string1			pHistMode
					,string100		gcid_name
					,string10			pBatch_jobID
					,string1			pAppendOption) := module
//AppendOption:
// 1 - Append LexID to records with LexID match AND Customer Record Key for all records
// 2 - Append LexID to records with LexID match AND Customer Record Key ONLY for records with NO LEXID
// 3 - Append LexID ONLY to records with LexID match and DO NOT append Customer Record Key for any records
// 4 - Append ONLY Customer Record Key for all records - NO LEXID appends for any records
	
					shared build_base_metrics := MCI.Update_Base_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).Return_Metrics;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames_V2(pVersion, pUseProd, gcid, pHistMode).tobatch_metrics_file.new
																				 	,build_base_metrics
																					,Build_metrics_Base
																					);
					export full_build_metrics	:=  
						sequential(				
						 		 Build_metrics_Base
								,MCI.Functions.PipeMetricsFile(pVersion, pUseProd, gcid, pHistMode, pBatch_jobID)
								,MCI.Functions.PipeHistoryFile(pVersion, pUseProd, gcid, pHistMode, pBatch_jobID)
									// putting this here to convert the linking history file to pipe-delimited, to be consistent with the other
									// output files that are desprayed to batch at the end of the CRK process - the history file does not
									// relate directly to the metrics file, but the history file is not called anywhere else, so no "good"
									// place to call this function, so sticking it here to be sure it gets done before despray
								,Promote_V2.promote_tobatch_metrics(pVersion, pUseProd, gcid, pHistMode).buildfiles.New2Built);
	
					export metrics_all	:=
						if(VersionControl.IsValidVersion(pVersion[1..8])
								,full_build_metrics
								,output('No Valid version parameter passed, skipping batch metrics build')
						);
		END; 
		
		EXPORT build_slim_report(
					 string				pVersion
					,boolean			pUseProd
					,string				gcid
					,unsigned1		pLexidThreshold
					,string1			pHistMode
					,string100		gcid_name
					,string10			pBatch_jobID
					,string1			pAppendOption) := module
	
					shared build_slim_report := MCI.Update_Base_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).slim_report;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames_V2(pVersion, pUseProd, gcid, pHistMode).slim_history_file.new
																				 	,build_slim_report
																					,Build_slim_file
																					);
					export full_build_slim_report	:=  
						sequential(				
						 		 Build_slim_file
								// ,Promote_V2.promote_tobatch_metrics(pVersion, pUseProd, gcid, pHistMode).buildfiles.New2Built); // figure out promote, can it be done at time of built?
						);
	
					export slim_all	:=
						if(VersionControl.IsValidVersion(pVersion[1..8])
								,full_build_slim_report
								,output('No Valid version parameter passed, skipping slim report file build')
						);
		END; 

		EXPORT Build_temp_header(
			 string				pVersion
			,boolean			pUseProd
			,string				gcid
			,string				pHistMode
			,string100		gcid_name
			,string10			batch_jobid) := module

			shared dBuildtemp_header := MCI.Convert_Base_toHeader(pVersion,pUseProd,gcid,pHistMode).Build_it;
			
			VersionControl.macBuildNewLogicalFile(
																			 MCI.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).temp_header.new
																		 	,dBuildtemp_header
																			,Build_temp_header_File
																			);
			shared full_build	:=  
				sequential(				
				 		 Build_temp_header_File
						,Promote_V2.promote_temp_header(pVersion, pUseProd, gcid, pHistMode).buildfiles.New2Built);
	
			export temp_header_all	:=
				if(VersionControl.IsValidVersion(pVersion[1..8])
						,full_build
						,output('No Valid version parameter passed, skipping temp_header build')
				);
	END;
								
END;
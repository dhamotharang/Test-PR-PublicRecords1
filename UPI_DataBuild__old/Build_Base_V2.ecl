import _control, versioncontrol, UPI_DataBuild__old;

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
	
					shared build_base_member := UPI_DataBuild__old.Update_Base_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).all_data_base;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames_V2(pVersion, pUseProd, gcid, pHistMode).member_base.new
																				 	,build_base_member
																					,Build_member_Base
																					);
					shared full_build_member	:=  
						sequential(				
						 		 Build_member_Base
								 ,if(pHistMode = 'A', UPI_DataBuild__old.Promote_V2.promote_base(pVersion,pUseProd,gcid,pHistMode).buildfiles.New2Built,
								 sequential(
										fileservices.startsuperfiletransaction()
										,fileservices.addsuperfile('~ushc::crk::base::' + gcid + '::built_nosave',UPI_DataBuild__old.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).member_base.new)
										// ,fileservices.addsuperfile('~ushc::crk::base::' + gcid + '::qa_nosave',UPI_DataBuild__old.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).member_base.new)
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
	
					shared build_processed_input := UPI_DataBuild__old.Update_Base_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).processed_input;
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
	
					shared build_batch_output := UPI_DataBuild__old.Update_Base_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).return_tobatch;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames_V2(pVersion, pUseProd, gcid, pHistMode).tobatch_file.new
																				 	,build_batch_output
																					,Build_output_tobatch
																					);
					shared full_batch_output	:=  
						sequential(				
						 		 Build_output_tobatch
								,UPI_DataBuild__old.Functions.PipeFile(pVersion, pUseProd, gcid, pHistMode, pBatch_jobID)
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
	
					shared build_base_metrics := UPI_DataBuild__old.Update_Base_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).Return_Metrics;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames_V2(pVersion, pUseProd, gcid, pHistMode).tobatch_metrics_file.new
																				 	,build_base_metrics
																					,Build_metrics_Base
																					);
					export full_build_metrics	:=  
						sequential(				
						 		 Build_metrics_Base
								,UPI_DataBuild__old.Functions.PipeMetricsFile(pVersion, pUseProd, gcid, pHistMode, pBatch_jobID)
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
	
					shared build_slim_report := UPI_DataBuild__old.Update_Base_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).slim_report;
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

			shared dBuildtemp_header := UPI_DataBuild__old.Convert_Base_toHeader(pVersion,pUseProd,gcid,pHistMode).Build_it;
			
			VersionControl.macBuildNewLogicalFile(
																			 UPI_DataBuild__old.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).temp_header.new
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
import versioncontrol, _control, ut, tools, UPI_DataBuild, HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest, Workman;
export Build_all_V2(pVersion, pUseProd, gcid, pLexidThreshold, pHistMode, gcid_name, pBatch_jobID, pAppendOption, pReceivingID, crk_suffix, pOrbEnv) := functionmacro
	return module
	export check_supers	:= function
		superFile_frombatch 						:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::from_batch::' + gcid),
																													FileServices.SuperFileExists('~ushc::crk::from_batch::' + gcid + '_nosave'));
		superFile_frombatch_hist				:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::from_batch::' + gcid + '::history'),
																													FileServices.SuperFileExists('~ushc::crk::from_batch::' + gcid + '::history_nosave'));
	
		superFile_tobatch_building		 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::to_batch::' + gcid + '::building'),
																													FileServices.SuperFileExists('~ushc::crk::to_batch::' + gcid + '::building_nosave'));
		superFile_tobatch_built				 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::to_batch::' + gcid + '::built'),
																													FileServices.SuperFileExists('~ushc::crk::to_batch::' + gcid + '::built_nosave'));
		superFile_tobatch_qa					 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::to_batch::' + gcid + '::qa'),
																													FileServices.SuperFileExists('~ushc::crk::to_batch::' + gcid + '::qa_nosave'));
		superFile_tobatch_father			 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::to_batch::' + gcid + '::father'),
																													FileServices.SuperFileExists('~ushc::crk::to_batch::' + gcid + '::father_nosave'));
		superFile_tobatch_delete				:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::to_batch::' + gcid + '::delete'),
																													FileServices.SuperFileExists('~ushc::crk::to_batch::' + gcid + '::delete_nosave'));
		
		superFile_tobatch_metrics_building		 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::to_batch_metrics::' + gcid + '::building'),
																																	FileServices.SuperFileExists('~ushc::crk::to_batch_metrics::' + gcid + '::building_nosave'));
		superFile_tobatch_metrics_built				 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::to_batch_metrics::' + gcid + '::built'),
																																	FileServices.SuperFileExists('~ushc::crk::to_batch_metrics::' + gcid + '::built_nosave'));
		superFile_tobatch_metrics_qa					 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::to_batch_metrics::' + gcid + '::qa'),
																																	FileServices.SuperFileExists('~ushc::crk::to_batch_metrics::' + gcid + '::qa_nosave'));
		superFile_tobatch_metrics_father			 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::to_batch_metrics::' + gcid + '::father'),
																																	FileServices.SuperFileExists('~ushc::crk::to_batch_metrics::' + gcid + '::father_nosave'));
		superFile_tobatch_metrics_delete				:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::to_batch_metrics::' + gcid + '::delete'),
																																	FileServices.SuperFileExists('~ushc::crk::to_batch_metrics::' + gcid + '::delete_nosave'));
	
		superFile_asHeader_building			:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::asheader::' + gcid + '::building'),
																													FileServices.SuperFileExists('~ushc::crk::asheader::' + gcid + '::building_nosave'));
		superFile_asHeader_built				:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::asheader::' + gcid + '::built'),
																													FileServices.SuperFileExists('~ushc::crk::asheader::' + gcid + '::built_nosave'));
		superFile_asHeader_qa						:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::asheader::' + gcid + '::qa'),
																													FileServices.SuperFileExists('~ushc::crk::asheader::' + gcid + '::qa_nosave'));
		superFile_asHeader_father				:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::asheader::' + gcid + '::father'),
																													FileServices.SuperFileExists('~ushc::crk::asheader::' + gcid + '::father_nosave'));
		superFile_asHeader_delete				:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::asheader::' + gcid + '::delete'),
																													FileServices.SuperFileExists('~ushc::crk::asheader::' + gcid + '::delete_nosave'));
		
		superFile_temp_header_building	:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::temp_header::' + gcid + '::building'),
																													FileServices.SuperFileExists('~ushc::crk::temp_header::' + gcid + '::building_nosave'));
		superFile_temp_header_built			:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::temp_header::' + gcid + '::built'),
																													FileServices.SuperFileExists('~ushc::crk::temp_header::' + gcid + '::built_nosave'));
		superFile_temp_header_qa				:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::temp_header::' + gcid + '::qa'),
																													FileServices.SuperFileExists('~ushc::crk::temp_header::' + gcid + '::qa_nosave'));
		superFile_temp_header_father		:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::temp_header::' + gcid + '::father'),
																													FileServices.SuperFileExists('~ushc::crk::temp_header::' + gcid + '::father_nosave'));
		superFile_temp_header_delete		:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::temp_header::' + gcid + '::delete'),
																													FileServices.SuperFileExists('~ushc::crk::temp_header::' + gcid + '::delete_nosave'));

		superFile_base_building					:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::base::' + gcid + '::building'),
																													FileServices.SuperFileExists('~ushc::crk::base::' + gcid + '::building_nosave'));
		superFile_base_built						:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::base::' + gcid + '::built'),
																													FileServices.SuperFileExists('~ushc::crk::base::' + gcid + '::built_nosave'));
		superFile_base_qa								:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::base::' + gcid + '::qa'),
																													FileServices.SuperFileExists('~ushc::crk::base::' + gcid + '::qa_nosave'));
		superFile_base_father						:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::base::' + gcid + '::father'),
																													FileServices.SuperFileExists('~ushc::crk::base::' + gcid + '::father_nosave'));
		superFile_base_delete						:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::base::' + gcid + '::delete'),
																													FileServices.SuperFileExists('~ushc::crk::base::' + gcid + '::delete_nosave'));
	
		superFile_processed_input_building	:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::processed_input::' + gcid + '::building'),
																															FileServices.SuperFileExists('~ushc::crk::processed_input::' + gcid + '::building_nosave'));
		superFile_processed_input_built			:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::processed_input::' + gcid + '::built'),
																															FileServices.SuperFileExists('~ushc::crk::processed_input::' + gcid + '::built_nosave'));
		superFile_processed_input_qa				:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::processed_input::' + gcid + '::qa'),
																															FileServices.SuperFileExists('~ushc::crk::processed_input::' + gcid + '::qa_nosave'));
		superFile_processed_input_father		:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::processed_input::' + gcid + '::father'),
																															FileServices.SuperFileExists('~ushc::crk::processed_input::' + gcid + '::father_nosave'));
		superFile_processed_input_delete		:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::processed_input::' + gcid + '::delete'),
																															FileServices.SuperFileExists('~ushc::crk::processed_input::' + gcid + '::delete_nosave'));
		
		superFile_slim_history_building		:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::slim_history::' + gcid + '::building'),
																														FileServices.SuperFileExists('~ushc::crk::slim_history::' + gcid + '::building_nosave'));
		superFile_slim_history_built			:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::slim_history::' + gcid + '::built'),
																														FileServices.SuperFileExists('~ushc::crk::slim_history::' + gcid + '::built_nosave'));
		superFile_slim_history_qa					:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::slim_history::' + gcid + '::qa'),
																														FileServices.SuperFileExists('~ushc::crk::slim_history::' + gcid + '::qa_nosave'));
		superFile_slim_history_father			:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::slim_history::' + gcid + '::father'),
																														FileServices.SuperFileExists('~ushc::crk::slim_history::' + gcid + '::father_nosave'));
		superFile_slim_history_delete			:= if(pHistMode = 'A',FileServices.SuperFileExists('~ushc::crk::slim_history::' + gcid + '::delete'),
																														FileServices.SuperFileExists('~ushc::crk::slim_history::' + gcid + '::delete_nosave'));
																												
	// make sure superfiles are created	
		make_frombatch					:= map(not superFile_frombatch and pHistMode = 'A'	=> FileServices.CreateSuperFile('~ushc::crk::from_batch::' + gcid),
																	 not superFile_frombatch and pHistMode = 'N'  => FileServices.CreateSuperFile('~ushc::crk::from_batch::' + gcid + '_nosave'));
		make_frombatch_hist			:= map(not superFile_frombatch_hist and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::from_batch::' + gcid + '::history'),
																	 not superfile_frombatch_hist and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::from_batch::' + gcid + '::history_nosave'));
		
		make_tobatch_building		:= map(not superFile_tobatch_building and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::to_batch::' + gcid + '::building'),
																   not superFile_tobatch_building and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::to_batch::' + gcid + '::building_nosave'));
		make_tobatch_built			:= map(not superFile_tobatch_built and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::to_batch::' + gcid + '::built'),
																	 not superFile_tobatch_built and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::to_batch::' + gcid + '::built_nosave'));
		make_tobatch_qa					:= map(not superFile_tobatch_qa and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::to_batch::' + gcid + '::qa'),
																	 not superFile_tobatch_qa and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::to_batch::' + gcid + '::qa_nosave'));
		make_tobatch_father			:= map(not superFile_tobatch_father and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::to_batch::' + gcid + '::father'),
																	 not superFile_tobatch_father and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::to_batch::' + gcid + '::father_nosave'));
		make_tobatch_delete			:= map(not superFile_tobatch_delete and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::to_batch::' + gcid + '::delete'),
																	 not superFile_tobatch_delete and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::to_batch::' + gcid + '::delete_nosave'));
		
		make_tobatch_metrics_building		:= map(not superFile_tobatch_building and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::to_batch_metrics::' + gcid + '::building'),
																					 not superFile_tobatch_building and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::to_batch_metrics::' + gcid + '::building_nosave'));
		make_tobatch_metrics_built			:= map(not superFile_tobatch_built and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::to_batch_metrics::' + gcid + '::built'),
																					 not superFile_tobatch_built and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::to_batch_metrics::' + gcid + '::built_nosave'));
		make_tobatch_metrics_qa					:= map(not superFile_tobatch_qa and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::to_batch_metrics::' + gcid + '::qa'),
																					 not superFile_tobatch_qa and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::to_batch_metrics::' + gcid + '::qa_nosave'));
		make_tobatch_metrics_father			:= map(not superFile_tobatch_father and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::to_batch_metrics::' + gcid + '::father'),
																					 not superFile_tobatch_father and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::to_batch_metrics::' + gcid + '::father_nosave'));
		make_tobatch_metrics_delete			:= map(not superFile_tobatch_delete and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::to_batch_metrics::' + gcid + '::delete'),
																					 not superFile_tobatch_delete and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::to_batch_metrics::' + gcid + '::delete_nosave'));

		make_asheader_building	:= map(not superFile_asHeader_building and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::asheader::' + gcid + '::building'),
																	 not superFile_asHeader_building and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::asheader::' + gcid + '::building_nosave'));
		make_asheader_built			:= map(not superFile_asHeader_built and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::asheader::' + gcid + '::built'),
																	 not superFile_asHeader_built and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::asheader::' + gcid + '::built_nosave'));
		make_asheader_qa				:= map(not superFile_asHeader_qa and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::asheader::' + gcid + '::qa'),
																	 not superFile_asHeader_qa and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::asheader::' + gcid + '::qa_nosave'));
		make_asheader_father		:= map(not superFile_asHeader_father and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::asheader::' + gcid + '::father'),
																	 not superFile_asHeader_father and pHistMode = 'N' =>	FileServices.CreateSuperFile('~ushc::crk::asheader::' + gcid + '::father_nosave'));
		make_asheader_delete		:= map(not superFile_asHeader_delete and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::asheader::' + gcid + '::delete'),
																	 not superFile_asHeader_delete and pHistMode = 'N' =>	FileServices.CreateSuperFile('~ushc::crk::asheader::' + gcid + '::delete_nosave'));
		
		make_base_building			:= map(not superFile_base_building and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::base::' + gcid + '::building'),
																	 not superFile_base_building and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::base::' + gcid + '::building_nosave'));
		make_base_built					:= map(not superFile_base_built and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::base::' + gcid + '::built'),
																	 not superFile_base_built and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::base::' + gcid + '::built_nosave'));
		make_base_qa						:= map(not superFile_base_qa and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::base::' + gcid + '::qa'),
																	 not superFile_base_qa and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::base::' + gcid + '::qa_nosave'));
		make_base_father				:= map(not superFile_base_father and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::base::' + gcid + '::father'),
																	 not superFile_base_father and pHistMode = 'N' =>	FileServices.CreateSuperFile('~ushc::crk::base::' + gcid + '::father_nosave'));
		make_base_delete				:= map(not superFile_base_delete and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::base::' + gcid + '::delete'),
																	 not superFile_base_delete and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::base::' + gcid + '::delete_nosave'));
		
		make_processed_building		:= map(not superFile_processed_input_building and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::processed_input::' + gcid + '::building'),
																	 not superFile_processed_input_building and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::processed_input::' + gcid + '::building_nosave'));
		make_processed_built				:= map(not superFile_processed_input_built and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::processed_input::' + gcid + '::built'),
																	 not superFile_processed_input_built and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::processed_input::' + gcid + '::built_nosave'));
		make_processed_qa					:= map(not superFile_processed_input_qa and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::processed_input::' + gcid + '::qa'),
																	 not superFile_processed_input_qa and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::processed_input::' + gcid + '::qa_nosave'));
		make_processed_father			:= map(not superFile_processed_input_father and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::processed_input::' + gcid + '::father'),
																	 not superFile_processed_input_father and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::processed_input::' + gcid + '::father_nosave'));
		make_processed_delete			:= map(not superFile_processed_input_delete and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::processed_input::' + gcid + '::delete'),
																	 not superFile_processed_input_delete and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::processed_input::' + gcid + '::delete_nosave'));
																	 
		make_slim_history_built		:= map(not superFile_slim_history_built and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::slim_history::' + gcid + '::built'),
																	 not superFile_slim_history_built and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::slim_history::' + gcid + '::built_nosave'));
		make_slim_history_qa			:= map(not superFile_slim_history_qa and pHistMode = 'A' => FileServices.CreateSuperFile('~ushc::crk::slim_history::' + gcid + '::qa'),
																	 not superFile_slim_history_qa and pHistMode = 'N' => FileServices.CreateSuperFile('~ushc::crk::slim_history::' + gcid + '::qa_nosave'));
	
		make_them := sequential(
				make_frombatch, make_frombatch_hist,
				make_tobatch_building, make_tobatch_built, make_tobatch_qa, make_tobatch_father, make_tobatch_delete,
				make_tobatch_metrics_building, make_tobatch_metrics_built, make_tobatch_metrics_qa, make_tobatch_metrics_father, make_tobatch_metrics_delete,
				make_asheader_building, make_asheader_built, make_asheader_qa, make_asheader_father, make_asheader_delete,
				make_base_building, make_base_built, make_base_qa, make_base_father, make_base_delete,
				make_processed_building, make_processed_built, make_processed_qa, make_processed_father, make_processed_delete,
				make_slim_history_built, make_slim_history_qa);				
		return make_them;
	end;
		
	export pVersion_unique			:= pVersion + '_' + trim(pBatch_jobID);
	
	export pMasterBuild					:= 'G' + gcid + '_' + crk_suffix;
	export Orbit_token					:= if(pOrbEnv = 'QA', UPI_DataBuild.Orbit_Login(), UPI_DataBuild.Orbit_LoginPROD());
	
	export createNewBuildQA			:= 	UPI_DataBuild.Orbit_CreateBuild(
																						pMasterBuild
																					 ,UPI_DataBuild.Orbit_Tracking.OrbitBuildInProgress
																					 ,pVersion_unique
																					 ,''
																					 ,pMasterBuild
																					 ,orbit_token
																					 ,pOrbEnv):independent;
	
	export createNewBuildPROD		:= 	UPI_DataBuild.Orbit_CreateBuild(
																						pMasterBuild
																					 ,UPI_DataBuild.Orbit_TrackingPROD.OrbitBuildInProgress
																					 ,pVersion_unique
																					 ,''
																					 ,pMasterBuild
																					 ,orbit_token
																					 ,pOrbEnv):independent;
																					 
	export addComponent					:= UPI_DataBuild.Orbit_AddComponentsToABuild ( 		
																						pMasterBuild
																					 ,pVersion_unique
																					 ,pReceivingID
																					 ,orbit_token
																					 ,pOrbEnv):independent;
																					 
	export changeBuildStatusQA	:= UPI_DataBuild.Orbit_UpdateBuildStatus (		
																						pMasterBuild
																					 ,UPI_DataBuild.Orbit_Tracking.OrbitBuilt
																					 ,pVersion_unique
																					 ,orbit_token
																					 ,//comment
																					 ,pOrbEnv
																					 ):independent;
																					 
	export changeBuildStatusPROD:= UPI_DataBuild.Orbit_UpdateBuildStatus (		
																						pMasterBuild
																					 ,UPI_DataBuild.Orbit_TrackingPROD.OrbitBuilt
																					 ,pVersion_unique
																					 ,orbit_token
																					 ,//comment
																					 ,pOrbEnv
																					 ):independent;
																					 
	export changeRecdItemStatusSprayedQA	:= UPI_DataBuild.Orbit_UpdateReceiveItem (
																					 pReceivingID
																					,UPI_DataBuild.Orbit_Tracking.OrbitSprayed
																					,orbit_token
																					,pOrbEnv):independent;

	export changeRecdItemStatusSprayedPROD	:= UPI_DataBuild.Orbit_UpdateReceiveItem (
																					 pReceivingID
																					,UPI_DataBuild.Orbit_TrackingPROD.OrbitSprayed
																					,orbit_token
																					,pOrbEnv):independent;
																					
	export changeRecdItemStatusBuiltQA	:= UPI_DataBuild.Orbit_UpdateReceiveItem (
																					 pReceivingID
																					,UPI_DataBuild.Orbit_Tracking.OrbitBuilt
																					,orbit_token
																					,pOrbEnv):independent;
																					
	export changeRecdItemStatusBuiltPROD	:= UPI_DataBuild.Orbit_UpdateReceiveItem (
																					 pReceivingID
																					,UPI_DataBuild.Orbit_TrackingPROD.OrbitBuilt
																					,orbit_token
																					,pOrbEnv):independent;

	export step1 := sequential(
			check_supers
			// ,if(pOrbEnv = 'QA', ChangeRecdItemStatusSprayedQA, ChangeRecdItemStatusSprayedPROD)
			// ,if(pOrbEnv = 'QA', CreateNewBuildQA, CreateNewBuildPROD)
			// ,AddComponent			
			,FileServices.ClearSuperFile(UPI_DataBuild.Filenames_V2(pVersion_unique,pUseProd,gcid,pHistMode).batch_lInputTemplate) // if processing new input - clear out anything that might still be in the *in* superfile
			,FileServices.AddSuperFile(UPI_DataBuild.Filenames_V2(pVersion_unique,pUseProd,gcid,pHistMode).batch_lInputTemplate,UPI_DataBuild._Dataset(pUseProd).thor_cluster_files + 'from_batch::' + gcid + '::' + trim(pBatch_jobID,all) + '::' + pVersion)
																	
			,UPI_DataBuild.Build_Base_V2.process_input_file(pVersion_unique,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).process_input_all
			,UPI_DataBuild.Promote_V2.promote_processed_input(pVersion_unique,pUseProd,gcid,pHistMode).buildfiles.Built2QA
			
			,UPI_DataBuild.Build_asHeader_V2(pVersion_unique,pUseProd,gcid,pHistMode,gcid_name,pBatch_jobID).asHeader_all // for this product, the asheader is built from the previously processed base file
			,UPI_DataBuild.Promote_V2.promote_asHeader(pVersion_unique,pUseProd,gcid,pHistMode).buildfiles.Built2QA
		
			,UPI_DataBuild.Build_Base_V2.Build_temp_header(pVersion_unique,pUseProd,gcid,pHistMode,gcid_name,pBatch_jobID).temp_header_all
			,UPI_DataBuild.Promote_V2.promote_temp_header(pVersion_unique,pUseProd,gcid,pHistMode).buildfiles.Built2QA
	);

	export step2	:= HealthcareNoMatchHeader_InternalLinking.MAC_AppendCRK(
				gcid
			 ,pVersion_unique
			 ,UPI_DataBuild.Filenames_V2(pVersion_unique, pUseProd, gcid, pHistMode).temp_header.built
			 ,UPI_DataBuild.Filenames_V2(pVersion_unique, pUseProd, gcid, pHistMode).asheader.built);
			 			 
	export step3 := sequential(
			UPI_DataBuild.Build_Base_V2.Build_base_members(pVersion_unique,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).member_all
			,if(pHistMode = 'A', UPI_DataBuild.Promote_V2.promote_base(pVersion_unique,pUseProd,gcid,pHistMode).buildfiles.Built2QA,
					sequential(
						 fileservices.startsuperfiletransaction()
						,fileservices.addsuperfile('~ushc::crk::base::' + gcid + '::qa_nosave',UPI_DataBuild.Filenames_V2(pVersion_unique, pUseProd, gcid, pHistMode).member_base.new)
						// ,fileservices.addsuperfile('~ushc::crk::base::' + gcid + '::built_nosave',UPI_DataBuild.Filenames_V2(pVersion_unique, pUseProd, gcid, pHistMode).member_base.new)
						,fileservices.finishsuperfiletransaction()))
						// only promote save all base files through normal promote - nosave base files should only go to QA, and will 
						// eventually be deleted with the nosave cleanup process
																											
			,UPI_DataBuild.Build_Base_V2.Build_batch_output(pVersion_unique,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).full_batch_all
			,UPI_DataBuild.Promote_V2.promote_return_tobatch(pVersion_unique,pUseProd,gcid,pHistMode).buildfiles.Built2QA
			
			,UPI_DataBuild.Build_Base_V2.Build_base_metrics(pVersion_unique,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).full_build_metrics
			,UPI_DataBuild.Promote_V2.promote_tobatch_metrics(pVersion_unique,pUseProd,gcid,pHistMode).buildfiles.Built2QA
			
			,UPI_DataBuild.Build_Base_V2.Build_slim_report(pVersion_unique,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name,pBatch_jobID,pAppendOption).full_build_slim_report
			,sequential(
						 fileservices.startsuperfiletransaction()
						,fileservices.addsuperfile('~ushc::crk::slim_history::' + gcid + '::qa',UPI_DataBuild.Filenames_V2(pVersion_unique, pUseProd, gcid, pHistMode).slim_history_file.new)
						,fileservices.finishsuperfiletransaction())
						// push slim history files to qa superfile - no deletes and no automatic promote through additional generations
													
			,FileServices.StartSuperFileTransaction()
			,FileServices.RemoveOwnedSubFiles(UPI_DataBuild.Filenames_V2(pVersion_unique,pUseProd,gcid,pHistMode).batch_lInputHistTemplate,true)
			,FileServices.ClearSuperFile(UPI_DataBuild.Filenames_V2(pVersion_unique,pUseProd,gcid,pHistMode).batch_lInputHistTemplate)
			,FileServices.AddSuperFile(UPI_DataBuild.Filenames_V2(pVersion_unique,pUseProd,gcid,pHistMode).batch_lInputHistTemplate,  UPI_DataBuild.Filenames_V2(pVersion_unique,pUseProd,gcid,pHistMode).batch_lInputTemplate,,true)
			
			,FileServices.RemoveOwnedSubFiles(UPI_DataBuild.Filenames_V2(pVersion_unique,pUseProd,gcid,pHistMode).batch_lInputTemplate,true)
			,FileServices.ClearSuperFile(UPI_DataBuild.Filenames_V2(pVersion_unique,pUseProd,gcid,pHistMode).batch_lInputTemplate)

			,FileServices.FinishSuperFileTransaction() 
			
			// ,if(pOrbEnv = 'QA', ChangeBuildStatusQA, ChangeBuildStatusPROD)

); 
end;
endmacro;
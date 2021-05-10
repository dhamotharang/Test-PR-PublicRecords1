import versioncontrol, _control, ut, tools, std, MCI;

export Create_Aggregate(boolean pUseProd, string gcid, string pHistMode, dataset(MCI.layouts_v2.jobID_list) pBatch_jobID_list, string pVersion_start, string pVersion_end) := module
	
	export pVersion 		:= if(pVersion_start <> '', pVersion_start, (string)std.date.today());
	export pBatch_jobID	:= if(MCI.Aggregate_Report(pUseProd, gcid, pHistMode, pBatch_jobID_list, pVersion_start, pVersion_end).pBatch_jobID_set <> [], MCI.Aggregate_Report(pUseProd, gcid, pHistMode, pBatch_jobID_list, pVersion_start, pVersion_end).pBatch_jobID_set[1], '999999');
	export check_supers	:= function
			
		superFile_aggregate_report_building		 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~usgv::mci::aggregate_report::' + gcid + '::building'),
																																	FileServices.SuperFileExists('~usgv::mci::aggregate_report::' + gcid + '::building_nosave'));
		superFile_aggregate_report_built				:= if(pHistMode = 'A',FileServices.SuperFileExists('~usgv::mci::aggregate_report::' + gcid + '::built'),
																																	FileServices.SuperFileExists('~usgv::mci::aggregate_report::' + gcid + '::built_nosave'));
		superFile_aggregate_report_qa					 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~usgv::mci::aggregate_report::' + gcid + '::qa'),
																																	FileServices.SuperFileExists('~usgv::mci::aggregate_report::' + gcid + '::qa_nosave'));
		superFile_aggregate_report_father			 	:= if(pHistMode = 'A',FileServices.SuperFileExists('~usgv::mci::aggregate_report::' + gcid + '::father'),
																																	FileServices.SuperFileExists('~usgv::mci::aggregate_report::' + gcid + '::father_nosave'));
		superFile_aggregate_report_delete				:= if(pHistMode = 'A',FileServices.SuperFileExists('~usgv::mci::aggregate_report::' + gcid + '::delete'),
																																	FileServices.SuperFileExists('~usgv::mci::aggregate_report::' + gcid + '::delete_nosave'));
																													
	// make sure superfiles are created	
		make_aggregate_report_building		:= map(not superFile_aggregate_report_building and pHistMode = 'A' => FileServices.CreateSuperFile('~usgv::mci::aggregate_report::' + gcid + '::building'),
																					 not superFile_aggregate_report_building and pHistMode = 'N' => FileServices.CreateSuperFile('~usgv::mci::aggregate_report::' + gcid + '::building_nosave'));
		make_aggregate_report_built			:= map(not superFile_aggregate_report_built and pHistMode = 'A' => FileServices.CreateSuperFile('~usgv::mci::aggregate_report::' + gcid + '::built'),
																					 not superFile_aggregate_report_built and pHistMode = 'N' => FileServices.CreateSuperFile('~usgv::mci::aggregate_report::' + gcid + '::built_nosave'));
		make_aggregate_report_qa					:= map(not superFile_aggregate_report_qa and pHistMode = 'A' => FileServices.CreateSuperFile('~usgv::mci::aggregate_report::' + gcid + '::qa'),
																					 not superFile_aggregate_report_qa and pHistMode = 'N' => FileServices.CreateSuperFile('~usgv::mci::aggregate_report::' + gcid + '::qa_nosave'));
		make_aggregate_report_father			:= map(not superFile_aggregate_report_father and pHistMode = 'A' => FileServices.CreateSuperFile('~usgv::mci::aggregate_report::' + gcid + '::father'),
																					 not superFile_aggregate_report_father and pHistMode = 'N' => FileServices.CreateSuperFile('~usgv::mci::aggregate_report::' + gcid + '::father_nosave'));
		make_aggregate_report_delete			:= map(not superFile_aggregate_report_delete and pHistMode = 'A' => FileServices.CreateSuperFile('~usgv::mci::aggregate_report::' + gcid + '::delete'),
																					 not superFile_aggregate_report_delete and pHistMode = 'N' => FileServices.CreateSuperFile('~usgv::mci::aggregate_report::' + gcid + '::delete_nosave'));

	
		make_them := sequential(
				make_aggregate_report_building, make_aggregate_report_built, make_aggregate_report_qa, make_aggregate_report_father, make_aggregate_report_delete);				
		return make_them;
	end;
		
	export pVersion_unique			:= pVersion + '_' + trim(pBatch_jobID);
	
	export do_it := //sequential(
				 //check_supers			
				MCI.Aggregate_Report(pUseProd,gcid,pHistMode,pBatch_jobID_list,pVersion_start,pVersion_end).get_all;

end;

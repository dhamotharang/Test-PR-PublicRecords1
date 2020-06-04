import _control, versioncontrol, std, UPI_DataBuild;

export Build_Aggregate(boolean pUseProd, string gcid, string pHistMode,  dataset (UPI_DataBuild.Layouts_V2.jobID_list) pBatch_jobID_list, string pVersion_start, string pVersion_end) := module

	export pVersion 		:= if(pVersion_start <> '', pVersion_start, (string)std.date.today());
	export pBatch_jobID	:= if(UPI_DataBuild.Aggregate_Report(pUseProd, gcid, pHistMode, pBatch_jobID_list, pVersion_start, pVersion_end).pBatch_jobID_set <> [], UPI_DataBuild.Aggregate_Report(pUseProd, gcid, pHistMode, pBatch_jobID_list, pVersion_start, pVersion_end).pBatch_jobID_set[1], '999999');
	
	shared build_aggregate := UPI_DataBuild.Create_Aggregate(pUseProd,gcid,pHistMode,pBatch_jobID_list,pVersion_start,pVersion_end).do_it;
	VersionControl.macBuildNewLogicalFile(
																	 Filenames_V2(pVersion + '_' + pBatch_jobID, pUseProd, gcid, pHistMode).aggregate_report_file.new
																 	,build_aggregate
																	,Build_aggregate_report
																	);
	export full_build_aggregate	:=  
		sequential(				
		 		 Build_aggregate_report
				,Promote_V2.promote_aggregate(pVersion + '_' + pBatch_jobID, pUseProd, gcid, pHistMode).buildfiles.New2Built
				,Promote_V2.promote_aggregate(pVersion + '_' + pBatch_jobID, pUseProd, gcid, pHistMode).buildfiles.Built2QA
				,UPI_DataBuild.Functions.PipeAggregateFile(pVersion + '_' + pBatch_jobID, pUseProd, gcid, pHistMode, pBatch_jobID));
	
	export aggregate_all	:=
		if(VersionControl.IsValidVersion(pVersion[1..8])
				,full_build_aggregate
				,output('No Valid parameter passed, skipping aggregate report build')
		);
END; 	

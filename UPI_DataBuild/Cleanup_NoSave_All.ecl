import versioncontrol, _control, ut, tools, UPI_DataBuild, HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest, Workman;
export Cleanup_NoSave_All(pAsOfDate) := functionmacro
	return module
		
	export dataset_for_linking_delete	:= function
		filenames_ds	:= UPI_DataBuild.NoSave_Cleanup.search_logical_files(pAsOfDate,'BASE');

		rCleanup  :=  RECORD
			STRING  pSrc;
			STRING  pVersion;
		END;

		gcid_date_ds	:=sort(project(filenames_ds, transform(rcleanup, self.pSrc := left.gcid, self.pVersion := left.version)), -pSrc);
		return gcid_date_ds;
	end;

	export step1 := UPI_DataBuild.NoSave_Cleanup.search_and_destroy_all(pAsOfDate);

	export step2	:= APPLY(dataset_for_linking_delete, HealthcareNoMatchHeader_Ingest.Cleanup(pSrc,pVersion,,,TRUE,TRUE).deleteAllFiles);
	
	export all_steps	:= sequential(
														 step1
														,step2);
	
	end;
endmacro;

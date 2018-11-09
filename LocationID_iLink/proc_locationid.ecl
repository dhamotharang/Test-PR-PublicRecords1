import LocationID_Build;
import LocationID_Ingest;
import wk_ut;

export proc_locationid := module

 export f_locationid_in	  := LocationID_Ingest.files_locationid.FILE_LOCATION_ID_IN  + '_' + LocationID_Build.KeySuffix;
 export f_locationid_iter := LocationID_Ingest.files_locationid.FILE_LOCATION_ID_IN  + '_' + LocationID_Build.KeySuffix + '_it';
 export f_locationid_out	 := LocationID_Ingest.files_locationid.FILE_OUT             + '_' + LocationID_Build.KeySuffix;

	export runPreprocess() := function
		
		eclsample	 := '#workunit(\'name\',\'LocationID @version@\');\n'
								      + '#OPTION(\'multiplePersistInstances\',FALSE);\n' 
								      + 'evaluate(LocationID_iLink.proc_locationid.fn_preProcess())';
												 
		kickBuild	  := wk_ut.mac_ChainWuids(
			 eclsample,1,1,LocationID_Build.KeySuffix,
			,LocationID_Build.Constants.BuildServer
			,pOutputEcl        := false
			,pUniqueOutput     := 'LocationID_RunPreprocess'
			,pNotifyEmails     := LocationID_Build.email_list
			,pOutputFilename   := LocationID_Build.Constants.HistoryFileNamePrefix + 'LocationID_RunPreprocess'
			,pOutputSuperfile  := LocationID_Build.Constants.HistoryFileNameSFName
		);
		

		return kickBuild;
	end;
	
	export fn_preProcess() := function
		 InputBase            := LocationID_Ingest.files_ingest.DS_Base;
																	   
		 go := sequential(
				 output(InputBase,,f_locationid_in,overwrite,compressed)
				,LocationID_Ingest.files_locationid.updateLocationid(f_locationid_in)
		 );
		
		return go;
	end;

	export runLocationId(startiter) := functionmacro
	 import wk_ut, LocationID_Build;
		eclsample	 := '#workunit(\'name\',\'LocationID @version@\');\n'
								      + '#OPTION(\'multiplePersistInstances\',FALSE);\n' 
								      + 'iteration := \'@iteration@\';\n'
								      + 'evaluate(LocationID_iLink.proc_locationid.fn_runLocationId(iteration))';
								

					 
		kickBuild	  := wk_ut.mac_ChainWuids(
			 eclsample,startiter,LocationID_Build.Constants.NumOfIterations,LocationID_Build.KeySuffix,
			,LocationID_Build.Constants.BuildServer
			,pOutputEcl        := false
			,pUniqueOutput     := 'LocationID_RunLocationID'
			,pNotifyEmails     := LocationID_Build.email_list
			,pOutputFilename   := LocationID_Build.Constants.HistoryFileNamePrefix + 'LocationID_RunLocationID'
			,pOutputSuperfile  := LocationID_Build.Constants.HistoryFileNameSFName
		);
		

		return kickBuild;
	endmacro;
	
	export fn_runLocationId(string iter) := function
		
		SetLocID := project(In_LocationID,
		                    transform(Layout_LocationId, 
												                    self.LocId := left.aid,
																						          self       := left));
												
		go := sequential(
		  output(SetLocID,,f_locationid_iter + iter,overwrite,compressed)
			,LocationID_Ingest.files_locationid.updateLocationid(f_locationid_iter + iter)
		);
		
		return go;
	end;

	export runPostProcess() := function
		
		eclsample	 := '#workunit(\'name\',\'LocationID @version@\');\n'
								      + '#OPTION(\'multiplePersistInstances\',FALSE);\n' 
								      + 'evaluate(LocationID_iLink.proc_locationid.fn_postProcess())';
								

					 
		kickBuild	  := wk_ut.mac_ChainWuids(
			 eclsample,1,1,LocationID_Build.KeySuffix,
			,LocationID_Build.Constants.BuildServer
			,pOutputEcl        := false
			,pUniqueOutput     := 'LocationID_PostProcess'
			,pNotifyEmails     := LocationID_Build.email_list
			,pOutputFilename   := LocationID_Build.Constants.HistoryFileNamePrefix + 'LocationID_PostProcess'
			,pOutputSuperfile  := LocationID_Build.Constants.HistoryFileNameSFName
		);
		

		return kickBuild;
	end;
	
	export fn_postProcess() := function                 
  	
		go := sequential(
			 output(In_LocationID,, f_locationid_out, compressed, overwrite)
		 ,LocationID_Ingest.files_locationid.updateSuperFiles(f_locationid_out)
		);
		
		return go;
	end;	
end;
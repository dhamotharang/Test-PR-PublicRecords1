import wk_ut;
import LocationID_Build;

export proc_xlink := module

	export buildKeys() := function
		
		eclsample	 := '#workunit(\'name\',\'LocationID @version@\');\n'
								      + '#OPTION(\'multiplePersistInstances\',FALSE);\n' 
								      + 'evaluate(LocationID_xLink.proc_xlink.fn_buildKeys())';
												 
		kickBuild	  := wk_ut.mac_ChainWuids(
			 eclsample,1,1,LocationID_Build.KeySuffix,
			,LocationID_Build.Constants.BuildServer
			,pOutputEcl        := false
			,pUniqueOutput     := 'LocationID_xLink'
			,pNotifyEmails     := LocationID_Build.email_list
			,pOutputFilename   := LocationID_Build.Constants.HistoryFileNamePrefix + 'LocationID_xLink'
			,pOutputSuperfile  := LocationID_Build.Constants.HistoryFileNameSFName
		);
		

		return kickBuild;
	end;
	
	export fn_buildKeys() := function																	   
		 go := sequential(
				  evaluate(Proc_GoExternal)
				 ,evaluate(Proc_ClearSuperKeys)
				 ,evaluate(Proc_CurrentToSuperKeys)
		 );
		 
		 //Add QA Step
		
		return go;
	end;
	
end;
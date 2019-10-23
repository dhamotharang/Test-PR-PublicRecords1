EXPORT Proc_FullbuildDelta_Keys(STRING versionIn) := FUNCTION;

  notifyDone	 := NOTIFY(Constants.FullBuildDeltaEventName, '*');
	
  sequentialSteps := SEQUENTIAL(Proc_XlinkKeyBuild(versionIn),
	                              //commeting out so we can review sample before promotion to QA
																//Proc_PromoteToQA(versionIn), 
																notifyDone
																); 
RETURN IF(IncBuildRunningCheck, 
          WAIT(Constants.XlinkIncBuildEventName) , sequentialSteps)  ; 
END; 

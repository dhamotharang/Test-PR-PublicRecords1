IMPORT InsuranceHeader_xLink, STD;
BOOLEAN incrementalkeyBuild := TRUE;
#STORED('IsIncrementalBuild', incrementalkeyBuild);

EXPORT Proc_XlinkKeyBuild(STRING versionUse) := FUNCTION

	#STORED('fileVersion', versionUse); 
	createSF     := InsuranceHeader_xLink.CreateUpdateSuperFile(InsuranceHeader_xLink.Constants.INCREMENTAL_BUILD).createSuperFiles();
	
	// Move Inc logical to IncMaster SuperKeys save atleast 3 months logical keys 
	buildKeys 	 := InsuranceHeader_xLink.Proc_Build_All(incrementalkeyBuild);

	// Pass BuildDate.AlphaDops  or  BuildDate.BocaDops as min_date using IncrementalismTutorial_Xlink.BWR_MergeIncFiles and merge the keys 
	
	// move merged logical to Alpha / Boca Inc Super	
	String AlphaBuildVersion := versionUse + 'i'; 
	unsigned4 AlphaMergeDate := (unsigned4)Build_Date.AlphaDops;
	mergeAlphakeys := InsuranceHeader_xLink.mergeIncKeys(AlphaBuildVersion, AlphaMergeDate);
	
	String BocaBuildVersion := versionUse + 'ib'; 
	unsigned4 BocaMergeDate := (unsigned4)Build_Date.BocaDops ;
	mergeBocaKeys := InsuranceHeader_xLink.mergeIncKeys(BocaBuildVersion, BocaMergeDate);
 recycleIncSuperFiles := InsuranceHeader_xLink.recycleIncKeys();
// wait if xlink specificities key build is in progress (should notify upon completion)
	RETURN SEQUENTIAL(createSF,
	                  IF(XlinkSpecRunningCheck, WAIT(Constants.XlinkSpecEventName)),
	                  buildKeys, mergeAlphakeys,
										mergeBocaKeys, recycleIncSuperFiles
										);
	
END;
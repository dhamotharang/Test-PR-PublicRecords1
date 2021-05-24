IMPORT BancorpRCDList, VersionControl, STD, Orbit3, RoxieKeyBuild, dops, ut;

EXPORT procBuildAll(
	STRING  pVersion   = (STRING)STD.Date.Today(), boolean isDelta=true, string pServer=Constants().serverIP, string pDirectory=Constants().Directory.Main) := MODULE
    //isDelta = true for delta build and false for refresh
    shared updateType := if( isDelta=false, 'F', 'D');
	// Spray Files.
	Export SprayFiles := BancorpRCDList.sprayfile(pversion,pServer,pDirectory);
			
	shared dops_update := dops.updateversion('BancorpRCDListKeys', pVersion, 'david.dittman@lexisnexisrisk.com',,'N',,,,,, updateType);
	
	// All filenames associated with this Dataset
	SHARED dAll_filenames := BancorpRCDList.Filenames().dAll_filenames;
	// Full Build
	EXPORT full_build := SEQUENTIAL(
		versioncontrol.mUtilities.createsupers(dAll_filenames),
		SprayFiles,
		BancorpRCDList.procBuildBase(pVersion, isDelta),
		BancorpRCDList.procBuildKeys(pVersion, isDelta),
		dops_update,
		);
	EXPORT All :=
	IF(VersionControl.IsValidVersion(pVersion)
		,full_build
		,OUTPUT('No Valid version parameter passed, skipping FirstData.Proc_FirstData_Buildall().All')
	);
END;

EXPORT Files := MODULE
	EXPORT PostProc_Prefix					:= '~thor::wk_ut::InsuranceHeader::PostProcess::';
	EXPORT Build_Prefix					:= '~thor::wk_ut::InsuranceHeader::HeaderBuild::';
	
	EXPORT PostProc_OutFile_Logical_Prefix := PostProc_Prefix + 'it_';
	EXPORT PostProc_Changes_Logical_Prefix := PostProc_Prefix + 'changes_';
	EXPORT Build_OutFile_Logical_Prefix := Build_Prefix + 'it_';
	EXPORT Build_Changes_Logical_Prefix := Build_Prefix + 'changes_';
	
	EXPORT PostProc_KeyPrefix := '~key::wk_ut::InsuranceHeader::PostProcess::';
	EXPORT Build_KeyPrefix := '~key::wk_ut::InsuranceHeader::HeaderBuild::';
	
	EXPORT MasterWUOutputSF := PostProc_Prefix + 'WUInfo';
	EXPORT MasterWUSummarySF := PostProc_Prefix + 'WUSummaryIters';
	EXPORT BuildWUOutputSF := Build_Prefix + 'WUInfo';
	EXPORT BuildWUSummarySF := Build_Prefix + 'WUSummaryIters';
	
	EXPORT CreateMasterSuperFiles() := FUNCTION
		superFiles := SEQUENTIAL(
												IF( NOT fileservices.superfileexists(MasterWUOutputSF),
													fileservices.createsuperfile(MasterWUOutputSF)),
												IF( NOT fileservices.superfileexists(MasterWUSummarySF),
													fileservices.createsuperfile(MasterWUSummarySF)));
		RETURN superFiles;
	END;
	
	EXPORT CreateBuildSuperFiles() := FUNCTION
		superFiles := SEQUENTIAL(
												IF( NOT fileservices.superfileexists(BuildWUOutputSF),
													fileservices.createsuperfile(BuildWUOutputSF)),
												IF( NOT fileservices.superfileexists(BuildWUSummarySF),
													fileservices.createsuperfile(BuildWUSummarySF)));
		RETURN superFiles;
	END;
	
	
END;
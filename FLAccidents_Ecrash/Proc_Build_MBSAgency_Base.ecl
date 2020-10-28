IMPORT RoxieKeyBuild;
#OPTION('multiplePersistInstances',FALSE);

EXPORT Proc_Build_MBSAgency_Base(STRING Build_DateTime = mod_Utilities.strCurrentDateTimeStamp,
																 BOOLEAN isSprayAndBaseBuild = TRUE) := FUNCTION
   
// ###########################################################################
//                    Email Notifications
// ###########################################################################
  modSendEmail := Mod_SendEmail(Constants_MBSAgency.AgencyBuildName, Build_DateTime);
	
  NoInputFileEmail := modSendEmail.NoInputFileEmail;
  EmptyInputFileEmail := modSendEmail.EmptyInputFileEmail;
  BuildFailureEmail := modSendEmail.BuildFailureEmail;
  BuildSuccessEmail := modSendEmail.BuildSuccessEmail;

// ###########################################################################
//                        PreBuild 
// ###########################################################################
  CreateSF := fn_CreateSuperFiles_MBSAgency();
	ClearPreSpray := mod_Utilities.fn_ClearSuperFile(Files_MBSAgency.FILE_SPRAY_AGENCY_SF);
															
  PreBuild := SEQUENTIAL(CreateSF, ClearPreSpray);		 
	 
// ###########################################################################
//                         Spray
// ###########################################################################
	modCheckAgencyInputFile := mod_CheckMBSAgencyInputFile(Build_DateTime);
	isSprayFileExists := modCheckAgencyInputFile.isAgencyFileExists;
	isSprayFileNotEmpty := modCheckAgencyInputFile.isAgencyFileRecordCountsNotZero;	
		
	SprayAgency := Spray_MBSAgency(Build_DateTime);
	
// ###########################################################################
//                        Orbit
// ###########################################################################	
	PID := ProductName.MBS_AgencyBuild;
  
	OrbitReceiveLoad := fn_Orbit_ReceiveInstance(PID, Build_DateTime);										 	
  OrbitCreateBuild := fn_Orbit_CreateOrUpdateBuildInstance(Build_DateTime, PID, Orbit3IConstants(PID).buildstatus_B, TRUE, TRUE, TRIM(Orbit3IConstants(PID).componentfilename(Build_DateTime), LEFT, RIGHT));		
  OrbitUpdateBuild := fn_Orbit_CreateOrUpdateBuildInstance(Build_DateTime, PID, Orbit3IConstants(PID).buildstatus, FALSE, FALSE);		
	
// ###########################################################################
//                        BuildBase
// ###########################################################################
	AgencyBase := mod_BuildMBSAgency.BaseAgency;																						
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(AgencyBase, Files_MBSAgency.BASE_PREFIX, Files_MBSAgency.SUFFIX, Build_DateTime, NewBase, 3, TRUE, TRUE); 																							
	BuildBase := SEQUENTIAL(NewBase);																					

// ###########################################################################
//                        PostBuild 
// ###########################################################################	
	PostBuild := SEQUENTIAL(ClearPreSpray, OrbitUpdateBuild, BuildSuccessEmail);
	
// ###########################################################################
//                        OrbitProfiling 
// ###########################################################################
  // ProfileDistribution := fn_Distribute_DLCorrectionsBase(PID, Files_DLC.DS_BASE_DLC);
	// ProfileSuffixName   := OrbitConstants(PID).ProfileSuffixName;
  
  // RunOrbitProfiles := mac_fn_OrbitProfiling(Build_DateTime, PID, ProfileSuffixName, PID, ProfileDistribution);
  // GetOrbitStatus := SEQUENTIAL(Orbit3SOA.GetBuildStatusPostProfileSeverity(Build_DateTime,
                                                                           // Files_DLC.DS_FCRA_DL_CORRECTIONS_BASE_PROFILE,
                                                                           // OrbitConstants(PRODUCT_NAME.DLC_BUILD_ID).masterbuildname,
                                                                           // OrbitConstants(PRODUCT_NAME.DLC_BUILD_ID).FileType,
                                                                           // FALSE,
                                                                           // OrbitConstants().platformKey_Done),
                               // OUTPUT(DATASET([{'Notification : ORBIT UPDATE COMPLETE; ALL PROFILE STATUSES VERIFIED'}], {STRING message}), 
                                      // NAMED('build_dl_corrections_notes'), EXTEND)
                               // );

  // OrbitProfiling := ORDERED(RunOrbitProfiles, GetOrbitStatus);

// ###########################################################################
//                         RunBaseBuild 
// ###########################################################################	
	RunBaseBuild := SEQUENTIAL(PreBuild, SprayAgency, OrbitReceiveLoad, BuildBase, OrbitCreateBuild);																							
																							 
	BuildAgencyBase := IF(isSprayAndBaseBuild, 
												IF(isSprayFileExists,
													 IF(isSprayFileNotEmpty, SEQUENTIAL(RunBaseBuild, /*OrbitProfiling,*/ PostBuild), EmptyInputFileEmail),
													 NoInputFileEmail),
												SEQUENTIAL(CreateSF, BuildBase, /*OrbitProfiling,*/ PostBuild) 
											):FAILURE(BuildFailureEmail);

	RETURN BuildAgencyBase;
	 
END;
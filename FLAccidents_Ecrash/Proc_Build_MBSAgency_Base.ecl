IMPORT RoxieKeyBuild, Scrubs_eCrash_MBSAgency, Orbit3;
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
  OrbitCreateBuild := fn_Orbit_CreateOrUpdateBuildInstance(Build_DateTime, PID, Orbit3.Constants().bstatus_B, TRUE, TRUE, OrbitConstants(PID).PlatformKey);		
  OrbitUpdateBuild := fn_Orbit_CreateOrUpdateBuildInstance(Build_DateTime, PID, Orbit3.Constants().bstatus_A, FALSE, FALSE, OrbitConstants(PID).PlatformKeyDone);		

// ###########################################################################
//                        Scrubs
// ###########################################################################	
	RunSaltScrubs := Scrubs_eCrash_MBSAgency.PostBuildScrubs_eCrash_MBSAgency(Build_DateTime, Constants_MBSAgency.BuildEmailTarget);
	
// ###########################################################################
//                        BuildBase
// ###########################################################################
	AgencyBase := mod_BuildMBSAgency.BaseAgency;																						
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(AgencyBase, Files_MBSAgency.BASE_PREFIX, Files_MBSAgency.SUFFIX, Build_DateTime, NewBase, 3, FALSE, TRUE); 																							
	BuildBase := SEQUENTIAL(NewBase);																					

// ###########################################################################
//                        PostBuild 
// ###########################################################################	
	PostBuild := SEQUENTIAL(ClearPreSpray, OrbitUpdateBuild, BuildSuccessEmail);
	//PostBuild := SEQUENTIAL(ClearPreSpray, BuildSuccessEmail);
	
// ###########################################################################
//                        OrbitProfiling 
// ###########################################################################
  ProfileDistribution := fn_Distribute_MBSAgencyBase(PID, Files_MBSAgency.DS_BASE_AGENCY);
  
  RunOrbitProfiles := mac_fn_Orbit_Profile_MBSAgencyBase(Build_DateTime, PID, ProfileDistribution);
  // GetOrbitStatus := SEQUENTIAL(Orbit3SOA.GetBuildStatusPostProfileSeverity(Build_DateTime,
                                                                           // Files_MBSAgency.DS_AGENCY_BASE_PROFILE,
                                                                           // OrbitConstants(PID).MasterBuildname,
                                                                           // OrbitConstants(PID).FileType,
                                                                           // FALSE,
                                                                           // OrbitConstants(PID).PlatformKeyDone),
                               // OUTPUT(DATASET([{'Notification : ORBIT UPDATE COMPLETE; ALL PROFILE STATUSES VERIFIED'}], {STRING message}), 
                                      // NAMED('build_ecrash_mbs_agency_orbit_notes'), EXTEND));

  // OrbitProfiling := ORDERED(RunOrbitProfiles, GetOrbitStatus);
  OrbitProfiling := RunOrbitProfiles;

// ###########################################################################
//                         RunBaseBuild 
// ###########################################################################	
	RunBaseBuild := SEQUENTIAL(PreBuild, SprayAgency, RunSaltScrubs, OrbitReceiveLoad, BuildBase, OrbitCreateBuild);																							
																							 
	BuildAgencyBase := IF(isSprayAndBaseBuild, 
												IF(isSprayFileExists,
													 IF(isSprayFileNotEmpty, SEQUENTIAL(RunBaseBuild, OrbitProfiling, PostBuild), EmptyInputFileEmail),
													 NoInputFileEmail),
												SEQUENTIAL(CreateSF, BuildBase, OrbitProfiling, PostBuild) 
											):FAILURE(BuildFailureEmail);											

	RETURN BuildAgencyBase;
	 
END;
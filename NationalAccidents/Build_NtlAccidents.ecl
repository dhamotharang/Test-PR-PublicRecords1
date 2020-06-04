IMPORT _Control, STD, RoxieKeyBuild, Ecrash_Common;
#OPTION('multiplePersistInstances',FALSE);

EXPORT Build_NtlAccidents(STRING Build_Date = (STRING) mod_Utilities.SysDate, UNSIGNED Build_Seq = 1, 																		
                              BOOLEAN isSprayAndBaseBuild = TRUE) := FUNCTION

 STRING14 pBuild_Date := Build_Date[1..14];
 pBuildSeq := pBuild_Date + IF(Build_Seq = 1, '', Constants.LowerCaseAlphabet[Build_Seq]);
	
 buildMacrosFailureEmail := Ecrash_Common.Send_Email(pBuild_Date,Constants.Email_Msg).BuildBaseMacrosFailed;
 buildDBCountsFailureEmail := Ecrash_Common.Send_Email(pBuild_Date,Constants.Email_Msg).BuildDBCountsFailed;
 buildFailureEmail := Ecrash_Common.Send_Email(pBuild_Date,Constants.Email_Msg).BuildFailed;

 SprayMissingRequiredFilesEmail := mod_NtlAccInqCheckInputFiles(pBuild_Date).NtlAccidentsInquiryFileEmail;

 sfCreation := fn_CreateSuperFiles();		
	
 isSprayReady := mod_NtlAccInqCheckInputFiles(pBuild_Date).isNtlAccidentsInquiryFilesReadyToSpray;
	
 SprayNtlAccInq := build_spray_NAccidentsInquiry(pBuild_Date);

 Result             := mod_BuildNtlAccidentsConsolidated.AllResult;
 Vehicle            := mod_BuildNtlAccidentsConsolidated.AllVehicle;
 Vehicle_Incident   := mod_BuildNtlAccidentsConsolidated.AllVehicleIncident;
 Vehicle_Insurance  := mod_BuildNtlAccidentsConsolidated.AllVehicleInscr;
 Vehicle_Party      := mod_BuildNtlAccidentsConsolidated.AllVehicleParty;
 Client             := mod_BuildNtlAccidentsConsolidated.AllClient;
	
 AllCruOrdersBase   := mod_BuildNtlAccidentsConsolidated.AllCruOrders;	
 eNtlAccidentsBase  := mod_BuildNtlAccidentsConsolidated.NtlAccidentsBase;
 eNtlCruInquiryBase := mod_BuildNtlAccidentsConsolidated.NtlCruInquiryBase;
 
 RoxieKeyBuild.Mac_SF_BuildProcess_V2(Result, Files_NAccidentsInquiry.BASE_PREFIX, Files_NAccidentsInquiry.SUFFIX_NAME_RESULT, pBuildSeq, newResult, 3, FALSE, TRUE);
 RoxieKeyBuild.Mac_SF_BuildProcess_V2(Vehicle, Files_NAccidentsInquiry.BASE_PREFIX, Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE, pBuildSeq, newVehicles, 3, FALSE, TRUE);
 RoxieKeyBuild.Mac_SF_BuildProcess_V2(Vehicle_Incident, Files_NAccidentsInquiry.BASE_PREFIX, Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_INCIDENT, pBuildSeq, newVehicleIncident, 3, FALSE, TRUE);
 RoxieKeyBuild.Mac_SF_BuildProcess_V2(Vehicle_Insurance, Files_NAccidentsInquiry.BASE_PREFIX, Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_INSCR, pBuildSeq, newVehicleInsurance, 3, FALSE, TRUE);
 RoxieKeyBuild.Mac_SF_BuildProcess_V2(Vehicle_Party, Files_NAccidentsInquiry.BASE_PREFIX, Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_PARTY, pBuildSeq, newVehicleParty, 3, FALSE, TRUE);
 RoxieKeyBuild.Mac_SF_BuildProcess_V2(Client, Files_NAccidentsInquiry.BASE_PREFIX, Files_NAccidentsInquiry.SUFFIX_NAME_CLIENT, pBuildSeq, newClient, 3, FALSE, TRUE);
 
 RoxieKeyBuild.Mac_SF_BuildProcess_V2(AllCruOrdersBase, Files_NAccidentsInquiry.BASE_PREFIX, Files_NAccidentsInquiry.SUFFIX_NAME_ALL_CRU_ORDERS, pBuildSeq, newAllCruOrders, 3, FALSE, TRUE);  
 RoxieKeyBuild.Mac_SF_BuildProcess_V2(eNtlAccidentsBase, Files_NAccidentsInquiry.BASE_PREFIX, Files_NAccidentsInquiry.SUFFIX_NAME_ACCIDENTS_BASE, pBuildSeq, neweNtlAccidents, 3, FALSE, TRUE);
 RoxieKeyBuild.Mac_SF_BuildProcess_V2(eNtlCruInquiryBase, Files_NAccidentsInquiry.BASE_PREFIX, Files_NAccidentsInquiry.SUFFIX_NAME_INQUIRY_BASE, pBuildSeq, neweNtlCruInquiry, 3, FALSE, TRUE);
 
 BuildBase := SEQUENTIAL (neweNtlAccidents, neweNtlCruInquiry, newResult, newVehicles, newVehicleIncident, newVehicleInsurance, newVehicleParty, newClient, 
                          newAllCruOrders);
 
 clearDaily := SEQUENTIAL(FileServices.StartSuperFileTransaction(),
                          FileServices.ClearSuperFile(Files_NAccidentsInquiry.SPRAY_INT_ORDER_BASE_FILE, TRUE),
                          FileServices.ClearSuperFile(Files_NAccidentsInquiry.SPRAY_ORDER_VERSION_BASE_FILE, TRUE),
                          FileServices.ClearSuperFile(Files_NAccidentsInquiry.SPRAY_VEHICLE_PARTY_BASE_FILE, TRUE),
                          FileServices.ClearSuperFile(Files_NAccidentsInquiry.SPRAY_VEHICLE_INCIDENT_BASE_FILE, TRUE),
                          FileServices.ClearSuperFile(Files_NAccidentsInquiry.SPRAY_VEHICLE_BASE_FILE, TRUE),
                          FileServices.ClearSuperFile(Files_NAccidentsInquiry.SPRAY_RESULT_BASE_FILE, TRUE),
                          FileServices.ClearSuperFile(Files_NAccidentsInquiry.SPRAY_VEHICLE_INSCR_BASE_FILE, TRUE),
                          FileServices.ClearSuperFile(Files_NAccidentsInquiry.SPRAY_CLIENT_BASE_FILE, TRUE),
                          FileServices.FinishSuperFileTransaction());

 preBuild := IF(isSprayReady,SEQUENTIAL(sfCreation, clearDaily, SprayNtlAccInq), SprayMissingRequiredFilesEmail);
 
 postBuild := SEQUENTIAL(/* Add Orbit Build create instance*/ clearDaily); 
 
 // ClearDaily is used twice to add re-start capability
 RunNtlAccInqBuild := IF(isSprayAndBaseBuild, 
	                        SEQUENTIAL(preBuild, BuildBase, postBuild), 
	                        SEQUENTIAL(BuildBase, postBuild) 
	                        ):FAILURE(buildFailureEmail);

 RETURN RunNtlAccInqBuild;

END;
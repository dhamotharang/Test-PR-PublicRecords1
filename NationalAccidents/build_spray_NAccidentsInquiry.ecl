IMPORT Ecrash_Common;

EXPORT build_spray_NAccidentsInquiry(STRING pDate = mod_Utilities.strSysDate) := FUNCTION   
	
	isClientReadyToSpray               := mod_NtlAccInqCheckInputFiles(pDate).isClientReadyToSpray;
	isVehicle_PartyReadyToSpray        := mod_NtlAccInqCheckInputFiles(pDate).isVehicle_PartyReadyToSpray;
  isVehicleReadyToSpray	             := mod_NtlAccInqCheckInputFiles(pDate).isVehicleReadyToSpray;
  isVehicle_InscrReadyToSpray	       := mod_NtlAccInqCheckInputFiles(pDate).isVehicle_InscrReadyToSpray;
  isInt_OrderReadyToSpray 		       := mod_NtlAccInqCheckInputFiles(pDate).isInt_OrderReadyToSpray;
	isOrder_VersionReadyToSpray        := mod_NtlAccInqCheckInputFiles(pDate).isOrder_VersionReadyToSpray;
	isResultReadyToSpray	             := mod_NtlAccInqCheckInputFiles(pDate).isResultReadyToSpray;
	isVehicle_IncidentReadyToSpray     := mod_NtlAccInqCheckInputFiles(pDate).isVehicle_IncidentReadyToSpray;
	
	sprayClientFailureEmail            := Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.Client_FILE_NAME).SprayFailed;
	sprayInt_OrderFailureEmail         := Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.Int_Order_FILE_NAME).SprayFailed;
	sprayOrder_VersionFailureEmail     := Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.Order_Version_FILE_NAME).SprayFailed;
	sprayVehicle_PartyFailureEmail     := Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.Vehicle_Party_FILE_NAME).SprayFailed;
	sprayVehicle_IncidentFailureEmail  := Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.Vehicle_Incident_FILE_NAME).SprayFailed;
	sprayVehicleFailureEmail           := Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.Vehicle_FILE_NAME).SprayFailed;
	sprayResultFailureEmail            := Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.Result_FILE_NAME).SprayFailed;
	sprayVehicle_InscrFailureEmail     := Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.Vehicle_Inscr_FILE_NAME).SprayFailed;
	
 sprayClient                         := IF(isClientReadyToSpray, Spray(FileNames.Client_FILE_NAME, pDate, PRODUCT_NAME.NAI_BUILD_ID)):FAILURE(sprayClientFailureEmail);	
 sprayInt_Order           					 := IF(isInt_OrderReadyToSpray, Spray(FileNames.Int_Order_FILE_NAME, pDate, PRODUCT_NAME.NAI_BUILD_ID)):FAILURE(sprayInt_OrderFailureEmail);
 sprayOrder_Version       					 := IF(isOrder_VersionReadyToSpray, Spray(FileNames.Order_Version_FILE_NAME, pDate, PRODUCT_NAME.NAI_BUILD_ID)):FAILURE(sprayOrder_VersionFailureEmail);
 sprayVehicle_Party       					 := IF(isVehicle_PartyReadyToSpray, Spray(FileNames.Vehicle_Party_FILE_NAME, pDate, PRODUCT_NAME.NAI_BUILD_ID)):FAILURE(sprayVehicle_PartyFailureEmail);
 sprayVehicle_Incident    					 := IF(isVehicle_IncidentReadyToSpray, Spray(FileNames.Vehicle_Incident_FILE_NAME, pDate, PRODUCT_NAME.NAI_BUILD_ID)):FAILURE(sprayVehicle_IncidentFailureEmail);
 sprayVehicle             					 := IF(isVehicleReadyToSpray, Spray(FileNames.Vehicle_FILE_NAME, pDate, PRODUCT_NAME.NAI_BUILD_ID)):FAILURE(sprayVehicleFailureEmail);
 sprayResult              					 := Spray(FileNames.Result_FILE_NAME, pDate, PRODUCT_NAME.NAI_BUILD_ID):FAILURE(sprayResultFailureEmail);
 sprayVehicle_Inscr       					 := Spray(FileNames.Vehicle_Inscr_FILE_NAME, pDate, PRODUCT_NAME.NAI_BUILD_ID):FAILURE(sprayVehicle_InscrFailureEmail);
  
 sprayNAccidentsInquiry              := SEQUENTIAL(sprayClient, sprayInt_Order, sprayOrder_Version, sprayVehicle_Party,   
																					         sprayVehicle_Incident, sprayVehicle, sprayResult, sprayVehicle_Inscr);
								
 RETURN sprayNAccidentsInquiry;
	
END;
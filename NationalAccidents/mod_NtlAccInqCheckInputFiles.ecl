IMPORT Ecrash_Common;

EXPORT mod_NtlAccInqCheckInputFiles(STRING pDate = mod_Utilities.strSysDate) := MODULE

	SHARED isClientExists              := EXISTS(mod_NtlAccInqRemoteFileList(pDate).Client);	
	SHARED isInt_OrderExists           := EXISTS(mod_NtlAccInqRemoteFileList(pDate).Int_Order);
	SHARED isOrder_VersionExists       := EXISTS(mod_NtlAccInqRemoteFileList(pDate).Order_Version);
	SHARED isVehicle_PartyExists       := EXISTS(mod_NtlAccInqRemoteFileList(pDate).Vehicle_Party);
	SHARED isVehicle_IncidentExists    := EXISTS(mod_NtlAccInqRemoteFileList(pDate).Vehicle_Incident);
	SHARED isVehicleExists             := EXISTS(mod_NtlAccInqRemoteFileList(pDate).Vehicle);
	SHARED isResultExists              := EXISTS(mod_NtlAccInqRemoteFileList(pDate).Result);
	SHARED isVehicle_InscrExists       := EXISTS(mod_NtlAccInqRemoteFileList(pDate).Vehicle_Inscr);

	SHARED isClientFileRecordCountsNotZero              := mod_NtlAccInqRemoteFileList(pDate).Client[1].SIZE           <> 0;
	SHARED isInt_OrderFileRecordCountsNotZero           := mod_NtlAccInqRemoteFileList(pDate).Int_Order[1].SIZE        <> 0;
	SHARED isOrder_VersionFileRecordCountsNotZero       := mod_NtlAccInqRemoteFileList(pDate).Order_Version[1].SIZE    <> 0;
	SHARED isVehicle_PartyFileRecordCountsNotZero       := mod_NtlAccInqRemoteFileList(pDate).Vehicle_Party[1].SIZE    <> 0;
	SHARED isVehicle_IncidentFileRecordCountsNotZero    := mod_NtlAccInqRemoteFileList(pDate).Vehicle_Incident[1].SIZE <> 0;
	SHARED isVehicleFileRecordCountsNotZero             := mod_NtlAccInqRemoteFileList(pDate).Vehicle[1].SIZE          <> 0;
	SHARED isResultFileRecordCountsNotZero              := mod_NtlAccInqRemoteFileList(pDate).Result[1].SIZE           <> 0;
	SHARED isVehicle_InscrFileRecordCountsNotZero       := mod_NtlAccInqRemoteFileList(pDate).Vehicle_Inscr[1].SIZE    <> 0;


	SHARED isNtlAccidentsInquiryFilesExists := isInt_OrderExists     
																																								AND isOrder_VersionExists
																																								AND isVehicle_PartyExists
																																								AND isVehicle_IncidentExists
																																								AND isVehicleExists
																																								AND isResultExists;


	SHARED isNtlAccidentsInquiryFileRecordCountsNotZero := isInt_OrderFileRecordCountsNotZero 
																																																	 AND isOrder_VersionFileRecordCountsNotZero
																																																	 AND isVehicle_PartyFileRecordCountsNotZero
																																																	 AND isVehicle_IncidentFileRecordCountsNotZero
																																																	 AND isVehicleFileRecordCountsNotZero
																																																	 AND isResultFileRecordCountsNotZero;
																						 

	SHARED NtlAccidentsInquiryFileMissingEmail := SEQUENTIAL( IF( ~isInt_OrderExists, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.INT_ORDER_FILE_NAME).FileMissing),
																																																											IF( ~isOrder_VersionExists, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.ORDER_VERSION_FILE_NAME).FileMissing),
																																																											IF( ~isVehicle_PartyExists, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.VEHICLE_PARTY_FILE_NAME).FileMissing),
																																																											IF( ~isVehicle_IncidentExists, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.VEHICLE_INCIDENT_FILE_NAME).FileMissing),
																																																											IF( ~isVehicleExists, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.VEHICLE_FILE_NAME).FileMissing),
																																																											IF( ~isResultExists, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.RESULT_FILE_NAME).FileMissing)
																																																										);
																				
	SHARED NtlAccidentsInquiryEmptyFileEmail := SEQUENTIAL( IF( ~isInt_OrderFileRecordCountsNotZero, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.INT_ORDER_FILE_NAME).EmptyFile),
																																																									IF( ~isOrder_VersionFileRecordCountsNotZero, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.ORDER_VERSION_FILE_NAME).EmptyFile),
																																																									IF( ~isVehicle_PartyFileRecordCountsNotZero, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.VEHICLE_PARTY_FILE_NAME).EmptyFile),
																																																									IF( ~isVehicle_IncidentFileRecordCountsNotZero, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.VEHICLE_INCIDENT_FILE_NAME).EmptyFile),
																																																									IF( ~isVehicleFileRecordCountsNotZero, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.VEHICLE_FILE_NAME).EmptyFile),
																																																									IF( ~isResultFileRecordCountsNotZero, Ecrash_Common.Send_Email(pDate,Constants.Email_Msg,FileNames.RESULT_FILE_NAME).EmptyFile)
																																																								);

	EXPORT BOOLEAN isNtlAccidentsInquiryFilesReadyToSpray  := isNtlAccidentsInquiryFilesExists AND isNtlAccidentsInquiryFileRecordCountsNotZero;
	EXPORT NtlAccidentsInquiryFileEmail := SEQUENTIAL( IF (~isNtlAccidentsInquiryFilesExists, NtlAccidentsInquiryFileMissingEmail),
																																																			 IF (~isNtlAccidentsInquiryFileRecordCountsNotZero AND isNtlAccidentsInquiryFilesExists, NtlAccidentsInquiryEmptyFileEmail)
																																																		 );

	EXPORT isClientReadyToSpray := isClientExists AND isClientFileRecordCountsNotZero;
	EXPORT isInt_OrderReadyToSpray := isInt_OrderExists AND isInt_OrderFileRecordCountsNotZero;
	EXPORT isOrder_VersionReadyToSpray := isOrder_VersionExists AND isOrder_VersionFileRecordCountsNotZero;
	EXPORT isVehicle_PartyReadyToSpray := isVehicle_PartyExists AND isVehicle_PartyFileRecordCountsNotZero;
	EXPORT isVehicle_IncidentReadyToSpray := isVehicle_IncidentExists AND isVehicle_IncidentFileRecordCountsNotZero;
	EXPORT isVehicleReadyToSpray := isVehicleExists AND isVehicleFileRecordCountsNotZero;
	EXPORT isResultReadyToSpray := isResultExists AND isResultFileRecordCountsNotZero;
	EXPORT isVehicle_InscrReadyToSpray := isVehicle_InscrExists AND isVehicle_InscrFileRecordCountsNotZero;

END;
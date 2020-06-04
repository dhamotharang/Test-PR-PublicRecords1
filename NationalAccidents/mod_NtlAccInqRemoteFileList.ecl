IMPORT STD;

EXPORT mod_NtlAccInqRemoteFileList(STRING pDate = mod_Utilities.strSysDate) := MODULE
	SHARED LandingZone := Constants.LandingZone;	
	SHARED NAccidentsInquirySourcePath := SprayProcess_FileNames('INSURANCE_NtlAccidentsInquiry',pDate).NAccidentsInquirySprayDirPath;

	EXPORT Client              := FileServices.RemoteDirectory(LandingZone, NAccidentsInquirySourcePath, FileNames.Client_FILE_NAME           + Constants.NAccidentsInquiryFileType);
	EXPORT Int_Order           := FileServices.RemoteDirectory(LandingZone, NAccidentsInquirySourcePath, FileNames.Int_Order_FILE_NAME        + Constants.NAccidentsInquiryFileType);
	EXPORT Order_Version       := FileServices.RemoteDirectory(LandingZone, NAccidentsInquirySourcePath, FileNames.Order_Version_FILE_NAME    + Constants.NAccidentsInquiryFileType);
	EXPORT Vehicle_Party       := FileServices.RemoteDirectory(LandingZone, NAccidentsInquirySourcePath, FileNames.Vehicle_Party_FILE_NAME    + Constants.NAccidentsInquiryFileType);
	EXPORT Vehicle_Incident    := FileServices.RemoteDirectory(LandingZone, NAccidentsInquirySourcePath, FileNames.Vehicle_Incident_FILE_NAME + Constants.NAccidentsInquiryFileType);
	EXPORT Vehicle             := FileServices.RemoteDirectory(LandingZone, NAccidentsInquirySourcePath, FileNames.Vehicle_FILE_NAME          + Constants.NAccidentsInquiryFileType);
	EXPORT Result              := FileServices.RemoteDirectory(LandingZone, NAccidentsInquirySourcePath, FileNames.Result_FILE_NAME           + Constants.NAccidentsInquiryFileType);
	EXPORT Vehicle_Inscr       := FileServices.RemoteDirectory(LandingZone, NAccidentsInquirySourcePath, FileNames.Vehicle_Inscr_FILE_NAME    + Constants.NAccidentsInquiryFileType);
END;
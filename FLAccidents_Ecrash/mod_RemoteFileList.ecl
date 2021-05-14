EXPORT mod_RemoteFileList(STRING pDate = mod_Utilities.strCurrentDateTimeStamp) := MODULE

  SHARED LandingZone := Constants.LandingZone;	
  SHARED AgencySourcePath := SprayProcess_MBSAgencyFileNames(pDate).AgencySprayProcessDirPath;

  EXPORT Agency_InFile := FileServices.RemoteDirectory(LandingZone, AgencySourcePath, Constants_MBSAgency.AgencyLZFilename);

END;
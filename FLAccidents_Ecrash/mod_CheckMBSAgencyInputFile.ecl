EXPORT mod_CheckMBSAgencyInputFile (STRING pDate = mod_Utilities.strCurrentDateTimeStamp) := MODULE

  EXPORT isAgencyFileExists := EXISTS(mod_RemoteFileList(pDate).Agency_InFile):INDEPENDENT;	

  EXPORT isAgencyFileRecordCountsNotZero := mod_RemoteFileList(pDate).Agency_InFile[1].SIZE <> 0:INDEPENDENT;

END;
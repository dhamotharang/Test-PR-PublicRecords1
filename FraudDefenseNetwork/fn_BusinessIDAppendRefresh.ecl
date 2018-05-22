IMPORT std, _control, tools, roxiekeybuild, did_add, Business_Header_SS, Business_HeaderV2;

EXPORT fn_BusinessIDAppendRefresh(STRING pversion = (STRING8)Std.Date.Today() + 'a') := FUNCTION
  dsFDNHeaderVersion                          := files().fdn_BIP_header_build_version;
  HdrFileVersion                              := did_add.get_EnvVariable(Constants().BIP_Header_Package_Env_Var)[1..8]: INDEPENDENT;
																											 
  FDNBusinessIDAppendBuildFailureEmail        := fileservices.sendemail(Constants().Email_List,
								                                                         'FDN BusinessID Append Build Failure on ' + pversion,
                                                                         WORKUNIT + '\n' + FAILMESSAGE);	

  FDNBusinessIDAppendVersion                  := IF(NOTHOR(fileservices.fileexists(FraudDefenseNetwork.FileNames().BIP_Header_Build_Version)), dsFDNHeaderVersion[1].build_version, 'NoVersion');


  isReadyForBusinessIDAppend                  := HdrFileVersion <>  FDNBusinessIDAppendVersion;
	
	BusinessIDAppend_FDN_BaseFiles              := fn_FDNBaseFiles_BusinessID(pversion);

	
  UpdDsFDNHeaderVersion                       := PROJECT(dsFDNHeaderVersion, TRANSFORM(RECORDOF(dsFDNHeaderVersion), 
                                                                                      SELF.build_version   := IF(isReadyForBusinessIDAppend, HdrFileVersion, LEFT.build_version)));
																																											 
	
  roxiekeybuild.Mac_SF_BuildProcess_V2(UpdDsFDNHeaderVersion, FileNames().Fdn_Prefix, FileNames().BIP_Header_Build_Suffix, pversion, NewFdnBaseHdrBuildVersion, 3, FALSE, TRUE);
  

  NewHdrFileVersionEmail                     := fileservices.sendemail(Constants().Email_List, 
	                                                                      'FDN BusinessID Append to a new Build Version: ' + 
									                                                        HdrFileVersion,
								                                                          WORKUNIT);

  runFDNBusinessIDAppend                     := IF(isReadyForBusinessIDAppend, 	   
	                                                 SEQUENTIAL(BusinessIDAppend_FDN_BaseFiles, NewFdnBaseHdrBuildVersion, NewHdrFileVersionEmail), 
	                                                 OUTPUT('NoNewBIPHeaderBuildVersionAvailable')):FAILURE(FDNBusinessIDAppendBuildFailureEmail); 
	
  RETURN runFDNBusinessIDAppend;
	
END;
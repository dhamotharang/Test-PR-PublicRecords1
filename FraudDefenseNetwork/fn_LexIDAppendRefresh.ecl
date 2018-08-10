IMPORT std, _control, tools, roxiekeybuild, DID_Add, FraudDefenseNetwork;

EXPORT fn_LexIDAppendRefresh(STRING pversion = (STRING8)Std.Date.Today() + 'a') := FUNCTION
  dsFDNHeaderVersion                          := files().fdn_Lexid_header_build_version; 
  HdrFileVersion                              := did_add.get_EnvVariable(Constants().Lexid_Header_Package_Env_Var)[1..8] : INDEPENDENT;
																											 
  FDNLexIDAppendBuildFailureEmail             := fileservices.sendemail(Constants().Email_list,
								                                                         'FDN LexID Append Build Failure on ' + pversion,
                                                                         WORKUNIT + '\n' + FAILMESSAGE);	

  FDNLexIDAppendVersion                      := IF(NOTHOR(fileservices.fileexists(FraudDefenseNetwork.FileNames().LexID_Header_Build_Version)), dsFDNHeaderVersion[1].build_version, 'NoVersion');


  isReadyForLexIDAppend                      := HdrFileVersion <>  FDNLexIDAppendVersion;
	
	LexIDAppend_FDN_BaseFiles                  := FraudDefenseNetwork.fn_FDNBaseFiles_LexID(pversion);

	
  UpdDsFDNHeaderVersion                      := PROJECT(dsFDNHeaderVersion, TRANSFORM(RECORDOF(dsFDNHeaderVersion), 
                                                                                      SELF.build_version   := IF(isReadyForLexIDAppend, HdrFileVersion, LEFT.build_version)));
																																											 
	
  roxiekeybuild.Mac_SF_BuildProcess_V2(UpdDsFDNHeaderVersion, FileNames().Fdn_Prefix, FileNames().LexID_Header_Build_Suffix, pversion, NewFdnBaseHdrBuildVersion, 3, FALSE, TRUE);
  

  NewHdrFileVersionEmail                     := fileservices.sendemail(Constants().Email_list, 
	                                                                      'FDN LexID Append to a new Build Version: ' + 
									                                                        HdrFileVersion,
								                                                          WORKUNIT);

  runFDNLexIDAppend                          := IF(isReadyForLexIDAppend, 	   
	                                                 SEQUENTIAL(LexIDAppend_FDN_BaseFiles, NewFdnBaseHdrBuildVersion, NewHdrFileVersionEmail), 
	                                                 OUTPUT('NoNewPersonHeaderBuildVersionAvailable')):FAILURE(FDNLexIDAppendBuildFailureEmail); 
	
  RETURN runFDNLexIDAppend;
	
END;
	
	// fn_LexIDAppend_FDN_BaseFiles();
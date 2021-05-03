IMPORT  _Control,Orbit3,Orbit3Insurance,STD;

EXPORT OrbitConstants(STRING product, STRING emailme = '') := MODULE
	
// ###########################################################################
//                    File Tracking & Receiving Instance
// ###########################################################################	
	EXPORT datasetname := CASE(product, 															
															'ecrashCRU_Delta'  =>'eCrashCRUAcidentsDelta',
															'eCrash_MBSAgency' => 'ecrash MBS',
															'NA');
														 
	EXPORT sourcename := CASE(product, 
															'ecrashCRU_Delta' => 'eCrashCRUAcidentsDelta',//CC Attributes Delta Log History																
															'eCrash_MBSAgency' => 'LexisNexis/Boca',
															'NA');

	EXPORT media 			:= CASE(product, 
															'ecrashCRU_Delta' => 'SFTP',
															'eCrash_MBSAgency' => 'SFTP',
															'NA');
														
	EXPORT updatetype := CASE(product,
															'ecrashCRU_Delta' => 'Update-Append',
															'eCrash_MBSAgency' => 'Update-Append',
															'NA');
														
	EXPORT orbitreceivedate(STRING pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8] + 'T00:00:00Z'; 
	EXPORT orbitreceivedatetime(STRING pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T' + pdate[9..10] + ':' + pdate[11..12] + ':' + pdate[13..14] + 'Z'; 

// ###########################################################################
//                        Create & Update Build
// ###########################################################################	
	EXPORT buildname := CASE(product, 
													 'ecrashCRU_Delta' => 'eCrashCRUAcidentsDelta', //FCRA CCAttrDeltaKeys
													 'eCrash_MBSAgency' => 'eCrash MBS Agency Build',
													 'NA');
														
	EXPORT masterbuildname := CASE(product, 
																 'ecrashCRU_Delta' => 'eCrashCRUAcidentsDelta', //FCRA CCAttrDeltaKeys
																 'eCrash_MBSAgency' => 'eCrash MBS Agency Build',
																 'NA');
														
	EXPORT orbitfilename := CASE(product, 
																'ecrashCRU_Delta' => 'delta_attribute_log.txt',
																'eCrash_MBSAgency' => 'mbs_ecrash_v_agency_hpcc_export.txt',
																'NA');
															
	EXPORT orbitpathname(STRING pdate) := CASE(product, 
																						 'ecrashCRU_Delta' => Orbit3Insurance.EnvironmentVariables.orbitpathprefix + 'delta_cc_attributes\\process\\' + pdate + '\\',
																						 'NA');
																												
	EXPORT componentfilename(STRING pdate) := CASE(product, 
																								 'ecrashCRU_Delta' => Orbit3Insurance.EnvironmentVariables.orbitcomponentpathprefix + 'delta_cc_attributes\\\\process\\\\' + pdate + '\\\\' + STD.Str.ToLowerCase(orbitfilename),
																								 'eCrash_MBSAgency' => '\\\\tapeload.risk.regn.net\\K\\accident_reports\\ecrash_(ei)\\mbs\\' + pDate + '\\' + STD.Str.ToLowerCase(orbitfilename),
																								 'NA');														
																
	EXPORT PlatformKey := DATASET([{Orbit3.Constants().platform_N, Orbit3.Constants().pstatus_B}], 
																Orbit3.Layouts.OrbitPlatformUpdateLayout);
																		 
  															
  EXPORT PlatformKeyDone := DATASET([{Orbit3.Constants().platform_N, Orbit3.Constants().pstatus_D}], 
	                                  Orbit3.Layouts.OrbitPlatformUpdateLayout);																

// ###########################################################################
//                        Orbit Profiling
// ###########################################################################																
  EXPORT ProfileWorkunitName := CASE(product,
																		'eCrash_MBSAgency' => 'DIST_ECRASH_MBS_AGENCY',
																		'NA');			

  EXPORT FileType :=  CASE(product,
													'eCrash_MBSAgency' => 'ECRASH MBS AGENCY BASE',
													'NA');																
																	
	EXPORT ProfilePrefix := 'DATABUILD';
  EXPORT ProfileType   := 'ProfilingDataBuilds';
	
	EXPORT SubsetName := CASE(product,
                            'eCrash_MBSAgency' => 'ECRASH',
                            'NA');
														
  EXPORT ProfileSuffixName := CASE(product,
																	'eCrash_MBSAgency' => 'MBS_AGENCY_DISTRIBUTION',
																	'NA');														
														
  EXPORT EcrashMBSAgencyProfileName := ProfilePrefix + '_' + SubsetName + '_' + ProfileSuffixName + '_' + 'VIEW';
	
  EXPORT ProfileName := CASE(product,
														'eCrash_MBSAgency' => EcrashMBSAgencyProfileName,
														'NA');																	
												
// ###########################################################################
//                           Orbit Email Targets
// ###########################################################################													
  EXPORT dev_email_target := 'DataDevelopment-InsRiskeCrash@lexisnexisrisk.com';
  EXPORT data_qa_email := 'alp-qadata.team@lexisnexis.com';
  EXPORT data_ops_email := 'Sudhir.Kasavajjala@lexisnexisrisk.com';
  EXPORT prod_email_target := 'DataDevelopment-InsRiskeCrash@lexisnexisrisk.com' + ', ' + data_ops_email;
												
  EXPORT orbit_createBuild_email := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', data_qa_email,
                                       dev_email_target);
																			 
  EXPORT orbit_creBuildErr_email := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', 
                                        data_qa_email + ', ' + prod_email_target,
                                       dev_email_target);
																			 
  EXPORT orbit_recload_err_email := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', 
                                       data_qa_email + ', ' + prod_email_target,
                                       dev_email_target);
																			 
  EXPORT orbit_receiveload_email := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', data_qa_email,
                                       dev_email_target);
																 
END;
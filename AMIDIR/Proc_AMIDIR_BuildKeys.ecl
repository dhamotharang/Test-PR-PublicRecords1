//Build key for AMIDIR, and move to qa.
import ut,RoxieKeyBuild;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(AMIDIR.Key_AMIDIR_DID,
																					 '~thor_data400::key::AMIDIR_did','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_did',
																				 	 AMIDIRDidKeyOut);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::AMIDIR_did','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_did', mv_did_key,2);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::AMIDIR_did', 'Q', mv_did_to_qa);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(AMIDIR.Key_AMIDIR_BDID,
																					 '~thor_data400::keyAMIDIR_bdid','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_bdid',
																					 AMIDIRBdidKeyOut);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::AMIDIR_bdid','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_bdid', mv_bdid_key,2);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::AMIDIR_bdid', 'Q', mv_bdid_to_qa);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(AMIDIR.Key_AMIDIR_LinkIDs.key,
																					 '~thor_data400::key::AMIDIR_LinkIDs','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_LinkIDs',
																					 AMIDIRLinkIDsKeyOut);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::AMIDIR_LinkIDs','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_LinkIDs', mv_LinkIDs_key,2);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::AMIDIR_LinkIDs', 'Q', mv_LinkIDs_to_qa);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(AMIDIR.Key_AMIDIR_BusName,
																					 '~thor_data400::key::AMIDIR_busname','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_busname',
																					 AMIDIRBusnameKeyOut);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::AMIDIR_busname', '~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_busname', mv_busname_key,2);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::AMIDIR_busname', 'Q', mv_busname_to_qa);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(AMIDIR.Key_AMIDIR_DEA,
																					 '~thor_data400::key::AMIDIR_dea','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_dea',
																					 AMIDIRDeaKeyOut);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::AMIDIR_dea','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_dea', mv_dea_key,2);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::AMIDIR_dea', 'Q', mv_dea_to_qa);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(AMIDIR.Key_AMIDIR_Licnumber,
																					 '~thor_data400::key::AMIDIR_licnumber','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_licnumber',
																					 AMIDIRLicnumberKeyOut);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::AMIDIR_licnumber','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_licnumber', mv_licnumber_key,2);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::AMIDIR_licnumber', 'Q', mv_licnumber_to_qa);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(AMIDIR.Key_AMIDIR_PHYName,
																					 '~thor_data400::key::AMIDIR_phyname','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_phyname',
																					 AMIDIRPhynameKeyOut);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::AMIDIR_phyname','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_phyname', mv_phyname_key,2);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::AMIDIR_phyname', 'Q', mv_phyname_to_qa);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(AMIDIR.Key_AMIDIR_SSN,
																					 '~thor_data400::key::AMIDIR_ssn','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_ssn',
																					 AMIDIRSsnKeyOut);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::AMIDIR_ssn','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_ssn', mv_ssn_key,2);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::AMIDIR_ssn', 'Q', mv_ssn_to_qa);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(AMIDIR.Key_AMIDIR_UPIN,
																					'~thor_data400::key::AMIDIR_upin','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_upin',
																					AMIDIRUpinKeyOut);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::AMIDIR_upin','~thor_data400::key::'+AMIDIR.version_update+'::AMIDIR_upin', mv_Upin_key,2);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::AMIDIR_upin', 'Q', mv_Upin_to_qa);


export Proc_AMIDIR_BuildKeys := sequential(parallel(AMIDIRDidKeyOut, AMIDIRBdidKeyOut, AMIDIRLinkIDsKeyOut, AMIDIRBusnameKeyOut,
																										AMIDIRDeaKeyOut, AMIDIRLicnumberKeyOut, AMIDIRPhynameKeyOut,
																										AMIDIRSsnKeyOut, AMIDIRUpinKeyOut), 
																				   parallel(mv_did_key, mv_bdid_key, mv_LinkIDs_key, mv_busname_key, mv_dea_key,
																									  mv_licnumber_key, mv_phyname_key, mv_ssn_key, mv_Upin_key),
																				   parallel(mv_did_to_qa, mv_bdid_to_qa, mv_LinkIDs_to_qa, mv_busname_to_qa, mv_dea_to_qa,
																									  mv_licnumber_to_qa, mv_phyname_to_qa, mv_ssn_to_qa, mv_Upin_to_qa)
																				  );	

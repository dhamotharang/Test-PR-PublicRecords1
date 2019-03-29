IMPORT _control, Dops, Doxie, dx_PhonesInfo, PromoteSupers, RoxieKeyBuild, std, ut, Orbit3, Scrubs_PhonesInfo,buildLogger;

EXPORT Proc_Build_Ported_Metadata_Key(string version):= function

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Create Ported Metadata Base File///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	buildComBase	:= output(PhonesInfo.Map_Ported_Metadata_Main,,'~thor_data400::base::phones::ported_metadata_main_'+version, overwrite, __compressed__);

	//Clear Ported Metadata Base Delete Superfile
	clearDelete 	:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::ported_metadata_main_delete', true));		

	//Move Ported Metadata Base Logical File to Appropriate Superfile
	moveComBase		:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::ported_metadata_main',
																									'~thor_data400::base::phones::ported_metadata_main_father',
																									'~thor_data400::base::phones::ported_metadata_main_grandfather',
																									'~thor_data400::base::phones::ported_metadata_main_great_grandfather',
																									'~thor_data400::base::phones::ported_metadata_main_delete'], '~thor_data400::base::phones::ported_metadata_main_'+version, true);																						

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Build Ported Metadata Key//////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PhonesInfo.Key_Phones.Ported_Metadata
																							,'~thor_data400::key::phones_ported_metadata'
																							,'~thor_data400::key::'+version+'::phones_ported_metadata'
																							,bkPhonesPortedmetadata
																							);	

	//Move Ported Metadata Key to Built Superfile	
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phones_ported_metadata'
																							,'~thor_data400::key::'+version+'::phones_ported_metadata'
																							,mvBltPhonesPortedmetadata
																							);
	
	//Move Ported Metadata Key to QA Superfile
	PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::phones_ported_metadata','Q',mvQAPhonesPortedmetadata,'4');

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Build Carrier Reference Key////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhonesInfo.Key_Source_Reference.ocn_name
																							,PhonesInfo.File_Source_Reference.Main
																							,'~thor_data400::key::phonesmetadata::carrier_reference'
																							,'~thor_data400::key::'+version+'::phonesmetadata::carrier_reference'
																							,bkPhonesMetadataCarrierName
																							);	

	//Move Metadata Carrier Name Key to Built Superfile	
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesmetadata::carrier_reference'
																							,'~thor_data400::key::'+version+'::phonesmetadata::carrier_reference'
																							,mvBltPhonesMetadataCarrierName
																							);
	
	//Move Metadata Carrier Name Key to QA Superfile
	PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::phonesmetadata::carrier_reference','Q',mvQAPhonesMetadataCarrierName,'3');

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Update DOps Page///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	dopsUpdate 		:= dops.updateversion('PhonesMetadataKeys', version, 'charlene.ros@lexisnexisrisk.com,judy.tao@lexisnexisrisk.com,gregory.rose@lexisnexisrisk.com,darren.knowles@lexisnexisrisk.com',,'N');

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Update Orbit///////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//orbitUpdate := Orbit3.proc_Orbit3_CreateBuild('Phones Metadata',version); 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Run Strata Stats///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	PhonesInfo.Out_STRATA_Population_Stats(PhonesInfo.File_TCPA.Main_Current,
																										PhonesInfo.File_iConectiv.Main_Current,
																										PhonesInfo.File_LIDB.Response_Processed,
																										PhonesInfo.File_Deact_GH.Main_Current,
																										PhonesInfo.File_Deact.Main_Current2,
																										PhonesInfo.File_Metadata.PortedMetadata_Main,
																										PhonesInfo.File_Source_Reference.Main,
																										version,
																										buildStrata
																										);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Run Scrub Reports//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////																				 
	ScrubsRuns	:= sequential(Scrubs_PhonesInfo.RawFileScrubs(version, _control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'), 
																										Scrubs_PhonesInfo.IndividualBaseFileScrubs(version, _control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'),
																										Scrubs_PhonesInfo.PostBuildScrubs(version, _control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'),
																										Scrubs_PhonesInfo.ScrubsProcessLIDB_Current(version, _control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'),
																										Scrubs_PhonesInfo.ScrubsProcessLIDB_Received(version, _control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'),
																										Scrubs_PhonesInfo.ScrubsProcessLIDB_Processed(version, _control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'),
																										);
															
/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Run Build & Send Notification Emails///////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	sendEmail		:= sequential(BuildLogger.BuildStart(false),
																										BuildLogger.PrepStart(false),
																										BuildLogger.PrepEnd(false),
																										BuildLogger.BaseStart(False),
																											buildComBase, 
																										BuildLogger.BaseEnd(False),
																											clearDelete, 
																											moveComBase, 
																										BuildLogger.KeyStart(false), 
																											bkPhonesPortedmetadata, mvBltPhonesPortedmetadata, mvQAPhonesPortedmetadata,
																											bkPhonesMetadataCarrierName, mvBltPhonesMetadataCarrierName, mvQAPhonesMetadataCarrierName, 
																										BuildLogger.KeyEnd(false),
																										BuildLogger.PostStart(False),
																											dopsUpdate, 
																											buildStrata, 
																											Sample_PhonesMetadata, 
																											ScrubsRuns,
																										BuildLogger.PostEnd(False),
																										BuildLogger.BuildEnd(false)):
																									Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' /*+ ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'*/, 'PhonesInfo Ported & Metadata Key Build Succeeded', workunit + ': Build complete.')),
																									Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' /*+ ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'*/, 'PhonesInfo Ported & Metadata Key Build Failed', workunit + '\n' + FAILMESSAGE)
																									);
	return sendEmail;														

END;
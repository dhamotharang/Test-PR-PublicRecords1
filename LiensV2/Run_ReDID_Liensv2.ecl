import ut,Liensv2,bankrupt,lib_fileservices,_control,RoxieKeybuild;

// Re-DID Liensv2 ( 7 Sources) and Evictions base file.

ut.MAC_SF_BuildProcess(Liensv2.Proc_DID_BDID_Liensv2(Liensv2.file_ILFDLN_party,'ilfdln'),
                       '~thor_data400::base::Liens::party::ILFDLN',bld_ILFDLN_party, 2,,true);

ut.MAC_SF_BuildProcess(Liensv2.Proc_DID_BDID_Liensv2(Liensv2.file_nyc_party,'nyc'),
                       '~thor_data400::base::Liens::party::NYC', bld_NYC_party, 2,,true);

   
ut.MAC_SF_BuildProcess(Liensv2.Proc_DID_BDID_Liensv2(Liensv2.file_nyfdln_party,'nyfdln'),
                       '~thor_data400::base::Liens::party::NYFDLN', bld_NYFDLN_party,2,,true);


				  
ut.MAC_SF_BuildProcess(Liensv2.Proc_DID_BDID_Liensv2(Liensv2.file_sa_party,'sa'),
                       '~thor_data400::base::Liens::party::SA', bld_SA_party, 2,,true);


				   
ut.MAC_SF_BuildProcess(Liensv2.Proc_DID_BDID_Liensv2(Liensv2.file_chicago_law_party,'chicago_law'),
                       '~thor_data400::base::Liens::party::chicago_law', bld_CGL_party,2,,true);


				   
ut.MAC_SF_BuildProcess(Liensv2.Proc_DID_BDID_Liensv2(Liensv2.file_CA_federal_party,'ca'),
                       '~thor_data400::base::Liens::party::CA_federal', bld_CA_federal_party,2,,true);
					   

// bld_hogan_party := output(
// Liensv2.Proc_DID_BDID_Liensv2_hogan(
// dataset('~thor_data400::base::liens::party::hogan_full',LiensV2.Layout_liens_party_ssn_for_hogan,flat),'hogan'),,
                       // '~thor_data400::base::liens::party::temp::hogan_full',overwrite);

Roxiekeybuild.Mac_SF_BuildProcess_V2(
		Liensv2.Proc_DID_BDID_Liensv2_hogan(Liensv2.file_Hogan_party_full,'hogan'),
		'~thor_data400::base::liens::party','hogan_full',ut.GetDate,bld_hogan_party,,,true);

ut.MAC_SF_BuildProcess(Liensv2.Proc_DID_BDID_Liensv2(liensv2.file_Superior_Party,'superior'),
                       '~thor_data400::base::liens::party::superior', bld_superior_party, 2,,true);

ut.MAC_SF_BuildProcess(Liensv2.Proc_DID_BDID_Liensv2(liensv2.file_MA_party,'ma'),
                       '~thor_data400::base::Liens::party::MA', bld_MA_party, 2,,true);

pre_redid := sequential(
			fileservices.clearsuperfile('~thor_data400::in::evictions_did_in'),
			fileservices.addsuperfile('~thor_data400::in::evictions_did_in','~thor_data400::base::eviction',,true)
			);	



ut.MAC_SF_BuildProcess(Bankrupt.BWR_DID_Evictions,
                       '~thor_data400::base::eviction', bld_eviction, 2,,true);

// Despray the base::eviction file to edata12, 
// so that the file is ready for next update (since it is a daily).

evic_file_despray := fileservices.Despray('~thor_data400::base::eviction',_Control.IPAddress.bctlpedata10,
 									'/thor_back5/liens/eviction/build/eviction_redid.d00',,,,TRUE);

// Check if the prod header version is newer than the last liensv2/evictions redid

export Run_ReDID_Liensv2 := if (ut.IsNewProdHeaderVersion('liensv2') or ut.IsNewProdHeaderVersion('liensv2','bheader_file_version'),
								sequential(
											fileservices.removesuperfile('~thor_data400::base::Liens::party::Hogan','~thor_data400::in::liensv2::party::dummy_irs2'),
											bld_ILFDLN_party,bld_NYC_party,bld_NYFDLN_party,
											bld_SA_party,bld_CGL_party,bld_CA_federal_party,
											bld_hogan_party,bld_superior_party,bld_MA_party,/*pre_redid,bld_eviction,evic_file_despray,*/
											fileservices.addsuperfile('~thor_data400::base::Liens::party::Hogan','~thor_data400::in::liensv2::party::dummy_irs2'),
											ut.PostDID_HeaderVer_Update('liensv2'),
											ut.PostDID_HeaderVer_Update('liensv2','bheader_file_version')
											//FileServices.DeleteLogicalFile('~thor_data400::base::liens::party::Hogan_full'),
											//FileServices.RenameLogicalFile('~thor_data400::base::liens::party::temp::Hogan_full', '~thor_data400::base::liens::party::Hogan_full')											
											),
								output('Liensv2 DID/BDID is up to date')
								);
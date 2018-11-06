import insuranceheader_postprocess, idl_header, adl_idl_mapping, idops, orbit, _Control;

// Preprocess
export proc_RidDidFile(string iter) := module

		shared files := InsuranceHeader_PostProcess.files;
		
		// Create DID-RID pair 
		// hdr_sf := NoThor(FileServices.SuperFileContents(idl_header.Files.FILE_IDL_POLICY_HEADER_BASE));
		// location := StringLib.StringFind(hdr_sf[1].name, '_w', 1);
		// shared iter := hdr_sf[1].name[location+1..location+16];		
		
		didRidDataset := InsuranceHeader_PostProcess.CreateDIDRIDFile;
		export didRidFile1 := output(didRidDataset,, files.FILE_DID_RID + iter, overwrite,compressed);
		export didRidFile2 := files.updateDIDRIDSuperFiles(files.FILE_DID_RID + iter);
		
		shared keys := adl_idl_mapping.keys.build_keys;
		shared builddate := thorlib.wuid()[2..9];
		shared update_idops		:= idops.UpdateBuildVersion('ADL_IDL_MappingKeys',trim(buildDate,left,right),mod_email.emailList,,'N');
		shared update_orbit    	:= orbit.CreateBuild('ADL_IDL_Mapping','ADL_IDL_Mapping',buildDate,'Production NonFCRA',orbit.GetToken());
				
		export run_did_rid := sequential(didRidFile1, didRidFile2, keys, update_iDops)
																			: SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader', ,'RID-DID File',)), 
																			     FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'RID-DID File'));
		
		export run := if(_Control.ThisEnvironment.Name = 'Prod',
													sequential(run_did_rid, 
															if (update_orbit[1].retcode = 'Success', 
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,
																		'Alpharetta InsuranceHeader ADL_IDL_Mapping File File OrbitI Create Build:'+buildDate+':SUCCESS',
																		'OrbitI Create build successful: ' + buildDate),
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList ,
																		'Alpharetta InsuranceHeader ADL_IDL_Mapping File OrbitI Create Build:'+buildDate+':FAILED',
																		'OrbitI Create build failed. Reason: ' + update_orbit[1].retdesc )
															)
													 ),
									sequential(output('Not a prod environment'))
									);
end;

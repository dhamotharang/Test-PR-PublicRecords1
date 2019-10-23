import idops, orbit, _control, InsuranceHeader_PostProcess, idl_header;

// Postprocess
export proc_ciidphone(string version) := module

		//#workunit('name','CIID Phone File Build');
		
		export hdr := idl_header.Files.DS_IDL_POLICY_HEADER_BASE;
		shared buildDate := thorlib.wuid()[2..9];
		shared mod_files := InsuranceHeader_PostProcess.ciidphone_files;

		export keys    := InsuranceHeader_PostProcess.CreateFileForPhoneVerification(hdr).hdrphonekey;
		shared ver_filename := '~' + mod_files.ver_file_prefix + '::' + version;
		export contrib := output(InsuranceHeader_PostProcess.CreateFileForPhoneVerification(hdr).contributory,,ver_filename,overwrite,compressed);
		
		shared ver_sf := mod_files.sfile_ver;
		export updateSF := SEQUENTIAL(if( not fileservices.superfileexists(ver_sf),
																			fileservices.createsuperfile(ver_sf)),
																	FileServices.PromoteSuperFileList([ver_sf], ver_filename,true));
		
		shared update_idops		:= idops.UpdateBuildVersion('IHdrCiidPhoneKeys',trim(buildDate,left,right),mod_email.emailList,,'N');
		shared update_orbit   := orbit.CreateBuild('IHdrCiidPhone','IHdrCiidPhone',buildDate,'Production NonFCRA',orbit.GetToken());
		
		export run_ciidphone := sequential(keys, contrib, updateSF, update_iDops)
																			 : SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader', , 'CiidPhone')), 
																			      FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'CiidPhone'));
		
		 export run := if(_Control.ThisEnvironment.Name = 'Prod',
													 sequential(run_ciidphone, 
															 if (update_orbit[1].retcode = 'Success', 
																 fileservices.sendemail(
																		 'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,																	
																		 'Alpharetta InsuranceHeader Ciid Phone OrbitI Create Build:'+buildDate+':SUCCESS',
																		 'OrbitI Create build successful: ' + buildDate),
																 fileservices.sendemail(
																		 'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,																	
																		 'Alpharetta InsuranceHeader Ciid Phone OrbitI Create Build:'+buildDate+':FAILED',
																		 'OrbitI Create build failed. Reason: ' + update_orbit[1].retdesc )
															 )
													  ),
									 sequential(output('Not a prod environment'))
									 );
									 
end;
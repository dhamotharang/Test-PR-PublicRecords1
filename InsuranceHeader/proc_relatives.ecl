import InsuranceHeader_Salt_T46, idl_header, dops, orbit, _control, insuranceheader_postprocess, insuranceheader_relative;

// Preprocess
export proc_relatives(string iter) := module

		#workunit('name','SALT - Relative File');
		shared hdr   := IDL_Header.Files.DS_SALT_ITER_OUTPUT;
		shared input := insuranceheader_relative.in_relative;

		shared specMod := InsuranceHeader_Relative.specificities(input);
		export specBuild := specMod.Build;
				
		shared oFile := InsuranceHeader_Salt_T46.file_relative.Relative_File + iter; 

		// Salt Iteration
		result := InsuranceHeader_Relative.relationships(input).ASSOC_links
							:persist('~thor_data400::persist::relatives::SALTResult', expire(30));

    // Append Metadata 
		resultf := project(result,insuranceheader_relative.layout_output.iter);
		append := InsuranceHeader_Relative.proc_postprocess(resultf,hdr);
		export relatives_build := output(append,,oFile,overwrite,compressed);

		// Update superfile
		export updateSuperFile := InsuranceHeader_Salt_T46.file_relative.updateSuperFile(oFile);
		
		// Generate Keys
		export buildKeys := InsuranceHeader_Salt_T46.keys_relative.build_keys;
		
		// Build Stats
		export buildStats := InsuranceHeader_Relative.proc_stats(iter);
		
		export run_base := sequential(relatives_build, updateSuperFile, buildKeys, buildStats);
		
		shared builddate := thorlib.wuid()[2..9];
		shared update_idops		:= dops.updateversion('RelativeV3Keys',trim(buildDate,left,right),mod_email.emailList,,'N');
		shared update_orbit   := orbit.CreateBuild('RelativeV3Keys','RelativeV3Keys',buildDate,'Production NonFCRA',orbit.GetToken());
		
		export run_relatives := sequential(specBuild, relatives_build, updateSuperFile, buildkeys, buildStats, update_iDops)
																			: SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader', , 'Relatives')), 
																			     FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'Relatives'));
		
		export run := if(_Control.ThisEnvironment.Name = 'Prod',
													sequential(run_relatives, 
															if (update_orbit[1].retcode = 'Success', 
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,																	
																		'Alpharetta InsuranceHeader Relatives OrbitI Create Build:'+buildDate+':SUCCESS',
																		'OrbitI Create build successful: ' + buildDate),
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,																	
																		'Alpharetta InsuranceHeader Relatives OrbitI Create Build:'+buildDate+':FAILED',
																		'OrbitI Create build failed. Reason: ' + update_orbit[1].retdesc )
															)
													 ),
									sequential(output('Not a prod environment'))
									);
end;
import idops, orbit, _control, InsuranceHeader_PostProcess;


// Preprocess
export proc_segmentation(string version) := module

		#workunit('name','Segmentation File Build');
		shared buildDate := thorlib.wuid()[2..9];
		
		export keys := InsuranceHeader_PostProcess.segmentation_keys.build_keys;
		
		shared update_idops		:= idops.UpdateBuildVersion('IHdrSegmentationKeys',trim(buildDate,left,right),mod_email.emailList,,'N');
		shared update_orbit   := orbit.CreateBuild('IHdrSegmentation Build','IHdrSegmentation Build',buildDate,'Production NonFCRA',orbit.GetToken());
		
		export run_segmentation := sequential( keys, update_iDops)
																			 : SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader', , 'Segmentation')), 
																			      FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'Segmentation'));
		
		 export run := if(_Control.ThisEnvironment.Name = 'Prod',
													 sequential(run_segmentation, 
															 if (update_orbit[1].retcode = 'Success', 
																 fileservices.sendemail(
																		 'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,																	
																		 'Alpharetta InsuranceHeader Segmentation OrbitI Create Build:'+buildDate+':SUCCESS',
																		 'OrbitI Create build successful: ' + buildDate),
																 fileservices.sendemail(
																		 'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,																	
																		 'Alpharetta InsuranceHeader Segmentation OrbitI Create Build:'+buildDate+':FAILED',
																		 'OrbitI Create build failed. Reason: ' + update_orbit[1].retdesc )
															 )
													  ),
									 sequential(output('Not a prod environment'))
									 );
end;
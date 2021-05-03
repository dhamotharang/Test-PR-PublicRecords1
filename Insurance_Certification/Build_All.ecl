IMPORT versioncontrol, _control, ut, Roxiekeybuild,scrubs,Scrubs_Insurance_Cert;

EXPORT Build_All(STRING	pversion) := MODULE
		EXPORT spray_files	:= fSpray(pversion);
		
		/* Certification Keybuild file */
		EXPORT dkeybuildCert :=	Update_Base_Cert(files().cert_input.using
																			      ,files().base_cert.qa,  pversion);
		VersionControl.macBuildNewLogicalFile( Filenames('Certification',pversion).keybuild.new 
																					,dkeybuildCert,  Build_CertKeyBuild_File );
																						
		/* Policy Keybuild file */
		EXPORT dkeybuildPol :=	Update_Base_Pol(files().pol_input.using
																			    ,files().base_pol.qa,  pversion);
		VersionControl.macBuildNewLogicalFile( Filenames('Policy',pversion).keybuild.new 
																					,dkeybuildPol,  Build_PolKeyBuild_File );
																					
		/* Certification Base file */	
		NewBaseCert			:=	project(files(pversion).keybuild_Cert.logical
												,TRANSFORM(layouts_certification.Base,SELF := LEFT;));
		VersionControl.macBuildNewLogicalFile( Filenames('Certification',pversion).base.new 
																					,NewBaseCert,  Build_CertBase_File );	
																						
		/* Policy Base file */		
		NewBasePol			:=	project(files(pversion).keybuild_Pol.logical
												,TRANSFORM(layouts_policy.Base,SELF := LEFT;));
   	VersionControl.macBuildNewLogicalFile( Filenames('Policy',pversion).base.new 
																					,NewBasePol,  Build_PolBase_File );

	run_scrubs := Scrubs_Insurance_Cert.Fn_RunScrubs(pversion,'charles.pettola@lexisnexis.com');
																					
	  dops_update := if(scrubs.mac_ScrubsFailureTest('Scrubs_Insurance_Cert_Cert,Scrubs_Insurance_Cert_Pol',pversion)
	  					,Roxiekeybuild.updateversion('InsuranceCertKeys',pVersion,'charles.pettola@lexisnexis.com',,'N')
						,OUTPUT('Dops update failed due to Scrubs reject warning(s)',NAMED('Dops_status')));																					
								
		full_build 	:= SEQUENTIAL( 
				 				   nothor(APPLY(filenames('Certification',pversion).Base.dAll_filenames, APPLY(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
					    		,nothor(APPLY(filenames('Certification',pversion).Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)))
								 	,nothor(APPLY(filenames('Policy',pversion).Base.dAll_filenames, APPLY(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
					    	  ,nothor(APPLY(filenames('Policy',pversion).Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)))
				    	    ,spray_files
									,PromoteFiles().fPromote_Sprayed2Using
									,Build_CertKeyBuild_File
									,Build_PolKeyBuild_File
									,Build_CertBase_File 
									,Build_PolBase_File 
									,run_scrubs
									,FileServices.ClearSuperFile(filenames('Certification',pversion).keybuild.built,true)
									,FileServices.ClearSuperFile(filenames('Policy',pversion).keybuild.built,true)
							    ,FileServices.AddSuperFile(filenames('Certification',pversion).keybuild.built,
																				     filenames('Certification',pversion).keybuild.logical)
									,FileServices.AddSuperFile(filenames('Policy',pversion).keybuild.built,
																					  filenames('Policy',pversion).keybuild.logical)													 
						      ,PromoteFiles().fPromote_Using2Used
						      ,PromoteFiles(pversion).fPromote_New2Built
						      ,PromoteFiles(pversion).fPromote_Built2QA
									,Proc_AutokeyBuild_BDID(pversion)    /* Build BDID & DID AutoKeys   */
									,Proc_Build_Keys(pversion)			 /* Build Roxie Keys  */
									,out_STRATApopulation_stats(pversion)
									,out_STRATApopulation_stats_Policy(pversion)
									,dops_update
																) : success(send_email(pversion).buildsuccess), 
																    failure(send_email(pversion).buildfailure);
   
		EXPORT All 	:= IF(VersionControl.IsValidVersion(pversion)
												,full_build
												,OUTPUT('No Valid version parameter passed, skipping build') );
END;
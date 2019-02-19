IMPORT versioncontrol, _control, ut, Orbit3;

EXPORT Build_All(STRING	pversion) := MODULE
		EXPORT spray_files	:= fSpray(pversion);
		
		EXPORT dkeybuild		:=	Update_Base(files().input.using,files().Base_Full.qa,pversion);
		
		VersionControl.macBuildNewLogicalFile( Filenames(pversion).keybuild_full.new 
																				,dkeybuild
																				,Build_KeyBuild_File );
																				
		EXPORT DS_Full_Key := files(pversion).keybuild_full.logical;
		
		//added 9/11/2015 Tim Newport
		OLDKey  		:= project(DS_Full_Key,Transform(Layouts.KeyBuild,
														SELF.Description := LEFT.Business_Name; /*Field Name Updated 9/11/2015*/
														SELF.EffectiveMonth := LEFT.Policy_Eff_Month ; /*Field Name Updated 9/11/2015*/
														SELF.Effective_Date :=  LEFT.Policy_Eff_Date;   /*Effective_Date; /*Field Name Updated 9/11/2015*/ 
														SELF.NAICCarrierName := LEFT.Carrier_NAIC_Name;   /*Field Name Updated 9/11/2015*/
														SELF.NAICCarrierNumber := LEFT.Carrier_NAIC_Id;   /*Field Name Updated 9/11/2015*/
														SELF.NAICGroupName := LEFT.Group_NAIC_NAME;   /*Field Name Updated 9/11/2015*/
														SELF.NAICGroupNumber := LEFT.Group_NAIC_Id;   /*Field Name Updated 9/11/2015*/
														SELF.PolicySelf := LEFT.Policy_Number;   /*Field Name Updated 9/11/2015*/
														SELF := LEFT));													
		
		VersionControl.macBuildNewLogicalFile( Filenames(pversion).keybuild.new 
																						,OLDKey
																						,Build_OLD_KeyBuild_File );
			
		NewBase			:=	project(DS_Full_Key,TRANSFORM(Layouts.Base_FULL,SELF := LEFT;));
   	VersionControl.macBuildNewLogicalFile( Filenames(pversion).Base_Full.new 
																						,NewBase
																						,Build_Base_File );	
																						
    Copy2Alpha := sequential(output('Copying WorkerComp keybuild_full file to 10.194.112.105')
		                                ,fileservices.Copy(filenames(pversion).keybuild_full.logical
																		,'thor400_112'
																		,filenames(pversion).keybuild_full.logical
																		,_control.IPAddress.prod_thor_dali
																		,
																		,'http://alpha_prod_thor_esp.risk.regn.net:8010/FileSpray'
																		,
																		,true
																		,true
																		,
																		,true));
										
		create_orbit := Orbit3.proc_Orbit3_CreateBuild ( 'Workers Compensation',pversion);
				
		full_build 	:= SEQUENTIAL(
				 				   nothor(APPLY(filenames().Base.dAll_filenames, APPLY(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
					    		,nothor(APPLY(filenames().Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)))
				    	    ,spray_files
							    ,Promote().Input.sprayed2using
									,Build_KeyBuild_File
									,Build_OLD_KeyBuild_File
									,Build_Base_File
									,FileServices.ClearSuperFile(filenames(pversion).keybuild.built,true)
									,FileServices.AddSuperFile(filenames(pversion).keybuild.built,filenames(pversion).keybuild.logical)
									,Promote().Input.Using2Used
									,Promote(pversion).New2Built
									,Promote().Built2QA
									,Copy2Alpha
									,Proc_AutokeyBuild(pversion)      /* Build BDID AutoKeys */
									,proc_build_keys(pversion).all    /* Build Roxie Keys */
									,out_STRATApopulation_stats(pversion)
									,out_qa_samples
									,create_orbit
									,send_email(pversion).buildsuccess
														) : success(send_email(pversion).roxie.qa), 
																failure(send_email(pversion).buildfailure);
   
		EXPORT All 	:= IF(VersionControl.IsValidVersion(pversion)
												,full_build
												,OUTPUT('No Valid version parameter passed, skipping build') );
END;

		
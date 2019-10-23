import versioncontrol, _control, ut,Roxiekeybuild, orbit3;

export Build_all(string	pVersion,string filedate) := function 
							 
		 current_Keybase			:= ECRulings.File_cleaned(pVersion);
		 Previous_Keybase			:= Files().Base.qa ;
		 Test									:= nothor(count(fileservices.superfilecontents(filenames().Base.qa)) > 0);
		 		 
		 Full_keybase					:= sort(if(Test,current_Keybase + Previous_Keybase,current_Keybase),RECORD); 
																
		 ECRulings.Layouts.Clean_comp_DeciPub_EconomicAct_Eventdoc   rollupXform(ECRulings.Layouts.Clean_comp_DeciPub_EconomicAct_Eventdoc  l, ECRulings.Layouts.Clean_comp_DeciPub_EconomicAct_Eventdoc  r) := transform
				self.dt_vendor_first_reported  	:=  if(l.dt_vendor_first_reported > r.dt_vendor_first_reported, r.dt_vendor_first_reported, l.dt_vendor_first_reported);
				self.dt_vendor_last_reported   	:= 	if(l.dt_vendor_last_reported  < r.dt_vendor_last_reported,  r.dt_vendor_last_reported,  l.dt_vendor_last_reported);
				self.dt_first_seen							:=	if(l.dt_first_seen > r.dt_first_seen, r.dt_first_seen, l.dt_first_seen);
				self.dt_last_seen								:=	if(l.dt_last_seen  < r.dt_last_seen,  r.dt_last_seen,  l.dt_last_seen);
				self                						:= 	l;
		 end;
  
		 new_base := rollup(Full_keybase, rollupXform(LEFT,RIGHT), RECORD,EXCEPT dt_vendor_first_reported,dt_vendor_last_reported,dt_first_seen,dt_last_seen);
   
		 VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.new,new_base,Build_Base_File);
							
		 dops_update := Roxiekeybuild.updateversion('ECRulingKeys',pVersion,'saritha.myana@lexisnexis.com, charlene.ros@lexisnexis.com',,'N'); 

		 orbitUpdate := Orbit3.proc_Orbit3_CreateBuild_AddItem('ECRulings',pversion,'N');
																	
		 full_build :=sequential (nothor(apply(filenames().Base.dAll_filenames, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
														 ,nothor(apply(Keynames(pversion).dall_filenames, apply(dSuperfiles,VersionControl.mUtilities.createsupers(Keynames(pversion).dall_filenames))))
														 ,fSprayFiles(filedate)
														 ,Build_Base_File
														 ,Proc_build_autoKeys(pversion)
														 ,Promote(pversion).New2Built
														 ,Promote(pversion).Built2Qa
														 ,output(choosen(sort(Files().Base.qa,-DateAdded), 5000), named ('BaseFile_SampleRecords'))
														 ,dops_update
														 ,Out_Strata_Population_Stats(pversion)
														 ,orbitUpdate
														) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);
   
		return  if(VersionControl.IsValidVersion(pversion)
							,full_build
							,output('No Valid version parameter passed, skipping  the build')
						 );
end;
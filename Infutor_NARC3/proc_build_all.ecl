
import versioncontrol,Orbit3,Roxiekeybuild,_Control;

EXPORT proc_build_all (string pVersion):= function

 spray_raw := Infutor_NARC3.fSprayFiles(pVersion,,,,'thor400_sta01');
 
 
  dAll_filenames	:=	Filenames().dAll_filenames +	
														Keynames().dAll_filenames		+    // create non FCRA Superfiles 
														Keynames(,,TRUE).dAll_filenames  // create FCRA Superfiles
															;
  //DOPS Entry Creation  
	dops_update	:=	RoxieKeyBuild.updateversion('InfutorNARC3Keys', pVersion, _Control.MyInfo.EmailAddressNotify+';tarun.patel@lexisnexisrisk.com',,'N');														
 
  //Orbit Entry Creation  
	orbit_update := Orbit3.proc_Orbit3_CreateBuild ('InfutorNARC3',pVersion,'N');
	
	build_infutor_narc3	:=	SEQUENTIAL(
		versioncontrol.mUtilities.createsupers(dAll_filenames),
		spray_raw,
		infutor_narc3.Promote(pVersion).inputfiles.Sprayed2Using,
		Infutor_NARC3.proc_build_base(pVersion),
		infutor_narc3.Promote(pVersion).Inputfiles.Using2Used,
		infutor_narc3.Promote(pVersion, 'base',pIsDeltaBuild:=FALSE).buildfiles.New2Built,
		infutor_narc3.Promote(pVersion, 'base',pIsDeltaBuild:=FALSE).buildfiles.Built2QA,
		Infutor_NARC3.proc_build_keys(pVersion),
		infutor_narc3.Promote(pVersion,'key').BuildFiles.New2Built,
		infutor_narc3.Promote(,'key').BuildFiles.Built2QA,
		// scrubs,
		// strata,
		dops_update,
		orbit_update,
	) : SUCCESS(Send_Emails(pVersion,pBuildMessage:='Infutor Narc3 Basefile Build is complete').BuildMessage),
			FAILURE(Send_Emails(pVersion).BuildFailure);	
	
	return build_infutor_narc3;
	
	end;
	
	

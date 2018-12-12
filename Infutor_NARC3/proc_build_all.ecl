
import versioncontrol;
EXPORT proc_build_all (string pVersion):= function

 spray_raw := Infutor_NARC3.fSprayFiles(pVersion,,,,'thor400_sta01');
 
 
  dAll_filenames	:=	Filenames().dAll_filenames +	
														Keynames().dAll_filenames		+    // create non FCRA Superfiles 
														Keynames(,,TRUE).dAll_filenames  // create FCRA Superfiles
															;

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
		infutor_narc3.Promote(,'key').BuildFiles.Built2QA	
	) : SUCCESS(Send_Emails(pVersion,pBuildMessage:='Infutor Narc3 Basefile Build is complete').BuildMessage),
			FAILURE(Send_Emails(pVersion).BuildFailure);
	
	
	return build_infutor_narc3;
	
	end;
	
	

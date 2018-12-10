
import versioncontrol;
EXPORT proc_build_all (string pVersion):= function

 spray_raw := Infutor_NARC3.fSprayFiles(pVersion,,,,'thor400_sta01');
 
 
  dAll_filenames	:=	Filenames().dAll_filenames	
	                          //  +	
														//	Keynames().dAll_filenames		+
														//	Keynames(,,TRUE).dAll_filenames
															;

	build_infutor_narc3	:=	SEQUENTIAL(
		versioncontrol.mUtilities.createsupers(dAll_filenames),
		spray_raw,
		Promote(pVersion).inputfiles.Sprayed2Using,
		Infutor_NARC3.proc_build_base(pVersion),
		Promote(pVersion).Inputfiles.Using2Used,
		Promote(pVersion, 'base',pIsDeltaBuild:=FALSE).buildfiles.New2Built,
		Promote(pVersion, 'base',pIsDeltaBuild:=FALSE).buildfiles.Built2QA	
	) : SUCCESS(Send_Emails(pVersion,pBuildMessage:='Infutor Narc3 Basefile Build is complete').BuildMessage),
			FAILURE(Send_Emails(pVersion).BuildFailure);
	
	
	return build_infutor_narc3;
	
	end;
	
	

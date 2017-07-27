IMPORT versioncontrol, _control, ut, tools,HMS_KOP_TRGT_HARV;
EXPORT Build_all(string pversion, boolean pUseProd = false) := FUNCTION

	spray_  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));



	built := sequential(
						spray_
						,Build_Base.build_base_koptrgtharv(pVersion,pUseProd).koptrgtharv_all
						,Build_Keys.Build_Keys_koptrgtharv(pversion,pUseProd).koptrgtharv_all
						,Promote.Promote_koptrgtharv(pversion,pUseProd).buildfiles.Built2QA
	
					): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure

	);


	return built;
END;
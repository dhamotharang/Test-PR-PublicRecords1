IMPORT versioncontrol, _control, ut, tools,HMS_KOP_TRGT_HARV;
EXPORT Build_all(string pversion, boolean pUseProd = false) := FUNCTION

	spray_  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));

	superFile := FileServices.SuperFileExists('~thor400_data::base::kop_trgt_harv::trgt_harv_results');

	if(not superFile,FileServices.CreateSuperFile('~thor400_data::base::kop_trgt_harv::trgt_harv_results',,1));

	built := sequential(
						spray_,
						Build_Base.build_base_koptrgtharv(pVersion,pUseProd).koptrgtharv_all
						,Build_Keys.Build_Keys_koptrgtharv(pversion,pUseProd).koptrgtharv_all
						,Promote.Promote_koptrgtharv(pversion,pUseProd).buildfiles.Built2QA
						
						,FileServices.StartSuperFileTransaction()
						//Clean Up Base Files
						,FileServices.RemoveOwnedSubFiles('~thor400_data::base::kop_trgt_harv::trgt_harv_results',true)
						,FileServices.AddSuperFile('~thor400_data::base::kop_trgt_harv::trgt_harv_results','~thor400_data::base::kop_trgt_harv::trgt_harv_results::' + pVersion)
						,FileServices.FinishSuperFileTransaction()
	
					): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure

	);


	return built;
END;
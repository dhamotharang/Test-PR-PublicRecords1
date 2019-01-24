
import versioncontrol, _control, ut, tools;
export Build_all(string pversion, boolean pUseProd = false) := function

spray_  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));


built := sequential(
					spray_
					,Build_Base(pversion,pUseProd).all
					,Build_Keys(pversion,pUseProd).all
					,Promote(pversion,pUseProd).buildfiles.Built2QA
			    ,Build_Strata(pversion,pUseProd).all
					//Archive processed files in history					
					,FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile(Filenames(pversion,pUseProd).lInputHistTemplate,  Filenames(pversion,pUseProd).lInputTemplate,,true)
					,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).lInputTemplate)
					,FileServices.FinishSuperFileTransaction()
				): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure

);


return built;
end;

import versioncontrol, _control, ut, tools, Roxiekeybuild, Scrubs_Infutor_NARC;
export Build_all(string pversion, boolean pUseProd = false) := function

spray_  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));
dops_update := Roxiekeybuild.updateversion('InfutorNARCKeys',pversion,'Randy.Reyes@lexisnexis.com;Manuel.Tarectecan@lexisnexis.com;Abednego.Escobal@lexisnexis.com',,'N');

built := sequential(
					spray_
					,Build_Base(pversion,pUseProd).all
					,Build_Keys(pversion,pUseProd).all
					,Promote(pversion,pUseProd).buildfiles.Built2QA
			    ,Build_Strata(pversion,pUseProd).all
					,Scrubs_Infutor_NARC.PostBuildScrubs(pversion)
					//Archive processed files in history					
					,FileServices.StartSuperFileTransaction()
					,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).lInputHistTemplate,true)
					,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).lInputHistTemplate)
					,FileServices.AddSuperFile(Filenames(pversion,pUseProd).lInputHistTemplate,  Filenames(pversion,pUseProd).lInputTemplate,,true)
					,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).lInputTemplate)
					,FileServices.FinishSuperFileTransaction()
					,dops_update
				): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure

);


return built;
end;
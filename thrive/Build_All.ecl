
import versioncontrol, _control, ut, tools, RoxieKeyBuild;
export Build_all(string pversion, boolean pUseProd = false) := function

spray_lt  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd).lt);
spray_pd  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd).pd);

dops_update  := sequential(RoxieKeybuild.updateversion('ThriveKeys',pversion,'angela.herzberg@lexisneis.com; Melanie.Jackson@lexisnexis.com',,'N'));

built := sequential(
					spray_lt
					,spray_pd
					,Build_Base(pversion,pUseProd).all
					,Build_Keys(pversion,pUseProd).all
					,Promote(pversion,pUseProd).buildfiles.Built2QA
			    ,Build_Strata(pversion,pUseProd).all
					//Archive processed files in history					
					,FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile(Filenames(pversion,pUseProd).lInputLtHistTemplate,  Filenames(pversion,pUseProd).lInputLtTemplate,,true)
					,FileServices.AddSuperFile(Filenames(pversion,pUseProd).lInputPdHistTemplate,  Filenames(pversion,pUseProd).lInputPdTemplate,,true)					
					,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).lInputLtTemplate)
					,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).lInputPdTemplate)
					,FileServices.FinishSuperFileTransaction()
					,dops_update
				): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure

);


return built;
end;
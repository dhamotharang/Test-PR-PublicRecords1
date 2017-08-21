
import versioncontrol, _control, ut, tools,HMS_SureScripts;
export Build_all(string pversion, boolean pUseProd = false) := function

spray_  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));
spray_Specialty  := VersionControl.fSprayInputFiles(fSpray_Specialty(pversion,pUseProd));

built := sequential(
					Create_SuperFiles(pversion,pUseProd).CreateSF_All
					,spray_
					,spray_Specialty
					,HMS_SureScripts.Build_Specialty_Base(pversion,pUseProd).All
					,HMS_SureScripts.Promote_specCodes(pversion,pUseProd).buildfiles.Built2QA					
					,Build_Base(pversion,pUseProd).all
					,Promote(pversion,pUseProd).buildfiles.Built2QA
					,Build_Keys(pversion,pUseProd).all
					,Promote(pversion,pUseProd).buildfiles.Built2QA
					,Scrub_code(pversion).Scrubbed_Output					
 			    ,Build_Strata(pversion,pUseProd).all
					// Archive processed files in history					
					,FileServices.StartSuperFileTransaction()
					// Move the input to history AFTER cleaning the history -- OR just use father & grand father
					,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).lInputHistTemplate)					
					,FileServices.AddSuperFile(Filenames(pversion,pUseProd).lInputHistTemplate,  Filenames(pversion,pUseProd).lInputTemplate,,true)
					,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).lInputTemplate)
					// Now do the same for the ss_Spec file
					,FileServices.ClearSuperFile(Filenames_SpecCodes(pversion,pUseProd).lSpecCodesInputHistTemplate)					
					,FileServices.AddSuperFile(Filenames_SpecCodes(pversion,pUseProd).lSpecCodesInputHistTemplate,  Filenames_SpecCodes(pversion,pUseProd).lSpecCodesInputTemplate,,true)
					,FileServices.ClearSuperFile(Filenames_SpecCodes(pversion,pUseProd).lSpecCodesInputTemplate)
					
					,FileServices.FinishSuperFileTransaction()

				): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure

);

return built;
end;

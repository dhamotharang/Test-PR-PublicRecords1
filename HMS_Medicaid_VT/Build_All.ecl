import versioncontrol, _control, ut, tools,HMS_Medicaid_VT,HMS_Medicaid_Common;
export Build_all(string pversion, boolean pUseProd = false) := function
Medicaid_State := 'VT';
spray_  		 := VersionControl.fSprayInputFiles(HMS_Medicaid_Common.fSpray(Medicaid_State,pversion,pUseProd));

built := sequential(
					HMS_Medicaid_Common.Create_SuperFiles(Medicaid_State, pversion,pUseProd).CreateSF_All
					,spray_
					,Build_Base(pversion,pUseProd).all
					//,Build_Keys(pversion,pUseProd).all
					,HMS_Medicaid_Common.Promote(Medicaid_State,pversion,pUseProd).buildfiles.Built2QA
					,Scrub_code(pversion).Scrubbed_Output					
 			    ,Build_Strata(pversion,pUseProd).all
					// Archive processed files in history					
					,FileServices.StartSuperFileTransaction()
					// Move the input to history AFTER cleaning the history -- OR just use father & grand father
					,FileServices.ClearSuperFile(HMS_Medicaid_Common.FileNames(Medicaid_State,pversion,pUseProd).lInputHistTemplate)					
					,FileServices.AddSuperFile(HMS_Medicaid_Common.FileNames(Medicaid_State,pversion,pUseProd).lInputHistTemplate,  HMS_Medicaid_Common.FileNames(Medicaid_State,pversion,pUseProd).lInputTemplate,,true)
					,FileServices.ClearSuperFile(HMS_Medicaid_Common.FileNames(Medicaid_State,pversion,pUseProd).lInputTemplate)
					,FileServices.FinishSuperFileTransaction()
				): success(HMS_Medicaid_Common.Send_EMail(Medicaid_State,pversion,pUseProd).BuildSuccess), failure(HMS_Medicaid_Common.send_email(Medicaid_State,pversion,pUseProd).BuildFailure

);
return built;
end;
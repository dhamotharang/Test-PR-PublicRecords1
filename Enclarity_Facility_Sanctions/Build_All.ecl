import versioncontrol, _control, ut, tools;
export Build_all(string pversion, boolean pUseProd = false) := function

spray_  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));

built := sequential(
					 spray_
					,Enclarity_Facility_Sanctions.Build_base.build_base_facility_sanctions(pversion,pUseProd).facility_sanctions_all
					,Enclarity_Facility_Sanctions.Build_Keys.build_keys_facility_sanctions(pversion,pUseProd).facility_sanctions_all
					,Enclarity_Facility_Sanctions.Promote.promote_facility_sanctions(pversion,pUseProd).buildfiles.Built2QA
					//Archive processed files in history					
						,FileServices.StartSuperFileTransaction()
						,FileServices.RemoveOwnedSubFiles(Enclarity_Facility_Sanctions.Filenames(pversion,pUseProd).facility_sanctions_lInputHistTemplate,true)
						,FileServices.ClearSuperFile(Enclarity_Facility_Sanctions.Filenames(pversion,pUseProd).facility_sanctions_lInputHistTemplate)
						,FileServices.AddSuperFile(Enclarity_Facility_Sanctions.Filenames(pversion,pUseProd).facility_sanctions_lInputHistTemplate,  Enclarity_Facility_Sanctions.Filenames(pversion,pUseProd).facility_sanctions_lInputTemplate,,true)
						,FileServices.RemoveOwnedSubFiles(Enclarity_Facility_Sanctions.Filenames(pversion,pUseProd).facility_sanctions_lInputTemplate,true)
						,FileServices.ClearSuperFile(Enclarity_Facility_Sanctions.Filenames(pversion,pUseProd).facility_sanctions_lInputTemplate)
						,FileServices.FinishSuperFileTransaction()
					): success(Enclarity_Facility_Sanctions.Send_Email(pversion,pUseProd).BuildSuccess), failure(Enclarity_Facility_Sanctions.send_email(pversion,pUseProd).BuildFailure

);

return built;
end;
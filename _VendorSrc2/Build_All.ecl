import versioncontrol, _control, ut, tools,promotesupers,std;

export Build_all(string pversion, boolean pUseProd = false) := function


spray  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));

ORBITdump:=_VendorSrc2.StandardizeInputFile(pversion, pUseProd).ORBIT;
PromoteSupers.MAC_SF_BuildProcess(orbitdump,'~thor_data400::in::vendorsrc::orbit', ExtractOrbit,2,,true,pversion);

built := sequential(
          
					// STD.File.CreateSuperFile('~thor_data400::in::vendorsrc::orbit');
					// STD.File.CreateSuperFile('~thor_data400::in::vendorsrc::orbit_father');
					
					spray,
					ExtractORBIT,
					_VendorSrc2.Build_Base(pversion,pUseProd).vendorsrc_all,
					Build_Keys(pversion,pUseProd).all,
					_VendorSrc2.Promote.Promote_vendorsrc2(pversion,pUseProd).buildfiles.Built2QA,
			    Build_Strata(pversion,pUseProd).all, 
					 
					 
					//Archive processed files in history					
					FileServices.StartSuperFileTransaction(),
					
					FileServices.AddSuperFile(Filenames(pversion,pUseProd).BankCourt_lInputFatherTemplate,  Filenames(pversion,pUseProd).BankCourt_lInputTemplate,,true),
					FileServices.ClearSuperFile(Filenames(pversion,pUseProd).BankCourt_lInputTemplate),
					
					FileServices.AddSuperFile(Filenames(pversion,pUseProd).LienCourt_lInputFatherTemplate,  Filenames(pversion,pUseProd).LienCourt_lInputTemplate,,true),
					FileServices.ClearSuperFile(Filenames(pversion,pUseProd).LienCourt_lInputTemplate),
					
					FileServices.AddSuperFile(Filenames(pversion,pUseProd).CourtLocations_lInputFatherTemplate,  Filenames(pversion,pUseProd).CourtLocations_lInputTemplate,,true),
					FileServices.ClearSuperFile(Filenames(pversion,pUseProd).CourtLocations_lInputTemplate),
					
					FileServices.AddSuperFile(Filenames(pversion,pUseProd).MasterList_lInputFatherTemplate,  Filenames(pversion,pUseProd).MasterList_lInputTemplate,,true),
					FileServices.ClearSuperFile(Filenames(pversion,pUseProd).MasterList_lInputTemplate),
					
					FileServices.AddSuperFile(Filenames(pversion,pUseProd).CollegeLocator_lInputFatherTemplate,  Filenames(pversion,pUseProd).CollegeLocator_lInputTemplate,,true),
					FileServices.ClearSuperFile(Filenames(pversion,pUseProd).CollegeLocator_lInputTemplate),
					
				  FileServices.FinishSuperFileTransaction(),
				  ): success(Send_Email(pversion,pUseProd).BuildSuccess),
				  failure(send_email(pversion,pUseProd).BuildFailure) ;


return built;
end;
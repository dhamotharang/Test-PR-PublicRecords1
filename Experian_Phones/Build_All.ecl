import ut, VersionControl,scrubs_experian_phones;
export Build_all(string version, boolean incr_update) := function

//-----------Spray input and delete files
spray_input  := VersionControl.fSprayInputFiles(Spray(version).Input);
//----------Build base
base_f := Build_base(version, incr_update);
ut.MAC_SF_BuildProcess(base_f,Filenames.Base ,ExperianPhones,3,,true);

built := sequential(
					spray_input
					,Scrubs_Experian_Phones.fnRunInputScrubs(version)
				  ,ExperianPhones
					,Scrubs_Experian_Phones.fnRunBaseScrubs(version)
					,Build_keys(version).all
			    ,Build_Strata(version).all
					,Build_Reports(version, incr_update)
					,PhonesMatrixReport
					//Archive processed files in history
					,FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile(Filenames.history,Filenames.input,,true)
					,FileServices.ClearSuperFile(Filenames.input)
					,FileServices.FinishSuperFileTransaction()
					);
return built;

end;
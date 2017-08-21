IMPORT HMS_SureScripts;

EXPORT Create_Superfiles(string pversion = '', boolean pUseProd = false) := MODULE


    EXPORT CreateSF_individual() :=    MODULE
			sfName := Filenames(pversion, pUseProd).lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_history() :=    MODULE
			sfName := Filenames(pversion, pUseProd).lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_SpecCodes() :=    MODULE
			sfName := Filenames_SpecCodes(pversion, pUseProd).lSpecCodesTemplate_Built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
    EXPORT CreateSF_individual_SpecCodes_history() :=    MODULE
			sfName := Filenames_SpecCodes(pversion, pUseProd).lSpecCodesInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
   EXPORT CreateSF_All :=  PARALLEL(
    CreateSF_individual().create_sf;
    CreateSF_individual_history().create_sf;
    CreateSF_individual_SpecCodes().create_sf; 
    CreateSF_individual_SpecCodes_history().create_sf; 
  );

END;

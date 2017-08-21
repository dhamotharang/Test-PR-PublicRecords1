//IMPORT HMS_SureScripts;

EXPORT Create_Superfiles(string2 Medicaid_State, string pversion = '', boolean pUseProd = false) := MODULE

    EXPORT CreateSF_individual() :=    MODULE
			sfName := Filenames(Medicaid_State, pversion, pUseProd).lInputTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_Built() :=    MODULE
			sfName := Filenames(Medicaid_State, pversion, pUseProd).lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_individual_history() :=    MODULE
			sfName := Filenames(Medicaid_State, pversion, pUseProd).lInputHistTemplate;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;
				
   EXPORT CreateSF_All :=  PARALLEL(
    CreateSF_individual().create_sf;
		CreateSF_individual_Built().create_sf;
    CreateSF_individual_history().create_sf;
  );

END;

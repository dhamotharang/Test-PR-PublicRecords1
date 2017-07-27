IMPORT HMS;

EXPORT CreateSuperFiles(string pversion = '', boolean pUseProd = false) := MODULE

    EXPORT CreateSF_aha() :=    MODULE
			sfName := Filenames(pversion, pUseProd).aha_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_dea() :=    MODULE
			sfName := Filenames(pversion, pUseProd).dea_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_npi() :=    MODULE
			sfName := Filenames(pversion, pUseProd).npi_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_pos() :=    MODULE
			sfName := Filenames(pversion, pUseProd).pos_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_organization() :=    MODULE
			sfName := Filenames(pversion, pUseProd).organization_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_affiliations() :=    MODULE
			sfName := Filenames(pversion, pUseProd).affiliations_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;

    EXPORT CreateSF_crosswalk() :=    MODULE
			sfName := Filenames(pversion, pUseProd).crosswalk_lBaseTemplate_built;
			EXPORT create_sf := if (not Fileservices.SuperFileExists(sfName), Fileservices.CreateSuperFile(sfName));
    END;


   EXPORT CreateSF_All :=  PARALLEL(
    CreateSF_aha().create_sf;
    CreateSF_dea().create_sf;
    CreateSF_npi().create_sf;
    CreateSF_pos().create_sf;
    CreateSF_organization().create_sf;
    CreateSF_crosswalk().create_sf;
    CreateSF_affiliations().create_sf;
  );

END;

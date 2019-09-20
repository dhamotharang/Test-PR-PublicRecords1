IMPORT tools;

EXPORT Files(STRING pversion='', boolean pUseProd=false, boolean pIsFull=false) := module

    /* Flag Files */
    export flagFile          := 
        DATASET(Filenames(pversion, pUseProd, pIsFull).buildFlagFile, INQL_TMX.layouts.BuildVersionRecord, THOR);
        
    export flagFileHistory   := 
        DATASET(Filenames(pversion, pUseProd, pIsFull).buildHistoryFlagFile, INQL_TMX.layouts.BuildVersionRecord, THOR);


    /* Input File Versions */
    export input := DATASET(Filenames(pversion, pUseProd, pIsFull).lInputTemplate, layouts.raw, CSV);
    
    /* Base File Versions */
    // tools.mac_FilesBase(Filenames(pversion, pUseProd).input, layouts.raw, input);
    tools.mac_FilesBase(Filenames(pversion, pUseProd, pIsFull).base, Layouts.base, base, pOpt:=true);

    /* Keybuild File */
    // versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.key_payload, keybuild); 
    // versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild); 
	 
end;
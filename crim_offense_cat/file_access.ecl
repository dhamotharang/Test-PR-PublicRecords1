import crim_offense_cat;
export file_access(pUseProd = false) := module
    #option('multiplePersistInstances',FALSE);
    export raw_input := dataset(crim_offense_cat.filenames(pUseProd).BaseIn, crim_offense_cat.layouts.base_layout, CSV(Heading(1),separator(['^|^']))):persist(crim_offense_cat.filenames(pUseProd).basein + 'rawpersist');
    export Base := dataset(crim_offense_cat.Filenames(pUseProd).base, crim_offense_cat.layouts.base_layout, thor, __compressed__, opt):persist(crim_offense_cat.filenames(pUseProd).key + 'persist');
    
end;
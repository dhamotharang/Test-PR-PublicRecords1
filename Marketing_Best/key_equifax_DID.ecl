import Marketing_Best, Doxie, Data_Services;

got_a_did := marketing_best.file_equifax_base(did<>0);

export key_equifax_DID := index(got_a_did,{unsigned6 l_did := (unsigned)did},{got_a_did},Data_Services.Data_location.Prefix()+'thor_data400::key::Marketing_Best::'+ Doxie.Version_SuperKey+'::equifax_DID');
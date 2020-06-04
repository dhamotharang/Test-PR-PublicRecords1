import doxie,ut, PRTE2_Certegy, Data_services;

EXPORT Keys := MODULE

export key_certegy_did := index(files.key_did,{did},{files.key_did},
Data_Services.Data_location.Prefix('DEFAULT')+ constants.key_prefix + doxie.Version_SuperKey + '::did');

END;
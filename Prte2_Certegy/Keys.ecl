// import doxie,ut, PRTE2_Certegy, Data_services;

// EXPORT Keys := MODULE

// export key_certegy_did := index(files.key_did,{did>0},{files.key_did},
// Data_Services.Data_location.Prefix('DEFAULT')+ constants.key_prefix + doxie.Version_SuperKey + '::did');

// END;


import doxie,ut, PRTE2_Certegy, Data_services;

EXPORT Keys := MODULE

certegy_did := files.key_did(did>0);

export key_certegy_did := index(certegy_did,{did},{certegy_did},
Data_Services.Data_location.Prefix('DEFAULT')+ constants.key_prefix + doxie.Version_SuperKey + '::did');
                        
                       
END;
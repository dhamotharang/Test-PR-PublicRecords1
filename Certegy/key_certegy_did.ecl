import doxie, data_services;

certegy_did := Files.certegy_base(did>0);

export key_certegy_did := index(certegy_did,{did},{certegy_did}
								,data_services.data_location.prefix() + 'thor_data400::key::certegy::'+doxie.Version_SuperKey+'::did');

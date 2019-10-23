import doxie,data_services;
d := Files.Payload(did>0);

export Key_DID := INDEX(d, {did}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC2::key::did_' + doxie.version_superkey);
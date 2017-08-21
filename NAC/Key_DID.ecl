import doxie,data_services;
d := Files().Base(did>0);

export Key_DID := INDEX(d, {did}, {d}-[prefname,NCF_FileTime], 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC::key::did_' + doxie.version_superkey);
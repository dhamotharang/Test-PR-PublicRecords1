import doxie,data_services;
d := Files().Base(PrepRecSeq>0);

export Key_PrepRecSeq := INDEX(d, {PrepRecSeq}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC::key::PrepRecSeq_' + doxie.version_superkey);
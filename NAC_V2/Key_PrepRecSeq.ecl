import doxie,data_services;
d := Files.Payload(PrepRecSeq>0);

export Key_PrepRecSeq := INDEX(d, {PrepRecSeq}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC2::key::PrepRecSeq_' + doxie.version_superkey);
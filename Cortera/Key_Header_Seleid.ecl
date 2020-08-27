import doxie,data_services;

hdr := Cortera.Files().Base.Header.Built(seleid<>0);
EXPORT Key_Header_Seleid := INDEX(hdr, {seleid}, {hdr}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::cortera::key::hdr_seleid_' + doxie.version_superkey);

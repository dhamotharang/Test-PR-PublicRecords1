import doxie,data_services;

hdr := Cortera.Files().Base.Header.Built(ULTIMATE_LINKID<>0);
EXPORT Key_Header_UltimateId := INDEX(hdr, {ULTIMATE_LINKID}, {hdr}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::cortera::key::hdr_ultimateid_' + doxie.version_superkey);

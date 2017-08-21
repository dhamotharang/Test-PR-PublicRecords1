import doxie,data_services;

hdr := Cortera.Files.Hdr_Out(link_id<>0);
EXPORT Key_Header_Link_Id := INDEX(hdr, {link_id}, {hdr}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::cortera::key::hdr_linkid_' + doxie.version_superkey);

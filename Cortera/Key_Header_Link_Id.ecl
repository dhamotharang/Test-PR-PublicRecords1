import doxie,data_services;

hdr := Cortera.Files.Hdr_Out(link_id<>0);
EXPORT Key_Header_Link_Id := INDEX(hdr, {link_id}, {hdr}, 
				Data_Services.Data_location.Prefix('tools')+'thor_data400::key::cortera::'+ doxie.Version_SuperKey + '::hdr_linkid');

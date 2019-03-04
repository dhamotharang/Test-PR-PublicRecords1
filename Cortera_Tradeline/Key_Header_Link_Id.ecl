import doxie,data_services;

hdr := $.Files.base(link_id<>0,status<>'D');
EXPORT Key_Header_Link_Id := INDEX(hdr, {link_id,account_key,ar_date}, {hdr}, 
				Data_Services.Data_location.Prefix('tools')+'thor_data400::key::cortera_tradeline::'+ doxie.Version_SuperKey + '::tradeline_linkid');
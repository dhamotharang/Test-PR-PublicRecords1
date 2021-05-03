IMPORT doxie,data_services;

hdr_all := Cortera.Files().Base.Header.Built(link_id<>0);
hdr := 
DEDUP(
  SORT(
    DISTRIBUTE(hdr_all,HASH64(link_id)
    ),link_id,-processdate,LOCAL
  ),link_id,LOCAL
);
EXPORT Key_Header_Link_Id := INDEX(hdr, {link_id}, {hdr}, 
  Data_Services.Data_location.Prefix('tools')+'thor_data400::key::cortera::'+ doxie.Version_SuperKey + '::hdr_linkid');

import data_services, doxie;

df := project(File_IP_Metadata.Base(is_current=TRUE), IP_metadata.Layout_IP_Metadata.Base-[dt_first_seen, dt_last_seen, is_current]);

EXPORT Key_IP_Metadata_IPv4 := index(df,{beg_octet1, end_octet1, beg_octet2, end_octet2, beg_octets34, end_octets34},{df}, 
																data_services.data_location.Prefix('ip_metadata')+'thor_data400::key::ip_metadata_ipv4_'+doxie.Version_SuperKey);
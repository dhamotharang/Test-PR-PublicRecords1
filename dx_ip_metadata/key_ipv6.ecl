import dx_IP_Metadata, doxie;

df := project(dx_IP_Metadata.names.Base_ipv6(is_current=TRUE), dx_IP_Metadata.Layout_IP_Metadata.Base_ipv6-[dt_first_seen, ip_rng_beg_full, ip_rng_end_full, end_hextet1, dt_last_seen, is_current]);

EXPORT Key_IPv6 := index(df,{beg_hextet1},{df}, 
																dx_IP_Metadata.names.key_ipv6_path+'_'+doxie.Version_SuperKey);
import dx_IP_Metadata, doxie;

EXPORT Key_IPv6 := index(dx_IP_Metadata.Layout_IP_Metadata.keyed_fields,dx_IP_Metadata.Layout_IP_Metadata.Key_layout_ipv6, 
																dx_IP_Metadata.names.key_ipv6_path+'_'+doxie.Version_SuperKey);
Import dx_IP_Metadata,IP_metadata;
EXPORT Layouts := module
 
Export IP_4_layout:=record
IP_metadata.Layout_IP_Metadata.Base-[dt_first_seen, dt_last_seen, is_current];
end;
 
 Export IP_6_layout:=record
 dx_IP_Metadata.Layout_IP_Metadata.Key_layout_ipv6;
 end;

 end;

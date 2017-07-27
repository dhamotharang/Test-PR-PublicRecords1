import Fraudpoint3,Data_Services,doxie;

file_base_has_IPaddress := fraudpoint3.file_base(ip_address <> '');

export Key_ipaddress := 
       index(file_base_has_IPaddress,
             {ip_address},
						 {file_base_has_IPaddress},
						 Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::fraudpoint3::' + doxie.Version_SuperKey + '::ipaddr');
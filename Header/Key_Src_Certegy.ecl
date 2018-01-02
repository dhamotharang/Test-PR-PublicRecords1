import Certegy, data_services;

dCertegy_as_Source	:=	Certegy.As_source(,true);

mac_key_src(dCertegy_as_Source, Certegy.layouts.base, 
						certegy_child, 
						data_services.data_location.prefix() + 'thor_data400::key::certegy_src_index_',id)
						
export Key_Src_Certegy := id;
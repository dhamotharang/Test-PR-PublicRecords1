﻿import Targus, data_services;

t_in := Targus.Consumer_as_Source(,true);
mac_key_src(t_in, targus.layout_consumer_out, 
						targ_child, 
						data_services.data_location.prefix() + 'thor_data400::key::targ_src_index_',id)
						
export Key_Src_Targus := id;
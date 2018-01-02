import Transunion_PTrak, data_services;
t_in := Transunion_PTrak.Transunion_as_source(,true);
mac_key_src(t_in, Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut, 
						tran_child, 
						data_services.data_location.prefix() + 'thor_data400::key::tucs_src_index_',id)
						
export key_src_Tucs := id;
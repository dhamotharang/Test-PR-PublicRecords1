import Transunion_PTrak;
t_in := Transunion_PTrak.Transunion_as_source(,true);
mac_key_src(t_in, Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut, 
						tran_child, 
						'~thor_data400::key::tucs_src_index_',id)
						
export key_src_Tucs := id;
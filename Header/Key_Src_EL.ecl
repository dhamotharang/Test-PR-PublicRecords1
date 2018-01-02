import ExperianIRSG_Build, data_services;

dExprn_ph_as_Source	:=	ExperianIRSG_Build.ExperianIRSG_asSource(,true);

mac_key_src(dExprn_ph_as_Source, ExperianIRSG_Build.Layouts.Layout_Out, 
						Exprn_ph_child, 
						data_services.data_location.prefix() + 'thor_data400::key::exprnph_src_index_',id);
						
export Key_Src_EL := id;
import atf, data_services;

dATF_as_Source	:=	atf.ATF_as_Source(,true);

mac_key_src(dATF_as_Source, atf.layout_firearms_explosives_in, 
						atf_child, 
						data_services.data_location.prefix() + 'thor_data400::key::atf_src_index_',id)

export Key_Src_ATF := id;

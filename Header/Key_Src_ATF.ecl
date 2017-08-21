Import Data_Services, atf, data_services;

dATF_as_Source	:=	header.Files_SeqdSrc().ATF;

mac_key_src(dATF_as_Source, atf.layout_firearms_explosives_in, 
						atf_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::atf_src_index_',id)

export Key_Src_ATF := id;

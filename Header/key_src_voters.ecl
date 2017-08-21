Import Data_Services, votersv2,data_services;

dvoters_as_source	:=	header.Files_SeqdSrc().VO;

mac_key_src(dvoters_as_source, votersv2.layouts_voters.layout_voters_base, 
						voters_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::voters_src_index_',id)
						
export key_src_voters := id;
Import Data_Services, votersv2,data_services;

dcensus_UM_as_source	:=	header.Files_SeqdSrc().UM;

mac_key_src(dcensus_UM_as_source, votersv2.layouts_voters.layout_voters_base, 
						voters_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::voters_src_index_',id)
						
export key_src_census_UM := id;
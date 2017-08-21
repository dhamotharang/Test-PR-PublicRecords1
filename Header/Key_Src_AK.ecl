Import Data_Services, AK_Perm_Fund, data_services;

dAPF_as_Source	:=	header.Files_SeqdSrc().AK;

mac_key_src(dAPF_as_Source, ak_perm_fund.Layout_AK_Common, 
						ak_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::ak_src_index_',id)

export Key_Src_AK := id;


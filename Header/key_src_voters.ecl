import votersv2;

dvoters_as_source	:=	votersv2.voters_as_source(,true);

mac_key_src(dvoters_as_source, votersv2.layouts_voters.layout_voters_base, 
						voters_child, 
						'~thor_data400::key::voters_src_index_',id)
						
export key_src_voters := id;
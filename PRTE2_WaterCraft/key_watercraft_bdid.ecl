IMPORT doxie,ut,data_services;

file_base_search_dev_bdid 										:= PROJECT(_Datasets.Search,
																													 TRANSFORM(_Layouts.Search_Slim,
																																		 SELF.bdid 	:= LEFT.bdid,
																																		 SELF 			:= LEFT
																																		)
																													 );

base_file 																		:= file_base_search_dev_bdid((UNSIGNED6)bdid<>0);

base_slim 																		:= TABLE(base_file,{bdid,state_origin,watercraft_key,sequence_key});
						
base_srt 																			:= SORT(base_slim, RECORD);
base_dep 																			:= DEDUP(base_srt, RECORD);						

EXPORT key_watercraft_bdid(STRING IdxFile) 		:= INDEX(base_dep,
																												{l_bdid := (UNSIGNED6) bdid},
																												{state_origin, watercraft_key,sequence_key},
																												IdxFile);
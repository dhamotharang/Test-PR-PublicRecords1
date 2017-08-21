import doxie,ut;

base_file := watercraft.file_base_search_dev_bid((unsigned6)bdid<>0);

base_slim := table(base_file,{base_file.bdid,
                              base_file.state_origin,
						base_file.watercraft_key,base_file.sequence_key});
						
base_srt := sort(base_slim, record);
base_dep := dedup(base_srt, record);						

export key_watercraft_bid := 
       index(base_dep,
	       {l_bdid := (unsigned6) bdid},
		  {state_origin, watercraft_key,sequence_key},
            '~thor_data400::key::watercraft_bid_'+doxie.Version_SuperKey);

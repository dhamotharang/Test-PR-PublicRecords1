import doxie_files, ut, doxie, autokey;

ut.MAC_SK_BuildProcess_v2(doxie_files.key_nextones_did,
                          '~thor_data400::key::nextones_did',
                          bld_did_key);

//start nextones autokeys
f_nextones := doxie_files.file_nextones_base;

xl_nextones := RECORD
	f_nextones;
	unsigned6 fdid;
	string25 city_name;
	string2 st;
	zero := 0;
	blk := '';
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('NXTO'))| ut.bit_set(0,0);
END;

xl_nextones xpand_nexo(f_nextones le,integer nxto_cntr) :=  TRANSFORM 
     string zip_citys := ZipLib.ZipToCities(le.zip);
	SELF.fdid := nxto_cntr + autokey.did_adder('NXTO'); 
	self.city_name := map(zip_citys[1]='0' => '',
					  zip_citys[1]='1' => zip_citys[3..],
					  zip_citys[3..stringlib.StringFind(zip_citys,',',2)-1]);
	self.st := ZipLib.ZipToState2(le.zip);
	SELF := le; 
END;
DS_nxto := PROJECT(f_nextones,xpand_nexo(LEFT,COUNTER)) : PERSIST('persist::nxto_fdids');

AutoKey.MAC_Build(DS_nxto,clean_name_first,clean_name_middle,clean_name_last,
				 blk,
				 zero,
				 MSISDN,
				 blk, blk, st, city_name, ZIP, blk,
				 zero,
				 zero,zero,zero,
				 zero,zero,zero,
				 zero,zero,zero,
				 lookups,
				 fdid,
				 '~thor_data400::key::nextones_',bld_nxto_auto,false)

DS_nxto_rec := record
	unsigned6 fdid;
	f_nextones;
	string25 city_name;
	string2 st;
end;

DS_nxto_rec slim_it(DS_nxto  l) := transform
	self := l;
end;

DS_nxto_slim := project(DS_nxto, slim_it(left));

nxto_fdids_key := index(DS_nxto_slim,{fdid},{DS_nxto_slim},
                        '~thor_data400::key::nextones_fdids');

ut.MAC_SK_BuildProcess_v2(nxto_fdids_key,
                          '~thor_data400::key::nextones_fdids',
					 bld_fdids_key); 
					 
//end providers autokeys 

ut.MAC_SK_Move_v2('~thor_data400::key::nextones_did', 'Q', mv_did_key);
autokey.MAC_AcceptSK_to_QA('~thor_data400::key::nextones_',mv_autokey,false);
ut.MAC_SK_Move_v2('~thor_data400::key::nextones_fdids', 'Q', mv_fdids_key);

export proc_build_nextones_keys := sequential(parallel(bld_did_key, bld_nxto_auto, bld_fdids_key),
                                              parallel(mv_did_key, mv_autokey,mv_fdids_key));
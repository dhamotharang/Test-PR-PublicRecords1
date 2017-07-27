import doxie_build, ut, doxie;

ut.MAC_SK_BuildProcess_v2(doxie.key_watercraft_cid,
                          '~thor_data400::key::watercraft_cid', 
                          bk_cid)

ut.MAC_SK_BuildProcess_v2(doxie.key_watercraft_bdid,
                          '~thor_data400::key::watercraft_bdid', 
                          bk_bdid)

ut.MAC_SK_BuildProcess_v2(doxie.key_watercraft_did,
                          '~thor_data400::key::watercraft_did', 
                          bk_did)
								 
ut.MAC_SK_BuildProcess_v2(doxie.key_watercraft_sid,
                          '~thor_data400::key::watercraft_sid', 
                          bk_sid)

ut.MAC_SK_BuildProcess_v2(doxie.key_watercraft_wid,
                          '~thor_data400::key::watercraft_wid', 
                          bk_wid)

ut.MAC_SK_BuildProcess_v2(doxie.key_watercraft_hullnum,
                          '~thor_data400::key::watercraft_hullnum', 
                          bk_hullnum)

ut.MAC_SK_BuildProcess_v2(doxie.key_watercraft_offnum,
                          '~thor_data400::key::watercraft_offnum', 
                          bk_offnum)

ut.MAC_SK_BuildProcess_v2(doxie.key_watercraft_vslnam,
                          '~thor_data400::key::watercraft_vslnam', 
                          bk_vslnam)
								  
bk := parallel(bk_cid,bk_bdid,bk_did,bk_sid,bk_wid,bk_hullnum,bk_offnum,bk_vslnam);

export proc_build_watercraft_keys := bk;
import gong; 

export key_hhid_prep := index(gong.file_gong_hhid(hhid<>0, trim(phone10)<>''),
                             {unsigned6 s_hhid := hhid},{gong.file_gong_hhid},
                             '~thor_data400::key::gong_hhid' + thorlib.wuid());

import autokeyb2,doxie;

fakepf := dataset([],recordof(atf.file_atf_firearms_autokey_bid));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did_out6,zero,'~thor_data400::key::atf::firearms::autokey::bid::payload',plk,'');

export key_atf_payload_bid := plk;

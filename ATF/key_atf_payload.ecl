import autokeyb2,doxie;

fakepf := dataset([],recordof(atf.file_atf_firearms_autokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did_out6,zero,'~thor_data400::key::atf::firearms::autokey::payload',plk,'');

export key_atf_payload := plk;
import autokeyb2,doxie;

fakepf := dataset([],recordof(fedex.file_fedex_autokey2)-[version]);

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,'~thor_data400::key::fedex2::autokey::qa::payload',plk,'');

export key_fedex2_payload := plk;
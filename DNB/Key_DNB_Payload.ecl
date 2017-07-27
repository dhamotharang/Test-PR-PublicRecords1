import autokeyb2,doxie;

fakepf := dataset([],recordof(DNB.File_DNB_autoKey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',0,bdid,'~thor_data400::key::dnb::autokey::qa::payload',plk,'');

export Key_DNB_Payload := plk;

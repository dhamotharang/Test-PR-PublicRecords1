import autokeyb2,doxie;

fakepf := marriage_divorce_v2.file_searchautokey;
fname  := constants().ak_keyname+'payload';

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,0,fname,plk,'');

export key_mar_div_payload := plk;
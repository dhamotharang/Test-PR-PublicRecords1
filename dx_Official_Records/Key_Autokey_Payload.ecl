IMPORT $, autokeyb2;

fakepf := DATASET([], $.layouts.ak_rec);
fname  := $.names().i_ak_payload;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zeroDID,zeroBDID,fname,plk,'');

EXPORT Key_Autokey_Payload := plk;

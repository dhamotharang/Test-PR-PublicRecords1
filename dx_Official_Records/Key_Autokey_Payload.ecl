IMPORT $, autokeyb2;

fakepf := $.Constants.ak_dataset;
fname  := $.Constants.ak_keyname;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zeroDID,zeroBDID,fname,plk,'');

EXPORT Key_Autokey_Payload := plk;

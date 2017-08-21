import autokeyb2,doxie;

Layout_Prolic_AutoKeys  := Prof_LicenseV2.Layouts_ProfLic.Layout_autokeys;

fakepf := dataset([],Layout_Prolic_AutoKeys);

t := Prof_LicenseV2.Constants.bid_autokey_qa_name;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,zero,t+'Payload',plk,'')

export Key_ProfLic_Payload_Bid := plk;

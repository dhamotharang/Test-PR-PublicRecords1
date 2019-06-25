import autokeyb,doxie,header;
fakepf := dataset([],header_quick.layout_Autokey);
//integer8 FakeID := 0;
autokeyb.MAC_FID_Payload(fakepf,'','','','','','','','','',did,0,header_quick.str_AutokeyName+'Payload',plk,'',,integer8 FakeID)

export key_AutokeyPayload := plk;
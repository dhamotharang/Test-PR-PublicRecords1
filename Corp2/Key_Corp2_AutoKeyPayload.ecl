import autokeyb,doxie,Corp2,Corp2_services;

layout_autokeyready :=record
corp2_services.assorted_layouts.layout_common;
//unsigned1 seq_num_added := 0;
end;

fakepf := dataset([],layout_autokeyready);

//fakepf := liensv2.file_SearchAutokey(dataset([],LiensV2.Layout_liens_party));
autokeyb.MAC_FID_Payload(fakepf,'','','','','','','','','',0,0,'~thor_data400::key::corp2::qa::autokey::Payload',plk,'');

export Key_Corp2_AutokeyPayload := plk;


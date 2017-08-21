despray(STRING file, string server, string destination) := IF(FileServices.FileExists(file),
		fileservices.despray(file,server,destination), 
		OUTPUT('File "' + file + '" does not exist, so no despray performed'));

f1  := despray(MOXIE_KEY_THOR + 'OUT::Corp_' + Corp.Corp_Build_Date, MOXIE_DESPRAY_SERVER,MOXIE_CORP_MOUNT + 'corp2.d00');
f2  := despray(MOXIE_KEY_THOR + 'OUT::Corp_Event_' + Corp.Corp_Build_Date, MOXIE_DESPRAY_SERVER,MOXIE_CORP_MOUNT + 'corp2_events.d00');
f3  := despray(MOXIE_KEY_THOR + 'OUT::Corp_Supp_' + Corp.Corp_Build_Date, MOXIE_DESPRAY_SERVER,MOXIE_CORP_MOUNT + 'corp2_supp.d00');
f4  := despray(MOXIE_KEY_THOR + 'OUT::Corp_Cont_' + Corp.Corp_Build_Date, MOXIE_DESPRAY_SERVER,MOXIE_CORP_MOUNT + 'corp2_cont.d00');


export Despray_Corp_Out_Files := sequential(f2,f3);
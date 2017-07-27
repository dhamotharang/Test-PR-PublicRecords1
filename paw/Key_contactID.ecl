import  RoxieKeyBuild,ut,autokey,doxie, header_services, BIPV2;

KeyName       := cluster.cluster_out+'Key::PAW::';
dBase 	  	  := paw.File_base_cleanAddr_keybuild;
File_To_Process_To_Key_	:= File_keybuild(dBase)(contact_id > 0);
File_To_Process_To_Key := project(File_To_Process_To_Key_, {recordof(File_To_Process_To_Key_), BIPV2.IDlayouts.l_xlink_ids});

dSort         := sort(distribute(File_To_Process_To_Key,Hash(contact_id)),contact_id,local);

export Key_contactID := INDEX(dSort ,{contact_id},{dSort},KeyName+doxie.Version_SuperKey+'::contactid');

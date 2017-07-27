IMPORT  RoxieKeyBuild,ut,autokey,doxie, header_services;

KeyName       	:= cluster.cluster_out+'Key::PAW::';
dBase 	      	:= paw.File_base_cleanAddr_keybuild(Bdid>0);
File_To_Process_To_Key	:= File_keybuild(dBase)(Bdid>0);

dSlim		  := TABLE(File_To_Process_To_Key, {Bdid,contact_id});
dDist         := DISTRIBUTE(dSlim,hash(Bdid,contact_id)); 
dSort         := SORT(dDist, Bdid,contact_id,local);
dDedup        := DEDUP(DSort ,Bdid,contact_id,local);

export Key_BDID := INDEX(dDedup  ,{Bdid},{contact_id},KeyName+doxie.Version_SuperKey+'::Bdid');


import  RoxieKeyBuild,ut,autokey,doxie, header_services;

KeyName       := cluster.cluster_out+'Key::pAW::';
dBase 	      := paw.File_base_cleanAddr_keybuild(did>0);

File_To_Process_To_Key	:= File_keybuild(dBase)(did>0);

dSlim		  := TABLE(File_To_Process_To_Key, {did,contact_id});
dDist         := distribute(dSlim,hash(did,contact_id)); 
dSort         := sort(dDist, did,contact_id,local);
dDedup        := dedup(DSort ,did,contact_id,local);

EXPORT Key_DID := INDEX(dDedup  ,{did},{contact_id},KeyName +doxie.Version_SuperKey+'::did');

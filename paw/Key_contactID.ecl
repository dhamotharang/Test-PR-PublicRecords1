import  RoxieKeyBuild,ut,autokey,doxie, header_services, BIPV2;

KeyName       := cluster.cluster_out+'Key::PAW::';
dBase 	  	  := paw.File_base_cleanAddr_keybuild;
dbaseBIP			:=	distribute(File_keybuild_BIPv2(PAW.File_base_CleanAddr_Keybuild_BIPv2)(contact_id > 0),hash(contact_id));

File_To_Process_To_Key_	:= File_keybuild(dBase)(contact_id > 0);
File_To_Process_To_Key 	:= distribute(project(File_To_Process_To_Key_, {recordof(File_To_Process_To_Key_), BIPV2.IDlayouts.l_xlink_ids}),hash(contact_id));

recordof(File_To_Process_To_Key) JoinForLinkIds	(File_To_Process_To_Key l, dbaseBip r)	:=	transform
	self	:=	r;
	self	:=	l;
end;

JoinedForLinks	:=	join(	File_To_Process_To_Key,
													dbaseBIP,
													left.contact_id = right.contact_id,
													JoinForLinkIds(left,right),
													left outer,
													local);

dSort         	:= sort(JoinedForLinks,contact_id,local);

export Key_contactID := INDEX(dSort ,{contact_id},{dSort},KeyName+doxie.Version_SuperKey+'::contactid');
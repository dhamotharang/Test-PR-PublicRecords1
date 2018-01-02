import doxie,data_services;

in_base  := Txbus.File_Txbus_Base_For_Keys(bdid <> 0);

dis_base := distribute(in_base, hash64(bdid));

deduped_base := dedup(sort(dis_base, bdid, taxpayer_number, local), bdid, taxpayer_number, local);			   

export Key_Txbus_BDID := index(deduped_base,
							   {bdid},
							   {bdid, Taxpayer_Number},
							   data_services.data_location.prefix() + 'thor_data400::key::txbus::'+doxie.Version_SuperKey+'::bdid');

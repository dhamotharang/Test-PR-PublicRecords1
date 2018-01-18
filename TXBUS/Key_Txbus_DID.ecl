import doxie,data_services;

in_base  := Txbus.File_Txbus_Base_For_Keys(did <> 0);

dis_base := distribute(in_base, hash64(did));

deduped_base := dedup(sort(dis_base, did, Taxpayer_Number, local), did, Taxpayer_Number, local);

export Key_Txbus_DID := index(deduped_base,
							  {did},
							  {did, Taxpayer_Number},
							  data_services.data_location.prefix() + 'thor_data400::key::txbus::'+doxie.Version_SuperKey+'::did');

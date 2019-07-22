import doxie,data_services, vault, _control;
in_file := Targus.File_targus_key_building(prim_name!='' and zip!='');



#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_Targus_fcra_Address := vault.Targus.Key_Targus_fcra_address;
#ELSE
export Key_Targus_fcra_Address := index(in_file,{prim_name, zip, prim_range, sec_range, predir, suffix}
						,{in_file},data_services.data_location.prefix() + 'thor_data400::key::targus::fcra::' + doxie.Version_SuperKey + '::address');


#END;



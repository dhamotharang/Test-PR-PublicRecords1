import doxie,data_services, vault, _control;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_AID_Base := vault.AID_Build.Key_AID_Base;  
#ELSE
export Key_AID_Base := index(build_base,{rawaid},{build_base},
			Data_Services.Data_location.prefix('aid_build')+
			'thor_data400::key::AID::RawAID_to_ACECahe_'+doxie.Version_SuperKey);
#END;



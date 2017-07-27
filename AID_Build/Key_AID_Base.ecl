import doxie,data_services;

export Key_AID_Base := index(build_base,{rawaid},{build_base},
			Data_Services.Data_location.prefix('aid_build')+
			'thor_data400::key::AID::RawAID_to_ACECahe_'+doxie.Version_SuperKey);
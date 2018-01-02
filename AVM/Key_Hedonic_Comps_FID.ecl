import doxie, ut, data_services;

f := avm.File_Hedonic_Comps('');

export Key_Hedonic_Comps_FID := index(f,{ln_fares_id},{f},
		data_services.data_location.prefix() + 'thor_data400::key::avm::' + doxie.Version_SuperKey+'::comp_fid');
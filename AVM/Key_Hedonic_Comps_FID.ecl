import doxie, ut;

f := avm.File_Hedonic_Comps('');

export Key_Hedonic_Comps_FID := index(f,{ln_fares_id},{f},
		'~thor_data400::key::avm::' + doxie.Version_SuperKey+'::comp_fid');
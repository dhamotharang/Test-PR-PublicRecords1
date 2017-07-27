Import Data_Services, doxie, ut;

f := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::base::avm_v2_comps',avm_v2.layouts.layout_hedonic_base,thor);

export Key_Hedonic_Comps_FID := index(f,{ln_fares_id},{f},
		Data_Services.Data_location.Prefix('avm')+'thor_data400::key::avm_v2::' + doxie.Version_SuperKey+'::comp_fid');
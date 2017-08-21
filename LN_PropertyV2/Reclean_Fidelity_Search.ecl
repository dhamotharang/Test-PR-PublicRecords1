ds := LN_PropertyV2.Reclean_Concat;

ds_fidelity_filter	:= ds(ln_fares_id[1] <> 'R');

ds_fidelity_out		:= output(ds_fidelity_filter,,'~thor_data400::in::ln_propertyv2::search_fidelity_reclean', __compressed__, overwrite);

export Reclean_Fidelity_Search := ds_fidelity_out;
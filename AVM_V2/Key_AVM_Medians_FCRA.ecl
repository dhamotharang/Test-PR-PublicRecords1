Import Data_Services, doxie;

// filter out any records that don't have at least fips level median, state level doesn't make sense to keep
f := AVM_V2.File_AVM_Medians_Base(length( trim((string)fips_geo_12) ) >= 5);

export Key_AVM_Medians_FCRA := index(f,
             {fips_geo_12},
		    {f},
			Data_Services.Data_location.Prefix('avm')+'thor_data400::key::avm_v2::fcra::' + doxie.Version_SuperKey+'::medians');
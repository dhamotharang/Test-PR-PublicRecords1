Import Data_Services, doxie, vault, _control;

// filter out any records that don't have at least fips level median, state level doesn't make sense to keep
f := AVM_V2.File_AVM_Medians_Base(length( trim((string)fips_geo_12) ) >= 5);


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_AVM_Medians_FCRA := vault.AVM_V2.Key_AVM_Medians_FCRA;
#ELSE
export Key_AVM_Medians_FCRA := index(f,
             {fips_geo_12},
		    {f},
			Data_Services.Data_location.Prefix('avm')+'thor_data400::key::avm_v2::fcra::' + doxie.Version_SuperKey+'::medians');
#END;



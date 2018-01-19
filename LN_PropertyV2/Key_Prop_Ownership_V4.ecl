import doxie,Data_Services;

boolean filter_fares := false;
prop := File_Property_Ownership_V4(filter_fares);

export Key_Prop_Ownership_V4 := index(Prop, {did}, {Prop},
																			Data_Services.Data_location.Prefix('Property')+'thor_data400::key::ln_propertyV2::'+doxie.Version_SuperKey+'::did.ownership_v4');
import doxie,Data_Services;

boolean filter_fares := true;
prop := File_Property_Ownership_v4(filter_fares);

export Key_Prop_Ownership_V4_No_Fares := index(Prop, {did}, {Prop},
																			Data_Services.Data_location.Prefix('Property')+'thor_data400::key::ln_propertyV2::'+doxie.Version_SuperKey+'::did.ownership_v4_no_fares');
Import Data_Services, doxie,LN_PropertyV2_Fast;

export Key_Prop_Ownership_V4(boolean isFast) := FUNCTION

boolean filter_fares := false;
prop := LN_PropertyV2_Fast.File_Property_Ownership_V4(filter_fares,isFast);

keyPrefix := LN_PropertyV2_Fast.FileNames.fullKeyBuildPrefix;

RETURN index(Prop, {did}, {Prop},
																			Constants.keyServerPointer+'thor_data400::key::'+keyPrefix+'::'+doxie.Version_SuperKey+'::did.ownership_v4');
END;
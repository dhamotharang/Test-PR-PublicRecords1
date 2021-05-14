Import LN_PropertyV2,LN_PropertyV2_Fast,Data_Services, doxie, ln_property,ut;

export key_addl_fares_deed_fid(boolean isFast = false) := FUNCTION

keyPrefix := if (isFast, 'property_fast','ln_propertyv2');
addl_fares_deed := if (isFast,LN_PropertyV2_Fast.Files.basedelta.addl_frs_d,LN_PropertyV2.File_addl_fares_deed); // DF-27847 basedelta

file_in := addl_fares_deed(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);

return 

index(file_in,
      {ln_fares_id},
			{file_in},
      Constants.keyServerPointer+'thor_data400::key::'+keyPrefix+'::'+doxie.Version_SuperKey+'::addlfaresdeed.fid'
			);
	 
END;
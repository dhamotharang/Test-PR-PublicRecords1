Import LN_PropertyV2,LN_PropertyV2_Fast,Data_Services, doxie, ln_property, ut;

export key_addl_fares_tax_fid(boolean isFast = false) := FUNCTION

keyPrefix := if (isFast, 'property_fast','ln_propertyv2');

addl_fares_assessment := if (isFast,LN_PropertyV2_Fast.Files.basedelta.addl_frs_a,LN_PropertyV2.File_addl_fares_tax);

file_in := addl_fares_assessment(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);

return

index(file_in,
      {ln_fares_id},
			{file_in},	  
      Constants.keyServerPointer+'thor_data400::key::'+keyPrefix+'::'+doxie.Version_SuperKey+'::addlfarestax.fid'
			);
			
END;
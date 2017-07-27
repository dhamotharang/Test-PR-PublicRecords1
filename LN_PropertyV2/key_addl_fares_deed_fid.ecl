import doxie, ln_property,ut;

file_in := LN_PropertyV2.File_addl_fares_deed(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);
				   
export key_addl_fares_deed_fid := 

index(file_in,
      {ln_fares_id},
			{file_in},	  
      '~thor_data400::key::ln_propertyv2::'+doxie.Version_SuperKey+'::addlfaresdeed.fid'
	 );
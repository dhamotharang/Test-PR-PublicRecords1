import doxie, ln_property, ut;

file_in := LN_PropertyV2.File_addl_Fares_tax(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);
				   
export key_addl_fares_tax_fid := 

index(file_in,
      {ln_fares_id},
			{file_in},	  
      '~thor_data400::key::ln_propertyv2::'+doxie.Version_SuperKey+'::addlfarestax.fid'
			);
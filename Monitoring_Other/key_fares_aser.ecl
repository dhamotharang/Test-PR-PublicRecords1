import doxie, ln_property, LN_PropertyV2, ut;

file_in := LN_PropertyV2.File_addl_Fares_tax;
				   
export key_fares_aser := 

index(file_in,
      {ln_fares_id},
	    {file_in},	  
      ut.foreign_prod + 'thor_data400::key::ln_propertyv2::'+doxie.Version_SuperKey+'::addlfarestax.fid'
	    );
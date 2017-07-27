Import Data_Services, emerges,doxie, ut;

export key_hunters_did(boolean  IsFCRA = false) := function

		// This attribute was modified to use the same keybuild logic as the build process does. Additionally, this attribute is replacing the 
		// old key building attribute (emerges.key_prep_hunters_did) in the eMerges.proc_build_key attribute.
		
		key_name := if(isFCRA, 
									 'thor_Data400::key::hunters_doxie_did_fcra_',
									 'thor_Data400::key::hunters_doxie_did_'
									 );
									 
	  return_file		:= index(emerges.file_hunters_keybuild((integer)did_out != 0),{UNSIGNED8 did := (UNSIGNED8) did_out}, {emerges.file_hunters_keybuild},
														Data_Services.Data_location.Prefix('Emerges')+ key_name + doxie.Version_SuperKey);
														
		return(return_file);

end;
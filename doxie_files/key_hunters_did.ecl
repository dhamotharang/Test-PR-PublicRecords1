Import Data_Services, emerges,doxie, ut;

export key_hunters_did(boolean  IsFCRA = false) := function

		// This attribute was modified to use the same keybuild logic as the build process does. Additionally, this attribute is replacing the 
		// old key building attribute (emerges.key_prep_hunters_did) in the eMerges.proc_build_key attribute.
     dBase := emerges.fBuild_Key_Hunters_DID(IsFCRA);		
    
		key_name := if(isFCRA, 
									 'thor_Data400::key::hunters_doxie_did_fcra_',
									 'thor_Data400::key::hunters_doxie_did_'
									 );
									 
	  return_file		:= index(dBase,{UNSIGNED8 did := (UNSIGNED8) did_out}, {dBase},
														Data_Services.Data_location.Prefix('Emerges')+ key_name + doxie.Version_SuperKey);
														
		return(return_file);

end;
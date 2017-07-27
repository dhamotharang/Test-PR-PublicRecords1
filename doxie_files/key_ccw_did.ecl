Import Data_Services, emerges,doxie,ut;

export Key_ccw_did(boolean  IsFCRA = false) := function

		// This attribute was modified to use the same keybuild logic as the build process does. Additionally, this attribute is replacing the 
		// old key building attribute (emerges.key_prep_ccw_did) in the eMerges.proc_build_key attribute.

	  return_file		:= IF (IsFCRA
												,index(eMerges.file_ccw_keybuild((integer)did_out != 0),{UNSIGNED8 did := (UNSIGNED8) did_out},{eMerges.file_ccw_keybuild},
																Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::ccw_doxie_did_fcra_' + doxie.Version_SuperKey)
												,index(eMerges.file_ccw_keybuild((integer)did_out != 0),{UNSIGNED8 did := (UNSIGNED8) did_out},{eMerges.file_ccw_keybuild},
																Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::ccw_doxie_did_' + doxie.Version_SuperKey)
												 );
		return(return_file);

end;
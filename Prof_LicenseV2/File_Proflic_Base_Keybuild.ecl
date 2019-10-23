import ut;

original_Layout_Base_With_Tiers := RECORD
  Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers - [xadl2_weight, xadl2_score, xadl2_distance,
	                                                         xadl2_keys_used, xadl2_keys_desc, xadl2_matches,
																													 xadl2_matches_desc];
END;

tempLayout := RECORD
	original_Layout_Base_With_Tiers - lnpid;
	unsigned6	temp_DID;
end;


tempLayout trfTempLayout(Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers input)	:= transform
	self.temp_did	:= (integer)input.did;
	self					:= input;
end;
 
 
tempBase	:= project(Prof_LicenseV2.File_Proflic_Base_Tiers, trfTempLayout(left));


ut.mac_suppress_by_phonetype(tempbase,Phone,St,phone_suppression,true,temp_did);	

	
{original_Layout_Base_With_Tiers - lnpid}  trfBaseLayout(tempLayout input)	:= transform
	self								:= input;
end;
 
Base	:= project(phone_suppression, trfBaseLayout(left));		

export File_Proflic_Base_Keybuild := base : persist('~thor_dell400::persist::proflic_base_keybuild');


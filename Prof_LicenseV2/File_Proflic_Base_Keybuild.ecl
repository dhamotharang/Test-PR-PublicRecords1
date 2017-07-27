import ut;

tempLayout := RECORD
	Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers - lnpid;
	unsigned6	temp_DID;
end;


tempLayout trfTempLayout(Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers input)	:= transform
	self.temp_did	:= (integer)input.did;
	self					:= input;
end;
 
 
tempBase	:= project(Prof_LicenseV2.File_Proflic_Base_Tiers, trfTempLayout(left));


ut.mac_suppress_by_phonetype(tempbase,Phone,St,phone_suppression,true,temp_did);	

	
{Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers - lnpid}  trfBaseLayout(tempLayout input)	:= transform
	self								:= input;
end;
 
Base	:= project(phone_suppression, trfBaseLayout(left));		

export File_Proflic_Base_Keybuild := base : persist('~thor_dell400::persist::proflic_base_keybuild');


EXPORT Files := module

	export base 			:= dataset([], layouts.keybuild);
	export ncpdp 			:= dataset([], layouts.ncpdp);
	export linkids		:= dataset([], layouts.linkids);
	export final_base := dataset([], layouts.combined_file);


//autokey files
		Layouts.Slim_Autokey_All slim_keybuild_ContLegalMail(Layouts.Keybuild L) := TRANSFORM
		SELF.first_name          := L.contact_first_name;
		SELF.middle_initial      := L.contact_middle_initial;
		SELF.last_name           := L.contact_last_name;
		SELF.phone               := L.contact_phone;
	  SELF.business_name       := L.legal_business_name;
		SELF.fein                := L.federal_tax_id;
		SELF.business_phone      := L.phys_loc_phone;
		SELF.business_prim_name  := L.Mail_prim_name;
		SELF.business_prim_range := L.Mail_prim_range;
		SELF.business_st         := L.Mail_state;
		SELF.business_city       := L.Mail_v_city_name;
		SELF.business_zip        := L.Mail_zip5;
		SELF.business_sec_range  := L.Mail_sec_range;
		
		SELF := L;
		SELF := [];
	END;
	
	export autokey_ContLegalMail := PROJECT(base, slim_keybuild_ContLegalMail(LEFT));

Layouts.Slim_Autokey_All slim_keybuild_ContLegalPhys(Layouts.Keybuild L) := TRANSFORM
		SELF.first_name          := L.contact_first_name;
		SELF.middle_initial      := L.contact_middle_initial;
		SELF.last_name           := L.contact_last_name;
		SELF.phone               := L.contact_phone;
	  SELF.business_name       := L.legal_business_name;
		SELF.fein                := L.federal_tax_id;
		SELF.business_phone      := L.phys_loc_phone;
		SELF.business_prim_name  := L.Phys_prim_name;
		SELF.business_prim_range := L.Phys_prim_range;
		SELF.business_st         := L.Phys_state;
		SELF.business_city       := L.Phys_v_city_name;
		SELF.business_zip        := L.Phys_zip5;
		SELF.business_sec_range  := L.Phys_sec_range;
		
		SELF := L;
		SELF := [];
	END;
 
	export autokey_ContLegalPhys := PROJECT(base, slim_keybuild_ContLegalPhys(LEFT));
	
	Layouts.Slim_Autokey_Business slim_keybuild_DBAMail(Layouts.Keybuild L) := TRANSFORM
	  SELF.business_name       := L.DBA;
		SELF.fein                := L.federal_tax_id;
		SELF.business_phone      := L.phys_loc_phone;
		SELF.business_prim_name  := L.Mail_prim_name;
		SELF.business_prim_range := L.Mail_prim_range;
		SELF.business_st         := L.Mail_state;
		SELF.business_city       := L.Mail_v_city_name;
		SELF.business_zip        := L.Mail_zip5;
		SELF.business_sec_range  := L.Mail_sec_range;
		
		SELF := L;
		SELF := [];
	END;

	export autokey_DBAMail := PROJECT(base, slim_keybuild_DBAMail(LEFT));
	
	
	Layouts.Slim_Autokey_Business slim_keybuild_DBAPhys(Layouts.Keybuild L) := TRANSFORM
	  SELF.business_name       := L.DBA;
		SELF.fein                := L.federal_tax_id;
		SELF.business_phone      := L.phys_loc_phone;
		SELF.business_prim_name  := L.Phys_prim_name;
		SELF.business_prim_range := L.Phys_prim_range;
		SELF.business_st         := L.Phys_state;
		SELF.business_city       := L.Phys_v_city_name;
		SELF.business_zip        := L.Phys_zip5;
		SELF.business_sec_range  := L.Phys_sec_range;
		
		SELF := L;
		self := [];
		
	END;

	export autokey_DBAPhys := PROJECT(base, slim_keybuild_DBAPhys(LEFT));

end;	
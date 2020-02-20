import standard, ut, doxie; 

export file_SearchAutokey(
	
	dataset(Layout.Employment_Out) pBase = PAW.File_base_CleanAddr_Keybuild

) := function
			
	rec := record
		Layout.Employment_Out.company_name	; 	
		Layout.Employment_Out.contact_id	;
		Layout.Employment_Out.ssn			;
		Layout.Employment_Out.company_fein	;
		Layout.Employment_Out.company_phone	;
		Layout.Employment_Out.did			;
		Layout.Employment_Out.phone			;
		Layout.Employment_Out.bdid			;
		Standard.L_Address.base Bus_addr   	;
		Standard.L_Address.base person_addr	;
		standard.name person_name			;
		unsigned1 zero 					:= 0;
		// The below 2 fields are added for CCPA (California Consumer Protection Act) project enhancements - JIRA# CCPA-111
		unsigned4 global_sid := 0;
		unsigned8 record_sid := 0;
	end;


	Rec tranBC(Layout.Employment_Out  pInput) 
	 := transform
		self.DID 						:= pInput.DID;
		self.BDID 						:= pInput.BDID;
		self.company_name 					:= pInput.company_name;
		SELF.Bus_addr.prim_range		:= pinput.company_prim_range;
		SELF.Bus_addr.predir			:= pinput.company_predir;
		SELF.Bus_addr.prim_name			:= pinput.company_prim_name;
		SELF.Bus_addr.addr_suffix		:= pinput.company_addr_suffix;
		SELF.Bus_addr.postdir			:= pinput.company_postdir;
		SELF.Bus_addr.unit_desig		:= pinput.company_unit_desig;
		SELF.Bus_addr.sec_range			:= pinput.company_sec_range;
		SELF.Bus_addr.p_city_name		:= pinput.company_city;
		SELF.Bus_addr.v_city_name		:= '';
		SELF.Bus_addr.st				:= pinput.company_state;
		SELF.Bus_addr.zip5				:= pinput.company_zip;
		SELF.Bus_addr.zip4				:= pinput.company_zip4;
		SELF.Bus_addr.fips_state		:= '';
		SELF.Bus_addr.fips_county		:= '';
		SELF.Bus_addr.addr_rec_type		:= '';
		self.person_addr 				:= pInput;
		self.person_addr.st		  := pInput.state;
		self.person_addr.v_city_name := pInput.city;
		self.person_addr.p_city_name := '';
		self.person_addr.zip5 := pInput.zip;
		self.person_addr.fips_state := '';
		self.person_addr.fips_county := pInput.county;
		self.person_addr.addr_rec_type := pInput.record_type;
		self.person_name 				:= pInput;
		self.Person_name.name_score      := '';
		self 							:= pInput;
	end;


	File_To_Process_To_Key	:= File_keybuild(pBase);
	b := PROJECT(File_To_Process_To_Key,tranBC(LEFT));

	return B;
	
end;

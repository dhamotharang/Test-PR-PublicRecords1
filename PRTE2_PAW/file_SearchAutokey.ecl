import standard, ut, doxie; 

export file_SearchAutokey(dataset(Layouts.Employment_Out) pBase = Files.file_Employment_Out) := function
			
	Layouts.AutoKeyLayout tranBC(Layouts.Employment_Out  pInput)  := transform
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

	b := PROJECT(pBase,tranBC(LEFT));

	return B;
	
end;

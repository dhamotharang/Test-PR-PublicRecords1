import standard, ut, doxie; 

export file_SearchAutokey(dataset(Layout.Employment_Out) paw_files = dataset([],Layout.Employment_Out)
						 ) := function;
			
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
	self.person_addr 				:= [];
	self.person_name 				:= pInput;
	self.Person_name                := [];
	self 							:= pInput;
end;



b := PROJECT(paw_files,tranBC(LEFT));

return B;
end;
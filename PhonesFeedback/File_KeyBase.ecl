import PhonesFeedback;

export File_KeyBase(string filedate, string1 BuildType) := module

	shared base := if(BuildType = 'F',
											PhonesFeedback.File_PhonesFeedback_base,
											dataset(PhonesFeedback.Cluster + 'base::PhonesFeedback_'+filedate,PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base,thor)
										);
					 

	export PhoneBase := base((integer)phone_number <> 0);	
	
	AddrBase := base((integer)phone_number <> 0 AND (integer)trim(phone_number)[1..3] <> 0 AND 
									(unsigned)street_number <> 0 AND trim(street_name) <> '' AND trim(zip5) <> '');	
									
	phonesFeedback.Layouts_PhonesFeedback.layoutPhonesFeedbackAddress cleanAddrBase(AddrBase le) := TRANSFORM
		self.fname				:= stringLib.stringToUpperCase(trim(le.fname));
		self.mname				:= stringLib.stringToUpperCase(trim(le.mname));
		self.lname				:= stringLib.stringToUpperCase(trim(le.lname));
		self.Prim_Range		:= trim(le.street_number);
		self.Predir				:= stringLib.stringToUpperCase(trim(le.street_pre_direction));
		self.Prim_Name		:= stringLib.stringToUpperCase(trim(le.street_name));
		self.Addr_Suffix	:= stringLib.stringToUpperCase(trim(le.street_suffix));
		self.Postdir			:= stringLib.stringToUpperCase(trim(le.street_post_direction));
		self.Unit_Desig		:= trim(le.unit_designation);
		self.Sec_Range		:= trim(le.unit_number);
		self.Zip5					:= trim(le.Zip5);
		self.Zip4					:= trim(le.Zip4);
		self							:= le;
	end;

	export AddressBase := PROJECT(AddrBase, cleanAddrBase(left));
	
	DID_Base := base (trim(phone_number) NOT IN ['0', ''] AND trim(phone_number)[1..3] <> '000' AND DID <> 0);	
									
	phonesFeedback.Layouts_PhonesFeedback.layoutPhonesFeedbackDID cleanDIDBase(DID_Base le) := TRANSFORM
		self.fname				:= stringLib.stringToUpperCase(trim(le.fname));
		self.mname				:= stringLib.stringToUpperCase(trim(le.mname));
		self.lname				:= stringLib.stringToUpperCase(trim(le.lname));
		self.Prim_Range		:= trim(le.street_number);
		self.Predir				:= stringLib.stringToUpperCase(trim(le.street_pre_direction));
		self.Prim_Name		:= stringLib.stringToUpperCase(trim(le.street_name));
		self.Addr_Suffix	:= stringLib.stringToUpperCase(trim(le.street_suffix));
		self.Postdir			:= stringLib.stringToUpperCase(trim(le.street_post_direction));
		self.Unit_Desig		:= trim(le.unit_designation);
		self.Sec_Range		:= trim(le.unit_number);
		self.Zip5					:= trim(le.Zip5);
		self.Zip4					:= trim(le.Zip4);
		self							:= le;
	end;

	export DIDBase := PROJECT(DID_Base, cleanDIDBase(left));
	
end;	
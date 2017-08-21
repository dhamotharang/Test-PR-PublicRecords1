import ut,address,idl_header;
export Prep_File(
	 dataset(Layouts.Input.Sprayed	)	pSprayedFile
	,string														pPersistname	= persistnames().PrepFile
) :=
function
	dStandardizedName := project(pSprayedFile	,transform(
		layouts.base,
			assembled_name 					:=					trim(left.Lname	)
																+ ', '	+	trim(left.Fname )
																;                
			clean_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;
			self.rawfields									:= left;
			self.clean_phones.Phone_Home		:= ut.CleanPhone(left.Phone					);			
			self.clean_phones.Phone_Work		:= ''																				;			
			self.clean_name									:= clean_name															 ;
			self.rid												:= counter;
			self 														:= [];
	
	));
	ut.mac_flipnames(dStandardizedName, clean_name.fname, clean_name.mname, clean_name.lname, dStandardizedName_flipnames)
	dStandardizedName_flipnames_persist := dStandardizedName_flipnames : persist(pPersistname);
	
	return dStandardizedName_flipnames;
end;

import ut,address,idl_header;
export Standardize_Contacts(

	dataset(Layouts.Base.contacts	)	pBaseContacts

) :=
function

		Layouts.Base.contacts tStandardizeName(Layouts.Base.contacts l) :=
		transform
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Clean Name, determine if it is a person
		//////////////////////////////////////////////////////////////////////////////////////
		assembled_name 					:=					trim(l.rawfields.exec_last_name				)
															+ ', ' + 	trim(l.rawfields.exec_first_name			)
															+					trim(l.rawfields.exec_middle_initial	)
															;                

		clean_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;

																																		
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////
		self.clean_name									:= clean_name	;

		self														:= l									;
	end;

	dStandardizedName := project(pBaseContacts, tStandardizeName(left));
	
	ut.mac_flipnames(dStandardizedName, clean_name.fname, clean_name.mname, clean_name.lname, dStandardizedName_flipnames)

	return dStandardizedName_flipnames;
	
end;
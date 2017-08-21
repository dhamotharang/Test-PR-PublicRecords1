import ut,address,idl_header;

export Prep_Input(

	 string										pversion
	,dataset(Layouts.Input	)	pInputFile	= files().input.using

) :=
function

		Layouts.Base tStandardizeName(Layouts.Input l) :=
		transform
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Clean Name, determine if it is a person
		//////////////////////////////////////////////////////////////////////////////////////
		assembled_name 					:=					trim(l.Last_Name		)
															+ ', ' + 	trim(l.First_Name		)
															+	' '	 +	trim(l.Middle_Name	)
															;                

		clean_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;

																																		
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////
		self.clean_name									:= clean_name	;
		SELF.Date_First_Seen 						:= (unsigned4)pversion[1..8];			//no date field in record, so have to use version passed in, which 
		SELF.Date_Last_Seen  						:= SELF.Date_First_Seen;//should be the receiving date
		SELF.Date_Vendor_First_Reported	:= (unsigned4)pversion[1..8];
		SELF.Date_Vendor_Last_Reported	:= SELF.Date_Vendor_First_Reported;
		SELF.rawfields.Row_ID						:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Row_ID)), LEFT, RIGHT);
		SELF.rawfields.Company_Name			:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Company_Name)), LEFT, RIGHT);
		SELF.rawfields.Web_Address			:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Web_Address)), LEFT, RIGHT);
		SELF.rawfields.Prefix 					:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Prefix)), LEFT, RIGHT);
		SELF.rawfields.Contact_Name			:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Contact_Name)), LEFT, RIGHT);
		SELF.rawfields.First_Name				:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.First_Name)), LEFT, RIGHT);
		SELF.rawfields.Middle_Name			:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Middle_Name)), LEFT, RIGHT);
		SELF.rawfields.Last_Name				:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Last_Name)), LEFT, RIGHT);
		SELF.rawfields.Title						:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Title)), LEFT, RIGHT);
		SELF.rawfields.Address					:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Address)), LEFT, RIGHT);
		SELF.rawfields.Address1					:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Address1)), LEFT, RIGHT);
		SELF.rawfields.City							:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.City)), LEFT, RIGHT);
		SELF.rawfields.State						:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.State)), LEFT, RIGHT);
		SELF.rawfields.Zip_Code					:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Zip_Code)), LEFT, RIGHT);
		SELF.rawfields.Country					:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Country)), LEFT, RIGHT);
		SELF.rawfields.Phone_Number			:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Phone_Number)), LEFT, RIGHT);
		SELF.rawfields.Email						:= TRIM(StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Email)), LEFT, RIGHT);
		self														:= l									;
		self 														:= [];
	end;

	dStandardizedName := project(pInputFile, tStandardizeName(left));
	
	ut.mac_flipnames(dStandardizedName, clean_name.fname, clean_name.mname, clean_name.lname, dStandardizedName_flipnames)

	return dStandardizedName_flipnames;
	
end;
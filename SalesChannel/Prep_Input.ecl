import ut,address,idl_header, NID;

export Prep_Input(

	 string										pversion
	,dataset(Layouts.Input	)	pInputFile	= files().input.using

) :=
function
																			
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Base tCleanFields(pInputFile L) := TRANSFORM
		SELF.Date_First_Seen 						:= (unsigned4)pversion[1..8];			//no date field in record, so have to use version passed in, which 
		SELF.Date_Last_Seen  						:= SELF.Date_First_Seen;//should be the receiving date
		SELF.Date_Vendor_First_Reported	:= (unsigned4)pversion[1..8];
		SELF.Date_Vendor_Last_Reported	:= SELF.Date_Vendor_First_Reported;
		SELF.rawfields.Row_ID						:= ut.CleanSpacesAndUpper(l.Row_ID);
		SELF.rawfields.Company_Name			:= ut.CleanSpacesAndUpper(l.Company_Name);
		SELF.rawfields.Web_Address			:= ut.CleanSpacesAndUpper(l.Web_Address);
		SELF.rawfields.Prefix 					:= ut.CleanSpacesAndUpper(l.Prefix);
		SELF.rawfields.Contact_Name			:= ut.CleanSpacesAndUpper(l.Contact_Name);
		SELF.rawfields.First_Name				:= ut.CleanSpacesAndUpper(l.First_Name);
		SELF.rawfields.Middle_Name			:= ut.CleanSpacesAndUpper(l.Middle_Name);
		SELF.rawfields.Last_Name				:= ut.CleanSpacesAndUpper(l.Last_Name);
		SELF.rawfields.Title						:= ut.CleanSpacesAndUpper(l.Title);
		SELF.rawfields.Address					:= ut.CleanSpacesAndUpper(l.Address);
		SELF.rawfields.Address1					:= ut.CleanSpacesAndUpper(l.Address1);
		SELF.rawfields.City							:= ut.CleanSpacesAndUpper(l.City);
		SELF.rawfields.State						:= ut.CleanSpacesAndUpper(l.State);
		SELF.rawfields.Zip_Code					:= ut.CleanSpacesAndUpper(l.Zip_Code);
		SELF.rawfields.Country					:= ut.CleanSpacesAndUpper(l.Country);
		SELF.rawfields.Phone_Number			:= ut.CleanSpacesAndUpper(l.Phone_Number);
		SELF.rawfields.Email						:= ut.CleanSpacesAndUpper(l.Email);
		self														:= l;
		self 														:= [];
	end;

	dPopFields := project(pInputFile, tCleanFields(left));
	
			//////////////////////////////////////////////////////////////////////////////////////
		// -- Clean Name, determine if it is a person
		//////////////////////////////////////////////////////////////////////////////////////
	NID.Mac_CleanParsedNames(dPopFields, FileClnName, 
													rawfields.First_Name, rawfields.Last_Name
													,rawfields.Middle_Name, clean_name.name_suffix
													,includeInRepository:=false, normalizeDualNames:=false, useV2 := true);
	
	//Name flags
	person_flags := ['P', 'D'];
	business_flags := ['B'];
	InvName_flags	:= ['I'];
	
	Layouts.Base tStandardizeName(FileClnName L) := TRANSFORM
		BOOLEAN IsName							:=	L.nametype IN person_flags OR	(L.nametype = 'U' AND trim(L.cln_fname) != '' AND TRIM(L.cln_lname) != '');
		SELF.clean_name.title				:= IF(IsName,L.cln_title, '');
		SELF.clean_name.fname				:= IF(IsName,L.cln_fname, '');
		SELF.clean_name.mname				:= IF(IsName,L.cln_mname, '');
		SELF.clean_name.lname				:= IF(IsName,L.cln_lname, '');
		SELF.clean_name.name_suffix	:= IF(IsName,L.cln_suffix, '');
		SELF.clean_name.name_score	:= '';
		SELF 												:= L;
	END;
	
	dStandardizedName := PROJECT(FileClnName, tStandardizeName(LEFT));

	return dStandardizedName;
	
end;
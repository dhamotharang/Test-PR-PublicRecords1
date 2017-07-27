import codes, doxie, ut, STD;

boolean random_value := false : STORED('Randomize');

results_out := doxie.dl_Search_Local;

ExtendedLayout :=
RECORD
	results_out;
	unsigned1 age_today := ut.age(results_out.dob);
	unsigned1 dead_age := if((unsigned4)results_out.dod=0,0,((unsigned4)results_out.dod-results_out.dob) div 10000);
	string330 license_type_name := '';
	
	string330	restriction1 := '';
	string330	restriction2 := '';
	string330	restriction3 := '';
	string330	restriction4 := '';
	string330	restriction5 := '';
  
	string330 endorsement1 := '';
	string330 endorsement2 := '';
	string330 endorsement3 := '';
	string330 endorsement4 := '';
	string330 endorsement5 := '';
END;
ta := table(results_out,ExtendedLayout);
 
ExtendedLayout Trans_DL_Code(ExtendedLayout L) := transform
	self.license_type_name	:= Codes.KeyCodes('DRIVERS_LICENSE2', 'LICENSE_TYPE', L.orig_state, L.license_type, true);

	string15 restrict_delim(unsigned1 idx) := STD.Str.Extract (L.restrictions_delimited, idx);
	self.restriction1 := Codes.KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(1), true);
	self.restriction2 := Codes.KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(2), true);
	self.restriction3 := Codes.KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(3), true);
	self.restriction4 := Codes.KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(4), true);
	self.restriction5 := Codes.KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(5), true);

	string15 endorse_delim(unsigned1 idx) := L.lic_endorsement[idx];
	self.endorsement1 := Codes.KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(1), true);
	self.endorsement2 := Codes.KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(2), true);
	self.endorsement3 := Codes.KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(3), true);
	self.endorsement4 := Codes.KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(4), true);
	self.endorsement5 := Codes.KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(5), true);

	self := L;
end;

dl_search_out := project(ta, Trans_DL_Code(left));

export dl_Search_Records := dl_search_out;
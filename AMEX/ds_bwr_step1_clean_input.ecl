rawinput  := record
  string10 sequence_number;
  string13 first_name;
  string1 mid_initial;
  string16 last_name;
  string29 address1;
  string25 address2;
  string20 city;
  string2 state;
  string5 zip_code;
  string4 zip_plus_4;
  string4 birth_year;
  string10 phone;
  string4 last_4_ssn;
  string1 crlf	;	
END;
formatinput := record
	STRING30 seq;
	STRING12 DID;
	STRING30 FirstName;
	STRING20 MiddleName;
	STRING30 LastName;
	STRING30 StreetAddress;
	STRING30 City;
	STRING2 State;
	STRING9 Zip;
	STRING8 DateOfBirth;
	STRING9 SSN;
	STRING12 HomePhone;
	UNSIGNED3 historydateyyyymm;
end;

 infile_name   := '~tfuerstenberg::in::vendor08_young_data_updated'; 
 ds_in := dataset (infile_name, rawinput, thor);
 
 formatinput  formatit(rawinput l) := transform
	self.seq := l.sequence_number;
	self.DID := '';
	self.FirstName := l.first_name;
	self.MiddleName := l.mid_initial;
	self.LastName := l.last_name;
	self.StreetAddress := StringLib.StringCleanSpaces(l.address1 + ' '+ l.address2);
	self.Zip := l.zip_code + l.zip_plus_4;	
	self.DateOfBirth := if (length(trim(l.birth_year)) > 0, l.birth_year +'0000','');
	self.SSN := l.last_4_ssn;				
	self.HomePhone := l.phone;			
	self.historydateyyyymm := 200912;		
	self := l;
	self := [];
 end;
 ds_in100 := ds_in;
 ds_out := project(ds_in100, formatit(left));
 output(choosen(ds_in100, 10), named('first_ten'));
 
output(choosen(ds_out, 1000000, 1),, '~dvstemp::in::AMEX_input_cleaned_0_1mill', CSV(QUOTE('"')));
output(choosen(ds_out, 1000000, 1000001),, '~dvstemp::in::AMEX_input_cleaned_1_2mill', CSV(QUOTE('"')));
output(choosen(ds_out, 1000000, 2000001),, '~dvstemp::in::AMEX_input_cleaned_2_3mill', CSV(QUOTE('"')));
output(choosen(ds_out, 1000000, 3000001),, '~dvstemp::in::AMEX_input_cleaned_3_4mill', CSV(QUOTE('"')));


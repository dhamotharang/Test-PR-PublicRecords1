rec := record
ebcdic string15 first_name;
ebcdic string1 middle_initial;
ebcdic string25 last_name;
ebcdic string2 suffix;
ebcdic string15 former_first_name;
ebcdic string1 former_middle_initial;
ebcdic string25 former_last_name;
ebcdic string2 former_suffix;
ebcdic string15 aka_first_name;
ebcdic string1 aka_middle_initial;
ebcdic string25 aka_last_name;
ebcdic string2 aka_suffix;
ebcdic string57 current_address;
ebcdic string20 current_city;
ebcdic string2 current_state;
ebcdic string5 current_zip;
ebcdic string6 current_address_date_reported;
ebcdic string57 former1_address;
ebcdic string20 former1_city;
ebcdic string2 former1_state;
ebcdic string5 former1_zip;
ebcdic string6 former1_address_date_reported;
ebcdic string57 former2_address;
ebcdic string20 former2_city;
ebcdic string2 former2_state;
ebcdic string5 former2_zip;
ebcdic string6 former2_address_date_reported;
ebcdic string6 birthdate;
ebcdic string9 ssn;
ebcdic string9 cid;
ebcdic string10 phone;
ebcdic string35 current_occupation_employer;
ebcdic string35 former_occupation_employer;
ebcdic string35 former2_occupation_employer;
ebcdic string35 other_occupation_employer;
ebcdic string35 other_former_occupation_employer;
end;

header.layout_eq_in stringLayout1(rec L) := transform
 self.file_date := 200008;
 self := l;
end;

header.layout_eq_in stringLayout2(rec L) := transform
 self.file_date := 200007;
 self := l;
end;

header.layout_eq_in stringLayout3(rec L) := transform
 self.file_date := 199201;
 self := l;
end;

in_files_4 := project(dataset('~thor_data400::in::header::company::200008a',rec,flat),stringLayout1(left)) + 
			project(dataset('~thor_data400::in::header::company::200008b',rec,flat),stringLayout1(left)) +
			project(dataset('~thor_data400::in::header::company::200008c',rec,flat),stringLayout1(left));

in_files_5 := project(dataset('~thor_data400::in::header::company::200007a',rec,flat),stringLayout2(left)) + 
			project(dataset('~thor_data400::in::header::company::200007b',rec,flat),stringLayout2(left));

in_files_6 := project(dataset('~thor_data400::in::header::company::1992',rec,flat),stringLayout3(left));

in_files := in_files_4 + in_files_5; //+ in_files_6;

export File_Eq_In := in_files;

/*header.layout_eq_in stringLayout1(rec L) := transform
 self.file_date := 198501;
 self := l;
end;

header.layout_eq_in stringLayout2(rec L) := transform
 self.file_date := 198601; 
 self := l;
end;

header.layout_eq_in stringLayout3(rec L) := transform
 self.file_date := 198801;
 self := l;
end;

header.layout_eq_in stringLayout4(rec L) := transform
 self.file_date := 199001;
 self := l;
end;

header.layout_eq_in stringLayout5(rec L) := transform
 self.file_date := 199009;
 self := l;
end;

header.layout_eq_in stringLayout6(rec L) := transform
 self.file_date := 199101;
 self := l;
end;

header.layout_eq_in stringLayout7(rec L) := transform
 self.file_date := 199201;
 self := l;
end;

in_files := project(dataset('~thor_data400::in::header::company::1985',rec,flat),stringLayout1(left)) + 
			project(dataset('~thor_data400::in::header::company::1986',rec,flat),stringLayout2(left)) +
			project(dataset('~thor_data400::in::header::company::1988',rec,flat),stringLayout3(left)) +			
			project(dataset('~thor_data400::in::header::company::1990q1',rec,flat),stringLayout4(left)) +
			project(dataset('~thor_data400::in::header::company::1990q4',rec,flat),stringLayout5(left)) +
			project(dataset('~thor_data400::in::header::company::1991',rec,flat),stringLayout6(left)) +
			project(dataset('~thor_data400::in::header::company::1992',rec,flat),stringLayout7(left));*/
import ut,idl_header,doxie, data_services;

f := dataset(idl_header.name_count_file, idl_header.layout_name_count, flat);

layout_plus := RECORD
	RECORDOF(f);
	BOOLEAN isLastName;
	BOOLEAN isFirstName;
END;

layout_plus defineNames(f le) := TRANSFORM
	SELF.isLastName := (le.lname_cnt / (le.fname_cnt+le.lname_cnt)) > 0.75;
	SELF.isFirstName := (le.fname_cnt / (le.fname_cnt+le.lname_cnt)) > 0.75;
	SELF := le;
END;
final := PROJECT(f, defineNames(LEFT));


EXPORT Key_NameFrequency := index(final, {name}, {final}, Data_Services.Data_location.person_header +'thor_data400::key::ri::name_frequency_' + Doxie.Version_SuperKey);
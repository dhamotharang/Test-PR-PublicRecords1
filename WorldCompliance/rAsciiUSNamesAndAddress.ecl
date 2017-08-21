EXPORT rAsciiUSNamesAndAddress := RECORD
unsigned8		Ent_ID;
unsigned6   LexID := 0;

STRING255		name;
STRING50		FirstName;
STRING20		FName;
STRING20		MiddleName := '';
STRING20		LastName;
STRING5			Suffix;
STRING75		Dob;
STRING20		Dob2;
STRING8			Clean_Dob;
STRING20		NationalId;
STRING9			SSN				 := '';

STRING20		EntryType;
STRING			Gender;

STRING255		Orig_Address;
STRING182		Clean_Address;
STRING10   	Clean_prim_range;
STRING28		Clean_prim_name;
STRING8			Clean_sec_range;
STRING50		Orig_City;
STRING30		Clean_City;
STRING50		Orig_SateProvince;
STRING2			Clean_StateProvince;
STRING100		Country;
STRING15		Orig_PostalCode;
STRING5			Clean_ZipCode;
STRING4     Clean_ZipCode4;
STRING4 		Error_Code;
END;
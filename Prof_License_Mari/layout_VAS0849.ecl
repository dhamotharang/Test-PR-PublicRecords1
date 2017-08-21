// VAS0849 / Virginia Dept. of Profess./Occupational Regulation	/ Multiple Professions //

export layout_VAS0849 := MODULE

export raw := RECORD
	string30   BOARD;
	string30   OCCUPATION;
	string30   CERTIFICATE;
	string100  INDIV_NAME;
	string150  BUS_NAME;
	string50   ADDRESS1;
	string50   ADDRESS2;
	string50   POBOX;
	string30   CITY;
	string2    STATE;
	string5    ZIP5;
	string4    ZIPCODE_EXT;
	string30   PROVINCE;
	string30   COUNTRY;
	string30   POSTAL_CODE;
	string30   EXP_DATE;
	string30   CERTIF_DATE;
	string30   LIC_TYPE;
	string30   LIC_SPEC1;
	// string30   LIC_SPEC2;
	string80	 EMAIL;
END;

export src := RECORD
	raw;
	string8 ln_filedate;
end;

end;
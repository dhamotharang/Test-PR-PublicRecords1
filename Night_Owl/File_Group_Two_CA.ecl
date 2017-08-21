layout :=
RECORD
	STRING uniqueid;
	STRING9 best_ssn;
	STRING9 ssn;
	STRING14 dl_number;
	
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5 name_suffix;
	STRING100 fullname;
	STRING address;
	STRING city;
	STRING2 state;
	STRING9 zip9;
END;

f := dataset('~thor_data400::in::nightowl::group_two_ca',layout,CSV(QUOTE('"')));

typeof(File_Group_Two) moreStandard(f le) :=
TRANSFORM
	SELF.ssn := INTFORMAT((INTEGER)le.ssn,9,1);
	SELF := le;
	
	SELF.deceased := 'N';
	SELF := [];
END;

export File_Group_Two_CA  := PROJECT(f, moreStandard(LEFT));
import header, doxie;

mdate(integer2 date_year) := MAP(	date_year=0=>0,
							date_year < 10 => date_year+2000, 
							date_year < 100 => date_year+1900,
							date_year);

Layout_map :=
RECORD
	STRING5 ssn5;
	STRING8 start_date;
	STRING8 end_date;
	STRING32 state_name;
	STRING1 status_code;
END;

layout_map reformat(header.File_SSN_Map le) :=
TRANSFORM
	start_yyyy := mdate((INTEGER)(le.start_date[5..6]));
	end_yyyy := mdate((INTEGER)(le.end_date[5..6]));
	
	SELF.start_date := IF(start_yyyy<1000,'',start_yyyy+le.start_date[1..4]);
	SELF.end_date := IF(end_yyyy<1000,'',end_yyyy+le.end_date[1..4]);
	SELF := le;
END;

p := PROJECT(header.File_SSN_Map((INTEGER)ssn5<>0), reformat(LEFT));

export Key_SSN_map := INDEX(p,{ssn5},{start_date,end_date,state_name,status_code},'~thor_data400::key::ssn_map_long_' + doxie.Version_SuperKey);
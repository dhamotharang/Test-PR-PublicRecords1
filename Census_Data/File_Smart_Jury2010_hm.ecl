Layout_Smart_Jury_hm := record
string2  STUSAB;
string3  COUNTY;
string6  TRACT;
string1  BLKGRP;
string5  age;
string9  income;
string9  home_value;
string5  education;
end;

EXPORT File_Smart_Jury2010_hm := 
	PROJECT(
		dataset('~thor20_241_10::in::smartjury::smart_jury_2010_hm',Layout_Smart_Jury_hm,
			CSV(HEADING(1),SEPARATOR(','),TERMINATOR(['\n','\r\n','\n\r']))),
			TRANSFORM(Layout_Smart_Jury_hm,
				SELF.county := INTFORMAT((integer)LEFT.county, 3, 1);
				SELF.TRACT := INTFORMAT((integer)LEFT.TRACT, 6, 1);
				SELF := LEFT;));

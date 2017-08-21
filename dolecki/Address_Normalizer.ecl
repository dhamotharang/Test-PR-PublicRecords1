Address_Layout := RECORD
  string40 STREET1;
  string30 CITY;
  string30 STATE;
  string30 ZIP;
	string30 BUILDING_NUMBER;
  string30 DIRECTION;
  string30 POST_BOX;
  string30 STREET_SUFFIX;
	string30 UNIT_DESCRIPTION;
 END;
 
Address_Dataset := DATASET(
	'~mist::addressnormalizer',
	Address_Layout,
	csv
);

Extended_Address_Record := RECORD
	string40 MY_DIRECTION;
	string40 MY_POST_BOX;
	string40 MY_STREET_SUFFIX;
	string40 MY_UNIT_DESCRIPTION;
	Address_Layout;
END;

Extended_Address_Record createRow(Address_Layout l) := TRANSFORM
	SELF.MY_DIRECTION := (string40)
		REGEXFIND(
			'^.* (EAST|E|WEST|W|NORTH|N|SOUTH|S|NORTHEAST|NE|NORTHWEST|NW|SOUTHEAST|SE|SOUTHWEST|SW) .*$' ,
			l.STREET1, 
			1,
			NOCASE
		);
	SELF.MY_POST_BOX := (string40)
		REGEXFIND(
			'^.* (PO|P.O.|BOX|RTE|RT|RR) .*$' ,
			l.STREET1,
			1,
			NOCASE
		);
	SELF.MY_STREET_SUFFIX := (string40)
		REGEXFIND(
			' (AVE|RD|ST) ' ,
			l.STREET1,
			1,
			NOCASE
		);
	SELF.MY_UNIT_DESCRIPTION := (string40)
		REGEXFIND(
			'^.* (SUITE|STE|APT|UNIT|#|FL|BLDG|RM|ROOM|OFC|LOT) .*$' ,
			l.STREET1,
			1,
			NOCASE
		);
	SELF := l;
END;

Address_Normalizer := PROJECT(
	Address_Dataset,
	createRow(LEFT)
);

output(Address_Normalizer);
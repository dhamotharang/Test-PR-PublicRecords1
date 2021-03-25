IMPORT header;
EXPORT mod_matchCodes := MODULE
/*
Best Match
// L             LexId
Name Matches
// N             exact match. Name: last name, first or preferred first
// V             Last Name + Partial First
// W             Last Name only
SSN Matches
// S             Full SSN
// P             Possible SSN
DOB Matches
// D             DOB
// B             Possible DOB
Address Matches
// A             Street: prim range & prim name
// C             City/State 
// Z             Zip 
Reserved for Future Use
// H             Phone
*/
	shared strEq  (STRING str1, STRING str2) := str1 = str2 AND str2 <> '';

	export NameMatch(string fname1, string lname1, string fname2, string lname2, string prefname1='', string prefname2='') := 

			MAP(
				lname1 <> lname2 => '',
				length(trim(fname1))= 0 OR length(trim(fname2))= 0 => '',
				fname1 = fname2
						or strEq(fname1, prefname2)
						or strEq(prefname1, prefname2) => 'N',		// name match
						
				fname1[1] = fname2[1]
						or fname1[1] = prefname2[1]
						or strEq(prefname1[1], prefname2[1]) => 'V',
				'W'	// last name only
			);
				
	export SSNMatch(string ssn1, string ssn2) := 
			MAP(
				(unsigned)ssn1 = 0 OR (unsigned)ssn2 = 0 => '',
				ssn1=ssn2 => 'S',										// SSN match
				$.ssn_value(ssn1,ssn2) > 0 => 'P',		// Possible SSN match
				''
			);

	export DobMatch(unsigned dob1, unsigned dob2, string suffix1='', string suffix2='') := 
			MAP(
				dob1 = 0 OR dob2 = 0 => '',
				dob1=dob2 => 'D',										// DOB match
				$.gens_ok(suffix1,dob1,suffix2,dob2) AND
					(
						header.sig_near_dob(dob1,dob2) OR
						header.date_value(dob1,dob2) > 1
					) => 'B',
			'');
	export AddressMatch(string prim_range1, string prim_name1, string prim_range2, string prim_name2) :=
			MAP(
				prim_name1 = '' OR prim_name2 = '' => '',
				prim_name1 = prim_name2 AND prim_range1 = prim_range2 => 'A',
				''
			);
				
	export CityMatch(string city1, string st1, string city2, string st2) := 
			MAP(
				city1 = '' OR city2 = '' OR st1 = '' OR st2 = '' => '',
				city1 = city2 AND st1 = st2 => 'C',
				''
			);
			
	export ZipMatch(string zip1, string zip2) := 
			MAP(
				zip1 = '' OR zip2 = '' => '',
				zip1 = zip2 => 'Z',
				''
			);
				
END;
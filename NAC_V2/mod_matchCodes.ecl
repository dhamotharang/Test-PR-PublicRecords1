IMPORT header, Std;
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
	shared strEq  (string str1, string str2) := str1 = str2 AND str2 <> '';
	shared intEq  (unsigned8 id1, unsigned8 id2) := id1 = id2 AND id2 <> 0;
	
	shared integer getAge(unsigned4 dob) :=
					IF(NOT Std.Date.IsValidDate(dob), 0,
					(integer)(Std.Date.MonthsBetween(dob, STD.Date.Today())/12)
					);
					
	shared ValidLexid(unsigned6 lexId, unsigned4 dob, unsigned4 bestdob) :=
					LexId <> 0 
					AND getAge(dob) > 17
					AND header.sig_near_dob(dob,bestdob);
	
	// best dob is dob returned by did_add.MAC_Add_DOB_By_DID
	export boolean LexidMatch(unsigned6 lexId1, unsigned6 lexId2, unsigned4 dob1, unsigned4 dob2,
										unsigned4 bestdob1, unsigned4 bestdob2) :=
				 ValidLexid(lexId1, dob1, bestdob1) AND
				 ValidLexid(lexId2, dob2, bestdob2) AND
				 lexId1 = lexId2;

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

	export DobMatch(unsigned4 dob1, unsigned4 dob2, string suffix1='', string suffix2='') := 
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
			IF(strEq(prim_name1, prim_name2) AND prim_range1 = prim_range2, 'A', '');
				
	export CityMatch(string city1, string st1, string city2, string st2) := 
			IF(strEq(city1, city2) AND strEq(st1, st2), 'C', '');

			
	export ZipMatch(string zip1, string zip2) := 
			IF(strEq(zip1, zip2), 'Z', '');

				
END;
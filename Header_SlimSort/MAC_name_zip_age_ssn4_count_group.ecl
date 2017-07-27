EXPORT MAC_name_zip_age_ssn4_count_group
(
	infile,
	outfile,
	field_set,
	fname,
	mname = ''
) := MACRO

/* ----------------------------------------------------
	 Flag description:
	A - age
	S - ssn4
	Z - zip
	M - middle name (full or initial)
	F - full middle name (valid only with M)
	I - first initial
-----------------------------------------------------*/

#uniquename(infile_s)

#if('I' IN field_set)
// Need to resort on first initial, middle initial
%infile_s% := SORT(infile(
	#if('Z' in field_set)
		zip != '',
	#end
	#if('S' in field_set)
		ssn4 != 0,
	#end
	true)
	, did, fname, mname);
#else
%infile_s% := infile(
	#if('Z' in field_set)
		zip != '',
	#end
	#if('S' in field_set)
		ssn4 != 0,
	#end
	true);
#end

#uniquename(infile_d)
%infile_d% := DEDUP(%infile_s%	, did, fname 
#if('M' IN field_set)
								, mname
#end
						);

#uniquename(layout_res)
MAC_name_zip_age_ssn4_MakeLayout(infile, field_set, fname, mname, %layout_res%)

#uniquename(res)
#uniquename(res1)
#uniquename(res3)
%res1% := TABLE(%infile_d%, %layout_res%
#if('Z' IN field_set)
						, zip
#end
#if('A' IN field_set)
						, age
#end
#if('S' IN field_set)
						, ssn4
#end
						, lname
						, fname
#if('M' IN field_set)
						, mname
#end
						, LOCAL, MANY, UNSORTED);

#uniquename(AddPartialCount)
%layout_res% %AddPartialCount%
(
	%layout_res% le, 
	rightcount,
	divisor
) := 
TRANSFORM
	SELF.DIDCount := IF(le.DIDCount + rightcount / divisor > 65500,
						65535,
						le.DIDCount + rightcount / divisor);
	SELF := le;
END;

#if('A' IN field_set)
%res3% := %res1%;

// Now add in the partial weight of 0-aged groups to non-zero aged groups.
#uniquename(res4)
%res4% := JOIN(%res3%, %res3%(age = 0),
				    LEFT.lname 		 = RIGHT.lname 
				AND LEFT.first_name  = RIGHT.first_name
#if('M' IN field_set)
				AND LEFT.middle_name = RIGHT.middle_name
#end
#if('Z' IN field_set)
				AND LEFT.zip    	 = RIGHT.zip
#end
#if('S' IN field_set)
				AND LEFT.ssn4		 = RIGHT.ssn4
#end
				AND LEFT.age		 != 0,
		 %AddPartialCount%(LEFT, RIGHT.DIDCount, 50), LEFT OUTER, LOCAL);

// Get a sum the scores of non-zero aged groups.
#uniquename(layout_res3)
%layout_res3% := RECORD
#if('Z' IN field_set)
	%res1%.zip;
#end
#if('S' IN field_set)
	%res1%.ssn4;
#end
	%res1%.lname;
	%res1%.first_name;
#if('M' IN field_set)
	%res1%.middle_name;
#end
	UNSIGNED2 DIDCount := IF(SUM(GROUP, %res1%.DIDCount) > 65500, 
						65535, SUM(GROUP, %res1%.DIDCount));
END;

#uniquename(res5)
%res5% := TABLE(%res1%(age != 0), %layout_res3%
#if('Z' IN field_set)
						, zip
#end
#if('S' IN field_set)
						, ssn4
#end
						, lname
						, first_name
#if('M' IN field_set)
						, middle_name
#end
						, LOCAL, MANY, UNSORTED);

// Add the partial count of non-zero aged groups to 0 aged groups.
%res% := JOIN(%res4%, %res5%,
				    LEFT.lname 		 = RIGHT.lname 
				AND LEFT.first_name  = RIGHT.first_name
#if('M' IN field_set)
				AND LEFT.middle_name = RIGHT.middle_name
#end
#if('Z' IN field_set)
				AND LEFT.zip    	 = RIGHT.zip
#end
#if('S' IN field_set)
				AND LEFT.ssn4		 = RIGHT.ssn4
#end
				AND LEFT.age		 = 0,
		 %AddPartialCount%(LEFT, RIGHT.DIDCount, 50), LEFT OUTER, LOCAL);

#else
%res% := %res1%;
#end // 'A' in field_set

// Now add in the partial weight of blank middle name groups,
// taking care not to double count the 0 aged ones.
#uniquename(blankmiddle)
#if('M' IN field_set)
%blankmiddle% := JOIN(%res%, %res1%(middle_name = ''), 
				    LEFT.lname 		 = RIGHT.lname 
				AND LEFT.first_name  = RIGHT.first_name
#if('A' IN field_set)
				AND LEFT.age 		 = RIGHT.age
#end
#if('Z' IN field_set)
				AND LEFT.zip    	 = RIGHT.zip
#end
#if('S' IN field_set)
				AND LEFT.ssn4		 = RIGHT.ssn4
#end
				AND LEFT.middle_name != '',
		 %AddPartialCount%(LEFT, RIGHT.DIDCount,
#if('F' IN field_set)
				100
#else
				10
#end
										), LEFT OUTER, LOCAL);

#else
%blankmiddle% := %res%;
#end // 'M' IN field_set

outfile := %blankmiddle%;
ENDMACRO;
EXPORT MAC_name_zip_age_ssn4_join_group
(
	infile,
	groupfile,
	outfile,
	count_name,
	count_age_radius_name,
	field_set,
	fname,
	mname = ''
) := MACRO

#uniquename(j1)
#uniquename(JoinFN)
TYPEOF(infile) %JoinFN%(infile le, groupfile ri) := TRANSFORM
	SELF.count_name := ri.DIDCount;
// --------------- Disable Age Radius processing --------------
/*	
#if('A' in field_set)
	SELF.count_age_radius_name := ri.DIDCount2;
#end
*/
	SELF := le;
END;

%j1% := JOIN(infile, groupfile, 
					LEFT.lname = RIGHT.lname
			    AND LEFT.fname = RIGHT.first_name
#if('M' IN field_set)
				AND LEFT.mname = RIGHT.middle_name
#end
#if('Z' IN field_set)
				AND LEFT.zip   = RIGHT.zip
#end
#if('A' IN field_set)
				AND LEFT.age   = RIGHT.age
#end
#if('S' IN field_set)
				AND LEFT.ssn4  = RIGHT.ssn4
#end
							, %JoinFN%(LEFT, RIGHT), left outer, LOCAL);

outfile := %j1%;
ENDMACRO;
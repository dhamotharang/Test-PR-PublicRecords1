export SSN_Match_Score(string9 ssn1, string9 ssn2) := function
	d1 := if(ssn1[1]=ssn2[1],1,0);
	d2 := if(ssn1[2]=ssn2[2],1,0);
	d3 := if(ssn1[3]=ssn2[3],1,0);
	d4 := if(ssn1[4]=ssn2[4],1,0);
	d5 := if(ssn1[5]=ssn2[5],1,0);
	d6 := if(ssn1[6]=ssn2[6],1,0);
	d7 := if(ssn1[7]=ssn2[7],1,0);
	d8 := if(ssn1[8]=ssn2[8],1,0);
	d9 := if(ssn1[9]=ssn2[9],1,0);

	match:=d1+d2+d3+d4+d5+d6+d7+d8+d9;
	
	return map	(
				ssn1='' or ssn2=''															=> 0
				,regexfind(ssn1[1..7],ssn2)		/*looking for a shift error*/				=> 3
				,regexfind(ssn1[2..8],ssn2)		/*looking for a shift error*/				=> 3
				,regexfind(ssn1[3..9],ssn2)		/*looking for a shift error*/				=> 3
				,match > 6																	=> 3
				,(integer)ssn1[1..5]=0 or (integer)ssn2[1..5]=0 and ssn1[6..9]=ssn1[6..9]	=> 2
				,match = 6																	=> 1
				,0
				);
end;
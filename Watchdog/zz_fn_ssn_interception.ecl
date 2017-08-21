export fn_ssn_interception(string9 ssn1, string9 ssn2) := function

	match1:=if(ssn1[1]=ssn2[1],1,0);
	match2:=if(ssn1[2]=ssn2[2],1,0);
	match3:=if(ssn1[3]=ssn2[3],1,0);
	match4:=if(ssn1[4]=ssn2[4],1,0);
	match5:=if(ssn1[5]=ssn2[5],1,0);
	match6:=if(ssn1[6]=ssn2[6],1,0);
	match7:=if(ssn1[7]=ssn2[7],1,0);
	match8:=if(ssn1[8]=ssn2[8],1,0);
	match9:=if(ssn1[9]=ssn2[9],1,0);

	return	 match1
			+match2
			+match3
			+match4
			+match5
			+match6
			+match7
			+match8
			+match9;
end;
export keep_fuller_ssn(string9 ssn1, string9 ssn2) := function
 
 keep_fuller := if(ut.partial_ssn(ssn1) and ut.full_ssn(ssn2) and ssn1[6..9]=ssn2[6..9],ssn2,
                if(ut.partial_ssn(ssn2) and ut.full_ssn(ssn1) and ssn1[6..9]=ssn2[6..9],ssn1,
				''));
 

 return keep_fuller;

end;
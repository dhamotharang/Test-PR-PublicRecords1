export varstring ErrorCodes(integer c) := 
				CASE(c,	203	=>
				'Your subject cannot be uniquely identified.  Please include additional identifying information such as Name, Address, SSN or DOB.'
				,204 => 
				'The email address cannot be uniquely identified.  Please include additional identifying information such as Name, Address, SSN or DOB.'			
				,'Database Error');
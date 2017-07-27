export business_activity(string1 Business_activity_code) := FUNCTION
		String codeStr := MAP( 
		                        (Business_activity_code = 'A' )=>  'PHARMACY'
													, (Business_activity_code = 'B' )=> 'HOSPITAL/CLINIC'
													, (Business_activity_code = 'C' )=> 'PRACTITIONER'
													, (Business_activity_code = 'D' )=> 'TEACHINGINSTITUTION'
													, (Business_activity_code = 'E' )=> 'MANUFACTURER'
													, (Business_activity_code = 'F' )=> 'DISTRIBUTOR'
													, (Business_activity_code = 'G' )=> 'RESEARCHER'
													, (Business_activity_code = 'H' )=> 'ANALYTICAL LAB'
													, (Business_activity_code = 'J' )=> 'IMPORTER'
													, (Business_activity_code = 'K' )=> 'EXPORTER'
													, (Business_activity_code = 'M' )=> 'MID-LEVEL PRACTITIONER'
													, 'NARCOTIC TREATMENT PROGRAMS'
													);
		return (codeStr);

END;

//'or'P'or'R'or'S'or'T'or'U'
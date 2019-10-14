import std, Risk_Indicators;
export Validate_SSN(STRING9 ssn, STRING8 dob) :=
MODULE

	// Pure format
	export invalid := LENGTH(STD.Str.Filter(ssn,'0123456789'))<>9;
	export begin_invalid := ssn[1]='9' OR ssn[1..3] = '000';
	export middle_invalid := ssn[4..5]='00';
	export last_invalid := ssn[6..9]='0000';
	export invalid_666s := ssn[1..3] = '666';
	export pocketbook_ssn := ssn IN [
			'123456789', '022281852', '042103580', '062360749', '062360794', '078051120', '095073645', '128036045', '135016629',
			'141186941', '165167999', '165187999', '165207999', '165227999', '165247999', '189092294', '212097694',
			'212099999', '219099998', '219099999', '306302348', '308125070', '468288779', '549241889', '987654320'
		];
	export isDobEmpty := (LENGTH(STD.Str.Filter(dob,'0123456789'))<>8) OR invalid;
	export isDobInvalid := (dob[1..2]>'20' or (dob[1..2]<'19')) or (dob[1..4]>(STRING8)Std.Date.Today()) or
					    dob[5..6]>'12' or dob[5..6]='00' or dob[7..8]>'31' or dob[7..8]='00';
	
  
	              //for invalid ITIN date 
  export isITINPOtentiallyExpired:=Risk_Indicators.rcSet.isCodeIT(ssn)and ssn[4..5] IN ['70','71','72','73','74','75','76','77','78','79','80','81','82'];
		
	export ssnDobFlag(UNSIGNED3 highissue) := MAP(isDobEmpty => '3',
										 isDobInvalid => '2',
										 highissue <> 0 AND highissue < (UNSIGNED3)(dob[1..6]) => '1',
										 '0');
				   
END;
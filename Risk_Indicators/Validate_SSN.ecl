import ut;
export Validate_SSN(STRING9 ssn, STRING8 dob) :=
MODULE

	// Pure format
	export invalid := LENGTH(Stringlib.StringFilter(ssn,'0123456789'))<>9;
	export begin_invalid := ssn[1]='9' OR ssn[1..3] = '000';
	export middle_invalid := ssn[4..5]='00';
	export last_invalid := ssn[6..9]='0000';
	export invalid_666s := ssn[1..3] = '666';
	export pocketbook_ssn := ssn IN [
			'123456789', '022281852', '042103580', '062360749', '062360794', '078051120', '095073645', '128036045', '135016629',
			'141186941', '165167999', '165187999', '165207999', '165227999', '165247999', '189092294', '212097694',
			'212099999', '219099998', '219099999', '306302348', '308125070', '468288779', '549241889', '987654320'
		];
	export isDobEmpty := (LENGTH(StringLib.StringFilter(dob,'0123456789'))<>8) OR invalid;
	export isDobInvalid := (dob[1..2]>'20' or (dob[1..2]<'19')) or (dob[1..4]>ut.GetDate) or
					    dob[5..6]>'12' or dob[5..6]='00' or dob[7..8]>'31' or dob[7..8]='00';
	
	// Based on ssn tables
/*	shared k3 := Key_SSN_Map(ssn5[1..3] = ssn[1..3]);
	shared k5 := Key_SSN_Map(ssn5 = ssn[1..5]);
	
	export outOfRange3 := ~EXISTS(k3);
	export outOfRange2 := ~outOfRange3 AND ~EXISTS(k5);

	export isCurrent := EXISTS(k5(end_date=''));

	export dobMismatch := EXISTS(k5(dob > end_date OR end_date=''));*/
	
	export ssnDobFlag(UNSIGNED3 highissue) := MAP(isDobEmpty => '3',
										 isDobInvalid => '2',
										 highissue <> 0 AND highissue < (UNSIGNED3)(dob[1..6]) => '1',
										 '0');
				   
/*				   
	export ssnValidFlag := MAP(ssn='' => '3',
						  invalid => '2',
						  begin_invalid or middle_invalid or last_invalid or
						  outOfRange3 or outOfRange2 => '1',
						  '0');
						  
	export ssnValidFlag2(UNSIGNED3 highissue) := MAP(ssn='' => '6',
											begin_invalid or middle_invalid or last_invalid or outOfRange3 or outOfRange2 => '1',
											dob<> '' and highissue - (UNSIGNED3)(dob[1..6]) > 1800 => '5',
											highissue <> 0 and (INTEGER)(ut.GetDate[1..6]) - highissue < 700 => '4',
											// not sure what to do for 3 or 2
											'0');
*/	
END;
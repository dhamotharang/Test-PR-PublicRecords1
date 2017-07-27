export CRIM_OFFENDER2 :=  MODULE

export VARSTRING SEX(string code) :=
		 CASE(code,
			 '' => 'Unknown',
			 '0' => 'Unknown',
			 '1' => 'Male',
			 '2' => 'Female',
		 	 'F' => 'Female',
			 'M' => 'Male',
			 'U' => 'Unknown',
			 '');
			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'SEX' =>	SEX(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='CRIM_OFFENDER2',field_name in ['SEX']
	),trans(LEFT));
	RETURN p;
		
	END;
END;
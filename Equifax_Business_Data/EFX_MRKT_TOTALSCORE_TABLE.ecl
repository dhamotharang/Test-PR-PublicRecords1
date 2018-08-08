IMPORT Codes;

EXPORT EFX_MRKT_TOTALSCORE_TABLE := 
MODULE
	EXPORT VARSTRING MRKT_TOTALSCORE(STRING code) :=
	  MAP(		
       code='0' => 'Non-Telemarketable',
       code='1' => 'Neutral',
       // code='2' => 'indicate varying degrees of confidence that the phone number is connected (in-service).  In general, all scores 2-5 should be treated as tele-marketable.',
       // code='3' => 'indicate varying degrees of confidence that the phone number is connected (in-service).  In general, all scores 2-5 should be treated as tele-marketable.',
       // code='4' => 'indicate varying degrees of confidence that the phone number is connected (in-service).  In general, all scores 2-5 should be treated as tele-marketable.',
       // code='5' => 'indicate varying degrees of confidence that the phone number is connected (in-service).  In general, all scores 2-5 should be treated as tele-marketable.	',	
       code='2' => 'Telemarketable',
       code='3' => 'Telemarketable',
       code='4' => 'Telemarketable',
       code='5' => 'Telemarketable',	       
			 code='' => '',
			 'INVALID');	 
						 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'MRKT_TOTALSCORE' =>	MRKT_TOTALSCORE(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='MRKT_TOTALSCORE',field_name in ['MRKT_TOTALSCORE']
	),trans(LEFT));
	RETURN p;
		
	END;
	
END;	
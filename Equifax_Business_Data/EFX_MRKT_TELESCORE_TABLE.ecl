﻿IMPORT Codes;

EXPORT EFX_MRKT_TELESCORE_TABLE := 
MODULE
	EXPORT VARSTRING MRKT_TELESCORE(STRING code) :=
	  MAP(		
       code='0' => 'Non-Telemarketable',
       // code='1' => 'indicates there\'s insufficient information to reliably determine if this telephone number is connected and/or valid for this business (neutral)',
       // code='2' => 'indicate varying degrees of confidence that the phone number is connected (in-service).  In general, all scores 2-5 should be treated as tele-marketable.',
       // code='3' => 'indicate varying degrees of confidence that the phone number is connected (in-service).  In general, all scores 2-5 should be treated as tele-marketable.',
       // code='4' => 'indicate varying degrees of confidence that the phone number is connected (in-service).  In general, all scores 2-5 should be treated as tele-marketable.',
       // code='5' => 'indicate varying degrees of confidence that the phone number is connected (in-service).  In general, all scores 2-5 should be treated as tele-marketable.	',	
			 code='1' => 'Telemarketable',
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
				MAP(le.field_name = 'MRKT_TELESCORE' =>	MRKT_TELESCORE(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='MRKT_TELESCORE',field_name in ['MRKT_TELESCORE']
	),trans(LEFT));
	RETURN p;
		
	END;
	
END;	
IMPORT corp2;
	
EXPORT Functions := MODULE
		
		//****************************************************************************
		//valid_documentid: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_documentid(STRING code) := FUNCTION																				
					 uc_code								:= corp2.t2u(code);		
					 isValidCD			 		  	:= if(corp2.t2u(stringlib.stringfilterout(uc_code,'-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))='',true,false);
					 RETURN if(isValidCD,1,0);
		END;

END;
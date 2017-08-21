EXPORT Layouts_Temporary := MODULE

  SHARED max_size := _Dataset().max_record_size;

  EXPORT Jigsaw_AddTwoPhones := RECORD,
	  	                      MAXLENGTH(max_size)
 		 Layouts.Base;
		 UNSIGNED6		business_phone;
		 UNSIGNED6		person_phone	;
	END;
	
END;
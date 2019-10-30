


 


IMPORT $, STD;


EXPORT fn_IsEmailAddressFormatValid
(
	DATASET(Layouts.rlEmailValidation) dsCheckFormat
)
:= FUNCTION 
	rgxEmail:='^(?=[A-Z0-9][A-Z0-9@._%+-]{5,253}+$)[A-Z0-9._%+-]{1,64}+@(?:(?=[A-Z0-9-]{1,63}+\\.)[A-Z0-9]++(?:-[A-Z0-9]++)*+\\.){1,8}+[A-Z]{2,63}+$'; 
	dsInvalid :=  dsCheckFormat(NOT REGEXFIND(rgxEmail, STD.Str.ToUpperCase(EmailAddress)));
	cnt := COUNT(dsInvalid); 
	rval := (cnt > 0);
	IF(cnt > 0 , 
		SEQUENTIAL(OUTPUT (dsInvalid, NAMED('invalid_format')), FAIL(1, 'Error in email format')) , 
			OUTPUT('Email format check passed', NAMED('email_format_check'))); 
	RETURN rval; 
END;








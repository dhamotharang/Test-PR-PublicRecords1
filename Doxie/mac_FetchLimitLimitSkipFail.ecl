export mac_FetchLimitLimitSkipFail(
	indxread,
	limit_inner,
	limit_outer,
	doSkip /*else fail*/,
	errorCode,
	doChoosen,
	doReturnMessage,
	outfile) := macro

Import doxie;

#uniquename(theskip)
#uniquename(thefail)
#uniquename(thekeep)
#uniquename(outrec)
#uniquename(didfail)
%outrec% := recordof(indxread);	//compiler didnt like not knowing the exact layout
%theskip% := limit(limit(indxread, limit_inner, skip, keyed), limit_outer, skip);

//**** YOU NOW HAVE THE OPTION OF RETURNING AN ERROR CODE RATHER THAN FAILING
#if(doReturnMessage)
	%didfail% := exists(indxread) and 
							 (count(%theskip%) = 0);			//i would rather use "not exists(%theskip%)", but bug 25500 

	%thefail%    := if(%didfail%, 
                     DATASET ([TRANSFORM (%outrec%, SELF.error_code := errorcode, SELF := [])]),
										 project(%theskip%, %outrec%));
#else										 
	%thefail% := limit(limit(indxread, limit_inner, FAIL(errorCode, doxie.ErrorCodes(errorCode)), keyed), limit_outer, FAIL(errorCode, doxie.ErrorCodes(errorCode)));
#end


%thekeep% := choosen(indxread, limit_outer);

outfile := map(doChoosen 				=> project(%thekeep%, %outrec%), 
							 doSkip						=> project(%theskip%, %outrec%), 
							 project(%thefail%, %outrec%));
endmacro;
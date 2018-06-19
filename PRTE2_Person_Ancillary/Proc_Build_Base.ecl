

EXPORT Proc_Build_Base := FUNCTION

	Build_Temps	:=	proc_build_temps;
	
	Build_SSN_Base	:=	Proc_Build_SSN_Base;
	
	return_val := 	sequential(Build_Temps,	Build_SSN_Base);
	
	return return_val;

END;
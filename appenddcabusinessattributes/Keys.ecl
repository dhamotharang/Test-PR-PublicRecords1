IMPORT $;

EXPORT Keys := MODULE
	SHARED prefix := '~';//'~foreign::10.241.3.238:7070::';

	DCABusinessFile := DATASET('', $.Layouts.DCABusinessLayout, THOR);

	EXPORT DCABusinessKey := INDEX(DCABusinessFile,
															{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
															{DCABusinessFile},
															prefix + 'thor_data400::key::dca::qa::linkids');

END;
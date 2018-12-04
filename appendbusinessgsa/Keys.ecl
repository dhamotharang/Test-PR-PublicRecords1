IMPORT $;

EXPORT Keys := MODULE
	SHARED prefix := '~';//'~foreign::10.241.3.238:7070::';

	GsaBusinessFile := DATASET('', $.Layouts.GsaBusinessLayout, THOR);

	EXPORT GsaBusinessKey := INDEX(GsaBusinessFile,
															{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
															{GsaBusinessFile},
															prefix + 'thor_data400::key::gsa::qa::linkids');

END;
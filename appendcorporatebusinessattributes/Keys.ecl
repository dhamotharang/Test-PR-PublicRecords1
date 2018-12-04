IMPORT $;

EXPORT Keys := MODULE
	SHARED prefix := '~';//'~foreign::10.241.3.238:7070::';

	CorpBusinessFile := DATASET('', $.Layouts.CorpBusinessLayout, THOR);

	EXPORT CorpBusinessKey := INDEX(CorpBusinessFile,
															{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
															{CorpBusinessFile},
															prefix + 'thor_data400::key::corp2::qa::corp::linkids');

END;
IMPORT $;

EXPORT Keys := MODULE
	SHARED prefix := '~';//'~foreign::10.241.3.238:7070::';

	GsaPersonFile := DATASET('', $.Layouts.GsaPersonLayout, THOR);

	EXPORT GsaPersonKey := INDEX(GsaPersonFile,
															{did},
															{GsaPersonFile},
															prefix + 'thor_data400::key::gsa::qa::did');

END;
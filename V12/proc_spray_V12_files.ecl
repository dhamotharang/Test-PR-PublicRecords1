IMPORT _control,ut,RoxieKeyBuild;

EXPORT proc_spray_V12_files(STRING version) := FUNCTION
	
	//Run epostal spray
	spray_postal := V12.spray_V12_epostal(version);

	//Run ezip spray
	spray_ezip	:= V12.spray_V12_ezip(version);
	
	//Run optout spray
	spray_optout	:= V12.spray_V12_optout(version);
	
	//Run hb spray
	spray_hb	:= V12.spray_V12_hb(version);
	
RETURN parallel(spray_postal/*,spray_ezip, spray_optout, spray_hb*/); //No longer receiving ezip, optout, or hb files

END;

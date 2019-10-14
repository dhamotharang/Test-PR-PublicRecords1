﻿IMPORT _Control, Property, Orbit3, STD;

#OPTION('skipfileformatcrccheck',1);
EXPORT Proc_Build_Forceclosure_all(
	STRING  pVersion,
	STRING  pHostname,
	STRING  pSource,
	STRING  pGroup = STD.System.Thorlib.Group(),
	STRING  pGlob  = 'REOOut.txt',
	BOOLEAN pSpray = TRUE
) := FUNCTION

	doSpray := Property.spray_Foreclosure_Raw(
		pVersion,
		pHostname,
		pVersion,
		pGroup,
		pSource + '/' + pGlob
	);

	doKeyBuild := Property.Foreclosure_Keys(pVersion);

	doOrbitStat := Property.scrubs_foreclosure_raw(pVersion);
	orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem(
		'Foreclosures',
		(pVersion),
		'N'
	);

	retval := SEQUENTIAL(
		IF(pSpray, doSpray),
		doOrbitStat,
		doKeyBuild,
		orbit_update
	); 

	RETURN retval;
END;

﻿import $, Orbit3, _control;

EXPORT Orbit_Build(string version) := function
		create_orbit_build := Orbit3.proc_Orbit3_CreateBuild('PRTE- Ecrash', version, 'PN', false, false, true,  _control.MyInfo.EmailAddressNormal);
	return create_orbit_build;

end;	

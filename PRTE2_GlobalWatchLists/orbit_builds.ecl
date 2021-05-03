import Orbit3, _control;

EXPORT orbit_builds(string version) := function

gwl 		 := Orbit3.proc_Orbit3_CreateBuild('PRTE - GlobalWatchListKeys', version, 'PN',  _control.MyInfo.EmailAddressNormal);
gwl2 		 := Orbit3.proc_Orbit3_CreateBuild('PRTE - GlobalWatchListV2Keys', version, 'PN', _control.MyInfo.EmailAddressNormal);
patriot  := Orbit3.proc_Orbit3_CreateBuild('PRTE - PatriotKeys', version, 'PN', _control.MyInfo.EmailAddressNormal);

create_orbit_build := parallel( gwl, gwl2, patriot);

 return create_orbit_build;	

end; 
	
import Orbit3, _control;

EXPORT Orbit_Build(string version) := function

	create_orbit_build	:= Orbit3.proc_Orbit3_CreateBuild('PRTE - DCA', version, 'PN',_control.MyInfo.EmailAddressNotify);

return create_orbit_build;

end;

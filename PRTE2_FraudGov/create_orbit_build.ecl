
import orbit3,_control;
EXPORT create_orbit_build(STRING current_version) := FUNCTION
orbit_build := 	Orbit3.proc_Orbit3_CreateBuild('PRTE - FraudGov', current_version, 'N', true, true, false,  _control.MyInfo.EmailAddressNormal);
return orbit_build;
end;
																

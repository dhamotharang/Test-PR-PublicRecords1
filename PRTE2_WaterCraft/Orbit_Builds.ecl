import Orbit3, _control;

EXPORT Orbit_Builds(string version) := function

create_orbit_build 			:= Orbit3.proc_Orbit3_CreateBuild('PRTE - WatercraftKeys', version, 'PN');
create_orbit_build_fcra := Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_WatercraftKeys', version, 'PF');

run_build := sequential(create_orbit_build, create_orbit_build_fcra);

return run_build;

end;


	
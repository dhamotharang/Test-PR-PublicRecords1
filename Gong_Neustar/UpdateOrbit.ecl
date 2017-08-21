import Orbit3,ut;


EXPORT UpdateOrbit(string version) := FUNCTION
 
create_build:= sequential(Orbit3.proc_Orbit3_CreateBuild ('Directory Assistance Daily',version,'N'),
               Orbit3.proc_Orbit3_CreateBuild ('FCRA Directory Assistance Daily',version,'F'));


return sequential(if(ut.Weekday((integer)version[1..8]) <> 'FRIDAY' and ut.Weekday((integer)version[1..8]) <> 'SATURDAY',
					 create_build,
					 output('No Orbit Entries Needed for weekend builds')));
END;
import versioncontrol, _control, ut, std;
export Build_all(string pVersion, boolean fcra = false, boolean pDaily = false) := function

	pDate 	:= (string8)std.date.today():INDEPENDENT;
	version := if(pVersion = '', pDate, pVersion);		
	
	seq := sequential(
					 // INQL_v2.Build_Strata(version).all
					 INQL_v2.proc_BuildBases(version, fcra, pDaily)					
					);

	return seq;
	
end;
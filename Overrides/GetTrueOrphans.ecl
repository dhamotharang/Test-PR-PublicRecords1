IMPORT Overrides;

EXPORT  GetTrueOrphans(STRING filedate) := FUNCTION

	OverrideBase := overrides.GetOverrideBase;

	output(TABLE(OverrideBase, {Datagroup, cnt := COUNT(GROUP)}, Datagroup, MERGE), NAMED('DsLexid_override_base'));

	//hit ConsumerDisclosure.FCRADataService to append compliance flags and get orphans candidates 

	Overrides.Mac_GetOverrides(OverrideBase, dsOutGet);

	dsOut_candidates := dsOutGet(IsOverride AND ~IsOverwritten): PERSIST('~thor_data400::persist::override_orphan_candidates');

   output(dsOut_candidates, NAMED('dsOut_candidates'));

	dsOut_C := DEDUP(dsOut_candidates(IsOverride and ~IsOverwritten), all);
	
	//GONG
	GongTrueOrphans := Overrides.Gong_Override_Findings(dsOut_C(datagroup = 'GONG'), filedate);
	
	// PAW
	PAW_TrueOrphans := Overrides.PAW_Override_Findings(dsOut_C(datagroup = 'PAW'), filedate);	
	
	// ALLOY
	
	//STUDENT
	Student_TrueOrphans := Overrides.American_Student_Override_Findings(dsOut_C(datagroup = 'STUDENT'), filedate);
	
	BaseTrueOrphans := (
					GongTrueOrphans
				  + PAW_TrueOrphans
					
					+Student_TrueOrphans
	): PERSIST('~thor_data400::persist::override_trueorphans');
	
	RETURN BaseTrueOrphans;
	
END;	 
	 
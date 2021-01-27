IMPORT Overrides;


//NOTE:test configurations
//Set GROWTH_CHECK_CALL  flag in constants
//Set filedate to father's file date plus one YYYYMMDD.
//the orphan count exceeds the threshold set in constants email will be sent.
//the orphan count does not exceeds the threshold orphans will be computed no email.

STRING filedate :='20201114';

OverrideBase := overrides.GetOverrideBase;

output(TABLE(OverrideBase, {Datagroup, cnt := COUNT(GROUP)}, Datagroup, MERGE), NAMED('DsLexid_override_base'));

Overrides.Mac_GetOverrides(OverrideBase, dsOutGet);

dsOut_candidates := dsOutGet(IsOverride AND ~IsOverwritten);

output(dsOut_candidates, NAMED('dsOut_candidates'));

dsOut_C := DEDUP(dsOut_candidates(IsOverride and ~IsOverwritten), all);


PAW_TrueOrphans := Overrides.American_Student_Override_Findings(dsOut_C(datagroup = 'STUDNET'), filedate);
output(PAW_TrueOrphans, NAMED('PAW_TrueOrphans'));

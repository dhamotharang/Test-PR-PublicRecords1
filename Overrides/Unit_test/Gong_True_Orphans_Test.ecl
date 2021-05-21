IMPORT Overrides;


//NOTE:test configurations
//Set GROWTH_CHECK_CALL  flag in constants
//Set filedate to father's file date plus one YYYYMMDD.
//the orphan count exceeds the threshold set in constants email will be sent.
//the orphan count does not exceeds the threshold orphans will be computed no email.

STRING filedate :='20201122';

OverrideBase := overrides.GetOverrideBase;

output(TABLE(OverrideBase, {Datagroup, cnt := COUNT(GROUP)}, Datagroup, MERGE), NAMED('DsLexid_override_base'));

Overrides.Mac_GetOverrides(OverrideBase, dsOutGet);

dsOut_candidates := dsOutGet(IsOverride AND ~IsOverwritten);

dsOut_C := DEDUP(dsOut_candidates(IsOverride and ~IsOverwritten), all);

Gong_TrueOrphans := Overrides.Gong_Override_Findings(dsOut_C(datagroup = 'GONG'), filedate);
output(Gong_TrueOrphans, NAMED('Gong_TrueOrphans'));

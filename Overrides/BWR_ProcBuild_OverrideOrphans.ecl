
//OverrideBase := overrides.GetOverrideBase;

//OverrideBase(DataGroup = 'GONG');

orphan_file_gong := Proc_Build_Override_Orphans('20200501');

//orphan_file_gong;

output(orphan_file_gong, named('gong_orphans_end'));
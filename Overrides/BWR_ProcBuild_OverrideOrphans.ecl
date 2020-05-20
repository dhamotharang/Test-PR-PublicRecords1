
//OverrideBase := overrides.GetOverrideBase;

//OverrideBase(DataGroup = 'GONG');

orphan_file_gong := Proc_Build_Override_Orphans('20200305');

orphan_file_gong;

//output(orphan_file_gong, named('gong_orphans'));
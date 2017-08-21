IMPORT	nac, Std;

sf := nac.Superfile_List().Base;

lfn := Std.File.GetSuperFileSubName(sf, 1);


EXPORT fn_Base1_Version := REGEXFIND('_(\\d+)$', lfn, 1);
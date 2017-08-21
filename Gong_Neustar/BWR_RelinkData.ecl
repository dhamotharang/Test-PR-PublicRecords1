import STD, gong_v2, gong, header_quick, header, ut;

h := Gong_neustar.File_GongHistory;
lfnh := '~'+Std.File.GetSuperFileSubName( Gong_Neustar.Constants.sfHistory, 1) + '::relinked';
lfnm := '~'+Std.File.GetSuperFileSubName( Gong_Neustar.Constants.sfMaster, 1) + '::relinked';
h1 := gong_neustar.fn_did_bdid_hhid(h);
gong_v2.Macro_GongLift(h1, history_with_lift);
h2 := gong.fnPropagateADLs(history_with_lift).history;

m := Gong_neustar.File_Master;
m1 := gong_neustar.proc_CleanNames(m);
m2 := gong_neustar.proc_LinkUp(m1);

SEQUENTIAL(
	OUTPUT(h2,,lfnh,COMPRESSED),
	OUTPUT(m2,,lfnm,COMPRESSED),
	gong_Neustar.Promotions.Master(lfnm),
	gong_Neustar.Promotions.History(lfnh)
);

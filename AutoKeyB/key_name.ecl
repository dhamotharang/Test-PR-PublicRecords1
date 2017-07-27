import doxie, autokeyb, lib_stringlib;

d := DATASET([],AutokeyB.Layout_Name);

export Key_Name(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'NameB'),
					INDEX(d, {d}, TRIM(t)+'NameB' + '_' + doxie.Version_SuperKey));
import doxie, AutoKeyB, lib_stringlib;

d := DATASET([],AutokeyB.Layout_StName);

export Key_StName(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'StNameB'),
					INDEX(d, {d}, TRIM(t)+'StNameB' + '_' + doxie.Version_SuperKey));
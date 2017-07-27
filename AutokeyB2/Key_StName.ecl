import doxie, AutoKeyB2, lib_stringlib;

d := DATASET([],AutoKeyB2.Layout_StName);

export Key_StName(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'StNameB2'),
					INDEX(d, {d}, TRIM(t)+'StNameB2' + '_' + doxie.Version_SuperKey));
import doxie, AutoKeyB, lib_stringlib;

d := DATASET([],AutokeyB.Layout_NameWords);

export Key_NameWords(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'NameWords'),
					INDEX(d, {d}, TRIM(t)+'NameWords' + '_' + doxie.Version_SuperKey));

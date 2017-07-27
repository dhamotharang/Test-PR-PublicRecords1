import doxie, AutoKeyB2, lib_stringlib;

d := DATASET([],AutoKeyB2.Layout_NameWords);

export Key_NameWords(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'NameWords2'),
					INDEX(d, {d}, TRIM(t)+'NameWords2' + '_' + doxie.Version_SuperKey));

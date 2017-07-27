import doxie, autokeyb2, lib_stringlib;

d := DATASET([],AutoKeyB2.Layout_Name);

export Key_Name(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'NameB2'),
					INDEX(d, {d}, TRIM(t)+'NameB2' + '_' + doxie.Version_SuperKey));
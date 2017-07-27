import doxie, AutoKey, lib_stringlib;

d := DATASET([],Autokey.Layout_StName);

export Key_StName(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'StName'),INDEX(d, {d}, TRIM(t)+'StName' + '_' + doxie.Version_SuperKey));
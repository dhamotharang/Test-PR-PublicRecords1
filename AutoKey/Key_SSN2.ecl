import doxie, AutoKey, lib_stringlib;

d := DATASET([],Autokey.Layout_SSN2);

export Key_SSN2(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'SSN2'),INDEX(d, {d}, TRIM(t)+'SSN2' + '_' + doxie.Version_SuperKey));
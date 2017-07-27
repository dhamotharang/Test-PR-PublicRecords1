import doxie, AutoKey, lib_stringlib;

d := DATASET([],Autokey.Layout_SSN);

export Key_SSN(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'SSN'),INDEX(d, {d}, TRIM(t)+'SSN' + '_' + doxie.Version_SuperKey));
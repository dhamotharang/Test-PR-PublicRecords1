import doxie, AutoKey, lib_stringlib;

d := DATASET([],Autokey.Layout_Zip);

export Key_Zip(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'Zip'),INDEX(d, {d}, TRIM(t)+'Zip' + '_' + doxie.Version_SuperKey));
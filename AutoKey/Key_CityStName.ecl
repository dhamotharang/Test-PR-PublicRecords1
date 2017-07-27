import doxie, AutoKey, lib_stringlib;

d := DATASET([],Autokey.Layout_CityStName);

export Key_CityStName(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'CityStName'),INDEX(d, {d}, TRIM(t)+'CityStName' + '_' + doxie.Version_SuperKey));
import doxie, AutoKeyB2, lib_stringlib;

d := DATASET([],AutoKeyB2.Layout_CityStName);

export Key_CityStName(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'CityStNameB2'),
					INDEX(d, {d}, TRIM(t)+'CityStNameB2' + '_' + doxie.Version_SuperKey));
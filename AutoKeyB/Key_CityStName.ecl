import doxie, AutoKeyB, lib_stringlib;

d := DATASET([],AutokeyB.Layout_CityStName);

export Key_CityStName(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'CityStnameB'),
					INDEX(d, {d}, TRIM(t)+'CityStNameB' + '_' + doxie.Version_SuperKey));
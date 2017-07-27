import doxie, AutoKeyB, lib_stringlib;

d := DATASET([],Autokeyb.Layout_Zip);

export Key_Zip(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'ZipB'),
					INDEX(d, {d}, TRIM(t)+'ZipB' + '_' + doxie.Version_SuperKey));
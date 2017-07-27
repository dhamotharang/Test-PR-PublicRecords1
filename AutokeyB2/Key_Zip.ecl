import doxie, AutoKeyB2, lib_stringlib;

d := DATASET([],AutoKeyB2.Layout_Zip);

export Key_Zip(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'ZipB2'),
					INDEX(d, {d}, TRIM(t)+'ZipB2' + '_' + doxie.Version_SuperKey));
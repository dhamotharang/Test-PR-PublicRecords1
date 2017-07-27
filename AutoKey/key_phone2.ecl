import doxie,Autokey, lib_stringlib;

d := DATASET([],Autokey.Layout_Phone2);

export Key_Phone2(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'Phone2'),INDEX(d, {d}, TRIM(t)+'Phone2' + '_' + doxie.Version_SuperKey));
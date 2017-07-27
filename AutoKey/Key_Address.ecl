import doxie,Autokey,lib_stringlib;

d := DATASET([],Autokey.Layout_Address);

export Key_Address(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'address'),INDEX(d, {d}, TRIM(t)+'Address' + '_' + doxie.Version_SuperKey));
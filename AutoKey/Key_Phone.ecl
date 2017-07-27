import doxie,Autokey,lib_stringlib;

d := DATASET([],Autokey.Layout_Phone);

export Key_Phone(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'Phone'),INDEX(d, {d}, TRIM(t)+'Phone' + '_' + doxie.Version_SuperKey));
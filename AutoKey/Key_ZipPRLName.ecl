import doxie, AutoKey, lib_stringlib;

d := DATASET([],Autokey.Layout_ZipPRLName);

export Key_ZipPRLName(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'ZipPRLName'),INDEX(d, {d}, TRIM(t)+'ZipPRLName' + '_' + doxie.Version_SuperKey, 
					opt)); //this opt is important because most datasets will not use this key
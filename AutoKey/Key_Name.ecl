import doxie,lib_stringlib,Autokey;

d := DATASET([],Autokey.Layout_Name);


export Key_Name(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'Name'),
					INDEX(d, {d}, TRIM(t)+'Name' + '_' + doxie.Version_SuperKey));
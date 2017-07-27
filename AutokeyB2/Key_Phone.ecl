import doxie, AutoKeyB2, lib_stringlib;

d := DATASET([],AutoKeyB2.Layout_Phone);

export Key_Phone(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'PhoneB2'),
					INDEX(d, {d}, TRIM(t)+'PhoneB2' + '_' + doxie.Version_SuperKey));
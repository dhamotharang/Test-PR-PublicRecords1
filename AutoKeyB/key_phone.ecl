import doxie, AutoKeyB, lib_stringlib;

d := DATASET([],AutokeyB.Layout_Phone);

export Key_Phone(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'PhoneB'),
					INDEX(d, {d}, TRIM(t)+'PhoneB' + '_' + doxie.Version_SuperKey));
import doxie, autokeyb2, lib_stringlib;

d := DATASET([],AutoKeyB2.Layout_FEIN);

export Key_FEIN(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'FEIN2'),
					INDEX(d, {d}, TRIM(t)+'FEIN2' + '_' + doxie.Version_SuperKey));
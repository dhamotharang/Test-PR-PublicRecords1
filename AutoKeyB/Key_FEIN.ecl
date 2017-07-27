import doxie, autokeyb, lib_stringlib;

d := DATASET([],Autokeyb.Layout_FEIN);

export Key_FEIN(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'FEIN'),
					INDEX(d, {d}, TRIM(t)+'FEIN' + '_' + doxie.Version_SuperKey));
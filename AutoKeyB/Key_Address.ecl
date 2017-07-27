import doxie,AutoKeyB, lib_stringlib;

d := DATASET([],AutokeyB.Layout_Address);

export Key_Address(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'AddressB'),
					INDEX(d, {d}, TRIM(t)+'AddressB' + '_' + doxie.Version_SuperKey));
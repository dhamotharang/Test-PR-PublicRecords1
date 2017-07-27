import doxie,AutoKeyB2, lib_stringlib;

d := DATASET([],AutoKeyB2.Layout_Address);

export Key_Address(STRING t) := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0,
					INDEX(d, {d}, TRIM(t)+'AddressB2'),
					INDEX(d, {d}, TRIM(t)+'AddressB2' + '_' + doxie.Version_SuperKey));
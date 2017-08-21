import okc_sexual_offenders;

export OnelineAddr(string state) := FUNCTION

ds := okc_sexual_offenders.OKC_Sex_Offender_Norm(orig_state=state);

Layout_out := record
	unsigned8 key;
	string1   name_type;
	OKC_Sexual_Offenders.Layout_OKC_Fixed_Altered;
	//unsigned8 fpos;
end;

addrp1(string address1) := stringlib.stringtouppercase(address1[1..25][1.. 25-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)]);
addrp2(string address1) := stringlib.stringtouppercase(address1[26-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)..length(trim(address1, left, right)) - stringlib.stringfind( StringLib.StringReverse(trim(address1, left, right)), ',', 1)]);

Layout_out RegAdd3Rem(ds l) := transform
self.registration_address_1 := if(regexfind('ADDRESS AS OF',stringlib.StringToUpperCase(l.registration_address_2),0)<>'',
								addrp1(l.registration_address_1),
								l.registration_address_1);
self.registration_address_2 := if(regexfind('ADDRESS AS OF',stringlib.StringToUpperCase(l.registration_address_2),0)<>'',
								addrp2(regexreplace(',',l.registration_address_1,' ')),
								l.registration_address_2);
self.registration_address_3 := if(regexfind('ADDRESS AS OF',stringlib.StringToUpperCase(l.registration_address_3),0)<>'',
								'',
								l.registration_address_3);
self := l;
end;

return project(ds, RegAdd3Rem(left));

END;
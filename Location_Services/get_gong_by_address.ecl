export get_gong_by_address(inf, attr, outf) := macro
import gong, location_services;


#uniquename(dk)
%dk% := Gong.key_address_current;


#uniquename(get_gong)
typeof(%dk%) %get_gong%(inf L, %dk% R) := transform
	self := R;
end;

#uniquename(df_history)
%df_history% := join(inf, %dk%,
			keyed(left.prim_name = right.prim_name) and
			keyed(left.st = right.st) and
			keyed(left.zip = right.z5) and
			keyed(left.prim_range = right.prim_range) and
			ut.nneq(left.sec_range, right.sec_range),
	   %get_gong%(LEFT,RIGHT), limit(50, skip));

#uniquename(df)
%df% := %df_history%;
#uniquename(norm_to_inf)
inf %norm_to_inf%(inf L, %df% R) := transform
	self.attr := L.attr + dataset([{R.phone10, R.phone10, R.listed_name, R.publish_code}],location_services.layout_phone);
	self := L;
end;


outf := denormalize(inf, dedup(sort(%df%, prim_range, prim_name, sec_range, z5, phone10, listed_name, publish_code),
						  prim_range, prim_name, sec_range, z5, phone10, listed_name, publish_code),
					left.prim_name = right.prim_name and
					left.st = right.st and
					left.zip = right.z5 and
					left.prim_range = right.prim_range and
					ut.nneq(left.sec_range, right.sec_range),
				%norm_to_inf%(LEFT,RIGHT));

endmacro;

import ut, lib_stringlib, AutoHeaderI;

export Functions := module

	export string AddOrdinal(string in_val) := function
		temp_val := trim(in_val);
		last_2 := temp_val[length(temp_val) - 1..length(temp_val)];
		last_1 := temp_val[length(temp_val)];
		return map(
			temp_val = '0' => in_val,
			last_2 in ['11','12','13'] => temp_val + 'TH',
			last_1 = '3' => temp_val + 'RD',
			last_1 = '2' => temp_val + 'ND',
			last_1 = '1' => temp_val + 'ST',
			last_1 in ['0','4','5','6','7','8','9'] => temp_val + 'TH',
			in_val);
	end;
	
	export ExtendedZips(AutoHeaderI.Types.zip_value zip_value,AutoHeaderI.Types.state_value state_value,AutoHeaderI.Types.city_value city_value ) :=
		zip_value + IF(state_value<>'' AND city_value<>'',ut.ZipsWithinCity(state_value,city_value),[]); 
	
	export string FilteredName(string in_val) := function
		return stringlib.stringfilter(in_val,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789');
	end;

end;

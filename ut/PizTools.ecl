import lib_stringlib;
export PizTools := module
	export reverseZip(string5 zip5) := (integer4)stringlib.stringreverse((string5)zip5);
	
	export reverseZipset(set of integer4 zipValues) := set(dataset(zipValues, {integer4 zip}), (integer4)stringlib.stringreverse(intformat(zip, 5, 1)));
end;
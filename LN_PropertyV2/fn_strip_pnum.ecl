// strip leading zeroes and any sort of punction -- to be used for indexing the parcel number
// and for processing the corresponding SOAP parameter before referencing the index.
//
// optionally strip trailing zeroes; useful for dedup/rollup once we've got an answer set.

export fn_strip_pnum(string pnum, boolean stripTrailing=false) := function

	clean := stringlib.stringfilter(pnum,
		'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
	
	// note: these patterns rely on "greedy" matching
	pat := if(stripTrailing, '([^0].*[^0])', '([^0].*)');
	stripped := regexfind(pat, clean, 0);
	
	upper := StringLib.StringToUpperCase(stripped);

	return upper;
end;
// Strip "vanity" terms from a company name; useful to avoid double-counting terms when matching
//
// It would be nice to tie the search/replace to word boundaries, but not so nice that it's worth
// introducing the performance penalty of using regular expressions. We do assert that vanity terms
// have to be at least 3 chars long... stripping based on just an initial or a couple letters would
// be too aggressive.

EXPORT fn_devanitize(string cname, string fname, string lname) := FUNCTION
	ds1 := IF(LENGTH(TRIM(fname))>=3, stringlib.stringfindreplace(cname, TRIM(fname), ''), cname);
	ds2 := IF(LENGTH(TRIM(fname))>=3, stringlib.stringfindreplace(ds1, BIPV2_Tools.fn_PreferredName(fname), ''), ds1);
	ds3 := IF(LENGTH(TRIM(lname))>=3, stringlib.stringfindreplace(ds2, TRIM(lname), ''), ds2);
	RETURN TRIM(ds3,LEFT);
END;
import NID, Address;

// only want any names that are populated, but don't contain numbers, parens, etc.
// only use current residential records that have good data
boolean isGoodName(string lname) := LENGTH(TRIM(lname)) > 0 AND TRIM(stringlib.stringfilter(lname,'@.0123456789()"')) = '';
fgf := File_Gong_Full_Prepped_For_Keys(listing_type_res = 'R' AND isGoodName(name_last));
Nid.Mac_CleanParsedNames(fgf, f_clean, name_first,name_middle,name_last,name_suffix); 
good_names := PROJECT(f_clean(nametype='P',listed_name NOT IN Surname_Overrides,NOT REGEXFIND('\\b(FOR|UNLISTED|UNPUBLISHED|BLOCKED)\\b',listed_name)), layout_gong);

slim_rec := RECORD
	good_names.name_last;
	good_names.st;
END;

good_names_slim := PROJECT(good_names, slim_rec);

good_names_dist := DISTRIBUTE(good_names_slim, HASH(name_last, st));

EXPORT ds_surname_cnts := TABLE(good_names_dist, {name_last, st, cnt := COUNT(GROUP)}, name_last, st, LOCAL);

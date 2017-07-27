df := dataset('~thor_data400::base::prof_licenses_BUILDING',layout_proflic_out,flat);


// layout doxie is the same as layout_proflic_out, as far as i can see
// so this has no effect.
/*
layout_doxie into(df L) := transform
	self := l;
end;
*/

export file_keybase := df;
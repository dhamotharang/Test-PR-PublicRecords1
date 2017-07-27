// Indicate whether a given ln_fares_id is associated with a deed (D) or an assessment (A)

import LN_PropertyV2;

t := typeof(LN_PropertyV2.key_assessor_fid().ln_fares_id);

export string1 fn_fid_type(t ln_fares_id) := case(
	ln_fares_id[2],
	'D' => 'D',
	'M' => 'D',
	'A' => 'A',
	''
);
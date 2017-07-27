export string8 fn_fid_type_desc(string1 fid_type) := case(
	fid_type,
	'A' => 'Assessed',
	'D' => 'Deed',
	''
);
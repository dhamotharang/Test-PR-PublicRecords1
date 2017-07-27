export Documentation := '';
/*
	First, create new base file layouts for all datasets.
	then, convert the base files of the existing datasets(not new) to the new layout.
	This includes corp, cont, event.
	Then, make some corp_update_xxx attributes to merge the new layout input files with these newly converted 
	base files.
	Then, with the new datasets(AR and Stock), make base file layouts for them.
	then, make corp_update_xxxx attributes to make them into base files.
	then, create roxie keys on all new base files.

*/
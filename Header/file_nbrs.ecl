myrec := record
	unsigned6	did1;
	unsigned6	nbr_did1;
	unsigned6	nbr_did2;
	unsigned6	nbr_did3;
	unsigned6	nbr_did4;
	unsigned6	nbr_did5;
	unsigned6	nbr_did6;
	unsigned2	prim_range;
end;

export file_nbrs := dataset('~thor_data400::base::nbrs',myrec,flat);

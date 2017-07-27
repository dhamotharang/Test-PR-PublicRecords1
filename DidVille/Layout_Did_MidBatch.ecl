export Layout_Did_MidBatch := record
	Didville.Layout_Did_OutBatch;
	integer4 mob;
	integer1 dayob;
	unsigned2	ssn4;
	unsigned1	age;
	unsigned4	match_score := 0;
	unsigned6	sub_did := 0;
	unsigned1	sub_score := 0;
	boolean	NN_cand := false;
end;
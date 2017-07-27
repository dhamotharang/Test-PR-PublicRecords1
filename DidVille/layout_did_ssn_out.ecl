export layout_did_ssn_out := record
	didville.Layout_Did_InBatch;
	unsigned6	did;
	unsigned1	score;
	string9		ssn_appended;
	unsigned1	ssn_perms;
end;
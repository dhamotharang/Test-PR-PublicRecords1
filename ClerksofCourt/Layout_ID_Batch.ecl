import didville;

export Layout_ID_Batch :=
RECORD
	unsigned6 did := 0;
     unsigned2 score := 0;
     didville.layout_did_inbatch;
	unsigned2 head_cnt;
	unsigned6 bdid;
     unsigned2 bdid_score;
	STRING120 name;
	string15  pid;
	string20	ucn;
	UNSIGNED2 county_code;
	STRING18 county_name;
	STRING25 DLNum;
	BOOLEAN well_behaved;
END;
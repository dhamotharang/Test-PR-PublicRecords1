EXPORT Layout_LAB_Pairs
	:= RECORD
		unsigned8  did;
		unsigned8  rid;
        unsigned8  alpha_rid;
		string1    ssn_ind;
		string1    dob_ind;
		string2    addr_ind;
		string1    dlno_ind;
		unsigned2  source_cnt;
		unsigned2  ins_source_cnt;
		string5 addressstatus;
		string3 addresstype;
		string1 best_addr_ind;
		string1 ambiguous;
END;


export layout_search_out := MODULE

export address :=
RECORD
	STRING100 country;
	STRING50 addr_1;
	STRING50 addr_2;
	STRING50 addr_3;
	STRING50 addr_4;
	STRING50 addr_5;
	STRING50 addr_6;
	STRING50 addr_7;
	STRING50 addr_8;
	STRING50 addr_9;
	STRING50 addr_10;
END;

export remark :=
RECORD
  STRING75 remark_v;
END;

export aka :=
RECORD
	UNICODE350 orig_pty_name;
	STRING5 score;
END;

export parent := 
RECORD
	STRING5 score;
	STRING20 pty_key;
	STRING60 source;
	UNICODE350 orig_pty_name;
	STRING1 record_type := '';
	UNICODE100 blocked_country;
	DATASET(aka) AKAs {MAXCOUNT(10)};
	DATASET(address) Addresses {MAXCOUNT(10)};
	DATASET(remark) Remarks {MAXCOUNT(30)};
END;

END;
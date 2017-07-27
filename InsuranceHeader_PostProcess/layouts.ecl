export layouts := module

export layout_stats_extend :=  record
	string		name;
	string 		value1;
	string 		value2;
	string 		value3;
end;

export layout_did_rid_srcd := record
  layout_did_rid,
	string9 src;
	unsigned6 rec_cnt;
	unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
end;

 Export DL := record
	UNSIGNED8 	DID;
	STRING5			TITLE;
	STRING20		FNAME;
	STRING20		MNAME;
	STRING28		LNAME; 
	STRING5			SNAME;
	UNSIGNED4		DOB;
	STRING25		DL_NBR;
	STRING2			DL_STATE;
	STRING9			SRC;
	UNSIGNED4		DT_FIRST_SEEN;
	UNSIGNED4		DT_LAST_SEEN;
 end ; 
 
end;
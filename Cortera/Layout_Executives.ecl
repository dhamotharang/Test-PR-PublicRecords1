import address, BIPV2;
EXPORT Layout_Executives := RECORD
	Cortera.Layout_Header_Out;
	integer		cnt;
	string		EXECUTIVE_NAME {maxlength(250)};	//	VARCHAR2(250)	Executive Name
	string	  EXEC_TITLE{maxlength(250)};						//	VARCHAR2(250)	Executive Title
	string5		cln_title := '';
	string20	cln_fname := '';
	string20	cln_mname := '';
	string20	cln_lname := '';
	string5		cln_suffix := '';
	unsigned8	nid := 0;
	string1		nametype := '';
	unsigned6	LexId := 0;
	unsigned1	LexId_Score := 0;	
END;
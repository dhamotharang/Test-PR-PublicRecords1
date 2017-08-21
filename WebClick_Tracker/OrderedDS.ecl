import ut;
		
base_rec :=RECORD
	string1 source;
	string companyid;
	String3   vert;
	string20  loginid;
	string32  session_id;
	string45  event;
	integer   sorder;
	integer date_accessed;
	string8 time_accessed;
END;

base_rec xfm_r(layout_wc_filein L, integer C) := TRANSFORM
		self.source := L.source;
		SELF.event := StringLib.StringToUpperCase((string45)CHOOSE(C, L.event1, L.event2, L.event3));
		SELF.sorder := C;
		SELf.companyID := L.CompanyID;
		SELF.vert      := L.vert;
		SELf.loginID := (String20)L.LoginID;
		SELf.session_ID := (String32)L.session_ID;
		SELf.time_accessed :=  StringLib.StringExtract(
																	 StringLib.StringFindReplace(L.time_accessed, ' ',','),2);
  	SELF.date_accessed := (integer)StringLib.StringFindReplace(
		                               StringLib.StringExtract(
																	 StringLib.StringFindReplace(L.time_accessed, ' ',','),1), '-','');
END;


ds_csv := Webclick_tracker.WC_FileIn;
ds_sorted  := SORT(ds_csv((LENGTH(TRIM(session_id))=24 or
						LENGTH(TRIM(session_id))=32)and session_id<>''),companyid,loginid,session_id,time_accessed);
ds_norm  := NORMALIZE(ds_sorted,3,xfm_r(LEFT,COUNTER));
WC_File_In := ds_norm(event<>'');



DSG:=group(dedup(SORT(distribute(WC_File_In,hash(session_id)),session_id,date_accessed,time_accessed,sorder,local),record,local),session_id);
NewR:=record
	string1 source;
    string20 companyID;
		String3 vert;
		string32 session_id;
		string45 event;
		integer order;
  	STRING20 loginid;
	  integer date_accessed;
	  integer hrs;
	  integer mins;		
end;
NewR f(recordof(WC_File_In) L, integer C):=transform
			self.order:=C;
			self.companyid := l.companyid;
		  SELf.hrs:=  (integer)StringLib.StringExtract(StringLib.StringFindReplace(L.time_Accessed,':',','),1);
		  SELf.mins:=  (integer)StringLib.StringExtract(StringLib.StringFindReplace(L.time_accessed,':',','),2);				
			self:=L;
end;


export OrderedDS:=group(project(DSG,f(left,counter)));


// in future infile + base file

// OrderedDS_new := OrderedDS + OrderedDSFPos;


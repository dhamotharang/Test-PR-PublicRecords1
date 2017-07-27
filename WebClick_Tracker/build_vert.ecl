
    
		//input_rec
vert_rec := RECORD
	string1 source;
	String3 vert;
	String32 Session_ID;
END;

int_ds := DEDUP(SORT(PROJECT(WEbClick_Tracker.OrderedDSFPos(vert<>''),vert_rec),vert,source,session_id),vert,source,session_id);



		
EXPORT build_vert := int_ds;


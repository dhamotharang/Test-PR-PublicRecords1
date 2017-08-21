export layouts := 
MODULE
export rec_WU_filesread := record
string name ;
string cluster;
boolean issuper;
integer usage;
end;

export rec_WU_messages := record

integer severity;
integer code;
string location;
integer row;
integer col;
string source;
string  time;
string message;
end; 

export rec_WU_timings := record
integer count;
integer duration;
integer max;
string name;
end; 

export rec_log := record
		string20  wuid := '';
		string20  cluster := '';
		string20  platform := '';
		string50  jobname := '';
		string50  jobowner := '';
		string8   start_time := '';
		string8   stop_time := '';
		decimal8_5   thor_time := 0;
		unsigned6 total_count := 0;
		unsigned6 DID_count := 0;
		unsigned2  low_score_threshold := 0;
		string8   xADL_version := '';
		decimal2_1   ECL_version := 0;
		decimal10_3  throughput := 0;
		string25   matchset := '';
		decimal8_5   total_thor_time := 0;
		string25   ADL_route := '';
		string25   filler4 := '';
		string25   filler5 := '';
		unsigned6  filler6 := 0;
		unsigned6  filler7 := 0;
		unsigned6  filler8 := 0;
		unsigned6  filler9 := 0;
		unsigned6  filler10 := 0;
		
	END;

export base_log := record
rec_log;
	    dataset(rec_WU_filesread)   WUfilesRead;
        dataset(rec_WU_messages)    WUmessages;
		dataset(rec_WU_timings)     WUtimings;

end;

END;
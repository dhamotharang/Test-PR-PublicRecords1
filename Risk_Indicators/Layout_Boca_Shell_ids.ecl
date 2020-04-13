export Layout_Boca_Shell_ids := 
RECORD
			unsigned4 seq;
			unsigned3 historydate;
			unsigned6 did;
			boolean isrelat;
			STRING20 fname;
			STRING20 lname;
			STRING20 relation;
			$.Layout_Overrides;
			boolean skip_opt_out := false;
END;
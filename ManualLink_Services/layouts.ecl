export layouts := 
MODULE

	export rec_RID :=
	RECORD
		unsigned6 RID;
	END;

	export Overlink :=
	RECORD
		unsigned6 ADL;
		dataset(rec_RID) RIDs {maxcount(500)};
		string50  user_reported;
		string8   date_reported;
		string6   time_reported;
		unsigned6 bug_number;
		string8   date_applied_to_header;
		string6   time_applied_to_header;
		string50  user_applied_to_header;
		string200 comments_by_user_reported;
	END;
	
	export OverlinkDisplay :=
	RECORD
		Overlink - [RIDs];
		string10 RIDs := 'not shown';
	END;

END;
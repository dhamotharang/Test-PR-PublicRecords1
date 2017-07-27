export Layout_6000_Inquiries_Base_Rolled :=
MODULE

	export child :=
	RECORD
		string4 INQ_YYMM;
		string3 INQ_COUNT;
	END;

	export parent :=
	RECORD
		string4 BUS_CODE;
		string10 BUS_DESC;
		DATASET(child) Counts {MAXCOUNT(constants.maxcounts.Inquiry_counts)};
	END;

	export top_level :=
	RECORD
		STRING4 INQ_YYMM_MIN;
		STRING4 INQ_YYMM_MAX;
		DATASET(parent) Inquiries {MAXCOUNT(constants.maxcounts.Inquiry_history)};
	END;
END;
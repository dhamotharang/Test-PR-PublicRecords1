EXPORT Layouts := MODULE

	EXPORT ResultsFile := RECORD
		string sourcename;
		string buildversion;
		integer8 totaldatasetsize;
		integer8 volume_change;
		integer8 volume_change_lower;
		integer8 volume_change_upper;
		integer8 samplesize;
		decimal8_2 samplesizepercent;
		string rulename;
		string ruletype;
		string rulemeaning;
		string fieldname;
		decimal8_2 lowerlimit;
		decimal8_2 upperlimit;
		decimal8_2 matchpercent;
		decimal8_4 zscore;
		string finalconclusion;
		string detailedreportname;
		string wuid;
	END;

END;

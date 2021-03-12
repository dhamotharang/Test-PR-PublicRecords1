import iesp;

export SourceCount_Layouts := module

	export SourceDetailsLayout := record
		string13	src;
		string50	src_desc;
		boolean		hasName  := false; 
		boolean		hasSSN   := false;
		boolean		hasDOB   := false;
		boolean		hasFEIN  := false;		
		boolean		hasAddr  := false;
		boolean		hasPhone := false;
		unsigned		dt_first_seen;
		unsigned		dt_last_seen;
	end;
	
	export SourceDetailLayout := record
		string50 src; // NOTE: for ESP purposes, this will actually contain the description
		unsigned occurrences;
		unsigned dt_first_seen;
		unsigned dt_last_seen;
	end;
	
	export SummaryLayout := record
		string5											cat_type;
		unsigned1										num_sources;
		dataset(SourceDetailLayout)	sources {MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_SOURCE_SOURCES)};
	end;
	
	export OptionsLayout := record
		iesp.topbusinesssourcecount.t_TopBusinessSourceCountOption;
		string32  app_type;
		string6 	ssn_mask;
		string1		fetch_level;
    boolean   IncludeVendorSourceB;
    boolean   IncludeAssignmentsAndReleases;
	end;

end;
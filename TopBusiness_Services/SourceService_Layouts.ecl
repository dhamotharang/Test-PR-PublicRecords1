import iesp;

export SourceService_Layouts := module

	export InputLayout := record
		string25 acctno;
		iesp.topbusinesssourcedoc.t_TopBusinessSourceDocBy;
	end;
	
	export OptionsLayout := record
		string32  app_type;
		string6 	ssn_mask;
		string1		fetch_level;
    boolean   IncludeVendorSourceB;
    boolean   IncludeAssignmentsAndReleases;
	end;
	
	export OutputLayout := record
		InputLayout.acctno;
	  iesp.topbusinesssourcedoc.t_TopBusinessSourceDocRecord;
	end;

end;

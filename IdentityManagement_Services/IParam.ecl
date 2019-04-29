/***
 ** Module to define parameter interface for selection of desired reports. Each defaults to 'false' unless requested.
***/
import PersonReports;

export IParam := module
  export _include := INTERFACE
    export boolean include_personreport := false;
    export boolean include_driverslicenses := false;
    export boolean include_motorvehicles := false;
		export boolean include_relatives := false;
		export boolean include_neighbors := false;
		export boolean include_associates := false;
    export boolean include_histphones := false;
    export boolean include_properties := false;
		export boolean include_studentrecords := false;
    export boolean include_watercrafts := false;
		export boolean include_noregulatedwatercrafts := false;
		export boolean include_aircrafts := false;
		export boolean include_peopleatwork := false;
		export boolean include_corporateaffiliations := false;
		export boolean include_emailaddresses := false;
		export boolean include_transactionhistory := false;
		export boolean include_realtimevehicle := false;
		export boolean include_noregulatedvehicles := false;
		export boolean include_professionallicenses := false;
		export boolean include_InternetDomains := false;
		export boolean include_InsuranceDL := false;
		export string RealTimePermissibleUse := '';
		export unsigned2 LinkingWeightThreshold := 0;
  end;

	export _report := INTERFACE (PersonReports.IParam._report, PersonReports.IParam.relatives,
															 PersonReports.IParam.neighbors, _include)
		export boolean SuppressCompromisedDLs := false;
	end;

	export _search := INTERFACE
		export boolean include_hri   := false;
		export boolean use_saltFetch := false;
	end;

end;

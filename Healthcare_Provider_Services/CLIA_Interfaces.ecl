EXPORT CLIA_Interfaces := MODULE

	export clia_config := interface
		export unsigned4 MaxRecordsPerRow := 4;
		export unsigned4 penalty_threshold := 10;
		export string applicationType := '';
	end;

end;
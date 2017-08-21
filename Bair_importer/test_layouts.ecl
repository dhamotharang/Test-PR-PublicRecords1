EXPORT test_layouts := MODULE

	export orbit_receivings  := record
		string ReceivingID;
		string Filename;
	end;

	export orbit_build := record
		string BuildName;
		string BuildVersion;
		string PreppedAgencyBuildVersion;
		string ReProcessFlag;
		string LandingZone;
		string FileType;
		string FileExtension;
		string Agency;
		dataset(orbit_receivings) Receivings;
	end;
	
END;


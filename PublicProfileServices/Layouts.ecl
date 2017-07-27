IMPORT doxie,iesp;

EXPORT Layouts := MODULE

	EXPORT srchRecord := RECORD
		BOOLEAN validSrch;
		SET OF STRING srchBy {MAXLENGTH(Constants.MAX_LEN)};
		STRING30  FirstName;
		STRING30  MiddleName;
		STRING30  LastName;
		STRING11  SSN;
		UNSIGNED8 DOB;
		STRING200 Addr;
		STRING25  City;
		STRING2   State;
		STRING6   Zip;
	END;
	
	EXPORT didRecord := RECORD
		UNSIGNED2 seq;
		SET OF STRING SrchBy {MAXLENGTH(Constants.MAX_LEN)};
		doxie.layout_references_hh;
	END;

	EXPORT hdrDidRecord := RECORD
		UNSIGNED2 seq;
		DATASET(didRecord) didRecs {MAXCOUNT(Constants.MAX_DIDS)};
	END;

	EXPORT hdrRollupRecord := RECORD
		doxie.Layout_Rollup.KeyRec;
		UNSIGNED2 SSNCount;
		UNSIGNED2 DOBCount;
	END;

	EXPORT hdrSumRecord := RECORD
		iesp.public_profile_report.t_SSNResults SSNResults;
		iesp.public_profile_report.t_NameSSNResults NameSSNResults;
		iesp.public_profile_report.t_NameDOBResults NameDOBResults;
		iesp.public_profile_report.t_AddressResults AddressResults;
		iesp.public_profile_report.t_NameAddressResults NameAddressResults;
		iesp.public_profile_report.t_CombinationResults CombinationResults;
	END;

	export myDemoRec := Record
		STRING12  UniqueID;
		STRING30  FirstName;
		STRING30  MiddleName;
		STRING30  LastName;
		STRING11  SSN;
		integer2  DOB_MONTH;
		integer2  DOB_DAY;
		integer2  DOB_YEAR;
		STRING60  Addr;
		STRING25  City;
		STRING2   State;
		STRING5   Zip;
	end;

END;
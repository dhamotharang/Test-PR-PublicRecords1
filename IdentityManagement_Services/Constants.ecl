/***
 ** IdentityManagement_Services.Constants
 ** Define a few constants for use in IdentityManagement Services
 ***/

export Constants := module

		// no more than this many addresses for relatives
		export Integer MaxRelativeAddresses := 10;

		// no persons not seen in this long
		export Integer MaxYearsSinceLastSeen := 30;
		
		// restrict how many SSN's can be associated with a DID
		export Integer MaxSSNperDID := 500;

		// include Deeds in this set of Deed Types, exclude others
		export SET of String2 IncludedDeedTypes := [ 'G', 'T', 'CD', 'DE', 'GD', 'JT', 'LW', 'SV', 'SW', 'TS', 'WD', '' ];
		
		// exclude these Standardized_Land_Use_Code type of records
		export SET of string ExcludedStandardizedLandUseCodes := ['2000','0015','8002','9210','9200','3003',
																																	 '8004','521','5000','5003','0025','9212',
																																	 '0019','1016','7004','0513'];

		
		// defenestrate lienholders with a name in this set
		export SET of String LienHoldersToExclude := ['NOT AVAILABLE', 'NO ACTIVE LIENS ON FILE',
		                            'NO LIENS ON FILE', 'NOT ON FILE', 'UNKNOWN LIENHOLDER',
		                            'LIENHOLDER NUMBER', 'UNKNOWN', 'AS AGENT', 'AS AGT'
			                          ];

		// defenestrate watercraft the size of aircraft carriers
		export Integer MaxWatercraftLen := 1200; // value in inches, 100 feet

		// minimum number of Cohabits for an associate to be considered
		export Integer MinAssociateCohabits := 10;

		// maximum age beyond which a relative/associate is considered too close to death
		export Integer MaxAgeNearDeath := 100;
		
		// maximum number of hris per address
		export Integer MaxHriPerAddr := 10;

		// this pattern rejects controversial names in companies. - (F12-Functions)
		export DebatableNames := '(KKK|KU|KLUX|KLAN|ARYAN|ARIAN|CLAN|BLOOD|NAZI|MILITIA|MILITIAS|CHURCH|TEMPLE|MOSQUE|JESUS|GOD|ALLAH|AKBAR|MUSLIM|JEWISH|JEW|CHRISTIAN|PART TIME JOB)';
		
		// death_codes for a deceased person, V= verified, P=proof (death certificate)
		export DeathCodes := ['V', 'P'];

		// search service constants (F12-FetchDIDs)	
		export unsigned2 MAX_DL_RECORDS := 500;
		export unsigned2 MAX_DIDS_PER_SSNS := 100;
		export unsigned2 MAX_DIDS_PER_NAMES := 200;
		export unsigned2 MAX_DIDS_PER_PHONES := 100;
		export unsigned2 MAX_DIDS_PER_DOBS := 100;
		export unsigned2 MAX_DIDS_PER_ADDRS := 100;
		export unsigned2 lost_in_header := 7;
		
		//Insurance DL Constant
		export unsigned INS_MAX_RECORD_PER_DID := 100; //W20151211-091127 - currently most high volume DIDs have a TON of redundant records. 
		//I am asking Manish about those and then hopefully once this is fixed I can recalculate a more appropriate limit
end;
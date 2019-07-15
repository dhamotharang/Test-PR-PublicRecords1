
import risk_indicators, iesp, identifier2, address;

export GetIdentifier2(DATASET (risk_indicators.Layout_InstantID_NuGenPlus) iid_results, string20 TestDataTableName) := FUNCTION

	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	iesp.instantid.t_WatchList xform_wl( risk_indicators.layouts.layout_watchlists_plus_seq le ) := transform
		self.Table                  := le.Watchlist_Table;
		self.RecordNumber           := le.Watchlist_Record_Number;
		self.Name.First             := le.Watchlist_fname;
		self.Name.Last              := le.Watchlist_lname;
		self.Name                   := [];
		self.Address.StreetAddress1 := le.Watchlist_address;
		self.Address.City           := le.Watchlist_City;
		self.Address.State          := le.Watchlist_State;
		self.Address.Zip5           := le.Watchlist_zip;
		self.Country                := le.Watchlist_contry;
		self.EntityName             := le.Watchlist_Entity_Name;

		clean := risk_indicators.MOD_AddressClean.clean_addr( le.Watchlist_address, le.Watchlist_City, le.Watchlist_State, le.Watchlist_zip );
		cf := Address.CleanFields(clean);

		self.Address.StreetNumber         := cf.prim_range;
		self.Address.StreetPreDirection   := cf.predir;
		self.Address.StreetName           := cf.prim_name;
		self.Address.StreetSuffix         := cf.addr_suffix;
		self.Address.StreetPostDirection  := cf.postdir;
		self.Address.UnitDesignation      := cf.unit_desig;
		self.Address.UnitNumber           := cf.sec_range;
		// self.Address.StreetAddress1       := le.Watchlist_address;
		self.Address.StreetAddress2       := '';
		// self.Address.City                 := cf.p_city_name;
		// self.Address.State                := cf.st;
		// self.Address.Zip5                 := cf.zip;
		self.Address.Zip4                 := cf.zip4;
		self.Address.County               := cf.county[3..5];
		self.Address.PostalCode           := '';
		self.Address.StateCityZip         := '';
		self.sequence 							 := le.seq;
	end;
	
	identifier2.layout_Identifier2 add_identifier2(iid_results le, seed_files.Key_Identifier2 rt) := transform			
		self.InputSSNMatchesLastAndDOB.InputSSNMatchesLastAndDOB := (boolean)(unsigned)rt.InputSSNMatchesLastAndDOB; 
		self.InputSSNMatchesLastAndDOB.RiskIndicators := row({rt.InputSSNMatchesLastAndDOB_riskindicator,rt.InputSSNMatchesLastAndDOB_riskindicatordescription},iesp.share.t_RiskIndicator) ; 
    self.DiscoveredDOB.DOBDiscovered := rt.DiscoveredDOB_DOBDiscovered;
    self.InputAddressEverOccupant.WasEverOccupant := rt.InputAddressEverOccupant_WasEverOccupant;
		self.passportValidated := le.passportValidated='Y';
		self.watchlists := project( le.watchlists, xform_wl(left) );
		self.DOBMatchLevel := (integer)le.dobmatchlevel;		//***KWH - CIV
		self := le;
		self := [];
	end;
	
	// Join the input data to the identifer2 key
	with_identifier2 := Join(iid_results, seed_files.Key_Identifier2,  
		keyed(right.table_name=Test_Data_Table_Name) and 
		keyed(right.hashvalue=Seed_Files.Hash_InstantID((string20)left.fname,(string20)left.lname,
			(string9)left.ssn,Risk_Indicators.nullstring,
			(string5)left.in_zipCode,
			(string10)left.phone10,Risk_Indicators.nullstring)), 
		add_identifier2(LEFT, RIGHT), LEFT OUTER, KEEP(1));
	
	RETURN with_identifier2;
END;

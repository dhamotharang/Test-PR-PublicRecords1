EXPORT macAnonymizeAddress(Input, InPrimaryRange='',InPreDirectional='',InPrimaryName='',InAddressSuffix='',InPostDirectional='',
		InUnitDesignation='',InSecondaryRange='',InPCity='',InVCity='',InState='',Inzip='',Inzip4='',InCounty='',
		InGeoBlock='',InLatitude='',InLongitude='',
		TargetZip='11208', TargetRadius = 100, SeedListSize = 5000000) := FUNCTIONMACRO

	IMPORT Address_Attributes, WatchDog, lib_StringLib, AppendCleanAddress, ut, ComputeConcatenatedColumn, ComputeSearchString, STD, doxie, Address_clean;

	// Fetch Zips witin the radius of the input zip. 
	ZipList := ziplib.zipswithinradius((STRING)TargetZip,(INTEGER)TargetRadius);
	
	//Creating a target set from the clean address key
	TargetSet := DEDUP(SORT(Address_clean.key_clean((INTEGER)zip5 in ZipList), HASH32(Line1, LineLast)), HASH32(Line1, LineLast)) : PERSIST('~temp::deletemeanon1');
	
	dOut := JOIN(Input, TargetSet,  
	(HASH32(#IF(#TEXT(InPrimaryRange) != '')(STRING)LEFT.InPrimaryRange,#END
		#IF(#TEXT(InPreDirectional) != '')(STRING)LEFT.InPreDirectional,#END 
		#IF(#TEXT(InPrimaryName) != '')(STRING)LEFT.InPrimaryName,#END
		#IF(#TEXT(InAddressSuffix) != '')(STRING)LEFT.InAddressSuffix,#END 
		#IF(#TEXT(InPostDirectional) != '')(STRING)LEFT.InPostDirectional,#END
		#IF(#TEXT(InUnitDesignation) != '')(STRING)LEFT.InUnitDesignation,#END
		#IF(#TEXT(InSecondaryRange) != '')(STRING)LEFT.InSecondaryRange,#END
		#IF(#TEXT(InVCity) != '')(STRING)LEFT.InVCity,#END
		#IF(#TEXT(InState) != '')(STRING)LEFT.InState,#END
		#IF(#TEXT(Inzip) != '')(STRING)LEFT.Inzip#END) % SeedListSize) = 
		(HASH32(RIGHT.Line1, RIGHT.LineLast) % SeedListSize), 
	 TRANSFORM(RECORDOF(LEFT), 
			#IF(#TEXT(InPrimaryRange) != '')
				SELF.InPrimaryRange := (TYPEOF(LEFT.InPrimaryRange))RIGHT.prim_range, 
			#END
			#IF(#TEXT(InPreDirectional) != '')
				SELF.InPreDirectional := (TYPEOF(LEFT.InPreDirectional))RIGHT.predir, 
			#END
			#IF(#TEXT(InPrimaryName) != '')
				SELF.InPrimaryName := (TYPEOF(LEFT.InPrimaryName))RIGHT.prim_name,
			#END
			#IF(#TEXT(InAddressSuffix) != '')
				SELF.InAddressSuffix := (TYPEOF(LEFT.InAddressSuffix))RIGHT.addr_suffix,
			#END
			#IF(#TEXT(InPostDirectional) != '')
				SELF.InPostDirectional := (TYPEOF(LEFT.InPostDirectional))RIGHT.postdir,
			#END
			#IF(#TEXT(InUnitDesignation) != '')
				SELF.InUnitDesignation := (TYPEOF(LEFT.InUnitDesignation))RIGHT.unit_desig,
			#END
			#IF(#TEXT(InSecondaryRange) != '')
				SELF.InSecondaryRange := (TYPEOF(LEFT.InSecondaryRange))RIGHT.sec_range,
			#END
			#IF(#TEXT(InPCity) != '')
				SELF.InPCity := (TYPEOF(LEFT.InPCity))RIGHT.v_city_name,
			#END
			#IF(#TEXT(InVCity) != '')
				SELF.InVCity := (TYPEOF(LEFT.InVCity))RIGHT.v_city_name,
			#END
			#IF(#TEXT(InState) != '')
				SELF.InState := (TYPEOF(LEFT.InState))RIGHT.st, 
			#END
			#IF(#TEXT(Inzip) != '')
				SELF.Inzip := (TYPEOF(LEFT.Inzip))RIGHT.zip5,
			#END
			#IF(#TEXT(Inzip4) != '')
				SELF.Inzip4 := (TYPEOF(LEFT.Inzip4))RIGHT.zip4,
			#END
			#IF(#TEXT(InCounty) != '')
				SELF.InCounty := (TYPEOF(LEFT.InCounty))RIGHT.county,
			#END
			#IF(#TEXT(InGeoBlock) != '')
				SELF.InGeoBlock := (TYPEOF(LEFT.InGeoBlock))RIGHT.geo_blk, 
			#END
			#IF(#TEXT(InLatitude) != '')
				SELF.InLatitude := (TYPEOF(LEFT.InLatitude))RIGHT.geo_lat, 
			#END
			#IF(#TEXT(InLongitude) != '')
				SELF.InLongitude := (TYPEOF(LEFT.InLongitude))Right.geo_long,
			#END
			SELF := LEFT),
		KEEP(1), HASH);

	RETURN dOut;
ENDMACRO;
//inData		- this is the input dataset
//UseIndexThreshold - this sets the cut over record count switching between 
//addr1 corresponds to the unparsed street address
//addr2 corresponds to the unparsed city, st zip

EXPORT mac_CleanAddress(inData, UseIndexThreshold=5000000, addr1_field, addr2_with_city_st_zip_field='', addr2_field='', incity='', instate='', inzip='', appendPrefix='Address') := FUNCTIONMACRO

IMPORT AppendCleanAddress; 
IMPORT lib_stringlib;

	rFinal := RECORD
		INTEGER #EXPAND(appendPrefix + 'seq');
		RECORDOF(inData);
    string10 #EXPAND(appendPrefix + 'PrimaryRange'); 	// [1..10]
		string2 #EXPAND(appendPrefix + 'PreDirectional');		// [11..12]
		string28 #EXPAND(appendPrefix + 'PrimaryName');	// [13..40]
		string4 #EXPAND(appendPrefix + 'AddressSuffix');  // [41..44]
		string2 #EXPAND(appendPrefix + 'PostDirectional');		// [45..46]
		string10 #EXPAND(appendPrefix + 'UnitDesignation');	// [47..56]
		string8 #EXPAND(appendPrefix + 'SecondaryRange');	// [57..64]
		string25 #EXPAND(appendPrefix + 'PostalCity');	// [65..89]
		string25 #EXPAND(appendPrefix + 'VanityCity');  // [90..114]
		string2 #EXPAND(appendPrefix + 'State');			// [115..116]
		string5 #EXPAND(appendPrefix + 'Zip');		// [117..121]
		string4 #EXPAND(appendPrefix + 'Zip4');		// [122..125]
		string2 #EXPAND(appendPrefix + 'DBPC');		// [136..137]
		string1 #EXPAND(appendPrefix + 'CheckDigit');	// [138]
		string2 #EXPAND(appendPrefix + 'RecordType');	// [139..140]
		string5 #EXPAND(appendPrefix + 'County');		// [141..145]
		string10 #EXPAND(appendPrefix + 'Latitude');		// [146..155]
		string11 #EXPAND(appendPrefix + 'Longitude');	// [156..166]
		string4 #EXPAND(appendPrefix + 'Msa');		// [167..170]
		string7 #EXPAND(appendPrefix + 'GeoBlock');		// [171..177]
		string1 #EXPAND(appendPrefix + 'GeoMatchCode');	// [178]
		string4 #EXPAND(appendPrefix + 'ErrorStatus');	// [179..182]
    QSTRING45 addx1;
		QSTRING45	addx2;
		BOOLEAN #EXPAND(appendPrefix + 'CacheHit') := FALSE;
		BOOLEAN #EXPAND(appendPrefix + 'CleanerHit') := FALSE;
    STRING #EXPAND(appendPrefix + 'CleanedAddress') := '';
    STRING #EXPAND(appendPrefix + 'InputAddress') := '';
	END;

	//Make the addr1 and addr2 well formed
	rFinal fixAddr(inData l, INTEGER c) := TRANSFORM
		SELF.#EXPAND(appendPrefix + 'seq') := c;
    string AddressLine2 :=
		#IF(#TEXT(addr2_with_city_st_zip_field)!='')
		   l.addr2_with_city_st_zip_field;
		#ELSE
      #IF(#TEXT(incity)!='' AND #TEXT(instate)!= '' AND #TEXT(inzip)!= '')
        TRIM(l.incity) + ', ' + TRIM(l.instate) + ' ' + (STRING)l.inzip[1..5]
      #ELSEIF(#TEXT(incity)!='' AND #TEXT(instate)!='')
        TRIM(l.incity) + ', ' + TRIM(l.instate) 
      #ELSEIF(#TEXT(inzip)!='')
        (STRING)l.inzip[1..5]
      #ELSE
       ''
      #END
		#END
		;
    
    addr1WithSec  := l.addr1_field + 
    #IF(#TEXT(addr2_field)!='')
      IF(l.addr2_field <> '', ' '+l.addr2_field, '')
    #ELSE
      ''
    #END;
		addr1Space1 := stringlib.StringFindReplace(addr1WithSec,'  ',' ');
		addr1Space2 := stringlib.StringFindReplace(addr1Space1,'  ',' ');
		addr1Period := stringlib.StringFindReplace(addr1Space2,'.','');
		addr1POBox  := stringlib.StringFindReplace(addr1Period,'P O ','PO ');
		addr1Final  := stringlib.StringToUpperCase(addr1POBox);
		addr2Spaces := stringlib.StringFindReplace(AddressLine2,'  ',' ');
		addr2Period := stringlib.StringFindReplace(addr2Spaces,'.','');
		addr2Final  := stringlib.StringToUpperCase(addr2Period);
		SELF.addx1 := addr1Final;
		SELF.addx2 := addr2Final;
		SELF := l;
		SELF := [];
	END;
	fixedAddrs := PROJECT(inData(addr1_field <> ''), fixAddr(LEFT, COUNTER));

  rFinal tFinal(fixedAddrs L, AppendCleanAddress.Key_RawACE R) := TRANSFORM
 		SELF.#EXPAND(appendPrefix + 'PrimaryRange') := R.prim_range;
		SELF.#EXPAND(appendPrefix + 'PreDirectional') := R.predir;
		SELF.#EXPAND(appendPrefix + 'PrimaryName') := R.prim_name;
		SELF.#EXPAND(appendPrefix + 'AddressSuffix') := R.addr_suffix;
		SELF.#EXPAND(appendPrefix + 'PostDirectional') := R.postdir;
		SELF.#EXPAND(appendPrefix + 'UnitDesignation') := R.unit_desig;
		SELF.#EXPAND(appendPrefix + 'SecondaryRange') := R.sec_range;
		SELF.#EXPAND(appendPrefix + 'PostalCity') := R.p_city_name;
		SELF.#EXPAND(appendPrefix + 'VanityCity') := R.v_city_name;
		SELF.#EXPAND(appendPrefix + 'State') := R.st;
		SELF.#EXPAND(appendPrefix + 'Zip') := R.zip5;
		SELF.#EXPAND(appendPrefix + 'Zip4') := R.zip4;
		SELF.#EXPAND(appendPrefix + 'DBPC') := R.dbpc;
		SELF.#EXPAND(appendPrefix + 'CheckDigit') := R.chk_digit;
		SELF.#EXPAND(appendPrefix + 'RecordType') := R.rec_type;
		SELF.#EXPAND(appendPrefix + 'County') := R.County;
		SELF.#EXPAND(appendPrefix + 'Latitude') := R.geo_lat;
		SELF.#EXPAND(appendPrefix + 'Longitude') := R.geo_long;
		SELF.#EXPAND(appendPrefix + 'Msa') := R.msa;
		SELF.#EXPAND(appendPrefix + 'GeoBlock') := R.geo_blk;
		SELF.#EXPAND(appendPrefix + 'GeoMatchCode') := R.geo_match;
		SELF.#EXPAND(appendPrefix + 'ErrorStatus') := R.err_stat;  
    SELF.#EXPAND(appendPrefix + 'CacheHit') := R.err_stat[1]='S',
    SELF := L;
  END;
	
	//Look up cleaned address in Address_Clean key
	cacheLookupSM := JOIN(fixedAddrs, AppendCleanAddress.Key_RawACE, LEFT.addx1=RIGHT.Line1 AND LEFT.addx2=RIGHT.LineLast,
																				tFinal(LEFT, RIGHT), KEYED, SKEW(1));

	cacheLookupLG := JOIN(AppendCleanAddress.Key_RawACE, fixedAddrs, LEFT.Line1=RIGHT.addx1 AND LEFT.LineLast=RIGHT.addx2,
																				tFinal(RIGHT,LEFT), SKEW(1), SMART, MANY, ATMOST(10000));	
	
	cacheResults := MAP(COUNT(fixedAddrs) > UseIndexThreshold => cacheLookupLG, cacheLookupSM);
	cacheHits		:= cacheResults(#EXPAND(appendPrefix + 'CacheHit'));
		
	//From the inData set, get the records that missed on the Address Cache Key
	smartDrops := JOIN(cacheResults, fixedAddrs, LEFT.#EXPAND(appendPrefix + 'seq') = RIGHT.#EXPAND(appendPrefix + 'seq'), TRANSFORM(rFinal, SELF := RIGHT),HASH,RIGHT ONLY);	

	//For cache miss use cleaner
	cacheMisses := MAP(COUNT(cacheResults)=COUNT(fixedAddrs) => cacheResults(~#EXPAND(appendPrefix + 'CacheHit')), smartDrops);
	
	rFinal cleanAddr(cacheMisses l) := TRANSFORM
		clean_address 		:= Address.CleanAddress182(l.addx1,l.addx2);	
		SELF.#EXPAND(appendPrefix + 'PrimaryRange') := clean_address[1..10];
		SELF.#EXPAND(appendPrefix + 'PreDirectional') := clean_address[11..12];
		SELF.#EXPAND(appendPrefix + 'PrimaryName') := clean_address[13..40];
		SELF.#EXPAND(appendPrefix + 'AddressSuffix') := clean_address[41..44];
		SELF.#EXPAND(appendPrefix + 'PostDirectional') := clean_address[45..46];
		SELF.#EXPAND(appendPrefix + 'UnitDesignation') := clean_address[47..56];
		SELF.#EXPAND(appendPrefix + 'SecondaryRange') := clean_address[57..64];
		SELF.#EXPAND(appendPrefix + 'PostalCity') := clean_address[65..89];
		SELF.#EXPAND(appendPrefix + 'VanityCity') := clean_address[90..114];
		SELF.#EXPAND(appendPrefix + 'State') := clean_address[115..116];
		SELF.#EXPAND(appendPrefix + 'zip') := clean_address[117..121];
		SELF.#EXPAND(appendPrefix + 'Zip4') := clean_address[122..125];
		SELF.#EXPAND(appendPrefix + 'DBPC') := clean_address[136..137];
		SELF.#EXPAND(appendPrefix + 'CheckDigit') := clean_address[138];
		SELF.#EXPAND(appendPrefix + 'RecordType') := clean_address[139..140];
		SELF.#EXPAND(appendPrefix + 'County') := clean_address[141..145];
		SELF.#EXPAND(appendPrefix + 'Latitude') := clean_address[146..155];
		SELF.#EXPAND(appendPrefix + 'Longitude') := clean_address[156..166];
		SELF.#EXPAND(appendPrefix + 'MSA') := clean_address[167..170];
		SELF.#EXPAND(appendPrefix + 'GeoBlock') := clean_address[171..177];
		SELF.#EXPAND(appendPrefix + 'GeoMatchCode') := clean_address[178];
		SELF.#EXPAND(appendPrefix + 'ErrorStatus') := clean_address[179..182];		
		SELF.#EXPAND(appendPrefix + 'CacheHit') 		:= FALSE;
		SELF := l;
	END;

	cleanerCall := PROJECT(cacheMisses, cleanAddr(LEFT));

  
  results_out :=RECORD
	 rFinal AND NOT [#EXPAND(appendPrefix + 'seq'), addx1, addx2];
	END;
	
	Results := PROJECT(cacheHits + cleanerCall, 
    TRANSFORM(results_out, 
      SELF.#EXPAND(appendPrefix + 'CleanedAddress') := TRIM(' ' + TRIM(LEFT.#EXPAND(appendPrefix + 'PrimaryRange'))) + TRIM(' ' + TRIM(LEFT.#EXPAND(appendPrefix + 'predirectional'))) + TRIM(' ' + TRIM(LEFT.#EXPAND(appendPrefix + 'primaryname'))) + TRIM(' ' + TRIM(LEFT.#EXPAND(appendPrefix + 'addresssuffix'))) +TRIM(' ' + TRIM(LEFT.#EXPAND(appendPrefix + 'postdirectional'))) + 
              IF(LEFT.#EXPAND(appendPrefix + 'UnitDesignation') <> '' OR LEFT.#EXPAND(appendPrefix + 'SecondaryRange') <> '', TRIM(' ' + TRIM(LEFT.#EXPAND(appendPrefix + 'unitdesignation'))) + TRIM(' ' + TRIM(LEFT.#EXPAND(appendPrefix + 'secondaryrange'))), '') + 
							IF(LEFT.#EXPAND(appendPrefix + 'VanityCity') <> '', TRIM('<BR/>' + TRIM(LEFT.#EXPAND(appendPrefix + 'vanitycity'))), '') + IF(LEFT.#EXPAND(appendPrefix + 'State') <> '', TRIM(', ' + TRIM(LEFT.#EXPAND(appendPrefix + 'state'))), '') + IF(LEFT.#EXPAND(appendPrefix + 'Zip') <> '', TRIM(' ' + TRIM(LEFT.#EXPAND(appendPrefix + 'zip'))), '') + IF(LEFT.#EXPAND(appendPrefix + 'Zip4') <> '', TRIM('-' + TRIM(LEFT.#EXPAND(appendPrefix + 'Zip4'))), ''),
      SELF.#EXPAND(appendPrefix + 'InputAddress') := TRIM(' ' + TRIM(LEFT.addx1))+ IF(TRIM(LEFT.addx2) NOT IN [',', ''], TRIM('<BR/>' + TRIM(LEFT.addx2)), ''),	      
      self := LEFT)) +
    PROJECT(inData(addr1_field = ''), TRANSFORM(results_out,
      SELF := LEFT,
      SELF := []));

	RETURN Results;
		
ENDMACRO;

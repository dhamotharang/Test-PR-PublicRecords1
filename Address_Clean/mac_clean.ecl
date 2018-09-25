//inData		- this is the input dataset
//UseIndexThreshold - this sets the cut over record count switching between 
//addr1 corresponds to the unparsed street address
//addr2 corresponds to the unparsed city, st zip

EXPORT mac_clean(inData, UseIndexThreshold=5000000, addr1_field, addr2_field) := FUNCTIONMACRO
	
	IMPORT Address, Address_Clean;
	
	rFinal := RECORD
		INTEGER seq;
		RECORDOF(inData);
		Address_Clean.Layouts.rFinalMac;
	END;
	//

	//Make the addr1 and addr2 well formed
	rFinal fixAddr(inData l, INTEGER c) := TRANSFORM
		SELF.seq := c;
		addr1Space1 := stringlib.StringFindReplace(l.addr1_field,'  ',' ');
		addr1Space2 := stringlib.StringFindReplace(addr1Space1,'  ',' ');
		addr1Period := stringlib.StringFindReplace(addr1Space2,'.','');
		addr1POBox  := stringlib.StringFindReplace(addr1Period,'P O ','PO ');
		addr1Final  := stringlib.StringToUpperCase(addr1POBox);
		addr2Spaces := stringlib.StringFindReplace(l.addr2_field,'  ',' ');
		addr2Period := stringlib.StringFindReplace(addr2Spaces,'.','');
		addr2Final  := stringlib.StringToUpperCase(addr2Period);
		SELF.addx1 := addr1Final;
		SELF.addx2 := addr2Final;
		SELF := l;
		SELF := [];
	END;
	fixedAddrs := PROJECT(inData, fixAddr(LEFT, COUNTER));

	//Look up cleaned address in Address_Clean key
	cacheLookupSM := JOIN(fixedAddrs, Address_Clean.key_clean, LEFT.addx1=RIGHT.Line1 AND LEFT.addx2=RIGHT.LineLast,
																				TRANSFORM(rFinal, 
																										SELF.cache_hit := RIGHT.err_stat[1]='S',
																										SELF := RIGHT, SELF := LEFT)
																				, KEYED, SKEW(1));

	cacheLookupLG := JOIN(Address_Clean.key_clean, fixedAddrs, LEFT.Line1=RIGHT.addx1 AND LEFT.LineLast=RIGHT.addx2,
																				TRANSFORM(rFinal, 
																										SELF.cache_hit := LEFT.err_stat[1]='S',
																										SELF := LEFT, SELF := RIGHT)
																				, SKEW(1), SMART, MANY, ATMOST(10000));	
	
	cacheResults := MAP(COUNT(fixedAddrs) < UseIndexThreshold => cacheLookupSM, cacheLookupLG);
	
	//From the inData set, get the records that missed on the Address Cache Key
	smartDrops := JOIN(cacheResults, fixedAddrs, LEFT.seq = RIGHT.seq, TRANSFORM(rFinal, SELF := RIGHT),HASH,RIGHT ONLY);	

	//For cache miss use cleaner
	cacheMisses := MAP(COUNT(cacheResults)=COUNT(fixedAddrs) => cacheResults(~cache_hit), smartDrops);
	cacheHits		:= cacheResults(cache_hit);
	
	rFinal cleanAddr(cacheMisses l) := TRANSFORM
		clean_address 		:= Address.CleanAddress182(l.addx1,l.addx2);	
		SELF.prim_range 	:= Address.CleanFields(clean_address).prim_range; 	// [1..10]
		SELF.predir 			:= Address.CleanFields(clean_address).predir;				// [11..12]
		SELF.prim_name 		:= Address.CleanFields(clean_address).prim_name;		// [13..40]
		SELF.addr_suffix 	:= Address.CleanFields(clean_address).addr_suffix;  // [41..44]
		SELF.postdir 			:= Address.CleanFields(clean_address).postdir;			// [45..46]
		SELF.unit_desig 	:= Address.CleanFields(clean_address).unit_desig;		// [47..56]
		SELF.sec_range 		:= Address.CleanFields(clean_address).sec_range;		// [57..64]
		SELF.p_city_name	:= Address.CleanFields(clean_address).p_city_name;	// [65..89]
		SELF.v_city_name	:= Address.CleanFields(clean_address).v_city_name;  // [90..114]
		SELF.st 					:= Address.CleanFields(clean_address).st;						// [115..116]
		SELF.zip 					:= Address.CleanFields(clean_address).zip;					// [117..121]
		SELF.zip4 				:= Address.CleanFields(clean_address).zip4;					// [122..125]
		SELF.cart 				:= Address.CleanFields(clean_address).cart;					// [126..129]
		SELF.cr_sort_sz 	:= Address.CleanFields(clean_address).cr_sort_sz;		// [130]
		SELF.lot 					:= Address.CleanFields(clean_address).lot;					// [131..134]
		SELF.lot_order 		:= Address.CleanFields(clean_address).lot_order;		// [135]
		SELF.dbpc 				:= Address.CleanFields(clean_address).dbpc;					// [136..137]
		SELF.chk_digit 		:= Address.CleanFields(clean_address).chk_digit;		// [138]
		SELF.rec_type 		:= Address.CleanFields(clean_address).rec_type;			// [139..140]
		SELF.county 			:= Address.CleanFields(clean_address).county;				// [141..145]
		SELF.geo_lat 			:= Address.CleanFields(clean_address).geo_lat;			// [146..155]
		SELF.geo_long 		:= Address.CleanFields(clean_address).geo_long;			// [156..166]
		SELF.msa 					:= Address.CleanFields(clean_address).msa;					// [167..170]
		SELF.geo_blk 			:= Address.CleanFields(clean_address).geo_blk;			// [171..177]
		SELF.geo_match 		:= Address.CleanFields(clean_address).geo_match;		// [178]
		SELF.err_stat 		:= Address.CleanFields(clean_address).err_stat;			// [179..182]
		SELF.cleaner_hit  := Address.CleanFields(clean_address).err_stat[1] = 'S';
		SELF.cache_hit 		:= FALSE;
		SELF := l;
	END;

	cleanerCall := PROJECT(cacheMisses, cleanAddr(LEFT));

	Results := cacheHits + cleanerCall;

	RETURN Results;
		
ENDMACRO;

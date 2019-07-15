ds := CHOOSEN(PULL(Advo.Key_Addr1_history(prim_name[1..6] <> 'PO BOX')),10000000);

Layout_Slim_Clean := record
	 string 		  Address1;
	 string 			Address2;
end; 
//

Layout_Slim_clean prepDS(ds l) := TRANSFORM
	is_flip := trim(l.STREET_NUM, left, right) <> '' and (trim(l.STREET_NAME, left, right)[..3] in ['RR ', 'HC '] or (trim(l.STREET_NAME, left, right) = 'PO BOX')) and trim(l.STREET_PRE_DIRectional, left, right) = '' and trim(l.STREET_SUFFIX, left, right) = '' and trim(l.STREET_POST_DIRectional, left, right) = '';
	STREET_NUM := if(trim(l.STREET_NUM, left, right) = '0', '0'+ l.STREET_NUM, l.STREET_NUM);

	self.address1 := if(~is_flip, Address.Addr1FromComponents(stringlib.stringtouppercase(STREET_NUM),stringlib.stringtouppercase(l.STREET_PRE_DIRectional),stringlib.stringtouppercase(l.STREET_NAME),stringlib.stringtouppercase(l.STREET_SUFFIX),stringlib.stringtouppercase(l.STREET_POST_DIRectional),stringlib.stringtouppercase(l.Secondary_Unit_Designator),stringlib.stringtouppercase(l.Secondary_Unit_Number)),
																Address.Addr1FromComponents('','',stringlib.stringtouppercase(trim(l.STREET_NAME, left, right) + ' ' + trim(STREET_NUM, left, right)),'','',stringlib.stringtouppercase(l.Secondary_Unit_Designator),stringlib.stringtouppercase(l.Secondary_Unit_Number)));
	self.address2 := Address.Addr2FromComponents(stringlib.stringtouppercase(l.City_Name),stringlib.stringtouppercase(l.State_Code),stringlib.stringtouppercase(l.ZIP_5));
end;

advo_prepped := PROJECT(ds, prepDS(LEFT));

cleanedHash  := Address_Clean.mac_clean(advo_prepped, , address1, address2);

//VS
rFinal := RECORD
	INTEGER seq;
	Layout_Slim_Clean;
	Address_Clean.Layouts.rFinalMac;
END;

rFinal cleanAddr(advo_prepped l) := TRANSFORM
	clean_address 		:= Address.CleanAddress182(l.address1,l.address2);	
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
	SELF := [];
END;

cleanerCall := PROJECT(advo_prepped, cleanAddr(LEFT));

//REPORT
rCacheCounts := record
	cache_cnt := COUNT(GROUP, cleanedHash.cache_hit);
	cleaner_cnt := COUNT(GROUP, cleanedHash.cleaner_hit);
	miss_cnt := COUNT(GROUP, ~cleanedHash.cleaner_hit and ~cleanedHash.cache_hit);
end;
hashCounts := TABLE(cleanedHash, rCacheCounts, few);
outA := output(hashCounts, named('hash_counts'));

rCleanerCounts := record
	cache_cnt := COUNT(GROUP, cleanerCall.cache_hit);
	cleaner_cnt := COUNT(GROUP, cleanerCall.cleaner_hit);
	miss_cnt := COUNT(GROUP, ~cleanerCall.cleaner_hit and ~cleanerCall.cache_hit);
end;
cleanerCounts := TABLE(cleanerCall, rCleanerCounts, few);
outB := output(cleanerCounts, named('cleanerCounts'));

//CALL
SEQUENTIAL(outA, outB);

/* ************************************************************************************************************************
This is just to perfect the CSV data - so this can happen PRIOR to saving the CSV version of the base file (we spray/despray that)
INPUT: Alpha CSV LAYOUT directly from the sprayed file
OUTPUT: Alpha CSV LAYOUT

************************************************************************************************************************ */
IMPORT PRTE2_Common;

EXPORT Transforms := MODULE

		SHARED AlphaPropertyCSVRec := Layouts.AlphaPropertyCSVRec;

		EXPORT AlphaPropertyCSVRec spreadsheet_clean(AlphaPropertyCSVRec L) := TRANSFORM
					clean_address := PRTE2_Common.Clean_Address.cleanAddr1Addr2(l.property_street_address, l.property_city_state_zip);
					// NOTE: Nancy will edit these fields: property_street_address, property_city, property_state, property_zip
					// 				We then just need to update the other addresses in the record based on what she changes or adds.
					//TODO - are there other address fields in there to do?
					// SELF.property_street_address := clean_address.addr1;	// I think we should just keep Nancy's values for the above incoming fields.
					// SELF.property_city 	:= clean_address.v_city_name;		// I think we should just keep Nancy's values for the above incoming fields.
					// SELF.property_state := clean_address.st;							// I think we should just keep Nancy's values for the above incoming fields.
					// SELF.property_zip 	:= clean_address.zip;							// I think we should just keep Nancy's values for the above incoming fields.
					// SELF.addr_error	:= IF(clean_address.errorCode[1]='E',clean_address.errorCode,'');
					SELF.property_city_state_zip := clean_address.addr2;
					SELF.prim_name  := clean_address.prim_name;
					SELF.predir     := clean_address.predir;
					SELF.prim_range := clean_address.prim_range;
					SELF.sec_range  := clean_address.sec_range;					
					SELF.unit_desig := clean_address.unit_desig;
					SELF.postdir    := clean_address.postdir;
					SELF.addr_suffix := clean_address.addr_suffix;
					SELF.st         := clean_address.st;
					self.zip        := clean_address.zip; 
					self.zip4       := clean_address.zip4;
					SELF.msa        := clean_address.msa;
					SELF.err_stat   := clean_address.err_stat;
					SELF.cart       := clean_address.cart;
					SELF.cr_sort_sz := clean_address.cr_sort_sz;
					SELF.lot        := clean_address.lot;
					SELF.lot_order  := clean_address.lot_order;
					SELF.dbpc       := clean_address.dbpc;
					SELF.chk_digit  := clean_address.chk_digit;
					SELF.rec_type   := clean_address.rec_type;
					SELF.county     := clean_address.fips_state+clean_address.fips_county;	// ??? This is what it used to do - [141-145]
					self.geo_lat    := clean_address.geo_lat;
					self.geo_long   := clean_address.geo_long;
					SELF.geo_blk    := clean_address.geo_blk;
					SELF.geo_match  := clean_address.geo_match;
					SELF.p_city_name := clean_address.p_city_name;
					SELF.v_city_name := clean_address.v_city_name;
					SELF := L;
					// SELF := [];
		END;

END;
IMPORT PRTE2_Common;

EXPORT Transforms := MODULE

/*		Dead code after moving to new layout 1/2016
 		// Reduce the local base file to a simple spreadsheet layout
   		EXPORT Layouts.editable_spreadsheet Gateway_Reduce(Layouts.batch_in L) := TRANSFORM
   				SELF  := L;
   				SELF  := [];
   		END;

   
   		// Expand the simple spreadsheet layout to an expanded layout in the local base file 
   		EXPORT Layouts.batch_in Spreadsheet_Expand(Layouts.editable_spreadsheet L) := TRANSFORM
   				SELF  := L;
   				SELF  := [];
   		END;
*/
		SHARED spreadsheet_layout := PRTE2_LNProperty.Layouts_V2.LN_spreadsheet;

		EXPORT spreadsheet_layout spreadsheet_clean(spreadsheet_layout L) := TRANSFORM
					newUnitString		:= IF(L.Apt='','',L.unitDesc+' '+L.Apt);
					tempAddrString  := l.address+' '+newUnitString;
					clean_address := PRTE2_Common.Clean_Address.FromLine(tempAddrString, l.city,l.st,l.zip);
					SELF.prim_name  :=  clean_address.prim_name;
					SELF.predir     := clean_address.predir;
					SELF.prim_range := clean_address.prim_range;
					SELF.sec_range  := clean_address.sec_range;					
					SELF.unit_desig := clean_address.unit_desig;
					SELF.postdir    := clean_address.postdir;
					SELF.suffix     := clean_address.addr_suffix;
					SELF.st         := clean_address.st;
					self.state      := clean_address.st;
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
		END;
		
		//***********************************************************************************************
		// The following two are more for study - probably not a good layout to spray back in yet
		//***********************************************************************************************
		// Reduce the local base file to a simple spreadsheet layout
		EXPORT Layouts.Boca_Base_Limited Boca_Reduce(Layouts.layout_LNP_V2_expanded_payload L) := TRANSFORM
				SELF  := L;
				SELF  := [];
		END;
		// Expand the simple spreadsheet layout to an expanded layout in the local base file 
		EXPORT Layouts.layout_LNP_V2_expanded_payload Boca_Spreadsheet_Expand(Layouts.Boca_Base_Limited L) := TRANSFORM
				SELF.dob := (INTEGER) L.dob;
				SELF  := L;
				SELF  := [];
		END;

END;
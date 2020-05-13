import AID,Address,PromoteSupers,STD;

EXPORT procBuildBase(string pversion) := function
	infile:=CollateralAnalytics.file_CollaterialAnalytics_in;
	
	
	CollateralAnalytics.layouts.base tToBaseForm (CollateralAnalytics.layouts.raw L):=transform
			SELF.process_date			:=	thorlib.wuid()[2..9];
			SELF.date_vendor_first_reported	:=	pversion;
			SELF.date_vendor_last_reported	:=	pversion;
			SELF.date_first_seen	:=	if(L.MLS_LIST_DT<>'',STD.STR.FilterOut(L.MLS_LIST_DT[1..10],'-'),'');
			SELF.date_last_seen		:=	if(L.MLS_LIST_DT<>'',STD.STR.FilterOut(L.MLS_LIST_DT[1..10],'-'),'');
			self.MLS_GEO_FULL_ADDRESS:=STD.STR.TOUPPERCASE(L.MLS_GEO_FULL_ADDRESS);
			self.MLS_GEO_CITY:=STD.STR.TOUPPERCASE(L.MLS_GEO_CITY);
			self.MLS_GEO_STATE:=STD.STR.TOUPPERCASE(L.MLS_GEO_STATE);
			self.MLS_GEO_ZIP_CODE:=STD.STR.TOUPPERCASE(L.MLS_GEO_ZIP_CODE);
			self.CA_ASSESSED_IMPROVEMENTS:=STD.STR.TOUPPERCASE(L.CA_ASSESSED_IMPROVEMENTS);
			self.CA_ASSESSED_LAND:=STD.STR.TOUPPERCASE(L.CA_ASSESSED_LAND);
			self.CA_ASSESSED_VAL:=STD.STR.TOUPPERCASE(L.CA_ASSESSED_VAL);
			self.CA_ASSESSMENT_PERC_REPLACEMENT_VALUE:=STD.STR.TOUPPERCASE(L.CA_ASSESSMENT_PERC_REPLACEMENT_VALUE);
			self.CA_AVM_HIGH:=STD.STR.TOUPPERCASE(L.CA_AVM_HIGH);
			self.CA_AVM_LOW:=STD.STR.TOUPPERCASE(L.CA_AVM_LOW);
			self.CA_AVM_VALUE:=STD.STR.TOUPPERCASE(L.CA_AVM_VALUE);
			self.CA_BUILDING_PERCENT:=STD.STR.TOUPPERCASE(L.CA_BUILDING_PERCENT);
			self.CA_FSD_SCORE:=STD.STR.TOUPPERCASE(L.CA_FSD_SCORE);
			self.CA_LAND_PRICE_IMPLIED_REPLACEMENT_VALUE:=STD.STR.TOUPPERCASE(L.CA_LAND_PRICE_IMPLIED_REPLACEMENT_VALUE);
			self.CA_MARKET_CONDITION:=STD.STR.TOUPPERCASE(L.CA_MARKET_CONDITION);
			self.CA_MOST_RECENT_LOAN:=STD.STR.TOUPPERCASE(L.CA_MOST_RECENT_LOAN);
			self.CA_MOST_RECENT_SALE_PRICE:=STD.STR.TOUPPERCASE(L.CA_MOST_RECENT_SALE_PRICE);
			self.CA_ORIGINAL_LOAN_1ST_LOAN_AMT:=STD.STR.TOUPPERCASE(L.CA_ORIGINAL_LOAN_1ST_LOAN_AMT);
			self.CA_ORIGINAL_PURCHASE_LOAN_AMT:=STD.STR.TOUPPERCASE(L.CA_ORIGINAL_PURCHASE_LOAN_AMT);
			self.CA_ORIGINAL_PURCHASE_LOAN_DATE:=STD.STR.TOUPPERCASE(L.CA_ORIGINAL_PURCHASE_LOAN_DATE);
			self.CA_REFI_1ST_LOAN_AMT:=STD.STR.TOUPPERCASE(L.CA_REFI_1ST_LOAN_AMT);
			self.CA_REFI_DATE:=STD.STR.TOUPPERCASE(L.CA_REFI_DATE);
			self.CA_SOLD_DATE_1:=STD.STR.TOUPPERCASE(L.CA_SOLD_DATE_1);
			self.CA_SOLD_PRICE_1:=STD.STR.TOUPPERCASE(L.CA_SOLD_PRICE_1);
			self.MLS_AIR_CONDITIONING_TYPE:=STD.STR.TOUPPERCASE(L.MLS_AIR_CONDITIONING_TYPE);
			self.MLS_APN:=STD.STR.TOUPPERCASE(L.MLS_APN);
			self.MLS_BATH_TOTAL:=STD.STR.TOUPPERCASE(L.MLS_BATH_TOTAL);
			self.MLS_BATHS_FULL:=STD.STR.TOUPPERCASE(L.MLS_BATHS_FULL);
			self.MLS_BATHS_PARTIAL:=STD.STR.TOUPPERCASE(L.MLS_BATHS_PARTIAL);
			self.MLS_BEDROOMS:=STD.STR.TOUPPERCASE(L.MLS_BEDROOMS);
			self.MLS_BLOCK_NUMBER:=STD.STR.TOUPPERCASE(L.MLS_BLOCK_NUMBER);
			self.MLS_BUILDING_SQUARE_FOOTAGE:=STD.STR.TOUPPERCASE(L.MLS_BUILDING_SQUARE_FOOTAGE);
			self.MLS_CONSTRUCTION_TYPE:=STD.STR.TOUPPERCASE(L.MLS_CONSTRUCTION_TYPE);
			self.MLS_DOM:=STD.STR.TOUPPERCASE(L.MLS_DOM);
			self.MLS_EXTERIOR_WALL_TYPE:=STD.STR.TOUPPERCASE(L.MLS_EXTERIOR_WALL_TYPE);
			self.MLS_FIREPLACE_TYPE:=STD.STR.TOUPPERCASE(L.MLS_FIREPLACE_TYPE);
			self.MLS_FIREPLACE_YN:=STD.STR.TOUPPERCASE(L.MLS_FIREPLACE_YN);
			self.MLS_FIRST_FLOOR_SQUARE_FOOTAGE:=STD.STR.TOUPPERCASE(L.MLS_FIRST_FLOOR_SQUARE_FOOTAGE);
			self.MLS_FLOOD_ZONE_PANEL:=STD.STR.TOUPPERCASE(L.MLS_FLOOD_ZONE_PANEL);
			self.MLS_FLOOR_TYPE:=STD.STR.TOUPPERCASE(L.MLS_FLOOR_TYPE);
			self.MLS_FOUNDATION:=STD.STR.TOUPPERCASE(L.MLS_FOUNDATION);
			self.MLS_FUEL_TYPE:=STD.STR.TOUPPERCASE(L.MLS_FUEL_TYPE);
			self.MLS_GARAGE:=STD.STR.TOUPPERCASE(L.MLS_GARAGE);
			self.MLS_GEO_COUNTY:=STD.STR.TOUPPERCASE(L.MLS_GEO_COUNTY);
			self.MLS_GEO_FIPS:=STD.STR.TOUPPERCASE(L.MLS_GEO_FIPS);
			self.MLS_GEO_LAT:=STD.STR.TOUPPERCASE(L.MLS_GEO_LAT);
			self.MLS_GEO_LON:=STD.STR.TOUPPERCASE(L.MLS_GEO_LON);
			self.MLS_HEATING:=STD.STR.TOUPPERCASE(L.MLS_HEATING);
			self.MLS_INTEREST_RATE_TYPE_CODE:=STD.STR.TOUPPERCASE(L.MLS_INTEREST_RATE_TYPE_CODE);
			self.MLS_LIST_DATE_1:=STD.STR.TOUPPERCASE(L.MLS_LIST_DATE_1);
			self.MLS_LIST_DT:=STD.STR.TOUPPERCASE(L.MLS_LIST_DT);
			self.MLS_LIST_PRICE:=STD.STR.TOUPPERCASE(L.MLS_LIST_PRICE);
			self.MLS_LIST_PRICE_1:=STD.STR.TOUPPERCASE(L.MLS_LIST_PRICE_1);
			self.MLS_LIVING_AREA:=STD.STR.TOUPPERCASE(L.MLS_LIVING_AREA);
			self.MLS_LOAN_AMOUNT:=STD.STR.TOUPPERCASE(L.MLS_LOAN_AMOUNT);
			self.MLS_LOAN_TYPE_CODE:=STD.STR.TOUPPERCASE(L.MLS_LOAN_TYPE_CODE);
			self.MLS_LOT_DEPTH_FOOTAGE:=STD.STR.TOUPPERCASE(L.MLS_LOT_DEPTH_FOOTAGE);
			self.MLS_LOT_NUMBER:=STD.STR.TOUPPERCASE(L.MLS_LOT_NUMBER);
			self.MLS_LOT_SIZE:=STD.STR.TOUPPERCASE(L.MLS_LOT_SIZE);
			self.MLS_LOT_SIZE_ACRE:=STD.STR.TOUPPERCASE(L.MLS_LOT_SIZE_ACRE);
			self.MLS_MORTGAGE_COMPANY_NAME:=STD.STR.TOUPPERCASE(L.MLS_MORTGAGE_COMPANY_NAME);
			self.MLS_NBR_STORIES:=STD.STR.TOUPPERCASE(L.MLS_NBR_STORIES);
			self.MLS_NEIGHBORHOOD:=STD.STR.TOUPPERCASE(L.MLS_NEIGHBORHOOD);
			self.MLS_NUMBER_OF_BATH_FIXTURES:=STD.STR.TOUPPERCASE(L.MLS_NUMBER_OF_BATH_FIXTURES);
			self.MLS_NUMBER_OF_FIREPLACES:=STD.STR.TOUPPERCASE(L.MLS_NUMBER_OF_FIREPLACES);
			self.MLS_NUMBER_OF_ROOMS:=STD.STR.TOUPPERCASE(L.MLS_NUMBER_OF_ROOMS);
			self.MLS_NUMBER_OF_UNITS:=STD.STR.TOUPPERCASE(L.MLS_NUMBER_OF_UNITS);
			self.MLS_PARKING_TYPE:=STD.STR.TOUPPERCASE(L.MLS_PARKING_TYPE);
			self.MLS_POOL_TYPE:=STD.STR.TOUPPERCASE(L.MLS_POOL_TYPE);
			self.MLS_POOL_YN:=STD.STR.TOUPPERCASE(L.MLS_POOL_YN);
			self.MLS_PROP_STYLE:=STD.STR.TOUPPERCASE(L.MLS_PROP_STYLE);
			self.MLS_PROPERTY_CONDITION:=STD.STR.TOUPPERCASE(L.MLS_PROPERTY_CONDITION);
			self.MLS_PROPERTY_TYPE:=STD.STR.TOUPPERCASE(L.MLS_PROPERTY_TYPE);
			self.MLS_ROOF_COVER:=STD.STR.TOUPPERCASE(L.MLS_ROOF_COVER);
			self.MLS_SALE_DATE_PR:=STD.STR.TOUPPERCASE(L.MLS_SALE_DATE_PR);
			self.MLS_SALE_PRICE_PR:=STD.STR.TOUPPERCASE(L.MLS_SALE_PRICE_PR);
			self.MLS_SALE_TYPE_CODE:=STD.STR.TOUPPERCASE(L.MLS_SALE_TYPE_CODE);
			self.MLS_SECOND_LOAN_AMOUNT:=STD.STR.TOUPPERCASE(L.MLS_SECOND_LOAN_AMOUNT);
			self.MLS_SEWER:=STD.STR.TOUPPERCASE(L.MLS_SEWER);
			self.MLS_SOLD_DATE:=STD.STR.TOUPPERCASE(L.MLS_SOLD_DATE);
			self.MLS_SOLD_PRICE:=STD.STR.TOUPPERCASE(L.MLS_SOLD_PRICE);
			self.MLS_TAX_AMOUNT:=STD.STR.TOUPPERCASE(L.MLS_TAX_AMOUNT);
			self.MLS_TAX_YEAR:=STD.STR.TOUPPERCASE(L.MLS_TAX_YEAR);
			self.MLS_WATER:=STD.STR.TOUPPERCASE(L.MLS_WATER);
			self.MLS_YEAR_BUILT:=STD.STR.TOUPPERCASE(L.MLS_YEAR_BUILT);
			self.MLS_ZONING:=STD.STR.TOUPPERCASE(L.MLS_ZONING);
			self.MLS_REMARKS:=STD.STR.TOUPPERCASE(L.MLS_REMARKS);
			SELF:=L;
			SELF := [];
	end;
	
	InBaseForm:=project(infile,tToBaseForm(Left));
	
	layout_ind_clean:=RECORD
    CollateralAnalytics.layouts.base;
    STRING addr1;
    STRING addr2;
  END;

  layout_ind_clean t_clean(InBaseForm L):=TRANSFORM
    SELF.addr1 :=StringLib.StringCleanSpaces(TRIM(TRIM(stringlib.stringtouppercase(L.MLS_GEO_FULL_ADDRESS),LEFT,RIGHT),LEFT,RIGHT));
    SELF.addr2 :=StringLib.StringCleanSpaces(Address.Addr2FromComponents(stringlib.stringtouppercase(L.MLS_GEO_CITY),stringlib.stringtouppercase(L.MLS_GEO_STATE),stringlib.stringtouppercase(L.MLS_GEO_ZIP_CODE[..5])));
    SELF :=L;
		SELF := [];
  END;
  ind_name_clean:=PROJECT(InBaseForm,t_clean(LEFT));

  // Call the AID macro to get the cleaned address information
  UNSIGNED4 lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.ACEAIDs;
  AID.MacAppendFromRaw_2Line(ind_name_clean, addr1, addr2, RawAID, ind_aid, lFlags);
    
  // Get standardized Name and Address fields
  CollateralAnalytics.layouts.base tProjectClean(ind_aid L):=TRANSFORM
    SELF.prim_range           := L.aidwork_acecache.prim_range;
    SELF.predir               := L.aidwork_acecache.predir;
    SELF.prim_name            := L.aidwork_acecache.prim_name;
    SELF.addr_suffix          := L.aidwork_acecache.addr_suffix;
    SELF.postdir              := L.aidwork_acecache.postdir;
    SELF.unit_desig           := L.aidwork_acecache.unit_desig;
    SELF.sec_range            := L.aidwork_acecache.sec_range;
    SELF.p_city_name          := L.aidwork_acecache.p_city_name;
    SELF.v_city_name          := L.aidwork_acecache.v_city_name;
    SELF.st                   := L.aidwork_acecache.st;
    SELF.zip                  := L.aidwork_acecache.zip5;
    SELF.zip4                 := L.aidwork_acecache.zip4;
    SELF.cart                 := L.aidwork_acecache.cart;
    SELF.cr_sort_sz           := L.aidwork_acecache.cr_sort_sz;
    SELF.lot                  := L.aidwork_acecache.lot;
    SELF.lot_order            := L.aidwork_acecache.lot_order;
    SELF.dbpc                 := L.aidwork_acecache.dbpc;
    SELF.chk_digit            := L.aidwork_acecache.chk_digit;
    SELF.rec_type             := L.aidwork_acecache.rec_type;
    SELF.county               := L.aidwork_acecache.county;
    SELF.geo_lat              := L.aidwork_acecache.geo_lat;
    SELF.geo_long             := L.aidwork_acecache.geo_long;
    SELF.msa                  := L.aidwork_acecache.msa;
    SELF.geo_blk              := L.aidwork_acecache.geo_blk;
    SELF.geo_match            := L.aidwork_acecache.geo_match;
    SELF.err_stat             := L.aidwork_acecache.err_stat;
    SELF.RawAID               := L.aidwork_rawaid;
    Self.ACEAID               := L.aidwork_acecache.AID;
    SELF                      := L;
    SELF                      := [];
  END;
  InBaseFormWithAddress:=PROJECT(ind_aid,tProjectClean(LEFT));
	ingestMod							:= CollateralAnalytics.Ingest(FALSE,,CollateralAnalytics.file_CollaterialAnalytics_Base,InBaseFormWithAddress);
	new_base							:= ingestMod.AllRecords_NoTag;
	
	
	PromoteSupers.Mac_SF_BuildProcess(new_base,'~thor_data400::collateral_analytics::base',build_base,,,TRUE);
	
	
	return build_base;
	
end;
import AID,Address,PromoteSupers;

EXPORT procBuildBase(string pversion) := function
	infile:=CollateralAnalytics.file_CollaterialAnalytics_in;
	
	
	CollateralAnalytics.layouts.base tToBaseForm (CollateralAnalytics.layouts.raw L):=transform
			SELF.process_date			:=	thorlib.wuid()[2..9];
			SELF.date_vendor_first_reported	:=	pversion;
			SELF.date_vendor_last_reported	:=	pversion;
			SELF.date_first_seen	:=	'';
			SELF.date_last_seen		:=	'';
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
  UNSIGNED4 lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
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
    SELF                      := L;
    SELF                      := [];
  END;
  InBaseFormWithAddress:=PROJECT(ind_aid,tProjectClean(LEFT));
	ingestMod							:= CollateralAnalytics.Ingest(FALSE,,CollateralAnalytics.file_CollaterialAnalytics_Base,InBaseFormWithAddress);
	new_base							:= ingestMod.AllRecords_NoTag;
	
	
	PromoteSupers.Mac_SF_BuildProcess(new_base,'~thor_data400::collateral_analytics::base',build_base,,,TRUE);
	
	
	return build_base;
	
end;
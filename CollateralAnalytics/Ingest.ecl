IMPORT STD,SALT311;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_CollateralAnalytics) Delta = DATASET([],Layout_CollateralAnalytics)
, DATASET(Layout_CollateralAnalytics) dsBase = In_CollateralAnalytics // Change IN_CollateralAnalytics to change input to ingest process
, DATASET(RECORDOF(CollateralAnalytics.File_CollaterialAnalytics_Base))  infile = CollateralAnalytics.File_CollaterialAnalytics_Base
) := MODULE
  SHARED NullFile := DATASET([],Layout_CollateralAnalytics); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_CollateralAnalytics;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.process_date := MAP ( le.__Tpe = 0 => ri.process_date,
                     ri.__Tpe = 0 => le.process_date,
                     (UNSIGNED)le.process_date < (UNSIGNED)ri.process_date => ri.process_date, // Want the highest value
                     le.process_date);
    SELF.date_first_seen := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.date_first_seen = 0 => ri.date_first_seen,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.date_first_seen = 0 => le.date_first_seen,
                     (UNSIGNED)le.date_first_seen < (UNSIGNED)ri.date_first_seen => le.date_first_seen, // Want the lowest non-zero value
                     ri.date_first_seen);
    SELF.date_last_seen := MAP ( le.__Tpe = 0 => ri.date_last_seen,
                     ri.__Tpe = 0 => le.date_last_seen,
                     (UNSIGNED)le.date_last_seen < (UNSIGNED)ri.date_last_seen => ri.date_last_seen, // Want the highest value
                     le.date_last_seen);
    SELF.date_vendor_first_reported := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.date_vendor_first_reported = 0 => ri.date_vendor_first_reported,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.date_vendor_first_reported = 0 => le.date_vendor_first_reported,
                     (UNSIGNED)le.date_vendor_first_reported < (UNSIGNED)ri.date_vendor_first_reported => le.date_vendor_first_reported, // Want the lowest non-zero value
                     ri.date_vendor_first_reported);
    SELF.date_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.date_vendor_last_reported,
                     ri.__Tpe = 0 => le.date_vendor_last_reported,
                     (UNSIGNED)le.date_vendor_last_reported < (UNSIGNED)ri.date_vendor_last_reported => ri.date_vendor_last_reported, // Want the highest value
                     le.date_vendor_last_reported);
    SELF.ca_id := ri.ca_id; // Derived(NEW)
    SELF.ca_assessed_improvements := ri.ca_assessed_improvements; // Derived(NEW)
    SELF.ca_assessed_land := ri.ca_assessed_land; // Derived(NEW)
    SELF.ca_assessed_val := ri.ca_assessed_val; // Derived(NEW)
    SELF.ca_assessment_perc_replacement_value := ri.ca_assessment_perc_replacement_value; // Derived(NEW)
    SELF.ca_avm_high := ri.ca_avm_high; // Derived(NEW)
    SELF.ca_avm_low := ri.ca_avm_low; // Derived(NEW)
    SELF.ca_avm_value := ri.ca_avm_value; // Derived(NEW)
    SELF.ca_building_percent := ri.ca_building_percent; // Derived(NEW)
    SELF.ca_fsd_score := ri.ca_fsd_score; // Derived(NEW)
    SELF.ca_land_price_implied_replacement_value := ri.ca_land_price_implied_replacement_value; // Derived(NEW)
    SELF.ca_market_condition := ri.ca_market_condition; // Derived(NEW)
    SELF.ca_most_recent_loan := ri.ca_most_recent_loan; // Derived(NEW)
    SELF.ca_most_recent_sale_price := ri.ca_most_recent_sale_price; // Derived(NEW)
    SELF.ca_original_loan_1st_loan_amt := ri.ca_original_loan_1st_loan_amt; // Derived(NEW)
    SELF.ca_original_purchase_loan_amt := ri.ca_original_purchase_loan_amt; // Derived(NEW)
    SELF.ca_original_purchase_loan_date := ri.ca_original_purchase_loan_date; // Derived(NEW)
    SELF.ca_refi_1st_loan_amt := ri.ca_refi_1st_loan_amt; // Derived(NEW)
    SELF.ca_refi_date := ri.ca_refi_date; // Derived(NEW)
    SELF.ca_sold_date_1 := ri.ca_sold_date_1; // Derived(NEW)
    SELF.ca_sold_price_1 := ri.ca_sold_price_1; // Derived(NEW)
    SELF.mls_air_conditioning_type := ri.mls_air_conditioning_type; // Derived(NEW)
    SELF.mls_apn := ri.mls_apn; // Derived(NEW)
    SELF.mls_bath_total := ri.mls_bath_total; // Derived(NEW)
    SELF.mls_baths_full := ri.mls_baths_full; // Derived(NEW)
    SELF.mls_baths_partial := ri.mls_baths_partial; // Derived(NEW)
    SELF.mls_bedrooms := ri.mls_bedrooms; // Derived(NEW)
    SELF.mls_block_number := ri.mls_block_number; // Derived(NEW)
    SELF.mls_building_square_footage := ri.mls_building_square_footage; // Derived(NEW)
    SELF.mls_construction_type := ri.mls_construction_type; // Derived(NEW)
    SELF.mls_dom := ri.mls_dom; // Derived(NEW)
    SELF.mls_exterior_wall_type := ri.mls_exterior_wall_type; // Derived(NEW)
    SELF.mls_fireplace_type := ri.mls_fireplace_type; // Derived(NEW)
    SELF.mls_fireplace_yn := ri.mls_fireplace_yn; // Derived(NEW)
    SELF.mls_first_floor_square_footage := ri.mls_first_floor_square_footage; // Derived(NEW)
    SELF.mls_flood_zone_panel := ri.mls_flood_zone_panel; // Derived(NEW)
    SELF.mls_floor_type := ri.mls_floor_type; // Derived(NEW)
    SELF.mls_foundation := ri.mls_foundation; // Derived(NEW)
    SELF.mls_fuel_type := ri.mls_fuel_type; // Derived(NEW)
    SELF.mls_garage := ri.mls_garage; // Derived(NEW)
    SELF.mls_geo_county := ri.mls_geo_county; // Derived(NEW)
    SELF.mls_geo_fips := ri.mls_geo_fips; // Derived(NEW)
    SELF.mls_geo_lat := ri.mls_geo_lat; // Derived(NEW)
    SELF.mls_geo_lon := ri.mls_geo_lon; // Derived(NEW)
    SELF.mls_heating := ri.mls_heating; // Derived(NEW)
    SELF.mls_interest_rate_type_code := ri.mls_interest_rate_type_code; // Derived(NEW)
    SELF.mls_list_date_1 := ri.mls_list_date_1; // Derived(NEW)
    SELF.mls_list_dt := ri.mls_list_dt; // Derived(NEW)
    SELF.mls_list_price := ri.mls_list_price; // Derived(NEW)
    SELF.mls_list_price_1 := ri.mls_list_price_1; // Derived(NEW)
    SELF.mls_living_area := ri.mls_living_area; // Derived(NEW)
    SELF.mls_loan_amount := ri.mls_loan_amount; // Derived(NEW)
    SELF.mls_loan_type_code := ri.mls_loan_type_code; // Derived(NEW)
    SELF.mls_lot_depth_footage := ri.mls_lot_depth_footage; // Derived(NEW)
    SELF.mls_lot_number := ri.mls_lot_number; // Derived(NEW)
    SELF.mls_lot_size := ri.mls_lot_size; // Derived(NEW)
    SELF.mls_lot_size_acre := ri.mls_lot_size_acre; // Derived(NEW)
    SELF.mls_mortgage_company_name := ri.mls_mortgage_company_name; // Derived(NEW)
    SELF.mls_nbr_stories := ri.mls_nbr_stories; // Derived(NEW)
    SELF.mls_neighborhood := ri.mls_neighborhood; // Derived(NEW)
    SELF.mls_number_of_bath_fixtures := ri.mls_number_of_bath_fixtures; // Derived(NEW)
    SELF.mls_number_of_fireplaces := ri.mls_number_of_fireplaces; // Derived(NEW)
    SELF.mls_number_of_rooms := ri.mls_number_of_rooms; // Derived(NEW)
    SELF.mls_number_of_units := ri.mls_number_of_units; // Derived(NEW)
    SELF.mls_parking_type := ri.mls_parking_type; // Derived(NEW)
    SELF.mls_pool_type := ri.mls_pool_type; // Derived(NEW)
    SELF.mls_pool_yn := ri.mls_pool_yn; // Derived(NEW)
    SELF.mls_prop_style := ri.mls_prop_style; // Derived(NEW)
    SELF.mls_property_condition := ri.mls_property_condition; // Derived(NEW)
    SELF.mls_property_type := ri.mls_property_type; // Derived(NEW)
    SELF.mls_roof_cover := ri.mls_roof_cover; // Derived(NEW)
    SELF.mls_sale_date_pr := ri.mls_sale_date_pr; // Derived(NEW)
    SELF.mls_sale_price_pr := ri.mls_sale_price_pr; // Derived(NEW)
    SELF.mls_sale_type_code := ri.mls_sale_type_code; // Derived(NEW)
    SELF.mls_second_loan_amount := ri.mls_second_loan_amount; // Derived(NEW)
    SELF.mls_sewer := ri.mls_sewer; // Derived(NEW)
    SELF.mls_sold_date := ri.mls_sold_date; // Derived(NEW)
    SELF.mls_sold_price := ri.mls_sold_price; // Derived(NEW)
    SELF.mls_tax_amount := ri.mls_tax_amount; // Derived(NEW)
    SELF.mls_tax_year := ri.mls_tax_year; // Derived(NEW)
    SELF.mls_water := ri.mls_water; // Derived(NEW)
    SELF.mls_year_built := ri.mls_year_built; // Derived(NEW)
    SELF.mls_zoning := ri.mls_zoning; // Derived(NEW)
    SELF.mls_remarks := ri.mls_remarks; // Derived(NEW)
    SELF.rawaid := ri.rawaid; // Derived(NEW)
    SELF.prim_range := ri.prim_range; // Derived(NEW)
    SELF.predir := ri.predir; // Derived(NEW)
    SELF.prim_name := ri.prim_name; // Derived(NEW)
    SELF.addr_suffix := ri.addr_suffix; // Derived(NEW)
    SELF.postdir := ri.postdir; // Derived(NEW)
    SELF.unit_desig := ri.unit_desig; // Derived(NEW)
    SELF.sec_range := ri.sec_range; // Derived(NEW)
    SELF.p_city_name := ri.p_city_name; // Derived(NEW)
    SELF.v_city_name := ri.v_city_name; // Derived(NEW)
    SELF.st := ri.st; // Derived(NEW)
    SELF.zip := ri.zip; // Derived(NEW)
    SELF.zip4 := ri.zip4; // Derived(NEW)
    SELF.cart := ri.cart; // Derived(NEW)
    SELF.cr_sort_sz := ri.cr_sort_sz; // Derived(NEW)
    SELF.lot := ri.lot; // Derived(NEW)
    SELF.lot_order := ri.lot_order; // Derived(NEW)
    SELF.dbpc := ri.dbpc; // Derived(NEW)
    SELF.chk_digit := ri.chk_digit; // Derived(NEW)
    SELF.rec_type := ri.rec_type; // Derived(NEW)
    SELF.county := ri.county; // Derived(NEW)
    SELF.geo_lat := ri.geo_lat; // Derived(NEW)
    SELF.geo_long := ri.geo_long; // Derived(NEW)
    SELF.msa := ri.msa; // Derived(NEW)
    SELF.geo_blk := ri.geo_blk; // Derived(NEW)
    SELF.geo_match := ri.geo_match; // Derived(NEW)
    SELF.err_stat := ri.err_stat; // Derived(NEW)
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.process_date <> le.process_date OR SELF.date_first_seen <> le.date_first_seen OR SELF.date_last_seen <> le.date_last_seen OR SELF.date_vendor_first_reported <> le.date_vendor_first_reported OR SELF.date_vendor_last_reported <> le.date_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(mls_geo_full_address,mls_geo_city,mls_geo_state
             ,mls_geo_zip_code));
  SortIngest0 := SORT(DistIngest0,mls_geo_full_address,mls_geo_city,mls_geo_state
             ,mls_geo_zip_code, __Tpe, rid, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,mls_geo_full_address,mls_geo_city,mls_geo_state
             ,mls_geo_zip_code, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(mls_geo_full_address,mls_geo_city,mls_geo_state
             ,mls_geo_zip_code));
  SortBase0 := SORT(DistBase0,mls_geo_full_address,mls_geo_city,mls_geo_state
             ,mls_geo_zip_code, __Tpe, rid, LOCAL);
  GroupBase0 := GROUP(SortBase0,mls_geo_full_address,mls_geo_city,mls_geo_state
             ,mls_geo_zip_code, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,mls_geo_full_address,mls_geo_city,mls_geo_state
             ,mls_geo_zip_code, __Tpe,rid,LOCAL);
  Group0 := GROUP(Sort0,mls_geo_full_address,mls_geo_city,mls_geo_state
             ,mls_geo_zip_code,LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));
 
  //Now need to update 'rid' numbers on new records
  //Base upon SALT311.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,rid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rid := IF ( le.rid=0, PrevBase+1+thorlib.node(), le.rid+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(rid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(rid<>0) : PERSIST('~temp::CollateralAnalytics::Ingest_Cache',EXPIRE(CollateralAnalytics.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_CollateralAnalytics);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_CollateralAnalytics);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_CollateralAnalytics);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_CollateralAnalytics); // Records in 'pure' format
 
f := TABLE(dsBase,{rid}) : GLOBAL;
rcid_clusters := SALT311.MOD_ClusterStats.Counts(f,rid);
DuplicateRids0 := COUNT(dsBase) - SUM(rcid_clusters,NumberOfClusters); // Should be zero
d := DATASET([{DuplicateRids0}],{UNSIGNED2 DuplicateRids0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
  EXPORT DoStats := S0;
 
  EXPORT StandardStats(BOOLEAN doInfileOverallCnt = TRUE, BOOLEAN doStatusOverallCnt = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    infileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(FilesToIngest), 'Infile', myTimeStamp));
    basefileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(dsBase), 'Basefile', myTimeStamp));
    deltaCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(Delta), 'Deltafile', myTimeStamp));
    ingestStatusOverall := IF(doStatusOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestStatus(UpdateStats,, myTimeStamp));
    standardStats := infileCntOverall & basefileCntOverall & ingestStatusOverall;
    RETURN standardStats;
  END;
END;

IMPORT STD,SALT311,Infutor_NARC3;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_basefile) Delta = DATASET([],Layout_basefile)
, DATASET(Layout_basefile) dsBase = In_basefile // Change IN_basefile to change input to ingest process
, DATASET(RECORDOF(Infutor_NARC3.Files.base))  infile = Infutor_NARC3.Files.base
) := MODULE
  SHARED NullFile := DATASET([],Layout_basefile); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_basefile;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.src := ri.src; // Derived(NEW)
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
    SELF.orig_hhid := ri.orig_hhid; // Derived(NEW)
    SELF.orig_pid := ri.orig_pid; // Derived(NEW)
    SELF.orig_age := ri.orig_age; // Derived(NEW)
    SELF.orig_hhnbr := ri.orig_hhnbr; // Derived(NEW)
    SELF.orig_addrid := ri.orig_addrid; // Derived(NEW)
    SELF.orig_house := ri.orig_house; // Derived(NEW)
    SELF.orig_predir := ri.orig_predir; // Derived(NEW)
    SELF.orig_street := ri.orig_street; // Derived(NEW)
    SELF.orig_strtype := ri.orig_strtype; // Derived(NEW)
    SELF.orig_postdir := ri.orig_postdir; // Derived(NEW)
    SELF.orig_apttype := ri.orig_apttype; // Derived(NEW)
    SELF.orig_aptnbr := ri.orig_aptnbr; // Derived(NEW)
    SELF.orig_z4 := ri.orig_z4; // Derived(NEW)
    SELF.orig_z4type := ri.orig_z4type; // Derived(NEW)
    SELF.orig_crte := ri.orig_crte; // Derived(NEW)
    SELF.orig_dpv := ri.orig_dpv; // Derived(NEW)
    SELF.orig_vacant := ri.orig_vacant; // Derived(NEW)
    SELF.orig_msa := ri.orig_msa; // Derived(NEW)
    SELF.orig_cbsa := ri.orig_cbsa; // Derived(NEW)
    SELF.orig_dma := ri.orig_dma; // Derived(NEW)
    SELF.orig_county_code := ri.orig_county_code; // Derived(NEW)
    SELF.orig_time_zone := ri.orig_time_zone; // Derived(NEW)
    SELF.orig_time_zone_descr := ri.orig_time_zone_descr; // Derived(NEW)
    SELF.orig_daylight_savings := ri.orig_daylight_savings; // Derived(NEW)
    SELF.orig_latitude := ri.orig_latitude; // Derived(NEW)
    SELF.orig_longitude := ri.orig_longitude; // Derived(NEW)
    SELF.orig_dma_tps_dnc_flag_1 := ri.orig_dma_tps_dnc_flag_1; // Derived(NEW)
    SELF.orig_telephone_number_2 := ri.orig_telephone_number_2; // Derived(NEW)
    SELF.orig_dma_tps_dnc_flag_2 := ri.orig_dma_tps_dnc_flag_2; // Derived(NEW)
    SELF.orig_telephone_number_3 := ri.orig_telephone_number_3; // Derived(NEW)
    SELF.orig_dma_tps_dnc_flag_3 := ri.orig_dma_tps_dnc_flag_3; // Derived(NEW)
    SELF.orig_length_of_residence := ri.orig_length_of_residence; // Derived(NEW)
    SELF.orig_homeowner_renter := ri.orig_homeowner_renter; // Derived(NEW)
    SELF.orig_homeowner_renter_descr := ri.orig_homeowner_renter_descr; // Derived(NEW)
    SELF.orig_year_built := ri.orig_year_built; // Derived(NEW)
    SELF.orig_mobile_home_indicator := ri.orig_mobile_home_indicator; // Derived(NEW)
    SELF.orig_pool_owner := ri.orig_pool_owner; // Derived(NEW)
    SELF.orig_fireplace_in_home := ri.orig_fireplace_in_home; // Derived(NEW)
    SELF.orig_estimated_income := ri.orig_estimated_income; // Derived(NEW)
    SELF.orig_estimated_income_descr := ri.orig_estimated_income_descr; // Derived(NEW)
    SELF.orig_marital_status := ri.orig_marital_status; // Derived(NEW)
    SELF.orig_marital_status_descr := ri.orig_marital_status_descr; // Derived(NEW)
    SELF.orig_single_parent := ri.orig_single_parent; // Derived(NEW)
    SELF.orig_senior_in_hh := ri.orig_senior_in_hh; // Derived(NEW)
    SELF.orig_credit_card_user := ri.orig_credit_card_user; // Derived(NEW)
    SELF.orig_wealth_score_estimated_net_worth := ri.orig_wealth_score_estimated_net_worth; // Derived(NEW)
    SELF.orig_wealth_score_estimated_net_worth_descr := ri.orig_wealth_score_estimated_net_worth_descr; // Derived(NEW)
    SELF.orig_donator_to_charity_or_causes := ri.orig_donator_to_charity_or_causes; // Derived(NEW)
    SELF.orig_dwelling_type := ri.orig_dwelling_type; // Derived(NEW)
    SELF.orig_dwelling_type_descr := ri.orig_dwelling_type_descr; // Derived(NEW)
    SELF.orig_home_market_value := ri.orig_home_market_value; // Derived(NEW)
    SELF.orig_home_market_value_descr := ri.orig_home_market_value_descr; // Derived(NEW)
    SELF.orig_education := ri.orig_education; // Derived(NEW)
    SELF.orig_education_descr := ri.orig_education_descr; // Derived(NEW)
    SELF.orig_ethnicity := ri.orig_ethnicity; // Derived(NEW)
    SELF.orig_ethnicity_descr := ri.orig_ethnicity_descr; // Derived(NEW)
    SELF.orig_child := ri.orig_child; // Derived(NEW)
    SELF.orig_child_age_ranges := ri.orig_child_age_ranges; // Derived(NEW)
    SELF.orig_child_age_ranges_descr := ri.orig_child_age_ranges_descr; // Derived(NEW)
    SELF.orig_number_of_children_in_hh := ri.orig_number_of_children_in_hh; // Derived(NEW)
    SELF.orig_number_of_children_in_hh_descr := ri.orig_number_of_children_in_hh_descr; // Derived(NEW)
    SELF.orig_luxury_vehicle_owner := ri.orig_luxury_vehicle_owner; // Derived(NEW)
    SELF.orig_suv_owner := ri.orig_suv_owner; // Derived(NEW)
    SELF.orig_pickup_truck_owner := ri.orig_pickup_truck_owner; // Derived(NEW)
    SELF.orig_price_club_and_value_purchasing_indicator := ri.orig_price_club_and_value_purchasing_indicator; // Derived(NEW)
    SELF.orig_womens_apparel_purchasing_indicator := ri.orig_womens_apparel_purchasing_indicator; // Derived(NEW)
    SELF.orig_womens_apparel_purchasing_indicator_descr := ri.orig_womens_apparel_purchasing_indicator_descr; // Derived(NEW)
    SELF.orig_mens_apparel_purchasing_indcator := ri.orig_mens_apparel_purchasing_indcator; // Derived(NEW)
    SELF.orig_mens_apparel_purchasing_indcator_descr := ri.orig_mens_apparel_purchasing_indcator_descr; // Derived(NEW)
    SELF.orig_parenting_and_childrens_interest_bundle := ri.orig_parenting_and_childrens_interest_bundle; // Derived(NEW)
    SELF.orig_pet_lovers_or_owners := ri.orig_pet_lovers_or_owners; // Derived(NEW)
    SELF.orig_pet_lovers_or_owners_descr := ri.orig_pet_lovers_or_owners_descr; // Derived(NEW)
    SELF.orig_book_buyers := ri.orig_book_buyers; // Derived(NEW)
    SELF.orig_book_readers := ri.orig_book_readers; // Derived(NEW)
    SELF.orig_hi_tech_enthusiasts := ri.orig_hi_tech_enthusiasts; // Derived(NEW)
    SELF.orig_arts_bundle := ri.orig_arts_bundle; // Derived(NEW)
    SELF.orig_arts_bundle_descr := ri.orig_arts_bundle_descr; // Derived(NEW)
    SELF.orig_collectibles_bundle := ri.orig_collectibles_bundle; // Derived(NEW)
    SELF.orig_collectibles_bundle_descr := ri.orig_collectibles_bundle_descr; // Derived(NEW)
    SELF.orig_hobbies_home_and_garden_bundle := ri.orig_hobbies_home_and_garden_bundle; // Derived(NEW)
    SELF.orig_hobbies_home_and_garden_bundle_descr := ri.orig_hobbies_home_and_garden_bundle_descr; // Derived(NEW)
    SELF.orig_home_improvement := ri.orig_home_improvement; // Derived(NEW)
    SELF.orig_home_improvement_descr := ri.orig_home_improvement_descr; // Derived(NEW)
    SELF.orig_cooking_and_wine := ri.orig_cooking_and_wine; // Derived(NEW)
    SELF.orig_cooking_and_wine_descr := ri.orig_cooking_and_wine_descr; // Derived(NEW)
    SELF.orig_gaming_and_gambling_enthusiast := ri.orig_gaming_and_gambling_enthusiast; // Derived(NEW)
    SELF.orig_travel_enthusiasts := ri.orig_travel_enthusiasts; // Derived(NEW)
    SELF.orig_travel_enthusiasts_descr := ri.orig_travel_enthusiasts_descr; // Derived(NEW)
    SELF.orig_physical_fitness := ri.orig_physical_fitness; // Derived(NEW)
    SELF.orig_physical_fitness_descr := ri.orig_physical_fitness_descr; // Derived(NEW)
    SELF.orig_self_improvement := ri.orig_self_improvement; // Derived(NEW)
    SELF.orig_self_improvement_descr := ri.orig_self_improvement_descr; // Derived(NEW)
    SELF.orig_automotive_diy := ri.orig_automotive_diy; // Derived(NEW)
    SELF.orig_spectator_sports_interest := ri.orig_spectator_sports_interest; // Derived(NEW)
    SELF.orig_spectator_sports_interest_descr := ri.orig_spectator_sports_interest_descr; // Derived(NEW)
    SELF.orig_outdoors := ri.orig_outdoors; // Derived(NEW)
    SELF.orig_outdoors_descr := ri.orig_outdoors_descr; // Derived(NEW)
    SELF.orig_avid_investors := ri.orig_avid_investors; // Derived(NEW)
    SELF.orig_avid_interest_in_boating := ri.orig_avid_interest_in_boating; // Derived(NEW)
    SELF.orig_avid_interest_in_motorcycling := ri.orig_avid_interest_in_motorcycling; // Derived(NEW)
    SELF.orig_percent_range_black := ri.orig_percent_range_black; // Derived(NEW)
    SELF.orig_percent_range_black_descr := ri.orig_percent_range_black_descr; // Derived(NEW)
    SELF.orig_percent_range_white := ri.orig_percent_range_white; // Derived(NEW)
    SELF.orig_percent_range_white_descr := ri.orig_percent_range_white_descr; // Derived(NEW)
    SELF.orig_percent_range_hispanic := ri.orig_percent_range_hispanic; // Derived(NEW)
    SELF.orig_percent_range_hispanic_descr := ri.orig_percent_range_hispanic_descr; // Derived(NEW)
    SELF.orig_percent_range_asian := ri.orig_percent_range_asian; // Derived(NEW)
    SELF.orig_percent_range_asian_descr := ri.orig_percent_range_asian_descr; // Derived(NEW)
    SELF.orig_percent_range_english_speaking := ri.orig_percent_range_english_speaking; // Derived(NEW)
    SELF.orig_percent_range_english_speaking_descr := ri.orig_percent_range_english_speaking_descr; // Derived(NEW)
    SELF.orig_percnt_range_spanish_speaking := ri.orig_percnt_range_spanish_speaking; // Derived(NEW)
    SELF.orig_percnt_range_spanish_speaking_descr := ri.orig_percnt_range_spanish_speaking_descr; // Derived(NEW)
    SELF.orig_percent_range_asian_speaking := ri.orig_percent_range_asian_speaking; // Derived(NEW)
    SELF.orig_percent_range_asian_speaking_descr := ri.orig_percent_range_asian_speaking_descr; // Derived(NEW)
    SELF.orig_percent_range_sfdu := ri.orig_percent_range_sfdu; // Derived(NEW)
    SELF.orig_percent_range_sfdu_descr := ri.orig_percent_range_sfdu_descr; // Derived(NEW)
    SELF.orig_percent_range_mfdu := ri.orig_percent_range_mfdu; // Derived(NEW)
    SELF.orig_percent_range_mfdu_descr := ri.orig_percent_range_mfdu_descr; // Derived(NEW)
    SELF.orig_mhv := ri.orig_mhv; // Derived(NEW)
    SELF.orig_mhv_descr := ri.orig_mhv_descr; // Derived(NEW)
    SELF.orig_mor := ri.orig_mor; // Derived(NEW)
    SELF.orig_mor_descr := ri.orig_mor_descr; // Derived(NEW)
    SELF.orig_car := ri.orig_car; // Derived(NEW)
    SELF.orig_car_descr := ri.orig_car_descr; // Derived(NEW)
    SELF.orig_medschl := ri.orig_medschl; // Derived(NEW)
    SELF.orig_penetration_range_white_collar := ri.orig_penetration_range_white_collar; // Derived(NEW)
    SELF.orig_penetration_range_white_collar_descr := ri.orig_penetration_range_white_collar_descr; // Derived(NEW)
    SELF.orig_penetration_range_blue_collar := ri.orig_penetration_range_blue_collar; // Derived(NEW)
    SELF.orig_penetration_range_blue_collar_descr := ri.orig_penetration_range_blue_collar_descr; // Derived(NEW)
    SELF.orig_penetration_range_other_occupation := ri.orig_penetration_range_other_occupation; // Derived(NEW)
    SELF.orig_penetration_range_other_occupation_descr := ri.orig_penetration_range_other_occupation_descr; // Derived(NEW)
    SELF.orig_demolevel := ri.orig_demolevel; // Derived(NEW)
    SELF.orig_demolevel_descr := ri.orig_demolevel_descr; // Derived(NEW)
    SELF.title := ri.title; // Derived(NEW)
    SELF.fname := ri.fname; // Derived(NEW)
    SELF.mname := ri.mname; // Derived(NEW)
    SELF.lname := ri.lname; // Derived(NEW)
    SELF.name_suffix := ri.name_suffix; // Derived(NEW)
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
    SELF.fips_st := ri.fips_st; // Derived(NEW)
    SELF.fips_county := ri.fips_county; // Derived(NEW)
    SELF.geo_lat := ri.geo_lat; // Derived(NEW)
    SELF.geo_long := ri.geo_long; // Derived(NEW)
    SELF.msa := ri.msa; // Derived(NEW)
    SELF.geo_blk := ri.geo_blk; // Derived(NEW)
    SELF.geo_match := ri.geo_match; // Derived(NEW)
    SELF.err_stat := ri.err_stat; // Derived(NEW)
    SELF.did := ri.did; // Derived(NEW)
    SELF.ssn_append := ri.ssn_append; // Derived(NEW)
    SELF.did_score := ri.did_score; // Derived(NEW)
    SELF.clean_phone := ri.clean_phone; // Derived(NEW)
    SELF.clean_dob := ri.clean_dob; // Derived(NEW)
    SELF.record_type := ri.record_type; // Derived(NEW)
    SELF.rawaid := ri.rawaid; // Derived(NEW)
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.process_date <> le.process_date OR SELF.date_first_seen <> le.date_first_seen OR SELF.date_last_seen <> le.date_last_seen OR SELF.date_vendor_first_reported <> le.date_vendor_first_reported OR SELF.date_vendor_last_reported <> le.date_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(orig_fname
             ,orig_mname,orig_lname,orig_suffix,orig_gender,orig_dob,orig_address,orig_city,orig_state,orig_zip
             ,orig_dpc,orig_telephone_number_1));
  SortIngest0 := SORT(DistIngest0,orig_fname
             ,orig_mname,orig_lname,orig_suffix,orig_gender,orig_dob,orig_address,orig_city,orig_state,orig_zip
             ,orig_dpc,orig_telephone_number_1, __Tpe, recordid, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,orig_fname
             ,orig_mname,orig_lname,orig_suffix,orig_gender,orig_dob,orig_address,orig_city,orig_state,orig_zip
             ,orig_dpc,orig_telephone_number_1, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(orig_fname
             ,orig_mname,orig_lname,orig_suffix,orig_gender,orig_dob,orig_address,orig_city,orig_state,orig_zip
             ,orig_dpc,orig_telephone_number_1));
  SortBase0 := SORT(DistBase0,orig_fname
             ,orig_mname,orig_lname,orig_suffix,orig_gender,orig_dob,orig_address,orig_city,orig_state,orig_zip
             ,orig_dpc,orig_telephone_number_1, __Tpe, recordid, LOCAL);
  GroupBase0 := GROUP(SortBase0,orig_fname
             ,orig_mname,orig_lname,orig_suffix,orig_gender,orig_dob,orig_address,orig_city,orig_state,orig_zip
             ,orig_dpc,orig_telephone_number_1, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,orig_fname
             ,orig_mname,orig_lname,orig_suffix,orig_gender,orig_dob,orig_address,orig_city,orig_state,orig_zip
             ,orig_dpc,orig_telephone_number_1, __Tpe,recordid,LOCAL);
  Group0 := GROUP(Sort0,orig_fname
             ,orig_mname,orig_lname,orig_suffix,orig_gender,orig_dob,orig_address,orig_city,orig_state,orig_zip
             ,orig_dpc,orig_telephone_number_1,LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));
 
  //Now need to update 'rid' numbers on new records
  //Base upon SALT311.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,recordid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.recordid := IF ( le.recordid=0, PrevBase+1+thorlib.node(), le.recordid+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(recordid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(recordid<>0) : PERSIST('~temp::Infutor_NARC3::Ingest_Cache',EXPIRE(Infutor_NARC3.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_basefile);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_basefile);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_basefile);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_basefile); // Records in 'pure' format
 
f := TABLE(dsBase,{recordid}) : GLOBAL;
rcid_clusters := SALT311.MOD_ClusterStats.Counts(f,recordid);
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

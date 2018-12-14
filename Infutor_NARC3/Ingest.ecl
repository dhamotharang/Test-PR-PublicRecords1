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
    SELF.orig_hhid := ri.orig_hhid; // Derived(NEW)
    SELF.orig_pid := ri.orig_pid; // Derived(NEW)
    SELF.orig_age := ri.orig_age; // Derived(NEW)
    SELF.orig_dob := ri.orig_dob; // Derived(NEW)
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
    SELF.orig_daylight_savings := ri.orig_daylight_savings; // Derived(NEW)
    SELF.orig_latitude := ri.orig_latitude; // Derived(NEW)
    SELF.orig_longitude := ri.orig_longitude; // Derived(NEW)
    SELF.orig_orig_Telephone_Number_1 := ri.orig_Telephone_Number_1; // Derived(NEW)
    SELF.orig_dma_tps_dnc_flag_1 := ri.orig_dma_tps_dnc_flag_1; // Derived(NEW)
    SELF.orig_telephonenumber_2 := ri.orig_telephonenumber_2; // Derived(NEW)
    SELF.orig_dma_tps_dnc_flag_2 := ri.orig_dma_tps_dnc_flag_2; // Derived(NEW)
    SELF.orig_telephonenumber_3 := ri.orig_telephonenumber_3; // Derived(NEW)
    SELF.orig_dma_tps_dnc_flag_3 := ri.orig_dma_tps_dnc_flag_3; // Derived(NEW)
    SELF.orig_length_of_residence := ri.orig_length_of_residence; // Derived(NEW)
    SELF.orig_homeowner := ri.orig_homeowner; // Derived(NEW)
    SELF.year_built := ri.year_built; // Derived(NEW)
    SELF.mobile_home_ind := ri.mobile_home_ind; // Derived(NEW)
    SELF.pool_owner_ind := ri.pool_owner_ind; // Derived(NEW)
    SELF.fireplace_ind := ri.fireplace_ind; // Derived(NEW)
    SELF.orig_estimatedincome := ri.orig_estimatedincome; // Derived(NEW)
    SELF.orig_married := ri.orig_married; // Derived(NEW)
    SELF.single_parent_ind := ri.single_parent_ind; // Derived(NEW)
    SELF.senior_hh_ind := ri.senior_hh_ind; // Derived(NEW)
    SELF.credit_card_user_ind := ri.credit_card_user_ind; // Derived(NEW)
    SELF.wealth_score := ri.wealth_score; // Derived(NEW)
    SELF.charity_donor_ind := ri.charity_donor_ind; // Derived(NEW)
    SELF.orig_dwelling_type := ri.orig_dwelling_type; // Derived(NEW)
    SELF.home_marker_value := ri.home_marker_value; // Derived(NEW)
    SELF.education_level := ri.education_level; // Derived(NEW)
    SELF.ethnicity := ri.ethnicity; // Derived(NEW)
    SELF.orig_child := ri.orig_child; // Derived(NEW)
    SELF.child_age_range := ri.child_age_range; // Derived(NEW)
    SELF.orig_nbrchild := ri.orig_nbrchild; // Derived(NEW)
    SELF.luxury_veh_owner_ind := ri.luxury_veh_owner_ind; // Derived(NEW)
    SELF.suv_veh_owner_ind := ri.suv_veh_owner_ind; // Derived(NEW)
    SELF.truck_veh_ownere_ind := ri.truck_veh_ownere_ind; // Derived(NEW)
    SELF.price_club_purchasing_ind := ri.price_club_purchasing_ind; // Derived(NEW)
    SELF.women_apparal_purchasing_ind := ri.women_apparal_purchasing_ind; // Derived(NEW)
    SELF.men_apparel_purchasing_ind := ri.men_apparel_purchasing_ind; // Derived(NEW)
    SELF.parent_child_interest_ind := ri.parent_child_interest_ind; // Derived(NEW)
    SELF.pet_owner := ri.pet_owner; // Derived(NEW)
    SELF.book_buyer_ind := ri.book_buyer_ind; // Derived(NEW)
    SELF.book_reader_ind := ri.book_reader_ind; // Derived(NEW)
    SELF.hi_tech_enthusiasts := ri.hi_tech_enthusiasts; // Derived(NEW)
    SELF.arts := ri.arts; // Derived(NEW)
    SELF.collectibles := ri.collectibles; // Derived(NEW)
    SELF.hobbies_garden := ri.hobbies_garden; // Derived(NEW)
    SELF.home_improvement := ri.home_improvement; // Derived(NEW)
    SELF.cook_wine := ri.cook_wine; // Derived(NEW)
    SELF.gaming_gabling := ri.gaming_gabling; // Derived(NEW)
    SELF.travel_enthusiast := ri.travel_enthusiast; // Derived(NEW)
    SELF.physical_fitness := ri.physical_fitness; // Derived(NEW)
    SELF.self_improvement := ri.self_improvement; // Derived(NEW)
    SELF.automotive_diy := ri.automotive_diy; // Derived(NEW)
    SELF.spectator_sport_interest := ri.spectator_sport_interest; // Derived(NEW)
    SELF.outdoors := ri.outdoors; // Derived(NEW)
    SELF.avid_investors_ind := ri.avid_investors_ind; // Derived(NEW)
    SELF.avid_boating_ind := ri.avid_boating_ind; // Derived(NEW)
    SELF.avid_motorcycling_ind := ri.avid_motorcycling_ind; // Derived(NEW)
    SELF.orig_percent_range_black := ri.orig_percent_range_black; // Derived(NEW)
    SELF.orig_percent_range_white := ri.orig_percent_range_white; // Derived(NEW)
    SELF.orig_percent_range_hispanic := ri.orig_percent_range_hispanic; // Derived(NEW)
    SELF.orig_percent_range_asian := ri.orig_percent_range_asian; // Derived(NEW)
    SELF.orig_percent_range_english_speaking := ri.orig_percent_range_english_speaking; // Derived(NEW)
    SELF.orig_percnt_range_spanish_speaking := ri.orig_percnt_range_spanish_speaking; // Derived(NEW)
    SELF.orig_percent_range_asian_speaking := ri.orig_percent_range_asian_speaking; // Derived(NEW)
    SELF.orig_percent_range_sfdu := ri.orig_percent_range_sfdu; // Derived(NEW)
    SELF.orig_percent_range_mfdu := ri.orig_percent_range_mfdu; // Derived(NEW)
    SELF.orig_mhv := ri.orig_mhv; // Derived(NEW)
    SELF.orig_mor := ri.orig_mor; // Derived(NEW)
    SELF.orig_car := ri.orig_car; // Derived(NEW)
    SELF.orig_medschl := ri.orig_medschl; // Derived(NEW)
    SELF.orig_penetration_range_whitecollar := ri.orig_penetration_range_whitecollar; // Derived(NEW)
    SELF.orig_penetration_range_bluecollar := ri.orig_penetration_range_bluecollar; // Derived(NEW)
    SELF.orig_penetration_range_otheroccupation := ri.orig_penetration_range_otheroccupation; // Derived(NEW)
    SELF.orig_demolevel := ri.orig_demolevel; // Derived(NEW)
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
    SELF.did_score := ri.did_score; // Derived(NEW)
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
    SELF.record_type := ri.record_type; // Derived(NEW)
    SELF.src := ri.src; // Derived(NEW)
    SELF.rawaid := ri.rawaid; // Derived(NEW)
    SELF.lexhhid := ri.lexhhid; // Derived(NEW)
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.process_date <> le.process_date OR SELF.date_first_seen <> le.date_first_seen OR SELF.date_last_seen <> le.date_last_seen OR SELF.date_vendor_first_reported <> le.date_vendor_first_reported OR SELF.date_vendor_last_reported <> le.date_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_address
             ,orig_city,orig_state,orig_zip,orig_dpc
             ,clean_phone,clean_dob));
  SortIngest0 := SORT(DistIngest0,orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_address
             ,orig_city,orig_state,orig_zip,orig_dpc
             ,clean_phone,clean_dob, __Tpe, key, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_address
             ,orig_city,orig_state,orig_zip,orig_dpc
             ,clean_phone,clean_dob, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_address
             ,orig_city,orig_state,orig_zip,orig_dpc
             ,clean_phone,clean_dob));
  SortBase0 := SORT(DistBase0,orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_address
             ,orig_city,orig_state,orig_zip,orig_dpc
             ,clean_phone,clean_dob, __Tpe, key, LOCAL);
  GroupBase0 := GROUP(SortBase0,orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_address
             ,orig_city,orig_state,orig_zip,orig_dpc
             ,clean_phone,clean_dob, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_address
             ,orig_city,orig_state,orig_zip,orig_dpc
             ,clean_phone,clean_dob, __Tpe,key,LOCAL);
  Group0 := GROUP(Sort0,orig_fname,orig_mname,orig_lname,orig_suffix,orig_gender,orig_address
             ,orig_city,orig_state,orig_zip,orig_dpc
             ,clean_phone,clean_dob,LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));
 
  //Now need to update 'rid' numbers on new records
  //Base upon SALT311.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,key);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.key := IF ( le.key=0, PrevBase+1+thorlib.node(), le.key+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(key=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(key<>0) : PERSIST('~temp::Infutor_NARC3::Ingest_Cache',EXPIRE(Infutor_NARC3.Config.PersistExpire));
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
 
f := TABLE(dsBase,{key}) : GLOBAL;
rcid_clusters := SALT311.MOD_ClusterStats.Counts(f,key);
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

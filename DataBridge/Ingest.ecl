IMPORT STD,SALT311;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(DataBridge.Layouts.Base)            Delta = DATASET([],DataBridge.Layouts.Base)
, DATASET(DataBridge.Layouts.Base)            dsBase 
, DATASET(RECORDOF(DataBridge.Layouts.Base))  infile 
) := MODULE
  SHARED NullFile := DATASET([],DataBridge.Layouts.Base); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  In_Src_Cnt_Rec := RECORD
    FilesToIngest.source;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  EXPORT InputSourceCounts := TABLE(FilesToIngest,In_Src_Cnt_Rec,source,FEW);
  SHARED S0 := OUTPUT(InputSourceCounts,ALL,NAMED('InputSourceCounts'));
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    DataBridge.Layouts.Base;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.dt_first_seen := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.dt_first_seen = 0 => ri.dt_first_seen,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.dt_first_seen = 0 => le.dt_first_seen,
                     (UNSIGNED)le.dt_first_seen < (UNSIGNED)ri.dt_first_seen => le.dt_first_seen, // Want the lowest non-zero value
                     ri.dt_first_seen);
    SELF.dt_last_seen := MAP ( le.__Tpe = 0 => ri.dt_last_seen,
                     ri.__Tpe = 0 => le.dt_last_seen,
                     (UNSIGNED)le.dt_last_seen < (UNSIGNED)ri.dt_last_seen => ri.dt_last_seen, // Want the highest value
                     le.dt_last_seen);
    SELF.dt_vendor_first_reported := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.dt_vendor_first_reported = 0 => ri.dt_vendor_first_reported,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.dt_vendor_first_reported = 0 => le.dt_vendor_first_reported,
                     (UNSIGNED)le.dt_vendor_first_reported < (UNSIGNED)ri.dt_vendor_first_reported => le.dt_vendor_first_reported, // Want the lowest non-zero value
                     ri.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.dt_vendor_last_reported,
                     ri.__Tpe = 0 => le.dt_vendor_last_reported,
                     (UNSIGNED)le.dt_vendor_last_reported < (UNSIGNED)ri.dt_vendor_last_reported => ri.dt_vendor_last_reported, // Want the highest value
                     le.dt_vendor_last_reported);
    SELF.process_date := ri.process_date; // Derived(NEW)
    SELF.dotid := ri.dotid; // Derived(NEW)
    SELF.dotscore := ri.dotscore; // Derived(NEW)
    SELF.dotweight := ri.dotweight; // Derived(NEW)
    SELF.empid := ri.empid; // Derived(NEW)
    SELF.empscore := ri.empscore; // Derived(NEW)
    SELF.empweight := ri.empweight; // Derived(NEW)
    SELF.powid := ri.powid; // Derived(NEW)
    SELF.powscore := ri.powscore; // Derived(NEW)
    SELF.powweight := ri.powweight; // Derived(NEW)
    SELF.proxid := ri.proxid; // Derived(NEW)
    SELF.proxscore := ri.proxscore; // Derived(NEW)
    SELF.proxweight := ri.proxweight; // Derived(NEW)
    SELF.selescore := ri.selescore; // Derived(NEW)
    SELF.seleweight := ri.seleweight; // Derived(NEW)
    SELF.orgid := ri.orgid; // Derived(NEW)
    SELF.orgscore := ri.orgscore; // Derived(NEW)
    SELF.orgweight := ri.orgweight; // Derived(NEW)
    SELF.ultid := ri.ultid; // Derived(NEW)
    SELF.ultscore := ri.ultscore; // Derived(NEW)
    SELF.ultweight := ri.ultweight; // Derived(NEW)
    SELF.record_type := ri.record_type; // Derived(NEW)
    SELF.global_sid := ri.global_sid; // Derived(NEW)
    SELF.clean_company_name := ri.clean_company_name; // Derived(NEW)
    SELF.clean_telephone_num := ri.clean_telephone_num; // Derived(NEW)
    SELF.mail_score_desc := ri.mail_score_desc; // Derived(NEW)
    SELF.name_gender_desc := ri.name_gender_desc; // Derived(NEW)
    SELF.title_desc_1 := ri.title_desc_1; // Derived(NEW)
    SELF.title_desc_2 := ri.title_desc_2; // Derived(NEW)
    SELF.title_desc_3 := ri.title_desc_3; // Derived(NEW)
    SELF.title_desc_4 := ri.title_desc_4; // Derived(NEW)
    SELF.sic8_desc_1 := ri.sic8_desc_1; // Derived(NEW)
    SELF.sic8_desc_2 := ri.sic8_desc_2; // Derived(NEW)
    SELF.sic8_desc_3 := ri.sic8_desc_3; // Derived(NEW)
    SELF.sic8_desc_4 := ri.sic8_desc_4; // Derived(NEW)
    SELF.sic6_desc_1 := ri.sic6_desc_1; // Derived(NEW)
    SELF.sic6_desc_2 := ri.sic6_desc_2; // Derived(NEW)
    SELF.sic6_desc_3 := ri.sic6_desc_3; // Derived(NEW)
    SELF.sic6_desc_4 := ri.sic6_desc_4; // Derived(NEW)
    SELF.sic6_desc_5 := ri.sic6_desc_5; // Derived(NEW)
    SELF.title := ri.title; // Derived(NEW)
    SELF.fname := ri.fname; // Derived(NEW)
    SELF.mname := ri.mname; // Derived(NEW)
    SELF.lname := ri.lname; // Derived(NEW)
    SELF.name_score := ri.name_score; // Derived(NEW)
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
    SELF.fips_state := ri.fips_state; // Derived(NEW)
    SELF.fips_county := ri.fips_county; // Derived(NEW)
    SELF.geo_lat := ri.geo_lat; // Derived(NEW)
    SELF.geo_long := ri.geo_long; // Derived(NEW)
    SELF.msa := ri.msa; // Derived(NEW)
    SELF.geo_blk := ri.geo_blk; // Derived(NEW)
    SELF.geo_match := ri.geo_match; // Derived(NEW)
    SELF.err_stat := ri.err_stat; // Derived(NEW)
    SELF.raw_aid := ri.raw_aid; // Derived(NEW)
    SELF.ace_aid := ri.ace_aid; // Derived(NEW)
    SELF.prep_address_line1 := ri.prep_address_line1; // Derived(NEW)
    SELF.prep_address_line_last := ri.prep_address_line_last; // Derived(NEW)
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.dt_first_seen <> le.dt_first_seen OR SELF.dt_last_seen <> le.dt_last_seen OR SELF.dt_vendor_first_reported <> le.dt_vendor_first_reported OR SELF.dt_vendor_last_reported <> le.dt_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(name,company,address,address2,city
             ,state,scf,zip_code5,zip_code4,mail_score,area_code,telephone_number,name_gender,name_prefix,name_first
             ,name_middle_initial,name_last,suffix,title_code_1,title_code_2,title_code_3,title_code_4,web_address,sic8_1,sic8_2
             ,sic8_3,sic8_4,sic6_1,sic6_2,sic6_3,sic6_4,sic6_5,email,email_present_flag,site_source1
             ,site_source2,site_source3,site_source4,site_source5,site_source6,site_source7,site_source8,site_source9,site_source10,individual_source1
             ,individual_source2,individual_source3,individual_source4,individual_source5,individual_source6,individual_source7,individual_source8,individual_source9,individual_source10,email_status));
  SortIngest0 := SORT(DistIngest0,name,company,address,address2,city
             ,state,scf,zip_code5,zip_code4,mail_score,area_code,telephone_number,name_gender,name_prefix,name_first
             ,name_middle_initial,name_last,suffix,title_code_1,title_code_2,title_code_3,title_code_4,web_address,sic8_1,sic8_2
             ,sic8_3,sic8_4,sic6_1,sic6_2,sic6_3,sic6_4,sic6_5,email,email_present_flag,site_source1
             ,site_source2,site_source3,site_source4,site_source5,site_source6,site_source7,site_source8,site_source9,site_source10,individual_source1
             ,individual_source2,individual_source3,individual_source4,individual_source5,individual_source6,individual_source7,individual_source8,individual_source9,individual_source10,email_status, __Tpe, record_sid, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,name,company,address,address2,city
             ,state,scf,zip_code5,zip_code4,mail_score,area_code,telephone_number,name_gender,name_prefix,name_first
             ,name_middle_initial,name_last,suffix,title_code_1,title_code_2,title_code_3,title_code_4,web_address,sic8_1,sic8_2
             ,sic8_3,sic8_4,sic6_1,sic6_2,sic6_3,sic6_4,sic6_5,email,email_present_flag,site_source1
             ,site_source2,site_source3,site_source4,site_source5,site_source6,site_source7,site_source8,site_source9,site_source10,individual_source1
             ,individual_source2,individual_source3,individual_source4,individual_source5,individual_source6,individual_source7,individual_source8,individual_source9,individual_source10,email_status, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(name,company,address,address2,city
             ,state,scf,zip_code5,zip_code4,mail_score,area_code,telephone_number,name_gender,name_prefix,name_first
             ,name_middle_initial,name_last,suffix,title_code_1,title_code_2,title_code_3,title_code_4,web_address,sic8_1,sic8_2
             ,sic8_3,sic8_4,sic6_1,sic6_2,sic6_3,sic6_4,sic6_5,email,email_present_flag,site_source1
             ,site_source2,site_source3,site_source4,site_source5,site_source6,site_source7,site_source8,site_source9,site_source10,individual_source1
             ,individual_source2,individual_source3,individual_source4,individual_source5,individual_source6,individual_source7,individual_source8,individual_source9,individual_source10,email_status));
  SortBase0 := SORT(DistBase0,name,company,address,address2,city
             ,state,scf,zip_code5,zip_code4,mail_score,area_code,telephone_number,name_gender,name_prefix,name_first
             ,name_middle_initial,name_last,suffix,title_code_1,title_code_2,title_code_3,title_code_4,web_address,sic8_1,sic8_2
             ,sic8_3,sic8_4,sic6_1,sic6_2,sic6_3,sic6_4,sic6_5,email,email_present_flag,site_source1
             ,site_source2,site_source3,site_source4,site_source5,site_source6,site_source7,site_source8,site_source9,site_source10,individual_source1
             ,individual_source2,individual_source3,individual_source4,individual_source5,individual_source6,individual_source7,individual_source8,individual_source9,individual_source10,email_status, __Tpe, record_sid, LOCAL);
  GroupBase0 := GROUP(SortBase0,name,company,address,address2,city
             ,state,scf,zip_code5,zip_code4,mail_score,area_code,telephone_number,name_gender,name_prefix,name_first
             ,name_middle_initial,name_last,suffix,title_code_1,title_code_2,title_code_3,title_code_4,web_address,sic8_1,sic8_2
             ,sic8_3,sic8_4,sic6_1,sic6_2,sic6_3,sic6_4,sic6_5,email,email_present_flag,site_source1
             ,site_source2,site_source3,site_source4,site_source5,site_source6,site_source7,site_source8,site_source9,site_source10,individual_source1
             ,individual_source2,individual_source3,individual_source4,individual_source5,individual_source6,individual_source7,individual_source8,individual_source9,individual_source10,email_status, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,name,company,address,address2,city
             ,state,scf,zip_code5,zip_code4,mail_score,area_code,telephone_number,name_gender,name_prefix,name_first
             ,name_middle_initial,name_last,suffix,title_code_1,title_code_2,title_code_3,title_code_4,web_address,sic8_1,sic8_2
             ,sic8_3,sic8_4,sic6_1,sic6_2,sic6_3,sic6_4,sic6_5,email,email_present_flag,site_source1
             ,site_source2,site_source3,site_source4,site_source5,site_source6,site_source7,site_source8,site_source9,site_source10,individual_source1
             ,individual_source2,individual_source3,individual_source4,individual_source5,individual_source6,individual_source7,individual_source8,individual_source9,individual_source10,email_status, __Tpe,record_sid,LOCAL);
  Group0 := GROUP(Sort0,name,company,address,address2,city
             ,state,scf,zip_code5,zip_code4,mail_score,area_code,telephone_number,name_gender,name_prefix,name_first
             ,name_middle_initial,name_last,suffix,title_code_1,title_code_2,title_code_3,title_code_4,web_address,sic8_1,sic8_2
             ,sic8_3,sic8_4,sic6_1,sic6_2,sic6_3,sic6_4,sic6_5,email,email_present_flag,site_source1
             ,site_source2,site_source3,site_source4,site_source5,site_source6,site_source7,site_source8,site_source9,site_source10,individual_source1
             ,individual_source2,individual_source3,individual_source4,individual_source5,individual_source6,individual_source7,individual_source8,individual_source9,individual_source10,email_status,LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));
 
  //Now need to update 'rid' numbers on new records
  //Base upon SALT311.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,record_sid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.record_sid := IF ( le.record_sid=0, PrevBase+1+thorlib.node(), le.record_sid+thorlib.nodes() );
    SELF.seleid := SELF.record_sid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR(record_sid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(record_sid<>0) : PERSIST('~temp::seleid::DataBridge::Ingest_Cache',EXPIRE(DataBridge.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S1 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
  SHARED UpdateStatsSrcFull := SORT(TABLE(AllRecs, {source,__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, source,__Tpe, FEW),source,__Tpe, FEW);
  SHARED UpdateStatsSrcInc := SORT(UpdateStatsSrcFull(__Tpe = RecordType.New), source,__Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStatsSrc := IF(incremental, UpdateStatsSrcInc, UpdateStatsSrcFull);
  SHARED S2 := OUTPUT(UpdateStatsSrc, {{UpdateStatsSrc} AND NOT __Tpe}, ALL, NAMED('UpdateStatsSrc'));
 
  SHARED l_roll := RECORD
    UpdateStatsSrc.source;
    unsigned cnt_Old;
    unsigned cnt_Unchanged;
    unsigned cnt_Updated;
    unsigned cnt_New;
    unsigned pct_tot_Old;
    unsigned pct_tot_Unchanged;
    unsigned pct_tot_Updated;
    unsigned pct_tot_New;
    unsigned pct_ingest_Unchanged;
    unsigned pct_ingest_Updated;
    unsigned pct_ingest_New;
  END;
  SHARED l_roll toRoll(UpdateStatsSrc L) := TRANSFORM
    SELF.cnt_Old := IF(L.__Tpe=RecordType.Old, L.Cnt, 0);
    SELF.cnt_Unchanged := IF(L.__Tpe=RecordType.Unchanged, L.Cnt, 0);
    SELF.cnt_Updated := IF(L.__Tpe=RecordType.Updated, L.Cnt, 0);
    SELF.cnt_New := IF(L.__Tpe=RecordType.New, L.Cnt, 0);
    SELF := L;
    SELF := [];
  END;
  SHARED l_roll doRoll(l_roll L, l_roll R) := TRANSFORM
    SELF.cnt_Old := IF(L.cnt_Old<>0, L.cnt_Old, R.cnt_Old);
    SELF.cnt_Unchanged := IF(L.cnt_Unchanged<>0, L.cnt_Unchanged, R.cnt_Unchanged);
    SELF.cnt_Updated := IF(L.cnt_Updated<>0, L.cnt_Updated, R.cnt_Updated);
    SELF.cnt_New := IF(L.cnt_New<>0, L.cnt_New, R.cnt_New);
    SELF := L;
  END;
  SHARED l_roll toPct(l_roll L) := TRANSFORM
    cnt_tot := L.cnt_old + L.cnt_unchanged + L.cnt_updated + L.cnt_new;
    cnt_ingest := L.cnt_unchanged + L.cnt_updated + L.cnt_new;
    SELF.pct_tot_Old := 100.0 * L.cnt_Old / cnt_tot;
    SELF.pct_tot_Unchanged := 100.0 * L.cnt_Unchanged / cnt_tot;
    SELF.pct_tot_Updated := 100.0 * L.cnt_Updated / cnt_tot;
    SELF.pct_tot_New := 100.0 * L.cnt_New / cnt_tot;
    SELF.pct_ingest_Unchanged := 100.0 * L.cnt_Unchanged / cnt_ingest;
    SELF.pct_ingest_Updated := 100.0 * L.cnt_Updated / cnt_ingest;
    SELF.pct_ingest_New := 100.0 * L.cnt_New / cnt_ingest;
    SELF := L;
  END;
  SHARED UpdateStatsXtab := PROJECT(ROLLUP(PROJECT(SORT(UpdateStatsSrc,source),toRoll(LEFT)),doRoll(LEFT,RIGHT),source),toPct(LEFT));
  SHARED S3 := IF(~incremental, OUTPUT(UpdateStatsXtab,ALL,NAMED('UpdateStatsXtab')));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,DataBridge.Layouts.Base);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,DataBridge.Layouts.Base);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,DataBridge.Layouts.Base);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,DataBridge.Layouts.Base); // Records in 'pure' format
 
f := TABLE(dsBase,{record_sid}) : GLOBAL;
rcid_clusters := SALT311.MOD_ClusterStats.Counts(f,record_sid);
DuplicateRids0 := COUNT(dsBase) - SUM(rcid_clusters,NumberOfClusters); // Should be zero
d := DATASET([{DuplicateRids0}],{UNSIGNED2 DuplicateRids0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
  EXPORT DoStats := PARALLEL(S0,S1,S2,S3);
 
  EXPORT StandardStats(BOOLEAN doInfileOverallCnt = TRUE, BOOLEAN doStatusOverallCnt = TRUE, BOOLEAN doInfilePerSrcCnt = TRUE, BOOLEAN doStatusPerSrcCnt = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    infileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(FilesToIngest), 'Infile', myTimeStamp));
    basefileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(dsBase), 'Basefile', myTimeStamp));
    deltaCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(Delta), 'Deltafile', myTimeStamp));
    sourceCountsStandard := IF(doInfilePerSrcCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileSourceCounts(InputSourceCounts, source, myTimeStamp));
    ingestStatusOverall := IF(doStatusOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestStatus(UpdateStats,, myTimeStamp));
    ingestStatusPerSrc := IF(doStatusPerSrcCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestStatus(UpdateStatsSrc, source, myTimeStamp));
    standardStats := infileCntOverall & basefileCntOverall & ingestStatusOverall & sourceCountsStandard & ingestStatusPerSrc;
    RETURN standardStats;
  END;
END;

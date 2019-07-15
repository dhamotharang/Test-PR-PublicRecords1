IMPORT SALT37,InsuranceHeader_Ingest,InsuranceHeader_Incremental;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_Base) Delta = DATASET([],Layout_Base)
, DATASET(Layout_Base) dsBase = In_Base // Change IN_Base to change input to ingest process
, DATASET(RECORDOF(InsuranceHeader_Ingest.In_Ingest))  infile = InsuranceHeader_Ingest.In_Ingest
) := MODULE
  SHARED NullFile := DATASET([],Layout_Base); // Use to replace files you wish to remove
  SHARED FilesToIngest := infile;
  In_Src_Cnt_Rec := RECORD
    FilesToIngest.src;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  EXPORT InputSourceCounts := TABLE(FilesToIngest,In_Src_Cnt_Rec,src,FEW);
  SHARED S0 := OUTPUT(InputSourceCounts,ALL,NAMED('InputSourceCounts'));
// Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_Base;
    BOOLEAN DidChange := FALSE;
    BOOLEAN hardDeleteAdded := FALSE;
    __Tpe := RecordType.Unknown;
  END;
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.DT_EFFECTIVE_FIRST := MAP ( le.__Tpe = 0 OR (unsigned)le.DT_EFFECTIVE_FIRST = 0 => ri.DT_EFFECTIVE_FIRST,
                     ri.__Tpe = 0 OR (unsigned)ri.DT_EFFECTIVE_FIRST = 0 => le.DT_EFFECTIVE_FIRST,
                     (unsigned)le.DT_EFFECTIVE_FIRST < (unsigned)ri.DT_EFFECTIVE_FIRST => le.DT_EFFECTIVE_FIRST, // Want the lowest non-zero value
                     ri.DT_EFFECTIVE_FIRST);
    SELF.DT_EFFECTIVE_LAST := MAP ( le.__Tpe = 0 => ri.DT_EFFECTIVE_LAST,
                     ri.__Tpe = 0 => le.DT_EFFECTIVE_LAST,
                     (unsigned)le.DT_EFFECTIVE_LAST < (unsigned)ri.DT_EFFECTIVE_LAST => ri.DT_EFFECTIVE_LAST, // Want the highest value
                     le.DT_EFFECTIVE_LAST);
    SELF.dt_first_seen := MAP ( le.__Tpe = 0 OR (unsigned)le.dt_first_seen = 0 => ri.dt_first_seen,
                     ri.__Tpe = 0 OR (unsigned)ri.dt_first_seen = 0 => le.dt_first_seen,
                     (unsigned)le.dt_first_seen < (unsigned)ri.dt_first_seen => le.dt_first_seen, // Want the lowest non-zero value
                     ri.dt_first_seen);
    SELF.dt_last_seen := MAP ( le.__Tpe = 0 => ri.dt_last_seen,
                     ri.__Tpe = 0 => le.dt_last_seen,
                     (unsigned)le.dt_last_seen < (unsigned)ri.dt_last_seen => ri.dt_last_seen, // Want the highest value
                     le.dt_last_seen);
    SELF.dt_vendor_first_reported := MAP ( le.__Tpe = 0 OR (unsigned)le.dt_vendor_first_reported = 0 => ri.dt_vendor_first_reported,
                     ri.__Tpe = 0 OR (unsigned)ri.dt_vendor_first_reported = 0 => le.dt_vendor_first_reported,
                     (unsigned)le.dt_vendor_first_reported < (unsigned)ri.dt_vendor_first_reported => le.dt_vendor_first_reported, // Want the lowest non-zero value
                     ri.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.dt_vendor_last_reported,
                     ri.__Tpe = 0 => le.dt_vendor_last_reported,
                     (unsigned)le.dt_vendor_last_reported < (unsigned)ri.dt_vendor_last_reported => ri.dt_vendor_last_reported, // Want the highest value
                     le.dt_vendor_last_reported);
    SELF.title := ri.title; // Derived(NEW)
    SELF.mname := ri.mname; // Derived(NEW)
    SELF.lname := ri.lname; // Derived(NEW)
    SELF.sname := ri.sname; // Derived(NEW)
    SELF.phone := ri.phone; // Derived(NEW)
    SELF.gender := ri.gender; // Derived(NEW)
    SELF.prim_range := ri.prim_range; // Derived(NEW)
    SELF.predir := ri.predir; // Derived(NEW)
    SELF.prim_name := ri.prim_name; // Derived(NEW)
    SELF.addr_suffix := ri.addr_suffix; // Derived(NEW)
    SELF.postdir := ri.postdir; // Derived(NEW)
    SELF.unit_desig := ri.unit_desig; // Derived(NEW)
    SELF.sec_range := ri.sec_range; // Derived(NEW)
    SELF.city := ri.city; // Derived(NEW)
    SELF.st := ri.st; // Derived(NEW)
    SELF.zip := ri.zip; // Derived(NEW)
    SELF.zip4 := ri.zip4; // Derived(NEW)
    SELF.boca_did := ri.boca_did; // Derived(NEW)
    SELF.vendor_id := ri.vendor_id; // Derived(NEW)
    SELF.hardDeleteAdded := le.DT_EFFECTIVE_LAST = 0 AND ri.DT_EFFECTIVE_LAST > 0 AND le.__Tpe <> RecordType.New AND ri.__Tpe = RecordType.New;
    SELF.DidChange := ~SELF.hardDeleteAdded AND incremental AND le.Did > 0 AND ri.Did > 0 AND le.Did <> ri.Did AND le.__Tpe <> RecordType.New AND ri.__Tpe = RecordType.New;
    SELF.Did := MAP(~incremental OR SELF.hardDeleteAdded => le.Did,
                   SELF.DidChange => ri.Did,
                   ri.Did > 0 => ri.Did,
                   le.Did);
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.DT_EFFECTIVE_FIRST <> le.DT_EFFECTIVE_FIRST OR SELF.DT_EFFECTIVE_LAST <> le.DT_EFFECTIVE_LAST OR SELF.dt_first_seen <> le.dt_first_seen OR SELF.dt_last_seen <> le.dt_last_seen OR SELF.dt_vendor_first_reported <> le.dt_vendor_first_reported OR SELF.dt_vendor_last_reported <> le.dt_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := IF(__Tpe0 <> RecordType.New AND (SELF.hardDeleteAdded OR SELF.DidChange), RecordType.Updated, __Tpe0);
    SELF := le; // Take current version - noting update if needed
  END;
  // Ingest Files: Rollup to get unique new records
  GroupIngest0 := GROUP( FilesToIngest0,src,source_rid,ssn
             ,dob,dl_nbr,dl_state,fname,ALL);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP( SORT( GroupIngest0,__Tpe,RID,Did),TRUE,MergeData(LEFT,RIGHT)));
  // Existing Base: combine delta with base file
  GroupBase0 := GROUP( SALT37.MAC_DatasetAsOf(Base0+Delta0,RID,Did,,DT_EFFECTIVE_FIRST,DT_EFFECTIVE_LAST,,'YYYYMMDD',TRUE),src,source_rid,ssn
             ,dob,dl_nbr,dl_state,fname,ALL);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP( SORT( GroupBase0,__Tpe,RID),TRUE,MergeData(LEFT,RIGHT))):INDEPENDENT;
  Group0 := GROUP( AllBaseRecs0+AllIngestRecs0,src,source_rid,ssn
             ,dob,dl_nbr,dl_state,fname,ALL);
  SHARED AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,__Tpe,RID),TRUE,MergeData(LEFT,RIGHT))):INDEPENDENT;
// Did changed records
  DidChangeNewRecs  := AllRecs0(DidChange);
  DidChangePrevRecs := JOIN(AllBaseRecs0, DidChangeNewRecs, LEFT.RID = RIGHT.RID, TRANSFORM(LEFT), HASH);
  DidChangeAll0     := SALT37.MAC_PoisonRecords(DidChangePrevRecs, DidChangeNewRecs, 'Did,RID', DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, 'YYYYMMDD'):PERSIST(Filenames.Persist_DidChangeAll, EXPIRE(30));
  SHARED DidChangeAll      := PROJECT(DidChangeAll0, TRANSFORM(RECORDOF(LEFT), SELF.__Tpe := RecordType.Updated, SELF := LEFT));
  // Hard delete records (other than from Did change)
  SHARED HardDeleteRecs := AllRecs0(__Tpe=RecordType.Updated AND hardDeleteAdded);
//Now need to update 'rid' numbers on new records
//Base upon SALT37.utMac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);

 // hack to produce RID consistent Ayeesha Kayttala --start 
 // adding as header all as we filter out blanks from base and avoid issue of blank rid as max rid 
	PrevBase:= ORe + PROJECT(InsuranceHeader_Ingest.Files.AsHeaderAll_Current_DS , TRANSFORM(WithRT, SELF := LEFT,SELF := []))
	               + PROJECT(InsuranceHeader_Incremental.Files.AsHeaderAll_Current_DS , TRANSFORM(WithRT, SELF := LEFT,SELF := []));

  zeroDs     := NR(RID=0); 
 	prevBasePR := MAX(PrevBase(src[1..3] = 'ADL'), rid);
	
	OUTPUT(prevBasePR, NAMED('prevBasePR_RID'));
	
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.RID := IF ( le.RID=0, prevBasePR+1+thorlib.node(), le.RID+thorlib.nodes() );
    SELF.Did := SELF.RID; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NRPR := ITERATE(SORT(DISTRIBUTE(zeroDs(src[1..3] ='ADL'),random()),src,LOCAL),AddNewRid(LEFT,RIGHT),LOCAL);
		
	prevBaseInsurance := MAX(PrevBase(src[1..3] <> 'ADL'), rid);	
	
	OUTPUT(prevBaseInsurance, NAMED('prevBaseInsurance_RID'));
	
	WithRT AddNewRid1(WithRT le, WithRT ri) := TRANSFORM
    SELF.RID := IF ( le.RID=0, prevBaseInsurance+1+thorlib.node(), le.RID+thorlib.nodes() );
    SELF.Did := SELF.RID; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NRInsurance := ITERATE(SORT(DISTRIBUTE(zeroDs(src[1..3] <>'ADL'),random()),src,LOCAL),AddNewRid1(LEFT,RIGHT),LOCAL);
	
	NR1 := NRPR + NRInsurance ; 
	
  SHARED AllRecs := ORe+NR1+NR(RID<>0) : PERSIST('~temp::Did::InsuranceHeader_Ingest::Ingest_Cache',EXPIRE(InsuranceHeader_Ingest.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT37.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  UpdateStats_HardDelete := TABLE(HardDeleteRecs, {__Tpe,SALT37.StrType INGESTSTATUS:='HardDeleteOnly',UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW);
  UpdateStats_DidChanges := TABLE(DidChangeAll, {__Tpe,SALT37.StrType INGESTSTATUS:='HardDeleteEntityChange',UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New) & UpdateStats_HardDelete & UpdateStats_DidChanges, __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S1 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
  SHARED UpdateStatsSrcFull := SORT(TABLE(AllRecs, {src,__Tpe,SALT37.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, src,__Tpe, FEW),src,__Tpe, FEW);
  UpdateStatsSrc_HardDelete := TABLE(HardDeleteRecs, {src,__Tpe,SALT37.StrType INGESTSTATUS:='HardDeleteOnly',UNSIGNED Cnt:=COUNT(GROUP)}, src,__Tpe, FEW);
  UpdateStatsSrc_DidChanges := TABLE(DidChangeAll, {src,__Tpe,SALT37.StrType INGESTSTATUS:='HardDeleteEntityChange',UNSIGNED Cnt:=COUNT(GROUP)}, src,__Tpe, FEW);
  SHARED UpdateStatsSrcInc := SORT(UpdateStatsSrcFull(__Tpe = RecordType.New) & UpdateStatsSrc_HardDelete & UpdateStatsSrc_DidChanges, src,__Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStatsSrc := IF(incremental, UpdateStatsSrcInc, UpdateStatsSrcFull);
  SHARED S2 := OUTPUT(UpdateStatsSrc, {{UpdateStatsSrc} AND NOT __Tpe}, ALL, NAMED('UpdateStatsSrc'));
  SHARED l_roll := RECORD
    UpdateStatsSrc.src;
    unsigned cnt_Old;
    unsigned cnt_Unchanged;
    unsigned cnt_Updated;
    unsigned cnt_New;
    real8 pct_tot_Old;
    real8 pct_tot_Unchanged;
    real8 pct_tot_Updated;
    real8 pct_tot_New;
    real8 pct_ingest_Unchanged;
    real8 pct_ingest_Updated;
    real8 pct_ingest_New;
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
  EXPORT UpdateStatsXtab := PROJECT(ROLLUP(PROJECT(SORT(UpdateStatsSrc,src),toRoll(LEFT)),doRoll(LEFT,RIGHT),src),toPct(LEFT));
  SHARED S3 := IF(~incremental, OUTPUT(UpdateStatsXtab,ALL,NAMED('UpdateStatsXtab')));
  SHARED NoFlagsRec := WithRT -[hardDeleteAdded, DidChange];
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_Base);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_Base);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_Base);
  EXPORT UpdatedRecords_HardDeleteOnly := PROJECT(HardDeleteRecs, NoFlagsRec);
  EXPORT UpdatedRecords_HardDeleteOnly_NoTag := PROJECT(UpdatedRecords_HardDeleteOnly,Layout_Base);
  EXPORT UpdatedRecords_HardDeleteEntityChange := IF(incremental, PROJECT(DidChangeAll, NoFlagsRec), emptyDS); // no poison pills in full build
  EXPORT UpdatedRecords_HardDeleteEntityChange_NoTag := PROJECT(UpdatedRecords_HardDeleteEntityChange,Layout_Base);
  EXPORT AllRecords := IF(incremental, NewRecords & UpdatedRecords_HardDeleteOnly & UpdatedRecords_HardDeleteEntityChange, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_Base); // Records in 'pure' format
  EXPORT DoStats := PARALLEL(S0,S1,S2,S3);
END;

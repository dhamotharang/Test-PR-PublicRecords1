IMPORT SALT37,LocationID_Ingest;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_BASE) Delta = DATASET([],Layout_BASE)
, DATASET(Layout_BASE) dsBase = In_BASE // Change IN_BASE to change input to ingest process
, DATASET(RECORDOF(LocationID_Ingest.In_INGEST))  infile = LocationID_Ingest.In_INGEST
) := MODULE
  SHARED NullFile := DATASET([],Layout_BASE); // Use to replace files you wish to remove
 
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
    Layout_BASE;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.aid := ri.aid; // Derived(NEW)
    SELF.dateseenfirst := MAP ( le.__Tpe = 0 OR (unsigned)le.dateseenfirst = 0 => ri.dateseenfirst,
                     ri.__Tpe = 0 OR (unsigned)ri.dateseenfirst = 0 => le.dateseenfirst,
                     (unsigned)le.dateseenfirst < (unsigned)ri.dateseenfirst => le.dateseenfirst, // Want the lowest non-zero value
                     ri.dateseenfirst);
    SELF.dateseenlast := MAP ( le.__Tpe = 0 => ri.dateseenlast,
                     ri.__Tpe = 0 => le.dateseenlast,
                     (unsigned)le.dateseenlast < (unsigned)ri.dateseenlast => ri.dateseenlast, // Want the highest value
                     le.dateseenlast);
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.dateseenfirst <> le.dateseenfirst OR SELF.dateseenlast <> le.dateseenlast => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  GroupIngest0 := GROUP( FilesToIngest0,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig
             ,sec_range,v_city_name,st,zip5,rec_type,err_stat,cntprimname,ALL);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP( SORT( GroupIngest0,__Tpe,rid),TRUE,MergeData(LEFT,RIGHT)));
  // Existing Base: combine delta with base file
  GroupBase0 := GROUP( Base0+Delta0,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig
             ,sec_range,v_city_name,st,zip5,rec_type,err_stat,cntprimname,ALL);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP( SORT( GroupBase0,__Tpe,rid),TRUE,MergeData(LEFT,RIGHT)));
 
  Group0 := GROUP( AllBaseRecs0+AllIngestRecs0,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig
             ,sec_range,v_city_name,st,zip5,rec_type,err_stat,cntprimname,ALL);
  SHARED AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,__Tpe,rid),TRUE,MergeData(LEFT,RIGHT)));
//Now need to update 'rid' numbers on new records
//Base upon SALT37.utMac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,rid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rid := IF ( le.rid=0, PrevBase+1+thorlib.node(), le.rid+thorlib.nodes() );
    SELF.LocId := SELF.rid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR(rid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(rid<>0) : PERSIST('~temp::LocId::LocationID_Ingest::Ingest_Cache',EXPIRE(LocationID_Ingest._CFG.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT37.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S1 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
  SHARED UpdateStatsSrcFull := SORT(TABLE(AllRecs, {source,__Tpe,SALT37.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, source,__Tpe, FEW),source,__Tpe, FEW);
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
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_BASE);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_BASE);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_BASE);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_BASE); // Records in 'pure' format
 
  // Compute field level differences
  IOR := JOIN(OldRecords,InputSourceCounts,left.source=right.source,TRANSFORM(LEFT),LOOKUP); // Only send in old records from sources in this ingest
  Fields.MAC_CountDifferencesByPivot(NewRecords,IOR,((SALT37.StrType)source+'|'+(SALT37.StrType)source_record_id),BadPivs,DC)
  EXPORT FieldChangeStats := DC;
  SHARED S4 := OUTPUT(FieldChangeStats,ALL,NAMED('FieldChangeStats'));
 
  EXPORT DoStats := PARALLEL(S0,S1,S2,S3,S4);
 
END;

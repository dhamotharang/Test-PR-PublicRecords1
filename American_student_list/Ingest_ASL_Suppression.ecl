IMPORT SALT37,American_Student_List;
EXPORT Ingest_ASL_Suppression(BOOLEAN incremental=FALSE
, DATASET(Layout_ASL_Suppression) Delta = DATASET([],Layout_ASL_Suppression)
, DATASET(Layout_ASL_Suppression) dsBase = In_ASL_Suppression // Change IN_ASL_Suppression to change input to ingest process
, DATASET(RECORDOF(American_Student_List.File_american_student_suppression.base))  infile = American_Student_List.File_american_student_suppression.base
) := MODULE
  SHARED NullFile := DATASET([],Layout_ASL_Suppression); // Use to replace files you wish to remove

  SHARED FilesToIngest := infile;
// Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_ASL_Suppression;
    __Tpe := RecordType.Unknown;
  END;

  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));

  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.DATE_FIRST_SEEN := MAP ( le.__Tpe = 0 OR (unsigned)le.DATE_FIRST_SEEN = 0 => ri.DATE_FIRST_SEEN,
                     ri.__Tpe = 0 OR (unsigned)ri.DATE_FIRST_SEEN = 0 => le.DATE_FIRST_SEEN,
                     (unsigned)le.DATE_FIRST_SEEN < (unsigned)ri.DATE_FIRST_SEEN => le.DATE_FIRST_SEEN, // Want the lowest non-zero value
                     ri.DATE_FIRST_SEEN);
    SELF.DATE_LAST_SEEN := MAP ( le.__Tpe = 0 => ri.DATE_LAST_SEEN,
                     ri.__Tpe = 0 => le.DATE_LAST_SEEN,
                     (unsigned)le.DATE_LAST_SEEN < (unsigned)ri.DATE_LAST_SEEN => ri.DATE_LAST_SEEN, // Want the highest value
                     le.DATE_LAST_SEEN);
    SELF.DATE_VENDOR_FIRST_REPORTED := MAP ( le.__Tpe = 0 OR (unsigned)le.DATE_VENDOR_FIRST_REPORTED = 0 => ri.DATE_VENDOR_FIRST_REPORTED,
                     ri.__Tpe = 0 OR (unsigned)ri.DATE_VENDOR_FIRST_REPORTED = 0 => le.DATE_VENDOR_FIRST_REPORTED,
                     (unsigned)le.DATE_VENDOR_FIRST_REPORTED < (unsigned)ri.DATE_VENDOR_FIRST_REPORTED => le.DATE_VENDOR_FIRST_REPORTED, // Want the lowest non-zero value
                     ri.DATE_VENDOR_FIRST_REPORTED);
    SELF.DATE_VENDOR_LAST_REPORTED := MAP ( le.__Tpe = 0 => ri.DATE_VENDOR_LAST_REPORTED,
                     ri.__Tpe = 0 => le.DATE_VENDOR_LAST_REPORTED,
                     (unsigned)le.DATE_VENDOR_LAST_REPORTED < (unsigned)ri.DATE_VENDOR_LAST_REPORTED => ri.DATE_VENDOR_LAST_REPORTED, // Want the highest value
                     le.DATE_VENDOR_LAST_REPORTED);
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.DATE_FIRST_SEEN <> le.DATE_FIRST_SEEN OR SELF.DATE_LAST_SEEN <> le.DATE_LAST_SEEN OR SELF.DATE_VENDOR_FIRST_REPORTED <> le.DATE_VENDOR_FIRST_REPORTED OR SELF.DATE_VENDOR_LAST_REPORTED <> le.DATE_VENDOR_LAST_REPORTED => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;

  // Ingest Files: Rollup to get unique new records
  GroupIngest0 := GROUP( FilesToIngest0,FULL_NAME,ADDRESS_1,ADDRESS_2,CITY,STATE
             ,Z5,ZIP_4,ALL);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP( SORT( GroupIngest0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
  // Existing Base: combine delta with base file
  GroupBase0 := GROUP( Base0+Delta0,FULL_NAME,ADDRESS_1,ADDRESS_2,CITY,STATE
             ,Z5,ZIP_4,ALL);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP( SORT( GroupBase0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));

  Group0 := GROUP( AllBaseRecs0+AllIngestRecs0,FULL_NAME,ADDRESS_1,ADDRESS_2,CITY,STATE
             ,Z5,ZIP_4,ALL);
  SHARED AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
//Now need to update 'rid' numbers on new records
//Base upon SALT37.utMac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,rcid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rcid := IF ( le.rcid=0, PrevBase+1+thorlib.node(), le.rcid+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(rcid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(rcid<>0) : PERSIST('~temp::American_Student_List_Suppression::Ingest_Cache',EXPIRE(Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT37.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));

  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_ASL_Suppression);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_ASL_Suppression);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_ASL_Suppression);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_ASL_Suppression); // Records in 'pure' format

  EXPORT DoStats := S0;

END;

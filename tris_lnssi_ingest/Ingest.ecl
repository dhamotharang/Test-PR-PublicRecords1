IMPORT SALT36,tris_lnssi_build;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_basefile) Delta = DATASET([],Layout_basefile)
, DATASET(Layout_basefile) dsBase = In_basefile // Change IN_basefile to change input to ingest process
, DATASET(RECORDOF(tris_lnssi_build.file_input))  infile = tris_lnssi_build.file_input
) := MODULE
  SHARED NullFile := DATASET([],Layout_basefile); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
// Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  WithRT := RECORD(Layout_basefile)
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=IF(incremental,RecordType.Old,RecordType.New),SELF:=LEFT));
  Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.__Tpe := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      RecordType.Unchanged);
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Full Ingest: combine delta with ingest files
  GroupIngest0 := GROUP( Delta0+FilesToIngest0,contrib_risk_field,Contrib_Risk_Value,Contrib_Risk_Attr,contrib_state_excl,ALL);
  AllIngestRecs0 := UNGROUP(ROLLUP( SORT( GroupIngest0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
  // Incremental Ingest: combine delta with base file
  GroupBase0 := GROUP( Base0+Delta0,contrib_risk_field,Contrib_Risk_Value,Contrib_Risk_Attr,contrib_state_excl,ALL);
  AllBaseRecs0 := UNGROUP(ROLLUP( SORT( GroupBase0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
 
  Base1 := IF(incremental,AllBaseRecs0,Base0);
  FilesToIngest1 := IF(incremental,FilesToIngest0,AllIngestRecs0);
  Group0 := GROUP( Base1+FilesToIngest1,contrib_risk_field,Contrib_Risk_Value,Contrib_Risk_Attr,contrib_state_excl,ALL);
  AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
//Now need to update 'rid' numbers on new records
//Base upon SALT36.utMac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,rcid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rcid := IF ( le.rcid=0, PrevBase+1+thorlib.node(), le.rcid+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(rcid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(rcid<>0) : PERSIST('~temp::tris_lnssi_ingest::Ingest_Cache',EXPIRE(tris_lnssi_ingest.Config.PersistExpire));
  EXPORT UpdateStats := SORT(TABLE(AllRecs, {__Tpe,SALT36.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
 
  EXPORT NewRecords := AllRecs(__Tpe=RecordType.New);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_basefile);
  EXPORT OldRecords := AllRecs(__Tpe=RecordType.Old);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_basefile);
  EXPORT UpdatedRecords := AllRecs(__Tpe=RecordType.Updated);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_basefile);
  EXPORT AllRecords := AllRecs;
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_basefile); // Records in 'pure' format
 
  EXPORT DoStats := S0;
 
END;

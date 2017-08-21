IMPORT SALT33,American_student_list;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_American_Student_List_Raw) Delta = DATASET([],Layout_American_Student_List_Raw)
, DATASET(Layout_American_Student_List_Raw) dsBase = In_American_Student_List_Raw // Change IN_American_Student_List_Raw to change input to ingest process
, DATASET(RECORDOF(American_student_list.File_American_Student_in))  infile = American_student_list.File_American_Student_in
) := MODULE
  SHARED NullFile := DATASET([],Layout_American_Student_List_Raw); // Use to replace files you wish to remove
  SHARED FilesToIngest := infile;
// Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  WithRT := RECORD(Layout_American_Student_List_Raw)
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
  GroupIngest0 := GROUP( Delta0+FilesToIngest0,name,first_name,last_name,address_1,address_2,city,state,z5,zip_4
             ,crrt_code,delivery_point_barcode,zip4_check_digit,address_type,county_number,county_name,gender,age,birth_date,telephone
             ,class,college_class,college_name,college_major,college_code,college_type,head_of_household_first_name,head_of_household_gender,income_level,file_type,ALL);
  AllIngestRecs0 := UNGROUP(ROLLUP( SORT( GroupIngest0,__Tpe),TRUE,MergeData(LEFT,RIGHT)));
  // Incremental Ingest: combine delta with base file
  GroupBase0 := GROUP( Base0+Delta0,name,first_name,last_name,address_1,address_2,city,state,z5,zip_4
             ,crrt_code,delivery_point_barcode,zip4_check_digit,address_type,county_number,county_name,gender,age,birth_date,telephone
             ,class,college_class,college_name,college_major,college_code,college_type,head_of_household_first_name,head_of_household_gender,income_level,file_type,ALL);
  AllBaseRecs0 := UNGROUP(ROLLUP( SORT( GroupBase0,__Tpe),TRUE,MergeData(LEFT,RIGHT)));
  Base1 := IF(incremental,AllBaseRecs0,Base0);
  FilesToIngest1 := IF(incremental,FilesToIngest0,AllIngestRecs0);
  Group0 := GROUP( Base1+FilesToIngest1,name,first_name,last_name,address_1,address_2,city,state,z5,zip_4
             ,crrt_code,delivery_point_barcode,zip4_check_digit,address_type,county_number,county_name,gender,age,birth_date,telephone
             ,class,college_class,college_name,college_major,college_code,college_type,head_of_household_first_name,head_of_household_gender,income_level,file_type,ALL);
  AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,__Tpe),TRUE,MergeData(LEFT,RIGHT)));
  SHARED AllRecs := AllRecs0 : PERSIST('~temp::Ingest_American_Student_List::Ingest_Cache',EXPIRE(Config.PersistExpire));
  EXPORT UpdateStats := SORT(TABLE(AllRecs, {__Tpe,SALT33.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
  EXPORT NewRecords := AllRecs(__Tpe=RecordType.New);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_American_Student_List_Raw);
  EXPORT OldRecords := AllRecs(__Tpe=RecordType.Old);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_American_Student_List_Raw);
  EXPORT UpdatedRecords := AllRecs(__Tpe=RecordType.Updated);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_American_Student_List_Raw);
  EXPORT AllRecords := AllRecs;
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_American_Student_List_Raw); // Records in 'pure' format
  EXPORT DoStats := S0;
END;

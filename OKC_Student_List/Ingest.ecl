IMPORT SALT37,OKC_Student_List;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_OKC_Student_List) Delta = DATASET([],Layout_OKC_Student_List)
, DATASET(Layout_OKC_Student_List) dsBase = In_OKC_Student_List // Change IN_OKC_Student_List to change input to ingest process
, DATASET(RECORDOF(OKC_Student_List.File_OKC_Base))  infile = OKC_Student_List.File_OKC_Base
) := MODULE
  SHARED NullFile := DATASET([],Layout_OKC_Student_List); // Use to replace files you wish to remove

  SHARED FilesToIngest := infile;
// Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_OKC_Student_List;
    __Tpe := RecordType.Unknown;
  END;

  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));

  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.did := ri.did; // Derived(NEW)
    SELF.process_date := MAP ( le.__Tpe = 0 => ri.process_date,
                     ri.__Tpe = 0 => le.process_date,
                     (unsigned)le.process_date < (unsigned)ri.process_date => ri.process_date, // Want the highest value
                     le.process_date);
    SELF.date_first_seen := MAP ( le.__Tpe = 0 OR (unsigned)le.date_first_seen = 0 => ri.date_first_seen,
                     ri.__Tpe = 0 OR (unsigned)ri.date_first_seen = 0 => le.date_first_seen,
                     (unsigned)le.date_first_seen < (unsigned)ri.date_first_seen => le.date_first_seen, // Want the lowest non-zero value
                     ri.date_first_seen);
    SELF.date_last_seen := MAP ( le.__Tpe = 0 => ri.date_last_seen,
                     ri.__Tpe = 0 => le.date_last_seen,
                     (unsigned)le.date_last_seen < (unsigned)ri.date_last_seen => ri.date_last_seen, // Want the highest value
                     le.date_last_seen);
    SELF.date_vendor_first_reported := MAP ( le.__Tpe = 0 OR (unsigned)le.date_vendor_first_reported = 0 => ri.date_vendor_first_reported,
                     ri.__Tpe = 0 OR (unsigned)ri.date_vendor_first_reported = 0 => le.date_vendor_first_reported,
                     (unsigned)le.date_vendor_first_reported < (unsigned)ri.date_vendor_first_reported => le.date_vendor_first_reported, // Want the lowest non-zero value
                     ri.date_vendor_first_reported);
    SELF.date_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.date_vendor_last_reported,
                     ri.__Tpe = 0 => le.date_vendor_last_reported,
                     (unsigned)le.date_vendor_last_reported < (unsigned)ri.date_vendor_last_reported => ri.date_vendor_last_reported, // Want the highest value
                     le.date_vendor_last_reported);
    SELF.dateadded := MAP ( le.__Tpe = 0 OR (unsigned)le.dateadded = 0 => ri.dateadded,
                     ri.__Tpe = 0 OR (unsigned)ri.dateadded = 0 => le.dateadded,
                     (unsigned)le.dateadded < (unsigned)ri.dateadded => le.dateadded, // Want the lowest non-zero value
                     ri.dateadded);
    SELF.dateupdated := MAP ( le.__Tpe = 0 => ri.dateupdated,
                     ri.__Tpe = 0 => le.dateupdated,
                     (unsigned)le.dateupdated < (unsigned)ri.dateupdated => ri.dateupdated, // Want the highest value
                     le.dateupdated);
    SELF.studentid := ri.studentid; // Derived(NEW)
    SELF.dartid := ri.dartid; // Derived(NEW)
    SELF.projectsource := ri.projectsource; // Derived(NEW)
    SELF.collegestate := ri.collegestate; // Derived(NEW)
    SELF.college := ri.college; // Derived(NEW)
    SELF.semester := ri.semester; // Derived(NEW)
    SELF.year := ri.year; // Derived(NEW)
    SELF.suffix := ri.suffix; // Derived(NEW)
    SELF.major := ri.major; // Derived(NEW)
    SELF.grade := ri.grade; // Derived(NEW)
    SELF.email := ri.email; // Derived(NEW)
    SELF.cleanemail := ri.cleanemail; // Derived(NEW)
    SELF.dateofbirth := ri.dateofbirth; // Derived(NEW)
    SELF.dob_formatted := ri.dob_formatted; // Derived(NEW)
    SELF.attendancedate := ri.attendancedate; // Derived(NEW)
    SELF.enrollmentstatus := ri.enrollmentstatus; // Derived(NEW)
    SELF.addresstype := ri.addresstype; // Derived(NEW)
    SELF.city := ri.city; // Derived(NEW)
    SELF.state := ri.state; // Derived(NEW)
    SELF.z4 := ri.z4; // Derived(NEW)
    SELF.phonetyp := ri.phonetyp; // Derived(NEW)
    SELF.tier := ri.tier; // Derived(NEW)
    SELF.school_size_code := ri.school_size_code; // Derived(NEW)
    SELF.competitive_code := ri.competitive_code; // Derived(NEW)
    SELF.tuition_code := ri.tuition_code; // Derived(NEW)
    SELF.title := ri.title; // Derived(NEW)
    SELF.fname := ri.fname; // Derived(NEW)
    SELF.mname := ri.mname; // Derived(NEW)
    SELF.lname := ri.lname; // Derived(NEW)
    SELF.name_suffix := ri.name_suffix; // Derived(NEW)
    SELF.name_score := ri.name_score; // Derived(NEW)
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
    SELF.dpbc := ri.dpbc; // Derived(NEW)
    SELF.chk_digit := ri.chk_digit; // Derived(NEW)
    SELF.rec_type := ri.rec_type; // Derived(NEW)
    SELF.county := ri.county; // Derived(NEW)
    SELF.fips_state := ri.fips_state; // Derived(NEW)
    SELF.fips_county := ri.fips_county; // Derived(NEW)
    SELF.geo_lat := ri.geo_lat; // Derived(NEW)
    SELF.geo_long := ri.geo_long; // Derived(NEW)
    SELF.msa := ri.msa; // Derived(NEW)
    SELF.geo_blk := ri.geo_blk; // Derived(NEW)
    SELF.geo_match := ri.geo_match; // Derived(NEW)
    SELF.err_stat := ri.err_stat; // Derived(NEW)
    SELF.telephone := ri.telephone; // Derived(NEW)
    SELF.tier2 := ri.tier2; // Derived(NEW)
    SELF.source := ri.source; // Derived(NEW)
    SELF.ssn := ri.ssn; // Derived(NEW)
    SELF.historical_flag := ri.historical_flag; // Derived(NEW)
    SELF.full_name := ri.full_name; // Derived(NEW)
    SELF.college_class := ri.college_class; // Derived(NEW)
    SELF.college_name := ri.college_name; // Derived(NEW)
    SELF.ln_college_name := ri.ln_college_name; // Derived(NEW)
    SELF.new_college_major := ri.new_college_major; // Derived(NEW)
    SELF.college_code := ri.college_code; // Derived(NEW)
    SELF.college_code_exploded := ri.college_code_exploded; // Derived(NEW)
    SELF.college_type := ri.college_type; // Derived(NEW)
    SELF.college_type_exploded := ri.college_type_exploded; // Derived(NEW)
    SELF.file_type := ri.file_type; // Derived(NEW)
    SELF.collegeupdate := ri.collegeupdate; // Derived(NEW)
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.process_date <> le.process_date OR SELF.date_first_seen <> le.date_first_seen OR SELF.date_last_seen <> le.date_last_seen OR SELF.date_vendor_first_reported <> le.date_vendor_first_reported OR SELF.date_vendor_last_reported <> le.date_vendor_last_reported OR SELF.dateadded <> le.dateadded OR SELF.dateupdated <> le.dateupdated => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;

  // Ingest Files: Rollup to get unique new records
  GroupIngest0 := GROUP( FilesToIngest0,collegeid,firstname,middlename,lastname
             ,address_1,address_2,z5,phonenumber,college_major,ALL);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP( SORT( GroupIngest0,__Tpe,key),TRUE,MergeData(LEFT,RIGHT)));
  // Existing Base: combine delta with base file
  GroupBase0 := GROUP( Base0+Delta0,collegeid,firstname,middlename,lastname
             ,address_1,address_2,z5,phonenumber,college_major,ALL);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP( SORT( GroupBase0,__Tpe,key),TRUE,MergeData(LEFT,RIGHT)));

  Group0 := GROUP( AllBaseRecs0+AllIngestRecs0,collegeid,firstname,middlename,lastname
             ,address_1,address_2,z5,phonenumber,college_major,ALL);
  SHARED AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,__Tpe,key),TRUE,MergeData(LEFT,RIGHT)));
//Now need to update 'rid' numbers on new records
//Base upon SALT37.utMac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,key);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.key := IF ( le.key=0, PrevBase+1+thorlib.node(), le.key+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(key=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(key<>0) : PERSIST('~temp::OKC_Student_List::Ingest_Cache',EXPIRE(OKC_Student_List.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT37.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));

  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_OKC_Student_List);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_OKC_Student_List);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_OKC_Student_List);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_OKC_Student_List); // Records in 'pure' format

  EXPORT DoStats := S0;

END;

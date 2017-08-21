import tools;
EXPORT Ingest(

	 dataset(Layouts.Base			)	pInputFile							
	,dataset(Layouts.Base			)	pBaseFile			= Files().base.prod_thor.qa									
	,string											pPersistname	= persistnames().Ingestp
	
) :=
MODULE

  shared base := pBaseFile; // Change IN_pBaseFile to change input to ingest process
  SHARED NullFile := DATASET([],Layouts.Base); // Use to replace files you wish to remove
// First collect together all sources
  infile := pInputFile;
//infile := NullFile; // Can be uncommented to remove temporarily
  FilesToIngest1 := infile;
  Layouts.Base Into(FilesToIngest1 le) := TRANSFORM
    self := le;
  end;
    FilesToIngest0 := PROJECT(FilesToIngest1,Into(left)); // In case local header decl and _as_ attributes differ
  SHARED FilesToIngest := DEDUP( SORT ( FilesToIngest0, WHOLE RECORD ), WHOLE RECORD ); // Remove dups from input
// Now need to discover which records are old / new / updated
  SHARED RecordType := ENUM(UNSIGNED1,Unknown,Unchanged,Updated,Old,New);
  SHARED RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');
  WithRT := RECORD(Layouts.Base)
    __Tpe := RecordType.Unknown;
  END;
  WithRT AddFlag(Layouts.Base le,UNSIGNED1 c) := TRANSFORM
    SELF.__Tpe := c;
    SELF := le;
  END;
  FilesToIngest0 := PROJECT(FilesToIngest,AddFlag(LEFT,RecordType.New));
  Base0 := PROJECT(Base,AddFlag(LEFT,RecordType.Old));
  WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
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
    SELF.__Tpe := MAP ( le.__Tpe = 0 => ri.__Tpe, ri.__Tpe = 0 => le.__Tpe,SELF.date_first_seen <> le.date_first_seen OR SELF.date_last_seen <> le.date_last_seen OR SELF.date_vendor_first_reported <> le.date_vendor_first_reported OR SELF.date_vendor_last_reported <> le.date_vendor_last_reported => RecordType.Updated,  RecordType.Unchanged);
    SELF := IF ( le.__Tpe = 0, ri, le ); // Copy most fields from left if possible
  END;
  AllRecs0 := JOIN(Base0,FilesToIngest0,left.rawfields.jobid = right.rawfields.jobid AND left.rawfields.acctno = right.rawfields.acctno AND left.rawfields.tin_number = right.rawfields.tin_number AND left.rawfields.tin_name = right.rawfields.tin_name AND left.rawfields.tin_type = right.rawfields.tin_type AND left.rawfields.tin_match_code = right.rawfields.tin_match_code AND left.rawfields.Address = right.rawfields.Address AND left.rawfields.city = right.rawfields.city AND left.rawfields.state = right.rawfields.state AND left.rawfields.zip = right.rawfields.zip AND left.rawfields.ACCOUNT_NUMBER = right.rawfields.ACCOUNT_NUMBER AND left.rawfields.Phone = right.rawfields.Phone AND left.rawfields.gcid = right.rawfields.gcid,MergeData(LEFT,RIGHT),FULL OUTER,HASH);
//Now need to update 'rid' numbers on new records
//Base upon ut.Mac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,rid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rid := IF ( le.rid=0, PrevBase+1+thorlib.node(), le.rid+thorlib.nodes() );
//    SELF. := SELF.rid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR,AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1  ;
  StatsRec := RECORD
    STRING Type := RTToText(AllRecs.__Tpe);
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  EXPORT UpdateStats := TABLE(AllRecs,StatsRec,__Tpe,FEW);
  SHARED Layouts.Base DeTag(AllRecs le) := TRANSFORM
	  self.record_type := le.__Tpe;
    SELF := le;
  END;
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New),DeTag(LEFT));
  EXPORT OldRecords := PROJECT(AllRecs(__Tpe=RecordType.Old),DeTag(LEFT));
  EXPORT AllRecords := AllRecs;
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,DeTag(LEFT)) : persist(pPersistname);// Records in 'pure' format
END;

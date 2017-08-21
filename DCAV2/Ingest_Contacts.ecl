import tools;
EXPORT Ingest_Contacts(

	 dataset(layouts.temporary.contacts_aid_prep	)	pInputFile							
	,dataset(layouts.base.contacts								)	pBaseFile			= Files().base.Contacts.qa
	,string																					pPersistname	= persistnames().IngestContacts
	
) :=
MODULE
  shared base := project(pBaseFile,transform(layouts.temporary.contacts_aid_prep,self := left,self := [])); // Change IN_file_base to change input to ingest process
  IMPORT SALT22;
  SHARED NullFile := DATASET([],layouts.temporary.contacts_aid_prep); // Use to replace files you wish to remove
// First collect together all sources
  infile := pInputFile;
//infile := NullFile; // Can be uncommented to remove temporarily
  FilesToIngest1 := infile;
  layouts.temporary.contacts_aid_prep Into(FilesToIngest1 le) := TRANSFORM
    self := le;
  end;
    FilesToIngest0 := PROJECT(FilesToIngest1,Into(left)); // In case local header decl and _as_ attributes differ
  SHARED FilesToIngest := DEDUP( SORT ( FilesToIngest0, WHOLE RECORD ), WHOLE RECORD ); // Remove dups from input
// Now need to discover which records are old / new / updated
  SHARED RecordType := ENUM(UNSIGNED1,Unknown,Unchanged,Updated,Old,New);
  SHARED RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');
  WithRT := RECORD(layouts.temporary.contacts_aid_prep)
    __Tpe := RecordType.Unknown;
  END;
  WithRT AddFlag(layouts.temporary.contacts_aid_prep le,UNSIGNED1 c) := TRANSFORM
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
  AllRecs0 := JOIN(Base0,FilesToIngest0,left.rawfields.Enterprise_num = right.rawfields.Enterprise_num AND left.rawfields.level = right.rawfields.level AND left.rawfields.Name = right.rawfields.Name AND left.rawfields.address1.PO_Box_Bldg = right.rawfields.address1.PO_Box_Bldg AND left.rawfields.address1.street = right.rawfields.address1.street AND left.rawfields.address1.Foreign_PO = right.rawfields.address1.Foreign_PO AND left.rawfields.address1.Misc__adr = right.rawfields.address1.Misc__adr AND left.rawfields.address1.Postal_Code_1 = right.rawfields.address1.Postal_Code_1 AND left.rawfields.address1.city = right.rawfields.address1.city AND left.rawfields.address1.state = right.rawfields.address1.state AND left.rawfields.address1.zip = right.rawfields.address1.zip AND left.rawfields.address1.Province = right.rawfields.address1.Province AND left.rawfields.address1.Postal_Code_2 = right.rawfields.address1.Postal_Code_2 AND left.rawfields.address1.country = right.rawfields.address1.country AND left.rawfields.address1.Postal_Code_3 = right.rawfields.address1.Postal_Code_3 AND left.rawfields.phone = right.rawfields.phone AND left.rawfields.FAX = right.rawfields.FAX AND left.rawfields.Telex = right.rawfields.Telex AND left.rawfields.address2.PO_Box_Bldg = right.rawfields.address2.PO_Box_Bldg AND left.rawfields.address2.street = right.rawfields.address2.street AND left.rawfields.address2.Foreign_PO = right.rawfields.address2.Foreign_PO AND left.rawfields.address2.Misc__adr = right.rawfields.address2.Misc__adr AND left.rawfields.address2.Postal_Code_1 = right.rawfields.address2.Postal_Code_1 AND left.rawfields.address2.city = right.rawfields.address2.city AND left.rawfields.address2.state = right.rawfields.address2.state AND left.rawfields.address2.zip = right.rawfields.address2.zip AND left.rawfields.address2.Province = right.rawfields.address2.Province AND left.rawfields.address2.Postal_Code_2 = right.rawfields.address2.Postal_Code_2 AND left.rawfields.address2.country = right.rawfields.address2.country AND left.rawfields.address2.Postal_Code_3 = right.rawfields.address2.Postal_Code_3 AND left.rawfields.executive.Name = right.rawfields.executive.Name AND left.rawfields.executive.Title = right.rawfields.executive.Title AND left.rawfields.executive.Code = right.rawfields.executive.Code,MergeData(LEFT,RIGHT),FULL OUTER,HASH);
//Now need to update 'rid' numbers on new records
//Base upon ut.Mac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,rid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
// -- rid being taken care of earlier than this to preserve the order of the incoming records
//    SELF.rid := IF ( le.rid=0, PrevBase+1+thorlib.node(), le.rid+thorlib.nodes() );
//    SELF. := SELF.rid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR,AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1;
  StatsRec := RECORD
    SALT22.StrType Type := RTToText(AllRecs.__Tpe);
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  EXPORT UpdateStats := TABLE(AllRecs,StatsRec,__Tpe,FEW);
  SHARED layouts.temporary.contacts_aid_prep DeTag(AllRecs le) := TRANSFORM
		self.record_type := RecordType.New;	//they are all new records(don't keep history)
    SELF := le;
  END;
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New),DeTag(LEFT));
  EXPORT OldRecords := PROJECT(AllRecs(__Tpe=RecordType.Old),DeTag(LEFT));
  EXPORT AllRecords := AllRecs;
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,DeTag(LEFT)) : persist(persistnames().IngestContacts); // Records in 'pure' format
  S1 := OUTPUT(UpdateStats,all);
//  S2 := OUTPUT(FieldChangeStats,all);
 // S3 := OUTPUT(InputSourceCounts,all);
//  EXPORT DoStats := PARALLEL(S1,S2,S3);
//  O := OUTPUT(AllRecords_Notag,,DCAV2.BuildFiles.Names.New); // Remove _Notag to keep 'what happened' byte
/*  EXPORT Sequence := SEQUENTIAL( DCAV2.RawFiles.CreateSupers, // Make sure all superfiles exist
                                DCAV2.RawFiles.Spray, // Spray all the required data
                                DCAV2.RawFiles.Promote.Sprayed2Using, // Capture all files
                                O, // Do the ingest
                                DCAV2.RawFiles.Promote.Using2Used, // 'Eat' the files
                                DCAV2.BuildFiles.Promote.New2Built, // Register the new built file
                                DoStats); // You can add your post processing in here ....
*/
END;

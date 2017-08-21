EXPORT Ingest_Contacts(

	 dataset(Layouts.base.contacts)	pUpdateFile
	,dataset(Layouts.base.contacts)	pBaseFile
	,string													pPersistname	= persistnames().IngestContacts
	
) :=
MODULE
  shared base := pBaseFile; // Change IN_file_base to change input to ingest process
  shared NullFile := dataset([],Layouts.base.contacts); // Use to replace files you wish to remove
// First collect together all sources
  infile := pUpdateFile;
//infile := NullFile; // Can be uncommented to remove temporarily
  FilesToIngest1 := infile;
  Layouts.base.contacts Into(FilesToIngest1 le) := transform
    self := le;
  end;
  shared FilesToIngest := project(FilesToIngest1,Into(left)); // In case local header decl and _as_ attributes differ
// Now need to discover which records are old / new / updated
  shared RecordType := utilities.RecordType;
  shared RTToText(unsigned1 c) := utilities.RTToText(c);
  WithRT := RECORD(Layouts.base.contacts)
    __Tpe := RecordType.Unknown;
  END;
  WithRT AddFlag(Layouts.base.contacts le,UNSIGNED1 c) := TRANSFORM
    SELF.__Tpe := c;
    SELF := le;
  END;

  WithRT MergeData(WithRT le, WithRT ri) := transform // Pick the data for the new record
    SELF.date_first_seen 						:= MAP (	le.__Tpe = 0 OR (unsigned)le.date_first_seen = 0 =>	ri.date_first_seen,
																							ri.__Tpe = 0 OR (unsigned)ri.date_first_seen = 0 =>	le.date_first_seen,
																							(unsigned)le.date_first_seen < (unsigned)ri.date_first_seen 			=>	le.date_first_seen, // Want the lowest non-zero value
																																																										ri.date_first_seen);
    SELF.date_last_seen 						:= MAP (	le.__Tpe = 0															=>	ri.date_last_seen,
																							ri.__Tpe = 0															=>	le.date_last_seen,
																							(unsigned)le.date_last_seen < (unsigned)ri.date_last_seen =>	ri.date_last_seen, // Want the highest value
																																																						le.date_last_seen);
    SELF.date_vendor_first_reported := MAP (	le.__Tpe = 0 OR (unsigned)le.date_vendor_first_reported = 0			=>	ri.date_vendor_first_reported,
																							ri.__Tpe = 0 OR (unsigned)ri.date_vendor_first_reported = 0			=>	le.date_vendor_first_reported,
																							(unsigned)le.date_vendor_first_reported < (unsigned)ri.date_vendor_first_reported =>	le.date_vendor_first_reported, // Want the lowest non-zero value
																																																																		ri.date_vendor_first_reported);
    SELF.date_vendor_last_reported 	:= MAP (	le.__Tpe = 0 																									=>	ri.date_vendor_last_reported,
																							ri.__Tpe = 0 																									=>	le.date_vendor_last_reported,
																							(unsigned)le.date_vendor_last_reported < (unsigned)ri.date_vendor_last_reported =>	ri.date_vendor_last_reported, // Want the highest value
																																																																	le.date_vendor_last_reported);
    SELF.__Tpe := MAP ( le.__Tpe = 0 																			=>	ri.__Tpe
											, ri.__Tpe = 0																			=>	le.__Tpe
											,		self.date_first_seen <> le.date_first_seen 
											OR	self.date_last_seen  <> le.date_last_seen 
											OR	self.date_vendor_first_reported <> le.date_vendor_first_reported 
											OR self.date_vendor_last_reported <> le.date_vendor_last_reported 		=>	RecordType.Updated
											,																																					RecordType.Unchanged
									);
    SELF := IF ( le.__Tpe = 0, ri, le ); // Copy most fields from left if possible
  END;

	fRollup(dataset(WithRT)	pDataset) :=
	function

		AllRecs_Sort		:= sort(pDataset
			,duns_number
			,rawfields.exec_first_name
			,rawfields.exec_middle_initial
			,rawfields.exec_last_name
			,rawfields.exec_suffix
			,rawfields.exec_mrc_title_code
			,rawfields.exec_title
			,rawfields.exec_vanity_title
			,company_name
		);

		AllRecs_rollup := rollup(AllRecs_Sort
			,		left.duns_number 										= right.duns_number 
			AND left.rawfields.exec_first_name 			= right.rawfields.exec_first_name 
			AND left.rawfields.exec_middle_initial 	= right.rawfields.exec_middle_initial 
			AND left.rawfields.exec_last_name 			= right.rawfields.exec_last_name 
			AND left.rawfields.exec_suffix 					= right.rawfields.exec_suffix 
			AND left.rawfields.exec_mrc_title_code 	= right.rawfields.exec_mrc_title_code 
			AND left.rawfields.exec_title						= right.rawfields.exec_title 
			AND left.rawfields.exec_vanity_title		= right.rawfields.exec_vanity_title 
			AND left.company_name										= right.company_name 
			,MergeData(left,right));
			
		return AllRecs_rollup;

	end;

	maxdtvendorlastreported := max(FilesToIngest, date_vendor_last_reported) : stored('maxdtvendorlastreportedcontacts');//what is date of latest update file

	dFilesToIngest_latest		:= FilesToIngest(date_vendor_last_reported  = maxdtvendorlastreported);
	dFilesToIngest_other		:= FilesToIngest(date_vendor_last_reported != maxdtvendorlastreported);

  FilesToIngest0					:= project(dFilesToIngest_latest				,AddFlag(LEFT,RecordType.New));
  Base0										:= project(Base + dFilesToIngest_other	,AddFlag(LEFT,RecordType.Old));
	
	dFilesToIngest0					:= fRollup(FilesToIngest0	);
	dBase0									:= fRollup(Base0					);

  dFilesToIngest0_reflag	:= project(dFilesToIngest0		,AddFlag(LEFT,RecordType.New));
  dBase0_reflag						:= project(dBase0							,AddFlag(LEFT,RecordType.Old));

  AllRecs_join := JOIN(dBase0_reflag,dFilesToIngest0_reflag
		,		left.duns_number										= right.duns_number 
		AND left.rawfields.exec_first_name			= right.rawfields.exec_first_name 
		AND left.rawfields.exec_middle_initial	= right.rawfields.exec_middle_initial 
		AND left.rawfields.exec_last_name				= right.rawfields.exec_last_name 
		AND left.rawfields.exec_suffix					= right.rawfields.exec_suffix 
		AND left.rawfields.exec_mrc_title_code 	= right.rawfields.exec_mrc_title_code 
		AND left.rawfields.exec_title						= right.rawfields.exec_title 
		AND left.rawfields.exec_vanity_title 		= right.rawfields.exec_vanity_title 
		AND left.company_name										= right.company_name 
		,MergeData(left,right),full outer,hash);

	basefilexists := exists(Base0);
	
	AllRecs0 := if(basefilexists	,AllRecs_join,dFilesToIngest0_reflag);

	//Now need to update 'rid' numbers on new records
	//Base upon ut.Mac_Sequence_Records
	// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New or rid = 0);
  ORe := AllRecs0(not(__Tpe=RecordType.New or rid = 0));
  PrevBase := MAX(ORe,rid);
  WithRT AddNewRid(WithRT le, WithRT ri) := transform
    SELF.rid := IF ( le.rid=0, PrevBase+1+thorlib.node(), le.rid+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR,AddNewRid(left,right),local);
  shared AllRecs := ORe+NR1;
  StatsRec := RECORD
    STRING Type := RTToText(AllRecs.__Tpe);
    unsigned Cnt := COUNT(GROUP);
  end;
  export UpdateStats := table(AllRecs,StatsRec,__Tpe,FEW);
  shared Layouts.base.contacts DeTag(AllRecs le) := TRANSFORM
    SELF := le;
  END;
  shared Layouts.base.contacts MapTag(AllRecs le) := TRANSFORM
	  self.record_type := le.__Tpe;
    SELF := le;
  END;
  export NewRecords := project(AllRecs(__Tpe=RecordType.New),DeTag(left));
  export OldRecords := project(AllRecs(__Tpe=RecordType.Old),DeTag(left));
  export AllRecords := AllRecs;
  export AllRecords_NoTag := project(AllRecords,DeTag(left)); // Records in 'pure' format
  export AllRecords_MapTag := project(AllRecords,MapTag(left))  : persist(pPersistname); // Records in 'pure' format
  export AllRecords_MapTag_nopersist := project(AllRecords,MapTag(left)); // Records in 'pure' format
END;

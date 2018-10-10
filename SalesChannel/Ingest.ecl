import tools;
EXPORT Ingest(

	 dataset(Layouts.Base_new			)	pInputFile							
	,dataset(Layouts.Base_new			)	pBaseFile			= Files().base.qa									
	,string											pPersistname	= persistnames().IngestIt
	
) :=
MODULE
  shared base := pBaseFile; // Change IN_File_Base to change input to ingest process
  SHARED NullFile := DATASET([],Layouts.Base_new); // Use to replace files you wish to remove
// First collect together all sources
  shared infile := pInputFile;
//infile := NullFile; // Can be uncommented to remove temporarily
  shared FilesToIngest1 := infile;
  Layouts.Base_new Into(FilesToIngest1 le) := TRANSFORM
    self := le;
  end;
   shared  FilesToIngest := PROJECT(FilesToIngest1,Into(left)); // In case local header decl and _as_ attributes differ
//  SHARED FilesToIngest := DEDUP( SORT ( FilesToIngest0, WHOLE RECORD ), WHOLE RECORD ); // Remove dups from input
// Now need to discover which records are old / new / updated
  SHARED RecordType := utilities.recordtype;
  SHARED RTToText(unsigned1 c) := utilities.rttotext(c);
  shared WithRT := RECORD(Layouts.Base_new)
    __Tpe := RecordType.Unknown;
  END;
  shared  WithRT AddFlag(Layouts.base_new le,UNSIGNED1 c) := TRANSFORM
    SELF.__Tpe := c;
    SELF := le;
  END;
	
  shared  WithRT AddFlag2(WithRT le,UNSIGNED1 c) := TRANSFORM
    SELF.__Tpe := c;
    SELF := le;
  END;

  FilesToIngest0 := PROJECT(FilesToIngest,AddFlag(LEFT,RecordType.New));
  Base0 := PROJECT(Base,AddFlag(LEFT,RecordType.Old));
  shared WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
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
	export fRollup(dataset(WithRT)	pDataset) := 
	function
		AllRecs_dist := distribute(pDataset	,hash64(rawfields.Row_ID,rawfields.Company_Name,rawfields.Contact_Name));
		AllRecs_Sort		:= sort(AllRecs_dist
	,rawfields.Row_ID				
	,rawfields.Company_Name	
	,rawfields.Web_Address		
	,rawfields.Prefix				
	,rawfields.Contact_Name	
	,rawfields.First_Name		
	,rawfields.Middle_Name		
	,rawfields.Last_Name			
	,rawfields.Title					
	,rawfields.Address				
	,rawfields.Address1			
	,rawfields.City					
	,rawfields.State					
	,rawfields.Zip_Code			
	,rawfields.Country				
	,rawfields.Phone_Number	
	,rawfields.Email					
	,local
	);
		AllRecs_rollup := rollup(AllRecs_Sort
			,			left.rawfields.Row_ID				= right.rawfields.Row_ID				
				AND left.rawfields.Company_Name	= right.rawfields.Company_Name	
				AND left.rawfields.Web_Address	= right.rawfields.Web_Address	
				AND left.rawfields.Prefix				= right.rawfields.Prefix				
				AND left.rawfields.Contact_Name	= right.rawfields.Contact_Name	
				AND left.rawfields.First_Name		= right.rawfields.First_Name		
				AND left.rawfields.Middle_Name	= right.rawfields.Middle_Name	
				AND left.rawfields.Last_Name		= right.rawfields.Last_Name		
				AND left.rawfields.Title				= right.rawfields.Title				
				AND left.rawfields.Address			= right.rawfields.Address			
				AND left.rawfields.Address1			= right.rawfields.Address1			
				AND left.rawfields.City					= right.rawfields.City					
				AND left.rawfields.State				= right.rawfields.State				
				AND left.rawfields.Zip_Code			= right.rawfields.Zip_Code			
				AND left.rawfields.Country			= right.rawfields.Country			
				AND left.rawfields.Phone_Number	= right.rawfields.Phone_Number	 
				AND left.rawfields.Email				= right.rawfields.Email					

		,MergeData(left,right),local);
		return AllRecs_rollup;
	end;

	export maxdtvendorlastreported := max(FilesToIngest, date_vendor_last_reported) : stored('maxdtvendorlastreported');//what is date of latest update file

	export dFilesToIngest_latest	:= FilesToIngest(date_vendor_last_reported  = maxdtvendorlastreported);
	export dFilesToIngest_other		:= FilesToIngest(date_vendor_last_reported != maxdtvendorlastreported);

  export FilesToIngest0					:= project(dFilesToIngest_latest				,AddFlag(LEFT,RecordType.New));
  export Base0									:= project(Base + dFilesToIngest_other	,AddFlag(LEFT,RecordType.Old));
	
	export dFilesToIngest0				:= fRollup(FilesToIngest0		);
	export dBase0									:= fRollup(Base0						);
	
  export dFilesToIngest0_reflag	:= project(dFilesToIngest0		,AddFlag2(LEFT,RecordType.New));
  export dBase0_reflag					:= project(dBase0							,AddFlag2(LEFT,RecordType.Old));

  export AllRecs_join := JOIN(dBase0_reflag,dFilesToIngest0_reflag
			,			left.rawfields.Row_ID				= right.rawfields.Row_ID				
				AND left.rawfields.Company_Name	= right.rawfields.Company_Name	
				AND left.rawfields.Web_Address	= right.rawfields.Web_Address	
				AND left.rawfields.Prefix				= right.rawfields.Prefix				
				AND left.rawfields.Contact_Name	= right.rawfields.Contact_Name	
				AND left.rawfields.First_Name		= right.rawfields.First_Name		
				AND left.rawfields.Middle_Name	= right.rawfields.Middle_Name	
				AND left.rawfields.Last_Name		= right.rawfields.Last_Name		
				AND left.rawfields.Title				= right.rawfields.Title				
				AND left.rawfields.Address			= right.rawfields.Address			
				AND left.rawfields.Address1			= right.rawfields.Address1			
				AND left.rawfields.City					= right.rawfields.City					
				AND left.rawfields.State				= right.rawfields.State				
				AND left.rawfields.Zip_Code			= right.rawfields.Zip_Code			
				AND left.rawfields.Country			= right.rawfields.Country			
				AND left.rawfields.Phone_Number	= right.rawfields.Phone_Number	 
				AND left.rawfields.Email				= right.rawfields.Email					

	,MergeData(left,right),full outer,hash);
	
	basefilexists := exists(Base0);
	
	AllRecs0 := if(basefilexists	,AllRecs_join,dFilesToIngest0_reflag);
	
//Now need to update 'rid' numbers on new records
//Base upon ut.Mac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New or rid = 0);
  ORe := AllRecs0(not(__Tpe=RecordType.New or rid = 0));

//Now need to update 'rid' numbers on new records
//Base upon ut.Mac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  PrevBase := MAX(ORe,rid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rid := IF ( le.rid=0, PrevBase+1+thorlib.node(), le.rid+thorlib.nodes() );
    SELF.bdid := SELF.rid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR,AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1 ;
  StatsRec := RECORD
    STRING Type := RTToText(AllRecs.__Tpe);
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  EXPORT UpdateStats := TABLE(AllRecs,StatsRec,__Tpe,FEW);
  SHARED Layouts.base_new DeTag(AllRecs le) := TRANSFORM
	  self.record_type := le.__Tpe;
    SELF := le;
  END;
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New),DeTag(LEFT));
  EXPORT OldRecords := PROJECT(AllRecs(__Tpe=RecordType.Old),DeTag(LEFT));
	// Bug: 196922 - Privacy Manager Directing Removal of Email Grady.Ogburn@Lanxness.com 
	EXPORT AllRecords := AllRecs(~regexfind('GRADY.OGBURN@LANXESS.COM',rawfields.email, nocase)); 
  export AllRecords_NoTag := project(AllRecords,DeTag(left)) : persist(pPersistname); // Records in 'pure' format

END;

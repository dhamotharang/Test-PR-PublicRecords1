import tools;
EXPORT Ingest_Companies(

	 dataset(layouts.temporary.companies_aid_prep	)	pInputFile							
	,dataset(layouts.base.companies								)	pBaseFile			= Files().base.companies.qa
	,string																					pPersistname	= persistnames().IngestCompanies
	
) :=
MODULE

  shared base := project(pBaseFile,transform(layouts.temporary.companies_aid_prep,self := left,self := [])); // Change IN_file_base to change input to ingest process
  IMPORT SALT22;
  SHARED NullFile := DATASET([],layouts.temporary.companies_aid_prep); // Use to replace files you wish to remove
// First collect together all sources
  infile := pInputFile;
//infile := NullFile; // Can be uncommented to remove temporarily
  FilesToIngest1 := infile;
  layouts.temporary.companies_aid_prep Into(FilesToIngest1 le) := TRANSFORM
    self := le;
  end;
    FilesToIngest0 := PROJECT(FilesToIngest1,Into(left)); // In case local header decl and _as_ attributes differ
  SHARED FilesToIngest := DEDUP( SORT ( distribute(FilesToIngest0, hash64(rawfields.enterprise_num)), WHOLE RECORD,local ), WHOLE RECORD,local ); // Remove dups from input
// Now need to discover which records are old / new / updated
  SHARED RecordType := ENUM(UNSIGNED1,Unknown,Unchanged,Updated,Old,New);
  SHARED RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');
  WithRT := RECORD(layouts.temporary.companies_aid_prep)
    __Tpe := RecordType.Unknown;
  END;
  WithRT AddFlag(layouts.temporary.companies_aid_prep le,UNSIGNED1 c) := TRANSFORM
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
  AllRecs0 := JOIN(Base0,FilesToIngest0, left.rawfields.Enterprise_num = right.rawfields.Enterprise_num AND left.rawfields.Parent_Enterprise_number = right.rawfields.Parent_Enterprise_number AND left.rawfields.Ultimate_Enterprise_number = right.rawfields.Ultimate_Enterprise_number AND left.rawfields.Company_Type = right.rawfields.Company_Type AND left.rawfields.name = right.rawfields.name AND left.rawfields.Note = right.rawfields.Note AND left.rawfields.level = right.rawfields.level AND left.rawfields.Root = right.rawfields.Root AND left.rawfields.sub = right.rawfields.sub AND left.rawfields.Parent_Name = right.rawfields.Parent_Name AND left.rawfields.Parent_Number = right.rawfields.Parent_Number AND left.rawfields.JV_Parent1 = right.rawfields.JV_Parent1 AND left.rawfields.JV1_num = right.rawfields.JV1_num AND left.rawfields.JV_Parent2 = right.rawfields.JV_Parent2 AND left.rawfields.JV2_num = right.rawfields.JV2_num 
	AND left.rawfields.address1.PO_Box_Bldg = right.rawfields.address1.PO_Box_Bldg AND left.rawfields.address1.street = right.rawfields.address1.street AND left.rawfields.address1.Foreign_PO = right.rawfields.address1.Foreign_PO AND left.rawfields.address1.Misc__adr = right.rawfields.address1.Misc__adr AND left.rawfields.address1.Postal_Code_1 = right.rawfields.address1.Postal_Code_1 AND left.rawfields.address1.city = right.rawfields.address1.city AND left.rawfields.address1.state = right.rawfields.address1.state AND left.rawfields.address1.zip = right.rawfields.address1.zip AND left.rawfields.address1.Province = right.rawfields.address1.Province AND left.rawfields.address1.Postal_Code_2 = right.rawfields.address1.Postal_Code_2 AND left.rawfields.address1.country = right.rawfields.address1.country AND left.rawfields.address1.Postal_Code_3 = right.rawfields.address1.Postal_Code_3
	AND left.rawfields.phone = right.rawfields.phone AND left.rawfields.FAX = right.rawfields.FAX AND left.rawfields.Telex = right.rawfields.Telex AND left.rawfields.E_mail = right.rawfields.E_mail AND left.rawfields.url = right.rawfields.url 
	AND left.rawfields.address2.PO_Box_Bldg = right.rawfields.address2.PO_Box_Bldg AND left.rawfields.address2.street = right.rawfields.address2.street AND left.rawfields.address2.Foreign_PO = right.rawfields.address2.Foreign_PO AND left.rawfields.address2.Misc__adr = right.rawfields.address2.Misc__adr AND left.rawfields.address2.Postal_Code_1 = right.rawfields.address2.Postal_Code_1 AND left.rawfields.address2.city = right.rawfields.address2.city AND left.rawfields.address2.state = right.rawfields.address2.state AND left.rawfields.address2.zip = right.rawfields.address2.zip AND left.rawfields.address2.Province = right.rawfields.address2.Province AND left.rawfields.address2.Postal_Code_2 = right.rawfields.address2.Postal_Code_2 AND left.rawfields.address2.country = right.rawfields.address2.country AND left.rawfields.address2.Postal_Code_3 = right.rawfields.address2.Postal_Code_3
	AND left.rawfields.INCORP = right.rawfields.INCORP AND left.rawfields.percent_owned = right.rawfields.percent_owned AND left.rawfields.Earnings = right.rawfields.Earnings AND left.rawfields.Sales = right.rawfields.Sales AND left.rawfields.Sales_Desc = right.rawfields.Sales_Desc AND left.rawfields.assets = right.rawfields.assets AND left.rawfields.liabilities = right.rawfields.liabilities AND left.rawfields.net_worth = right.rawfields.net_worth AND left.rawfields.FYE = right.rawfields.FYE AND left.rawfields.EMP_NUM = right.rawfields.EMP_NUM AND left.rawfields.DoesImport = right.rawfields.DoesImport AND left.rawfields.DoesExport = right.rawfields.DoesExport AND left.rawfields.Bus_Desc = right.rawfields.Bus_Desc AND left.rawfields.Sic1 = right.rawfields.Sic1 AND left.rawfields.Text1 = right.rawfields.Text1 AND left.rawfields.Sic2 = right.rawfields.Sic2 AND left.rawfields.Text2 = right.rawfields.Text2 AND left.rawfields.Sic3 = right.rawfields.Sic3 AND left.rawfields.Text3 = right.rawfields.Text3 AND left.rawfields.Sic4 = right.rawfields.Sic4 AND left.rawfields.Text4 = right.rawfields.Text4 AND left.rawfields.Sic5 = right.rawfields.Sic5 AND left.rawfields.Text5 = right.rawfields.Text5 AND left.rawfields.Sic6 = right.rawfields.Sic6 AND left.rawfields.Text6 = right.rawfields.Text6 AND left.rawfields.Sic7 = right.rawfields.Sic7 AND left.rawfields.Text7 = right.rawfields.Text7 AND left.rawfields.Sic8 = right.rawfields.Sic8 AND left.rawfields.Text8 = right.rawfields.Text8 AND left.rawfields.Sic9 = right.rawfields.Sic9 AND left.rawfields.Text9 = right.rawfields.Text9 AND left.rawfields.Sic10 = right.rawfields.Sic10 AND left.rawfields.Text10 = right.rawfields.Text10 AND left.rawfields.Ticker_Symbol = right.rawfields.Ticker_Symbol AND left.rawfields.Exchange1 = right.rawfields.Exchange1 AND left.rawfields.Exchange2 = right.rawfields.Exchange2 AND left.rawfields.Exchange3 = right.rawfields.Exchange3 AND left.rawfields.Exchange4 = right.rawfields.Exchange4 AND left.rawfields.Exchange5 = right.rawfields.Exchange5 AND left.rawfields.Exchange6 = right.rawfields.Exchange6 AND left.rawfields.Exchange7 = right.rawfields.Exchange7 AND left.rawfields.Exchange8 = right.rawfields.Exchange8 AND left.rawfields.Exchange9 = right.rawfields.Exchange9 AND left.rawfields.Exchange10 = right.rawfields.Exchange10 AND left.rawfields.Exchange11 = right.rawfields.Exchange11 AND left.rawfields.Exchange12 = right.rawfields.Exchange12 AND left.rawfields.Exchange13 = right.rawfields.Exchange13 AND left.rawfields.Exchange14 = right.rawfields.Exchange14 AND left.rawfields.Exchange15 = right.rawfields.Exchange15 AND left.rawfields.Exchange16 = right.rawfields.Exchange16 AND left.rawfields.Exchange17 = right.rawfields.Exchange17 AND left.rawfields.Exchange18 = right.rawfields.Exchange18 AND left.rawfields.Exchange19 = right.rawfields.Exchange19 AND left.rawfields.Exchange20 = right.rawfields.Exchange20 AND left.rawfields.Extended_Profile = right.rawfields.Extended_Profile AND left.rawfields.cbsa = right.rawfields.cbsa AND left.rawfields.Competitors = right.rawfields.Competitors AND left.rawfields.Naics1 = right.rawfields.Naics1 AND left.rawfields.Naics_Text1 = right.rawfields.Naics_Text1 AND left.rawfields.Naics2 = right.rawfields.Naics2 AND left.rawfields.Naics_Text2 = right.rawfields.Naics_Text2 AND left.rawfields.Naics3 = right.rawfields.Naics3 AND left.rawfields.Naics_Text3 = right.rawfields.Naics_Text3 AND left.rawfields.Naics4 = right.rawfields.Naics4 AND left.rawfields.Naics_Text4 = right.rawfields.Naics_Text4 AND left.rawfields.Naics5 = right.rawfields.Naics5 AND left.rawfields.Naics_Text5 = right.rawfields.Naics_Text5 AND left.rawfields.Naics6 = right.rawfields.Naics6 AND left.rawfields.Naics_Text6 = right.rawfields.Naics_Text6 AND left.rawfields.Naics7 = right.rawfields.Naics7 AND left.rawfields.Naics_Text7 = right.rawfields.Naics_Text7 AND left.rawfields.Naics8 = right.rawfields.Naics8 AND left.rawfields.Naics_Text8 = right.rawfields.Naics_Text8 AND left.rawfields.Naics9 = right.rawfields.Naics9 AND left.rawfields.Naics_Text9 = right.rawfields.Naics_Text9 AND left.rawfields.Naics10 = right.rawfields.Naics10 AND left.rawfields.Naics_Text10 = right.rawfields.Naics_Text10,MergeData(LEFT,RIGHT),FULL OUTER,HASH);
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
  SHARED AllRecs := project(ORe+NR1,transform(recordof(left),self.__Tpe := RecordType.New,self := left));
  StatsRec := RECORD
    SALT22.StrType Type := RTToText(AllRecs.__Tpe);
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  EXPORT UpdateStats := TABLE(AllRecs,StatsRec,__Tpe,FEW);
  SHARED layouts.temporary.companies_aid_prep DeTag(AllRecs le) := TRANSFORM
		self.record_type := RecordType.New;	//they are all new records(don't keep history)
    SELF := le;
  END;
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New),DeTag(LEFT));
  EXPORT OldRecords := PROJECT(AllRecs(__Tpe=RecordType.Old),DeTag(LEFT));
  EXPORT AllRecords := AllRecs;
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,DeTag(LEFT)) : PERSIST(persistnames().IngestCompanies) ;// Records in 'pure' format
  S1 := OUTPUT(UpdateStats,all);
//  S2 := OUTPUT(FieldChangeStats,all);
//  S3 := OUTPUT(InputSourceCounts,all);
//  EXPORT DoStats := PARALLEL(S1,S2,S3);
  O := OUTPUT(AllRecords_Notag,,DCAV2.BuildFiles.Names.New); // Remove _Notag to keep 'what happened' byte
/*  EXPORT Sequence := SEQUENTIAL( DCAV2.RawFiles.CreateSupers, // Make sure all superfiles exist
                                DCAV2.RawFiles.Spray, // Spray all the required data
                                DCAV2.RawFiles.Promote.Sprayed2Using, // Capture all files
                                O, // Do the ingest
                                DCAV2.RawFiles.Promote.Using2Used, // 'Eat' the files
                                DCAV2.BuildFiles.Promote.New2Built, // Register the new built file
                                DoStats); // You can add your post processing in here ....
*/
END;

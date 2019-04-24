//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Aircraft,E_Aircraft_Owner,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Aircraft_Search(SET OF KEL.typ.int __PLexIDs, KEL.typ.unk __PArchiveDate, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED TYPEOF(E_Aircraft(__in).__Result) __E_Aircraft := E_Aircraft(__in).__Result;
  SHARED TYPEOF(E_Aircraft_Owner(__in).__Result) __E_Aircraft_Owner := E_Aircraft_Owner(__in).__Result;
  SHARED TYPEOF(E_Person(__in).__Result) __E_Person := E_Person(__in).__Result;
  SHARED __EE460052 := __E_Person;
  SHARED __EE460600 := __EE460052(__T(__OP2(__EE460052.UID,IN,__CN(__PLexIDs))));
  SHARED __EE460054 := __E_Aircraft;
  SHARED __EE460053 := __E_Aircraft_Owner;
  SHARED __EE460355 := __EE460053(__NN(__EE460053.Plane_) AND __NN(__EE460053.Owner_));
  SHARED __ST459633_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr N_Number_;
    KEL.typ.nstr Serial_Number_;
    KEL.typ.nstr Manufacturer_Model_Code_;
    KEL.typ.nstr Engine_Manufacturer_Model_Code_;
    KEL.typ.nint Year_Manufactured_;
    KEL.typ.nint Type_;
    KEL.typ.nstr Type_Engine_;
    KEL.typ.nstr Manufacturer_Name_;
    KEL.typ.nstr Model_Name_;
    KEL.typ.nstr Transponder_Code_;
    KEL.typ.ndataset(E_Aircraft(__in).Ownership_Status_Layout) Ownership_Status_;
    KEL.typ.ndataset(E_Aircraft(__in).Last_Action_Date_Layout) Last_Action_Date_;
    KEL.typ.ndataset(E_Aircraft(__in).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.ndataset(E_Aircraft_Owner(__in).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC460367(E_Aircraft(__in).Layout __EE460054, E_Aircraft_Owner(__in).Layout __EE460355) := __EEQP(__EE460355.Plane_,__EE460054.UID);
  __ST459633_Layout __JT460367(E_Aircraft(__in).Layout __l, E_Aircraft_Owner(__in).Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE460368 := JOIN(__EE460355,__EE460054,__JC460367(RIGHT,LEFT),__JT460367(RIGHT,LEFT),INNER,HASH);
  SHARED __ST459921_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST459633_Layout) Plane_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC460606(E_Person(__in).Layout __EE460600, __ST459633_Layout __EE460368) := __EEQP(__EE460600.UID,__EE460368.Owner_);
  __ST459921_Layout __Join__ST459921_Layout(E_Person(__in).Layout __r, DATASET(__ST459633_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Plane_ := __CN(__recs);
  END;
  SHARED __EE460660 := DENORMALIZE(DISTRIBUTE(__EE460600,HASH(UID)),DISTRIBUTE(__EE460368,HASH(Owner_)),__JC460606(LEFT,RIGHT),GROUP,__Join__ST459921_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST20974_Layout := RECORD
    KEL.typ.nstr Status_Code_;
    KEL.typ.nstr Fractional_Owner_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST20980_Layout := RECORD
    KEL.typ.nkdate Last_Action_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST20985_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST20988_Layout := RECORD
    KEL.typ.nstr N_Number_;
    KEL.typ.nstr Serial_Number_;
    KEL.typ.nstr Manufacturer_Model_Code_;
    KEL.typ.nstr Engine_Manufacturer_Model_Code_;
    KEL.typ.nint Year_Manufactured_;
    KEL.typ.nint Type_;
    KEL.typ.nstr Type_Engine_;
    KEL.typ.nstr Manufacturer_Name_;
    KEL.typ.nstr Model_Name_;
    KEL.typ.nstr Transponder_Code_;
    KEL.typ.ndataset(__ST20974_Layout) Ownership_Status_;
    KEL.typ.ndataset(__ST20980_Layout) Last_Action_Date_;
    KEL.typ.ndataset(__ST20985_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21003_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ndataset(__ST20988_Layout) Plane_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21003_Layout __ND460681__Project(__ST459921_Layout __PP460677) := TRANSFORM
    __EE460663 := __PP460677.Plane_;
    __ST20988_Layout __ND460703__Project(__ST459633_Layout __PP460699) := TRANSFORM
      __EE460667 := __PP460699.Ownership_Status_;
      SELF.Ownership_Status_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE460667),__ST20974_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Status_Code_,Fractional_Owner_},Status_Code_,Fractional_Owner_,MERGE),__ST20974_Layout),__NL(__EE460667));
      __EE460671 := __PP460699.Last_Action_Date_;
      SELF.Last_Action_Date_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE460671),__ST20980_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Last_Action_Date_},Last_Action_Date_,MERGE),__ST20980_Layout),__NL(__EE460671));
      __EE460675 := __PP460699.Data_Sources_;
      SELF.Data_Sources_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE460675),__ST20985_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_,MERGE),__ST20985_Layout),__NL(__EE460675));
      SELF := __PP460699;
    END;
    __ST20988_Layout __ND460703__Rollup(__ST20988_Layout __r, DATASET(__ST20988_Layout) __recs) := TRANSFORM
      __recs_Ownership_Status_ := NORMALIZE(__recs,__T(LEFT.Ownership_Status_),TRANSFORM(__ST20974_Layout,SELF:=RIGHT));
      __recs_Ownership_Status__allnull := NOT EXISTS(__recs(__NN(Ownership_Status_)));
      SELF.Ownership_Status_ := __BN(PROJECT(TABLE(__recs_Ownership_Status_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Status_Code_,Fractional_Owner_},Status_Code_,Fractional_Owner_),__ST20974_Layout),__recs_Ownership_Status__allnull);
      __recs_Last_Action_Date_ := NORMALIZE(__recs,__T(LEFT.Last_Action_Date_),TRANSFORM(__ST20980_Layout,SELF:=RIGHT));
      __recs_Last_Action_Date__allnull := NOT EXISTS(__recs(__NN(Last_Action_Date_)));
      SELF.Last_Action_Date_ := __BN(PROJECT(TABLE(__recs_Last_Action_Date_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Last_Action_Date_},Last_Action_Date_),__ST20980_Layout),__recs_Last_Action_Date__allnull);
      __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(__ST20985_Layout,SELF:=RIGHT));
      __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
      SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),__ST20985_Layout),__recs_Data_Sources__allnull);
      SELF.__RecordCount := SUM(__recs,__RecordCount);
      SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
      SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
      SELF := __r;
    END;
    SELF.Plane_ := __BN(ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__T(__EE460663),__ND460703__Project(LEFT))(__NN(N_Number_) OR __NN(Serial_Number_) OR __NN(Manufacturer_Model_Code_) OR __NN(Engine_Manufacturer_Model_Code_) OR __NN(Year_Manufactured_) OR __NN(Type_) OR __NN(Type_Engine_) OR __NN(Manufacturer_Name_) OR __NN(Model_Name_) OR __NN(Transponder_Code_) OR __NN(Ownership_Status_) OR __NN(Last_Action_Date_) OR __NN(Data_Sources_)),'Ownership_Status_,Last_Action_Date_,Data_Sources_','ownership_status_,last_action_date_,data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),N_Number_,Serial_Number_,Manufacturer_Model_Code_,Engine_Manufacturer_Model_Code_,Year_Manufactured_,Type_,Type_Engine_,Manufacturer_Name_,Model_Name_,Transponder_Code_,Ownership_Status_Clean,Last_Action_Date_Clean,Data_Sources_Clean,ALL),GROUP,__ND460703__Rollup(ROW(LEFT,__ST20988_Layout), PROJECT(ROWS(LEFT),__ST20988_Layout))),__NL(__EE460663));
    SELF := __PP460677;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(PROJECT(__EE460660,__ND460681__Project(LEFT)),__ST21003_Layout));
END;

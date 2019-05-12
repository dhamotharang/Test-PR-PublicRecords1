//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Aircraft,E_Aircraft_Owner,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Aircraft_Search(SET OF KEL.typ.uid __PLexIDs, KEL.typ.kdate __PArchiveDate, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PArchiveDate;
  END;
  SHARED E_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,IN,__CN(__PLexIDs)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Aircraft_Owner_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Aircraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Aircraft_Owner_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Plane_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Aircraft_Owner_Filtered := E_Aircraft_Owner_Filtered_1;
  SHARED E_Person_Filtered := E_Person_Filtered_2;
  SHARED TYPEOF(E_Aircraft(__in,__cfg_Local).__Result) __E_Aircraft := E_Aircraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg_Local).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE34004 := __E_Person;
  SHARED __EE35309 := __EE34004(__T(__OP2(__EE34004.UID,IN,__CN(__PLexIDs))));
  SHARED __EE34007 := __E_Aircraft_Owner;
  SHARED __EE34529 := __EE34007(__NN(__EE34007.Owner_));
  SHARED __EE34006 := __E_Aircraft;
  SHARED __ST33215_Layout := RECORD
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.ndataset(E_Aircraft_Owner(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
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
    KEL.typ.ndataset(E_Aircraft(__in,__cfg_Local).Ownership_Status_Layout) Ownership_Status_;
    KEL.typ.ndataset(E_Aircraft(__in,__cfg_Local).Last_Action_Date_Layout) Last_Action_Date_;
    KEL.typ.ndataset(E_Aircraft(__in,__cfg_Local).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC34535(E_Aircraft_Owner(__in,__cfg_Local).Layout __EE34529, E_Aircraft(__in,__cfg_Local).Layout __EE34006) := __EEQP(__EE34529.Plane_,__EE34006.UID);
  __ST33215_Layout __JT34535(E_Aircraft_Owner(__in,__cfg_Local).Layout __l, E_Aircraft(__in,__cfg_Local).Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE34536 := JOIN(__EE34529,__EE34006,__JC34535(LEFT,RIGHT),__JT34535(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST33613_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST33215_Layout) Aircraft_Owner_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC35315(E_Person(__in,__cfg_Local).Layout __EE35309, __ST33215_Layout __EE34536) := __EEQP(__EE35309.UID,__EE34536.Owner_);
  __ST33613_Layout __Join__ST33613_Layout(E_Person(__in,__cfg_Local).Layout __r, DATASET(__ST33215_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Aircraft_Owner_ := __CN(__recs);
  END;
  SHARED __EE35369 := DENORMALIZE(DISTRIBUTE(__EE35309,HASH(UID)),DISTRIBUTE(__EE34536,HASH(Owner_)),__JC35315(LEFT,RIGHT),GROUP,__Join__ST33613_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __EE35013 := __EE34006;
  SHARED __EE35010 := __EE34007;
  SHARED __EE35027 := __EE35010(__NN(__EE35010.Plane_) AND __NN(__EE35010.Owner_));
  SHARED __ST33325_Layout := RECORD
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
    KEL.typ.ndataset(E_Aircraft(__in,__cfg_Local).Ownership_Status_Layout) Ownership_Status_;
    KEL.typ.ndataset(E_Aircraft(__in,__cfg_Local).Last_Action_Date_Layout) Last_Action_Date_;
    KEL.typ.ndataset(E_Aircraft(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.ndataset(E_Aircraft_Owner(__in,__cfg_Local).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC35035(E_Aircraft(__in,__cfg_Local).Layout __EE35013, E_Aircraft_Owner(__in,__cfg_Local).Layout __EE35027) := __EEQP(__EE35027.Plane_,__EE35013.UID);
  __ST33325_Layout __JT35035(E_Aircraft(__in,__cfg_Local).Layout __l, E_Aircraft_Owner(__in,__cfg_Local).Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE35036 := JOIN(__EE35027,__EE35013,__JC35035(RIGHT,LEFT),__JT35035(RIGHT,LEFT),INNER,HASH);
  SHARED __ST33834_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST33215_Layout) Aircraft_Owner_;
    KEL.typ.ndataset(__ST33325_Layout) Plane_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC35375(__ST33613_Layout __EE35369, __ST33325_Layout __EE35036) := __EEQP(__EE35369.UID,__EE35036.Owner_);
  __ST33834_Layout __Join__ST33834_Layout(__ST33613_Layout __r, DATASET(__ST33325_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Plane_ := __CN(__recs);
  END;
  SHARED __EE35460 := DENORMALIZE(DISTRIBUTE(__EE35369,HASH(UID)),DISTRIBUTE(__EE35036,HASH(Owner_)),__JC35375(LEFT,RIGHT),GROUP,__Join__ST33834_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST18525_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST18528_Layout := RECORD
    KEL.typ.nstr N_Number_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.ndataset(__ST18525_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST18539_Layout := RECORD
    KEL.typ.nstr Status_Code_;
    KEL.typ.nstr Fractional_Owner_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST18545_Layout := RECORD
    KEL.typ.nkdate Last_Action_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST18550_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST18553_Layout := RECORD
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
    KEL.typ.ndataset(__ST18539_Layout) Ownership_Status_;
    KEL.typ.ndataset(__ST18545_Layout) Last_Action_Date_;
    KEL.typ.ndataset(__ST18550_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST18568_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ndataset(__ST18528_Layout) Aircraft_Owner_;
    KEL.typ.ndataset(__ST18553_Layout) Plane_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST18568_Layout __ND35489__Project(__ST33834_Layout __PP35485) := TRANSFORM
    __EE35463 := __PP35485.Aircraft_Owner_;
    __ST18528_Layout __ND35504__Project(__ST33215_Layout __PP35500) := TRANSFORM
      __EE35498 := __PP35500.Data_Sources_;
      SELF.Data_Sources_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE35498),__ST18525_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_,MERGE),__ST18525_Layout),__NL(__EE35498));
      SELF := __PP35500;
    END;
    __ST18528_Layout __ND35504__Rollup(__ST18528_Layout __r, DATASET(__ST18528_Layout) __recs) := TRANSFORM
      __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(__ST18525_Layout,SELF:=RIGHT));
      __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
      SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),__ST18525_Layout),__recs_Data_Sources__allnull);
      SELF.__RecordCount := SUM(__recs,__RecordCount);
      SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
      SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
      SELF := __r;
    END;
    SELF.Aircraft_Owner_ := __BN(ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__T(__EE35463),__ND35504__Project(LEFT))(__NN(N_Number_) OR __NN(Registrant_Type_) OR __NN(Certificate_Issue_Date_) OR __NN(Certification_) OR __NN(Data_Sources_)),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),N_Number_,Registrant_Type_,Certificate_Issue_Date_,Certification_,Data_Sources_Clean,ALL),GROUP,__ND35504__Rollup(ROW(LEFT,__ST18528_Layout), PROJECT(ROWS(LEFT),__ST18528_Layout))),__NL(__EE35463));
    __EE35471 := __PP35485.Plane_;
    __ST18553_Layout __ND35552__Project(__ST33325_Layout __PP35548) := TRANSFORM
      __EE35538 := __PP35548.Ownership_Status_;
      SELF.Ownership_Status_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE35538),__ST18539_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Status_Code_,Fractional_Owner_},Status_Code_,Fractional_Owner_,MERGE),__ST18539_Layout),__NL(__EE35538));
      __EE35546 := __PP35548.Last_Action_Date_;
      SELF.Last_Action_Date_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE35546),__ST18545_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Last_Action_Date_},Last_Action_Date_,MERGE),__ST18545_Layout),__NL(__EE35546));
      __EE35542 := __PP35548.Data_Sources_;
      SELF.Data_Sources_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE35542),__ST18550_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_,MERGE),__ST18550_Layout),__NL(__EE35542));
      SELF := __PP35548;
    END;
    __ST18553_Layout __ND35552__Rollup(__ST18553_Layout __r, DATASET(__ST18553_Layout) __recs) := TRANSFORM
      __recs_Ownership_Status_ := NORMALIZE(__recs,__T(LEFT.Ownership_Status_),TRANSFORM(__ST18539_Layout,SELF:=RIGHT));
      __recs_Ownership_Status__allnull := NOT EXISTS(__recs(__NN(Ownership_Status_)));
      SELF.Ownership_Status_ := __BN(PROJECT(TABLE(__recs_Ownership_Status_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Status_Code_,Fractional_Owner_},Status_Code_,Fractional_Owner_),__ST18539_Layout),__recs_Ownership_Status__allnull);
      __recs_Last_Action_Date_ := NORMALIZE(__recs,__T(LEFT.Last_Action_Date_),TRANSFORM(__ST18545_Layout,SELF:=RIGHT));
      __recs_Last_Action_Date__allnull := NOT EXISTS(__recs(__NN(Last_Action_Date_)));
      SELF.Last_Action_Date_ := __BN(PROJECT(TABLE(__recs_Last_Action_Date_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Last_Action_Date_},Last_Action_Date_),__ST18545_Layout),__recs_Last_Action_Date__allnull);
      __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(__ST18550_Layout,SELF:=RIGHT));
      __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
      SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),__ST18550_Layout),__recs_Data_Sources__allnull);
      SELF.__RecordCount := SUM(__recs,__RecordCount);
      SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
      SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
      SELF := __r;
    END;
    SELF.Plane_ := __BN(ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__T(__EE35471),__ND35552__Project(LEFT))(__NN(N_Number_) OR __NN(Serial_Number_) OR __NN(Manufacturer_Model_Code_) OR __NN(Engine_Manufacturer_Model_Code_) OR __NN(Year_Manufactured_) OR __NN(Type_) OR __NN(Type_Engine_) OR __NN(Manufacturer_Name_) OR __NN(Model_Name_) OR __NN(Transponder_Code_) OR __NN(Ownership_Status_) OR __NN(Last_Action_Date_) OR __NN(Data_Sources_)),'Ownership_Status_,Last_Action_Date_,Data_Sources_','ownership_status_,last_action_date_,data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),N_Number_,Serial_Number_,Manufacturer_Model_Code_,Engine_Manufacturer_Model_Code_,Year_Manufactured_,Type_,Type_Engine_,Manufacturer_Name_,Model_Name_,Transponder_Code_,Ownership_Status_Clean,Last_Action_Date_Clean,Data_Sources_Clean,ALL),GROUP,__ND35552__Rollup(ROW(LEFT,__ST18553_Layout), PROJECT(ROWS(LEFT),__ST18553_Layout))),__NL(__EE35471));
    SELF := __PP35485;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(PROJECT(__EE35460,__ND35489__Project(LEFT)),__ST18568_Layout));
END;

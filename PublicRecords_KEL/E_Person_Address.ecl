//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Person,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Address(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nint Address_Rank_;
    KEL.typ.nint Insurance_Source_Count_;
    KEL.typ.nint Property_Source_Count_;
    KEL.typ.nint Utility_Source_Count_;
    KEL.typ.nint Vehicle_Source_Count_;
    KEL.typ.nint D_L_Source_Count_;
    KEL.typ.nint Voter_Source_Count_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(Subject_:0),Location_(Location_:0),primaryrange(Primary_Range_:\'\'),predirectional(Predirectional_:\'\'),primaryname(Primary_Name_:\'\'),suffix(Suffix_:\'\'),postdirectional(Postdirectional_:\'\'),secondaryrange(Secondary_Range_:\'\'),zip5(Z_I_P5_:0),addressrank(Address_Rank_:0),insurancesourcecount(Insurance_Source_Count_:0),propertysourcecount(Property_Source_Count_:0),utilitysourcecount(Utility_Source_Count_:0),vehiclesourcecount(Vehicle_Source_Count_:0),dlsourcecount(D_L_Source_Count_:0),votersourcecount(Voter_Source_Count_:0),addresstype(Address_Type_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(Subject_:0),Location_(Location_:0),prim_range(Primary_Range_:\'\'),predir(Predirectional_:\'\'),prim_name(Primary_Name_:\'\'),suffix(Suffix_:\'\'),postdir(Postdirectional_:\'\'),sec_range(Secondary_Range_:\'\'),zip(Z_I_P5_:0),addressrank(Address_Rank_:0),insurancesourcecount(Insurance_Source_Count_:0),propertysourcecount(Property_Source_Count_:0),utilitysourcecount(Utility_Source_Count_:0),vehiclesourcecount(Vehicle_Source_Count_:0),dlsourcecount(D_L_Source_Count_:0),votersourcecount(Voter_Source_Count_:0),addresstype(Address_Type_:\'\'),src(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_KELfiltered,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(Subject_:0),Location_(Location_:0),prim_range(Primary_Range_:\'\'),predir(Predirectional_:\'\'),prim_name(Primary_Name_:\'\'),suffix(Suffix_:\'\'),postdir(Postdirectional_:\'\'),sec_range(Secondary_Range_:\'\'),zip(Z_I_P5_:0),addressrank(Address_Rank_:0),insurancesourcecount(Insurance_Source_Count_:0),propertysourcecount(Property_Source_Count_:0),utilitysourcecount(Utility_Source_Count_:0),vehiclesourcecount(Vehicle_Source_Count_:0),dlsourcecount(D_L_Source_Count_:0),votersourcecount(Voter_Source_Count_:0),addresstype(Address_Type_:\'\'),src(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),DPMBitmap(__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Location__Mapped := JOIN(__d1_KELfiltered,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Location__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  SHARED __Mapping2 := 'did(Subject_:0),Location_(Location_:0),prim_range(Primary_Range_:\'\'),predir(Predirectional_:\'\'),prim_name(Primary_Name_:\'\'),addr_suffix(Suffix_:\'\'),postdir(Postdirectional_:\'\'),sec_range(Secondary_Range_:\'\'),zip5(Z_I_P5_:0),addressrank(Address_Rank_:0),insurancesourcecount(Insurance_Source_Count_:0),propertysourcecount(Property_Source_Count_:0),utilitysourcecount(Utility_Source_Count_:0),vehiclesourcecount(Vehicle_Source_Count_:0),dlsourcecount(D_L_Source_Count_:0),votersourcecount(Voter_Source_Count_:0),addresstype(Address_Type_:\'\'),src(Source_:\'\'),fcra_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip5 != 0 AND (UNSIGNED)did != 0);
  SHARED __d2_Location__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d2_Location__Mapped := JOIN(__d2_KELfiltered,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d2_Prefiltered := __d2_Location__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2));
  SHARED __Mapping3 := 'did(Subject_:0),Location_(Location_:0),prim_range(Primary_Range_:\'\'),predir(Predirectional_:\'\'),prim_name(Primary_Name_:\'\'),addr_suffix(Suffix_:\'\'),postdir(Postdirectional_:\'\'),sec_range(Secondary_Range_:\'\'),zip(Z_I_P5_:0),addressrank(Address_Rank_:0),insurancesourcecount(Insurance_Source_Count_:0),propertysourcecount(Property_Source_Count_:0),utilitysourcecount(Utility_Source_Count_:0),vehiclesourcecount(Vehicle_Source_Count_:0),dlsourcecount(D_L_Source_Count_:0),votersourcecount(Voter_Source_Count_:0),addresstype(Address_Type_:\'\'),date_first_seen(Date_First_Seen_:EPOCH),date_last_seen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d3_Location__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d3_Location__Mapped := JOIN(__d3_KELfiltered,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d3_Prefiltered := __d3_Location__Mapped;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3),__Mapping3_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nint Address_Rank_;
    KEL.typ.nint Insurance_Source_Count_;
    KEL.typ.nint Property_Source_Count_;
    KEL.typ.nint Utility_Source_Count_;
    KEL.typ.nint Vehicle_Source_Count_;
    KEL.typ.nint D_L_Source_Count_;
    KEL.typ.nint Voter_Source_Count_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Location_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,Address_Rank_,Insurance_Source_Count_,Property_Source_Count_,Utility_Source_Count_,Vehicle_Source_Count_,D_L_Source_Count_,Voter_Source_Count_,Address_Type_,ALL));
  Person_Address_Group := __PostFilter;
  Layout Person_Address__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Address_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Address_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Location__Orphan),COUNT(Z_I_P5__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Z_I_P5__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressRank',COUNT(__d0(__NL(Address_Rank_))),COUNT(__d0(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InsuranceSourceCount',COUNT(__d0(__NL(Insurance_Source_Count_))),COUNT(__d0(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertySourceCount',COUNT(__d0(__NL(Property_Source_Count_))),COUNT(__d0(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UtilitySourceCount',COUNT(__d0(__NL(Utility_Source_Count_))),COUNT(__d0(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleSourceCount',COUNT(__d0(__NL(Vehicle_Source_Count_))),COUNT(__d0(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DLSourceCount',COUNT(__d0(__NL(D_L_Source_Count_))),COUNT(__d0(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VoterSourceCount',COUNT(__d0(__NL(Voter_Source_Count_))),COUNT(__d0(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressType',COUNT(__d0(__NL(Address_Type_))),COUNT(__d0(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressRank',COUNT(__d1(__NL(Address_Rank_))),COUNT(__d1(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InsuranceSourceCount',COUNT(__d1(__NL(Insurance_Source_Count_))),COUNT(__d1(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertySourceCount',COUNT(__d1(__NL(Property_Source_Count_))),COUNT(__d1(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UtilitySourceCount',COUNT(__d1(__NL(Utility_Source_Count_))),COUNT(__d1(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleSourceCount',COUNT(__d1(__NL(Vehicle_Source_Count_))),COUNT(__d1(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DLSourceCount',COUNT(__d1(__NL(D_L_Source_Count_))),COUNT(__d1(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VoterSourceCount',COUNT(__d1(__NL(Voter_Source_Count_))),COUNT(__d1(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressType',COUNT(__d1(__NL(Address_Type_))),COUNT(__d1(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d2(__NL(Location_))),COUNT(__d2(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip5',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressRank',COUNT(__d2(__NL(Address_Rank_))),COUNT(__d2(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InsuranceSourceCount',COUNT(__d2(__NL(Insurance_Source_Count_))),COUNT(__d2(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertySourceCount',COUNT(__d2(__NL(Property_Source_Count_))),COUNT(__d2(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UtilitySourceCount',COUNT(__d2(__NL(Utility_Source_Count_))),COUNT(__d2(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleSourceCount',COUNT(__d2(__NL(Vehicle_Source_Count_))),COUNT(__d2(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DLSourceCount',COUNT(__d2(__NL(D_L_Source_Count_))),COUNT(__d2(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VoterSourceCount',COUNT(__d2(__NL(Voter_Source_Count_))),COUNT(__d2(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressType',COUNT(__d2(__NL(Address_Type_))),COUNT(__d2(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d3(__NL(Location_))),COUNT(__d3(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressRank',COUNT(__d3(__NL(Address_Rank_))),COUNT(__d3(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InsuranceSourceCount',COUNT(__d3(__NL(Insurance_Source_Count_))),COUNT(__d3(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertySourceCount',COUNT(__d3(__NL(Property_Source_Count_))),COUNT(__d3(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UtilitySourceCount',COUNT(__d3(__NL(Utility_Source_Count_))),COUNT(__d3(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleSourceCount',COUNT(__d3(__NL(Vehicle_Source_Count_))),COUNT(__d3(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DLSourceCount',COUNT(__d3(__NL(D_L_Source_Count_))),COUNT(__d3(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VoterSourceCount',COUNT(__d3(__NL(Voter_Source_Count_))),COUNT(__d3(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressType',COUNT(__d3(__NL(Address_Type_))),COUNT(__d3(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;

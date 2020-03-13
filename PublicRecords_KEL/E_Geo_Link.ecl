//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT E_Geo_Link(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Geo_Link_;
    KEL.typ.nbool Is_Latest_;
    KEL.typ.nfloat Geo_Percent_White_;
    KEL.typ.nfloat Geo_Percent_Black_;
    KEL.typ.nfloat Geo_Percent_American_Indian_Alaska_Native_;
    KEL.typ.nfloat Geo_Percent_Asian_Pacific_Islander_;
    KEL.typ.nfloat Geo_Percent_Multiracial_;
    KEL.typ.nfloat Geo_Percent_Hispanic_;
    KEL.typ.nfloat Here_;
    KEL.typ.nfloat Here_Given_White_;
    KEL.typ.nfloat Here_Given_Black_;
    KEL.typ.nfloat Here_Given_American_Indian_Alaska_Native_;
    KEL.typ.nfloat Here_Given_Asian_Pacific_Islander_;
    KEL.typ.nfloat Here_Given_Multiracial_;
    KEL.typ.nfloat Here_Given_Hispanic_;
    KEL.typ.nstr State_Fips10_;
    KEL.typ.nstr County_Fips10_;
    KEL.typ.nstr Tract_Fips10_;
    KEL.typ.nint Block_Group_Fips10_;
    KEL.typ.nint Total_Population_;
    KEL.typ.nint Hispanic_Total_;
    KEL.typ.nint Non_Hispanic_Total_;
    KEL.typ.nint Non_Hispanic_White_Alone_;
    KEL.typ.nint Non_Hispanic_Black_Alone_;
    KEL.typ.nint Non_Hispanic_American_Indian_Alaska_Native_Alone_;
    KEL.typ.nint Non_Hispanic_Asian_Pacific_Islander_Alone_;
    KEL.typ.nint Non_Hispanic_Other_Alone_;
    KEL.typ.nint Non_Hispanic_Multiracial_Alone_;
    KEL.typ.nint Non_Hispanic_White_Other_;
    KEL.typ.nint Non_Hispanic_Black_Other_;
    KEL.typ.nint Non_Hispanic_American_Indian_Alaska_Native_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Pacific_Islander_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),geolink(DEFAULT:Geo_Link_:\'\'),islatest(DEFAULT:Is_Latest_),geopercentwhite(DEFAULT:Geo_Percent_White_:0.0),geopercentblack(DEFAULT:Geo_Percent_Black_:0.0),geopercentamericanindianalaskanative(DEFAULT:Geo_Percent_American_Indian_Alaska_Native_:0.0),geopercentasianpacificislander(DEFAULT:Geo_Percent_Asian_Pacific_Islander_:0.0),geopercentmultiracial(DEFAULT:Geo_Percent_Multiracial_:0.0),geopercenthispanic(DEFAULT:Geo_Percent_Hispanic_:0.0),here(DEFAULT:Here_:0.0),heregivenwhite(DEFAULT:Here_Given_White_:0.0),heregivenblack(DEFAULT:Here_Given_Black_:0.0),heregivenamericanindianalaskanative(DEFAULT:Here_Given_American_Indian_Alaska_Native_:0.0),heregivenasianpacificislander(DEFAULT:Here_Given_Asian_Pacific_Islander_:0.0),heregivenmultiracial(DEFAULT:Here_Given_Multiracial_:0.0),heregivenhispanic(DEFAULT:Here_Given_Hispanic_:0.0),statefips10(DEFAULT:State_Fips10_:\'\'),countyfips10(DEFAULT:County_Fips10_:\'\'),tractfips10(DEFAULT:Tract_Fips10_:\'\'),blockgroupfips10(DEFAULT:Block_Group_Fips10_:0),totalpopulation(DEFAULT:Total_Population_:0),hispanictotal(DEFAULT:Hispanic_Total_:0),nonhispanictotal(DEFAULT:Non_Hispanic_Total_:0),nonhispanicwhitealone(DEFAULT:Non_Hispanic_White_Alone_:0),nonhispanicblackalone(DEFAULT:Non_Hispanic_Black_Alone_:0),nonhispanicamericanindianalaskanativealone(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nonhispanicasianpacificislanderalone(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nonhispanicotheralone(DEFAULT:Non_Hispanic_Other_Alone_:0),nonhispanicmultiracialalone(DEFAULT:Non_Hispanic_Multiracial_Alone_:0),nonhispanicwhiteother(DEFAULT:Non_Hispanic_White_Other_:0),nonhispanicblackother(DEFAULT:Non_Hispanic_Black_Other_:0),nonhispanicamericanindianalaskanativeother(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nonhispanicasianother(DEFAULT:Non_Hispanic_Asian_Other_:0),nonhispanicasianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nonhispanicasianhawaiianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_ADVO__Key_Addr1_History,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.Geo_Link)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(DEFAULT:UID),geo_link(OVERRIDE:Geo_Link_:\'\'),islatest(DEFAULT:Is_Latest_),geopercentwhite(DEFAULT:Geo_Percent_White_:0.0),geopercentblack(DEFAULT:Geo_Percent_Black_:0.0),geopercentamericanindianalaskanative(DEFAULT:Geo_Percent_American_Indian_Alaska_Native_:0.0),geopercentasianpacificislander(DEFAULT:Geo_Percent_Asian_Pacific_Islander_:0.0),geopercentmultiracial(DEFAULT:Geo_Percent_Multiracial_:0.0),geopercenthispanic(DEFAULT:Geo_Percent_Hispanic_:0.0),here(DEFAULT:Here_:0.0),heregivenwhite(DEFAULT:Here_Given_White_:0.0),heregivenblack(DEFAULT:Here_Given_Black_:0.0),heregivenamericanindianalaskanative(DEFAULT:Here_Given_American_Indian_Alaska_Native_:0.0),heregivenasianpacificislander(DEFAULT:Here_Given_Asian_Pacific_Islander_:0.0),heregivenmultiracial(DEFAULT:Here_Given_Multiracial_:0.0),heregivenhispanic(DEFAULT:Here_Given_Hispanic_:0.0),statefips10(DEFAULT:State_Fips10_:\'\'),countyfips10(DEFAULT:County_Fips10_:\'\'),tractfips10(DEFAULT:Tract_Fips10_:\'\'),blockgroupfips10(DEFAULT:Block_Group_Fips10_:0),totalpopulation(DEFAULT:Total_Population_:0),hispanictotal(DEFAULT:Hispanic_Total_:0),nonhispanictotal(DEFAULT:Non_Hispanic_Total_:0),nonhispanicwhitealone(DEFAULT:Non_Hispanic_White_Alone_:0),nonhispanicblackalone(DEFAULT:Non_Hispanic_Black_Alone_:0),nonhispanicamericanindianalaskanativealone(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nonhispanicasianpacificislanderalone(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nonhispanicotheralone(DEFAULT:Non_Hispanic_Other_Alone_:0),nonhispanicmultiracialalone(DEFAULT:Non_Hispanic_Multiracial_Alone_:0),nonhispanicwhiteother(DEFAULT:Non_Hispanic_White_Other_:0),nonhispanicblackother(DEFAULT:Non_Hispanic_Black_Other_:0),nonhispanicamericanindianalaskanativeother(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nonhispanicasianother(DEFAULT:Non_Hispanic_Asian_Other_:0),nonhispanicasianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nonhispanicasianhawaiianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_ADVO__Key_Addr1_History,TRANSFORM(RECORDOF(__in.Dataset_ADVO__Key_Addr1_History),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_ADVO__Key_Addr1_History);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.Geo_Link) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Block_Group_Layout := RECORD
    KEL.typ.nbool Is_Latest_;
    KEL.typ.nfloat Geo_Percent_White_;
    KEL.typ.nfloat Geo_Percent_Black_;
    KEL.typ.nfloat Geo_Percent_American_Indian_Alaska_Native_;
    KEL.typ.nfloat Geo_Percent_Asian_Pacific_Islander_;
    KEL.typ.nfloat Geo_Percent_Multiracial_;
    KEL.typ.nfloat Geo_Percent_Hispanic_;
    KEL.typ.nfloat Here_;
    KEL.typ.nfloat Here_Given_White_;
    KEL.typ.nfloat Here_Given_Black_;
    KEL.typ.nfloat Here_Given_American_Indian_Alaska_Native_;
    KEL.typ.nfloat Here_Given_Asian_Pacific_Islander_;
    KEL.typ.nfloat Here_Given_Multiracial_;
    KEL.typ.nfloat Here_Given_Hispanic_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Block_Group_Over18_Layout := RECORD
    KEL.typ.nbool Is_Latest_;
    KEL.typ.nstr State_Fips10_;
    KEL.typ.nstr County_Fips10_;
    KEL.typ.nstr Tract_Fips10_;
    KEL.typ.nint Block_Group_Fips10_;
    KEL.typ.nint Total_Population_;
    KEL.typ.nint Hispanic_Total_;
    KEL.typ.nint Non_Hispanic_Total_;
    KEL.typ.nint Non_Hispanic_White_Alone_;
    KEL.typ.nint Non_Hispanic_Black_Alone_;
    KEL.typ.nint Non_Hispanic_American_Indian_Alaska_Native_Alone_;
    KEL.typ.nint Non_Hispanic_Asian_Pacific_Islander_Alone_;
    KEL.typ.nint Non_Hispanic_Other_Alone_;
    KEL.typ.nint Non_Hispanic_Multiracial_Alone_;
    KEL.typ.nint Non_Hispanic_White_Other_;
    KEL.typ.nint Non_Hispanic_Black_Other_;
    KEL.typ.nint Non_Hispanic_American_Indian_Alaska_Native_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Pacific_Islander_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Geo_Link_;
    KEL.typ.ndataset(Block_Group_Layout) Block_Group_;
    KEL.typ.ndataset(Block_Group_Over18_Layout) Block_Group_Over18_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Geo_Link_Group := __PostFilter;
  Layout Geo_Link__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Geo_Link_ := KEL.Intake.SingleValue(__recs,Geo_Link_);
    SELF.Block_Group_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Is_Latest_,Geo_Percent_White_,Geo_Percent_Black_,Geo_Percent_American_Indian_Alaska_Native_,Geo_Percent_Asian_Pacific_Islander_,Geo_Percent_Multiracial_,Geo_Percent_Hispanic_,Here_,Here_Given_White_,Here_Given_Black_,Here_Given_American_Indian_Alaska_Native_,Here_Given_Asian_Pacific_Islander_,Here_Given_Multiracial_,Here_Given_Hispanic_},Is_Latest_,Geo_Percent_White_,Geo_Percent_Black_,Geo_Percent_American_Indian_Alaska_Native_,Geo_Percent_Asian_Pacific_Islander_,Geo_Percent_Multiracial_,Geo_Percent_Hispanic_,Here_,Here_Given_White_,Here_Given_Black_,Here_Given_American_Indian_Alaska_Native_,Here_Given_Asian_Pacific_Islander_,Here_Given_Multiracial_,Here_Given_Hispanic_),Block_Group_Layout)(__NN(Is_Latest_) OR __NN(Geo_Percent_White_) OR __NN(Geo_Percent_Black_) OR __NN(Geo_Percent_American_Indian_Alaska_Native_) OR __NN(Geo_Percent_Asian_Pacific_Islander_) OR __NN(Geo_Percent_Multiracial_) OR __NN(Geo_Percent_Hispanic_) OR __NN(Here_) OR __NN(Here_Given_White_) OR __NN(Here_Given_Black_) OR __NN(Here_Given_American_Indian_Alaska_Native_) OR __NN(Here_Given_Asian_Pacific_Islander_) OR __NN(Here_Given_Multiracial_) OR __NN(Here_Given_Hispanic_)));
    SELF.Block_Group_Over18_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Is_Latest_,State_Fips10_,County_Fips10_,Tract_Fips10_,Block_Group_Fips10_,Total_Population_,Hispanic_Total_,Non_Hispanic_Total_,Non_Hispanic_White_Alone_,Non_Hispanic_Black_Alone_,Non_Hispanic_American_Indian_Alaska_Native_Alone_,Non_Hispanic_Asian_Pacific_Islander_Alone_,Non_Hispanic_Other_Alone_,Non_Hispanic_Multiracial_Alone_,Non_Hispanic_White_Other_,Non_Hispanic_Black_Other_,Non_Hispanic_American_Indian_Alaska_Native_Other_,Non_Hispanic_Asian_Other_,Non_Hispanic_Asian_Pacific_Islander_Other_,Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_},Is_Latest_,State_Fips10_,County_Fips10_,Tract_Fips10_,Block_Group_Fips10_,Total_Population_,Hispanic_Total_,Non_Hispanic_Total_,Non_Hispanic_White_Alone_,Non_Hispanic_Black_Alone_,Non_Hispanic_American_Indian_Alaska_Native_Alone_,Non_Hispanic_Asian_Pacific_Islander_Alone_,Non_Hispanic_Other_Alone_,Non_Hispanic_Multiracial_Alone_,Non_Hispanic_White_Other_,Non_Hispanic_Black_Other_,Non_Hispanic_American_Indian_Alaska_Native_Other_,Non_Hispanic_Asian_Other_,Non_Hispanic_Asian_Pacific_Islander_Other_,Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_),Block_Group_Over18_Layout)(__NN(Is_Latest_) OR __NN(State_Fips10_) OR __NN(County_Fips10_) OR __NN(Tract_Fips10_) OR __NN(Block_Group_Fips10_) OR __NN(Total_Population_) OR __NN(Hispanic_Total_) OR __NN(Non_Hispanic_Total_) OR __NN(Non_Hispanic_White_Alone_) OR __NN(Non_Hispanic_Black_Alone_) OR __NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_) OR __NN(Non_Hispanic_Asian_Pacific_Islander_Alone_) OR __NN(Non_Hispanic_Other_Alone_) OR __NN(Non_Hispanic_Multiracial_Alone_) OR __NN(Non_Hispanic_White_Other_) OR __NN(Non_Hispanic_Black_Other_) OR __NN(Non_Hispanic_American_Indian_Alaska_Native_Other_) OR __NN(Non_Hispanic_Asian_Other_) OR __NN(Non_Hispanic_Asian_Pacific_Islander_Other_) OR __NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Geo_Link__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Block_Group_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Block_Group_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Is_Latest_) OR __NN(Geo_Percent_White_) OR __NN(Geo_Percent_Black_) OR __NN(Geo_Percent_American_Indian_Alaska_Native_) OR __NN(Geo_Percent_Asian_Pacific_Islander_) OR __NN(Geo_Percent_Multiracial_) OR __NN(Geo_Percent_Hispanic_) OR __NN(Here_) OR __NN(Here_Given_White_) OR __NN(Here_Given_Black_) OR __NN(Here_Given_American_Indian_Alaska_Native_) OR __NN(Here_Given_Asian_Pacific_Islander_) OR __NN(Here_Given_Multiracial_) OR __NN(Here_Given_Hispanic_)));
    SELF.Block_Group_Over18_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Block_Group_Over18_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Is_Latest_) OR __NN(State_Fips10_) OR __NN(County_Fips10_) OR __NN(Tract_Fips10_) OR __NN(Block_Group_Fips10_) OR __NN(Total_Population_) OR __NN(Hispanic_Total_) OR __NN(Non_Hispanic_Total_) OR __NN(Non_Hispanic_White_Alone_) OR __NN(Non_Hispanic_Black_Alone_) OR __NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_) OR __NN(Non_Hispanic_Asian_Pacific_Islander_Alone_) OR __NN(Non_Hispanic_Other_Alone_) OR __NN(Non_Hispanic_Multiracial_Alone_) OR __NN(Non_Hispanic_White_Other_) OR __NN(Non_Hispanic_Black_Other_) OR __NN(Non_Hispanic_American_Indian_Alaska_Native_Other_) OR __NN(Non_Hispanic_Asian_Other_) OR __NN(Non_Hispanic_Asian_Pacific_Islander_Other_) OR __NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Geo_Link_Group,COUNT(ROWS(LEFT))=1),GROUP,Geo_Link__Single_Rollup(LEFT)) + ROLLUP(HAVING(Geo_Link_Group,COUNT(ROWS(LEFT))>1),GROUP,Geo_Link__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Geo_Link__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Geo_Link_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid),COUNT(Geo_Link__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid,KEL.typ.int Geo_Link__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid),COUNT(__d0)},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Geo_Link',COUNT(__d0(__NL(Geo_Link_))),COUNT(__d0(__NN(Geo_Link_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsLatest',COUNT(__d0(__NL(Is_Latest_))),COUNT(__d0(__NN(Is_Latest_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentWhite',COUNT(__d0(__NL(Geo_Percent_White_))),COUNT(__d0(__NN(Geo_Percent_White_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentBlack',COUNT(__d0(__NL(Geo_Percent_Black_))),COUNT(__d0(__NN(Geo_Percent_Black_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentAmericanIndianAlaskaNative',COUNT(__d0(__NL(Geo_Percent_American_Indian_Alaska_Native_))),COUNT(__d0(__NN(Geo_Percent_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentAsianPacificIslander',COUNT(__d0(__NL(Geo_Percent_Asian_Pacific_Islander_))),COUNT(__d0(__NN(Geo_Percent_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentMultiracial',COUNT(__d0(__NL(Geo_Percent_Multiracial_))),COUNT(__d0(__NN(Geo_Percent_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentHispanic',COUNT(__d0(__NL(Geo_Percent_Hispanic_))),COUNT(__d0(__NN(Geo_Percent_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Here',COUNT(__d0(__NL(Here_))),COUNT(__d0(__NN(Here_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenWhite',COUNT(__d0(__NL(Here_Given_White_))),COUNT(__d0(__NN(Here_Given_White_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenBlack',COUNT(__d0(__NL(Here_Given_Black_))),COUNT(__d0(__NN(Here_Given_Black_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenAmericanIndianAlaskaNative',COUNT(__d0(__NL(Here_Given_American_Indian_Alaska_Native_))),COUNT(__d0(__NN(Here_Given_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenAsianPacificIslander',COUNT(__d0(__NL(Here_Given_Asian_Pacific_Islander_))),COUNT(__d0(__NN(Here_Given_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenMultiracial',COUNT(__d0(__NL(Here_Given_Multiracial_))),COUNT(__d0(__NN(Here_Given_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenHispanic',COUNT(__d0(__NL(Here_Given_Hispanic_))),COUNT(__d0(__NN(Here_Given_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateFips10',COUNT(__d0(__NL(State_Fips10_))),COUNT(__d0(__NN(State_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyFips10',COUNT(__d0(__NL(County_Fips10_))),COUNT(__d0(__NN(County_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TractFips10',COUNT(__d0(__NL(Tract_Fips10_))),COUNT(__d0(__NN(Tract_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BlockGroupFips10',COUNT(__d0(__NL(Block_Group_Fips10_))),COUNT(__d0(__NN(Block_Group_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TotalPopulation',COUNT(__d0(__NL(Total_Population_))),COUNT(__d0(__NN(Total_Population_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HispanicTotal',COUNT(__d0(__NL(Hispanic_Total_))),COUNT(__d0(__NN(Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicTotal',COUNT(__d0(__NL(Non_Hispanic_Total_))),COUNT(__d0(__NN(Non_Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicWhiteAlone',COUNT(__d0(__NL(Non_Hispanic_White_Alone_))),COUNT(__d0(__NN(Non_Hispanic_White_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicBlackAlone',COUNT(__d0(__NL(Non_Hispanic_Black_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Black_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAmericanIndianAlaskaNativeAlone',COUNT(__d0(__NL(Non_Hispanic_American_Indian_Alaska_Native_Alone_))),COUNT(__d0(__NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianPacificIslanderAlone',COUNT(__d0(__NL(Non_Hispanic_Asian_Pacific_Islander_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Pacific_Islander_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicOtherAlone',COUNT(__d0(__NL(Non_Hispanic_Other_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Other_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicMultiracialAlone',COUNT(__d0(__NL(Non_Hispanic_Multiracial_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Multiracial_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicWhiteOther',COUNT(__d0(__NL(Non_Hispanic_White_Other_))),COUNT(__d0(__NN(Non_Hispanic_White_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicBlackOther',COUNT(__d0(__NL(Non_Hispanic_Black_Other_))),COUNT(__d0(__NN(Non_Hispanic_Black_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAmericanIndianAlaskaNativeOther',COUNT(__d0(__NL(Non_Hispanic_American_Indian_Alaska_Native_Other_))),COUNT(__d0(__NN(Non_Hispanic_American_Indian_Alaska_Native_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianOther',COUNT(__d0(__NL(Non_Hispanic_Asian_Other_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianPacificIslanderOther',COUNT(__d0(__NL(Non_Hispanic_Asian_Pacific_Islander_Other_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianHawaiianPacificIslanderOther',COUNT(__d0(__NL(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;

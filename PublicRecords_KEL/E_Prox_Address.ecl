//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Prox_Address(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Site_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr S_I_C_Code_;
    KEL.typ.nstr N_A_I_C_S_Code_;
    KEL.typ.nkdate Date_First_Seen_Company_Address_;
    KEL.typ.nkdate Date_Last_Seen_Company_Address_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Site_(Site_:0),Location_(Location_:0),primaryrange(Primary_Range_:\'\'),predirectional(Predirectional_:\'\'),primaryname(Primary_Name_:\'\'),suffix(Suffix_:\'\'),postdirectional(Postdirectional_:\'\'),secondaryrange(Secondary_Range_:\'\'),zip5(Z_I_P5_:0),siccode(S_I_C_Code_:\'\'),naicscode(N_A_I_C_S_Code_:\'\'),datefirstseencompanyaddress(Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(Date_Last_Seen_Company_Address_:DATE),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Site_(Site_:0),Location_(Location_:0),prim_range_derived(Primary_Range_:\'\'),predir(Predirectional_:\'\'),prim_name_derived(Primary_Name_:\'\'),addr_suffix(Suffix_:\'\'),postdir(Postdirectional_:\'\'),sec_range(Secondary_Range_:\'\'),zip(Z_I_P5_:0),siccode(S_I_C_Code_:\'\'),naicscode(N_A_I_C_S_Code_:\'\'),dt_first_seen_company_address(Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(Date_Last_Seen_Company_Address_:DATE),source(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_Ids),SELF:=RIGHT));
  SHARED __d0_Site__Layout := RECORD
    RECORDOF(__d0_Norm);
    KEL.typ.uid Site_;
  END;
  SHARED __d0_Site__Mapped := JOIN(__d0_Norm,E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d0_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_Site__Mapped,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT S_I_C_Codes_Layout := RECORD
    KEL.typ.nstr S_I_C_Code_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT N_A_I_C_S_Codes_Layout := RECORD
    KEL.typ.nstr N_A_I_C_S_Code_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Site_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ndataset(S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.nkdate Date_First_Seen_Company_Address_;
    KEL.typ.nkdate Date_Last_Seen_Company_Address_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Site_,Location_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,Date_First_Seen_Company_Address_,Date_Last_Seen_Company_Address_,ALL));
  Prox_Address_Group := __PostFilter;
  Layout Prox_Address__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.S_I_C_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),S_I_C_Code_,Source_},S_I_C_Code_,Source_),S_I_C_Codes_Layout)(__NN(S_I_C_Code_) OR __NN(Source_)));
    SELF.N_A_I_C_S_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),N_A_I_C_S_Code_,Source_},N_A_I_C_S_Code_,Source_),N_A_I_C_S_Codes_Layout)(__NN(N_A_I_C_S_Code_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Prox_Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.S_I_C_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_I_C_Codes_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(S_I_C_Code_) OR __NN(Source_)));
    SELF.N_A_I_C_S_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(N_A_I_C_S_Codes_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(N_A_I_C_S_Code_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Prox_Address_Group,COUNT(ROWS(LEFT))=1),GROUP,Prox_Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(Prox_Address_Group,COUNT(ROWS(LEFT))>1),GROUP,Prox_Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Site__Orphan := JOIN(InData(__NN(Site_)),E_Business_Prox(__in,__cfg).__Result,__EEQP(LEFT.Site_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Site__Orphan),COUNT(Location__Orphan),COUNT(Z_I_P5__Orphan)}],{KEL.typ.int Site__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Z_I_P5__Orphan});
  EXPORT NullCounts := DATASET([
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d0(__NL(Site_))),COUNT(__d0(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d0(__NL(S_I_C_Code_))),COUNT(__d0(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d0(__NL(N_A_I_C_S_Code_))),COUNT(__d0(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d0(__NL(Date_First_Seen_Company_Address_))),COUNT(__d0(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d0(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d0(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;

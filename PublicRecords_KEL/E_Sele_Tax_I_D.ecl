//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Tax_I_D_Number,E_Business_Ult FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Sele_Tax_I_D(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Business_Tax_I_D_Number().Typ) Company_Tax_Number_;
    KEL.typ.nint Best_Tax_Indicator_;
    KEL.typ.nstr Deleted_F_E_I_N_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Legal_(Legal_:0),Company_Tax_Number_(Company_Tax_Number_:0),besttaxindicator(Best_Tax_Indicator_:0),deletedfein(Deleted_F_E_I_N_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Legal_(Legal_:0),Company_Tax_Number_(Company_Tax_Number_:0),best_fein_indicator(Best_Tax_Indicator_:0),deleted_fein(Deleted_F_E_I_N_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_Ids),SELF:=RIGHT));
  SHARED __d0_Legal__Layout := RECORD
    RECORDOF(__d0_Norm);
    KEL.typ.uid Legal_;
  END;
  SHARED __d0_Legal__Mapped := JOIN(__d0_Norm,E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Company_Tax_Number__Layout := RECORD
    RECORDOF(__d0_Legal__Mapped);
    KEL.typ.uid Company_Tax_Number_;
  END;
  SHARED __d0_Company_Tax_Number__Mapped := JOIN(__d0_Legal__Mapped,E_Business_Tax_I_D_Number(__in,__cfg).Lookup,TRIM((STRING)LEFT.company_fein) = RIGHT.KeyVal,TRANSFORM(__d0_Company_Tax_Number__Layout,SELF.Company_Tax_Number_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Company_Tax_Number__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Business_Tax_I_D_Number().Typ) Company_Tax_Number_;
    KEL.typ.nint Best_Tax_Indicator_;
    KEL.typ.nstr Deleted_F_E_I_N_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Legal_,Company_Tax_Number_,Best_Tax_Indicator_,Deleted_F_E_I_N_,ALL));
  Sele_Tax_I_D_Group := __PostFilter;
  Layout Sele_Tax_I_D__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Sele_Tax_I_D__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Sele_Tax_I_D_Group,COUNT(ROWS(LEFT))=1),GROUP,Sele_Tax_I_D__Single_Rollup(LEFT)) + ROLLUP(HAVING(Sele_Tax_I_D_Group,COUNT(ROWS(LEFT))>1),GROUP,Sele_Tax_I_D__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Legal__Orphan := JOIN(InData(__NN(Legal_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Legal_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Company_Tax_Number__Orphan := JOIN(InData(__NN(Company_Tax_Number_)),E_Business_Tax_I_D_Number(__in,__cfg).__Result,__EEQP(LEFT.Company_Tax_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Legal__Orphan),COUNT(Company_Tax_Number__Orphan)}],{KEL.typ.int Legal__Orphan,KEL.typ.int Company_Tax_Number__Orphan});
  EXPORT NullCounts := DATASET([
    {'SeleTaxID','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d0(__NL(Legal_))),COUNT(__d0(__NN(Legal_)))},
    {'SeleTaxID','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyTaxNumber',COUNT(__d0(__NL(Company_Tax_Number_))),COUNT(__d0(__NN(Company_Tax_Number_)))},
    {'SeleTaxID','PublicRecords_KEL.ECL_Functions.Dataset_FDC','best_fein_indicator',COUNT(__d0(__NL(Best_Tax_Indicator_))),COUNT(__d0(__NN(Best_Tax_Indicator_)))},
    {'SeleTaxID','PublicRecords_KEL.ECL_Functions.Dataset_FDC','deleted_fein',COUNT(__d0(__NL(Deleted_F_E_I_N_))),COUNT(__d0(__NN(Deleted_F_E_I_N_)))},
    {'SeleTaxID','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SeleTaxID','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SeleTaxID','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;

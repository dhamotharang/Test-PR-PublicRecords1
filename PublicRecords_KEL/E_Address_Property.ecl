//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Property,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Address_Property(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Property().Typ) Transaction_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nbool Is_Owner_Address_;
    KEL.typ.nbool Is_Seller_Address_;
    KEL.typ.nbool Is_Property_Address_;
    KEL.typ.nbool Is_Borrower_Address_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Transaction_(Transaction_:0),Location_(Location_:0),isowneraddress(Is_Owner_Address_),isselleraddress(Is_Seller_Address_),ispropertyaddress(Is_Property_Address_),isborroweraddress(Is_Borrower_Address_),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Transaction__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d0_Transaction__Mapped := JOIN(__in,E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.LnFaresId) = RIGHT.KeyVal,TRANSFORM(__d0_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Transaction__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_Transaction__Mapped,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Property().Typ) Transaction_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nbool Is_Owner_Address_;
    KEL.typ.nbool Is_Seller_Address_;
    KEL.typ.nbool Is_Property_Address_;
    KEL.typ.nbool Is_Borrower_Address_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Transaction_,Location_,Is_Owner_Address_,Is_Seller_Address_,Is_Property_Address_,Is_Borrower_Address_,ALL));
  Address_Property_Group := __PostFilter;
  Layout Address_Property__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Address_Property__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Address_Property_Group,COUNT(ROWS(LEFT))=1),GROUP,Address_Property__Single_Rollup(LEFT)) + ROLLUP(HAVING(Address_Property_Group,COUNT(ROWS(LEFT))>1),GROUP,Address_Property__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Transaction__Orphan := JOIN(InData(__NN(Transaction_)),E_Property(__in,__cfg).__Result,__EEQP(LEFT.Transaction_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Transaction__Orphan),COUNT(Location__Orphan)}],{KEL.typ.int Transaction__Orphan,KEL.typ.int Location__Orphan});
  EXPORT NullCounts := DATASET([
    {'AddressProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Transaction',COUNT(__d0(__NL(Transaction_))),COUNT(__d0(__NN(Transaction_)))},
    {'AddressProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'AddressProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsOwnerAddress',COUNT(__d0(__NL(Is_Owner_Address_))),COUNT(__d0(__NN(Is_Owner_Address_)))},
    {'AddressProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSellerAddress',COUNT(__d0(__NL(Is_Seller_Address_))),COUNT(__d0(__NN(Is_Seller_Address_)))},
    {'AddressProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPropertyAddress',COUNT(__d0(__NL(Is_Property_Address_))),COUNT(__d0(__NN(Is_Property_Address_)))},
    {'AddressProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsBorrowerAddress',COUNT(__d0(__NL(Is_Borrower_Address_))),COUNT(__d0(__NN(Is_Borrower_Address_)))},
    {'AddressProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'AddressProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'AddressProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;

//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Property FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Property(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property().Typ) Transaction_;
    KEL.typ.nkdate Purchase_Date_By_Subject_;
    KEL.typ.nkdate Sale_Date_By_Subject_;
    KEL.typ.nbool Is_Buyer_Or_Owner_;
    KEL.typ.nbool Is_Seller_;
    KEL.typ.nbool Is_Borrower_;
    KEL.typ.nbool Is_Care_Of_;
    KEL.typ.nint Person_Number_;
    KEL.typ.nint Conjunctive_Name_Sequence_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(Subject_:0),Transaction_(Transaction_:0),purchasedatebysubject(Purchase_Date_By_Subject_:DATE),saledatebysubject(Sale_Date_By_Subject_:DATE),isbuyerorowner(Is_Buyer_Or_Owner_),isseller(Is_Seller_),isborrower(Is_Borrower_),iscareof(Is_Care_Of_),personnumber(Person_Number_:0),conjunctivenamesequence(Conjunctive_Name_Sequence_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Transaction__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d0_Transaction__Mapped := JOIN(__in,E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.LnFaresId) = RIGHT.KeyVal,TRANSFORM(__d0_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Transaction__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property().Typ) Transaction_;
    KEL.typ.nkdate Purchase_Date_By_Subject_;
    KEL.typ.nkdate Sale_Date_By_Subject_;
    KEL.typ.nbool Is_Buyer_Or_Owner_;
    KEL.typ.nbool Is_Seller_;
    KEL.typ.nbool Is_Borrower_;
    KEL.typ.nbool Is_Care_Of_;
    KEL.typ.nint Person_Number_;
    KEL.typ.nint Conjunctive_Name_Sequence_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Transaction_,Purchase_Date_By_Subject_,Sale_Date_By_Subject_,Is_Buyer_Or_Owner_,Is_Seller_,Is_Borrower_,Is_Care_Of_,Person_Number_,Conjunctive_Name_Sequence_,ALL));
  Person_Property_Group := __PostFilter;
  Layout Person_Property__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Property__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Property_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Property__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Property_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Property__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Person_Property::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Transaction__Orphan := JOIN(InData(__NN(Transaction_)),E_Property(__in,__cfg).__Result,__EEQP(LEFT.Transaction_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Transaction__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Transaction__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Transaction',COUNT(__d0(__NL(Transaction_))),COUNT(__d0(__NN(Transaction_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchaseDateBySubject',COUNT(__d0(__NL(Purchase_Date_By_Subject_))),COUNT(__d0(__NN(Purchase_Date_By_Subject_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SaleDateBySubject',COUNT(__d0(__NL(Sale_Date_By_Subject_))),COUNT(__d0(__NN(Sale_Date_By_Subject_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsBuyerOrOwner',COUNT(__d0(__NL(Is_Buyer_Or_Owner_))),COUNT(__d0(__NN(Is_Buyer_Or_Owner_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeller',COUNT(__d0(__NL(Is_Seller_))),COUNT(__d0(__NN(Is_Seller_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsBorrower',COUNT(__d0(__NL(Is_Borrower_))),COUNT(__d0(__NN(Is_Borrower_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCareOf',COUNT(__d0(__NL(Is_Care_Of_))),COUNT(__d0(__NN(Is_Care_Of_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersonNumber',COUNT(__d0(__NL(Person_Number_))),COUNT(__d0(__NN(Person_Number_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConjunctiveNameSequence',COUNT(__d0(__NL(Conjunctive_Name_Sequence_))),COUNT(__d0(__NN(Conjunctive_Name_Sequence_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonProperty','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;

//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Person_Property_Event(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nint Person_Number_;
    KEL.typ.nint Conjunctive_Name_Sequence_;
    KEL.typ.nbool Party_Is_Buyer_Or_Owner_;
    KEL.typ.nbool Party_Is_Borrower_;
    KEL.typ.nbool Party_Is_Seller_;
    KEL.typ.nbool Party_Is_Care_Of_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Vendor_Source_Code_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),Event_(DEFAULT:Event_:0),lnfaresid(DEFAULT:L_N_Fares_I_D_:\'\'),personnumber(DEFAULT:Person_Number_:0),conjunctivenamesequence(DEFAULT:Conjunctive_Name_Sequence_:0),partyisbuyerorowner(DEFAULT:Party_Is_Buyer_Or_Owner_),partyisborrower(DEFAULT:Party_Is_Borrower_),partyisseller(DEFAULT:Party_Is_Seller_),partyiscareof(DEFAULT:Party_Is_Care_Of_),processdate(DEFAULT:Process_Date_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),vendorsourcecode(DEFAULT:Vendor_Source_Code_:\'\'),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __d0_Event__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Event_;
  END;
  SHARED __d0_Event__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__in,'LNFaresID','__in'),E_Property_Event(__in,__cfg).Lookup,TRIM((STRING)LEFT.LNFaresID) = RIGHT.KeyVal,TRANSFORM(__d0_Event__Layout,SELF.Event_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Event__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nint Person_Number_;
    KEL.typ.nint Conjunctive_Name_Sequence_;
    KEL.typ.nbool Party_Is_Buyer_Or_Owner_;
    KEL.typ.nbool Party_Is_Borrower_;
    KEL.typ.nbool Party_Is_Seller_;
    KEL.typ.nbool Party_Is_Care_Of_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Vendor_Source_Code_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Event_,L_N_Fares_I_D_,Person_Number_,Conjunctive_Name_Sequence_,Party_Is_Buyer_Or_Owner_,Party_Is_Borrower_,Party_Is_Seller_,Party_Is_Care_Of_,Process_Date_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Vendor_Source_Code_,ALL));
  Person_Property_Event_Group := __PostFilter;
  Layout Person_Property_Event__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Property_Event__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Property_Event_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Property_Event__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Property_Event_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Property_Event__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Event__Orphan := JOIN(InData(__NN(Event_)),E_Property_Event(__in,__cfg).__Result,__EEQP(LEFT.Event_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Event__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Event__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Event',COUNT(__d0(__NL(Event_))),COUNT(__d0(__NN(Event_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNFaresID',COUNT(__d0(__NL(L_N_Fares_I_D_))),COUNT(__d0(__NN(L_N_Fares_I_D_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersonNumber',COUNT(__d0(__NL(Person_Number_))),COUNT(__d0(__NN(Person_Number_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConjunctiveNameSequence',COUNT(__d0(__NL(Conjunctive_Name_Sequence_))),COUNT(__d0(__NN(Conjunctive_Name_Sequence_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PartyIsBuyerOrOwner',COUNT(__d0(__NL(Party_Is_Buyer_Or_Owner_))),COUNT(__d0(__NN(Party_Is_Buyer_Or_Owner_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PartyIsBorrower',COUNT(__d0(__NL(Party_Is_Borrower_))),COUNT(__d0(__NN(Party_Is_Borrower_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PartyIsSeller',COUNT(__d0(__NL(Party_Is_Seller_))),COUNT(__d0(__NN(Party_Is_Seller_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PartyIsCareOf',COUNT(__d0(__NL(Party_Is_Care_Of_))),COUNT(__d0(__NN(Party_Is_Care_Of_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VendorSourceCode',COUNT(__d0(__NL(Vendor_Source_Code_))),COUNT(__d0(__NN(Vendor_Source_Code_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;

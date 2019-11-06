//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Sele_Property_Event(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
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
  SHARED __Mapping := 'Legal_(DEFAULT:Legal_:0),Event_(DEFAULT:Event_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),lnfaresid(DEFAULT:L_N_Fares_I_D_:\'\'),personnumber(DEFAULT:Person_Number_:0),conjunctivenamesequence(DEFAULT:Conjunctive_Name_Sequence_:0),partyisbuyerorowner(DEFAULT:Party_Is_Buyer_Or_Owner_),partyisborrower(DEFAULT:Party_Is_Borrower_),partyisseller(DEFAULT:Party_Is_Seller_),partyiscareof(DEFAULT:Party_Is_Care_Of_),processdate(DEFAULT:Process_Date_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),vendorsourcecode(DEFAULT:Vendor_Source_Code_:\'\'),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED Date_Vendor_First_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'Legal_(DEFAULT:Legal_:0),Event_(DEFAULT:Event_:0),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),which_orig(OVERRIDE:Person_Number_:0),conjunctive_name_seq(OVERRIDE:Conjunctive_Name_Sequence_:0),partyisbuyerorowner(OVERRIDE:Party_Is_Buyer_Or_Owner_),partyisborrower(OVERRIDE:Party_Is_Borrower_),partyisseller(OVERRIDE:Party_Is_Seller_),partyiscareof(OVERRIDE:Party_Is_Care_Of_),process_date(OVERRIDE:Process_Date_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE:Date_Vendor_First_Reported_0Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE:Date_Vendor_Last_Reported_0Rule),vendor_source_flag(OVERRIDE:Vendor_Source_Code_:\'\'),src(OVERRIDE:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_PropertyV2__Key_Search_Fid,TRANSFORM(RECORDOF(__in.Dataset_PropertyV2__Key_Search_Fid),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm(ultid != 0 AND orgid != 0 AND seleid != 0 AND ln_fares_id != '');
  SHARED __d0_Legal__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d0_Legal__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_KELfiltered,'ultid,orgid,seleid','__in'),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Event__Layout := RECORD
    RECORDOF(__d0_Legal__Mapped);
    KEL.typ.uid Event_;
  END;
  SHARED __d0_Event__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_Legal__Mapped,'ln_fares_id','__in'),E_Property_Event(__in,__cfg).Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d0_Event__Layout,SELF.Event_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Event__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Party_Details_Layout := RECORD
    KEL.typ.nint Person_Number_;
    KEL.typ.nint Conjunctive_Name_Sequence_;
    KEL.typ.nbool Party_Is_Buyer_Or_Owner_;
    KEL.typ.nbool Party_Is_Borrower_;
    KEL.typ.nbool Party_Is_Seller_;
    KEL.typ.nbool Party_Is_Care_Of_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Dates_Layout := RECORD
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Vendor_Source_Code_;
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
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.ndataset(Party_Details_Layout) Party_Details_;
    KEL.typ.ndataset(Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Legal_,Event_,Ult_I_D_,Org_I_D_,Sele_I_D_,L_N_Fares_I_D_,ALL));
  Sele_Property_Event_Group := __PostFilter;
  Layout Sele_Property_Event__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Party_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Person_Number_,Conjunctive_Name_Sequence_,Party_Is_Buyer_Or_Owner_,Party_Is_Borrower_,Party_Is_Seller_,Party_Is_Care_Of_},Person_Number_,Conjunctive_Name_Sequence_,Party_Is_Buyer_Or_Owner_,Party_Is_Borrower_,Party_Is_Seller_,Party_Is_Care_Of_),Party_Details_Layout)(__NN(Person_Number_) OR __NN(Conjunctive_Name_Sequence_) OR __NN(Party_Is_Buyer_Or_Owner_) OR __NN(Party_Is_Borrower_) OR __NN(Party_Is_Seller_) OR __NN(Party_Is_Care_Of_)));
    SELF.Reported_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Process_Date_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Vendor_Source_Code_},Process_Date_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Vendor_Source_Code_),Reported_Dates_Layout)(__NN(Process_Date_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Vendor_Source_Code_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Sele_Property_Event__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Party_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Party_Details_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Person_Number_) OR __NN(Conjunctive_Name_Sequence_) OR __NN(Party_Is_Buyer_Or_Owner_) OR __NN(Party_Is_Borrower_) OR __NN(Party_Is_Seller_) OR __NN(Party_Is_Care_Of_)));
    SELF.Reported_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Dates_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Process_Date_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Vendor_Source_Code_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Sele_Property_Event_Group,COUNT(ROWS(LEFT))=1),GROUP,Sele_Property_Event__Single_Rollup(LEFT)) + ROLLUP(HAVING(Sele_Property_Event_Group,COUNT(ROWS(LEFT))>1),GROUP,Sele_Property_Event__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Legal__Orphan := JOIN(InData(__NN(Legal_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Legal_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Event__Orphan := JOIN(InData(__NN(Event_)),E_Property_Event(__in,__cfg).__Result,__EEQP(LEFT.Event_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Legal__Orphan),COUNT(Event__Orphan)}],{KEL.typ.int Legal__Orphan,KEL.typ.int Event__Orphan});
  EXPORT NullCounts := DATASET([
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d0(__NL(Legal_))),COUNT(__d0(__NN(Legal_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Event',COUNT(__d0(__NL(Event_))),COUNT(__d0(__NN(Event_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_fares_id',COUNT(__d0(__NL(L_N_Fares_I_D_))),COUNT(__d0(__NN(L_N_Fares_I_D_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','which_orig',COUNT(__d0(__NL(Person_Number_))),COUNT(__d0(__NN(Person_Number_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','conjunctive_name_seq',COUNT(__d0(__NL(Conjunctive_Name_Sequence_))),COUNT(__d0(__NN(Conjunctive_Name_Sequence_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','partyisbuyerorowner',COUNT(__d0(__NL(Party_Is_Buyer_Or_Owner_))),COUNT(__d0(__NN(Party_Is_Buyer_Or_Owner_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','partyisborrower',COUNT(__d0(__NL(Party_Is_Borrower_))),COUNT(__d0(__NN(Party_Is_Borrower_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','partyisseller',COUNT(__d0(__NL(Party_Is_Seller_))),COUNT(__d0(__NN(Party_Is_Seller_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','partyiscareof',COUNT(__d0(__NL(Party_Is_Care_Of_))),COUNT(__d0(__NN(Party_Is_Care_Of_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','process_date',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_source_flag',COUNT(__d0(__NL(Vendor_Source_Code_))),COUNT(__d0(__NN(Vendor_Source_Code_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SelePropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;

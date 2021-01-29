﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Person_Property_Event(CFG_Compile __cfg = CFG_Compile) := MODULE
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
    KEL.typ.nstr Vendor_Source_Code_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),Event_(DEFAULT:Event_:0),lnfaresid(DEFAULT:L_N_Fares_I_D_:\'\'),personnumber(DEFAULT:Person_Number_:0),conjunctivenamesequence(DEFAULT:Conjunctive_Name_Sequence_:0),partyisbuyerorowner(DEFAULT:Party_Is_Buyer_Or_Owner_),partyisborrower(DEFAULT:Party_Is_Borrower_),partyisseller(DEFAULT:Party_Is_Seller_),partyiscareof(DEFAULT:Party_Is_Care_Of_),vendorsourcecode(DEFAULT:Vendor_Source_Code_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'did(OVERRIDE:Subject_:0),Event_(DEFAULT:Event_:0),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),which_orig(OVERRIDE:Person_Number_:0),conjunctive_name_seq(OVERRIDE:Conjunctive_Name_Sequence_:0),partyisbuyerorowner(OVERRIDE:Party_Is_Buyer_Or_Owner_),partyisborrower(OVERRIDE:Party_Is_Borrower_),partyisseller(OVERRIDE:Party_Is_Seller_),partyiscareof(OVERRIDE:Party_Is_Care_Of_),vendor_source_flag(OVERRIDE:Vendor_Source_Code_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault(did != 0 AND ln_fares_id != '');
  SHARED __d0_Event__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Event_;
  END;
  SHARED __d0_Missing_Event__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'ln_fares_id','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault');
  SHARED __d0_Event__Mapped := IF(__d0_Missing_Event__UIDComponents = 'ln_fares_id',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Event__Layout,SELF.Event_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Event__UIDComponents),E_Property_Event(__cfg).Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d0_Event__Layout,SELF.Event_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Event__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault'));
  SHARED __Mapping1 := 'did(OVERRIDE:Subject_:0),Event_(DEFAULT:Event_:0),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),which_orig(OVERRIDE:Person_Number_:0),conjunctive_name_seq(OVERRIDE:Conjunctive_Name_Sequence_:0),partyisbuyerorowner(OVERRIDE:Party_Is_Buyer_Or_Owner_),partyisborrower(OVERRIDE:Party_Is_Borrower_),partyisseller(OVERRIDE:Party_Is_Seller_),partyiscareof(OVERRIDE:Party_Is_Care_Of_),vendor_source_flag(OVERRIDE:Vendor_Source_Code_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault(did != 0 AND ln_fares_id != '');
  SHARED __d1_Event__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Event_;
  END;
  SHARED __d1_Missing_Event__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'ln_fares_id','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault');
  SHARED __d1_Event__Mapped := IF(__d1_Missing_Event__UIDComponents = 'ln_fares_id',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Event__Layout,SELF.Event_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Event__UIDComponents),E_Property_Event(__cfg).Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d1_Event__Layout,SELF.Event_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Event__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault'));
  EXPORT InData := __d0 + __d1;
  EXPORT Party_Details_Layout := RECORD
    KEL.typ.nint Person_Number_;
    KEL.typ.nint Conjunctive_Name_Sequence_;
    KEL.typ.nbool Party_Is_Buyer_Or_Owner_;
    KEL.typ.nbool Party_Is_Borrower_;
    KEL.typ.nbool Party_Is_Seller_;
    KEL.typ.nbool Party_Is_Care_Of_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Dates_Layout := RECORD
    KEL.typ.nstr Vendor_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.ndataset(Party_Details_Layout) Party_Details_;
    KEL.typ.ndataset(Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Event_,L_N_Fares_I_D_,ALL));
  Person_Property_Event_Group := __PostFilter;
  Layout Person_Property_Event__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Party_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Person_Number_,Conjunctive_Name_Sequence_,Party_Is_Buyer_Or_Owner_,Party_Is_Borrower_,Party_Is_Seller_,Party_Is_Care_Of_},Person_Number_,Conjunctive_Name_Sequence_,Party_Is_Buyer_Or_Owner_,Party_Is_Borrower_,Party_Is_Seller_,Party_Is_Care_Of_),Party_Details_Layout)(__NN(Person_Number_) OR __NN(Conjunctive_Name_Sequence_) OR __NN(Party_Is_Buyer_Or_Owner_) OR __NN(Party_Is_Borrower_) OR __NN(Party_Is_Seller_) OR __NN(Party_Is_Care_Of_)));
    SELF.Reported_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Vendor_Source_Code_},Vendor_Source_Code_),Reported_Dates_Layout)(__NN(Vendor_Source_Code_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Person_Property_Event__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Party_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Party_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Person_Number_) OR __NN(Conjunctive_Name_Sequence_) OR __NN(Party_Is_Buyer_Or_Owner_) OR __NN(Party_Is_Borrower_) OR __NN(Party_Is_Seller_) OR __NN(Party_Is_Care_Of_)));
    SELF.Reported_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Dates_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Vendor_Source_Code_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Property_Event_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Property_Event__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Property_Event_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Property_Event__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Event__Orphan := JOIN(InData(__NN(Event_)),E_Property_Event(__cfg).__Result,__EEQP(LEFT.Event_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Event__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Event__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','Event',COUNT(__d0(__NL(Event_))),COUNT(__d0(__NN(Event_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','ln_fares_id',COUNT(__d0(__NL(L_N_Fares_I_D_))),COUNT(__d0(__NN(L_N_Fares_I_D_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','which_orig',COUNT(__d0(__NL(Person_Number_))),COUNT(__d0(__NN(Person_Number_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','conjunctive_name_seq',COUNT(__d0(__NL(Conjunctive_Name_Sequence_))),COUNT(__d0(__NN(Conjunctive_Name_Sequence_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','partyisbuyerorowner',COUNT(__d0(__NL(Party_Is_Buyer_Or_Owner_))),COUNT(__d0(__NN(Party_Is_Buyer_Or_Owner_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','partyisborrower',COUNT(__d0(__NL(Party_Is_Borrower_))),COUNT(__d0(__NN(Party_Is_Borrower_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','partyisseller',COUNT(__d0(__NL(Party_Is_Seller_))),COUNT(__d0(__NN(Party_Is_Seller_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','partyiscareof',COUNT(__d0(__NL(Party_Is_Care_Of_))),COUNT(__d0(__NN(Party_Is_Care_Of_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','vendor_source_flag',COUNT(__d0(__NL(Vendor_Source_Code_))),COUNT(__d0(__NN(Vendor_Source_Code_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','Event',COUNT(__d1(__NL(Event_))),COUNT(__d1(__NN(Event_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','ln_fares_id',COUNT(__d1(__NL(L_N_Fares_I_D_))),COUNT(__d1(__NN(L_N_Fares_I_D_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','which_orig',COUNT(__d1(__NL(Person_Number_))),COUNT(__d1(__NN(Person_Number_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','conjunctive_name_seq',COUNT(__d1(__NL(Conjunctive_Name_Sequence_))),COUNT(__d1(__NN(Conjunctive_Name_Sequence_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','partyisbuyerorowner',COUNT(__d1(__NL(Party_Is_Buyer_Or_Owner_))),COUNT(__d1(__NN(Party_Is_Buyer_Or_Owner_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','partyisborrower',COUNT(__d1(__NL(Party_Is_Borrower_))),COUNT(__d1(__NN(Party_Is_Borrower_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','partyisseller',COUNT(__d1(__NL(Party_Is_Seller_))),COUNT(__d1(__NN(Party_Is_Seller_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','partyiscareof',COUNT(__d1(__NL(Party_Is_Care_Of_))),COUNT(__d1(__NN(Party_Is_Care_Of_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','vendor_source_flag',COUNT(__d1(__NL(Vendor_Source_Code_))),COUNT(__d1(__NN(Vendor_Source_Code_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'PersonPropertyEvent','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
